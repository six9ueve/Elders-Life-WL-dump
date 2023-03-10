ConfigFuel = {}
-- What should the price of jerry cans be?
ConfigFuel.JerryCanCost = 25
ConfigFuel.RefillCost = 50 -- If it is missing half of it capacity, this amount will be divided in half, and so on.
-- Fuel decor - No need to change this, just leave it.

ConfigFuel.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}
-- ConfigFuelure the strings as you wish here.
ConfigFuel.Strings = {
	ExitVehicle = "Sortez pour faire le plein de votre véhicule",
	EToRefuel = "Appuyez sur ~g~E ~w~pour faire le plein de votre véhicule",
	JerryCanEmpty = "Bidon d'essence' vide",
	FullTank = "Le réservoir est plein",
	PurchaseJerryCan = "Appuyez sur ~g~E ~w~pour acheter un bidon d'essence' pour ~g~$" .. ConfigFuel.JerryCanCost,
	CancelFuelingPump = "Appuyez sur ~g~E ~w~pour annuler le ravitaillement du véhicule",
	CancelFuelingJerryCan = "Appuyez sur ~g~E ~w~pour arrêter le ravitaillement",
	NotEnoughCash = "Pas assez d'argent",
	RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir le bidon d'essence",
	NotEnoughCashJerryCan = "Pas assez d'argent pour remplir le bidon d'essence",
	JerryCanFull = "Bidon d'essence plein",
	TotalCost = "Prix",
}

ConfigFuel.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
ConfigFuel.Classes = {
	[0] = 0.4, -- Compacts
	[1] = 0.4, -- Sedans
	[2] = 0.5, -- SUVs
	[3] = 0.5, -- Coupes
	[4] = 0.5, -- Muscle
	[5] = 0.4, -- Sports Classics
	[6] = 0.5, -- Sports
	[7] = 0.6, -- Super
	[8] = 0.4, -- Motorcycles
	[9] = 0.5, -- Off-road
	[10] = 0.5, -- Industrial
	[11] = 0.5, -- Utility
	[12] = 0.5, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.3, -- Boats
	[15] = 0.2, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 0.5, -- Service
	[18] = 0.5, -- Emergency
	[19] = 0.5, -- Military
	[20] = 0.5, -- Commercial
	[21] = 0.5, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
ConfigFuel.FuelUsage = {
	[1.0] = 0.9,
	[0.9] = 0.78,
	[0.8] = 0.55,
	[0.7] = 0.45,
	[0.6] = 0.37,
	[0.5] = 0.33,
	[0.4] = 0.28,
	[0.3] = 0.23,
	[0.2] = 0.17,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

ConfigFuel.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550), --route 68
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868), --Paleto
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534), --Grove Steet
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253),
	vector3(1771.395, 3234.2207, 42.329),
	vector3(3858.300, 4458.9145, 1.822),
	vector3(-706.319, -1464.2655, 5.042),
	vector3(-764.35, -1435.04, 5.00)
}