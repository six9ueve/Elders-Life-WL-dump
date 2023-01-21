ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("Banque", "achat", RageUI.CreateMenu("Banque", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("Banque", "achat").Closed = function()
    isMenuOpened = false
end


local function openMenuTrocLingot()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Banque", "achat"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("Banque", "achat"),true,true,true,function()
                RageUI.Separator('↓ Achat Lingot d\'or ↓')
                RageUI.ButtonWithStyle("Montant", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                            local amount = KeyboardInput("Prix", "Prix", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                TriggerServerEvent('god:AchatLingotOr', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                    end
                end)
                RageUI.Separator('↓ Vente Lingot d\'or ↓')
                RageUI.ButtonWithStyle("Nombre de Lingot d'or", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                           local amount = KeyboardInput("Prix", "Prix", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                TriggerServerEvent('god:VenteLingotOr', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigLingot.points) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.achat
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    --DrawMarker(1, v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la banque")
                        if IsControlJustPressed(1,51) then
                            openMenuTrocLingot()
                        end
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)