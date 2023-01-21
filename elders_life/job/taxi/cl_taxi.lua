ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local statusJob = {
    [true] = "~g~Activer~s~",
    [false] = "~r~Désactiver~s~",
}
local missionTotal    = 0
local statusMission   = false
local missionBlip     = nil 
local zoneActualPoint = 0 
local point           = -1


function IsInAuthorizedVehicle()
    local playerPed = PlayerPedId()
    local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

    for i = 1, #ConfigTaxi.vehicule, 1 do
        if vehModel == GetHashKey(ConfigTaxi.vehicule[i].name) then
            return true
        end
    end
    
    return false
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
AddEventHandler('god:setjob2', function(job2)
  ESX.PlayerData.job2 = job2
end)

RMenu.Add("taxi", "princ", RageUI.CreateMenu("DownTown Taxi", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("taxi", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("taxi", "vestiaire", RageUI.CreateMenu("DownTown Taxi", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("taxi", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("taxi", "mixo", RageUI.CreateSubMenu(RMenu:Get("taxi", "princ"), "DownTown Taxi", "~b~Menu job :"))
RMenu:Get("taxi", "mixo").Closed = function()end

RMenu.Add("taxi", "palpe", RageUI.CreateSubMenu(RMenu:Get("taxi", "princ"), "DownTown Taxi", "~b~Menu job :"))
RMenu:Get("taxi", "palpe").Closed = function()end

RMenu.Add("taxi", "changetenue", RageUI.CreateSubMenu(RMenu:Get("taxi", "vestiaire"), "DownTown Taxi", "~b~Menu job :"))
RMenu:Get("taxi", "changetenue").Closed = function()end

RMenu.Add("taxi", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("taxi", "vestiaire"), "DownTown Taxi", "~b~Menu job :"))
RMenu:Get("taxi", "deletetenue").Closed = function()end

local function openMenutaxiF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("taxi", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("taxi", "princ"),true,true,true,function()
                RageUI.Separator('~y~↓ Annonces ↓')
                RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('god_taxijob:Perso',msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_taxijob:Ouverture')
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_taxijob:Fermeture')
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('god_taxijob:recrutement')
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                end)    
                RageUI.Separator("~y~↓↓ ~s~Information ~y~↓↓~s~")
                RageUI.Separator((" ~r~> ~s~Statut Mission : %s"):format (statusJob[statusMission]))
                RageUI.Separator((" ~r~> ~s~ Checkpoint validés : ~g~%s~s~"):format(missionTotal))
                if IsInAuthorizedVehicle() then
                    if statusMission then
                        RageUI.ButtonWithStyle("~r~> ~s~Désactiver les missions", nil, {RightLabel = "→→→"}, true,function(a,h,s)                    
                                if s then
                                    TriggerServerEvent("Elderslife:eventMission", false)
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                end                            
                        end) 
                    else 
                        RageUI.ButtonWithStyle("~r~> ~s~Activer les missions", nil, {RightLabel = "→→→"}, true,function(a,h,s)                    
                                if s then
                                    TriggerServerEvent("Elderslife:eventMission", true)
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                end                            
                        end) 
                    end 
                else
                    RageUI.ButtonWithStyle("~r~> ~s~Activer les missions", nil, {RightLabel = "→→→"}, true,function(a,h,s)                    
                                if s then
                                    ESX.ShowAdvancedNotification('Elders Life', '~b~Taxi DownTown', 'Vous n\'etes pas dans un taxi !', 'CHAR_ELDERS', 10)
                                end                            
                    end)        
                end                         
                RageUI.Separator('~y~↓↓~s~ Citoyen ~y~↓↓~s~')
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    taxiinteract = true else taxiinteract = false
                end   
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, taxiinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_taxi', 'taxi', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenutaxiVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("taxi", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("taxi", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigTaxi.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, ConfigTaxi.uniform_female)
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
                end, RMenu:Get("taxi", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("taxi", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("taxi", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("taxi", "deletetenue"),true,true,true,function()
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
        for k, v in pairs(ConfigTaxi.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "taxi" and ESX.PlayerData.job2.name == "taxi" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenutaxiVestiaire()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('taxi', function()
    if ESX.PlayerData.job.name == "taxi" or ESX.PlayerData.job2.name == "taxi" then
        openMenutaxiF6()
    end
end)

RegisterKeyMapping('taxi', 'Menu Job : taxi', 'keyboard', 'F6')

RegisterNetEvent("Elderslife:refreshTotalCourse")
AddEventHandler("Elderslife:refreshTotalCourse", function()
    missionTotal = (missionTotal + 1)
end)

RegisterNetEvent("Elderslife:eventMission")
AddEventHandler("Elderslife:eventMission", function(status)
    statusMission = status

    if statusMission == false then
        Citizen.Wait(500)
        if DoesBlipExist(missionBlip) then
            RemoveBlip(missionBlip)
            missionBlip = nil
        end
        zoneActualPoint = 0
        point = -1        
    end

    Citizen.CreateThread(function()
        while statusMission do
            Citizen.Wait(1)
            if IsInAuthorizedVehicle() then
                local playerPos = GetEntityCoords(PlayerPedId())
                
                local zoneSelected = (zoneActualPoint + 1)

                if MissionTaxi[zoneSelected] == nil then
                    if DoesBlipExist(missionBlip) then
                        RemoveBlip(missionBlip)
                        missionBlip = nil
                    end
                    ESX.ShowNotification("~r~Vous avez fini votre parcours de mission !")

                    statusMission = false
                    zoneActualPoint = 0
                    point = -1
                else
                    if zoneActualPoint ~= point then
                        if DoesBlipExist(missionBlip) then
                            RemoveBlip(missionBlip)
                            missionBlip = nil
                        end

                        missionBlip = AddBlipForCoord(MissionTaxi[zoneSelected].pos)
                        SetBlipRoute(missionBlip, true)

                        point = zoneActualPoint
                    end

                    local distanceZonePlayer = #(MissionTaxi[zoneSelected].pos-playerPos)

                    if distanceZonePlayer <= 75 then
                        local veh = GetVehiclePedIsUsing(PlayerPedId())
                        local t1, t2, t3 = table.unpack(MissionTaxi[zoneSelected].marker.markerTaille)
                        local r, g, b, o = table.unpack(MissionTaxi[zoneSelected].marker.markerColor)
                        DrawMarker(MissionTaxi[zoneSelected].marker.markerType, MissionTaxi[zoneSelected].pos.x, MissionTaxi[zoneSelected].pos.y, MissionTaxi[zoneSelected].pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, t1, t2, t3, r, g, b, o, false, true, 2, false, false, false, false)
                        if distanceZonePlayer <= MissionTaxi[zoneSelected].radius and GetEntitySpeed(veh) < 4 then
                            ESX.ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ ~g~valider ~y~le Check Point ~s~!")
                            if IsControlJustPressed(0, 51) then
                                MissionTaxi[zoneSelected].callback()
                                zoneActualPoint = (zoneActualPoint + 1)
                            end
                        end
                    end
                end
            else
                if DoesBlipExist(missionBlip) then
                    RemoveBlip(missionBlip)
                    missionBlip = nil
                end
        
                point = -1
                statusMission = false
                ESX.ShowNotification("~r~Merci d'etre dans un vehicule de l'entreprise")
            end
        end
    end)
end)

RegisterCommand("debugtaxi", function()
    statusMission = false
    TriggerServerEvent("Elderslife:eventMission", false)
    if DoesBlipExist(missionBlip) then
        RemoveBlip(missionBlip)
        missionBlip = nil
    end
    zoneActualPoint = 0
    point = -1
end)