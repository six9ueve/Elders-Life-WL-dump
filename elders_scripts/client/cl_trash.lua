ESX = nil
local cachedBins = {}

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent('trash:find')
AddEventHandler('trash:find', function(closestBin)
	local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local x = GetClosestObjectOfType(playerCoords, 2.0, closestBin, false, false, false)
    local entity = nil
    local illegal = false
    if ESX.GetPlayerData().job2.name == 'mafia' or ESX.GetPlayerData().job2.name == 'mafia_1' or ESX.GetPlayerData().job2.name == 'mafia_2' or ESX.GetPlayerData().job2.name == 'mafia_3' or ESX.GetPlayerData().job2.name == 'cartel' or ESX.GetPlayerData().job2.name == 'cartel_1' or ESX.GetPlayerData().job2.name == 'cartel_2' then 
    illegal = true
    end
    if DoesEntityExist(x) then
        entity = x
        bin    = GetEntityCoords(entity)
        if not cachedBins[entity] then
            FreezeEntityPosition(PlayerPedId(),true)
			local progressbartime = math.random(10000, 20000)
			ClearPedTasksImmediately(PlayerPedId())
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
			TriggerEvent("mythic_progbar:client:progress", {
				name = "fouille",
				duration = progressbartime,
				label = "Fouille en cours...",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
			}, function(status)
				if not status then
					ClearPedTasksImmediately(PlayerPedId())
				end
			end)
			Citizen.Wait(progressbartime)
			FreezeEntityPosition(PlayerPedId(),false)
			cachedBins[entity] = true
			TriggerServerEvent('esx-sopletare:getItem',illegal)
        else
            ESX.ShowNotification('Vous avez déjà cherché ici !')
        end
    end
end)