ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)


local cancreate = true

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("mosley", "princ", RageUI.CreateMenu("Mosley", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mosley", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mosley", "vestiaire", RageUI.CreateMenu("Mosley", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mosley", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mosley", "annonce", RageUI.CreateSubMenu(RMenu:Get("mosley", "princ"), "Mosley", "~b~Menu job :"))
RMenu:Get("mosley", "annonce").Closed = function()end

RMenu.Add("mosley", "changetenue", RageUI.CreateSubMenu(RMenu:Get("mosley", "vestiaire"), "Mosley", "~b~Menu job :"))
RMenu:Get("mosley", "changetenue").Closed = function()end

RMenu.Add("mosley", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("mosley", "vestiaire"), "Mosley", "~b~Menu job :"))
RMenu:Get("mosley", "deletetenue").Closed = function()end

local function openMenumosleyF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mosley", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("mosley", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    mosleyinteract = true else mosleyinteract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:mosley', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:mosley')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:mosley')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:mosley')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Lire la plaque", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if h then
                        GetCloseVehi()
                        if s then
                            local playerPed = PlayerPedId()
                            local coords = GetEntityCoords(playerPed)
                            local vehicle = ESX.Game.GetClosestVehicle(coords)
                            local vehiclecoords = GetEntityCoords(vehicle)
                            local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                            local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
                                if DoesEntityExist(vehicle) and (vehDistance <= 5) then
                                    ESX.ShowNotification("Plaque du véhicule : "..vehProps.plate)
                                end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, mosleyinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("Prix", "Prix", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mosley', 'mosley', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Racheter une voiture", nil, {RightLabel = "→→→"}, mosleyinteract,function(a,h,s)
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
                                local montant = 0
                                if DoesEntityExist(vehicle) and (vehDistance <= 5) then
                                    local montant = KeyboardInput("Prix", "Prix", "", 6)
                                    if montant then
                                        montant = tonumber(montant)
                                        if montant then
                                            TriggerServerEvent("elders_mosley:requestachat", GetPlayerServerId(closestPlayer), vehProps.plate, montant)
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                end
                            else
                                 ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vendre voiture (civil)", nil, {RightLabel = "→→→"}, mosleyinteract,function(a,h,s)
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
                                            TriggerServerEvent("elders_mosley:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,1)
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                end
                            else
                                 ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vendre voiture (Job1)", nil, {RightLabel = "→→→"}, mosleyinteract,function(a,h,s)
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
                                            TriggerServerEvent("elders_mosley:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,2)
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                end
                            else
                                ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Vendre voiture (job2)", nil, {RightLabel = "→→→"}, mosleyinteract,function(a,h,s)
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
                                            TriggerServerEvent("elders_mosley:requestvente", GetPlayerServerId(closestPlayer), vehProps.plate, montant,3)
                                        end
                                    end
                                else
                                    ESX.ShowNotification('Aucun véhicule à proximité', 'Problème')
                                end
                            else
                                 ESX.ShowNotification('Aucun propriétaire à proximité...', 'Problème')
                            end
                        end
                    end
                end)

            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenumosleyVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mosley", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("mosley", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("mosley", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("mosley", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("mosley", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("mosley", "deletetenue"),true,true,true,function()
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

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigMosley.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "mosley" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenumosleyVestiaire()
                        end
                    end
                end      
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('mosley', function()
    if ESX.PlayerData.job.name == "mosley" then
        openMenumosleyF6()
    end
end)

RegisterKeyMapping('mosley', 'Menu Job : Mosley', 'keyboard', 'F6')

RegisterNetEvent("elders_mosley:requestachatClient")
AddEventHandler("elders_mosley:requestachatClient", function(target, plate, montant)
    ESX.ShowAdvancedNotification('Mosley', "~b~Rachat véhicule", 'Le Mosley souhaite racheter votre véhicule pour ~g~'..montant..'$~s~ \n~g~Y~s~ Pour accepter\n~r~X~s~ Pour Refuser.', 'CHAR_MOSLEY', 8)
    while true do
        if IsControlJustPressed(0, 246) then
            ESX.ShowNotification("Vous avez accepté le rachat !", 'Mosley')
            TriggerServerEvent("elders_Molsey:sellVehicle", target, plate, true, montant)
            break
        elseif IsControlJustPressed(0, 73) then
            ESX.ShowNotification("Vous avez refusé le rachat !", 'Mosley')
            TriggerServerEvent("elders_Molsey:sellVehicle", target, plate, false)
        end
        Wait(1)
    end
end)

RegisterNetEvent("elders_mosley:requestventeClient")
AddEventHandler("elders_mosley:requestventeClient", function(target, plate, montant,job)
    ESX.ShowAdvancedNotification('Mosley', "~b~Rachat véhicule", 'Le Mosley souhaite vendre son véhicule pour ~g~'..montant..'$~s~ \n~g~Y~s~ Pour accepter\n~r~X~s~ Pour Refuser.', 'CHAR_MOSLEY', 8)
    while true do
        if IsControlJustPressed(0, 246) then
            ESX.ShowNotification("Vous avez accepté le contrat !", 'Mosley')
            TriggerServerEvent("elders_Molsey:buyVehicleCivil", target, plate, true, montant,job)
            break
        elseif IsControlJustPressed(0, 73) then
            ESX.ShowNotification("Vous avez refusé le contrat !", 'Mosley')
            TriggerServerEvent("elders_Molsey:buyVehicleCivil", target, plate, false,montant,job)
        end
        Wait(1)
    end
end)