
local inVehicle = false
local fizzPed = nil
local carget = false
local mechBlip = nil


RegisterNUICallback('getCarsValetGKS', function(data, cb)

	if not carget then
		carget = true
		local vehicles = GetGamePool("CVehicle")
		for _, vehicle in pairs(vehicles) do
			local plate = Entity(vehicle).state.plate or GetVehicleNumberPlateText(vehicle)
			if ESX.Math.Trim(plate) == ESX.Math.Trim(data.plate) then
				local vehicleCoords = GetEntityCoords(vehicle)
                SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)
				TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_getr'), img= '/html/static/img/icons/vale.png' })
				carget = false
				return
			end
		end
		ESX.TriggerServerCallback('gksphone:loadVehicle', function(vehicleinfo, coords)
			if vehicleinfo ~= false then
				if vehicleinfo == "nomoney" then
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_checmoney'), img= '/html/static/img/icons/vale.png' })
					carget = false
				else
					local props = json.decode(vehicleinfo.vehicle)
					SpawnVehicle(props, props.plate)
					TriggerServerEvent('gksphone:valet-car-set-outside', props.plate)
				end
			else
				if coords then
					SetNewWaypoint(coords.x, coords.y)
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_getr'), img= '/html/static/img/icons/vale.png' })
				else
					TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_notcoming'), img= '/html/static/img/icons/vale.png' })
				end
				carget = false
			end
		end, data.plate)
	else
		TriggerEvent('gksphone:notifi', {title = _U('vale_title'), message = _U('vale_gete'), img= '/html/static/img/icons/vale.png' })
	end
	cb('ok')
end)




function SpawnVehicle(vehicle, plate)
	if	Config.ValeNPC  then
		local player = PlayerPedId()
		local playerPos = GetEntityCoords(player)
		local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(playerPos.x + math.random(-100, 100), playerPos.y + math.random(-100, 100), playerPos.z, 0, 3, 0)

		local driverhash = 999748158
		local vehhash = vehicle.model

		RequestModel(driverhash)
		RequestModel(vehhash)
		while not HasModelLoaded(driverhash) or not HasModelLoaded(vehhash)  do
			Citizen.Wait(0)
		end

		Wait(500)

		ESX.Game.SpawnVehicle(vehicle.model, {
				x = spawnPos.x,
				y = spawnPos.y,
				z = spawnPos.z + 1
			}, 180.0, function(callback_vehicle)

				ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
				SetVehicleEngineOn(callback_vehicle,true)


				fizzPed = CreatePedInsideVehicle(callback_vehicle, 26, driverhash, -1, true, false)
				mechBlip = AddBlipForEntity(callback_vehicle)
				SetBlipSprite(mechBlip, 225)                                                      	--Blip Spawning.
				SetBlipFlashes(mechBlip, true)
				SetBlipColour(mechBlip, 0)
				SetBlipFlashes(mechBlip, false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(vehicle.plate)
				EndTextCommandSetBlipName(mechBlip)

				inVehicle = true
				GiveKeyCar(GetVehicleNumberPlateText(callback_vehicle))
				TaskVehicle(callback_vehicle, vehhash)
		end)

	else

		local player = PlayerPedId()
		local playerPos = GetEntityCoords(player)
		local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(playerPos.x + math.random(-30, 30), playerPos.y + math.random(-30, 30), playerPos.z, 0, 3, 0)

		local driverhash = 999748158
		local vehhash = vehicle.model

		RequestModel(driverhash)
		RequestModel(vehhash)
		while not HasModelLoaded(driverhash) or not HasModelLoaded(vehhash)  do
			Citizen.Wait(0)
		end

		Wait(500)

		ESX.Game.SpawnVehicle(vehicle.model, {
				x = spawnPos.x,
				y = spawnPos.y,
				z = spawnPos.z + 1
			}, 180.0, function(callback_vehicle)

				ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
				SetVehicleEngineOn(callback_vehicle,true)

				mechBlip = AddBlipForEntity(callback_vehicle)
				SetBlipSprite(mechBlip, 225)                                                      	--Blip Spawning.
				SetBlipFlashes(mechBlip, true)
				SetBlipColour(mechBlip, 0)
				SetBlipFlashes(mechBlip, false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(vehicle.plate)
				EndTextCommandSetBlipName(mechBlip)

				GiveKeyCar(GetVehicleNumberPlateText(callback_vehicle))
				Citizen.Wait(10000)
				RemoveBlip(mechBlip)
				mechBlip = nil
				carget = false
		end)

	end
	carget = false
end

function TaskVehicle(vehicle, vehhash)
	while inVehicle do
		Citizen.Wait(750)
		local pedcoords = GetEntityCoords(PlayerPedId())
		local plycoords = GetEntityCoords(fizzPed)
		local dist = GetDistanceBetweenCoords(plycoords, pedcoords.x,pedcoords.y,pedcoords.z, false)

		if dist <= 40.0 then
			TaskVehicleDriveToCoord(fizzPed, vehicle, pedcoords.x, pedcoords.y, pedcoords.z, 20.0, 1, vehhash, 786603, 5.0, 1)
			SetVehicleFixed(vehicle)
			if dist <= 7.5 then
				LeaveIt(vehicle)
				break
			else
				Citizen.Wait(500)
			end
		else
			TaskVehicleDriveToCoord(fizzPed, vehicle, pedcoords.x, pedcoords.y, pedcoords.z, 60.0, 1, vehhash, 2883621, 15.0, 1)
			Citizen.Wait(500)
		end
	end
end

function LeaveIt(vehicle)
	TaskLeaveVehicle(fizzPed, vehicle, 14)
	inVehicle = false
	while IsPedInAnyVehicle(fizzPed, false) do
		Citizen.Wait(0)
	end

	Citizen.Wait(500)
	TaskWanderStandard(fizzPed, 10.0, 10)
	Citizen.Wait(10000)
	DeleteEntity(fizzPed)
	RemoveBlip(mechBlip)
	mechBlip = nil
	fizzPed = nil
	carget = false
end


