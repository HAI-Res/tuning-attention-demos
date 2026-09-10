"""Landmark smoothing.

Raw per-frame landmarks jitter by a few pixels even when the subject is still.
On screen that reads as a constantly vibrating skeleton — the single most
uncomfortable thing about a naive tracking overlay. A one-euro filter kills the
jitter while staying responsive during real movement, which a plain exponential
average cannot do (it either lags or shakes).

Reference: Casiez, Roussel & Vogel, "1e Filter", CHI 2012.
"""

from __future__ import annotations

import math

import numpy as np


def _alpha(cutoff: float, dt: float) -> float:
    tau = 1.0 / (2.0 * math.pi * cutoff)
    return 1.0 / (1.0 + tau / dt)


class OneEuro:
    """One-euro filter over an array of values of fixed shape.

    ``min_cutoff`` sets how still a still subject looks (lower = steadier).
    ``beta`` sets how much the filter opens up during motion (higher = less lag
    when moving, at the cost of a little more jitter).
    """

    def __init__(self, min_cutoff: float = 1.2, beta: float = 0.4, d_cutoff: float = 1.0) -> None:
        self.min_cutoff = min_cutoff
        self.beta = beta
        self.d_cutoff = d_cutoff
        self._x: np.ndarray | None = None
        self._dx: np.ndarray | None = None
        self._t: float | None = None

    def reset(self) -> None:
        self._x = self._dx = self._t = None

    def __call__(self, x: np.ndarray, t: float) -> np.ndarray:
        x = np.asarray(x, dtype=np.float64)
        if self._x is None or self._t is None or x.shape != self._x.shape:
            self._x = x.copy()
            self._dx = np.zeros_like(x)
            self._t = t
            return x

        dt = t - self._t
        if dt <= 0:
            return self._x
        self._t = t

        dx = (x - self._x) / dt
        assert self._dx is not None
        a_d = _alpha(self.d_cutoff, dt)
        self._dx = a_d * dx + (1 - a_d) * self._dx

        cutoff = self.min_cutoff + self.beta * np.abs(self._dx)
        a = 1.0 / (1.0 + 1.0 / (2.0 * np.pi * np.maximum(cutoff, 1e-6) * dt))
        self._x = a * x + (1 - a) * self._x
        return self._x


class LandmarkSmoother:
    """One-euro filter applied to an (N, 3) landmark array, keyed by nothing.

    Tracking loss resets the filter so the skeleton does not sweep across the
    frame when a new person is picked up.
    """

    def __init__(self, min_cutoff: float = 1.2, beta: float = 0.4) -> None:
        self._filter = OneEuro(min_cutoff=min_cutoff, beta=beta)
        self._misses = 0

    def update(self, points: np.ndarray | None, t: float) -> np.ndarray | None:
        if points is None:
            self._misses += 1
            if self._misses > 3:
                self._filter.reset()
            return None
        self._misses = 0
        return self._filter(points, t)
