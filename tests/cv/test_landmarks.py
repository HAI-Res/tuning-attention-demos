import numpy as np

from attention_cv import landmarks as L


def test_name_tables_match_the_models():
    assert len(L.HAND_NAMES) == 21
    assert len(L.POSE_NAMES) == 33
    assert len(set(L.HAND_NAMES)) == 21
    assert len(set(L.POSE_NAMES)) == 33


def test_names_sit_at_the_indices_mediapipe_uses():
    # Spot-checks against the published landmark order. If these drift, every
    # named OSC address quietly points at the wrong joint.
    assert L.INDEX["hand"]["wrist"] == 0
    assert L.INDEX["hand"]["thumb_tip"] == 4
    assert L.INDEX["hand"]["index_tip"] == 8
    assert L.INDEX["hand"]["pinky_tip"] == 20
    assert L.INDEX["pose"]["nose"] == 0
    assert L.INDEX["pose"]["left_shoulder"] == 11
    assert L.INDEX["pose"]["right_wrist"] == 16
    assert L.INDEX["pose"]["right_foot_index"] == 32


def test_key_points_all_exist():
    for name in L.HAND_KEY_POINTS:
        assert name in L.INDEX["hand"]
    for name in L.POSE_KEY_POINTS:
        assert name in L.INDEX["pose"]


def test_edges_stay_inside_the_point_count():
    assert all(0 <= a < 21 and 0 <= b < 21 for a, b in L.HAND_EDGES)
    assert all(0 <= a < 33 and 0 <= b < 33 for a, b in L.POSE_EDGES)


def test_every_hand_point_is_connected_to_something():
    touched = {i for edge in L.HAND_EDGES for i in edge}
    assert touched == set(range(21))


def test_to_array_shape():
    class LM:
        def __init__(self, x, y, z):
            self.x, self.y, self.z = x, y, z

    pts = L.to_array([LM(0.1, 0.2, 0.3), LM(0.4, 0.5, 0.6)])
    assert pts.shape == (2, 3)
    assert pts[1].tolist() == [0.4, 0.5, 0.6]


def test_distance_is_euclidean():
    pts = np.array([[0.0, 0.0, 0.0], [3.0, 4.0, 0.0]])
    assert L.distance(pts, 0, 1) == 5.0
