// qr.js — the configure link as a PNG, with nothing to install.
//
// The native app sends OSC straight to Max with no laptop-side server at all,
// so the QR must not quietly add one. Generating it with Python and segno would
// have: macOS ships python3 without segno, so every machine in the room would
// have needed a repo clone and `uv sync` before a code appeared.
//
// Node for Max is bundled with every Max 8 install, `vendor/` holds a
// dependency-free MIT library committed into the repo, and zlib comes with
// Node — which is the whole of the PNG writer below. So this runs wherever Max
// runs, with nothing fetched and nothing installed.
//
//   const qr = require('./qr.js');
//   fs.writeFileSync('qr.png', qr.png('ductus://configure?...'));

'use strict';

const zlib = require('zlib');
const qrcode = require('./vendor/qrcode-generator.js');

/** The QR as an array of rows of 0/1. Error correction M, version chosen for us. */
function matrix(text) {
    // 0 means "the smallest version that fits". M tolerates a good deal of the
    // code being obscured, which matters when it is being scanned off a laptop
    // screen at an angle from across a room.
    const code = qrcode(0, 'M');
    code.addData(text);
    code.make();

    const n = code.getModuleCount();
    const rows = [];
    for (let r = 0; r < n; r++) {
        const row = [];
        for (let c = 0; c < n; c++) { row.push(code.isDark(r, c) ? 1 : 0); }
        rows.push(row);
    }
    return rows;
}

// ── a minimal greyscale PNG, using Node's own zlib ──────────────────────────
function crc32(buf) {
    let c;
    let crc = 0xffffffff;
    for (let n = 0; n < buf.length; n++) {
        c = (crc ^ buf[n]) & 0xff;
        for (let k = 0; k < 8; k++) { c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1; }
        crc = c ^ (crc >>> 8);
    }
    return (crc ^ 0xffffffff) >>> 0;
}

function chunk(type, data) {
    const len = Buffer.alloc(4);
    len.writeUInt32BE(data.length, 0);
    const body = Buffer.concat([Buffer.from(type, 'ascii'), data]);
    const crc = Buffer.alloc(4);
    crc.writeUInt32BE(crc32(body), 0);
    return Buffer.concat([len, body, crc]);
}

/**
 * PNG of the QR: `scale` pixels per module, plus a quiet zone of `border`
 * modules. Scanners fail on codes drawn flush to their own edge, so the border
 * is not decoration.
 */
function png(text, scale, border) {
    scale = scale || 8;
    border = border === undefined ? 4 : border;

    const m = matrix(text);
    const modules = m.length + border * 2;
    const size = modules * scale;

    const raw = Buffer.alloc((size + 1) * size);
    let at = 0;
    for (let y = 0; y < size; y++) {
        raw[at++] = 0;                                   // no per-line filter
        const my = Math.floor(y / scale) - border;
        for (let x = 0; x < size; x++) {
            const mx = Math.floor(x / scale) - border;
            const dark = my >= 0 && my < m.length && mx >= 0 && mx < m.length && m[my][mx];
            raw[at++] = dark ? 0 : 255;
        }
    }

    const ihdr = Buffer.alloc(13);
    ihdr.writeUInt32BE(size, 0);
    ihdr.writeUInt32BE(size, 4);
    ihdr[8] = 8;        // bit depth
    ihdr[9] = 0;        // greyscale
    return Buffer.concat([
        Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]),
        chunk('IHDR', ihdr),
        chunk('IDAT', zlib.deflateSync(raw)),
        chunk('IEND', Buffer.alloc(0))
    ]);
}

module.exports = { matrix, png };
