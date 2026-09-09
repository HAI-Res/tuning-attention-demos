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
			1120.0,
			660.0
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
						800.0,
						80.0
					],
					"text": "cv-pinch-voice #1 \u2014 one hand's saw/square voice. #1 is the pitch ratio on the base Hz\n(1. = as given, 1.5 = a fifth up). Inlets, left to right: pinch (m) \u00b7 pinch closed (m) \u00b7 pinch open (m) \u00b7\nwrist x y z \u00b7 present 0/1 \u00b7 base Hz \u00b7 resonance.  Outlets: signal L \u00b7 signal R \u00b7 pinch at 2 Hz \u00b7 y at 2 Hz.\nMax numbers inlets and outlets by their x position, so their order here IS the interface.",
					"linecount": 4
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "pinch, metres"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						330.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "wrist x y z, 0-1"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						680.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "present 0/1"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "base Hz"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						120.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "pinch closed, m"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						180.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "pinch open, m"
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "inlet",
					"numinlets": 0,
					"numoutlets": 1,
					"patching_rect": [
						1000.0,
						110.0,
						30.0,
						22.0
					],
					"outlettype": [
						""
					],
					"comment": "resonance 0-1"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						155.0,
						200.0,
						20.0
					],
					"text": "PINCH \u2192 filter cutoff",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						185.0,
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
					"id": "obj-11",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						220.0,
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
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						255.0,
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
					"id": "obj-13",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						90.0,
						255.0,
						300.0,
						20.0
					],
					"text": "MIDI note \u2192 Hz: exponential, 110 Hz \u2026 8.4 kHz",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						290.0,
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
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						30.0,
						325.0,
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
					"id": "obj-16",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						90.0,
						325.0,
						300.0,
						20.0
					],
					"text": "80 ms ramp per new value (~30/s from the camera)",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						210.0,
						185.0,
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
					"id": "obj-18",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						330.0,
						155.0,
						300.0,
						20.0
					],
					"text": "HAND HEIGHT \u2192 square/saw blend",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						330.0,
						185.0,
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
					"id": "obj-20",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						330.0,
						220.0,
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
					"id": "obj-21",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						490.0,
						220.0,
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
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						330.0,
						250.0,
						520.0,
						40.0
					],
					"text": "y is 0 at the TOP of the frame, 1 at the bottom. Equal-power: square sin(y\u00b7\u03c0/2), saw cos(y\u00b7\u03c0/2),\nso hand low = square, hand raised = saw, and the middle is a full mix, not a dip",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						330.0,
						290.0,
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
					"id": "obj-24",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						490.0,
						290.0,
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
					"id": "obj-25",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						330.0,
						325.0,
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
					"id": "obj-26",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						490.0,
						325.0,
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
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						450.0,
						185.0,
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
					"id": "obj-28",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						155.0,
						160.0,
						20.0
					],
					"text": "PRESENT \u2192 gate",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						680.0,
						185.0,
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
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						680.0,
						220.0,
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
					"id": "obj-31",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						680.0,
						255.0,
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
					"id": "obj-32",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						680.0,
						285.0,
						200.0,
						20.0
					],
					"text": "300 ms fade when the hand leaves",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						900.0,
						155.0,
						100.0,
						20.0
					],
					"text": "PITCH",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						185.0,
						50.0,
						22.0
					],
					"outlettype": [
						"float"
					],
					"text": "* #1"
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						960.0,
						185.0,
						240.0,
						20.0
					],
					"text": "\u00d7 #1 \u2014 pass 1. or 1.5, with the dot",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						220.0,
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
					"id": "obj-37",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1000.0,
						220.0,
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
					"id": "obj-38",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						290.0,
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
					"id": "obj-39",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1000.0,
						290.0,
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
					"id": "obj-40",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						325.0,
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
					"id": "obj-41",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						360.0,
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
					"id": "obj-42",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						395.0,
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
					"id": "obj-43",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						375.0,
						260.0,
						20.0
					],
					"text": "HAND LEFT\u2013RIGHT \u2192 stereo pan",
					"linecount": 1
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						405.0,
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
					"id": "obj-45",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						190.0,
						405.0,
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
					"id": "obj-46",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						435.0,
						560.0,
						40.0
					],
					"text": "x = 0 is the left edge of the mirrored view, so a hand on your left sounds on the left.\nEqual-power again: left cos(x\u00b7\u03c0/2), right sin(x\u00b7\u03c0/2)",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						30.0,
						480.0,
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
					"id": "obj-48",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						190.0,
						480.0,
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
					"id": "obj-49",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						30.0,
						515.0,
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
					"id": "obj-50",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"patching_rect": [
						190.0,
						515.0,
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
					"id": "obj-51",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						900.0,
						430.0,
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
					"id": "obj-52",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						1000.0,
						430.0,
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
					"id": "obj-53",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30.0,
						575.0,
						30.0,
						22.0
					],
					"comment": "signal, left"
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						80.0,
						575.0,
						30.0,
						22.0
					],
					"comment": "signal, right"
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						210.0,
						575.0,
						30.0,
						22.0
					],
					"comment": "pinch, m, at 2 Hz"
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "outlet",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						450.0,
						575.0,
						30.0,
						22.0
					],
					"comment": "y, at 2 Hz"
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
						"obj-10",
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
						"obj-10",
						1
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
						"obj-10",
						2
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
						"obj-11",
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
						"obj-12",
						0
					],
					"destination": [
						"obj-14",
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
						"obj-2",
						0
					],
					"destination": [
						"obj-17",
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
						"obj-19",
						1
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
						"obj-19",
						1
					],
					"destination": [
						"obj-21",
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
						"obj-23",
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
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-23",
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
						"obj-24",
						0
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
						1
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
						"obj-4",
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
						"obj-29",
						0
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
						"obj-30",
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
						"obj-5",
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
						"obj-36",
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
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						0
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
						"obj-25",
						0
					],
					"destination": [
						"obj-38",
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
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-26",
						0
					],
					"destination": [
						"obj-39",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
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
						"obj-39",
						0
					],
					"destination": [
						"obj-40",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-41",
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
						"obj-41",
						1
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
						"obj-41",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
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
						"obj-31",
						0
					],
					"destination": [
						"obj-42",
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
						"obj-44",
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
						"obj-47",
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
						"obj-42",
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
						"obj-49",
						0
					],
					"destination": [
						"obj-51",
						1
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
						"obj-52",
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
						1
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
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-55",
						0
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
						"obj-56",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
