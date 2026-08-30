"""Parser tests, focused on the ways a real phone's data is malformed."""

import math

from attention_phone.model import G
from attention_phone.sources.sensorlogger import parse_push
from attention_phone.sources.web import WebClientStats, parse_sample


# ---- the web sender page ------------------------------------------------

def test_parse_sample_splits_sensors():
    out = list(parse_sample({
        "d": "p1", "q": 1, "t": 1.5,
        "s": {"accel": [1, 2, 3], "heading": [270]},
    }))
    assert {r.sensor for r in out} == {"accel", "heading"}
    assert next(r for r in out if r.sensor == "accel").values == (1.0, 2.0, 3.0)
    assert all(r.t == 1.5 for r in out)


def test_nan_is_dropped():
    # iOS emits NaN for compass heading before the magnetometer has a fix;
    # letting that through poisons every downstream average.
    out = list(parse_sample({"d": "p1", "t": 0, "s": {"heading": [float("nan")]}}))
    assert out == []


def test_wrong_axis_count_is_dropped():
    out = list(parse_sample({"d": "p1", "t": 0, "s": {"accel": [1, 2]}}))
    assert out == []


def test_unknown_sensor_is_kept():
    # Better a strangely-named channel than a silently missing one.
    out = list(parse_sample({"d": "p1", "t": 0, "s": {"mystery": [1, 2, 3, 4, 5]}}))
    assert [r.sensor for r in out] == ["mystery"]


def test_missing_device_or_sensors_is_ignored():
    assert list(parse_sample({"s": {"accel": [1, 2, 3]}})) == []
    assert list(parse_sample({"d": "p1"})) == []
    assert list(parse_sample({"d": "p1", "s": "not-a-dict"})) == []


def test_non_numeric_values_are_dropped_not_raised():
    assert list(parse_sample({"d": "p1", "t": 0, "s": {"accel": ["a", "b", "c"]}})) == []


def test_sequence_gaps_are_counted():
    s = WebClientStats()
    for q in (1, 2, 5, 6):
        s.note(q)
    assert s.gaps == 2
    assert s.messages == 4


# ---- Sensor Logger HTTP push -------------------------------------------

def _push(*entries):
    return {"deviceId": "dev", "payload": list(entries)}


def test_accelerometer_maps_to_gravity_included():
    # Sensor Logger's own example shows z ~= 9.8 at rest, so its
    # "accelerometer" is the gravity-included channel.
    out = list(parse_push(_push(
        {"name": "accelerometer", "time": 2_000_000_000, "values": {"x": 0, "y": 0, "z": 9.8}}
    )))
    assert [r.sensor for r in out] == ["accelg"]
    assert out[0].t == 2.0  # nanoseconds → seconds
    assert abs(out[0].magnitude - G) < 0.02


def test_orientation_is_converted_to_degrees():
    out = list(parse_push(_push({
        "name": "orientation", "time": 0,
        "values": {"yaw": math.pi / 2, "pitch": 0.0, "roll": -math.pi / 4},
    })))
    assert out[0].sensor == "attitude"
    yaw, pitch, roll = out[0].values
    assert abs(yaw - 90.0) < 1e-6
    assert abs(roll + 45.0) < 1e-6
    assert pitch == 0.0


def test_unmapped_sensor_is_passed_through_tagged():
    # AirPods head motion arrives as "headphone"; keep it rather than drop it.
    out = list(parse_push(_push({
        "name": "headphone", "time": 0, "values": {"yaw": 0.3, "pitch": 0.2, "roll": 0.1},
    })))
    assert out[0].sensor == "sl:headphone"
    # Axis order is sorted key order, so it is at least deterministic.
    assert out[0].values == (0.2, 0.1, 0.3)


def test_non_numeric_extras_are_skipped():
    out = list(parse_push(_push({"name": "annotation", "time": 0, "values": {"label": "jump"}})))
    assert out == []


def test_missing_axis_drops_only_that_entry():
    out = list(parse_push(_push(
        {"name": "accelerometer", "time": 0, "values": {"x": 1, "y": 2}},
        {"name": "gyroscope", "time": 0, "values": {"x": 1, "y": 2, "z": 3}},
    )))
    assert [r.sensor for r in out] == ["gyro"]


def test_falls_back_to_session_id_for_device():
    out = list(parse_push({"sessionId": "sess-1", "payload": [
        {"name": "gyroscope", "time": 0, "values": {"x": 0, "y": 0, "z": 0}}
    ]}))
    assert out[0].device == "sess-1"
