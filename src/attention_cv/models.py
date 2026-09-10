"""Registry and downloader for MediaPipe Tasks model bundles.

MediaPipe 1.0 removed the old ``mp.solutions`` API, so every task now needs an
explicit ``.task`` bundle on disk. These live in ``models/`` (gitignored) and are
fetched with ``uv run fetch-models``.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import urllib.request
from dataclasses import dataclass
from pathlib import Path

BASE = "https://storage.googleapis.com/mediapipe-models"

# Repo root, i.e. the directory holding pyproject.toml.
ROOT = Path(__file__).resolve().parents[2]
MODEL_DIR = ROOT / "models"


@dataclass(frozen=True)
class Model:
    name: str
    url: str
    note: str

    @property
    def path(self) -> Path:
        return MODEL_DIR / f"{self.name}.task"


def _m(name: str, task: str, variant: str, note: str) -> Model:
    return Model(name, f"{BASE}/{task}/{variant}/float16/latest/{variant}.task", note)


MODELS: dict[str, Model] = {
    m.name: m
    for m in (
        _m("pose_landmarker_lite", "pose_landmarker", "pose_landmarker_lite",
           "33 body points, fastest — the default for live camera work"),
        _m("pose_landmarker_full", "pose_landmarker", "pose_landmarker_full",
           "33 body points, better accuracy, ~2x the cost"),
        _m("pose_landmarker_heavy", "pose_landmarker", "pose_landmarker_heavy",
           "33 body points, best accuracy, offline / recorded video"),
        _m("hand_landmarker", "hand_landmarker", "hand_landmarker",
           "21 points per hand, up to 2 hands"),
        _m("face_landmarker", "face_landmarker", "face_landmarker",
           "478 face points + blendshapes"),
        _m("holistic_landmarker", "holistic_landmarker", "holistic_landmarker",
           "body + hands + face in one graph"),
    )
}

# Fetched by default; the heavy pose model is opt-in.
DEFAULT = ["pose_landmarker_lite", "pose_landmarker_full", "hand_landmarker", "face_landmarker"]


def fetch(model: Model, *, force: bool = False) -> Path:
    """Download ``model`` into ``models/`` unless it is already there."""
    MODEL_DIR.mkdir(parents=True, exist_ok=True)
    if model.path.exists() and not force:
        size = model.path.stat().st_size / 1e6
        print(f"  have  {model.name:24s} {size:6.1f} MB")
        return model.path

    tmp = model.path.with_suffix(".part")
    print(f"  get   {model.name:24s} ... ", end="", flush=True)
    with urllib.request.urlopen(model.url) as r, tmp.open("wb") as f:
        shutil.copyfileobj(r, f)
    tmp.replace(model.path)
    print(f"{model.path.stat().st_size / 1e6:.1f} MB")
    return model.path


def require(name: str) -> Path:
    """Path to a model bundle, with a useful error if it has not been fetched."""
    try:
        model = MODELS[name]
    except KeyError:
        raise SystemExit(f"unknown model {name!r}; known: {', '.join(MODELS)}") from None
    if not model.path.exists():
        raise SystemExit(
            f"model {name!r} is not downloaded yet.\n"
            f"  run: uv run fetch-models {name}"
        )
    return model.path


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="Download MediaPipe model bundles into models/.")
    p.add_argument("names", nargs="*", help="models to fetch (default: the common set)")
    p.add_argument("--all", action="store_true", help="fetch every known model")
    p.add_argument("--force", action="store_true", help="re-download even if present")
    p.add_argument("--list", action="store_true", help="list known models and exit")
    args = p.parse_args(argv)

    if args.list:
        for m in MODELS.values():
            mark = "*" if m.path.exists() else " "
            print(f" {mark} {m.name:24s} {m.note}")
        print("\n * = already downloaded")
        return 0

    names = list(MODELS) if args.all else (args.names or DEFAULT)
    print(f"models -> {MODEL_DIR}")
    for name in names:
        if name not in MODELS:
            print(f"  skip  {name}: unknown (see --list)", file=sys.stderr)
            continue
        fetch(MODELS[name], force=args.force)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
