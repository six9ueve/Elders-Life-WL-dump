ConfigPeage = {}
ConfigPeage.Blips = {Color = 1, Sprite = 79, Scale = 0.6, Name = 'Péage'}
ConfigPeage.TollPrice = 100 -- Price per time the user goes through the toll.
ConfigPeage.TickRateMS = 500 -- Every set amount of time it will check. If you are having FPS problems with the script it is suggested you turn down the MS rate

ConfigPeage.DevMode = false -- If set as true it will draw markers for Config.Zones

-- Lane Zones -- 
-- Lane Zones are for lane in the road.

ConfigPeage.Zones = {
	--Los Santos
	vector3(1525.83, -2835.92, 48.13),
	vector3(1527.76, -2832.11, 48.13),
	--Cayo Perico
	vector3(4582.70, -4320.38, 9.96),
	vector3(4580.67, -4324.22, 9.96),
}

-- Blip Zones -- 
-- Blip zones are for each "Toll Station"

ConfigPeage.BlipZones = {
	{id = 1, x = 1522.68, y = -2837.88, z = 48.33, name = 'Los Santos'},
	{id = 2, x = 4582.46,  y = -4316.74, z = 10.00, name = 'Cayo Perico'}
}