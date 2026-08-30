"""`uv run phone-demo` — get phone sensors onto the laptop and show them.

The whole point is that this is one command with no configuration: it works
out which of the laptop's addresses a phone can reach, fetches an HTTPS
certificate that iOS will accept, prints a QR code, and then prints live
values for every phone that joins.
"""

from __future__ import annotations

import argparse
import asyncio
import contextlib
import logging
import signal
import sys

import aiohttp
from aiohttp import web

from . import certs, net
from .display import LiveDisplay, summary
from .hub import Reading, SensorHub
from .osc import OscSender, parse_endpoint
from .server import build_app
from .sources.phyphox import PhyphoxPoller
from .tunnel import QuickTunnel, TunnelUnavailable

log = logging.getLogger("attention_phone")


def print_qr(url: str) -> None:
    try:
        import segno
    except ImportError:  # pragma: no cover - segno is a declared dependency
        print(f"  (install segno for a QR code)  {url}")
        return
    qr = segno.make(url, error="m")
    qr.terminal(compact=True, border=2)


def banner(url: str, *, extra: list[str] | None = None) -> None:
    print()
    print("  attention-phone")
    print()
    print_qr(url)
    print()
    print(f"  {url}")
    print()
    print("  On the phone: scan it, type a name, tap Start, allow motion access.")
    for line in extra or []:
        print(f"  {line}")
    print()


def attach_osc(hub: SensorHub, endpoint: str, prefix: str) -> OscSender:
    """Forward every reading to SuperCollider / Max / Pd.

    Address is `/<prefix>/<device-label>/<sensor>` with the axes as floats, e.g.
    `/phone/ada/accel -0.02 0.11 -0.05`. The label is slugified because OSC
    address patterns treat space, `#`, `*`, `?`, `[`, `{` and `/` as special.
    """
    host, port = parse_endpoint(endpoint)
    sender = OscSender(host, port)

    def slug(s: str) -> str:
        keep = [c if (c.isalnum() or c in "-_.") else "-" for c in s.lower()]
        return "".join(keep).strip("-") or "phone"

    @hub.subscribe
    def _forward(r: Reading) -> None:
        label = hub.devices[r.device].label if r.device in hub.devices else r.device
        sender.send_vector(f"/{prefix}/{slug(label)}/{r.sensor}", r.values)

    print(f"  OSC → {host}:{port} as /{prefix}/<name>/<sensor>")
    return sender


