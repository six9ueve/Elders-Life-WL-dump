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

local function CreateVehiculeCardealer3(model, state)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1)  ESX.ShowHelpNotification("~g~Chargement en cours du véhicule...") end
    if state == "catalogue" then
        veh = CreateVehicle(model, -43.25, -1095.00, 27.27, 100.0, false, true)
    elseif state == "preview" then
        veh = CreateVehicle(model, -23.55, -1094.3194, 27.30, 163.94, false, true)
    else
        veh = CreateVehicle(model, -23.55, -1094.3194, 27.30, 235.94, false, true)
    end
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    ConcessCardealer3.InfosVeh.entity = veh
    ConcessCardealer3.InfosVeh.model = model
    ConcessCardealer3.InfosVeh.props = ESX.Game.GetVehicleProperties(veh)
    if name ~= nil then ConcessCardealer3.InfosVeh.name = name end
    SetModelAsNoLongerNeeded(model)
    ConcessCardealer3.RototaeStatus = true
    SetEntityHeading(veh, 74.00)
end


local cancreate = true
local ConcessCardealer3Menu = {
    {MainMenu = "Liste véhicules : Compacts", submenu = "compacts"},
    {MainMenu = "Liste véhicules : Coupés", submenu = "coupes"},
    {MainMenu = "Liste véhicules : Sedans", submenu = "sedans"},
    {MainMenu = "Liste véhicules : Muscle", submenu = "muscle"},
    {MainMenu = "Liste véhicules : Offroad", submenu = "offroad"},
    {MainMenu = "Liste véhicules : Sports", submenu = "sports"},
    {MainMenu = "Liste véhicules : Sports classique", submenu = "classique"},
    {MainMenu = "Liste véhicules : Super", submenu = "super"},
    {MainMenu = "Liste véhicules : Suvs", submenu = "suvs"},
    {MainMenu = "Liste véhicules : Vans", submenu = "vans"},
    {MainMenu = "Liste véhicules : Job", submenu = "job"},
    {MainMenu = "Liste véhicules : Import", submenu = "Import"},
}

