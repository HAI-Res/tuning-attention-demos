import numpy as np
import pytest

from attention_cv.timing import FrameClock, FpsMeter


def render_count(source_fps: float, cap_fps: float, seconds: float) -> int:
    """How many frames pass the gate when a source_fps camera runs for `seconds`."""
    clock = FrameClock(cap_fps)
    n = int(source_fps * seconds)
    return sum(1 for i in range(n) if clock.due(i / source_fps))


@pytest.mark.parametrize("source_fps", [30, 60, 120, 240])
def test_cap_holds_regardless_of_source_rate(source_fps):
    rendered = render_count(source_fps, 30.0, 2.0)
    assert 58 <= rendered <= 61, f"{source_fps} fps source -> {rendered} frames in 2s"


def test_slow_source_is_passed_through_untouched():
    # A 24 fps camera under a 30 fps cap must not lose frames.
    assert render_count(24, 30.0, 2.0) == 48


def test_stall_does_not_cause_a_catch_up_burst():
    """After a late frame the clock resyncs instead of firing back-to-back."""
    clock = FrameClock(30.0)
    t, stamps = 0.0, []
    for i in range(120):
        t += 0.2 if i == 40 else 1 / 90  # one 200 ms hitch
        if clock.due(t):
            stamps.append(t)
    gaps = np.diff(stamps)
    assert gaps.min() > 0.028, f"burst detected: min gap {gaps.min() * 1000:.1f}ms"


def test_fps_meter_reports_the_source_rate():
    meter = FpsMeter()
    for i in range(60):
        meter.tick(i / 30.0)
    assert meter.value == pytest.approx(30.0, rel=0.05)


def test_bad_fps_rejected():
    with pytest.raises(ValueError):
        FrameClock(0)
