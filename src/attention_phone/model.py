"""The one data model every source normalises into.

Different senders disagree about units in ways that are easy to lose an
afternoon to.  The web `DeviceMotionEvent` reports rotation in **degrees**
per second; CoreMotion and Sensor Logger report **radians** per second.
CoreMotion's `userAcceleration` is in **g**; the web API and Sensor Logger
use **m/s²**.  Every source module converts on the way in so that anything
downstream — the terminal display, an OSC send, a student's demo — sees one
set of units:

| sensor      | axes                  | unit                        |
| ----------- | --------------------- | --------------------------- |
| `accel`     | x, y, z               | m/s², gravity removed       |
| `accelg`    | x, y, z               | m/s², gravity included      |
| `gravity`   | x, y, z               | m/s²                        |
| `gyro`      | x, y, z               | rad/s                       |
| `attitude`  | yaw, pitch, roll      | degrees                     |
| `mag`       | x, y, z               | microtesla                  |
| `pressure`  | kpa                   | kilopascal                  |
| `location`  | lat, lon, alt, speed  | degrees, m, m/s             |
| `heading`   | deg                   | degrees clockwise from north |
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field

#: Axis names per sensor, in the order they appear in ``Reading.values``.
AXES: dict[str, tuple[str, ...]] = {
    # Fused device motion — what you almost always want.
    "accel": ("x", "y", "z"),
    "gravity": ("x", "y", "z"),
    "gyro": ("x", "y", "z"),
    "attitude": ("yaw", "pitch", "roll"),
    "quat": ("w", "x", "y", "z"),
    "mag": ("x", "y", "z"),
    # Raw, unfused.
    "accelg": ("x", "y", "z"),
    "gyroraw": ("x", "y", "z"),
    "magraw": ("x", "y", "z"),
    # Environment.
    "pressure": ("kpa", "altitude"),
    "location": ("lat", "lon", "alt", "speed"),
    "heading": ("deg",),
    "steps": ("count", "cadence", "distance"),
    "device": ("proximity", "battery", "orientation"),
    # AirPods head motion, which only the native app can reach.
    "head": ("yaw", "pitch", "roll"),
    "headaccel": ("x", "y", "z"),
    # Microphone, reduced on the phone to three numbers.
    "audio": ("rms", "peak", "onset"),
}

#: Channels whose axes form a vector, so `magnitude` is meaningful. Averaging
#: or taking the length of a lat/lon pair is nonsense, and this is what stops
#: the display offering it.
VECTOR_SENSORS = frozenset(
    {"accel", "accelg", "gravity", "gyro", "gyroraw", "mag", "magraw", "headaccel"}
)

G = 9.80665  # m/s² per g, for sources that report acceleration in g


@dataclass(frozen=True, slots=True)
class Reading:
    """One sample of one sensor from one phone.

    ``values`` is positional rather than a dict: it is what gets forwarded to
    OSC and what a student indexes into, and at 60 Hz × 20 phones the
    allocation difference is not nothing.  ``AXES[sensor]`` names the slots.
    """

    device: str
    sensor: str
    t: float
    """Seconds on the *sender's* clock. Monotonic within one session, but not
    comparable between two phones — they never agree on an epoch. Use it for
    intervals and ordering, not for cross-device alignment."""
    values: tuple[float, ...]
    recv: float = field(default_factory=time.monotonic)
    """``time.monotonic()`` on this laptop when the sample arrived. This *is*
    comparable across phones, at the cost of network jitter."""

    def as_dict(self) -> dict[str, float]:
        return dict(zip(AXES.get(self.sensor, ()), self.values, strict=False))

    @property
    def magnitude(self) -> float:
        """Euclidean length of the vector — the single most useful scalar to
        map onto sound, because it does not care how the phone is held."""
        return sum(v * v for v in self.values) ** 0.5
