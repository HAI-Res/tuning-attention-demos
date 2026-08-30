"""HTTPS for a laptop on a class wifi, with nothing to install on the phones.

`DeviceMotionEvent.requestPermission()` only exists in a **secure context**,
so the sender page has to be served over HTTPS.  On a LAN that normally means
a self-signed certificate and 20 students tapping through a full-page
"This Connection Is Not Private" warning, which is both slow and a bad thing
to teach.

`local-ip.sh` solves it: `10-0-0-184.local-ip.sh` resolves (over public DNS)
to `10.0.0.184`, and the project publishes a real Let's Encrypt wildcard
certificate for `*.local-ip.sh` together with its private key.  Because the
name matches and the issuer is trusted, iOS and Android accept it with no
warning and no profile install.

The trade, stated plainly: **that private key is public**, so this TLS
authenticates nothing and protects against nobody.  It buys the "secure
context" bit that the motion API demands, not confidentiality.  Fine for
accelerometer data in a classroom; never use this pattern for anything real.

Two things can still break it, both handled by falling back to a tunnel
(`--tunnel`, see the README):
  * a resolver with DNS-rebinding protection refuses answers pointing at
    private address space, so the name will not resolve at all;
  * a wifi network with client isolation blocks phone→laptop entirely.
"""

from __future__ import annotations

import argparse
import datetime as dt
import socket
import ssl
import sys
import urllib.request
from pathlib import Path

from . import net

CERT_URL = "https://local-ip.sh/server.pem"
KEY_URL = "https://local-ip.sh/server.key"
CACHE = Path(__file__).resolve().parent.parent.parent / "certs"
RENEW_WITHIN = dt.timedelta(days=7)


def hostname_for(ip: str) -> str:
    """``10.0.0.184`` → ``10-0-0-184.local-ip.sh``."""
    return ip.replace(".", "-") + ".local-ip.sh"


def _expiry(pem: Path) -> dt.datetime | None:
    try:
        text = pem.read_bytes()
    except OSError:
        return None
    try:
        # ssl can parse a PEM without a full x509 library.
        info = ssl._ssl._test_decode_cert(str(pem))  # type: ignore[attr-defined]
    except Exception:
        return None
    if not (na := info.get("notAfter")):
        return None
    del text
    return dt.datetime.strptime(na, "%b %d %H:%M:%S %Y %Z").replace(tzinfo=dt.UTC)


def ensure(directory: Path = CACHE, *, refresh: bool = False) -> tuple[Path, Path]:
    """Return (cert, key), downloading them if missing or near expiry.

    The wildcard is reissued every ~90 days, so a cached copy goes stale
    mid-semester; this checks rather than trusting the file's presence.
    """
    directory.mkdir(parents=True, exist_ok=True)
    cert, key = directory / "server.pem", directory / "server.key"
    fresh = not refresh and cert.exists() and key.exists()
    if fresh:
        exp = _expiry(cert)
        if exp is None or exp - dt.datetime.now(dt.UTC) < RENEW_WITHIN:
            fresh = False
    if not fresh:
        for url, path in ((CERT_URL, cert), (KEY_URL, key)):
            with urllib.request.urlopen(url, timeout=15) as r:  # noqa: S310
                path.write_bytes(r.read())
        key.chmod(0o600)
    return cert, key


def ssl_context(directory: Path = CACHE, *, refresh: bool = False) -> ssl.SSLContext:
    cert, key = ensure(directory, refresh=refresh)
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ctx.load_cert_chain(cert, key)
    return ctx


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="Fetch/inspect the *.local-ip.sh certificate.")
    ap.add_argument("--refresh", action="store_true", help="re-download even if cached")
    ap.add_argument("--dir", type=Path, default=CACHE)
    a = ap.parse_args(argv)

    cert, key = ensure(a.dir, refresh=a.refresh)
    exp = _expiry(cert)
    ip = net.best()
    print(f"cert   {cert}")
    print(f"key    {key}")
    print(f"expires{'':2}{exp.isoformat() if exp else 'unknown'}")
    print("addresses:")
    print(net.describe())
    print(f"lan ip {ip}")
    print(f"host   {hostname_for(ip)}")
    resolved = None
    try:
        resolved = socket.gethostbyname(hostname_for(ip))
    except OSError as e:
        print(f"DNS    FAILED ({e}) — this network blocks it; use --tunnel", file=sys.stderr)
    if resolved:
        ok = "ok" if resolved == ip else f"MISMATCH (got {resolved})"
        print(f"DNS    {ok}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
