"""The bundled sender page's WebSocket protocol.

Deliberately terse: at 60 Hz × 20 phones this is ~1200 messages a second, and
short keys keep both the JSON and the parse cheap.

Phone → laptop, first message only::

    {"hello": {"d": "ph-a3f9", "n": "Ada", "ua": "...", "platform": "..."}}

Phone → laptop, per sample — one message carries every sensor that shares a
timestamp, because `devicemotion` delivers them together::

    {"d": "ph-a3f9",          # device id, stable across reloads
     "q": 1041,               # sequence number, for spotting loss
     "t": 17.362,             # seconds since this session started, phone clock
     "i": 16.6,              # the interval the phone reports between samples
     "s": {"accel":   [x, y, z],       # m/s², gravity removed
           "accelg":  [x, y, z],       # m/s², gravity included
           "gravity": [x, y, z],       # m/s²
           "gyro":    [x, y, z],       # rad/s (converted from the API's deg/s)
           "attitude":[yaw, pitch, roll],  # degrees
           "heading": [deg]}}          # degrees from true north, iOS only

Sensor keys are already in this project's normalised names and units — the
conversion happens in the page, next to the API that needs it.
"""

from __future__ import annotations

import asyncio
import contextlib
import json
import logging
import time
from collections.abc import Iterator
from typing import Any

from aiohttp import WSMsgType, web

from ..hub import HUB
from ..model import AXES, Reading

log = logging.getLogger(__name__)

#: Sequence gap and rate bookkeeping live here rather than on the hub, since
#: only this protocol has a sequence number.
class WebClientStats:
    def __init__(self) -> None:
        self.gaps = 0
        self.messages = 0
        self._last_q = 0

    def note(self, q: int) -> None:
        self.messages += 1
        if self._last_q and q > self._last_q + 1:
            self.gaps += q - self._last_q - 1
        self._last_q = q


def parse_sample(msg: dict[str, Any]) -> Iterator[Reading]:
    """One wire message → zero or more `Reading`s.

    Unknown sensor names are kept rather than dropped: a silently discarded
    channel is much harder to notice than an oddly-named one.
    """
    device = msg.get("d")
    sensors = msg.get("s")
    if not isinstance(device, str) or not isinstance(sensors, dict):
        return
    t = float(msg.get("t") or 0.0)
    for name, values in sensors.items():
        if not isinstance(values, list) or not values:
            continue
        try:
            vals = tuple(float(v) for v in values)
        except (TypeError, ValueError):
            continue
        if any(v != v for v in vals):  # NaN: iOS emits these before the first fix
            continue
        expected = AXES.get(name)
        if expected and len(vals) != len(expected):
            continue
        yield Reading(device=device, sensor=name, t=t, values=vals)


#: Seconds between server heartbeats. The sender uses these to tell a live
#: receiver from a socket that merely opened: URLSession reports a WebSocket
#: send as successful before delivery, so on iOS "sent" proves nothing. Traffic
#: coming back is the only evidence the far end exists.
HEARTBEAT_INTERVAL = 2.0


async def _heartbeat(ws: web.WebSocketResponse) -> None:
    while not ws.closed:
        await asyncio.sleep(HEARTBEAT_INTERVAL)
        try:
            await ws.send_str(json.dumps({"ok": round(time.time(), 3)}))
        except (ConnectionResetError, RuntimeError):
            return


async def websocket_handler(request: web.Request) -> web.WebSocketResponse:
    hub = request.app[HUB]
    # Liveness is judged by data arriving, not by a protocol ping.
    #
    # `heartbeat=` was the obvious choice and it breaks the iOS app:
    # URLSessionWebSocketTask does not reliably answer a server-initiated PING,
    # so aiohttp closed a perfectly healthy connection with "No PONG received
    # after 10.0 seconds" mid-stream. Browsers answer pings correctly, so this
    # only showed up once there was a native client.
    #
    # Every sender here streams continuously, so "nothing at all for 30 s" is a
    # stronger liveness test than a pong anyway — it catches a phone whose
    # screen locked, which a pong from a still-open socket would not.
    ws = web.WebSocketResponse(receive_timeout=30.0, max_msg_size=64 * 1024)
    await ws.prepare(request)

    stats = WebClientStats()
    device = ""
    attached = False
    peer = request.remote or "?"
    log.info("websocket open from %s", peer)
    beat = asyncio.create_task(_heartbeat(ws))

    try:
        while True:
            try:
                msg = await ws.receive()
            except TimeoutError:
                log.info("%s went quiet for 30s; closing", device or peer)
                break
            if msg.type in (WSMsgType.CLOSE, WSMsgType.CLOSING, WSMsgType.CLOSED):
                break
            if msg.type is not WSMsgType.TEXT:
                if msg.type is WSMsgType.ERROR:
                    log.warning("websocket error from %s: %s", peer, ws.exception())
                continue
            try:
                payload = json.loads(msg.data)
            except json.JSONDecodeError:
                continue
            if not isinstance(payload, dict):
                continue

            if (hello := payload.get("hello")) and isinstance(hello, dict):
                device = str(hello.get("d") or "")
                label = str(hello.get("n") or device)
                if device:
                    hub.attach(device, label)
                    attached = True
                    log.info("%s (%s) joined from %s", label, device, peer)
                continue

            if (q := payload.get("q")) is not None:
                try:
                    stats.note(int(q))
                except (TypeError, ValueError):
                    pass
            hub.publish_all(parse_sample(payload))
    finally:
        beat.cancel()
        with contextlib.suppress(asyncio.CancelledError):
            await beat
        if attached:
            hub.detach(device)
        log.info(
            "websocket closed (%s): %d messages, %d dropped in transit",
            device or peer, stats.messages, stats.gaps,
        )
    return ws
