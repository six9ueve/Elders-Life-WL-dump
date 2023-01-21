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
local ConcessTruckTruckMenu = {
    {MainMenu = "Liste véhicules : Box", submenu = "box"},
    {MainMenu = "Liste véhicules : Haul", submenu = "haul"},
    {MainMenu = "Liste véhicules : Autres", submenu = "others"},
    {MainMenu = "Liste véhicules : Remorques", submenu = "trailer"},
    {MainMenu = "Liste véhicules : Trans", submenu = "trans"},

}

Citizen.CreateThread(function()
    for i = 48,  57 do table.insert(ConcessTruck.NumberPlate, string.char(i)) end
    for i = 65,  90 do table.insert(ConcessTruck.LettePlate, string.char(i)) end
    for i = 97, 122 do table.insert(ConcessTruck.LettePlate, string.char(i)) end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    PlayerData.job = job
end)


RMenu.Add("truckWolrd", "ConcessTruck_truck_menu_main", RageUI.CreateMenu("Concessionaire", "~b~Camion :", nil, nil, "aLib", "black"))
RMenu:Get("truckWolrd", "ConcessTruck_truck_menu_main").Closed = function()
    isMenuOpened = false
    DeleteVehicle(ConcessTruck.InfosVeh.entity)
end

for k,v in pairs(ConcessTruckTruckMenu) do
    RMenu.Add("truckWolrd", v.submenu, RageUI.CreateSubMenu(RMenu:Get("truckWolrd", "ConcessTruck_truck_menu_main"), "Concessionaire", "INTÉRACTIONS"))
    RMenu:Get("truckWolrd", v.submenu).Closed = function()
    DeleteVehicle(ConcessTruck.InfosVeh.entity)
    end
end

RMenu.Add("truckWolrd", "ConcessTruck_menu_buy", RageUI.CreateSubMenu(RMenu:Get("truckWolrd", "ConcessTruck_truck_menu_main"), "Concessionaire", "~b~Actions"))
RMenu:Get("truckWolrd", "ConcessTruck_menu_buy").Closed = function()
    DeleteVehicle(ConcessTruck.InfosVeh.entity)
end


local function openMenuAchatTruck()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("truckWolrd", "ConcessTruck_truck_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("truckWolrd", "ConcessTruck_truck_menu_main"),true,true,true,function()
                        for k,v in pairs(ConcessTruckTruckMenu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ConcessTruck.kSelected = k
                                end
                            end, RMenu:Get("truckWolrd", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessTruckTruckMenu) do    
                        RageUI.IsVisible(RMenu:Get("truckWolrd", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigTruckShop["TRUCK"][ConcessTruck.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessTruck.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            CreateVehiculeCD(GetHashKey(w.model), "preview")
                                        end
                                    end
                                    if s then
                                        ConcessTruck.GarageLabel = w.label
                                        ConcessTruck.GarageModel = w.model
                                        ConcessTruck.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("truckWolrd", "ConcessTruck_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigTruckShop["TRUCK"][ConcessTruck.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/220, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/2, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                                RageUI.BoutonPanel("Prix d'achat :  ", "~g~"..actuality.price.."$", actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("truckWolrd", "ConcessTruck_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessTruck.GarageLabel)
                        RageUI.Separator("Prix d'achat du véhicule : ~b~"..ConcessTruck.GaragePriceBuy.."$")
                        RageUI.ButtonWithStyle("Acheter le véhicule (Perso)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessTruck.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableTruck", ConcessTruck.GarageModel, VehiculesProps.plate,ConcessTruck.GaragePriceBuy)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessTruck.GarageModel, vector3(896.33, -1163.43, 24.98), 82.20, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessTruck.GaragePriceBuy)

                                end
                        end) 
                        if PlayerData.job.grade_name == 'boss' then
                            RageUI.ButtonWithStyle("Acheter le véhicule (job)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessTruck.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableTruckEntreprise", ConcessTruck.GarageModel, VehiculesProps.plate,ConcessTruck.GaragePriceBuy, PlayerData.job.name)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessTruck.GarageModel, vector3(896.33, -1163.43, 24.98), 82.20, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessTruck.GaragePriceBuy)

                                end
                            end) 
                        end 
                        if PlayerData.job2.grade_name == 'boss' then
                            RageUI.ButtonWithStyle("Acheter le véhicule (Job2)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessTruck.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableTruckjob2", ConcessTruck.GarageModel, VehiculesProps.plate,ConcessTruck.GaragePriceBuy, PlayerData.job2.name)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessTruck.GarageModel, vector3(896.33, -1163.43, 24.98), 82.20, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessTruck.InfosVeh.entity)
                                            ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessTruck.GaragePriceBuy)

                                end
                            end) 
                        end                       
                    end)     
                
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigTruckShop.points) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.achat
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Magasin")
                        if IsControlJustPressed(1,51) then
                            ESX.TriggerServerCallback('god_license:checkLicense', function(hasTruckingLicense)
                               if hasTruckingLicense then
                                    openMenuAchatTruck()
                                else
                                    ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas le permis Camion !', 'CHAR_ELDERS', 10)
                                end
                            end, GetPlayerServerId(PlayerId()), 'drive_truck')
                        end
                    end
            end
        end
        Citizen.Wait(interval)
    end
end)

function CreateVehiculeCD(model, state)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1)  ESX.ShowHelpNotification("~g~Chargement en cours du véhicule...") end
    if state == nil then
        veh = CreateVehicle(model, -777.44, -227.64, 37.16, 100.0, false, true)
    elseif state == "preview" then
        veh = CreateVehicle(model, 896.33, -1163.43, 24.98, 163.94, false, true)
    else
        veh = CreateVehicle(model, 1224.89, 2733.174, 38.00654, 235.94, false, true)
    end
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    ConcessTruck.InfosVeh.entity = veh
    ConcessTruck.InfosVeh.model = model
    ConcessTruck.InfosVeh.props = ESX.Game.GetVehicleProperties(veh)
    if name ~= nil then ConcessTruck.InfosVeh.name = name end
    SetModelAsNoLongerNeeded(model)
    ConcessTruck.RototaeStatus = true
    SetEntityHeading(veh, 82.20)
end