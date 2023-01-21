ConfigGarage = {}
ConfigGarage.Blip			= {sprite= 524, color = 30, scale = 0.7 }
ConfigGarage.BoatBlip		= {sprite= 410, color = 30, scale = 0.7 }
ConfigGarage.AirplaneBlip	= {sprite= 423, color = 30, scale = 0.7 }
ConfigGarage.MecanoBlip	= {sprite= 357, color = 26, scale = 0.7 }
ConfigGarage.Price		= 150 -- pound price to get vehicle back
ConfigGarage.SwitchGaragePrice	= 25000 -- price to pay to switch vehicles in garage
ConfigGarage.StoreOnServerStart = true -- Store all vehicles in garage on server start?
ConfigGarage.Locale = 'fr'

ConfigGarage.Garages = {
	Garage_cayo  = {
		Pos = {x=4469.44, y= -4446.73, z= 4.55},-- +0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=4488.57 , y=-4450.49, z= 4.40},-- +0.3
			Heading = 200.33,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = { x=4479.90, y= -4451.83, z= 4.40 },-- +0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_larrys  = {
		Pos = {x=1225.43, y= 2696.882, z= 38.55},-- +0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=1226.07 , y=2709.91, z= 38.30},-- +0.3
			Heading = 244.33,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = { x=1233.55, y= 2701.89, z= 38.30 },-- +0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_sandymotel  = {
		Pos = {x=186.41, y= 2752.83, z= 43.80},-- +0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=184.89 , y=2746.25, z= 43.70},-- +0.3
			Heading = 244.33,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = { x=203.31, y= 2749.69, z= 43.70 },-- +0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_bayview  = {
		Pos = {x=-773.60, y= 5530.34, z= 33.90},-- +0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=-773.67 , y=5537.99, z= 33.80},-- +0.3
			Heading = 20.33,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = { x=-751.34, y= 5541.57, z= 33.80 },-- +0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_vespucci  = {
		Pos = {x=-1159.00, y= -740.00, z= 20.30},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=-1153.72 , y=-746.00, z= 19.80},
			Heading = 215.8,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = { x=-1142.43, y= -740.97, z= 20.30 },
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Eclipse  = {
		Pos = {x=-340.72, y=266.80, z=86.10},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=-333.70, y= 278.94, z= 86.25},
			Heading = 172.83,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x=-343.86, y=273.91, z=85.70},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Centre = {
		Pos = {x=213.61, y=-809.35, z=31.40},-- z + 0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=228.31, y= -802.57, z= 30.90},-- z + 0.3
			Heading = 169.9,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x=221.09, y=-774.68, z=31.10},-- z + 0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Grapeseed = {
		Pos = {x=1717.92, y=4794.62, z=42.40},-- z + 0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=1713.42, y= 4801.06, z= 42.05},-- z + 0.3
			Heading = 92.9,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x=1713.95, y=4807.93, z=42.10},-- z + 0.3
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_zonah = {
		Pos = {x=431.60, y=-1274.37, z=30.95},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=407.13, y= -1278.60, z= 30.60},
			Heading = 246.34,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x=415.44, y=-1288.77, z=30.60},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Centre2 = {
		Pos = {x = -1464.08,y = -504.34,z = 33.20},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = -1479.29,y = -500.92,z = 33.10},
			Heading = 297.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = -1472.81,y = -507.84,z = 33.10},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Paleto = {
		Pos = {x=31.63, y=6376.43, z=31.80},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=35.66, y= 6368.74, z= 31.55},
			Heading = 302.937,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x=39.24, y=6359.07, z=31.55},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_SandyShore = {
		Pos = {x=1737.67, y=3709.42, z=34.55},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x=1738.32, y= 3718.33, z= 34.35},
			Heading = 20.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = 1720.85,y = 3715.44,z = 34.50},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Ocean1 = {
		Pos = {x = -3131.11,y = 1122.36,z = 21.05},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = -3135.39,y = 1125.75,z = 21.00},
			Heading = 160.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = -3141.84,y = 1120.62,z = 21.00},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_Sud = {
		Pos = {x = 445.44,y = -1955.31,z = 23.60},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = 437.8140,y = -1958.572,z = 23.30},
			Heading = 182.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = 453.98,y = -1965.88,z = 23.30},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_vigne = {
		Pos = {x = -1895.265,y = 1979.724,z = 142.90},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = -1895.95,y = 1986.09,z = 142.60},
			Heading = 6.74,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = -1897.02,y = 1994.10,z = 142.25},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_vinewood = {
		Pos = {x = 491.757,y = -76.84,z = 78.10},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = 494.42,y = -70.93,z = 78.00},
			Heading = 329.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = 482.95,y = -71.87,z = 77.90},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
	Garage_senora = {
		Pos = {x = 2538.20,y = 2607.92,z = 37.94},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = 2532.44,y = 2628.84,z = 37.94},
			Heading = 329.0,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre véhicule'
		},
		DeletePoint = {
			Pos = {x = 2535.87,y = 2616.95,z = 37.94},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre véhicule'
		}, 	
	},
}

