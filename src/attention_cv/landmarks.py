"""Landmark names, connections, and the array conversion.

MediaPipe hands back landmarks as opaque objects with anonymous indices. Two
things are needed before that data can leave the process: a name for every
index, so an OSC address can say ``index_tip`` instead of ``8``, and a plain
``(N, 3)`` array, so smoothing and geometry are numpy rather than loops.

Two coordinate spaces come out of every task, and they are not
interchangeable:

``norm``
    x and y normalised to the image, 0..1, origin top-left. z is a *relative*
    depth in roughly the same scale as x, negative towards the camera, with the
    origin at the wrist (hands) or the hip midpoint (body). Use it for "where
    is this in the frame".

``world``
    metres, right-handed, origin at the hand's geometric centre (hands) or the
    hip midpoint (body). Independent of where in the frame the subject is and
    how far away they are, which is what makes a distance like a pinch mean the
    same thing across the room as it does up close. Use it for geometry.
"""

from __future__ import annotations

import numpy as np
from mediapipe.tasks.python import vision

# --- hands: 21 points ------------------------------------------------------

HAND_NAMES: tuple[str, ...] = (
    "wrist",
    "thumb_cmc", "thumb_mcp", "thumb_ip", "thumb_tip",
    "index_mcp", "index_pip", "index_dip", "index_tip",
    "middle_mcp", "middle_pip", "middle_dip", "middle_tip",
    "ring_mcp", "ring_pip", "ring_dip", "ring_tip",
    "pinky_mcp", "pinky_pip", "pinky_dip", "pinky_tip",
)

HAND_EDGES: list[tuple[int, int]] = [
    (c.start, c.end) for c in vision.HandLandmarksConnections.HAND_CONNECTIONS
]

# --- body: 33 points -------------------------------------------------------

POSE_NAMES: tuple[str, ...] = (
    "nose",
    "left_eye_inner", "left_eye", "left_eye_outer",
    "right_eye_inner", "right_eye", "right_eye_outer",
    "left_ear", "right_ear",
    "mouth_left", "mouth_right",
    "left_shoulder", "right_shoulder",
    "left_elbow", "right_elbow",
    "left_wrist", "right_wrist",
    "left_pinky", "right_pinky",
    "left_index", "right_index",
    "left_thumb", "right_thumb",
    "left_hip", "right_hip",
    "left_knee", "right_knee",
    "left_ankle", "right_ankle",
    "left_heel", "right_heel",
    "left_foot_index", "right_foot_index",
)

POSE_EDGES: list[tuple[int, int]] = [
    (c.start, c.end) for c in vision.PoseLandmarksConnections.POSE_LANDMARKS
]

# The first eleven body points are face detail — eyes, ears, mouth corners.
# They are dense, jittery, and drawn as a scribble across the head, so the
# skeleton leaves them out. They are still sent; only the drawing skips them.
POSE_FACE_POINTS = frozenset(range(11))
POSE_BODY_EDGES = [
    (a, b) for a, b in POSE_EDGES
    if a not in POSE_FACE_POINTS and b not in POSE_FACE_POINTS
]

INDEX = {
    "hand": {name: i for i, name in enumerate(HAND_NAMES)},
    "pose": {name: i for i, name in enumerate(POSE_NAMES)},
}

# The points worth their own OSC address. Everything is still available in the
# bulk message; this is the shortlist that a mapping actually reaches for, kept
# short because each one is a packet per frame.
HAND_KEY_POINTS: tuple[str, ...] = (
    "wrist", "thumb_tip", "index_tip", "middle_tip", "ring_tip", "pinky_tip",
)

POSE_KEY_POINTS: tuple[str, ...] = (
    "nose",
    "left_shoulder", "right_shoulder",
    "left_elbow", "right_elbow",
    "left_wrist", "right_wrist",
    "left_hip", "right_hip",
    "left_knee", "right_knee",
    "left_ankle", "right_ankle",
)


def to_array(landmarks: list) -> np.ndarray:
    """MediaPipe landmark list -> ``(N, 3)`` float array."""
    return np.array([[lm.x, lm.y, lm.z] for lm in landmarks], dtype=np.float64)


def visibility_of(landmarks: list) -> np.ndarray:
    """``(N,)`` confidence per landmark.

    ``visibility`` and ``presence`` mean different things — "in frame, not
    occluded" and "this point exists at all" — and either being low is reason
    enough not to draw the point, so take the smaller. The hand model leaves
    both at zero, which is why hands do not use this.
    """
    return np.array(
        [min(lm.visibility, lm.presence) for lm in landmarks], dtype=np.float64
    )


def distance(points: np.ndarray, a: int, b: int) -> float:
    """Euclidean distance between two landmarks, in whatever space they are in."""
    return float(np.linalg.norm(points[a] - points[b]))


def hand_size(norm: np.ndarray) -> float:
    """Apparent size of a hand in the image: palm length, in image units.

    The mean of wrist→index knuckle and wrist→middle knuckle, as full 3D
    lengths in *image-normalised* space. Those two lengths are rigid — the
    knuckles do not move relative to the wrist when the fingers curl or spread,
    unlike the fingertips — so this changes for one reason only: how far the
    hand is from the camera. Roughly ``size ∝ 1 / distance``, which makes it
    the one number here that tracks camera distance, something neither model's
    z reports (hand z is relative to the wrist, pose z to the hips).

    Deliberately image space, not metres: in world space a palm is always the
    same length, which is exactly the property a distance proxy must not have.
    The z component is kept because a hand tilted towards the camera
    foreshortens in x–y while its wrist-relative z grows, and the 3D length
    largely cancels that.
    """
    idx = INDEX["hand"]
    return 0.5 * (distance(norm, idx["wrist"], idx["index_mcp"])
                  + distance(norm, idx["wrist"], idx["middle_mcp"]))
