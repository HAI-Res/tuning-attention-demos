# attention-phone

> This is the long-form design write-up for the phone side, moved here from the root README of the private `tuning-attention-class-demos` repo. Links to `ios/…` and `SURVEY.md` refer to that repo, where the Ductus app lives. The short version to run things from is the root [`README.md`](../README.md).

Stream real phone sensors (accelerometer, gyro, attitude, compass) into
sound, live, for *Tuning Attention* (21M.369).

## Quick start

```sh
open patches/max/attention-phone.maxpat
```

Point the phone's camera at the QR code in the patch — no laptop-side server
needed, the phone talks to Max directly. Needs the native **Ductus** app on
the phone (see [`ios/README.md`](ios/README.md)). Full walkthrough:
[`patches/max/README.md`](patches/max/README.md).

**Then try `phone-gyroscope-demo.maxpat`** — turn the phone and you should hear a
sample scrub/pitch with it. That's the quickest way to confirm the phone is
actually connected, rather than just watching numbers move. (Needs a
`tudor.wav` in `patches/max/` — see the Max README.)

## Three ways in

- **The web page** — the QR in the patch, by default. Any phone's browser,
  through the class server at `ductus-web-app.csail.mit.edu`, keyed to your
  laptop by a room code; the receiver's `relay.js` pulls it back into Max.
  Eight of the app's seventeen channels, including the microphone. How and
  why it is hosted: [`hosting.md`](hosting.md).
- **Native iOS app** (*Ductus*) — OSC straight to Max over the LAN at 100 Hz;
  also reaches AirPods head orientation. Menu under the QR.
- **A page served from your own laptop** — `uv run phone-demo --osc
  127.0.0.1:7400`, for a LAN with no internet. Third item in the same menu.

The Max side is the same for all three: [`attention-phone-max.md`](attention-phone-max.md).

## Sending elsewhere

```sh
uv run phone-demo --osc 127.0.0.1:57120    # SuperCollider / Max / Pd
```

## If it's not working

```sh
uv run phone-demo --check
```

Diagnoses network/certificate issues. Most common cause: wifi **client
isolation** blocks phone→laptop traffic outright — nothing on the laptop
fixes that, use `uv run phone-demo --tunnel` instead.

## More

| you want | read |
| --- | --- |
| design reasoning, what a phone can actually expose | [`SURVEY.md`](SURVEY.md) |
| the iOS app: building, known traps | [`ios/README.md`](ios/README.md) |
| Max: receiving, and why the patches are shaped that way | [`patches/max/README.md`](patches/max/README.md) |
| rules not obvious from the code | [`CLAUDE.md`](CLAUDE.md) |
| shipping the app | [`ios/APPSTORE.md`](ios/APPSTORE.md) |
