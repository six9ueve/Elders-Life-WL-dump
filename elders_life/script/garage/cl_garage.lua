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

local carInstance = {}
local PlayerData  = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

local function exitmarker()
	RageUI.CloseAll()
	isMenuOpened = false
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

local function DoesAPlayerDrivesCar(plate)
	local isVehicleTaken = false
	local players  = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

local function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps.vehicleHeadLight then SetVehicleHeadlightsColour(vehicle, vehicleProps.vehicleHeadLight) end
	
end

local function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 9 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)

        return vehicleProps
	else
		return nil
    end
end

local function SpawnVehicleMecano(vehicleProps, garage)


	ESX.Game.SpawnVehicle(vehicleProps.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehicleProps)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			SetVehicleDoorsLocked(callback_vehicle, 0)
		end)
	TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, false)
end

local function SpawnVehicle(vehicleProps, garage, KindOfVehicle)
	ESX.Game.SpawnVehicle(vehicleProps.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 0.5											
		},garage.SpawnPoint.Heading, function(callback_vehicle)
		 	ESX.Game.SetVehicleProperties(callback_vehicle, vehicleProps)
			SetVehicleFixed(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehicleProps)
			SetVehicleDeformationFixed(callback_vehicle)
            SetVehicleEngineHealth(callback_vehicle, vehicleProps.engineHealth)
			SetVehicleDoorsLocked(callback_vehicle, 0)
			SetVehicleFuelLevel(callback_vehicle,vehicleProps.fuelLevel)
			SetModelAsNoLongerNeeded(vehicleProps.model)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			local carplate = GetVehicleNumberPlateText(callback_vehicle)
			table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})	
		end)
	TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, false)
end

