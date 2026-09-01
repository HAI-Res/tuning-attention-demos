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
   1060.0,
   850.0
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
      20,
      8,
      700,
      30.0
     ],
     "style": "",
     "text": "attention-cv \u2014 camera landmarks into Max",
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
      20,
      42,
      720,
      21.6
     ],
     "style": "",
     "text": "One receiver, then as many taps as you want. Each tap picks a channel from the dropdown. Run: uv run track-demo --osc max",
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
      20,
      74,
      390,
      206
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 0,
     "outlettype": [],
     "name": "cv.receive.maxpat",
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
      425,
      74,
      300,
      21.6
     ],
     "style": "",
     "text": "The receiver. Exactly one per Max session \u2014 it owns the UDP socket.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "comment",
     "patching_rect": [
      425,
      110,
      320,
      21.6
     ],
     "style": "",
     "text": "Nothing arrives? Run `uv run osc-dump 7500` instead of Max: it says whether the packets exist at all, which Max cannot.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "comment",
     "patching_rect": [
      425,
      170,
      320,
      21.6
     ],
     "style": "",
     "text": "7500, not 7400 \u2014 that one belongs to the phone receiver, and one UDP port takes one receiver. This way both can run at once.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "comment",
     "patching_rect": [
      20,
      300,
      500,
      25.2
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
     "id": "obj-8",
     "maxclass": "comment",
     "patching_rect": [
      20,
      326,
      720,
      21.6
     ],
     "style": "",
     "text": "Outlets, left to right: the whole list \u00b7 x \u00b7 y \u00b7 z \u00b7 magnitude. Lock the patch (\u2318E) to click a dropdown.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "bpatcher",
     "patching_rect": [
      20,
      360,
      250,
      28
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "cv.point.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "cv.hand.right.index_tip"
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "comment",
     "patching_rect": [
      280,
      362,
      440,
      21.6
     ],
     "style": "",
     "text": "index fingertip, image space \u2014 x and y are 0\u20131 across the frame",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "bpatcher",
     "patching_rect": [
      20,
      400,
      250,
      28
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "cv.point.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "cv.pose.0.center"
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "patching_rect": [
      280,
      402,
      440,
      21.6
     ],
     "style": "",
     "text": "hip midpoint \u2014 the steadiest 'where is this person' point there is",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "bpatcher",
     "patching_rect": [
      20,
      440,
      250,
      28
     ],
     "style": "",
     "numinlets": 0,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "name": "cv.point.maxpat",
     "embed": 0,
     "offset": [
      0.0,
      0.0
     ],
     "args": [
      "cv.hand.right.pinch"
     ]
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "comment",
     "patching_rect": [
      280,
      442,
      440,
      21.6
     ],
     "style": "",
     "text": "thumb tip to index tip, in METRES \u2014 the same distance up close and across the room",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "comment",
     "patching_rect": [
      20,
      500,
      500,
      25.2
     ],
     "style": "",
     "text": "A worked example: pinch \u2192 pitch",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 14
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "comment",
     "patching_rect": [
      20,
      526,
      720,
      21.6
     ],
     "style": "",
     "text": "The pinch tap's x outlet drives this. Change the four numbers in [scale] first; that one object is most of the mapping.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      560,
      210,
      22.0
     ],
     "style": "",
     "text": "scale 0.02 0.15 220. 2000.",
     "numinlets": 6,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "comment",
     "patching_rect": [
      240,
      562,
      460,
      21.6
     ],
     "style": "",
     "text": "0.02\u20130.15 m onto 220\u20132000 Hz. A closed pinch is ~2 cm.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontname": "Arial",
     "fontsize": 12
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      594,
      90,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      626,
      60,
      22.0
     ],
     "style": "",
     "text": "line~",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ],
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "comment",
     "patching_rect": [
      120,
      596,
      500,
      21.6
     ],
     "style": "",
     "text": "20 ms of glide, so a jittery landmark does not zipper the pitch",
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
      20,
      658,
      90,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      690,
      70,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "ezdac~",
     "patching_rect": [
      20.0,
      726.0,
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
     "id": "obj-25",
     "maxclass": "toggle",
     "patching_rect": [
      76,
      736,
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
     "id": "obj-26",
     "maxclass": "comment",
     "patching_rect": [
      106,
      739,
      200,
      21.6
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
     "id": "obj-27",
     "maxclass": "comment",
     "patching_rect": [
      20,
      786,
      720,
      21.6
     ],
     "style": "",
     "text": "Nothing here updates a number box, so nothing on screen moves at the camera's rate. That is deliberate \u2014 see the README.",
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
      "obj-17",
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
      "obj-19",
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
      "obj-22",
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
      "obj-24",
      1
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
      "obj-24",
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