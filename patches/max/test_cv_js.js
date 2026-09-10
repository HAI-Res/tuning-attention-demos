// Runs cv.js outside Max, with the handful of globals Max provides stubbed out.
//
// Max's js cannot be unit-tested in place, and the address splitting is exactly
// the part that is easy to get subtly wrong and hard to see wrong from inside a
// patcher — a channel name off by one component looks like "the taps are not
// receiving" rather than like a parsing bug. So it is tested here.
//
//     node patches/max/test_cv_js.js

const fs = require("fs");
const path = require("path");
const vm = require("vm");

let out = [];        // [outletIndex, args]
let named = [];      // [receiveName, messageName, args]

const sandbox = {
    autowatch: 0, inlets: 0, outlets: 0, messagename: "",
    outlet: (n, ...args) => out.push([n, args.length === 1 ? args[0] : args]),
    messnamed: (name, msg, ...args) => named.push([name, msg, args[0]]),
    arrayfromargs: (args) => Array.prototype.slice.call(args),
    // Max's Task: we drive report() by hand instead of on a timer.
    Task: function (fn) { this.fn = fn; this.interval = 0;
                          this.repeat = () => {}; this.cancel = () => {}; },
};
vm.createContext(sandbox);
vm.runInContext(fs.readFileSync(path.join(__dirname, "cv.js"), "utf8"), sandbox);

let failures = 0;
function check(what, got, want) {
    const g = JSON.stringify(got), w = JSON.stringify(want);
    if (g === w) { console.log(`  ok   ${what}`); }
    else { console.log(`  FAIL ${what}\n         got  ${g}\n         want ${w}`); failures++; }
}

function send(address, ...values) {
    out = []; named = [];
    sandbox.messagename = address;
    sandbox.anything.apply(sandbox, values);
}

console.log("address -> channel name");
send("/cv/hand/left/index_tip", 0.4, 0.3, -0.02);
check("named send name", named[0] && named[0][0], "cv.hand.left.index_tip");
check("named send is a list", named[0] && named[0][1], "list");
check("named send values", named[0] && named[0][2], [0.4, 0.3, -0.02]);
check("outlet 0 is channel + values",
      out.find(o => o[0] === 0)[1], ["hand.left.index_tip", 0.4, 0.3, -0.02]);

send("/cv/pose/0/right_wrist", 0.24, 0.5, -0.21);
check("body index survives", named[0][0], "cv.pose.0.right_wrist");

send("/cv/hand/left/present", 1);
check("a one-element message still goes out as a list", named[0][2], [1]);

send("/cv/pose/0/hands_apart", 0.57);
check("scalar channel", named[0][0], "cv.pose.0.hands_apart");

console.log("\nthe prefix does not matter — last three components win");
send("/room/1/hand/right/pinch", 0.09);
check("longer prefix", named[0][0], "cv.hand.right.pinch");
send("/x/pose/2/norm", 1, 2, 3);
check("shorter prefix", named[0][0], "cv.pose.2.norm");

console.log("\nmalformed addresses are ignored, not guessed at");
send("/cv/hand", 1);
check("too short sends nothing", named.length, 0);
check("too short outputs nothing", out.length, 0);

console.log("\nbulk messages survive intact");
const bulk = Array.from({length: 63}, (_, i) => i / 100);
send("/cv/hand/left/world", ...bulk);
check("63 floats arrive as 63", named[0][2].length, 63);
check("63 floats are unchanged", named[0][2][62], 0.62);

console.log("\nthe channel menu is built from what actually arrives");
out = []; sandbox.clear();
send("/cv/hand/left/pinch", 0.1);
const menu = out.filter(o => o[0] === 1);
check("menu carries the full send name", menu.map(m => m[1]),
      ["clear", ["append", "cv.hand.left.pinch"]]);
out = [];
send("/cv/hand/left/pinch", 0.2);
check("a repeat does not re-publish the menu",
      out.filter(o => o[0] === 1).length, 0);

console.log("\nthe status line counts channels and messages");
sandbox.clear();
send("/cv/hand/left/pinch", 0.1);
send("/cv/pose/0/nose", 0.5, 0.1, 0.0);
send("/cv/pose/0/nose", 0.5, 0.1, 0.0);
out = [];
sandbox.report();
const status = out.find(o => o[0] === 2)[1];
check("two channels, three messages in a 2s window",
      status, ["set", 2, "channel(s)", 2, "msg/sec"]);
check("last address is verbatim", out.find(o => o[0] === 3)[1],
      ["set", "/cv/pose/0/nose"]);

console.log("\nfreeze holds the screen but not the data");
sandbox.freeze(1);
out = [];
send("/cv/hand/left/pinch", 0.9);
check("data still flows while frozen", named.length, 1);
out = [];
sandbox.report();
check("nothing is drawn while frozen", out.length, 0);
sandbox.freeze(0);

console.log("\ninterval is clamped to something a person can read");
sandbox.interval(10);
check("floor", sandbox.reporter.interval, 250);
sandbox.interval(999999);
check("ceiling", sandbox.reporter.interval, 30000);

console.log(failures ? `\n${failures} failure(s)` : "\nall ok");
process.exit(failures ? 1 : 0);
