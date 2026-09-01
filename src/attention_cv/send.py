"""Landmarks onto OSC.

Twenty-one points per hand and thirty-three per body is a lot of numbers, and
there are two reasonable things to want from them. So both go out:

* **bulk** — every landmark of one hand or body flattened into a single
  message, ``x y z x y z ...``. Nothing is lost, and one message per frame per
  subject keeps the packet count sane.
* **named** — one message per interesting point, addressed by its anatomical
  name, plus a couple of derived scalars. This is what a mapping actually
  reaches for, and it means the Max side is ``[route index_tip]`` rather than
  unpacking element 24 of a 63-float list and hoping.

The split matters because unpacking a flat list in Max is genuinely unpleasant,
and because most mappings want four or five points, not sixty-three.

Address layout, with the default ``/cv`` prefix::

    /cv/hand/left/present      i   1 while the hand is tracked, 0 the frame it goes
    /cv/hand/left/norm        63f  21 points, image space
    /cv/hand/left/world       63f  21 points, metres
    /cv/hand/left/index_tip    3f  one named point
    /cv/hand/left/pinch        1f  thumb tip to index tip, metres
    /cv/hand/left/spread       1f  index tip to pinky tip, metres

    /cv/pose/0/present         i
    /cv/pose/0/norm           99f  33 points, image space
    /cv/pose/0/world          99f  33 points, metres
    /cv/pose/0/visibility     33f  per-point confidence
    /cv/pose/0/right_wrist     3f
    /cv/pose/0/center          3f  hip midpoint, image space
    /cv/pose/0/hands_apart     1f  wrist to wrist, metres

Named points carry **image space** by default (``--named-space world`` swaps
it), because "where is this in the frame" is the usual question of a single
point. The derived scalars are always **metres**, because a pinch has to mean
the same thing at the back of the room as it does at the front, and only the
world landmarks are scale-independent.

``present`` is sent every frame for every side and body slot, whether or not
anything was found. A channel that is off, a subject who left, and a crashed
sender otherwise all look the same downstream — silence — and telling them
apart at 2am is worth one integer per frame.
"""

from __future__ import annotations

from collections import Counter

import numpy as np

from . import landmarks as L
from .osc import OscSender

SIDES = ("left", "right")


class LandmarkOsc:
    """Turns landmarker results into OSC messages on a fixed address layout."""

    def __init__(
        self,
        sender: OscSender,
        *,
        prefix: str = "/cv",
        bulk: str = "both",
        named: bool = True,
        named_space: str = "norm",
    ) -> None:
        if bulk not in ("both", "norm", "world", "none"):
            raise ValueError(f"bulk must be both/norm/world/none, not {bulk!r}")
        if named_space not in ("norm", "world"):
            raise ValueError(f"named_space must be norm or world, not {named_space!r}")
        self.osc = sender
        self.prefix = prefix.rstrip("/")
        self.bulk = bulk
        self.named = named
        self.named_space = named_space
        # Per-address message counts, for the honest summary at exit: which
        # channels actually carried data and which stayed at zero.
        self.counts: Counter[str] = Counter()

    def _send(self, address: str, *args: float | int) -> None:
        self.osc.send(address, *args)
        self.counts[address] += 1

    def _vector(self, address: str, values) -> None:
        self.osc.send_vector(address, values)
        self.counts[address] += 1

    def _spaces(self, norm: np.ndarray, world: np.ndarray) -> list[tuple[str, np.ndarray]]:
        want = ("norm", "world") if self.bulk == "both" else (
            () if self.bulk == "none" else (self.bulk,)
        )
        return [(n, {"norm": norm, "world": world}[n]) for n in want]

    # --- hands -------------------------------------------------------------

    def hands(self, tracked: dict[str, tuple[np.ndarray, np.ndarray]]) -> None:
        """``tracked`` maps ``"left"``/``"right"`` to ``(norm, world)`` arrays.

        A side missing from the dict is reported absent rather than skipped.
        """
        for side in SIDES:
            base = f"{self.prefix}/hand/{side}"
            found = tracked.get(side)
            self._send(f"{base}/present", 1 if found is not None else 0)
            if found is None:
                continue
            norm, world = found

            for name, points in self._spaces(norm, world):
                self._vector(f"{base}/{name}", points.reshape(-1))

            if not self.named:
                continue
            points = norm if self.named_space == "norm" else world
            for name in L.HAND_KEY_POINTS:
                self._vector(f"{base}/{name}", points[L.INDEX["hand"][name]])

            idx = L.INDEX["hand"]
            self._send(f"{base}/pinch",
                       L.distance(world, idx["thumb_tip"], idx["index_tip"]))
            self._send(f"{base}/spread",
                       L.distance(world, idx["index_tip"], idx["pinky_tip"]))

    # --- bodies ------------------------------------------------------------

    def poses(
        self,
        tracked: dict[int, tuple[np.ndarray, np.ndarray, np.ndarray]],
        slots: int,
    ) -> None:
        """``tracked`` maps a body slot to ``(norm, world, visibility)``."""
        for i in range(slots):
            base = f"{self.prefix}/pose/{i}"
            found = tracked.get(i)
            self._send(f"{base}/present", 1 if found is not None else 0)
            if found is None:
                continue
            norm, world, visibility = found

            for name, points in self._spaces(norm, world):
                self._vector(f"{base}/{name}", points.reshape(-1))
            if self.bulk != "none":
                self._vector(f"{base}/visibility", visibility)

            if not self.named:
                continue
            points = norm if self.named_space == "norm" else world
            for name in L.POSE_KEY_POINTS:
                self._vector(f"{base}/{name}", points[L.INDEX["pose"][name]])

            idx = L.INDEX["pose"]
            # The hip midpoint is the most stable single "where is this person"
            # point there is: it barely moves when the arms do, and unlike the
            # nose it does not vanish when someone turns around.
            centre = (norm[idx["left_hip"]] + norm[idx["right_hip"]]) / 2.0
            self._vector(f"{base}/center", centre)
            self._send(f"{base}/hands_apart",
                       L.distance(world, idx["left_wrist"], idx["right_wrist"]))

    # --- reporting ---------------------------------------------------------

    def summary(self, elapsed: float) -> list[str]:
        """Lines describing what actually went out, for printing at exit."""
        if not self.counts:
            return ["osc: nothing sent"]
        lines = [
            f"osc: {self.osc.sent} messages to "
            f"{self.osc.addr[0]}:{self.osc.addr[1]} in {elapsed:.1f}s "
            f"({self.osc.sent / elapsed:.0f}/s)"
        ]
        if self.osc.errors:
            lines.append(f"     {self.osc.errors} send error(s) — "
                         "wrong address, or nothing bound to that port")
        # Which subjects were actually seen, rather than which were asked for.
        for address, n in sorted(self.counts.items()):
            if address.endswith("/present"):
                subject = address[len(self.prefix) + 1 : -len("/present")]
                seen = self.counts.get(f"{self.prefix}/{subject}/pinch",
                                       self.counts.get(f"{self.prefix}/{subject}/center", 0))
                lines.append(f"     {subject:16s} tracked in {seen}/{n} frames")
        return lines