ConfigGarage.GaragesMecano = {
	mechanic = {
		Name = 'Garage',
		SpawnPoint = {
			Pos = {x = 403.290,y = -1631.83,z = 29.70},
			Heading = 308.2,
			Marker = {  w= 1.0, h= 1.0,r=0,g=255,b=0,type=36, distance = 1},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir un véhicule de fourrière'
		},
		DeletePoint = {
			Pos = {x = 396.386,y = -1637.78,z = 29.70},
			Marker = {  w= 1.0, h= 1.0,r=255,g=0,b=0,type=36, distance = 1},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer le véhicule en fourrière'
		}, 	
	},
	mechanic2 = {
		Name = 'Garage',
		SpawnPoint = {
			Pos = {x = 71.90,y = 6635.097,z = 32.30},
			Heading = 308.2,
			Marker = {  w= 1.0, h= 1.0,r=0,g=255,b=0,type=36, distance = 1},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir un véhicule de fourrière'
		},
		DeletePoint = {
			Pos = {x = 75.019,y = 6639.216,z = 32.30},
			Marker = {  w= 1.0, h= 1.0,r=255,g=0,b=0,type=36, distance = 1},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer le véhicule en fourrière'
		}, 	
	}
}

ConfigGarage.BoatGarages = {
	BoatGarage_Centre = {
		Pos = {x = -742.47064208984,y = -1332.4702148438,z = 2.00 },--z + 0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name ='Garage bateaux',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de navire',
		SpawnPoint = {
			Pos = {x = -714.81,y = -1346.58,z = 1.0 },
			MarkerPos = {x = -733.58,y = -1338.62,z = 2.30 },--z + 0.7
			Heading = 129.33,
			Marker = {  w= 0.8, h= 1.4,r=0,g=255,b=0,type=35, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre navire'
		},
		DeletePoint = {
			Pos = {x = -750.39,y = -1354.00,z = 2.1 },
			Marker = {  w= 1.6, h= 2.8,r=255,g=0,b=0,type=35, distance = 8},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre navire'
		}, 	
	},
	BoatGarage_Cayo = {
		Pos = {x = 4943.37,y = -5176.88,z = 3.00 },--z + 0.4
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name ='Garage bateaux',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de navire',
		SpawnPoint = {
			Pos = {x = 4929.42,y = -5167.93,z = 1.0 },
			MarkerPos = {x = 4932.34,y = -5175.36,z = 3.15 },--z + 0.7
			Heading = 63.87,
			Marker = {  w= 0.8, h= 1.4,r=0,g=255,b=0,type=35, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre navire'
		},
		DeletePoint = {
			Pos = {x = 4952.69,y = -5163.14,z = 2.1 },
			Marker = {  w= 1.6, h= 2.8,r=255,g=0,b=0,type=35, distance = 8},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre navire'
		}, 	
	},
	BoatGarage_sandy = {
		Pos = {x = 1586.64,y = 3906.67,z = 32.00 },
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name ='Garage bateaux',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de navire',
		SpawnPoint = {
			Pos = {x = 1577.93,y = 3938.05,z = 32.39 },
			MarkerPos = {x = 1581.89,y = 3906.53,z = 32.45 },
			Heading = 85.28,
			Marker = {  w= 0.8, h= 1.4,r=0,g=255,b=0,type=35, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre navire'
		},
		DeletePoint = {
			Pos = {x = 1576.17,y = 3915.17,z = 32.2 },
			Marker = {  w= 1.6, h= 2.8,r=255,g=0,b=0,type=35, distance = 8},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre navire'
		}, 	
	},
	BoatGarage_paleto = {
		Pos = {x = -281.01,y = 6601.40,z = 2.05},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name ='Garage bateaux',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de navire',
		SpawnPoint = {
			Pos = {x = -291.77,y = 6624.3 ,z = 0.92 },
			MarkerPos = {x = -285.47,y = 6598.159,z = 2.50 },
			Heading = 28.99,
			Marker = {  w= 0.8, h= 1.4,r=0,g=255,b=0,type=35, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre navire'
		},
		DeletePoint = {
			Pos = {x = -300.69,y = 6592.88,z = 2.1 },
			Marker = {  w= 1.6, h= 2.8,r=255,g=0,b=0,type=35, distance = 8},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre navire'
		}, 	
	},
}

ConfigGarage.AirplaneGarages = {
	AirplaneGarage_Centre = {
		Pos = {x = -1144.36,y = -3405.66,z = 14.35 },
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Hangar d\'avion',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de aviation',
		SpawnPoint = {
			Pos = {x = -1155.37,y = -3391.30,z = 14.35 },
			Heading = 329.0,
			Marker = {  w= 1.0, h= 0.75,r=0,g=255,b=0,type=7, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre engin d\'aviation'
		},
		DeletePoint = {
			Pos = {x = -1131.42,y = -3411.95,z = 14.35 },--z + 0.4
			Marker = {  w= 1.5, h= 1.0,r=255,g=0,b=0,type=7, distance = 6},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre engin d\'aviation'
		}, 	
	},
	AirplaneGarage_Sandy = {
		Pos = {x = 1727.36,y = 3287.90,z = 41.55 },
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Hangar d\'avion',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de aviation',
		SpawnPoint = {
			Pos = {x = 1726.25,y = 3269.62,z = 41.55 },
			Heading = 116.0,
			Marker = {  w= 1.0, h= 0.75,r=0,g=255,b=0,type=7, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre engin d\'aviation'
		},
		DeletePoint = {
			Pos = {x=1740.9125976563, y=3244.2844238281, z=42.00},
			Marker = {  w= 1.5, h= 1.0,r=255,g=0,b=0,type=7, distance = 6},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre engin d\'aviation'
		}, 	
	},
	AirplaneGarage_Cayo = {
		Pos = {x = 4486.31,y = -4510.83,z = 5.20 },
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Hangar d\'avion',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de aviation',
		SpawnPoint = {
			Pos = {x = 4479.25,y = -4490.83,z = 4.20 },
			Heading = 100.47,
			Marker = {  w= 1.0, h= 0.75,r=0,g=255,b=0,type=7, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre engin d\'aviation'
		},
		DeletePoint = {
			Pos = {x=4485.47, y=-4470.93, z=4.65},
			Marker = {  w= 1.5, h= 1.0,r=255,g=0,b=0,type=7, distance = 6},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre engin d\'aviation'
		}, 	
	},
	AirplaneGarage_Grapeseed = {
		Pos = {x = 2143.67,y = 4797.38,z = 41.45 },
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Hangar d\'avion',
		HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage de aviation',
		SpawnPoint = {
			Pos = {x = 2144.55,y = 4811.03,z = 41.60 },
			Heading = 116.0,
			Marker = {  w= 1.0, h= 0.75,r=0,g=255,b=0,type=7, distance = 2},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour sortir votre engin d\'aviation'
		},
		DeletePoint = {
			Pos = {x = 2127.48,y = 4797.67,z = 41.55 },
			Marker = {  w= 1.5, h= 1.0,r=255,g=0,b=0,type=7, distance = 6},
			HelpPrompt = 'Appuyer sur ~INPUT_PICKUP~ pour rentrer votre engin d\'aviation'
		}, 	
	},
}


ConfigGarage.SocietyGarages = {
	bahama_mamas =  { -- database job name
		{
			Pos = {x = -1404.65,y = -632.68,z = 29.10 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1401.56 ,y = -639.94,z = 29.00 },
				Heading = 124.42,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1409.53,y = -636.08,z = 29.00 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	gang_1 =  { -- database job name
		{
			Pos = {x = 108.72,y = 64.54,z = 73.41 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 86.20 ,y = 68.61,z = 73.41 },
				Heading = 73.68,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 97.64,y = 64.87,z = 73.41 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	gang_2 =  { -- database job name
		{
			Pos = {x = 453.09,y = -1548.77,z = 29.43 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 455.09 ,y = -1552.16,z = 29.28 },
				Heading = 73.68,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 458.09,y = -1548.77,z = 29.28 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	famille_1 =  { -- database job name
		{
			Pos = {x = 135.40 ,y = -3045.32,z = 7.04 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 144.56 ,y = -3036.73,z = 7.04 },
				Heading = 281.57,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 142.30,y = -3044.12,z = 7.04 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	famille_2 =  { -- database job name
		{
			Pos = {x = -1061.536 ,y = 305.2628,z = 65.984 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1060.713 ,y = 308.4347,z = 66.0302 },
				Heading = 348.393,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1062.094,y = 301.516,z = 65.930 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	steinway =  { -- database job name
		{
			Pos = {x = 1942.08,y = 3840.31,z = 32.55 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1933.81 ,y = 3834.37,z = 32.70 },
				Heading = 5.41,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1940.44,y = 3830.24,z = 32.55 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	ferme_oneil =  { -- database job name
		{
			Pos = {x = 1814.911,y = 4588.373,z = 36.80 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1815.307 ,y = 4591.561,z = 37.00 },
				Heading = 100.69,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1815.274,y = 4594.88,z = 37.30 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mosley =  { -- database job name
		{
			Pos = {x = -72.73,y = 84.52,z = 71.87 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -68.85 ,y = 82.38,z = 71.80 },
				Heading = 63.61,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -79.94,y = 88.089,z = 71.89 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	tacos =  { -- database job name
		{
			Pos = {x = 426.61,y = -1907.43,z = 25.95 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 419.218 ,y = -1899.197,z = 25.90 },
				Heading = 43.27,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 422.64,y = -1903.065,z = 25.95 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	unicorn =  { -- database job name
		{
			Pos = {x = 123.98,y = -1274.07,z = 29.45 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 115.32 ,y = -1275.73,z = 29.30 },
				Heading = 288.94,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 130.2,y = -1272.71,z = 29.35 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	paradise =  { -- database job name
		{
			Pos = {x=-2966.87, y=74.23, z=11.85 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=-2975.0441894531, y=71.294044494629, z=11.90 },
				Heading = 288.94,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=-2975.00390625, y=65.496032714844, z=11.90 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			},
		},
	},
	juge =  { -- database job name
		{
			Pos = {x = -563.89,y = -180.81,z = 38.45 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -578.95 ,y = -171.04,z = 38.45 },
				Heading = 106.94,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -564.88,y = -173.59,z = 38.45 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	gruppe6 =  { -- database job name
		{
			Pos = {x = 0.65,y = -659.31,z = 33.90 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -4.95 ,y = -672.12,z = 32.65 },
				Heading = 180.37,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 2.76,y = -671.26,z = 32.65 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	black_wood =  { -- database job name
		{
			Pos = {x = -306.41,y = 6276.24,z = 31.90 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -317.87 ,y = 6273.64,z = 31.90 },
				Heading = 136.42,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -308.96,y = 6280.51,z = 31.80 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	coffeeshop =  { -- database job name
		{
			Pos = {x = -1316.20,y = -1262.78,z = 4.00 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1312.13 ,y = -1261.51,z = 4.00 },
				Heading = 24.42,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1308.11,y = -1259.92,z = 4.00 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	maison10 =  { -- database job name
		{
			Pos = {x = -377.33,y = 189.21,z = 81.15 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -380.67 ,y = 184.57,z = 80.65 },
				Heading = 85.15,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -370.45,y = 183.96,z = 80.45 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	yellow_jack =  { -- database job name
		{
			Pos = {x = 1964.66,y = 3031.06,z = 47.45 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1972.99 ,y = 3032.22,z = 47.35 },
				Heading = 331.18,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1967.95,y = 3036.11,z = 47.35 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cardealer =  { -- database job name
		{
			Pos = {x = 142.91,y = -128.75,z = 55.20 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 135.40 ,y = -121.06,z = 55.10 },
				Heading = 64.28,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 144.65,y = -124.10,z = 55.10 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cardealer3 =  { -- database job name
		{
			Pos = {x = -4.50,y = -1082.39,z = 27.45 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -13.59 ,y = -1091.89,z = 27.35 },
				Heading = 157.48,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -13.42,y = -1080.3,z = 27.35 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cardealer2 =  { -- database job name
		{
			Pos = {x = 1194.30,y = 2722.61,z = 39.00 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1200.26 ,y = 2726.25,z = 38.30 },
				Heading = 256.2,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1189.34,y = 2728.01,z = 38.30 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	police =  { -- database job name
		{
			Pos = {x=-573.63525390625, y=-82.606605529785, z=34.30},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=-576.01538085938, y=-87.803579406738, z=34.05 },
				Heading = 203.56,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=-582.44887939453, y=-90.246597290039, z=34.05},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			},
		},
	},
	police_row =  { -- database job name
		{
			Pos = {x = 447.63,y = -1008.42,z = 28.20 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 443.92 ,y = -1021.88,z = 28.85 },
				Heading = 98.91,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 452.78,y = -1007.98,z = 28.05 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	police_davis =  { -- database job name
		{
			Pos = {x = 379.14,y = -1633.61,z = 28.30 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 383.67 ,y = -1623.35,z = 29.60 },
				Heading = 320.69,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 378.95,y = -1628.26,z = 29.25 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	sheriff =  { -- database job name
		{
			Pos = {x = 1870.5,y = 3698.608,z = 33.407 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1870.735 ,y = 3691.576,z = 33.62 },
				Heading = 198.00,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1866.453,y = 3698.608,z = 33.58},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	sheriff_sandy =  { -- database job name
		{
			Pos = {x = -463.35,y = 6044.53,z = 31.75 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -458.78 ,y = 6039.83,z = 31.65 },
				Heading = 137.09,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -469.09,y = 6038.55,z = 31.65 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	gouv =  { -- database job name
		{
			Pos = {x = -556.8847,y = -171.157,z = 38.07 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -564.512 ,y = -164.759,z = 38.085 },
				Heading = 26.00,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -558.997,y = -171.157,z = 38.195 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	brasseur =  { -- database job name
		{
			Pos = {x = -57.28,y = 6417.47,z =31.90 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -43.96 ,y = 6410.42,z = 31.80 },
				Heading = 313.4,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -51.08,y = 6416.75,z = 31.80 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	forge =  { -- database job name
		{
			Pos = {x = 2682.61,y = 2766.65,z = 38.30 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 2722.29 ,y = 2770.35,z = 36.09 },
				Heading = 313.4,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 2715.97,y = 2762.58,z = 36.58 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	pearl =  { -- database job name
		{
			Pos = {x = -1856.15,y = -1210.25,z =13.40 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1868.427 ,y = -1213.479,z = 13.30 },
				Heading = 313.4,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1861.695,y = -1216.321,z = 13.30 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	restochinois =  { -- database job name
		{
			Pos = {x = -213.036,y = 314.786,z = 96.94 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -205.871 ,y = 307.445,z = 96.94 },
				Heading = 292.518,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -213.130,y = 306.985,z = 96.95 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	popdiner =  { -- database job name
		{
			Pos = {x = 1598.33,y = 6452.98,z =25.70 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1600.53 ,y = 6447.43,z = 25.60 },
				Heading = 158.28,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1602.56,y = 6452.29,z = 25.50 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mechanic =  { -- database job name
		{
			Pos = {x = -182.19,y = -1323.72,z = 31.65 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -182.13 ,y = -1315.45,z = 31.60 },
				Heading = 201.50,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -181.65,y = -1331.08,z = 31.50 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mechanic2 =  { -- database job name
		{
			Pos = {x = 52.265,y = 6488.538,z = 31.85},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 59.35 ,y = 6464.81,z = 31.40 },
				Heading = 224.281,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 47.15,y = 6494.095,z = 31.75 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mechanic3 =  { -- database job name
		{
			Pos = {x = -380.119,y = -101.323,z = 38.69},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -363.23 ,y = -110.094,z = 38.69 },
				Heading = 75.66,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -372.88,y = -107.055,z = 38.68 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mechanic4 =  { -- database job name
		{
			Pos = {x = 528.06,y = -146.63,z = 58.80},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 549.14 ,y = -143.80,z = 58.85 },
				Heading = 91.68,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 549.02,y = -136.85,z = 59.60 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mechanic5 =  { -- database job name
		{
			Pos = {x = 1038.02,y = -2489.75,z = 28.51},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1021.56 ,y = -2488.82,z = 28.51 },
				Heading = 139.68,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1028.72,y = -2490.75,z = 28.51 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	ambulance =  { -- database job name
		{
			Pos = {x = 321.20,y = -565.06,z = 29.20},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 336.22 ,y = -571.57,z = 29.10},
				Heading = 339.14,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 325.63,y = -569.22,z = 29.10},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	ambulance_paleto =  { -- database job name
		{
			Pos = {x = -271.32,y = 6322.38,z = 32.80},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -274.84 ,y = 6316.51,z = 32.65},
				Heading = 227.42,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -279.71,y = 6321.59,z = 32.65},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	ballas =  { -- database job name
		{
			Pos = {x = 88.34,y = -1967.62,z = 21.15},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 91.87,y = -1963.73,z = 21.05},
				Heading = 324.28,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 104.96, y=-1955.70, z=21.05},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	crips_gang =  { -- database job name
		{
			Pos = {x = -1564.60,y = -246.74,z = 48.70},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1561.756,y = -254.819,z = 48.60},
				Heading = 137.87,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1554.164, y=-244.7878, z=48.60},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	oneil =  { -- database job name
		{
			Pos = {x = 2419.82,y = 4989.77,z = 46.55},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 2407.186 ,y = 4984.92,z = 46.35},
				Heading = 137.42,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 2413.73,y = 4991.09,z = 46.55},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	gitan =  { -- database job name
		{
			Pos = {x = 1357.62,y = 4376.76,z = 44.34},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1347.16 ,y = 4376.85,z = 44.34},
				Heading = 259.64,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1364.86,y = 4382.59,z = 44.32},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	vagos =  { -- database job name
		{
			Pos = {x = 331.89,y = -2055.15,z = 21.30},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 334.81 ,y = -2039.53,z = 21.40},
				Heading = 54.0,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 334.89,y = -2033.10,z = 21.60},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	families =  { -- database job name
		{
			Pos = {x = -1.57,y = -1507.19,z = 30.30},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -14.09 ,y = -1511.96, z = 30.35},
				Heading = 317.00,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -4.53,y = -1520.27,z = 29.90},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	crips =  { -- database job name
		{
			Pos = {x = -355.76,y = 35.16,z = 47.90},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -364.57,y = 30.98,z = 47.90},
				Heading = 88.07,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -356.62,y = 26.32,z = 47.70},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cartel_1 =  { -- database job name
		{
			Pos = {x = -319.46,y = -1287.93,z = 31.24},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -313.49 ,y = -1287.91, z = 31.24},
				Heading = 91.24,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -306.97,y = -1287.98,z = 31.24},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	biker =  { -- database job name
		{
			Pos = {x = 1005.233,y = -111.3616,z = 74.30},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 999.545 ,y = -106.3931,z = 74.22},
				Heading = 38.221,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 993.373 ,y = -92.448,z = 74.65},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	biker_1 =  { -- database job name
		{
			Pos = {x = 1044.39,y = -2490.93,z = 28.90},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1042.43 ,y = -2494.83,z = 28.80},
				Heading = 153.89,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1047.76,y = -2494.32,z = 28.80},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	biker_2 =  { -- database job name
		{
			Pos = {x = -96.400,y = 6495.063,z = 31.490},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -93.541 ,y = 6491.98,z = 31.490},
				Heading = 227.93,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -100.50,y = 6499.875,z = 31.490},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	biker_3 =  { -- database job name
		{
			Pos = {x = 897.363,y = 3576.507,z = 33.42},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 896.0739 ,y = 3583.981,z = 33.41},
				Heading = 351.375,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 893.581,y = 3578.132,z = 33.36},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	tequilala =  {
		{
			Pos = {x = -556.27,y = 296.95,z = 83.45},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -553.02 ,y = 304.54,z = 83.55},
				Heading = 258.77,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -561.06,y = 302.15,z = 83.50},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cartel_2 =  { -- database job name
	{
			Pos = {x = -120.22,y = 1014.32,z = 236.20},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
			Pos = {x = -112.8 ,y = 1005.3,z = 236.10},
			Heading = 113.25,
			Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
		},
			DeletePoint = {
			Pos = {x = -124.68,y = 1007.23,z = 236.10},
			Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	chicken =  { -- database job name
		{
			Pos = {x = -61.77,y = 6272.2,z = 31.75},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -58.77 ,y = 6278.67,z = 31.60},
				Heading = 274.3,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -63.77,y = 6277.71,z = 31.65},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},

	ranch =  { -- database job name
		{
			Pos = {x = 1571.980,y = 2206.464,z = 79.35},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1571.574 ,y = 2199.723,z = 79.40},
				Heading = 83.520,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1562.909,y = 2200.318,z = 79.30},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mafia_2 =  { -- database job name
		{
			Pos = {x = 1425.17,y = 1119.51,z = 114.45},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1414.09 ,y = 1118.63, z = 114.83},
				Heading = 86.780,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1402.33,y = 1117.01,z = 114.83 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mafia_1 =  { -- database job name
		{
			Pos = {x=-1791.45, y=454.0531, z= 128.30},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=-1795.234, y=459.4386, z= 128.28},
				Heading = 102.34,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=-1797.027, y=456.2251, z= 128.315},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mafia =  { -- database job name
		{
			Pos = {x=375.81, y=-9.45, z=82.98},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=371.56, y=-3.96, z=82.98},
				Heading = 36.94,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=360.11, y=-12.60, z=82.99},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	blood =  { -- database job name
		{
			Pos = {x = -1561.68,y = -380.53,z = 42.40 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1558.81 ,y = -388.34 ,z = 42.30},
				Heading = 312.87,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1552.53,y = -391.74,z = 42.30 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	marabunta =  { -- database job name ATTENTION AZTECAS
		{
			Pos = {x = 358.90,y = -1845.08,z = 28.45 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 364.814 ,y = -1845.285 ,z = 28.45},
				Heading = 221.2,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 370.427,y = -1840.677,z = 28.55 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mara =  { -- database job name
		{
			Pos = {x = 1331.63,y = -1735.82,z = 56.60 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1304.74 ,y = -1712.18 ,z = 55.05},
				Heading = 206.65,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1301.09,y = -1737.73,z = 54.20 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 4},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	mara18 =  { -- database job name
		{
			Pos = {x = 1409.75,y = -1497.227,z = 60.05 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1415.48 ,y = -1501.58 ,z = 60.35},
				Heading = 204.2,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1408.02,y = -1505.39,z = 59.75 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	vigne =  { -- database job name
		{
			Pos = {x = -1905.54,y = 2068.19 ,z = 141.20 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1903.71 ,y = 2057.62,z = 141.00},
				Heading = 43.46,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1924.74,y = 2065.32 ,z = 140.95 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	tabac =  { -- database job name
		{
			Pos = {x = 2875.29 ,y = 4402.47,z = 51.15 },
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 2898.07,y = 4383.08,z = 50.05 },
				Heading = 200.73,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 2879.03,y = 4407.16,z =50.95 },
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	realestateagent =  { -- database job name
		{
			Pos = {x = 56.17,y = -876.50,z = 31.05},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 64.48 ,y =-850.69,z = 31.10},  -- -0.5
				Heading = 166.82,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 61.38,y =-858.39,z = 31.00}, -- +0.5
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	taxi =  { -- database job name
		{
			Pos = {x = 903.55,y = -167.74,z = 74.50},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 899.88 ,y =-187.51,z = 74.10},  -- -0.5
				Heading = 325.3,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 906.48,y =-174.96,z = 74.40}, -- +0.5
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	burgershot =  { -- database job name
		{
			Pos = {x = -1171.79,y = -900.68,z = 14.20},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1171.36 ,y = -891.28,z = 14.25},  -- -0.5
				Heading = 0.04,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1164.69,y = -889.48,z = 14.40}, -- +0.5
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	distillerie =  { -- database job name
		{
			Pos = {x = 69.597,y = 6323.81,z = 31.60},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 67.184 ,y = 6329.230,z = 31.50},
				Heading = 36.22,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 63.90,y = 6334.029,z = 31.50},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	weazelnews =  { -- database job name
		{
			Pos = {x = -538.478,y = -889.791,z = 25.013},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -524.3317 ,y = -884.292,z = 25.14},
				Heading = 142.91,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -543.49,y = -889.796,z = 25.05},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	pizzeria =  { -- database job name
		{
			Pos = {x = -1471.49,y = -350.11,z = 44.75},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1464.54,y = -360.99,z = 44.30},
				Heading = 221.0,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1468.24,y = -354.92,z = 44.45},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	boulangerie =  { -- database job name
		{
			Pos = {x = -1277.704,y = -280.144,z = 38.55},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1268.619,y = -298.107,z = 37.50},
				Heading = 204.0,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1274.391,y = -286.834,z = 38.15},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	black_disciple =  { -- database job name
		{
			Pos = {x = -1158.92,y = -1564.61,z = 4.80},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = -1151.15,y = -1562.53,z = 4.65},
				Heading = 31.17,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = -1159.81,y = -1551.07,z = 4.60},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	th410 =  { -- database job name
		{
			Pos = {x = 464.72,y = -1742.21,z = 29.50},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 477.07,y = -1745.16,z = 29.20},
				Heading = 28.9,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 469.36,y = -1741.26,z = 29.25},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	cartel =  { -- database job name
		{
			Pos = {x=490.02, y=-2759.15, z=3.06},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=497.36, y=-2750.25, z=3.06},
				Heading = 214.46,
				Marker = {  w= 1.0, h= 1.4,r=0,g=255,b=0,type=36, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=498.54, y=-2741.88, z=3.06},
				Marker = {  w= 1.0, h= 1.4,r=255,g=0,b=0,type=36, distance = 3},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
}

ConfigGarage.SocietyGaragesAir = {
	police =  { -- database job name
		{
			Pos = {x=-575.87, y=-125.21, z=52.40},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=-566.04144287109, y=-123.80556488037, z=52.70},
				Heading = 289.75,
				Marker = {  w= 1.2, h= 1.2,r=0,g=255,b=0,type=34, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=-578.59, y=-136.40, z=52.70},
				Marker = {  w= 1.2, h= 1.2,r=255,g=0,b=0,type=34, distance = 5},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	police_airport =  { -- database job name
		{
			Pos = {x=-1012.38, y=-3025.39, z=13.94},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=-998.98, y=-3004.95, z=13.94},
				Heading = 58.75,
				Marker = {  w= 1.2, h= 1.2,r=0,g=255,b=0,type=34, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=-1006.43, y=-3014.54, z=13.94},
				Marker = {  w= 1.2, h= 1.2,r=255,g=0,b=0,type=34, distance = 5},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	ambulance =  { -- database job name
		{
			Pos = {x=340.00, y=-581.55, z=74.6},
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x=352.79, y=-583.85, z=74.85},
				Heading = 250,
				Marker = {  w= 1.2, h= 1.2,r=0,g=255,b=0,type=34, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x=348.34, y=-593.40, z=74.85},
				Marker = {  w= 1.2, h= 1.2,r=255,g=0,b=0,type=34, distance = 5},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},
	weazelnews =  { -- database job name
	{
		Pos = {x = -557.941,y = -890.791,z = 25.00},
		Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
		Name = 'Garage',
		HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
		SpawnPoint = {
			Pos = {x = -562.408,y = -897.140,z = 24.27},
			Heading = 227.34,
			Marker = {  w= 1.2, h= 1.2,r=0,g=255,b=0,type=34, distance = 2},
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
		},
		DeletePoint = {
			Pos = {x = -560.470,y = -903.4426,z = 23.94},
			Marker = {  w= 1.2, h= 1.2,r=255,g=0,b=0,type=34, distance = 5},
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
		}, 	
	},
	},
	sheriff =  { -- database job name
		{
			Pos = {x = 1860.91,y = 3688.64,z = 41.50 },-- z + 0.4
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1848.38 ,y = 3684.37,z = 41.50 },--z + 0.7
				Heading = 321.51,
				Marker = {  w= 1.2, h= 1.6,r=0,g=255,b=0,type=34, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1851.07,y = 3695.83,z = 41.50 },
				Marker = {  w= 1.2, h= 1.6,r=255,g=0,b=0,type=34, distance = 5},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},	
	sheriff_airport =  { -- database job name
		{
			Pos = {x = 1692.16,y = 3279.77,z = 41.20 },-- z + 0.4
			Marker = { w= 0.6, h= 0.6,r = 204, g = 204, b = 0, type = 24, distance = 2},
			Name = 'Garage',
			HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage',
			SpawnPoint = {
				Pos = {x = 1688.29 ,y = 3264.89,z = 41.20 },--z + 0.7
				Heading = 122.7,
				Marker = {  w= 1.2, h= 1.6,r=0,g=255,b=0,type=34, distance = 2},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour sortir un véhicule du garage'
			},
			DeletePoint = {
				Pos = {x = 1704.74,y = 3272.51,z = 41.20 },
				Marker = {  w= 1.2, h= 1.6,r=255,g=0,b=0,type=34, distance = 5},
				HelpPrompt = 'Appuyez sur ~INPUT_PICKUP~ pour rentrer votre dans le garage '
			}, 	
		},
	},	
}