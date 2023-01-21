ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

TriggerEvent('god_society:registerSociety', 'burgershot', 'burgershot', 'society_burgershot', 'society_burgershot', 'society_burgershot', {type = 'public'})


local cancreate = true

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("burgershot", "princ", RageUI.CreateMenu("Burgershot", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("burgershot", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("burgershot", "vestiaire", RageUI.CreateMenu("Burgershot", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("burgershot", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("burgershot", "Magasin", RageUI.CreateMenu("Burgershot", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("burgershot", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("burgershot", "Cuisine", RageUI.CreateMenu("Burgershot", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("burgershot", "Cuisine").Closed = function()
    isMenuOpened = false
end

RMenu.Add("burgershot", "annonce", RageUI.CreateSubMenu(RMenu:Get("burgershot", "princ"), "Burgershot", "~b~Menu job :"))
RMenu:Get("burgershot", "annonce").Closed = function()end

RMenu.Add("burgershot", "changetenue", RageUI.CreateSubMenu(RMenu:Get("burgershot", "vestiaire"), "Burgershot", "~b~Menu job :"))
RMenu:Get("burgershot", "changetenue").Closed = function()end

RMenu.Add("burgershot", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("burgershot", "vestiaire"), "Burgershot", "~b~Menu job :"))
RMenu:Get("burgershot", "deletetenue").Closed = function()end

local function openMenuburgershotF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("burgershot", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("burgershot", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    burgershotinteract = true else burgershotinteract = false
                end
                RageUI.ButtonWithStyle("Cuisine camion", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        local ped = PlayerPedId()
                        local veh = GetVehiclePedIsIn(ped, false)
                        local model = GetEntityModel(veh)
                        local displaytext = GetDisplayNameFromVehicleModel(model)
                        if displaytext == 'taco burger' then
                            isMenuOpened = false 
                            RageUI.CloseAll()
                            OpenCuisine_burgershot()         
                                        
                        else
                            ESX.ShowNotification("Vous devez être dans le Taco BurgerShot", 'Problème')
                        end
                    end
                end)
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:burgershot', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:burgershot')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:burgershot')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:burgershot')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, burgershotinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burgershot', 'burgershot', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir le fournisseur", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(28.51, -1769.771, 28.58)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.")
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end
function OpenCuisine_burgershot()
    if isMenuOpened then return end
    isMenuOpened = true
    RageUI.Visible(RMenu:Get("burgershot", "Cuisine"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("burgershot", "Cuisine"),true,true,true,function()
                RageUI.Separator('↓ Cuisine ↓')
                for k, v in pairs(ConfigBurgershot.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("elders_burgershot:Cuisine", v.value)
                            Wait(10000)
                        end
                    end)
                end           
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function OpenMagasin_burgershot()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("burgershot", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("burgershot", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(ConfigBurgershot.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_burgershot:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                RageUI.Separator('↓ Boisson ↓')
                for k, v in pairs(ConfigBurgershot.boisson) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_burgershot:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                
            end, function()end, 1)

            Wait(0)
        end
    end)
end
local function openMenuburgershotVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("burgershot", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("burgershot", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("burgershot", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("burgershot", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("burgershot", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("burgershot", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" then
                local playerPos = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigBurgershot.points.vestiaire
                local distancePlayerVestiaire = #(playerPos - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, ConfigBurgershot.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuburgershotVestiaire()
                        end
                    end
                end            
                local pos1 = ConfigBurgershot.points.cuisine
                local distancePlayerCuisine = #(playerPos - pos1)
                if distancePlayerCuisine < 15 then
                    interval = 1
                    DrawMarker(1, ConfigBurgershot.points.cuisine, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerCuisine <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_burgershot()
                        end
                    end
                end
                local pos2 = ConfigBurgershot.points.cuisine1
                local distancePlayerCuisine2 = #(playerPos - pos2)

                if distancePlayerCuisine2 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigBurgershot.points.cuisine1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerCuisine2 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_burgershot()
                        end
                    end
                end
                local pos3 = ConfigBurgershot.points.shop
                local distancePlayershop = #(playerPos - pos3)
                if distancePlayershop <= 15 and ESX.PlayerData.job.grade >= 3 then
                    interval = 1
                    DrawMarker(1, ConfigBurgershot.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayershop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_burgershot()
                        end
                    end
                end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('burgershot', function()
    if ESX.PlayerData.job.name == "burgershot" then
        openMenuburgershotF6()
    end
end)

RegisterKeyMapping('burgershot', 'Menu Job : O\'burgershot', 'keyboard', 'F6')