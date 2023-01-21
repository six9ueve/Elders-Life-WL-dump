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

RMenu.Add("tacos", "princ", RageUI.CreateMenu("O'Tacos", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tacos", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tacos", "vestiaire", RageUI.CreateMenu("O'Tacos", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tacos", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tacos", "Magasin", RageUI.CreateMenu("O'Tacos", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tacos", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tacos", "Cuisine", RageUI.CreateMenu("O'Tacos", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("tacos", "Cuisine").Closed = function()
    isMenuOpened = false
end

RMenu.Add("tacos", "annonce", RageUI.CreateSubMenu(RMenu:Get("tacos", "princ"), "O'Tacos", "~b~Menu job :"))
RMenu:Get("tacos", "annonce").Closed = function()end

RMenu.Add("tacos", "changetenue", RageUI.CreateSubMenu(RMenu:Get("tacos", "vestiaire"), "O'Tacos", "~b~Menu job :"))
RMenu:Get("tacos", "changetenue").Closed = function()end

RMenu.Add("tacos", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("tacos", "vestiaire"), "O'Tacos", "~b~Menu job :"))
RMenu:Get("tacos", "deletetenue").Closed = function()end

local function openMenutacosF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tacos", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tacos", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    tacosinteract = true else tacosinteract = false
                end
                RageUI.Separator('~y~↓ Anno~g~nces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:tacos', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:tacos')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:tacos')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:tacos')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Emp~g~loyé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, tacosinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_tacos', 'tacos', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir le fournisseur", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(46.48, -1749.645, 28.63)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.")
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end
local function OpenCuisine_tacos()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tacos", "Cuisine"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tacos", "Cuisine"),true,true,true,function()
                RageUI.Separator('↓ Cuisine ↓')
                for k, v in pairs(Configtacos.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("elders_tacos:Cuisine", v.value)
                            Wait(10000)
                        end
                    end)
                end           
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function OpenMagasin_tacos()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tacos", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tacos", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(Configtacos.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_tacos:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                RageUI.Separator('↓ Boisson ↓')
                for k, v in pairs(Configtacos.boisson) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_tacos:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                
            end, function()end, 1)

            Wait(0)
        end
    end)
end
local function openMenutacosVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("tacos", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("tacos", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("tacos", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("tacos", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("tacos", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("tacos", "deletetenue"),true,true,true,function()
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "tacos" then            
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = Configtacos.points.vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)

                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, Configtacos.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenutacosVestiaire()
                        end
                    end
                end            
                local pos1 = Configtacos.points.cuisine
                local distancePlayershop = #(plyCoords-pos1)
                if distancePlayershop < 15 then
                    interval = 1
                    DrawMarker(1, Configtacos.points.cuisine, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayershop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_tacos()
                        end
                    end
                end
                local pos2 = Configtacos.points.cuisine1
                local distancePlayercuisine1 = #(plyCoords-pos2)
                if distancePlayercuisine1 < 15 then
                    interval = 1
                    DrawMarker(1, Configtacos.points.cuisine1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayercuisine1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_tacos()
                        end
                    end
                end
                local pos3 = Configtacos.points.shop
                local distancePlayershop = #(plyCoords-pos3)
                if distancePlayershop < 15 then
                    interval = 1
                    DrawMarker(1, Configtacos.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayershop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_tacos()
                        end
                    end                
            end
            Citizen.Wait(interval)
        else
        Citizen.Wait(interval)
        end
    end
end)

RegisterCommand('tacos', function()
    if ESX.PlayerData.job.name == "tacos" then
        openMenutacosF6()
    end
end)

RegisterKeyMapping('tacos', 'Menu Job : O\'tacos', 'keyboard', 'F6')