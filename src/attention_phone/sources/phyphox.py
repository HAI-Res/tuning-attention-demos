"""Polling phyphox's REST API — the laptop pulls, the phone serves.

phyphox (RWTH Aachen, free, open source, no account) runs a small webserver on
the phone when you enable *Remote access*: port **80 on iOS**, 8080 on
Android.  This is the only source here where the connection is established
laptop → phone, which matters when a network permits one direction and not the
other.  It is also the only one that needs no software on the laptop beyond a
browser, which is why it is the standard tool in physics teaching.

The trade-offs are real:

* Every phone must be reachable at a known IP, and you must type 20 of them.
* You are polling.  A `/get` round trip on wifi is 10–40 ms, so a poll loop
  gets maybe 25–50 requests/second *shared across all phones*.
* `updateMode: "partial"` plus a monotonic threshold on the time buffer means
  each poll returns every sample recorded since the last one, so **no samples
  are lost** even at a slow poll rate — you just get them in bursts.

Buffer names are per-experiment.  These defaults match phyphox's built-in
"Acceleration with g" and "Acceleration without g" experiments.
"""

from __future__ import annotations

import asyncio
import logging
from dataclasses import dataclass, field

import aiohttp

from ..hub import SensorHub
from ..model import Reading

log = logging.getLogger(__name__)


@dataclass(slots=True)
class PhyphoxBuffers:
    """Which phyphox buffer feeds which of our sensors.

    ``time`` is the monotonic reference used both as the sample timestamp and
    as the incremental-fetch threshold.
    """

    time: str = "accT"
    channels: dict[str, tuple[str, ...]] = field(
        default_factory=lambda: {"accelg": ("accX", "accY", "accZ")}
    )

    def all_names(self) -> list[str]:
        return [self.time, *(b for chans in self.channels.values() for b in chans)]


class PhyphoxPoller:
    """Poll one phone until cancelled."""

    def __init__(
        self,
        host: str,
        hub: SensorHub,
        *,
        device: str | None = None,
        port: int = 80,
        interval: float = 0.05,
        buffers: PhyphoxBuffers | None = None,
    ) -> None:
        self.base = f"http://{host}:{port}"
        self.hub = hub
        self.device = device or host
        self.interval = interval
        self.buffers = buffers or PhyphoxBuffers()
        self.polls = 0
        self.errors = 0
        self._threshold: float = 0.0

    def _query(self) -> str:
        """`/get?accT=12.5&accX=12.5|accT&…` — every channel is asked for at the
        indices where the time buffer exceeds the last timestamp we saw."""
        t = self.buffers.time
        parts = [f"{t}={self._threshold:.6f}"]
        for chans in self.buffers.channels.values():
            parts += [f"{b}={self._threshold:.6f}|{t}" for b in chans]
        return "&".join(parts)

    async def run(self, session: aiohttp.ClientSession) -> None:
        consecutive_errors = 0
        while True:
            try:
                async with session.get(
                    f"{self.base}/get?{self._query()}",
                    timeout=aiohttp.ClientTimeout(total=2.0),
                ) as resp:
                    data = await resp.json(content_type=None)
                self.polls += 1
                consecutive_errors = 0
                self._emit(data)
            except asyncio.CancelledError:
                raise
            except Exception as exc:
                self.errors += 1
                consecutive_errors += 1
                # Back off rather than hammering a phone that has locked its
                # screen or left the network; give up loudly after a while
                # instead of retrying forever in silence.
                if consecutive_errors == 1:
                    log.warning("phyphox %s: %s", self.base, exc)
                if consecutive_errors >= 20:
                    log.error("phyphox %s: giving up after 20 failures", self.base)
                    return
                await asyncio.sleep(min(2.0, self.interval * 2**consecutive_errors))
                continue
            await asyncio.sleep(self.interval)

    def _emit(self, data: object) -> None:
        if not isinstance(data, dict):
            return
        buf = data.get("buffer")
        if not isinstance(buf, dict):
            return

        def series(name: str) -> list[float]:
            entry = buf.get(name)
            values = entry.get("buffer") if isinstance(entry, dict) else None
            if not isinstance(values, list):
                return []
            return [float(v) for v in values if isinstance(v, (int, float))]

        times = series(self.buffers.time)
        if not times:
            return
        for sensor, chans in self.buffers.channels.items():
            cols = [series(c) for c in chans]
            if any(not c for c in cols):
                continue
            n = min(len(times), *(len(c) for c in cols))
            for i in range(n):
                self.hub.publish(
                    Reading(self.device, sensor, times[i], tuple(c[i] for c in cols))
                )
        self._threshold = max(self._threshold, times[-1])
