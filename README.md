# tuning-attention-demos

Two live demos for *Tuning Attention* (21M.369): a phone's motion sensors into
Max, and a laptop camera's hand and body tracking into Max. Vanilla Max 8 for
the patches; Python only for the camera and for optional phone tools.

This repo is a read-only handout — clone it and use it.

## Setup, once per machine

```sh
git clone https://github.com/HAI-Res/tuning-attention-demos.git
cd tuning-attention-demos
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/tuning-attention
```

Then restart Max — it scans its search path at launch. Without the link,
patches open with empty boxes where the bpatchers should be.

For the camera you also need [uv](https://docs.astral.sh/uv/) (`brew install uv`),
then:

```sh
uv sync          # Python 3.13, MediaPipe, OpenCV — ~120 MB
uv run fetch-models         # the tracking models, ~30 MB, into models/
```

## Phone → Max

```sh
open patches/max/attention-phone.maxpat
```

Point the phone's camera at the QR code in the patch — no laptop-side server,
the phone talks to Max directly. Needs the **Ductus** app on an iPhone (App
Store, by Chaparral Studios; it also reaches AirPods head motion and mic onset).
The first packet triggers an iOS *Local Network* prompt; nothing arrives until
you allow it.

**Then try `3. gyro_buffer.1.maxpat`**: turn the phone and a sample scrubs
and pitches with it. That is the quickest way to confirm the phone is really
connected. It wants a `tudor.wav` in `patches/max/` — drop in any `.wav` under
that name, it is deliberately not committed.

There is also a browser sender (`uv run phone-demo`, then open the page it
prints on the phone) that needs no app. It was not verified on class wifi as
of this writing, so start with the app.

## Camera → Max

```sh
uv run track-demo --osc max                   # laptop camera → OSC on UDP 7500
open patches/max/cv-pinch-synth.maxpat        # two hands, two voices
```

Pinch opens a lowpass, hand height blends square into saw, left–right pans,
the right hand plays a fifth up. `attention-cv.maxpat` is the plainer starter
with a receiver and taps for building your own mapping. Details, including
the pinch calibration you will want to do first:
[`patches/max/README.md`](patches/max/README.md).

## If it's not working

| symptom | first thing to try |
| --- | --- |
| empty boxes in a patch | the `ln -sfn` above, then restart Max |
| phone: nothing arrives | `python3 patches/max/poke.py` — patch or phone? Then Local Network permission, then port 7400 |
| camera: nothing arrives | `python3 patches/max/cv-poke.py`; or quit Max and `uv run osc-dump 7500` |
| phone on class wifi refuses | client isolation blocks phone→laptop; `uv run phone-demo --check` diagnoses, `--tunnel` works around it |
| two patches fight | only one receiver per port may be open — one phone patch, one camera patch |

## What's here

| path | what |
| --- | --- |
| `patches/max/` | every Max patch, both sources, and the run sheet |
| `src/attention_phone/` | the phone receiver, browser sender page, and diagnostics |
| `src/attention_cv/` | the camera tracker and its OSC sender |
| `docs/` | the long-form design notes for each half |
| `tests/` | `uv run pytest` |

The iOS app's source and the course's research code live in other repos; this
one is only what is needed to run the demos.
