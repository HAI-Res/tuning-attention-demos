"""One aiohttp app on one port: the sender page, its socket, and the push endpoint.

Everything shares a port on purpose.  The page is served from the same origin
the WebSocket connects back to, so there is no CORS to configure and no second
URL for a student to mistype; and because the page is HTTPS, the socket is
`wss://` automatically, which is required — a secure page may not open an
insecure socket.
"""

from __future__ import annotations

import logging
from pathlib import Path

from aiohttp import web

from .hub import HUB, SensorHub
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


async def _health(request: web.Request) -> web.Response:
    hub = request.app[HUB]
    return web.json_response(
        {
            "ok": True,
            "devices": [
                {"device": d.device, "label": d.label, "sensors": d.sensors,
                 "hz": round(max((r.hz for r in d.rates.values()), default=0.0), 1)}
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
            web.get("/ws", websocket_handler),
            web.post("/sensorlogger", push_handler),
            web.get("/health", _health),
        ]
    )
    return app
