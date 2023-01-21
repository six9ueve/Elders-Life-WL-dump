ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_tabac()
    TriggerServerEvent('tabac:tabac:startTabac')
end

local function ttmt_tabac()
    TriggerServerEvent('tabac:tabac:startTtmt_Tabac')
end

local function ttmt_paquet()
    TriggerServerEvent('tabac:tabac:startTtmt_paquet')
end

local function vente_tabac()
    TriggerServerEvent('tabac:tabac:startVente_tabac')
end

AddEventHandler('tabac:hasEnteredMarkertabac', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 6 then
            CurrentAction = 'Champs_tabac'
        elseif zone == 7 then
            CurrentAction = 'traitement_tabac'
        elseif zone == 8 then
            CurrentAction = 'traitement_paquet'
        elseif zone == 9 then
            CurrentAction = 'vente_produit_tabac'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('tabac:hasExitedMarkertabac', function(zone)

    if zone == 6 then
        TriggerServerEvent('tabac:tabac:stopTabac')
    elseif zone == 7 then
        TriggerServerEvent('tabac:tabac:stopTtmt_Tabac')
    elseif zone == 8 then
        TriggerServerEvent('tabac:tabac:stopTtmt_paquet')
    elseif zone == 9 then
        TriggerServerEvent('tabac:tabac:stopVente_tabac')
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

RMenu.Add("tabac", "princ", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tabac", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tabac", "vestiaire", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tabac", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tabac", "Fabrication", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tabac", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tabac", "Magasin", RageUI.CreateMenu("Redwood inc.", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tabac", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tabac", "annonce", RageUI.CreateSubMenu(RMenu:Get("tabac", "princ"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("tabac", "annonce").Closed = function()end

RMenu.Add("tabac", "changetenue", RageUI.CreateSubMenu(RMenu:Get("tabac", "vestiaire"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("tabac", "changetenue").Closed = function()end

RMenu.Add("tabac", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("tabac", "vestiaire"), "Redwood inc.", "~b~Menu job :"))
RMenu:Get("tabac", "deletetenue").Closed = function()end

local function openMenutabacF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tabac", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tabac", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persotabac', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvretabac')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Fermetabac')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recrutabac')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_tabac', 'tabac', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir le champ", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2241.65, 4777.55, 40.13)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)                  
                RageUI.ButtonWithStyle("Obtenir la production 1", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2886.13, 4506.14, 47.50)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la production 2", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2919.96, 4478.39, 47.50)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(473.160, -1952.310, 24.57)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenutabacVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tabac", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tabac", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigTabac.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigTabac.uniform_female)
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
                end, RMenu:Get("tabac", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("tabac", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("tabac", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("tabac", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "tabac" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigTabac.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigTabac.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenutabacVestiaire()
                        end
                    end
                end
                local position = ConfigTabac.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigTabac.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du tabac")
                    end
                end
                local pos5 = ConfigTabac.points[3].traitement
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigTabac.points[3].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour Sécher votre tabac")
                    end
                end 
                local pos6 = ConfigTabac.points[4].traitement_1
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigTabac.points[4].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en paquet")
                    end
                end
                local pos8 = ConfigTabac.points[5].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigTabac.points[5].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('tabac', function()
    if ESX.PlayerData.job.name == "tabac" then
        openMenutabacF6()
    end
end)

RegisterKeyMapping('tabac', 'Menu Job : Redwood inc.', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('tabac', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(ConfigTabac.points) do
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
        TriggerEvent('tabac:hasEnteredMarkertabac', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('tabac:hasExitedMarkertabac', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('tabac', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_tabac' then
                recolte_tabac()
            elseif CurrentAction == 'traitement_tabac' then
                ttmt_tabac()
            elseif CurrentAction == 'traitement_paquet' then
                ttmt_paquet()  
            elseif CurrentAction == 'vente_produit_tabac' then
                vente_tabac()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)
