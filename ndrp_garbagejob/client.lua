local truckplate = false
local truckcoords
local inTruck
local missionBlip = nil
local binCoords = false
local maxruns = 0
local runs = 0
local arrived 
local jobBlip
local submitBlip
ESX = nil
local submitCoords = vector3(-354.28,-1560.88,24.9)
local clockRoom = vector3(-321.70, -1545.94, 31.02)
local stopjob = vector3(-316.53, -1536.58, 27.70)
local doingGarbage = false
local jobCompleted = false
local garbageHQBlip = 0
local truckTaken = false

local JobCoords = {
    {x = 114.83280181885, y = -1462.3127441406, z = 29.295083999634},
    {x = -6.0481648445129, y = -1566.2338867188, z = 29.209197998047},
    {x = -1.8858588933945, y = -1729.5538330078, z = 29.300233840942},
    {x = 159.09, y = -1816.69, z = 27.9},
    {x = 358.94696044922, y = -1805.0723876953, z = 28.966590881348},
    {x = 481.36560058594, y = -1274.8297119141, z = 29.64475440979},
    {x = 254.70010375977, y = -985.32482910156, z = 29.196590423584},
    {x = 240.08079528809, y = -826.91204833984, z = 30.018426895142},
    {x = 342.78308105469, y = -1036.4720458984, z = 29.194206237793},
    {x = 462.17517089844, y = -949.51434326172, z = 27.959424972534},
    {x = 317.53698730469, y = -737.95416259766, z = 29.278547286987},
    {x = 410.22503662109, y = -795.30517578125, z = 29.20943069458},
    {x = 398.36038208008, y = -716.35577392578, z = 29.282489776611},
    {x = 443.96984863281, y = -574.33978271484, z = 28.494501113892},
    {x = -1332.53, y = -1198.49, z = 4.62},
    {x = -45.443946838379, y = -191.32261657715, z = 52.161594390869},
    {x = -31.948055267334, y = -93.437454223633, z = 57.249073028564},
    {x = 283.10873413086, y = -164.81878662109, z = 60.060565948486},
    {x = 441.89678955078, y = 125.97653198242, z = 99.887702941895},
}

local Dumpsters = {
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_3a",
    "prop_dumpster_4a",
    "prop_dumpster_4b",
    "prop_skip_01a",
    "prop_skip_02a",
    "prop_skip_06a",
    "prop_skip_05a",
    "prop_skip_03",
    "prop_skip_10a"
}


-- Make player look like a worker

function LoadWorkPlayerSkin()
	
	local playerPed = PlayerPedId() 
	TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then				
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['eboueur'].male)				
			else		
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['eboueur'].female)
			end
	end)
end

-- Load the default player skin (for god_skin)

function LoadDefaultPlayerSkin()
	ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, jobSkin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

--[[RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)]]--

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'garbage' then
            havingGarbageJob = true
            if garbageHQBlip == nil or garbageHQBlip == 0 then
                garbageHQBlip = AddBlipForCoord(clockRoom)
                SetBlipSprite(garbageHQBlip, 467)
                SetBlipDisplay(garbageHQBlip, 4)
                SetBlipScale(garbageHQBlip, 0.6)
                SetBlipColour(garbageHQBlip, 25)
                SetBlipAsShortRange(garbageHQBlip, false)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Centre poubelle")
                EndTextCommandSetBlipName(garbageHQBlip)
            end    
        else
            havingGarbageJob = false
            if garbageHQBlip ~= nil or garbageHQBlip ~= 0 then
                RemoveBlip(garbageHQBlip)
                garbageHQBlip = 0
            end
        end
    end
end)

