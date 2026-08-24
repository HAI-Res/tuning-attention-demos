"""Live body-tracking demo.

    uv run pose-demo                 # 30 fps, calm theme, smoothing on
    uv run pose-demo --fps 24 --theme mono
    uv run pose-demo --list-cameras

Keys while running: q / Esc quit, s toggle smoothing, h toggle the HUD,
d cycle dimming, t cycle theme, SPACE freeze the overlay.
"""

from __future__ import annotations

import argparse
import time

import cv2
import numpy as np
from mediapipe import Image, ImageFormat
from mediapipe.tasks.python import BaseOptions
from mediapipe.tasks.python import vision

from . import draw, models
from .camera import Camera
from .smoothing import LandmarkSmoother
from .timing import FpsMeter

WINDOW = "attention-cv | pose"


def landmarks_to_array(landmarks: list) -> tuple[np.ndarray, np.ndarray]:
    """MediaPipe landmark list -> (N, 3) positions and (N,) visibility."""
    pts = np.array([[lm.x, lm.y, lm.z] for lm in landmarks], dtype=np.float64)
    vis = np.array([min(lm.visibility, lm.presence) for lm in landmarks], dtype=np.float64)
    return pts, vis


def list_cameras(limit: int = 6) -> int:
    print("probing camera indices...")
    for i in range(limit):
        cap = cv2.VideoCapture(i)
        if cap.isOpened():
            ok, _ = cap.read()
            w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
            print(f"  {i}: {w}x{h} {'ok' if ok else '(opened but no frame)'}")
        cap.release()
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        description="Live pose tracking from the camera, rate-capped for comfort.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("--fps", type=float, default=30.0,
                   help="hard cap on displayed frames per second")
    p.add_argument("--camera", type=int, default=0, help="camera index")
    p.add_argument("--width", type=int, default=1280)
    p.add_argument("--height", type=int, default=720)
    p.add_argument("--model", default="pose_landmarker_lite",
                   choices=[n for n in models.MODELS if n.startswith("pose")],
                   help="which pose bundle to run")
    p.add_argument("--poses", type=int, default=1, help="max bodies to track")
    p.add_argument("--theme", default="calm", choices=sorted(draw.THEMES),
                   help="overlay style; calm dims the video and thins the lines")
    p.add_argument("--dim", type=float, default=None,
                   help="override the theme's video brightness (0.0-1.0)")
    p.add_argument("--no-mirror", action="store_true", help="do not flip the image")
    p.add_argument("--no-smooth", action="store_true",
                   help="disable one-euro smoothing (shows the raw jitter)")
    p.add_argument("--min-cutoff", type=float, default=1.2,
                   help="smoothing: lower is steadier when still")
    p.add_argument("--beta", type=float, default=0.4,
                   help="smoothing: higher is more responsive when moving")
    p.add_argument("--min-visibility", type=float, default=0.5,
                   help="hide landmarks the model is unsure about")
    p.add_argument("--no-hud", action="store_true", help="hide the text readout")
    p.add_argument("--record", metavar="PATH",
                   help="also write the composited view to an mp4 at --fps")
    p.add_argument("--seconds", type=float, default=None,
                   help="quit automatically after this long (for timed clips)")
    p.add_argument("--list-cameras", action="store_true")
    return p


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    if args.list_cameras:
        return list_cameras()

    model_path = models.require(args.model)
    theme = draw.THEMES[args.theme]
    dim = theme.dim if args.dim is None else max(0.0, min(1.0, args.dim))
    themes = sorted(draw.THEMES)

    options = vision.PoseLandmarkerOptions(
        base_options=BaseOptions(model_asset_path=str(model_path)),
        # VIDEO mode keeps tracking state between frames, so the model tracks a
        # body instead of re-detecting it every frame — cheaper and much steadier.
        running_mode=vision.RunningMode.VIDEO,
        num_poses=args.poses,
        min_pose_detection_confidence=0.5,
        min_pose_presence_confidence=0.5,
        min_tracking_confidence=0.5,
    )

    smoothers = [LandmarkSmoother(args.min_cutoff, args.beta) for _ in range(args.poses)]
    smooth = not args.no_smooth
    show_hud = not args.no_hud
    meter = FpsMeter()
    writer: cv2.VideoWriter | None = None
    frozen: np.ndarray | None = None
    frames = 0
    # Frame timestamps and per-frame inference cost, for the summary at exit.
    # Steadiness matters more than the average here, so report percentiles.
    stamps: list[float] = []
    infer_ms: list[float] = []

    with vision.PoseLandmarker.create_from_options(options) as landmarker, \
            Camera(args.camera, width=args.width, height=args.height,
                   request_fps=args.fps) as cam:
        info = cam.info
        print(f"camera {args.camera}: {info.width}x{info.height} "
              f"@ {info.reported_fps:g} reported, {info.backend}")
        print(f"model:  {model_path.name}")
        print(f"render: capped at {args.fps:g} fps   (q or Esc to quit)")

        cv2.namedWindow(WINDOW, cv2.WINDOW_AUTOSIZE)
        t0 = time.perf_counter()

        for frame, now in cam.frames(args.fps, mirror=not args.no_mirror):
            if args.seconds is not None and now - t0 >= args.seconds:
                break
            frames += 1
            if frozen is None:
                rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                mp_image = Image(image_format=ImageFormat.SRGB, data=rgb)
                # Timestamps must be monotonically increasing whole milliseconds.
                t_infer = time.perf_counter()
                result = landmarker.detect_for_video(mp_image, int((now - t0) * 1000))
                infer_ms.append((time.perf_counter() - t_infer) * 1000)

                canvas = draw.dim_frame(frame, dim)
                bodies = result.pose_landmarks or []
                for i, landmarks in enumerate(bodies[: args.poses]):
                    pts, vis = landmarks_to_array(landmarks)
                    if smooth:
                        # `or` would ask a numpy array for its truth value.
                        filtered = smoothers[i].update(pts, now)
                        if filtered is not None:
                            pts = filtered
                    draw.draw_pose(canvas, pts, theme=theme, visibility=vis,
                                   min_visibility=args.min_visibility)
                for i in range(len(bodies), args.poses):
                    smoothers[i].update(None, now)
            else:
                canvas = frozen.copy()
                bodies = []

            meter.tick(now)
            stamps.append(now)
            if show_hud:
                draw.draw_hud(canvas, [
                    f"{meter.display:4.1f} fps  (cap {args.fps:g})",
                    f"{len(bodies)} body{'' if len(bodies) == 1 else 'ies'}"
                    f"   smooth {'on' if smooth else 'off'}"
                    f"   {theme.name}  dim {dim:.2f}"
                    + ("   FROZEN" if frozen is not None else ""),
                ], theme=theme)

            if args.record:
                if writer is None:
                    h, w = canvas.shape[:2]
                    writer = cv2.VideoWriter(args.record,
                                             cv2.VideoWriter_fourcc(*"mp4v"),
                                             args.fps, (w, h))
                writer.write(canvas)

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
        p50, p95, worst = np.percentile(gaps, [50, 95]).tolist() + [gaps.max()]
        print(f"frame interval: median {p50:.1f}ms, p95 {p95:.1f}ms, worst {worst:.1f}ms "
              f"(target {1000 / args.fps:.1f}ms)")
        late = int((gaps > 1000 / args.fps * 1.5).sum())
        print(f"{late} frame(s) more than 50% late — these are what read as stutter")
    if infer_ms:
        arr = np.array(infer_ms)
        print(f"inference:      median {np.median(arr):.1f}ms, p95 "
              f"{np.percentile(arr, 95):.1f}ms of the {1000 / args.fps:.1f}ms budget")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
