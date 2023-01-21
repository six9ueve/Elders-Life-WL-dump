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

local pPed = PlayerPedId()
local pIsInVeh = false
local pVeh = 0
local pSpeed = 0

Citizen.CreateThread(function()
	while true do
		pPed = PlayerPedId()
		pIsInVeh = IsPedInAnyVehicle(pPed, false)
		if pIsInVeh then
			pVeh = GetVehiclePedIsIn(pPed, 0)
			pSpeed = GetEntitySpeed(pPed) * 3.6
		end

		Wait(250)
	end
end)

Citizen.CreateThread(function()
	while true do
		if pIsInVeh then
			if pSpeed >= 10 then
				if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlJustReleased(0, 172) then
					if IsThisModelABicycle(GetEntityModel(pVeh)) or IsThisModelABike(GetEntityModel(pVeh)) then
						RequestAnimDict('rcmextreme2atv')
						while not HasAnimDictLoaded('rcmextreme2atv') do
							Citizen.Wait(100)
						end
						TaskPlayAnim(pPed, 'rcmextreme2atv', 'idle_e', -1, -1, -1, 32, 0, 0, 0, 0)
					end	
				end

				if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlJustReleased(0, 173) then
					if IsThisModelABicycle(GetEntityModel(pVeh)) or IsThisModelABike(GetEntityModel(pVeh))  then
						RequestAnimDict('rcmextreme2atv')
						while not HasAnimDictLoaded('rcmextreme2atv') do
							Citizen.Wait(100)
						end
						TaskPlayAnim(pPed, 'rcmextreme2atv', 'idle_d', -1, -1, -1, 32, 0, 0, 0, 0)
					end	
				end

				if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlJustReleased(0, 174) then
					if IsThisModelABicycle(GetEntityModel(pVeh)) or IsThisModelABike(GetEntityModel(pVeh)) then
						RequestAnimDict('rcmextreme2atv')
						while not HasAnimDictLoaded('rcmextreme2atv') do
							Citizen.Wait(100)
						end
						TaskPlayAnim(pPed, 'rcmextreme2atv', 'idle_b', -1, -1, -1, 32, 0, 0, 0, 0)
					end	
				end

				if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlJustReleased(0, 175) then
					if IsThisModelABicycle(GetEntityModel(pVeh)) or IsThisModelABike(GetEntityModel(pVeh)) then
						RequestAnimDict('rcmextreme2atv')
						while not HasAnimDictLoaded('rcmextreme2atv') do
							Citizen.Wait(100)
						end
						TaskPlayAnim(pPed, 'rcmextreme2atv', 'idle_c', -1, -1, -1, 32, 0, 0, 0, 0)
					end	
				end
				Wait(1)
			else
				Wait(100)
			end
		else
			Wait(200)
		end
	end
end)