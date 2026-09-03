# attention-phone

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

## Two ways in

- **Max** — vanilla Max 8 patches, phone talks to it directly. See
  [`patches/max/README.md`](patches/max/README.md).
- **Native iOS app** (*Ductus*) — also reaches AirPods head orientation and
  mic onset detection, at 100 Hz. See [`ios/README.md`](ios/README.md).

(There's also a browser-based sender path via `uv run phone-demo` — not
verified working right now, so use the app + Max path above instead until
that's sorted out.)

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
