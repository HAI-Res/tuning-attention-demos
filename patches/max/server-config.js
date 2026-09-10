// server-config.js — where the hosted receiver lives. One place to change it.
//
// Both Node scripts in this folder read it: address.js puts this address into
// the "Web page — server" QR, and relay.js opens the feed on it. Until the DNS
// name exists this points at nothing, and both scripts say so rather than
// failing quietly: the QR still draws, and the relay reports that it cannot
// reach the server.
//
// No trailing slash.
'use strict';

module.exports = {
    SERVER: 'https://ductus-web-app.csail.mit.edu'
};
