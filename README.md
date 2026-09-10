# tuning-attention-demos

Two live demos for *Tuning Attention* (21M.369): a phone's motion sensors into
Max, and a laptop camera's hand and body tracking into Max. Vanilla Max 8 or 9
for the patches; Python only for the camera and for optional phone tools.

This repo is a read-only handout — clone it and use it.

## What you need

| | for | where |
| --- | --- | --- |
| **Max 8 or 9** | everything | cycling74.com; the free 30-day trial is enough for the term's demos |
| **CNMAT Externals** package | the camera patch only (`OSC-route`) — the phone demo needs no package | in Max: File → Show Package Manager, search "CNMAT Externals", Install |
| **git** and **uv** | the camera | `brew install git uv`, or [uv's installer](https://docs.astral.sh/uv/) |
| a webcam | the camera | the laptop's own is fine |
| a phone | the phone demo | any phone's browser, via the QR in the patch; or the **Ductus** iOS app (App Store), which adds AirPods head motion |

Everything else — the Python packages, the tracking models, Dobrian's `xfade~`
crossfader — is fetched by the steps below or is already in this repo.

## Setup, once per machine

```sh
git clone https://github.com/HAI-Res/tuning-attention-demos.git
cd tuning-attention-demos
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/tuning-attention   # Max 8
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 9/Library/tuning-attention   # Max 9
```

Use the line for the Max you have (both is harmless). Then restart Max — it
scans its search path at launch. Without the link, patches open with empty
boxes where the bpatchers and abstractions should be.

For the camera:

```sh
uv sync                     # Python 3.13, MediaPipe, OpenCV — about 120 MB
uv run fetch-models         # the tracking models, about 30 MB, into models/
```

and the CNMAT Externals package from Max's Package Manager (one click; it
provides `OSC-route`, which splits an OSC address one level at a time — the
built-in `route` cannot).

## Phone → Max

```sh
open patches/max/phone-gyroscope-demo.maxpat
```

Point the phone's camera at the QR code in the patch. It opens a web page on
the class server (`ductus-web-app.csail.mit.edu`) keyed to *your* laptop —
the five-letter **room** shown in the receiver — and your phone's sensors
appear in your Max. Turn the phone and the sample scrubs and pitches with it. Nothing to install on the phone, and the laptop only
needs Max: the receiver pulls your room down from the server through a script
bundled with Max. Works on any wifi, because both ends only make outbound
connections.

The page is a copy of the Ductus app's screen: switch sensors on and off, watch
the rate beside each, and tap **Start**. iOS asks once for motion access, and
for the microphone if you switch that on. Keep the page in the foreground;
browsers stop motion events in the background.

**Have the Ductus app?** Switch the menu under the QR to *Ductus app* and
scan again: the app sends OSC straight to Max over the LAN, at 100 Hz, and
reaches AirPods head motion, which no browser can. The first packet triggers
an iOS *Local Network* prompt; nothing arrives until you allow it.

The patch wants a `tudor.wav` in `patches/max/` — drop in any `.wav` under
that name, it is deliberately not committed. How the patch works, and how to
build your own mapping from the same pieces:
[`patches/max/README.md`](patches/max/README.md).

## Camera → Max

```sh
uv run track-demo --track hands --dim 0 --osc max   # hands only, black background, OSC on UDP 7500
open patches/max/cv-synth.maxpat                    # two hands, two voices
```

Each hand is a voice. Pinch opens a lowpass filter, hand height blends between
two waveforms, moving toward the camera makes it louder, left–right pans it.
The left hand plays the fundamental, the right hand a fifth up. Double-click a
hand in the patch to see how. First time, calibrate the pinch and size ranges
to your own hand — the readouts and the boxes to type into are described in
[`patches/max/README.md`](patches/max/README.md).

If your left hand drives the right-hand voice, add `--swap-hands`. Drop
`--dim 0` to see yourself; `d` and `t` cycle the view while it runs.

## If it's not working

| symptom | first thing to try |
| --- | --- |
| empty boxes in a patch | the `ln -sfn` above, then restart Max; an empty `OSC-route` means the CNMAT package isn't installed |
| phone (web page): nothing arrives | the receiver's status line should read "connected to ductus-web-app.csail.mit.edu · room …"; the phone's page shows the same room. If the relay gave up, send it a `bang`. `https://ductus-web-app.csail.mit.edu/health` lists every live phone |
| phone (app): nothing arrives | Local Network permission, then port 7400 on both ends |
| camera: nothing arrives | quit Max and `uv run osc-dump 7500` — if nothing prints, the problem is before Max |
| app on class wifi refuses | client isolation blocks phone→laptop OSC; use the web page (menu under the QR), which goes through the server |
| two patches fight | only one receiver per port may be open — one phone patch, one camera patch |

## What's here

| path | what |
| --- | --- |
| `patches/max/` | the two demos, the pieces they are built from, and the run sheet |
| `src/attention_cv/` | the camera tracker and its OSC sender |
| `src/attention_phone/` | the phone receiver and web page — what runs on the class server; only needed here for the "this laptop" option |
| `tests/` | `uv run pytest` |

The iOS app's source, the class server's deployment, the long-form design
notes and the course's research code live in other repos; this one is only
what is needed to run the demos.
