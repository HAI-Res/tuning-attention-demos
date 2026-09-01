import numpy as np
import pytest

from attention_cv import landmarks as L
from attention_cv.send import LandmarkOsc


class Recorder:
    """Stands in for an OscSender and keeps everything it was asked to send."""

    addr = ("127.0.0.1", 7400)
    errors = 0

    def __init__(self):
        self.messages = []
        self.sent = 0

    def send(self, address, *args):
        self.messages.append((address, list(args)))
        self.sent += 1

    def send_vector(self, address, values):
        self.send(address, *(float(v) for v in values))

    def by_address(self):
        return {a: v for a, v in self.messages}


def a_hand(scale=1.0):
    """21 points on a diagonal, so every landmark differs from every other."""
    norm = np.linspace(0.1, 0.9, 63).reshape(21, 3)
    world = norm * scale
    return norm, world


def a_body():
    norm = np.linspace(0.0, 1.0, 99).reshape(33, 3)
    return norm, norm * 0.5, np.ones(33)


def out(recorder, **kw):
    return LandmarkOsc(recorder, **kw)


def test_absent_hands_still_report_themselves():
    r = Recorder()
    out(r).hands({})
    assert r.by_address()["/cv/hand/left/present"] == [0]
    assert r.by_address()["/cv/hand/right/present"] == [0]
    # Nothing else: silence would be indistinguishable from a crashed sender,
    # but a present=0 is not an excuse to send sixty-three zeroes.
    assert len(r.messages) == 2


def test_a_tracked_hand_sends_bulk_and_named():
    r = Recorder()
    norm, world = a_hand()
    out(r).hands({"left": (norm, world)})
    msgs = r.by_address()
    assert msgs["/cv/hand/left/present"] == [1]
    assert len(msgs["/cv/hand/left/norm"]) == 63
    assert len(msgs["/cv/hand/left/world"]) == 63
    for name in L.HAND_KEY_POINTS:
        assert len(msgs[f"/cv/hand/left/{name}"]) == 3
    assert msgs["/cv/hand/right/present"] == [0]


def test_named_points_carry_the_landmark_they_are_named_after():
    r = Recorder()
    norm, world = a_hand()
    out(r).hands({"right": (norm, world)})
    got = r.by_address()["/cv/hand/right/index_tip"]
    assert got == pytest.approx(norm[L.INDEX["hand"]["index_tip"]].tolist())


def test_named_space_switches_to_world():
    r = Recorder()
    norm, world = a_hand(scale=0.25)
    out(r, named_space="world").hands({"left": (norm, world)})
    got = r.by_address()["/cv/hand/left/index_tip"]
    assert got == pytest.approx(world[L.INDEX["hand"]["index_tip"]].tolist())


def test_pinch_is_measured_in_world_space_not_image_space():
    # The whole point of the metric landmarks: a pinch has to mean the same
    # thing across the room as it does up close, and image coordinates shrink
    # with distance while world coordinates do not.
    r = Recorder()
    norm, world = a_hand(scale=0.25)
    out(r).hands({"left": (norm, world)})
    idx = L.INDEX["hand"]
    expected = L.distance(world, idx["thumb_tip"], idx["index_tip"])
    assert r.by_address()["/cv/hand/left/pinch"][0] == pytest.approx(expected)
    assert expected != pytest.approx(L.distance(norm, idx["thumb_tip"], idx["index_tip"]))


def test_bulk_none_still_sends_named_points():
    r = Recorder()
    norm, world = a_hand()
    out(r, bulk="none").hands({"left": (norm, world)})
    msgs = r.by_address()
    assert "/cv/hand/left/norm" not in msgs
    assert "/cv/hand/left/world" not in msgs
    assert "/cv/hand/left/index_tip" in msgs


def test_named_off_still_sends_bulk():
    r = Recorder()
    norm, world = a_hand()
    out(r, named=False).hands({"left": (norm, world)})
    msgs = r.by_address()
    assert len(msgs["/cv/hand/left/world"]) == 63
    assert "/cv/hand/left/index_tip" not in msgs
    assert "/cv/hand/left/pinch" not in msgs


def test_prefix_is_applied_everywhere():
    r = Recorder()
    norm, world = a_hand()
    out(r, prefix="/room/1").hands({"left": (norm, world)})
    assert all(a.startswith("/room/1/") for a, _ in r.messages)


def test_a_body_sends_visibility_and_a_centre():
    r = Recorder()
    norm, world, vis = a_body()
    out(r).poses({0: (norm, world, vis)}, slots=1)
    msgs = r.by_address()
    assert len(msgs["/cv/pose/0/norm"]) == 99
    assert len(msgs["/cv/pose/0/visibility"]) == 33
    idx = L.INDEX["pose"]
    centre = (norm[idx["left_hip"]] + norm[idx["right_hip"]]) / 2
    assert msgs["/cv/pose/0/center"] == pytest.approx(centre.tolist())
    assert msgs["/cv/pose/0/hands_apart"][0] == pytest.approx(
        L.distance(world, idx["left_wrist"], idx["right_wrist"]))


def test_every_requested_body_slot_reports_even_when_empty():
    r = Recorder()
    norm, world, vis = a_body()
    out(r).poses({0: (norm, world, vis)}, slots=3)
    msgs = r.by_address()
    assert msgs["/cv/pose/0/present"] == [1]
    assert msgs["/cv/pose/1/present"] == [0]
    assert msgs["/cv/pose/2/present"] == [0]


def test_bad_options_are_refused_at_construction():
    with pytest.raises(ValueError):
        LandmarkOsc(Recorder(), bulk="everything")
    with pytest.raises(ValueError):
        LandmarkOsc(Recorder(), named_space="metres")


def test_summary_reports_frames_tracked_not_frames_asked_for():
    r = Recorder()
    norm, world = a_hand()
    o = out(r)
    o.hands({"left": (norm, world)})
    o.hands({})
    o.hands({})
    lines = "\n".join(o.summary(1.0))
    assert "hand/left" in lines and "1/3" in lines
    assert "hand/right" in lines and "0/3" in lines
