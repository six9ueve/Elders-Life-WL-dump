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

RMenu.Add("pearl", "princ", RageUI.CreateMenu("Pearl", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("pearl", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("pearl", "vestiaire", RageUI.CreateMenu("Pearl", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("pearl", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("pearl", "Magasin", RageUI.CreateMenu("Pearl", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("pearl", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("pearl", "Cuisine", RageUI.CreateMenu("Pearl", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("pearl", "Cuisine").Closed = function()
    isMenuOpened = false
end

RMenu.Add("pearl", "annonce", RageUI.CreateSubMenu(RMenu:Get("pearl", "princ"), "Pearl", "~b~Menu job :"))
RMenu:Get("pearl", "annonce").Closed = function()end

RMenu.Add("pearl", "changetenue", RageUI.CreateSubMenu(RMenu:Get("pearl", "vestiaire"), "Pearl", "~b~Menu job :"))
RMenu:Get("pearl", "changetenue").Closed = function()end

RMenu.Add("pearl", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("pearl", "vestiaire"), "Pearl", "~b~Menu job :"))
RMenu:Get("pearl", "deletetenue").Closed = function()end

local function openMenupearlF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("pearl", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("pearl", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    pearlinteract = true else pearlinteract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:pearl', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:pearl')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:pearl')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:pearl')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, pearlinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_pearl', 'pearl', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir le fournisseur", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(62.763,-1728.57, 29.61)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.")
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end
local function OpenCuisine_pearl()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("pearl", "Cuisine"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("pearl", "Cuisine"),true,true,true,function()
                RageUI.Separator('↓ Cuisine ↓')
                for k, v in pairs(ConfigPearl.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("elders_pearl:Cuisine", v.value)
                            Wait(10000)
                        end
                    end)
                end           
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function OpenMagasin_pearl()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("pearl", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("pearl", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(ConfigPearl.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_pearl:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                RageUI.Separator('↓ Boisson ↓')
                for k, v in pairs(ConfigPearl.boisson) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_pearl:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                
            end, function()end, 1)

            Wait(0)
        end
    end)
end
local function openMenupearlVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("pearl", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("pearl", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("pearl", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("pearl", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("pearl", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("pearl", "deletetenue"),true,true,true,function()
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "pearl" then            
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigPearl.points.vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)

                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, ConfigPearl.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenupearlVestiaire()
                        end
                    end
                end            
                local pos1 = ConfigPearl.points.cuisine
                local distancePlayershop = #(plyCoords-pos1)
                if distancePlayershop < 15 then
                    interval = 1
                    DrawMarker(1, ConfigPearl.points.cuisine, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayershop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_pearl()
                        end
                    end
                end
                local pos2 = ConfigPearl.points.cuisine1
                local distancePlayercuisine1 = #(plyCoords-pos2)
                if distancePlayercuisine1 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigPearl.points.cuisine1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayercuisine1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_pearl()
                        end
                    end
                end
                local pos3 = ConfigPearl.points.shop
                local distancePlayershop = #(plyCoords-pos3)
                if distancePlayershop < 15 then
                    interval = 1
                    DrawMarker(1, ConfigPearl.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayershop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_pearl()
                        end
                    end                
            end
            Citizen.Wait(interval)
        else
        Citizen.Wait(interval)
        end
    end
end)

RegisterCommand('pearl', function()
    if ESX.PlayerData.job.name == "pearl" then
        openMenupearlF6()
    end
end)

RegisterKeyMapping('pearl', 'Menu Job : O\'pearl', 'keyboard', 'F6')