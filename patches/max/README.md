# Max patches

Two sources into Max: a phone's sensors (UDP 7400) and a laptop camera's hand
tracking (UDP 7500). The phone patches are vanilla Max 8; the camera class
patch additionally needs the **CNMAT Externals** package (for `OSC-route`) from
Max's Package Manager. One receiver per source may be open at a time; the two
sources can run together.

## Setup (once per machine)

```sh
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/tuning-attention
```

Restart Max — it only scans its search path at launch. Without this, patches
open with empty boxes instead of the bpatchers they need.

## Phone → Max

```sh
open patches/max/attention-phone.maxpat
```

Point the phone's camera at the QR code in the patch. By default it opens a
web page on the class server keyed to this laptop's **room** (the five-letter
code in the receiver), and the phone's sensors arrive here through the
receiver's relay — nothing to install. The menu under the code switches to the
**Ductus app** link (OSC straight to Max over the LAN; the first packet
triggers an iOS **Local Network** prompt) or to a page served from this laptop
(needs `uv run phone-demo --osc 127.0.0.1:7400` running). The long version:
[`docs/attention-phone-max.md`](../../docs/attention-phone-max.md).

No phone handy? `python3 patches/max/poke.py` fakes one so you can check the
patch itself works.

**Only one patch with a receiver can be open at a time** (`attention-phone.maxpat`,
`attention-phone-monitor.maxpat`, `phone-gyroscope-demo.maxpat` each embed one,
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
| `phone-gyroscope-demo.maxpat` | class demo — see below |
| `attention-cv.maxpat` | camera starter patch: receiver, three taps, one worked example |
| `cv.receive.maxpat` | the camera receiver — socket on UDP 7500, throughput, channel list |
| `cv.point.maxpat` | a camera tap: channel dropdown + outlets |
| `cv.js` | splits camera OSC addresses for the receiver; must stay beside the patches |
| `cv-poke.py` | fakes the camera for testing without one |
| `cv-synth.maxpat` | **the class demo** — two hands, two voices, each a subpatcher; see below |
| `cv-pinch-synth.maxpat` | the same idea as one flat grid, no packages needed; kept for comparison |
| `xfade~.maxpat` | Christopher Dobrian's crossfader, vendored; see below |

## Using a tap

Copy an `ap.channel` bpatcher, lock the patch (⌘E), pick a channel from its
dropdown. Outlets: whole reading · axis 1–4 · magnitude. `[ap.channel ap.gyro]`
typed directly also works, no dropdown needed.

## Class demo: `phone-gyroscope-demo.maxpat`

Gyro rotation rate drives `groove~` playback speed through a resonant filter
— turning the phone scrubs/pitches the sample. Needs a file named
`tudor.wav` in this folder; it's intentionally not committed (source audio,
not ours to redistribute), so drop your own `.wav` there and rename it, or
edit the `buffer~ tudor tudor.wav` object to point elsewhere.

## Camera → Max

```sh
uv sync && uv run fetch-models                     # once; MediaPipe is ~120 MB of it
uv run track-demo --track hands --dim 0 --osc max   # hands only, black background, OSC on UDP 7500
open patches/max/attention-cv.maxpat               # receiver, three taps, a worked example
```

`cv.point` taps work like `ap.channel`: copy one, lock the patch, pick a
channel. Scalars worth knowing: `cv.hand.right.pinch` (thumb to index tip,
metres), `cv.hand.right.size` (palm length in image units — the only thing
that tracks distance from the camera), `cv.pose.0.center` (hip midpoint),
`cv.*.present` (1 while tracked). Rationale and the full channel list:
[`docs/attention-cv-max.md`](../docs/attention-cv-max.md).

No camera handy? `python3 patches/max/cv-poke.py` fakes one.

## Class demo: `cv-synth.maxpat`

```sh
open patches/max/cv-synth.maxpat
```

Two hands, two voices. The parent patch is small on purpose: a block of
defaults at the top (fundamental, pinch min and max, resonance, size far and
near — each a message fired by `loadbang` and sent by name), `udpreceive`,
then `p left hand` and `p right hand`, summed into `ezdac~`. Double-click a
hand to open it. Inside, one column read top to bottom:

| the hand does | the sound does | how |
| --- | --- | --- |
| is in the frame | fades in; leaves, fades out over 300 ms | `OSC-route /present` → `line~` → `*~` |
| moves up and down | crossfades triangle (raised) ↔ saw (low) | wrist y → `line~` → `xfade~` |
| pinches / opens thumb and index | lowpass sweeps 0–6 octaves above the fundamental | pinch (m) → `scale` → `expr 110.*pow(2., $f1)` → `line~` → `lores~` |
| moves toward the camera | gets louder, -40 dB far to 0 dB near | palm `size` → `scale` → `dbtoa` → `line~` → `*~` |
| moves left and right | pans | wrist x → `zmap` → `pan2` |

The right hand is the same patch listening to `/cv/hand/right`, with
`receive fund` → `* 1.5` before the oscillators: a fifth up.

Three things need the package or the folder: `OSC-route` is from CNMAT
Externals (Package Manager), `xfade~` is Dobrian's abstraction in this folder,
and `pan2` is an example abstraction that ships inside Max 8 itself. An empty
box in place of any of them is a missing dependency, not a broken patch.

**Calibrate first.** Pinch arrives in metres, size in image units, and both
depend on the hand and the camera. Defaults are 0.02–0.1 m for the pinch and
0.1–0.3 for size. Read the values off a hand at the extremes — fingers touching
and wide apart; arm's length and close to the camera — and type them into the
messages at the top; they reach both hands by `send`. Outside the range is
clipped, not extrapolated.

**Why the waveform blend is hard to hear with the pinch closed:** the lowpass
sits after the blend and strips exactly the harmonics that tell triangle from
saw. Open the pinch and the difference is there. That's subtractive synthesis
doing what it does, and worth pointing at.

**Why `OSC-route` and not `route`.** Vanilla `route` matches the whole
message selector, so `route /cv/hand/left` matches nothing sent to
`/cv/hand/left/pinch`; splitting an address one level at a time needs
CNMAT's object. (`cv-pinch-synth.maxpat` avoids the package by listing all
the full addresses in one `route`, at the cost of a very wide box.)

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