local function OpenMenuGarage(garage, KindOfVehicle, garage_name, vehicle_type)
	ESX.PlayerData = ESX.GetPlayerData()

	if garage_name == "police_row" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end

	if garage_name == "police_airport" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end

	if garage_name == "sheriff_airport" then
		garage_name = "sheriff" 
		KindOfVehicle = "sheriff" 
	end

	if garage_name == "sheriff_sandy" then
		garage_name = "sheriff" 
		KindOfVehicle = "sheriff" 
	end

	if garage_name == "ambulance_sandy" then
		garage_name = "ambulance" 
		KindOfVehicle = "ambulance" 
	end

	if garage_name == "ambulance_paleto" then
		garage_name = "ambulance" 
		KindOfVehicle = "ambulance" 
	end

	if garage_name == "police_davis" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end

	if KindOfVehicle ~= "personal" then
		if (ESX.PlayerData.job.name == garage_name or ESX.PlayerData.job2.name == garage_name) then
		    if isMenuOpened then return end
		    isMenuOpened = true

		    RageUI.Visible(RMenu:Get("garage", "pointjaune"), true)

		    Citizen.CreateThread(function()
		        while isMenuOpened do
		            RageUI.IsVisible(RMenu:Get("garage", "pointjaune"),true,true,true,function()
		            	RageUI.ButtonWithStyle("~g~Retour véhicule Perso ("..ConfigGarage.Price.."$)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                        ESX.TriggerServerCallback('eden_garage:getOutVehicles2', function(vehicles)
		                        	tablevehicles = {}
									if not table.empty(vehicles) then
										tablevehicles = vehicles
									else
										tablevehicles = nil
									end
								end, KindOfVehicle, garage_name, vehicle_type)
		                    end
		                end, RMenu:Get("garage", "pointjaunesoc")) 
		                RageUI.ButtonWithStyle("Retour véhicule Job ("..ConfigGarage.Price.."$)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                        ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
		                        	tablevehicles = {}
									if not table.empty(vehicles) then
										tablevehicles = vehicles
									else
										tablevehicles = nil
									end
								end, KindOfVehicle, garage_name, vehicle_type)
		                    end
		                end, RMenu:Get("garage", "pointjaunesoc"))
		                end, function()end, 1)
		            RageUI.IsVisible(RMenu:Get("garage", "pointjaunesoc"),true,true,true,function()
		                if tablevehicles ~= nil then
		                    for k, v in pairs(tablevehicles) do
		                    	local vehicleProps2 = json.decode(v.vehicle)
								local vehicleHash2 = vehicleProps2.model
		                    	if v.vehiclename then
									vehicleName2 = v.vehiclename					
								else
									vehicleName2 = GetDisplayNameFromVehicleModel(vehicleHash2)
								end
								local plateveh2 = vehicleProps2.plate
		                        RageUI.ButtonWithStyle(vehicleName2, nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                            if s then
		                            	local doesVehicleExist = false
										for k,v in pairs (carInstance) do
											if ESX.Math.Trim(v.plate) == ESX.Math.Trim(plateveh2) then
												if DoesEntityExist(v.vehicleentity) then
													doesVehicleExist = true
												else
													table.remove(carInstance, k)
													doesVehicleExist = false
												end
											end
										end
										if not doesVehicleExist and not DoesAPlayerDrivesCar(plateveh2) then
											ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
												if hasEnoughMoney then
													RageUI.CloseAll()
													isMenuOpened = false
													SpawnVehicle(vehicleProps2, garage, KindOfVehicle)
												else
													ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas assez d\'argent', 'CHAR_ELDERS', 10)
												end
											end, ConfigGarage.Price)
										else
											ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas sortir ce véhicule. Allez la chercher!', 'CHAR_ELDERS', 10)
										end
		                            end
		                        end)
		                    end
		                else
		                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
	                            if s then
	                            	RageUI.CloseAll()
	                            	isMenuOpened = false
	                            end
	                        end)
		                end
	            	end, function()end, 1)
		            Wait(0)
		        end
		    end)
		else
			ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas accès à ce garage', 'CHAR_ELDERS', 10)
		end									
	else
		if isMenuOpened then return end
	    isMenuOpened = true

	    RageUI.Visible(RMenu:Get("garage", "pointjaune"), true)

	    Citizen.CreateThread(function()
	        while isMenuOpened do
	            RageUI.IsVisible(RMenu:Get("garage", "pointjaune"),true,true,true,function()
	            	RageUI.ButtonWithStyle("Retour véhicule ("..ConfigGarage.Price.."$)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then   
	                        ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
	                        	tablevehicles = {}
								if not table.empty(vehicles) then
									tablevehicles = vehicles
								else
									tablevehicles = nil
								end
							end, KindOfVehicle, garage_name, vehicle_type)
	                    end
	                end, RMenu:Get("garage", "pointjauneperso")) 
	                end, function()end, 1)
	            RageUI.IsVisible(RMenu:Get("garage", "pointjauneperso"),true,true,true,function()
		                if tablevehicles ~= nil then
		                    for k, v in pairs(tablevehicles) do
		                    	local vehicleProps = json.decode(v.vehicle)
								local vehicleHash = vehicleProps.model
		                    	if v.vehiclename then
									vehicleName = v.vehiclename					
								else
									vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
								end
								local plateveh = vehicleProps.plate
		                        RageUI.ButtonWithStyle(vehicleName, nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                            if s then
		                            	local doesVehicleExist = false
										for k,v in pairs (carInstance) do
											if ESX.Math.Trim(v.plate) == ESX.Math.Trim(plateveh) then
												if DoesEntityExist(v.vehicleentity) then
													doesVehicleExist = true
												else
													table.remove(carInstance, k)
													doesVehicleExist = false
												end
											end
										end
										if not doesVehicleExist and not DoesAPlayerDrivesCar(plateveh) then
											ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
												if hasEnoughMoney then
													RageUI.CloseAll()
													isMenuOpened = false
													SpawnVehicle(vehicleProps, garage, KindOfVehicle)
												else
													ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas assez d\'argent', 'CHAR_ELDERS', 10)
												end
											end, ConfigGarage.Price)
										else
											ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas sortir ce véhicule. Allez la chercher!', 'CHAR_ELDERS', 10)
										end
		                            end
		                        end)
		                    end
		                else
		                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
	                            if s then
	                            	RageUI.CloseAll()
	                            	isMenuOpened = false
	                            end
	                        end)
		                end
	            	end, function()end, 1)
	            Wait(0)
	        end
	    end)
	end
end

