ESX = nil

local isMenuOpened = false
local nom = ''
local prenom = ''
local date = ''
local sexe = ''
local mdp = ''

local result = {}
local resulttransa = {}
local argentsolde = 0
-- Pos pour blips
local ATMbanque = { 
    {x=150.266, y=-1040.203, z=29.374},
    {x=-1212.980, y=-330.841, z=37.787},
    {x=-2962.582, y=482.627, z=15.703},
    {x=-112.202, y=6469.295, z=31.626}, 
    {x=314.187, y=-278.621, z=54.170},
    {x=-351.534, y=-49.529, z=49.042},
    {x=1175.0643310547, y=2706.6435546875, z=38.094036102295},

    {x=89.75, y=2.35, z=68.31}, 
    {x=1167.02, y=-456.32, z=66.79},
    {x=-386.733, y=6045.953, z=31.501},
    {x=-284.037, y=6224.385, z=31.187},
    {x=-284.037, y=6224.385, z=31.187},
    {x=-135.165, y=6365.738, z=31.101},
    {x=-110.753, y=6467.703, z=31.784},
    {x=-94.9690, y=6455.301, z=31.784},
    {x=155.4300, y=6641.991, z=31.784},
    {x=174.6720, y=6637.218, z=31.784},
    {x=1703.138, y=6426.783, z=32.730},
    {x=1735.114, y=6411.035, z=35.164},
    {x=1702.842, y=4933.593, z=42.051},
    {x=1967.333, y=3744.293, z=32.272},
    {x=1821.917, y=3683.483, z=34.244},
    {x=1174.532, y=2705.278, z=38.027},
    {x=540.0420, y=2671.007, z=42.177},
    {x=2564.399, y=2585.100, z=38.016},
    {x=2558.683, y=349.6010, z=108.050},
    {x=2558.051, y=389.4817, z=108.660},
    {x=1077.692, y=-775.796, z=58.218},
    {x=1139.018, y=-469.886, z=66.789},
    {x=1168.975, y=-457.241, z=66.641},
    {x=1153.884, y=-326.540, z=69.245},
    {x=381.2827, y=323.2518, z=103.270},
    {x=236.4638, y=217.4718, z=106.840},
    {x=265.0043, y=212.1717, z=106.780},
    {x=285.2029, y=143.5690, z=104.970},
    {x=157.7698, y=233.5450, z=106.450},
    {x=-164.568, y=233.5066, z=94.919},
    {x=-1827.04, y=785.5159, z=138.020},
    {x=-1409.39, y=-99.2603, z=52.473},
    {x=-1205.35, y=-325.579, z=37.870},
    {x=-1215.64, y=-332.231, z=37.881},
    {x=-2072.41, y=-316.959, z=13.345},
    {x=-2975.72, y=379.7737, z=14.992},
    {x=-2962.60, y=482.1914, z=15.762},
    {x=-2955.70, y=488.7218, z=15.486},
    {x=-3044.22, y=595.2429, z=7.595},
    {x=-3144.13, y=1127.415, z=20.868},
    {x=-3241.10, y=996.6881, z=12.500},
    {x=-3241.11, y=1009.152, z=12.877},
    {x=-1305.40, y=-706.240, z=25.352},
    {x=-538.225, y=-854.423, z=29.234},
    {x=-711.156, y=-818.958, z=23.768},
    {x=-717.614, y=-915.880, z=19.268},
    {x=-526.566, y=-1222.90, z=18.434},
    {x=-256.831, y=-719.646, z=33.444},
    {x=-203.548, y=-861.588, z=30.205},
    {x=112.4102, y=-776.162, z=31.427},
    {x=112.9290, y=-818.710, z=31.386},
    {x=119.9000, y=-883.826, z=31.191},
    {x=149.4551, y=-1038.95, z=29.366},
    {x=-846.304, y=-340.402, z=38.687},
    {x=-1204.35, y=-324.391, z=37.877},
    {x=-1216.27, y=-331.461, z=37.773},
    {x=-56.1935, y=-1752.53, z=29.452},
    {x=-261.692, y=-2012.64, z=30.121},
    {x=-273.001, y=-2025.60, z=30.197},
    {x=314.187, y=-278.621, z=54.170},
    {x=-351.534, y=-49.529, z=49.042},
    {x=24.589, y=-946.056, z=29.357},
    {x=-254.112, y=-692.483, z=33.616},
    {x=-1570.197, y=-546.651, z=34.955},
    {x=-1415.909, y=-211.825, z=46.500},
    {x=-1430.112, y=-211.014, z=46.500},
    {x=33.232, y=-1347.849, z=29.497},
    {x=122.19, y=-1293.56, z=29.25},
    {x=287.645, y=-1282.646, z=29.659},
    {x=289.012, y=-1256.545, z=29.440},
    {x=295.839, y=-895.640, z=29.217},
    {x=1686.753, y=4815.809, z=42.008},
    {x=-302.408, y=-829.945, z=32.417},
    {x=5.134, y=-919.949, z=29.557},
    {x=214.83, y=-923.83, z=30.708},
    {x=211.90, y=-928.19, z=30.69},
    {x=218.34, y=-918.83, z=30.70},
    {x=-1391.06, y=-590.36, z=30.31},
    {x=239.47, y=-892.11, z=30.49},
    {x=242.55, y=-889.61, z=30.49},
    {x=-2293.86, y=359.81, z=174.60},
    {x=-2294.68, y=356.46, z=174.60},
    {x=-2295.37, y=358.08, z=174.60},
    {x=-914.05, y=-2026.04, z=9.40},
    {x=-821.65, y=-1081.91, z=11.13},
    {x=2683.08, y=3286.58, z=55.24},
    {x=-2524.04, y=2318.03, z=33.21},
    {x=-457.98, y=-326.30, z=34.50},
    {x=-37.90, y=-1115.26, z=26.43},
    {x=-527.78, y=-166.10, z=38.23},
    {x=-537.31, y=-171.60, z=38.21},
    {x=-577.07, y=-194.82, z=38.21},
}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
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

