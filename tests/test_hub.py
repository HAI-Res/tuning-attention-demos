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
        m.tick(i * 0.01)  # 100 Hz for 0.3 s
    # hz_at, not hz: these are synthetic timestamps, and the bare property
    # judges them against the real clock (where they are ancient, hence zero).
    assert 99.0 < m.hz_at(0.30) < 105.0
    assert m.count == 31
    # summary() is the exit report, so it uses the session average rather than
    # a trailing window that has long since expired.
    assert 99.0 < m.average_hz < 105.0
    assert "Hz" in m.summary()


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


def test_summary_average_is_not_the_windowed_rate():
    m = RateMeter()
    for i in range(300):
        m.tick(i * 0.01)          # 100 Hz for 3 s, entirely in the past
    assert m.hz == 0.0            # trailing window: nothing recent
    assert 99 < m.average_hz < 101  # session average: what the run did


def test_burst_delivery_does_not_report_absurd_rate():
    # AirPods head motion arrives batched: 37 samples inside 1.5 ms. Dividing
    # by the span between first and last gave ~25,000 Hz, which is what the app
    # was displaying.
    m = RateMeter()
    for i in range(37):
        m.tick(100.0 + i * 0.00004)   # 37 samples across 1.5 ms
    hz = m.hz_at(101.0)               # judged one second later
    assert hz < 60, hz
    assert m.count == 37


def test_rate_decays_to_zero_when_a_channel_stops():
    m = RateMeter()
    for i in range(300):
        m.tick(i * 0.01)              # 100 Hz for 3 s
    assert 90 < m.hz_at(3.0) < 110
    # Ten seconds later, nothing has arrived since.
    assert m.hz_at(13.0) == 0.0


def test_steady_rate_is_still_measured_correctly():
    m = RateMeter()
    for i in range(1000):
        m.tick(i * 0.01)              # 100 Hz
    assert 95 < m.hz_at(10.0) < 105
