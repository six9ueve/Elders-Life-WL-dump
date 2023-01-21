------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showMenu = false
local showCrosshair = false
local toggleCoffre = 0
local toggleCapot = 0
local toggleLocked = 0
local playing_emote = false


------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

local function callhud()
	TriggerEvent('elders_coffre:callHud')
	return
end

local function seCacherDansLeCoffre()
	TriggerEvent('elders_scripts:hideInTrunk')
	return
end


local function hasPapier(cb)
	if (ESX == nil) then return cb(0) end
	ESX.TriggerServerCallback('KorioZ-PersonalMenu:getItemAmount', function(qtty)
	  cb(qtty > 0)
	end, 'papierid')
end

-- Show crosshair (circle) when player targets entities (vehicle, pedestrian…)
local function Crosshair(enable)
	showCrosshair = enable
	SendNUIMessage({
		crosshair = enable
	})
end

-- Toggle focus (Example of Vehcile's menu)
RegisterNUICallback('disablenuifocus', function(data)
	showMenu = data.nuifocus
	SetNuiFocus(data.nuifocus, data.nuifocus)
end)

-- Toggle car trunk (Example of Vehcile's menu)
RegisterNUICallback('togglecoffre', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
		callhud()
end)
--Show ID Card to Other
--Thrylas

RegisterNUICallback('showIdCard', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			hasPapier(function (hasPapier)
				if hasPapier == true then
				
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestDistance ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
						TriggerEvent("3dme:AddMe", "~o~La personne: ~g~montre sa carte d'identitée")
					else
						ESX.ShowNotification(('Pas de joueurs à proximité'))
					end
				else
					ESX.ShowNotification('Vous n\'avez pas vos papiers')
				end
			end)
end)

--Show driver license to other
--Thrylas
RegisterNUICallback('showDriverLicense', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	hasPapier(function (hasPapier)
		if hasPapier == true then
			if closestDistance ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
				TriggerEvent("3dme:AddMe", "~o~La personne: ~g~montre son permis de conduire")
			else
				ESX.ShowNotification(('Pas de joueurs à proximité'))
			end
		else
			ESX.ShowNotification('Vous n\'avez pas vos papiers')
		end
	end)
end)
--Show medic paper to other
--Thrylas
RegisterNUICallback('showMedic', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	hasPapier(function (hasPapier)
		if hasPapier == true then
			if closestDistance ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'medic')
				TriggerEvent("3dme:AddMe", "~o~La personne: ~g~montre son Attestation médical")
			else
				ESX.ShowNotification(_U('Pas de joueurs à proximité'))
			end
		else
			ESX.ShowNotification('Vous n\'avez pas vos papiers')
		end
	end)
end)
--Show Fire arm paper to other
--Thrylas
RegisterNUICallback('showFireArm', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	hasPapier(function (hasPapier)
		if hasPapier == true then
			if closestDistance ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
				TriggerEvent("3dme:AddMe", "~o~La personne: ~g~montre son permis port d'arme")
			else
				ESX.ShowNotification(_U('Pas de joueurs à proximité'))
			end
		else
			ESX.ShowNotification('Vous n\'avez pas vos papiers')
		end
	end)
end)

local function callVehiclelock()
	TriggerEvent('god_vehiclelock:callVehiclelock')
	    return
end

local function slashTires()
	TriggerEvent('SlashTires:SlashClientTire')
	    return
end


-- Toggle car hood (Example of Vehcile's menu)
RegisterNUICallback('togglecapot', function(data)
	if(toggleCapot == 0)then
		SetVehicleDoorOpen(data.id, 4, false)
		toggleCapot = 1
	else
		SetVehicleDoorShut(data.id, 4, false)
		toggleCapot = 0
	end
end)


--RegisterNUICallback('reparation', function(data)
	--if(reparation == 0)then
		--TriggerEvent('iens:repair2')
	--else
		--TriggerEvent('iens:repair2')
	--end
--end)

--RegisterNUICallback('lock', function(data)
--		print("here")
--		TriggerServerEvent('god_vehiclelock:givekey', function(source, cb, plate))
--		TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
--	end)

-- Toggle car lock (Example of Vehcile's menu)
RegisterNUICallback('togglelock', function(data)
	if(toggleLocked == 0)then
		SetVehicleDoorsLocked(data.id, 2)
		TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 1.0)
		toggleLocked = 1
	else
		SetVehicleDoorsLocked(data.id, 0)
		TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
		toggleLocked = 0
	end
end)

-- Example of animation (Ped's menu)
RegisterNUICallback('cheer', function(data)
	local plyPed = PlayerPedId()
	if (not IsPedInAnyVehicle(plyPed)) then
		if plyPed then
			if playing_emote == false then
				TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_CHEERING', 0, true);
				playing_emote = true
			end
		end
	end
end)

RegisterNUICallback('salue', function(data)
	local plyPed = PlayerPedId()
	if (not IsPedInAnyVehicle(plyPed)) then
		if plyPed then
			if playing_emote == false then
				local lib, anim = 'gestures@m@standing@casual', 'gesture_hello'
				--TaskStartScenarioInPlace(plyPed, 'gesture_hello', 0, true);
				TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
				--playing_emote = true
			end
		end
	end
end)

--------------------------------------------
-----------------Thrylas--------------------
-------------Fait chier----------------
--------------------------------------------
RegisterNUICallback('shit', function(data)
	local plyPed = PlayerPedId()
	if (not IsPedInAnyVehicle(plyPed)) then
		if plyPed then
			if playing_emote == false then
				local lib, anim = "gestures@m@standing@casual", "gesture_damn"
				--TaskStartScenarioInPlace(plyPed, 'gesture_hello', 0, true);
				TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
				--playing_emote = true
			end
		end
	end
end)
--------------------------------------------
-----------------Thrylas--------------------
---------------------facture----------------
--------------------------------------------
RegisterNUICallback('facture', function(data)
	local plyPed = PlayerPedId()
	if (not IsPedInAnyVehicle(plyPed)) then
		if plyPed then
			if playing_emote == false then
				TaskStartScenarioInPlace(plyPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true);
				playing_emote = true
			end
		end
	end
end)


--------------------------------------------
-----------------Thrylas--------------------
-------------Clef Vehicule------------------
--------------------------------------------
RegisterNUICallback('vehicleLock', function(data)
	local plyPed = PlayerPedId()
	if (not IsPedInAnyVehicle(plyPed)) then
		if plyPed then
			showMenu = false
			SetNuiFocus(false, false)
			SendNUIMessage({
			menu = false
			})
			callVehiclelock()
		end
	end
end)

--------------------------------------------
-----------------Thrylas--------------------
-------------Crever les pneus---------------
--------------------------------------------
RegisterNUICallback('slashTires', function(data)
	TriggerEvent('SlashTires2:startgo')
end)
--------------------------------------------
-----------------Thrylas--------------------
---------Se cacher dans le coffre-----------
--------------------------------------------
RegisterNUICallback('hideInTrunk', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	seCacherDansLeCoffre()
end)
--------------------------------------------
-----------------Thrylas--------------------
---------		Machine a café-----------
--------------------------------------------

RegisterNUICallback('coffee', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerEvent('coffeMachina:Boire')
end)
--------------------------------------------
-----------------Thrylas--------------------
---------		WATER-----------
--------------------------------------------

RegisterNUICallback('water', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerEvent('WaterBank:Boire')
end)

--------------------------------------------
-----------------Thrylas--------------------
---------		TRASH-----------
--------------------------------------------

RegisterNUICallback('trash', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerEvent('trash:find', data.model)
end)

--------------------------------------------
-----------------Thrylas--------------------
---------		BANK-----------
--------------------------------------------

RegisterNUICallback('bank', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerServerEvent('aBank:requestaccount')
end)
--------------------------------------------
-----------------Thrylas--------------------
---------		friandise-----------
--------------------------------------------

RegisterNUICallback('friandise', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerEvent('distributeur:OpenMenu')
end)
--------------------------------------------
---------		TV  -----------
--------------------------------------------

RegisterNUICallback('tv', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	--TriggerEvent('distributeur:OpenMenu')
end)
--------------------------------------------
-----------------Thrylas--------------------
---------		boisson-----------
--------------------------------------------
RegisterNUICallback('boisson', function(data)
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
	menu = false
	})
	TriggerEvent('distributeur:OpenMenu2')
end)
------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------
local function CoordsFromCam(distance)
  local camRot = GetGameplayCamRot(2)
  local camCoords = GetGameplayCamCoord()

  local newRotX = camRot.x * 0.0174532924
  local newRotZ = camRot.z * 0.0174532924
  local num = math.abs(math.cos(newRotZ))

  local resultCoords = vector3(camCoords.x + (-math.sin(newRotZ)) * (num + distance), camCoords.y + (math.cos(newRotZ)) * (num + distance), camCoords.z + (math.sin(newRotX) * 8.0))

  return resultCoords
end

local function Target(ped, distance)
  local ent = nil

  local camCoords = GetGameplayCamCoord()
  local coords = CoordsFromCam(distance)
  
  local ray = StartShapeTestRay(camCoords, coords, -1, ped, 0)
  local _, _, _, _, ent = GetRaycastResult(ray)

  return ent, coords
end



Citizen.CreateThread(function()
	while true do
		local plyPed = PlayerPedId()

		local ent = Target(plyPed, 4.0)
		local entType = GetEntityType(ent)
		local allowedWeapons = {"WEAPON_KNIFE", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_SWITCHBLADE"}
		local arme = false
		local sleeping_menu = 750
			--print(GetEntityModel(ent))
			if entType == 3 and GetEntityModel(ent) == 690372739 then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'coffee',
					idEntity = ent
				})
				end
			elseif entType == 3 and (GetEntityModel(ent) == -742198632 or GetEntityModel(ent) == -1691644768) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'water',
					idEntity = ent
				})
			end
			elseif entType == 3 and (GetEntityModel(ent) == 666561306 or GetEntityModel(ent) == -130812911 or GetEntityModel(ent) == 1329570871 or GetEntityModel(ent) == 1614656839 or GetEntityModel(ent) == 1511880420 or GetEntityModel(ent) == 1437508529 or GetEntityModel(ent) == -58485588 or GetEntityModel(ent) == 651101403 or GetEntityModel(ent) == -228596739 or GetEntityModel(ent) == 218085040 or GetEntityModel(ent) == -2096124444) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'trash',
					idEntity = ent,
					model = GetEntityModel(ent)
				})
			end
			elseif entType == 3 and (GetEntityModel(ent) == -1126237515 or GetEntityModel(ent) == 506770882 or GetEntityModel(ent) == -870868698 or GetEntityModel(ent) == 150237004 or GetEntityModel(ent) == -239124254 or GetEntityModel(ent) == -1364697528) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'bank',
					idEntity = ent
				})
				end
			elseif entType == 3 and (GetEntityModel(ent) == -654402915 or GetEntityModel(ent) == -1034034125) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'friandise',
					idEntity = ent
				})
				end
			elseif entType == 3 and (GetEntityModel(ent) == 608950395) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'tv',
					idEntity = ent
				})
				end
			elseif entType == 3 and (GetEntityModel(ent) == 1114264700 or GetEntityModel(ent) == 992069095 or GetEntityModel(ent) == -1317235795) then
				sleeping_menu = 0
				Crosshair(true)
				if IsControlJustReleased(1, 38) then
					showMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({
					menu = 'boisson',
					idEntity = ent
				})
				end
			end

			if entType ~= 1 and entType ~= 2 and entType ~= 3 then
				if showCrosshair then
					Crosshair(false)
				end
				if showMenu then
					showMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({
						menu = false
					})
				end
			end

			-- Stop emotes if user press E
			-- TODO: Stop emotes if user move
			if playing_emote == true then
				if IsControlPressed(1, 38) then
					ClearPedTasks(plyPed)
					playing_emote = false
				end
			end

		Citizen.Wait(sleeping_menu)
	end
end)