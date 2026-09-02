"""One aiohttp app on one port: the sender page, its socket, and the push endpoint.

Everything shares a port on purpose.  The page is served from the same origin
the WebSocket connects back to, so there is no CORS to configure and no second
URL for a student to mistype; and because the page is HTTPS, the socket is
`wss://` automatically, which is required — a secure page may not open an
insecure socket.
"""

from __future__ import annotations

import ipaddress
import logging
from pathlib import Path

from aiohttp import web

from .hub import HUB, SensorHub
from .model import AXES
from .sources.sensorlogger import push_handler
from .sources.web import websocket_handler

log = logging.getLogger(__name__)
WEB_DIR = Path(__file__).resolve().parent / "web"



async def _index(request: web.Request) -> web.Response:
    return web.FileResponse(
        WEB_DIR / "index.html",
        headers={
            # The page changes while iterating on it and students will have it
            # open across sessions; a cached copy is a confusing bug.
            "Cache-Control": "no-store",
        },
    )


async def _probe(request: web.Request) -> web.Response:
    """A page that measures what the browser on *this* phone can actually do.

    Feature detection alone is not the answer to "can the web do this" — the
    rate iOS Safari delivers `devicemotion` at is undocumented and reports vary
    between 30 and 60 Hz. This measures it, along with the microphone sample
    rate and camera settings, and prints a copyable report.
    """
    return web.FileResponse(WEB_DIR / "probe.html", headers={"Cache-Control": "no-store"})


def app_config_link(host_header: str, secure: bool) -> str | None:
    """The `ductus://` URL that configures the native iOS app.

    The app (Ductus) registers this scheme and applies host/port/tls from the query, so
    scanning one QR (or tapping /app) replaces typing an address on the phone.
    Behind local-ip.sh the Host header carries the dashed IP; the app wants the
    bare one, since it rebuilds the dashed hostname itself when TLS is on.

    Returns None when the advertised host is not a LAN IP — through a tunnel
    the app has no usable address, because its transport speaks either
    `wss://<dashed-ip>.local-ip.sh` or `ws://<ip>` and nothing else.
    """
    name, _, port = host_header.partition(":")
    if name.endswith(".local-ip.sh"):
        name = name.removesuffix(".local-ip.sh").replace("-", ".")
    try:
        ipaddress.ip_address(name)
    except ValueError:
        return None
    if not port:
        port = "443" if secure else "80"
    return f"ductus://configure?host={name}&port={port}&tls={1 if secure else 0}"


async def _app(request: web.Request) -> web.Response:
    """A one-button page that opens the native app pre-configured."""
    link = app_config_link(request.host, request.secure)
    if link is None:
        inner = (
            "<p>This receiver is reached through a tunnel, so there is no LAN "
            "address to hand the app. Run <code>phone-demo</code> without "
            "<code>--tunnel</code> on a network the phone can reach, or type "
            "the laptop's address into the app by hand.</p>"
        )
    else:
        inner = (
            f'<a class="button" href="{link}">Configure the app</a>'
            "<p>Nothing happens? Ductus is not installed — it is the "
            'instructor\'s instrument, built from Xcode. The <a href="/">web '
            "sender</a> works on any phone.</p>"
        )
    html = (
        "<!doctype html>\n"
        '<meta charset="utf-8">\n'
        '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
        "<title>Ductus setup</title>\n"
        "<style>body{font:17px/1.5 -apple-system,system-ui,sans-serif;"
        "margin:3em auto;max-width:24em;padding:0 1em}"
        ".button{display:block;text-align:center;background:#0a84ff;color:#fff;"
        "text-decoration:none;padding:1em;border-radius:12px;font-weight:600}"
        "</style>\n"
        "<h1>Native app setup</h1>\n"
        "<p>Hands this laptop's address, port and TLS setting to the "
        "Ductus iOS app in one tap.</p>\n"
        f"{inner}\n"
    )
    return web.Response(text=html, content_type="text/html", headers={"Cache-Control": "no-store"})


async def _health(request: web.Request) -> web.Response:
    hub = request.app[HUB]
    return web.json_response(
        {
            "ok": True,
            "devices": [
                {
                    "device": d.device,
                    "label": d.label,
                    "age": round(d.age, 1),
                    "connected": d.connected,
                    "silent": d.silent,
                    "channels": {
                        sensor: {
                            **d.rates[sensor].stats(),
                            "latest": [round(v, 4) for v in d.latest[sensor].values],
                            "axes": AXES.get(sensor, ()),
                        }
                        for sensor in d.sensors
                    },
                }
                for d in hub.live()
            ],
        }
    )


def build_app(hub: SensorHub) -> web.Application:
    app = web.Application(client_max_size=2 * 1024 * 1024)
    app[HUB] = hub
    app.add_routes(
        [
            web.get("/", _index),
            web.get("/app", _app),
            web.get("/probe", _probe),
            web.get("/ws", websocket_handler),
            web.post("/sensorlogger", push_handler),
            web.get("/health", _health),
        ]
    )
    return app
