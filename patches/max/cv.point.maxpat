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
   560.0
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
     "maxclass": "umenu",
     "patching_rect": [
      2,
      3,
      244,
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
     "arrow": 1,
     "depth": 1,
     "prefix": "",
     "types": [],
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      10,
      50,
      620,
      21.6
     ],
     "style": "",
     "text": "Below here is invisible in the parent patch \u2014 the bpatcher only shows its top strip.",
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
      10,
      80,
      70,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "newobj",
     "patching_rect": [
      10,
      112,
      60,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "message",
     "patching_rect": [
      110,
      150,
      700,
      60.0
     ],
     "style": "",
     "text": "clear, append cv.hand.left.present, append cv.hand.left.norm, append cv.hand.left.world, append cv.hand.left.wrist, append cv.hand.left.thumb_tip, append cv.hand.left.index_tip, append cv.hand.left.middle_tip, append cv.hand.left.ring_tip, append cv.hand.left.pinky_tip, append cv.hand.left.pinch, append cv.hand.left.spread, append cv.hand.right.present, append cv.hand.right.norm, append cv.hand.right.world, append cv.hand.right.wrist, append cv.hand.right.thumb_tip, append cv.hand.right.index_tip, append cv.hand.right.middle_tip, append cv.hand.right.ring_tip, append cv.hand.right.pinky_tip, append cv.hand.right.pinch, append cv.hand.right.spread, append cv.pose.0.present, append cv.pose.0.norm, append cv.pose.0.world, append cv.pose.0.visibility, append cv.pose.0.nose, append cv.pose.0.left_shoulder, append cv.pose.0.right_shoulder, append cv.pose.0.left_elbow, append cv.pose.0.right_elbow, append cv.pose.0.left_wrist, append cv.pose.0.right_wrist, append cv.pose.0.left_hip, append cv.pose.0.right_hip, append cv.pose.0.left_knee, append cv.pose.0.right_knee, append cv.pose.0.left_ankle, append cv.pose.0.right_ankle, append cv.pose.0.center, append cv.pose.0.hands_apart",
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
     "id": "obj-6",
     "maxclass": "newobj",
     "patching_rect": [
      10,
      150,
      220,
      22.0
     ],
     "style": "",
     "text": "patcherargs cv.hand.right.index_tip",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "fontname": "Arial",
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "comment",
     "patching_rect": [
      240,
      152,
      420,
      21.6
     ],
     "style": "",
     "text": "the object's argument is the starting channel, and what persists \u2014 edit @args to make a choice stick",
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
      10,
      190,
      80,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "newobj",
     "patching_rect": [
      120,
      230,
      80,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "comment",
     "patching_rect": [
      10,
      222,
      100,
      21.6
     ],
     "style": "",
     "text": "argument \u2192 menu",
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
      10,
      270,
      70,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "comment",
     "patching_rect": [
      90,
      272,
      560,
      21.6
     ],
     "style": "",
     "text": "[receive] takes 'set <name>' at runtime \u2014 that is the whole reason a dropdown is possible here. [route] cannot.",
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
      120,
      320,
      120,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      330,
      320,
      100,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      330,
      352,
      60,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "newobj",
     "patching_rect": [
      330,
      384,
      110,
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
     "fontsize": 12.0
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "outlet",
     "patching_rect": [
      10,
      430,
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
      120,
      430,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "x / first axis"
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "outlet",
     "patching_rect": [
      190,
      430,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "y / second axis"
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "outlet",
     "patching_rect": [
      260,
      430,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "z / third axis"
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "outlet",
     "patching_rect": [
      330,
      430,
      30.0,
      30.0
     ],
     "style": "",
     "numinlets": 1,
     "numoutlets": 0,
     "comment": "magnitude"
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "comment",
     "patching_rect": [
      10,
      470,
      620,
      21.6
     ],
     "style": "",
     "text": "A bulk channel (norm, world, visibility) puts its whole list on outlet 0; the axis outlets show only its first three numbers.",
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
      "obj-21",
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