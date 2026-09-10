# attention-phone in Max

Vanilla Max 8 — no packages, no externals, no CNMAT odot, because this has to
open on twenty students' stock installs.

Two reusable pieces rather than one big patch:

```
[bpatcher ap.receive.maxpat]                   one per Max session; it owns the socket
[bpatcher ap.qr.maxpat]                        the code to scan; one in every patch
[bpatcher ap.channel.maxpat @args ap.gyro]     a tap: pick a channel, use the outlets
```

**Only `ap.receive` is limited to one**, because it owns UDP 7400 and a second
one cannot bind it. `ap.qr` owns no socket, so put one in every patch you build
and copy it freely; it draws whatever port the receiver is on, because the
receiver broadcasts that on `ap.port` and every code redraws when it changes. A
code pointing at a port nothing is listening on is worse than no code at all.

Taps read from named sends, which are global across Max, so **one receiver
anywhere feeds every tap in every open patch** — including patches that contain
no receiver themselves.

```sh
open patches/max/attention-phone.maxpat        # the starter patch, using both
```

It listens on **UDP 7400**. Nothing else needs to be running: the phone talks
to Max directly.

## Install it once, so it works in every patch

Max finds an abstraction only if it is on the search path, and that path
includes the folder of the *open patch* — which an unsaved patch does not have.
Paste one of these into a new untitled patch without installing and you get an
empty box: not a broken object, a file Max cannot find.

```sh
ln -sfn "$(pwd)/patches/max" ~/Documents/Max\ 8/Library/attention-phone
```

`~/Documents/Max 8/Library` is on Max's default search path, and a symlink keeps
it pointing at the repo, so editing a file here changes what Max loads. **Then
restart Max** — the search path is scanned at launch. Undo it with
`rm ~/Documents/Max\ 8/Library/attention-phone`; nothing in the repo is touched.

Three failure modes worth recognising, because all three look like a broken
object rather than what they are:

**An empty bpatcher is a missing file.** Check the name against what is actually
in this folder before suspecting presentation mode.

**A bpatcher showing patch cords is an out-of-date file.** Presentation mode is
a property of the abstraction; an older copy of it on the search path will show
its patching view instead.

**Max caches abstractions for the life of a session.** Edit one of these while a
patch using it is open and the open copy keeps the old version — which looks
exactly like your change having no effect. Restart Max to pick it up.

A checkout that is behind produces all three at once, and two copies of the same
abstraction on the search path with different contents is worse still: which one
Max loads depends on where the open patch is saved.

| file | what it is |
| --- | --- |
| `attention-phone.maxpat` | starter patch — a receiver, three taps, one worked example |
| `attention-phone-monitor.maxpat` | all seventeen channels with their arrival rates |
| `ap.receive.maxpat` | the receiver: the socket and the phone chooser. Exactly one. |
| `ap.qr.maxpat` | the address as a scannable code. As many as you like. |
| `ap.channel.maxpat` | one tap: a channel dropdown and its outlets |
| `attention-phone.js` | splits the OSC address; the reason is below |
| `address.js` | this Mac's address and the QR, via Node for Max |
| `qr.js` | draws the QR — no install, see below |
| `vendor/qrcode-generator.js` | the QR encoder, MIT, committed so nothing needs fetching |
| `poke.py` | drives every channel so the patch works with no phone |
| `xfade~.maxpat` | Christopher Dobrian's two-signal crossfader abstraction, vendored so it clones with the repo — see below |
| `attention-cv.maxpat` | separate pipeline's starter patch — a receiver, three taps, one worked example |
| `cv.receive.maxpat` | receives attention-cv's pose/hand landmarks on UDP 7401, fans them out. Exactly one. |
| `cv.channel.maxpat` | one tap: a landmark dropdown (pose + both hands) and its outlets |
| `cv-pinch-synth.maxpat` | two-hand demo: pinch → lowpass, hand height → square/saw blend, hand left/right → stereo pan, right hand a fifth up. Listens on 7500 itself. |

