"""Capture with a hard cap on the rate we actually process and display.

For a **camera** the strategy is *grab-and-drop*: it is read as fast as it
produces frames, but only frames that are due under a
:class:`~attention_cv.timing.FrameClock` are decoded, tracked and shown. Two
things fall out of that:

* the display rate is exactly the requested rate, whatever the camera does;
* latency stays flat, because we never let undecoded frames pile up in the
  driver's buffer (which is what happens if you simply ``sleep`` in the loop).

For a **video file** the strategy is the opposite: a file has no back-pressure
at all and will hand over frames as fast as they decode, so it is *paced*
instead of dropped. Dropping there would throw away frames nobody was too busy
to look at, and running unpaced turns a mapping test into a two-second burst.
"""

from __future__ import annotations

import sys
import time
from collections.abc import Iterator
from dataclasses import dataclass

import cv2
import numpy as np

from .timing import FrameClock


@dataclass
class CaptureInfo:
    width: int
    height: int
    reported_fps: float
    backend: str


class Camera:
    """A ``cv2.VideoCapture`` with sane defaults, used as a context manager."""

    def __init__(
        self,
        index: int | str = 0,
        *,
        width: int = 1280,
        height: int = 720,
        request_fps: float = 30.0,
        warmup: float = 2.0,
        loop: bool = False,
    ) -> None:
        self.index = index
        self.width = width
        self.height = height
        self.request_fps = request_fps
        self.warmup = warmup
        self.loop = loop
        self.cap: cv2.VideoCapture | None = None
        self.dropped = 0

    @property
    def is_file(self) -> bool:
        """A path rather than a device index — no back-pressure, so pace it."""
        return isinstance(self.index, str)

    def __enter__(self) -> Camera:
        # AVFoundation is the only backend worth using on macOS; the default
        # picks it anyway, but naming it avoids a slow probe of the others.
        if self.is_file:
            cap = cv2.VideoCapture(str(self.index))
            if not cap.isOpened():
                raise SystemExit(f"could not open video file {self.index!r}")
            self.cap = cap
            return self

        backend = cv2.CAP_AVFOUNDATION if sys.platform == "darwin" else cv2.CAP_ANY
        cap = cv2.VideoCapture(self.index, backend)
        if not cap.isOpened():
            raise SystemExit(
                f"could not open camera {self.index}.\n"
                "  On macOS the terminal app needs camera access:\n"
                "  System Settings > Privacy & Security > Camera."
            )
        cap.set(cv2.CAP_PROP_FRAME_WIDTH, self.width)
        cap.set(cv2.CAP_PROP_FRAME_HEIGHT, self.height)
        # Asking for 30 fps often works and saves the drop path some work, but
        # it is a hint only — cameras and backends are free to ignore it.
        cap.set(cv2.CAP_PROP_FPS, self.request_fps)
        cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)

        # Opening is not the same as working. A virtual camera whose host app
        # is not running — OBS installs one, and it is often index 0 — opens
        # happily and then delivers nothing at all, so without this check the
        # demo runs to completion and reports "0 frames" with no reason given.
        # Real cameras sometimes need a moment to wake, hence the retries.
        deadline = time.perf_counter() + self.warmup
        while True:
            ok, _frame = cap.read()
            if ok:
                break
            if time.perf_counter() >= deadline:
                cap.release()
                raise SystemExit(
                    f"camera {self.index} opened but delivered no frames in "
                    f"{self.warmup:g}s.\n"
                    "  Usually a virtual camera whose app is not running (OBS "
                    "installs one,\n"
                    "  often at index 0), or a camera already in use by "
                    "another app.\n"
                    "  Run with --list-cameras: an index that says 'opened but "
                    "no frame' is this."
                )

        self.cap = cap
        return self

    def __exit__(self, *exc: object) -> None:
        if self.cap is not None:
            self.cap.release()
            self.cap = None

    @property
    def info(self) -> CaptureInfo:
        assert self.cap is not None
        return CaptureInfo(
            width=int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH)),
            height=int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT)),
            reported_fps=float(self.cap.get(cv2.CAP_PROP_FPS)),
            backend=self.cap.getBackendName(),
        )

    def frames(self, fps: float, *, mirror: bool = True) -> Iterator[tuple[np.ndarray, float]]:
        """Yield ``(frame, timestamp_seconds)`` at no more than ``fps`` per second.

        Frames that arrive between deadlines are grabbed but never decoded, so
        they cost almost nothing and keep the pipeline current.
        """
        assert self.cap is not None
        clock = FrameClock(fps)
        while True:
            if self.is_file:
                ok, frame = self.cap.read()
                if not ok or frame is None:
                    if not self.loop:
                        break
                    self.cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
                    continue
                # Wait for the deadline set on the *previous* frame, then
                # take the next one. In this order the period covers the
                # caller's work — inference — instead of being added to it,
                # which is the difference between a file playing at 30 fps and
                # a file playing at 14. If the work overruns, sleep_until_due
                # returns at once and due() resyncs the grid rather than
                # firing a catch-up burst.
                clock.sleep_until_due()
                clock.due()
                if mirror:
                    frame = cv2.flip(frame, 1)
                yield frame, time.perf_counter()
                continue
            if not self.cap.grab():
                break
            now = time.perf_counter()
            if not clock.due(now):
                self.dropped += 1
                continue
            ok, frame = self.cap.retrieve()
            if not ok or frame is None:
                continue
            if mirror:
                # Mirrored view: moving your right hand moves the right side of
                # the image, which is what people expect of a camera preview.
                frame = cv2.flip(frame, 1)
            yield frame, now
