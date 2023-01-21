
ESX = nil

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--
-------------anti bunny

--neige
--ForceSnowPass(true)
local function setBleedingBlock()
    Citizen.CreateThread(function()
        while bleeding do
            Citizen.Wait(0)
            DisableControlAction(0, 22, true)               -- Jump
            DisableControlAction(0, 21, true)               -- run
            DisableControlAction(0, 263, true)              -- Disable melee
            DisableControlAction(0, 264, true)              -- Disable melee
            DisableControlAction(0, 257, true)              -- Disable melee
            DisableControlAction(0, 140, true)              -- Disable melee
            DisableControlAction(0, 141, true)              -- Disable melee
            DisableControlAction(0, 142, true)              -- Disable melee
            DisableControlAction(0, 143, true)              -- Disable melee
        end
    end)
end

local function InfoRanny(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local function setBleedingOn()
    local player = PlayerPedId()
    local Health = GetEntityHealth(player)

    r = math.random(1,3)
    if r == 2 then
        SetEntityHealth(player, Health - 1)
        lasthealth = Health
    end
    
    if (Health <= 105) then
        if not effect2 then
            --StopScreenEffect('Rampage')
            --StartScreenEffect('DrugsTrevorClownsFightIn', 0, true)

            -- Movement
            RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
            while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
            Citizen.Wait(0)
            end

            SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
            effect2 = true
            bleeding = true
            setBleedingBlock()
        else
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
        end
    else
        if not effect then
            --StartScreenEffect('Rampage', 0, true)
            effect = true
            bleeding = true
            setBleedingBlock()
        end
    end

    InfoRanny("~r~Vous êtes blessé, consultez un médecin !")
    Wait(10000)
end

local function setBleedingOff()
    if (effect) then
        --StopScreenEffect('Rampage')
        effect = false
        bleeding = false
        ResetPedMovementClipset(PlayerPedId(), 0)
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedTasks(PlayerPedId())
    end


    if (effect2) then
        --StopScreenEffect('DrugsTrevorClownsFightIn')
        effect2 = false
        bleeding = false
        ResetPedMovementClipset(PlayerPedId(), 0)
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedTasks(PlayerPedId())
    end
end

Citizen.CreateThread(function()
    while true do
        interval  = 750
        local ped = PlayerPedId()
        if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
            local chance_result = math.random()
            interval  = 1
            if chance_result < 0.50 then
                Citizen.Wait(600)     
                SetPedToRagdoll(ped, 5000, 1, 2)
            else
                Citizen.Wait(2000)
            end
        end
        Citizen.Wait(interval)
    end
end)

-- Desactiver coup crosse
Citizen.CreateThread(function()
    while true do
        interval = 750
	   local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            interval = 1
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        else
        Citizen.Wait(500)
        end
        Citizen.Wait(interval)
    end
    
end)
--Health
RegisterNetEvent('UtilsCore:heal')
AddEventHandler('UtilsCore:heal', function()
    local playerPed = PlayerPedId()
    local maxHealth = GetEntityMaxHealth(playerPed)
    SetEntityHealth(playerPed, maxHealth)
end)


-- ADD PVP

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

--Ko
local knockedOut = false
local wait = math.random(1,5)
local count = 50

Citizen.CreateThread(function()
	while true do
        interval = 750
		if IsPedInMeleeCombat(PlayerPedId()) then
			if GetEntityHealth(PlayerPedId()) < 120 then
                interval = 1
				SetPlayerInvincible(PlayerId(), false)
				SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
				ESX.ShowNotification("~r~Tu as été mis KO!")
				wait = math.random(1,4)
				knockedOut = true
				SetEntityHealth(PlayerPedId(), 140)
			end
		end
		if knockedOut then
            interval = 1
			SetPlayerInvincible(PlayerId(), false)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(PlayerPedId())

			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 50
					wait = wait - 1
					--SetEntityHealth(myPed, GetEntityHealth(myPed)+1)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
        if GetEntityHealth(PlayerPedId()) <= 160 then
            if not low then
                interval = 1
                ExecuteCommand('walk Blessé')
                low = true
            end
        else
            if low then
                ExecuteCommand('walk reset')
                low = false
            end
        end
        Citizen.Wait(interval)
	end
end)

-------------------------------- bloque le joueur si degat 
local effect = false
local effect2 = false
local bleeding = false
local lasthealth = GetEntityHealth(PlayerPedId())

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local player = PlayerPedId()
        local Health = GetEntityHealth(player)
        if Health <= 140 and Health > 0 then
            setBleedingOn()
            setBleedingBlock()
        elseif Health > 141 then
            Citizen.Wait(50)
            setBleedingOff()
        elseif Health == 0 then
            
        end
        for _,ped in pairs(ESX.Game.GetPeds()) do
            SetPedDropsWeaponsWhenDead(ped, false)
        end

        ClearPedBloodDamage(PlayerPedId()) -- Temp because OneSync Infinity desync
        InvalidateIdleCam()
        N_0x9e4cfff989258472() -- Disable the vehicle idle camera
        Citizen.Wait(1000)
    end
end)