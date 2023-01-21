AddEventHandler('playerSpawned', function()
    Citizen.Wait(1000)
    TriggerServerEvent("aSpawnpoint:requestpos")
    spawn = true
end)

RegisterNetEvent("aSpawnpoint:setcoords")
AddEventHandler("aSpawnpoint:setcoords", function(coords, life)
    if coords ~= nil then
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, false)
    end
    Citizen.Wait(500)
    if life ~= nil then
        SetEntityHealth(PlayerPedId(), life)
    end
    SetPedMaxTimeUnderwater(PlayerPedId(), 40.0)
end)

--Citizen.CreateThread(function()
    --while true do
        --Wait(1500)
        --print(PlayerPedId())
        --if spawn then
            --lifeplayer = GetEntityHealth(PlayerPedId())
            --TriggerServerEvent("aSpawnpoint:savelife",lifeplayer)
        --end
    --end
--end)

RegisterNetEvent("aSpawnpoint:setlife")
AddEventHandler("aSpawnpoint:setlife", function(life)
    Citizen.Wait(3000)
    if life ~= nil then
        SetEntityHealth(PlayerPedId(), life)
    end
end)

RegisterNetEvent("aSpawnpoint:lifesave")
AddEventHandler("aSpawnpoint:lifesave", function()
    lifeplayer = GetEntityHealth(PlayerPedId())
    TriggerServerEvent("aSpawnpoint:savelife",lifeplayer)
end)