# attention-phone

Phone sensors — accelerometer, gyroscope, attitude, compass — streamed onto the
laptop for the tuning-attention class. Companion to
[`attention-cv`](../tunning-attention-class): same language, same `uv` runner
conventions, same one-command bar.

Nothing to install on the phones. No App Store, no TestFlight, no per-student
provisioning. A student opens a URL, taps Start, and their movement is on the
laptop.

## Setup

```sh
uv sync                 # create .venv and install
uv run phone-demo       # serve the sender page, print a QR code, show live values
```

Then scan the QR code with a phone on the same wifi, type a name, tap **Start**,
and allow motion access when iOS asks.

```
https://10-0-0-184.local-ip.sh:8443  3 phones · 24s

  Ada             59.4 Hz   +0.31   -1.20   +2.44  |█▊          |  2.75
                        attitude  yaw  214.8  pitch   -3.2  roll   88.1
  Grisha          58.8 Hz   -0.02   +0.11   -0.05  |▏           |  0.12
  Anna            59.1 Hz   +4.10   +0.88   -6.02  |████▍       |  7.34
```

## The demos

```sh
uv run phone-demo                          # accelerometer, live, all phones
uv run phone-demo --sensor gyro            # or accelg / gravity / attitude / mag
uv run phone-demo --osc 127.0.0.1:57120    # forward to SuperCollider / Max / Pd
uv run phone-demo --tunnel                 # public URL, for a wifi that blocks LAN traffic
uv run phone-demo --check                  # network + certificate diagnostics
uv run phone-demo --phyphox 10.0.0.7,10.0.0.8   # also poll phyphox devices
```

No phone to hand? A synthetic one speaks the same protocol, so you can build a
sound mapping on a train:

```sh
uv run phone-demo                                  # in one pane
uv run fake-phone --insecure -n 4 --hz 60          # in another: four walking phones
```

`fake-phone` generates a walking gait — a ~2 Hz bounce with a sharper
heel-strike transient — rather than noise, because a mapping tuned against
white noise falls apart the moment a body is involved.

On exit `phone-demo` prints how the run actually went, which is the number that
matters:

```
3 device(s):
  Ada (ph-a3f9)
    accel      1412 samples, 59.4 Hz, interval median 16.7ms p95 21.3ms worst 84.1ms
    attitude   1412 samples, 59.4 Hz, interval median 16.7ms p95 21.4ms worst 84.2ms
```

## Units, and the one trap worth knowing

Every source normalises to the same units on the way in, because the sources
disagree in ways that cost an afternoon. The web `DeviceMotionEvent` reports
rotation in **degrees** per second; CoreMotion and Sensor Logger use
**radians** per second. CoreMotion's `userAcceleration` is in **g**; the web
API and Sensor Logger use **m/s²**. Downstream, there is one set of units:

| sensor | axes | unit |
| --- | --- | --- |
| `accel` | x, y, z | m/s², **gravity removed** |
| `accelg` | x, y, z | m/s², gravity included |
| `gravity` | x, y, z | m/s² |
| `gyro` | x, y, z | rad/s |
| `attitude` | yaw, pitch, roll | degrees |
| `mag` | x, y, z | microtesla |
| `heading` | deg | degrees from true north (iOS only) |
| `pressure` | kpa | kilopascal |
| `location` | lat, lon, alt, speed | degrees, m, m/s |

`accel` is almost always the one you want: gravity removed means a phone lying
still reads ~0 instead of 9.8 in whichever axis happens to be down, so a
mapping does not need to know how the phone is being held. `Reading.magnitude`
goes further and ignores orientation entirely — it is the single most useful
scalar to put onto sound.

## Why HTTPS, and why the URL looks like that

`DeviceMotionEvent.requestPermission()` — the iOS 13+ gate on motion data —
only exists in a **secure context**. A page served over plain HTTP gets no
accelerometer at all, silently. So the page has to be HTTPS, which on a LAN
normally means a self-signed certificate and twenty students each tapping
through a full-page "This Connection Is Not Private" warning.

