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

RMenu.Add("unicorn", "princ", RageUI.CreateMenu("Unicorn", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("unicorn", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("unicorn", "vestiaire", RageUI.CreateMenu("Unicorn", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("unicorn", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("unicorn", "casier", RageUI.CreateMenu("Unicorn", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("unicorn", "casier").Closed = function()
    isMenuOpened = false
end

RMenu.Add("unicorn", "mixo", RageUI.CreateSubMenu(RMenu:Get("unicorn", "princ"), "Unicorn", "~b~Menu job :"))
RMenu:Get("unicorn", "mixo").Closed = function()end

RMenu.Add("unicorn", "palpe", RageUI.CreateSubMenu(RMenu:Get("unicorn", "princ"), "Unicorn", "~b~Menu job :"))
RMenu:Get("unicorn", "palpe").Closed = function()end

RMenu.Add("unicorn", "changetenue", RageUI.CreateSubMenu(RMenu:Get("unicorn", "vestiaire"), "Unicorn", "~b~Menu job :"))
RMenu:Get("unicorn", "changetenue").Closed = function()end

RMenu.Add("unicorn", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("unicorn", "vestiaire"), "Unicorn", "~b~Menu job :"))
RMenu:Get("unicorn", "deletetenue").Closed = function()end

RMenu.Add("unicorn", "gestioncasier", RageUI.CreateSubMenu(RMenu:Get("unicorn", "casier"), "Unicorn", "~b~Actions :"))
RMenu:Get("unicorn", "gestioncasier").Closed = function()end

local function openMenuUnicornF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("unicorn", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("unicorn", "princ"),true,true,true,function()
                RageUI.Separator('↓ Annonces ↓')
                for k, v in pairs(ConfigUnicorn.annonces) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                        if s then
                            TriggerServerEvent('aUnicorn:annonces', v.msg)
                            cool(120000)
                        end
                    end)
                end
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('aUnicorn:annonces', msg)
                            cool(120000)
                        end
                    end
                end)
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    unicorninteract = true else unicorninteract = false
                end
                RageUI.Separator('↓ Citoyen ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, unicorninteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_unicorn', 'Unicorn', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.Separator('↓ Bar ↓')
                RageUI.ButtonWithStyle("Mixologie", nil, {RightLabel = "→→→"}, true,function(a,h,s) end, RMenu:Get("unicorn", "mixo"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("unicorn", "mixo"),true,true,true,function()
                RageUI.Separator('↓ Mixologie ↓')
                for k, v in pairs(ConfigUnicorn.mixologie) do
                    RageUI.ButtonWithStyle("Faire un(e) ~b~"..v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            RequestAnimDict("mini@drinking")
                            while not HasAnimDictLoaded("mini@drinking") do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(PlayerPedId(), "mini@drinking", "shots_barman_b", 8.0, -8.0, 10000, flag, 0, 0, 0, 0)
                            TriggerServerEvent("aUnicorn:craftingCoktails", v.value)
                            Wait(10000)
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("unicorn", "palpe"),true,true,true,function()
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

local function openMenuUnicornVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("unicorn", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("unicorn", "vestiaire"),true,true,true,function()
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
                end, RMenu:Get("unicorn", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("unicorn", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("unicorn", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("unicorn", "deletetenue"),true,true,true,function()
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "unicorn" then
            for k, v in pairs(ConfigUnicorn.points) do
            
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuUnicornVestiaire()
                        end
                    end
                end
            end
            Citizen.Wait(interval)
        else
        Citizen.Wait(interval)
        end
    end
end)

RegisterCommand('unicorn', function()
    if ESX.PlayerData.job.name == "unicorn" then
        openMenuUnicornF6()
    end
end)

RegisterKeyMapping('unicorn', 'Menu Job : Unicorn', 'keyboard', 'F6')