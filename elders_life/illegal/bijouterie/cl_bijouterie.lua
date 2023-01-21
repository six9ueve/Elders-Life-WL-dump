local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0 

local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},--
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},--
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},--
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},--
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},--
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},--
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},--
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},--
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},--
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},--
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},--
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},--
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},--
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},--
	{x = -619.686, y = -227.753, z = 38.057, heading = 305.245, isOpen = false},--
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},--
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},--
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},--
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},--
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},--
}
------------------RATION
local RequiredCopsRob = 3
local RequiredCopsSell = 0
local MinJewels = 5 
local MaxJewels = 20
local MaxWindows = 20
local SecBetwNextRob = 18000 --1 hour
local MaxJewelsSell = 20
local MaxJewelsSellOr = 5
local PriceForOneJewel = 500
local EnableMarker = true
local NeedBag = true

local Borsoni = {40, 41, 44, 45}

local Stores = {
	["jewelry"] = {
		position = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },       
		nameofstore = "jewelry",
		lastrobbed = 0
	}
}
---------------------------------------

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

local function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

local function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('god_vangelico_robbery:currentlyrobbing')
AddEventHandler('god_vangelico_robbery:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('god_vangelico_robbery:killblip')
AddEventHandler('god_vangelico_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('god_vangelico_robbery:setblip')
AddEventHandler('god_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('god_vangelico_robbery:toofarlocal')
AddEventHandler('god_vangelico_robbery:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('god_vangelico_robbery:robberycomplete')
AddEventHandler('god_vangelico_robbery:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.6)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

local function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

local borsa = nil

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(PlayerPedId(), true)
		local sleepaille = 750

		for k,v in pairs(Stores)do
			local pos2 = v.position
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				sleepaille = 0
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 0, 0, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsPedShooting(PlayerPedId()) then
							if ESX.GetTimeIRL() > 1 and ESX.GetTimeIRL() < 10 then
	                            ESX.ShowAdvancedNotification('FLEECA', 'Rapport', 'Heure de braquage dépassée', 'CHAR_LESTER_DEATHWISH', 4)
	                        else
								if NeedBag then
								    if borsa == 10 or borsa == 11 or borsa == 14 or borsa == 32 or borsa == 33 or borsa == 34 or borsa == 97 or borsa == 96 or borsa == 93 or borsa == 92 or borsa == 50 or borsa == 86 or borsa == 87 or borsa == 90 or borsa ==91 then
								        ESX.TriggerServerCallback('god_vangelico_robbery:conteggio', function(CopsConnected)
									        if CopsConnected >= RequiredCopsRob then
								                TriggerServerEvent('god_vangelico_robbery:rob', k)
										        PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
									        else
										        TriggerEvent('god:showNotification', _U('min_two_police') .. RequiredCopsRob .. _U('min_two_police2'))
									        end
								        end)		
							        else
								        TriggerEvent('god:showNotification', _U('need_bag'))
									end
								else
									ESX.TriggerServerCallback('god_vangelico_robbery:conteggio', function(CopsConnected)
										if CopsConnected >= RequiredCopsRob then
											TriggerServerEvent('god_vangelico_robbery:rob', k)
											PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
										else
											TriggerEvent('god:showNotification', _U('min_two_police') .. RequiredCopsRob .. _U('min_two_police2'))
										end
									end)	
								end	
							end
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end

		if holdingup then
			sleepaille = 0
			drawTxt(0.3, 1.4, 0.45, _U('smash_case') .. ' :~r~ ' .. vetrineRotte .. '/' .. MaxWindows, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do 
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and EnableMarker then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 0, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~] ' .. _U('press_to_collect'), 0.6)
					if IsControlJustPressed(0, 38) then
						animazione = true
					    SetEntityCoords(PlayerPedId(), v.x, v.y, v.z-0.95)
					    SetEntityHeading(PlayerPedId(), v.heading)
						v.isOpen = true 
						PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
					    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
					    RequestNamedPtfxAsset("scr_jewelheist")
					    end
					    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
					    Citizen.Wait(0)
					    end
					    SetPtfxAssetNextCall("scr_jewelheist")
					    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					    loadAnimDict( "missheist_jewel" ) 
						TaskPlayAnim(PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						TriggerEvent("mt:missiontext", _U('collectinprogress'), 3000)
					    --DisplayHelpText(_U('collectinprogress'))
					    DrawSubtitleTimed(5000, 1)
					    Citizen.Wait(7000)
					    ClearPedTasksImmediately(PlayerPedId())
					    TriggerServerEvent('god_vangelico_robbery:gioielli')
					    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    vetrineRotte = vetrineRotte+1
					    animazione = false

						if vetrineRotte == MaxWindows then 
						    for i,v in pairs(vetrine) do 
								v.isOpen = false
								vetrineRotte = 0
							end
							TriggerServerEvent('god_vangelico_robbery:endrob', store)
						    ESX.ShowNotification(_U('lester'))
						    holdingup = false
						    StopSound(soundid)
						end
					end
				end	
			end

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('god_vangelico_robbery:toofar', store)
				holdingup = false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
			end

		end

		Citizen.Wait(sleepaille)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		interval = 750
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				interval = 1
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
		Wait(interval)
	end
end)

blip = false

Citizen.CreateThread(function()
	TriggerEvent('lester:createBlip', 77, 705.962, -960.87, 30.39)
	while true do
	
		local sleep = 2000
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 201.974, -2228.54, 5.95, true) <  20.0) then
               sleep = 0
            end
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 201.974, -2228.54, 5.95, true) <= 20 and not blip then
				DrawMarker(20, 201.974, -2228.54, 5.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 100, 102, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 201.974, -2228.54, 5.95, true) < 1.0 then
					DisplayHelpText(_U('press_to_sell'))
					if IsControlJustReleased(1, 51) then
						blip = true
						ESX.TriggerServerCallback('god_vangelico_robbery:getItemAmount', function(quantity)
							if quantity >= MaxJewelsSell then
								ESX.TriggerServerCallback('god_vangelico_robbery:conteggio', function(CopsConnected)
									if CopsConnected >= RequiredCopsSell then
										FreezeEntityPosition(playerPed, true)
										TriggerEvent('mt:missiontext', _U('goldsell'), 10000)
										Wait(10000)
										FreezeEntityPosition(playerPed, false)
										TriggerServerEvent('lester:vendita')
										blip = false
									else
										blip = false
										TriggerEvent('god:showNotification', _U('copsforsell') .. RequiredCopsSell .. _U('copsforsell2'))
									end
								end)
							else
								blip = false
								TriggerEvent('god:showNotification', _U('notenoughgold'))
							end
						end, 'jewels')
					end
				end
			end
		Citizen.Wait(sleep)

	end
end)

Citizen.CreateThread(function()
	TriggerEvent('lester:createBlip', 77, 705.962, -960.87, 30.39)
	while true do
	
		local sleep = 2000
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 201.9529, -2205.442, 5.95, true) <  20.0) then
               sleep = 0
            end
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 201.9529, -2205.442, 5.95, true) <= 20 and not blip then
				DrawMarker(20, 201.9529, -2205.442, 5.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 100, 102, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 201.9529, -2205.442, 5.95, true) < 1.0 then
					DisplayHelpText(_U('press_to_sell2'))
					if IsControlJustReleased(1, 51) then
						blip = true
						ESX.TriggerServerCallback('god_vangelico_robbery:getItemAmount', function(quantity)
							if quantity >= MaxJewelsSellOr then
								ESX.TriggerServerCallback('god_vangelico_robbery:conteggio', function(CopsConnected)
									if CopsConnected >= RequiredCopsSell then
										FreezeEntityPosition(playerPed, true)
										TriggerEvent('mt:missiontext', _U('goldsellor'), 10000)
										Wait(10000)
										FreezeEntityPosition(playerPed, false)
										TriggerServerEvent('lester:venditalingot')
										blip = false
									else
										TriggerEvent('god:showNotification', _U('copsforsell') .. RequiredCopsSell .. _U('copsforsell2'))
										Wait(10000)
										blip = false
									end
								end)
							else
								TriggerEvent('mt:missiontext',_U('notenoughgold2'), 10000)
								Wait(10000)
								blip = false	
							end
						end, 'lingot_orheist')
					end
				end
			end
		Citizen.Wait(sleep)
	end
end)

