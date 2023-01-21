ESX = nil

local isMenuOpened = false
local societyopen


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)
local blms = nil

local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(250)
        blockinput = false
        return result
    else
        Citizen.Wait(250)
        blockinput = false
        return nil
    end
end

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job)
    ESX.PlayerData.job2 = job2
end)

RMenu.Add("coffreentre", "princ", RageUI.CreateMenu("Coffre", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("coffreentre", "princ").Closed = function()
    FreezeEntityPosition(PlayerPedId(), false)
    isMenuOpened = false
end

RMenu.Add("coffreentre", "deposerobject", RageUI.CreateSubMenu(RMenu:Get("coffreentre", "princ"), "Coffre", "~b~Déposer objet :"))
RMenu:Get("coffreentre", "deposerobject").Closed = function()end

RMenu.Add("coffreentre", "retirerobject", RageUI.CreateSubMenu(RMenu:Get("coffreentre", "princ"), "Coffre", "~b~Rétirer objet :"))
RMenu:Get("coffreentre", "retirerobject").Closed = function()end

RMenu.Add("coffreentre", "supprimerobject", RageUI.CreateSubMenu(RMenu:Get("coffreentre", "princ"), "Coffre", "~b~Supprimer objet :"))
RMenu:Get("coffreentre", "supprimerobject").Closed = function()end

RMenu.Add("coffreentre", "deposerargent", RageUI.CreateSubMenu(RMenu:Get("coffreentre", "princ"), "Coffre", "~b~Déposer argent sale :"))
RMenu:Get("coffreentre", "deposerargent").Closed = function()end

RMenu.Add("coffreentre", "retireargent", RageUI.CreateSubMenu(RMenu:Get("coffreentre", "princ"), "Coffre", "~b~Retirer argent sale :"))
RMenu:Get("coffreentre", "retireargent").Closed = function()end

local function openCoffreEntreprise(soc, blackmoney, jobname)

    FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true
    societyopen = soc

    RageUI.Visible(RMenu:Get("coffreentre","princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            sale = false
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.grade_name == "boss" or ESX.PlayerData.job2.grade_name == "boss2" then
                sale = true end
            if ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == "boss" then
                sale = true end
            if ESX.PlayerData.job.name == 'sheriff' and ESX.PlayerData.job.grade_name == "boss" then
                sale = true end
            RageUI.IsVisible(RMenu:Get("coffreentre","princ"),true,true,true,function()
                if blackmoney  then
                    if blms ~= nil then
                        RageUI.Separator('↓ Argent Sale ↓')
                        RageUI.Separator('↓ Coffre :~r~ '..blms..' $~s~ ↓')
                    end
                end
                RageUI.ButtonWithStyle("Déposer des objets", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("coffreentre", "deposerobject"))
                RageUI.ButtonWithStyle("Retirer des objets", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("coffreentre", "retirerobject"))
                if ESX.PlayerData.group == 'superadmin' then
                    RageUI.ButtonWithStyle("~r~Supprimer des objets", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    end, RMenu:Get("coffreentre", "supprimerobject"))
                end
                if blackmoney then
                    RageUI.ButtonWithStyle("Déposer argent sale", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    end, RMenu:Get("coffreentre", "deposerargent"))
                    RageUI.ButtonWithStyle("Retirer argent sale", nil, {RightLabel = "→→→"}, sale,function(a,h,s)
                    end, RMenu:Get("coffreentre", "retireargent"))
                    if ESX.PlayerData.group == 'superadmin' or ESX.PlayerData.group == 'admin' then
                        RageUI.ButtonWithStyle('~r~Vider le coffre Argent Sale', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("atmos", "Oui pour effacer Black Money ?","", 4)
                                if count == 'Oui' then
                                    TriggerServerEvent("aEntrepriseCoffreTest:removeallblack", soc)
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                    FreezeEntityPosition(PlayerPedId(), false)
                                else
                                    ESX.ShowNotification("Action Annulée", 'Problème')
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                    FreezeEntityPosition(PlayerPedId(), false)
                                end
                            end
                        end)
                    end
                end
                if ESX.PlayerData.group == 'superadmin' or ESX.PlayerData.group == 'admin' then
                    RageUI.ButtonWithStyle('~r~Vider le coffre Objets', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("atmos", "Oui pour effacer Objets ?","", 4)
                            if count == 'Oui' then
                                TriggerServerEvent("aEntrepriseCoffreTest:removeallobj", soc)
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            else
                                ESX.ShowNotification("Action Annulée", 'Problème')
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffreentre","deposerobject"),true,true,true,function()
                RageUI.Separator('↓ Vos items ↓')
                ESX.PlayerData = ESX.GetPlayerData()
                for i = 1, #ESX.PlayerData.inv do
                    if ESX.PlayerData.inv[i].count > 0 then
                        RageUI.ButtonWithStyle(ESX.PlayerData.inv[i].label, nil, {RightLabel = "Quantité : ~r~x"..ESX.PlayerData.inv[i].count}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("atmos", "Combien ?","", 4)
                                count = tonumber(count)
                                local timer = math.random(1,50)
                                Citizen.Wait(timer)
                                TriggerServerEvent('aEntrepriseCoffreTest:putStockItems', soc, ESX.PlayerData.inv[i].name, count)
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end
                        end)
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffreentre","retirerobject"),true,true,true,function()
                RageUI.ButtonWithStyle("Filtre", nil, {RightLabel = filtrecoffre}, true,function(a,h,s)
                    if s then
                        filtrecoffre = KeyboardInput("atmos", "Nom Objets", "", 4)
                        if filtrecoffre ~= nil then
                            filtrecoffre = filtrecoffre
                        else
                            filtrecoffre = nil
                        end
                    end
                end)
                if filtrecoffre ~= nil then
                    RageUI.ButtonWithStyle("Supprimer filtre", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            filtrecoffre = nil
                        end
                    end)
                end
                RageUI.Separator('↓ Objets coffre ↓')
                for k,v in pairs(itemstock) do
                    if v.label ~= nil then
                        if v.count > 0 then
                            if filtrecoffre == nil then
                                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.count}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        local count = KeyboardInput("atmos", "Combien ?","", 4)
                                        count = tonumber(count)
                                        local timer = math.random(1,50)
                                        Citizen.Wait(timer)
                                        TriggerServerEvent('aEntrepriseCoffreTest:getStockItem', soc, v.name, count)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end
                                end)
                            elseif starts(v.label:lower(), filtrecoffre:lower()) then
                                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.count}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        local count = KeyboardInput("atmos", "Combien ?","", 4)
                                        count = tonumber(count)
                                        local timer = math.random(1,50)
                                        Citizen.Wait(timer)
                                        TriggerServerEvent('aEntrepriseCoffreTest:getStockItem', soc, v.name, count)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end
                                end)
                            end
                        end
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffreentre","supprimerobject"),true,true,true,function()
                RageUI.ButtonWithStyle("Filtre", nil, {RightLabel = filtrecoffre}, true,function(a,h,s)
                    if s then
                        filtrecoffre = KeyboardInput("atmos", "Nom Objets", "", 4)
                        if filtrecoffre ~= nil then
                            filtrecoffre = filtrecoffre
                        else
                            filtrecoffre = nil
                        end
                    end
                end)
                if filtrecoffre ~= nil then
                    RageUI.ButtonWithStyle("Supprimer filtre", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            filtrecoffre = nil
                        end
                    end)
                end
                RageUI.Separator('↓ Objets coffre ↓')
                for k,v in pairs(itemstock) do
                    if v.label ~= nil then
                        if v.count > 0 then
                            if filtrecoffre == nil then
                                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.count}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        local count = KeyboardInput("atmos", "Combien ?","", 4)
                                        count = tonumber(count)
                                        local timer = math.random(1,50)
                                        Citizen.Wait(timer)
                                        TriggerServerEvent('aEntrepriseCoffreTest:delStockItem', soc, v.name, count)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end
                                end)
                            elseif starts(v.label:lower(), filtrecoffre:lower()) then
                                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.count}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        local count = KeyboardInput("atmos", "Combien ?","", 4)
                                        count = tonumber(count)
                                        local timer = math.random(1,50)
                                        Citizen.Wait(timer)
                                        TriggerServerEvent('aEntrepriseCoffreTest:delStockItem', soc, v.name, count)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                        FreezeEntityPosition(PlayerPedId(), false)
                                    end
                                end)
                            end
                        end
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffreentre", "deposerargent"),true,true,true,function()
                RageUI.Separator('↓ Votre argent sale ↓')
                RageUI.ButtonWithStyle("Argent sale", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(blm).."$"}, true,function(a,h,s)
                    if s then
                        local count = KeyboardInput("atmos", "Combien ?","", 9)
                        if count ~= nil then
                            count = tonumber(count)
                            TriggerServerEvent("aEntrepriseCoffreTest:depositblackmoney", soc, count)
                            RageUI.CloseAll()
                            isMenuOpened = false
                            FreezeEntityPosition(PlayerPedId(), false)
                        else
                            ESX.ShowNotification("Montant Invalide", 'Problème')
                        end
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("coffreentre", "retireargent"),true,true,true,function()
                RageUI.Separator('↓ Argent sale coffre ↓')
                RageUI.ButtonWithStyle("Argent sale", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(blms).."$"}, true,function(a,h,s)
                    if s then
                        local count = KeyboardInput("atmos", "Combien ?","", 9)
                        if count ~= nil then
                            count = tonumber(count)
                            TriggerServerEvent("aEntrepriseCoffreTest:retraitblackmoney", soc, count)
                            RageUI.CloseAll()
                            isMenuOpened = false
                            FreezeEntityPosition(PlayerPedId(), false)
                        else
                            ESX.ShowNotification("Montant Invalide", 'Problème')
                        end
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(Configcoffreentre.coffre) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.jobname or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.jobname then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.location)
                if v.grade == 0 then
                    if dist <= 15 then
                        interval = 1
                        DrawMarker(1, v.location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                        if dist <= 1.2 and not isMenuOpened then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ouvrir le coffre "..v.label)
                            if IsControlJustPressed(1,51) then
                                if v.blackmoney then
                                    Citizen.Wait(50)
                                    ESX.TriggerServerCallback("aEntrepriseCoffreTest:getplayerblackmoney", function(data)
                                        blm = data
                                    end)
                                    Citizen.Wait(50)
                                    ESX.TriggerServerCallback("aEntrepriseCoffreTest:getsocietyblackmoney", function(data)
                                        blms = data
                                    end, v.societyname)
                                end
                                ESX.TriggerServerCallback('aEntrepriseCoffreTest:getStockItems', function(items)
                                    itemstock = items
                                end, v.societyname)
                                Wait(50)
                                openCoffreEntreprise(v.societyname, v.blackmoney, v.jobname)
                            end
                        end
                    end
                elseif (v.grade <= ESX.PlayerData.job.grade and ESX.PlayerData.job.name == v.jobname) or (v.grade <= ESX.PlayerData.job2.grade and ESX.PlayerData.job2.name == v.jobname) then
                    if dist <= 15 then
                        interval = 1
                        DrawMarker(1, v.location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                        if dist <= 1.2 and not isMenuOpened then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ouvrir le coffre "..v.label)
                            if IsControlJustPressed(1,51) then
                                if v.blackmoney then
                                    Citizen.Wait(50)
                                    ESX.TriggerServerCallback("aEntrepriseCoffreTest:getplayerblackmoney", function(data)
                                        blm = data
                                    end)
                                    Citizen.Wait(50)
                                    ESX.TriggerServerCallback("aEntrepriseCoffreTest:getsocietyblackmoney", function(data)
                                        blms = data
                                    end, v.societyname)
                                end
                                ESX.TriggerServerCallback('aEntrepriseCoffreTest:getStockItems', function(items)
                                    itemstock = items
                                end, v.societyname)
                                Wait(50)
                                openCoffreEntreprise(v.societyname, v.blackmoney, v.jobname)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)