Citizen.CreateThread(function() 
    local wait = 100
    while true do 
        Citizen.Wait(wait)
        if havingGarbageJob then
            local playerPed = PlayerPedId() 
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords, clockRoom, true)
            local vehicleCoords = vector3(-321.60, -1525.44, 27.70)
            local heading = 269.7
            if distance < 20 then
                wait = 5
                DrawMarker(2, clockRoom, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Pressez ~INPUT_CONTEXT~ pour démarrer le job", true, true, 5000)
                    if IsControlJustReleased(1,46) then
                        if not truckTaken then 
                            if ESX.Game.IsSpawnPointClear(vehicleCoords, 5) then
                                LoadWorkPlayerSkin()
                                truckTaken = true
                                local random = math.random(1, #JobCoords)
                                local coordVec = vector3(JobCoords[random].x, JobCoords[random].y, JobCoords[random].z)
                                inTruck = false
                                ESX.Game.SpawnVehicle("trash", vehicleCoords, heading , function(vehicle)
                                    truckplate = GetVehicleNumberPlateText(vehicle)
                                    truckcoords = GetEntityCoords(vehicle)
                                    SetVehicleDoorsLocked(vehicle, 0)
                                    Citizen.CreateThread(function() 
                                        while not inTruck do 
                                            Citizen.Wait(5)
                                            DrawMarker(2, truckcoords + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                                            if IsPedInAnyVehicle(PlayerPedId() ) then
                                                local truck = GetVehiclePedIsIn(PlayerPedId() ,false)
                                                if truck == vehicle then
                                                    inTruck = true
                                                    Citizen.Wait(1000)
                                                    missionStart(coordVec,vehicle)
                                                end
                                            end
                                        end
                                    end)
                                end)
                            else
                                ESX.ShowAdvancedNotification('EldersLife', 'Interim', 'Point de spawn occupé...', 'CHAR_ELDERS', 10)
                            end
                        else
                                ESX.ShowAdvancedNotification('EldersLife', 'Interim', 'Vous avez déjà pris un camion pour le job', 'CHAR_ELDERS', 10)
                        end
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function() 
    local wait = 100
    while true do 
        Citizen.Wait(wait)
        if havingGarbageJob then
            local playerPed = PlayerPedId() 
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords, stopjob, true)
            local truckin = GetVehiclePedIsIn(PlayerPedId() ,false)
            local platein = GetVehicleNumberPlateText(truckin)
            if distance < 20 and truckTaken then
                wait = 5
                DrawMarker(2, stopjob, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Pressez ~INPUT_CONTEXT~ pour arréter le job", true, true, 5000)
                    if IsControlJustReleased(1,46) then
                        if platein == truckplate then 
                            ESX.Game.DeleteVehicle(truckin)
                            truckTaken = false
                            for i=1,200,1 do 
                                if DoesEntityExist(truckin) then
                                    ESX.Game.DeleteVehicle(truckin)
                                else
                                    truckplate = false
                                    truckTaken = false
                                end
                            end
                            Citizen.Wait(1000)
                            SetBlipRoute(missionBlip, false)
                            RemoveBlip(missionBlip)
                            ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0
                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                                        TriggerEvent('skinchanger:loadSkin', skin)
                                        TriggerEvent('god:restoreLoadout')
                                    end)
                                end)
                            end)
                        else
                            ESX.ShowAdvancedNotification('EldersLife', 'Interim', 'Vous n\'etes pas dans votre camion poubelle', 'CHAR_ELDERS', 10)
                        end
                    end
                end
            end
        end
    end
end)

function submit()
    Citizen.CreateThread(function()
        local pressed = false
        local wait = 100
        while true do
            Citizen.Wait(wait)
            local playerPed = PlayerPedId() 
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords,submitCoords, true) 
            if distance < 20 then
                wait = 5
                if IsPedInAnyVehicle(playerPed) then
                    DrawMarker(2, submitCoords+vector3(0.0,0.0,2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                    local truck = GetVehiclePedIsIn(playerPed, false)
                    local plate = GetVehicleNumberPlateText(truck)
                    if distance < 2.0 then
                        ESX.ShowHelpNotification("Pressez ~INPUT_CONTEXT~ pour vider les poubelles", true, true, 5000)
                        if IsControlJustReleased(1,46) and not pressed then
                            truckTaken = false
                            pressed = true
                            RemoveBlip(submitBlip)
                            --LoadDefaultPlayerSkin()
                            if plate == truckplate then
                                jobCompleted = true
                                exports['progressBars']:startUI(5000, "Vidange en cours...")
                                Citizen.Wait(5000)
                                TriggerServerEvent('ndrp-garbage:pay',jobCompleted)
                                ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, jobSkin)
                                    local isMale = skin.sex == 0
                                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                        ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                                            TriggerEvent('skinchanger:loadSkin', skin)
                                            TriggerEvent('god:restoreLoadout')
                                        end)
                                    end)
                                end)
                                jobCompleted = false
                                ESX.Game.DeleteVehicle(truck)
                                for i=1,200,1 do 
                                    if DoesEntityExist(truck) then
                                        ESX.Game.DeleteVehicle(truck)
                                    else
                                        truckplate = false
                                        truckTaken = false
                                        return
                                    end
                                end
                                truckplate = false
                                Citizen.Wait(1000)
                                pressed = false    
                                return
                            else
                                ESX.ShowAdvancedNotification('EldersLife', 'Interim', 'Erreur, ce n\'est pas notre véhicule...', 'CHAR_ELDERS', 10)
                                Citizen.Wait(1000)
                                pressed = false
                            end
                            Citizen.Wait(1000)
                            pressed = false
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end)
end

