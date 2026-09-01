# attention-phone in Max

`attention-phone.maxpat` receives everything the iOS app sends and puts it on
screen: seventeen channels, their values, and the rate each one is actually
arriving at. Vanilla Max 8 — no packages, no externals, no CNMAT odot.

The screen updates every two seconds by default and can be frozen outright;
sensor-rate flicker is a migraine trigger, and the data path is separate from
the display path so slowing one down costs the other nothing. See
[Nothing on screen updates at sensor rate](#nothing-on-screen-updates-at-sensor-rate).

```sh
open patches/max/attention-phone.maxpat     # or File → Open in Max
```

It listens on **UDP 7400**. Nothing else needs to be running: the phone talks
to Max directly.

## Pointing the phone at it

Find the laptop's address (`uv run phone-demo --check` prints it), then either
scan a link or type it into the app's settings:

```
attention-phone://configure?host=10.0.0.184&osc=7400&mode=osc&name=ada
```

`mode=osc` sends only OSC; `mode=both` also keeps the WebSocket to `phone-demo`
alive, which is what you want if you would like the terminal readout at the same
time. Keys left out of the link are left alone.

The **first** OSC packet makes iOS raise its Local Network permission prompt.
Until it is answered the app's status line says "waiting", not "failed", and
nothing arrives — this is normal on the first run and easy to misread as a
broken patch.

## Or from `phone-demo`

The browser senders go through the laptop, so forward them:

```sh
uv run phone-demo --osc 127.0.0.1:7400
```

Same addresses, same units, so the patch does not care which one is upstream.
Browsers only reach six of the seventeen channels; the rest stay at 0 Hz, which
is the honest answer rather than an empty row.

## No phone at hand

```sh
python3 patches/max/poke.py                 # two phones, all channels, 10s
python3 patches/max/poke.py 127.0.0.1:7400 60
```

Every row moves except the ones a real phone would also leave still. Use it to
tell "the patch is wrong" apart from "nothing is arriving", which is the first
question every time.

## What is on screen

| | |
| --- | --- |
| **port** | 7400 on load. Change it and `udpreceive` rebinds immediately. |
| **phone** | Every name seen so far. The value rows show **one phone at a time** — the one selected here. `clear` forgets the list, which is worth doing when half the room has put their phones away. |
| **screen updates** | How often anything on screen is allowed to change, and a freeze that stops it entirely. See below — this one is not a preference. |
| **throughput** | Phones seen and messages/second, counting *all* phones, not just the selected one. |
| **last address** | The most recent OSC address, verbatim. The fastest way to see that packets are arriving but the names are not what you expected. |
| **Hz column** | Messages per second, per channel, for the selected phone. `0` means that channel is not arriving — a channel that is off, unavailable, or unsupported looks exactly like one that is silent, and this is what tells them apart. |
| **no row for** | Anything whose channel name the patch does not know. Sensor Logger passes unrecognised sensors through as `sl:<name>`, and they land here instead of vanishing. |

Units are the ones in the root `README.md` — m/s², rad/s, degrees, microtesla,
kilopascal — already converted by whichever sender is upstream. The `|v|` box
on the vector rows is the Euclidean magnitude, which is the single most useful
scalar to put onto sound because it does not care how the phone is being held.

## Nothing on screen updates at sensor rate

A phone sends at up to 100 Hz. Number boxes wired straight to that flicker, and
flicker at that rate is a **migraine and vestibular trigger** — for some people
a patch like this is not merely busy, it is unusable, and a room is enough
people that someone in it is affected. So the display is deliberately slow:

- **Averaged over the window, not sampled.** A box showing every 40th sample
  still jumps around; the mean of the window is both calmer and more
  informative. Vector channels (`accel`, `gyro`, `mag`, …) show the mean, and
  `|v|` is the mean of the per-sample magnitudes — not the magnitude of the
  mean, which would cancel out exactly the movement you are looking at.
- **The rest show their last sample**, because averaging an angle is wrong at
  the wrap-around: the mean of 359° and 1° is 180°, the one direction the phone
  was never pointing. That covers `attitude`, `head`, `heading` and `quat`.
- **Two seconds between updates by default**, adjustable from 250 ms to 30 s.
- **Freeze** stops every moving thing on screen — values, rates, throughput,
  last address — and holds the last picture.
- **Few decimal places.** Fewer digits means fewer digits *changing*, which is
  most of what makes a number box restful. Location keeps five, because at two
  it stops being a location.

None of this touches the data. The full-rate stream leaves the js on outlet 0
untouched, so a mapping or a sound runs at the phone's real rate while the
screen is frozen solid. If you slow the display down and the sound gets chunky,
something has been rewired — the two paths do not share a cord.

`head` and `headaccel` are the AirPods rows. They only fill in when a supported
set is connected to the phone, and they are the reason for having a native app
at all — a browser cannot reach them.

## Building your own mapping on top

Tap **outlet 0 of the js**, in the "full rate" block at the top right. Every
sample, unaveraged and unslowed, for whichever phone is selected; add your own
`[route <channel>]` alongside the `[route accel]` already there. The
`expr sqrt(...)` next to it turns three axes into a magnitude.

Do **not** tap the `route` objects in the grid below. Those are the display
cascade: they carry an averaged value, once per update window, with the rate
bolted on as the first element. Useful to look at, useless to play.

The **hear it** corner in the top right is the smallest possible example —
acceleration magnitude onto the pitch of a `cycle~`. Change the four numbers in
`scale 0. 20. 220. 2000.` first; that one object is most of the mapping.

## Why there is a `js` in the middle of it

The one thing worth reading before editing the patch.

**Max 8's `udpreceive` decodes OSC itself and hands the address over as the
message *selector*.** `/phone/ada/accel 0.1 0.2 9.8` arrives as a message named
`/phone/ada/accel` with three floats. That is fine for a fixed address — but a
student types their own name, so the middle component is not known until it
arrives, and `route` cannot be given its arguments at runtime.

Three things that look like the answer and are not:

- **`oscparse`** would split the address into path components. It is not in
  Max 8.5; check before reaching for it.
- **`[tosymbol]` → `[fromsymbol @separator /]`** does split the address, and it
  is the idiom the `fromsymbol` help file shows. But it interns a new symbol for
  every message that crosses it — including one per distinct float value — and
  Max never frees its symbol table. At 100 Hz that is a slow leak, not a style
  problem.
- **CNMAT's `[OSC-route]` / odot** handle all of this properly, and are the
  right answer in a patch that is allowed a package dependency. This one is not:
  it has to open on twenty students' laptops with a stock Max install.

So `attention-phone.js` reads `messagename`, splits it, and sends the values out
as a message named after the *channel* — which is a fixed, known list, so the
`route` cascade below it is ordinary vanilla Max. Only the last two components
of the address are used, so `--osc-prefix` or a differently-configured app still
works.

**The js file must sit next to the patch.** Max searches the patcher's own
folder; move `attention-phone.maxpat` somewhere else on its own and the `js`
object fails to create, taking every patch cord attached to it with it.

## When nothing arrives

UDP has no notion of a peer that is not there, so a wrong address, a wrong port
and a blocked network all look identical: silence. In order of how often it is
the cause —

1. **The Local Network prompt.** iOS blocks the first packets until it is
   answered. Settings → attention-phone → Local Network.
2. **The port.** The app's OSC port and the number box must match. 57120 is
   SuperCollider's default and a reasonable thing to type by habit; on this
   machine `ollama` also binds it (`lsof -nP -iUDP:57120`). 7400 avoids both.
3. **The address.** `uv run phone-demo --check` prints the one a phone can
   actually reach, which is *not* the one with the MIT VPN connected.
4. **Client isolation** on the wifi, which blocks phone→laptop traffic
   outright. Nothing on the laptop can fix it; that is what `phone-demo
   --tunnel` exists for, and it is a WebSocket path, so run `phone-demo --osc
   127.0.0.1:7400` alongside it and let the laptop forward into Max.

`python3 patches/max/poke.py` rules out the patch itself in about five seconds,
which is worth doing before any of the above.
