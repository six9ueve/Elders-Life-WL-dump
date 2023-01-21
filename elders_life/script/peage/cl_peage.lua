ESX = nil
local blip
local CurrentAction = nil
local HasAlreadyEnteredMarker = false
local LastZone = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while not ESX.GetPlayerData().job do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('matt_hasEnteredMarker', function (zone)
  	if zone ~= nil then
    	CurrentAction = 'toll'
  	end
end)
	
AddEventHandler('matt_hasExitedMarker', function (zone)
	CurrentAction = nil
end)

Citizen.CreateThread(function (source)
	while true do
		Citizen.Wait(ConfigPeage.TickRateMS)
	
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		
		if CurrentAction ~= nil then
			if IsPedInAnyVehicle(playerPed, false) then
				local ped = GetPlayerPed( -1 )
				local pos = GetEntityCoords( ped )
				local vehicle = GetVehiclePedIsIn( ped, false )
				local vehicleP = GetVehicleNumberPlateText(vehicle)

				for k,v in ipairs(ConfigPeage.BlipZones) do
					if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 20 then
						ESX.TriggerServerCallback('matt_PayToll', function(ret)
							if ret == true then
								ESX.ShowNotification("<b>Péage :</b> Payé ~g~100$")
							else 
								TriggerServerEvent('matt_alert', vehicleP, 'failure', v.name, v.id)
							end
						end, ConfigPeage.TollPrice, v.id)
					end
				end
			end
		end
	end			 
end)

Citizen.CreateThread(function ()
	while true do
		
		interval = 500
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker = false
		local currentZone = nil
		
		for k,v in ipairs(ConfigPeage.Zones) do
			if(GetDistanceBetweenCoords(coords,v.x, v.y, v.z, true) < 50) then
				interval = 1
				if(GetDistanceBetweenCoords(coords,v.x, v.y, v.z, true) < 2) then
					isInMarker  = true
					currentZone = k

					if ConfigPeage.DevMode then
						DrawMarker(21, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 255, 255, 255, false, true, 2, false, false, false, false)
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('matt_hasEnteredMarker', currentZone, Location)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('matt_hasExitedMarker', LastZone)
		end
		Wait(interval)
	end
end)