async def run(args: argparse.Namespace) -> int:
    hub = SensorHub(stale_after=args.stale)
    app = build_app(hub)

    # --tunnel serves plain HTTP locally and lets Cloudflare's edge terminate
    # TLS; serving our own cert behind the tunnel would only add a hostname
    # mismatch for cloudflared to complain about.
    use_tls = not args.http and not args.tunnel
    ssl_ctx = None
    if use_tls:
        try:
            ssl_ctx = certs.ssl_context(refresh=args.refresh_cert)
        except Exception as exc:
            print(f"  could not get the local-ip.sh certificate ({exc});", file=sys.stderr)
            print("  falling back to plain HTTP — iOS will refuse motion access.", file=sys.stderr)
            use_tls = False

    runner = web.AppRunner(app, access_log=None)
    await runner.setup()
    site = web.TCPSite(runner, host="0.0.0.0", port=args.port, ssl_context=ssl_ctx)  # noqa: S104
    await site.start()

    extra: list[str] = []
    tunnel: QuickTunnel | None = None
    if args.tunnel:
        print("  starting cloudflared…")
        tunnel = QuickTunnel(args.port)
        try:
            url = await tunnel.start()
        except TunnelUnavailable as exc:
            print(f"\n  {exc}\n", file=sys.stderr)
            await runner.cleanup()
            return 2
        extra.append("via a Cloudflare quick tunnel — works even with client isolation")
    else:
        ip = args.host or net.best()
        scheme = "https" if use_tls else "http"
        hostpart = certs.hostname_for(ip) if use_tls else ip
        url = f"{scheme}://{hostpart}:{args.port}"
        if not use_tls:
            extra.append("plain HTTP: iOS will NOT release motion data. Desktop testing only.")
        if len(net.candidates()) > 1:
            extra.append("this laptop has several addresses — if nothing connects, try:")
            extra.extend(f"  {a.ip}  ({a.iface})" for a in net.candidates()[1:])

    if args.osc:
        attach_osc(hub, args.osc, args.osc_prefix)

    banner(url, extra=extra)

    pollers = [
        PhyphoxPoller(h.strip(), hub, port=args.phyphox_port, interval=args.phyphox_interval)
        for h in (args.phyphox or "").split(",")
        if h.strip()
    ]
    tasks: list[asyncio.Task[None]] = []
    client: aiohttp.ClientSession | None = None
    if pollers:
        client = aiohttp.ClientSession()
        tasks = [asyncio.create_task(p.run(client)) for p in pollers]
        print(f"  polling {len(pollers)} phyphox device(s)")

    stop = asyncio.Event()
    loop = asyncio.get_running_loop()
    for sig in (signal.SIGINT, signal.SIGTERM):
        with contextlib.suppress(NotImplementedError):
            loop.add_signal_handler(sig, stop.set)

    display = LiveDisplay(hub, url, sensor=args.sensor)
    period = 1.0 / max(1.0, args.refresh)
    try:
        while not stop.is_set():
            display.render()
            with contextlib.suppress(TimeoutError):
                await asyncio.wait_for(stop.wait(), period)
    finally:
        display.finish()
        for t in tasks:
            t.cancel()
        if client:
            await client.close()
        if tunnel:
            await tunnel.stop()
        await runner.cleanup()
        print(summary(hub))
        for p in pollers:
            print(f"  phyphox {p.base}: {p.polls} polls, {p.errors} errors")
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="phone-demo",
        description="Stream phone sensors to this laptop and show them live.",
    )
    p.add_argument("--port", type=int, default=8443, help="port to serve on (default 8443)")
    p.add_argument("--host", help="address to advertise, overriding auto-detection")
    p.add_argument("--http", action="store_true",
                   help="serve plain HTTP; iOS will refuse motion access, desktop only")
    p.add_argument("--tunnel", action="store_true",
                   help="publish through a Cloudflare quick tunnel (needs cloudflared)")
    p.add_argument("--refresh-cert", action="store_true", help="re-download the TLS certificate")
    p.add_argument("--sensor", default="accel",
                   choices=["accel", "accelg", "gravity", "gyro", "attitude", "mag"],
                   help="which sensor the live display shows (default accel)")
    p.add_argument("--osc", metavar="HOST:PORT",
                   help="forward readings over OSC/UDP, e.g. 127.0.0.1:57120 or 'sc'")
    p.add_argument("--osc-prefix", default="phone", help="OSC address prefix (default 'phone')")
    p.add_argument("--phyphox", metavar="IP[,IP...]",
                   help="also poll these phyphox devices")
    p.add_argument("--phyphox-port", type=int, default=80,
                   help="phyphox port: 80 on iOS, 8080 on Android (default 80)")
    p.add_argument("--phyphox-interval", type=float, default=0.05,
                   help="seconds between phyphox polls (default 0.05)")
    p.add_argument("--refresh", type=float, default=10.0,
                   help="display redraws per second (default 10)")
    p.add_argument("--stale", type=float, default=5.0,
                   help="seconds of silence before a phone leaves the display")
    p.add_argument("--check", action="store_true",
                   help="print network/cert diagnostics and exit")
    p.add_argument("--verbose", "-v", action="store_true", help="log connections and errors")
    return p


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.WARNING,
        format="%(levelname)s %(name)s: %(message)s",
    )
    if args.check:
        return certs.main([])
    try:
        return asyncio.run(run(args))
    except KeyboardInterrupt:
        return 130


if __name__ == "__main__":
    raise SystemExit(main())
