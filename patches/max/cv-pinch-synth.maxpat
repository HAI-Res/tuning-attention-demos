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
			59.0,
			87.0,
			1080.0,
			760.0
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
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						15.0,
						760.0,
						100.0
					],
					"text": "cv-pinch-synth \u2014 two hands on the laptop camera, two saw/square voices.\nSender:  uv run track-demo --osc max      (attention-cv, UDP 7500)\nEach hand: pinch (thumb tip to index tip) opens a lowpass; hand height in the frame pans\nsquare (low) \u2194 saw (raised), equal-power; left\u2013right in the frame pans it in the stereo field. Left hand plays the base pitch, right hand a fifth up.\nNothing on screen moves faster than 2 Hz.",
					"linecount": 5
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						130.0,
						117.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "udpreceive 7500"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 7,
					"patching_rect": [
						30.0,
						165.0,
						936.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						"",
						"",
						"",
						""
					],
					"text": "route /cv/hand/left/pinch /cv/hand/left/wrist /cv/hand/left/present /cv/hand/right/pinch /cv/hand/right/wrist /cv/hand/right/present"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						195.0,
						560.0,
						40.0
					],
					"text": "six fixed addresses, so [route] is enough \u2014 no js, no receiver bpatcher.\nleft/right is MediaPipe's label; if swapped, run track-demo --swap-hands.",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						250.0,
						320.0,
						20.0
					],
					"text": "SHARED \u2014 set by hand, not by the camera",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						280.0,
						92.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "loadmess 110."
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						30.0,
						310.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						335.0,
						80.0,
						20.0
					],
					"text": "base Hz",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						130.0,
						280.0,
						92.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "loadmess 0.02"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						130.0,
						310.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						130.0,
						335.0,
						90.0,
						20.0
					],
					"text": "pinched, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						230.0,
						280.0,
						92.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "loadmess 0.12"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						230.0,
						310.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						230.0,
						335.0,
						80.0,
						20.0
					],
					"text": "open, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						330.0,
						280.0,
						92.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "loadmess 0.6"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						330.0,
						310.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						330.0,
						335.0,
						80.0,
						20.0
					],
					"text": "resonance",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						360.0,
						480.0,
						40.0
					],
					"text": "calibrate the pinch: read a hand's pinch box with fingers touching, then wide\napart, and type those two values here. Outside the range is clipped, not extrapolated.",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"numinlets": 7,
					"numoutlets": 4,
					"patching_rect": [
						30.0,
						450.0,
						250.0,
						22.0
					],
					"outlettype": [
						"signal",
						"signal",
						"",
						""
					],
					"text": "cv-pinch-voice 1."
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"numinlets": 7,
					"numoutlets": 4,
					"patching_rect": [
						330.0,
						450.0,
						250.0,
						22.0
					],
					"outlettype": [
						"signal",
						"signal",
						"",
						""
					],
					"text": "cv-pinch-voice 1.5"
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						425.0,
						200.0,
						20.0
					],
					"text": "LEFT hand, base pitch",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						330.0,
						425.0,
						240.0,
						20.0
					],
					"text": "RIGHT hand, a fifth up (\u00d7 1.5)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						120.0,
						490.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						490.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						420.0,
						490.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						500.0,
						490.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						120.0,
						515.0,
						260.0,
						20.0
					],
					"text": "pinch, m        y            (2 Hz)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						420.0,
						515.0,
						260.0,
						20.0
					],
					"text": "pinch, m        y            (2 Hz)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						560.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "+~"
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						90.0,
						560.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "+~"
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						140.0,
						560.0,
						200.0,
						20.0
					],
					"text": "left            right",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						595.0,
						50.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~ 0.3"
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						90.0,
						595.0,
						50.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~ 0.3"
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						635.0,
						45.0,
						45.0
					]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						85.0,
						647.0,
						160.0,
						20.0
					],
					"text": "click to start audio",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						700.0,
						620.0,
						20.0
					],
					"text": "Open cv-pinch-voice.maxpat to see inside a voice. It must stay in this folder next to this patch.",
					"linecount": 1
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-2",
						0
					],
					"destination": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-6",
						0
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						0
					],
					"destination": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-12",
						0
					],
					"destination": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-15",
						0
					],
					"destination": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						0
					],
					"destination": [
						"obj-19",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						3
					],
					"destination": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						1
					],
					"destination": [
						"obj-19",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						4
					],
					"destination": [
						"obj-20",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						2
					],
					"destination": [
						"obj-19",
						4
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						5
					],
					"destination": [
						"obj-20",
						4
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-19",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						0
					],
					"destination": [
						"obj-19",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
						0
					],
					"destination": [
						"obj-19",
						5
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-16",
						0
					],
					"destination": [
						"obj-19",
						6
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-20",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						0
					],
					"destination": [
						"obj-20",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
						0
					],
					"destination": [
						"obj-20",
						5
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-16",
						0
					],
					"destination": [
						"obj-20",
						6
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						2
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						3
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						2
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						3
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						0
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						0
					],
					"destination": [
						"obj-29",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						1
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						1
					],
					"destination": [
						"obj-30",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-30",
						0
					],
					"destination": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						0
					],
					"destination": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						0
					],
					"destination": [
						"obj-34",
						1
					]
				}
			}
		],
		"dependency_cache": [
			{
				"name": "cv-pinch-voice.maxpat",
				"bootpath": "~/Documents/2026/MIT/class-demos/patches/max",
				"patcherrelativepath": ".",
				"type": "JSON",
				"implicit": 1
			}
		],
		"autosave": 0
	}
}
