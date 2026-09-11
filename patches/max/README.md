# Max patches

Two demos, one per source: a phone's sensors and a laptop camera's hand
tracking. Vanilla Max 8 or 9. The phone demo needs nothing installed; the
camera demo needs the **CNMAT Externals** package (for `OSC-route`) from
Max's Package Manager.

## Setup

None, if you open the two demos from this folder: Max searches the folder of
the open patch, and everything they load is in here beside them.

Optional, for patches saved elsewhere that want `ap.channel`, `xfade~` and the
rest: put this folder on Max's search path with a link, then restart Max (it
only scans the path at launch). Keep the quotes — the folder name has a space.

```sh
ln -sfn "$(pwd)/patches/max" "$HOME/Documents/Max 8/Library/tuning-attention"   # Max 8
ln -sfn "$(pwd)/patches/max" "$HOME/Documents/Max 9/Library/tuning-attention"   # Max 9
```

## 1. Phone: `1. phone-gyroscope-demo.maxpat`

```sh
open "patches/max/1. phone-gyroscope-demo.maxpat"
```

Point the phone's camera at the QR code. It opens a web page on the class
server keyed to this laptop's **room** — the five-letter code shown in the
receiver block — and the phone's sensors arrive here through the receiver's
relay. Tap **Start** on the page and allow motion access. Nothing to install on
either side; both ends only make outbound connections, so it works on any
wifi.

Turning the phone then scrubs and pitches a sample: the gyro's rotation rate,
in turns per second, is the `groove~` playback speed. The two `svf~ 10.`
objects are high-passes that strip the DC a nearly-stopped `groove~` produces.
The patch wants a file named `tudor.wav` in this folder — deliberately not
committed — so drop any `.wav` in under that name, or edit the `buffer~`.

The menu under the QR has two more targets. **Ductus app**: the native iOS
app's link, which sends OSC straight to Max over the LAN at 100 Hz and also
reaches AirPods head motion; the first packet triggers an iOS *Local Network*
prompt. **Web page — this laptop**: a page served from your own machine, for a
LAN with no internet; needs `uv run phone-demo --osc 127.0.0.1:7400` running.

**Only one patch with a receiver may be open at a time.** A second one both
fights for UDP 7400 and pulls the same room a second time, so every message
arrives twice.

### The pieces

| file | what it is |
| --- | --- |
| `ap.receive.maxpat` | the receiver: the socket, the phone chooser, the room key and relay |
| `ap.qr.maxpat` | the code to scan, with the target menu; paste one into any patch |
| `ap.channel.maxpat` | a tap: pick a channel from the dropdown; outlets are the whole reading, axis 1–4, magnitude |
| `attention-phone.js` | splits OSC addresses and keeps the display slow — see below |
| `relay.js` `wsclient.js` `server-config.js` | the relay that pulls this laptop's room from the class server; the server's address is the one line in `server-config.js` |
| `address.js` `qr.js` `vendor/` | this Mac's address and the QR image, via Node for Max; nothing fetched |

To build your own mapping, copy an `ap.channel` bpatcher into your patch
alongside an `ap.receive`, lock the patch (⌘E) and pick a channel from its
dropdown. `[ap.channel ap.gyro]` typed as a plain object works too. Channels
are `accel`, `gravity`, `gyro`, `attitude`, `accelg`, `heading`, `location`,
`audio` from the web page, and nine more from the app.

**Nothing on screen updates at sensor rate.** Values shown are averaged over
two seconds and the rate readouts are damped: flicker at 60 Hz is a migraine
and vestibular trigger. The data path is untouched — taps get every sample.

## 2. Camera: `2. cv-synth-demo.maxpat`

```sh
uv sync && uv run fetch-models                     # once; MediaPipe is ~120 MB of it
uv run track-demo --track hands --dim 0 --osc max   # hands only, black background, OSC on UDP 7500
open "patches/max/2. cv-synth-demo.maxpat"
```

Two hands, two voices. The parent patch is small on purpose: a block of
defaults at the top (fundamental, pinch min and max, resonance, size far and
near — each a message fired by `loadbang` and sent by name), `udpreceive`,
then `p left hand` and `p right hand`, summed into `ezdac~`. Double-click a
hand to open it. Inside, one column read top to bottom:

