-- ESX
ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-- Locals
local dragStatus = {}
dragStatus.isDragged = false
local cuffed = false
local putin = false
local dict = "mp_arresting"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")
local IsLockpicking    = false

-- Sätt på handklovar
RegisterNetEvent('god_handcuffs:cuff')
AddEventHandler('god_handcuffs:cuff', function()
    ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    if GetEntityModel(ped) == femaleHash then
        prevFemaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 51, 0, 0)
    elseif GetEntityModel(ped) == maleHash then
        prevMaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 72, 0, 0)
    end
    SetEnableHandcuffs(ped, true)
    TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
    cuffed = not cuffed
    TriggerEvent('god_handcuffs:cuffedmenuy')
    changed = true
end)

-- Ta av handklovar
RegisterNetEvent('god_handcuffs:uncuff')
AddEventHandler('god_handcuffs:uncuff', function()
    ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:getSkin', function(skina)
            TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms, ['chain_1'] = skin.chain_1, ['chain_2'] = skin.chain_2})
        end)
    end)
    ClearPedTasks(ped)
    SetEnableHandcuffs(ped, false)
    UncuffPed(ped)
    if GetEntityModel(ped) == femaleHash then -- mp female
        SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
    elseif GetEntityModel(ped) == maleHash then -- mp male
        SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
    end
    cuffed = not cuffed
    TriggerEvent('god_handcuffs:cuffedmenuy')
    changed = true
end)

RegisterNetEvent('god_handcuffs:cuffcheck')
AddEventHandler('god_handcuffs:cuffcheck', function()
    local Pid = GetPlayerServerId(PlayerId())
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    if distance <= 2.0 then
        TriggerServerEvent('god_handcuffs:requestarrest', target_id, playerheading, playerCoords, playerlocation)
         Wait(5000)
        TriggerServerEvent('god_handcuffs:cuffing', GetPlayerServerId(target))
    else
        ESX.ShowNotification('Personne à coté de vous!')
        TriggerServerEvent('god_handcuffs:addhandcuff', Pid)
    end
end)

RegisterNetEvent('god_handcuffs:uncuffcheck')
AddEventHandler('god_handcuffs:uncuffcheck', function()
    local Pid = GetPlayerServerId(PlayerId())
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    if distance <= 2.0 then
        TriggerServerEvent('god_handcuffs:requestrelease', target_id, playerheading, playerCoords, playerlocation)
        Wait(5000)
        TriggerServerEvent('god_handcuffs:uncuffing', GetPlayerServerId(target))
        TriggerServerEvent('god_handcuffs:addhandcuff', Pid)
    else
        ESX.ShowNotification('Personne à coté de vous!')
    end
end)

RegisterNetEvent('god_handcuffs:unlockingcuffs')
AddEventHandler('god_handcuffs:unlockingcuffs', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    if distance <= 2.0 then
        if IsLockpicking == false then
            IsLockpicking = true
            TriggerServerEvent('god_handcuffs:requestreleasepick', target_id, playerheading, playerCoords, playerlocation)
            Wait(25000)
            IsLockpicking = false
            TriggerServerEvent('god_handcuffs:uncuffing', GetPlayerServerId(target))
        else
            ESX.ShowNotification('Vous etes déjà en train de crocheter les menottes')
        end
    else
        ESX.ShowNotification('Personne à coté de vous!')
    end
end)

--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if not changed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped)
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(0)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        else        
            Citizen.Wait(500)
            changed = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        ped = PlayerPedId()
        if cuffed then
            DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
            DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(0, 257, true) -- INPUT_ATTACK2
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
            DisableControlAction(0, 24, true) -- INPUT_ATTACK
            DisableControlAction(0, 25, true) -- INPUT_AIM
			DisableControlAction(0, 21, true) -- SHIFT
			DisableControlAction(0, 22, true) -- SPACE
			DisableControlAction(0, 288, true) -- F1
            DisableControlAction(0, 166, true) -- F5
            DisableControlAction(0, 327, true) -- F5
            DisableControlAction(0, 318, true) -- F5
			DisableControlAction(0, 289, true) -- F2
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 167, true) -- F6
			DisableControlAction(0, 168, true) -- F7
            DisableControlAction(0, 56, true) -- F9
			DisableControlAction(0, 57, true) -- F10
            DisableControlAction(0, 344, true) -- F11
			DisableControlAction(0, 73, true) -- X            
        end
        if putin then
            DisableControlAction(0, 75, true) -- F
        end
    end
