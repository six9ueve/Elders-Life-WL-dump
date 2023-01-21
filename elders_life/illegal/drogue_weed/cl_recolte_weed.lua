local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local spawnedWeeds = 0
local weedPlants = {}
local CircleZonesWeed = {
	WeedField = {coords = vector3(3426.052, 5498.908, 20.419), name = "weed", color = 25, sprite = 496, radius = 6.0},
}

local function GetCoordZ(x, y)
	local groundCheckHeights = { 100.0, 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0, 109.0, 110.0, 111.0, 112.0, 113.0, 114.0, 115.0, 116.0, 117.0, 118.0, 119.0, 120.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 107.0
end
local function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true
		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, CircleZonesWeed.WeedField.coords, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
local function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)
		local weedCoordX, weedCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)
		Citizen.Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)
		weedCoordX = CircleZonesWeed.WeedField.coords.x + modX
		weedCoordY = CircleZonesWeed.WeedField.coords.y + modY
		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)
		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

local function SpawnWeedPlants()
	while spawnedWeeds < 25 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()
		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

Citizen.CreateThread(function()
	while true do
		interval = 750
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, CircleZonesWeed.WeedField.coords, true) < 70 then
			interval = 1
			if GetDistanceBetweenCoords(coords, CircleZonesWeed.WeedField.coords, true) < 60 then
				SpawnWeedPlants()
			else
				interval = 750
				Citizen.Wait(500)
			end
		end
		Citizen.Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while true do
		interval = 750
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 2 then
				interval = 1
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end
		if nearbyObject and IsPedOnFoot(playerPed) then
			interval = 1
			if not isPickingUp then
				ESX.ShowHelpNotification("appuyez sur [~b~ E ~w~] pour récolter un plan")
			end			
			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
				Citizen.Wait(5000)
				ClearPedTasks(playerPed)
				Citizen.Wait(2000)
				ESX.Game.DeleteObject(nearbyObject)
				table.remove(weedPlants, nearbyID)
				spawnedWeeds = spawnedWeeds - 1
				TriggerServerEvent('Elders_weed:takeweed')
				isPickingUp = false
			end
		else
			interval = 750
			Citizen.Wait(500)
		end
		Citizen.Wait(interval)
	end
end)