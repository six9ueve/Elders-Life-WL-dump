ESX                     = nil
local hasBeenFlashedRecently = false
local blips = {}
local playerCoords = vector3(0, 0, 0)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function GetCurrentKMHSpeed()
	return GetEntitySpeed(PlayerPedId()) * 3.6
end

RegisterNetEvent('god_speedradar:toggleRadars')
AddEventHandler('god_speedradar:toggleRadars', function()
	if #blips == 0 then
		TriggerEvent('god_speedradar:displayRadars')
	else
		TriggerEvent('god_speedradar:hideRadars')
	end
end)

RegisterNetEvent('god_speedradar:displayRadars')
AddEventHandler('god_speedradar:displayRadars', function()
	if #blips > 0 then return end

	for RadarId,Radar in pairs(ConfigRadar.Radars) do
		local blipRadar = AddBlipForCoord(Radar.Pos)
		SetBlipAlpha(blipRadar, 120)
		SetBlipAsShortRange(blipRadar, true)
		SetBlipDisplay(blipRadar, 2)
		SetBlipSprite(blipRadar, 163)
		SetBlipColour(blipRadar, 17)
		SetBlipScale(blipRadar, 1.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Radars Fixes')
		EndTextCommandSetBlipName(blipRadar)
		table.insert(blips, blipRadar)
	end
end)

RegisterNetEvent('god_speedradar:hideRadars')
AddEventHandler('god_speedradar:hideRadars', function()
	for _, blip in pairs(blips) do
		RemoveBlip(blip)
	end
	blips = {}
end)

RegisterNetEvent('god_speedradar:syncRadars')
AddEventHandler('god_speedradar:syncRadars', function(destroyedRadars)
	for radarId, destroyed in pairs(destroyedRadars) do
		ConfigRadar.Radars[radarId].Destroyed = destroyed
	end
end)

RegisterNetEvent('god_speedradar:SendBilll')
AddEventHandler('god_speedradar:SendBilll', function(xPlayer)
		--print('xPlayer',xPlayer)
     TriggerServerEvent('god_billing:sendBill', xPlayer, 'society_police', 'Radar Automatique', ConfigRadar.BillPrice)
end)

Citizen.CreateThread(function()
	TriggerServerEvent('god_speedradar:requestSyncRadars')
	print(destroyedRadars)
	while true do
		for RadarId,Radar in pairs(ConfigRadar.Radars) do
			if Radar.PropPos and #(playerCoords - Radar.PropPos) < 40 then
				if not Radar.Destroyed then
					DrawMarker(42, Radar.PropPos.x, Radar.PropPos.y, Radar.PropPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 230, 72, 72, 150, false, false, 2, true, nil, nil, false)

					if Radar.PropPos and HasBulletImpactedInArea(Radar.PropPos.x, Radar.PropPos.y, Radar.PropPos.z - 1.0, 1.0, 2, 1) then
						TriggerServerEvent('god_speedradar:destroyedRadar', RadarId)
					end
				else
					ESX.Game.Utils.DrawText3D(Radar.PropPos - vector3(0, 0, 0.3), '~r~Radar détruit !', 1.0)
				end
			end
		end
		Citizen.Wait(0)
	end
end)
-- Radar System
Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId(), true)

		if IsPedInAnyVehicle(PlayerPedId()) then
			for RadarId,Radar in pairs(ConfigRadar.Radars) do
				if not Radar.Destroyed and #(playerCoords - Radar.Pos) < Radar.Range then
					if GetCurrentKMHSpeed() > Radar.MinSpeed then
						if not hasBeenFlashedRecently then
							StartScreenEffect('SwitchShortMichaelIn',  400,  false)
							local Vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

							if GetPedInVehicleSeat(Vehicle, -1) == PlayerPedId() then
								local VehiclePlate = GetVehicleNumberPlateText(Vehicle)
								local VehicleModel = GetEntityModel(Vehicle)
								local VehicleModelName = GetDisplayNameFromVehicleModel(VehicleModel)

								local IsEmergencyVehicle = false

								for _,AnyModel in pairs(ConfigRadar.WhiteListedModels) do
									if AnyModel == VehicleModel then IsEmergencyVehicle = true end
								end

								if not IsEmergencyVehicle then
									hasBeenFlashedRecently = true

									--ESX.TriggerServerCallback('god_controlvehicle:myKey', function(gotKey)
									--	if gotKey then
											TriggerServerEvent('god_speedradar:flashed', VehiclePlate, GetCurrentKMHSpeed(), VehicleModelName, RadarId)
									--	end
									--end, VehiclePlate)

									Citizen.SetTimeout(20 * 1000, function()
										hasBeenFlashedRecently = false
									end)
								end
							end
						end
					end
				elseif #(playerCoords - Radar.Pos) < Radar.Range * 3 and #blips > 0 and GetCurrentKMHSpeed() > Radar.MinSpeed then
					ESX.ShowNotification('~r~Attention zone de radar (' .. Radar.MinSpeed .. 'km/h) !')
				end
			end
		else
			Citizen.Wait(3000)
		end

		Citizen.Wait(500)
	end
end)