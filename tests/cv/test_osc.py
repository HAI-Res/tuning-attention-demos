import pytest

from attention_cv.osc import decode, encode, parse_endpoint


def test_round_trip_of_every_supported_type():
    address, args = decode(encode("/cv/hand/left/wrist", 1.5, 2, "ada", b"\x01\x02\x03"))
    assert address == "/cv/hand/left/wrist"
    assert args[0] == pytest.approx(1.5)
    assert args[1] == 2
    assert args[2] == "ada"
    assert args[3] == b"\x01\x02\x03"


def test_a_whole_hand_fits_in_one_packet():
    values = [i / 100 for i in range(63)]
    packet = encode("/cv/hand/left/world", *values)
    assert len(packet) < 1400, "must stay under a normal MTU"
    _, back = decode(packet)
    assert back == pytest.approx(values, abs=1e-6)


def test_a_whole_body_fits_in_one_packet():
    packet = encode("/cv/pose/0/world", *[0.5] * 99)
    assert len(packet) < 1400
    assert len(decode(packet)[1]) == 99


def test_every_part_is_four_byte_aligned():
    # Max's udpreceive drops a misaligned packet silently rather than
    # complaining, which is a miserable thing to debug.
    for args in [(), (1.0,), ("a",), ("abcd",), ("abcde",), (b"\x00",)]:
        assert len(encode("/a", *args)) % 4 == 0


def test_bool_is_refused_rather_than_sent_as_a_number():
    with pytest.raises(TypeError):
        encode("/cv/hand/left/present", True)


def test_address_must_be_a_path():
    with pytest.raises(ValueError):
        encode("cv/hand", 1.0)


def test_decode_rejects_a_bundle():
    with pytest.raises(ValueError):
        decode(b"#bundle\x00" + b"\x00" * 8)


def test_endpoint_shorthands():
    assert parse_endpoint("max") == ("127.0.0.1", 7400)
    assert parse_endpoint("sc") == ("127.0.0.1", 57120)
    assert parse_endpoint("10.0.0.5:9000") == ("10.0.0.5", 9000)
    assert parse_endpoint("10.0.0.5") == ("10.0.0.5", 7400)
