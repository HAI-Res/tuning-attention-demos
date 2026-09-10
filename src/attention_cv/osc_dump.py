"""Print what is actually arriving on an OSC port.

    uv run osc-dump                 # listen on 7500, summarise every 2s
    uv run osc-dump 57120 --raw     # every message, verbatim

UDP has no notion of a peer that is not there, so a wrong port, a wrong address
and a firewall all look identical from the sending end: silence. This answers
"is anything arriving, and under what address" without opening Max, which is
the first question every time a mapping is quiet and the slowest one to answer
inside a patcher.

The summary is deliberately slow and averaged rather than per-message. A
readout that changes at 30 Hz is unreadable, and flicker at that rate is a
migraine and vestibular trigger for some people.
"""

from __future__ import annotations

import argparse
import socket
import time
from collections import Counter

from .osc import decode


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="osc-dump",
        description="Listen on a UDP port and report the OSC arriving on it.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("port", nargs="?", type=int, default=7500)
    p.add_argument("--host", default="0.0.0.0",
                   help="0.0.0.0 also hears senders on other machines")
    p.add_argument("--every", type=float, default=2.0,
                   help="seconds between summaries")
    p.add_argument("--raw", action="store_true",
                   help="print every message instead of summarising")
    p.add_argument("--seconds", type=float, default=None, help="stop after this long")
    return p


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try:
        sock.bind((args.host, args.port))
    except OSError as e:
        raise SystemExit(
            f"cannot bind UDP {args.host}:{args.port}: {e}\n"
            f"  something else already has it — lsof -nP -iUDP:{args.port}"
        ) from None
    sock.settimeout(0.25)
    print(f"listening on UDP {args.host}:{args.port}   (ctrl-c to stop)")

    counts: Counter[str] = Counter()
    last: dict[str, list] = {}
    total = 0
    bad = 0
    t0 = last_report = time.perf_counter()
    try:
        while True:
            now = time.perf_counter()
            if args.seconds is not None and now - t0 >= args.seconds:
                break
            try:
                packet, _peer = sock.recvfrom(65535)
            except TimeoutError:
                packet = None
            except OSError:
                break
            if packet is not None:
                try:
                    address, values = decode(packet)
                except (ValueError, IndexError, KeyError):
                    bad += 1
                else:
                    total += 1
                    counts[address] += 1
                    last[address] = values
                    if args.raw:
                        shown = ", ".join(
                            f"{v:.4f}" if isinstance(v, float) else str(v)
                            for v in values[:8]
                        )
                        more = f" ...+{len(values) - 8}" if len(values) > 8 else ""
                        print(f"{address}  [{len(values)}]  {shown}{more}")
            if not args.raw and now - last_report >= args.every:
                span = now - last_report
                last_report = now
                print(f"\n-- {total} msg total, {len(counts)} address(es), "
                      f"{bad} undecodable --")
                for address in sorted(counts):
                    values = last[address]
                    head = ", ".join(
                        f"{v:+.3f}" if isinstance(v, float) else str(v)
                        for v in values[:4]
                    )
                    more = f" ...+{len(values) - 4}" if len(values) > 4 else ""
                    print(f"  {counts[address] / span:6.1f} Hz  "
                          f"{address:34s} [{len(values):2d}]  {head}{more}")
                counts.clear()
    except KeyboardInterrupt:
        pass
    finally:
        sock.close()
    print(f"\n{total} message(s) in {time.perf_counter() - t0:.1f}s"
          + (f", {bad} undecodable" if bad else ""))
    if not total:
        print("nothing arrived. In order of how often it is the cause:\n"
              "  1. the sender is pointing at a different port\n"
              "  2. the sender is pointing at a different address "
              "(127.0.0.1 vs the LAN one)\n"
              "  3. a firewall, or wifi client isolation between the two machines")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
