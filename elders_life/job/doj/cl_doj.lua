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

RMenu.Add("doj", "princ", RageUI.CreateMenu("DOJ", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("doj", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("doj", "vestiaire", RageUI.CreateMenu("DOJ", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("doj", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("doj", "mixo", RageUI.CreateSubMenu(RMenu:Get("doj", "princ"), "DOJ", "~b~Menu job :"))
RMenu:Get("doj", "mixo").Closed = function()end

RMenu.Add("doj", "palpe", RageUI.CreateSubMenu(RMenu:Get("doj", "princ"), "DOJ", "~b~Menu job :"))
RMenu:Get("doj", "palpe").Closed = function()end

RMenu.Add("doj", "changetenue", RageUI.CreateSubMenu(RMenu:Get("doj", "vestiaire"), "DOJ", "~b~Menu job :"))
RMenu:Get("doj", "changetenue").Closed = function()end

RMenu.Add("doj", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("doj", "vestiaire"), "DOJ", "~b~Menu job :"))
RMenu:Get("doj", "deletetenue").Closed = function()end

local function openMenudojF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("doj", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("doj", "princ"),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    dojinteract = true else dojinteract = false
                end                
                RageUI.Separator('~y~↓ Citoyen ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, dojinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_juge', 'doj', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("doj", "palpe"),true,true,true,function()
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

local function openMenudojVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("doj", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("doj", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("doj", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("doj", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("doj", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("doj", "deletetenue"),true,true,true,function()
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
        for k, v in pairs(ConfigDoj.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "juge" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenudojVestiaire()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('doj', function()
    if ESX.PlayerData.job.name == "juge" then
        openMenudojF6()
    end
end)

RegisterKeyMapping('doj', 'Menu Job : doj', 'keyboard', 'F6')