"""Live body-tracking demo.

    uv run pose-demo                 # 30 fps, calm theme, smoothing on
    uv run pose-demo --fps 24 --theme mono
    uv run pose-demo --list-cameras

Keys while running: q / Esc quit, s toggle smoothing, h toggle the HUD,
d cycle dimming, t cycle theme, SPACE freeze the overlay.

This is ``track-demo --track pose`` under its original name. The two used to be
separate loops; there is no version of "read the camera, run a landmarker at a
fixed rate, draw it" that is worth maintaining twice, and every fix to one was
a fix owed to the other. Every ``track-demo`` flag works here too — including
``--osc`` and ``--track hands``, which is the same program.
"""

from __future__ import annotations

import sys

from .track_demo import main as _track_main


def main(argv: list[str] | None = None) -> int:
    argv = sys.argv[1:] if argv is None else argv
    # Prepended, not appended, so an explicit --track on the command line still
    # wins: argparse keeps the last occurrence.
    return _track_main(["--track", "pose", *argv])


if __name__ == "__main__":
    raise SystemExit(main())
