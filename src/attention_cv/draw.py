"""Skeleton overlay rendering.

Two themes. ``calm`` is the default: the video is dimmed, lines are thin and
low-saturation, and nothing on screen blinks or strobes. ``bright`` is the
conventional high-contrast overlay, kept for when a projector washes everything
out.
"""

from __future__ import annotations

from dataclasses import dataclass

import cv2
import numpy as np
from mediapipe.tasks.python import vision

# (start, end) index pairs for the 33-point body model.
POSE_EDGES: list[tuple[int, int]] = [
    (c.start, c.end) for c in vision.PoseLandmarksConnections.POSE_LANDMARKS
]

# Face landmarks (0-10) are dense and jittery; the body reads more clearly
# without a scribble of lines across the head.
FACE_POINTS = frozenset(range(11))
BODY_EDGES = [(a, b) for a, b in POSE_EDGES if a not in FACE_POINTS and b not in FACE_POINTS]


@dataclass(frozen=True)
class Theme:
    """Colours are BGR, the way OpenCV wants them."""

    name: str
    line: tuple[int, int, int]
    joint: tuple[int, int, int]
    text: tuple[int, int, int]
    line_width: int
    joint_radius: int
    dim: float  # video brightness multiplier, 1.0 = untouched


THEMES: dict[str, Theme] = {
    # Muted teal on a dimmed image: enough contrast to read, not enough to glare.
    "calm": Theme("calm", (176, 196, 132), (208, 220, 190), (190, 190, 185), 2, 3, 0.55),
    "bright": Theme("bright", (80, 255, 80), (60, 200, 255), (255, 255, 255), 3, 5, 1.0),
    # Skeleton only, on black — no video luminance at all.
    "mono": Theme("mono", (190, 190, 190), (235, 235, 235), (160, 160, 160), 2, 3, 0.0),
}


def dim_frame(frame: np.ndarray, factor: float) -> np.ndarray:
    if factor >= 1.0:
        return frame
    if factor <= 0.0:
        return np.zeros_like(frame)
    return cv2.convertScaleAbs(frame, alpha=factor, beta=0)


def to_pixels(points: np.ndarray, width: int, height: int) -> np.ndarray:
    """Normalised (N, >=2) landmarks -> integer pixel coordinates."""
    xy = points[:, :2].copy()
    xy[:, 0] *= width
    xy[:, 1] *= height
    return np.rint(xy).astype(np.int32)


def draw_pose(
    frame: np.ndarray,
    points: np.ndarray,
    *,
    theme: Theme,
    visibility: np.ndarray | None = None,
    min_visibility: float = 0.5,
    edges: list[tuple[int, int]] | None = None,
) -> np.ndarray:
    """Draw one body's skeleton onto ``frame`` in place.

    Landmarks below ``min_visibility`` are dropped rather than drawn at their
    guessed position: an occluded limb otherwise thrashes around the frame,
    which is both wrong and unpleasant to look at.
    """
    h, w = frame.shape[:2]
    px = to_pixels(points, w, h)
    edges = BODY_EDGES if edges is None else edges

    def ok(i: int) -> bool:
        return visibility is None or visibility[i] >= min_visibility

    for a, b in edges:
        if ok(a) and ok(b):
            cv2.line(frame, tuple(px[a]), tuple(px[b]), theme.line,
                     theme.line_width, cv2.LINE_AA)
    for i in range(len(px)):
        if i in FACE_POINTS or not ok(i):
            continue
        cv2.circle(frame, tuple(px[i]), theme.joint_radius, theme.joint, -1, cv2.LINE_AA)
    return frame


def draw_hud(frame: np.ndarray, lines: list[str], *, theme: Theme) -> np.ndarray:
    """Small fixed-position text block in the top-left corner."""
    x, y = 14, 26
    for text in lines:
        cv2.putText(frame, text, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.5,
                    (0, 0, 0), 3, cv2.LINE_AA)
        cv2.putText(frame, text, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.5,
                    theme.text, 1, cv2.LINE_AA)
        y += 22
    return frame
