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

RMenu.Add("blackwood", "princ", RageUI.CreateMenu("BlackWood", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("blackwood", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("blackwood", "vestiaire", RageUI.CreateMenu("BlackWood", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("blackwood", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("blackwood", "mixo", RageUI.CreateSubMenu(RMenu:Get("blackwood", "princ"), "BlackWood", "~b~Menu job :"))
RMenu:Get("blackwood", "mixo").Closed = function()end

RMenu.Add("blackwood", "palpe", RageUI.CreateSubMenu(RMenu:Get("blackwood", "princ"), "BlackWood", "~b~Menu job :"))
RMenu:Get("blackwood", "palpe").Closed = function()end

RMenu.Add("blackwood", "changetenue", RageUI.CreateSubMenu(RMenu:Get("blackwood", "vestiaire"), "BlackWood", "~b~Menu job :"))
RMenu:Get("blackwood", "changetenue").Closed = function()end

RMenu.Add("blackwood", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("blackwood", "vestiaire"), "BlackWood", "~b~Menu job :"))
RMenu:Get("blackwood", "deletetenue").Closed = function()end

local function openMenublackwoodF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("blackwood", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("blackwood", "princ"),true,true,true,function()
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:black_wood', msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:black_wood')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:black_wood')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:black_wood')
                                    end
                end)   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    blackwoodinteract = true else blackwoodinteract = false
                end
                RageUI.Separator('~y~↓ Citoyen ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, blackwoodinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_black_wood', 'blackwood', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.Separator('~y~↓ Bar ↓')
                RageUI.ButtonWithStyle("Mixologie", nil, {RightLabel = "→→→"}, true,function(a,h,s) end, RMenu:Get("blackwood", "mixo"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("blackwood", "mixo"),true,true,true,function()
                RageUI.Separator('↓ Mixologie ↓')
                for k, v in pairs(ConfigBlackwood.mixologie) do
                    RageUI.ButtonWithStyle("Faire un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("ablackwood:craftingCoktails", v.value)
                            Wait(10000)
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("blackwood", "palpe"),true,true,true,function()
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

local function openMenublackwoodVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("blackwood", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("blackwood", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("blackwood", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("blackwood", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("blackwood", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("blackwood", "deletetenue"),true,true,true,function()
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
        for k, v in pairs(ConfigBlackwood.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "black_wood" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenublackwoodVestiaire()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('blackwood', function()
    if ESX.PlayerData.job.name == "black_wood" then
        openMenublackwoodF6()
    end
end)

RegisterKeyMapping('blackwood', 'Menu Job : blackwood', 'keyboard', 'F6')