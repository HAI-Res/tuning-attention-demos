// wsclient.js — a WebSocket client in ~120 lines, using only what Node ships.
//
// Node for Max bundles a Node whose version is not ours to choose, and which
// may predate the built-in WebSocket client (Node 22). The `ws` package would
// do, but it is a dependency to fetch — and the rule for this folder is that a
// fresh clone opens in Max with nothing installed (see qr.js). So: an HTTP
// upgrade, the accept-key check, frame parsing with masking and continuation,
// ping → pong, close. Text frames only, which is all the feed sends.
//
//   const ws = require('./wsclient.js');
//   const c = ws.connect('wss://host/feed?room=k7f2q');
//   c.on('open', …); c.on('message', text => …); c.on('close', …); c.on('error', err => …);
//   c.send('…'); c.close();
//
// An `error` with `.status` set is an HTTP refusal (401, 404 …) — the server
// answered and said no, so retrying will not help. Without `.status` it is a
// network failure, which is worth retrying.

'use strict';

const http = require('http');
const https = require('https');
const crypto = require('crypto');
const EventEmitter = require('events');

const GUID = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';

function connect(url, options) {
    options = options || {};
    const em = new EventEmitter();
    const u = new URL(url);
    const secure = u.protocol === 'wss:' || u.protocol === 'https:';
    const key = crypto.randomBytes(16).toString('base64');
    let socket = null;
    let closed = false;
    let closing = false;   // we asked for this; errors from tearing down are not news

    const req = (secure ? https : http).request({
        host: u.hostname,
        port: u.port || (secure ? 443 : 80),
        path: u.pathname + u.search,
        method: 'GET',
        headers: {
            Host: u.host,
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Version': '13',
            'Sec-WebSocket-Key': key
        },
        timeout: options.timeout || 10000,
        rejectUnauthorized: options.rejectUnauthorized !== false
    });

    function finish() {
        if (closed) { return; }
        closed = true;
        em.emit('close');
    }

    function sendFrame(opcode, payload) {
        if (!socket || socket.destroyed) { return; }
        payload = payload || Buffer.alloc(0);
        const mask = crypto.randomBytes(4);
        let header;
        if (payload.length < 126) {
            header = Buffer.from([0x80 | opcode, 0x80 | payload.length]);
        } else if (payload.length < 65536) {
            header = Buffer.alloc(4);
            header[0] = 0x80 | opcode; header[1] = 0x80 | 126;
            header.writeUInt16BE(payload.length, 2);
        } else {
            header = Buffer.alloc(10);
            header[0] = 0x80 | opcode; header[1] = 0x80 | 127;
            header.writeBigUInt64BE(BigInt(payload.length), 2);
        }
        const body = Buffer.from(payload);
        for (let i = 0; i < body.length; i++) { body[i] ^= mask[i & 3]; }
        socket.write(Buffer.concat([header, mask, body]));
    }

    req.on('upgrade', function (res, sock, head) {
        const expect = crypto.createHash('sha1').update(key + GUID).digest('base64');
        if (res.headers['sec-websocket-accept'] !== expect) {
            sock.destroy();
            em.emit('error', new Error('WebSocket handshake failed: bad Sec-WebSocket-Accept'));
            finish();
            return;
        }
        socket = sock;
        sock.setNoDelay(true);

        let buf = head && head.length ? Buffer.from(head) : Buffer.alloc(0);
        let fragments = [];
        let fragmentOpcode = 0;

        function handle(fin, opcode, payload) {
            if (opcode === 0x8) {                       // close: answer, then hang up
                sendFrame(0x8, payload.subarray(0, Math.min(2, payload.length)));
                sock.end();
                finish();
            } else if (opcode === 0x9) {                // ping
                sendFrame(0xA, payload);
            } else if (opcode === 0x1 || opcode === 0x2 || opcode === 0x0) {
                if (opcode !== 0x0) { fragmentOpcode = opcode; }
                fragments.push(payload);
                if (fin) {
                    const data = Buffer.concat(fragments);
                    fragments = [];
                    if (fragmentOpcode === 0x1) { em.emit('message', data.toString('utf8')); }
                    fragmentOpcode = 0;
                }
            }                                           // pong and anything else: ignore
        }

        sock.on('data', function (chunk) {
            buf = buf.length ? Buffer.concat([buf, chunk]) : chunk;
            for (;;) {
                if (buf.length < 2) { return; }
                const fin = (buf[0] & 0x80) !== 0;
                const opcode = buf[0] & 0x0f;
                const masked = (buf[1] & 0x80) !== 0;
                let len = buf[1] & 0x7f;
                let off = 2;
                if (len === 126) {
                    if (buf.length < 4) { return; }
                    len = buf.readUInt16BE(2); off = 4;
                } else if (len === 127) {
                    if (buf.length < 10) { return; }
                    len = Number(buf.readBigUInt64BE(2)); off = 10;
                }
                if (masked) { off += 4; }
                if (buf.length < off + len) { return; }
                let payload = buf.subarray(off, off + len);
                if (masked) {                           // servers must not mask, but be lenient
                    const m = buf.subarray(off - 4, off);
                    const p = Buffer.from(payload);
                    for (let i = 0; i < p.length; i++) { p[i] ^= m[i & 3]; }
                    payload = p;
                }
                buf = buf.subarray(off + len);
                handle(fin, opcode, payload);
            }
        });
        sock.on('close', finish);
        sock.on('error', function (err) { if (!closing) { em.emit('error', err); } });
        em.emit('open');
    });

    // A normal HTTP response instead of an upgrade: the server refused.
    req.on('response', function (res) {
        const err = new Error('HTTP ' + res.statusCode + ' from ' + u.host);
        err.status = res.statusCode;
        res.resume();
        req.destroy();
        em.emit('error', err);
        finish();
    });
    req.on('error', function (err) { if (!closing) { em.emit('error', err); } finish(); });
    req.on('timeout', function () { req.destroy(new Error('timed out connecting to ' + u.host)); });
    req.end();

    em.send = function (text) { sendFrame(0x1, Buffer.from(String(text), 'utf8')); };
    em.close = function () {
        closing = true;
        if (socket) {
            try { sendFrame(0x8, Buffer.from([0x03, 0xe8])); } catch (e) { /* already gone */ }
            socket.end();
        } else {
            req.destroy();
        }
        finish();
    };
    return em;
}

module.exports = { connect };
