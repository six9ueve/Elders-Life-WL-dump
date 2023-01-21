ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)

    end
    PlayerData = {}
    PlayerData = ESX.GetPlayerData()
end)

local ConcessVIPMenu = {
    {MainMenu = "Liste véhicules : Import Moto", submenu = "moto"},
    {MainMenu = "Liste véhicules : Import Auto", submenu = "auto"},
}

local function CreateCamInCDVIP(pos, state)
    ConcessVIP.MainCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamParams(ConcessVIP.MainCam,  pos.x, pos.y, pos.z, -14.367, 0.0, pos.h, 42.0, 0, 1, 1, 2)
    SetCamShakeAmplitude(ConcessVIP.MainCam, 13.0)
    if state then
        RenderScriptCams(1, 1, 1200, 1, 1)
    else
        RenderScriptCams(1, 1, 0, 1, 1)
    end
end

local function CreateVehiculeVIP(model, state)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) ESX.ShowHelpNotification("~g~Chargement en cours du véhicule...") end
    if state == nil then
        veh = CreateVehicle(model, -228.1715, 6252.771, 31.48, 100.0, false, true)
    elseif state == "preview" then
        veh = CreateVehicle(model, -228.1715, 6252.771, 31.48, 163.94, false, true)
    else
        veh = CreateVehicle(model, -228.1715, 6252.771, 31.48, 235.94, false, true)
    end
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    ConcessVIP.InfosVeh.entity = veh
    ConcessVIP.InfosVeh.model = model
    ConcessVIP.InfosVeh.props = ESX.Game.GetVehicleProperties(veh)
    if name ~= nil then ConcessVIP.InfosVeh.name = name end
    SetModelAsNoLongerNeeded(model)
    ConcessVIP.RototaeStatus = true
    SetEntityHeading(veh, 136.2020)
end

local function openMenuAchatVIP()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("vipWolrd", "Concess_VIP_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("vipWolrd", "Concess_VIP_menu_main"),true,true,true,function()
                        RageUI.Separator("~b~Ton niveau donateur : ~r~"..ESX.PlayerData.donator, nil, {}, true, function(_, _, _) end)
                        for k,v in pairs(ConcessVIPMenu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    CreateCamInCDVIP({x = -230.30,  y = 6246.123,  z = 32.49, h = 00.15}, false)
                                    ConcessVIP.kSelected = k
                                end
                            end, RMenu:Get("vipWolrd", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessVIPMenu) do    
                        RageUI.IsVisible(RMenu:Get("vipWolrd", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigVIPShop["TRUCK"][ConcessVIP.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessVIP.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            CreateVehiculeVIP(GetHashKey(w.model), "preview")
                                        end
                                    end
                                    if s then
                                        if ESX.PlayerData.donator == 1 then 
                                            w.price = w.price * 0.90
                                        elseif ESX.PlayerData.donator == 2 then 
                                            w.price = w.price * 0.85
                                        elseif ESX.PlayerData.donator == 3 then 
                                            w.price = w.price * 0.80
                                        end
                                        ConcessVIP.GarageLabel = w.label
                                        ConcessVIP.GarageModel = w.model
                                        ConcessVIP.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("vipWolrd", "ConcessVIP_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigVIPShop["TRUCK"][ConcessVIP.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/220, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/2, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                                --RageUI.BoutonPanel("Prix d'achat :  ", "~g~"..actuality.price.."$", actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("vipWolrd", "ConcessVIP_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessVIP.GarageLabel)
                        RageUI.Separator("Prix d'achat du véhicule : ~b~"..ConcessVIP.GaragePriceBuy.."$")
                        RageUI.ButtonWithStyle("Acheter le véhicule (Perso)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessVIP.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableVip", ConcessVIP.GarageModel, VehiculesProps.plate,ConcessVIP.GaragePriceBuy)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessVIP.GarageModel, vector3(-228.1715, 6252.771, 31.48), 136.2020, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                            RenderScriptCams(0, 1, 1200, 0, 0)

                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            RenderScriptCams(0, 1, 1200, 0, 0)
                                        end
                                    end, ConcessVIP.GaragePriceBuy)

                                end
                        end) 
                        if PlayerData.job.grade_name == 'boss' then
                            RageUI.ButtonWithStyle("Acheter le véhicule (job)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessVIP.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableVipEntreprise", ConcessVIP.GarageModel, VehiculesProps.plate,ConcessVIP.GaragePriceBuy, PlayerData.job.name)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessVIP.GarageModel, vector3(-228.1715, 6252.771, 31.48), 136.2020, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                                                                        RenderScriptCams(0, 1, 1200, 0, 0)

                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            RenderScriptCams(0, 1, 1200, 0, 0)
                                        end
                                    end, ConcessVIP.GaragePriceBuy)

                                end
                            end) 
                        end 
                        if PlayerData.job2.grade_name == 'boss' then
                            RageUI.ButtonWithStyle("Acheter le véhicule (Job2)", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoney", function(hasmoney, mny)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessVIP.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToTableVipjob2", ConcessVIP.GarageModel, VehiculesProps.plate,ConcessVIP.GaragePriceBuy, PlayerData.job2.name)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            ESX.Game.SpawnVehicle(ConcessVIP.GarageModel, vector3(-228.1715, 6252.771, 31.48), 136.2020, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)
                                                                                        RenderScriptCams(0, 1, 1200, 0, 0)

                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessVIP.InfosVeh.entity)
                                            ConcessVIP.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            RenderScriptCams(0, 1, 1200, 0, 0)
                                        end
                                    end, ConcessVIP.GaragePriceBuy)

                                end
                            end) 
                        end                       
                    end)     
                
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    for i = 48,  57 do table.insert(ConcessVIP.NumberPlate, string.char(i)) end
    for i = 65,  90 do table.insert(ConcessVIP.LettePlate, string.char(i)) end
    for i = 97, 122 do table.insert(ConcessVIP.LettePlate, string.char(i)) end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    PlayerData.job = job
