#!/usr/bin/env python3
"""Drive every camera channel, so the Max patch works with no camera.

    python3 patches/max/poke.py                  # 10s into 127.0.0.1:7500
    python3 patches/max/poke.py 127.0.0.1:7500 60

Stdlib only, on purpose: this has to run without the project's venv, because
half the time you reach for it the question is whether Max is broken, and
adding "did uv sync work" to that question helps nobody.

Every channel moves except the ones a real camera would also leave still, so
"the patch is wrong" and "nothing is arriving" stop looking alike — which is
the first thing to establish, every time.
"""

from __future__ import annotations

import math
import socket
import struct
import sys
import time

HAND_POINTS = ("wrist", "thumb_tip", "index_tip", "middle_tip", "ring_tip",
               "pinky_tip")
POSE_POINTS = ("nose", "left_shoulder", "right_shoulder", "left_elbow",
               "right_elbow", "left_wrist", "right_wrist", "left_hip",
               "right_hip", "left_knee", "right_knee", "left_ankle",
               "right_ankle")


def _pad(n: int) -> int:
    return (4 - n % 4) % 4


def _string(s: str) -> bytes:
    b = s.encode() + b"\0"
    return b + b"\0" * _pad(len(b))


def encode(address: str, *args: float | int) -> bytes:
    tags, body = ",", b""
    for a in args:
        if isinstance(a, int):
            tags += "i"
            body += struct.pack(">i", a)
        else:
            tags += "f"
            body += struct.pack(">f", float(a))
    return _string(address) + _string(tags) + body


def main(argv: list[str]) -> int:
    target = argv[1] if len(argv) > 1 else "127.0.0.1:7500"
    seconds = float(argv[2]) if len(argv) > 2 else 10.0
    host, _, port = target.rpartition(":")
    addr = (host or "127.0.0.1", int(port))

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    hz, sent, t0 = 30.0, 0, time.time()
    print(f"poking {addr[0]}:{addr[1]} at {hz:g} Hz for {seconds:g}s "
          f"— ctrl-c to stop")

    try:
        while True:
            t = time.time() - t0
            if t >= seconds:
                break

            # A slow circle, so every value moves and none of them jump.
            ph = 2 * math.pi * t / 4.0
            wobble = 0.5 + 0.18 * math.sin(ph)

            for i, side in enumerate(("left", "right")):
                base = f"/cv/hand/{side}"
                x = 0.3 + 0.15 * math.sin(ph + i * math.pi)
                y = wobble
                sock.sendto(encode(f"{base}/present", 1), addr)
                for name in ("norm", "world"):
                    scale = 1.0 if name == "norm" else 0.08
                    flat = []
                    for k in range(21):
                        flat += [(x + k * 0.004) * scale,
                                 (y + k * 0.003) * scale,
                                 -0.02 * scale * k]
                    sock.sendto(encode(f"{base}/{name}", *flat), addr)
                    sent += 1
                for k, name in enumerate(HAND_POINTS):
                    sock.sendto(encode(f"{base}/{name}",
                                       x + k * 0.02, y + k * 0.015,
                                       -0.03 + k * 0.005), addr)
                    sent += 1
                # A pinch that opens and closes between 2 and 12 cm.
                sock.sendto(encode(f"{base}/pinch",
                                   0.02 + 0.05 * (1 + math.sin(ph * 1.7 + i))),
                            addr)
                sock.sendto(encode(f"{base}/spread",
                                   0.06 + 0.03 * math.sin(ph * 0.9)), addr)
                # A palm that approaches and retreats: 0.05 far, 0.25 near.
                sock.sendto(encode(f"{base}/size",
                                   0.15 + 0.10 * math.sin(ph * 0.5 + i)), addr)
                sent += 4

            base = "/cv/pose/0"
            sock.sendto(encode(f"{base}/present", 1), addr)
            for name, scale in (("norm", 1.0), ("world", 0.6)):
                flat = []
                for k in range(33):
                    flat += [(0.5 + 0.1 * math.sin(ph + k)) * scale,
                             (k / 33.0) * scale, 0.01 * k * scale]
                sock.sendto(encode(f"{base}/{name}", *flat), addr)
                sent += 1
            sock.sendto(encode(f"{base}/visibility", *([0.98] * 33)), addr)
            for k, name in enumerate(POSE_POINTS):
                sock.sendto(encode(f"{base}/{name}",
                                   0.5 + 0.12 * math.sin(ph + k * 0.4),
                                   0.15 + k * 0.06, -0.1 + k * 0.01), addr)
                sent += 1
            sock.sendto(encode(f"{base}/center", wobble, 0.51, 0.0), addr)
            sock.sendto(encode(f"{base}/hands_apart",
                               0.3 + 0.25 * (1 + math.sin(ph * 0.6))), addr)
            sent += 4

            time.sleep(1.0 / hz)
    except KeyboardInterrupt:
        pass

    elapsed = time.time() - t0
    print(f"{sent} messages in {elapsed:.1f}s ({sent / elapsed:.0f}/s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
