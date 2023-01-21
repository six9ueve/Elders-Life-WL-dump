custom_price = 0

-- Create the icons on the map
function CreateIcons()
	for i, k in pairs(custom_car_blips) do
		local BlipMap = AddBlipForCoord(k.coords.x, k.coords.y, k.coords.z)
		SetBlipSprite(BlipMap, k.map_blipid) 
		SetBlipColour(BlipMap, k.map_blipcolor) 
		SetBlipScale(BlipMap, k.map_blipscale)
		SetBlipAsShortRange(BlipMap, true)
		AddTextEntry("BlipMap", k.map_blipname)
		BeginTextCommandSetBlipName("BlipMap")
		AddTextComponentSubstringBlipName(BlipMap)
		EndTextCommandSetBlipName(BlipMap)
	end
end

function getVehiclePrice(vehicle)
   return VehicleClassPrice[tostring(GetVehicleClass(vehicle_id))]
end

-- Calculates the cost of each mod
function CalculateCost()
	if DoesEntityExist(vehicle_id) then
		if vehicle_dist < ped_dist_to_vehicle then
			new_custom = GetProperVehicle(vehicle_id)
			
			custom_price_veh = getVehiclePrice(vehicle_id)
			custom_price = 0
		
			for i, k in pairs(Modifications) do
				--if k.id == 'repair' and (new_custom.bodyHealth ~= current_custom.bodyHealth or new_custom.engineHealth ~= current_custom.engineHealth or new_custom.tankHealth ~= current_custom.tankHealth) then
				--	if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				--end

				--if k.id == 'repair' and (new_custom.dirtLevel ~= current_custom.dirtLevel) then
				--	if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				--end

				if k.id == 'plateIndex' and (new_custom.plateIndex ~= current_custom.plateIndex) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'veh_color' and (new_custom.color1 ~= current_custom.color1) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end
				
				if k.id == 'veh_color' and (new_custom.color2 ~= current_custom.color2) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'veh_color' and (new_custom.Rcolor_primary ~= current_custom.Rcolor_primary and new_custom.Gcolor_primary ~= current_custom.Gcolor_primary and new_custom.Bcolor_primary ~= current_custom.Bcolor_primary) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'veh_color' and (new_custom.Rcolor_secondary ~= current_custom.Rcolor_secondary and new_custom.Gcolor_secondary ~= current_custom.Gcolor_secondary and new_custom.Bcolor_secondary ~= current_custom.Bcolor_secondary) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'pearlescent_color' and (new_custom.pearlescentColor ~= current_custom.pearlescentColor) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'wheel_color' and (new_custom.wheelColor ~= current_custom.wheelColor) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'dashboard_color' and (new_custom.DashboardColor ~= current_custom.DashboardColor) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'interior_color' and (new_custom.InteriorColor ~= current_custom.InteriorColor) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'wheels' and (new_custom.wheels ~= current_custom.wheels) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'wheels' and (new_custom.customtires1 ~= current_custom.customtires1) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'wheels' and (new_custom.customtires2 ~= current_custom.customtires2) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'windows_tint' and (new_custom.windowTint ~= current_custom.windowTint) then CheckValuesMoney(k, new_custom.windowTint) end

				if k.id == 'xenon_colors' and (new_custom.xenonColor ~= current_custom.xenonColor) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'neon_color' and (new_custom.neonEnabled[1] ~= current_custom.neonEnabled[1] or new_custom.neonEnabled[2] ~= current_custom.neonEnabled[2] or new_custom.neonEnabled[3] ~= current_custom.neonEnabled[3] or new_custom.neonEnabled[4] ~= current_custom.neonEnabled[4]) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'neon_color' and (new_custom.neonColor[1] ~= current_custom.neonColor[1] and new_custom.neonColor[2] ~= current_custom.neonColor[2] and new_custom.neonColor[3] ~= current_custom.neonColor[3]) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['1'] ~= current_custom.extras['1']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['2'] ~= current_custom.extras['2']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['3'] ~= current_custom.extras['3']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['4'] ~= current_custom.extras['4']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['5'] ~= current_custom.extras['5']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['6'] ~= current_custom.extras['6']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['7'] ~= current_custom.extras['7']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['8'] ~= current_custom.extras['8']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['9'] ~= current_custom.extras['9']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['10'] ~= current_custom.extras['10']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['11'] ~= current_custom.extras['11']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'extras' and (new_custom.extras['12'] ~= current_custom.extras['12']) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'tyres_smoke' and (new_custom.tyreSmokeColor[1] ~= current_custom.tyreSmokeColor[1] and new_custom.tyreSmokeColor[2] ~= current_custom.tyreSmokeColor[2] and new_custom.tyreSmokeColor[3] ~= current_custom.tyreSmokeColor[3]) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 0 and (new_custom.modSpoilers ~= current_custom.modSpoilers) then CheckValuesMoney(k, new_custom.modSpoilers) end
				if k.id == 1 and (new_custom.modFrontBumper ~= current_custom.modFrontBumper) then CheckValuesMoney(k, new_custom.modFrontBumper) end
				if k.id == 2 and (new_custom.modRearBumper ~= current_custom.modRearBumper) then CheckValuesMoney(k, new_custom.modRearBumper) end
				if k.id == 3 and (new_custom.modSideSkirt ~= current_custom.modSideSkirt) then CheckValuesMoney(k, new_custom.modSideSkirt) end
				if k.id == 4 and (new_custom.modExhaust ~= current_custom.modExhaust) then CheckValuesMoney(k, new_custom.modExhaust) end
				if k.id == 5 and (new_custom.modFrame ~= current_custom.modFrame) then CheckValuesMoney(k, new_custom.modFrame) end
				if k.id == 6 and (new_custom.modGrille ~= current_custom.modGrille) then CheckValuesMoney(k, new_custom.modGrille) end
				if k.id == 7 and (new_custom.modHood ~= current_custom.modHood) then CheckValuesMoney(k, new_custom.modHood) end
				if k.id == 8 and (new_custom.modFender ~= current_custom.modFender) then CheckValuesMoney(k, new_custom.modFender) end
				if k.id == 9 and (new_custom.modRightFender ~= current_custom.modRightFender) then CheckValuesMoney(k, new_custom.modRightFender) end
				if k.id == 10 and (new_custom.modRoof ~= current_custom.modRoof) then CheckValuesMoney(k, new_custom.modRoof) end
				if k.id == 11 and (new_custom.modEngine ~= current_custom.modEngine) then CheckValuesMoney(k, new_custom.modEngine) end
				if k.id == 12 and (new_custom.modBrakes ~= current_custom.modBrakes) then CheckValuesMoney(k, new_custom.modBrakes) end
				if k.id == 13 and (new_custom.modTransmission ~= current_custom.modTransmission) then CheckValuesMoney(k, new_custom.modTransmission) end
				if k.id == 14 and (new_custom.modHorns ~= current_custom.modHorns) then CheckValuesMoney(k, new_custom.modHorns) end
				if k.id == 15 and (new_custom.modSuspension ~= current_custom.modSuspension) then CheckValuesMoney(k, new_custom.modSuspension) end
				if k.id == 16 and (new_custom.modArmor ~= current_custom.modArmor) then CheckValuesMoney(k, new_custom.modArmor) end

				if k.id == 'turbo' and (new_custom.modTurbo ~= current_custom.modTurbo) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == "tyres_smoke" and (new_custom.modSmokeEnabled ~= current_custom.modSmokeEnabled) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 'xenon_colors' and (new_custom.modXenon ~= current_custom.modXenon) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 23 and (new_custom.modFrontWheels ~= current_custom.modFrontWheels) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 24 and (new_custom.modBackWheels ~= current_custom.modBackWheels) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end

				if k.id == 25 and (new_custom.modPlateHolder ~= current_custom.modPlateHolder) then CheckValuesMoney(k, new_custom.modPlateHolder) end
				if k.id == 26 and (new_custom.modVanityPlate ~= current_custom.modVanityPlate) then CheckValuesMoney(k, new_custom.modVanityPlate) end
				if k.id == 27 and (new_custom.modTrimA ~= current_custom.modTrimA) then CheckValuesMoney(k, new_custom.modTrimA) end
				if k.id == 28 and (new_custom.modOrnaments ~= current_custom.modOrnaments) then CheckValuesMoney(k, new_custom.modOrnaments) end
				if k.id == 29 and (new_custom.modDashboard ~= current_custom.modDashboard) then CheckValuesMoney(k, new_custom.modDashboard) end
				if k.id == 30 and (new_custom.modDial ~= current_custom.modDial) then CheckValuesMoney(k, new_custom.modDial) end
				if k.id == 31 and (new_custom.modDoorSpeaker ~= current_custom.modDoorSpeaker) then CheckValuesMoney(k, new_custom.modDoorSpeaker) end
				if k.id == 32 and (new_custom.modSeats ~= current_custom.modSeats) then CheckValuesMoney(k, new_custom.modSeats) end
				if k.id == 33 and (new_custom.modSteeringWheel ~= current_custom.modSteeringWheel) then CheckValuesMoney(k, new_custom.modSteeringWheel) end
				if k.id == 34 and (new_custom.modShifterLeavers ~= current_custom.modShifterLeavers) then CheckValuesMoney(k, new_custom.modShifterLeavers) end
				if k.id == 35 and (new_custom.modAPlate ~= current_custom.modAPlate) then CheckValuesMoney(k, new_custom.modAPlate) end
				if k.id == 36 and (new_custom.modSpeakers ~= current_custom.modSpeakers) then CheckValuesMoney(k, new_custom.modSpeakers) end
				if k.id == 37 and (new_custom.modTrunk ~= current_custom.modTrunk) then CheckValuesMoney(k, new_custom.modTrunk) end
				if k.id == 38 and (new_custom.modHydrolic ~= current_custom.modHydrolic) then CheckValuesMoney(k, new_custom.modHydrolic) end
				if k.id == 39 and (new_custom.modEngineBlock ~= current_custom.modEngineBlock) then CheckValuesMoney(k, new_custom.modEngineBlock) end
				if k.id == 40 and (new_custom.modAirFilter ~= current_custom.modAirFilter) then CheckValuesMoney(k, new_custom.modAirFilter) end
				if k.id == 41 and (new_custom.modStruts ~= current_custom.modStruts) then CheckValuesMoney(k, new_custom.modStruts) end
				if k.id == 42 and (new_custom.modArchCover ~= current_custom.modArchCover) then CheckValuesMoney(k, new_custom.modArchCover) end
				if k.id == 43 and (new_custom.modAerials ~= current_custom.modAerials) then CheckValuesMoney(k, new_custom.modAerials) end	
				if k.id == 44 and (new_custom.modTrimB ~= current_custom.modTrimB) then CheckValuesMoney(k, new_custom.modTrimB) end
				if k.id == 45 and (new_custom.modTank ~= current_custom.modTank) then CheckValuesMoney(k, new_custom.modTank) end
				if k.id == 46 and (new_custom.modWindows ~= current_custom.modWindows) then CheckValuesMoney(k, new_custom.modWindows) end
				
				if k.id == 48 and (new_custom.modLivery ~= current_custom.modLivery) then
					if CustomFree then custom_price = 'Free' else custom_price = custom_price + (k.price * custom_price_veh) end
				end
			end
		end
	end
