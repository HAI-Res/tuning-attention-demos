"""Sensor Logger's HTTP Push, normalised into `Reading`s.

Sensor Logger (free, App Store, by Kelvin Choi) POSTs JSON to a URL you give
it.  Useful alongside the web page for two reasons: it can reach sensors the
browser cannot (barometer, pedometer, AirPods head motion, heart rate), and
it writes a full-rate local recording at the same time — so the live stream
and the archive agree.

The cost is latency, and it is worse than it first looks.  Each POST carries
*every* sample recorded in the batch window at the sensor's full rate, so no
data is lost — but the batch period **defaults to one second**, and changing it
is a paid (Plus/Pro) feature.  Sensor Logger's own README quotes 200 ms, which
is most likely the floor of that paid range rather than the free default.

So: a data-collection path, not a gesture-to-sound path.  For anything where a
movement should be heard as it happens, use the web sender page instead.

Each POST body looks like::

    {"messageId": 12, "sessionId": "...", "deviceId": "...",
     "payload": [{"name": "accelerometer", "time": 1698501144401773000,
                  "values": {"x": 0.0, "y": 0.0, "z": 9.8}}, ...]}

`time` is UTC epoch **nanoseconds**.

Name and unit mapping is from Sensor Logger's own documentation; the
`z ≈ 9.8` in its published example is why `accelerometer` maps to `accelg`
(gravity included) rather than to `accel`.  Anything unrecognised is passed
through as ``sl:<name>`` instead of being dropped, so a mapping that turns
out to be wrong shows up on the display rather than vanishing.
"""

from __future__ import annotations

import logging
from collections.abc import Iterator
from typing import Any

from aiohttp import web

from ..hub import HUB
from ..model import Reading

log = logging.getLogger(__name__)

#: Sensor Logger name → (our sensor name, axis keys in our order)
MAPPING: dict[str, tuple[str, tuple[str, ...]]] = {
    "accelerometer": ("accelg", ("x", "y", "z")),
    "accelerometeruncalibrated": ("accelg", ("x", "y", "z")),
    "gravity": ("gravity", ("x", "y", "z")),
    "gyroscope": ("gyro", ("x", "y", "z")),
    "gyroscopeuncalibrated": ("gyro", ("x", "y", "z")),
    "magnetometer": ("mag", ("x", "y", "z")),
    "magnetometeruncalibrated": ("mag", ("x", "y", "z")),
    # Sensor Logger reports kPa here (its example shows 101.3), matching the
    # native app's channel, plus its own relative altitude.
    "barometer": ("pressure", ("pressure", "relativeAltitude")),
    "location": ("location", ("latitude", "longitude", "altitude", "speed")),
}

#: Radians → degrees for the orientation channel, which Sensor Logger reports
#: in radians while this project's `attitude` is in degrees.
_R2D = 57.29577951308232


def parse_push(body: dict[str, Any]) -> Iterator[Reading]:
    device = str(body.get("deviceId") or body.get("sessionId") or "sensorlogger")
    payload = body.get("payload")
    if not isinstance(payload, list):
        return
    for entry in payload:
        if not isinstance(entry, dict):
            continue
        name = str(entry.get("name") or "")
        values = entry.get("values")
        if not name or not isinstance(values, dict):
            continue
        t = float(entry.get("time") or 0) / 1e9  # ns → s

        if name == "orientation":
            # Sensor Logger reports yaw/pitch/roll in radians.
            try:
                yaw, pitch, roll = (
                    float(values["yaw"]), float(values["pitch"]), float(values["roll"])
                )
            except (KeyError, TypeError, ValueError):
                continue
            yield Reading(device, "attitude", t, (yaw * _R2D, pitch * _R2D, roll * _R2D))
            continue

        if (mapped := MAPPING.get(name)) is not None:
            sensor, keys = mapped
            try:
                vals = tuple(float(values[k]) for k in keys)
            except (KeyError, TypeError, ValueError):
                continue
            yield Reading(device, sensor, t, vals)
            continue

        # Unrecognised: keep it, tagged, with a stable axis order.
        numeric = {k: v for k, v in values.items() if isinstance(v, (int, float))}
        if numeric:
            keys = tuple(sorted(numeric))
            yield Reading(device, f"sl:{name}", t, tuple(float(numeric[k]) for k in keys))


async def push_handler(request: web.Request) -> web.Response:
    hub = request.app[HUB]
    try:
        body = await request.json()
    except Exception:
        return web.json_response({"error": "expected JSON"}, status=400)
    if not isinstance(body, dict):
        return web.json_response({"error": "expected a JSON object"}, status=400)

    readings = list(parse_push(body))
    hub.publish_all(readings)
    if not readings:
        # 499 is Sensor Logger's convention for "show this message to the user".
        log.warning("Sensor Logger push contained nothing usable: %s", list(body)[:6])
        return web.json_response({"error": "no recognised sensors in payload"}, status=499)
    return web.json_response({"ok": True, "readings": len(readings)})
