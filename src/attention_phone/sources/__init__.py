"""Ways data gets in.

Every source turns some foreign wire format into `Reading` objects and hands
them to the hub. Three exist:

* `web` — the bundled sender page over a WebSocket. Zero install, works on
  Android, lowest latency. This is the one built for the class.
* `sensorlogger` — Sensor Logger's HTTP Push, for when you want a real
  recording alongside the live stream, or sensors the browser cannot reach
  (barometer, AirPods head motion).
* `phyphox` — polls phyphox's REST API. The laptop pulls rather than the
  phone pushing, which is occasionally the only direction a network allows.
"""
