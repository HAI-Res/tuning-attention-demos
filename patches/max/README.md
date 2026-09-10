# Max patches

Two sources into Max, vanilla Max 8 — no packages, no externals: a phone's
sensors (UDP 7400) and a laptop camera's hand/body tracking (UDP 7500). One
receiver per source may be open at a time; the two sources can run together.

## Setup (once per machine)

```sh
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/attention-phone
```

Restart Max — it only scans its search path at launch. Without this, patches
open with empty boxes instead of the bpatchers they need.

## Phone → Max

```sh
open patches/max/attention-phone.maxpat
```

Point the phone's camera at the QR code in the patch — it configures the app
and starts sending. First packet triggers an iOS **Local Network** permission
prompt; nothing arrives until you allow it.

No phone handy? `python3 patches/max/poke.py` fakes one so you can check the
patch itself works.

**Only one patch with a receiver can be open at a time** (`attention-phone.maxpat`,
`attention-phone-monitor.maxpat`, `3. gyro_buffer.1.maxpat` each embed one,
and all three fight over UDP 7400).

## Files

| file | what it is |
| --- | --- |
| `attention-phone.maxpat` | starter patch: receiver, three taps, one worked example |
| `attention-phone-monitor.maxpat` | every channel, with arrival rates |
| `ap.receive.maxpat` | the receiver — socket + phone chooser |
| `ap.qr.maxpat` | the QR code, paste one into any patch |
| `ap.channel.maxpat` | a tap: channel dropdown + outlets |
| `poke.py` | fakes a phone for testing without one |
| `3. gyro_buffer.1.maxpat` | class demo — see below |
| `attention-cv.maxpat` | camera starter patch: receiver, three taps, one worked example |
| `cv.receive.maxpat` | the camera receiver — socket on UDP 7500, throughput, channel list |
| `cv.point.maxpat` | a camera tap: channel dropdown + outlets |
| `cv.js` | splits camera OSC addresses for the receiver; must stay beside the patches |
| `cv-poke.py` | fakes the camera for testing without one |
| `cv-pinch-synth.maxpat` | class demo — two hands, two voices; see below |
| `xfade~.maxpat` | Christopher Dobrian's crossfader, vendored; see below |

## Using a tap

Copy an `ap.channel` bpatcher, lock the patch (⌘E), pick a channel from its
dropdown. Outlets: whole reading · axis 1–4 · magnitude. `[ap.channel ap.gyro]`
typed directly also works, no dropdown needed.

## Class demo: `3. gyro_buffer.1.maxpat`

Gyro rotation rate drives `groove~` playback speed through a resonant filter
— turning the phone scrubs/pitches the sample. Needs a file named
`tudor.wav` in this folder; it's intentionally not committed (source audio,
not ours to redistribute), so drop your own `.wav` there and rename it, or
edit the `buffer~ tudor tudor.wav` object to point elsewhere.

## Camera → Max

```sh
uv sync && uv run fetch-models     # once; MediaPipe is ~120 MB of it
uv run track-demo --osc max                   # the camera, as OSC on UDP 7500
open patches/max/attention-cv.maxpat          # receiver, three taps, a worked example
```

`cv.point` taps work like `ap.channel`: copy one, lock the patch, pick a
channel. Scalars worth knowing: `cv.hand.right.pinch` (thumb to index tip,
metres), `cv.hand.right.size` (palm length in image units — the only thing
that tracks distance from the camera), `cv.pose.0.center` (hip midpoint),
`cv.*.present` (1 while tracked). Rationale and the full channel list:
[`docs/attention-cv-max.md`](../docs/attention-cv-max.md).

No camera handy? `python3 patches/max/cv-poke.py` fakes one.

## Class demo: `cv-pinch-synth.maxpat`

Each hand on the camera is a saw/square voice: pinch (thumb tip to index tip)
opens a lowpass, hand height blends square (low) into saw (raised), left–right
pans, leaving the frame fades out. Left hand plays the base pitch, right hand a
fifth up. Every blend and pan is equal-power; every control ends in an 80 ms
`line~` ramp. It owns UDP 7500 itself, so close `attention-cv.maxpat` first.

The patch is one flat file laid out as a grid: rows are the stages of the chain
(INPUTS, OSCILLATORS, FILTER, GATE, PAN, OUT), columns are the two hands, the
signal runs down the left of each column and each control comes in from the
right at the stage it drives.

**Calibrate the pinch first.** It arrives in metres; the two SHARED boxes are
the closed and open distances the sweep runs between (defaults 0.02 and 0.12).
Read a hand's pinch readout with fingers touching, then wide apart, and type
those in. `track-demo --swap-hands` if left and right come out reversed.

## `xfade~`

Dobrian's two-signal crossfader from the UC Irvine Max Cookbook, vendored
unchanged so a clone has it: inlets signal A, signal B, crossfade 0–1 (float or
signal); outlet `A·(1−x) + B·x`. Linear, so the middle is ~3 dB down; the
equal-power version is `cos`/`sin` of `x·π/2`, which is what the pinch synth
and `pan2` do. Source and licence note:
[`docs/attention-phone-max.md`](../docs/attention-phone-max.md#xfade--a-crossfader-that-comes-with-the-repo).

## If nothing arrives

1. Local Network permission not granted yet, or the app reset after a rebuild.
2. Port mismatch — app and Max must both be on 7400.
3. Wifi client isolation blocks phone→laptop traffic; nothing on the laptop
   fixes this.

Run `python3 patches/max/poke.py` (phone) or `cv-poke.py` (camera) first — it
tells you in five seconds whether the problem is the patch or the source. For
the camera, `uv run osc-dump 7500` with Max closed shows what is arriving.
