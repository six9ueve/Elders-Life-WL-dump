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
local ConcessAirMenu = {
    {MainMenu = "Liste véhicules : Hélicoptère", submenu = "heli"},
    {MainMenu = "Liste véhicules : Avion", submenu = "plane"}
}

Citizen.CreateThread(function()
    for i = 48,  57 do table.insert(ConcessAir.NumberPlate, string.char(i)) end
    for i = 65,  90 do table.insert(ConcessAir.LettePlate, string.char(i)) end
    for i = 97, 122 do table.insert(ConcessAir.LettePlate, string.char(i)) end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    PlayerData.job = job
end)


RMenu.Add("airWolrd", "Concess_Air_menu_main", RageUI.CreateMenu("Concessionaire", "~b~Avion :", nil, nil, "aLib", "black"))
RMenu:Get("airWolrd", "Concess_Air_menu_main").Closed = function()
    isMenuOpened = false
    DeleteVehicle(ConcessAir.InfosVeh.entity)
end

for k,v in pairs(ConcessAirMenu) do
    RMenu.Add("airWolrd", v.submenu, RageUI.CreateSubMenu(RMenu:Get("airWolrd", "Concess_Air_menu_main"), "Concessionaire", "INTÉRACTIONS"))
    RMenu:Get("airWolrd", v.submenu).Closed = function()
    DeleteVehicle(ConcessAir.InfosVeh.entity)
    end
end

RMenu.Add("airWolrd", "ConcessAir_menu_buy", RageUI.CreateSubMenu(RMenu:Get("airWolrd", "Concess_Air_menu_main"), "Concessionaire", "~b~Actions"))
RMenu:Get("airWolrd", "ConcessAir_menu_buy").Closed = function()
    DeleteVehicle(ConcessAir.InfosVeh.entity)
end


local function openMenuAchatAir()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("airWolrd", "Concess_Air_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("airWolrd", "Concess_Air_menu_main"),true,true,true,function()
                        for k,v in pairs(ConcessAirMenu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ConcessAir.kSelected = k
                                end
                            end, RMenu:Get("airWolrd", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessAirMenu) do    
                        RageUI.IsVisible(RMenu:Get("airWolrd", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigAirShop["AIR"][ConcessAir.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessAir.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessAir.InfosVeh.entity)
                                            CreateVehiculeAir(GetHashKey(w.model), "preview")
                                        end
                                    end
                                    if s then
                                        ConcessAir.GarageLabel = w.label
                                        ConcessAir.GarageModel = w.model
                                        ConcessAir.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("airWolrd", "ConcessAir_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigAirShop["AIR"][ConcessAir.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/350, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/4220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/6, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                                RageUI.BoutonPanel("Prix d'achat :  ", "~g~"..actuality.price.."$", actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("airWolrd", "ConcessAir_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessAir.GarageLabel)
                        RageUI.Separator("Prix d'achat du véhicule : ~b~"..ConcessAir.GaragePriceBuy.."$")
                        RageUI.ButtonWithStyle("Acheter le véhicule (Perso)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessAir.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessAir.InfosVeh.entity)
                                            ConcessAir.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableAir", ConcessAir.GarageModel, VehiculesProps.plate,ConcessAir.GaragePriceBuy)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessAir.GarageModel, vector3(-979.705, -2992.628, 13.94), 59.56, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessAir.InfosVeh.entity)
                                            ConcessAir.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessAir.GaragePriceBuy)

                                end
                        end)                     
                    end)     
                
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigAirShop.points) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.achat
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Magasin")
                        if IsControlJustPressed(1,51) then
                            ESX.TriggerServerCallback('god_license:checkLicense', function(hasAirLicense)
                                if hasAirLicense then
                                    openMenuAchatAir()
                                else
                                    ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas le permis Avion !', 'CHAR_ELDERS', 10)
                                end
                            end, GetPlayerServerId(PlayerId()), 'aircraft')
                        end
                    end
            end
        end
        Citizen.Wait(interval)
    end
end)

function CreateVehiculeAir(model, state)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1)  ESX.ShowHelpNotification("~g~Chargement en cours du véhicule...") end
    if state == nil then
        veh = CreateVehicle(model, -979.705, -2992.628, 13.94, 100.0, false, true)
    elseif state == "preview" then
        veh = CreateVehicle(model, -979.705, -2992.628, 13.94, 163.94, false, true)
    else
        veh = CreateVehicle(model, -979.705, -2992.628, 13.94, 235.94, false, true)
    end
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    ConcessAir.InfosVeh.entity = veh
    ConcessAir.InfosVeh.model = model
    ConcessAir.InfosVeh.props = ESX.Game.GetVehicleProperties(veh)
    if name ~= nil then ConcessAir.InfosVeh.name = name end
    SetModelAsNoLongerNeeded(model)
    ConcessAir.RototaeStatus = true
    SetEntityHeading(veh, 59.56)
end