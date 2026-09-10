// relay.js — the last hop from the hosted receiver into this Max.
//
// When the page and the receiver live on a server (HOSTING.md), phones reach it
// from any network — but the server cannot push UDP into a laptop on room wifi.
// So this Max pulls: it opens an outbound WebSocket to `/feed?room=<key>` and
// re-emits every sample as a message shaped exactly like what [udpreceive]
// produces from the app — selector `/phone/<name>/<channel>`, floats after —
// into the same `js attention-phone.js`. Nothing downstream can tell the two
// apart, which is the point.
//
// The room key is what ties a phone to this laptop. It is made once, kept in
// ~/.attention-phone/room so it survives reopening the patch, and broadcast
// as `ap.room` so every ap.qr draws it into the "Web page — server" code.
// Anyone who scans that code lands in this room; that is the exposure a LAN
// already has, and the reason the key is per laptop rather than per class.
//
//   in    bang          reconnect now, forgetting any earlier failures
//   in    server <url>  use another server (default: server-config.js)
//   in    room <key>    use this key; `room new` makes a fresh one
//   in    stop          disconnect and stay disconnected until the next bang
//   out   room <key>
//   out   server <url>
//   out   status <text> one line, at most every two seconds
//   out   /phone/<name>/<channel> <f> …   the data, at full rate

'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const maxApi = require('max-api');
const ws = require('./wsclient.js');
const config = require('./server-config.js');

let server = config.SERVER;
let room = '';
let conn = null;
let wantConnection = true;
let failures = 0;
let retryTimer = null;
let received = 0;          // samples since the last status line
let lastHeard = 0;         // ms clock of the last heartbeat or sample
let lastStatus = '';

// ── the room key ──────────────────────────────────────────────────────────────

const ROOM_FILE = path.join(os.homedir(), '.attention-phone', 'room');
// No 0/o/1/l/i: this gets read aloud across a room.
const ALPHABET = 'abcdefghjkmnpqrstuvwxyz23456789';

function newKey() {
    let key = '';
    const bytes = require('crypto').randomBytes(5);
    for (let i = 0; i < 5; i++) { key += ALPHABET[bytes[i] % ALPHABET.length]; }
    return key;
}

function loadRoom() {
    try {
        const stored = fs.readFileSync(ROOM_FILE, 'utf8').trim();
        if (/^[a-z0-9]{3,32}$/.test(stored)) { return stored; }
    } catch (e) { /* first run */ }
    return saveRoom(newKey());
}

function saveRoom(key) {
    try {
        fs.mkdirSync(path.dirname(ROOM_FILE), { recursive: true });
        fs.writeFileSync(ROOM_FILE, key + '\n');
    } catch (err) {
        maxApi.post('attention-phone: could not save the room key — ' + err.message);
    }
    return key;
}

// ── status, at most every two seconds ─────────────────────────────────────────
//
// The rate here is a display rate, and it obeys the rule every other readout in
// this folder does: nothing on screen moves at data rate.

function status(text) {
    lastStatus = text;
    maxApi.outlet('status', text);
}

setInterval(function () {
    if (!conn || !wantConnection) { return; }
    const now = Date.now();
    if (lastHeard && now - lastHeard > 8000) {
        status('server silent for ' + Math.round((now - lastHeard) / 1000) + 's — reconnecting');
        reconnect();
        return;
    }
    status(received ? Math.round(received / 2) + ' msg/s from ' + hostOf(server) + ' · room ' + room
                    : 'connected to ' + hostOf(server) + ' · room ' + room + ' · no phones yet');
    received = 0;
}, 2000);

function hostOf(url) {
    try { return new URL(url).host; } catch (e) { return url; }
}

// ── the connection ────────────────────────────────────────────────────────────

function feedUrl() {
    return server.replace(/^http/, 'ws').replace(/\/$/, '') + '/feed?room=' + encodeURIComponent(room);
}

