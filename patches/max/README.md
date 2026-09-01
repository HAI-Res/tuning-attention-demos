# attention-phone in Max

Vanilla Max 8 — no packages, no externals, no CNMAT odot, because this has to
open on twenty students' stock installs.

Two reusable pieces rather than one big patch:

```
[bpatcher ap.receive.maxpat]                   one per Max session; it owns the socket
[bpatcher ap.channel.maxpat @args ap.gyro]     a tap: pick a channel, use the outlets
```

```sh
open patches/max/attention-phone.maxpat        # the starter patch, using both
```

It listens on **UDP 7400**. Nothing else needs to be running: the phone talks
to Max directly.

| file | what it is |
| --- | --- |
| `attention-phone.maxpat` | starter patch — a receiver, three taps, one worked example |
| `attention-phone-monitor.maxpat` | all seventeen channels with their arrival rates |
| `ap.receive.maxpat` | the receiver: socket, address, phone chooser, throughput |
| `ap.channel.maxpat` | one tap: a channel dropdown and its outlets |
| `attention-phone.js` | splits the OSC address; the reason is below |
| `address.js` | this Mac's address, via Node for Max |
| `poke.py` | drives every channel so the patch works with no phone |

**Both patches contain a receiver, and a receiver owns UDP 7400 — so open one
at a time.** The monitor is for answering "is the phone sending this at all";
the starter is for doing something with it.

## Pointing the phone at it

The receiver block prints the address and a link. Open the link on the phone and
it sets host, port and mode in one tap:

```
attention-phone://configure?host=128.30.9.64&osc=7400&mode=osc
```

`mode=osc` sends only OSC; `mode=both` also keeps the WebSocket to `phone-demo`
alive, which is what you want if you would like the terminal readout at the
same time. Keys left out of the link are left alone.

Two things to expect on a first run. iOS raises its **Local Network** permission
prompt on the first packet, and until it is answered nothing arrives. And
reinstalling the app from Xcode can reset its `UserDefaults`, which lands it on
`mode=websocket` with a blank host — so re-open the link after a rebuild.

## Or from `phone-demo`

```sh
uv run phone-demo --osc 127.0.0.1:7400
```

Same addresses, same units, so the patch does not care which is upstream.
Browsers only reach six of the seventeen channels; the rest stay at 0 Hz, which
is the honest answer rather than an empty row.

## No phone at hand

```sh
python3 patches/max/poke.py                 # two phones, all channels, 10s
python3 patches/max/poke.py 127.0.0.1:7400 60
```

Use it to tell "the patch is wrong" apart from "nothing is arriving", which is
the first question every time.

## Using a tap

Copy an `ap.channel` bpatcher as many times as you like. Outlets, left to right:

| outlet | what |
| --- | --- |
| 0 | the whole channel as a list |
| 1–4 | axis 1, 2, 3, 4 — x/y/z, or yaw/pitch/roll, or w/x/y/z |
| 5 | magnitude, the length of the vector |

An axis outlet **holds its last value** when the channel has fewer axes than
four: `heading` only ever fires outlet 1. Magnitude is meaningful for the vector
channels — `accel`, `gravity`, `gyro`, `mag`, `headaccel` and the raw ones — and
is the single most useful scalar to put onto sound, because it does not care how
the phone is being held.

The dropdown changes the channel live. What persists is the **object's
argument** — `@args ap.head` — so edit that to make a choice stick.

**You must lock the patch (⌘E) to click a dropdown.** Unlocked, clicking a
bpatcher selects it instead of operating the menu inside. This is the first
thing to check when a menu appears to do nothing.

## What the receiver shows

| | |
| --- | --- |
| **port** | 7400 on load. Change it and `udpreceive` rebinds immediately. |
| **host / link** | this Mac's address, found automatically, and the configure link. Type over the host if the guess is wrong. |
| **phone** | every name seen. The taps carry **one phone at a time** — the one selected here. `clear` forgets the list, worth doing when half the room has put their phones away. |
| **throughput** | phones seen and messages/second, counting *all* phones. |
| **last address** | the most recent OSC address, verbatim. The fastest way to see that packets are arriving but the names are not what you expected. |

A phone with no name set sends under its device id, so expect
`/phone/ios-e5b28f/accel` rather than a person's name.

One unit to be careful with: `audio` is `rms, peak, onset`, and only the first
two are 0–1. **`onset` is a dB rise between frames** — `max(0, db - previous)`
in `AudioProvider.swift` — so it is bounded below at 0 and unbounded above.
Values above 1 are a sharp transient, not a bug, and scaling it as if it were
0–1 will clip every real hit. The app agrees since Ductus 1.0 (1), where
`Channel.audio.unit` reads "0–1, dB rise".

## Nothing on screen updates at sensor rate

A phone sends at up to 100 Hz. Number boxes wired straight to that flicker, and
flicker at that rate is a **migraine and vestibular trigger** — for some people
that makes a patch unusable, not merely busy. So in the monitor:

- **Averaged over the window, not sampled.** Vector channels show the mean, and
  magnitude is the mean of the per-sample magnitudes — not the magnitude of the
  mean, which would cancel out exactly the movement you are looking at.
