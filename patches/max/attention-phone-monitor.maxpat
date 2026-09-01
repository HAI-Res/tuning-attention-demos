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
   40.0,
   60.0,
   1260.0,
   918.0
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
      620.0,
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
      840.0,
      20.0
     ],
     "style": "",
     "text": "The iOS app sends OSC straight here, or phone-demo --osc forwards the browser senders.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      66.0,
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
     "id": "obj-4",
     "maxclass": "message",
     "patching_rect": [
      90.0,
      66.0,
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
     "id": "obj-5",
     "maxclass": "number",
     "patching_rect": [
      148.0,
      66.0,
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
      214.0,
      68.0,
      240.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 UDP port; the app's must match",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      94.0,
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
     "id": "obj-8",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      122.0,
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
     "id": "obj-9",
     "maxclass": "comment",
     "patching_rect": [
      158.0,
      124.0,
      290.0,
      20.0
     ],
     "style": "",
     "text": "udpreceive decodes the OSC itself,",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      158.0,
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
     "id": "obj-11",
     "maxclass": "comment",
     "patching_rect": [
      200.0,
      160.0,
      258.0,
      20.0
     ],
     "style": "",
     "text": "and the js splits /phone/<name>/<channel>.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "patching_rect": [
      470.0,
      64.0,
      400.0,
      20.0
     ],
     "style": "",
     "text": "Point the iPhone app here",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "message",
     "patching_rect": [
      470.0,
      88.0,
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
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "comment",
     "patching_rect": [
      676.0,
      90.0,
      194.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 host: this Mac",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "message",
     "patching_rect": [
      470.0,
      116.0,
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
     "id": "obj-16",
     "maxclass": "comment",
     "patching_rect": [
      470.0,
      140.0,
      400.0,
      34.0
     ],
     "style": "",
     "text": "Open that link on the phone and it sets host, port and mode in one tap. Otherwise type the host and the port into the app's settings by hand.",
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
     "maxclass": "message",
     "patching_rect": [
      470.0,
      178.0,
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
     "id": "obj-18",
     "maxclass": "comment",
     "patching_rect": [
      470.0,
      202.0,
      400.0,
      20.0
     ],
     "style": "",
     "text": "other addresses on this Mac \u2014 a VPN, or a dead adapter",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      8.0,
      360.0,
      20.0
     ],
     "style": "",
     "text": "Screen updates",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      30.0,
      360.0,
      34.0
     ],
     "style": "",
     "text": "Slowed and averaged on purpose. Longer is calmer; the sound stays full rate.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      68.0,
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
     "id": "obj-22",
     "maxclass": "message",
     "patching_rect": [
      950.0,
      68.0,
      50.0,
      22.0
     ],
     "style": "",
     "text": "2000",
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
     "id": "obj-23",
     "maxclass": "number",
     "patching_rect": [
      1008.0,
      68.0,
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
     "id": "obj-24",
     "maxclass": "comment",
     "patching_rect": [
      1074.0,
      70.0,
      166.0,
      20.0
     ],
     "style": "",
     "text": "ms  (250\u201330000)",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      96.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "prepend interval",
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
     "id": "obj-26",
     "maxclass": "toggle",
     "patching_rect": [
      880.0,
      126.0,
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
     "id": "obj-27",
     "maxclass": "comment",
     "patching_rect": [
      910.0,
      128.0,
      200.0,
      20.0
     ],
     "style": "",
     "text": "freeze the screen",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      156.0,
      92.0,
      22.0
     ],
     "style": "",
     "text": "prepend freeze",
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
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      196.0,
      360.0,
      20.0
     ],
     "style": "",
     "text": "address lookup \u2014 Node for Max, bundled with Max 8",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      218.0,
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
     "id": "obj-31",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      248.0,
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
     "id": "obj-32",
     "maxclass": "newobj",
     "patching_rect": [
      950.0,
      248.0,
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
     "id": "obj-33",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      278.0,
      170.0,
      22.0
     ],
     "style": "",
     "text": "route host url alt",
     "numinlets": 2,
     "numoutlets": 4,
     "outlettype": [
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
     "id": "obj-34",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      308.0,
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
     "id": "obj-35",
     "maxclass": "newobj",
     "patching_rect": [
      972.0,
      308.0,
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
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      1064.0,
      308.0,
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
     "id": "obj-37",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      350.0,
      360.0,
      20.0
     ],
     "style": "",
     "text": "phone \u2014 the grid below is this one's",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "umenu",
     "patching_rect": [
      880.0,
      374.0,
      168.0,
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
     "id": "obj-39",
     "maxclass": "message",
     "patching_rect": [
      1058.0,
      374.0,
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
     "id": "obj-40",
     "maxclass": "comment",
     "patching_rect": [
      1112.0,
      376.0,
      120.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 forget all",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      404.0,
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
     "id": "obj-42",
     "maxclass": "message",
     "patching_rect": [
      880.0,
      436.0,
      330.0,
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
     "id": "obj-43",
     "maxclass": "message",
     "patching_rect": [
      880.0,
      464.0,
      330.0,
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
     "id": "obj-44",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      488.0,
      360.0,
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
     "id": "obj-45",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      522.0,
      360.0,
      20.0
     ],
     "style": "",
     "text": "Full rate \u2014 for mapping",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      544.0,
      360.0,
      34.0
     ],
     "style": "",
     "text": "Outlet 0 of the js is every sample, unaveraged. Add your own [route <channel>] here; the grid is no use for a mapping.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      584.0,
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
     "id": "obj-48",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      614.0,
      84.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "float",
      "float",
      "float"
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
      880.0,
      644.0,
      206.0,
      22.0
     ],
     "style": "",
     "text": "expr sqrt($f1*$f1 + $f2*$f2 + $f3*$f3)",
     "numinlets": 3,
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
     "id": "obj-50",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      674.0,
      130.0,
      22.0
     ],
     "style": "",
     "text": "s ap-accel-mag",
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
     "maxclass": "comment",
     "patching_rect": [
      880.0,
      710.0,
      360.0,
      20.0
     ],
     "style": "",
     "text": "Hear it: magnitude \u2192 pitch",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-65",
     "maxclass": "newobj",
     "patching_rect": [
      880.0,
      734.0,
      110.0,
      22.0
     ],
     "style": "",
     "text": "p hear-it",
     "numinlets": 0,
     "numoutlets": 0,
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
       560.0,
       360.0
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
         "id": "obj-52",
         "maxclass": "comment",
         "patching_rect": [
          20.0,
          10.0,
          480.0,
          34.0
         ],
         "style": "",
         "text": "Acceleration magnitude \u2192 pitch. The smallest thing that turns movement into sound; change the four numbers in [scale] first.",
         "numinlets": 1,
         "numoutlets": 0,
         "fontname": "Arial",
         "fontsize": 12,
         "linecount": 2
        }
       },
       {
        "box": {
         "id": "obj-53",
         "maxclass": "toggle",
         "patching_rect": [
          20.0,
          56.0,
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
         "id": "obj-54",
         "maxclass": "comment",
         "patching_rect": [
          50.0,
          58.0,
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
         "id": "obj-55",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          88.0,
          128.0,
          22.0
         ],
         "style": "",
         "text": "r ap-accel-mag",
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
         "id": "obj-56",
         "maxclass": "comment",
         "patching_rect": [
          154.0,
          90.0,
          340.0,
          20.0
         ],
         "style": "",
         "text": "fed by the full-rate tap in the main patch",
         "numinlets": 1,
         "numoutlets": 0,
         "fontname": "Arial",
         "fontsize": 12
        }
       },
       {
        "box": {
         "id": "obj-57",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          118.0,
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
         "id": "obj-58",
         "maxclass": "comment",
         "patching_rect": [
          216.0,
          120.0,
          300.0,
          20.0
         ],
         "style": "",
         "text": "0\u201320 m/s\u00b2 of movement onto 220\u20132000 Hz",
         "numinlets": 1,
         "numoutlets": 0,
         "fontname": "Arial",
         "fontsize": 12
        }
       },
       {
        "box": {
         "id": "obj-59",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          148.0,
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
         "id": "obj-60",
         "maxclass": "comment",
         "patching_rect": [
          106.0,
          150.0,
          300.0,
          20.0
         ],
         "style": "",
         "text": "20 ms glide, so steps do not click",
         "numinlets": 1,
         "numoutlets": 0,
         "fontname": "Arial",
         "fontsize": 12
        }
       },
       {
        "box": {
         "id": "obj-61",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          178.0,
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
         "id": "obj-62",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          208.0,
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
         "id": "obj-63",
         "maxclass": "newobj",
         "patching_rect": [
          20.0,
          238.0,
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
         "id": "obj-64",
         "maxclass": "ezdac~",
         "patching_rect": [
          20.0,
          268.0,
          45.0,
          45.0
         ],
         "style": "",
         "numinlets": 2,
         "numoutlets": 0
        }
       }
      ],
      "lines": [
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
          "obj-61",
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
          "obj-63",
          0
         ]
        }
       },
       {
        "patchline": {
         "destination": [
          "obj-64",
          1
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
          "obj-64",
          0
         ],
         "disabled": 0,
         "hidden": 0,
         "source": [
          "obj-53",
          0
         ]
        }
       }
      ]
     },
     "fontname": "Arial",
     "fontsize": 12,
     "saved_object_attributes": {
      "description": "",
      "digest": "",
      "fontsize": 12.0,
      "globalpatchername": "",
      "style": "",
      "tags": ""
     }
    }
   },
   {
    "box": {
     "id": "obj-66",
     "maxclass": "comment",
     "patching_rect": [
      998.0,
      736.0,
      240.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 double-click to open",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-67",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      246.0,
      400.0,
      20.0
     ],
     "style": "",
     "text": "What this phone is sending",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-68",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      268.0,
      840.0,
      20.0
     ],
     "style": "",
     "text": "Averaged over each window \u2014 vector channels are the mean, the rest the last value. Hz of 0 means nothing is arriving.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-69",
     "maxclass": "comment",
     "patching_rect": [
      274.0,
      292.0,
      48.0,
      20.0
     ],
     "style": "",
     "text": "Hz",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-70",
     "maxclass": "comment",
     "patching_rect": [
      338.0,
      292.0,
      200.0,
      20.0
     ],
     "style": "",
     "text": "values",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-71",
     "maxclass": "comment",
     "patching_rect": [
      582.0,
      292.0,
      60.0,
      20.0
     ],
     "style": "",
     "text": "|v|",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-72",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      314.0,
      600.0,
      20.0
     ],
     "style": "",
     "text": "Device motion (fused) \u2014 almost always what you want",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-73",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      336.0,
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
     "id": "obj-74",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      336.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-75",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      336.0,
      48.0,
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
     "id": "obj-76",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      336.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-77",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      336.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-78",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      336.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-79",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      336.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-80",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      338.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 m/s\u00b2, gravity removed",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-81",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      360.0,
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
     "id": "obj-82",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      360.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-83",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      360.0,
      48.0,
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
     "id": "obj-84",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      360.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-85",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      360.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-86",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      360.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-87",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      360.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-88",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      362.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 m/s\u00b2",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-89",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      384.0,
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
     "id": "obj-90",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      384.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-91",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      384.0,
      48.0,
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
     "id": "obj-92",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      384.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-93",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      384.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-94",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      384.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-95",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      384.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-96",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      386.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 rad/s",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-97",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      408.0,
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
     "id": "obj-98",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      408.0,
      104.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-99",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      408.0,
      48.0,
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
     "id": "obj-100",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      408.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-101",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      408.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-102",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      408.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-103",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      410.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "yaw pitch roll \u00b7 degrees",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-104",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      432.0,
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
     "id": "obj-105",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      432.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-106",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      432.0,
      48.0,
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
     "id": "obj-107",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      432.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-108",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      432.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-109",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      432.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-110",
     "maxclass": "flonum",
     "patching_rect": [
      512.0,
      432.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-111",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      434.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "w x y z",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-112",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      456.0,
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
     "id": "obj-113",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      456.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-114",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      456.0,
      48.0,
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
     "id": "obj-115",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      456.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-116",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      456.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-117",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      456.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-118",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      456.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-119",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      458.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 microtesla",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-120",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      484.0,
      600.0,
      20.0
     ],
     "style": "",
     "text": "Raw sensors, no fusion",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-121",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      506.0,
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
     "id": "obj-122",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      506.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-123",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      506.0,
      48.0,
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
     "id": "obj-124",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      506.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-125",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      506.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-126",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      506.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-127",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      506.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-128",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      508.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 m/s\u00b2, gravity included",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-129",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      530.0,
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
     "id": "obj-130",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      530.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-131",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      530.0,
      48.0,
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
     "id": "obj-132",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      530.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-133",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      530.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-134",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      530.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-135",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      530.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-136",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      532.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 rad/s",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-137",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      554.0,
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
     "id": "obj-138",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      554.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-139",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      554.0,
      48.0,
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
     "id": "obj-140",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      554.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-141",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      554.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-142",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      554.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-143",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      554.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-144",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      556.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 microtesla",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-145",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      582.0,
      600.0,
      20.0
     ],
     "style": "",
     "text": "Environment",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-146",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      604.0,
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
     "id": "obj-147",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      604.0,
      84.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-148",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      604.0,
      48.0,
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
     "id": "obj-149",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      604.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-150",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      604.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-151",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      606.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "kPa, altitude m",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-152",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      628.0,
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
     "id": "obj-153",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      628.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-154",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      628.0,
      48.0,
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
     "id": "obj-155",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      628.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-156",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      628.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-157",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      628.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-158",
     "maxclass": "flonum",
     "patching_rect": [
      512.0,
      628.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-159",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      630.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "lat lon alt speed",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-160",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      652.0,
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
     "id": "obj-161",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      652.0,
      64.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-162",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      652.0,
      48.0,
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
     "id": "obj-163",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      652.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-164",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      654.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "degrees from true north",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-165",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      676.0,
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
     "id": "obj-166",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      676.0,
      104.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-167",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      676.0,
      48.0,
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
     "id": "obj-168",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      676.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-169",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      676.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-170",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      676.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-171",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      678.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "count, cadence /s, distance m",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-172",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      700.0,
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
     "id": "obj-173",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      700.0,
      104.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-174",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      700.0,
      48.0,
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
     "id": "obj-175",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      700.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-176",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      700.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-177",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      700.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-178",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      702.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "proximity, battery, orientation",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-179",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      728.0,
      600.0,
      20.0
     ],
     "style": "",
     "text": "AirPods \u2014 the native app reaches these, the browser cannot",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-180",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      750.0,
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
     "id": "obj-181",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      750.0,
      104.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-182",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      750.0,
      48.0,
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
     "id": "obj-183",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      750.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-184",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      750.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-185",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      750.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-186",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      752.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "yaw pitch roll \u00b7 degrees",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-187",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      774.0,
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
     "id": "obj-188",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      774.0,
      124.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f f",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-189",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      774.0,
      48.0,
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
     "id": "obj-190",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      774.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-191",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      774.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-192",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      774.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-193",
     "maxclass": "flonum",
     "patching_rect": [
      582.0,
      774.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-194",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      776.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "x y z \u00b7 m/s\u00b2",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-195",
     "maxclass": "comment",
     "patching_rect": [
      20.0,
      802.0,
      600.0,
      20.0
     ],
     "style": "",
     "text": "Audio \u2014 onset detection, computed on the phone",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 13
    }
   },
   {
    "box": {
     "id": "obj-196",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      824.0,
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
     "id": "obj-197",
     "maxclass": "newobj",
     "patching_rect": [
      130.0,
      824.0,
      104.0,
      22.0
     ],
     "style": "",
     "text": "unpack f f f f",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "float",
      "float",
      "float",
      "float"
     ],
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-198",
     "maxclass": "number",
     "patching_rect": [
      274.0,
      824.0,
      48.0,
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
     "id": "obj-199",
     "maxclass": "flonum",
     "patching_rect": [
      338.0,
      824.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-200",
     "maxclass": "flonum",
     "patching_rect": [
      396.0,
      824.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-201",
     "maxclass": "flonum",
     "patching_rect": [
      454.0,
      824.0,
      54.0,
      22.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "format": 6,
     "parameter_enable": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-202",
     "maxclass": "comment",
     "patching_rect": [
      650.0,
      826.0,
      176.0,
      20.0
     ],
     "style": "",
     "text": "rms, peak 0\u20131 \u00b7 onset dB rise",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-203",
     "maxclass": "newobj",
     "patching_rect": [
      20.0,
      856.0,
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
     "id": "obj-204",
     "maxclass": "message",
     "patching_rect": [
      130.0,
      856.0,
      440.0,
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
     "id": "obj-205",
     "maxclass": "comment",
     "patching_rect": [
      580.0,
      858.0,
      250.0,
      20.0
     ],
     "style": "",
     "text": "\u2190 channels with no row here",
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
      "obj-4",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-3",
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
      "obj-4",
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
      "obj-5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-8",
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
      "obj-8",
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
      "obj-22",
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
      "obj-23",
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
      "obj-28",
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
      "obj-31",
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
      "obj-32",
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
      "obj-7",
      0
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
      "obj-30",
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
      "obj-36",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-33",
      2
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
      "obj-34",
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
      "obj-35",
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
      "obj-36",
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
      "obj-10",
      2
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
      "obj-10",
      3
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
      "obj-10",
      4
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
      "obj-38",
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
      "obj-41",
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
      "obj-39",
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
      "obj-10",
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
      "obj-47",
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
      "obj-48",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-49",
      1
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
      "obj-49",
      2
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-48",
      2
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
      "obj-74",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-73",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-75",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-74",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-76",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-74",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-77",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-74",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-78",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-74",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-79",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-74",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-82",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-81",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-83",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-82",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-84",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-82",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-85",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-82",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-86",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-82",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-87",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-82",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-81",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-73",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-90",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-89",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-91",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-90",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-92",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-90",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-93",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-90",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-94",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-90",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-95",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-90",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-89",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-81",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-98",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-97",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-99",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-98",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-100",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-98",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-101",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-98",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-102",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-98",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-97",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-89",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-105",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-104",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-106",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-105",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-107",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-105",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-108",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-105",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-109",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-105",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-110",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-105",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-104",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-97",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-113",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-112",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-114",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-113",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-115",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-113",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-116",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-113",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-117",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-113",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-118",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-113",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-112",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-104",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-122",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-121",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-123",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-122",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-124",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-122",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-125",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-122",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-126",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-122",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-127",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-122",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-121",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-112",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-130",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-129",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-131",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-130",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-132",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-130",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-133",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-130",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-134",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-130",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-135",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-130",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-129",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-121",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-138",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-137",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-139",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-138",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-140",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-138",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-141",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-138",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-142",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-138",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-143",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-138",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-137",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-129",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-147",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-146",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-148",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-147",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-149",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-147",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-150",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-147",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-146",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-137",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-153",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-152",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-154",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-153",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-155",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-153",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-156",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-153",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-157",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-153",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-158",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-153",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-152",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-146",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-161",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-160",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-162",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-161",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-163",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-161",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-160",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-152",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-166",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-165",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-167",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-166",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-168",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-166",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-169",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-166",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-170",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-166",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-165",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-160",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-173",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-172",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-174",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-173",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-175",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-173",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-176",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-173",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-177",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-173",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-172",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-165",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-181",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-180",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-182",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-181",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-183",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-181",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-184",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-181",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-185",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-181",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-180",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-172",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-188",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-187",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-189",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-188",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-190",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-188",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-191",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-188",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-192",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-188",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-193",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-188",
      4
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-187",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-180",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-197",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-196",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-198",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-197",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-199",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-197",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-200",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-197",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-201",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-197",
      3
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-196",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-187",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-73",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-10",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-203",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-196",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "obj-204",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-203",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}
