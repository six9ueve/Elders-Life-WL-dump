ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_houblon()
    TriggerServerEvent('brasseur:brasseur:startHoublon')
end

local function recolte_plante()
    TriggerServerEvent('brasseur:brasseur:startPlante')
end

local function recolte_orge()
    TriggerServerEvent('brasseur:brasseur:startOrge')
end

local function recolte_malt_b()
    TriggerServerEvent('brasseur:brasseur:startMaltB')
end

local function recolte_canne()
    TriggerServerEvent('brasseur:brasseur:startCanne')
end

local function vente_brasseur()
    TriggerServerEvent('brasseur:brasseur:startVente_brasseur')
end

AddEventHandler('brasseur:hasEnteredMarkerbrasseur', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 11  or zone == 12 or zone == 13 then
            CurrentAction = 'Champs_houblon'
        elseif zone == 14 then
            CurrentAction = 'Champs_malt_b'
        elseif zone == 15 then
            CurrentAction = 'Champs_orge'
        elseif zone == 16 then
            CurrentAction = 'traitement_brasseur'
        elseif zone == 17 then
            CurrentAction = 'traitement_brasseur'
        elseif zone == 18 then
            CurrentAction = 'vente_produit_brasseur'
        elseif zone == 19 then
            CurrentAction = 'vente_produit_brasseur'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('brasseur:hasExitedMarkerbrasseur', function(zone)

    if zone == 11  or zone == 12 or zone == 13 then
        TriggerServerEvent('brasseur:brasseur:stopHoublon')
    elseif zone == 14 then
        TriggerServerEvent('brasseur:brasseur:stopMaltB')
    elseif zone == 15 then
        TriggerServerEvent('brasseur:brasseur:stopOrge')
    elseif zone == 16 then
        TriggerServerEvent('brasseur:brasseur:stopTtmtB')
    elseif zone == 17 then
        TriggerServerEvent('brasseur:brasseur:stopTtmtB')
    elseif zone == 18 then
        TriggerServerEvent('brasseur:brasseur:stopVente_brasseur')
    elseif zone == 19 then
        TriggerServerEvent('brasseur:brasseur:stopVente_brasseur')
    end
    CurrentAction = nil

end)

-- Enter / Exit marker events
CreateJobLoop('brasseur', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(Configbrasseur.points) do
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
        TriggerEvent('brasseur:hasEnteredMarkerbrasseur', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('brasseur:hasExitedMarkerbrasseur', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('brasseur', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_houblon' then
                recolte_houblon()
            elseif CurrentAction == 'Champs_plante' then
                recolte_plante()
            elseif CurrentAction == 'Champs_orge' then
                recolte_orge()
            elseif CurrentAction == 'Champs_malt_b' then
                recolte_malt_b()
            elseif CurrentAction == 'traitement_brasseur' then
                traitement_brasseur()   
            elseif CurrentAction == 'vente_produit_brasseur' then
                vente_brasseur()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)


RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("brasseur", "princ", RageUI.CreateMenu("Brasserie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("brasseur", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("brasseur", "vestiaire", RageUI.CreateMenu("Brasserie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("brasseur", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("brasseur", "Traitement", RageUI.CreateMenu("Brasserie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("brasseur", "Traitement").Closed = function()
    isMenuOpened = false
end

RMenu.Add("brasseur", "Fabrication", RageUI.CreateMenu("Brasserie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("brasseur", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("brasseur", "Magasin", RageUI.CreateMenu("Brasserie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("brasseur", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("brasseur", "annonce", RageUI.CreateSubMenu(RMenu:Get("brasseur", "princ"), "Brasserie", "~b~Menu job :"))
RMenu:Get("brasseur", "annonce").Closed = function()end

RMenu.Add("brasseur", "changetenue", RageUI.CreateSubMenu(RMenu:Get("brasseur", "vestiaire"), "Brasserie", "~b~Menu job :"))
RMenu:Get("brasseur", "changetenue").Closed = function()end

RMenu.Add("brasseur", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("brasseur", "vestiaire"), "Brasserie", "~b~Menu job :"))
RMenu:Get("brasseur", "deletetenue").Closed = function()end

function traitement_brasseur()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("brasseur", "Traitement"), true)

    Citizen.CreateThread(function()
                while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("brasseur", "Traitement"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Mise en bouteille Bière Blonde", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                        TriggerServerEvent('brasseur:brasseur:startTtmtB',1)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)  
                RageUI.ButtonWithStyle("Mise en bouteille Bière Brune", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('brasseur:brasseur:startTtmtB',2)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("Mise en bouteille Corona", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('brasseur:brasseur:startTtmtB',3)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("Mise en bouteille Bière Ambrée", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('brasseur:brasseur:startTtmtB',4)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenubrasseurF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("brasseur", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("brasseur", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persobrasseur', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_brasseur:Ouverture')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_brasseur:Fermeture')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_brasseur:recrutement')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_brasseur', 'brasseur', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir le champ de Houblon", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(517.95, 6489.69, 30.27)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)   
                RageUI.ButtonWithStyle("Obtenir le champ de Houblon", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(517.81, 6480.06, 30.27)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)    
                RageUI.ButtonWithStyle("Obtenir le champ de Houblon", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(517.69, 6466.60, 30.27)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir le champ de Malt", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(543.47, 6500.13, 29.92)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir le champ d'orge", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(526.27, 6507.63, 29.56)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir la mise en bouteille", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-54.98, 6429.77, 32.69)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-239.99, -224.23, 36.51)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)       
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenubrasseurVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("brasseur", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("brasseur", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configbrasseur.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, Configbrasseur.uniform.female)
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
                end, RMenu:Get("brasseur", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("brasseur", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("brasseur", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("brasseur", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "brasseur" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = Configbrasseur.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  Configbrasseur.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenubrasseurVestiaire()
                        end
                    end
                end
                local position = Configbrasseur.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  Configbrasseur.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Houblon")
                    end
                end
                local pos2 = Configbrasseur.points[3].champ_1
                local distancePlayerChamp_1 = #(plyCoords - pos2)
                if distancePlayerChamp_1 < 25 then
                    interval = 1
                    DrawMarker(22,  Configbrasseur.points[3].champ_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Houblon")
                    end
                end   
                local pos3 = Configbrasseur.points[4].champ_2
                local distancePlayerChamp_2 = #(plyCoords - pos3)
                if distancePlayerChamp_2 < 25 then
                    interval = 1
                    DrawMarker(22,  Configbrasseur.points[4].champ_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Houblon")
                    end
                end 
                local pos4 = Configbrasseur.points[5].champ_3
                local distancePlayerChamp_3 = #(plyCoords - pos4)
                if distancePlayerChamp_3 < 25 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[5].champ_3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_3 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Malt")
                    end
                end 
                local pos5 = Configbrasseur.points[6].champ_4
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[6].champ_4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter de l'orge")
                    end
                end 
                local pos6 = Configbrasseur.points[7].traitement
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[7].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end
                local pos7 = Configbrasseur.points[8].traitement_1
                local distancePlayertraitement_2 = #(plyCoords - pos7)
                if distancePlayertraitement_2 < 15 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[8].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end
                local pos8 = Configbrasseur.points[9].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[9].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
                local pos9 = Configbrasseur.points[10].vente_1
                local distancePlayervente_1 = #(plyCoords - pos9)
                if distancePlayervente_1 < 15 then
                    interval = 1
                    DrawMarker(22,   Configbrasseur.points[10].vente_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('brasseur', function()
    if ESX.PlayerData.job.name == "brasseur" then
        openMenubrasseurF6()
    end
end)

RegisterKeyMapping('brasseur', 'Menu Job : Brasserie', 'keyboard', 'F6')
