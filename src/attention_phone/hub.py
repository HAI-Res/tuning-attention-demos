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
#: A room subscriber gets each phone's wire sample as it arrived (validated,
#: with the phone's label added) rather than one `Reading` per sensor: the far
#: end is a relay that re-emits it, and one message per sample is what it wants.
RoomSubscriber = Callable[[dict], None]


class RateMeter:
    """Samples per second over a trailing time window, plus interval spread.

    The rate is deliberately *not* "samples divided by the span between the
    first and last of them". Some sensors batch: AirPods head motion arrives in
    bursts, and 37 samples spanning 1.5 ms compute to 25,000 Hz — a number that
    is both meaningless and alarming. Dividing by elapsed wall-clock time is
    immune to it, reports a burst as the low average it really is, and decays to
    zero when a channel stops instead of freezing at its last value.

    The interval percentiles are still worth having: they describe *delivery*
    jitter, which is what makes a 100 Hz stream feel uneven.
    """

    WINDOW = 3.0

    def __init__(self, window: int = 400) -> None:
        self._t: deque[float] = deque(maxlen=window)
        self._start: float | None = None
        self._last: float | None = None
        self.count = 0

    def tick(self, t: float | None = None) -> None:
        now = time.monotonic() if t is None else t
        if self._start is None:
            self._start = now
        self._last = now
        self._t.append(now)
        self.count += 1

    @property
    def average_hz(self) -> float:
        """Rate over the whole session, for the report printed on exit.

        Distinct from `hz`, which is a trailing window and correctly reads zero
        for a channel that has stopped. "How did the run go" wants the average.
        """
        if self._start is None or self._last is None:
            return 0.0
        span = self._last - self._start
        return self.count / span if span > 0 else 0.0

    def hz_at(self, now: float) -> float:
        if self._start is None:
            return 0.0
        cutoff = now - self.WINDOW
        recent = sum(1 for t in self._t if t >= cutoff)
        if not recent:
            return 0.0
        elapsed = min(self.WINDOW, max(now - self._start, 1e-3))
        return recent / elapsed

    @property
    def hz(self) -> float:
        return self.hz_at(time.monotonic())

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
            f"{self.count} samples, {self.average_hz:.1f} Hz, interval median "
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
        self.room_of: dict[str, str] = {}
        """Device → room. A room is one laptop's worth of phones: when the
        receiver is hosted centrally, every student's Max relays the room its
        QR named, and nothing else. A device that joined without a room
        belongs to the laptop this process runs on, as before."""
        self._rooms: dict[str, list[RoomSubscriber]] = {}

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

    # -- rooms ---------------------------------------------------------------

    def join(self, device: str, room: str) -> None:
        self.room_of[device] = room

    def room_subscribe(self, room: str, fn: RoomSubscriber) -> RoomSubscriber:
        self._rooms.setdefault(room, []).append(fn)
        return fn

    def room_unsubscribe(self, room: str, fn: RoomSubscriber) -> None:
        subs = self._rooms.get(room)
        if subs and fn in subs:
            subs.remove(fn)
        if subs == []:
            del self._rooms[room]

    def rooms(self) -> dict[str, int]:
        """Room → number of relays listening. For /health."""
        return {room: len(subs) for room, subs in self._rooms.items()}

    def publish_room(self, device: str, sample: dict) -> None:
        """Hand one validated sample to whoever is relaying this device's room."""
        room = self.room_of.get(device)
        if room is None:
            return
        for fn in self._rooms.get(room, ()):
            try:
                fn(sample)
            except Exception:
                self.dropped += 1

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