end)

RegisterNetEvent('god_handcuffs:drag')
AddEventHandler('god_handcuffs:drag', function(copId)
    if not cuffed then
        return
    end

    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.DragId = copId
end)

RegisterNetEvent('god_handcuffs:draggang')
AddEventHandler('god_handcuffs:draggang', function(copId)
    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.DragId = copId
end)

Citizen.CreateThread(function()
    local playerPed
    local targetPed

    while true do
        Citizen.Wait(0)

        if cuffed then
            playerPed = PlayerPedId()

            if dragStatus.isDragged then
                targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.DragId))

                -- undrag if target is in an vehicle
                if not IsPedSittingInAnyVehicle(targetPed) then
                    AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    dragStatus.isDragged = false
                    DetachEntity(playerPed, true, false)
                end

                if IsPedDeadOrDying(targetPed, true) then
                    dragStatus.isDragged = false
                    DetachEntity(playerPed, true, false)
                end

            else
                DetachEntity(playerPed, true, false)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('god_handcuffs:putInVehicle')
AddEventHandler('god_handcuffs:putInVehicle', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if not cuffed then
        return
    end

    if IsAnyVehicleNearPoint(coords, 5.0) then
        local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

        if DoesEntityExist(vehicle) then
            local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

            for i=maxSeats - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    freeSeat = i
                    break
                end
            end

            if freeSeat then
                TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
                dragStatus.isDragged = false
                putin = true
            end
        end
    end
end)

RegisterNetEvent('god_handcuffs:putInVehiclegang')
AddEventHandler('god_handcuffs:putInVehiclegang', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if IsAnyVehicleNearPoint(coords, 5.0) then
        local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

        if DoesEntityExist(vehicle) then
            local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

            for i=maxSeats - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    freeSeat = i
                    break
                end
            end

            if freeSeat then
                TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
                dragStatus.isDragged = false
                putin = true
            end
        end
    end
end)

RegisterNetEvent('god_handcuffs:OutVehicle')
AddEventHandler('god_handcuffs:OutVehicle', function()
    local playerPed = PlayerPedId()

    if not IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, vehicle, 16)
    putin = false
    Citizen.Wait(800)
    SetEnableHandcuffs(playerPed, true)
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
end)

RegisterNetEvent('god_handcuffs:OutVehiclegang')
AddEventHandler('god_handcuffs:OutVehiclegang', function()
    local playerPed = PlayerPedId()

    if not IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, vehicle, 16)
    putin = false
    Citizen.Wait(800)
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
end)

-- Animation 

function loadanimdict(dictname)
  if not HasAnimDictLoaded(dictname) then
    RequestAnimDict(dictname) 
    while not HasAnimDictLoaded(dictname) do 
      Citizen.Wait(1)
    end
    RemoveAnimDict(dictname)
  end
end

