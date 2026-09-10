"""Frame-rate control.

The display rate is capped in software rather than trusted to the camera, because
(a) macOS cameras happily ignore ``CAP_PROP_FPS`` and (b) a loop that renders as
fast as it can produces an unstable, flickery update rate even when the average
looks fine. :class:`FrameClock` decides *when* a frame is due; the capture code
throws away everything in between so latency does not build up.
"""

from __future__ import annotations

import time
from collections import deque


class FrameClock:
    """Gate that opens ``fps`` times per second, on a fixed grid.

    ``due()`` returns True at most ``fps`` times a second. The schedule is a grid
    of absolute deadlines rather than "period since last frame", so jitter in one
    frame does not push every later frame late (which is what makes a 30 fps loop
    visibly wobble between 25 and 30).
    """

    def __init__(self, fps: float, *, tolerance: float = 0.002) -> None:
        if fps <= 0:
            raise ValueError("fps must be > 0")
        self.fps = float(fps)
        self.period = 1.0 / self.fps
        self.tolerance = tolerance
        self._next: float | None = None

    def due(self, now: float | None = None) -> bool:
        now = time.perf_counter() if now is None else now
        if self._next is None:
            self._next = now + self.period
            return True
        if now < self._next - self.tolerance:
            return False
        # Advance to the next deadline strictly in the future. If we fell more
        # than a whole period behind (a slow inference frame), resync to now
        # instead of trying to catch up with a burst of back-to-back frames.
        self._next += self.period
        if self._next <= now:
            self._next = now + self.period
        return True

    def sleep_until_due(self) -> None:
        """Block until the next frame is due (for sources with no back-pressure)."""
        if self._next is None:
            return
        remaining = self._next - time.perf_counter()
        if remaining > 0:
            time.sleep(remaining)


class FpsMeter:
    """Rolling frame-rate estimate, reported on a slow cadence.

    The displayed number is refreshed a few times a second; a per-frame readout
    is unreadable and the flicker is exactly the kind of thing we are trying to
    keep off the screen.
    """

    def __init__(self, window: int = 60, refresh: float = 0.4) -> None:
        self._stamps: deque[float] = deque(maxlen=window)
        self.refresh = refresh
        self._shown = 0.0
        self._shown_at = 0.0

    def tick(self, now: float | None = None) -> None:
        self._stamps.append(time.perf_counter() if now is None else now)

    @property
    def value(self) -> float:
        if len(self._stamps) < 2:
            return 0.0
        span = self._stamps[-1] - self._stamps[0]
        return (len(self._stamps) - 1) / span if span > 0 else 0.0

    @property
    def display(self) -> float:
        """The rate to draw: only updated every ``refresh`` seconds."""
        now = time.perf_counter()
        if now - self._shown_at >= self.refresh:
            self._shown = self.value
            self._shown_at = now
        return self._shown
