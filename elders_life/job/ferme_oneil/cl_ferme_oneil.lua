ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)
local HasAlreadyEnteredMarker = false
local CurrentAction = nil

local function recolte_carotte()
    TriggerServerEvent('ferme_oneil:ferme_oneil:startCarotte')
end

local function recolte_poireau()
    TriggerServerEvent('ferme_oneil:ferme_oneil:startPoireau')
end

local function recolte_patate()
    TriggerServerEvent('ferme_oneil:ferme_oneil:startPatate')
end

local function vente_Ferme()
    TriggerServerEvent('ferme_oneil:ferme_oneil:startVente_Ferme')
end

AddEventHandler('ferme_oneil:hasEnteredMarkerferme_oneil', function(zone)
    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        if zone == 7 then
            CurrentAction = 'Champs_poireau'
        elseif zone == 8 then
            CurrentAction = 'Champs_carotte'
        elseif zone == 9 then
            CurrentAction = 'champs_patate'
        elseif zone == 10 then
            CurrentAction = 'vente_produit'
        end
    else
        ESX.ShowNotification("Décendez de votre véhicule")
    end
end)

AddEventHandler('ferme_oneil:hasExitedMarkerferme_oneil', function(zone)

    if zone == 7 then
        TriggerServerEvent('ferme_oneil:ferme_oneil:stopPoireau')
    elseif zone == 8 then
        TriggerServerEvent('ferme_oneil:ferme_oneil:stopCarotte')
    elseif zone == 9 then
        TriggerServerEvent('ferme_oneil:ferme_oneil:stopPatate')
    elseif zone == 10 then
        TriggerServerEvent('ferme_oneil:ferme_oneil:stopVente_Ferme')
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

RMenu.Add("ferme_o", "princ", RageUI.CreateMenu("Ferme O'neil", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ferme_o", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ferme_o", "vestiaire", RageUI.CreateMenu("Ferme O'neil", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ferme_o", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ferme_o", "Fabrication", RageUI.CreateMenu("Ferme O'neil", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ferme_o", "Fabrication").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ferme_o", "Magasin", RageUI.CreateMenu("Ferme O'neil", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ferme_o", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ferme_o", "annonce", RageUI.CreateSubMenu(RMenu:Get("ferme_o", "princ"), "Ferme O'neil", "~b~Menu job :"))
RMenu:Get("ferme_o", "annonce").Closed = function()end

RMenu.Add("ferme_o", "changetenue", RageUI.CreateSubMenu(RMenu:Get("ferme_o", "vestiaire"), "Ferme O'neil", "~b~Menu job :"))
RMenu:Get("ferme_o", "changetenue").Closed = function()end

RMenu.Add("ferme_o", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("ferme_o", "vestiaire"), "Ferme O'neil", "~b~Menu job :"))
RMenu:Get("ferme_o", "deletetenue").Closed = function()end

local function openMenuferme_oF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ferme_o", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ferme_o", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ferme_ointeract = true else ferme_ointeract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:ferme_o', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:ferme_o')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:ferme_o')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:ferme_o')
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
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ferme_oneil', 'ferme_oneil', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir le magasin", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-13.39684, 6480.395, 30.42)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir le champs de Patate", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2069.699,4919.748,40.02)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)   
                RageUI.ButtonWithStyle("Obtenir le champs de Poireau", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2237.397,5047.421,44.27)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)    
                RageUI.ButtonWithStyle("Obtenir le champs de Carotte", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2187.662,5177.129,56.79)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end) 
                RageUI.ButtonWithStyle("Obtenir la cuisine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(2569.980,4667.176,33.076)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)  
                RageUI.ButtonWithStyle("Obtenir la Vente de produit", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-57.059,6522.217,31.49)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.", 'GPS')
                    end
                end)        
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuferme_oVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ferme_o", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ferme_o", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configferme_o.uniform.male)
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
                end, RMenu:Get("ferme_o", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("ferme_o", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("ferme_o", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("ferme_o", "deletetenue"),true,true,true,function()
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

local function traitement_Ferme()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ferme_o", "Fabrication"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ferme_o", "Fabrication"),true,true,true,function()
                RageUI.Separator('↓ Fabrication ↓')
                for k, v in pairs(Configferme_o.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                        local EnAction =false
                        local pPed = PlayerPedId()
                        EnAction = true
                        RageUI.Popup({
                            message = "Vous êtes en train de fabriquer les ~p~"..v.label.."~w~..!",
                        })
                        TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT_FACILITY", 0, true)
                        exports['progressBars']:startUI((6 * 1000), ('Traitement en cours'))

                        Citizen.Wait((6* 1000)) 
                        ClearPedTasksImmediately(PlayerPedId())
                        TriggerServerEvent(".:ELDERS!:.||Fabrication_ferme", v.value)  
                        EnAction = false                      
                        end
                    end)
                end           
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function OpenMagasin_ferme()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ferme_o", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ferme_o", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Objets ↓')
                    for k, v in pairs(Configferme_o.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                                ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_ferme_o:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end                
            end, function()end, 1)

            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "ferme_oneil" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = Configferme_o.points[1].vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[1].vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuferme_oVestiaire()
                        end
                    end
                end
                local pos1 = Configferme_o.points[6].champ_2
                local distancePlayerChamp_2 = #(plyCoords - pos1)
                if distancePlayerChamp_2 < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[6].champ_2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter des pommes de terres")
                       
                    end
                end  
                local pos2 = Configferme_o.points[5].champ_1
                local distancePlayerChamp_1 = #(plyCoords - pos2)
                if distancePlayerChamp_1 < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[5].champ_1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp_1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter des Carottes")
                    end
                end

                local pos3 = Configferme_o.points[2].shop
                local distancePlayerShop = #(plyCoords - pos3)
                if distancePlayerShop < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[2].shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerShop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au magasin")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_ferme()
                        end
                    end
                end
                local pos4 = Configferme_o.points[3].traitement
                local distancePlayerTraitement = #(plyCoords - pos4)
                if distancePlayerTraitement < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[3].traitement, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerTraitement <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour préparer les commandes")
                        if IsControlJustPressed(1,51) then
                            traitement_Ferme()
                        end
                    end
                end    
                local pos5 = Configferme_o.points[4].champ
                local distancePlayerChamp = #(plyCoords - pos5)
                if distancePlayerChamp < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[4].champ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerChamp <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour récolter des Poireaux")
                        
                    end
                end 

                local pos6 = Configferme_o.points[11].vente
                local distancePlayerVente = #(plyCoords - pos6)
                if distancePlayerVente < 15 then
                    interval = 1
                    DrawMarker(1, Configferme_o.points[11].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos prépatations")
                    end
                end     
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('ferme_o', function()
    if ESX.PlayerData.job.name == "ferme_oneil" then
        openMenuferme_oF6()
    end
end)

RegisterKeyMapping('ferme_o', 'Menu Job : ferme_o', 'keyboard', 'F6')

-- Enter / Exit marker events
CreateJobLoop('ferme_oneil', function()
    Citizen.Wait(400)
    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(Configferme_o.points) do
        if (v.Pos ~= nil) then
            if (#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < 1.5) then
              isInMarker = true
              currentZone = k
            end
        end
    end
    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone = currentZone             
        TriggerEvent('ferme_oneil:hasEnteredMarkerferme_oneil', currentZone)
    end
    if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('ferme_oneil:hasExitedMarkerferme_oneil', LastZone)
    end

    if not isInMarker then
        Citizen.Wait(300)
    end
end)

CreateJobLoop('ferme_oneil', function()
    if CurrentAction ~= nil then
        if IsControlJustPressed(1,51) then
            if CurrentAction == 'Champs_carotte' then
                recolte_carotte()
            elseif CurrentAction == 'Champs_poireau' then
                recolte_poireau()
            elseif CurrentAction == 'champs_patate' then
                recolte_patate()
            elseif CurrentAction == 'vente_produit' then
                vente_Ferme()         
            end
            CurrentAction = nil
        end
    else
        Citizen.Wait(500)
    end

end)


