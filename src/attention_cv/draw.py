"""Skeleton overlay rendering.

Three themes. ``calm`` is the default: the video is dimmed, lines are thin and
low-saturation, and nothing on screen blinks or strobes. ``bright`` is the
conventional high-contrast overlay, kept for when a projector washes everything
out. ``mono`` drops the video entirely.

Hands are drawn in the theme's ``accent`` rather than its ``line`` colour. With
a body and two hands on screen at once, twenty-one extra points in the same
colour read as noise around the wrist; a different hue separates them at a
glance.
"""

from __future__ import annotations

from dataclasses import dataclass

import cv2
import numpy as np

from .landmarks import (
    HAND_EDGES,
    POSE_BODY_EDGES,
    POSE_EDGES,
    POSE_FACE_POINTS,
)

# Kept under their old names: the pose demo and its tests refer to these.
FACE_POINTS = POSE_FACE_POINTS
BODY_EDGES = POSE_BODY_EDGES

__all__ = [
    "BODY_EDGES", "FACE_POINTS", "HAND_EDGES", "POSE_EDGES", "THEMES", "Theme",
    "dim_frame", "draw_hand", "draw_hud", "draw_label", "draw_pose",
    "draw_skeleton", "to_pixels",
]


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
    accent: tuple[int, int, int] = (255, 255, 255)  # hands


THEMES: dict[str, Theme] = {
    # Muted teal on a dimmed image: enough contrast to read, not enough to glare.
    "calm": Theme("calm", (176, 196, 132), (208, 220, 190), (190, 190, 185), 2, 3, 0.55,
                  accent=(150, 170, 225)),
    "bright": Theme("bright", (80, 255, 80), (60, 200, 255), (255, 255, 255), 3, 5, 1.0,
                    accent=(80, 120, 255)),
    # Skeleton only, on black — no video luminance at all.
    "mono": Theme("mono", (190, 190, 190), (235, 235, 235), (160, 160, 160), 2, 3, 0.0,
                  accent=(255, 255, 255)),
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


def draw_skeleton(
    frame: np.ndarray,
    points: np.ndarray,
    edges: list[tuple[int, int]],
    *,
    line: tuple[int, int, int],
    joint: tuple[int, int, int],
    line_width: int,
    joint_radius: int,
    visibility: np.ndarray | None = None,
    min_visibility: float = 0.5,
    skip: frozenset[int] = frozenset(),
) -> np.ndarray:
    """Draw one set of connected landmarks onto ``frame`` in place.

    Landmarks below ``min_visibility`` are dropped rather than drawn at their
    guessed position: an occluded limb otherwise thrashes around the frame,
    which is both wrong and unpleasant to look at.
    """
    h, w = frame.shape[:2]
    px = to_pixels(points, w, h)

    def ok(i: int) -> bool:
        return visibility is None or visibility[i] >= min_visibility

    for a, b in edges:
        if ok(a) and ok(b):
            cv2.line(frame, tuple(px[a]), tuple(px[b]), line, line_width, cv2.LINE_AA)
    for i in range(len(px)):
        if i in skip or not ok(i):
            continue
        cv2.circle(frame, tuple(px[i]), joint_radius, joint, -1, cv2.LINE_AA)
    return frame


def draw_pose(
    frame: np.ndarray,
    points: np.ndarray,
    *,
    theme: Theme,
    visibility: np.ndarray | None = None,
    min_visibility: float = 0.5,
    edges: list[tuple[int, int]] | None = None,
) -> np.ndarray:
    """Draw one body's skeleton, face detail omitted."""
    return draw_skeleton(
        frame, points, BODY_EDGES if edges is None else edges,
        line=theme.line, joint=theme.joint,
        line_width=theme.line_width, joint_radius=theme.joint_radius,
        visibility=visibility, min_visibility=min_visibility, skip=FACE_POINTS,
    )


def draw_hand(frame: np.ndarray, points: np.ndarray, *, theme: Theme) -> np.ndarray:
    """Draw one hand's 21 points.

    The hand model reports no visibility at all — every point comes back at
    zero — so there is nothing to threshold on here, and passing the pose
    demo's ``--min-visibility`` through would hide every hand.
    """
    return draw_skeleton(
        frame, points, HAND_EDGES,
        line=theme.accent, joint=theme.accent,
        line_width=max(1, theme.line_width - 1),
        joint_radius=max(2, theme.joint_radius - 1),
    )


def draw_label(
    frame: np.ndarray, text: str, point: np.ndarray, *, theme: Theme
) -> np.ndarray:
    """A short caption pinned near one landmark, e.g. which hand this is."""
    h, w = frame.shape[:2]
    x = int(np.clip(point[0] * w, 0, w - 60))
    y = int(np.clip(point[1] * h, 20, h - 8))
    for colour, thickness in ((0, 0, 0), 3), (theme.accent, 1):
        cv2.putText(frame, text, (x + 8, y - 8), cv2.FONT_HERSHEY_SIMPLEX,
                    0.45, colour, thickness, cv2.LINE_AA)
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
