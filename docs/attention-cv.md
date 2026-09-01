# attention-cv

Computer-vision experiments for the tuning-attention class. Live body / hand /
face landmark tracking from the camera, with the display rate held to a fixed,
comfortable cap.

## Setup

```sh
uv sync                 # create .venv and install
uv run fetch-models     # download the MediaPipe .task bundles into models/
uv run track-demo       # live hand + body points from the camera, 30 fps
uv run track-demo --osc max     # ...and into Max on UDP 7400
```

`models/` is gitignored — the bundles are 4–10 MB each and always re-fetchable.
`uv run fetch-models --list` shows what is available and what is already local.

## Hands and bodies, out over OSC

`track-demo` is the one that sends. It runs the hand landmarker, the pose
landmarker, or both, and puts the landmarks on OSC for Max / SuperCollider /
Pd. `pose-demo` is the same program under its old name, fixed to `--track pose`.

```sh
uv run track-demo                         # hands + body on screen, nothing sent
uv run track-demo --osc max               # ...and into Max on UDP 7400
uv run track-demo --track hands --osc sc  # hands only, into SuperCollider
uv run track-demo --no-window --osc max   # headless: just track and send
uv run track-demo --video clip.mp4 --loop # a recording instead of a camera
uv run osc-dump 7400                      # what is actually arriving
```

### The addresses

Twenty-one points per hand and thirty-three per body is a lot of numbers, and
there are two reasonable things to want from them, so both go out. **Bulk**
messages carry a whole hand or body flattened into one message. **Named**
messages carry one point each, addressed by its anatomical name, because
unpacking element 24 of a 63-float list inside Max is genuinely unpleasant and
most mappings want four or five points rather than sixty-three.

```
/cv/hand/left/present      i   1 while tracked, 0 the frame it goes
/cv/hand/left/norm        63f  21 points, image space
/cv/hand/left/world       63f  21 points, metres
/cv/hand/left/index_tip    3f  one named point
/cv/hand/left/pinch        1f  thumb tip to index tip, metres
/cv/hand/left/spread       1f  index tip to pinky tip, metres

/cv/pose/0/present         i
/cv/pose/0/norm           99f  33 points, image space
/cv/pose/0/world          99f  33 points, metres
/cv/pose/0/visibility     33f  per-point confidence
/cv/pose/0/right_wrist     3f
/cv/pose/0/center          3f  hip midpoint, image space
/cv/pose/0/hands_apart     1f  wrist to wrist, metres
```

Named hand points are the wrist and the five fingertips; named body points are
the nose, shoulders, elbows, wrists, hips, knees and ankles. `--osc-prefix`
changes the `/cv`, `--osc-bulk` and `--no-osc-named` turn off either half, and
everything not named is still in the bulk message.

`present` goes out every frame for both hands and every body slot, whether or
not anything was found. A channel that is off, a person who walked away, and a
sender that has crashed otherwise all look identical downstream — silence —
and telling them apart is worth one integer per frame.

### Two coordinate spaces, and which one you want

Every task reports its landmarks twice, and they are not interchangeable.

| | `norm` | `world` |
| --- | --- | --- |
| x, y | 0..1 across the image, origin top-left | metres |
| z | relative depth, same scale as x, negative towards camera | metres |
| origin | image | hand centre, or the hip midpoint |
| answers | *where is this in the frame* | *how big, how far apart* |

So `norm` is what you map to a filter sweep, and `world` is what you measure a
pinch with — a pinch has to mean the same thing at the back of the room as it
does at the front, and only the world landmarks are independent of how far away
someone is standing. Named points carry `norm` by default
(`--osc-named-space world` swaps that); the derived scalars — `pinch`,
`spread`, `hands_apart` — are always metres, for the same reason.

Yes, it is real 3D, with the honest caveat that a single camera infers depth
rather than measuring it. Relative depth within a hand is good; absolute
distance from the camera is not something either model reports.

### What it costs

Measured on this machine, 638×1080 video, one person, both hands, against a
33.3 ms budget:

| `--track` | inference, median |
| --- | --- |
| `pose` (lite) | 9.2 ms |
| `pose` (`--model pose_landmarker_full`) | 15.1 ms |
| `hands --hands 1` | 11.1 ms |
| `hands` (two) | 21.4 ms |
| `hands,pose` | **31.1 ms** |

Hands are the expensive half, and both together leave about 2 ms of the 30 fps
budget. That works — the run above held a 33.3 ms median interval with one late
frame in 150 — but there is no headroom for a slower machine or a second
person. `--fps 24` buys 8 ms back, `--hands 1` buys 10 ms, and `--track hands`
on its own is the cheapest thing that still tracks fingers.

### The trap: MediaPipe's handedness does *not* need swapping

