"""The live terminal readout.

Two constraints shaped this. It is shown on a projector to a room, so it has
to be readable from the back: few rows, big signals, no scrolling wall of
numbers. And it redraws several times a second for an hour, so it rewrites
a fixed block in place rather than clearing the screen — clearing destroys
the scrollback that holds the URL and the QR code students still need.
"""

from __future__ import annotations

import shutil
import sys
import time

from .hub import DeviceState, SensorHub
from .model import AXES, VECTOR_SENSORS

RESET = "\033[0m"
DIM = "\033[2m"
BOLD = "\033[1m"

#: Full-scale value per sensor for the bar meter. Acceleration: 20 m/s² is
#: about as hard as you can shake a phone you intend to keep. Gyro: 10 rad/s
#: is a brisk wrist flick.
FULL_SCALE = {
    "accel": 20.0, "accelg": 20.0, "gravity": 10.0, "gyro": 10.0, "gyroraw": 10.0,
    "mag": 100.0, "magraw": 100.0, "headaccel": 10.0, "audio": 1.0,
}


def bar(value: float, full: float, width: int = 12) -> str:
    """Unsigned magnitude bar, using eighth-blocks so slow movement still
    registers instead of quantising to nothing."""
    frac = 0.0 if full <= 0 else max(0.0, min(1.0, value / full))
    total = frac * width
    whole = int(total)
    eighths = int((total - whole) * 8)
    out = "█" * whole
    if eighths and whole < width:
        out += "▐▏▎▍▌▋▊▉"[eighths]
    return out.ljust(width)


class LiveDisplay:
    def __init__(self, hub: SensorHub, url: str, sensor: str = "accel") -> None:
        self.hub = hub
        self.url = url
        self.sensor = sensor
        self._lines = 0
        self._started = time.monotonic()

    def _rows(self) -> list[str]:
        devices = self.hub.live()
        width = shutil.get_terminal_size((100, 30)).columns
        rows = [
            f"{DIM}{self.url}{RESET}  "
            f"{BOLD}{len(devices)}{RESET} phone{'' if len(devices) == 1 else 's'}"
            f"{DIM} · {int(time.monotonic() - self._started)}s{RESET}",
            "",
        ]
        if not devices:
            rows.append(f"{DIM}  waiting — open the URL on a phone and tap Start{RESET}")
            return rows

        for d in devices:
            rows.extend(self._device_rows(d, width))
        return rows

    def _device_rows(self, d: DeviceState, width: int) -> list[str]:
        name = d.label[:14]
        r = d.latest.get(self.sensor)
        meter = d.rates.get(self.sensor)
        hz = meter.hz if meter else 0.0
        if r is None:
            avail = ",".join(d.sensors) or "none yet"
            return [f"  {BOLD}{name:<14}{RESET} {DIM}no {self.sensor} — has: {avail}{RESET}"]

        nums = "  ".join(f"{v:+6.2f}" for v in r.values)
        line = f"  {BOLD}{name:<14}{RESET}{hz:5.1f} Hz  {nums}"
        if self.sensor in VECTOR_SENSORS:
            # A bar only means something when the axes are a vector. The length
            # of a lat/lon pair is a number, but it is not about anything.
            mag = r.magnitude
            line += (
                f"  {DIM}|{RESET}{bar(mag, FULL_SCALE.get(self.sensor, 20.0))}"
                f"{DIM}|{RESET} {mag:5.2f}"
            )
        else:
            axes = AXES.get(self.sensor, ())
            if axes:
                line += f"   {DIM}{' '.join(axes)}{RESET}"
        out = [line]
        # Attitude is the other genuinely useful channel, and it costs one
        # short line, so show it when the phone is sending it.
        if (att := d.latest.get("attitude")) is not None and width > 78:
            yaw, pitch, roll = att.values
            out.append(
                f"  {'':<14}{DIM}      attitude  yaw {yaw:6.1f}  "
                f"pitch {pitch:6.1f}  roll {roll:6.1f}{RESET}"
            )
        return out

    def render(self, stream=sys.stdout) -> None:
        rows = self._rows()
        if self._lines:
            stream.write(f"\033[{self._lines}A")
        for row in rows:
            stream.write("\033[2K" + row + "\n")
        # If the table shrank (a phone left), wipe the rows it used to occupy
        # instead of leaving a stale ghost row on screen.
        for _ in range(max(0, self._lines - len(rows))):
            stream.write("\033[2K\n")
        self._lines = max(self._lines, len(rows))
        stream.flush()

    def finish(self, stream=sys.stdout) -> None:
        stream.write("\n")
        stream.flush()


def summary(hub: SensorHub) -> str:
    """What actually arrived, printed on exit — the number that matters, in
    the same spirit as attention-cv's frame-timing report."""
    if not hub.devices:
        return "No phone ever connected."
    lines = [f"{len(hub.devices)} device(s):"]
    for d in sorted(hub.devices.values(), key=lambda x: x.first_seen):
        lines.append(f"  {d.label} ({d.device})")
        for sensor in d.sensors:
            lines.append(f"    {sensor:<10} {d.rates[sensor].summary()}")
    if hub.dropped:
        lines.append(f"{hub.dropped} subscriber callback(s) raised and were ignored.")
    return "\n".join(lines)
