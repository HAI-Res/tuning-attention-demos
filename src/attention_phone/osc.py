"""A 60-line OSC 1.0 encoder, so SuperCollider / Max / Pd work with no dependency.

Only the four types that matter here (float, int, string, blob) are encoded.
There is no receiver and no bundle support: this direction is the only one
needed, and `python-osc` would be a whole dependency for one struct.pack.
"""

from __future__ import annotations

import socket
import struct
from collections.abc import Sequence


def _osc_string(s: str) -> bytes:
    b = s.encode("utf-8") + b"\0"
    return b + b"\0" * ((4 - len(b) % 4) % 4)


def encode(address: str, *args: float | int | str | bytes) -> bytes:
    if not address.startswith("/"):
        raise ValueError(f"OSC address must start with '/': {address!r}")
    tags = ","
    body = b""
    for a in args:
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
            body += struct.pack(">i", len(a)) + bytes(a) + b"\0" * ((4 - len(a) % 4) % 4)
        else:
            raise TypeError(f"cannot encode {type(a).__name__} as OSC")
    return _osc_string(address) + _osc_string(tags) + body


class OscSender:
    """Fire-and-forget UDP. Never blocks and never raises at the call site —
    a dead receiver must not stall the socket that phones are talking to."""

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


def parse_endpoint(text: str, default_port: int = 57120) -> tuple[str, int]:
    """``"127.0.0.1:57120"`` / ``"sc"``-style shorthand → (host, port).

    57120 is SuperCollider's default language port; Max and Pd have no default,
    so those get typed out in full.
    """
    if text in ("sc", "supercollider"):
        return ("127.0.0.1", 57120)
    if ":" in text:
        host, _, port = text.rpartition(":")
        return (host or "127.0.0.1", int(port))
    return (text, default_port)
