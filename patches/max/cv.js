// cv.js — routes the camera's OSC addresses into named sends.
//
// Max 8's [udpreceive] decodes OSC itself and hands the address over as the
// message *selector*: `/cv/hand/left/index_tip 0.4 0.3 -0.02` arrives here as a
// message named "/cv/hand/left/index_tip" with three floats. That is fine for a
// fixed address, but there are about forty of them, the body ones are numbered
// by however many people are in frame, and [route] cannot be given its
// arguments at runtime. Max 8 has no [oscparse]; the [tosymbol]→[fromsymbol]
// trick interns a fresh symbol for every float that crosses it and Max never
// frees its symbol table, which at 30 Hz × 40 addresses is a slow leak rather
// than a style problem; and CNMAT's odot is a package dependency this cannot
// have. So the address is split here.
//
// The channel name is the **last three components** of the address joined with
// dots — `/cv/hand/left/index_tip` becomes `hand.left.index_tip`. Three because
// that is the shape of every address the sender produces: a subject kind, a
// subject id, and a field. Taking them from the end rather than the start means
// a changed --osc-prefix keeps working, exactly as the phone patch takes the
// last two.
//
//   outlet 0  <channel> <values...>       live, full rate, every channel
//   outlet 1  umenu commands              clear / append cv.<channel>
//   outlet 2  status line                 set <n> channel(s) <n> msg/sec
//   outlet 3  last address seen           set /cv/hand/left/index_tip
//
// It also pushes every channel to a named receive, `cv.<channel>`, with
// messnamed(). That is what the taps listen to. Doing it here rather than with
// a [route]→[s] cascade in the patch is the whole reason the patch is small:
// the cascade would need one pair of objects per address, and would have to be
// edited by hand the first time someone tracks two people instead of one.

autowatch = 1;
inlets = 1;
outlets = 4;

var SEND_PREFIX = "cv.";

var DEFAULT_INTERVAL = 2000;   // ms between screen updates
var MIN_INTERVAL = 250;
var MAX_INTERVAL = 30000;

var seen = {};          // channel -> { n: messages this window, last: [values] }
var order = [];         // channels, in first-seen order = umenu order
var windowIn = 0;       // messages this window, all channels
var lastAddr = "";
var intervalMs = DEFAULT_INTERVAL;
var frozen = false;

function anything() {
    var parts = messagename.split("/");
    // "/a/b/c/d".split("/") is ["", "a", "b", "c", "d"], so a full address is
    // five elements. Anything shorter is not one of ours; ignore it rather than
    // inventing a channel name out of whatever did arrive.
    if (parts.length < 4) { return; }
    var channel = parts.slice(parts.length - 3).join(".");

    lastAddr = messagename;
    windowIn++;

    var values = arrayfromargs(arguments);

    var entry = seen[channel];
    if (!entry) {
        entry = seen[channel] = { n: 0, last: [] };
        order.push(channel);
        publishMenu();
    }
    entry.n++;
    entry.last = values;

    // A leading symbol makes this a message named after the channel, which is
    // what a [route] downstream would match.
    outlet(0, [channel].concat(values));

    // And straight to [r cv.hand.left.index_tip] and friends. "list" because a
    // bare list is what a tap wants to see; a single float still arrives as a
    // one-element list, which keeps every tap's inlet handling identical.
    messnamed(SEND_PREFIX + channel, "list", values);
}

// Forget every channel seen so far. Worth having: the menu accumulates a slot
// for each body index that was ever in frame, and a run with four people in it
// leaves rows behind that will never fill again.
function clear() {
    seen = {};
    order = [];
    windowIn = 0;
    lastAddr = "";
    publishMenu();
    report();
}

// Milliseconds between screen updates. Longer is calmer.
function interval(ms) {
    ms = Math.max(MIN_INTERVAL, Math.min(MAX_INTERVAL, ms));
    intervalMs = ms;
    reporter.interval = ms;
}

// Stop everything on screen. Outlet 0 and the named sends are untouched, so a
// mapping keeps running at full rate while the display holds still.
function freeze(on) {
    frozen = !!on;
    if (!frozen) { report(); }
}

// The menu carries the full send name — `cv.hand.left.pinch`, not
// `hand.left.pinch` — because that is the string you type into a tap. Outlet 0
// keeps the bare channel, because that is what a [route] downstream matches.
// Each is the form its own consumer needs; the prefix is the only difference.
function publishMenu() {
    outlet(1, "clear");
    for (var i = 0; i < order.length; i++) {
        outlet(1, ["append", SEND_PREFIX + order[i]]);
    }
}

function report() {
    if (!frozen) {
        outlet(3, ["set", lastAddr === "" ? "nothing yet" : lastAddr]);
        outlet(2, ["set", order.length, "channel(s)",
                   Math.round(windowIn * 1000 / intervalMs), "msg/sec"]);
    }
    // Windows reset whether or not anyone is looking, so unfreezing shows the
    // current rate rather than everything that piled up while frozen.
    for (var ch in seen) { seen[ch].n = 0; }
    windowIn = 0;
}

var reporter = new Task(report, this);
reporter.interval = intervalMs;
reporter.repeat();

function notifydeleted() {
    reporter.cancel();
}
