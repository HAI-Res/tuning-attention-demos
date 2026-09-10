# Working rules for this repo

The READMEs describe what the code does. This file holds the few rules that
are not derivable from the code, and that have each been re-learned the hard
way at least once.

## Display updates are capped, deliberately — do not "improve" them

**Anything that puts numbers on a screen updates at about 2 Hz, not at
sensor rate.** Rapidly flickering numerics and bars are a vestibular and
migraine trigger for people who use this — an accessibility requirement, not
a matter of polish or taste.

This is why:

- `src/attention_phone/web/index.html` repaints at most every 500 ms.
- `patches/max/` averages and slows everything shown.
- `phone-demo` accepts `--refresh 2`.
- the iOS app's per-channel Hz readout is damped with hysteresis, and its
  live values are off by default.

Data still streams at full rate in every case; only the *paint* is slow.
Decoupling paint rate from data rate is the whole technique. If you find
yourself raising a refresh rate, adding an animation, or wiring a number box
straight to a 100 Hz stream because it feels sluggish, that sluggishness is
the feature.

**The web page has no animations or transitions of its own, at all.** No CSS
`transition`, no `animation`, no sliding sheet, no fading status, no pulse —
the native app's status-light pulse is deliberately *not* reproduced there. The
only motion allowed is what the browser draws for its own controls (a native
switch flipping). Same reason as the paint cap: the person holding the phone is
moving, and motion on the screen at the same time is a vestibular trigger.

## The status light may never claim more than is known

A green light means the far end has been *heard from*, not that a send
returned success — `URLSessionWebSocketTask` reports sends as succeeding
against a receiver that is already dead. One-way transports (OSC/UDP) can
never confirm arrival, so they get their own state and their own colour
rather than borrowing green. Do not collapse these states to simplify the UI;
each one exists because the simpler version lied.

## Units are converted at the edge, once

Sources disagree — degrees vs radians, g vs m/s². Every provider converts on
the way in, so downstream there is exactly one set of units (m/s², rad/s,
degrees). A channel's advertised unit must match what it actually emits:
`audio`'s `onset` is an unbounded dB rise, and calling it `0–1` once caused a
mapping-clipping bug that shipped as far as a submission archive.

## Two names, three repos

The toolkit is **attention-phone** / **attention-cv** and lives here. The iOS
sender is **Ductus** (bundle id `com.chaparralstudios.ductus`, scheme
`ductus://`) and lives with its App Store material in the private
`HAI-Res/tuning-attention-class-demos` repo, not here — the receiver takes any
sender, and the app is only one of them. This repo is the public, read-only
handout: clone and use; changes land via the private repos.
