ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
			break
		else
			ESX = nil
			TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

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

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

local bait = "none"

local blip = AddBlipForCoord(ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z)

			SetBlipSprite (blip, 356)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, 17)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Marché")
			EndTextCommandSetBlipName(blip)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
end
end)
Citizen.CreateThread(function()
	while true do
		if fishing then
			if IsControlJustReleased(0, Keys['1']) then
				 input = 1
			end
			if IsControlJustReleased(0, Keys['2']) then
				input = 2
			end
			if IsControlJustReleased(0, Keys['3']) then
				input = 3
			end
			if IsControlJustReleased(0, Keys['4']) then
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
			end
			
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				ClearPedTasks(playerPed)
				ESX.ShowNotification("~r~Stop de la pêche")
			end
			if fishing then
			
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(PlayerPedId())
				local vehicle = GetClosestVehicleToPlayerFishing()
				local class = GetVehicleClass(vehicle)
				if IsEntityInWater(playerPed) or class == 14 then


				else
					fishing = false
					ClearPedTasks(playerPed)
					ESX.ShowNotification("~r~Stop de la pêche")
				end
				if IsEntityDead(playerPed) then
					fishing = false
					ClearPedTasks(playerPed)
					ESX.ShowNotification("~r~Stop de la pêche")
				end
			end
			
			
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
				else
					ESX.ShowNotification("~r~Le poisson est parti")
				end
			end
			Wait(5)
		else
			Citizen.Wait(500)
		end
	end
end)


				
Citizen.CreateThread(function()
	local wait_fish = 1500
	local vente = false
	while true do
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, true) <= 25 then
			wait_fish = 1
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, true) <= 10 then
				if not IsPedInAnyVehicle(PlayerPedId()) then
					if  GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, true) <= 1.2 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre votre poisson/viande")
                        if IsControlJustPressed(1,51) then
                        	vente = true
                        	TriggerServerEvent('fishing:startSelling')
                    	end
                    end
                    if  GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, true) > 3 and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, true) < 6  then                        
                        	if vente == true then
	                        	TriggerServerEvent('fishing:stopSelling')
	                        	vente = false
                        	end
                    end
				else
					ESX.ShowNotification("~r~Vous etes dans un véhicule !")
				end
			end
			DrawMarker(22,  ConfigFishing.SellFish.x, ConfigFishing.SellFish.y, ConfigFishing.SellFish.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
		else
			Citizen.Wait(wait_fish)
		end
		Citizen.Wait(wait_fish)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(ConfigFishing.FishTime.a , ConfigFishing.FishTime.b)
		Wait(wait)
			if fishing then
				pause = true
				correct = math.random(1,8)
				ESX.ShowNotification("~g~Le poisson à pris l'appât \n ~h~Presse " .. correct .. " pour le férrer")
				input = 0
				pausetimer = 0
			end
			
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishing:phone')
AddEventHandler('fishing:phone', function()
	local coord = GetEntityCoords(PlayerPedId())
	TriggerServerEvent('god_phone:send', 'police', "Bonjour, j'ai vu une personne faire de la pêche illégale, je vous envoi la position ou je l'es vu.", false, {
		x = coord.x,
		y = coord.y,
		z = coord.z
	})
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(PlayerPedId())	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()		
	playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification("~y~Tu ne peux pas pêcher depuis un véhicule")
	else
		local vehicle = GetClosestVehicleToPlayerFishing()
		local class = GetVehicleClass(vehicle)
		if IsEntityInWater(playerPed) or class == 14 then
			ESX.ShowNotification("~g~Début de la Pêche (X pour stopper)")
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			ESX.ShowNotification("~y~Tu dois être près de l'eau")
		end
	end
	
end, false)

function GetClosestVehicleToPlayerFishing()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 3.0
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end