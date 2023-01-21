ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    for _,v in pairs(ConfigBlips2.blips) do
        v.blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(v.blip, v.id)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.6)
        SetBlipColour(v.blip, v.color)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(v.blip)
    end   
end)