- **Angles show their last sample**, because averaging one is wrong at the
  wrap-around: the mean of 359° and 1° is 180°, the one direction the phone was
  never pointing. That covers `attitude`, `head`, `heading` and `quat`.
- **Two seconds between updates** by default, adjustable from 250 ms to 30 s,
  and a **freeze** that holds the screen completely still.
- **Few decimal places**, because fewer digits mean fewer digits *changing*.
  Location keeps five, or it stops being a location.

None of this touches the data. Taps get the full-rate stream, so a mapping runs
at the phone's real rate while the screen is frozen solid.

## Why there is a `js` in the middle of it

The one thing worth reading before editing.

**Max 8's `udpreceive` decodes OSC itself and hands the address over as the
message *selector*.** `/phone/ada/accel 0.1 0.2 9.8` arrives as a message named
`/phone/ada/accel` with three floats. Fine for a fixed address — but a student
types their own name, so the middle component is not known until it arrives, and
`route` cannot be given its arguments at runtime.

Three things that look like the answer and are not:

- **`oscparse`** would split the address into path components. It is not in
  Max 8.5; check before reaching for it.
- **`[tosymbol]` → `[fromsymbol @separator /]`** does split the address, and is
  the idiom the `fromsymbol` help file shows. But it interns a new symbol for
  every message that crosses it — one per distinct float value — and Max never
  frees its symbol table. At 100 Hz that is a slow leak, not a style problem.
- **CNMAT's `[OSC-route]` / odot** handle all of this properly and are the right
  answer in a patch allowed a package dependency. This one is not.

So `attention-phone.js` reads `messagename`, splits it, and re-emits the values
under the *channel* name — a fixed, known list — which the receiver fans out to
`[s ap.<channel>]`. Only the last two components of the address are used, so a
changed `--osc-prefix` still works.

**`[receive]` takes `set <name>` at runtime.** That is the whole reason a channel
dropdown is possible: the tap is one `[receive]` whose name the menu rewrites.
`[route]` cannot do that, which is why the monitor has to enumerate all
seventeen rows and a tap does not.

**The `.js` files must sit next to the patches.** Max searches the patcher's own
folder; move a `.maxpat` somewhere else on its own and the `js` object fails to
create, taking every patch cord attached to it with it.

### If `js` does not work here at all

Unverified as of 2026-09-01: the phone provably delivers 99 Hz to port 7400
(packet capture), but nobody has yet confirmed the `js` object instantiates on
the machine this runs on. If it does not, that is a rethink rather than a
tweak — the address still has to be split somewhere, and with `oscparse`
absent and `fromsymbol` leaking, only two real options remain:

- **Add the CNMAT package** and use `[OSC-route]`. Correct, and costs the
  no-dependencies property this patch set was built around.
- **Move the split to the Python side**: have `phone-demo` emit per-channel
  OSC addresses that a plain `[route]` can match with fixed arguments. Costs
  nothing in Max and changes the wire format, so the app and the page would
  have to agree.

Decide which before rebuilding anything; both are real, neither is a small
edit to what is here.

## Where the address comes from

Max has no object that reports a local IP and its `js` cannot enumerate network
interfaces, so `address.js` runs under **`node.script`** — Node for Max, bundled
with every Max 8, not a package you fetch. It scores every interface the way
`net.py` does and prefers a real one.

It is isolated: if it fails to start, the host and link boxes stay blank, you
type the address in by hand, and nothing else is affected.

Two things it exists to avoid: a VPN tunnel address no phone can reach (the MIT
VPN puts an 18.x address on `utun4`), and a **self-assigned 169.254.x** address
from an adapter whose DHCP never answered — which looks private, scores like it,
and is never routable. That one really did win over live wifi until it was
fixed.

## When nothing arrives

UDP has no notion of a peer that is not there, so a wrong address, a wrong port
and a blocked network all look identical: silence. In order of how often it is
the cause —

1. **The Local Network prompt**, or a rebuild that reset the app's settings.
2. **The port.** The app's OSC port and the number box must match. 57120 is
   SuperCollider's default and a reasonable thing to type by habit; on this
   machine `ollama` also binds it. 7401 is in use too — `attention-cv` sends
   there. `lsof -nP -iUDP:<port>` before blaming the patch.
3. **The address.** `uv run phone-demo --check` prints the one a phone can
   actually reach, which is *not* the one with the MIT VPN connected.
4. **Client isolation** on the wifi, which blocks phone→laptop traffic
   outright. Nothing on the laptop can fix it. `phone-demo --tunnel` is a
   WebSocket path and carries no UDP, so run `phone-demo --osc 127.0.0.1:7400`
   alongside it and let the laptop forward into Max.

`python3 patches/max/poke.py` rules out the patch itself in about five seconds,
which is worth doing before any of the above.

**The app's own status light cannot help you here.** OSC over UDP has no reply,
so the app can honestly say it is *sending* and can never say anything
*arrived* — that is what "Sending — arrival not confirmable" means. The
receiver's `last address` box is the ground truth.
