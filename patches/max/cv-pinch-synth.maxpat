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
			1330.0,
			1130.0
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
						20.0,
						10.0,
						700.0,
						24.0
					],
					"text": "cv-pinch-synth \u2014 two hands on the laptop camera, two saw/square voices",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 14.0
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						36.0,
						1300.0,
						22.0
					],
					"text": "Sender: uv run track-demo --osc max  (attention-cv, UDP 7500).   Rows are the stages of the chain, columns are the hands; the signal runs down the left of each column and each control comes in from the right at the stage it affects.",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						70.0,
						130.0,
						21.0
					],
					"text": "SHARED",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						90.0,
						140.0,
						40.0
					],
					"text": "set by hand, not by the camera",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						70.0,
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
					"id": "obj-6",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						170.0,
						100.0,
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
					"id": "obj-7",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						170.0,
						124.0,
						100.0,
						20.0
					],
					"text": "base Hz",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						300.0,
						70.0,
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
					"id": "obj-9",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						300.0,
						100.0,
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
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						300.0,
						124.0,
						100.0,
						20.0
					],
					"text": "pinched, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						430.0,
						70.0,
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
					"id": "obj-12",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						430.0,
						100.0,
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
					"id": "obj-13",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						430.0,
						124.0,
						100.0,
						20.0
					],
					"text": "open, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						560.0,
						70.0,
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
					"id": "obj-15",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						560.0,
						100.0,
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
					"id": "obj-16",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						124.0,
						100.0,
						20.0
					],
					"text": "resonance",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						700.0,
						100.0,
						600.0,
						20.0
					],
					"text": "calibrate the pinch: read a pinch box with fingers touching, then wide apart, and type the two values in",
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
						20.0,
						160.0,
						130.0,
						21.0
					],
					"text": "IN",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						160.0,
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
					"id": "obj-20",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						170.0,
						195.0,
						300.0,
						21.0
					],
					"text": "LEFT HAND \u2014 base pitch",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						760.0,
						195.0,
						300.0,
						21.0
					],
					"text": "RIGHT HAND \u2014 a fifth up",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						230.0,
						130.0,
						21.0
					],
					"text": "INPUTS",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						250.0,
						140.0,
						40.0
					],
					"text": "one route per hand;\nreadouts at 2 Hz",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						330.0,
						140.0,
						21.0
					],
					"text": "OSCILLATORS",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						350.0,
						140.0,
						60.0
					],
					"text": "height blends\nsquare (low) \u2194 saw (raised)\nequal-power",
					"linecount": 3
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						500.0,
						130.0,
						21.0
					],
					"text": "FILTER",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						520.0,
						140.0,
						60.0
					],
					"text": "pinch, metres \u2192\nMIDI note \u2192 Hz\n(exponential sweep)",
					"linecount": 3
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						720.0,
						130.0,
						21.0
					],
					"text": "GATE",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						740.0,
						140.0,
						40.0
					],
					"text": "300 ms fade when\nthe hand leaves",
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
						20.0,
						830.0,
						130.0,
						21.0
					],
					"text": "PAN",
					"linecount": 1,
					"fontface": 1,
					"fontsize": 13.0
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						850.0,
						140.0,
						40.0
					],
					"text": "left\u2013right in the frame,\nequal-power",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						990.0,
						130.0,
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
					"id": "obj-33",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"patching_rect": [
						170.0,
						230.0,
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
					"id": "obj-34",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						265.0,
						96.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "speedlim 500"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						170.0,
						295.0,
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
					"id": "obj-36",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						235.0,
						295.0,
						70.0,
						20.0
					],
					"text": "pinch, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						360.0,
						265.0,
						96.0,
						22.0
					],
					"outlettype": [
						"float",
						"float",
						"float"
					],
					"text": "unpack f f f"
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						460.0,
						265.0,
						200.0,
						20.0
					],
					"text": "x y z  (0\u20131, y = 0 at the top)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						400.0,
						295.0,
						96.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "speedlim 500"
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						400.0,
						325.0,
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
					"id": "obj-41",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						465.0,
						325.0,
						60.0,
						20.0
					],
					"text": "height",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						600.0,
						265.0,
						54.0,
						22.0
					],
					"outlettype": [
						"int",
						"int",
						"int"
					],
					"text": "change"
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						660.0,
						265.0,
						60.0,
						20.0
					],
					"text": "present",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						360.0,
						50.0,
						22.0
					],
					"outlettype": [
						"float"
					],
					"text": "* 1."
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "rect~ 110"
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						260.0,
						395.0,
						68.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "saw~ 110"
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						360.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr sin($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						520.0,
						360.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr cos($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						520.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						360.0,
						430.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						520.0,
						430.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						465.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						260.0,
						465.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						465.0,
						200.0,
						20.0
					],
					"text": "square gain      saw gain",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						500.0,
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
					"id": "obj-57",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						500.0,
						180.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "scale 0.02 0.12 45. 120."
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						535.0,
						103.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "clip 45. 120."
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						570.0,
						40.0,
						22.0
					],
					"outlettype": [
						"float"
					],
					"text": "mtof"
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						605.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						360.0,
						640.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						460.0,
						570.0,
						120.0,
						20.0
					],
					"text": "110 Hz \u2026 8.4 kHz",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						675.0,
						117.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "lores~ 1000 0.6"
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						290.0,
						675.0,
						120.0,
						20.0
					],
					"text": "cutoff \u2191    Q \u2191",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						600.0,
						720.0,
						82.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 300"
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						600.0,
						755.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						790.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						830.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr cos($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						520.0,
						830.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr sin($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						360.0,
						865.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						520.0,
						865.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						360.0,
						900.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						520.0,
						900.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						935.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						260.0,
						935.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						360.0,
						935.0,
						200.0,
						20.0
					],
					"text": "left gain         right gain",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 4,
					"patching_rect": [
						760.0,
						230.0,
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
					"id": "obj-78",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						265.0,
						96.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "speedlim 500"
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						760.0,
						295.0,
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
					"id": "obj-80",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						825.0,
						295.0,
						70.0,
						20.0
					],
					"text": "pinch, m",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						950.0,
						265.0,
						96.0,
						22.0
					],
					"outlettype": [
						"float",
						"float",
						"float"
					],
					"text": "unpack f f f"
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1050.0,
						265.0,
						200.0,
						20.0
					],
					"text": "x y z  (0\u20131, y = 0 at the top)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						990.0,
						295.0,
						96.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "speedlim 500"
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						990.0,
						325.0,
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
					"id": "obj-85",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1055.0,
						325.0,
						60.0,
						20.0
					],
					"text": "height",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						1190.0,
						265.0,
						54.0,
						22.0
					],
					"outlettype": [
						"int",
						"int",
						"int"
					],
					"text": "change"
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1250.0,
						265.0,
						60.0,
						20.0
					],
					"text": "present",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						360.0,
						50.0,
						22.0
					],
					"outlettype": [
						"float"
					],
					"text": "* 1.5"
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "rect~ 110"
				}
			},
			{
				"box": {
					"id": "obj-90",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						850.0,
						395.0,
						68.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "saw~ 110"
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						360.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr sin($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-92",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						1110.0,
						360.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr cos($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-94",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1110.0,
						395.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						950.0,
						430.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-96",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						1110.0,
						430.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						465.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-98",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						850.0,
						465.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						950.0,
						465.0,
						200.0,
						20.0
					],
					"text": "square gain      saw gain",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						500.0,
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
					"id": "obj-101",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						500.0,
						180.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "scale 0.02 0.12 45. 120."
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						535.0,
						103.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "clip 45. 120."
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						570.0,
						40.0,
						22.0
					],
					"outlettype": [
						"float"
					],
					"text": "mtof"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						605.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						950.0,
						640.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1050.0,
						570.0,
						120.0,
						20.0
					],
					"text": "110 Hz \u2026 8.4 kHz",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						675.0,
						117.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "lores~ 1000 0.6"
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						880.0,
						675.0,
						120.0,
						20.0
					],
					"text": "cutoff \u2191    Q \u2191",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1190.0,
						720.0,
						82.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 300"
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						1190.0,
						755.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						790.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						830.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr cos($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						1110.0,
						830.0,
						150.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "expr sin($f1*1.5708)"
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						950.0,
						865.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1110.0,
						865.0,
						75.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "pack f 80"
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						950.0,
						900.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						1110.0,
						900.0,
						47.0,
						22.0
					],
					"outlettype": [
						"signal",
						"bang"
					],
					"text": "line~"
				}
			},
			{
				"box": {
					"id": "obj-118",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						760.0,
						935.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						850.0,
						935.0,
						40.0,
						22.0
					],
					"outlettype": [
						"signal"
					],
					"text": "*~"
				}
			},
			{
				"box": {
					"id": "obj-120",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						950.0,
						935.0,
						200.0,
						20.0
					],
					"text": "left gain         right gain",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-121",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						990.0,
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
					"id": "obj-122",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						260.0,
						990.0,
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
					"id": "obj-123",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						310.0,
						990.0,
						200.0,
						20.0
					],
					"text": "left                right",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						170.0,
						1025.0,
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
					"id": "obj-125",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						260.0,
						1025.0,
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
					"id": "obj-126",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						170.0,
						1060.0,
						45.0,
						45.0
					]
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						225.0,
						1072.0,
						120.0,
						20.0
					],
					"text": "click for audio",
					"linecount": 1
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-5",
						0
					],
					"destination": [
						"obj-6",
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
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
						0
					],
					"destination": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-14",
						0
					],
					"destination": [
						"obj-15",
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
						"obj-33",
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
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						1
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
						"obj-37",
						1
					],
					"destination": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-39",
						0
					],
					"destination": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						2
					],
					"destination": [
						"obj-42",
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
						"obj-44",
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
						"obj-45",
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
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						1
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
						"obj-37",
						1
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
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						0
					],
					"destination": [
						"obj-50",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-52",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-53",
						1
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
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-54",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-56",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						0
					],
					"destination": [
						"obj-56",
						1
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
						"obj-57",
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
						"obj-57",
						1
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
						"obj-57",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-57",
						0
					],
					"destination": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-58",
						0
					],
					"destination": [
						"obj-59",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						0
					],
					"destination": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-56",
						0
					],
					"destination": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-61",
						0
					],
					"destination": [
						"obj-63",
						1
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
						"obj-63",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-65",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-65",
						0
					],
					"destination": [
						"obj-66",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-63",
						0
					],
					"destination": [
						"obj-67",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						0
					],
					"destination": [
						"obj-67",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						0
					],
					"destination": [
						"obj-70",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						0
					],
					"destination": [
						"obj-71",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						0
					],
					"destination": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-71",
						0
					],
					"destination": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-67",
						0
					],
					"destination": [
						"obj-74",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						0
					],
					"destination": [
						"obj-74",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-67",
						0
					],
					"destination": [
						"obj-75",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-75",
						1
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
						"obj-77",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-78",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-78",
						0
					],
					"destination": [
						"obj-79",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						1
					],
					"destination": [
						"obj-81",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						1
					],
					"destination": [
						"obj-83",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						0
					],
					"destination": [
						"obj-84",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						2
					],
					"destination": [
						"obj-86",
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
						"obj-88",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-88",
						0
					],
					"destination": [
						"obj-89",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-88",
						0
					],
					"destination": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						1
					],
					"destination": [
						"obj-91",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						1
					],
					"destination": [
						"obj-92",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-91",
						0
					],
					"destination": [
						"obj-93",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						0
					],
					"destination": [
						"obj-94",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						0
					],
					"destination": [
						"obj-95",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-96",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-89",
						0
					],
					"destination": [
						"obj-97",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-95",
						0
					],
					"destination": [
						"obj-97",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-90",
						0
					],
					"destination": [
						"obj-98",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-96",
						0
					],
					"destination": [
						"obj-98",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-97",
						0
					],
					"destination": [
						"obj-100",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-98",
						0
					],
					"destination": [
						"obj-100",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-101",
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
						"obj-101",
						1
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
						"obj-101",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-101",
						0
					],
					"destination": [
						"obj-102",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-102",
						0
					],
					"destination": [
						"obj-103",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-103",
						0
					],
					"destination": [
						"obj-104",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-104",
						0
					],
					"destination": [
						"obj-105",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-100",
						0
					],
					"destination": [
						"obj-107",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-105",
						0
					],
					"destination": [
						"obj-107",
						1
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
						"obj-107",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						0
					],
					"destination": [
						"obj-110",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-107",
						0
					],
					"destination": [
						"obj-111",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-110",
						0
					],
					"destination": [
						"obj-111",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-112",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-112",
						0
					],
					"destination": [
						"obj-114",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-113",
						0
					],
					"destination": [
						"obj-115",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-114",
						0
					],
					"destination": [
						"obj-116",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-115",
						0
					],
					"destination": [
						"obj-117",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						0
					],
					"destination": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-116",
						0
					],
					"destination": [
						"obj-118",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						0
					],
					"destination": [
						"obj-119",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-117",
						0
					],
					"destination": [
						"obj-119",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-74",
						0
					],
					"destination": [
						"obj-121",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-118",
						0
					],
					"destination": [
						"obj-121",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						0
					],
					"destination": [
						"obj-122",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-119",
						0
					],
					"destination": [
						"obj-122",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-121",
						0
					],
					"destination": [
						"obj-124",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						0
					],
					"destination": [
						"obj-125",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-124",
						0
					],
					"destination": [
						"obj-126",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-125",
						0
					],
					"destination": [
						"obj-126",
						1
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