**Both patches contain a receiver, and a receiver owns UDP 7400 — so open one
at a time.** The monitor is for answering "is the phone sending this at all";
the starter is for doing something with it.

## Pointing the phone at it

**Point the phone's camera at the QR in the receiver block.** It sets host, port
and transport in one tap, and redraws itself if the address or port changes, so
it cannot go stale. The same link is printed as text beside it, to read out or
type if a camera is not to hand:

```
ductus://configure?host=128.30.9.64&osc=7400&mode=osc
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

## More than one phone

Every phone that arrives is published under its own name, at full rate, whether
or not it is the one showing in the menu:

```
ap.<phone>.<channel>          ap.ada.gyro, ap.grisha.accel, ap.anna.head
```

So a tap can be pinned to a person:

```
[ap.channel ap.ada.gyro]      Ada's rotation, whoever the menu is showing
[ap.channel ap.gyro]          rotation from whichever phone the menu selects
```

The bare form is the convenience: one menu, and every unqualified tap follows
it. The qualified form is what a room needs — twenty phones each driving their
own voice, all at once.

The name is the one typed into the app, lowercased, with anything outside
`a-z 0-9 - _` replaced by a dash: "Ada Lovelace" becomes `ap.ada-lovelace.…`.
Dots become dashes too, so a name cannot fake a channel boundary. **A phone with
no name set uses its device id**, so expect `ap.ios-e5b28f.accel` — the phone
menu in the receiver is the list of what is actually available to type.

`[send]` cannot be renamed at runtime (only `[receive]` can), so this fan-out
happens inside the js with `messnamed()` rather than through objects in the
patch. The receive name is built once per phone-and-channel and cached, because
twenty phones at 60 Hz is thousands of these a second and rebuilding the string
each time would be the only part of this that costs anything.

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

**Or skip the bpatcher entirely.** `ap.channel` has no inlets, so it works as a
plain object box too:

```
[ap.channel ap.gyro]
```

Same six outlets, no dropdown — and nothing that can lose its view state. The
argument is what persists across a reopen anyway; the menu was only ever a way
to explore. If bpatchers are giving you trouble, this is the sturdier form.

### Why a copy-pasted bpatcher used to lose its presentation view

`viewvisibility` is what makes a bpatcher show the child's *presentation* view
rather than its patching view, cables and all — and it lives on **the box in
your patch**, not on the child patcher. Generated bpatchers that omit it look
right when first placed and revert the moment they are copied. Every bpatcher
here now carries it, along with the border, background and scroll keys Max
writes itself, so a pasted copy behaves like a hand-placed one.

## What the receiver shows

| | |
| --- | --- |
| **port** | 7400 on load. Change it and `udpreceive` rebinds immediately. |
| **host / link** | this Mac's address, found automatically, and the configure link. Type over the host if the guess is wrong. |
| **phone** | every name seen. This chooses which phone the *unqualified* taps follow — see below; taps naming a phone ignore it. `clear` forgets the list, worth doing when half the room has put their phones away. |
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
## Why the QR needs nothing installed

The app-to-Max path is meant to work with **no laptop-side server at all**, and
a QR that needed one would have quietly taken that away. The first version
shelled out to Python and `segno` — but macOS ships `python3` without `segno`,
so on any machine but the one it was written on that meant "clone the repo and
run `uv sync`" before a code appeared. For a room of people, that is not a
dependency, it is a wall.

So it uses only what Max already brings: **Node for Max** is bundled with every
Max 8, `zlib` is in Node's standard library, and `vendor/qrcode-generator.js`
is a dependency-free MIT encoder committed into the repo. Nothing is fetched
and nothing is installed. `qr.js` is a thin wrapper: the library makes the
module grid, and about forty lines turn it into a PNG.

Verified by decoding rather than by inspection — 27 generated codes were read
back with macOS's own QR detector, the same class of decoder a phone camera
uses, and every one returned exactly the URL encoded.

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

## Two hands, two saw/square voices (`cv-pinch-synth.maxpat`)

```sh
open patches/max/cv-pinch-synth.maxpat
cd ~/Documents/2026/MIT/tunning-attention-class/.claude/worktrees/mediapipe-osc
uv run track-demo --osc max            # the camera, onto UDP 7500
```

Each hand on the camera is one voice; the left hand plays the base pitch and
the right hand the same voice a fifth up (× 1.5). For either hand:

| the hand does | the sound does | how |
| --- | --- | --- |
| pinches / opens thumb and index | lowpass sweeps 110 Hz → 8.4 kHz | `/cv/hand/<side>/pinch` (metres) → `scale` → `mtof` → `line~` → `lores~` |
| moves down ↔ up in the frame | square at unity ↔ saw at unity, a full mix in the middle | `/cv/hand/<side>/wrist` y (0–1, 0 at the top) → `expr sin/cos($f1*π/2)` → `line~` → `*~` |
| leaves the frame | fades out over 300 ms | `/cv/hand/<side>/present` → `change` → `line~` → `*~` |
| moves left ↔ right in the frame | pans left ↔ right in the stereo field, equal-power | `/cv/hand/<side>/wrist` x (0–1, 0 at the left of the mirrored view) → `expr cos/sin($f1*π/2)` → `line~` → `*~` on each channel |

One flat file, no abstractions, laid out as a grid so it can be read aloud.
**Rows are the stages of the chain, columns are the two hands**, and the
labels down the left margin name the rows: INPUTS, OSCILLATORS, FILTER, GATE,
PAN, OUT. Within a column the signal runs straight down the left edge —
`rect~`/`saw~` → `*~` → `+~` → `lores~` → `*~` (gate) → `*~` `*~` (pan) — and
each control chain sits to the right of the stage it drives, feeding leftward
into a right-hand inlet: the height exprs beside the oscillators, the pinch
chain beside the filter, the presence ramp beside the gate, the x exprs beside
the pan. A SHARED row at the top holds the four hand-set values (base Hz, the
two pinch calibration distances, resonance) with cords down into both columns.
The two columns are identical apart from `* 1.` versus `* 1.5` on the pitch
and `left` versus `right` in the `route`. Six addresses, all fixed, so a plain
`route` per hand does the splitting — no `js`, no receiver bpatcher.

An earlier version put the voice in an abstraction with a colour-panelled
layout and a presentation view. It was harder to step through, not easier,
and was dropped. Two Max facts from that detour are worth keeping anyway:
Max numbers an abstraction's inlets by x position, not creation order; and
`#1` is not substituted inside a symbol (`route /cv/hand/#1/pinch` matches
nothing on Max 8.5, while `route #1` with a whole address works).