local function ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)
	ESX.PlayerData = ESX.GetPlayerData()

	if garage_name == "police_row" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end

	if garage_name == "police_airport" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end

	if garage_name == "sheriff_airport" then
		garage_name = "sheriff" 
		KindOfVehicle = "sheriff" 
	end

	if garage_name == "ambulance_sandy" then
		garage_name = "ambulance" 
		KindOfVehicle = "ambulance" 
	end

	if garage_name == "ambulance_paleto" then
		garage_name = "ambulance" 
		KindOfVehicle = "ambulance" 
	end

	if garage_name == "sheriff_sandy" then
		garage_name = "sheriff" 
		KindOfVehicle = "sheriff" 
	end

	if garage_name == "police_davis" then
		garage_name = "police" 
		KindOfVehicle = "police" 
	end
	if KindOfVehicle ~= "personal" then
		if (ESX.PlayerData.job.name == garage_name or ESX.PlayerData.job2.name == garage_name) then	
			if isMenuOpened then return end
		    isMenuOpened = true

		    RageUI.Visible(RMenu:Get("garage", "pointvert"), true)

		    ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
            	tablevehicles = {}
				if not table.empty(vehicles) then
					tablevehicles = vehicles
				else
					tablevehicles = nil
				end
			end, KindOfVehicle, garage_name, vehicle_type)

			Citizen.Wait(250)

		    Citizen.CreateThread(function()
	        while isMenuOpened do
	            RageUI.IsVisible(RMenu:Get("garage", "pointvert"),true,true,true,function()
	            	RageUI.ButtonWithStyle('~g~Véhicule perso', nil, {RightLabel = ""}, true,function(a,h,s)
                        if s then
                        	ESX.TriggerServerCallback('eden_garage:getVehicles2', function(vehicles2)
			            	tablevehicles2 = {}
							if not table.empty(vehicles2) then
								tablevehicles2 = vehicles2
							else
								tablevehicles2 = nil
							end
						end, KindOfVehicle, garage_name, vehicle_type)
                        end
                    end, RMenu:Get("garage", "pointvertperso"))
	                if tablevehicles ~= nil then
	                    for k, v in pairs(tablevehicles) do
	                    	local vehicleProps = json.decode(v.vehicle)
							local vehicleHash = vehicleProps.model
	                    	if v.vehiclename then
								vehicleName = v.vehiclename					
							else
								vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							if v.fourrieremecano then
								vehicleLabel = vehicleName..': ' .. ('pound_name')
							elseif v.stored then
								vehicleLabel = vehicleName..': ' .. 'Rentré' .." ("..v.garage_name..")"
							else
								vehicleLabel = vehicleName..': ' .. 'Sortie' .. " ("..v.garage_name..")"
							end
	                        RageUI.ButtonWithStyle(vehicleLabel, nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                            if s then
	                            	plateveh = v.plate
									fourriere = v.fourrieremecano
									garagevoit = v.garage_name
									storedvoit = v.stored
									CarProps = json.decode(v.vehicle)
	                            end
	                        end, RMenu:Get("garage", "pointvertchoice"))
	                    end
	                else
	                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                            if s then
                            	RageUI.CloseAll()
                            	isMenuOpened = false
                            end
                        end)
	                end
	                if ESX.PlayerData.group == 'superadmin' or ESX.PlayerData.group == 'admin' then
						RageUI.ButtonWithStyle('Vider le garage', nil, {RightLabel = ""}, true,function(a,h,s)
                            if s then
                            	local msg = KeyboardInput("atmos", "Vider le garage (OUI)", "", 4)
		                        if msg == 'OUI' then
		                        	RageUI.CloseAll()
	                            	isMenuOpened = false
	                            	TriggerServerEvent('eden_garage:removeallVehicles', garage_name)                                
		                        end
                            end
                        end)
					end
	            end, function()end, 1)
	            RageUI.IsVisible(RMenu:Get("garage", "pointvertchoice"),true,true,true,function()
	            	RageUI.ButtonWithStyle('Sortir le véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                        if s then
                    	    local doesVehicleExist = false
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(plateveh) then
									if DoesEntityExist(v.vehicleentity) then
										doesVehicleExist = true
									else
										table.remove(carInstance, k)
										doesVehicleExist = false
									end
								end
							end
							if (doesVehicleExist) or DoesAPlayerDrivesCar(plateveh) then
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas sortir ce véhicule. Allez la chercher!!', 'CHAR_ELDERS', 10)
							elseif (fourriere) then
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le véhicule est rentré dans la fourrière.', 'CHAR_ELDERS', 10)
							elseif garage_name ~= garagevoit then
								local msg = KeyboardInput("atmos", "Transferer (OUI) $"..tostring(ConfigGarage.SwitchGaragePrice), "", 100)
		                        if msg == 'OUI' then
		                        	transfert = true
		                        	ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
										if hasEnoughMoney then
											TriggerServerEvent("god_eden_garage:MoveGarage",plateveh, garage_name)
											SpawnVehicle(CarProps, garage, KindOfVehicle)
											RageUI.CloseAll()
											isMenuOpened = false
										else
											ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas assez d\'argent !', 'CHAR_ELDERS', 10)
										end
									end, ConfigGarage.SwitchGaragePrice)                                
		                        end
		                    elseif (storedvoit) and not transfert then
								SpawnVehicle(CarProps, garage, KindOfVehicle)
								RageUI.CloseAll()
								isMenuOpened = false
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Votre véhicule est déjà sorti', 'CHAR_ELDERS', 10)
							end
							transfert = false
                        end
                    end)
                    RageUI.ButtonWithStyle('Renommer le véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                        if s then
                        	local msg = KeyboardInput("atmos", "Renommer :", "", 100)
	                        if msg and msg ~= "" then
                        		TriggerServerEvent('eden_garage:renamevehicle', plateveh, msg)
								RageUI.CloseAll()
								isMenuOpened = false
								ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le nom du véhicule ne peut pas être vide', 'CHAR_ELDERS', 10)
							end
                        end
                    end)
            	end, function()end, 1)
            	RageUI.IsVisible(RMenu:Get("garage", "pointvertperso"),true,true,true,function()
	            	if tablevehicles2 ~= nil then
	                    for k, v in pairs(tablevehicles2) do
	                    	local vehicleProps = json.decode(v.vehicle)
							local vehicleHash = vehicleProps.model
	                    	if v.vehiclename then
								vehicleName = v.vehiclename					
							else
								vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							if v.fourrieremecano then
								vehicleLabel = vehicleName..': ' .. ('pound_name')
							elseif v.stored then
								vehicleLabel = vehicleName..': ' .. 'Rentré' .." ("..v.garage_name..")"
							else
								vehicleLabel = vehicleName..': ' .. 'Sortie' .. " ("..v.garage_name..")"
							end
	                        RageUI.ButtonWithStyle(vehicleLabel, nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                            if s then
	                            	local doesVehicleExist = false
									for k,v in pairs (carInstance) do
										if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
											if DoesEntityExist(v.vehicleentity) then
												doesVehicleExist = true
											else
												table.remove(carInstance, k)
												doesVehicleExist = false
											end
										end
									end
									if (doesVehicleExist) or DoesAPlayerDrivesCar(vehicleProps.plate) then
										ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas sortir ce véhicule. Allez la chercher!!', 'CHAR_ELDERS', 10)
									elseif (v.fourrieremecano) then
										ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le véhicule est rentré dans la fourrière.', 'CHAR_ELDERS', 10)
									elseif (v.stored) then
										SpawnVehicle(vehicleProps, garage, KindOfVehicle)
										RageUI.CloseAll()
                            			isMenuOpened = false
									else
										ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Votre véhicule est déjà sorti', 'CHAR_ELDERS', 10)
									end
	                            end
	                        end)
	                    end
	                else
	                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                            if s then
                            	RageUI.CloseAll()
                            	isMenuOpened = false
                            end
                        end)
	                end
            	end, function()end, 1)
	            Wait(0)
	        end
	    end)
		else
			ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas accès à ce garage', 'CHAR_ELDERS', 10)
		end
	else
		if isMenuOpened then return end
	    isMenuOpened = true

	    RageUI.Visible(RMenu:Get("garage", "pointvert"), true)

	    ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
        	tablevehicles = {}
			if not table.empty(vehicles) then
				tablevehicles = vehicles
			else
				tablevehicles = nil
			end
		end, KindOfVehicle, garage_name, vehicle_type)

		Citizen.Wait(250)

	    Citizen.CreateThread(function()
	        while isMenuOpened do
	            RageUI.IsVisible(RMenu:Get("garage", "pointvert"),true,true,true,function()
	                if tablevehicles ~= nil then
	                    for k, v in pairs(tablevehicles) do
	                    	local vehicleProps = json.decode(v.vehicle)
							local vehicleHash = vehicleProps.model
	                    	if v.vehiclename then
								vehicleName = v.vehiclename					
							else
								vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							if v.fourrieremecano then
								vehicleLabel = vehicleName..': ' .. ('pound_name')
							elseif v.stored then
								vehicleLabel = vehicleName..': ' .. 'Rentré' .." ("..v.garage_name..")"
							else
								vehicleLabel = vehicleName..': ' .. 'Sortie' .. " ("..v.garage_name..")"
							end
	                        RageUI.ButtonWithStyle(vehicleLabel, nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                            if s then
	                            	plateveh = v.plate
									fourriere = v.fourrieremecano
									garagevoit = v.garage_name
									storedvoit = v.stored
									CarProps = json.decode(v.vehicle)
	                            end
	                        end, RMenu:Get("garage", "pointvertchoice"))
	                    end
	                else
	                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                            if s then
                            	RageUI.CloseAll()
                            	isMenuOpened = false
                            end
                        end)
	                end
	            end, function()end, 1)
	            RageUI.IsVisible(RMenu:Get("garage", "pointvertchoice"),true,true,true,function()
	            	RageUI.ButtonWithStyle('Sortir le véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                        if s then
                    	    local doesVehicleExist = false
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(plateveh) then
									if DoesEntityExist(v.vehicleentity) then
										doesVehicleExist = true
									else
										table.remove(carInstance, k)
										doesVehicleExist = false
									end
								end
							end
							if (doesVehicleExist) or DoesAPlayerDrivesCar(plateveh) then
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas sortir ce véhicule. Allez la chercher!!', 'CHAR_ELDERS', 10)
							elseif (fourriere) then
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le véhicule est rentré dans la fourrière.', 'CHAR_ELDERS', 10)
							elseif garage_name ~= garagevoit then
								local msg = KeyboardInput("atmos", "Transferer (OUI) $"..tostring(ConfigGarage.SwitchGaragePrice), "", 100)
		                        if msg == 'OUI' then
		                        	transfert = true
		                        	ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
										if hasEnoughMoney then
											TriggerServerEvent("god_eden_garage:MoveGarage",plateveh, garage_name)
											SpawnVehicle(CarProps, garage, KindOfVehicle)
											RageUI.CloseAll()
											isMenuOpened = false
										else
											ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous n\'avez pas assez d\'argent !', 'CHAR_ELDERS', 10)
										end
									end, ConfigGarage.SwitchGaragePrice)                                
		                        end
		                    elseif (storedvoit) and not transfert then
								SpawnVehicle(CarProps, garage, KindOfVehicle)
								RageUI.CloseAll()
								isMenuOpened = false
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Votre véhicule est déjà sorti', 'CHAR_ELDERS', 10)
							end
							transfert = false
                        end
                    end)
                    RageUI.ButtonWithStyle('Renommer le véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                        if s then
                        	local msg = KeyboardInput("atmos", "Renommer :", "", 100)
	                        if msg and msg ~= "" then
                        		TriggerServerEvent('eden_garage:renamevehicle', plateveh, msg)
								RageUI.CloseAll()
								isMenuOpened = false
								ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le nom du véhicule ne peut pas être vide', 'CHAR_ELDERS', 10)
							end
                        end
                    end)
            	end, function()end, 1)
	            Wait(0)
	        end
	    end)
	end
