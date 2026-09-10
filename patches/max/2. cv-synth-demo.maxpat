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
			474.0,
			95.0,
			820.0,
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
					"id": "obj-74",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						132.5,
						66.0,
						61.0,
						22.0
					],
					"text": "send fund"
				}
			},
			{
				"box": {
					"id": "obj-126",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						142.0,
						145.0,
						103.0,
						22.0
					],
					"text": "send pinchmax"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						132.5,
						40.0,
						31.0,
						22.0
					],
					"text": "110."
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						85.5,
						172.0,
						29.5,
						22.0
					],
					"text": "0.8"
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						119.0,
						92.0,
						32.0,
						22.0
					],
					"text": "0.02"
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						2.5,
						172.0,
						71.0,
						20.0
					],
					"text": "resonance"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						70.5,
						234.0,
						67.0,
						22.0
					],
					"text": "udpreceive"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40.0,
						49.0,
						79.0,
						20.0
					],
					"text": "fundamental"
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40.0,
						92.0,
						60.0,
						20.0
					],
					"text": "pinch min"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						18.0,
						145.0,
						64.0,
						20.0
					],
					"text": "pinch max"
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						245.0,
						460.0,
						45.0,
						45.0
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						33.5,
						200.0,
						33.0,
						20.0
					],
					"text": "port"
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						70.5,
						200.0,
						59.0,
						22.0
					],
					"text": "port 7500"
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						124.0,
						172.0,
						110.0,
						22.0
					],
					"text": "send resonance"
				}
			},
			{
				"box": {
					"id": "obj-1",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						119.0,
						14.0,
						58.0,
						22.0
					],
					"text": "loadbang"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						103.0,
						145.0,
						29.5,
						22.0
					],
					"text": "0.1"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						260.0,
						168.0,
						157.0,
						20.0
					],
					"text": "receive network messages"
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						165.0,
						92.0,
						103.0,
						22.0
					],
					"text": "send pinchmin"
				}
			},
			{
				"box": {
					"id": "obj-143",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						266.0,
						60.0,
						22.0
					],
					"text": "size far"
				}
			},
			{
				"box": {
					"id": "obj-144",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						100.0,
						266.0,
						33.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "0.1"
				}
			},
			{
				"box": {
					"id": "obj-145",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						150.0,
						266.0,
						96.0,
						22.0
					],
					"text": "send sizefar"
				}
			},
			{
				"box": {
					"id": "obj-146",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						294.0,
						70.0,
						22.0
					],
					"text": "size near"
				}
			},
			{
				"box": {
					"id": "obj-147",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						100.0,
						294.0,
						33.0,
						22.0
					],
					"outlettype": [
						""
					],
					"text": "0.3"
				}
			},
			{
				"box": {
					"id": "obj-148",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						150.0,
						294.0,
						103.0,
						22.0
					],
					"text": "send sizenear"
				}
			},
			{
				"box": {
					"id": "obj-149",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						245.0,
						360.0,
						110.0,
						22.0
					],
					"outlettype": [
						"signal",
						"signal"
					],
					"text": "p left hand",
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
						"autosave": 0,
						"rect": [
							120.0,
							120.0,
							1230.0,
							960.0
						],
						"boxes": [
							{
								"box": {
									"id": "obj-101",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										800.0,
										292.0,
										170.0,
										33.0
									],
									"text": "palm size in the image:\nbigger = closer = louder"
								}
							},
							{
								"box": {
									"id": "obj-123",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										210.0,
										674.0,
										117.0,
										22.0
									],
									"text": "lores~ 1000 0.8"
								}
							},
							{
								"box": {
									"id": "obj-107",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										970.0,
										452.0,
										190.0,
										33.0
									],
									"text": "size \u2192 loudness in dB:\nfar is -40 dB, near is 0 dB"
								}
							},
							{
								"box": {
									"id": "obj-88",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										304.0,
										545.0,
										34.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-94",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										165.0,
										739.0,
										29.5,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"id": "obj-134",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										440.0,
										336.0,
										124.0,
										22.0
									],
									"text": "OSC-route /pinch"
								}
							},
							{
								"box": {
									"id": "obj-110",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										528.0,
										47.0,
										22.0
									],
									"text": "dbtoa"
								}
							},
							{
								"box": {
									"id": "obj-51",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"signal"
									],
									"patching_rect": [
										186.0,
										813.0,
										52.0,
										22.0
									],
									"text": "pan2 80"
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										195.0,
										249.0,
										173.0,
										22.0
									],
									"text": "OSC-route /cv/hand/left"
								}
							},
							{
								"box": {
									"id": "obj-54",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"float",
										"float",
										"float"
									],
									"patching_rect": [
										222.5,
										378.0,
										67.0,
										22.0
									],
									"text": "unpack f f f"
								}
							},
							{
								"box": {
									"id": "obj-120",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										528.0,
										75.0,
										22.0
									],
									"text": "pack f 80"
								}
							},
							{
								"box": {
									"id": "obj-124",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										389.0,
										700.0,
										250.0,
										33.0
									],
									"text": "lowpass filter: pinch sets the cutoff,\nresonance comes from the top"
								}
							},
							{
								"box": {
									"id": "obj-116",
									"linecount": 5,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										630.0,
										400.0,
										105.0,
										74.0
									],
									"text": "pinch \u2192 octaves, 0 to 6\n(pinch min and max set the range)"
								}
							},
							{
								"box": {
									"id": "obj-117",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										424.0,
										103.0,
										22.0
									],
									"text": "clip 0. 6."
								}
							},
							{
								"box": {
									"id": "obj-128",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										370.0,
										124.0,
										22.0
									],
									"text": "receive pinchmin"
								}
							},
							{
								"box": {
									"id": "obj-77",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										220.0,
										721.0,
										150.0,
										33.0
									],
									"text": "x position of wrist controls pan position"
								}
							},
							{
								"box": {
									"id": "obj-132",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										80.0,
										383.0,
										138.0,
										22.0
									],
									"text": "OSC-route /present"
								}
							},
							{
								"box": {
									"id": "obj-81",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										224.0,
										483.0,
										74.0,
										22.0
									],
									"text": "receive fund"
								}
							},
							{
								"box": {
									"id": "obj-46",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										96.5,
										711.0,
										29.5,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"id": "obj-115",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										400.0,
										173.0,
										22.0
									],
									"text": "scale 0.02 0.1 0. 6."
								}
							},
							{
								"box": {
									"id": "obj-118",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										476.0,
										166.0,
										22.0
									],
									"text": "expr 110.*pow(2., $f1)"
								}
							},
							{
								"box": {
									"id": "obj-69",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										243.0,
										819.0,
										124.0,
										20.0
									],
									"text": "80 ms fade time"
								}
							},
							{
								"box": {
									"id": "obj-129",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										570.0,
										370.0,
										124.0,
										22.0
									],
									"text": "receive pinchmax"
								}
							},
							{
								"box": {
									"id": "obj-111",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										566.0,
										82.0,
										22.0
									],
									"text": "pack f 150"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										440.0,
										263.0,
										190.0,
										33.0
									],
									"text": "pinch: thumb tip to index tip,\nin metres. opens the filter"
								}
							},
							{
								"box": {
									"id": "obj-80",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										224.0,
										545.0,
										63.0,
										22.0
									],
									"text": "saw~ 110."
								}
							},
							{
								"box": {
									"id": "obj-109",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										910.0,
										490.0,
										190.0,
										33.0
									],
									"text": "outside the range: stay at\nthe floor or at unity"
								}
							},
							{
								"box": {
									"id": "obj-119",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										615.0,
										476.0,
										160.0,
										33.0
									],
									"text": "octaves above 110 Hz:\n110 Hz up to 7 kHz"
								}
							},
							{
								"box": {
									"id": "obj-37",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										92.0,
										430.0,
										34.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-121",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										440.0,
										552.0,
										47.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-133",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										222.5,
										355.0,
										124.0,
										22.0
									],
									"text": "OSC-route /wrist"
								}
							},
							{
								"box": {
									"id": "obj-42",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										92.0,
										406.0,
										64.0,
										22.0
									],
									"text": "pack f 300"
								}
							},
							{
								"box": {
									"id": "obj-44",
									"linecount": 6,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										14.0,
										387.5,
										71.0,
										87.0
									],
									"text": "if hand \nis present, fade in, else fade out over\n300 ms"
								}
							},
							{
								"box": {
									"id": "obj-89",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										304.0,
										519.0,
										57.0,
										22.0
									],
									"text": "pack f 80"
								}
							},
							{
								"box": {
									"id": "obj-79",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										206.5,
										515.0,
										51.0,
										22.0
									],
									"text": "tri~ 110."
								}
							},
							{
								"box": {
									"id": "obj-57",
									"linecount": 5,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										298.0,
										329.0,
										78.0,
										74.0
									],
									"text": "extract the \nx, y, and z coordinates \nof the left \nwrist"
								}
							},
							{
								"box": {
									"id": "obj-60",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										220.0,
										760.0,
										161.0,
										20.0
									],
									"text": "map from [0, 1] -> [-1,  1]"
								}
							},
							{
								"box": {
									"id": "obj-113",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										800.0,
										604.0,
										47.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-106",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										452.0,
										159.0,
										22.0
									],
									"text": "scale 0.1 0.3 -40. 0."
								}
							},
							{
								"box": {
									"id": "obj-87",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										211.0,
										574.0,
										45.0,
										22.0
									],
									"text": "xfade~"
								}
							},
							{
								"box": {
									"id": "obj-114",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										16.5,
										736.0,
										140.0,
										33.0
									],
									"text": "loudness follows\nhand size"
								}
							},
							{
								"box": {
									"id": "obj-108",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										490.0,
										96.0,
										22.0
									],
									"text": "clip -40. 0."
								}
							},
							{
								"box": {
									"id": "obj-112",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										900.0,
										566.0,
										250.0,
										33.0
									],
									"text": "150 ms fade time \u2014 slower than the\nothers, size jitters more than position"
								}
							},
							{
								"box": {
									"id": "obj-93",
									"linecount": 4,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										263.5,
										578.0,
										147.0,
										60.0
									],
									"text": "crossfade between triangle wave and saw wave, controlled by y position of wrist"
								}
							},
							{
								"box": {
									"id": "obj-58",
									"maxclass": "newobj",
									"numinlets": 5,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										197.0,
										786.0,
										95.0,
										22.0
									],
									"text": "zmap 0. 1. -1. 1."
								}
							},
							{
								"box": {
									"id": "obj-122",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										500.0,
										552.0,
										120.0,
										20.0
									],
									"text": "80 ms fade time"
								}
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										224.0,
										227.0,
										330.0,
										20.0
									],
									"text": "route osc (OSC-route: one address level at a time)",
									"linecount": 1
								}
							},
							{
								"box": {
									"id": "obj-135",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										800.0,
										336.0,
										117.0,
										22.0
									],
									"text": "OSC-route /size"
								}
							},
							{
								"box": {
									"id": "obj-130",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										308.0,
										650.0,
										131.0,
										22.0
									],
									"text": "receive resonance"
								}
							},
							{
								"box": {
									"id": "obj-136",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										195.0,
										205.0,
										30.0,
										22.0
									],
									"outlettype": [
										""
									],
									"comment": "OSC from udpreceive"
								}
							},
							{
								"box": {
									"id": "obj-137",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										186.0,
										880.0,
										30.0,
										22.0
									],
									"comment": "left"
								}
							},
							{
								"box": {
									"id": "obj-138",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										236.0,
										880.0,
										30.0,
										22.0
									],
									"comment": "right"
								}
							},
							{
								"box": {
									"id": "obj-139",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										910.0,
										400.0,
										117.0,
										22.0
									],
									"outlettype": [
										""
									],
									"text": "receive sizefar"
								}
							},
							{
								"box": {
									"id": "obj-140",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										1040.0,
										400.0,
										124.0,
										22.0
									],
									"outlettype": [
										""
									],
									"text": "receive sizenear"
								}
							},
							{
								"box": {
									"id": "obj-141",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										575.0,
										312.0,
										200.0,
										20.0
									],
									"text": "readout at 2 Hz \u2014 pinch, metres"
								}
							},
							{
								"box": {
									"id": "obj-142",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"patching_rect": [
										575.0,
										336.0,
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
									"id": "obj-143",
									"maxclass": "flonum",
									"numinlets": 1,
									"numoutlets": 2,
									"patching_rect": [
										680.0,
										336.0,
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
									"id": "obj-144",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"patching_rect": [
										930.0,
										372.0,
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
									"id": "obj-145",
									"maxclass": "flonum",
									"numinlets": 1,
									"numoutlets": 2,
									"patching_rect": [
										1035.0,
										372.0,
										60.0,
										22.0
									],
									"outlettype": [
										"",
										"bang"
									],
									"parameter_enable": 0
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-108",
										0
									],
									"source": [
										"obj-106",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-110",
										0
									],
									"source": [
										"obj-108",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-111",
										0
									],
									"source": [
										"obj-110",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-113",
										0
									],
									"source": [
										"obj-111",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										1
									],
									"source": [
										"obj-113",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-117",
										0
									],
									"source": [
										"obj-115",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-118",
										0
									],
									"source": [
										"obj-117",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-120",
										0
									],
									"source": [
										"obj-118",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-121",
										0
									],
									"source": [
										"obj-120",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-123",
										1
									],
									"source": [
										"obj-121",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										1
									],
									"source": [
										"obj-123",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-115",
										1
									],
									"source": [
										"obj-128",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-115",
										2
									],
									"source": [
										"obj-129",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-123",
										2
									],
									"source": [
										"obj-130",
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
									"source": [
										"obj-42",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										0
									],
									"source": [
										"obj-46",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-58",
										0
									],
									"midpoints": [
										232.0,
										424.0,
										206.5,
										424.0
									],
									"source": [
										"obj-54",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-89",
										0
									],
									"midpoints": [
										256.0,
										456.0,
										313.5,
										456.0
									],
									"source": [
										"obj-54",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										1
									],
									"source": [
										"obj-58",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										0
									],
									"source": [
										"obj-79",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										1
									],
									"source": [
										"obj-80",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-79",
										0
									],
									"order": 1,
									"source": [
										"obj-81",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-80",
										0
									],
									"midpoints": [
										233.5,
										508.0,
										269.0,
										508.0,
										269.0,
										541.0,
										233.5,
										541.0
									],
									"order": 0,
									"source": [
										"obj-81",
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
									"source": [
										"obj-87",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										2
									],
									"source": [
										"obj-88",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-88",
										0
									],
									"source": [
										"obj-89",
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
									"source": [
										"obj-94",
										0
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
										"obj-132",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-132",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-133",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-133",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-134",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-134",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-135",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-135",
										0
									],
									"destination": [
										"obj-106",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-136",
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
										"obj-51",
										0
									],
									"destination": [
										"obj-137",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-51",
										1
									],
									"destination": [
										"obj-138",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-139",
										0
									],
									"destination": [
										"obj-106",
										1
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-140",
										0
									],
									"destination": [
										"obj-106",
										2
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-134",
										0
									],
									"destination": [
										"obj-142",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-142",
										0
									],
									"destination": [
										"obj-143",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-135",
										0
									],
									"destination": [
										"obj-144",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-144",
										0
									],
									"destination": [
										"obj-145",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"tags": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-150",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						420.0,
						360.0,
						110.0,
						22.0
					],
					"outlettype": [
						"signal",
						"signal"
					],
					"text": "p right hand",
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
						"autosave": 0,
						"rect": [
							120.0,
							120.0,
							1230.0,
							960.0
						],
						"boxes": [
							{
								"box": {
									"id": "obj-101",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										800.0,
										292.0,
										170.0,
										33.0
									],
									"text": "palm size in the image:\nbigger = closer = louder"
								}
							},
							{
								"box": {
									"id": "obj-123",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										210.0,
										674.0,
										117.0,
										22.0
									],
									"text": "lores~ 1000 0.8"
								}
							},
							{
								"box": {
									"id": "obj-107",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										970.0,
										452.0,
										190.0,
										33.0
									],
									"text": "size \u2192 loudness in dB:\nfar is -40 dB, near is 0 dB"
								}
							},
							{
								"box": {
									"id": "obj-88",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										304.0,
										545.0,
										34.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-94",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										165.0,
										739.0,
										29.5,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"id": "obj-134",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										440.0,
										336.0,
										124.0,
										22.0
									],
									"text": "OSC-route /pinch"
								}
							},
							{
								"box": {
									"id": "obj-110",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										528.0,
										47.0,
										22.0
									],
									"text": "dbtoa"
								}
							},
							{
								"box": {
									"id": "obj-51",
									"maxclass": "newobj",
									"numinlets": 4,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"signal"
									],
									"patching_rect": [
										186.0,
										813.0,
										52.0,
										22.0
									],
									"text": "pan2 80"
								}
							},
							{
								"box": {
									"id": "obj-38",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										195.0,
										249.0,
										173.0,
										22.0
									],
									"text": "OSC-route /cv/hand/right"
								}
							},
							{
								"box": {
									"id": "obj-54",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 3,
									"outlettype": [
										"float",
										"float",
										"float"
									],
									"patching_rect": [
										222.5,
										378.0,
										67.0,
										22.0
									],
									"text": "unpack f f f"
								}
							},
							{
								"box": {
									"id": "obj-120",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										528.0,
										75.0,
										22.0
									],
									"text": "pack f 80"
								}
							},
							{
								"box": {
									"id": "obj-124",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										389.0,
										700.0,
										250.0,
										33.0
									],
									"text": "lowpass filter: pinch sets the cutoff,\nresonance comes from the top"
								}
							},
							{
								"box": {
									"id": "obj-116",
									"linecount": 5,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										630.0,
										400.0,
										105.0,
										74.0
									],
									"text": "pinch \u2192 octaves, 0 to 6\n(pinch min and max set the range)"
								}
							},
							{
								"box": {
									"id": "obj-117",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										424.0,
										103.0,
										22.0
									],
									"text": "clip 0. 6."
								}
							},
							{
								"box": {
									"id": "obj-128",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										370.0,
										124.0,
										22.0
									],
									"text": "receive pinchmin"
								}
							},
							{
								"box": {
									"id": "obj-77",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										220.0,
										721.0,
										150.0,
										33.0
									],
									"text": "x position of wrist controls pan position"
								}
							},
							{
								"box": {
									"id": "obj-132",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										80.0,
										383.0,
										138.0,
										22.0
									],
									"text": "OSC-route /present"
								}
							},
							{
								"box": {
									"id": "obj-81",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										224.0,
										459.0,
										74.0,
										22.0
									],
									"text": "receive fund"
								}
							},
							{
								"box": {
									"id": "obj-46",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										96.5,
										711.0,
										29.5,
										22.0
									],
									"text": "*~"
								}
							},
							{
								"box": {
									"id": "obj-115",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										400.0,
										173.0,
										22.0
									],
									"text": "scale 0.02 0.1 0. 6."
								}
							},
							{
								"box": {
									"id": "obj-118",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										440.0,
										476.0,
										166.0,
										22.0
									],
									"text": "expr 110.*pow(2., $f1)"
								}
							},
							{
								"box": {
									"id": "obj-69",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										243.0,
										819.0,
										124.0,
										20.0
									],
									"text": "80 ms fade time"
								}
							},
							{
								"box": {
									"id": "obj-129",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										570.0,
										370.0,
										124.0,
										22.0
									],
									"text": "receive pinchmax"
								}
							},
							{
								"box": {
									"id": "obj-111",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										566.0,
										82.0,
										22.0
									],
									"text": "pack f 150"
								}
							},
							{
								"box": {
									"id": "obj-2",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										440.0,
										263.0,
										190.0,
										33.0
									],
									"text": "pinch: thumb tip to index tip,\nin metres. opens the filter"
								}
							},
							{
								"box": {
									"id": "obj-80",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										224.0,
										545.0,
										63.0,
										22.0
									],
									"text": "saw~ 110."
								}
							},
							{
								"box": {
									"id": "obj-109",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										910.0,
										490.0,
										190.0,
										33.0
									],
									"text": "outside the range: stay at\nthe floor or at unity"
								}
							},
							{
								"box": {
									"id": "obj-119",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										615.0,
										476.0,
										160.0,
										33.0
									],
									"text": "octaves above 110 Hz:\n110 Hz up to 7 kHz"
								}
							},
							{
								"box": {
									"id": "obj-37",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										92.0,
										430.0,
										34.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-121",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										440.0,
										552.0,
										47.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-133",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										222.5,
										355.0,
										124.0,
										22.0
									],
									"text": "OSC-route /wrist"
								}
							},
							{
								"box": {
									"id": "obj-42",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										92.0,
										406.0,
										64.0,
										22.0
									],
									"text": "pack f 300"
								}
							},
							{
								"box": {
									"id": "obj-44",
									"linecount": 6,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										14.0,
										387.5,
										71.0,
										87.0
									],
									"text": "if hand \nis present, fade in, else fade out over\n300 ms"
								}
							},
							{
								"box": {
									"id": "obj-89",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										304.0,
										519.0,
										57.0,
										22.0
									],
									"text": "pack f 80"
								}
							},
							{
								"box": {
									"id": "obj-79",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										206.5,
										515.0,
										51.0,
										22.0
									],
									"text": "tri~ 110."
								}
							},
							{
								"box": {
									"id": "obj-57",
									"linecount": 5,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										298.0,
										329.0,
										78.0,
										74.0
									],
									"text": "extract the \nx, y, and z coordinates \nof the right \nwrist"
								}
							},
							{
								"box": {
									"id": "obj-60",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										220.0,
										760.0,
										161.0,
										20.0
									],
									"text": "map from [0, 1] -> [-1,  1]"
								}
							},
							{
								"box": {
									"id": "obj-113",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 2,
									"outlettype": [
										"signal",
										"bang"
									],
									"patching_rect": [
										800.0,
										604.0,
										47.0,
										22.0
									],
									"text": "line~"
								}
							},
							{
								"box": {
									"id": "obj-106",
									"maxclass": "newobj",
									"numinlets": 6,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										452.0,
										159.0,
										22.0
									],
									"text": "scale 0.1 0.3 -40. 0."
								}
							},
							{
								"box": {
									"id": "obj-87",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										"signal"
									],
									"patching_rect": [
										211.0,
										574.0,
										45.0,
										22.0
									],
									"text": "xfade~"
								}
							},
							{
								"box": {
									"id": "obj-114",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										16.5,
										736.0,
										140.0,
										33.0
									],
									"text": "loudness follows\nhand size"
								}
							},
							{
								"box": {
									"id": "obj-108",
									"maxclass": "newobj",
									"numinlets": 3,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										800.0,
										490.0,
										96.0,
										22.0
									],
									"text": "clip -40. 0."
								}
							},
							{
								"box": {
									"id": "obj-112",
									"linecount": 2,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										900.0,
										566.0,
										250.0,
										33.0
									],
									"text": "150 ms fade time \u2014 slower than the\nothers, size jitters more than position"
								}
							},
							{
								"box": {
									"id": "obj-93",
									"linecount": 4,
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										263.5,
										578.0,
										147.0,
										60.0
									],
									"text": "crossfade between triangle wave and saw wave, controlled by y position of wrist"
								}
							},
							{
								"box": {
									"id": "obj-58",
									"maxclass": "newobj",
									"numinlets": 5,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										197.0,
										786.0,
										95.0,
										22.0
									],
									"text": "zmap 0. 1. -1. 1."
								}
							},
							{
								"box": {
									"id": "obj-122",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										500.0,
										552.0,
										120.0,
										20.0
									],
									"text": "80 ms fade time"
								}
							},
							{
								"box": {
									"id": "obj-28",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										224.0,
										227.0,
										330.0,
										20.0
									],
									"text": "route osc (OSC-route: one address level at a time)",
									"linecount": 1
								}
							},
							{
								"box": {
									"id": "obj-135",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 2,
									"outlettype": [
										"",
										""
									],
									"patching_rect": [
										800.0,
										336.0,
										117.0,
										22.0
									],
									"text": "OSC-route /size"
								}
							},
							{
								"box": {
									"id": "obj-130",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										308.0,
										650.0,
										131.0,
										22.0
									],
									"text": "receive resonance"
								}
							},
							{
								"box": {
									"id": "obj-136",
									"maxclass": "inlet",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										195.0,
										205.0,
										30.0,
										22.0
									],
									"outlettype": [
										""
									],
									"comment": "OSC from udpreceive"
								}
							},
							{
								"box": {
									"id": "obj-137",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										186.0,
										880.0,
										30.0,
										22.0
									],
									"comment": "left"
								}
							},
							{
								"box": {
									"id": "obj-138",
									"maxclass": "outlet",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										236.0,
										880.0,
										30.0,
										22.0
									],
									"comment": "right"
								}
							},
							{
								"box": {
									"id": "obj-139",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										910.0,
										400.0,
										117.0,
										22.0
									],
									"outlettype": [
										""
									],
									"text": "receive sizefar"
								}
							},
							{
								"box": {
									"id": "obj-140",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"patching_rect": [
										1040.0,
										400.0,
										124.0,
										22.0
									],
									"outlettype": [
										""
									],
									"text": "receive sizenear"
								}
							},
							{
								"box": {
									"id": "obj-141",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"patching_rect": [
										224.0,
										487.0,
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
									"id": "obj-142",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										280.0,
										487.0,
										90.0,
										22.0
									],
									"text": "a fifth up"
								}
							},
							{
								"box": {
									"id": "obj-143",
									"maxclass": "comment",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										575.0,
										312.0,
										200.0,
										20.0
									],
									"text": "readout at 2 Hz \u2014 pinch, metres"
								}
							},
							{
								"box": {
									"id": "obj-144",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"patching_rect": [
										575.0,
										336.0,
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
									"id": "obj-145",
									"maxclass": "flonum",
									"numinlets": 1,
									"numoutlets": 2,
									"patching_rect": [
										680.0,
										336.0,
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
									"id": "obj-146",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"patching_rect": [
										930.0,
										372.0,
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
									"id": "obj-147",
									"maxclass": "flonum",
									"numinlets": 1,
									"numoutlets": 2,
									"patching_rect": [
										1035.0,
										372.0,
										60.0,
										22.0
									],
									"outlettype": [
										"",
										"bang"
									],
									"parameter_enable": 0
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-108",
										0
									],
									"source": [
										"obj-106",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-110",
										0
									],
									"source": [
										"obj-108",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-111",
										0
									],
									"source": [
										"obj-110",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-113",
										0
									],
									"source": [
										"obj-111",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										1
									],
									"source": [
										"obj-113",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-117",
										0
									],
									"source": [
										"obj-115",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-118",
										0
									],
									"source": [
										"obj-117",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-120",
										0
									],
									"source": [
										"obj-118",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-121",
										0
									],
									"source": [
										"obj-120",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-123",
										1
									],
									"source": [
										"obj-121",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-46",
										1
									],
									"source": [
										"obj-123",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-115",
										1
									],
									"source": [
										"obj-128",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-115",
										2
									],
									"source": [
										"obj-129",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-123",
										2
									],
									"source": [
										"obj-130",
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
									"source": [
										"obj-42",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-94",
										0
									],
									"source": [
										"obj-46",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-58",
										0
									],
									"midpoints": [
										232.0,
										424.0,
										206.5,
										424.0
									],
									"source": [
										"obj-54",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-89",
										0
									],
									"midpoints": [
										256.0,
										456.0,
										313.5,
										456.0
									],
									"source": [
										"obj-54",
										1
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-51",
										1
									],
									"source": [
										"obj-58",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										0
									],
									"source": [
										"obj-79",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										1
									],
									"source": [
										"obj-80",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-79",
										0
									],
									"order": 1,
									"source": [
										"obj-141",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-80",
										0
									],
									"midpoints": [
										233.5,
										508.0,
										269.0,
										508.0,
										269.0,
										541.0,
										233.5,
										541.0
									],
									"order": 0,
									"source": [
										"obj-141",
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
									"source": [
										"obj-87",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-87",
										2
									],
									"source": [
										"obj-88",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-88",
										0
									],
									"source": [
										"obj-89",
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
									"source": [
										"obj-94",
										0
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
										"obj-132",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-132",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-133",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-133",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-134",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-134",
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
										"obj-38",
										0
									],
									"destination": [
										"obj-135",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-135",
										0
									],
									"destination": [
										"obj-106",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-136",
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
										"obj-51",
										0
									],
									"destination": [
										"obj-137",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-51",
										1
									],
									"destination": [
										"obj-138",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-139",
										0
									],
									"destination": [
										"obj-106",
										1
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-140",
										0
									],
									"destination": [
										"obj-106",
										2
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
										"obj-141",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-134",
										0
									],
									"destination": [
										"obj-144",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-144",
										0
									],
									"destination": [
										"obj-145",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-135",
										0
									],
									"destination": [
										"obj-146",
										0
									]
								}
							},
							{
								"patchline": {
									"source": [
										"obj-146",
										0
									],
									"destination": [
										"obj-147",
										0
									]
								}
							}
						]
					},
					"saved_object_attributes": {
						"description": "",
						"digest": "",
						"globalpatchername": "",
						"tags": ""
					}
				}
			},
			{
				"box": {
					"id": "obj-151",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						245.0,
						335.0,
						420.0,
						22.0
					],
					"text": "each hand is one voice with a stereo output \u2014 double-click to open"
				}
			},
			{
				"box": {
					"id": "obj-152",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						540.0,
						360.0,
						260.0,
						40.0
					],
					"text": "the same patch, listening to /cv/hand/right,\nwith the fundamental \u00d7 1.5 (a fifth up)",
					"linecount": 2
				}
			},
			{
				"box": {
					"id": "obj-153",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						245.0,
						420.0,
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
					"id": "obj-154",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						305.0,
						420.0,
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
					"id": "obj-155",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						355.0,
						420.0,
						200.0,
						22.0
					],
					"text": "left and right, both hands"
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
					"order": 1,
					"source": [
						"obj-1",
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
					"order": 2,
					"source": [
						"obj-1",
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
					"order": 3,
					"source": [
						"obj-1",
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
					"order": 4,
					"source": [
						"obj-1",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-3",
						0
					],
					"order": 0,
					"source": [
						"obj-1",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-125",
						0
					],
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-126",
						0
					],
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-127",
						0
					],
					"source": [
						"obj-16",
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
					"source": [
						"obj-23",
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
					"source": [
						"obj-3",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-1",
						0
					],
					"destination": [
						"obj-144",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-1",
						0
					],
					"destination": [
						"obj-147",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-144",
						0
					],
					"destination": [
						"obj-145",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-147",
						0
					],
					"destination": [
						"obj-148",
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
						"obj-149",
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
						"obj-150",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-149",
						0
					],
					"destination": [
						"obj-153",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-150",
						0
					],
					"destination": [
						"obj-153",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-149",
						1
					],
					"destination": [
						"obj-154",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-150",
						1
					],
					"destination": [
						"obj-154",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-153",
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
						"obj-154",
						0
					],
					"destination": [
						"obj-70",
						1
					]
				}
			}
		],
		"dependency_cache": [
			{
				"name": "pan2.maxpat",
				"bootpath": "~/Library/Application Support/Cycling '74/Max 8/Examples/spatialization/panning/lib",
				"patcherrelativepath": "../../../../../Library/Application Support/Cycling '74/Max 8/Examples/spatialization/panning/lib",
				"type": "JSON",
				"implicit": 1
			},
			{
				"name": "xfade~.maxpat",
				"bootpath": "~/Documents/2026/MIT/class-demos/patches/max",
				"patcherrelativepath": "./max",
				"type": "JSON",
				"implicit": 1
			}
		],
		"autosave": 0
	}
}
