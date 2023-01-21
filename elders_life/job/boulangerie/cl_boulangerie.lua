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

RMenu.Add("boulangerie", "princ", RageUI.CreateMenu("Boulangerie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("boulangerie", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("boulangerie", "vestiaire", RageUI.CreateMenu("Boulangerie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("boulangerie", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("boulangerie", "Magasin", RageUI.CreateMenu("Boulangerie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("boulangerie", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("boulangerie", "Cuisine", RageUI.CreateMenu("Boulangerie", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("boulangerie", "Cuisine").Closed = function()
    isMenuOpened = false
end

RMenu.Add("boulangerie", "annonce", RageUI.CreateSubMenu(RMenu:Get("boulangerie", "princ"), "Boulangerie", "~b~Menu job :"))
RMenu:Get("boulangerie", "annonce").Closed = function()end

RMenu.Add("boulangerie", "changetenue", RageUI.CreateSubMenu(RMenu:Get("boulangerie", "vestiaire"), "Boulangerie", "~b~Menu job :"))
RMenu:Get("boulangerie", "changetenue").Closed = function()end

RMenu.Add("boulangerie", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("boulangerie", "vestiaire"), "Boulangerie", "~b~Menu job :"))
RMenu:Get("boulangerie", "deletetenue").Closed = function()end

local function openMenuboulangerieF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("boulangerie", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("boulangerie", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    boulangerieinteract = true else boulangerieinteract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:boulangerie', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('boulangerie||Ouverture')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('boulangerie||Fermeture')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('boulangerie||recrutement')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, boulangerieinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_boulangerie', 'boulangerie', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir le fournisseur", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(55.03, -1739.093, 28.59)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.",'GPS')
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuboulangerieVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("boulangerie", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("boulangerie", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("boulangerie", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("boulangerie", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("boulangerie", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("boulangerie", "deletetenue"),true,true,true,function()
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


local function openMagasinboulangerie()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("boulangerie", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("boulangerie", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(ConfigBoulangerie.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                                return
                                end
                                TriggerServerEvent('.:ELDERS!:.||shop_boulangerie', v.value, v.price , amount)                            
                            end
                        end)
                    end
                RageUI.Separator('↓ Boisson ↓')
                for k, v in pairs(ConfigBoulangerie.boisson) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                                return
                                end
                                TriggerServerEvent('.:ELDERS!:.||shop_boulangerie', v.value, v.price , amount)                            
                            end
                        end)
                    end
                
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function OpenCuisine_boulangerie()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("boulangerie", "Cuisine"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("boulangerie", "Cuisine"),true,true,true,function()
                RageUI.Separator('↓ Cuisine ↓')
                for k, v in pairs(ConfigBoulangerie.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent(".:ELDERS!:.||Cuisine_boulangerie", v.value)
                            Wait(10000)
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "boulangerie" then     
            local playerPos = GetEntityCoords(PlayerPedId()) 
            local pos1 = ConfigBoulangerie.points.vestiaire
            local distancePlayerVestiaire = #(playerPos - pos1)

            if distancePlayerVestiaire < 15 then
                interval = 1
                DrawMarker(1, ConfigBoulangerie.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        openMenuboulangerieVestiaire()
                    end
                end
            end
            local pos2 = ConfigBoulangerie.points.shop
            local distancePlayershop = #(playerPos-pos2)
            if distancePlayershop < 15 then
                interval = 1
                DrawMarker(1, ConfigBoulangerie.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                if distancePlayershop <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin")
                    if IsControlJustPressed(1,51) then
                        openMagasinboulangerie()
                    end
                end
            end  
            local pos3 = ConfigBoulangerie.points.cuisine
            local distancePlayercuisine = #(playerPos-pos3)
            if distancePlayercuisine < 15 then
                interval = 1
                DrawMarker(1, ConfigBoulangerie.points.cuisine, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                if distancePlayercuisine <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                    if IsControlJustPressed(1,51) then
                        OpenCuisine_boulangerie()
                    end
                end
            end   
            local pos4 = ConfigBoulangerie.points.cuisine1
            local distancePlayercuisine1 = #(playerPos-pos4)
            if distancePlayercuisine1 < 15 then
                interval = 1
                DrawMarker(1, ConfigBoulangerie.points.cuisine1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                if distancePlayercuisine1 <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                    if IsControlJustPressed(1,51) then
                        OpenCuisine_boulangerie()
                    end
                end
            end       
            Citizen.Wait(interval)
        else
        Citizen.Wait(interval)
        end
    end
end)

RegisterCommand('boulangerie', function()
    if ESX.PlayerData.job.name == "boulangerie" then
        openMenuboulangerieF6()
    end
end)

RegisterKeyMapping('boulangerie', 'Menu Job : boulangerie', 'keyboard', 'F6')
