import numpy as np

from attention_cv import draw


def test_face_points_are_excluded_from_body_edges():
    assert len(draw.BODY_EDGES) < len(draw.POSE_EDGES)
    assert not any(a in draw.FACE_POINTS or b in draw.FACE_POINTS for a, b in draw.BODY_EDGES)


def test_dim_frame_scales_brightness():
    f = np.full((10, 10, 3), 200, np.uint8)
    assert draw.dim_frame(f, 1.0).mean() == 200
    assert draw.dim_frame(f, 0.5).mean() == 100
    assert draw.dim_frame(f, 0.0).mean() == 0


def test_to_pixels_maps_normalised_coords():
    pts = np.array([[0.0, 0.0, 0.0], [1.0, 1.0, 0.0], [0.5, 0.25, 0.0]])
    px = draw.to_pixels(pts, 640, 480)
    assert px.tolist() == [[0, 0], [640, 480], [320, 120]]


def test_invisible_landmarks_are_not_drawn():
    theme = draw.THEMES["calm"]
    pts = np.full((33, 3), 0.5)
    vis = np.zeros(33)
    blank = np.zeros((100, 100, 3), np.uint8)
    out = draw.draw_pose(blank.copy(), pts, theme=theme, visibility=vis)
    assert out.sum() == 0, "landmarks below the visibility threshold must be skipped"
    out = draw.draw_pose(blank.copy(), pts, theme=theme, visibility=np.ones(33))
    assert out.sum() > 0
