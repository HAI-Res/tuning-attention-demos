# attention-cv in Max

Vanilla Max 8 — no packages, no externals, no CNMAT odot, because this has to
open on twenty students' stock installs.

Two reusable pieces rather than one big patch:

```
[bpatcher cv.receive.maxpat]                        one per Max session; it owns the socket
[bpatcher cv.point.maxpat @args cv.hand.right.pinch] a tap: pick a channel, use the outlets
```

```sh
open patches/max/attention-cv.maxpat        # the starter patch, using both
uv run track-demo --osc max                 # ...and something to listen to
```

It listens on **UDP 7500**.

| file | what it is |
| --- | --- |
| `attention-cv.maxpat` | starter patch — a receiver, three taps, one worked example |
| `cv.receive.maxpat` | the receiver: socket, throughput, last address, channels arriving |
| `cv.point.maxpat` | one tap: a channel dropdown and its outlets |
| `cv.js` | splits the OSC address; the reason is below |
| `test_cv_js.js` | `node patches/max/test_cv_js.js` — tests the splitting outside Max |
| `poke.py` | drives every channel so the patch works with no camera |

## Why 7500 and not 7400

7400 belongs to the **phone** receiver in `attention-phone`. One UDP port takes
one receiver, so sharing it would mean a camera and a room of phones could never
be running at the same time. On separate ports both patches can be open at once,
which is the whole point of having two of them. `--osc 127.0.0.1:7400` still
sends into the phone patch on purpose, but its `js` reads the last *two* address
components and these have four, so nothing useful arrives.

## Using a tap

Copy a `cv.point` bpatcher as many times as you like. Outlets, left to right:

| outlet | what |
| --- | --- |
| 0 | the whole channel as a list |
| 1–3 | x, y, z |
| 4 | magnitude, the length of the vector |

A **bulk** channel — `norm`, `world`, `visibility` — puts its whole list on
outlet 0 (63, 99 or 33 numbers) and only its first three on the axis outlets.
A **scalar** channel — `pinch`, `spread`, `size`, `hands_apart`, `present` — arrives on
outlet 0 as a one-element list and on outlet 1 as the number.

The dropdown changes the channel live. What persists is the **object's
argument** — `@args cv.hand.right.pinch` — so edit that to make a choice stick.

**You must lock the patch (⌘E) to click a dropdown.** Unlocked, clicking a
bpatcher selects it instead of operating the menu inside. This is the first
thing to check when a menu appears to do nothing.

## Which channel do I actually want

Forty-one of them arrive, and most mappings want three or four. The short list:

| channel | why |
| --- | --- |
| `cv.hand.right.pinch` | thumb tip to index tip **in metres**. The most playable single number here — it means the same thing across the room as up close, because it comes from the metric landmarks rather than the picture. |
| `cv.hand.right.size` | palm length **in image units**, wrist to knuckles. The only scalar that is *not* in metres, on purpose: it shrinks as the hand moves away, so it is the camera-distance proxy — map it to loudness for "closer is louder". Neither model's z does this: hand z is relative to the wrist (the wrist's own z is always 0), pose z to the hips. |
| `cv.hand.right.index_tip` | where the fingertip is in the frame, x and y in 0–1. |
| `cv.pose.0.center` | hip midpoint — the steadiest "where is this person" point there is. It barely moves when the arms do, and unlike the nose it does not vanish when someone turns around. |
| `cv.pose.0.hands_apart` | wrist to wrist in metres. A whole-body gesture with one number. |
| `cv.*.present` | 1 while tracked, 0 the frame it goes. Gate on this. |

Two coordinate spaces arrive for everything, and they are not interchangeable:
`norm` is 0–1 across the image, `world` is metres from the hand centre or the
hip midpoint. Named points carry `norm`; `pinch`, `spread` and `hands_apart` are
always metres, and `size` is deliberately image units. The root `README.md` has the table.

## No camera at hand

```sh
python3 patches/max/poke.py                  # all 43 channels, 10s
python3 patches/max/poke.py 127.0.0.1:7500 60
```

Stdlib only, so it runs without the project's venv — half the time you reach for
it the question is whether Max is broken, and "did uv sync work" does not belong
in that question. Use it to tell "the patch is wrong" apart from "nothing is
arriving", which is the first thing to establish every time.

## When nothing arrives

