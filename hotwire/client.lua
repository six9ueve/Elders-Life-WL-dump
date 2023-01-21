local function StartHotwiring()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openUI"
    })
end
RegisterNUICallback('basarili', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
		type = "closeUI"
	})
    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), true, true, false)
    SetHornEnabled(GetVehiclePedIsIn(PlayerPedId(), false), true)
    ClearPedTasks(PlayerPedId())
end)
ClearPedTasksImmediately(PlayerPedId())
RegisterCommand("asjıhıuqtguaıwgdhauıyg176213187", function()
    StartHotwiring()
end)

