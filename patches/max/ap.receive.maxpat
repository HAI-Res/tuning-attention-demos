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
   1220.0
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
      8.0,
      4.0,
      380.0,
      20.0
     ],
     "style": "",
     "text": "attention-phone \u2014 receiver",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "number",
     "patching_rect": [
      8.0,
      28.0,
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
     "id": "obj-3",
     "maxclass": "comment",
     "patching_rect": [
      74.0,
      30.0,
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
     "id": "obj-4",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      56.0,
      230.0,
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
     "id": "obj-5",
     "maxclass": "comment",
     "patching_rect": [
      244.0,
      58.0,
      140.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 this Mac",
     "numinlets": 1,
     "numoutlets": 0,
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
      84.0,
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
     "id": "obj-7",
     "maxclass": "umenu",
     "patching_rect": [
      8.0,
      112.0,
      170.0,
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
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "message",
     "patching_rect": [
      184.0,
      112.0,
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
     "id": "obj-9",
     "maxclass": "comment",
     "patching_rect": [
      238.0,
      114.0,
      150.0,
      20.0
     ],
     "style": "",
     "text": "phone \u00b7 forget all",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      140.0,
      250.0,
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
     "id": "obj-11",
     "maxclass": "message",
     "patching_rect": [
      8.0,
      168.0,
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
     "id": "obj-12",
     "maxclass": "fpic",
     "patching_rect": [
      400.0,
      4.0,
      250.0,
      250.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "autofit": 1,
     "embed": 0,
     "forceaspect": 1
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "comment",
     "patching_rect": [
      400.0,
      256.0,
      250.0,
      20.0
     ],
     "style": "",
     "text": "scan to configure the phone",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-14",
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
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      328.0,
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
     "id": "obj-16",
     "maxclass": "message",
     "patching_rect": [
      78.0,
      328.0,
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
     "id": "obj-17",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      356.0,
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
     "id": "obj-18",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      384.0,
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
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      412.0,
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
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      200.0,
      412.0,
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
     "id": "obj-21",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      450.0,
      700.0,
      20.0
     ],
     "style": "",
     "text": "address and QR \u2014 Node for Max, bundled with Max 8",
     "numinlets": 1,
     "numoutlets": 0,
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
      472.0,
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
     "id": "obj-23",
     "maxclass": "newobj",
     "patching_rect": [
      320.0,
      472.0,
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
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      390.0,
      472.0,
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
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      500.0,
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
     "id": "obj-26",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      528.0,
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
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      100.0,
      528.0,
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
     "id": "obj-28",
     "maxclass": "newobj",
     "patching_rect": [
      192.0,
      528.0,
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
     "id": "obj-29",
     "maxclass": "message",
     "patching_rect": [
      284.0,
      528.0,
      300.0,
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
     "id": "obj-30",
     "maxclass": "comment",
     "patching_rect": [
      590.0,
      530.0,
      300.0,
      20.0
     ],
     "style": "",
     "text": "other addresses \u2014 a VPN, or a dead adapter",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      556.0,
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
     "id": "obj-32",
     "maxclass": "comment",
     "patching_rect": [
      8.0,
      594.0,
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
     "id": "obj-33",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      620.0,
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
     "id": "obj-34",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      620.0,
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
     "id": "obj-35",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      648.0,
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
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      648.0,
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
     "id": "obj-37",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      676.0,
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
     "id": "obj-38",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      676.0,
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
     "id": "obj-39",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      704.0,
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
     "id": "obj-40",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      704.0,
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
     "id": "obj-41",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      732.0,
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
     "id": "obj-42",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      732.0,
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
     "id": "obj-43",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      760.0,
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
     "id": "obj-44",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      760.0,
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
     "id": "obj-45",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      788.0,
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
     "id": "obj-46",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      788.0,
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
     "id": "obj-47",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      816.0,
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
     "id": "obj-48",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      816.0,
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
     "id": "obj-49",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      844.0,
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
     "id": "obj-50",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      844.0,
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
     "id": "obj-51",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      872.0,
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
     "id": "obj-52",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      872.0,
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
     "id": "obj-53",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      900.0,
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
     "id": "obj-54",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      900.0,
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
     "id": "obj-55",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      928.0,
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
     "id": "obj-56",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      928.0,
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
     "id": "obj-57",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      956.0,
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
     "id": "obj-58",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      956.0,
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
     "id": "obj-59",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      984.0,
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
     "id": "obj-60",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      984.0,
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
     "id": "obj-61",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1012.0,
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
     "id": "obj-62",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1012.0,
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
     "id": "obj-63",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1040.0,
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
     "id": "obj-64",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1040.0,
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
     "id": "obj-65",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1068.0,
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
     "id": "obj-66",
     "maxclass": "newobj",
     "patching_rect": [
      118.0,
      1068.0,
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
     "id": "obj-67",
     "maxclass": "newobj",
     "patching_rect": [
      8.0,
      1102.0,
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
     "id": "obj-68",
     "maxclass": "message",
     "patching_rect": [
      102.0,
      1102.0,
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
     "id": "obj-69",
     "maxclass": "comment",
     "patching_rect": [
      512.0,
      1104.0,
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
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "obj-16",
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
      "obj-2",
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
      "obj-17",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-2",
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
      "obj-7",
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
      "obj-19",
      3
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
      "obj-19",
      4
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
      "obj-7",
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
      "obj-20",
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
      "obj-8",
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
      "obj-23",
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
      "obj-24",
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
      "obj-17",
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
      "obj-22",
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
      "obj-25",
      0
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
      "obj-25",
      1
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
      "obj-25",
      2
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
      "obj-25",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-4",
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
      "obj-6",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-27",
      0
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
      "obj-12",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-31",
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
      "obj-33",
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
      "obj-35",
      0
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
      "obj-33",
      1
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
      "obj-37",
      0
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
      "obj-35",
      1
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
      "obj-39",
      0
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
      "obj-37",
      1
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
      "obj-41",
      0
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
      "obj-39",
      1
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
      "obj-43",
      0
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
      "obj-41",
      1
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
      "obj-45",
      0
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
      "obj-43",
      1
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
      "obj-47",
      0
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
      "obj-45",
      1
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
      "obj-49",
      0
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
      "obj-47",
      1
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
      "obj-51",
      0
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
      "obj-49",
      1
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
      "obj-53",
      0
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
      "obj-51",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-56",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-55",
      0
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
      "obj-53",
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
      "obj-57",
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
      "obj-55",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-60",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-59",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-59",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-57",
      1
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
      "obj-61",
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
      "obj-59",
      1
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
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-63",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-61",
      1
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
      "obj-65",
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
      "obj-63",
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
      "obj-19",
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
      "obj-65",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-68",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-67",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}
