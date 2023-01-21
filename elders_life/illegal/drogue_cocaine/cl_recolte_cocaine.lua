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
local spawnedCocaine = 0
local CocainePlants = {}
local CircleZonesCocaine = {
	CocaineField = {coords = vector3(319.4149, 4296.02, 46.00), name = "cocaine", color = 25, sprite = 496, radius = 10.0},
}

local function GetCoordCocaine(x, y)
	local groundCheckHeights = { 100.0, 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0, 109.0, 110.0, 111.0, 112.0, 113.0, 114.0, 115.0, 116.0, 117.0, 118.0, 119.0, 120.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 107.0
end
local function ValidateCocaineCoord(plantCoord)
	if spawnedCocaine > 0 then
		local validate = true
		for k, v in pairs(CocainePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, CircleZonesCocaine.CocaineField.coords, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
local function GenerateCocaineCoords()
	while true do
		Citizen.Wait(1)
		local CocaineCoordX, CocaineCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)
		Citizen.Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)
		CocaineCoordX = CircleZonesCocaine.CocaineField.coords.x + modX
		CocaineCoordY = CircleZonesCocaine.CocaineField.coords.y + modY
		local coordZ = GetCoordCocaine(CocaineCoordX, CocaineCoordY)
		local coord = vector3(CocaineCoordX, CocaineCoordY, coordZ)
		if ValidateCocaineCoord(coord) then
			return coord
		end
	end
end
local function SpawnCocainePlants()
	while spawnedCocaine < 10 do
		Citizen.Wait(0)
		local CocaineCoords = GenerateCocaineCoords()
		ESX.Game.SpawnLocalObject('pw_prop_coke_07', CocaineCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(CocainePlants, obj)
			spawnedCocaine = spawnedCocaine + 1
		end)
	end
end

Citizen.CreateThread(function()
	while true do
		interval = 750
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, CircleZonesCocaine.CocaineField.coords, true) < 70 then
			interval = 1
			if GetDistanceBetweenCoords(coords, CircleZonesCocaine.CocaineField.coords, true) < 60 then
				interval = 1
				SpawnCocainePlants()
			else
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
		for i=1, #CocainePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(CocainePlants[i]), false) < 2 then
				interval = 0
				nearbyObject, nearbyID = CocainePlants[i], i
			end
		end
		if nearbyObject and IsPedOnFoot(playerPed) then
			interval = 0
			if not isPickingUp then
				ESX.ShowHelpNotification("appuyez sur [ E ] pour récolter un plan")
			end			
			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
				Citizen.Wait(5000)
				ClearPedTasks(playerPed)
				Citizen.Wait(2000)
				ESX.Game.DeleteObject(nearbyObject)
				table.remove(CocainePlants, nearbyID)
				spawnedCocaine = spawnedCocaine - 1
				TriggerServerEvent('Elders_Cocaine:takecoke')
				isPickingUp = false
			end
		else
			interval = 750
			Citizen.Wait(500)
		end
		Citizen.Wait(interval)
	end
end)