| the hand does | the sound does | how |
| --- | --- | --- |
| is in the frame | fades in; leaves, fades out over 300 ms | `OSC-route /present` → `line~` → `*~` |
| moves up and down | crossfades triangle (raised) ↔ saw (low) | wrist y → `line~` → `xfade~` |
| pinches / opens thumb and index | lowpass sweeps 0–6 octaves above the fundamental | pinch (m) → `scale` → `expr 110.*pow(2., $f1)` → `line~` → `lores~` |
| moves toward the camera | gets louder, -40 dB far to 0 dB near | palm `size` → `scale` → `dbtoa` → `line~` → `*~` |
| moves left and right | pans | wrist x → `zmap` → `pan2` |

The right hand is the same patch listening to `/cv/hand/right`, with
`receive fund` → `* 1.5` before the oscillators: a fifth up. If your left hand
drives the right-hand voice, add `--swap-hands` to `track-demo`.

Three things need the package or the folder: `OSC-route` is from CNMAT
Externals (Package Manager), `xfade~` is Dobrian's abstraction in this folder,
and `pan2` is an example abstraction that ships inside Max itself. An empty
box in place of any of them is a missing dependency, not a broken patch.

**Calibrate first.** Pinch arrives in metres, size in image units, and both
depend on the hand and the camera. Defaults are 0.02–0.1 m for the pinch and
0.1–0.3 for size. Open a hand and watch its two readouts (beside `OSC-route /pinch` and
`OSC-route /size`, updated twice a second, on purpose) at the extremes —
fingers touching and wide apart; arm's length and close to the camera — and
type those values into the messages at the top; they reach both hands by
`send`. Outside the range is
clipped, not extrapolated.

**Why the waveform blend is hard to hear with the pinch closed:** the lowpass
sits after the blend and strips exactly the harmonics that tell triangle from
saw. Open the pinch and the difference is there. That's subtractive synthesis
doing what it does, and worth pointing at.

**Why `OSC-route` and not `route`.** Vanilla `route` matches the whole
message selector, so `route /cv/hand/left` matches nothing sent to
`/cv/hand/left/pinch`; splitting an address one level at a time needs
CNMAT's object.

### `xfade~`

Dobrian's two-signal crossfader from the
[UC Irvine Max Cookbook](https://music.arts.uci.edu/dobrian/maxcookbook/abstraction-mixing-or-crossfading-two-audio-signals),
vendored unchanged so a clone has it: inlets signal A, signal B, crossfade 0–1
(float or signal); outlet `A·(1−x) + B·x`. Linear, so the middle is ~3 dB down.
Copyright Christopher Dobrian, distributed as a teaching resource; credited
here and in the file.

## Why there is a `js` in the phone receiver

Max's `udpreceive` decodes OSC itself and hands the address over as the message
selector: `/phone/ada/accel 0.1 0.2 9.8` arrives as a message named
`/phone/ada/accel`. A student types their own name, so the middle part is not
known until it arrives, and `route` cannot take its arguments at runtime.
`attention-phone.js` splits the address and re-emits the values under the
channel name, and publishes every phone under `ap.<name>.<channel>` so a tap
can be pinned to one person: `[ap.channel ap.ada.gyro]`. The `.js` files must
stay beside the patches; Max looks for them in the patch's own folder.

## If nothing arrives

| | first thing to check |
| --- | --- |
| phone | the receiver's status line: it should read "connected to ductus-web-app.csail.mit.edu · room …", and the phone's page shows the same room. `https://ductus-web-app.csail.mit.edu/health` lists every live phone. If the relay gave up, send it a `bang`. |
| phone, app path | the *Local Network* prompt; then the port — app and Max both on 7400; then wifi client isolation, which blocks phone→laptop OSC (the web page is the way round it) |
| camera | quit Max and `uv run osc-dump 7500` — if nothing prints, the problem is before Max |
| any patch | empty boxes mean the setup symlink is missing or Max was not restarted; an empty `OSC-route` means the CNMAT package is not installed |