end

local function ListVehiclesFourriereMenu(garage)
	ESX.PlayerData = ESX.GetPlayerData()
	job = ESX.PlayerData.job.name

	if job == 'police' or job == 'sheriff' then

		ESX.TriggerServerCallback('eden_garage:getVehiclesMecano', function(vehicles)
        	tablevehicles = {}
			if not table.empty(vehicles) then
				tablevehicles = vehicles
			else
				tablevehicles = nil
			end
		end, KindOfVehicle, garage_name, vehicle_type)

		Citizen.Wait(400)

	    if isMenuOpened then return end
	    isMenuOpened = true

	    RageUI.Visible(RMenu:Get("garage", "fourrieremecano"), true)

	    Citizen.CreateThread(function()
	        while isMenuOpened do
	            --[[RageUI.IsVisible(RMenu:Get("garage", "fourrieremecano"),true,true,true,function()
	            	RageUI.ButtonWithStyle("Voir les véhicules", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                        ESX.TriggerServerCallback('eden_garage:getVehiclesMecano', function(vehicles)
	                        	tablevehicles = {}
								if not table.empty(vehicles) then
									tablevehicles = vehicles
								else
									tablevehicles = nil
								end
							end, KindOfVehicle, garage_name, vehicle_type)
	                    end
	                end, RMenu:Get("garage", "fourrieremecanochoice")) 
	            end, function()end, 1)]]--
	            RageUI.IsVisible(RMenu:Get("garage", "fourrieremecano"),true,true,true,function()
	                if tablevehicles ~= nil then
	                    for k, v in pairs(tablevehicles) do
	                    	local vehicleProps = json.decode(v.vehicle)
							local vehicleHash = vehicleProps.model
	                    	if v.vehiclename then
								vehicleName = v.vehiclename					
							else
								vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							local plateveh = vehicleProps.plate
							if v.owner ~= nil then
								if string.match(v.owner, 'steam:') then
									label = vehicleName..' '..v.firstname..' '..v.lastname
								else
									label = vehicleName..' Plaque : '..vehicleProps.plate
								end
							else
								label = vehicleName..' Plaque : '..vehicleProps.plate
							end
	                        RageUI.ButtonWithStyle(label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                            if s then
	                            	RageUI.CloseAll()
                            		isMenuOpened = false
	                            	SpawnVehicleMecano(vehicleProps, garage)
									TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, false)
	                            end
	                        end)
	                    end
	                else
	                	RageUI.ButtonWithStyle('Aucun Véhicule', nil, {RightLabel = ""}, true,function(a,h,s)
                            if s then
                            	RageUI.CloseAll()
                            	isMenuOpened = false
                            end
                        end)
	                end
            	end, function()end, 1)
	            Wait(0)
	        end
	    end)
	else
		ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas accéder vous même à la fourrière, contactez LSPD ou BCSO', 'CHAR_ELDERS', 10)
		--ESX.ShowNotification('Vous ne pouvez pas accéder vous même à la fourrière, contactez un garagiste')
	end