Two things to know before wondering why it does not sound right:

**The pinch distance is in metres and needs calibrating to the hand in front
of the camera.** The two shared boxes are the closed and open distances the
sweep runs between, defaulting to 0.02 and 0.12. Read a hand's 2 Hz pinch
readout with fingers touching, then wide apart, and type those in. Outside the
range is clipped, not extrapolated, so a mis-calibration sounds flat at one end
rather than exploding.

**The mapping is exponential on purpose.** The pinch goes to a MIDI note number
first and then through `mtof`, so equal finger travel is equal *pitch* travel of
the cutoff. A linear Hz mapping spends most of the finger's range above 4 kHz
where nothing audible changes.

The blend is an equal-power pan — square gain `sin(y·π/2)`, saw gain
`cos(y·π/2)` — so the two gains sum to unity *power* everywhere and the middle
is a full mix. MediaPipe's y is 0 at the top of the frame and 1 at the bottom,
which is why sin and cos are the way round they are: a low hand is the
square, a raised hand the saw. The stereo pan is the same trick on x, and each
voice puts out a left and a right signal that the main patch sums per channel.
The video is mirrored, so a hand on your left sounds on the left; with
`--no-mirror` it would be the other way round. The first version faded each voice in dB, which is silent at the
far ends but puts both at −30 dB in the middle: a hole where the mix should be.
Every control path ends in `pack f 80` → `line~`: the camera delivers about 30
values a second, and an 80 ms ramp to each new one is what keeps steps out of
the audio without adding noticeable lag. The four readouts go through
`speedlim 500` — see the section on screen updates above; the
data path has no number box on it.

