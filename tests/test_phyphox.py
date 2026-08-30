from attention_phone.hub import SensorHub
from attention_phone.sources.phyphox import PhyphoxPoller


def poller():
    return PhyphoxPoller("10.0.0.9", SensorHub())


def response(times, xs, ys, zs):
    def buf(v):
        return {"size": len(v), "updateMode": "partial", "buffer": v}
    return {"buffer": {"accT": buf(times), "accX": buf(xs), "accY": buf(ys), "accZ": buf(zs)},
            "status": {"measuring": True}}


def test_emits_one_reading_per_sample():
    p = poller()
    p._emit(response([0.0, 0.01, 0.02], [1, 2, 3], [4, 5, 6], [7, 8, 9]))
    dev = p.hub.devices["10.0.0.9"]
    assert dev.rates["accelg"].count == 3
    assert dev.latest["accelg"].values == (3.0, 6.0, 9.0)


def test_threshold_advances_so_the_next_poll_gets_only_new_data():
    p = poller()
    assert "accT=0.000000" in p._query()
    p._emit(response([0.0, 0.5, 1.25], [1, 1, 1], [1, 1, 1], [1, 1, 1]))
    assert p._threshold == 1.25
    q = p._query()
    assert "accT=1.250000" in q
    # Channels are indexed off the time buffer, which is what keeps the
    # columns aligned when phyphox is mid-write.
    assert "accX=1.250000|accT" in q


def test_threshold_never_goes_backwards():
    # A restarted experiment resets phyphox's clock; without the max() a
    # stale threshold would silently discard every later sample.
    p = poller()
    p._emit(response([5.0], [1], [1], [1]))
    p._emit(response([0.1], [1], [1], [1]))
    assert p._threshold == 5.0


def test_ragged_columns_are_truncated_not_misaligned():
    # phyphox can answer mid-write, with one channel a sample ahead.
    p = poller()
    p._emit(response([0.0, 0.01], [1, 2], [4, 5], [7]))
    dev = p.hub.devices["10.0.0.9"]
    assert dev.rates["accelg"].count == 1
    assert dev.latest["accelg"].values == (1.0, 4.0, 7.0)


def test_garbage_and_empty_responses_are_survived():
    p = poller()
    for bad in (None, {}, {"buffer": None}, {"buffer": {}}, response([], [], [], [])):
        p._emit(bad)
    assert p.hub.devices == {}
