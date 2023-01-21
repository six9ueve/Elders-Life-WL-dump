
ESX = nil

local isRunningWorkaround = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ToggleVehicleLock()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 4.0, 0, 71)
	end
	if not DoesEntityExist(vehicle) then
		return
	end

	ESX.TriggerServerCallback('euk-carlock:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)
			local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
			vehicleLabel = GetLabelText(vehicleLabel)
			
			if lockStatus == 0 then -- unlocked
				if vehicleLabel == 'NULL' then
					vehicleLabel = 'véhicule'
				end
				lockAnimation()
                PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', 0)
				ESX.ShowAdvancedNotification('Sécurité', '~b~Voiture', '~r~Fermé votre~w~ ~w~'..vehicleLabel..'~w~', 'CHAR_ELDERS', 10)
				SetVehicleDoorShut(vehicle, 0, false)
				SetVehicleDoorShut(vehicle, 1, false)
				SetVehicleDoorShut(vehicle, 2, false)
				SetVehicleDoorShut(vehicle, 3, false)
				SetVehicleDoorsLocked(vehicle, 2)
				PlayVehicleDoorCloseSound(vehicle, 1)
				if not IsPedInAnyVehicle(playerPed, false) then
					SetVehicleLights(vehicle, 2)
	                Wait(125)
	                SetVehicleLights(vehicle, 0)
					Wait(125)		
					SetVehicleLights(vehicle, 2)
	                Wait(125)
	                SetVehicleLights(vehicle, 0)
					Wait(125)		
				end	
			elseif lockStatus == 2 then -- locked
				if vehicleLabel == 'NULL' then
					vehicleLabel = 'véhicule'
				end
				lockAnimation()
				PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', 0)
				ESX.ShowAdvancedNotification('Sécurité', '~b~Voiture', '~g~Ouvert votre~w~ '..vehicleLabel..'~w~', 'CHAR_ELDERS', 10)
				SetVehicleDoorShut(vehicle, 0, false)
				SetVehicleDoorShut(vehicle, 1, false)
				SetVehicleDoorShut(vehicle, 2, false)
				SetVehicleDoorShut(vehicle, 3, false)
				SetVehicleDoorsLocked(vehicle, 0)
				PlayVehicleDoorOpenSound(vehicle, 0)
				if not IsPedInAnyVehicle(playerPed, false) then
	                SetVehicleLights(vehicle, 2)
	                Wait(125)
	                SetVehicleLights(vehicle, 0)
					Wait(125)
				end
			elseif lockStatus == 3 then
				ESX.ShowAdvancedNotification('Sécurité', '~b~Voiture', '~r~Votre véhicule à un sabot', 'CHAR_ELDERS', 10)
			end
		end

	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
end

function lockAnimation()
    local ply = PlayerPedId()
    RequestAnimDict("anim@heists@keycard@")
    while not HasAnimDictLoaded("anim@heists@keycard@") do
        Wait(0)
    end
    TaskPlayAnim(ply, "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(600)
    ClearPedTasks(ply)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle
		vehicle = GetClosestVehicle(coords, 10.0, 0, 71)

		if DoesEntityExist(vehicle) or IsPedInAnyVehicle(playerPed, false) then
			if IsControlJustReleased(0, 303) and IsInputDisabled(0) then
				ToggleVehicleLock()
				Citizen.Wait(2000)
			elseif IsControlJustReleased(0, 173) and not IsInputDisabled(0) then
				ToggleVehicleLock()
				Citizen.Wait(2000)
			elseif IsControlJustReleased(0, 11) and IsInputDisabled(0) then
				openwindows()
				Citizen.Wait(2000)
			end
		else
			Citizen.Wait(500)
		end

		
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
        	local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
            local lock = GetVehicleDoorLockStatus(veh)
            if lock == 7 or lock == 1 then
                SetVehicleDoorsLocked(veh, 2)
            end
            local pedd = GetPedInVehicleSeat(veh, -1)
            if pedd then
                SetPedCanBeDraggedOut(pedd, false)
            end
        end
        if IsControlJustReleased(0, 36) then
			-- emote démarche demarche accroupir
			TriggerEvent('elders_demarche:accroupi')
		end
    end
end)

local windowup = true
function openwindows()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
		if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
            SetEntityAsMissionEntity( playerCar, true, true )
		
			if ( windowup ) then
				RollDownWindow(playerCar, 0)
				RollDownWindow(playerCar, 1)
				windowup = false
			else
				RollUpWindow(playerCar, 0)
				RollUpWindow(playerCar, 1)
				windowup = true
			end
		end
	end
end