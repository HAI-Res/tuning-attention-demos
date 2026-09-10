"""A small OSC 1.0 codec, so Max / SuperCollider / Pd work with no dependency.

Deliberately the same encoder as ``attention-phone``'s ``osc.py``, so both
halves of the class put identical bytes on the wire and one Max patch can read
either. Only the four types that matter here are handled (float, int, string,
blob), and there are no bundles.

Unlike the phone side there is a ``decode`` here as well. It exists for
``uv run osc-dump``, which answers "is anything actually arriving, and under
what address" without opening Max — the first question every time a mapping is
silent, and one you do not want to have to answer inside a patcher.
"""

from __future__ import annotations

import socket
import struct
from collections.abc import Sequence


def _pad(n: int) -> int:
    return (4 - n % 4) % 4


def _osc_string(s: str) -> bytes:
    b = s.encode("utf-8") + b"\0"
    return b + b"\0" * _pad(len(b))


def encode(address: str, *args: float | int | str | bytes) -> bytes:
    if not address.startswith("/"):
        raise ValueError(f"OSC address must start with '/': {address!r}")
    tags = ","
    body = b""
    for a in args:
        # bool is a subclass of int, and silently sending True as 1 hides a
        # mistake at the call site rather than fixing it.
        if isinstance(a, bool):
            raise TypeError("OSC 1.0 has no bool type here; send 0/1")
        if isinstance(a, int):
            tags += "i"
            body += struct.pack(">i", a)
        elif isinstance(a, float):
            tags += "f"
            body += struct.pack(">f", a)
        elif isinstance(a, str):
            tags += "s"
            body += _osc_string(a)
        elif isinstance(a, (bytes, bytearray)):
            tags += "b"
            body += struct.pack(">i", len(a)) + bytes(a) + b"\0" * _pad(len(a))
        else:
            raise TypeError(f"cannot encode {type(a).__name__} as OSC")
    return _osc_string(address) + _osc_string(tags) + body


def _read_string(data: bytes, i: int) -> tuple[str, int]:
    end = data.index(b"\0", i)
    s = data[i:end].decode("utf-8")
    return s, end + 1 + _pad(end + 1 - i)


def decode(packet: bytes) -> tuple[str, list[float | int | str | bytes]]:
    """``bytes`` -> ``(address, args)``. Raises ``ValueError`` on anything else."""
    if packet[:1] != b"/":
        raise ValueError("not an OSC message (bundles are not supported)")
    address, i = _read_string(packet, 0)
    tags, i = _read_string(packet, i)
    if not tags.startswith(","):
        raise ValueError(f"bad type tag string {tags!r}")
    args: list[float | int | str | bytes] = []
    for t in tags[1:]:
        if t == "i":
            args.append(struct.unpack_from(">i", packet, i)[0])
            i += 4
        elif t == "f":
            args.append(struct.unpack_from(">f", packet, i)[0])
            i += 4
        elif t == "s":
            s, i = _read_string(packet, i)
            args.append(s)
        elif t == "b":
            (n,) = struct.unpack_from(">i", packet, i)
            i += 4
            args.append(packet[i : i + n])
            i += n + _pad(n)
        else:
            raise ValueError(f"unsupported OSC type tag {t!r}")
    return address, args


class OscSender:
    """Fire-and-forget UDP. Never blocks and never raises at the call site.

    A camera loop has a 33 ms budget and a receiver that has gone away must not
    be able to spend it. Failures are counted and reported at exit instead.
    """

    def __init__(self, host: str, port: int) -> None:
        self.addr = (host, port)
        self._sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self._sock.setblocking(False)
        self.sent = 0
        self.errors = 0

    def send(self, address: str, *args: float | int | str | bytes) -> None:
        try:
            self._sock.sendto(encode(address, *args), self.addr)
            self.sent += 1
        except OSError:
            self.errors += 1

    def send_vector(self, address: str, values: Sequence[float]) -> None:
        self.send(address, *(float(v) for v in values))

    def close(self) -> None:
        self._sock.close()


def parse_endpoint(text: str, default_port: int = 7500) -> tuple[str, int]:
    """``"127.0.0.1:7500"`` or a shorthand -> ``(host, port)``.

    7500 rather than 7400, which is the *phone* receiver's port in
    ``attention-phone``. One UDP port takes one receiver, so sharing 7400 would
    mean a camera and a room of phones could never be running at the same time.
    ``--osc 127.0.0.1:7400`` still sends into the phone patch on purpose.

    57120 is SuperCollider's language port — and on this machine ``ollama``
    also binds it, which is worth knowing before blaming a patch.
    """
    if text in ("max",):
        return ("127.0.0.1", 7500)
    if text in ("sc", "supercollider"):
        return ("127.0.0.1", 57120)
    if ":" in text:
        host, _, port = text.rpartition(":")
        return (host or "127.0.0.1", int(port))
    return (text, default_port)
