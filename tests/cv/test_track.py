import inspect

import pytest

from attention_cv.track_demo import parse_tracks, side_of


def test_track_list_parsing():
    assert parse_tracks("hands") == ["hands"]
    assert parse_tracks("hands,pose") == ["hands", "pose"]
    assert parse_tracks(" pose , hands ") == ["pose", "hands"]


def test_track_list_rejects_nonsense_rather_than_silently_tracking_nothing():
    for bad in ("", "face", "hands,face", ","):
        with pytest.raises(SystemExit):
            parse_tracks(bad)


def test_the_label_is_used_as_it_comes_in_both_views():
    # Measured against the pose model's own left/right wrist on the same photo,
    # as-shot and flipped: MediaPipe gets handedness anatomically right either
    # way. Swapping it for an unmirrored image — the advice you find everywhere
    # — is what puts every mapping on the wrong hand. See side_of's docstring.
    assert side_of("Left") == "left"
    assert side_of("Right") == "right"


def test_mirroring_is_not_part_of_this_decision():
    # Guards against the fix being quietly reverted: there is no mirror
    # argument, so no caller can reintroduce the swap by passing one.
    assert "mirrored" not in inspect.signature(side_of).parameters


def test_swap_flag_is_the_manual_escape_hatch():
    assert side_of("Left", swap=True) == "right"
    assert side_of("Right", swap=True) == "left"


def test_an_unexpected_label_does_not_crash_the_frame():
    assert side_of("") in ("left", "right")
    assert side_of("Unknown") in ("left", "right")
