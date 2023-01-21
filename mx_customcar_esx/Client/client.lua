vehicle_id = -1
vehicle_dist = 0
current_custom = {}
new_custom = {}

-- Press E on top of the blip to open Nui 
RegisterCommand(''..'mx_opencustomcar', function()
    local dist = next_dist
    if dist < (dist_ped / 2) then
        if not open then
            TriggerServerEvent("Mx :: OpenCustomCar", next_marker.permission)
        end
    end
end, false)
RegisterKeyMapping(''..'mx_opencustomcar', ''..'mx_opencustomcar', 'keyboard', 'e')

-- Save the vehicle by clicking the save button
RegisterNUICallback('SaveCustom', function(data, cb)
    if not CustomFree and tonumber(custom_price) > 0 then
        TriggerServerEvent("Mx :: SaveCustom", new_custom, custom_price)
    elseif CustomFree and custom_price == 'Free' then
        TriggerServerEvent("Mx :: SaveCustom", new_custom, 0)
    else
        TriggerEvent("Mx :: CustomCarNotification", texts.no_custom)
    end
    cb('ok')
end)

-- Event to enable notification on NUI
RegisterNetEvent('Mx :: CustomCarNotification')
AddEventHandler('Mx :: CustomCarNotification', function(text)
    SendNUIMessage({
        ui = 'Notification',
        text = text,
    })
end)

-- Vehicle not found
RegisterNetEvent('Mx :: VehicleNotFound')
AddEventHandler('Mx :: VehicleNotFound', function(veh_propers)
    current_custom = veh_propers
    TriggerEvent("Mx :: CustomCarNotification", texts.VehicleNotFound)
end)

-- Vehicle Save
RegisterNetEvent('Mx :: VehicleSave')
AddEventHandler('Mx :: VehicleSave', function(veh_propers)
    current_custom = veh_propers
    TriggerEvent("Mx :: CustomCarNotification", texts.VehicleSave)
end)

-- Get Vehicle save
RegisterNetEvent('Mx :: CustomCarGeted')
AddEventHandler('Mx :: CustomCarGeted', function(veh_propers, veh_id)
    SetProperVehicle(veh_id, veh_propers)
end)