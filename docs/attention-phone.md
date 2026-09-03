# attention-phone

Stream real phone sensors (accelerometer, gyro, attitude, compass) into
sound, live, for *Tuning Attention* (21M.369). Nothing to install on the
phone — open a URL, tap Start, movement is on the laptop.

## Quick start

```sh
uv sync
uv run phone-demo
```

Scan the QR code it prints, on a phone on the same wifi. Tap **Start**,
allow motion access when iOS asks. Live values show in the terminal.

No phone yet? `uv run fake-phone --insecure -n 4 --hz 60` simulates a few.

## Three ways in

- **Browser** — what students use. No install, ~60 Hz, works on Android too.
- **Max** — vanilla Max 8 patches that receive the same data. See
  [`patches/max/README.md`](patches/max/README.md).
- **Native iOS app** (*Ductus*, instructor use) — reaches AirPods head
  orientation and mic onset detection, at 100 Hz. See
  [`ios/README.md`](ios/README.md).

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
