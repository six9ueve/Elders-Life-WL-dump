ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local function isCarBlacklisted(model)
    for _, blacklistedCar in pairs(Configblvehicle.list) do
        if model == GetHashKey(blacklistedCar) then
            return true
        end
    end
    return false
end

local function checkCar(car)
    if car then
        carModel = GetEntityModel(car)
        carName = GetDisplayNameFromVehicleModel(carModel)
        if isCarBlacklisted(carModel) then
            DeleteVehicle(car)
        end
    end
end
CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        if vehicle then
            checkCar(vehicle)
        end
        Wait(1000)
    end
end)