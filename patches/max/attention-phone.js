// attention-phone.js — OSC address router, and the thing that keeps the screen
// still.
//
// Two jobs, and the second one is not cosmetic:
//
// 1. Split the OSC address. Max 8's [udpreceive] decodes OSC itself and hands
//    the address over as the *message selector*: `/phone/ada/accel 0.1 0.2 0.3`
//    arrives as a message named "/phone/ada/accel" with three floats. That is
//    fine for a fixed address, but a student types their own name, so the
//    middle component is not known until it arrives — and [route] cannot be
//    given its arguments at runtime. Max 8 has no [oscparse] either, and the
//    [tosymbol]→[fromsymbol] trick would intern a fresh symbol for every float
//    that ever crosses the wire, which at 100 Hz is a slow memory leak: Max
//    never frees the symbol table. So the address is split here, and this is
//    the one object in the patch that needs to know anything about naming.
//
// 2. Keep the display slow. A phone sends at up to 100 Hz. Number boxes wired
//    straight to that flicker, and flicker at that rate is a migraine trigger,
//    not a style problem — this patch is for a room full of people. So the
//    values that reach the screen are averaged over a window and emitted once
//    per window (two seconds by default, adjustable, freezable). The full-rate
//    stream still leaves outlet 0 untouched, because that is what a mapping
//    needs; nothing about the sound path is slowed down.
//
// Addresses are /<prefix>/<name>/<channel>; only the last two components are
// used, so a changed --osc-prefix (or a differently configured app) still works.
//
//   messnamed ap.<phone>.<channel>              live, full rate, every phone
//   outlet 0  <channel> <values...>              live, full rate, selected phone
//   outlet 1  <channel> <hz> <values...> [<mag>] once per window, for the screen
//   outlet 2  umenu commands                     clear / append <name> / set <n>
//   outlet 3  status line                        set <n> phone(s) <n> msg/sec
//   outlet 4  last address seen                  set /phone/ada/accel

autowatch = 1;
inlets = 1;
outlets = 5;

// Every channel the iOS app can send, in the order the patch lays them out.
// Kept here as well as in the patch so that a channel which is *not* arriving
// still reports 0 Hz — silence and absence look identical otherwise.
//
// `vector` marks the channels whose axes form a vector: those get averaged over
// the window and carry a magnitude. The rest report their last sample instead,
// because averaging an angle is wrong at the wrap-around — the mean of 359° and
// 1° is 180°, which is the one direction the phone was never pointing.
//
// `dp` is decimal places. Fewer digits mean fewer digits *changing*, which is
// most of what makes a number box restful to look at. Location needs five to
// still be a location; acceleration does not.
var CHANNELS = [
    { name: "accel",     axes: 3, vector: true,  dp: 2 },
    { name: "gravity",   axes: 3, vector: true,  dp: 2 },
    { name: "gyro",      axes: 3, vector: true,  dp: 2 },
    { name: "attitude",  axes: 3, vector: false, dp: 1 },
    { name: "quat",      axes: 4, vector: false, dp: 3 },
    { name: "mag",       axes: 3, vector: true,  dp: 1 },
    { name: "accelg",    axes: 3, vector: true,  dp: 2 },
    { name: "gyroraw",   axes: 3, vector: true,  dp: 2 },
    { name: "magraw",    axes: 3, vector: true,  dp: 1 },
    { name: "pressure",  axes: 2, vector: false, dp: 2 },
    { name: "location",  axes: 4, vector: false, dp: 5 },
    { name: "heading",   axes: 1, vector: false, dp: 1 },
    { name: "steps",     axes: 3, vector: false, dp: 2 },
    { name: "device",    axes: 3, vector: false, dp: 2 },
    { name: "head",      axes: 3, vector: false, dp: 1 },
    { name: "headaccel", axes: 3, vector: true,  dp: 2 },
    { name: "audio",     axes: 3, vector: false, dp: 3 }
];

var SPEC = {};
for (var k = 0; k < CHANNELS.length; k++) { SPEC[CHANNELS[k].name] = CHANNELS[k]; }

var DEFAULT_INTERVAL = 2000;   // ms between screen updates
var MIN_INTERVAL = 250;
var MAX_INTERVAL = 30000;

var devices = {};       // name -> { chans: { channel -> accumulator } }
var order = [];         // names, in first-seen order = umenu order
var sel = 0;            // index into `order`
var windowIn = 0;       // messages since the last report, all phones
var lastAddr = "";
var intervalMs = DEFAULT_INTERVAL;
var frozen = false;

function accumulator(spec) {
    var a = { n: 0, sum: [], magSum: 0, shown: [], seen: false, named: '' };
    var slots = spec ? spec.axes : 1;
    for (var i = 0; i < slots; i++) { a.sum.push(0); a.shown.push(0); }
    if (spec && spec.vector) { a.shown.push(0); }   // trailing magnitude
    return a;
}

