local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX						= nil
local CurrentAction		= nil
local isReparing 		= false
local IsMecanoOnline	= false
local PlayerData		= {}
local IsMecanoOnline    = true

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

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('god_repairkit:onUse')
AddEventHandler('god_repairkit:onUse', function()
	local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) and IsPedOnFoot(playerPed)  then

			local engine = GetEntityBoneIndexByName(vehicle, 'engine')
			if vehicle == 4565506 then
				engine = 34
			end
			if engine ~= -1 then
				local coordsE = GetWorldPositionOfEntityBone(vehicle, engine)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coordsE, true) <= 2.0 then 
				SetVehicleDoorOpen(vehicle, 4,0,0)
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'
				isReparing = not isReparing
				SetTextComponentFormat('STRING')
				AddTextComponentString('Appuyez sur ~INPUT_VEH_DUCK~ pour annuler')
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				exports['progressBars']:startUI(20 * 1000, 'Reparation du moteur en cours ...')
				Citizen.Wait(20 * 1000)
				
				local explosionchance = math.random(1, 4)

				if isReparing == true then
					isReparing = not isReparing
				end
				if explosionchance == 1 then
					SetVehicleDoorShut(vehicle, 4,0,0)
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('god_repairkit:removeKit')
					ESX.ShowNotification('Réparation échouée')
				else
					if CurrentAction ~= nil then
						SetVehicleDoorShut(vehicle, 4,0,0)
						SetVehicleEngineOn(vehicle, true, true)
						ClearPedTasksImmediately(playerPed)
						TriggerServerEvent('god_repairkit:removeKit')
						SetVehicleEngineHealth(vehicle, 750.0)
						--SetVehiclePetrolTankHealth(vehicle, 550.0)
					ESX.ShowNotification('~g~Vous avez réparé votre véhicule à peu près !')
				end

				CurrentAction = nil
				TerminateThisThread()
				end
			end)

		Citizen.CreateThread(function()
			while true do
			Citizen.Wait(0)
			if IsControlJustPressed(0, Keys["X"]) and isReparing == true then
				explosionchance = 2
				ClearPedTasksImmediately(playerPed)
				SetVehicleDoorShut(vehicle, 4,0,0)
				TerminateThread(ThreadID)
				exports['progressBars']:startUI(300, 'Annulation ...')
				ESX.ShowNotification('Vous avez ~r~abandonné ~w~la réparation')
				isReparing = not isReparing
				CurrentAction = nil
				TriggerServerEvent('god_repairkit:removeKit')
			end
		end
	end)
end
end
end
end)

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {["wheel_lf"] = 0, ["wheel_rf"] = 1, ["wheel_lm1"] = 2, ["wheel_rm1"] = 3, ["wheel_lm2"] = 45,["wheel_rm2"] = 47, ["wheel_lm3"] = 46, ["wheel_rm3"] = 48, ["wheel_lr"] = 4, ["wheel_rr"] = 5,}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end


RegisterNetEvent('tyrekit:onUse')
AddEventHandler('tyrekit:onUse', function()
	--print('repair pneuD')
	local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)
	local closestTire 	= GetClosestVehicleTire(vehicle)	

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) and IsPedOnFoot(playerPed) and closestTire ~= nil then
			TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
				-- WORLD_HUMAN_WELDING

			Citizen.CreateThread(function()
				ThreadID2 = GetIdOfThisThread()
				CurrentAction = 'repair'
				isReparing = not isReparing
				SetTextComponentFormat('STRING')
				AddTextComponentString('Appuyez sur ~INPUT_VEH_DUCK~ pour annuler')
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				exports['progressBars']:startUI(20 * 1000, 'Changement de la roue ...')
				Citizen.Wait(20 * 1000)
				
				if CurrentAction ~= nil then
					SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
					SetVehicleWheelHealth(vehicle, closestTire.tireIndex, 100)
					ClearPedTasks(playerPed)
					TriggerServerEvent('god_repairkit:removeTyreKit')
					ESX.ShowNotification('~g~Vous avez change la roue de votre véhicule')
				if isReparing == true then
					isReparing = not isReparing
				end

				CurrentAction = nil
				TerminateThisThread()
			end
		end)

		Citizen.CreateThread(function()
			while true do
			Citizen.Wait(0)
			if IsControlJustPressed(0, Keys["X"]) and isReparing == true then
				ClearPedTasksImmediately(playerPed)
				TerminateThread(ThreadID2)
				exports['progressBars']:startUI(300, 'Annulation ...')
				ESX.ShowNotification('Vous avez rangé le ~r~pneu de rechange')
				isReparing = not isReparing
				CurrentAction = nil
			end
		end
	end)
end
end)
