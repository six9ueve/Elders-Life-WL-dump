ESX = nil

PlayerData = {}
local jailTime = 0
local escape = 0
local box = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local function UnJail()
    InJail()
    ESX.Game.Teleport(PlayerPedId(), ConfigPrison["Exterieur"])
    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    ESX.ShowNotification("Vous êtes libéré, restez calme dehors! Bonne chance!")
end

local function UnJailEscape()
    local coord = GetEntityCoords(PlayerPedId())
    ESX.ShowNotification("Vous vous êtes évadé! Bonne chance!")
end

local function InJail()
    Citizen.CreateThread(function()

        while jailTime > 0 do
            jailTime = jailTime - 1
            ESX.ShowNotification("Il te reste " .. jailTime .. " minutes de prison!")
            TriggerServerEvent("eldersPrison:updateJailTime", jailTime)

            if jailTime == 0 and escape == 0 then
                UnJail()

                TriggerServerEvent("eldersPrison:updateJailTime", 0)
            end
            Citizen.Wait(60000)
        end
    end)
end

RMenu.Add("prison", "Menu_prison", RageUI.CreateMenu("Prison", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("prison", "Menu_prison").Closed = function()
    isMenuOpened = false
end

RMenu.Add("prison", "Magasin", RageUI.CreateMenu("Prison", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("prison", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("prison", "prisonnier", RageUI.CreateSubMenu(RMenu:Get("prison", "Menu_prison"), "Prison", "~b~Menu :"))
RMenu:Get("prison", "prisonnier").Closed = function()end

local function openJailMenu()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("prison", "Menu_prison"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("prison", "Menu_prison"),true,true,true,function()
                RageUI.ButtonWithStyle("Mettre en prison", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then 
                            local amount = KeyboardInput("Temps", "Minutes", "", 3)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                local amount2 = KeyboardInput("Raison", "Raison", "", 30)
                                if amount2 ~= nil then
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              
                                    if closestPlayer == -1 or closestDistance > 3.0 then
                                        ESX.ShowNotification("Personne autours!")
                                    else
                                        TriggerServerEvent("eldersPrison:jailPlayer", GetPlayerServerId(closestPlayer), amount, amount2)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end         
                                else
                                    ESX.ShowNotification("Raison invalide", 'Problème')
                                end 
                            else
                                ESX.ShowNotification("Temps invalide", 'Problème')
                            end  
                                
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Liberer la personne", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then 
                        prisonniers = {}
                        ESX.TriggerServerCallback("eldersPrison:retrieveJailedPlayers", function(playerArray)
                            prisonniers = playerArray
                        end)         
                    end
                end,RMenu:Get("prison", "prisonnier"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("prison", "prisonnier"),true,true,true,function()
                RageUI.Separator('↓ Prisonnier ↓')
                if prisonniers ~= nil then
                    for k, v in pairs(prisonniers) do
                        RageUI.ButtonWithStyle(v.lastname.." "..v.firstname.." reste : "..v.jail.." minutes", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("Liberer", "Liberer (OUI)", "", 3)
                                if amount == 'OUI' then
                                    TriggerServerEvent("eldersPrison:unJailPlayer", v.identifier)
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                else
                                    ESX.ShowNotification("Raison invalide", 'Problème')
                                end 
                            end
                        end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function Cutscene()
    DoScreenFadeOut(100)
    Citizen.Wait(250)

    TriggerEvent('skinchanger:getSkin', function(skin)
        if GetHashKey(GetEntityModel(PlayerPedId())) == -2044588471 then
            local clothesSkin = {
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 0, ['torso_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 57, ['pants_2'] = 2,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['shoes_1'] = 22, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                ['torso_1'] = 135, ['torso_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 33, ['pants_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['shoes_1'] = 52, ['shoes_2'] = 0,
                ['chain_1'] = 0, ['chain_2'] = 0,
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)

    Citizen.Wait(1000)

    DoScreenFadeIn(250)

    InJail()
end

RegisterNetEvent("eldersPrison:jailPlayer")
AddEventHandler("eldersPrison:jailPlayer", function(newJailTime)
    jailTime = newJailTime
    escape = 0

    Cutscene()
end)

RegisterNetEvent("eldersPrison:unJailPlayer")
AddEventHandler("eldersPrison:unJailPlayer", function()
    jailTime = 0

    UnJail()
end)

RegisterNetEvent("eldersPrison:unJailPlayerEscape")
AddEventHandler("eldersPrison:unJailPlayerEscape", function()
    jailTime = 0
    escape = 1

    UnJailEscape()
end)

RegisterNetEvent('eldersPrison:unJailPlayerEscapenotif')
AddEventHandler("eldersPrison:unJailPlayerEscapenotif", function()
    local PlayerData = ESX.GetPlayerData()
    local blip = nil

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~EVASION DE PRISON", "Evasion de prison\n~r~INTERVENTION DEMANDEE !", "CHAR_CALL911", 4)
    end

    if PlayerData.job.name == "sheriff" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~EVASION DE PRISON", "Evasion de prison\n~r~INTERVENTION DEMANDEE !", "CHAR_CALL911", 4)
    end
end)

RegisterNetEvent("elders_prison:reducetime")
AddEventHandler("elders_prison:reducetime", function()
    if jailTime > 3 then
        jailTime = jailTime - 2
        ESX.ShowNotification("Merci pour ton travail, ton temps de prison à été réduit de 2 minute!")
    end
end)


Citizen.CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Pid = GetPlayerServerId(PlayerId())
        local PedCoords = GetEntityCoords(Ped)
        local distancehangard = GetDistanceBetweenCoords(PedCoords, 1011.03, -3100.95, -38.99, true)
        local start = GetDistanceBetweenCoords(PedCoords, 402.91, -1000.63, -99.00, true)
            if distancehangard > 100 and jailTime > 0 and start > 100 then
                local DistanceCheck = GetDistanceBetweenCoords(PedCoords, 1692.65, 2561.82, 45.56, true)--300
                if DistanceCheck > 300 then
                    TriggerServerEvent("eldersPrison:unJailPlayerEscape",PlayerData, Pid)
                end
            end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    local repasse = false

    while true do
        interval = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "sheriff" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = ConfigPrison.points[1].gestion
                local distancePlayerMenu = #(plyCoords - pos)
                if distancePlayerMenu < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[1].gestion, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerMenu <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Menu Prison")
                        if IsControlJustPressed(1,51) then
                            openJailMenu()
                        end
                    end
                end
            end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos1 = ConfigPrison.points[2].champs
                local distancePlayerChamps = #(plyCoords - pos1)
                if distancePlayerChamps < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[2].champs, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerChamps <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au frigo")
                        if IsControlJustPressed(1,51) then
                            OpenMagasin_prison()
                        end
                    end
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos2 = ConfigPrison.points[3].lavage
                local distancePlayerLavage = #(plyCoords - pos2)
                if distancePlayerLavage < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[3].lavage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerLavage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour laver les pommes de terres")
                        if IsControlJustPressed(1,51) then
                            OpenLavage_patate()
                        end
                    end                    
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos3 = ConfigPrison.points[4].cuisson
                local distancePlayerCuisson = #(plyCoords - pos3)
                if distancePlayerCuisson < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[4].cuisson, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerCuisson <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour Cuire les pommes de terres")
                        if IsControlJustPressed(1,51) then
                            OpenCuisson_patate()
                        end
                    end                    
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos4 = ConfigPrison.points[5].vente
                local distancePlayerVente = #(plyCoords - pos4)
                if distancePlayerVente < 15 then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[5].vente, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerVente <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour Vendre les cornets de frites")
                        if IsControlJustPressed(1,51) then
                            TriggerServerEvent("elders_prison:startSell","Vente")
                        end
                    end                    
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos5 = ConfigPrison.points[6].repassage
                local distancePlayerFinRepassage = #(plyCoords - pos5)
                if distancePlayerFinRepassage < 15 and repasse and repassefin then
                    interval = 1
                    DrawMarker(22, ConfigPrison.points[6].repassage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerFinRepassage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter de repasser")
                        if IsControlJustPressed(1,51) then
                            repassefin = false
                            repasse = false
                            FinRepassage_prison()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos6 = ConfigPrison.points[6].repassage
                local distancePlayerRepassage = #(plyCoords - pos6)
                if distancePlayerRepassage < 15 and not repasse and not pliage and not nettoyage and not balayage then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[6].repassage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerRepassage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à repasser")
                        if IsControlJustPressed(1,51) then
                            repasse = true
                            repassefin = true
                            OpenRepassage_prison()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos7 = ConfigPrison.points[7].pliage
                local distancePlayerFinPliage = #(plyCoords - pos7)
                if distancePlayerFinPliage < 15 and pliage and pliagefin then
                    interval = 1
                    DrawMarker(22, ConfigPrison.points[7].pliage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerFinPliage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter de plier")
                        if IsControlJustPressed(1,51) then
                            pliagefin = false
                            pliage = false
                            FinPliage_prison()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos8 = ConfigPrison.points[7].pliage
                local distancePlayerPliage = #(plyCoords - pos8)
                if distancePlayerPliage < 15 and not pliage and not repasse and not nettoyage and not balayage then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[7].pliage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerPliage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à plier")
                        if IsControlJustPressed(1,51) then
                            pliage = true
                            pliagefin = true
                            StartPliage()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos8 = ConfigPrison.points[8].nettoyage
                local distancePlayerFinnettoyage = #(plyCoords - pos8)
                if distancePlayerFinnettoyage < 15 and nettoyage and nettoyagefin then
                    interval = 1
                    DrawMarker(22, ConfigPrison.points[8].nettoyage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerFinnettoyage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter de nettoyer")
                        if IsControlJustPressed(1,51) then
                            nettoyagefin = false
                            nettoyage = false
                            FinNettoyage_prison()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos9 = ConfigPrison.points[8].nettoyage
                local distancePlayerNettoyage = #(plyCoords - pos9)
                if distancePlayerNettoyage < 15 and not nettoyage and not repasse and not pliage and not balayage then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[8].nettoyage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerNettoyage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à nettoyer")
                        if IsControlJustPressed(1,51) then
                            nettoyage = true
                            nettoyagefin = true
                            StartNettoyage()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos10 = ConfigPrison.points[9].balayage
                local distancePlayerFinbalayage = #(plyCoords - pos10)
                if distancePlayerFinbalayage < 15 and balayage and balayagefin then
                    interval = 1
                    DrawMarker(22, ConfigPrison.points[9].balayage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerFinbalayage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter de balayer")
                        if IsControlJustPressed(1,51) then
                            balayagefin = false
                            balayage = false
                            FinBalayage_prison()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos11 = ConfigPrison.points[9].balayage
                local distancePlayerbalayage = #(plyCoords - pos11)
                if distancePlayerbalayage < 15 and not balayage and not repasse and not pliage and not nettoyage then
                    interval = 1
                    DrawMarker(22,  ConfigPrison.points[9].balayage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerbalayage <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à balayer")
                        if IsControlJustPressed(1,51) then
                            balayage = true
                            balayagefin = true
                            StartBalayage()
                            Citizen.Wait(500)
                        end
                    end                                        
                end
        Citizen.Wait(interval)
    end
end)

