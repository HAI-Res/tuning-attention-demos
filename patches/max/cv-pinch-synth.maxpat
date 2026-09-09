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
			880.0,
			780.0
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
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						70.0,
						800.0,
						140.0
					],
					"mode": 0,
					"proportion": 0.5,
					"rounded": 10,
					"border": 0,
					"bgcolor": [
						0.86,
						0.91,
						0.98,
						1.0
					],
					"bgfillcolor_type": "color",
					"bgfillcolor_color": [
						0.86,
						0.91,
						0.98,
						1.0
					],
					"bgfillcolor_color1": [
						0.86,
						0.91,
						0.98,
						1.0
					],
					"bgfillcolor_color2": [
						0.2,
						0.2,
						0.2,
						1.0
					],
					"bgfillcolor_angle": 270.0,
					"bgfillcolor_autogradient": 0.0,
					"bgfillcolor_proportion": 0.39
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						225.0,
						800.0,
						170.0
					],
					"mode": 0,
					"proportion": 0.5,
					"rounded": 10,
					"border": 0,
					"bgcolor": [
						1.0,
						0.96,
						0.82,
						1.0
					],
					"bgfillcolor_type": "color",
					"bgfillcolor_color": [
						1.0,
						0.96,
						0.82,
						1.0
					],
					"bgfillcolor_color1": [
						1.0,
						0.96,
						0.82,
						1.0
					],
					"bgfillcolor_color2": [
						0.2,
						0.2,
						0.2,
						1.0
					],
					"bgfillcolor_angle": 270.0,
					"bgfillcolor_autogradient": 0.0,
					"bgfillcolor_proportion": 0.39
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						410.0,
						800.0,
						130.0
					],
					"mode": 0,
					"proportion": 0.5,
					"rounded": 10,
					"border": 0,
					"bgcolor": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_type": "color",
					"bgfillcolor_color": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_color1": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_color2": [
						0.2,
						0.2,
						0.2,
						1.0
					],
					"bgfillcolor_angle": 270.0,
					"bgfillcolor_autogradient": 0.0,
					"bgfillcolor_proportion": 0.39
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "panel",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						555.0,
						300.0,
						170.0
					],
					"mode": 0,
					"proportion": 0.5,
					"rounded": 10,
					"border": 0,
					"bgcolor": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_type": "color",
					"bgfillcolor_color": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_color1": [
						0.9,
						0.9,
						0.9,
						1.0
					],
					"bgfillcolor_color2": [
						0.2,
						0.2,
						0.2,
						1.0
					],
					"bgfillcolor_angle": 270.0,
					"bgfillcolor_autogradient": 0.0,
					"bgfillcolor_proportion": 0.39
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
						10.0,
						700.0,
						22.0
					],
					"text": "cv-pinch-synth \u2014 two hands on the laptop camera, two saw/square voices.",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 14.0,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						10.0,
						600.0,
						24.0
					]
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						34.0,
						900.0,
						36.0
					],
					"text": "Sender:  uv run track-demo --osc max     Pinch opens a lowpass \u00b7 height blends square\u2192saw \u00b7 left\u2013right pans.\nLeft hand: base pitch.  Right hand: a fifth up.  \u2318\u2325E toggles the presentation view.",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						78.0,
						400.0,
						21.0
					],
					"text": "IN \u2014 the camera, as OSC on UDP 7500",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						45.0,
						108.0,
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
					"id": "obj-9",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"patching_rect": [
						45.0,
						145.0,
						481.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"text": "route /cv/hand/left/pinch /cv/hand/left/wrist /cv/hand/left/present"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"patching_rect": [
						45.0,
						178.0,
						502.0,
						22.0
					],
					"outlettype": [
						"",
						"",
						"",
						""
					],
					"text": "route /cv/hand/right/pinch /cv/hand/right/wrist /cv/hand/right/present"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						145.0,
						260.0,
						20.0
					],
					"text": "left hand:  pinch \u00b7 wrist \u00b7 present",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						570.0,
						178.0,
						200.0,
						20.0
					],
					"text": "right hand",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						108.0,
						400.0,
						20.0
					],
					"text": "(--swap-hands on the sender if they're the wrong way round)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						233.0,
						400.0,
						21.0
					],
					"text": "SHARED \u2014 set by hand, not by the camera",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						45.0,
						263.0,
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
					"id": "obj-16",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						45.0,
						293.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						45.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						317.0,
						100.0,
						20.0
					],
					"text": "base Hz",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						70.0,
						110.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						155.0,
						263.0,
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
					"id": "obj-19",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						155.0,
						293.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						135.0,
						45.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						155.0,
						317.0,
						100.0,
						20.0
					],
					"text": "pinched, m",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						135.0,
						70.0,
						110.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						265.0,
						263.0,
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
					"id": "obj-22",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						265.0,
						293.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						255.0,
						45.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						265.0,
						317.0,
						100.0,
						20.0
					],
					"text": "open, m",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						255.0,
						70.0,
						110.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						375.0,
						263.0,
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
					"id": "obj-25",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						375.0,
						293.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						375.0,
						45.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						375.0,
						317.0,
						100.0,
						20.0
					],
					"text": "resonance",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						375.0,
						70.0,
						110.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 4,
					"numoutlets": 1,
					"patching_rect": [
						45.0,
						355.0,
						166.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pak 110. 0.02 0.12 0.6"
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						220.0,
						355.0,
						200.0,
						20.0
					],
					"text": "one list to both voices",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						490.0,
						263.0,
						330.0,
						60.0
					],
					"text": "calibrate the pinch: read a hand's pinch box with fingers touching, then wide apart,\nand type those two values in. Outside the range is clipped, not extrapolated.",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						418.0,
						100.0,
						21.0
					],
					"text": "VOICES",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "newobj",
					"numinlets": 4,
					"numoutlets": 4,
					"patching_rect": [
						45.0,
						445.0,
						230.0,
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
					"id": "obj-32",
					"maxclass": "newobj",
					"numinlets": 4,
					"numoutlets": 4,
					"patching_rect": [
						420.0,
						445.0,
						230.0,
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
					"id": "obj-33",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						175.0,
						485.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						120.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						245.0,
						485.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						85.0,
						120.0,
						60.0,
						22.0
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
						175.0,
						509.0,
						140.0,
						20.0
					],
					"text": "pinch, m     height",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						145.0,
						150.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						485.0,
						100.0,
						20.0
					],
					"text": "left hand",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						15.0,
						100.0,
						150.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						550.0,
						485.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						255.0,
						120.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						620.0,
						485.0,
						60.0,
						22.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"presentation": 1,
					"presentation_rect": [
						325.0,
						120.0,
						60.0,
						22.0
					]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						550.0,
						509.0,
						140.0,
						20.0
					],
					"text": "pinch, m     height",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						255.0,
						145.0,
						150.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						420.0,
						485.0,
						100.0,
						20.0
					],
					"text": "right hand",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						255.0,
						100.0,
						150.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						480.0,
						150.0,
						40.0
					],
					"text": "readouts at 2 Hz \u2014 nothing here\nmoves faster than that",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						563.0,
						100.0,
						21.0
					],
					"text": "OUT",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						45.0,
						595.0,
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
					"id": "obj-44",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						105.0,
						595.0,
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
					"id": "obj-45",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						160.0,
						595.0,
						120.0,
						20.0
					],
					"text": "left     right",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						45.0,
						630.0,
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
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						105.0,
						630.0,
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
					"id": "obj-48",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						45.0,
						665.0,
						45.0,
						45.0
					],
					"presentation": 1,
					"presentation_rect": [
						15.0,
						180.0,
						45.0,
						45.0
					]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						100.0,
						677.0,
						120.0,
						20.0
					],
					"text": "click for audio",
					"linecount": 1,
					"presentation": 1,
					"presentation_rect": [
						70.0,
						192.0,
						120.0,
						20.0
					]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						565.0,
						470.0,
						40.0
					],
					"text": "Open cv-pinch-voice.maxpat to see inside a voice.\nIt and cv-smooth.maxpat must stay in this folder.",
					"linecount": 2
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
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
						"obj-18",
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
						"obj-21",
						0
					],
					"destination": [
						"obj-22",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						0
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
						"obj-16",
						0
					],
					"destination": [
						"obj-27",
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
						"obj-27",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-27",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						0
					],
					"destination": [
						"obj-27",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-31",
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
						"obj-31",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						1
					],
					"destination": [
						"obj-31",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						2
					],
					"destination": [
						"obj-31",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
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
						"obj-10",
						0
					],
					"destination": [
						"obj-32",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						1
					],
					"destination": [
						"obj-32",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						2
					],
					"destination": [
						"obj-32",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						2
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
						"obj-31",
						3
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
						"obj-32",
						2
					],
					"destination": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						3
					],
					"destination": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-43",
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
						"obj-43",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						1
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						1
					],
					"destination": [
						"obj-44",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-44",
						0
					],
					"destination": [
						"obj-47",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						0
					],
					"destination": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-48",
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
