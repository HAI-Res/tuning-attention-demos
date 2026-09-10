import numpy as np
import pytest

from attention_cv.smoothing import LandmarkSmoother, OneEuro


def test_jitter_is_reduced_on_a_still_signal():
    rng = np.random.default_rng(0)
    f = OneEuro()
    raw = [np.array([0.5, 0.5]) + rng.normal(0, 0.004, 2) for _ in range(200)]
    out = [f(x, i / 30) .copy() for i, x in enumerate(raw)]
    # Discard the warm-up before comparing.
    assert np.std(out[60:]) < np.std(raw[60:]) / 2


def test_lag_stays_small_while_moving():
    """A fast pan must not drag the skeleton behind the body."""
    f = OneEuro()
    speed = 1.0  # frame widths per second
    err = [abs(f(np.array([speed * i / 30]), i / 30)[0] - speed * i / 30) for i in range(90)]
    lag_ms = err[-1] / speed * 1000
    assert lag_ms < 80, f"steady-state lag {lag_ms:.0f}ms"


def test_first_sample_passes_through():
    f = OneEuro()
    x = np.array([0.1, 0.2, 0.3])
    assert np.allclose(f(x, 0.0), x)


def test_non_monotonic_time_is_ignored():
    f = OneEuro()
    f(np.array([0.0]), 1.0)
    assert f(np.array([99.0]), 0.5) == pytest.approx(0.0)


def test_tracking_loss_resets_the_filter():
    s = LandmarkSmoother()
    pts = np.full((33, 3), 0.2)
    for i in range(30):
        s.update(pts, i / 30)
    for i in range(30, 40):
        assert s.update(None, i / 30) is None
    # A body reappearing across the frame should be reported where it is, not
    # swept in from the old position.
    far = np.full((33, 3), 0.9)
    assert np.allclose(s.update(far, 40 / 30), far)
