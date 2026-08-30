"""The fan-in point: every source publishes here, every consumer subscribes.

Sources (the web page, Sensor Logger's HTTP push, a phyphox poller) know
nothing about consumers (the terminal display, an OSC forwarder, a student's
callback).  They only know the hub.  Adding a fourth source or a third
consumer touches nothing else.
"""

from __future__ import annotations

import statistics
import time
from collections import deque
from collections.abc import Callable, Iterable

from aiohttp import web

from .model import Reading

Subscriber = Callable[[Reading], None]


class RateMeter:
    """Measured arrival rate and interval spread over a sliding window.

    Reports what actually happened rather than what was asked for — the
    interesting numbers with phone sensors are always the p95 and the worst
    interval, because wifi delivers a 60 Hz stream as bursts.
    """

    def __init__(self, window: int = 120) -> None:
        self._t: deque[float] = deque(maxlen=window)
        self.count = 0

    def tick(self, t: float | None = None) -> None:
        self._t.append(time.monotonic() if t is None else t)
        self.count += 1

    @property
    def hz(self) -> float:
        if len(self._t) < 2:
            return 0.0
        span = self._t[-1] - self._t[0]
        return (len(self._t) - 1) / span if span > 0 else 0.0

    @property
    def intervals_ms(self) -> list[float]:
        return [(b - a) * 1e3 for a, b in zip(self._t, list(self._t)[1:], strict=False)]

    def stats(self) -> dict[str, float]:
        """Structured version of `summary`, for /health.

        p95 and worst are the interesting ones: wifi delivers a steady 100 Hz
        stream as bursts, and a median that looks perfect can hide a worst-case
        interval long enough to be audible in a movement-to-sound mapping.
        """
        iv = self.intervals_ms
        if len(iv) < 2:
            return {"hz": round(self.hz, 1), "count": self.count}
        iv_sorted = sorted(iv)
        return {
            "hz": round(self.hz, 1),
            "count": self.count,
            "median_ms": round(statistics.median(iv), 1),
            "p95_ms": round(iv_sorted[int(len(iv_sorted) * 0.95) - 1], 1),
            "worst_ms": round(max(iv), 1),
        }

    def summary(self) -> str:
        iv = self.intervals_ms
        if len(iv) < 2:
            return f"{self.count} samples"
        iv_sorted = sorted(iv)
        p95 = iv_sorted[int(len(iv_sorted) * 0.95) - 1]
        return (
            f"{self.count} samples, {self.hz:.1f} Hz, interval median "
            f"{statistics.median(iv):.1f}ms p95 {p95:.1f}ms worst {max(iv):.1f}ms"
        )


class DeviceState:
    """Everything the laptop knows about one phone."""

    def __init__(self, device: str, label: str = "") -> None:
        self.device = device
        self.label = label or device
        self.first_seen = time.monotonic()
        self.last_seen = self.first_seen
        self.latest: dict[str, Reading] = {}
        self.rates: dict[str, RateMeter] = {}
        self.sockets = 0
        """Open connections from this device. A phone that has announced itself
        but has every sensor switched off — or whose AirPods are not connected —
        sends nothing at all, and used to vanish from the display after the
        stale timeout. "Connected but silent" is the single most useful state to
        be able to see, so it is tracked separately from data arriving."""

    def record(self, r: Reading) -> None:
        self.last_seen = r.recv
        self.latest[r.sensor] = r
        self.rates.setdefault(r.sensor, RateMeter()).tick(r.recv)

    @property
    def age(self) -> float:
        """Seconds since this phone last said anything."""
        return time.monotonic() - self.last_seen

    @property
    def sensors(self) -> list[str]:
        return sorted(self.latest)

    @property
    def connected(self) -> bool:
        return self.sockets > 0

    @property
    def silent(self) -> bool:
        """Connected, but nothing has ever arrived."""
        return self.connected and not self.latest


class SensorHub:
    def __init__(self, stale_after: float = 5.0) -> None:
        self.devices: dict[str, DeviceState] = {}
        self.stale_after = stale_after
        self._subs: list[Subscriber] = []
        self.dropped = 0
        """Subscriber exceptions swallowed. A misbehaving consumer must not
        take the socket down mid-class."""

    def subscribe(self, fn: Subscriber) -> Subscriber:
        self._subs.append(fn)
        return fn

    def unsubscribe(self, fn: Subscriber) -> None:
        if fn in self._subs:
            self._subs.remove(fn)

    def publish(self, r: Reading) -> None:
        dev = self.devices.get(r.device)
        if dev is None:
            dev = self.devices[r.device] = DeviceState(r.device)
        dev.record(r)
        for fn in self._subs:
            try:
                fn(r)
            except Exception:
                self.dropped += 1

    def publish_all(self, readings: Iterable[Reading]) -> None:
        for r in readings:
            self.publish(r)

    def label(self, device: str, label: str) -> None:
        self._state(device).label = label

    def _state(self, device: str) -> DeviceState:
        dev = self.devices.get(device)
        if dev is None:
            dev = self.devices[device] = DeviceState(device)
        return dev

    def attach(self, device: str, label: str = "") -> None:
        """A socket opened for this device."""
        dev = self._state(device)
        if label:
            dev.label = label
        dev.sockets += 1

    def detach(self, device: str) -> None:
        dev = self.devices.get(device)
        if dev is not None:
            dev.sockets = max(0, dev.sockets - 1)

    def live(self) -> list[DeviceState]:
        """Devices worth showing, oldest connection first so a phone keeps its
        row instead of jumping around.

        A device with an open socket stays listed even when no data has arrived,
        because that is a state you need to diagnose rather than one to hide.
        """
        return sorted(
            (
                d
                for d in self.devices.values()
                if d.connected or d.age <= self.stale_after
            ),
            key=lambda d: d.first_seen,
        )

    def latest(self, device: str, sensor: str) -> Reading | None:
        dev = self.devices.get(device)
        return dev.latest.get(sensor) if dev else None


#: Typed key for stashing the hub on an aiohttp application. aiohttp prefers
#: these over bare strings so two components cannot collide on a name.
HUB = web.AppKey("hub", SensorHub)
