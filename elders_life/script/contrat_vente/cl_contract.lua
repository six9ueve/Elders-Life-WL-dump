ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function loadAnimDict_contract(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

RegisterNetEvent('god_contract:getVehicle')
AddEventHandler('god_contract:getVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			ESX.ShowNotification(_U('writingcontract', vehProps.plate))
			TriggerServerEvent('god_clothes:sellVehicle', GetPlayerServerId(closestPlayer), vehProps.plate)
			local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
			vehicleLabel = GetLabelText(vehicleLabel)
			TriggerServerEvent('Logs:contract', vehicleLabel, vehProps.plate, GetPlayerName(closestPlayer))
		else
			ESX.ShowNotification(_U('nonearby'))
		end
	else
		ESX.ShowNotification(_U('nonearbybuyer'))
	end
	
end)

RegisterNetEvent('god_contract:showAnim')
AddEventHandler('god_contract:showAnim', function(player)
	loadAnimDict_contract('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
	Citizen.Wait(20000)
	ClearPedTasks(PlayerPedId())
end)