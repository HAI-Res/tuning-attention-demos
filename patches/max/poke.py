#!/usr/bin/env python3
"""Send every channel the iOS app can send, so the Max patch can be checked
without a phone.

    python3 patches/max/poke.py                  # 127.0.0.1:7400 for 10 seconds
    python3 patches/max/poke.py 127.0.0.1:7400 60

`fake-phone` already exists for the WebSocket path, but it speaks the six
channels a *browser* has, and it needs `phone-demo` running to reach OSC at all.
This is the other half: the native app's full seventeen — head orientation,
audio onset, quaternion, pedometer — straight onto the UDP port, so every row in
the patch can be seen to move (and the ones that stay at 0 Hz can be seen not
to).

It uses the project's own encoder, which is the same wire format the Swift
`OSCEncoder` produces, so what arrives is what a phone would send.
"""

from __future__ import annotations

import math
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "src"))

from attention_phone.osc import OscSender, parse_endpoint  # noqa: E402

#: 100 Hz on the phone; sent here at whatever the sleep below allows.
FAST = {
    "accel": lambda t: (math.sin(t * 12) * 3, math.cos(t * 9) * 2, math.sin(t * 4) * 5),
    "gravity": lambda t: (0.2, -1.1, 9.7),
    "gyro": lambda t: (math.sin(t * 5), math.cos(t * 3), 0.1),
    "attitude": lambda t: ((t * 40) % 360, math.sin(t) * 30, math.cos(t) * 45),
    "quat": lambda t: (math.cos(t), math.sin(t) * 0.2, 0.1, 0.3),
    "mag": lambda t: (12.0, -30.0, 44.0),
    "accelg": lambda t: (0.2, -1.1, 9.7 + math.sin(t * 12)),
    "gyroraw": lambda t: (math.sin(t * 5), math.cos(t * 3), 0.1),
    "magraw": lambda t: (13.0, -31.0, 45.0),
    "head": lambda t: (math.sin(t) * 90, math.cos(t) * 20, 0.0),
    "headaccel": lambda t: (math.sin(t * 8) * 0.5, 0.1, 0.2),
    "audio": lambda t: (
        abs(math.sin(t * 6)),
        min(1.0, abs(math.sin(t * 6)) * 1.2),
        1.0 if int(t * 4) % 4 == 0 else 0.0,
    ),
}

#: ~1 Hz on the phone, and worth keeping slow here — a barometer row that
#: updates 100 times a second would be a lie about what a phone does.
SLOW = {
    "pressure": lambda t: (101.3, 42.0),
    "location": lambda t: (42.3601, -71.0942, 12.0, 1.4),
    "heading": lambda t: ((t * 40) % 360,),
    "steps": lambda t: (float(int(t * 2)), 1.9, t * 1.4),
    "device": lambda t: (0.0, 0.82, 1.0),
}


def main() -> int:
    endpoint = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1:7400"
    seconds = float(sys.argv[2]) if len(sys.argv) > 2 else 10.0
    host, port = parse_endpoint(endpoint, default_port=7400)

    names = ["ada", "grisha"]
    senders = {n: OscSender(host, port) for n in names}
    print(f"  {len(names)} phone(s) → {host}:{port} for {seconds:.0f}s  ({', '.join(names)})")
    print("  pick one in the patch's menu; the other keeps sending in the background")

    t0 = time.monotonic()
    tick = 0
    while (t := time.monotonic() - t0) < seconds:
        for offset, (name, sender) in enumerate(senders.items()):
            phase = t + offset * 1.7
            for channel, fn in FAST.items():
                sender.send_vector(f"/phone/{name}/{channel}", fn(phase))
            if tick % 100 == 0:
                for channel, fn in SLOW.items():
                    sender.send_vector(f"/phone/{name}/{channel}", fn(phase))
        # Sensor Logger passes sensors it does not recognise through as
        # sl:<name>; one of those should land in the patch's "no row for" box
        # rather than vanishing.
        if tick % 200 == 0:
            senders[names[0]].send_vector(f"/phone/{names[0]}/sl:heartrate", (68.0,))
        tick += 1
        time.sleep(0.01)

    sent = sum(s.sent for s in senders.values())
    errors = sum(s.errors for s in senders.values())
    print(f"  sent {sent} messages, {sent / seconds:.0f}/s, {errors} errors")
    for sender in senders.values():
        sender.close()
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
