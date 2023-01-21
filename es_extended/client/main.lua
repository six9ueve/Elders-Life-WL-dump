local pickups = {}
ESX.IsDead = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('god:onPlayerJoined')
			break
		end
	end
end)

Citizen.CreateThread(function()
	repeat Citizen.Wait(0) until ESX.PlayerData
	repeat Citizen.Wait(0) until ESX.PlayerData.weight
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.weight > ESX.PlayerData.maxWeight then
			SetPedMoveRateOverride(PlayerPedId(), 0.5)
			DisableControlAction(0, 22, true)

			if IsControlPressed(0, 21) then
				DisableControlAction(0, 21, true)
				ForcePedMotionState(PlayerPedId(), 'motionstate_walk', 0, 0, 0)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
	print('god:playerLoaded')
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer

	if GetEntityModel(PlayerPedId()) == 'PLAYER_ZERO' then
		local defaultModel = 'a_m_y_stbla_02'
		RequestModel(defaultModel)

		while not HasModelLoaded(defaultModel) do
			Citizen.Wait(10)
		end

		SetPlayerModel(PlayerId(), defaultModel)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetPedRandomComponentVariation(PlayerPedId(), true)
		SetModelAsNoLongerNeeded(defaultModel)
	end

	-- freeze the player
	FreezeEntityPosition(PlayerPedId(), true)

	-- enable PVP
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)

	-- disable wanted level
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	--ESX.Game.Teleportspawn(PlayerPedId(), {
	--	x = xPlayer.coords.x,
	--	y = xPlayer.coords.y,
	--	z = xPlayer.coords.z + 0.2,
	--	heading = xPlayer.coords.heading
	--}, function()
		TriggerServerEvent('god:onPlayerSpawn')
		TriggerEvent('god:onPlayerSpawn')
		TriggerEvent('god:restoreLoadout')

		--Citizen.Wait(4000)
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		--Citizen.Wait(500)
		FreezeEntityPosition(PlayerPedId(), false)
		--Citizen.Wait(5000)
		--DoScreenFadeIn(10000)
		--TriggerServerEvent("vMenu:RequestPermissions")

		--TriggerEvent('god:loadingScreenOff')
	--end)

end)

RegisterNetEvent('god_ambulancejob:justRespawned')
AddEventHandler('god_ambulancejob:justRespawned', function()
	ESX.IsDead = false
end)

RegisterNetEvent('god_ambulancejob:revive')
AddEventHandler('god_ambulancejob:revive', function()
	ESX.IsDead = false
end)

RegisterNetEvent('god:setMaxWeight')
AddEventHandler('god:setMaxWeight', function(newMaxWeight)
	ESX.PlayerData.maxWeight = newMaxWeight
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

AddEventHandler('god:onPlayerSpawn', function() ESX.IsDead = false end)
AddEventHandler('god:onPlayerDeath', function() ESX.IsDead = true end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end
	TriggerEvent('god:restoreLoadout')
end)

RegisterNetEvent('god:setAccountMoney')
AddEventHandler('god:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:addInventoryItem')
AddEventHandler('god:addInventoryItem', function(item, count, silent)
	local found = false
	for k,v in ipairs(ESX.PlayerData.inv) do
		if v.name == item.name then
			ESX.PlayerData.inv[k] = item
			found = true
			break
		end
	end

	if not found then
		table.insert(ESX.PlayerData.inv, item)
	end

	ESX.PlayerData.weight = ESX.PlayerData.weight + (item.weight * count)

	if not silent then
		ESX.UI.ShowInventoryItemNotification(true, item, count)
	end
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:removeInventoryItem')
AddEventHandler('god:removeInventoryItem', function(item, count, silent)
	for k,v in ipairs(ESX.PlayerData.inv) do
		if v.name == item.name then
			ESX.PlayerData.inv[k] = item
			if item.count < 0 then
				table.remove(ESX.PlayerData.inv, k)
			end
			break
		end
	end

	ESX.PlayerData.weight = ESX.PlayerData.weight - (item.weight * count)

	if not silent then
		ESX.UI.ShowInventoryItemNotification(false, item, count)
	end
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:onUpdateMaxWeight')
AddEventHandler('god:onUpdateMaxWeight', function(maxWeight)
	ESX.PlayerData.maxWeight = maxWeight
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job2)
	ESX.PlayerData.job2 = job2
	TriggerEvent('god:changedPlayerData', ESX.GetPlayerData())
end)

RegisterNetEvent('god:teleport')
AddEventHandler('god:teleport', function(coords)
	local playerPed = PlayerPedId()

	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	ESX.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('god:createPickup')
AddEventHandler('god:createPickup', function(pickupId, label, coords, type, name, components, tintIndex)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, false, true)

		pickups[pickupId] = {
			obj = object,
			label = label,
			inRange = false,
			coords = vector3(coords.x, coords.y, coords.z)
		}
	end

	ESX.Game.SpawnLocalObject('prop_cs_box_clothes', coords, setObjectProperties)
end)

RegisterNetEvent('god:createMissingPickups')
AddEventHandler('god:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		TriggerEvent('god:createPickup', pickupId, pickup.label, pickup.coords, pickup.type, pickup.name, pickup.components, pickup.tintIndex)
	end
end)

RegisterNetEvent('god:spawnCar')
AddEventHandler('god:spawnCar', function(model)
	ESX.Game.SpawnVehicle(model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		SetVehicleDoorsLocked(vehicle, 0)
	end)
end)

RegisterNetEvent('god:registerSuggestions')
AddEventHandler('god:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('god:removePickup')
AddEventHandler('god:removePickup', function(pickupId)
	if pickups[pickupId] and pickups[pickupId].obj then
		ESX.Game.DeleteObject(pickups[pickupId].obj)
		pickups[pickupId] = nil
	end
end)

RegisterNetEvent('god:deleteVehicle')
AddEventHandler('god:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)
		local list = {}
		for k,v in pairs(vehicles) do
			table.insert(list, NetworkGetNetworkIdFromEntity(v))
		end
		TriggerServerEvent("god:deleteEntityTable", list)
	else
		local radius = 2.0
		local vehicle = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)
		local list = {}
		for k,v in pairs(vehicle) do
			table.insert(list, NetworkGetNetworkIdFromEntity(v))
		end
		TriggerServerEvent("god:deleteEntityTable", list)
	end
end)

RegisterNetEvent('god:stuck')
AddEventHandler('god:stuck', function()
    local pos = GetEntityCoords(PlayerPedId())
    local interiorid = GetInteriorAtCoords(pos.x, pos.y, pos.z)

    if #(GetEntityCoords(PlayerPedId()).xy) < 30 or GetEntityCoords(PlayerPedId()).z < -30 or interiorid ~= 0 then
        ClearPedTasksImmediately(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true, 1)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), 241.23, -807.15, 30.27, false, false, false, true)
        if IsInProperty then
            TriggerServerEvent('god_property:BeUnstuck')
        end
        TriggerEvent('chatMessage', "", {0,0,0}, "^1^*Vous vous êtes débloqué !")
    else
        TriggerEvent('chatMessage', "", {0,0,0}, "^1^*Vous n'êtes pas bloqué")
    end
end)