Citizen.CreateThread(function()
    for i = 48,  57 do table.insert(ConcessCardealer3.NumberPlate, string.char(i)) end
    for i = 65,  90 do table.insert(ConcessCardealer3.LettePlate, string.char(i)) end
    for i = 97, 122 do table.insert(ConcessCardealer3.LettePlate, string.char(i)) end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    PlayerData.job = job
end)
RMenu.Add("Cardealer3_concess", "princ", RageUI.CreateMenu("Motorsport", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("Cardealer3_concess", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("Cardealer3_concess", "ConcessCardealer3_menu_main", RageUI.CreateMenu("Concessionaire", "~b~Camion :", nil, nil, "aLib", "black"))
RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main").Closed = function()
    isMenuOpened = false
    DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
end

RMenu.Add("Cardealer3_concess", "vestiaire", RageUI.CreateMenu("Concessionaire", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("Cardealer3_concess", "vestiaire").Closed = function()
    isMenuOpened = false
end

for k,v in pairs(ConcessCardealer3Menu) do
    RMenu.Add("Cardealer3_concess", v.submenu, RageUI.CreateSubMenu(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"), "Concessionaire", "INTÉRACTIONS"))
    RMenu:Get("Cardealer3_concess", v.submenu).Closed = function()
    DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
    end
end

RMenu.Add("Cardealer3_concess", "ConcessCardealer3_menu_buy", RageUI.CreateSubMenu(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"), "Concessionaire", "~b~Actions"))
RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_buy").Closed = function()
    DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
end

RMenu.Add("Cardealer3_concess", "changetenue", RageUI.CreateSubMenu(RMenu:Get("Cardealer3_concess", "vestiaire"), "Concessionaire", "~b~Menu job :"))
RMenu:Get("Cardealer3_concess", "changetenue").Closed = function()end

RMenu.Add("Cardealer3_concess", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("Cardealer3_concess", "vestiaire"), "Concessionaire", "~b~Menu job :"))
RMenu:Get("Cardealer3_concess", "deletetenue").Closed = function()end

local function openMenuF6Cardealer3()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Cardealer3_concess", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    Cardealer3interact = true else Cardealer3interact = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('Perso:cardeal3',msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:cardeal3')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:cardeal3')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:cardeal3')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_cardealer3', 'Motorsport', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.Separator('~y~↓ Ventes Véhicules ↓')
                RageUI.ButtonWithStyle("Vendre voiture (civil)", nil, {RightLabel = "→→→"}, Cardealer3interact,function(a,h,s)
                    if h then
                        GetCloseVehi()
                        if s then
                            local playerPed = PlayerPedId()
                            local coords = GetEntityCoords(playerPed)
                            local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer ~= -1 and playerDistance <= 3.0 then
                                local vehicle = ESX.Game.GetClosestVehicle(coords)
                                local vehiclecoords = GetEntityCoords(vehicle)
                                local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                                local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
                                if DoesEntityExist(vehicle) and (vehDistance <= 5) then
                                    local montant = KeyboardInput("Prix", "Prix", "", 7)
                                    if montant then
                                        montant = tonumber(montant)
                                        if montant then
                                            TriggerServerEvent("elders_Cardealer3:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,1)
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                end
                            else
                                ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vendre voiture (entreprise)", nil, {RightLabel = "→→→"}, Cardealer3interact,function(a,h,s)
                    if h then
                        GetCloseVehi()
                        if s then
                            local playerPed = PlayerPedId()
                            local coords = GetEntityCoords(playerPed)
                            local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer ~= -1 and playerDistance <= 3.0 then
                                local vehicle = ESX.Game.GetClosestVehicle(coords)
                                local vehiclecoords = GetEntityCoords(vehicle)
                                local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                                local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
                                if DoesEntityExist(vehicle) and (vehDistance <= 5) then
                                    local montant = KeyboardInput("Prix", "Prix", "", 7)
                                    if montant then
                                        montant = tonumber(montant)
                                        if montant then
                                            TriggerServerEvent("elders_Cardealer3:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,2)
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                end
                            else
                                 ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vendre voiture (job2)", nil, {RightLabel = "→→→"}, Cardealer3interact,function(a,h,s)
                    if h then
                        GetCloseVehi()
                        if s then
                            local playerPed = PlayerPedId()
                            local coords = GetEntityCoords(playerPed)
                            local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer ~= -1 and playerDistance <= 3.0 then
                                local vehicle = ESX.Game.GetClosestVehicle(coords)
                                local vehiclecoords = GetEntityCoords(vehicle)
                                local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                                local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
                                if DoesEntityExist(vehicle) and (vehDistance <= 5) then
                                    local montant = KeyboardInput("Prix", "Prix", "", 7)
                                    if montant then
                                        montant = tonumber(montant)
                                        if montant then
                                            TriggerServerEvent("elders_Cardealer3:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,3)
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                end
                            else
                                 ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                                 RageUI.CloseAll()
                                 isMenuOpened = false
                            end
                        end
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end
local function openMenuVestiaireCardealer3()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Cardealer3_concess", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("Cardealer3_concess", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("Cardealer3_concess", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "changetenue"),true,true,true,function()
                RageUI.Separator('↓ Mes tenues ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerOutfit', function(clothes)
                                        TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                        TriggerEvent('god_skin:setLastSkin', skin)
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('god_skin:save', skin)
                                        end)
                                    end, v.value)
                                end)
                               ESX.ShowNotification("Vous venez de mettre la tenue "..v.label.." !", 'Dressing')
                            end
                        end)
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "deletetenue"),true,true,true,function()
                RageUI.Separator('↓ Supprimer une tenue ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent('god_eden_clotheshop:removeOutfit', v.value)
                                ESX.ShowNotification("Vous venez de supprimer la tenue "..v.label.." !", 'Dressing')
                                RageUI.GoBack()
                            end
                        end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuAchatCardealer3()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"),true,true,true,function()
                        for k,v in pairs(ConcessCardealer3Menu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ConcessCardealer3.kSelected = k
                                end
                            end, RMenu:Get("Cardealer3_concess", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessCardealer3Menu) do    
                        RageUI.IsVisible(RMenu:Get("Cardealer3_concess", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigCardealer3Shop["Voiture"][ConcessCardealer3.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessCardealer3.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
                                            CreateVehiculeCardealer3(GetHashKey(w.model),"preview")
                                        end
                                    end
                                    if s then
                                        ConcessCardealer3.GarageLabel = w.label
                                        ConcessCardealer3.GarageModel = w.model
                                        ConcessCardealer3.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigCardealer3Shop["Voiture"][ConcessCardealer3.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/220, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/2, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                                RageUI.BoutonPanel("Prix d'achat :  ", "~g~"..actuality.price.."$", actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessCardealer3.GarageLabel)
                        RageUI.Separator("Prix d'achat du véhicule : ~b~"..ConcessCardealer3.GaragePriceBuy.."$")
                        RageUI.ButtonWithStyle("Acheter le véhicule", nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ESX.TriggerServerCallback("god:CheckMoneyCardealer3", function(hasmoney)
                                        if hasmoney then
                                            local VehiculesProps = ESX.Game.GetVehicleProperties(ConcessCardealer3.InfosVeh.entity,  false)
                                            VehiculesProps.plate = string.upper(GetRandomNumber(2)..GetRandomLetter(3)..GetRandomNumber(3))
                                            DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
                                            ConcessCardealer3.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                            --SPAWN AND CREATE TABLE
                                            TriggerServerEvent("god:AddToGarageCardealer3", ConcessCardealer3.GarageModel, VehiculesProps,ConcessCardealer3.GaragePriceBuy)
                                            Citizen.Wait(100)
                                            local playerPed = PlayerPedId()
                                            --[[ESX.Game.SpawnVehicle(ConcessCardealer3.GarageModel, vector3(-23.55, -1094.3194, 27.30), 336.98, function (vehicle)
                                                    SetVehicleNumberPlateText(vehicle, VehiculesProps.plate)
                                                    SetVehicleDoorsLocked(vehicle, 0)
                                                    FreezeEntityPosition(playerPed, false)
                                                    SetEntityVisible(playerPed, true)
                                                end)]]--
                                        else
                                            ESX.ShowAdvancedNotification('Concessionaire', 'Informations', '~r~Vous n\'avez pas assez d\'argent sur vous !', 'CHAR_ELDERS', 10)
                                            DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
                                            ConcessCardealer3.InfosVeh = {props = nil, entity = nil, model = nil}
                                            RageUI.CloseAll()
                                            isMenuOpened = false
                                        end
                                    end, ConcessCardealer3.GaragePriceBuy)

                                end
                        end)                         
                    end)     
                
            Wait(0)
        end
    end)
end

local function openMenuCatalogueCardealer3()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"), true)

    Citizen.CreateThread(function()

        while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_main"),true,true,true,function()
                        for k,v in pairs(ConcessCardealer3Menu) do
                            RageUI.ButtonWithStyle(v.MainMenu, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                if s then
                                    ConcessCardealer3.kSelected = k
                                end
                            end, RMenu:Get("Cardealer3_concess", v.submenu))
                        end
                end, function()end, 1)

                for k,v in pairs(ConcessCardealer3Menu) do    
                        RageUI.IsVisible(RMenu:Get("Cardealer3_concess", v.submenu),true,true,true,function()
                            for actif,w in pairs(ConfigCardealer3Shop["Voiture"][ConcessCardealer3.kSelected]) do
                                RageUI.ButtonWithStyle("[~b~"..actif.."~s~] - "..w.label, nil, {RightLabel = "→→"}, true, function(_,a,s)
                                    if a then
                                        if ConcessCardealer3.InfosVeh.model ~= GetHashKey(w.model) then
                                            DeleteVehicle(ConcessCardealer3.InfosVeh.entity)
                                            CreateVehiculeCardealer3(GetHashKey(w.model), "catalogue")
                                        end
                                    end
                                    if s then
                                        ConcessCardealer3.GarageLabel = w.label
                                        ConcessCardealer3.GarageModel = w.model
                                        ConcessCardealer3.GaragePriceBuy = w.price
                                    end
                                end, RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_buy"))
                            end
                        end, function()
                            for actif,actuality in pairs( ConfigCardealer3Shop["Voiture"][ConcessCardealer3.kSelected]) do
                                RageUI.StatisticPanel(GetVehicleModelMaxSpeed(actuality.model)*3.6/220, "Vitesse maximum : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelAcceleration(actuality.model)*3.6/220*100, "Accélération : ", actif)
                                RageUI.StatisticPanel(GetVehicleModelMaxBraking(actuality.model)/2, "Freinage  : ", actif)
                                RageUI.BoutonPanel("Nombre de sièges : ",  GetVehicleModelNumberOfSeats(actuality.model), actif)
                            end

                        end, function()end, 1)
                    end
                        RageUI.IsVisible(RMenu:Get("Cardealer3_concess", "ConcessCardealer3_menu_buy"),true,true,true,function()
                        RageUI.Separator("Model du véhicule : ~b~"..ConcessCardealer3.GarageLabel)
                    end)     
                
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "cardealer3" then
                local playerPos = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigCardealer3Shop.points.achat
                local distancePlayerMagasin = #(playerPos - pos)
                if distancePlayerMagasin < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigCardealer3Shop.points.achat, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerMagasin <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Magasin")
                        if IsControlJustPressed(1,51) then
                            openMenuAchatCardealer3()
                        end
                    end
                end
                local pos1 = ConfigCardealer3Shop.points.vestiaire
                local distancePlayerVestiaire = #(playerPos - pos1)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigCardealer3Shop.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vous changer")
                        if IsControlJustPressed(1,51) then
                            openMenuVestiaireCardealer3()
                        end
                    end
                end

            end
                local playerPos = GetEntityCoords(PlayerPedId(), false)
                local pos2 = ConfigCardealer3Shop.points.catalogue
                local distancePlayerCatalogue = #(playerPos - pos2)
                if distancePlayerCatalogue < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigCardealer3Shop.points.catalogue, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerCatalogue <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour regarder le catalogue")
                        if IsControlJustPressed(1,51) then
                            openMenuCatalogueCardealer3()
                        end
                    end
                end

        Citizen.Wait(interval)
    end
end)

RegisterNetEvent("elders_Cardealer3:requestventeClient")
AddEventHandler("elders_Cardealer3:requestventeClient", function(target, plate, montant,job)
    ESX.ShowAdvancedNotification('Motorsport', "Vente véhicule", 'Le Motorsport souhaite vendre son véhicule pour ~g~'..montant..'$~s~ \n~g~Y~s~ Pour accepter\n~r~X~s~ Pour Refuser.', 'CHAR_CARSITE', 8)
    while true do
        if IsControlJustPressed(0, 246) then
            ESX.ShowNotification("Vous avez accepté le contrat !", 'Motorsport')
            TriggerServerEvent("elders_Cardealer3:buyVehicleCivil", target, plate, true, montant,job)
            break
        elseif IsControlJustPressed(0, 73) then
            ESX.ShowNotification("Vous avez refusé le contrat !", 'Motorsport')
            TriggerServerEvent("elders_Cardealer3:buyVehicleCivil", target, plate, false,montant,job)
        end
        Wait(1)
    end
end)


RegisterCommand('Cardealer3', function()
    if ESX.PlayerData.job.name == "cardealer3" then
        openMenuF6Cardealer3()
    end
end)

RegisterKeyMapping('Cardealer3', 'Menu Job : Cardealer3', 'keyboard', 'F6')