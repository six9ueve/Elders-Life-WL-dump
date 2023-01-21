ESX = nil
local isMenuOpenedpawn = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("BlackM", "princ", RageUI.CreateMenu("Black Market", "~b~Menu BlackMarket :", nil, nil, "aLib", "black"))
RMenu:Get("BlackM", "princ").Closed = function()
    isMenuOpenedblack = false
end

local function openMenublack()

    if isMenuOpenedblack then return end
    isMenuOpenedblack = true

    RageUI.Visible(RMenu:Get("BlackM", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpenedblack do
            RageUI.IsVisible(RMenu:Get("BlackM", "princ"),true,true,true,function()                
                RageUI.Separator('↓ Achat ↓')
                for k,v in pairs(ConfigBlackmarket.items) do
                    RageUI.ButtonWithStyle(v.nom..' $'..v.prix, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                            amount = tonumber(amount)
                            if amount == nil or amount < 1 then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                                return
                            end
                            TriggerServerEvent('elders_life:!:shop_blackmarket', v.nom, v.arme, v.prix , amount)
                        end
                    end)
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name ~= "unemployed" and ESX.PlayerData.job2.name ~= "unemployed2" and ESX.PlayerData.job.name ~= "police" and ESX.PlayerData.job.name ~= "sheriff" and ESX.PlayerData.job.name ~= "offpolice" and ESX.PlayerData.job.name ~= "offsheriff" then     
            local playerPos = GetEntityCoords(PlayerPedId()) 
            local pos1 = ConfigBlackmarket.pos
            local distancePlayerBlack = #(playerPos - pos1)
            if distancePlayerBlack < 15 then
                interval = 1
                DrawMarker(22, ConfigBlackmarket.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                if distancePlayerBlack <= 1.2 and not isMenuOpenedblack then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Black Market")
                    if IsControlJustPressed(1,51) then
                        openMenublack()
                    end
                end
            end     
            Citizen.Wait(interval)
        else
        Citizen.Wait(interval)
        end
    end
end)