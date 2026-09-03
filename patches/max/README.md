# attention-phone in Max

Stream a real phone's sensors (accelerometer, gyro, etc.) into Max. Vanilla
Max 8 — no packages, no externals.

(The camera/MediaPipe pipeline is separate, unfinished work on the
`wip/attention-cv` branch — not covered here.)

## Setup (once per machine)

```sh
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/attention-phone
```

Restart Max — it only scans its search path at launch. Without this, patches
open with empty boxes instead of the bpatchers they need.

## Run it

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

## If nothing arrives

1. Local Network permission not granted yet, or the app reset after a rebuild.
2. Port mismatch — app and Max must both be on 7400.
3. Wifi client isolation blocks phone→laptop traffic; nothing on the laptop
   fixes this.

Run `python3 patches/max/poke.py` first — it tells you in five seconds
whether the problem is the patch or the phone.