The advice you will find repeated everywhere is that handedness assumes a
selfie view, so an unmirrored image needs left and right swapped. Following it
puts every mapping on the wrong hand.

It was measured here instead, running the same photo as-shot and again flipped,
and checking the hand label against the *pose* model's own left/right wrist as
ground truth:

```
as-shot    hand Left  x=0.603   pose left_wrist  x=0.596   agree
           hand Right x=0.243   pose right_wrist x=0.248   agree
mirrored   hand Left  x=0.753   pose left_wrist  x=0.753   agree
           hand Right x=0.395   pose right_wrist x=0.409   agree
```

Both models get it anatomically right either way, because handedness comes from
the shape of the hand — which side the thumb is on, palm versus back — not from
where it sits in the frame. So the label is used exactly as it arrives.
`--swap-hands` is still there for a camera that mirrors in hardware, and the
on-screen `L`/`R` caption next to each wrist makes it a five-second check.

## Using a phone as the camera

Nothing here is camera-specific: it is an index into whatever the OS offers, so
the question is only how to make the phone show up as a camera.

- **iPhone, wireless — Continuity Camera.** Nothing to install. The phone
  appears as an ordinary camera while it is unlocked, nearby, and not in use by
  another app, and disappears again when it is not. This is the easiest of the
  three and the picture is far better than a laptop's built-in camera.
- **iPhone, USB.** The same Continuity Camera, plugged in. Steadier and it
  charges; it does not change the camera index.
- **Android, or a phone that won't play** — a virtual-camera app (OBS with a
  phone source, Camo, DroidCam) presents itself as a camera and works the same
  way.

`uv run track-demo --list-cameras` prints the indices and, on macOS, the names
the system knows about.

**The index-0 trap, found on this machine.** OBS installs a virtual camera that
is often index 0. It *opens* perfectly happily and then delivers no frames at
all, so a naive run finishes with "0 frames shown" and no reason given. The
capture now does a test read on open and says so:

```
camera 0 opened but delivered no frames in 2s.
  Usually a virtual camera whose app is not running (OBS installs one,
  often at index 0), or a camera already in use by another app.
```

`--list-cameras` marks it `(opened but no frame)`; on this laptop the real
camera is index 1.

There is a second, quite different way to get a phone into this — the phone
runs MediaPipe *itself*, in its browser, and sends only landmarks over the
network, so no video crosses the wifi and a room full of phones scales. That
belongs with `attention-phone`, which already has the page, the HTTPS
certificate and the socket, and is not built yet.

## When nothing arrives in Max

UDP has no notion of a peer that is not there, so a wrong port, a wrong address
and a firewall all look identical from the sending end: silence.

```sh
uv run osc-dump 7400        # slow, averaged summary of every address arriving
uv run osc-dump 7400 --raw  # every message, verbatim
```

That answers "is anything arriving, and under what address" without opening
Max, which is the first question every time and the slowest one to answer
inside a patcher. Run it *instead of* Max, not alongside — two processes cannot
bind the same UDP port, and `osc-dump` says so rather than sitting there quiet.

The summary is deliberately slow and averaged rather than per-message, for the
same reason the on-screen readouts are: a number that changes at 30 Hz is
unreadable, and flicker at that rate is a migraine and vestibular trigger.

**Freeze does not stop the data.** SPACE holds the picture still; while `--osc`
is on, inference keeps running and messages keep going out. The screen and the
sound are separate paths, and someone who needs the display to stop moving
should not have to stop the music to get it.

## The old demo

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
| `src/attention_cv/landmarks.py` | the point names, connections and the two spaces |
| `src/attention_cv/osc.py` | OSC 1.0 codec and a non-blocking UDP sender |
| `src/attention_cv/send.py` | landmarks -> the address layout above |
| `src/attention_cv/track_demo.py` | the live demo CLI: camera, tracking, OSC |
| `src/attention_cv/osc_dump.py` | `uv run osc-dump` — what is arriving on a port |
| `src/attention_cv/pose_demo.py` | `track_demo` under its old name, `--track pose` |
| `tests/` | `uv run pytest` — 50 tests |

## Prior art: the singing bowl game

An earlier MediaPipe project of Jon's is on this machine and still runs:
`~/Documents/2024/Outlier/singing_bowl_game` (Outlier Technology LLC, last
commit Mar 2024). Gestures in different screen quadrants trigger singing bowl
sounds; it uses the old `gesture_recognizer.task` for hands, plus csound /
pyaudio for synthesis. Its `my_env3.10` venv is intact — `./my_env3.10/bin/python
main.py` from that directory works as-is. Worth mining for the
gesture-to-sound mapping and the hand rendering in `image_analysis.py`, keeping
in mind the repo belongs to the Outlier org.