function anything() {
    var addr = messagename;
    var parts = addr.split("/");
    if (parts.length < 3) { return; }              // not /<prefix>/<name>/<channel>
    var channel = parts[parts.length - 1];
    var who = parts[parts.length - 2];

    lastAddr = addr;
    windowIn++;

    var device = devices[who];
    if (!device) {
        device = devices[who] = { chans: {} };
        order.push(who);
        publishMenu();
    }

    var values = arrayfromargs(arguments);
    var spec = SPEC[channel];
    var acc = device.chans[channel];
    if (!acc) { acc = device.chans[channel] = accumulator(spec); }
    acc.n++;
    acc.seen = true;

    if (spec) {
        if (spec.vector) {
            var sq = 0;
            for (var i = 0; i < spec.axes; i++) {
                var v = values[i] || 0;
                acc.sum[i] += v;
                sq += v * v;
            }
            acc.magSum += Math.sqrt(sq);
        } else {
            // Last sample rather than a mean — see the note on CHANNELS.
            for (var j = 0; j < spec.axes; j++) { acc.sum[j] = values[j] || 0; }
        }
    }

    // Every phone, addressed by name: a tap written as [ap.channel ap.ada.gyro]
    // gets Ada whoever the menu happens to be showing. [send] cannot be renamed
    // at runtime and [receive] can, so the fan-out has to happen here rather
    // than through objects in the patch.
    //
    // The name is built once per phone-and-channel and kept on the accumulator:
    // twenty phones at 60 Hz is thousands of these a second, and rebuilding the
    // string every time is the one part of this that would actually cost.
    if (!acc.named) { acc.named = 'ap.' + slug(who) + '.' + channel; }
    messnamed.apply(null, [acc.named].concat(values));

    if (who === order[sel]) {
        // The menu-selected phone is also published under the bare channel
        // name, so [ap.channel ap.gyro] means "whichever phone is selected".
        // An array goes out as a Max list; a leading symbol makes it a message
        // named after the channel, which is what [route] downstream matches.
        outlet(0, [channel].concat(values));
    }
}

/**
 * A phone name as a Max symbol.
 *
 * OSC already restricted this to a-z 0-9 - _ . on the way in, but a dot would
 * make `ap.<name>.<channel>` ambiguous to read, so dots become dashes. Anything
 * unexpected is replaced rather than passed through, because a name typed by a
 * student ends up in a global symbol here.
 */
function slug(name) {
    var out = '';
    var allowed = 'abcdefghijklmnopqrstuvwxyz0123456789-_';
    var lower = String(name).toLowerCase();
    for (var i = 0; i < lower.length; i++) {
        var ch = lower.charAt(i);
        out += allowed.indexOf(ch) >= 0 ? ch : '-';
    }
    return out === '' ? 'phone' : out;
}

// umenu's left outlet, via [prepend select]. Index rather than the item text,
// because umenu's middle outlet sends the text *as a message* — a phone called
// "ada" would arrive here as a call to a function named ada().
function select(index) {
    if (index >= 0 && index < order.length) {
        sel = index;
        report();
    }
}

// Forget every phone seen so far. Worth having in a classroom: names accumulate
// across a session and the menu fills up with people who have already put their
// phone away.
function clear() {
    devices = {};
    order = [];
    sel = 0;
    windowIn = 0;
    publishMenu();
    report();
}

// Milliseconds between screen updates. Longer is calmer.
function interval(ms) {
    ms = Math.max(MIN_INTERVAL, Math.min(MAX_INTERVAL, ms));
    intervalMs = ms;
    reporter.interval = ms;
}

// Stop everything on screen. The data path out of outlet 0 is untouched, so a
// mapping or a sound keeps running while the display holds still.
function freeze(on) {
    frozen = !!on;
    if (!frozen) { report(); }
}

function publishMenu() {
    outlet(2, "clear");
    for (var i = 0; i < order.length; i++) {
        outlet(2, ["append", order[i]]);
    }
    outlet(2, ["set", sel]);   // display only; does not make umenu output
}

function round(v, dp) {
    var f = Math.pow(10, dp);
    return Math.round(v * f) / f;
}

function report() {
    var device = devices[order[sel]];

    if (!frozen) {
        for (var i = 0; i < CHANNELS.length; i++) {
            var spec = CHANNELS[i];
            var acc = device ? device.chans[spec.name] : null;
            var hz = 0;
            if (acc) {
                hz = round(acc.n * 1000 / intervalMs, 1);
                if (acc.n > 0) {
                    for (var j = 0; j < spec.axes; j++) {
                        var v = spec.vector ? acc.sum[j] / acc.n : acc.sum[j];
                        acc.shown[j] = round(v, spec.dp);
                    }
                    if (spec.vector) {
                        acc.shown[spec.axes] = round(acc.magSum / acc.n, spec.dp);
                    }
                }
                // With no samples this window the values hold and the rate reads
                // 0, which says "stopped" rather than "suddenly zero".
            }
            var shown = acc ? acc.shown : accumulator(spec).shown;
            outlet(1, [spec.name, hz].concat(shown));
        }
        outlet(4, ["set", lastAddr === "" ? "nothing yet" : lastAddr]);
        outlet(3, ["set", order.length, "phone(s)",
                   Math.round(windowIn * 1000 / intervalMs), "msg/sec"]);
    }

    // Windows reset whether or not anyone is looking, so that unfreezing shows
    // the current rate rather than everything accumulated while frozen.
    for (var name in devices) {
        var chans = devices[name].chans;
        for (var ch in chans) {
            chans[ch].n = 0;
            chans[ch].magSum = 0;
            var spec2 = SPEC[ch];
            if (spec2 && spec2.vector) {
                for (var m = 0; m < spec2.axes; m++) { chans[ch].sum[m] = 0; }
            }
        }
    }
    windowIn = 0;
}

var reporter = new Task(report, this);
reporter.interval = intervalMs;
reporter.repeat();

function notifydeleted() {
    reporter.cancel();
}
