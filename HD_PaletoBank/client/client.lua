ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local PlayerData = nil



RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)

local totalS = 0

local Picks = {}
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.CreateThread(function()
            ApplyDoorLock(1)
            ApplyDoorLock(2)
            ApplyDoorLock(3)
            RequestAnimDict('mp_arresting')
            RequestAnimDict('anim@amb@business@coc@coc_unpack_cut_left@')
            RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
            RequestModel('prop_c4_final')
            RequestModel(Config.GuardModel)

            for i = 1, #Config.MapBlips, 1 do
                if Config.MapBlips[i].Active then
                    local blip1 = AddBlipForCoord(Config.MapBlips[i].Loc.x, Config.MapBlips[i].Loc.y, Config.MapBlips[i].Loc.z)
                    SetBlipSprite(blip1, Config.MapBlips[i].Sprite)
                    SetBlipScale(blip1, 0.9)
                    SetBlipColour(blip1, Config.MapBlips[i].Color)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(Config.MapBlips[i].Name)
                    EndTextCommandSetBlipName(blip1)
                    SetBlipAsShortRange(blip1, true)
                end
            end

            for i = 1, #Config.Deposits, 1 do
                table.insert(Picks, false)
            end
            Citizen.Wait(1500)
            if Config.Guards then
                for i = 1, #Config.GuardLocs, 1 do
                    local guard = CreatePed(7, Config.GuardModel, Config.GuardLocs[i].Location.x, Config.GuardLocs[i].Location.y, Config.GuardLocs[i].Location.z, Config.GuardLocs[i].Heading, true, true)
                    PlaceObjectOnGroundProperly(guard)
                    SetEntityAsMissionEntity(guard)
                    GiveWeaponToPed(guard, GetHashKey(Config.GuardWeapon), 250, false, true)
                    SetPedAccuracy(guard, Config.GuardAccuracy)
                    SetPedDropsWeaponsWhenDead(guard, false)
                    SetRelationshipBetweenGroups(0, GetHashKey(Config.GuardPed), GetHashKey(Config.GuardPed))
                    Config.GuardLocs[i].GuardData = guard 
                    if Config.FreezeGuards then
                        FreezeEntityPosition(guard, true)
                    end
                end
            end
        end)
	end
end)

local doorsie = {
    [1] = {locked = true},
    [2] = {locked = true},
    [3] = {locked = true}
}



local closestDoor = 1
local near = false
local using = false
local started = false
local state = 0
local closestKey = 1
local activeKey = 0
local nearRob = false
local exStore = nil
local wasRob = false
local closestDep = 1
local rew = 0
local polBlip = nil

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    Citizen.CreateThread(function()
        ESX.PlayerData = xPlayer
        RequestAnimDict('mp_arresting')
        RequestAnimDict('anim@amb@business@coc@coc_unpack_cut_left@')
        RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
        RequestModel('prop_c4_final')
        ApplyDoorLock(1)
        ApplyDoorLock(2)
        ApplyDoorLock(3)
        RequestModel(Config.GuardModel)

        for i = 1, #Config.MapBlips, 1 do
            if Config.MapBlips[i].Active then
                local blip1 = AddBlipForCoord(Config.MapBlips[i].Loc.x, Config.MapBlips[i].Loc.y, Config.MapBlips[i].Loc.z)
                SetBlipSprite(blip1, Config.MapBlips[i].Sprite)
                SetBlipScale(blip1, 0.9)
                SetBlipColour(blip1, Config.MapBlips[i].Color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config.MapBlips[i].Name)
                EndTextCommandSetBlipName(blip1)
                SetBlipAsShortRange(blip1, true)
            end
        end

        for i = 1, #Config.Deposits, 1 do
            table.insert(Picks, false)
        end
        Citizen.Wait(2000)
        if Config.Guards then
            for i = 1, #Config.GuardLocs, 1 do
                local guard = CreatePed(7, Config.GuardModel, Config.GuardLocs[i].Location.x, Config.GuardLocs[i].Location.y, Config.GuardLocs[i].Location.z, Config.GuardLocs[i].Heading, true, true)
                PlaceObjectOnGroundProperly(guard)
                SetEntityAsMissionEntity(guard)
                SetPedCombatAttributes(guard, 0, true)
                SetPedCombatAttributes(guard, 5, true)
                SetPedCombatAttributes(guard, 46, true)
                SetPedFleeAttributes(guard, 0, true)
                GiveWeaponToPed(guard, GetHashKey(Config.GuardWeapon), 250, false, true)
                SetPedAccuracy(guard, Config.GuardAccuracy)
                SetPedDropsWeaponsWhenDead(guard, false)
                SetRelationshipBetweenGroups(0, GetHashKey(Config.GuardPed), GetHashKey(Config.GuardPed))
                Config.GuardLocs[i].GuardData = guard 
                if Config.FreezeGuards then
                    FreezeEntityPosition(guard, true)
                end
            end
        end
        ESX.TriggerServerCallback('HD_paleto:checkDoors', function(can1, can2, can3, copstart)
            doorsie[1].locked = can1
            doorsie[2].locked = can2
            doorsie[3].locked = can3

            if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) and copstart then
                local blip1 = AddBlipForCoord(Config.BankLoc.x, Config.BankLoc.y, Config.BankLoc.z)
                SetBlipSprite(blip1, Config.BankSprite)
                SetBlipScale(blip1, Config.BankSize)
                SetBlipColour(blip1, Config.BankColor)
                if Config.BankPulse then
                    PulseBlip(blip1)
                end
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config.Sayings[12])
                EndTextCommandSetBlipName(blip1)
                ESX.ShowNotification(Config.Sayings[13])
                polBlip = blip1
            end
        end)
    end)
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        ESX.TriggerServerCallback('HD_paleto:checkDoors', function(can1, can2, can3, copstart)
            doorsie[1].locked = can1
            doorsie[2].locked = can2
            doorsie[3].locked = can3
            ApplyDoorLock(1)
            ApplyDoorLock(2)
            ApplyDoorLock(3)
        end)
    end