function missionStart(coordVec,xtruck)
    local vehicle = xtruck
    arrived = false
    missionBlip = AddBlipForCoord(coordVec)
    SetBlipRoute(missionBlip, true)
    SetBlipRouteColour(missionBlip, 25)
    SetBlipColour(missionBlip, 25)
    Citizen.CreateThread(function()
        local wait = 100
        while not arrived do
            Citizen.Wait(wait)
            local tempdist = GetDistanceBetweenCoords(coordVec, GetEntityCoords(PlayerPedId() ),true)
            if  tempdist < 50 then
                wait = 5
                DrawMarker(20, coordVec + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                if tempdist < 2 then
                    arrived = true
                    maxruns  = math.random(6,10)
                    Citizen.Wait(1000)
                    SetBlipRoute(missionBlip, false)
                    RemoveBlip(missionBlip)
                    findtrashbins(coordVec,vehicle,0)
                end
            else
                wait = 100
            end
        end
    end)      
end

function findtrashbins(coordVec,xtruck,pickup)
    doingGarbage = true
    local location = coordVec
    local vehicle = xtruck
    local playerPed = PlayerPedId() 
    local boneindex = GetPedBoneIndex(playerPed, 57005)
    runs = pickup

    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
        RequestAnimDict("anim@heists@narcotics@trash")
    end
    while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
        Citizen.Wait(0)
    end

    if runs < maxruns then
        angle = math.random()*math.pi*2;
        r = math.sqrt(math.random());
        x = coordVec.x + r * math.cos(angle) * 100;     
        y = coordVec.y + r * math.sin(angle) * 100;
        for i = 0, #Dumpsters, 1 do 
            local NewBin = GetClosestObjectOfType(x, y, coordVec.z, 100.0, GetHashKey(Dumpsters[i]), false)
            if NewBin ~= 0 then
                local dumpCoords = GetEntityCoords(NewBin)
                jobBlip = AddBlipForCoord(dumpCoords)
                SetBlipSprite(jobBlip, 420)
                SetBlipScale (jobBlip, 0.6)
                SetBlipColour(jobBlip, 25)
                while true do
                    Wait(5) 
                    local userDist = GetDistanceBetweenCoords(dumpCoords,GetEntityCoords(PlayerPedId() ),true) 
                    if userDist < 20 then
                        DrawMarker(20, dumpCoords + vector3(0.0,0.0,2.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                        if userDist < 2 then
                            ESX.ShowHelpNotification("Pressez ~INPUT_CONTEXT~ pour prendre la poubelle", true, true, 5000)
                            if IsControlJustReleased(1,46) then
                                local geeky = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(geeky, playerPed, boneindex, 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
                                TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
                                RemoveBlip(jobBlip)
                                collectedtrash(geeky,vehicle,location,runs)
                                return
                            end
                        end
                    end
                end
                return
            end
        end
    else
        submit()
        doingGarbage = false
        ESX.ShowAdvancedNotification('EldersLife', 'Interim', 'Job terminé, retournez au centre vider le camion', 'CHAR_ELDERS', 10)
        submitBlip = AddBlipForCoord(submitCoords)
        SetBlipColour(submitBlip, 25)
    end
end

local trashCollected = false

function collectedtrash(geeky,vehicle,location,pickup)
    local wait = 100
    local trashbag = geeky
    local pressed = false
    while true do
        Wait(wait)
        local trunkcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "platelight"))
        local tdistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId() ),trunkcoord)
        local runs = pickup
        if tdistance < 20 then
            wait = 5
            DrawMarker(20, trunkcoord + vector3(0.0,0.0,0.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if tdistance < 2 then
                ESX.ShowHelpNotification("Pressez ~INPUT_CONTEXT~ pour jeter la poubelle", true, true, 5000)
                if IsControlJustReleased(1, 46) and not pressed then
                    pressed = true
                    local dropChance = math.random(1,4)
                    ClearPedTasksImmediately(PlayerPedId() )
					TaskPlayAnim(PlayerPedId() , 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
                    Citizen.Wait(100)
                    DeleteObject(trashbag)
                    Citizen.Wait(3000)
                    ClearPedTasksImmediately(PlayerPedId() )
                    findtrashbins(location,vehicle,runs+1)
                    pressed = false
                    return
                end
            end
        end
    end
end