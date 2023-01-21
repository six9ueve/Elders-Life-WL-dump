ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local ismuted = false

AddEventHandler('SaltyChat_PluginStateChanged', function(PluginState) 
        if PluginState == 2 or PluginState == 3 then 
            --SendNUIMessage({action = "toggleWindow", value = "false"})
            ismuted = false
        else
            --SendNUIMessage({action = "toggleWindow", value = "true"})
            ismuted = true
        end
end)

Citizen.CreateThread(function()
    Citizen.Wait(30000)
    ESX.TriggerServerCallback('SaltyNUI:getUsergroup', function(group)playergroup = group end)        

    while true do
        if ismuted and not playergroup == 'superadmin' then
            ESX.ShowNotification("⛔ Vous n'êtes pas connecté à Teamspeak ⛔", 'TEAMSPEAK')

            Citizen.Wait(1)
            FreezeEntityPosition(PlayerPedId(), true)
        else
            Citizen.Wait(1000)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)