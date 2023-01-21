ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("stickers", "princ", RageUI.CreateMenu("Stickers", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("stickers", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("stickers", "vestiaire", RageUI.CreateMenu("Stickers", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("stickers", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("stickers", "mixo", RageUI.CreateSubMenu(RMenu:Get("stickers", "princ"), "Stickers", "~b~Menu job :"))
RMenu:Get("stickers", "mixo").Closed = function()end

RMenu.Add("stickers", "palpe", RageUI.CreateSubMenu(RMenu:Get("stickers", "princ"), "Stickers", "~b~Menu job :"))
RMenu:Get("stickers", "palpe").Closed = function()end

RMenu.Add("stickers", "changetenue", RageUI.CreateSubMenu(RMenu:Get("stickers", "vestiaire"), "Stickers", "~b~Menu job :"))
RMenu:Get("stickers", "changetenue").Closed = function()end

RMenu.Add("stickers", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("stickers", "vestiaire"), "Stickers", "~b~Menu job :"))
RMenu:Get("stickers", "deletetenue").Closed = function()end

local function openMenustickersF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("stickers", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("stickers", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    stickersinteract = true else stickersinteract = false
                end
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('elders_stickers:Perso', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('elders_stickers:Ouverture')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('elders_stickers:Fermeture')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('elders_stickers:recrutement')
                                    end
                end)                  
                RageUI.Separator('~y~↓ Citoyen ↓')
                RageUI.ButtonWithStyle("Poser un stickers", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        local playerPed = PlayerPedId()
                        local coords    = GetEntityCoords(playerPed)
                        if GetDistanceBetweenCoords(coords,  733.17,  -1086.25,  22.16,  true) < 40 then
                          TriggerEvent('rcore_stickers:openMenu')
                          RageUI.CloseAll()
                          isMenuOpened = false
                        else
                          ESX.ShowNotification("Tu n'es pas à ton garage", 'Problème')
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, stickersinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_stickers', 'stickers', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("stickers", "palpe"),true,true,true,function()
                RageUI.Separator('↓ Inventaire ↓')
                for k, v in pairs(Items) do
                    if v.weight >= 3 then
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.amount}, true,function(a,h,s) end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenustickersVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("stickers", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("stickers", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigStickers.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigStickers.uniform_female)
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
                end, RMenu:Get("stickers", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("stickers", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("stickers", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("stickers", "deletetenue"),true,true,true,function()
                RageUI.Separator('↓ Supprimer une tenue ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent('god_eden_clotheshop:removeOutfit', v.value)
                                ESX.ShowNotification("Vous venez de supprimer la tenue "..v.label.."~s~ !", 'Dressing')

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
        for k, v in pairs(ConfigStickers.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "stickers" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(22,  v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenustickersVestiaire()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('stickers', function()
    if ESX.PlayerData.job.name == "stickers" then
        openMenustickersF6()
    end
end)

RegisterKeyMapping('stickers', 'Menu Job : stickers', 'keyboard', 'F6')