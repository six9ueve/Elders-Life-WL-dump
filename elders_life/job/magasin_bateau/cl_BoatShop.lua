ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)

    end
    PlayerData = {}
    PlayerData = ESX.GetPlayerData()
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true
local ConcessBoatMenu = {
    {MainMenu = "Liste véhicules : Bateau", submenu = "boat"}
}

local function CreateVehiculeBoat(model, state)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1)  ESX.ShowHelpNotification("~g~Chargement en cours du véhicule...") end
    if state == nil then
        veh = CreateVehicle(model, -714.4643, -1334.683, 0.86, 100.0, false, true)
    elseif state == "preview" then
        veh = CreateVehicle(model, -714.4643, -1334.683, 0.86, 163.94, false, true)
    else
        veh = CreateVehicle(model, -714.4643, -1334.683, 0.86, 235.94, false, true)
    end
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    ConcessBoat.InfosVeh.entity = veh
    ConcessBoat.InfosVeh.model = model
    ConcessBoat.InfosVeh.props = ESX.Game.GetVehicleProperties(veh)
    if name ~= nil then ConcessBoat.InfosVeh.name = name end
    SetModelAsNoLongerNeeded(model)
    ConcessBoat.RototaeStatus = true
    SetEntityHeading(veh, 136.08)
end

Citizen.CreateThread(function()
    for i = 48,  57 do table.insert(ConcessBoat.NumberPlate, string.char(i)) end
    for i = 65,  90 do table.insert(ConcessBoat.LettePlate, string.char(i)) end
    for i = 97, 122 do table.insert(ConcessBoat.LettePlate, string.char(i)) end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    PlayerData.job = job
end)


RMenu.Add("BoatWolrd", "Concess_Boat_menu_main", RageUI.CreateMenu("Concessionaire", "~b~Bateau :", nil, nil, "aLib", "black"))
RMenu:Get("BoatWolrd", "Concess_Boat_menu_main").Closed = function()
    isMenuOpened = false
    DeleteVehicle(ConcessBoat.InfosVeh.entity)
end

RMenu.Add("BoatWolrdLicense", "Concess_Boat_menu_main_License", RageUI.CreateMenu("Concessionaire", "~b~Bateau :", nil, nil, "aLib", "black"))
RMenu:Get("BoatWolrdLicense", "Concess_Boat_menu_main_License").Closed = function()
    isMenuOpened = false
end

for k,v in pairs(ConcessBoatMenu) do
    RMenu.Add("BoatWolrd", v.submenu, RageUI.CreateSubMenu(RMenu:Get("BoatWolrd", "Concess_Boat_menu_main"), "Concessionaire", "INTÉRACTIONS"))
    RMenu:Get("BoatWolrd", v.submenu).Closed = function()
    DeleteVehicle(ConcessBoat.InfosVeh.entity)
    end
end

RMenu.Add("BoatWolrd", "ConcessBoat_menu_buy", RageUI.CreateSubMenu(RMenu:Get("BoatWolrd", "Concess_Boat_menu_main"), "Concessionaire", "~b~Actions"))
RMenu:Get("BoatWolrd", "ConcessBoat_menu_buy").Closed = function()
    DeleteVehicle(ConcessBoat.InfosVeh.entity)
end


local function openMenuAchatBoat()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("BoatWolrd", "Concess_Boat_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("BoatWolrd", "Concess_Boat_menu_main"),true,true,true,function()
                        for k,v in pairs(ConcessBoatMenu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ConcessBoat.kSelected = k
                                end
                            end, RMenu:Get("BoatWolrd", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessBoatMenu) do    
                        RageUI.IsVisible(RMenu:Get("BoatWolrd", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigBoatShop["BOAT"][ConcessBoat.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessBoat.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessBoat.InfosVeh.entity)
                                            CreateVehiculeBoat(GetHashKey(w.model), "preview")
                                        end
                                    end
                                    if s then
                                        ConcessBoat.GarageLabel = w.label
                                        ConcessBoat.GarageModel = w.model
                                        ConcessBoat.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("BoatWolrd", "ConcessBoat_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigBoatShop["BOAT"][ConcessBoat.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/350, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/6220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/6, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                                RageUI.BoutonPanel("Prix d'achat :  ", "~g~"..actuality.price.."$", actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("BoatWolrd", "ConcessBoat_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessBoat.GarageLabel)
                        RageUI.Separator("Prix d'achat du véhicule : ~b~"..ConcessBoat.GaragePriceBuy.."$")
                        RageUI.ButtonWithStyle("Acheter le véhicule (Perso)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessBoat.InfosVeh.entity,  false)
                                            Citizen.Wait(100)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessBoat.InfosVeh.entity)
                                            ConcessBoat.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableBoat", ConcessBoat.GarageModel, VehiculesProps.plate, VehiculesProps, ConcessBoat.GaragePriceBuy)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessBoat.GarageModel, vector3(-714.4643, -1334.683, 0.86), 136.08, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessBoat.InfosVeh.entity)
                                            ConcessBoat.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessBoat.GaragePriceBuy)

                                end
                        end)                      
                    end)     
                
            Wait(0)
        end
    end)
end

local function OpenBuyLicenseMenuBoat()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("BoatWolrdLicense", "Concess_Boat_menu_main_License"), true)
        Citizen.CreateThread(function()

            while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("BoatWolrdLicense", "Concess_Boat_menu_main_License"),true,true,true,function()

                    RageUI.ButtonWithStyle("Acheter license Bateau", nil, {RightLabel = "~r~"..ConfigBoatShop.price.."$"}, true,function(a,h,s)
                                if s then
                                        ESX.TriggerServerCallback('god:buyLicenseBoat', function(bought)
                                            if bought then
                                                openMenuAchatBoat()
                                            else
                                                RageUI.CloseAll()
                                                isMenuOpened = false
                                            end
                                        end)                         
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
        for k, v in pairs(ConfigBoatShop.points) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.achat
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Magasin")
                        if IsControlJustPressed(1,51) then
                            ESX.TriggerServerCallback('god_license:checkLicense', function(hasBoatingLicense)
                                if hasBoatingLicense then
                                    openMenuAchatBoat()
                                else
                                    OpenBuyLicenseMenuBoat()
                                end
                            end, GetPlayerServerId(PlayerId()), 'boating')
                        end
                    end
            end
        end
        Citizen.Wait(interval)
    end
end)