UDP has no notion of a peer that is not there, so a wrong port, a wrong address
and a firewall all look identical: silence. In order of how often it is the
cause —

1. **`track-demo` is not running, or has no `--osc`.** It sends nothing by
   default.
2. **The port.** The receiver's number box and `--osc` must agree.
3. **Two receivers.** A second patch containing a `cv.receive` cannot bind 7500
   while the first one holds it, and Max says so only in the console.
4. **The wrong host.** `--osc max` is `127.0.0.1`; a camera on another machine
   needs this one's LAN address.

```sh
uv run osc-dump 7500     # run this INSTEAD of Max
```

That answers "is anything arriving, and under what address" without a patcher in
the way — the slowest question to answer from inside Max and the first one worth
asking. Two things cannot bind the same port, so quit Max first.

## Nothing on screen updates at camera rate

The camera sends about 1000 messages a second. Number boxes wired straight to
that flicker, and flicker at that rate is a **migraine and vestibular trigger** —
for some people that makes a patch unusable, not merely busy. So the receiver
shows a throughput figure and the last address **once every two seconds**
(adjustable from 250 ms to 30 s), with a freeze that holds the screen entirely
still.

None of this touches the data. `freeze` stops the display only; the named sends
keep firing at full rate, so a mapping runs while the screen is still. The
starter patch deliberately has **no number box** on the data path for the same
reason — the worked example goes from a tap straight into `scale` and on to
audio, and nothing on screen moves at all.

## Why there is a `js` in the middle of it

The one thing worth reading before editing.

**Max 8's `udpreceive` decodes OSC itself and hands the address over as the
message *selector*.** `/cv/hand/left/index_tip 0.4 0.3 -0.02` arrives as a
message named `/cv/hand/left/index_tip` with three floats. Fine for a fixed
address — but there are about forty of them, and the body ones are numbered by
however many people are in frame, so `route` cannot be given its arguments at
runtime.

Three things that look like the answer and are not:

- **`oscparse`** would split the address into path components. It is not in
  Max 8.5; check before reaching for it.
- **`[tosymbol]` → `[fromsymbol @separator /]`** does split the address, and is
  the idiom the `fromsymbol` help file shows. But it interns a new symbol for
  every message that crosses it — one per distinct float value — and Max never
  frees its symbol table. At 1000 messages a second that is a leak, not a style
  problem.
- **CNMAT's `[OSC-route]` / odot** handle all of this properly and are the right
  answer in a patch allowed a package dependency. This one is not.

So `cv.js` reads `messagename`, takes the **last three** components as the
channel name — `hand.left.index_tip` — and pushes the values to a named receive,
`cv.hand.left.index_tip`, with `messnamed()`. Last three rather than first three
so a changed `--osc-prefix` still works; three because that is the shape of every
address the sender makes: a subject kind, a subject id, and a field.

**`messnamed()` rather than a `[route]`→`[s]` cascade** is why this patch is
small. The cascade would need one pair of objects per address — forty of them —
and would have to be edited by hand the first time someone tracks two people
instead of one. With `messnamed` a second body just starts arriving at
`cv.pose.1.*` and any tap can name it.

**`[receive]` takes `set <name>` at runtime.** That is the whole reason a channel
dropdown is possible: the tap is one `[receive]` whose name the menu rewrites.
`[route]` cannot do that.

**The `.js` and `.maxpat` files must sit in the same folder.** Max searches the
patcher's own folder; move `attention-cv.maxpat` somewhere on its own and the
`js` object fails to create, taking every patch cord attached to it with it.

## What was actually tested

The address splitting is tested outside Max, where it can be:

```sh
node patches/max/test_cv_js.js     # 22 assertions
```

It covers the channel naming, that the prefix does not matter, 63-float bulk
messages surviving intact, malformed addresses being ignored rather than guessed
at, and freeze not stopping the data.

The patch itself was verified in Max 8 on this machine by making Max hand the
data back: a scratch patch of `[r cv.hand.right.pinch] → [udpsend]` echoing to a
port `osc-dump` was listening on. `poke.py` in, the same values out, 26 Hz
sustained — which is the whole chain, `udpreceive` → `cv.js` → `messnamed` →
`[receive]`, and the one link that cannot be checked any other way. The receiver
read `41 channel(s) 1066 msg/sec`, matching the 41 addresses the sender produced
at the time (43 since `size` was added per hand).
