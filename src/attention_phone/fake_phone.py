"""`uv run fake-phone` — a synthetic phone, for building demos without one.

Speaks exactly the protocol the sender page speaks, so anything downstream
cannot tell the difference. Two uses: proving the receiver works before class,
and writing a sound mapping on a train with no phone to hand.

The signal is not noise. It is a walking gait — a ~2 Hz vertical bounce with a
sharper heel-strike transient, plus gravity in whatever direction the phone is
held — because a mapping tuned against white noise falls apart the moment a
body is involved.
"""

from __future__ import annotations

import argparse
import asyncio
import json
import math
import random
import ssl
import time

import aiohttp

from .model import G


def gait(t: float, *, stride_hz: float = 2.0, intensity: float = 1.0) -> tuple[float, float, float]:
    """Gravity-free acceleration in m/s² for a phone carried by a walker."""
    phase = 2 * math.pi * stride_hz * t
    bounce = math.sin(phase)
    # Heel strike: a narrow spike once per stride, which is what actually makes
    # onset detection interesting.
    strike = math.exp(-40.0 * (((t * stride_hz) % 1.0) - 0.5) ** 2)
    jitter = lambda: random.gauss(0, 0.06)  # noqa: E731
    return (
        intensity * (0.6 * math.sin(phase * 0.5) + 2.2 * strike) + jitter(),
        intensity * (0.9 * bounce) + jitter(),
        intensity * (1.8 * bounce + 3.5 * strike) + jitter(),
    )


async def one_phone(url: str, name: str, hz: float, seconds: float, ssl_ctx: ssl.SSLContext | None,
                    room: str | None = None) -> None:
    device = f"fake-{name.lower().replace(' ', '-')}"
    interval = 1.0 / hz
    # A resting tilt, so attitude and gravity are not all zeros.
    tilt = random.uniform(-40, 40)
    async with aiohttp.ClientSession() as session:
        async with session.ws_connect(url, ssl=ssl_ctx, heartbeat=20) as ws:
            hello = {"d": device, "n": name, "ua": "fake-phone"}
            if room:
                hello["room"] = room
            await ws.send_str(json.dumps({"hello": hello}))
            t0 = time.monotonic()
            seq = 0
            deadline = t0
            while True:
                now = time.monotonic()
                t = now - t0
                if seconds and t >= seconds:
                    break
                ax, ay, az = gait(t)
                gx = G * math.sin(math.radians(tilt))
                gz = G * math.cos(math.radians(tilt))
                seq += 1
                await ws.send_str(json.dumps({
                    "d": device, "q": seq, "t": round(t, 4), "i": interval * 1e3,
                    "s": {
                        "accel": [round(ax, 4), round(ay, 4), round(az, 4)],
                        "accelg": [round(ax + gx, 4), round(ay, 4), round(az + gz, 4)],
                        "gravity": [round(gx, 4), 0.0, round(gz, 4)],
                        "gyro": [round(ay * 0.3, 4), round(ax * 0.2, 4), round(az * 0.1, 4)],
                        "attitude": [round((t * 12) % 360, 2), round(tilt, 2), round(ay * 4, 2)],
                        "heading": [round((t * 12) % 360, 1)],
                    },
                }))
                # Absolute deadlines, so a slow send does not shift every later
                # sample late — the same reasoning as attention-cv's FrameClock.
                deadline += interval
                await asyncio.sleep(max(0.0, deadline - time.monotonic()))
            await ws.close()


NAMES = ["Ada", "Grisha", "Anna", "Bo", "Cy", "Dev", "Ella", "Fen"]


async def run(args: argparse.Namespace) -> int:
    url = args.url.rstrip("/")
    if not url.endswith("/ws"):
        url += "/ws"
    ws_url = url.replace("https://", "wss://").replace("http://", "ws://")
    ssl_ctx: ssl.SSLContext | None = None
    if ws_url.startswith("wss://") and args.insecure:
        ssl_ctx = ssl.create_default_context()
        ssl_ctx.check_hostname = False
        ssl_ctx.verify_mode = ssl.CERT_NONE

    names = [args.name] if args.name else NAMES
    phones = [
        one_phone(ws_url, names[i % len(names)] + ("" if args.count == 1 else f" {i + 1}"),
                  args.hz, args.seconds, ssl_ctx, room=args.room)
        for i in range(args.count)
    ]
    print(f"fake-phone → {ws_url}: {args.count} phone(s) at {args.hz:g} Hz")
    results = await asyncio.gather(*phones, return_exceptions=True)
    failures = [r for r in results if isinstance(r, BaseException)]
    for f in failures:
        print(f"  failed: {f!r}")
    return 1 if failures else 0


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(prog="fake-phone", description=__doc__.splitlines()[0])
    p.add_argument("url", nargs="?", default="https://127.0.0.1:8443",
                   help="the phone-demo URL (default https://127.0.0.1:8443)")
    p.add_argument("--count", "-n", type=int, default=1, help="how many phones to simulate")
    p.add_argument("--hz", type=float, default=60.0, help="samples per second (default 60)")
    p.add_argument("--seconds", type=float, default=0.0, help="stop after N seconds (0 = forever)")
    p.add_argument("--name", help="label to use instead of the built-in names")
    p.add_argument("--room", help="join this room, as a phone that scanned a laptop's QR would")
    p.add_argument("--insecure", action="store_true",
                   help="skip TLS verification, for hitting 127.0.0.1 with the local-ip.sh cert")
    args = p.parse_args(argv)
    try:
        return asyncio.run(run(args))
    except KeyboardInterrupt:
        return 130


if __name__ == "__main__":
    raise SystemExit(main())