end

function CheckValuesMoney(k, vet)
	if CustomFree then custom_price = 'Free' 
	else 
		if k.levelprice and #k.levelprice > vet+1 and tonumber(k.levelprice[vet+2]) ~= -1 then
			custom_price = custom_price + (tonumber(k.levelprice[vet+2]) * custom_price_veh)
		else
			custom_price = custom_price + (k.price * custom_price_veh) 
		end
	end
end

-- Set the mods in the vehicle
function SetProperVehicle(vehicle, mods)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

		SetVehicleModKit(vehicle, 0)

		if mods.plate then SetVehicleNumberPlateText(vehicle, mods.plate) end
		if mods.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, mods.plateIndex) end
		if mods.bodyHealth then SetVehicleBodyHealth(vehicle, mods.bodyHealth + 0.0) end
		if mods.engineHealth then SetVehicleEngineHealth(vehicle, mods.engineHealth + 0.0) end
		if mods.tankHealth then SetVehiclePetrolTankHealth(vehicle, mods.tankHealth + 0.0) end
		if mods.fuelLevel then SetVehicleFuelLevel(vehicle, mods.fuelLevel + 0.0) end
		if mods.dirtLevel then SetVehicleDirtLevel(vehicle, mods.dirtLevel + 0.0) end
		
		SetVehicleColours(vehicle, mods.color1, mods.color2) 

        if mods.Rcolor_primary and mods.Gcolor_primary and mods.Bcolor_primary then
            SetVehicleCustomPrimaryColour(vehicle, mods.Rcolor_primary, mods.Gcolor_primary, mods.Bcolor_primary)
        end
        
        if mods.Rcolor_secondary and mods.Gcolor_secondary and mods.Bcolor_secondary then 
            SetVehicleCustomSecondaryColour(vehicle, mods.Rcolor_secondary, mods.Gcolor_secondary, mods.Bcolor_secondary)
        end
		
        if mods.pearlescentColor then 
			SetVehicleExtraColours(vehicle, mods.pearlescentColor, mods.wheelColor) 
		end

		if mods.wheelColor then 
			SetVehicleExtraColours(vehicle, mods.pearlescentColor, mods.wheelColor) 
		end

		if mods.wheels then SetVehicleWheelType(vehicle, mods.wheels) end

		if mods.DashboardColor then SetVehicleDashboardColor(vehicle, mods.DashboardColor) end
		if mods.InteriorColor then SetVehicleInteriorColor(vehicle, mods.InteriorColor) end

		if mods.windowTint or mods.windowTint == -1 then 
			if mods.windowTint == -1 then
				SetVehicleWindowTint(vehicle, 0) 
			else
				SetVehicleWindowTint(vehicle, mods.windowTint) 
			end
		end

		if mods.neonEnabled then
			SetVehicleNeonLightEnabled(vehicle, 0, mods.neonEnabled[1])
			SetVehicleNeonLightEnabled(vehicle, 1, mods.neonEnabled[2])
			SetVehicleNeonLightEnabled(vehicle, 2, mods.neonEnabled[3])
			SetVehicleNeonLightEnabled(vehicle, 3, mods.neonEnabled[4])
		end

		if mods.extras then
			for extraId,enabled in pairs(mods.extras) do
				if enabled then
					SetVehicleExtra(vehicle, tonumber(extraId), 0)
				else
					SetVehicleExtra(vehicle, tonumber(extraId), 1)
				end
			end
		end

		if mods.neonColor then SetVehicleNeonLightsColour(vehicle, mods.neonColor[1], mods.neonColor[2], mods.neonColor[3]) end
		if mods.xenonColor then SetVehicleXenonLightsColour(vehicle, mods.xenonColor) end
		if mods.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
		if mods.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, mods.tyreSmokeColor[1], mods.tyreSmokeColor[2], mods.tyreSmokeColor[3]) end
		if mods.modSpoilers then SetVehicleMod(vehicle, 0, mods.modSpoilers, false) end
		if mods.modFrontBumper then SetVehicleMod(vehicle, 1, mods.modFrontBumper, false) end
		if mods.modRearBumper then SetVehicleMod(vehicle, 2, mods.modRearBumper, false) end
		if mods.modSideSkirt then SetVehicleMod(vehicle, 3, mods.modSideSkirt, false) end
		if mods.modExhaust then SetVehicleMod(vehicle, 4, mods.modExhaust, false) end
		if mods.modFrame then SetVehicleMod(vehicle, 5, mods.modFrame, false) end
		if mods.modGrille then SetVehicleMod(vehicle, 6, mods.modGrille, false) end
		if mods.modHood then SetVehicleMod(vehicle, 7, mods.modHood, false) end
		if mods.modFender then SetVehicleMod(vehicle, 8, mods.modFender, false) end
		if mods.modRightFender then SetVehicleMod(vehicle, 9, mods.modRightFender, false) end
		if mods.modRoof then SetVehicleMod(vehicle, 10, mods.modRoof, false) end
		if mods.modEngine then SetVehicleMod(vehicle, 11, mods.modEngine, false) end
		if mods.modBrakes then SetVehicleMod(vehicle, 12, mods.modBrakes, false) end
		if mods.modTransmission then SetVehicleMod(vehicle, 13, mods.modTransmission, false) end
		if mods.modHorns then SetVehicleMod(vehicle, 14, mods.modHorns, false) end
		if mods.modSuspension then SetVehicleMod(vehicle, 15, mods.modSuspension, false) end
		if mods.modArmor then SetVehicleMod(vehicle, 16, mods.modArmor, false) end
		if mods.modTurbo then ToggleVehicleMod(vehicle,  18, mods.modTurbo) end
		if mods.modXenon then ToggleVehicleMod(vehicle,  22, mods.modXenon) end
		if mods.modFrontWheels then SetVehicleMod(vehicle, 23, mods.modFrontWheels, mods.customtires1) end
		if mods.modBackWheels then SetVehicleMod(vehicle, 24, mods.modBackWheels, mods.customtires2) end
		if mods.modPlateHolder then SetVehicleMod(vehicle, 25, mods.modPlateHolder, false) end
		if mods.modVanityPlate then SetVehicleMod(vehicle, 26, mods.modVanityPlate, false) end
		if mods.modTrimA then SetVehicleMod(vehicle, 27, mods.modTrimA, false) end
		if mods.modOrnaments then SetVehicleMod(vehicle, 28, mods.modOrnaments, false) end
		if mods.modDashboard then SetVehicleMod(vehicle, 29, mods.modDashboard, false) end
		if mods.modDial then SetVehicleMod(vehicle, 30, mods.modDial, false) end
		if mods.modDoorSpeaker then SetVehicleMod(vehicle, 31, mods.modDoorSpeaker, false) end
		if mods.modSeats then SetVehicleMod(vehicle, 32, mods.modSeats, false) end
		if mods.modSteeringWheel then SetVehicleMod(vehicle, 33, mods.modSteeringWheel, false) end
		if mods.modShifterLeavers then SetVehicleMod(vehicle, 34, mods.modShifterLeavers, false) end
		if mods.modAPlate then SetVehicleMod(vehicle, 35, mods.modAPlate, false) end
		if mods.modSpeakers then SetVehicleMod(vehicle, 36, mods.modSpeakers, false) end
		if mods.modTrunk then SetVehicleMod(vehicle, 37, mods.modTrunk, false) end
		if mods.modHydrolic then SetVehicleMod(vehicle, 38, mods.modHydrolic, false) end
		if mods.modEngineBlock then SetVehicleMod(vehicle, 39, mods.modEngineBlock, false) end
		if mods.modAirFilter then SetVehicleMod(vehicle, 40, mods.modAirFilter, false) end
		if mods.modStruts then SetVehicleMod(vehicle, 41, mods.modStruts, false) end
		if mods.modArchCover then SetVehicleMod(vehicle, 42, mods.modArchCover, false) end
		if mods.modAerials then SetVehicleMod(vehicle, 43, mods.modAerials, false) end
		if mods.modTrimB then SetVehicleMod(vehicle, 44, mods.modTrimB, false) end
		if mods.modTank then SetVehicleMod(vehicle, 45, mods.modTank, false) end
		if mods.modWindows then SetVehicleMod(vehicle, 46, mods.modWindows, false) end

		if mods.modLivery then
			SetVehicleMod(vehicle, 48, mods.modLivery, false)
			SetVehicleLivery(vehicle, mods.modLivery)
		end
	end