The patch owns UDP 7500 itself, so it cannot be open at the same time as
Pipeline A's `cv.receive.maxpat` (the CV repo's receiver); one or the other.
`track-demo --swap-hands` if MediaPipe's left/right is the wrong way round for
the camera in use — the pitch tells you at once.

**Which camera pipeline this listens to, and the state of the other one.**
This patch speaks the wire format of the `mediapipe-osc` branch of the
tuning-attention CV repo (port 7500, per-hand `pinch` scalar, named points).
That is the sender that exists and has been run against a real camera and real
Max. The `cv.receive.maxpat` / `cv.channel.maxpat` pair *in this folder* (port
7401, `/cv/hand hand side landmark …`, described in the next section) was
written for a `hand-demo` / `pose-demo` sender that was never committed
anywhere, so as of 2026-09-09 nothing can drive it. Treat the next section as
a design that lost, pending either deleting it or rewriting it against 7500.

## `xfade~` — a crossfader that comes with the repo

```
[xfade~ 0.5]        inlets: signal A · signal B · crossfade 0–1 (float or signal)
                    outlet: A·(1−x) + B·x
```

`xfade~.maxpat` is Christopher Dobrian's abstraction from the UC Irvine Max
Cookbook, ["Abstraction for mixing or crossfading two audio signals"](https://music.arts.uci.edu/dobrian/maxcookbook/abstraction-mixing-or-crossfading-two-audio-signals),
copied here unchanged (six objects: `sig~`, `-~`, two `*~`, `+~`) so that a
`git clone` has it and nobody has to fetch anything. Its argument is the
initial crossfade value, so `xfade~ 0.5` starts as an even mix; with no
argument it starts fully on the left inlet. Feed the right inlet a signal —
`line~`, or `pan2`'s output — for a smooth sweep, a float for a static mix.

Two things to know:

- **It is a linear crossfade**, gain `1−x` on one side and `x` on the other,
  so the two gains always sum to one. That keeps the peak in check, but the
  middle of the fade is about 3 dB quieter than the ends. The equal-power
  version (gains `cos` and `sin` of `x·π/2`, as `pan2` does for panning) keeps
  loudness level through the middle. Dobrian also publishes an
  [S-curve variant](https://music.arts.uci.edu/dobrian/maxcookbook/abstraction-s-curve-crossfading)
  with half-cosine gains that still sum to one; it is not vendored, but it is
  the same six-object shape if wanted.
- **Attribution and licence.** The Cookbook pages carry "Copyright 2017
  Christopher Dobrian" and no explicit licence. It is a teaching resource
  distributed for download, and this copy is for the same purpose; it is
  credited here and in the file's own comment. If this repo's visibility
  changes, that is the file to re-check, alongside the samples.

Like every abstraction here, Max finds it from a patch saved in this folder, or
from anywhere once the `~/Documents/Max 8/Library` symlink above is in place.
A patch saved elsewhere — `patches/`, say, rather than `patches/max/` — gets
an empty box until one of those is true.

## Pose and hand from the laptop camera (attention-cv), on a separate port

This is a second, independent pipeline — its own senders, its own port, its
own receiver — not another tap on the phone receiver above. Same two-piece
shape as the phone side, though:

```
[bpatcher cv.receive.maxpat]                 one per Max session; it owns UDP 7401
[bpatcher cv.channel.maxpat @args cv.pose.right_wrist]   a tap: pick a landmark, use the outlets
```

```sh
uv run pose-demo --osc 127.0.0.1:7401     # from demos/attention-cv
uv run hand-demo --osc 127.0.0.1:7401     # both can send at once — same port, different address
open patches/max/attention-cv.maxpat      # starter patch — a receiver, three taps, one worked example
```

`attention-cv.maxpat` is the fast path: it already embeds `cv.receive.maxpat`
and three `cv.channel.maxpat` taps (right wrist, right index fingertip, nose),
plus a worked example wiring the right wrist's `y` outlet to pitch — raise
your hand for a higher note — the same shape as `attention-phone.maxpat`'s
magnitude-to-pitch example. Open just that one file rather than assembling
the pieces by hand.

`x`/`y`/`z` are MediaPipe's own 0–1 image-normalised coordinates, not meters,
and not the same convention as the phone's `accel`/`gyro` channels.

**`pose-demo`** sends one OSC message per landmark per body, address
`/cv/pose`, args `body landmark x y z visibility` — `i i f f f f`. `landmark`
is BlazePose's fixed 33-point index (0 = nose, 15/16 = wrists, …); names in
`attention-cv/src/attention_cv/pose_demo.py:POSE_LANDMARK_NAMES`.

**`hand-demo`** sends one message per landmark per hand, address `/cv/hand`,
args `hand side landmark x y z confidence` — `i i i f f f f`. `side` is
0 = left, 1 = right (MediaPipe's own handedness classification, from the
camera's point of view — mirrored video flips which physical hand looks
which side); `landmark` is the 21-point index (0 = wrist, 4/8 = thumb/index
tips, …); names in `attention_cv/hand_demo.py:HAND_LANDMARK_NAMES`.

**`cv.receive.maxpat` fans every landmark out to a named send** —
`cv.pose.<name>`, `cv.hand.left.<name>`, `cv.hand.right.<name>` — exactly the
way `ap.receive` fans phone channels out to `ap.<channel>`. Its top two rows
are a raw debug readout (whichever pose or hand message arrived most
recently) — useful for confirming *something* is arriving before you go
looking for a specific landmark.

**`cv.channel.maxpat` taps one landmark**, the same trick as `ap.channel`: a
dropdown over all 75 names, backed by one `[receive]` whose name the dropdown
rewrites with `set <name>` at runtime. Outlets, left to right:

| outlet | what |
| --- | --- |
| 0 | the whole reading as a list |
| 1–3 | x, y, z |
| 4 | visibility (pose) or handedness confidence (hand) |
| 5 | body index (pose) or hand index (hand) |

No magnitude outlet here — `sqrt(x²+y²+z²)` is meaningful for an
accelerometer vector but not for an image-normalised point, so it's left out
rather than shipped as a number nobody should use.

**`hand-demo` also sends a derived per-hand metric**, address
`/cv/hand/spread`, args `hand side spread` — `i i f`. `spread` is 0 when the
five fingertips are together and ~1 when the hand is fully spread — see
`hand_demo.py:hand_spread()`. Computed in Python (mean pairwise fingertip
distance, normalised by palm width so it doesn't care how close the hand is
to the camera) rather than rebuilt with `zl` objects in every patch that
wants it — same "convert once at the edge" reasoning as the phone's unit
table. It's a single scalar, not five landmark values, so it doesn't fit
`cv.channel`'s outlet shape; tap it directly instead:

```
[receive cv.hand.left.spread]
[receive cv.hand.right.spread]
```

`--spread-scale` (default 1.4, untested — tune to your hand/camera) sets the
fully-spread-hand ratio that maps to 1.0.

Sent at whatever `--fps` the demo is running at (30 by default) — this is data
leaving the process, not something painted on screen, so it isn't subject to
the 2 Hz display cap described above.

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