end

local function StockVehicleMenu(KindOfVehicle, garage_name, vehicle_type)
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
				if trailerProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(trailerProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(TrailerHandle)
							TriggerServerEvent('eden_garage:modifystate', trailerProps.plate, true)
							TriggerServerEvent("god_eden_garage:MoveGarage", trailerProps.plate, garage_name)
							ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Votre remorque est dans le garage', 'CHAR_ELDERS', 10)
						else
							ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas stocker ce véhicule', 'CHAR_ELDERS', 10)
						end
					end,trailerProps, KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Véhicule non existant', 'CHAR_ELDERS', 10)
				end
			else
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				if vehicleProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(vehicle)
							TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, true)
							TriggerServerEvent("god_eden_garage:MoveGarage", vehicleProps.plate, garage_name)
							ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Votre véhicule est dans le garage', 'CHAR_ELDERS', 10)
						else
							ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas stocker ce véhicule', 'CHAR_ELDERS', 10)
						end
					end,ESX.Game.GetVehicleProperties(vehicle), KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Véhicule non existant', 'CHAR_ELDERS', 10)
				end
			end
		else
			ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous etes pas conducteur du vehicule', 'CHAR_ELDERS', 10)
		end
	else
		ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Il n\' y a pas de vehicule à rentrer', 'CHAR_ELDERS', 10)
	end
