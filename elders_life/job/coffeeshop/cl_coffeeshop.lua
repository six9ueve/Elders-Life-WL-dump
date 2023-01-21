ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

TriggerEvent('god_society:registerSociety', 'coffeeshop', 'coffeeshop', 'society_coffeeshop', 'society_coffeeshop', 'society_coffeeshop', {type = 'public'})


local cancreate = true
local AuTravailleBestbuddzCBD = false

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("coffeeshop", "princ", RageUI.CreateMenu("coffeeshop", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("coffeeshop", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("coffeeshop", "vestiaire", RageUI.CreateMenu("coffeeshop", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("coffeeshop", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("coffeeshop", "Magasin", RageUI.CreateMenu("coffeeshop", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("coffeeshop", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("coffeeshop", "Cuisine", RageUI.CreateMenu("coffeeshop", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("coffeeshop", "Cuisine").Closed = function()
    isMenuOpened = false
end

RMenu.Add("coffeeshop", "annonce", RageUI.CreateSubMenu(RMenu:Get("coffeeshop", "princ"), "coffeeshop", "~b~Menu job :"))
RMenu:Get("coffeeshop", "annonce").Closed = function()end

RMenu.Add("coffeeshop", "changetenue", RageUI.CreateSubMenu(RMenu:Get("coffeeshop", "vestiaire"), "coffeeshop", "~b~Menu job :"))
RMenu:Get("coffeeshop", "changetenue").Closed = function()end

RMenu.Add("coffeeshop", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("coffeeshop", "vestiaire"), "coffeeshop", "~b~Menu job :"))
RMenu:Get("coffeeshop", "deletetenue").Closed = function()end

local function StartTravailleBestbuddzCBD()
    while AuTravailleBestbuddzCBD do
        RageUI.Popup({
            message = "Un travail t'a été attribué, dirige-toi sur place !",
        })
        Citizen.Wait(1)
        local random = math.random(1,5)
        local count = 1
        for k,v in pairs(ConfigCoffeeshop.workszone) do
            count = count + 1
            if count == random and AuTravailleBestbuddzCBD then
                local EnAction = false
                local pPed = PlayerPedId()
                local pCoords = GetEntityCoords(pPed)
                local dstToMarker = GetDistanceBetweenCoords(v.pos, pCoords, true)
                local blip = AddBlipForCoord(v.pos)
                SetBlipSprite(blip, 402)
                SetBlipColour(blip, 1)
                SetBlipScale(blip, 0.85)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString("Récolte")
                EndTextCommandSetBlipName(blip)
                while not EnAction and AuTravailleBestbuddzCBD do
                    Citizen.Wait(1)
                    pCoords = GetEntityCoords(pPed)
                    dstToMarker = #(pCoords - v.pos)
                    DrawMarker(32, v.pos.x, v.pos.y, v.pos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                    local distance = #(pCoords - ConfigCoffeeshop.points.recolte)
                    if distance <= 7.0 then
                        DrawMarker(1, ConfigCoffeeshop.points.recolte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                        if distance <= 3.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter de ramasser")
                            if IsControlJustPressed(1, 51) and distance <= 3.0 then
                                AuTravailleBestbuddzCBD = false
                            end
                        end
                    end
                    if dstToMarker <= 3.0 and AuTravailleBestbuddzCBD then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ramasser")
                        if IsControlJustPressed(1, 51) and dstToMarker <= 3.0 then
                            RemoveBlip(blip)
                            EnAction = true
                            SetEntityCoords(pPed, v.pos, 0.0, 0.0, 0.0, 0)
                            SetEntityHeading(pPed, v.Heading)
                            ExecuteCommand(v.anim)
                            FreezeEntityPosition(pPed, true)
                            exports['progressBars']:startUI((11 * 1000), ('Ramassage Weed...'))
                            Citizen.Wait((11* 1000)) 
                            FreezeEntityPosition(pPed, false)
                            ClearPedTasksImmediately(PlayerPedId())
                            local count_4 = math.random(1, 3)
                            local chance = math.random(1, 100)
                            TriggerServerEvent('Elders_weed:takeCbd',count_4,chance)
                            RageUI.Popup({
                                message = "Bien ! Tu as reçu ~g~"..count_4.." weeds ~w~ pour ton travail, continue comme ça !",
                            })
                            break
                        end
                    end
                end
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
            end
        end
    end
end

local function openMenucoffeeshopF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("coffeeshop", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("coffeeshop", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    coffeeshopinteract = true else coffeeshopinteract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:eld_coffeeshop', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:eld_coffeeshop')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:eld_coffeeshop')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:eld_coffeeshop')
                                    end
                end)                                    
                RageUI.Separator('~y~↓ Employé ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, coffeeshopinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_coffeeshop', 'coffeeshop', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Obtenir le fournisseur", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(45.973, -1749.077, 29.62)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqué.")
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end
local function OpenCuisine_coffeeshop()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("coffeeshop", "Cuisine"), true)
        Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("coffeeshop", "Cuisine"),true,true,true,function()
                RageUI.Separator('↓ Cuisine ↓')
                for k, v in pairs(ConfigCoffeeshop.cuisine) do
                    RageUI.ButtonWithStyle("Préparer un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("elders_eld_coffeeshop:Cuisine", v.value)
                            Wait(10000)
                        end
                    end)
                end           
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function OpenMagasin_coffeeshop()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("coffeeshop", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("coffeeshop", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(ConfigCoffeeshop.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_eld_coffeeshop:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                RageUI.Separator('↓ Boisson ↓')
                for k, v in pairs(ConfigCoffeeshop.boisson) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then
                                            ESX.ShowNotification("Montant Invalide", 'Problème')
                                            return
                                            end
                                            TriggerServerEvent('elders_eld_coffeeshop:shop', v.value, v.price , amount)                            
                            end
                        end)
                    end
                
            end, function()end, 1)

            Wait(0)
        end
    end)
end
local function openMenucoffeeshopVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("coffeeshop", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("coffeeshop", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("coffeeshop", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("coffeeshop", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffeeshop", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("coffeeshop", "deletetenue"),true,true,true,function()
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "coffeeshop" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigCoffeeshop.points.vestiaire
                local distancePlayerVestiaire = #(plyCoords - pos)
                if distancePlayerVestiaire < 15 then
                    interval = 1
                    DrawMarker(1, ConfigCoffeeshop.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerVestiaire <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenucoffeeshopVestiaire()
                        end
                    end
                end            
                local pos1 = ConfigCoffeeshop.points.cuisine
                local distancePlayercuisine = #(plyCoords - pos1)
                if distancePlayercuisine < 15 then
                    interval = 1
                    DrawMarker(1, ConfigCoffeeshop.points.cuisine, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayercuisine <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_coffeeshop()
                        end
                    end
                end
                local pos11 = ConfigCoffeeshop.points.cuisine1
                local distancePlayercuisine1 = #(plyCoords - pos11)
                if distancePlayercuisine1 < 15 then
                    interval = 1
                    DrawMarker(1, ConfigCoffeeshop.points.cuisine1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayercuisine1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
                        if IsControlJustPressed(1,51) then
                            OpenCuisine_coffeeshop()
                        end
                    end
                end
                local pos3 = ConfigCoffeeshop.points.shop
                local distancePlayerShop = #(plyCoords - pos3)
                if distancePlayerShop <= 15 then
                    interval = 1
                    DrawMarker(1, ConfigCoffeeshop.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerShop <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_coffeeshop()
                        end
                    end
                end
                local pos4 = ConfigCoffeeshop.points.recolte
                local distancePlayerRecolte = #(plyCoords - pos4)
                if distancePlayerRecolte <= 5 then
                    interval = 1
                    DrawMarker(1, ConfigCoffeeshop.points.recolte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if distancePlayerRecolte <= 1.2 and not isMenuOpened then                     
                        if not AuTravailleBestbuddzCBD then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à récolter")
                            if IsControlJustPressed(1,51) then
                                 RageUI.Popup({
                            message = "Alors comme ça tu veux bosser au ~g~Coffeeshop~w~ hein ? Très bien prends ton chapeau et tes gants et c'est partit !",
                                })
                                AuTravailleBestbuddzCBD = true
                                StartTravailleBestbuddzCBD()
                            end
                        end                        
                    end
                end
            end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('coffeeshop', function()
    if ESX.PlayerData.job.name == "coffeeshop" then
        openMenucoffeeshopF6()
    end
end)

RegisterKeyMapping('coffeeshop', 'Menu Job : O\'coffeeshop', 'keyboard', 'F6')