[`local-ip.sh`](https://local-ip.sh) avoids that. `10-0-0-184.local-ip.sh`
resolves over public DNS to `10.0.0.184`, and the project publishes a real
Let's Encrypt wildcard certificate for `*.local-ip.sh` **together with its
private key**. The name matches and the issuer is trusted, so iOS and Android
accept it with no warning and nothing to install.

Stated plainly: that private key is public, so this TLS authenticates nothing
and protects against nobody. It buys the "secure context" bit the motion API
demands, not confidentiality. Fine for accelerometer data in a classroom;
never use this pattern for anything real.

Two things can still break it, and `--tunnel` is the answer to both:

- **A resolver with DNS-rebinding protection** refuses answers pointing into
  private address space, so the hostname will not resolve at all.
- **Wifi client isolation** blocks phone→laptop traffic entirely. Nothing on
  the laptop can fix this; the packets never arrive.

`--tunnel` runs a Cloudflare quick tunnel (`brew install cloudflared`, free, no
account). Phone and laptop both make *outbound* connections, which every
network allows. Costs a dependency on the internet and 30–80 ms of extra
latency.

## Which address? (the VPN trap)

The usual way to find "my IP" — open a UDP socket to 8.8.8.8 and read back the
local address — returns the address on whatever interface holds the default
route. **With the MIT VPN connected that is the tunnel**, an 18.x address no
phone on the room's wifi can reach. So `phone-demo` enumerates every interface
instead, skips tunnels and Apple's peer-to-peer links, and prefers a private
address on real wifi or ethernet. If it still guesses wrong it prints the
alternatives, and `--host` overrides it.

```
$ uv run phone-demo --check
addresses:
  → 10.0.0.184       en0      private
    18.30.132.126    utun4    PUBLIC, point-to-point (VPN?)
```

## Sending to SuperCollider, Max or Pd

```sh
uv run phone-demo --osc 127.0.0.1:57120
```

Addresses are `/phone/<name>/<sensor>` with the axes as floats:

```
/phone/ada/accel     -0.02  0.11  -0.05
/phone/ada/attitude  214.8  -3.2  88.1
```

Names are slugified, since OSC treats space, `#`, `*`, `?`, `[`, `{` and `/` as
pattern characters. Measured here: 4 phones × 6 sensors × 60 Hz is ~1400
packets/second, which neither the sender nor scsynth notices.

**Gotcha found on this machine:** `ollama` was bound to UDP **57120**,
SuperCollider's default language port, which had pushed `sclang` to 57121.
Check `lsof -nP -iUDP:57120` before blaming the patch.

## What can this phone's browser actually do?

`https://<the URL>/probe` measures it rather than guessing: the real
`devicemotion` and `deviceorientation` rates with interval percentiles, which
channels come back null, the microphone sample rate, camera resolution and frame
rate, and an explicit list of what iOS refuses (Generic Sensor API — so no rate
control — plus Web Bluetooth, Web MIDI, Vibration, ambient light, barometer). It
ends with a copyable report. Takes about 25 seconds and settles the
web-versus-native question with a number instead of an argument.

## The native iOS app

`ios/` holds a SwiftUI app that streams everything an iPhone exposes — including
the two things the browser cannot reach: **AirPods head orientation**
(`CMHeadphoneMotionManager`, up to 100 Hz) and **microphone onset detection**.
It speaks the same WebSocket protocol as the sender page, so `phone-demo` takes
it with no changes, and it can also send OSC/UDP straight to SuperCollider with
no laptop-side server at all.

See `ios/README.md` for building it and for the two iOS-specific traps
(`NSLocalNetworkUsageDescription`, and `URLSessionWebSocketTask` not answering
server pings) that cost real debugging time here.

## Other sources

The web page is the one built for the class, but the hub takes anything.

**Sensor Logger** (free, App Store) POSTs to `/sensorlogger` on the same port —
set its HTTP Push URL to `https://10-0-0-184.local-ip.sh:8443/sensorlogger`.
Worth it for sensors the browser cannot reach — barometer, pedometer, heart
rate, **AirPods head motion** — and because it writes a full-rate local
recording at the same time.

It does stream live, and each push carries every sample in the window at full
sensor rate, so nothing is lost. But the batch period **defaults to one
second**, and making it shorter is a paid Plus/Pro feature. That makes it a
data-collection path, not a gesture-to-sound path — use the web page when a
movement needs to be heard as it happens.

**phyphox** (free, open source, RWTH Aachen) is the reverse direction: the
laptop polls the phone's own webserver, port 80 on iOS. Occasionally the only
direction a network permits. `--phyphox IP[,IP...]`. Incremental fetching with
a monotonic threshold means a slow poll rate loses no samples — they just
arrive in bursts.

## Layout

| path | what it is |
| --- | --- |
| `src/attention_phone/model.py` | `Reading`, the axis/unit table |
| `src/attention_phone/hub.py` | `SensorHub` fan-in, `RateMeter`, per-device state |
| `src/attention_phone/server.py` | the one aiohttp app: page, socket, push endpoint |
| `src/attention_phone/web/index.html` | the sender page students open |
| `src/attention_phone/sources/web.py` | the sender page's WebSocket protocol |
| `src/attention_phone/sources/sensorlogger.py` | Sensor Logger HTTP Push |
| `src/attention_phone/sources/phyphox.py` | phyphox REST poller |
| `src/attention_phone/net.py` | which address a phone can actually reach |
| `src/attention_phone/certs.py` | the `local-ip.sh` certificate |
| `src/attention_phone/tunnel.py` | cloudflared quick tunnel |
| `src/attention_phone/osc.py` | 60-line OSC encoder, no dependency |
| `src/attention_phone/display.py` | the live terminal readout |
| `src/attention_phone/fake_phone.py` | synthetic phone for development |
| `tests/` | `uv run pytest` — 44 tests |

### Why a separate repo rather than another demo inside `attention-cv`

Judgement call, easily reversed. The dependency trees do not overlap at all —
`attention-cv` pulls ~120 MB of mediapipe and opencv, this pulls aiohttp — and a
student who wants accelerometer data should not wait for a CV stack to build,
or vice versa. If it turns out that in practice the two are always used
together, moving `src/attention_phone/` in as a second package is a small
change; nothing here depends on living at the repo root.

`SURVEY.md` is the survey behind the design choices: what an iPhone can
actually expose, what already exists, and why this is a web app rather than a
native one.

## What is verified, and what still needs a phone

Tested end to end on this laptop: the server, the WebSocket protocol, the hub,
the OSC output (4 phones × 6 sensors × 60 Hz, zero sample loss, p95 interval
17.8 ms against a 16.7 ms target), the Sensor Logger endpoint against the
schema from its documentation, the phyphox parser against synthetic responses,
and the `local-ip.sh` certificate and DNS from this machine.

**Not yet tested, because it needs hardware and a room:**

1. **A real iPhone.** The permission flow, and what rate iOS Safari actually
   delivers `devicemotion` at. Reports range from 30 to 60 Hz depending on iOS
   version; the page shows its own measured rate so this answers itself in one
   minute.
2. **The class wifi.** Whether `local-ip.sh` resolves on it, and whether it has
   client isolation. This is the single biggest unknown and decides whether the
   LAN path or `--tunnel` is the default on Sept 9. `--check` diagnoses the
   first half.
3. **Sensor Logger's real payload.** The name and unit mapping comes from its
   published schema, not from a live push. Unrecognised sensors are passed
   through as `sl:<name>` rather than dropped, so a wrong guess shows up on the
   display instead of vanishing.
4. **`--tunnel`.** `cloudflared` is not installed on this machine.
