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

local function OpenPawnshop()

    if isMenuOpenedpawn then return end
    isMenuOpenedpawn = true

    RageUI.Visible(RMenu:Get("PawnShop", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpenedpawn do
            RageUI.IsVisible(RMenu:Get("PawnShop", "princ"),true,true,true,function()                
                RageUI.Separator('↓ Vos items ↓')
                ESX.PlayerData = ESX.GetPlayerData()
                for i = 1, #ESX.PlayerData.inv do
                    item = ESX.PlayerData.inv[i]
                    price = ConfigPawn.PawnshopItems[item.name]
                    if price and item.count > 0 then
                        RageUI.ButtonWithStyle('x'..item.count..' '..item.label..' $'..ESX.Math.GroupDigits(price).. '(prix unitaire)', nil, {RightLabel = "->>"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("atmos", "Combien ?","", 4)
                                count = tonumber(count)
                                local timer = math.random(1,50)
                                Citizen.Wait(timer)
                                if count == nil then 
                                    ESX.ShowNotification("~r~Problème~s~ : Case vide !")
                                elseif count <= item.count then
                                    TriggerServerEvent('r3_prospecting:sellItem', item.name, count)
                                else
                                    ESX.ShowNotification("~r~Problème~s~ : Pas assez de produit !")
                                end
                                RageUI.CloseAll()
                                isMenuOpenedpawn = false
                                wasOpen = false
                            end
                        end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function Draw3DText(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(coords, vector3(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z), true) < 1.5 then
            if ConfigPawn.EnableOpeningHours then
                local ClockTime = GetClockHours()
                if ConfigPawn.CloseHour < ConfigPawn.OpenHour then
                    if (ClockTime >= ConfigPawn.OpenHour and ClockTime < 24) or (ClockTime <= ConfigPawn.CloseHour -1 and ClockTime > 0) then
                        if not isMenuOpenedpawn then
                            Draw3DText(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z, "~g~E~w~ - ouvrir le Pawnshop")
                            if IsControlJustReleased(0, 38) then
                                wasOpen = true
                                OpenPawnshop()
                            end
                        else
                            Citizen.Wait(500)
                        end
                    else
                        Draw3DText(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z, "Reviens la nuit, le recelleur ouvre à ~r~" .. ConfigPawn.OpenHour ..":00")
                    end
                else
                    if ClockTime >= ConfigPawn.OpenHour and ClockTime <= ConfigPawn.CloseHour - 1 then
                        if not isMenuOpenedpawn then
                            Draw3DText(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z, "~g~E~w~ - Le recelleur est disponible")
                            if IsControlJustReleased(0, 38) then
                                wasOpen = true
                                OpenPawnshop()
                            end
                        else
                            Citizen.Wait(500)
                        end
                    else
                        Draw3DText(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z, "Le recelleur est fermé, reviens la nuit après ~r~" .. ConfigPawn.OpenHour ..":00")
                    end
                end
            else
                if not isMenuOpenedpawn then
                    Draw3DText(ConfigPawn.PawnshopLocation.x, ConfigPawn.PawnshopLocation.y, ConfigPawn.PawnshopLocation.z, "~g~E~w~ - Le recelleur est disponible")
                    if IsControlJustReleased(0, 38) then
                        wasOpen = true
                        OpenPawnshop()
                    end
                else
                    Citizen.Wait(500)
                end
            end
        else
            isMenuOpenedpawn = false
            wasOpen = false
            Citizen.Wait(500)
        end
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

RMenu.Add("PawnShop", "princ", RageUI.CreateMenu("PawnShop", "~b~Menu PawnShop :", nil, nil, "aLib", "black"))
RMenu:Get("PawnShop", "princ").Closed = function()
end