end

-- Get all the properties of the vehicle mods
function GetProperVehicle(vehicle)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)

        local r_color_primary, g_color_primary, b_color_primary = GetVehicleCustomPrimaryColour(vehicle)
        local r_color_secondary, g_color_secondary, b_color_secondary = GetVehicleCustomSecondaryColour(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

		local extras = {}
		for extraId=0, 12 do
			if DoesExtraExist(vehicle, extraId) then
				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
				extras[tostring(extraId)] = state
			end
		end

		local modlivery = GetVehicleLivery(vehicle)
		if modlivery == -1 then
			modlivery = GetVehicleMod(vehicle, 48)
		end

		return {
			model = GetEntityModel(vehicle),

			plate = RemoveSymbols(GetVehicleNumberPlateText(vehicle)),
			plateIndex = GetVehicleNumberPlateTextIndex(vehicle),

			bodyHealth = MathRound(GetVehicleBodyHealth(vehicle), 2), --MathRound(GetVehicleBodyHealth(vehicle), 1),
			engineHealth = MathRound(GetVehicleEngineHealth(vehicle), 2), --MathRound(GetVehicleEngineHealth(vehicle), 1),
			tankHealth = MathRound(GetVehiclePetrolTankHealth(vehicle), 2), --MathRound(GetVehiclePetrolTankHealth(vehicle), 1),

			fuelLevel = MathRound(GetVehicleFuelLevel(vehicle), 1),
			dirtLevel = MathRound(GetVehicleDirtLevel(vehicle), 1),

			color1 = colorPrimary,
			color2 = colorSecondary,

            Rcolor_primary = r_color_primary,
            Gcolor_primary = g_color_primary,
            Bcolor_primary = b_color_primary,
            
            Rcolor_secondary = r_color_secondary,
            Gcolor_secondary = g_color_secondary,
            Bcolor_secondary = b_color_secondary,

			pearlescentColor  = pearlescentColor,
			wheelColor        = wheelColor,

			wheels = GetVehicleWheelType(vehicle),
			customtires1 =	GetVehicleModVariation(vehicle, 23),
			customtires2 =	GetVehicleModVariation(vehicle, 24),
			windowTint = GetVehicleWindowTint(vehicle),
			xenonColor = GetVehicleXenonLightsColour(vehicle),

			neonEnabled = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},

			neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras = extras,
			tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers = GetVehicleMod(vehicle, 0),
			modFrontBumper = GetVehicleMod(vehicle, 1),
			modRearBumper = GetVehicleMod(vehicle, 2),
			modSideSkirt = GetVehicleMod(vehicle, 3),
			modExhaust = GetVehicleMod(vehicle, 4),
			modFrame = GetVehicleMod(vehicle, 5),
			modGrille = GetVehicleMod(vehicle, 6),
			modHood = GetVehicleMod(vehicle, 7),
			modFender = GetVehicleMod(vehicle, 8),
			modRightFender = GetVehicleMod(vehicle, 9),
			modRoof = GetVehicleMod(vehicle, 10),

			modEngine = GetVehicleMod(vehicle, 11),
			modBrakes = GetVehicleMod(vehicle, 12),
			modTransmission = GetVehicleMod(vehicle, 13),
			modHorns = GetVehicleMod(vehicle, 14),
			modSuspension = GetVehicleMod(vehicle, 15),
			modArmor = GetVehicleMod(vehicle, 16),

			modTurbo = IsToggleModOn(vehicle, 18),
			modSmokeEnabled = IsToggleModOn(vehicle, 20),
			modXenon = IsToggleModOn(vehicle, 22),

			modFrontWheels = GetVehicleMod(vehicle, 23),
			modBackWheels = GetVehicleMod(vehicle, 24),

			modPlateHolder = GetVehicleMod(vehicle, 25),
			modVanityPlate = GetVehicleMod(vehicle, 26),
			modTrimA = GetVehicleMod(vehicle, 27),
			modOrnaments = GetVehicleMod(vehicle, 28),
			modDashboard = GetVehicleMod(vehicle, 29),
			modDial = GetVehicleMod(vehicle, 30),
			modDoorSpeaker = GetVehicleMod(vehicle, 31),
			modSeats = GetVehicleMod(vehicle, 32),
			modSteeringWheel = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate = GetVehicleMod(vehicle, 35),
			modSpeakers = GetVehicleMod(vehicle, 36),
			modTrunk = GetVehicleMod(vehicle, 37),
			modHydrolic = GetVehicleMod(vehicle, 38),
			modEngineBlock = GetVehicleMod(vehicle, 39),
			modAirFilter = GetVehicleMod(vehicle, 40),
			modStruts = GetVehicleMod(vehicle, 41),
			modArchCover = GetVehicleMod(vehicle, 42),
			modAerials = GetVehicleMod(vehicle, 43),
			modTrimB = GetVehicleMod(vehicle, 44),
			modTank = GetVehicleMod(vehicle, 45),
			modWindows = GetVehicleMod(vehicle, 46),
			modLivery = modlivery,

			DashboardColor = GetVehicleDashboardColor(vehicle),
			InteriorColor = GetVehicleInteriorColor(vehicle)
		}
	else
		return
	end
end

-- Check if the mod exists in the vehicle, otherwise it does not appear in nui
function GetModsExist()
    for k, v in pairs(Modifications) do
        if v.id ~= '' and tonumber(v.id) then
			v.enable = true

            if tonumber(v.id) ~= 48 and (GetNumVehicleMods(vehicle_id, tonumber(v.id)) - 1) == -1 then
                v.enable = false
			elseif (tonumber(v.id) == 48 and GetVehicleLiveryCount(vehicle_id) == -1) and (GetNumVehicleMods(vehicle_id, tonumber(v.id)) - 1) == -1 then -- Liverys
				v.enable = false
            end
        end
    end
end

-- Send the min and max of mods pro nui
function GetMinMaxMods(min, max) 
    SendNUIMessage({
        ui = "GetMinMaxMods",
        min_max_mods = { min, max },
    })
end

-- Display notification blip
function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel (0, 0, 1, -1)
end

-- Remove all symbols from a text
function RemoveSymbols(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

-- Round a number
function MathRound(value, numDecimalPlaces) 
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end