"""Live hand and body tracking, with the landmarks sent out over OSC.

    uv run track-demo                              # hands + body on screen
    uv run track-demo --osc max                    # ...and into Max on UDP 7400
    uv run track-demo --track hands --osc sc        # hands only, into SuperCollider
    uv run track-demo --camera 1 --list-cameras     # find the phone

Keys while running: q / Esc quit, s toggle smoothing, h toggle the HUD,
d cycle dimming, t cycle theme, SPACE freeze the *picture* (see below).

Freeze stops the overlay, not the data. While OSC is on, inference keeps
running and messages keep going out with the picture held still — the screen
and the sound are separate paths, and someone who needs the display to stop
moving should not have to stop the music to get it.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
import time
from contextlib import ExitStack

import cv2
import numpy as np
from mediapipe import Image, ImageFormat
from mediapipe.tasks.python import BaseOptions, vision

from . import draw, landmarks as L, models
from .camera import Camera
from .osc import OscSender, parse_endpoint
from .send import SIDES, LandmarkOsc
from .smoothing import LandmarkSmoother
from .timing import FpsMeter

WINDOW = "attention-cv | track"
TRACKS = ("hands", "pose")


class Subject:
    """The one-euro filters for one hand or one body.

    Image space and world space are filtered separately because they are in
    different units — pixels-ish versus metres — and one set of cutoffs cannot
    be right for both.
    """

    def __init__(self, min_cutoff: float, beta: float) -> None:
        self.norm = LandmarkSmoother(min_cutoff, beta)
        # World landmarks are metres, so a cutoff tuned for 0..1 image
        # coordinates would barely filter them. Scaling by a typical body
        # extent keeps the two behaving alike.
        self.world = LandmarkSmoother(min_cutoff * 0.5, beta * 0.5)

    def update(
        self, norm: np.ndarray | None, world: np.ndarray | None, t: float
    ) -> tuple[np.ndarray, np.ndarray] | None:
        a = self.norm.update(norm, t)
        b = self.world.update(world, t)
        if a is None or b is None:
            return None
        return a, b


def side_of(label: str, *, swap: bool = False) -> str:
    """MediaPipe's handedness label -> ``"left"`` / ``"right"``.

    The label is used exactly as it comes, in **both** the mirrored and the
    unmirrored case. That contradicts the advice you will find repeated
    everywhere — that handedness assumes a selfie view and must be swapped for
    an unmirrored image — so it was measured here rather than believed.

    On the same photo, run as-shot and again flipped, checking the hand label
    against the *pose* model's own left/right wrist as ground truth::

        as-shot    hand Left  x=0.603   pose left_wrist  x=0.596   agree
                   hand Right x=0.243   pose right_wrist x=0.248   agree
        mirrored   hand Left  x=0.753   pose left_wrist  x=0.753   agree
                   hand Right x=0.395   pose right_wrist x=0.409   agree

    Both models get it anatomically right either way, because handedness comes
    from the shape of the hand — which side the thumb is on, palm versus back —
    not from where it sits in the frame. Flipping the image on top of that is
    what puts every mapping on the wrong hand.

    ``--swap-hands`` remains, because a camera that is already mirrored in
    hardware would land you back in the other case and nobody should have to
    edit source to fix it.
    """
    side = label.strip().lower()
    if side not in SIDES:
        return "right"
    return {"left": "right", "right": "left"}[side] if swap else side


def camera_names() -> list[str]:
    """Camera names macOS knows about. Empty everywhere else, and on failure.

    OpenCV cannot report a device name on any platform, and these are *not*
    guaranteed to be in index order — they are a hint for spotting that an
    iPhone has attached itself, not a lookup table.
    """
    if sys.platform != "darwin":
        return []
    try:
        out = subprocess.run(
            ["system_profiler", "SPCameraDataType"],
            capture_output=True, text=True, timeout=10, check=True,
        ).stdout
    except (OSError, subprocess.SubprocessError):
        return []
    return [
        line.strip().rstrip(":")
        for line in out.splitlines()
        if line.startswith("    ") and not line.startswith("      ")
        and line.strip().endswith(":")
    ]


def list_cameras(limit: int = 8) -> int:
    names = camera_names()
    if names:
        print("macOS reports these cameras (not necessarily in index order):")
        for n in names:
            print(f"    {n}")
        print()
    print("probing camera indices...")
    found = 0
    for i in range(limit):
        cap = cv2.VideoCapture(i)
        if cap.isOpened():
            ok, _ = cap.read()
            w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
            print(f"  {i}: {w}x{h} {'ok' if ok else '(opened but no frame)'}")
            found += 1
        cap.release()
    if not found:
        print("  none. On macOS the terminal app needs camera access:")
        print("  System Settings > Privacy & Security > Camera.")
    print("\nAn iPhone only appears here while Continuity Camera is active — "
          "unlocked,\nnearby, and not already in use by another app. Plugging "
          "it in by USB makes it\nsteadier but does not change the index.")
    return 0


def parse_tracks(text: str) -> list[str]:
    want = [t.strip() for t in text.split(",") if t.strip()]
    bad = [t for t in want if t not in TRACKS]
    if bad or not want:
        raise SystemExit(
            f"--track takes a comma-separated list of {', '.join(TRACKS)}"
            + (f"; got {', '.join(bad)}" if bad else "")
        )
    return want


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="track-demo",
        description="Live hand and body landmarks from the camera, out over OSC.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("--track", default="hands,pose",
                   help=f"what to run: any of {', '.join(TRACKS)}")
    p.add_argument("--fps", type=float, default=30.0,
                   help="hard cap on displayed frames per second")
    p.add_argument("--camera", type=int, default=0, help="camera index")
    p.add_argument("--video", metavar="PATH",
                   help="read a video file instead of a camera; played at --fps")
    p.add_argument("--loop", action="store_true",
                   help="with --video, start over at the end")
    p.add_argument("--width", type=int, default=1280)
    p.add_argument("--height", type=int, default=720)
    p.add_argument("--model", default="pose_landmarker_lite",
                   choices=[n for n in models.MODELS if n.startswith("pose")],
                   help="which pose bundle to run")
    p.add_argument("--poses", type=int, default=1, help="max bodies to track")
    p.add_argument("--hands", type=int, default=2, dest="max_hands",
                   help="max hands to track")

    osc = p.add_argument_group("osc")
    osc.add_argument("--osc", metavar="HOST:PORT",
                     help="send landmarks here; 'max' = 127.0.0.1:7400, "
                          "'sc' = 127.0.0.1:57120")
    osc.add_argument("--osc-prefix", default="/cv",
                     help="first component of every OSC address")
    osc.add_argument("--osc-bulk", default="both",
                     choices=["both", "norm", "world", "none"],
                     help="which whole-subject vectors to send")
    osc.add_argument("--osc-named-space", default="norm", choices=["norm", "world"],
                     help="coordinate space for the per-point addresses")
    osc.add_argument("--no-osc-named", action="store_true",
                     help="send only the bulk vectors, no per-point addresses")

    view = p.add_argument_group("view")
    view.add_argument("--theme", default="calm", choices=sorted(draw.THEMES),
                      help="overlay style; calm dims the video and thins the lines")
    view.add_argument("--dim", type=float, default=None,
                      help="override the theme's video brightness (0.0-1.0)")
    view.add_argument("--no-mirror", action="store_true",
                      help="do not flip the image (does not affect handedness)")
    view.add_argument("--swap-hands", action="store_true",
                      help="left/right came out backwards; swap them")
    view.add_argument("--no-smooth", action="store_true",
                      help="disable one-euro smoothing (shows the raw jitter)")
    view.add_argument("--min-cutoff", type=float, default=1.2,
                      help="smoothing: lower is steadier when still")
    view.add_argument("--beta", type=float, default=0.4,
                      help="smoothing: higher is more responsive when moving")
    view.add_argument("--min-visibility", type=float, default=0.5,
                      help="hide body landmarks the model is unsure about")
    view.add_argument("--no-hud", action="store_true", help="hide the text readout")
    view.add_argument("--no-window", action="store_true",
                      help="no window at all; just track and send")
    view.add_argument("--record", metavar="PATH",
                      help="also write the composited view to an mp4 at --fps")
    view.add_argument("--seconds", type=float, default=None,
                      help="quit automatically after this long")
    p.add_argument("--list-cameras", action="store_true")
    return p


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    if args.list_cameras:
        return list_cameras()

    tracks = parse_tracks(args.track)
    theme = draw.THEMES[args.theme]
    dim = theme.dim if args.dim is None else max(0.0, min(1.0, args.dim))
    themes = sorted(draw.THEMES)
    # A recording is not a selfie view: mirroring it would be wrong to look at
    # and would invert the handedness label, so files default to unmirrored.
    mirrored = not (args.no_mirror or args.video)
    show_window = not args.no_window
    show_hud = not args.no_hud and show_window

    sender: OscSender | None = None
    out: LandmarkOsc | None = None
    if args.osc:
        host, port = parse_endpoint(args.osc)
        sender = OscSender(host, port)
        out = LandmarkOsc(sender, prefix=args.osc_prefix, bulk=args.osc_bulk,
                          named=not args.no_osc_named,
                          named_space=args.osc_named_space)

    hand_smoothers = {s: Subject(args.min_cutoff, args.beta) for s in SIDES}
    body_smoothers = [Subject(args.min_cutoff, args.beta) for _ in range(args.poses)]
    smooth = not args.no_smooth
    meter = FpsMeter()
    writer: cv2.VideoWriter | None = None
    frozen: np.ndarray | None = None
    frames = 0
    stamps: list[float] = []
    infer_ms: list[float] = []
    hud_lines: list[str] = []
    hud_at = 0.0
    last_ms = -1

    with ExitStack() as stack:
        hand_task = pose_task = None
        if "hands" in tracks:
            hand_task = stack.enter_context(vision.HandLandmarker.create_from_options(
                vision.HandLandmarkerOptions(
                    base_options=BaseOptions(
                        model_asset_path=str(models.require("hand_landmarker"))),
                    running_mode=vision.RunningMode.VIDEO,
                    num_hands=args.max_hands,
                    min_hand_detection_confidence=0.5,
                    min_hand_presence_confidence=0.5,
                    min_tracking_confidence=0.5,
                )))
        if "pose" in tracks:
            pose_task = stack.enter_context(vision.PoseLandmarker.create_from_options(
                vision.PoseLandmarkerOptions(
                    base_options=BaseOptions(
                        model_asset_path=str(models.require(args.model))),
                    # VIDEO mode keeps tracking state between frames, so the
                    # model tracks a body instead of re-detecting it every
                    # frame — cheaper and much steadier.
                    running_mode=vision.RunningMode.VIDEO,
                    num_poses=args.poses,
                    min_pose_detection_confidence=0.5,
                    min_pose_presence_confidence=0.5,
                    min_tracking_confidence=0.5,
                )))
        cam = stack.enter_context(Camera(args.video or args.camera,
                                         width=args.width, height=args.height,
                                         request_fps=args.fps, loop=args.loop))

        info = cam.info
        label = f"video {args.video!r}" if args.video else f"camera {args.camera}"
        print(f"{label}: {info.width}x{info.height} "
              f"@ {info.reported_fps:g} reported, {info.backend}")
        print(f"track:  {', '.join(tracks)}")
        if out is not None and sender is not None:
            print(f"osc:    {sender.addr[0]}:{sender.addr[1]}  "
                  f"{args.osc_prefix}/hand/<side>/... , {args.osc_prefix}/pose/<n>/...")
        print(f"render: capped at {args.fps:g} fps   (q or Esc to quit)")

        if show_window:
            cv2.namedWindow(WINDOW, cv2.WINDOW_AUTOSIZE)
        t0 = time.perf_counter()

        for frame, now in cam.frames(args.fps, mirror=mirrored):
            if args.seconds is not None and now - t0 >= args.seconds:
                break
            frames += 1

            # Freeze holds the picture. It only skips the work when there is
            # no OSC to keep alive.
            infer = frozen is None or out is not None
            hands: dict[str, tuple[np.ndarray, np.ndarray]] = {}
            bodies: dict[int, tuple[np.ndarray, np.ndarray, np.ndarray]] = {}

            if infer:
                rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                mp_image = Image(image_format=ImageFormat.SRGB, data=rgb)
                # Timestamps must be whole milliseconds and strictly increasing;
                # two frames inside the same millisecond would be rejected.
                ms = max(int((now - t0) * 1000), last_ms + 1)
                last_ms = ms
                t_infer = time.perf_counter()

                if hand_task is not None:
                    r = hand_task.detect_for_video(mp_image, ms)
                    seen: dict[str, float] = {}
                    for i, lms in enumerate(r.hand_landmarks):
                        cat = r.handedness[i][0]
                        side = side_of(cat.category_name, swap=args.swap_hands)
                        # Both hands occasionally come back with the same
                        # label; keep whichever the model was surer of rather
                        # than letting detection order decide.
                        if side in seen and seen[side] >= cat.score:
                            continue
                        seen[side] = cat.score
                        hands[side] = (L.to_array(lms),
                                       L.to_array(r.hand_world_landmarks[i]))

                if pose_task is not None:
                    r = pose_task.detect_for_video(mp_image, ms)
                    for i, lms in enumerate((r.pose_landmarks or [])[: args.poses]):
                        bodies[i] = (L.to_array(lms),
                                     L.to_array(r.pose_world_landmarks[i]),
                                     L.visibility_of(lms))
                infer_ms.append((time.perf_counter() - t_infer) * 1000)

                if smooth:
                    for side in SIDES:
                        found = hands.get(side)
                        f = hand_smoothers[side].update(
                            *(found if found else (None, None)), now)
                        if f is not None and found is not None:
                            hands[side] = f
                    for i in range(args.poses):
                        found = bodies.get(i)
                        f = body_smoothers[i].update(
                            *(found[:2] if found else (None, None)), now)
                        if f is not None and found is not None:
                            bodies[i] = (*f, found[2])

                if out is not None:
                    if hand_task is not None:
                        out.hands(hands)
                    if pose_task is not None:
                        out.poses(bodies, args.poses)

            if frozen is not None:
                canvas = frozen.copy()
            else:
                canvas = draw.dim_frame(frame, dim)
                for i, (norm, _world, vis) in sorted(bodies.items()):
                    draw.draw_pose(canvas, norm, theme=theme, visibility=vis,
                                   min_visibility=args.min_visibility)
                for side, (norm, _world) in sorted(hands.items()):
                    draw.draw_hand(canvas, norm, theme=theme)
                    draw.draw_label(canvas, side[0].upper(),
                                    norm[L.INDEX["hand"]["wrist"]], theme=theme)

            meter.tick(now)
            stamps.append(now)

            if show_hud:
                # Rebuilt a few times a second, not every frame: a text block
                # that changes at 30 Hz is the same flicker problem as a number
                # box wired to a sensor.
                if now - hud_at >= 0.4:
                    hud_at = now
                    hud_lines = [
                        f"{meter.display:4.1f} fps  (cap {args.fps:g})",
                        f"{len(hands)} hand(s) {'+'.join(sorted(hands)) or '-'}"
                        f"   {len(bodies)} bod{'y' if len(bodies) == 1 else 'ies'}"
                        f"   smooth {'on' if smooth else 'off'}",
                        (f"osc {sender.sent} sent" if sender is not None else "osc off")
                        + f"   {theme.name}  dim {dim:.2f}"
                        + ("   FROZEN" if frozen is not None else ""),
                    ]
                draw.draw_hud(canvas, hud_lines, theme=theme)

            if args.record:
                if writer is None:
                    h, w = canvas.shape[:2]
                    writer = cv2.VideoWriter(args.record,
                                             cv2.VideoWriter_fourcc(*"mp4v"),
                                             args.fps, (w, h))
                writer.write(canvas)

            if not show_window:
                continue
            cv2.imshow(WINDOW, canvas)
            key = cv2.waitKey(1) & 0xFF
            if key in (ord("q"), 27):
                break
            if key == ord("s"):
                smooth = not smooth
            elif key == ord("h"):
                show_hud = not show_hud
            elif key == ord("d"):
                dim = round((dim - 0.15) % 1.15, 2)
            elif key == ord("t"):
                theme = draw.THEMES[themes[(themes.index(theme.name) + 1) % len(themes)]]
                dim = theme.dim
            elif key == ord(" "):
                frozen = None if frozen is not None else canvas.copy()

    if writer is not None:
        writer.release()
        print(f"wrote {args.record}")
    cv2.destroyAllWindows()
    elapsed = time.perf_counter() - t0
    print(f"{frames} frames shown in {elapsed:.1f}s "
          f"({frames / elapsed:.1f} fps), {cam.dropped} camera frames dropped")
    if len(stamps) > 10:
        gaps = np.diff(stamps) * 1000
        p50, p95 = np.percentile(gaps, [50, 95])
        print(f"frame interval: median {p50:.1f}ms, p95 {p95:.1f}ms, "
              f"worst {gaps.max():.1f}ms (target {1000 / args.fps:.1f}ms)")
        late = int((gaps > 1000 / args.fps * 1.5).sum())
        print(f"{late} frame(s) more than 50% late — these are what read as stutter")
    if infer_ms:
        arr = np.array(infer_ms)
        print(f"inference:      median {np.median(arr):.1f}ms, p95 "
              f"{np.percentile(arr, 95):.1f}ms of the {1000 / args.fps:.1f}ms budget")
    if out is not None and sender is not None:
        for line in out.summary(elapsed):
            print(line)
        sender.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