end

local function StockVehicleFourriereMenu()
	ESX.PlayerData = ESX.GetPlayerData()
	job = ESX.PlayerData.job.name
	if job == 'police' or job == 'sheriff' or job == 'mechanic' or job == 'mechanic2' or job == 'mechanic3' or job == 'mechanic4' or job == 'mechanic5' then
		local playerPed  = PlayerPedId()
		if IsPedInAnyVehicle(playerPed,  false) then
			local vehicle =GetVehiclePedIsIn(playerPed,false)
			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
				if GotTrailer then
					local trailerProps  = GetVehicleProperties(TrailerHandle)
					if trailerProps ~= nil then
						ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
							if(valid) then
								DeleteVehicle(TrailerHandle)
								TriggerServerEvent('eden_garage:ChangeStateFrompound', trailerProps, true)
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'La remorque est rentré dans la fourrière', 'CHAR_ELDERS', 10)
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas stocker cette remorque dans la fourrière', 'CHAR_ELDERS', 10)
							end
						end,trailerProps)
					else
						ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Véhicule non existant', 'CHAR_ELDERS', 10)
					end
				else
					local vehicleProps  = GetVehicleProperties(vehicle)
					if vehicleProps ~= nil then
						ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
							if(valid) then
								DeleteVehicle(vehicle)
								TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, true)
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Le véhicule est rentré dans la fourrière', 'CHAR_ELDERS', 10)
							else
								ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas stocker cette remorque dans la fourrière', 'CHAR_ELDERS', 10)
							end
						end,vehicleProps)
					else
						ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Véhicule non existant', 'CHAR_ELDERS', 10)
					end
				end
			else
				ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous etes pas conducteur du véhicule', 'CHAR_ELDERS', 10)
			end
		else
			ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Il n\' y a pas de vehicule à rentrer', 'CHAR_ELDERS', 10)
		end
	else
		ESX.ShowAdvancedNotification('Elders Life', '~b~Garage', 'Vous ne pouvez pas déposer de véhicule dans la fourrière', 'CHAR_ELDERS', 10)
	end
end

