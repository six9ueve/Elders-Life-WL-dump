ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local stoprun = false
local IsLiftup = false
local piggyBackInProgress 	 = false
local carryingBackInProgress = false
local holdingHostageInProgress = false
local isCarry = false
local hasRope = false
local hostageAllowedWeapons = {
    "WEAPON_PISTOL",
    "WEAPON_PISTOL50",
}

RegisterCommand('porter', function()
     if not carryingBackInProgress then
        carryingBackInProgress = true
        stoprun = true
        lib = 'missfinale_c2mcs_1'
        anim1 = 'fin_c2_mcs_1_camman'
        lib2 = 'nm'
        anim2 = 'firemans_carry'
        distans = 0.15
        distans2 = 0.27
        height = 0.63
        spin = 0.0		
        length = 100000
        controlFlagMe = 49
        controlFlagTarget = 33
        animFlagTarget = 1
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()
        target = GetPlayerServerId(closestPlayer)
        if distance ~= -1 and distance <= 2.0 then
            TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
        else
            ESX.ShowNotification("~r~Aucun(e) individu à proximité !")
        end
    else
        carryingBackInProgress = false
        stoprun = false
        ClearPedSecondaryTask(GetPlayerPed(-1))
        DetachEntity(GetPlayerPed(-1), true, false)
        local closestPlayer = GetClosestPlayer(3)
        target = GetPlayerServerId(closestPlayer)
        TriggerServerEvent("cmg2_animations:stop",target)
    end
end, false)

