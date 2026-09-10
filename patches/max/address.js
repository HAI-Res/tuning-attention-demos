// address.js — "where should the phone send?", answered inside Max.
//
// Runs under [node.script] (Node for Max, bundled with every Max 8 install —
// not a package you have to go and get). The Max `js` object cannot enumerate
// network interfaces and Max has no object that reports a local address, so
// this is the only way for the patch to tell you where to point the phone
// instead of making you go and look it up.
//
// Mirrors the scoring in src/attention_phone/net.py, and avoids the bug that
// one had: the usual "open a socket to 8.8.8.8 and read back the local address"
// trick returns whatever interface holds the default route, which with the MIT
// VPN connected is an 18.x tunnel address no phone on the room's wifi can
// reach. So every interface is enumerated and scored instead.
//
//   in    port <n>       the UDP port the patch is listening on
//   in    target app|web|local
//                        what the code should open: the web page on the hosted
//                        server, keyed to this laptop's room (HOSTING.md; the
//                        default); the Ductus app; or the web page phone-demo
//                        serves from this laptop, for a LAN with no server in reach
//   in    room <key>     this laptop's room key, from relay.js via `ap.room`
//   in    webport <n>    the port a local phone-demo is serving on (8443 by default)
//   in    weburl <url>   another server than server-config.js names; `weburl none` undoes it
//   in    bang           look again (the address changes when you change network)
//   out   host <ip>      best guess at the address a phone should send to
//   out   url <url>      the link the code encodes — ductus://configure?… or https://…
//   out   alt <ip…>      every other address, because the guess is sometimes wrong
//   out   qr <path>      a PNG of that link, for [fpic] to show and a phone to scan

const os = require('os');
const fs = require('fs');
const path = require('path');
const maxApi = require('max-api');
const qr = require('./qr.js');
const config = require('./server-config.js');

// Interfaces that are never the answer: VPN tunnels, Apple's peer-to-peer and
// low-latency WLAN links, Thunderbolt and virtualisation bridges.
const SKIP = /^(lo|utun|tun|tap|ppp|ipsec|awdl|llw|bridge|vmnet|docker|gif|stf|anpi|ap)/;

let port = 7400;

// Which sender the code is for. All three speak the same wire format and land
// on the same channels in this patch, so a patch does not care which one the
// room is holding — but a phone does: a ductus:// link scans to nothing on a
// phone without the app, and a web page cannot send UDP. `web` is the page on
// the hosted server, which relay.js pulls into this receiver by room key;
// `local` is the page a phone-demo on this laptop serves, which reaches this
// receiver only if that phone-demo runs with `--osc 127.0.0.1:<port>`.
let target = 'web';        // the hosted page is the default; the menu in ap.qr changes it
let room = '';
let webPort = 8443;
let webUrlOverride = '';

function score(iface, ip) {
    let s = 0;
    if (!SKIP.test(iface)) { s += 100; }
    if (/^en/.test(iface)) { s += 20; }        // real wifi/ethernet on macOS

    // 169.254.x.x is what macOS assigns when DHCP never answered — a cable in a
    // dock with nothing behind it. It looks like a private address and scores
    // like one, which is how net.py came to prefer a dead adapter over live
    // wifi. It is never routable, so it loses outright.
    if (/^169\.254\./.test(ip)) { s -= 1000; }

    // A phone on the same wifi is usually in RFC1918 — but not always. CSAIL
    // hands out public 128.30.x addresses, so this is a nudge, not a rule.
    if (/^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01])\.)/.test(ip)) { s += 10; }
    return s;
}

function addresses() {
    const found = [];
    const interfaces = os.networkInterfaces();
    Object.keys(interfaces).forEach(function (iface) {
        interfaces[iface].forEach(function (a) {
            // Node has reported `family` as both "IPv4" and 4 across versions.
            const isV4 = a.family === 'IPv4' || a.family === 4;
            if (!isV4 || a.internal) { return; }
            found.push({ iface: iface, ip: a.address, score: score(iface, a.address) });
        });
    });
    found.sort(function (x, y) { return y.score - x.score; });
    return found;
}

