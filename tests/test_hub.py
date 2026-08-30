import time

from attention_phone.hub import RateMeter, SensorHub
from attention_phone.model import Reading


def r(device="p1", sensor="accel", t=0.0, values=(0.0, 0.0, 1.0), recv=None):
    kw = {} if recv is None else {"recv": recv}
    return Reading(device, sensor, t, values, **kw)


def test_publish_registers_device_and_latest():
    hub = SensorHub()
    hub.publish(r(values=(1.0, 2.0, 3.0)))
    assert hub.latest("p1", "accel").values == (1.0, 2.0, 3.0)
    assert hub.devices["p1"].sensors == ["accel"]


def test_subscriber_exception_does_not_break_the_stream():
    # A student's broken callback must not take down the socket every other
    # phone in the room is using.
    hub = SensorHub()
    hub.subscribe(lambda _: 1 / 0)
    got = []
    hub.subscribe(got.append)
    hub.publish(r())
    assert hub.dropped == 1
    assert len(got) == 1


def test_label_survives_before_any_reading():
    hub = SensorHub()
    hub.label("p9", "Ada")
    hub.publish(r(device="p9"))
    assert hub.devices["p9"].label == "Ada"


def test_live_excludes_stale_and_keeps_join_order():
    hub = SensorHub(stale_after=1.0)
    now = time.monotonic()
    hub.publish(r(device="old", recv=now - 10))
    hub.publish(r(device="new", recv=now))
    assert [d.device for d in hub.live()] == ["new"]


def test_rate_meter_measures_hz():
    m = RateMeter()
    for i in range(31):
        m.tick(i * 0.01)  # 100 Hz
    assert 99.0 < m.hz < 101.0
    assert m.count == 31
    assert "100.0 Hz" in m.summary()


def test_rate_meter_is_quiet_with_one_sample():
    m = RateMeter()
    m.tick(0.0)
    assert m.hz == 0.0
    assert m.summary() == "1 samples"


def test_magnitude_ignores_orientation():
    assert abs(Reading("p", "accel", 0, (3.0, 4.0, 0.0)).magnitude - 5.0) < 1e-9


def test_as_dict_names_the_axes():
    assert Reading("p", "attitude", 0, (10.0, 20.0, 30.0)).as_dict() == {
        "yaw": 10.0, "pitch": 20.0, "roll": 30.0
    }


def test_every_channel_the_ios_app_sends_has_axes():
    # The iOS app and the browser page both name channels from this table; a
    # channel missing here silently loses its axis labels and cannot be picked
    # with --sensor. Keep it in step with Channel.swift.
    from attention_phone.model import AXES, VECTOR_SENSORS

    ios_channels = {
        "accel", "gravity", "gyro", "attitude", "quat", "mag",
        "accelg", "gyroraw", "magraw",
        "pressure", "location", "heading", "steps", "device",
        "head", "headaccel", "audio",
    }
    assert ios_channels <= set(AXES), sorted(ios_channels - set(AXES))
    # Vector sensors must be a subset, and must be genuinely 3-or-4-axis xyz.
    assert VECTOR_SENSORS <= set(AXES)
    for sensor in VECTOR_SENSORS:
        assert AXES[sensor] == ("x", "y", "z"), (sensor, AXES[sensor])


def test_non_vector_sensors_are_not_treated_as_vectors():
    from attention_phone.model import VECTOR_SENSORS

    for sensor in ("location", "attitude", "heading", "steps", "device", "quat", "audio"):
        assert sensor not in VECTOR_SENSORS