end)


Citizen.CreateThread(function()
    while true do
        if GetDistanceBetweenCoords(Config.doors[1].objCoords.x,Config.doors[1].objCoords.y,Config.doors[1].objCoords.z,  GetEntityCoords(GetPlayerPed(-1)), true) < Config.CloseDoorCheck and not using then
            Citizen.Wait(500)
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            near = true
            local minDistance = 100
            for i = 1, #Config.doors, 1 do
                dist = Vdist(Config.doors[i].objCoords.x,Config.doors[i].objCoords.y,Config.doors[i].objCoords.z, coords)
                if dist < minDistance then
                    minDistance = dist
                    closestDoor = i
                end
            end
        elseif GetDistanceBetweenCoords(Config.doors[3].objCoords.x,Config.doors[3].objCoords.y,Config.doors[3].objCoords.z,  GetEntityCoords(GetPlayerPed(-1)), true) < Config.CloseDoorCheck and not using then
            Citizen.Wait(500)
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            near = true
            local minDistance = 100
            for i = 1, #Config.doors, 1 do
                dist = Vdist(Config.doors[i].objCoords.x,Config.doors[i].objCoords.y,Config.doors[i].objCoords.z, coords)
                if dist < minDistance then
                    minDistance = dist
                    closestDoor = i
                end
            end
        else
            near = false
            Citizen.Wait(3000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if near then
            Citizen.Wait(4)
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            dist = Vdist(Config.doors[closestDoor].objCoords.x,Config.doors[closestDoor].objCoords.y,Config.doors[closestDoor].objCoords.z, coords)
            if dist <= Config.MaxDoorDist then
                if not using then
                    if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
                        if doorsie[closestDoor].locked then
                            if closestDoor == 3 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x +1,Config.doors[closestDoor].objCoords.y -1,Config.doors[closestDoor].objCoords.z, Config.Sayings[1])
                            elseif closestDoor == 1 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[1])
                            elseif closestDoor == 2 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[1])
                            end
                        else
                            if closestDoor == 3 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x +1,Config.doors[closestDoor].objCoords.y -1,Config.doors[closestDoor].objCoords.z, Config.Sayings[2])
                            elseif closestDoor == 1 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[2])
                            elseif closestDoor == 2 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[2])
                            end
                        end
                        if IsControlJustReleased(0, 47) then
                            doorsie[closestDoor].locked = not doorsie[closestDoor].locked
                            TriggerServerEvent('HD_paleto:updatedoor', closestDoor, doorsie[closestDoor].locked, true)
                        end
                    else
                        if doorsie[closestDoor].locked then
                            if closestDoor == 3 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x +1,Config.doors[closestDoor].objCoords.y -1,Config.doors[closestDoor].objCoords.z, Config.Sayings[3])
                            elseif closestDoor == 1 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[3])
                            elseif closestDoor == 2 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[3])
                            end
                        else
                            if closestDoor == 3 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x +1,Config.doors[closestDoor].objCoords.y -1,Config.doors[closestDoor].objCoords.z, Config.Sayings[4])
                            elseif closestDoor == 1 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[4])
                            elseif closestDoor == 2 then
                                DrawText3D(Config.doors[closestDoor].objCoords.x -0.75,Config.doors[closestDoor].objCoords.y -0.75,Config.doors[closestDoor].objCoords.z , Config.Sayings[4])
                            end
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

