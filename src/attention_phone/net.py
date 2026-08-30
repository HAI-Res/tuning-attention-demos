"""Working out which of this laptop's addresses a phone can actually reach.

This is the single most common way the demo fails, and the failure is silent:
you print a URL, students type it, nothing connects, and the room waits.

The usual one-liner — open a UDP socket to 8.8.8.8 and read back the local
address — returns the address on whatever interface holds the **default
route**.  With the MIT VPN connected that is the tunnel (`utun4`, an 18.x
address), and a phone on the room's wifi has no path to it at all.  So this
module enumerates every interface instead and ranks them by whether a phone
on the same wifi could plausibly reach them.
"""

from __future__ import annotations

import ipaddress
import re
import subprocess
import sys
from dataclasses import dataclass

#: Interface name prefixes that are never the answer: VPN tunnels, Apple's
#: peer-to-peer/AWDL links, Thunderbolt bridges, and virtualisation bridges.
_SKIP_PREFIXES = ("lo", "utun", "tun", "tap", "ppp", "ipsec", "awdl", "llw", "bridge", "vmnet", "docker", "gif", "stf", "anpi", "ap")


@dataclass(frozen=True, slots=True)
class Address:
    iface: str
    ip: str
    private: bool
    point_to_point: bool

    @property
    def score(self) -> int:
        """Higher is a better guess for "the address phones should use"."""
        s = 0
        if self.private:
            s += 100  # a phone on the same wifi is almost always in RFC1918
        if not self.point_to_point:
            s += 50  # p2p interfaces are tunnels wearing a normal name
        if self.iface.startswith("en"):
            s += 10  # real wifi/ethernet on macOS
        return s


def _ifconfig() -> list[Address]:
    out = subprocess.run(["ifconfig", "-a"], capture_output=True, text=True, check=False).stdout
    found: list[Address] = []
    iface = ""
    for line in out.splitlines():
        if line and not line[0].isspace():
            iface = line.split(":", 1)[0]
            continue
        m = re.match(r"\s+inet (\d+\.\d+\.\d+\.\d+)(.*)", line)
        if not m or not iface:
            continue
        ip, rest = m.group(1), m.group(2)
        addr = ipaddress.ip_address(ip)
        if addr.is_loopback:
            continue
        found.append(
            Address(iface, ip, addr.is_private, "-->" in rest or "peer" in rest)
        )
    return found


def _ip_addr() -> list[Address]:
    out = subprocess.run(
        ["ip", "-o", "-4", "addr", "show"], capture_output=True, text=True, check=False
    ).stdout
    found: list[Address] = []
    for line in out.splitlines():
        parts = line.split()
        if len(parts) < 4 or parts[2] != "inet":
            continue
        iface, ip = parts[1], parts[3].split("/")[0]
        addr = ipaddress.ip_address(ip)
        if addr.is_loopback:
            continue
        found.append(Address(iface, ip, addr.is_private, "POINTOPOINT" in line))
    return found


def candidates() -> list[Address]:
    """Every reachable-looking IPv4 address, best guess first."""
    raw = _ifconfig() if sys.platform == "darwin" else _ip_addr()
    usable = [a for a in raw if not a.iface.startswith(_SKIP_PREFIXES)]
    # If filtering left nothing (unusual naming), fall back to the raw list
    # rather than claiming this machine has no address.
    return sorted(usable or raw, key=lambda a: -a.score)


def best() -> str:
    c = candidates()
    return c[0].ip if c else "127.0.0.1"


def describe() -> str:
    """A human-readable list for the startup banner, so a wrong pick is
    visible immediately instead of after five minutes of confusion."""
    lines = []
    for i, a in enumerate(candidates()):
        kind = "private" if a.private else "PUBLIC"
        p2p = ", point-to-point (VPN?)" if a.point_to_point else ""
        mark = "→" if i == 0 else " "
        lines.append(f"  {mark} {a.ip:<16} {a.iface:<8} {kind}{p2p}")
    return "\n".join(lines) or "  (no non-loopback IPv4 address found)"
