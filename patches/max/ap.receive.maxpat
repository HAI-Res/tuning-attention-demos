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
   900.0,
   1390.0
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
     "maxclass": "umenu",
     "patching_rect": [
      8.0,
      8.0,
      200.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "int",
      "",
      ""
     ],
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "presentation": 1,
     "presentation_rect": [
      0.0,
      0.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      32.0,
      200.0,
      20.0
     ],
     "style": "",
     "text": "phone",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "presentation": 1,
     "presentation_rect": [
      0.0,
      24.0,
      200.0,
      20.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      60.0,
      200.0,
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
      48.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      300.0,
      700.0,
      20.0
     ],
     "style": "",
     "text": "Below here is hidden in the parent patch. One of these per Max session: it owns the socket.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "number",
     "patching_rect": [
      8.0,
      328.0,
      60.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "comment",
     "patching_rect": [
      74.0,
      330.0,
      300.0,
      20.0
     ],
     "style": "",
     "text": "UDP port \u2014 the app's must match",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      384.0,
      48.0,
      22.0
     ],
     "style": "",
     "text": "clear",
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
     "id": "obj-8",
     "maxclass": "comment",
     "patching_rect": [
      62.0,
      386.0,
      260.0,
      20.0
     ],
     "style": "",
     "text": "forget every phone seen",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      440.0,
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
     "id": "obj-10",
     "maxclass": "comment",
     "patching_rect": [
      394.0,
      442.0,
      300.0,
      20.0
     ],
     "style": "",
     "text": "throughput, and the last address that arrived",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      476.0,
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
     "id": "obj-12",
     "maxclass": "message",
     "patching_rect": [
      78.0,
      476.0,
      50.0,
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
     "id": "obj-13",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      504.0,
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
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      532.0,
      130.0,
      22.0
     ],
     "style": "",
     "text": "udpreceive 7400",
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
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      560.0,
      172.0,
      22.0
     ],
     "style": "",
     "text": "js attention-phone.js",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12,
     "saved_object_attributes": {
      "filename": "attention-phone.js",
      "parameter_enable": 0
     }
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "newobj",
     "patching_rect": [
      200.0,
      560.0,
      96.0,
      22.0
     ],
     "style": "",
     "text": "prepend select",
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
      598.0,
      700.0,
      20.0
     ],
     "style": "",
     "text": "broadcast the port to every ap.qr",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      620.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "s ap.port",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      802.0,
      700.0,
      20.0
     ],
     "style": "",
     "text": "Every channel to a named send, full rate. This is what ap.channel taps into.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      828.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route accel",
     "numinlets": 2,
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
     "id": "obj-21",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      828.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.accel",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      856.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route gravity",
     "numinlets": 2,
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
     "id": "obj-23",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      856.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.gravity",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      884.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route gyro",
     "numinlets": 2,
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
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      884.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.gyro",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      912.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route attitude",
     "numinlets": 2,
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
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      912.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.attitude",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      940.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route quat",
     "numinlets": 2,
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
     "id": "obj-29",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      940.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.quat",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      968.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route mag",
     "numinlets": 2,
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
     "id": "obj-31",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      968.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.mag",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      996.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route accelg",
     "numinlets": 2,
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
     "id": "obj-33",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      996.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.accelg",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1024.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route gyroraw",
     "numinlets": 2,
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
     "id": "obj-35",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1024.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.gyroraw",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1052.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route magraw",
     "numinlets": 2,
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
     "id": "obj-37",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1052.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.magraw",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1080.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route pressure",
     "numinlets": 2,
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
     "id": "obj-39",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1080.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.pressure",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1108.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route location",
     "numinlets": 2,
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
     "id": "obj-41",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1108.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.location",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-42",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1136.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route heading",
     "numinlets": 2,
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
     "id": "obj-43",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1136.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.heading",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1164.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route steps",
     "numinlets": 2,
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
     "id": "obj-45",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1164.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.steps",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1192.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route device",
     "numinlets": 2,
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
     "id": "obj-47",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1192.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.device",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1220.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route head",
     "numinlets": 2,
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
     "id": "obj-49",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1220.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.head",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1248.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route headaccel",
     "numinlets": 2,
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
     "id": "obj-51",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1248.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.headaccel",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1276.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "route audio",
     "numinlets": 2,
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
     "id": "obj-53",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1276.0,
      120.0,
      22.0
     ],
     "style": "",
     "text": "s ap.audio",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-54",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1310.0,
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
     "id": "obj-55",
     "maxclass": "message",
     "patching_rect": [
      102.0,
      1310.0,
      400.0,
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
     "id": "obj-56",
     "maxclass": "comment",
     "patching_rect": [
      512.0,
      1312.0,
      300.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 channels with no send here",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-57",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      90.0,
      200.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "presentation": 1,
     "presentation_rect": [
      0.0,
      76.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-58",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      118.0,
      200.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 10,
     "text": "",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "presentation": 1,
     "presentation_rect": [
      0.0,
      102.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-59",
     "maxclass": "comment",
     "patching_rect": [
      216.0,
      92.0,
      400.0,
      20.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "\u2191 room key and server status, from relay.js below",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-60",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      660.0,
      760.0,
      34.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "numinlets": 1,
     "numoutlets": 0,
     "text": "The hosted path (HOSTING.md). relay.js pulls this laptop's room from the server and re-emits each sample as /phone/<name>/<channel>, the same message udpreceive gives the app \u2014 so it goes into the same js. The room key is broadcast as ap.room for every ap.qr to draw."
    }
   },
   {
    "box": {
     "id": "obj-61",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      700.0,
      270.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "node.script relay.js @autostart 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-62",
     "maxclass": "newobj",
     "patching_rect": [
      290.0,
      700.0,
      80.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "delay 2500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-63",
     "maxclass": "comment",
     "patching_rect": [
      380.0,
      702.0,
      380.0,
      20.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "Node may not be listening the instant we load",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-64",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      728.0,
      160.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "route room status server",
     "numinlets": 2,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-65",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      756.0,
      100.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "s ap.room",
     "numinlets": 1,
     "numoutlets": 0
    }
   },
   {
    "box": {
     "id": "obj-66",
     "maxclass": "newobj",
     "patching_rect": [
      120.0,
      756.0,
      110.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "prepend set room",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-67",
     "maxclass": "newobj",
     "patching_rect": [
      240.0,
      756.0,
      84.0,
      22.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "prepend set",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-68",
     "maxclass": "comment",
     "patching_rect": [
      340.0,
      758.0,
      420.0,
      20.0
     ],
     "style": "",
     "fontname": "Arial",
     "fontsize": 12,
     "text": "\u2190 unmatched messages are the data; they join the UDP stream in the js",
     "numinlets": 1,
     "numoutlets": 0
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "obj-12",
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
      "obj-5",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-12",
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
      "obj-5",
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
      "obj-15",
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
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-3",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-15",
      3
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
      "obj-15",
      4
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
      "obj-1",
      0
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
      "obj-16",
      0
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
      "obj-7",
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
      "obj-5",
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
      "obj-23",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-22",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-22",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-20",
      1
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
      "obj-24",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-22",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-27",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-26",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-26",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-24",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-29",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-28",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-28",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-26",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-31",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-30",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-30",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-28",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-33",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-32",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-32",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-30",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-35",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-34",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-34",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-32",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-37",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-36",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-36",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-34",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-39",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-38",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-38",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-36",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-41",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-40",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-38",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-43",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-42",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-42",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-40",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-45",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-44",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-44",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-42",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-47",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-46",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-46",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-44",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-49",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-48",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-48",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-46",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-51",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-50",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-50",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-48",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-53",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-52",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-52",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-50",
      1
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
      "obj-15",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-54",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-52",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-55",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-54",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-62",
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
      "obj-61",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-62",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-64",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-65",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-64",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-66",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-64",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-57",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-66",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-67",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-64",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-58",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-67",
      0
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
      "obj-64",
      3
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}