function ApplyDoorLock(door)
    local ped = PlayerPedId()
    if door == 1 then
        local closeDoor = GetClosestObjectOfType(Config.doors[1].objCoords.x, Config.doors[1].objCoords.y, Config.doors[1].objCoords.z, 1.0, GetHashKey(Config.doors[1].objName), false, false, false)
        if doorsie[1].locked then
            SetEntityHeading(closeDoor, Config.doors[1].heading)
        end
        FreezeEntityPosition(closeDoor, doorsie[1].locked)
    elseif door == 2 then
        local closeDoor2 = GetClosestObjectOfType(Config.doors[2].objCoords.x, Config.doors[2].objCoords.y, Config.doors[2].objCoords.z, 1.0, GetHashKey(Config.doors[2].objName), false, false, false)
        if doorsie[2].locked then
            SetEntityHeading(closeDoor2, Config.doors[2].heading)
        end
        FreezeEntityPosition(closeDoor2, doorsie[2].locked)
    elseif door == 3 then
        local closeDoor3 = GetClosestObjectOfType(Config.doors[3].objCoords.x, Config.doors[3].objCoords.y, Config.doors[3].objCoords.z, 1.0, GetHashKey(Config.doors[3].objName), false, false, false)
        FreezeEntityPosition(closeDoor3, doorsie[3].locked)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    if not Config.Use3dMarkers then
        DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    end
    ClearDrawOrigin()
end

RegisterNetEvent('HD_paleto:setState')
AddEventHandler('HD_paleto:setState', function(doorID, state)
	doorsie[doorID].locked = state
    ApplyDoorLock(doorID)
end)

