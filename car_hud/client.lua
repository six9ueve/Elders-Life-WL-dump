ESX                           = nil

local ind = {l = false, r = false}

local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false
local regulateurstatus = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)
-- Function
local function GetPed()return PlayerPedId()  end
local function GetCar()return GetVehiclePedIsIn(PlayerPedId() ,false) end

local function IsCar(veh)
		    local vc = GetVehicleClass(veh)
		    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 22)
end	

local function Fwv(entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

local function regulateur()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		if not regulateurstatus then
			local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))
			if speed > 1 then
				SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), speed)
				ESX.ShowAdvancedNotification('Sécurité', 'Régulateur Voiture', 'Régulateur ~g~activé~s~ !', 'CHAR_ELDERS', 10)
				regulateurstatus = true
				SendNUIMessage({
					cruise = true,
				})
			end
		else
			SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
			regulateurstatus = false
			ESX.ShowAdvancedNotification('Sécurité', 'Régulateur Voiture', 'Régulateur ~g~désactivé~s~ !', 'CHAR_ELDERS', 10)
			SendNUIMessage({
				cruise = false,
			})
		end
	end
end

RegisterCommand('regulateur', function()
	regulateur()
end)

RegisterKeyMapping('regulateur', 'Régulateur de vitesse', 'keyboard', 'k')



Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
		if IsPedInAnyVehicle(GetPed(), false)  then 
			if car ~= 0 and (wasInCar or IsCar(car)) then
			
				wasInCar = true
				
	            if beltOn then 
					DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
					DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
				end
				
				speedBuffer[2] = speedBuffer[1]
				speedBuffer[1] = GetEntitySpeed(car)
				
				if speedBuffer[2] ~= nil 
				   and not beltOn
				   and GetEntitySpeedVector(car, true).y > 1.0  
				   and speedBuffer[1] > Cfg.MinSpeed 
				   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Cfg.DiffTrigger) then
				   
					local co = GetEntityCoords(ped)
					local fw = Fwv(ped)
					SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
					SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
					Citizen.Wait(1)
					SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				end
					
				velBuffer[2] = velBuffer[1]
				velBuffer[1] = GetEntityVelocity(car)
				if IsControlJustReleased(0, 29) then ---config touche pour la ceinture
					beltOn = not beltOn
					if beltOn then
						SendNUIMessage({
							seatbelt = true,
						})
					else
						SendNUIMessage({
							seatbelt = false,
						})
					end
				end
			elseif wasInCar then
				wasInCar = false
				beltOn = false
				speedBuffer[1], speedBuffer[2] = 0.0, 0.0
			end
		else
			Citizen.Wait(500)
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		interval = 750
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped)) then --and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), - 1) == PlayerPedId() ) then
			interval = 1
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})

				-- Lights
				_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				if(feuPosition == 0 and feuRoute == 0) then
					SendNUIMessage({
						feuPosition = false
					})
				else
					SendNUIMessage({
						feuPosition = true
					})
				end
				if(feuPosition == 1 and feuRoute == 1) then
					SendNUIMessage({
						feuRoute = true
					})
				else
					SendNUIMessage({
						feuRoute = false
					})
				end

				
				
				
				-- Turn signal
				-- SetVehicleIndicatorLights (1 left -- 0 right)
				local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				if IsControlJustPressed(1, 190) then -- Sağ Ok
					ind.l = not ind.l
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 0, ind.l)
				end
				if IsControlJustPressed(1, 189) then -- Sol Ok
					ind.r = not ind.r
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 1, ind.r)
				end

				if(VehIndicatorLight == 0) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 1) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 2) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = true,
					})
				elseif(VehIndicatorLight == 3) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = true,
					})
				end

			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end

		Citizen.Wait(interval)
	end
end)
-- Song 
Citizen.CreateThread(function()
	while true do
		interval = 5000
		local Ped = PlayerPedId()
		local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6
		
		if IsPedInAnyVehicle(Ped) and not beltOn and speed >= 20.0 then
			veh = GetVehiclePedIsIn(Ped, false)
			if GetCamActiveViewModeContext() == 1 then
				interval = 3500
				SendNUIMessage({
					transactionType = 'playSounds',
					transactionVolume = 0.3
				  })
					ESX.ShowAdvancedNotification('Sécurité', 'Alarme Voiture', '⚠️ Veuillez mettre votre ceinture !', 'CHAR_ELDERS', 10)

				  --ESX.ShowNotification('Veuillez mettre votre ceinture', 'Alarme Voiture')
			end
		end
		Citizen.Wait(interval)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		interval = 750
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped)) then
			interval = 1
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				fuel = GetVehicleFuelLevel(PedCar)
				rpm = GetVehicleCurrentRpm(PedCar)
				rpmfuel = 0
				SendNUIMessage({
			showfuel = true,
					fuel = fuel
				})
			end
		end

		Citizen.Wait(interval)
	end
end)

  --larko--

local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
-----------------
--   E D I T   --
-----------------
local driftmode = false -- on/off speed
local speed = kmh -- or mph
local drift_speed_limit = 120.0 
local toggle = 118 -- Numpad 9

-- Thread
Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        if driftmode then
            if IsPedInAnyVehicle(GetPed(), false) then
                CarSpeed = GetEntitySpeed(GetCar()) * speed

                if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then

                    if CarSpeed <= drift_speed_limit then  

                        if IsControlPressed(1, 21) then
                            Citizen.Wait(20)

                            SetVehicleReduceGrip(GetCar(), true)
        
                        else
            
                            SetVehicleReduceGrip(GetCar(), false)
        
                        end
                    end
                end
            else
                Citizen.Wait(500)
            end
        else
       	Citizen.Wait(250)
        end
    end
end)

RegisterKeyMapping('driftmd', 'Activer Drift', 'keyboard', 'INSERT')

RegisterCommand('driftmd', function()
	driftmode = not driftmode
	if driftmode then
        TriggerEvent("chatMessage", 'DRIFT', { 255,255,255}, '^2ON')
    else
        TriggerEvent("chatMessage", 'DRIFT', { 255,255,255}, '^1OFF')
    end
end)