ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("Casino_jeton", "achat", RageUI.CreateMenu("Jetons", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("Casino_jeton", "achat").Closed = function()
    isMenuOpened = false
end


local function OpenMenuJetonkcasino()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Casino_jeton", "achat"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("Casino_jeton", "achat"),true,true,true,function()
                RageUI.Separator('~y~↓ ~w~Achat Jetons ~y~↓')
                RageUI.ButtonWithStyle("Nombre de Jetons (5$/unité)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                            local amount = KeyboardInput("Prix", "Prix", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                TriggerServerEvent("CASINO:AchatJeton", amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                    end
                end)
                RageUI.Separator('~y~↓~w~ Vente Jetons ~y~↓')
                RageUI.ButtonWithStyle("Nombre de Jetons (5$/unité)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                           local amount = KeyboardInput("Prix", "Prix", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                TriggerServerEvent("CASINO:rachatJeton", amount)
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
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = vector3(1116.02,220.28,-49.44)
                if #(plyCoords - pos) < 6 then
                    interval = 1
                    DrawMarker(22,  pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~b~[E] ~s~pour accèder au ~b~guichet ~s~!")
                        if IsControlJustPressed(1,51) then
                            OpenMenuJetonkcasino()
                        end
                    end
                end
        Citizen.Wait(interval)
    end
end)