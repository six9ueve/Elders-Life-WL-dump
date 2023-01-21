ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_patate()
    TriggerServerEvent('distillerie:distillerie:startPatate')
end

local function recolte_plante()
    TriggerServerEvent('distillerie:distillerie:startPlante')
end

local function recolte_agave()
    TriggerServerEvent('distillerie:distillerie:startAgave')
end

local function recolte_malt()
    TriggerServerEvent('distillerie:distillerie:startMalt')
end

local function recolte_canne()
    TriggerServerEvent('distillerie:distillerie:startCanne')
end

local function vente_distillerie()
    TriggerServerEvent('distillerie:distillerie:startVente_distillerie')
end

AddEventHandler('distillerie:hasEnteredMarkerdistillerie', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 11 then
            CurrentAction = 'Champs_patate'
        elseif zone == 12 then
            CurrentAction = 'Champs_plante'
        elseif zone == 13 then
            CurrentAction = 'Champs_agave'
        elseif zone == 14 then
            CurrentAction = 'Champs_malt'
        elseif zone == 21 then
            CurrentAction = 'Champs_Canne'
        elseif zone == 15 then
            CurrentAction = 'traitement'
        elseif zone == 16 then
            CurrentAction = 'traitement'
        elseif zone == 17 then
            CurrentAction = 'traitement'
        elseif zone == 18 then
            CurrentAction = 'vente_produit_disti'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('distillerie:hasExitedMarkerdistillerie', function(zone)

    if zone == 11 then
        TriggerServerEvent('distillerie:distillerie:stopPatate')
    elseif zone == 12 then
        TriggerServerEvent('distillerie:distillerie:stopPlante')
    elseif zone == 13 then
        TriggerServerEvent('distillerie:distillerie:stopAgave')
    elseif zone == 14 then
        TriggerServerEvent('distillerie:distillerie:stopMalt')
    elseif zone == 21 then
        TriggerServerEvent('distillerie:distillerie:stopCanne')
    elseif zone == 15 then
        TriggerServerEvent('distillerie:distillerie:stopTtmt')
    elseif zone == 16 then
        TriggerServerEvent('distillerie:distillerie:stopTtmt')
    elseif zone == 17 then
        TriggerServerEvent('distillerie:distillerie:stopTtmt')
    elseif zone == 18 then
        TriggerServerEvent('distillerie:distillerie:stopVente_distillerie')
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

RMenu.Add("distillerie", "princ", RageUI.CreateMenu("The Circle Distillery", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("distillerie", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distillerie", "vestiaire", RageUI.CreateMenu("The Circle Distillery", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("distillerie", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distillerie", "Traitement", RageUI.CreateMenu("The Circle Distillery", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("distillerie", "Traitement").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distillerie", "Fabrication", RageUI.CreateMenu("The Circle Distillery", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("distillerie", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distillerie", "Magasin", RageUI.CreateMenu("The Circle Distillery", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("distillerie", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distillerie", "annonce", RageUI.CreateSubMenu(RMenu:Get("distillerie", "princ"), "The Circle Distillery", "~b~Menu job :"))
RMenu:Get("distillerie", "annonce").Closed = function()end

RMenu.Add("distillerie", "changetenue", RageUI.CreateSubMenu(RMenu:Get("distillerie", "vestiaire"), "The Circle Distillery", "~b~Menu job :"))
RMenu:Get("distillerie", "changetenue").Closed = function()end

RMenu.Add("distillerie", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("distillerie", "vestiaire"), "The Circle Distillery", "~b~Menu job :"))
RMenu:Get("distillerie", "deletetenue").Closed = function()end

local function traitement()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("distillerie", "Traitement"), true)

    Citizen.CreateThread(function()
                while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("distillerie", "Traitement"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Mise en bouteille Wisky", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                        TriggerServerEvent('distillerie:distillerie:startTtmt',1)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)  
                RageUI.ButtonWithStyle("Mise en bouteille Vodka", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('distillerie:distillerie:startTtmt',2)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("Mise en bouteille Tequila", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('distillerie:distillerie:startTtmt',3)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("Mise en bouteille Rhum", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('distillerie:distillerie:startTtmt',4)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("Mise en bouteille Jager", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('distillerie:distillerie:startTtmt',5)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)

            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenudistillerieF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("distillerie", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("distillerie", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('persodistillerie', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_distillerie:Ouverture')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_distillerie:Fermeture')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_distillerie:recrutement')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_distillerie', 'distillerie', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.Separator('~y~↓ GPS ↓')
                RageUI.ButtonWithStyle("Obtenir le champ de pomme de terre", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2642.05, 4751.36, 33.70)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)   
                RageUI.ButtonWithStyle("Obtenir le champ de plante", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1763.42, 4991.03, 51.560)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)    
                RageUI.ButtonWithStyle("Obtenir le champ d'agave", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1844.14, 4809.24, 43.5)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir le champ  de Malt", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(543.02, 6500.23, 29.93)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir le depot de canne a sucre", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(1961.00, 5185.02, 47.94)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir la mise en bouteille", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(107.144, 6342.194, 31.74)  
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

local function openMenudistillerieVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("distillerie", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("distillerie", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigDistillerie.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigDistillerie.uniform.female)
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
                end, RMenu:Get("distillerie", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("distillerie", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("distillerie", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("distillerie", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "distillerie" or ESX.PlayerData.job2.name == "distillerie" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigDistillerie.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigDistillerie.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenudistillerieVestiaire()
                        end
                    end
                end
                local position = ConfigDistillerie.points[2].champ
                local distancePlayerChamp = #(plyCoords - position)
                if distancePlayerChamp < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigDistillerie.points[2].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter des pommes de terres")
                    end
                end
                local pos2 = ConfigDistillerie.points[3].champ_1
                local distancePlayerChamp_1 = #(plyCoords - pos2)
                if distancePlayerChamp_1 < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigDistillerie.points[3].champ_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter des plantes")
                    end
                end   
                local pos3 = ConfigDistillerie.points[4].champ_2
                local distancePlayerChamp_2 = #(plyCoords - pos3)
                if distancePlayerChamp_2 < 25 then
                    interval = 1
                    DrawMarker(22,  ConfigDistillerie.points[4].champ_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter de l'agave")
                    end
                end 
                local pos4 = ConfigDistillerie.points[5].champ_3
                local distancePlayerChamp_3 = #(plyCoords - pos4)
                if distancePlayerChamp_3 < 25 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[5].champ_3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_3 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter du Malt")
                    end
                end 
                local pos40 = ConfigDistillerie.points[20].champ_4
                local distancePlayerChamp_30 = #(plyCoords - pos40)
                if distancePlayerChamp_30 < 25 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[20].champ_4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_30 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter de la Canne à sucre")
                    end
                end
                local pos5 = ConfigDistillerie.points[6].traitement
                local distancePlayertraitement = #(plyCoords - pos5)
                if distancePlayertraitement < 15 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[6].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end 
                local pos6 = ConfigDistillerie.points[7].traitement_1
                local distancePlayertraitement_1 = #(plyCoords - pos6)
                if distancePlayertraitement_1 < 15 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[7].traitement_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end
                local pos7 = ConfigDistillerie.points[8].traitement_2
                local distancePlayertraitement_2 = #(plyCoords - pos7)
                if distancePlayertraitement_2 < 15 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[8].traitement_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayertraitement_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour la mise en bouteille")
                    end
                end
                local pos8 = ConfigDistillerie.points[9].vente
                local distancePlayervente = #(plyCoords - pos8)
                if distancePlayervente < 15 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[9].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
                local pos9 = ConfigDistillerie.points[10].vente_1
                local distancePlayervente_1 = #(plyCoords - pos9)
                if distancePlayervente_1 < 15 then
                    interval = 1
                    DrawMarker(22,   ConfigDistillerie.points[10].vente_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayervente_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos produits")
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('distillerie', function()
    if ESX.PlayerData.job.name == "distillerie" or ESX.PlayerData.job2.name == "distillerie" then
        openMenudistillerieF6()
    end
end)

RegisterKeyMapping('distillerie', 'Menu Job : The Circle Distillery', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('distillerie', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(ConfigDistillerie.points) do
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
        TriggerEvent('distillerie:hasEnteredMarkerdistillerie', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('distillerie:hasExitedMarkerdistillerie', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('distillerie', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_patate' then
                recolte_patate()
            elseif CurrentAction == 'Champs_plante' then
                recolte_plante()
            elseif CurrentAction == 'Champs_agave' then
                recolte_agave()
            elseif CurrentAction == 'Champs_malt' then
                recolte_malt()
            elseif CurrentAction == 'Champs_Canne' then
                recolte_canne()
            elseif CurrentAction == 'traitement' then
                traitement()   
            elseif CurrentAction == 'vente_produit_disti' then
                vente_distillerie()        
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)

