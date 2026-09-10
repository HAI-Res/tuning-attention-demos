{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 8,
   "minor": 5,
   "revision": 7,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   80.0,
   100.0,
   820.0,
   700.0
  ],
  "bglocked": 0,
  "openinpresentation": 1,
  "default_fontsize": 12.0,
  "default_fontface": 0,
  "default_fontname": "Arial",
  "gridonopen": 1,
  "gridsize": [
   15.0,
   15.0
  ],
  "gridsnaponopen": 1,
  "objectsnaponopen": 1,
  "statusbarvisible": 2,
  "toolbarvisible": 1,
  "lefttoolbarpinned": 0,
  "toptoolbarpinned": 0,
  "righttoolbarpinned": 0,
  "bottomtoolbarpinned": 0,
  "toolbars_unpinned_last_save": 0,
  "tallnewobj": 0,
  "boxanimatetime": 200,
  "enablehscroll": 1,
  "enablevscroll": 1,
  "devicewidth": 0.0,
  "description": "",
  "digest": "",
  "tags": "",
  "style": "",
  "subpatcher_template": "",
  "assistshowspatchername": 0,
  "boxes": [
   {
    "box": {
     "id": "obj-1",
     "maxclass": "fpic",
     "patching_rect": [
      8.0,
      8.0,
      256.0,
      256.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "autofit": 1,
     "embed": 0,
     "forceaspect": 1,
     "presentation": 1,
     "presentation_rect": [
      0.0,
      0.0,
      256.0,
      256.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      270.0,
      256.0,
      22.0
     ],
     "style": "",
     "text": "",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12,
     "presentation": 1,
     "presentation_rect": [
      0.0,
      260.0,
      256.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      320.0,
      760.0,
      20.0
     ],
     "style": "",
     "text": "Hidden below. No socket here \u2014 the receiver owns that; this only draws the address.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      348.0,
      62.0,
      22.0
     ],
     "style": "",
     "text": "loadbang",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "newobj",
     "patching_rect": [
      78.0,
      348.0,
      54.0,
      22.0
     ],
     "style": "",
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      376.0,
      60.0,
      22.0
     ],
     "style": "",
     "text": "7400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "patching_rect": [
      78.0,
      376.0,
      90.0,
      22.0
     ],
     "style": "",
     "text": "r ap.port",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "comment",
     "patching_rect": [
      174.0,
      378.0,
      400.0,
      20.0
     ],
     "style": "",
     "text": "the receiver's port, whenever it changes",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      404.0,
      84.0,
      22.0
     ],
     "style": "",
     "text": "prepend port",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      440.0,
      300.0,
      22.0
     ],
     "style": "",
     "text": "node.script address.js @autostart 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "patching_rect": [
      320.0,
      440.0,
      80.0,
      22.0
     ],
     "style": "",
     "text": "delay 2500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "patching_rect": [
      410.0,
      442.0,
      380.0,
      20.0
     ],
     "style": "",
     "text": "Node may not be listening the instant we load",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      468.0,
      210.0,
      22.0
     ],
     "style": "",
     "text": "route host url alt qr",
     "numinlets": 2,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      496.0,
      84.0,
      22.0
     ],
     "style": "",
     "text": "prepend set",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      100.0,
      496.0,
      84.0,
      22.0
     ],
     "style": "",
     "text": "prepend read",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "message",
     "patching_rect": [
      192.0,
      496.0,
      380.0,
      22.0
     ],
     "style": "",
     "text": "",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      524.0,
      760.0,
      20.0
     ],
     "style": "",
     "text": "\u2191 the link the code encodes, if you would rather read it out",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "umenu",
     "patching_rect": [
      8.0,
      300.0,
      256.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "items": [
      "Web page \u2014 server",
      ",",
      "Ductus app",
      ",",
      "Web page \u2014 this laptop"
     ],
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "int",
      "",
      ""
     ],
     "presentation": 1,
     "presentation_rect": [
      0.0,
      286.0,
      256.0,
      22.0
     ],
     "annotation": "Which sender the code is for. Default: the web page on the hosted server, keyed to this laptop's room, relayed here by ap.receive. The app talks to Max directly over the LAN; the local page needs phone-demo --osc 127.0.0.1:7400 on this laptop."
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      560.0,
      60.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "sel 0 1 2",
     "numinlets": 2,
     "numoutlets": 4,
     "outlettype": [
      "bang",
      "bang",
      "bang",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      588.0,
      74.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "target web",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "message",
     "patching_rect": [
      90.0,
      588.0,
      78.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "target app",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      616.0,
      760.0,
      34.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "server (default): https://ductus-web-app.csail.mit.edu/?room=<key>, relayed here by ap.receive. app: ductus://configure?\u2026 scans straight into the app over the LAN. local: https://<dashed-ip>.local-ip.sh:8443/ from a phone-demo on this laptop run with --osc 127.0.0.1:7400.",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "message",
     "patching_rect": [
      176.0,
      588.0,
      84.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "target local",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      320.0,
      376.0,
      90.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "r ap.room",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      320.0,
      404.0,
      90.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "prepend room",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "comment",
     "patching_rect": [
      416.0,
      378.0,
      360.0,
      20.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "this laptop's room key, from the receiver's relay",
     "numinlets": 1,
     "numoutlets": 0
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "obj-5",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-6",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-5",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-11",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-9",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-9",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-9",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-11",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-13",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-10",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-14",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-13",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-16",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-13",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-15",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-13",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-2",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-1",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-15",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-19",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-18",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-20",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-19",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-21",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-19",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-20",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-21",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-23",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-19",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-23",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-25",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-24",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-10",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-25",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}