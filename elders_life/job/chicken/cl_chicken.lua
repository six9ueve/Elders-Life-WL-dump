ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_chicken()
    TriggerServerEvent('chicken:chicken:startChicken')
end

local function ttmt_chicken()
    TriggerServerEvent('chicken:chicken:startTtmt_Chicken')
end

local function ttmt_paquet_p()
    TriggerServerEvent('chicken:chicken:startTtmt_paquet_p')
end

local function vente_chicken()
    TriggerServerEvent('chicken:chicken:startVente_chicken')
end

AddEventHandler('chicken:hasEnteredMarkerchicken', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 6 then
            CurrentAction = 'Champs_chicken'
        elseif zone == 7 then
            CurrentAction = 'traitement_chicken'
        elseif zone == 8 then
            CurrentAction = 'traitement_paquet'
        elseif zone == 9 then
            CurrentAction = 'vente_produit_chicken'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('chicken:hasExitedMarkerchicken', function(zone)

    if zone == 6 then
        TriggerServerEvent('chicken:chicken:stopChicken')
    elseif zone == 7 then
        TriggerServerEvent('chicken:chicken:stopTtmt_Chicken')
    elseif zone == 8 then
        TriggerServerEvent('chicken:chicken:stopTtmt_paquet_p')
    elseif zone == 9 then
        TriggerServerEvent('chicken:chicken:stopVente_chicken')
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

RMenu.Add("chicken", "princ", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("chicken", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("chicken", "vestiaire", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("chicken", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("chicken", "Fabrication", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("chicken", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("chicken", "Magasin", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("chicken", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("chicken", "annonce", RageUI.CreateSubMenu(RMenu:Get("chicken", "princ"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("chicken", "annonce").Closed = function()end

RMenu.Add("chicken", "changetenue", RageUI.CreateSubMenu(RMenu:Get("chicken", "vestiaire"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("chicken", "changetenue").Closed = function()end

RMenu.Add("chicken", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("chicken", "vestiaire"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("chicken", "deletetenue").Closed = function()end

local function openMenuchickenF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("chicken", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("chicken", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('god_chickenjob:perso', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_chickenjob:Ouverture')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_chickenjob:Fermeture')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_chickenjob:recrutement')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_chicken', 'chicken', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir le récolte", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2553.81, 4669.04, 33.98)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)                  
                RageUI.ButtonWithStyle("Obtenir la Découpe", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-83.62, 6226.13, 31.09)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la mise en barquet", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-101.52, 6208.44, 31.09)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-3169.523, 1034.65, 20.8388)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuchickenVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("chicken", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("chicken", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigChicken.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigChicken.uniform_female)
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
                end, RMenu:Get("chicken", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("chicken", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("chicken", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("chicken", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "chicken" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigChicken.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigChicken.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuchickenVestiaire()
                        end
                    end
                end
                local position = ConfigChicken.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigChicken.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Poulet")
                    end
                end
                local pos5 = ConfigChicken.points[3].traitement
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigChicken.points[3].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour Découper votre Poulet")
                    end
                end 
                local pos6 = ConfigChicken.points[4].traitement_1
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigChicken.points[4].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en paquet")
                    end
                end
                local pos8 = ConfigChicken.points[5].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigChicken.points[5].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('chicken', function()
    if ESX.PlayerData.job.name == "chicken" then
        openMenuchickenF6()
    end
end)

RegisterKeyMapping('chicken', 'Menu Job : Redwood inc.', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('chicken', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(ConfigChicken.points) do
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
        TriggerEvent('chicken:hasEnteredMarkerchicken', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('chicken:hasExitedMarkerchicken', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('chicken', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_chicken' then
                recolte_chicken()
            elseif CurrentAction == 'traitement_chicken' then
                ttmt_chicken()
            elseif CurrentAction == 'traitement_paquet' then
                ttmt_paquet_p()  
            elseif CurrentAction == 'vente_produit_chicken' then
                vente_chicken()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)