local rew = 1
local reward = nil
Citizen.CreateThread(function()
	while true do
		if GetDistanceBetweenCoords(Config.doors[1].objCoords.x,Config.doors[1].objCoords.y,Config.doors[1].objCoords.z,  GetEntityCoords(GetPlayerPed(-1)), true) < 2 then
			if ESX.PlayerData.job and (ESX.PlayerData.job.name ~= Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
                local ped = GetPlayerPed(-1)
				Citizen.Wait(5)
                if not using then
                    if doorsie[1].locked then
                        DrawText3D(Config.doors[1].objCoords.x -0.75,Config.doors[1].objCoords.y -0.75,Config.doors[1].objCoords.z +0.1, Config.Sayings[5])
                        if IsControlJustReleased(0, 47) then
                            ESX.TriggerServerCallback('HD_paleto:CheckLock', function(can)
                                if can then
                                    using = true
                                    SetEntityCoords(ped, Config.LockPick1.x, Config.LockPick1.y, Config.LockPick1.z - 1, false, false, false, false)
                                    SetEntityHeading(ped, Config.LockPickHead1)
                                    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                    FreezeEntityPosition(ped, true)
                                    exports['progressBars']:startUI(Config.LockPickTime *1000, Config.Sayings[34])
                                    Citizen.Wait(Config.LockPickTime *1000)
                                    FreezeEntityPosition(ped, false)
                                    ClearPedTasksImmediately(ped)
                                    using = false
                                    TriggerServerEvent('HD_paleto:updatedoor', 1, false, true)
                                    if Config.TakeLockpick then
                                        TriggerServerEvent('HD_paleto:TakePick')
                                    end
                                else
                                    ESX.ShowNotification(Config.Sayings[35])
                                end
                            end)
                        end
                    end
                end
			else
				Citizen.Wait(2000)
			end
        elseif GetDistanceBetweenCoords(Config.doors[3].objCoords.x,Config.doors[3].objCoords.y,Config.doors[3].objCoords.z,  GetEntityCoords(GetPlayerPed(-1)), true) < 2 then
            if ESX.PlayerData.job and (ESX.PlayerData.job.name ~= Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
                local ped = GetPlayerPed(-1)
				Citizen.Wait(5)
                if not using then
                    if doorsie[3].locked then
                        DrawText3D(Config.doors[3].objCoords.x +1,Config.doors[3].objCoords.y -1,Config.doors[3].objCoords.z +0.1, Config.Sayings[5])
                        if IsControlJustReleased(0, 47) then
                            ESX.TriggerServerCallback('HD_paleto:CheckLock', function(can)
                                if can then
                                    using = true
                                    SetEntityCoords(ped, Config.LockPick2.x, Config.LockPick2.y, Config.LockPick2.z - 1, false, false, false, false)
                                    SetEntityHeading(ped, Config.LockPickHead2)
                                    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                    FreezeEntityPosition(ped, true)
                                    exports['progressBars']:startUI(Config.LockPickTime *1000, Config.Sayings[34])
                                    Citizen.Wait(Config.LockPickTime *1000)
                                    FreezeEntityPosition(ped, false)
                                    ClearPedTasksImmediately(ped)
                                    using = false
                                    TriggerServerEvent('HD_paleto:updatedoor', 3, false, true)
                                    if Config.TakeLockpick then
                                        TriggerServerEvent('HD_paleto:TakePick')
                                    end
                                else
                                    ESX.ShowNotification(Config.Sayings[35])
                                end
                            end)
                        end
                    end
                end
			else
				Citizen.Wait(2000)
			end
		elseif not started and GetDistanceBetweenCoords(Config.StartLoc.x,Config.StartLoc.y,Config.StartLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) < Config.SeeMarkerDist then
			Citizen.Wait(7)
            if Config.Use3dMarkers and not using then
                DrawMarker(Config.StartMarkerNum, Config.StartLoc.x, Config.StartLoc.y, Config.StartLoc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.StartMarkerSize.x, Config.StartMarkerSize.y, Config.StartMarkerSize.z, Config.StartMarkerColor.r, Config.StartMarkerColor.g, Config.StartMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
            if not using then
                local ped = GetPlayerPed(-1)
                if GetDistanceBetweenCoords(Config.StartLoc.x,Config.StartLoc.y,Config.StartLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) < 2 then
                    DrawText3D(Config.StartLoc.x,Config.StartLoc.y,Config.StartLoc.z + Config.Text3DHeight, Config.Sayings[6])
                    if IsControlJustReleased(0, 38) then
                        ESX.TriggerServerCallback('HD_paleto:CheckRob', function(can)
                            if can == 2 then
                                using = true
                                SetEntityCoords(ped, Config.StartAnimLoc.x, Config.StartAnimLoc.y, Config.StartAnimLoc.z - 1, false, false, false, false)
                                SetEntityHeading(ped, Config.StartHeading)
                                TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                FreezeEntityPosition(ped, true)
                                exports['progressBars']:startUI(Config.PanelTime *1000, Config.Sayings[7])
                                Citizen.Wait(Config.PanelTime *1000)
                                TriggerEvent("mhacking:show")
                                TriggerEvent("mhacking:start",Config.HackDiff,Config.HackTime,mycb)
                                FreezeEntityPosition(ped, false)
                                ClearPedTasksImmediately(ped)
                            elseif can == 1 then
                                using = true
                                ESX.ShowNotification(Config.Sayings[18])
                                Citizen.Wait(3000)
                                using = false
                            elseif can == 3 then
                                using = true
                                ESX.ShowNotification(Config.Sayings[19]..Config.NeededCops..Config.Sayings[20])
                                Citizen.Wait(3000)
                                using = false
                            elseif can == 4 then
                                using = true
                                ESX.ShowNotification(Config.Sayings[36])
                                Citizen.Wait(3000)
                                using = false
                            end
                        end)
                    end
                end
            end
		elseif started and state == 1 then
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            local dist = Vdist(Config.keyblips[closestKey].Loc.x, Config.keyblips[closestKey].Loc.y, Config.keyblips[closestKey].Loc.z, coords)
            if dist < Config.MaxDistKey then
                if dist < Config.ShowDistKey then
                    Citizen.Wait(4)
                    if not using then
                        if not Config.keyblips[closestKey].BlipUsed then
                            DrawText3D(Config.keyblips[closestKey].Loc.x, Config.keyblips[closestKey].Loc.y, Config.keyblips[closestKey].Loc.z + Config.Text3DHeight, Config.Sayings[14])
                            if IsControlJustReleased(0, 38) then
                                using = true
                                if closestKey == activeKey then
                                    for i = 1, #Config.keyblips, 1 do
                                        if Config.keyblips[i].BlipUsed then
                                            Config.keyblips[closestKey].BlipUsed = false
                                        else
                                            RemoveBlip(Config.keyblips[i].BlipData)
                                        end
                                    end
                                    state = 2
                                    ESX.ShowNotification(Config.Sayings[16])
                                else
                                    ESX.ShowNotification(Config.Sayings[17])
                                end
                                Config.keyblips[closestKey].BlipUsed = true
                                RemoveBlip(Config.keyblips[closestKey].BlipData)
                                SetEntityCoords(ped, Config.keyblips[closestKey].AnimLoc.x, Config.keyblips[closestKey].AnimLoc.y, Config.keyblips[closestKey].AnimLoc.z - 1, false, false, false, false)
                                SetEntityHeading(ped, Config.keyblips[closestKey].Heading)
                                TaskPlayAnim(ped, "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                FreezeEntityPosition(ped, true)
                                exports['progressBars']:startUI(Config.SearchTime *1000, Config.Sayings[15])
                                Citizen.Wait(Config.SearchTime *1000)
                                FreezeEntityPosition(ped, false)
                                ClearPedTasksImmediately(ped)
                                using = false
                            end
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(2000)
            end
        elseif state == 2 and started then
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            if Vdist(Config.KeyPadLoc.x, Config.KeyPadLoc.y, Config.KeyPadLoc.z, coords) < Config.SeeMarkerDist then
                Citizen.Wait(5)
                if Config.Use3dMarkers then
                    DrawMarker(Config.KPadMarkerNum, Config.KeyPadLoc.x, Config.KeyPadLoc.y, Config.KeyPadLoc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.KPadMarkerSize.x, Config.KPadMarkerSize.y, Config.KPadMarkerSize.z, Config.KPadMarkerColor.r, Config.KPadMarkerColor.g, Config.KPadMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
                end
                if Vdist(Config.KeyPadLoc.x, Config.KeyPadLoc.y, Config.KeyPadLoc.z, coords) < Config.KeyPadClose then
                    if not using then
                        DrawText3D(Config.KeyPadLoc.x, Config.KeyPadLoc.y, Config.KeyPadLoc.z + Config.Text3DHeight, Config.Sayings[21])
                        if IsControlJustReleased(0, 38) then
                            using = true
                            SetEntityCoords(ped, Config.KeyPadAnimLoc.x, Config.KeyPadAnimLoc.y, Config.KeyPadAnimLoc.z - 1, false, false, false, false)
                            SetEntityHeading(ped, Config.KeyPadHeading)
                            TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                            FreezeEntityPosition(ped, true)
                            exports['progressBars']:startUI(Config.KeyPadTime *1000, Config.Sayings[22])
                            Citizen.Wait(Config.KeyPadTime *1000)
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                            using = false
                            state = 3
                            activeKey = 0
                        end
                    end
                end
            else
                Citizen.Wait(1500)
            end
        elseif state == 3 and started then
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            if Vdist(Config.DoorLoc.x, Config.DoorLoc.y, Config.DoorLoc.z, coords) < Config.SeeMarkerDist then
                Citizen.Wait(5)
                if Config.Use3dMarkers and not using then
                    DrawMarker(Config.ExpMarkerNum , Config.DoorAnimLoc.x, Config.DoorAnimLoc.y, Config.DoorAnimLoc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.ExpMarkerSize.x, Config.ExpMarkerSize.y, Config.ExpMarkerSize.z, Config.ExpMarkerColor.r, Config.ExpMarkerColor.g, Config.ExpMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
                end
                if Vdist(Config.DoorAnimLoc.x, Config.DoorAnimLoc.y, Config.DoorAnimLoc.z, coords) < Config.DoorClose then
                    if not using then
                        DrawText3D(Config.DoorAnimLoc.x, Config.DoorAnimLoc.y, Config.DoorAnimLoc.z + Config.Text3DHeight, Config.Sayings[23])
                        if IsControlJustReleased(0, 38) then
                            ESX.TriggerServerCallback('HD_paleto:CheckExplosive', function(can)
                                if can then
                                    using = true
                                    SetEntityCoords(ped, Config.DoorAnimLoc.x, Config.DoorAnimLoc.y, Config.DoorAnimLoc.z - 1, false, false, false, false)
                                    SetEntityHeading(ped, Config.DoorHeading)
                                    local x, y, z = table.unpack(GetEntityCoords(ped))
                                    local bomba = CreateObject(GetHashKey("prop_c4_final"), x, y, z + 0.2,  true,  true, true)
                                
                                    SetEntityCollision(bomba, false, true)
                                    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                    FreezeEntityPosition(ped, true)
                                    exports['progressBars']:startUI(Config.DoorETime *1000, Config.Sayings[24])
                                    Citizen.Wait(Config.DoorETime *1000)
                                    DeleteObject(bomba)
                                    FreezeEntityPosition(ped, false)
                                    ClearPedTasksImmediately(ped)
                                    using = false
                                    state = 4
                                    TriggerServerEvent('HD_paleto:startExplode')
                                else
                                    ESX.ShowNotification(Config.Sayings[37])
                                end
                            end)
                        end
                    end
                end
            else
                Citizen.Wait(1500)
            end
        elseif state == 4 and started then
            local ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(ped)
            local dist = Vdist(Config.Deposits[closestDep].Loc.x, Config.Deposits[closestDep].Loc.y, Config.Deposits[closestDep].Loc.z, coords)
            if dist < Config.MaxDistDep then
                if dist < Config.ShowDistDep then
                    Citizen.Wait(5)
                    if not using then
                        if not Picks[closestDep] then
                            DrawText3D(Config.Deposits[closestDep].Loc.x, Config.Deposits[closestDep].Loc.y, Config.Deposits[closestDep].Loc.z + Config.Text3DHeight, Config.Sayings[28])
                            if IsControlJustReleased(0, 38) then
                                rew = 1
                                GetRandom()
                                TriggerServerEvent('HD_paleto:GivePickup', closestDep, rew, reward)
                                using = true
                                SetEntityCoords(ped, Config.Deposits[closestDep].Loc.x, Config.Deposits[closestDep].Loc.y, Config.Deposits[closestDep].Loc.z -1 , false, false, false, false)
                                SetEntityHeading(ped, Config.Deposits[closestDep].Heading)
                                if Config.Deposits[closestDep].AnimType == 1 then
                                    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                else
                                    TaskPlayAnim(ped, "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                                end
                                FreezeEntityPosition(ped, true)
                                exports['progressBars']:startUI(Config.PickupTime *1000, Config.Sayings[29])
                                Citizen.Wait(Config.PickupTime *1000)
                                FreezeEntityPosition(ped, false)
                                ClearPedTasksImmediately(ped)
                                using = false
                            end
                        end
                    end
                else
                    Citizen.Wait(2000)
                end
            else
                Citizen.Wait(2000)
            end
        else
			Citizen.Wait(3000)
		end
	end
end)

function GetRandom()
    if rew == 1 then
        local firstnum = Config.MoneyR.firstnum
        local secondnum = Config.MoneyR.secondnum
    end
end

Citizen.CreateThread(function()
    while true do
        if GetDistanceBetweenCoords(Config.BankLoc.x, Config.BankLoc.y, Config.BankLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) < Config.MaxDist and started then
            local ped = GetPlayerPed(-1)
            if state == 1 then
                Citizen.Wait(500)
                local minDistance = 100
                local coords = GetEntityCoords(PlayerPedId())
                for i = 1, #Config.keyblips, 1 do
                    dist = Vdist(Config.keyblips[i].Loc.x, Config.keyblips[i].Loc.y, Config.keyblips[i].Loc.z, coords)
                    if dist < minDistance then
                        minDistance = dist
                        closestKey = i
                    end
                end
            elseif state == 4 then
                Citizen.Wait(500)
                local minDistance = 100
                local coords = GetEntityCoords(PlayerPedId())
                for i = 1, #Config.Deposits, 1 do
                    dist = Vdist(Config.Deposits[i].Loc.x, Config.Deposits[i].Loc.y, Config.Deposits[i].Loc.z, coords)
                    if dist < minDistance then
                        minDistance = dist
                        closestDep = i
                    end
                end
            else
                Citizen.Wait(2000)
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if not using then
            if state == 1 then
                Citizen.Wait(5)
                local coords = GetEntityCoords(PlayerPedId())
                if Config.Use3dMarkers then
                    for i = 1, #Config.keyblips, 1 do
                        dist = Vdist(Config.keyblips[i].Loc.x, Config.keyblips[i].Loc.y, Config.keyblips[i].Loc.z, coords)
                        if dist < Config.SeeMarkerDist then
                            if not Config.keyblips[i].BlipUsed then
                                DrawMarker(Config.KeyMarkerNum, Config.keyblips[i].Loc.x, Config.keyblips[i].Loc.y, Config.keyblips[i].Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.KeyMarkerSize.x, Config.KeyMarkerSize.y, Config.KeyMarkerSize.z, Config.KeyMarkerColor.r, Config.KeyMarkerColor.g, Config.KeyMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
                            end
                        end
                    end
                end
            elseif state == 4 then
                Citizen.Wait(5)
                local coords = GetEntityCoords(PlayerPedId())
                if Config.Use3dMarkers then
                    for i = 1, #Config.Deposits, 1 do
                        dist = Vdist(Config.Deposits[i].Loc.x, Config.Deposits[i].Loc.y, Config.Deposits[i].Loc.z, coords)
                        if dist < Config.SeeMarkerDist then
                            if not Picks[i] then
                                DrawMarker(Config.DepositMarkerNum, Config.Deposits[i].Loc.x, Config.Deposits[i].Loc.y, Config.Deposits[i].Loc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DepositMarkerSize.x, Config.DepositMarkerSize.y, Config.DepositMarkerSize.z, Config.DepositMarkerColor.r, Config.DepositMarkerColor.g, Config.DepositMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)


function mycb(success, timeremaining)
    local ped = PlayerPedId()
    if success then
        TriggerEvent('mhacking:hide')
        started = true
        using = false
        TriggerServerEvent('HD_paleto:StartRob')
        ESX.ShowNotification(Config.Sayings[8])
        SpawnKeyBlips()
        GetKeyLoc()
        state = 1
    else
        TriggerEvent('mhacking:hide')
        using = false
        TriggerServerEvent('HD_paleto:TempCallPol')
        ESX.ShowNotification(Config.Sayings[9])
    end
end

function SpawnKeyBlips()
    for i = 1, #Config.keyblips, 1 do
        local blip1 = AddBlipForCoord(Config.keyblips[i].Loc.x, Config.keyblips[i].Loc.y, Config.keyblips[i].Loc.z)
        SetBlipSprite(blip1, Config.KeySprite)
        SetBlipScale(blip1, Config.KeySize)
        SetBlipColour(blip1, Config.KeyColor)
        if Config.KeyPulse then
            PulseBlip(blip1)
        end
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Sayings[15])
        EndTextCommandSetBlipName(blip1)
        Config.keyblips[i].BlipData = blip1


        activeKey = activeKey + 1
    end
end

function GetKeyLoc()
    local num = math.random(1, activeKey)
    activeKey = num
end

RegisterNetEvent('HD_paleto:CallCopsTemp')
AddEventHandler('HD_paleto:CallCopsTemp', function()
    Citizen.CreateThread(function()
        if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
            local blip1 = AddBlipForCoord(Config.BankLoc.x, Config.BankLoc.y, Config.BankLoc.z)
            SetBlipSprite(blip1, Config.TempSprite)
            SetBlipScale(blip1, Config.TempSize)
            SetBlipColour(blip1, Config.TempColor)
            if Config.TempPulse then
                PulseBlip(blip1)
            end
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Sayings[10])
            EndTextCommandSetBlipName(blip1)
            ESX.ShowNotification(Config.Sayings[11])
        
            Citizen.Wait(Config.TempTime *60000)
            RemoveBlip(blip1)
        end
    end)
end)

RegisterNetEvent('HD_paleto:CallCops')
AddEventHandler('HD_paleto:CallCops', function()
    Citizen.CreateThread(function()
        if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
            local blip1 = AddBlipForCoord(Config.BankLoc.x, Config.BankLoc.y, Config.BankLoc.z)
            SetBlipSprite(blip1, Config.BankSprite)
            SetBlipScale(blip1, Config.BankSize)
            SetBlipColour(blip1, Config.BankColor)
            if Config.BankPulse then
                PulseBlip(blip1)
            end
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Sayings[12])
            EndTextCommandSetBlipName(blip1)
            ESX.ShowNotification(Config.Sayings[13])
            polBlip = blip1
        end
    end)
end)

RegisterNetEvent('HD_paleto:ExplodeNote')
AddEventHandler('HD_paleto:ExplodeNote', function()
    if GetDistanceBetweenCoords(Config.BankLoc.x, Config.BankLoc.y, Config.BankLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) < Config.CloseExplode then
        ESX.ShowNotification(Config.Sayings[25]..Config.ExplodeTimer..Config.Sayings[26])
        nearRob = true
        local bomba = CreateObject(GetHashKey("prop_c4_final"), Config.DoorLoc.x +0.15, Config.DoorLoc.y, Config.DoorLoc.z,  true,  false, true)
        SetEntityHeading(bomba, Config.BombHeading)
        FreezeEntityPosition(bomba, true)
        exStore = bomba
    end
end)

function SpawnDepBlips()
    for i = 1, #Config.Deposits, 1 do
        local blip1 = AddBlipForCoord(Config.Deposits[i].Loc.x, Config.Deposits[i].Loc.y, Config.Deposits[i].Loc.z)
        SetBlipSprite(blip1, Config.DepSprite)
        SetBlipScale(blip1, Config.DepSize)
        SetBlipColour(blip1, Config.DepColor)
        if Config.DepPulse then
            PulseBlip(blip1)
        end
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Sayings[33])
        EndTextCommandSetBlipName(blip1)
        Config.Deposits[i].Datastore = blip1
    end
end

RegisterNetEvent('HD_paleto:ExplodeNow')
AddEventHandler('HD_paleto:ExplodeNow', function()
    if Config.HaveExplosion then
        AddExplosion(Config.DoorLoc.x + 0.5, Config.DoorLoc.y, Config.DoorLoc.z, 5, Config.Explosion, true, false, 100)
        Citizen.CreateThread(function()
            Citizen.Wait(250)
            StopFireInRange(Config.DoorLoc.x, Config.DoorLoc.y, Config.DoorLoc.z, 30)
        end)
    end
    if nearRob then
        SpawnDepBlips()
        DeleteObject(exStore)
        ESX.ShowNotification(Config.Sayings[27])
    end
end)

RegisterNetEvent('HD_paleto:Picked')
AddEventHandler('HD_paleto:Picked', function(num)
    Picks[num] = true
    if nearRob then
        RemoveBlip(Config.Deposits[num].Datastore)
    end
end)

RegisterNetEvent('HD_paleto:CancelRobb')
AddEventHandler('HD_paleto:CancelRobb', function()
    RemoveBlip(polBlip)
    ESX.ShowNotification(Config.Sayings[39])
end)

RegisterNetEvent('HD_paleto:RobDone')
AddEventHandler('HD_paleto:RobDone', function()
    started = false
    state = 0
    for i = 1, #Picks, 1 do
        Picks[i] = false
        Config.Deposits[i].Datastore = nil
    end
    if nearRob then
        nearRob = false
    end
    if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceJob or ESX.PlayerData.job.name == Config.PoliceJob2) then
        RemoveBlip(polBlip)
        ESX.ShowNotification(Config.Sayings[32])
    end
end)

Citizen.CreateThread(function()
    while true do
        if started and state ~= 4 then 
            Citizen.Wait(2000)
            if GetDistanceBetweenCoords(Config.BankLoc.x,Config.BankLoc.y,Config.BankLoc.z,  GetEntityCoords(GetPlayerPed(-1)), true) > Config.CloseRob then
                started = false
                nearRob = false
                if state == 1 then
                    for i = 1, #Config.keyblips, 1 do
                        if Config.keyblips[i].BlipUsed then
                            Config.keyblips[closestKey].BlipUsed = false
                        else
                            RemoveBlip(Config.keyblips[i].BlipData)
                        end
                    end
                end
                state = 0
                TriggerServerEvent('HD_paleto:CancelRob')
                ESX.ShowNotification(Config.Sayings[38])
            end
        else
            Citizen.Wait(4000)
        end
    end
end)