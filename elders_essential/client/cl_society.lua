ESX = nil

local isMenuOpened = false
local societymoney = nil
local salaire = {}
local transactions = {}
local societyName = {}
local transactions2 = {}
local transactions3 = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

local function refreshmoney(illegal)
    if not illegal then
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
            ESX.TriggerServerCallback('aScripts:getSocietyMoney', function(money)
                societymoney = money
            end, societyName)
        end
    else
        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
            ESX.TriggerServerCallback('aScripts:getSocietyMoney', function(money)
                societymoney = money
            end, societyName)
        end
    end
end

local function loadEmployes(society)
    EmployeesList = {}
    ESX.TriggerServerCallback('god_society:getEmployees', function(employees)
        for i=1, #employees, 1 do
            table.insert(EmployeesList,  employees[i])
        end
    end, society)
end

local function loadEmployes2(society)
    EmployeesList = {}
    ESX.TriggerServerCallback('god_society:getEmployees2', function(employees)
        for i=1, #employees, 1 do
            table.insert(EmployeesList,  employees[i])
        end
    end, society)
end

RMenu.Add("society", "princ", RageUI.CreateMenu("Boss actions", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("society", "princ").Closed = function()
    FreezeEntityPosition(PlayerPedId(), false)
    isMenuOpened = false
end

RMenu.Add('society', 'listeemploye', RageUI.CreateSubMenu(RMenu:Get('society', 'princ'), 'Boss actions', "~b~Liste employés :"))
RMenu:Get('society', 'listeemploye').Closed = function()end

RMenu.Add('society', 'gestionemploye', RageUI.CreateSubMenu(RMenu:Get('society', 'listeemploye'), 'Boss actions', "~b~Gestion employés :"))
RMenu:Get('society', 'gestionemploye').Closed = function()end

RMenu.Add('society', 'gestionsalaire', RageUI.CreateSubMenu(RMenu:Get('society', 'princ'), 'Boss actions', "~b~Gestion salaires :"))
RMenu:Get('society', 'gestionsalaire').Closed = function()end

RMenu.Add('society', 'transactions', RageUI.CreateSubMenu(RMenu:Get('society', 'princ'), 'Boss actions', "~b~Gestion transactions entreprise :"))
RMenu:Get('society', 'transactions').Closed = function()end

RMenu.Add('society', 'transactionsclient', RageUI.CreateSubMenu(RMenu:Get('society', 'princ'), 'Boss actions', "~b~Gestion transactions client :"))
RMenu:Get('society', 'transactionsclient').Closed = function()end

local arrayIndexFiltreTran = 1
local arrayFiltreTran = {
    'Retraits',
    'Dépôts',
    'Facture',
    'Achat pièces',
    'Facture CB entreprise'
}
local arrayIndexFiltreTran2 = 1
local arrayFiltreTran2 = {
    'Facture impayé',
    'Facture payé'  
}

local function openMenuSociety(jobname, illegal)

    FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("society","princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("society","princ"),true,true,true,function()
                if societymoney then
                    RageUI.Separator("~r~→~s~ Patron : "..GetPlayerName(PlayerId()).." ~r~←~s~")
                    RageUI.Separator("~r~→~s~ Argent entreprise : "..societymoney.."$ ~r~←~s~")
                    RageUI.ButtonWithStyle("Déposer de l'argent", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local depot = KeyboardInput("society", "Montant", "", 9)
                            depot = tonumber(depot)
                            if depot == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            else
                                TriggerServerEvent('aScripts:depositMoney', societyName, depot, GetPlayerName(PlayerId()), ESX.PlayerData.job.name, ESX.PlayerData.job2.name, illegal)
                                refreshmoney()
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Retirer de l'argent", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local retrait = KeyboardInput("society", "Montant", "", 9)
                            retrait = tonumber(retrait)
                            if retrait == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            else
                                TriggerServerEvent('aScripts:withdrawMoney', societyName, retrait, GetPlayerName(PlayerId()), ESX.PlayerData.job.name, ESX.PlayerData.job2.name, illegal)
                                refreshmoney()
                            end
                        end
                    end)   
                    if ESX.PlayerData.group == 'superadmin' or ESX.PlayerData.group == 'admin' then
                        RageUI.ButtonWithStyle('~r~Vider le coffre Patron', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("society", "Oui pour effacer Objets ?","", 4)
                                if count == 'Oui' then
                                    TriggerServerEvent("aScripts:removeallbm", societyName)
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
                    if not illegal and jobname ~= 'police' and jobname ~= 'ambulance' and jobname ~= 'sheriff' then
                        RageUI.ButtonWithStyle("Blanchir de l'argent", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                ESX.TriggerServerCallback('elders_society:getBlackMoney', function(blackmoney)
                                    if blackmoney == true then
                                    ESX.ShowNotification('Il y as déja un blanchiement en cours...')
                                    else
                                        local result = KeyboardInput("society", "Montant", "", 9)
                                        result = tonumber(result)
                                        if result == nil or result <= 0 or result > 12000 then
                                            ESX.ShowNotification("Montant Invalide", 'montant invalide ( ~r~Max 12000$~s~ )')
                                        else
                                            TriggerServerEvent("god_society:washMoney", societyName, result)
                                        end
                                    end
                                end, societyName)
                            end
                        end)
                    end
                    RageUI.Separator("--------------------------------")
                    RageUI.ButtonWithStyle("Gestion employés", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            if not illegal then
                                loadEmployes(jobname)
                            else
                                loadEmployes2(jobname)
                            end
                        end
                    end, RMenu:Get('society', 'listeemploye'))
                    RageUI.ButtonWithStyle("Gestion salaires", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            if not illegal then
                                ESX.TriggerServerCallback('aScripts:chargementsalaire', function(keys)
                                    salaire = keys
                                end, ESX.PlayerData.job.name)
                            else
                                ESX.TriggerServerCallback('aScripts:chargementsalaire', function(keys)
                                    salaire = keys
                                end, ESX.PlayerData.job2.name)
                            end
                        end
                    end, RMenu:Get('society', 'gestionsalaire'))
                    RageUI.ButtonWithStyle("Historique des transactions entreprise", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            if not illegal then
                                ESX.TriggerServerCallback('aScripts:transactions', function(keys)
                                    transactions = keys
                                end, ESX.PlayerData.job.name)
                            else
                                ESX.TriggerServerCallback('aScripts:transactions', function(keys)
                                    transactions = keys
                                end, ESX.PlayerData.job2.name)
                            end
                        end
                    end, RMenu:Get('society', 'transactions'))
                    if not illegal then
                        if not maj then
                            RageUI.ButtonWithStyle("Historique des transactions client", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    ESX.TriggerServerCallback('aScripts:transactions3', function(keys)
                                        transactions3 = keys
                                    end, ESX.PlayerData.job.name)
                                    ESX.TriggerServerCallback('aScripts:transactions2', function(keys)
                                        transactions2 = keys
                                    end, ESX.PlayerData.job.name)
                                end
                            end, RMenu:Get('society', 'transactionsclient'))
                        end
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get('society', 'transactions'),true,true,true,function()
                RageUI.List('Filtres', arrayFiltreTran, arrayIndexFiltreTran, nil, {}, true, function(h, a, s, i) arrayIndexFiltreTran = i end)
                RageUI.Separator('↓ Transactions ↓')
                for i=1, #transactions do
                    if arrayIndexFiltreTran == 1 then
                        if transactions[i].type == arrayFiltreTran[arrayIndexFiltreTran] then
                            RageUI.ButtonWithStyle('Retrait de ~r~'..transactions[i].montant..'$', 'Auteur : '..transactions[i].name, {RightLabel = transactions[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    elseif arrayIndexFiltreTran == 2 then
                        if transactions[i].type == arrayFiltreTran[arrayIndexFiltreTran] then
                            RageUI.ButtonWithStyle('Dépôt de ~g~'..transactions[i].montant..'$', 'Auteur : '..transactions[i].name, {RightLabel = transactions[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    elseif arrayIndexFiltreTran == 3 then
                        if transactions[i].type == arrayFiltreTran[arrayIndexFiltreTran] then
                            RageUI.ButtonWithStyle('Facture payé de ~r~'..transactions[i].montant..'$', 'Auteur : '..transactions[i].name, {RightLabel = transactions[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    elseif arrayIndexFiltreTran == 4 then
                        if transactions[i].type == arrayFiltreTran[arrayIndexFiltreTran] then
                            RageUI.ButtonWithStyle('Achat pièces de ~g~'..transactions[i].montant..'$', 'Auteur : '..transactions[i].name, {RightLabel = transactions[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    elseif arrayIndexFiltreTran == 5 then
                        if transactions[i].type == arrayFiltreTran[arrayIndexFiltreTran] then
                            RageUI.ButtonWithStyle('Facture CB entreprise ~g~'..transactions[i].montant..'$', 'Auteur : '..transactions[i].name, {RightLabel = transactions[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get('society', 'transactionsclient'),true,true,true,function()
                RageUI.List('Filtres', arrayFiltreTran2, arrayIndexFiltreTran2, nil, {}, true, function(h, a, s, i) arrayIndexFiltreTran2 = i end)
                RageUI.Separator('↓ Transactions ↓')
                for i=1, #transactions2 do
                    if arrayIndexFiltreTran2 == 1 then
                        if transactions2[i].name == nil then transactions2[i].name = 'Aucun' end
                        if transactions2[i].lastname == nil then transactions2[i].name = 'Aucun' end
                        RageUI.ButtonWithStyle('Facture impayé de ~r~'..transactions2[i].amount..'$', 'Nom : '..transactions2[i].name..' '..transactions2[i].lastname, {RightLabel = transactions2[i].date}, true, function(Hovered, Active, Selected)
                        end)
                    end
                end
                for i=1, #transactions3 do
                    if arrayIndexFiltreTran2 == 2 then
                        if transactions3[i].type == arrayFiltreTran2[arrayIndexFiltreTran2] then
                            RageUI.ButtonWithStyle('Facture payé de ~g~'..transactions3[i].montant..'$', 'Nom : '..transactions3[i].name, {RightLabel = transactions3[i].date}, true, function(Hovered, Active, Selected)
                            end)
                        end
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get('society', 'listeemploye'),true,true,true,function()
                RageUI.Separator('↓ Liste employés ↓')
                if not illegal then
                    for i=1, #EmployeesList do
                        local ply = EmployeesList[i]
                        RageUI.ButtonWithStyle(ply.name, false, {RightLabel = ply.job.grade_label.." →→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                employer = ply
                            end
                        end, RMenu:Get('society', 'gestionemploye'))
                    end
                else
                    for i=1, #EmployeesList do
                        local ply = EmployeesList[i]
                        RageUI.ButtonWithStyle(ply.name, false, {RightLabel = ply.job2.grade_label.." →→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                employer = ply
                            end
                        end, RMenu:Get('society', 'gestionemploye'))
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get('society', 'gestionemploye'),true,true,true,function()
                if not illegal then
                    RageUI.Separator("~r~→~s~ Employé : "..employer.name.." ~r~←~s~")
                    RageUI.Separator("~r~→~s~ Grade : "..employer.job.grade_label.." ~r~←~s~")
                    RageUI.ButtonWithStyle("~r~Virer", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, 'unemployed', 0, 'fire')
                            ESX.ShowNotification("Vous venez de ~r~licencier~s~ "..employer.name.." !", 'Action Patron')
                           
                        end
                    end)
                else
                    RageUI.Separator("~r~→~s~ Employé : "..employer.name.." ~r~←~s~")
                    RageUI.Separator("~r~→~s~ Grade : "..employer.job2.grade_label.." ~r~←~s~")
                    RageUI.ButtonWithStyle("~r~Virer", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob2', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, 'unemployed', 0, 'fire')
                            ESX.ShowNotification("Vous venez de ~r~licencier~s~ "..employer.name.." !")
                        end
                    end)
                end
                if not illegal then
                    RageUI.ButtonWithStyle("~r~Promouvoir", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, employer.job.name, (employer.job.grade + 1), 'promote')
                            ESX.ShowNotification("Vous venez de ~r~Promouvoir~s~ "..employer.name.." !", 'Action Patron')
                           
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("~r~Promouvoir", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob2', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, employer.job2.name, (employer.job2.grade + 1), 'promote')
                            ESX.ShowNotification("Vous venez de ~r~Promouvoir~s~ "..employer.name.." !")
                        end
                    end)
                end
                if not illegal then
                    RageUI.ButtonWithStyle("~r~Rétrograder", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, employer.job.name, (employer.job.grade - 1), 'demote')
                            ESX.ShowNotification("Vous venez de ~r~Promouvoir~s~ "..employer.name.." !", 'Action Patron')
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("~r~Rétrograder", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_society:setJob2', function()
                                RageUI.CloseAll()
                                isMenuOpened = false
                                FreezeEntityPosition(PlayerPedId(), false)
                            end, employer.identifier, employer.job2.name, (employer.job2.grade - 1), 'demote')
                            ESX.ShowNotification("Vous venez de ~r~Promouvoir~s~ "..employer.name.." !")
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get('society', 'gestionsalaire'),true,true,true,function()
                RageUI.Separator('↓ Liste salaires ↓')
                for k, v in pairs(salaire) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.salary.."$"}, true,function(a,h,s)
                        if s then
                            local salaire = KeyboardInput("society", "Salaire", "", 9)
                            salaire = tonumber(salaire)
                            if salaire == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            else
                                if not illegal then
                                    ESX.TriggerServerCallback('god_society:setJobSalary', function()
                                        RageUI.GoBack()
                                    end, ESX.PlayerData.job.name, v.grade, salaire)
                                else
                                    ESX.TriggerServerCallback('god_society:setJobSalary', function()
                                        RageUI.GoBack()
                                    end, ESX.PlayerData.job2.name, v.grade, salaire)
                                end
                            end
                        end
                    end)
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    while true do
        interval = 1000
        for k, v in pairs(Configsociety.gestion) do
            if ESX.PlayerData.job and ESX.PlayerData.job2 and (ESX.PlayerData.job.name == v.jobname and ESX.PlayerData.job.grade_name == 'boss') or (ESX.PlayerData.job2.name == v.jobname and ESX.PlayerData.job2.grade_name == 'boss') then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.location)
                if dist <= 15 then
                    interval = 1
                    DrawMarker(1, v.location, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if dist <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le boss action "..v.label)
                        maj = v.maj
                        if IsControlJustPressed(1,51) then
                            if not v.illegal then
                                societyName = v.societyname
                                refreshmoney()
                                openMenuSociety(v.jobname)
                            else
                                societyName = v.societyname
                                refreshmoney(v.illegal)
                                openMenuSociety(v.jobname, v.illegal)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)