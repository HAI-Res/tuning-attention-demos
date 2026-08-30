import struct

import pytest

from attention_phone.osc import encode, parse_endpoint


def unpack(msg: bytes) -> tuple[str, str, tuple]:
    addr = msg.split(b"\0", 1)[0].decode()
    i = (len(addr) // 4 + 1) * 4
    tags = msg[i:].split(b"\0", 1)[0].decode()
    j = i + (len(tags) // 4 + 1) * 4
    nf = tags.count("f")
    return addr, tags, struct.unpack(">" + "f" * nf, msg[j : j + 4 * nf]) if nf else ()


def test_message_is_4_byte_aligned():
    # Every OSC part is NUL-padded to a 4-byte boundary; a receiver that
    # trusts the spec silently misreads anything else.
    for addr in ("/a", "/ab", "/abc", "/abcd", "/abcde"):
        assert len(encode(addr, 1.0)) % 4 == 0


def test_roundtrip_floats():
    addr, tags, vals = unpack(encode("/phone/ada/accel", 1.5, -2.25, 0.0))
    assert (addr, tags) == ("/phone/ada/accel", ",fff")
    assert vals == (1.5, -2.25, 0.0)


def test_address_must_be_absolute():
    with pytest.raises(ValueError):
        encode("phone/acc", 1.0)


def test_bool_is_rejected_not_silently_sent_as_int():
    # bool is an int subclass in Python, so without the explicit guard True
    # would encode as 1 and quietly change meaning.
    with pytest.raises(TypeError):
        encode("/a", True)


def test_int_and_float_get_different_tags():
    assert unpack(encode("/a", 1))[1] == ",i"
    assert unpack(encode("/a", 1.0))[1] == ",f"


@pytest.mark.parametrize(
    ("text", "expected"),
    [
        ("127.0.0.1:57120", ("127.0.0.1", 57120)),
        ("sc", ("127.0.0.1", 57120)),
        ("localhost:9000", ("localhost", 9000)),
        ("10.0.0.5", ("10.0.0.5", 57120)),
    ],
)
def test_parse_endpoint(text, expected):
    assert parse_endpoint(text) == expected