end)


RMenu.Add("vipWolrd", "Concess_VIP_menu_main", RageUI.CreateMenu("Concessionaire", "~b~Véhicule :", nil, nil, "aLib", "black"))
RMenu:Get("vipWolrd", "Concess_VIP_menu_main").Closed = function()
    isMenuOpened = false
    DeleteVehicle(ConcessVIP.InfosVeh.entity)
    RenderScriptCams(0, 1, 1200, 0, 0)
end

for k,v in pairs(ConcessVIPMenu) do
    RMenu.Add("vipWolrd", v.submenu, RageUI.CreateSubMenu(RMenu:Get("vipWolrd", "Concess_VIP_menu_main"), "Concessionaire", "INTÉRACTIONS"))
    RMenu:Get("vipWolrd", v.submenu).Closed = function()
    DeleteVehicle(ConcessVIP.InfosVeh.entity)
    RenderScriptCams(0, 1, 1200, 0, 0)
    end
end

RMenu.Add("vipWolrd", "ConcessVIP_menu_buy", RageUI.CreateSubMenu(RMenu:Get("vipWolrd", "Concess_VIP_menu_main"), "Concessionaire", "~b~Actions"))
RMenu:Get("vipWolrd", "ConcessVIP_menu_buy").Closed = function()
    DeleteVehicle(ConcessVIP.InfosVeh.entity)
    RenderScriptCams(0, 1, 1200, 0, 0)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigVIPShop.points) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.achat
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Magasin Donateur")
                        if IsControlJustPressed(1,51) then
                             if ESX.PlayerData.donator ~= 0 then
                                    openMenuAchatVIP()
                            else
                                ESX.ShowNotification("~r~Problème~s~ : Vous n'êtes pas donateur !")
                            end
                        end
                    end
            end
        end
        Citizen.Wait(interval)
    end
end)