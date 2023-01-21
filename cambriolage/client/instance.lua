JoinInstance = function(id, data)
    DecorSetInt(PlayerPedId(), 'instance', id)
    cachedData["instanced"] = true
    cachedData["instanceId"] = id
    NetworkSetVoiceChannel(data["Pos"])
end

ExitInstance = function()
    DecorSetInt(PlayerPedId(), 'instance', 0)
    NetworkClearVoiceChannel()
    cachedData["instanced"] = false
end

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        if cachedData["instanced"] then
            sleep = 5
            local players = ESX.Game.GetPlayers()
            for i=1, #players do
                if DecorGetInt(GetPlayerPed(players[i]), 'instance') ~= cachedData["instanceId"] and players[i] ~= PlayerId() then
                    SetPlayerInvisibleLocally(players[i], true)
                    SetEntityNoCollisionEntity(PlayerPedId(), GetPlayerPed(players[i]), true)
                    SetEntityCoords(GetPlayerPed(players[i]), 0.0, 0.0, 0.0)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)