RegisterNetEvent('god_handcuffs:getarrested')
AddEventHandler('god_handcuffs:getarrested', function(playerheading, playercoords, playerlocation)
  playerPed = PlayerPedId()
  SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
  local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
  SetEntityCoords(PlayerPedId(), x, y, z)
  SetEntityHeading(PlayerPedId(), playerheading)
  Citizen.Wait(250)
  loadanimdict('mp_arrest_paired')
  TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
  Citizen.Wait(3760)
  loadanimdict('mp_arresting')
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('god_handcuffs:doarrested')
AddEventHandler('god_handcuffs:doarrested', function()
  Citizen.Wait(250)
  loadanimdict('mp_arrest_paired')
  TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
  Citizen.Wait(3000)

end) 

RegisterNetEvent('god_handcuffs:douncuffing')
AddEventHandler('god_handcuffs:douncuffing', function()
  Citizen.Wait(250)
  loadanimdict('mp_arresting')
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('god_handcuffs:getuncuffed')
AddEventHandler('god_handcuffs:getuncuffed', function(playerheading, playercoords, playerlocation)
  local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
  z = z - 1.0
  SetEntityCoords(PlayerPedId(), x, y, z)
  SetEntityHeading(PlayerPedId(), playerheading)
  Citizen.Wait(250)
  loadanimdict('mp_arresting')
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('god_handcuffs:douncuffingpick')
AddEventHandler('god_handcuffs:douncuffingpick', function()
  Citizen.Wait(250)
  loadanimdict('mp_arresting')
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(3500)
  ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('god_handcuffs:getuncuffedpick')
AddEventHandler('god_handcuffs:getuncuffedpick', function(playerheading, playercoords, playerlocation)
  local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
  z = z - 1.0
  SetEntityCoords(PlayerPedId(), x, y, z)
  SetEntityHeading(PlayerPedId(), playerheading)
  Citizen.Wait(250)
  loadanimdict('mp_arresting')
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(5500)
  TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
  Citizen.Wait(3500)
  ClearPedTasks(PlayerPedId())
end)

TakeHiddenHead = function()
    Citizen.CreateThread(function()
        ClearPedTasks(GetPlayerPed(-1))
        SetPedCanPlayAmbientBaseAnims(GetPlayerPed(-1), true)
        ESX.ShowNotification("~r~ATTENTION~s~\n- Une personne vous a mis un sac sur la tête !")
        DisablePlayerFiring(PlayerPedId(), true)
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
        SetPedCanPlayGestureAnims(GetPlayerPed(-1), false)
        Worek = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
        AttachEntityToEntity(Worek, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
        haveSacInHead = true
        while haveSacInHead do
            Citizen.Wait(0)
            HideHudAndRadarThisFrame()
            DrawRect(.0,.0,2.0,2.0,0,0,0,255)
            SetPauseMenuActive(false)
            SetTextFont(4)
            SetTextScale(.7, .7)
            SetTextColour(255,255,255,255)
            SetTextJustification(1)
            SetTextEntry("STRING")
            AddTextComponentString("- Vous avez actuellement un sac sur la tête.\n- Appuyez sur [X] pour enlever le sac de votre tête.")
            DrawText(.4, .4)
            if IsControlJustPressed(0, 186) then
                if not cuffed then
                    ESX.ShowNotification("~r~ATTENTION~s~\n- Vous avez enlever le sac de votre tête !")
                    ClearPedSecondaryTask(GetPlayerPed(-1))
                    DisablePlayerFiring(GetPlayerPed(-1), false)
                    SetPedCanPlayGestureAnims(GetPlayerPed(-1), true)
                    DeleteEntity(Worek)
                    SetEntityAsNoLongerNeeded(Worek)                      
                    haveSacInHead = false
                    break
                else
                    ESX.ShowNotification("~r~ATTENTION~s~\n- Vous êtes menotté, vous ne pouvez pas enlever le sac de votre tête !")
                end
            end
        end
    end)
end

RegisterNetEvent("Elders_anim_illegal:HiddenHeadCheck")
AddEventHandler("Elders_anim_illegal:HiddenHeadCheck", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 2.0 then
        TriggerServerEvent("Elders_anim_illegal:HiddenHead", GetPlayerServerId(player))
        TriggerServerEvent("elderslife:removeInvItems", "headbag", 1)
        ESX.ShowNotification("~r~ATTENTION~s~\n- Vous avez mis un sac sur la tête de la personne !")
    else
        ESX.ShowNotification("~r~Aucun individu(s) à proximité !")
    end
end)

RegisterNetEvent("Elders_anim_illegal:HiddenHead")
AddEventHandler("Elders_anim_illegal:HiddenHead",function()
    if haveSacInHead then 
        return 
    else
        TakeHiddenHead()
    end
end)