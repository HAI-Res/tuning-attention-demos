"""Camera capture with a hard cap on the rate we actually process and display.

The strategy is *grab-and-drop*: the camera is read as fast as it produces
frames, but only frames that are due under a :class:`~attention_cv.timing.FrameClock`
are decoded, tracked and shown. Two things fall out of that:

* the display rate is exactly the requested rate, whatever the camera does;
* latency stays flat, because we never let undecoded frames pile up in the
  driver's buffer (which is what happens if you simply ``sleep`` in the loop).
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
        index: int = 0,
        *,
        width: int = 1280,
        height: int = 720,
        request_fps: float = 30.0,
    ) -> None:
        self.index = index
        self.width = width
        self.height = height
        self.request_fps = request_fps
        self.cap: cv2.VideoCapture | None = None
        self.dropped = 0

    def __enter__(self) -> Camera:
        # AVFoundation is the only backend worth using on macOS; the default
        # picks it anyway, but naming it avoids a slow probe of the others.
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
