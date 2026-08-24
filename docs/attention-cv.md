# attention-cv

Computer-vision experiments for the tuning-attention class. Live body / hand /
face landmark tracking from the camera, with the display rate held to a fixed,
comfortable cap.

## Setup

```sh
uv sync                 # create .venv and install
uv run fetch-models     # download the MediaPipe .task bundles into models/
uv run pose-demo        # live body points from the camera, 30 fps
```

`models/` is gitignored — the bundles are 4–10 MB each and always re-fetchable.
`uv run fetch-models --list` shows what is available and what is already local.

## The demo

```sh
uv run pose-demo                          # 30 fps cap, calm theme, smoothing on
uv run pose-demo --fps 24                 # steadier; see the note below
uv run pose-demo --theme mono --dim 0     # skeleton on black, no video at all
uv run pose-demo --model pose_landmarker_full --poses 2
uv run pose-demo --seconds 10 --record out.mp4
uv run pose-demo --list-cameras
```

Keys while running: `q`/`Esc` quit · `s` smoothing · `h` HUD · `d` dimming ·
`t` theme · `space` freeze.

On exit it prints how the run actually went, which is the number that matters:

```
215 frames shown in 8.2s (26.2 fps), 9 camera frames dropped
frame interval: median 33.2ms, p95 66.0ms, worst 126.6ms (target 33.3ms)
26 frame(s) more than 50% late — these are what read as stutter
inference:      median 10.0ms, p95 11.0ms of the 33.3ms budget
```

## Frame rate, and keeping this comfortable to look at

Yes, the rate is controlled, and it is controlled in software rather than left
to the camera. Three separate things were making naive versions of this
unpleasant, and each has its own switch:

**1. The update rate itself.** `--fps` is a hard cap, default 30. The camera is
read as fast as it produces frames, but only frames due on a fixed 33.3 ms grid
are decoded, tracked and drawn; the rest are grabbed and discarded. Two reasons
it works this way:

- `cv2.CAP_PROP_FPS` is a *hint*. This camera accepts the 30 fps request and
  then delivers ~27, so trusting it would leave the rate wherever the hardware
  felt like putting it.
- The deadlines are absolute, not "one period since the last frame", so one slow
  frame doesn't shift every later frame late — and after a real stall the clock
  resyncs instead of firing a catch-up burst of back-to-back frames. That burst
  is the worst thing on screen, and it's what a naive `sleep(1/30)` loop does.

Measured on this machine: a 60, 120 or 240 fps source all come out at exactly 30
rendered frames per second, and a 24 fps source passes through untouched.

**2. Landmark jitter.** Raw per-frame landmarks wobble a few pixels even when
you hold still, so the skeleton vibrates constantly. That is a bigger visual
irritant than the frame rate. A one-euro filter cuts the jitter ~3× while
keeping lag at 40–65 ms during real movement — an exponential average can't do
both. `--no-smooth` shows you the raw version; the difference is obvious.
`--min-cutoff` (lower = steadier when still) and `--beta` (higher = less lag
when moving) are exposed; defaults 1.2 / 0.4 came from a parameter sweep.

**3. Brightness and contrast.** The default `calm` theme dims the video to 55%
and draws thin, low-saturation lines. `--theme mono --dim 0` drops the video
entirely and shows the skeleton on black, which removes essentially all
luminance flicker. `bright` is the conventional high-contrast overlay, for a
washed-out projector. Nothing in any theme blinks or strobes, and the FPS
readout is refreshed 2.5× a second rather than every frame.

Also: occluded limbs are hidden rather than drawn at their guessed position
(`--min-visibility`), because a low-confidence limb thrashes around the frame.
The 11 dense face landmarks are left out of the body skeleton for the same
reason.

### If 30 fps still isn't steady

Inference is only ~10 ms of the 33 ms budget, so the model is not the
constraint. On this machine the built-in camera measured **27.4 fps raw** —
below the 30 it reports — while another camera app was running, and that shows
up as ~12% of frames arriving a whole period late. When the source can't keep
up, a *steady* lower rate is more comfortable than a jittery 30:

```sh
uv run pose-demo --fps 24
```

At 24 the same camera held p95 44.8 ms against a 41.7 ms target. Check the
`frames more than 50% late` line to see which is behaving better for you.

## Version pinning, and why

`mediapipe` is pinned to the `0.10.3x` line. **1.0.x is broken on macOS
arm64 here**: every vision graph — pose, hand and face alike — aborts at graph
open with `DrishtiMetalHelper` / `Check failed: service_ Service is
unavailable`. 0.10.35 is the newest working release and installs on Python 3.13.

MediaPipe removed the old `mp.solutions` API in 0.10.30, so everything here uses
the Tasks API (`mediapipe.tasks.python.vision`) with an explicit `.task` bundle —
this is also why models must be downloaded rather than bundled with the library.
The pose landmarker runs in `VIDEO` mode, which keeps tracking state between
frames: cheaper than re-detecting every frame, and noticeably steadier.

## Layout

| path | what it is |
| --- | --- |
| `src/attention_cv/timing.py` | `FrameClock` (the rate cap) and `FpsMeter` |
| `src/attention_cv/camera.py` | capture with grab-and-drop frame dropping |
| `src/attention_cv/smoothing.py` | one-euro landmark filter |
| `src/attention_cv/draw.py` | skeleton rendering and themes |
| `src/attention_cv/models.py` | model registry and downloader |
| `src/attention_cv/pose_demo.py` | the live demo CLI |
| `tests/` | `uv run pytest` — covers the clock, the filter and the drawing |

## Prior art: the singing bowl game

An earlier MediaPipe project of Jon's is on this machine and still runs:
`~/Documents/2024/Outlier/singing_bowl_game` (Outlier Technology LLC, last
commit Mar 2024). Gestures in different screen quadrants trigger singing bowl
sounds; it uses the old `gesture_recognizer.task` for hands, plus csound /
pyaudio for synthesis. Its `my_env3.10` venv is intact — `./my_env3.10/bin/python
main.py` from that directory works as-is. Worth mining for the
gesture-to-sound mapping and the hand rendering in `image_analysis.py`, keeping
in mind the repo belongs to the Outlier org.
