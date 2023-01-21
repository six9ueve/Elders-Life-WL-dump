local cooldown = 0

RegisterNetEvent("dr-scratching:isActiveCooldown", function()
	TriggerServerEvent("dr-scratching:handler", cooldown > 0 and true or false, cooldown)
end)

RegisterNetEvent("dr-scratching:setCooldown", function()
  cooldown = Config.ScratchCooldownInSeconds
	CreateThread(function()
		while (cooldown ~= 0) do
			Wait(1000)
			cooldown = cooldown - 1
		end
	end)
end)

RegisterNetEvent("dr-scratching:startScratchingEmote", function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
end)

RegisterNetEvent("dr-scratching:stopScratchingEmote", function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('dr-scratching:deposit', data.key, data.price, data.amount, data.type)
end)