RegisterCommand('carry', function()
	if not piggyBackInProgress then
        piggyBackInProgress = true
        stoprun = true
        lib = 'anim@arena@celeb@flat@paired@no_props@'
        anim1 = 'piggyback_c_player_a'
        anim2 = 'piggyback_c_player_b'
        distans = -0.07
        distans2 = 0.0
        height = 0.45
        spin = 0.0		
        length = 100000
        controlFlagMe = 49
        controlFlagTarget = 33
        animFlagTarget = 1
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()
        target = GetPlayerServerId(closestPlayer)
        if distance ~= -1 and distance <= 2.0 then
            TriggerServerEvent('esx_barbie_lyftupp2:sync', closestPlayer, lib, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
        else
            ESX.ShowNotification("~r~Aucun(e) individu à proximité !")
        end
    else
        piggyBackInProgress = false
        stoprun = false
        IsLiftup = false
        ClearPedSecondaryTask(GetPlayerPed(-1))
        DetachEntity(GetPlayerPed(-1), true, false)
        local closestPlayer = GetClosestPlayer(3)
        target = GetPlayerServerId(closestPlayer)
        TriggerServerEvent("esx_barbie_lyftupp2:stop",target)
    end

end, false)

RegisterCommand('otage', function()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    DetachEntity(GetPlayerPed(-1), true, false)
    for i=1, #hostageAllowedWeapons do
        if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(hostageAllowedWeapons[i]), false) then
            canTakeHostage = true 
            foundWeapon = GetHashKey(hostageAllowedWeapons[i])
            break
        end
    end
    if not holdingHostageInProgress and canTakeHostage then		
        local player = PlayerPedId()	
        lib = 'anim@gangops@hostage@'
        anim1 = 'perp_idle'
        lib2 = 'anim@gangops@hostage@'
        anim2 = 'victim_idle'
        distans = 0.11 
        distans2 = -0.24
        height = 0.0
        spin = 0.0		
        length = 100000
        controlFlagMe = 49
        controlFlagTarget = 49
        animFlagTarget = 50
        attachFlag = true 
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()
        target = GetPlayerServerId(closestPlayer)
        if distance ~= -1 and distance <= 2.0 then
            SetCurrentPedWeapon(GetPlayerPed(-1), foundWeapon, true)
            holdingHostageInProgress = true
            holdingHostage = true 
            TriggerServerEvent('cmg3_animations2:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
        else
            ESX.ShowNotification("~r~Aucun(e) individu à proximité !")
        end 
    end
end, false)

local function releaseHostage()
	local player = PlayerPedId()	
	lib = 'reaction@shove'
	anim1 = 'shove_var_a'
	lib2 = 'reaction@shove'
	anim2 = 'shoved_back'
	distans = 0.11
	distans2 = -0.24
	height = 0.0
	spin = 0.0		
	length = 100000
	controlFlagMe = 120
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		TriggerServerEvent('cmg3_animations2:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	end
end 

local function DText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local function killHostage()
	local player = PlayerPedId()	
	lib = 'anim@gangops@hostage@'
	anim1 = 'perp_fail'
	lib2 = 'anim@gangops@hostage@'
	anim2 = 'victim_fail'
	distans = 0.11
	distans2 = -0.24 
	height = 0.0
	spin = 0.0		
	length = 0.2
	controlFlagMe = 168
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		TriggerServerEvent('cmg3_animations2:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	end	
end

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('esx_barbie_lyftupp2:syncTarget')
AddEventHandler('esx_barbie_lyftupp2:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	piggyBackInProgress = true
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	Citizen.Wait(length)
end)

RegisterNetEvent('esx_barbie_lyftupp2:syncMe')
AddEventHandler('esx_barbie_lyftupp2:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	piggyBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent('esx_barbie_lyftupp2:cl_stop')
AddEventHandler('esx_barbie_lyftupp2:cl_stop', function()
	piggyBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent('cmg3_animations2:syncTarget')
AddEventHandler('cmg3_animations2:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	if holdingHostageInProgress then 
		holdingHostageInProgress = false 
	else 
		holdingHostageInProgress = true
	end
	if beingHeldHostage then 
		beingHeldHostage = false 
	else 
		beingHeldHostage = true 
	end  
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	if attach then 
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	end
	if controlFlag == nil then controlFlag = 0 end
	if animation2 == "victim_fail" then 
		SetEntityHealth(GetPlayerPed(-1),0)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
		holdingHostageInProgress = false 
	elseif animation2 == "shoved_back" then 
		holdingHostageInProgress = false 
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false	
	end
end)

RegisterNetEvent('cmg3_animations2:syncMe')
AddEventHandler('cmg3_animations2:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	ClearPedSecondaryTask(GetPlayerPed(-1))
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	if animation == "perp_fail" then 
		SetPedShootsAtCoord(GetPlayerPed(-1), 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false 
	end
	if animation == "shove_var_a" then 
		Wait(900)
		ClearPedSecondaryTask(GetPlayerPed(-1))
		holdingHostageInProgress = false 
	end
end)

RegisterNetEvent('cmg3_animations2:cl_stop')
AddEventHandler('cmg3_animations2:cl_stop', function()
	holdingHostageInProgress = false
	beingHeldHostage = false 
	holdingHostage = false 
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

Citizen.CreateThread(function()
	while true do 
		if holdingHostage then
			if GetEntityHealth(GetPlayerPed(-1)) <= 102 then
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations2:stop",target)
				Wait(100)
				releaseHostage()
			end 
			DisableControlAction(0,24,true) 
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisablePlayerFiring(GetPlayerPed(-1),true)
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			DText3D(playerCoords.x,playerCoords.y,playerCoords.z,"Appuyez sur [G] pour relacher, [H] pour tuer")
			if IsDisabledControlJustPressed(0,47) then
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations2:stop",target)
				Wait(100)
				releaseHostage()
			elseif IsDisabledControlJustPressed(0,74) then
				holdingHostage = false
				holdingHostageInProgress = false 		
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations2:stop",target)				
				killHostage()
			end
		end
		if beingHeldHostage then 
			DisableControlAction(0,21,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(27,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
  Citizen.Wait(60000)
  while true do
    Citizen.Wait(0)
    if stoprun then
      SetPedMoveRateOverride(PlayerPedId(), 0.5)
      DisableControlAction(0, 22, true)

      if IsControlPressed(0, 21) then
        DisableControlAction(0, 21, true)
        ForcePedMotionState(PlayerPedId(), 'motionstate_walk', 0, 0, 0)
      end
    else
      Citizen.Wait(2000)
    end
  end
end)