function connect() {
    clearTimeout(retryTimer); retryTimer = null;
    if (conn) {
        // Keep its listeners: they check `c !== conn` and go quiet. Stripping
        // them first turned the abort of a half-open connection into an
        // unhandled 'error' event, which under Node for Max kills the script.
        const old = conn; conn = null; old.close();
    }
    if (!wantConnection) { return; }
    status('connecting to ' + hostOf(server) + ' · room ' + room);
    const c = ws.connect(feedUrl());
    conn = c;
    c.on('open', function () {
        failures = 0;
        lastHeard = Date.now();
        status('connected to ' + hostOf(server) + ' · room ' + room + ' · no phones yet');
    });
    c.on('message', function (text) {
        lastHeard = Date.now();
        let msg;
        try { msg = JSON.parse(text); } catch (e) { return; }
        if (!msg || typeof msg !== 'object' || !msg.s) { return; }     // heartbeat, or nothing we know
        received++;
        const who = slug(msg.n || msg.d || 'phone');
        for (const channel in msg.s) {
            const values = msg.s[channel];
            if (!Array.isArray(values)) { continue; }
            // A leading string makes this a Max message with that selector —
            // the same shape udpreceive gives the app's OSC.
            maxApi.outlet.apply(maxApi, ['/phone/' + who + '/' + channel].concat(values.map(Number)));
        }
    });
    c.on('error', function (err) {
        if (c !== conn) { return; }
        if (err.status === 401 || err.status === 403 || err.status === 404) {
            // The server answered and refused. Retrying cannot change that, and
            // hammering a host that says no is how an address gets rate-limited.
            wantConnection = false;
            status('server refused (' + err.message + ') — check server-config.js, then bang to retry');
            return;
        }
        status('cannot reach ' + hostOf(server) + ' (' + (err.code || err.message) + ')');
    });
    c.on('close', function () {
        if (c !== conn) { return; }
        conn = null;
        scheduleRetry();
    });
}

function scheduleRetry() {
    if (!wantConnection || retryTimer) { return; }
    failures++;
    if (failures > 12) {
        // Roughly five minutes of trying. A room whose network is not going to
        // appear should not be polled forever; a bang starts again.
        wantConnection = false;
        status('gave up reaching ' + hostOf(server) + ' after ' + failures + ' tries — bang to retry');
        return;
    }
    const delay = Math.min(30000, 1000 * Math.pow(2, failures - 1));
    retryTimer = setTimeout(function () { retryTimer = null; connect(); }, delay);
}

function reconnect() {
    failures = 0;
    wantConnection = true;
    connect();
}

// Match attach_osc.slug in phone_demo.py, so a name comes out the same whether
// the phone reached Max directly, through phone-demo, or through this relay.
function slug(name) {
    let out = '';
    const s = String(name).toLowerCase();
    for (let i = 0; i < s.length; i++) {
        const ch = s.charAt(i);
        out += /[a-z0-9\-_.]/.test(ch) ? ch : '-';
    }
    out = out.replace(/^-+|-+$/g, '');
    return out || 'phone';
}

// ── messages from the patch ───────────────────────────────────────────────────

function announce() {
    maxApi.outlet('room', room);
    maxApi.outlet('server', server);
    if (lastStatus) { maxApi.outlet('status', lastStatus); }
}

maxApi.addHandler(maxApi.MESSAGE_TYPES.BANG, function () { announce(); reconnect(); });
maxApi.addHandler('stop', function () {
    wantConnection = false;
    clearTimeout(retryTimer); retryTimer = null;
    if (conn) { conn.close(); conn = null; }
    status('stopped');
});
maxApi.addHandler('server', function (url) {
    if (typeof url === 'string' && /^(https?|wss?):\/\//.test(url)) {
        server = url.replace(/\/$/, '');
        announce();
        reconnect();
    }
});
maxApi.addHandler('room', function (key) {
    if (key === 'new') { room = saveRoom(newKey()); }
    else if (typeof key === 'string' && /^[a-z0-9]{3,32}$/.test(key)) { room = saveRoom(key); }
    else { return; }
    announce();
    reconnect();
});

room = loadRoom();
announce();
connect();
