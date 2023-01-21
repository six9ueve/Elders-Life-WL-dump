ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_forge()
    TriggerServerEvent('forge:forge:startforge')
end

local function ttmt_forge()
    TriggerServerEvent('forge:forge:startTtmt_forge')
end

local function ttmt_forge_1()
    TriggerServerEvent('forge:forge:startTtmt_forge1')
end

local function vente_forge()
    TriggerServerEvent('forge:forge:startVente_forge')
end

AddEventHandler('forge:hasEnteredMarkerforge', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 8 or zone == 9 or zone == 10 then
            CurrentAction = 'Champs_forge'
        elseif zone == 11 then
            CurrentAction = 'traitement_forge'
        elseif zone == 12 then
            CurrentAction = 'traitement_forge_1'
        elseif zone == 13 then
            CurrentAction = 'vente_produit_forge'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('forge:hasExitedMarkerforge', function(zone)

    if zone == 8 or zone == 9 or zone == 10 then
        TriggerServerEvent('forge:forge:stopforge')
    elseif zone == 11 then
        TriggerServerEvent('forge:forge:stopTtmt_forge')
    elseif zone == 12 then
        TriggerServerEvent('forge:forge:stopTtmt_forge1')
    elseif zone == 13 then
        TriggerServerEvent('forge:forge:stopVente_forge')
    end
    CurrentAction = nil

end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("forge", "princ", RageUI.CreateMenu("Mineur", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("forge", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("forge", "vestiaire", RageUI.CreateMenu("Mineur", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("forge", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("forge", "Fabrication", RageUI.CreateMenu("Mineur", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("forge", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("forge", "Magasin", RageUI.CreateMenu("Mineur", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("forge", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("forge", "annonce", RageUI.CreateSubMenu(RMenu:Get("forge", "princ"), "Mineur", "~b~Menu job :"))
RMenu:Get("forge", "annonce").Closed = function()end

RMenu.Add("forge", "changetenue", RageUI.CreateSubMenu(RMenu:Get("forge", "vestiaire"), "Mineur", "~b~Menu job :"))
RMenu:Get("forge", "changetenue").Closed = function()end

RMenu.Add("forge", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("forge", "vestiaire"), "Mineur", "~b~Menu job :"))
RMenu:Get("forge", "deletetenue").Closed = function()end

local function openMenuforgeF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("forge", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("forge", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persoforge', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvreforge')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Fermeforge')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recruforge')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, ferme_ointeract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_forge', 'forge', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir la mine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2937.59, 2794.61, 40.58)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)     
                RageUI.ButtonWithStyle("Obtenir la mine 1", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2945.93, 2801.61, 41.20)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)             
                RageUI.ButtonWithStyle("Obtenir la mine 2", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2932.79, 2795.27, 40.68)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir transformation des roches", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(286.750, 2843.975,  43.704)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir transformation des minerais", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1068.136, -2004.624,32.08)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-630.548, -229.059, 37.05)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuforgeVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("forge", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("forge", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configforge.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, Configforge.uniform_female)
                                end
                            end)
                    end
                end)  
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("forge", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("forge", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("forge", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("forge", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "forge" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = Configforge.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuforgeVestiaire()
                        end
                    end
                end
                local position = Configforge.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du minerai")
                    end
                end
                local pos5 = Configforge.points[3].champ1
                local distancePlayerChamp1 = #(plyCoords - pos5)
                if distancePlayerChamp1 < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[3].champ1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du minerai")
                    end
                end 
                local pos6 = Configforge.points[4].champ2
                local distancePlayerChamp2 = #(plyCoords - pos6)
                if distancePlayerChamp2 < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[4].champ2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du minerai")
                    end
                end
                local pos8 = Configforge.points[5].traitement
                local distancePlayertraitement = #(plyCoords - pos8)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[5].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour transformer vos roches")
                    end
                end
                local pos9 = Configforge.points[6].traitement_1
                local distancePlayertraitement1 = #(plyCoords - pos9)
                if distancePlayertraitement1 < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[6].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour transformer vos minerais")
                    end
                end
                local pos10 = Configforge.points[7].vente
                local distancePlayerVente = #(plyCoords - pos10)
                if distancePlayerVente < 15 then
                    interval = 1
                    DrawMarker(22,  Configforge.points[7].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('forge', function()
    if ESX.PlayerData.job.name == "forge" then
        openMenuforgeF6()
    end
end)

RegisterKeyMapping('forge', 'Menu Job : Mineur', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('forge', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(Configforge.points) do
        if (v.Pos ~= nil) then
            if #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < 1.5 then               
              isInMarker = true
              currentZone = k
            end
        end
    end
    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone = currentZone  
        TriggerEvent('forge:hasEnteredMarkerforge', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('forge:hasExitedMarkerforge', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('forge', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_forge' then
                recolte_forge()
            elseif CurrentAction == 'traitement_forge' then
                ttmt_forge()
            elseif CurrentAction == 'traitement_forge_1' then
                ttmt_forge_1()  
            elseif CurrentAction == 'vente_produit_forge' then
                vente_forge()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)

RegisterNetEvent('elders_forge:playMinage')
AddEventHandler('elders_forge:playMinage', function(prop_name)
    local prop_name = prop_name or 'prop_tool_pickaxe'
        IsAnimated = true
        local playerPed = PlayerPedId()
        Citizen.CreateThread(function()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            prop = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
            AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
            RequestAnimDict("melee@large_wpn@streamed_core")
        
            TaskPlayAnim(playerPed, 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(2700)
            IsAnimated = false
            ClearPedSecondaryTask(playerPed)
            DeleteObject(prop)
        end)
end)