-- Pickups
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords, letSleep = GetEntityCoords(playerPed), true
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(playerCoords)

		for pickupId,pickup in pairs(pickups) do
			local distance = #(playerCoords - pickup.coords)

			if distance < 5 then
				local label = pickup.label
				letSleep = false

				if distance < 1 then
					if IsControlJustReleased(0, 38) then
						if IsPedOnFoot(playerPed) and (closestDistance == -1 or closestDistance > 3) and not pickup.inRange then
							pickup.inRange = true

							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							ESX.Streaming.RequestAnimDict(dict)
							TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
							Citizen.Wait(1000)

							TriggerServerEvent('god:onPickup', pickupId)
							PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						end
					end

					label = ('%s~n~%s'):format(label, _U('threw_pickup_prompt'))
				end

				ESX.Game.Utils.DrawText3D({
					x = pickup.coords.x,
					y = pickup.coords.y,
					z = pickup.coords.z + 0.25
				}, label, 1.2, 4)
			elseif pickup.inRange then
				pickup.inRange = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('god:setHealth')
AddEventHandler('god:setHealth', function(health)
	SetEntityHealth(PlayerPedId(), health)
end)

RegisterNetEvent('god:setHealthEntity')
AddEventHandler('god:setHealthEntity', function(netId, health)
	SetEntityHealth(NetworkGetEntityFromNetworkId(netId), health)
end)

RegisterNetEvent('god:setVehicleProps')
AddEventHandler('god:setVehicleProps', function(netId, vehicleProps)
	if NetworkDoesEntityExistWithNetworkId(netId) then
		ESX.Game.SetVehicleProperties(NetworkGetEntityFromNetworkId(netId), vehicleProps)
	end
end)

local freeze = false
RegisterNetEvent('god:freeze')
AddEventHandler('god:freeze', function()
	freeze = not freeze
	FreezeEntityPosition(PlayerPedId(), freeze)
end)

RegisterNetEvent('god:setArmor')
AddEventHandler('god:setArmor', function(armor)
	SetPedArmour(PlayerPedId(), armor)
end)

RegisterNetEvent('god:setPlayerModel')
AddEventHandler('god:setPlayerModel', function(model)
	if type(model) == 'string' then model = GetHashKey(model) end
	ESX.Streaming.RequestModel(model)
	SetPlayerModel(PlayerId(), model)
	--SetModelAsNoLongerNeeded(model)
end)

local lastNotifOverweight = 0
AddEventHandler('god:changedPlayerData', function(PlayerData)
	if PlayerData.weight > PlayerData.maxWeight then
		if GetGameTimer() - lastNotifOverweight > 15 * 60 * 1000 then
			ESX.ShowNotification('~r~Trop de poids sur vous ... Vous vous déplacerez plus lentement !')
			lastNotifOverweight = GetGameTimer()
		end
	end
end)