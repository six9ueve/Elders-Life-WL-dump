ESX =  nil
local robbing = false

Citizen.CreateThread(function()
    while ESX == nil do
	  TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("fizzfau-banktruck:onUse")
AddEventHandler("fizzfau-banktruck:onUse", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local closestVeh = ESX.Game.GetClosestVehicle(coords, false)
    local veh_coords = GetOffsetFromEntityInWorldCoords(closestVeh, 0.0, -4.25, 0.0)
    local distance = #(playerCoords - veh_coords)
    local model = GetEntityModel(closestVeh)
    print(ESX.GetTimeIRL())
    if ESX.GetTimeIRL() > 1 and ESX.GetTimeIRL() < 10 then
        ESX.ShowAdvancedNotification('GRUPPE 6', 'Rapport', 'Heure de braquage dépassée', 'CHAR_LESTER_DEATHWISH', 4)
    else
        if distance <= 5 then
            if model == 1747439474 then
                local plate = GetVehicleNumberPlateText(closestVeh)
                TriggerServerEvent("fizzfau-moneytruck:checkRob", plate, closestVeh)
            end
        end
    end
end)

RegisterNetEvent("fizzfau-moneytruck:PoliceAlert")
AddEventHandler("fizzfau-moneytruck:PoliceAlert", function(playerpos)
    local PlayerData = ESX.GetPlayerData()
    local blip = nil

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage Camion Brinks\n~r~INTERVENTION DEMANDEE, INDIVDU ARME", "CHAR_CALL911", 4)

        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(playerpos.x, playerpos.y, playerpos.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(60000)
            RemoveBlip(blip)
        end
    end

    if PlayerData.job.name == "sheriff" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage Camion Brinks\n~r~INTERVENTION DEMANDEE, INDIVDU ARME", "CHAR_CALL911", 4)
        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(playerpos.x, playerpos.y, playerpos.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(60000)
            RemoveBlip(blip)
        end
    end
    --[[local ped = PlayerPedId()
    local playerPos = playerpos
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end
    ESX.ShowAdvancedNotification('GRUPPE 6', 'Rapport', 'Un braquage de fourgon est en cours sur '..streetLabel, 'CHAR_LESTER_DEATHWISH', 4)]]--
end)

RegisterNetEvent("fizzfau-moneytruck:startRob")
AddEventHandler("fizzfau-moneytruck:startRob", function(vehicle)
    robbing = true
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(100)
    end
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end
    local coords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    SetPlayerCoordBrinks(ped, coords, vehicle)
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    local cancelled = exports['progressBars']:startUI((6 * 1000), ('Lecture de la carte'))
    TriggerServerEvent("fizzfau-moneytruck:s_police_notify", GetEntityCoords(PlayerPedId()))
    Citizen.Wait(6000)
    ClearPedTasks(ped)
    CreateGuardsBrinks(vehicle, ped)
end)

RegisterNetEvent("fizzfau-moneytruck:endRobbery")
AddEventHandler("fizzfau-moneytruck:endRobbery", function()
    robbing = false
    ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("fizzfau-moneytruck:anim")
AddEventHandler("fizzfau-moneytruck:anim", function()
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        while robbing == true do
            if not IsEntityPlayingAnim(ped, "mini@repair", "fixing_a_player", 3) then
                ClearPedSecondaryTask(ped)
                TaskPlayAnim(ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
            end
            Citizen.Wait(25)
        end
    end)
    exports['progressBars']:startUI((30 * 1000), ('Ramassage en cours'))
end)

function CreateGuardsBrinks(vehicle, ped)
    local peds = {}
    local hashKey = `ig_casey`
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(250)
    end
    for i =1, 3 do
        peds[i] = CreatePedInsideVehicle(vehicle, 0xF50B51B7, hashKey, i - 1 , 1, 1)
        SetPedShootRate(peds[i],  750)
        GiveWeaponToPed(peds[i], `WEAPON_SMG`, 150, true, true)
        SetPedCombatAttributes(peds[i], 46, true)
        SetPedFleeAttributes(peds[i], 0, 0)
        SetPedAsEnemy(peds[i],true)
        SetPedMaxHealth(peds[i], 900)
        SetPedAlertness(peds[i], 3)
        SetPedCombatRange(peds[i], 0)
        SetPedCombatMovement(peds[i], 3)
        TaskLeaveVehicle(peds[i], vehicle, 0)
        SetPedRelationshipGroupHash(peds[i], `HATES_PLAYER`)
    end
    Citizen.Wait(1000)
    SetVehicleDoorOpen(vehicle,2,0,0)
    SetVehicleDoorOpen(vehicle,3,0,0)
    DrawRobBrinks(vehicle)
end

function DrawRobBrinks(vehicle)
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        while true do
            local wait = 750
            if DoesEntityExist(vehicle) then
                local health = GetEntityHealth(vehicle)
                if health > 10 then
                    wait = 100
                    local coords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
                    local pcoords = GetEntityCoords(ped)
                    local distance = #(pcoords - coords)
                    if distance <= 3.5 then
                        wait = 0
                        DrawText3DsBrinks(coords.x, coords.y, coords.z, "E - Voler")
                        if IsControlJustPressed(0, 46) then
                            SetPlayerCoordBrinks(ped, coords, vehicle)
                            TriggerServerEvent("fizzfau-moneytruck:server:startRob")
                            TriggerEvent("fizzfau-moneytruck:anim")
                            return
                        end
                    end
                end
            end
            Citizen.Wait(wait)
        end
    end)
end

function DrawText3DsBrinks(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SetPlayerCoordBrinks(ped, coords, vehicle)
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    SetEntityHeading(ped, GetEntityHeading(vehicle))
end

RegisterNetEvent("god:onPlayerDeath")
AddEventHandler('god:onPlayerDeath', function()
    robbing = false
    TriggerServerEvent("fizzfau-moneytruck:onPlayerDeath")
end)

RegisterNetEvent("god:onPlayerSpawn")
AddEventHandler('god:onPlayerSpawn', function()
    TriggerServerEvent("fizzfau-moneytruck:playerSpawned")
end)
