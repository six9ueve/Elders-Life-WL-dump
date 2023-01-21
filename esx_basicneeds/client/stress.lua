ESX          = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(15000)
	while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()

        TriggerEvent('god_status:getStatus', 'stress', function(status)
			StressVal = status.val
        end)

        if StressVal == 1000000 then -- max StressVal
			SetTimecycleModifier("WATER_silty") -- hafif blurlanır ve görüş düşer // a bit blur and vision distance reduce
			SetTimecycleModifierStrength(1)
		else
			ClearExtraTimecycleModifier()
		end

        if StressVal >= 900000 then
			local veh = GetVehiclePedIsUsing(ped)
		  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then -- eğer oyuncu araçtaysa ve ayrıca o aracı kullanıyorsa // if ped "driving" a vehicle
				Citizen.Wait(1000)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.25) -- kamera sallanmaları // cam shake
				TaskVehicleTempAction(ped, veh, 7, 250) -- aracı hafif sola kırma // turn left a bit
				Citizen.Wait(500)
				TaskVehicleTempAction(ped, veh, 8, 250) -- aracı hafif sağa kırma // turn right a bit
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.25)
				Citizen.Wait(500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.25)
		  	else
				Citizen.Wait(1500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.25)
		  	end
		elseif StressVal >= 800000 then
			local veh = GetVehiclePedIsUsing(ped)
		  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then
				Citizen.Wait(1000)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.18)
				TaskVehicleTempAction(ped, veh, 7, 150)
				Citizen.Wait(500)
				TaskVehicleTempAction(ped, veh, 8, 150)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.18)
				Citizen.Wait(500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.18)
		  	else
				Citizen.Wait(1500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.18)
		  	end
		elseif StressVal >= 700000 then
			local veh = GetVehiclePedIsUsing(ped)
		  	if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(veh, -1) == ped then
				Citizen.Wait(1000)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.14)
				TaskVehicleTempAction(ped, veh, 7, 100)
				Citizen.Wait(500)
				TaskVehicleTempAction(ped, veh, 8, 100)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.14)
				Citizen.Wait(500)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.14)
		  	else
				Citizen.Wait(2000)
				ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.14)
		  	end
		elseif StressVal >= 600000 then -- %60 altındayken araç sürüşüne bir etkisi olmuyor // Below ½60 no effect to driving
			Citizen.Wait(2500) -- sıklık // frequency
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.12) -- efekt // effect
		elseif StressVal >= 500000 then
			Citizen.Wait(3500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.10)
		--[[elseif StressVal >= 350000 then
			Citizen.Wait(5500)
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
		elseif StressVal >= 200000 then
			Citizen.Wait(6500)
            ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.05)
        elseif StressVal >= 100000 then
			Citizen.Wait(6500)
            ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.03)]]--
        else
            Citizen.Wait(3000)
        end
    end
end)

Citizen.CreateThread(function() -- Nişan almak // Aiming with a weapon
    while true do
        local ped = PlayerPedId()
        local status = GetPedConfigFlag(ped, 78, 1)

        if status then
            TriggerEvent("god_status:add", "stress", 150)
            Citizen.Wait(5000)
        else
            Citizen.Wait(250)
        end
    end
end)

Citizen.CreateThread(function() -- Elinde silah tutarken (melee ve patlayıcılar kategorisi hariç) // Holding a weapon (except melee and explosives category)
    while true do
        local ped = PlayerPedId()
        local status = IsPedArmed(ped, 4)

        if status then
            TriggerEvent("god_status:add", "stress", 80)
            Citizen.Wait(15000)
        else
            Citizen.Wait(250)
        end
    end
end)

Citizen.CreateThread(function() -- Ateş ederken // While shooting
    while true do
        local ped = PlayerPedId()
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)

        if status and not silenced then
            TriggerEvent("god_status:add", "stress", 300)
            Citizen.Wait(2000)
        else
            Citizen.Wait(250)
        end
    end
end)

Citizen.CreateThread(function() -- Silah, yumruk vs sesi duyarsa / çalışmıyor gibi, büyük ihtimal npc lerde çalışan bir şey çünkü sadece npc ler bu tür olaylara tepki veriyor // Heard gunshot, melee hit etc., seems not to work, since player peds don't act like NPC's ?
    while true do
        local ped = PlayerPedId()
        local status = GetPedAlertness(ped)

        if status == 1 then
            TriggerEvent("god_status:add", "stress", 80)
            Citizen.Wait(10000)
        else
            Citizen.Wait(250)
        end
    end
end)

Citizen.CreateThread(function() -- Yumruk atmak, yumruk yemek veya yakın mesafe silahı ile birine kitlenmek // Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local ped = PlayerPedId()
        local status = IsPedInMeleeCombat(ped)

        if status then
            TriggerEvent("god_status:add", "stress", 150)
            Citizen.Wait(5000)
        else
            Citizen.Wait(250)
        end
    end
end)


Citizen.CreateThread(function() -- Can 100(yarı) altındayken BUNU DENEYİN, SORUNLU OLABİLİR // While healt is below 100(half) TEST THIS BEFORE USE, CAN GET PROBLEMATIC
    while true do
        local ped = PlayerPedId()
        local amount = (GetEntityHealth(ped)-100)

        if amount <= 25 then
            TriggerEvent("god_status:add", "stress", 300)
            Citizen.Wait(10000)
        else
            Citizen.Wait(250)
        end
    end
end)

Citizen.CreateThread(function() -- Olduğun yerde kalmak veya yürümek // stress veh
    while true do
    	Citizen.Wait(250)
        local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped,false) then
			local speed = GetEntitySpeed(GetVehiclePedIsIn(ped,true)) * 3.6
			local onBike = IsPedOnAnyBike(ped)

			if speed > 160 then
				if onBike then
					TriggerEvent("god_status:add", "stress", 800)
					Citizen.Wait(10000)
				else
					TriggerEvent("god_status:add", "stress", 600)
					Citizen.Wait(10000)
				end
			end
		end
	end
end)

Citizen.CreateThread(function() -- Olduğun yerde kalmak veya yürümek // nage
    while true do
    	Citizen.Wait(250)
        local ped = PlayerPedId()
		if IsPedSwimming(ped) then
			TriggerEvent("god_status:remove", "stress", 10000)
			Citizen.Wait(3000)
	    end
	end
end)

Citizen.CreateThread(function() -- Paraşütle skydive // Skydiving with parachute
    while true do
        local ped = PlayerPedId()
        local status = GetPedParachuteState(ped)

        if status == 0 then -- paraşütle dalış // freefall with chute (not falling without it)
            TriggerEvent("god_status:add", "stress", 600)
            Citizen.Wait(5000)
        elseif status == 1 or status == 2 then -- paraşüt açık // opened chute
            TriggerEvent("god_status:add", "stress", 200)
            Citizen.Wait(5000)
        else
            Citizen.Wait(250) -- kontrol hızı düşük çünkü paraşüt atlaması çok olan bir şey değil // refresh rate is low on this one since it's not so common to skydive in RP servers
        end
    end
end)

Citizen.CreateThread(function() -- Gizli moda girmek // Stealth mode
    while true do
        local ped = PlayerPedId()
        local status = GetPedStealthMovement(ped)

        if status then
            TriggerEvent("god_status:add", "stress", 300)
            Citizen.Wait(8000)
        else
            Citizen.Wait(250) -- refresh rate
        end
    end
end)
