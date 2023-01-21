ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_poitrine_ranch()
    TriggerServerEvent('ranch:ranch:startTtmt_Poitrine')
end
local function recolte_viande_ranch()
    TriggerServerEvent('ranch:ranch:startTtmt_viande')
end

local function recolte_poulet_ranch()
    TriggerServerEvent('ranch:ranch:startTtmt_poulet')
end

local function ttmt_ribs()
    TriggerServerEvent('ranch:ranch:startTtmt_ribs')
end

local function ttmt_cote()
    TriggerServerEvent('ranch:ranch:startTtmt_cote')
end

local function ttmt_poulet()
    TriggerServerEvent('ranch:ranch:startTtmt_poulet1')
end

local function vente_ranch()
    TriggerServerEvent('ranch:ranch:startVente_ranch')
end

AddEventHandler('ranch:hasEnteredMarkerranch', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 10 then
            CurrentAction = 'recolte_poitrine'
        elseif zone == 11 then
            CurrentAction = 'recolte_viande'
        elseif zone == 12 then
            CurrentAction = 'recolte_poulet'
        elseif zone == 13 then
            CurrentAction = 'traitement_ribs'
        elseif zone == 14 then
            CurrentAction = 'traitement_cote'
        elseif zone == 15 then
            CurrentAction = 'traitement_poulet'
        elseif zone == 16 then
            CurrentAction = 'vente_produit_ranch'
        elseif zone == 17 then
            CurrentAction = 'vente_produit_ranch'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('ranch:hasExitedMarkerranch', function(zone)

    if zone == 10 then
        TriggerServerEvent('ranch:ranch:stopPoitrine')
    elseif zone == 11 then
        TriggerServerEvent('ranch:ranch:stopTtmt_viande')
    elseif zone == 12 then
        TriggerServerEvent('ranch:ranch:stopTtmt_poulet')
    elseif zone == 13 then
        TriggerServerEvent('ranch:ranch:stopTtmt_ribs')
    elseif zone == 14 then
        TriggerServerEvent('ranch:ranch:stopTtmt_cote')
    elseif zone == 15 then
        TriggerServerEvent('ranch:ranch:stopTtmt_poulet1')
    elseif zone == 16 then
        TriggerServerEvent('ranch:ranch:stopVente_ranch')
    elseif zone == 17 then
        TriggerServerEvent('ranch:ranch:stopVente_ranch')
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

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

RMenu.Add("ranch", "princ", RageUI.CreateMenu("River Ranch", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ranch", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ranch", "vestiaire", RageUI.CreateMenu("River Ranch", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ranch", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ranch", "Fabrication", RageUI.CreateMenu("River Ranch", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ranch", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ranch", "Magasin", RageUI.CreateMenu("River Ranch", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ranch", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ranch", "annonce", RageUI.CreateSubMenu(RMenu:Get("ranch", "princ"), "River Ranch", "~b~Menu job :"))
RMenu:Get("ranch", "annonce").Closed = function()end

RMenu.Add("ranch", "changetenue", RageUI.CreateSubMenu(RMenu:Get("ranch", "vestiaire"), "River Ranch", "~b~Menu job :"))
RMenu:Get("ranch", "changetenue").Closed = function()end

RMenu.Add("ranch", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("ranch", "vestiaire"), "River Ranch", "~b~Menu job :"))
RMenu:Get("ranch", "deletetenue").Closed = function()end

local function openMenuranchF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ranch", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ranch", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persoranch', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvreranch')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Fermeranch')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recruranch')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ranch', 'ranch', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir récolte Poitrine De Boeuf", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(986.983, -2180.966, 30.051)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)   
                RageUI.ButtonWithStyle("Obtenir Récolte Viande De Boeuf", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1220.97, 1897.56, 77.93)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)    
                RageUI.ButtonWithStyle("Obtenir récolte Poulet fermier", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(851.96, 2131.92, 52.28)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir Cuisson Des Ribs Texan", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1554.816, 2183.381, 78.913)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir Cuisson des Côtes De Boeuf", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1551.804, 2163.853, 78.943)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Cuisson des poulets", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1542.59, 2178.86, 78.81)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2467.41, 4100.94, 38.06)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuranchVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ranch", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ranch", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigRanch.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigRanch.uniform.female)
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
                end, RMenu:Get("ranch", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("ranch", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("ranch", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("ranch", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "ranch" or ESX.PlayerData.job2.name == "ranch" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigRanch.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigRanch.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuranchVestiaire()
                        end
                    end
                end
                local position = ConfigRanch.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigRanch.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter Des Poitrines De Boeuf")
                    end
                end
                local pos2 = ConfigRanch.points[3].champ_1
                local distancePlayerChamp_1 = #(plyCoords - pos2)
                if distancePlayerChamp_1 < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigRanch.points[3].champ_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter de la Viandes De Boeuf")
                    end
                end   
                local pos3 = ConfigRanch.points[4].champ_2
                local distancePlayerChamp_2 = #(plyCoords - pos3)
                if distancePlayerChamp_2 < 25 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[4].champ_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Poulet fermier")
                    end
                end 
                local pos5 = ConfigRanch.points[5].traitement
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[5].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuire vos ribs")
                    end
                end 
                local pos6 = ConfigRanch.points[6].traitement_1
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[6].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuire vos cotes")
                    end
                end
                local pos7 = ConfigRanch.points[7].traitement_2
                local distancePlayertraitement_2 = #(plyCoords - pos7)
                if distancePlayertraitement_2 < 15 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[7].traitement_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuire vos poulets")
                    end
                end
                local pos8 = ConfigRanch.points[8].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[8].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
                local pos9 = ConfigRanch.points[9].vente_1
                local distancePlayervente_1 = #(plyCoords - pos9)
                if distancePlayervente_1 < 15 then
                    interval = 1
                    DrawMarker(22, ConfigRanch.points[9].vente_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('ranch', function()
    if ESX.PlayerData.job.name == "ranch" or ESX.PlayerData.job2.name == "ranch" then
        openMenuranchF6()
    end
end)

RegisterKeyMapping('ranch', 'Menu Job : River Ranch', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('ranch', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(ConfigRanch.points) do
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
        TriggerEvent('ranch:hasEnteredMarkerranch', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('ranch:hasExitedMarkerranch', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('ranch', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'recolte_poitrine' then
                recolte_poitrine_ranch()
            elseif CurrentAction == 'recolte_viande' then
                recolte_viande_ranch()
            elseif CurrentAction == 'recolte_poulet' then
                recolte_poulet_ranch()
            elseif CurrentAction == 'traitement_ribs' then
                ttmt_ribs()   
            elseif CurrentAction == 'traitement_cote' then
                ttmt_cote() 
            elseif CurrentAction == 'traitement_poulet' then
                ttmt_poulet() 
            elseif CurrentAction == 'vente_produit_ranch' then
                vente_ranch()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)
