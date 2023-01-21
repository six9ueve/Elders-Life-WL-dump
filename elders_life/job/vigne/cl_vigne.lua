ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_raisin()
    TriggerServerEvent('vigne:vigne:startRaisin')
end

local function ttmt_raisin()
    TriggerServerEvent('vigne:vigne:startTtmt_raisin')
end

local function ttmt_jus()
    TriggerServerEvent('vigne:vigne:startTtmt_jus')
end

local function ttmt_champ()
    TriggerServerEvent('vigne:vigne:startTtmt_champ')
end

local function vente_vigne()
    TriggerServerEvent('vigne:vigne:startVente_vigne')
end

AddEventHandler('vigne:hasEnteredMarkervigne', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 11 or zone == 12 or zone == 13 or zone == 14 then
            CurrentAction = 'Champs_raisin'
        elseif zone == 15 then
            CurrentAction = 'traitement_raisin'
        elseif zone == 16 then
            CurrentAction = 'traitement_jus'
        elseif zone == 17 then
            CurrentAction = 'traitement_champ'
        elseif zone == 18 then
            CurrentAction = 'vente_produit'
        elseif zone == 19 then
            CurrentAction = 'vente_produit'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('vigne:hasExitedMarkervigne', function(zone)

    if zone == 11 or zone == 12 or zone == 13 or zone == 14 then
        TriggerServerEvent('vigne:vigne:stopRaisin')
    elseif zone == 15 then
        TriggerServerEvent('vigne:vigne:stopTtmt_raisin')
    elseif zone == 16 then
        TriggerServerEvent('vigne:vigne:stopTtmt_jus')
    elseif zone == 17 then
        TriggerServerEvent('vigne:vigne:stopTtmt_champ')
    elseif zone == 18 then
        TriggerServerEvent('vigne:vigne:stopVente_Vigne')
    elseif zone == 19 then
        TriggerServerEvent('vigne:vigne:stopVente_Vigne')
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

RMenu.Add("vigne", "princ", RageUI.CreateMenu("Vignoble", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("vigne", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("vigne", "vestiaire", RageUI.CreateMenu("Vignoble", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("vigne", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("vigne", "Fabrication", RageUI.CreateMenu("Vignoble", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("vigne", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("vigne", "Magasin", RageUI.CreateMenu("Vignoble", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("vigne", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("vigne", "annonce", RageUI.CreateSubMenu(RMenu:Get("vigne", "princ"), "Vignoble", "~b~Menu job :"))
RMenu:Get("vigne", "annonce").Closed = function()end

RMenu.Add("vigne", "changetenue", RageUI.CreateSubMenu(RMenu:Get("vigne", "vestiaire"), "Vignoble", "~b~Menu job :"))
RMenu:Get("vigne", "changetenue").Closed = function()end

RMenu.Add("vigne", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("vigne", "vestiaire"), "Vignoble", "~b~Menu job :"))
RMenu:Get("vigne", "deletetenue").Closed = function()end

local function openMenuVigneF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("vigne", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("vigne", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persovigne', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvrevigne')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Fermevigne')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recruvigne')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_vigne', 'vigne', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir le champ 1 de raisin", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-1859.31, 2245.89, 83.25)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)   
                RageUI.ButtonWithStyle("Obtenir le champ 2 de raisin", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-1770.94, 2249.71, 85.50)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)    
                RageUI.ButtonWithStyle("Obtenir le champ 3 de raisin", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-1867.02, 2191.57, 105.20)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir le champ 4 de raisin", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-1754.98, 2174.22, 114.30)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir la mise en bouteille", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-1754.98, 2174.22, 114.30)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1036.54, -2111.41, 32.59)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1040.10, -2115.59, 32.59)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuVigneVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("vigne", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("vigne", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigVignoble.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
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
                end, RMenu:Get("vigne", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("vigne", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("vigne", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("vigne", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "vigne" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigVignoble.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuVigneVestiaire()
                        end
                    end
                end
                local position = ConfigVignoble.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin")
                    end
                end
                local pos2 = ConfigVignoble.points[3].champ_1
                local distancePlayerChamp_1 = #(plyCoords - pos2)
                if distancePlayerChamp_1 < 25 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[3].champ_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin")
                    end
                end   
                local pos3 = ConfigVignoble.points[4].champ_2
                local distancePlayerChamp_2 = #(plyCoords - pos3)
                if distancePlayerChamp_2 < 25 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[4].champ_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin")
                    end
                end 
                local pos4 = ConfigVignoble.points[5].champ_3
                local distancePlayerChamp_3 = #(plyCoords - pos4)
                if distancePlayerChamp_3 < 25 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[5].champ_3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_3 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin")
                    end
                end 
                local pos5 = ConfigVignoble.points[6].traitement
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[6].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour transformer votre raisin")
                    end
                end 
                local pos6 = ConfigVignoble.points[7].traitement_1
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[7].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end
                local pos7 = ConfigVignoble.points[8].traitement_2
                local distancePlayertraitement_2 = #(plyCoords - pos7)
                if distancePlayertraitement_2 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[8].traitement_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour faire du champagne")
                    end
                end
                local pos8 = ConfigVignoble.points[9].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[9].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
                local pos9 = ConfigVignoble.points[10].vente_1
                local distancePlayervente_1 = #(plyCoords - pos9)
                if distancePlayervente_1 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigVignoble.points[10].vente_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayervente_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('vigne', function()
    if ESX.PlayerData.job.name == "vigne" then
        openMenuVigneF6()
    end
end)

RegisterKeyMapping('vigne', 'Menu Job : Vignoble', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('vigne', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(ConfigVignoble.points) do
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
        TriggerEvent('vigne:hasEnteredMarkervigne', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('vigne:hasExitedMarkervigne', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('vigne', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_raisin' then
                recolte_raisin()
            elseif CurrentAction == 'traitement_raisin' then
                ttmt_raisin()
            elseif CurrentAction == 'traitement_jus' then
                ttmt_jus()
            elseif CurrentAction == 'traitement_champ' then
                ttmt_champ()   
            elseif CurrentAction == 'vente_produit' then
                vente_vigne()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)
