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
   780.0,
   660.0
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
      4.0,
      4.0,
      240.0,
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
      246.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      4.0,
      44.0,
      700.0,
      20.0
     ],
     "style": "",
     "text": "Below here is invisible in the parent patch \u2014 the bpatcher shows only the menu above.",
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
      4.0,
      70.0,
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
     "maxclass": "newobj",
     "patching_rect": [
      76.0,
      70.0,
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
     "id": "obj-5",
     "maxclass": "message",
     "patching_rect": [
      4.0,
      100.0,
      700.0,
      22.0
     ],
     "style": "",
     "text": "clear, append ap.accel, append ap.gravity, append ap.gyro, append ap.attitude, append ap.quat, append ap.mag, append ap.accelg, append ap.gyroraw, append ap.magraw, append ap.pressure, append ap.location, append ap.heading, append ap.steps, append ap.device, append ap.head, append ap.headaccel, append ap.audio",
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
     "id": "obj-6",
     "maxclass": "newobj",
     "patching_rect": [
      4.0,
      130.0,
      160.0,
      22.0
     ],
     "style": "",
     "text": "patcherargs ap.accel",
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
     "id": "obj-7",
     "maxclass": "comment",
     "patching_rect": [
      174.0,
      132.0,
      530.0,
      20.0
     ],
     "style": "",
     "text": "the object's argument is the starting channel, and its default if you give none",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "newobj",
     "patching_rect": [
      4.0,
      160.0,
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
     "id": "obj-9",
     "maxclass": "newobj",
     "patching_rect": [
      200.0,
      160.0,
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
     "id": "obj-10",
     "maxclass": "comment",
     "patching_rect": [
      294.0,
      162.0,
      420.0,
      20.0
     ],
     "style": "",
     "text": "argument \u2192 menu + receive \u00b7 menu \u2192 receive",
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
      4.0,
      190.0,
      80.0,
      22.0
     ],
     "style": "",
     "text": "receive",
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
     "id": "obj-12",
     "maxclass": "comment",
     "patching_rect": [
      92.0,
      192.0,
      620.0,
      20.0
     ],
     "style": "",
     "text": "[receive] takes 'set <name>' at runtime. [route] cannot, which is the whole reason a dropdown is possible here.",
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
      4.0,
      230.0,
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
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      170.0,
      230.0,
      100.0,
      22.0
     ],
     "style": "",
     "text": "vexpr $f1*$f1",
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
      170.0,
      258.0,
      62.0,
      22.0
     ],
     "style": "",
     "text": "zl sum",
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
     "id": "obj-16",
     "maxclass": "newobj",
     "patching_rect": [
      170.0,
      286.0,
      110.0,
      22.0
     ],
     "style": "",
     "text": "expr sqrt($f1)",
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
     "id": "obj-17",
     "maxclass": "outlet",
     "patching_rect": [
      4.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "the whole channel as a list"
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "outlet",
     "patching_rect": [
      56.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "axis 1 \u2014 x, or yaw, or w"
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "outlet",
     "patching_rect": [
      108.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "axis 2 \u2014 y, or pitch"
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "outlet",
     "patching_rect": [
      160.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "axis 3 \u2014 z, or roll"
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "outlet",
     "patching_rect": [
      212.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "axis 4 \u2014 quat and location only"
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "outlet",
     "patching_rect": [
      264.0,
      330.0,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "magnitude \u2014 length of the vector"
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "comment",
     "patching_rect": [
      4.0,
      374.0,
      700.0,
      34.0
     ],
     "style": "",
     "text": "An axis outlet holds its last value when the channel has fewer axes \u2014 'heading' only ever fires outlet 1. Magnitude is meaningful for the vector channels: accel, gravity, gyro, mag and the raw ones.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12,
     "linecount": 2
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
      1
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
      "obj-4",
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
      "obj-6",
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
      "obj-8",
      0
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
      "obj-8",
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
      "obj-1",
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
      "obj-9",
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
      "obj-11",
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
      "obj-11",
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
      "obj-13",
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
      "obj-13",
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
      "obj-13",
      2
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
      "obj-13",
      3
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
      "obj-22",
      0
     ],
     "disabled": 0,
     "hidden": 0,
     "source": [
      "obj-16",
      0
     ]
    }
   }
  ],
  "dependency_cache": [],
  "autosave": 0
 }
}
