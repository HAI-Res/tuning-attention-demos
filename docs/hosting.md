# Hosting the receiver

Decided and stood up 2026-09-10: **one receiver for the class, on a CSAIL
OpenStack VM, and each student's Max pulls its own phones back down.**

| | |
| --- | --- |
| URL | `https://ductus-web-app.csail.mit.edu/` — `/health` shows live phones and rooms |
| VM | `ductus-web-app`, CSAIL OpenStack, `128.52.133.17`, `ups.2c2g`, stock `Ubuntu-24.04LTS` image |
| ssh | `ssh ductus-csail` (user `ubuntu`, hops via `slurm2`; needs `fleet up`) |
| code | `/opt/attention-phone`, service user `ductus`, `systemctl status ductus`, `journalctl -u ductus` |
| update | `deploy/push.sh` from this Mac — rsyncs the checkout, re-syncs the venv, restarts |
| TLS | Let's Encrypt via certbot, renewal timer enabled |

## Why not each laptop

The first design had every laptop serve its own page: `phone-demo` on the
student's Mac, phones reaching it over the room wifi. That is fine for one
instructor and fails for a class:

- every student would install Python, `uv` and this repo, and fetch a
  certificate, before a single phone could connect — "not a dependency, a
  wall", as the Max notes already say about the QR;
- every laptop would need the wifi to allow phone→laptop traffic, and campus
  networks routinely block exactly that (client isolation), or refuse to
  resolve the `local-ip.sh` names the certificate depends on;
- twenty laptops means twenty different network situations to debug at once.

GitHub Pages was considered and rejected: it hosts the static file, which was
never the hard part. The page has to open a socket to a receiver the phone can
reach, and a public page opening a socket to a private LAN address is what
Chrome's Private Network Access work is progressively closing.

## The shape

```
  phone (browser)  ──wss──▶  ductus-web-app.csail.mit.edu  ◀──wss──  Max on a student's laptop
  joins ?room=k7f2q          phone-demo behind nginx          relay.js pulls /feed?room=k7f2q
                                                              and re-emits into the receiver
```

- **The server** runs `phone-demo --http --bind 127.0.0.1 --headless` behind
  nginx with a Let's Encrypt certificate. It serves the page, takes every
  phone's WebSocket, and offers `/feed?room=<key>`.
- **A room is one laptop.** `relay.js`, a Node for Max script inside
  `ap.receive`, makes a five-letter key once and keeps it in
  `~/.attention-phone/room`. The `ap.qr` code in "Web page — server" mode is
  `https://ductus-web-app.csail.mit.edu/?room=<key>`. A phone that scans it joins that
  room; the relay pulls that room and nothing else, and emits each sample as
  the same `/phone/<name>/<channel>` message `udpreceive` produces from the
  app. Every existing tap works unchanged.
- **Nothing is installed anywhere.** The phone needs a browser. The laptop
  needs Max and this folder: Node for Max is bundled, and `wsclient.js` is a
  WebSocket client on Node's standard library so no package is fetched.
- **Both directions are outbound**, which every network allows.

The room key is the only credential, and it is visible in the QR. Anyone who
can see a laptop's screen can join or tap that laptop's room. That is the
exposure a LAN already has, and it is the right trade for a class; it would
not be for anything else.

The Ductus app cannot join a room yet: with TLS on its transport builds
`<dashed-ip>.local-ip.sh` from an IP and has no way to name a hostname. A
`url=` key in the configure link and a hostname-capable transport is a small
change but an App Store build. Until then the app sends OSC straight to Max
over the LAN, and the page goes round through the server; both land in the
same receiver.

## What is verified

**Against the live server (2026-09-10):** `fake-phone https://ductus-web-app.csail.mit.edu
--room livetest` at 60 Hz from this Mac, and `relay.js` run under plain Node
(stub `max-api`) against the default server: 3126 `/phone/ada-lovelace/…`
messages in nine seconds, 60 msg/s steady, all six channels, so both
WebSocket hops go through nginx correctly. `/health` showed the phone at
60.0 Hz on every channel. The page loads over the public internet with a valid
certificate and reads the room and name from its URL. Before that, the same
loop was verified locally with a second phone in no room, which never leaked
into the relay. 68 pytest tests cover the server side.

**Not yet verified:** `relay.js` inside a real Max (only under plain Node),
and a real phone through the whole loop.

## How it was stood up, and what went wrong on the way

Reaching CSAIL from here needs the tunnel (`fleet up`, one Duo tap). The
recipe, with the traps met on 2026-09-10 — each cost real time:

1. **WebDNS**: reserve the name on the **real** OpenStack public network,
   `128.52.128.0/18` (third octet 128–191), not the "(for future use only)
   128.52.112.0/21" decoy that sorts above it. **Never override the address
   WebDNS assigns**, and never repoint the record at a DHCP address — TIG has
   objected to that before. *Trap:* WebDNS handed out `128.52.132.177` twice,
   including after delete-and-re-add, while a live Ubuntu 22.04 host of
   another project already held it (and `.178` next to it). Every launch died
   with `Fixed IP … is already in use`. The way out was reserving under a new
   name (`ductus-web-app`), which drew `128.52.133.17`, checked free by ping
   and `nc` from slurm2 *before* launching. TIG should hear about the
   collision so the next person does not get it (`help@csail.mit.edu`).
2. **Horizon**: `ups.2c2g` (32 GB disk, enough — a smaller flavor once had no
   room for the image), network `inet` only, count 1, the address in **eth0
   Fixed IP** under Details, key pair `idtap_server`, security group
   `cluster-status-web` (80 and 443 from anywhere, 22 from `128.52.0.0/16`).
   *Trap:* the `default` group alone blocks everything, and looks exactly like
   a dead VM. *Trap:* an instance that reads ACTIVE and answers nothing may
   have missed its first-boot network — hard reboot, not rebuild.
3. **Image**: the stock **`Ubuntu-24.04LTS`**, not `CSAIL-Ubuntu-24.04LTS`.
   *Trap:* the CSAIL image came up with a working network after a hard reboot
   and sshd still refused every connection (allowed ports refused, unlisted
   ports dropped — so the host itself, not the group). Horizon's console was
   unusable, so the cause is unknown; a Rebuild onto the stock image had
   port 22 open in twelve seconds. The CSAIL image adds LDAP, puppet, nagios
   and sshguard, none of which this server needs.
4. **ssh alias** `ductus-csail` in `~/.ssh/config`: `HostName 128.52.133.17`,
   `User ubuntu`, `ProxyJump slurm2`, `GSSAPIAuthentication no`, copied from
   the `cluster-status` block. From slurm2, a plain `ssh` to any `128.52.*`
   host is routed by the shared AFS `~/.ssh/config` through `jump.csail.mit.edu`
   and refused there — probe with `nc`, not `ssh`.
5. `deploy/push.sh` from this Mac: `rsync` with `--rsync-path="sudo rsync"`,
   since `/opt/attention-phone` belongs to the `ductus` user, then `uv sync`
   and a restart. Not a git pull: the repo is private and a deploy key on an
   unmanaged VM is one secret more than the job needs.
6. On the VM as root, `NAME=ductus-web-app.csail.mit.edu deploy/provision.sh`
   — nginx, certbot, the `ductus` user, `uv`, the venv, the unit, the site,
   the certificate, the renewal timer. Idempotent. Two things it had to learn:
   Ubuntu 24.04 ships nginx 1.24, whose HTTP/2 syntax is `listen 443 ssl
   http2;` (the `http2 on;` form is 1.25+), and the unit must use
   `ProtectHome=read-only`, because `uv` keeps the interpreter the venv points
   at under `/home/ductus/.local` and `ProtectHome=true` turned every exec
   into `Permission denied` (status 203/EXEC).
7. If the name ever changes: `patches/max/server-config.js` is the only place
   it is written on the Max side; on the server side, `NAME=` when
   provisioning, and the `sed` in `deploy/push.sh`'s ssh step is not needed —
   nginx's site file is generated from `deploy/nginx-ductus.conf` by name.

Two nginx details already handled in the config, worth knowing because their
absence looks like a broken relay: the WebSocket `Upgrade`/`Connection`
headers on `/ws` and `/feed`, and a `proxy_read_timeout` of an hour, since a
feed is silent whenever no phone is moving and nginx's default cuts a quiet
stream at 60 s. `server.py` reads `X-Forwarded-Proto` so `/app` hands the iOS
app `tls=1` from behind the proxy.

## Keeping it up

| failure | handled? |
| --- | --- |
| `phone-demo` crash | yes — `Restart=always` |
| VM reboot | yes — `ductus` and `nginx` are enabled |
| certificate expiry | yes — certbot's timer |
| a relay's laptop loses wifi | yes — `relay.js` retries with backoff for ~5 min, then waits for a `bang` |
| security patches | **no — the VM is not TIG-managed**, same as the other two boxes |

`/health` is the thing to look at: it lists every live phone with its rates,
and `rooms` — which room keys currently have a relay listening.