local function verifsolde()
    TriggerServerEvent("aBank:solde", action)
end


RMenu.Add("atmos", "creation", RageUI.CreateMenu("Banque", "~b~Crée toi un compte :", nil, nil, "aLib", "black"))
RMenu:Get("atmos", "creation").Closed = function()
	FreezeEntityPosition(PlayerPedId(), false)
	isMenuOpened = false
    nom = ''
    prenom = ''
    date = ''
    sexe = ''
    mdp = ''
end

RMenu.Add("atmos", "creationcompte", RageUI.CreateSubMenu(RMenu:Get("atmos", "creation"), "Création compte", "~b~Option :"))
RMenu:Get("atmos", "creationcompte").Closed = function()
    nom = ''
    prenom = ''
    date = ''
    sexe = ''
    mdp = ''
end

RMenu.Add("atmos", "info", RageUI.CreateMenu("Information compte", "~b~Options :", nil, nil, "aLib", "black"))
RMenu:Get("atmos", "info").Closed = function()
	FreezeEntityPosition(PlayerPedId(), false)
	isMenuOpened = false
end

RMenu.Add("atmos", "effacer", RageUI.CreateSubMenu(RMenu:Get("atmos", "info"), "Effacer compte", "~b~Option :"))
RMenu:Get("atmos", "effacer").Closed = function()
end

RMenu.Add("atmos", "transaction", RageUI.CreateSubMenu(RMenu:Get("atmos", "info"), "Transaction", "~b~Action effectué :"))
RMenu:Get("atmos", "transaction").Closed = function()
end

RMenu.Add("atmos", "atm", RageUI.CreateMenu("Information compte", "~b~Options :", nil, nil, "aLib", "black"))
RMenu:Get("atmos", "atm").Closed = function()
	FreezeEntityPosition(PlayerPedId(), false)
	isMenuOpened = false
end

RMenu.Add("atmos", "transactionatm", RageUI.CreateSubMenu(RMenu:Get("atmos", "atm"), "Transaction", "~b~Action effectué :"))
RMenu:Get("atmos", "transactionatm").Closed = function()
end

