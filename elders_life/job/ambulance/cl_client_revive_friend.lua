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

ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

--------------------------------------Configurattion
local Price = 600

local DrawDistance = 25.0
local MarkerSize   = {x = 1.2, y = 1.2, z = 1.2}
local MarkerColor  = {r = 255, g = 255, b = 255}
local MarkerType   = 21

local Zones = {}

local Hosp = {
	{x = 310.69, y = -585.83, z = 43.29},
	{x = -260.194, y = 6328.459, z = 32.408},
}

for i=1, #Hosp, 1 do
	Zones['Private Doc_' .. i] = {
		Pos   = Hosp[i],
		Size  = MarkerSize,
		Color = MarkerColor,
		Type  = MarkerType
	}
end
---------------------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		local coords = GetEntityCoords(PlayerPedId())
		local sleep = 500

		for k,v in pairs(Zones) do
			
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < DrawDistance) then
				sleep = 0
				DrawMarker(22, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)

			end
		end
		Citizen.Wait(sleep)

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		local sleep = 500


		for k,v in pairs(Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
				sleep       = 0
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('god_test:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('god_test:hasExitedMarker', LastZone)
		end
		Citizen.Wait(sleep)

	end
end)

AddEventHandler('god_test:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = ('Appuyez sur ~INPUT_CONTEXT~ pour sauver quelqu\'un de la mort')
	CurrentActionData = {}
end)

AddEventHandler('god_test:hasExitedMarker', function(zone)
	CurrentAction = nil
end)


-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			--ESX.ShowFloatingHelpNotification(CurrentActionMsg, vector3(playerX, playerY, playerZ))
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, 38) then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				
				if closestPlayer == -1 or closestDistance > 1.0 then
						ESX.ShowAdvancedNotification('EldersLife', 'Soins', 'Aucun joueur à proximité...', 'CHAR_ELDERS', 10)
				else
					local closestPlayerPed = GetPlayerPed(closestPlayer)
					if IsPedDeadOrDying(closestPlayerPed, 1) then
						
						ESX.TriggerServerCallback('god_test:revive', function(bought)
							if bought then
								ESX.ShowAdvancedNotification('EldersLife', 'Soins', 'Réanimation en cours!', 'CHAR_ELDERS', 10)
								exports['progressBars']:startUI(15000, "Réanimation..")
								Wait(15000)
								TriggerServerEvent('god_test:test', GetPlayerServerId(closestPlayer))
							end
						end)
					else
					ESX.ShowAdvancedNotification('EldersLife', 'Soins', 'Tu n\'as pas assez d\'argent...', 'CHAR_ELDERS', 10)
					end
				end
			end
		else
		Citizen.Wait(500)
		end
	end
end)