function emit() {
    const list = addresses();
    if (list.length === 0) {
        maxApi.outlet('host', 'no-network');
        maxApi.outlet('url', 'connect-this-mac-to-a-network');
        maxApi.outlet('alt', 'none');
        return;
    }
    const best = list[0];
    // `ductus://`, not `attention-phone://`. The app registers exactly one URL
    // scheme (CFBundleURLSchemes: [ductus]) and it was renamed with the app —
    // a code carrying the old scheme scans to nothing at all, because iOS
    // routes by scheme and no installed app claims that one any more. It fails
    // silently and looks like a broken camera.
    const url = target === 'web' ? webUrl() : target === 'local' ? localUrl(best.ip) : appUrl(best.ip);

    maxApi.outlet('host', best.ip);
    maxApi.outlet('url', url);

    const others = list.slice(1).map(function (a) { return a.ip + '(' + a.iface + ')'; });
    maxApi.outlet.apply(maxApi, ['alt'].concat(others.length ? others : ['none']));

    drawQr(url);
}

function appUrl(ip) {
    return 'ductus://configure?host=' + ip + '&osc=' + port + '&mode=osc';
}

// The page on the hosted server, keyed to this laptop: whoever scans it joins
// this room, and relay.js brings the room here. No room yet (relay.js has not
// reported one) means a code with no key, which the page treats as "the laptop
// that served me" — honest, but it will not reach this Max.
function webUrl() {
    const base = (webUrlOverride || config.SERVER).replace(/\/$/, '');
    return base + '/' + (room ? '?room=' + encodeURIComponent(room) : '');
}

// The page a phone-demo on this laptop serves. Same hostname scheme phone-demo
// prints: the dashed IP under local-ip.sh carries a real certificate, which iOS
// needs before it will release motion data to a page. Nothing here checks that
// phone-demo is actually running — a UDP receiver cannot — so the README says
// to start it with `--osc 127.0.0.1:7400` before showing this code.
function localUrl(ip) {
    return 'https://' + ip.replace(/\./g, '-') + '.local-ip.sh:' + webPort + '/';
}

// The QR is redrawn whenever the address or the port changes, and never
// otherwise — a stale code is worse than none, because it sends a room full of
// people to an address that stopped being right.
let lastDrawn = '';
let generation = 0;
let lastFile = '';

function drawQr(url) {
    if (url === lastDrawn) { return; }
    try {
        // A fresh filename each time, because [fpic] is free to cache by name
        // and a silently stale image is exactly the failure this must not have.
        generation += 1;
        const file = path.join(os.tmpdir(), 'attention-phone-qr-' + generation + '.png');
        fs.writeFileSync(file, qr.png(url));

        if (lastFile) { try { fs.unlinkSync(lastFile); } catch (e) { /* already gone */ } }
        lastFile = file;
        lastDrawn = url;
        maxApi.outlet('qr', file);
    } catch (err) {
        // The link is still on screen as text, which a person can read and type.
        maxApi.post('attention-phone: could not draw the QR — ' + err.message);
    }
}

maxApi.addHandler('port', function (p) {
    if (p >= 1 && p <= 65535) { port = p; }
    emit();
});
maxApi.addHandler('target', function (which) {
    if (which === 'app' || which === 'web' || which === 'local') { target = which; }
    emit();
});
maxApi.addHandler('room', function (key) {
    room = typeof key === 'string' ? key : String(key);
    emit();
});
maxApi.addHandler('webport', function (p) {
    if (p >= 1 && p <= 65535) { webPort = p; }
    emit();
});
maxApi.addHandler('weburl', function (url) {
    webUrlOverride = (url && url !== 'none') ? String(url) : '';
    emit();
});
maxApi.addHandler(maxApi.MESSAGE_TYPES.BANG, emit);

// Max may not be listening the instant the script is evaluated, so the patch
// also bangs this after a delay. Reporting twice is harmless.
emit();