Citizen.CreateThread(function()
    for k,v in pairs(ConfigGarage.Garages) do
    	local kblip = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
        SetBlipSprite (kblip, 524)
        SetBlipDisplay(kblip, 4)
        SetBlipScale  (kblip, 0.6)
        SetBlipColour (kblip, 30)
        SetBlipAsShortRange(kblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(kblip)
    end
    for k,v in pairs(ConfigGarage.GaragesMecano) do
    	local kblip1 = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
        SetBlipSprite (kblip1, 357)
        SetBlipDisplay(kblip1, 4)
        SetBlipScale  (kblip1, 0.6)
        SetBlipColour (kblip1, 30)
        SetBlipAsShortRange(kblip1, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Fourrière")
        EndTextCommandSetBlipName(kblip1)
    end
    for k,v in pairs(ConfigGarage.BoatGarages) do
    	local kblip10 = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
        SetBlipSprite (kblip10, 410)
        SetBlipDisplay(kblip10, 4)
        SetBlipScale  (kblip10, 0.6)
        SetBlipColour (kblip10, 30)
        SetBlipAsShortRange(kblip10, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage Bateau")
        EndTextCommandSetBlipName(kblip10)
    end
    for k,v in pairs(ConfigGarage.AirplaneGarages) do
    	local kblip100 = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
        SetBlipSprite (kblip100, 423)
        SetBlipDisplay(kblip100, 4)
        SetBlipScale  (kblip100, 0.6)
        SetBlipColour (kblip100, 30)
        SetBlipAsShortRange(kblip100, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage Avion")
        EndTextCommandSetBlipName(kblip100)
    end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	PlayerData = ESX.GetPlayerData()
	PlayerData.job = job
end)

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job2)
	PlayerData = ESX.GetPlayerData()
	PlayerData.job2 = job2
end)

RMenu.Add("garage", "pointjaune", RageUI.CreateMenu("Garage", "~b~Choix :", nil, nil, "aLib", "black"))
RMenu:Get("garage", "pointjaune").Closed = function()
    isMenuOpened = false
end

RMenu.Add("garage", "pointjauneperso", RageUI.CreateSubMenu(RMenu:Get("garage", "pointjaune"), "Garage", "~b~Vehicule :"))
RMenu:Get("garage", "pointjauneperso").Closed = function()end

RMenu.Add("garage", "pointjaunesoc", RageUI.CreateSubMenu(RMenu:Get("garage", "pointjaune"), "Garage", "~b~Vehicule :"))
RMenu:Get("garage", "pointjaunesoc").Closed = function()end

RMenu.Add("garage", "fourrieremecano", RageUI.CreateMenu("Fourriere", "~b~Vehicule :", nil, nil, "aLib", "black"))
RMenu:Get("garage", "fourrieremecano").Closed = function()
    isMenuOpened = false
end

RMenu.Add("garage", "fourrieremecanochoice", RageUI.CreateSubMenu(RMenu:Get("garage", "fourrieremecano"), "Fourriere", "~b~Vehicule :"))
RMenu:Get("garage", "fourrieremecanochoice").Closed = function()end

RMenu.Add("garage", "pointvert", RageUI.CreateMenu("Garage", "~b~Vehicule :", nil, nil, "aLib", "black"))
RMenu:Get("garage", "pointvert").Closed = function()
    isMenuOpened = false
end

RMenu.Add("garage", "pointvertchoice", RageUI.CreateSubMenu(RMenu:Get("garage", "pointvert"), "Garage", "~b~Choix :"))
RMenu:Get("garage", "pointvertchoice").Closed = function()end

RMenu.Add("garage", "pointvertperso", RageUI.CreateSubMenu(RMenu:Get("garage", "pointvert"), "Garage", "~b~Choix :"))
RMenu:Get("garage", "pointvertperso").Closed = function()end


--- garage societe

RegisterNetEvent('god_eden_garage:ListVehiclesMenu')
AddEventHandler('god_eden_garage:ListVehiclesMenu', function(garage, society, societygarage)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		ListVehiclesMenu(garage, society, societygarage, "car")
	end
end)

RegisterNetEvent('god_eden_garage:OpenMenuGarage')
AddEventHandler('god_eden_garage:OpenMenuGarage', function(garage, society, societygarage)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		OpenMenuGarage(garage, society, societygarage, "car")
	end
end)

RegisterNetEvent('god_eden_garage:StockVehicleMenu')
AddEventHandler('god_eden_garage:StockVehicleMenu', function(society, societygarage)
	StockVehicleMenu(society, societygarage, "car")
end)


Citizen.CreateThread(function()
	Citizen.Wait(5000)
	while true do				
		local coords = GetEntityCoords(PlayerPedId())			
		local inter = 500
		for k,v in pairs(ConfigGarage.Garages) do
			if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(36, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Marker.w, v.SpawnPoint.Marker.h, 1.0, v.SpawnPoint.Marker.r, v.SpawnPoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)	
				if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) <= 4) then 
                	inter = 0
					if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesMenu(v, "personal", k, "car")
					end
                end  
			end	
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(24, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.w, v.Marker.h, 1.0, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, false, false, false)
					if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= 4) then 
                		inter = 0
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							OpenMenuGarage(v, "personal", k, "car")
						end
                	end	
			end	
			if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(20, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Marker.w, v.DeletePoint.Marker.h, 1.0, v.DeletePoint.Marker.r, v.DeletePoint.Marker.g, v.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) <= 4) then 
                		inter = 0
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleMenu("personal", k, "car")
						end
                	end	
			end	
		end	

		for k,v in pairs(ConfigGarage.GaragesMecano) do
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'mechanic2' or PlayerData.job.name == 'mechanic3' or PlayerData.job.name == 'mechanic4' or PlayerData.job.name == 'mechanic5' then	
				if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < 10) then	
					inter = 4				
					DrawMarker(36, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Marker.w, v.SpawnPoint.Marker.h, 1.0, v.SpawnPoint.Marker.r, v.SpawnPoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								ListVehiclesFourriereMenu(v)
							end
                		end  
				end	
				if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < 10) then	
					inter = 4				
					DrawMarker(20, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Marker.w, v.DeletePoint.Marker.h, 1.0, v.DeletePoint.Marker.r, v.DeletePoint.Marker.g, v.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)
						if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
								StockVehicleFourriereMenu()
							end
                		end  	
				end	
			end		
		end

		for k,v in pairs(ConfigGarage.BoatGarages) do
			if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(36, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Marker.w, v.SpawnPoint.Marker.h, 1.0, v.SpawnPoint.Marker.r, v.SpawnPoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								ListVehiclesMenu(v, "personal", k, "boat")
							end
                		end 
			end	
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(24, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.w, v.Marker.h, 1.0, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								OpenMenuGarage(v, "personal", k, "boat")
							end
                		end
			end	
			if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(20, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Marker.w, v.DeletePoint.Marker.h, 1.0, v.DeletePoint.Marker.r, v.DeletePoint.Marker.g, v.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
								StockVehicleMenu("personal", k, "boat")
							end
                	end
			end			
		end

		for k,v in pairs(ConfigGarage.AirplaneGarages) do
			if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(36, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Marker.w, v.SpawnPoint.Marker.h, 1.0, v.SpawnPoint.Marker.r, v.SpawnPoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								ListVehiclesMenu(v, "personal", k, "airplane")
							end
                		end 
			end	
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(24, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.w, v.Marker.h, 1.0, v.Marker.r, v.Marker.g, v.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								OpenMenuGarage(v, "personal", k, "airplane")
							end
                		end 
			end	
			if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < 10) then	
				inter = 4				
				DrawMarker(20, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Marker.w, v.DeletePoint.Marker.h, 1.0, v.DeletePoint.Marker.r, v.DeletePoint.Marker.g, v.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)	
						if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) <= 4) then 
                			inter = 0
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
								StockVehicleMenu("personal", k, "airplane")
							end
                		end 
			end			
		end

		for k,v in pairs(ConfigGarage.SocietyGarages) do
			--if k == PlayerData.job.name or k == PlayerData.job2.name then
				for key, value in pairs (v) do
					if(GetDistanceBetweenCoords(coords, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(36, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.SpawnPoint.Marker.w, value.SpawnPoint.Marker.h, 1.0, value.SpawnPoint.Marker.r, value.SpawnPoint.Marker.g, value.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)
							if (GetDistanceBetweenCoords(coords, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
									ListVehiclesMenu(value, k, k, "car")
								end
	                		end 	
					end
					if(GetDistanceBetweenCoords(coords, value.Pos.x, value.Pos.y, value.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(24, value.Pos.x, value.Pos.y, value.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.Marker.w, value.Marker.h, 1.0, value.Marker.r, value.Marker.g, value.Marker.b, 100, false, true, 2, false, false, false, false)
							if (GetDistanceBetweenCoords(coords, value.Pos.x, value.Pos.y, value.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
									OpenMenuGarage(value, k, k, "car")
								end
	                		end 	
					end	
					if(GetDistanceBetweenCoords(coords, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(20, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.DeletePoint.Marker.w, value.DeletePoint.Marker.h, 1.0, value.DeletePoint.Marker.r, value.DeletePoint.Marker.g, value.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)	
							if (GetDistanceBetweenCoords(coords, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
									StockVehicleMenu(k, k, "car")
								end
	                		end 
					end	
				end		
			--end
		end
		for k,v in pairs(ConfigGarage.SocietyGaragesAir) do
			--if k == PlayerData.job.name or k == PlayerData.job2.name then
				for key, value in pairs (v) do
					if(GetDistanceBetweenCoords(coords, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(36, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.SpawnPoint.Marker.w, value.SpawnPoint.Marker.h, 1.0, value.SpawnPoint.Marker.r, value.SpawnPoint.Marker.g, value.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)	
							if (GetDistanceBetweenCoords(coords, value.SpawnPoint.Pos.x, value.SpawnPoint.Pos.y, value.SpawnPoint.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
									ListVehiclesMenu(value, k, k, "airplane")
								end
	                		end 
					end
					if(GetDistanceBetweenCoords(coords, value.Pos.x, value.Pos.y, value.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(24, value.Pos.x, value.Pos.y, value.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.Marker.w, value.Marker.h, 1.0, value.Marker.r, value.Marker.g, value.Marker.b, 100, false, true, 2, false, false, false, false)	
							if (GetDistanceBetweenCoords(coords, value.Pos.x, value.Pos.y, value.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
									OpenMenuGarage(value, k, k, "airplane")
								end
	                		end 
					end	
					if(GetDistanceBetweenCoords(coords, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, true) < 10) then	
						inter = 4				
						DrawMarker(20, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.DeletePoint.Marker.w, value.DeletePoint.Marker.h, 1.0, value.DeletePoint.Marker.r, value.DeletePoint.Marker.g, value.DeletePoint.Marker.b, 100, false, true, 2, false, false, false, false)
							if (GetDistanceBetweenCoords(coords, value.DeletePoint.Pos.x, value.DeletePoint.Pos.y, value.DeletePoint.Pos.z, true) <= 4) then 
	                			inter = 0
								if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
									StockVehicleMenu(k, k, "airplane")
								end
	                		end 	
					end	
				end	
			--end	
		end

		Citizen.Wait(inter)
	end
end)