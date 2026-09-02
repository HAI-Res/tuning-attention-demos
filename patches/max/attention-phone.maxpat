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
   60.0,
   80.0,
   1000.0,
   810.0
  ],
  "bglocked": 0,
  "openinpresentation": 0,
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
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      8.0,
      700.0,
      30.0
     ],
     "style": "",
     "text": "attention-phone \u2014 iPhone sensors into Max",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 20
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      40.0,
      940.0,
      20.0
     ],
     "style": "",
     "text": "One receiver, then as many taps as you want. Each tap picks its channel from the menu.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "bpatcher",
     "patching_rect": [
      20.0,
      70.0,
      440.0,
      272.0
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 0,
     "outlettype": [],
     "name": "ap.receive.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "comment",
     "patching_rect": [
      476.0,
      70.0,
      260.0,
      34.0
     ],
     "style": "",
     "text": "The receiver. Exactly one per Max session \u2014 it owns the UDP socket.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "comment",
     "patching_rect": [
      476.0,
      112.0,
      260.0,
      62.0
     ],
     "style": "",
     "text": "Point a phone's camera at the code and it configures the app in one tap: host, port and transport together. It redraws itself if the address changes.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 4
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      380.0,
      500.0,
      20.0
     ],
     "style": "",
     "text": "Taps \u2014 copy one, choose a channel, use the outlets",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      402.0,
      940.0,
      34.0
     ],
     "style": "",
     "text": "Outlets, left to right: the whole list \u00b7 axis 1 \u00b7 2 \u00b7 3 \u00b7 4 \u00b7 magnitude. The menu chooses live; the object's argument is what it comes back as when you reopen.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "bpatcher",
     "patching_rect": [
      20.0,
      452.0,
      250.0,
      28.0
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 6,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "ap.channel.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "ap.accel"
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      486.0,
      250.0,
      34.0
     ],
     "style": "",
     "text": "acceleration, gravity removed \u2014 the usual one",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "bpatcher",
     "patching_rect": [
      310.0,
      452.0,
      250.0,
      28.0
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 6,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "ap.channel.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "ap.gyro"
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "comment",
     "patching_rect": [
      310.0,
      486.0,
      250.0,
      34.0
     ],
     "style": "",
     "text": "rotation rate",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "bpatcher",
     "patching_rect": [
      600.0,
      452.0,
      250.0,
      28.0
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 6,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "ap.channel.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "ap.head"
     ]
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "comment",
     "patching_rect": [
      600.0,
      486.0,
      250.0,
      34.0
     ],
     "style": "",
     "text": "AirPods head orientation \u2014 needs the native app",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      550.0,
      500.0,
      20.0
     ],
     "style": "",
     "text": "A worked example: magnitude \u2192 pitch",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      580.0,
      190.0,
      22.0
     ],
     "style": "",
     "text": "scale 0. 20. 220. 2000.",
     "numinlets": 6,
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
     "maxclass": "comment",
     "patching_rect": [
      216.0,
      582.0,
      196.0,
      34.0
     ],
     "style": "",
     "text": "0\u201320 m/s\u00b2 onto 220\u20132000 Hz. Change these four first.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      608.0,
      80.0,
      22.0
     ],
     "style": "",
     "text": "pack f 20",
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
     "id": "obj-18",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      636.0,
      60.0,
      22.0
     ],
     "style": "",
     "text": "line~",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "bang"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      664.0,
      80.0,
      22.0
     ],
     "style": "",
     "text": "cycle~ 220",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      692.0,
      70.0,
      22.0
     ],
     "style": "",
     "text": "*~ 0.12",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "ezdac~",
     "patching_rect": [
      20.0,
      720.0,
      45.0,
      45.0
     ],
     "style": "",
     "numinlets": 2,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "toggle",
     "patching_rect": [
      76.0,
      720.0,
      24.0,
      24.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "comment",
     "patching_rect": [
      106.0,
      722.0,
      200.0,
      20.0
     ],
     "style": "",
     "text": "audio on",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "comment",
     "patching_rect": [
      424.0,
      580.0,
      540.0,
      48.0
     ],
     "style": "",
     "text": "The tap's magnitude outlet drives this. Nothing here updates a number box, so nothing on screen moves \u2014 open attention-phone-monitor.maxpat when you want to see what the phone is sending.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 3
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "obj-15",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-8",
      5
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-17",
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
      "obj-18",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-17",
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
      "obj-20",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-21",
      1
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
      "obj-21",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-22",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}