local function openMenucreation()
	
	FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

	RageUI.Visible(RMenu:Get("atmos","creation"), true)

	Citizen.CreateThread(function()
        while isMenuOpened do 
            RageUI.IsVisible(RMenu:Get("atmos","creation"),true,true,true,function()
                RageUI.Separator('↓ Bank ↓')
                RageUI.ButtonWithStyle("Crée un compte bancaire", nil, {}, true,function(a,h,s)
                end, RMenu:Get("atmos", "creationcompte"))
                RageUI.ButtonWithStyle("Annuler", nil, {}, true,function(a,h,s)
                    if s then
                        RageUI.CloseAll()
                        FreezeEntityPosition(PlayerPedId(), false)
                        isMenuOpened = false
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos",'creationcompte'),true,true,true,function()
                RageUI.ButtonWithStyle("Nom :", nil, {RightLabel = nom}, true,function(a,h,s)
                    if s then
                        nom = KeyboardInput("atmos", "Nom :", "", 9)
                    end
                end)
                RageUI.ButtonWithStyle("Prénom :", nil, {RightLabel = prenom}, true,function(a,h,s)
                    if s then
                        prenom = KeyboardInput("atmos", "Prénom :", "", 9)
                    end
                end)
                RageUI.ButtonWithStyle("Date de naissance :", nil, {RightLabel = date}, true,function(a,h,s)
                    if s then
                        date = KeyboardInput("atmos", "Date de naissance :", "", 10)
                    end
                end)
                RageUI.ButtonWithStyle("Sexe :", nil, {RightLabel = sexe}, true,function(a,h,s)
                    if s then
                        sexe = KeyboardInput("atmos", "Sexe :", "", 1)
                    end
                end)
                RageUI.ButtonWithStyle("Mot de passe :", nil, {RightLabel = mdp}, true,function(a,h,s)
                    if s then
                        mdp = KeyboardInput("atmos", "Mot de passe :", "", 9)
                    end
                end)
                RageUI.ButtonWithStyle("~g~Confirmer la création", nil, {}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent("aBank:ajoutcompte", nom, prenom, date, sexe, mdp)
                        ESX.ShowNotification("Création du compte ~g~effectué~s~ !")
                        RageUI.CloseAll()
                        FreezeEntityPosition(PlayerPedId(), false)
                        isMenuOpened = false
                    end
                end)
                RageUI.ButtonWithStyle("~r~Annuler la création", nil, {}, true,function(a,h,s)
                    if s then
                        RageUI.CloseAll()
                        FreezeEntityPosition(PlayerPedId(), false)
                        isMenuOpened = false
                        nom = ''
                        prenom = ''
                        date = ''
                        sexe = ''
                        mdp = ''
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenubanque()
	
	FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

	RageUI.Visible(RMenu:Get("atmos","info"), true)

	Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("atmos","info"),true,true,true,function()
                for selected = 1, #result, 1 do
                    RageUI.Separator("~r~→ ~s~Numéro de compte : ~g~"..result[selected].Ncompte.." ~r~←")
                    RageUI.Separator("~r~→ ~s~Solde bancaire : ~g~"..ESX.Math.GroupDigits(argentsolde).." $ ~r~←")
                    RageUI.Separator('↓ Transferts ↓')
                    RageUI.ButtonWithStyle("Depôt", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local depot = KeyboardInput("atmos", "Montant du depôt !", "", 10)
                            if depot ~= nil then
                                depot = tonumber(depot)
                                if type(depot) == 'number' then
                                    TriggerServerEvent('aBank:depot', depot)
                                    local minute = GetClockMinutes()
                                    local hours = GetClockHours()
                                    local tiepe = 'Dépot'
                                    TriggerServerEvent('aBank:updatehistorique', GetPlayerServerId(playerPed), hours, minute, tiepe, depot)
                                    verifsolde()
                                end
                            else
                                ESX.ShowNotification("Montant invalide !", "error")
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Retrait", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_billing:hasTooManyBills', function(hasTooManyBills)
                                if hasTooManyBills then
                                    ESX.ShowNotification('~r~La banque vous interdit les retraits avec autant de facture impayé !')
                                return
                                end
                                    local retrait = KeyboardInput("atmos", "Montant du retrait !", "", 6)
                                    if retrait ~= nil then
                                        retrait = tonumber(retrait)
                                        if type(retrait) == 'number' then
                                            TriggerServerEvent('aBank:retrait', retrait)
                                            local minute = GetClockMinutes()
                                            local hours = GetClockHours()
                                            local tiepe = 'Retrait'
                                            TriggerServerEvent('aBank:updatehistorique', GetPlayerServerId(playerPed), hours, minute, tiepe, retrait)
                                            verifsolde()
                                        end
                                    else
                                        ESX.ShowNotification("Montant invalide !", "error")
                                    end
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Faire un virement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_billing:hasTooManyBills', function(hasTooManyBills)
                                if hasTooManyBills then
                                    ESX.ShowNotification('~r~La banque vous interdit les retraits avec autant de facture impayé !')
                                return
                                end
                                local ncompte = KeyboardInput("atmos", "ID (joueur en ligne)", "", 8)
                                if ncompte ~= nil then
                                    ncompte = tonumber(ncompte)
                                    if type(ncompte) == 'number' then
                                        local montant = KeyboardInput("atmos", "Montant du retrait !", "", 6)
                                        if montant ~= nil then
                                            montant = tonumber(montant)
                                            if type(montant) == 'number' then
                                                TriggerServerEvent("aBank:verifvirement", ncompte, montant)
                                                verifsolde()
                                            end
                                        else
                                            ESX.ShowNotification("Montant invalide !", "error")
                                        end
                                    end
                                else
                                    ESX.ShowNotification("Numéro de compte invalide !", "error")
                                end
                            end)
                        end
                    end)
                    RageUI.Separator('↓ Options du compte ↓')
                    RageUI.ButtonWithStyle("Crée une carte bancaire", nil, {RightLabel = "~r~"..Configbanque.prixcarte.. " $"}, true,function(a,h,s)
                        if s then
                            TriggerServerEvent('aBank:creecarte')
                        end
                    end)
                    RageUI.ButtonWithStyle("Modifier mot de passe", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local confirmer = KeyboardInput("atmos", "Veuillez confirmez l'ancien mot de passe !", "", 9)
                            if confirmer == result[selected].Password then
                                local nouveaumdp = KeyboardInput("atmos", "Veuillez saisir nouveau mot de passe !", "", 9)
                                if nouveaumdp ~= result[selected].Password then
                                    TriggerServerEvent('aBank:nouveaumdp', nouveaumdp)
                                    ESX.ShowNotification("Changement de mot de passe éffectué !", "success")
                                else
                                    ESX.ShowNotification("Veuillez choisir un mot de passe différent !", "error")
                                end
                            else
                                ESX.ShowNotification("Mot de passe incorect !", "error")
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Historique des transactions", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('abank:infotransa', function(keys)
                                resulttransa = keys
                            end)
                        end
                    end,RMenu:Get("atmos","transaction"))   
                    RageUI.ButtonWithStyle("~r~Effacer compte bancaire", "Cette action est irréversible", {RightBadge = RageUI.BadgeStyle.Alert}, true,function(a,h,s)
                    end, RMenu:Get("atmos", "effacer"))                
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","effacer"),true,true,true,function()
                RageUI.Separator('↓ Confirmation ↓')
                RageUI.ButtonWithStyle("~g~Validé", nil, {}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('aBank:deletetransa', GetPlayerServerId())
                        TriggerServerEvent('aBank:deletecompte', GetPlayerServerId())
                        ESX.ShowNotification("Suppression du compte éffectué !", "success")
                        RageUI.CloseAll()
                        isMenuOpened = false
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)
                RageUI.ButtonWithStyle("~r~Annuler", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("atmos", "info"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","transaction"),true,true,true,function()
                RageUI.Separator('↓ Transactions ↓')
                for selected = 1, #resulttransa, 1 do
                    RageUI.ButtonWithStyle("["..resulttransa[selected].id.."] ~b~"..resulttransa[selected].type.. " ~s~effectué à "..resulttransa[selected].Heure..":"..resulttransa[selected].Minutes.." de ~g~"..resulttransa[selected].Montant.. " $", nil, {}, true,function(a,h,s)end)
                end
                RageUI.ButtonWithStyle("~r~Vider les transactions", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('aBank:deletetransa')
                        RageUI.CloseAll()
                        FreezeEntityPosition(PlayerPedId(), false)
                        isMenuOpened = false
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
        for k in pairs(Configbanque.points) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Configbanque.points[k].x, Configbanque.points[k].y, Configbanque.points[k].z)
            if dist < 10 then
                interval = 1
                DrawMarker(1, Configbanque.points[k].x, Configbanque.points[k].y, Configbanque.points[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                if dist <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accèder à la banque")
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('abank:verifcompte', function(compte)
                            if not compte then
                                openMenucreation()
                            else
                                ESX.TriggerServerCallback('abank:info', function(keys)
                                    openMenubanque()
                                    verifsolde()
                                    result = keys
                                end)
                            end
                        end)
                    end
                end
            end
        end
    Citizen.Wait(interval)
    end
end)

-- fonction atm

local function openMenuatm()
	
	FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

	RageUI.Visible(RMenu:Get("atmos","atm"), true)

	Citizen.CreateThread(function()
        while isMenuOpened do
            for selected = 1, #result, 1 do
                RageUI.IsVisible(RMenu:Get("atmos","atm"),true,true,true,function()
                    RageUI.Separator("~r~→ ~s~Numéro de compte : ~g~"..result[selected].Ncompte.." ~r~←")
                    RageUI.Separator("~r~→ ~s~Solde bancaire : ~g~"..ESX.Math.GroupDigits(argentsolde).." $ ~r~←")
                    RageUI.Separator('↓ Transfert ↓')
                    RageUI.ButtonWithStyle("Retrait", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local retrait = KeyboardInput("atmos", "Montant du retrait !", "", 6)
                            if retrait ~= nil then
                                retrait = tonumber(retrait)
                                if type(retrait) == 'number' then
                                    TriggerServerEvent('aBank:retrait', retrait)
                                    local minute = GetClockMinutes()
                                    local hours = GetClockHours()
                                    local tiepe = 'Retrait'  
                                    TriggerServerEvent('aBank:updatehistorique', GetPlayerServerId(playerPed), hours, minute, tiepe, retrait)  
                                    verifsolde()
                                end
                            else
                                ESX.ShowNotification("Montant invalide !", "error")
                            end
                        end
                    end)
                    RageUI.Separator('↓ Option du compte ↓')
                    RageUI.ButtonWithStyle("Historique de transaction", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then 
                            ESX.TriggerServerCallback('abank:infotransa', function(keys)
                                resulttransa = keys
                            end)
                        end
                    end, RMenu:Get("atmos", "transactionatm"))
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get("atmos","transactionatm"),true,true,true,function()
                    RageUI.Separator('↓ Transactions ↓')
                    for selected = 1, #resulttransa, 1 do
                        RageUI.ButtonWithStyle("["..resulttransa[selected].id.."] ~b~"..resulttransa[selected].type.. " ~s~effectué à "..resulttransa[selected].Heure..":"..resulttransa[selected].Minutes.." de ~g~"..resulttransa[selected].Montant.. " $", nil, {}, true,function(a,h,s)end)
                    end
                    RageUI.ButtonWithStyle("~r~Vider les transactions", nil, {}, true,function(a,h,s)
                        if s then
                            TriggerServerEvent('aBank:deletetransa')
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false)
                            isMenuOpened = false
                        end
                    end)
                end, function()end, 1)
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent('aBank:atm')
AddEventHandler('aBank:atm', function(id)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    error = true
    for k, v in pairs(ConfigATMBank) do
        local hash = GetHashKey(v)
        local atm = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 2.0)
        if atm then 
            error = false
            ESX.TriggerServerCallback('abank:info', function(keys)
            result = keys
            end)
            for selected = 1, #result, 1 do
                local mdp = KeyboardInput("atmos", "Saisir mot de passe !", "", 9)
                if mdp ~= result[selected].Password then
                    ESX.ShowNotification("Mot de passe incorrect !", "error")
                else
                    openMenuatm()
                    verifsolde()
                end
            end
        end
    end
    if error == true then
        ESX.ShowNotification("Vous ne pouvez pas utiliser la carte sans ATM !", "error")
    end
end) 

RegisterNetEvent("aBank:solderefresh")
AddEventHandler("aBank:solderefresh", function(money, cash)
    argentsolde = tonumber(money)
end)

Citizen.CreateThread(function()
    for k,v in pairs(Configbanque.points) do
        local kblip = AddBlipForCoord(Configbanque.points[k].x, Configbanque.points[k].y, Configbanque.points[k].z)
        SetBlipSprite (kblip, 434)
        SetBlipDisplay(kblip, 4)
        SetBlipScale  (kblip, 0.6)
        SetBlipColour (kblip, 17)
        SetBlipAsShortRange(kblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Banques")
        EndTextCommandSetBlipName(kblip)
    end
end)

RegisterNetEvent("aBank:registernewvirement")
AddEventHandler("aBank:registernewvirement", function(montant)
    local minute = GetClockMinutes()
    local hours = GetClockHours()
    local tiepe = 'Virement'
    TriggerServerEvent('aBank:updatehistorique', GetPlayerServerId(playerPed), hours, minute, tiepe, montant)
end)