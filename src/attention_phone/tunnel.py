"""A public HTTPS URL via cloudflared, for when the LAN path is blocked.

Needed when the class wifi has **client isolation** — phones can reach the
internet but not each other or a laptop on the same SSID.  Nothing on the
laptop can fix that, because the packets never arrive.  A tunnel sidesteps it:
both the phone and the laptop make *outbound* connections to Cloudflare, which
every network allows.

`cloudflared tunnel --url` with no account creates a "quick tunnel": free, no
login, and the hostname is random and lasts only as long as the process.  That
randomness is why the QR code matters — nobody is typing
`https://polite-mango-vast-idea.trycloudflare.com` correctly on a phone.

Install with `brew install cloudflared`.  The cost of this path is a hard
dependency on the internet and on Cloudflare being up, and a round trip
through their edge — expect 30–80 ms more latency than the LAN.
"""

from __future__ import annotations

import asyncio
import logging
import re
import shutil

log = logging.getLogger(__name__)

_URL_RE = re.compile(r"https://[a-z0-9-]+\.trycloudflare\.com")


class TunnelUnavailable(RuntimeError):
    pass


class QuickTunnel:
    def __init__(self, local_port: int) -> None:
        self.local_port = local_port
        self.url: str | None = None
        self._proc: asyncio.subprocess.Process | None = None
        self._reader: asyncio.Task[None] | None = None

    async def start(self, timeout: float = 25.0) -> str:
        exe = shutil.which("cloudflared")
        if exe is None:
            raise TunnelUnavailable(
                "cloudflared is not installed. `brew install cloudflared`, "
                "or run without --tunnel to use the LAN."
            )
        self._proc = await asyncio.create_subprocess_exec(
            exe, "tunnel", "--url", f"http://127.0.0.1:{self.local_port}",
            "--no-autoupdate",
            stdout=asyncio.subprocess.DEVNULL,
            stderr=asyncio.subprocess.PIPE,
        )
        found: asyncio.Future[str] = asyncio.get_running_loop().create_future()

        async def read_stderr() -> None:
            assert self._proc and self._proc.stderr
            async for raw in self._proc.stderr:
                line = raw.decode("utf-8", "replace")
                if not found.done() and (m := _URL_RE.search(line)):
                    found.set_result(m.group(0))
                log.debug("cloudflared: %s", line.rstrip())

        self._reader = asyncio.create_task(read_stderr())
        try:
            self.url = await asyncio.wait_for(found, timeout)
        except TimeoutError:
            await self.stop()
            raise TunnelUnavailable(
                f"cloudflared did not report a URL within {timeout:.0f}s. "
                "Re-run with --verbose to see its output."
            ) from None
        return self.url

    async def stop(self) -> None:
        if self._reader:
            self._reader.cancel()
        if self._proc and self._proc.returncode is None:
            self._proc.terminate()
            try:
                await asyncio.wait_for(self._proc.wait(), 5.0)
            except TimeoutError:
                self._proc.kill()
