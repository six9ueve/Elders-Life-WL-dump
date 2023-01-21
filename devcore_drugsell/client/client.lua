local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168,["F11"] = 344, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local selldrugs = false
local menuOpen = false
local commandsell = false
local selling = false
local cancelsell = false
local sell = false
local checkdistance = false
local IsSell = false
local coords = {}
local bargain = true
local thief = false
local currentped = nil

ESX = nil

Citizen.CreateThread(function()
  	while ESX == nil do
    	TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(250)
  	end

  	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(250)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while(true) do
		playerPed = PlayerPedId()
		coords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(1000)
    end
end)

ShowFloatingHelpNotification = function(msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

RegisterNetEvent('devcore_drugsell:startSell')
AddEventHandler('devcore_drugsell:startSell', function(source)
			if commandsell == false then
				commandsell = true
				selldrugs = true
				--exports['mythic_notify']:DoHudText('inform', _U('start_sell'))
				ESX.ShowNotification(_U('start_sell'))
			else
				if thief == false and selling == false then
				oldped = ped
				--exports['mythic_notify']:DoHudText('inform', _U('stop_sell'))
				ESX.ShowNotification(_U('stop_sell'))
				selldrugs = false
				selling = false
				sell = false
				IsSell = false
				checkdistance = false
				cancelsell = false
				bargain = true
				FreezeEntityPosition(oldped, false)
				SetPedAsNoLongerNeeded(oldped)
				--ESX.UI.Menu.CloseAll()
				Wait(Config.Cooldown)
				commandsell = false
				return
				else
					--exports['mythic_notify']:DoHudText('inform', _U('proccess'))
					ESX.ShowNotification(_U('proccess'))
				end
		    end
end)

wait = 200

Citizen.CreateThread(function()
			while true do
				Wait(1)
		if selldrugs and not IsPedInAnyVehicle(playerPed, true) then
			wait = wait + 1
			local handle, ped = FindFirstPed()
			repeat
			success, ped = FindNextPed(handle)
			local playerPed = GetPlayerPed(PlayerId())
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords['x'], coords['y'], coords['z'], true)
			if not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
				local pedType = GetPedType(ped)
					if pedType ~= 28 and not IsPedAPlayer(ped) then
					currentped = pos
						for i , model in pairs(Config.BlacklistNPC) do
							if GetEntityModel(ped) ~= GetHashKey(model) then
								if wait > 200 and distance <= 3 and not selling and ped ~= playerPed and ped ~= oldped or Config.SellInCar and IsPedInVehicle(playerPed, vehicle, true) and distance <= 7 and not selling and ped ~= playerPed and ped ~= oldped then
									local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))
									ShowFloatingHelpNotification(_U('press_for_sell'), vector3(playerX, playerY, playerZ))
									if IsControlJustPressed(1, Config.OfferButton) then
										wait = 0
										if Config.SellInCar and IsPedInAnyVehicle(playerPed, true) then
											oldped = ped
											local playerVeh = GetVehiclePedIsIn(playerPed, false)
											RollDownWindow(playerVeh, 0)
											Citizen.Wait(200)
											SellDrugInCar(ped)
										else
											thief = false
											oldped = ped
											Citizen.Wait(200)
											SellDrug(ped)
										end
									
									end
								end
							end
						break
						end
					end
				end
			until not success
			EndFindPed(handle)
		else
			Wait(500)
		end
	end
end)	


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(oldped)
		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords['x'], coords['y'], coords['z'], true)
		if checkdistance then
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local player = GetPlayerPed(-1)
			local playerpos = GetEntityCoords(player)
			local playerheadingveh = GetEntityHeading(GetPlayerPed(-1))
			SetEntityAsMissionEntity(oldped, true, false)
			if IsPedInVehicle(player, vehicle, true)  and cancelsell then
				ESX.ShowHelpNotification(_U('cancelsell'))
				if IsControlJustPressed(0, Config.CancelSellButton) then
					selling = false
					sell = false
					IsSell = false
					bargain = true
					cancelsell = false
					ClearPedTasks(oldped)
					SetPedAsNoLongerNeeded(oldped)
					SetEntityAsMissionEntity(oldped, true, false)
					--ESX.UI.Menu.CloseAll()
					checkdistance = false
				end
			end
			 if distance <= 2 then
				local playerheadingveh = GetEntityHeading(GetPlayerPed(-1))
				local playerlocationveh = GetEntityForwardVector(PlayerPedId())
				local playerCoordsveh = GetEntityCoords(GetPlayerPed(-1))
				local xhr, yhr, zhr   = table.unpack(playerCoordsveh + playerlocationveh * 1.0)
				if IsPedInVehicle(player, vehicle, true) then
					ClearPedTasks(oldped)
					SetPedAsNoLongerNeeded(oldped)
					Citizen.Wait(2000)
					SetEntityHeading(oldped, playerheadingveh+260)
					Citizen.Wait(1000)
					DrugSell(oldped)
					cancelsell = false
				else
					ClearPedTasks(oldped)
					SetPedAsNoLongerNeeded(oldped)
					DrugSell(oldped)
					cancelsell = false
				end
			 end
			else
				Citizen.Wait(500)
		end
	end
end)


function SellDrug(ped)
	--ESX.TriggerServerCallback("devcore_drugsell:canSell",function(bool)
        --if (bool == true) then
			local playerPed = PlayerPedId()
			oldped = ped
			local r1 = math.random(1, 100)
			local r2 = math.random(1, 100)

			SetEntityAsMissionEntity(oldped, true, false)
            if r1 > 80 then 
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
				Citizen.Wait(1500)
				SetPedAsNoLongerNeeded(oldped)
				playerAnim(oldped,"cellphone@","cellphone_call_listen_base", 5000)
				phone = CreateObject(GetHashKey('prop_npc_phone_02'), x, y, z+0.9,  true,  true, true)
				AttachEntityToEntity(phone, oldped, GetPedBoneIndex(oldped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
				if not IsPedDeadOrDying(ped) then
					local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
			        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			        local street1 = GetStreetNameFromHashKey(s1)
			        local street2 = GetStreetNameFromHashKey(s2)
					local player = GetPlayerPed(PlayerId())
					ESX.ShowNotification('La police à été appelé !')
					TriggerServerEvent('devcore_drugsell:s_police_notify', player, plyPos.x, plyPos.y, plyPos.z, playerPed)
					--TriggerServerEvent('devcore_drugsell:s_police_notify_blip', plyPos.x, plyPos.y, plyPos.z, playerPed)
				end
				Citizen.Wait(5000)
				DetachEntity(phone, 1, 1)
				DeleteObject(phone)
			else
				local randomRejectPed = math.random(1, Config.randomReject)
				if r2 > 70 then					
					Citizen.Wait(1200)
					SetEntityAsMissionEntity(oldped, true, false)
					playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
				else
					local player = GetPlayerPed(-1)
					local playerpos = GetEntityCoords(player)
					local playerheadingveh = GetEntityHeading(GetPlayerPed(-1))
					TaskGoStraightToCoord(oldped, playerpos.x, playerpos.y, playerpos.z, 1.0, 1.0, playerheadingveh+260, 1.0)
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					checkdistance = true
					cancelsell = true
					oldped = ped
					selling = true
				end
				SetPedAsNoLongerNeeded(oldped)
			end
		--else
		--	ESX.ShowAdvancedNotification('EldersLife', 'Règlement', 'Tu as atteind le maximum de vente aujourd\'hui !', 'CHAR_ELDERS', 10)
        --    return
        --end
    --end)
end

function SellDrugInCar(ped)
	local playerPed = PlayerPedId()
	local cars = {'Compacts', 'Sedans', 'SUVs', 'Coupes', 'Muscle', 'Sport Classics', 'Sports', 'Super', 'Motorcycle', 'Off-road', 'Industrial', 'Utility', 'Vans', 'Cycles', 'Boats', 'Helicopters', 'Planes', 'Service', 'Emergency', 'Military', 'Commercial', 'Trains'}
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local vehicleClass = GetVehicleClass(vehicle)
	local vehicleStringClass = cars[vehicleClass + 1]
	oldped = ped
	playerAnim(playerPed,"rcmnigel1c","hailing_whistle_waive_a", 1000)
	SetEntityAsMissionEntity(oldped, true, false)
	local r3 = math.random(1, 100)
	local r4 = math.random(1, 100)
    if r3 > 60 then 
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
		Citizen.Wait(1200)
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
		local player = GetPlayerPed(PlayerId())
		if not IsPedDeadOrDying(ped) then
		TriggerServerEvent('devcore_drugsell:s_police_notify_vehicle', player, vehicleStringClass)
		TriggerServerEvent('devcore_drugsell:s_police_notify_blip', plyPos.x, plyPos.y, plyPos.z)
		end
		SetPedAsNoLongerNeeded(oldped)
		playerAnim(oldped,"cellphone@","cellphone_call_listen_base", 5000)
		phone = CreateObject(GetHashKey('prop_npc_phone_02'), x, y, z+0.9,  true,  true, true)
		AttachEntityToEntity(phone, oldped, GetPedBoneIndex(oldped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(5000)
		DetachEntity(phone, 1, 1)
		DeleteObject(phone)
	else
		if r4 > 70 then
			SetEntityAsMissionEntity(oldped, true, false)
		playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
		Citizen.Wait(1200)
else
	local player = GetPlayerPed(-1)
	local playerpos = GetEntityCoords(player)
	local playerheadingveh = GetEntityHeading(GetPlayerPed(-1))
	TaskGoStraightToCoord(oldped, playerpos.x, playerpos.y, playerpos.z, 1.0, 1.0, playerheadingveh+260, 1.0)
		SetEntityAsMissionEntity(ped, true, false)
		checkdistance = true
		cancelsell = true
		selling = true
		IsSell = true
		oldped = ped
		end
			SetPedAsNoLongerNeeded(oldped)
		end
end

function playerAnim(playerPed, animDictionary, animationName, time)
    if (DoesEntityExist(playerPed) and not IsEntityDead(playerPed)) then
        loaddict(animDictionary)
        TaskPlayAnim(playerPed, animDictionary, animationName, 8.0, -8.0, time, 49, 1, false, false, false)
    end
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

RegisterNetEvent('devcore_drugsell:c_police_notify')
AddEventHandler('devcore_drugsell:c_police_notify', function(player)
	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' then
		if Config.mugshotnotify then
			local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(player)))
			ESX.ShowAdvancedNotification('Description du', 'suspect', 'Une personne essai de me vendre de la drogue ', mugshotStr, 4)
			UnregisterPedheadshot(mugshot)
			else
			ESX.ShowAdvancedNotification('Vente', 'Rapport', 'Une personne essai de me vendre de la drogue ', 'CHAR_LESTER_DEATHWISH', 4)
		end
	end
end)

RegisterNetEvent('devcore_drugsell:c_police_notify_vehicle')
AddEventHandler('devcore_drugsell:c_police_notify_vehicle', function(player, vehicleStringClass)
	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' then
		if Config.mugshotnotify then
			local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(player)))
			ESX.ShowAdvancedNotification('Description du', 'suspect', 'Une personne essai de me vendre de la drogue depuis un véhicule. Type de vehicule ' ..vehicleStringClass, mugshotStr, 4)
			UnregisterPedheadshot(mugshot)
		else
			ESX.ShowAdvancedNotification('Vente', 'Rapport', 'Une personne essai de me vendre de la drogue depuis un véhicule. Type de vehicule ' ..vehicleStringClass, 'CHAR_LESTER_DEATHWISH', 4)
		end
	end
end)

RegisterNetEvent('devcore_drugsell:c_police_notify_blip')
AddEventHandler('devcore_drugsell:c_police_notify_blip', function(tx, ty, tz)
	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' then
	local transT = 250
	local Blip = AddBlipForCoord(tx, ty, tz)
	SetBlipSprite(Blip,  51)
	SetBlipColour(Blip,  27)
	SetBlipScale(Blip , 0.8)
	SetBlipAlpha(Blip,  transT)
	SetBlipAsShortRange(Blip,  false)
	PulseBlip(Blip)
	while transT ~= 0 do
		Wait(Config.blipTime * 4)
		transT = transT - 1
		SetBlipAlpha(Blip,  transT)
			if transT == 0 then
				--SetBlipSprite(Blip,  2)
				RemoveBlip(Blip)
				return
			end
		end
	end
end)

function DrugSell(ped, oldped)
	--ESX.UI.Menu.CloseAll()
	selling = true
	checkdistance = false
	local playerPed = PlayerPedId()
	local elements = {}
	if ped ~= oldped then
		oldped = ped
		menuOpen = true
		IsSell = true
		TaskStandStill(ped, 100.0)

		for k, v in pairs(Config.SellNpcItems) do
			if Config.esxVersion == 'final' or Config.esxVersion == '1.2' or Config.esxVersion == '1.1' then
			local inventory = ESX.GetPlayerData().inv
				local count = 0
				for i=1, #inventory, 1 do
					if inventory[i].name == v.Items then
						if inventory[i].count > 0 then
						local amount = math.random(v.MinAmount, v.MaxAmount)
						local price = math.random(v.PriceMin, v.PriceMax)*amount
						local labels = v.ItemsLabel
						table.insert(elements, {
							label = (v.ItemsLabel.. ' | <span style="color:green;">Vendre</span>'),
							item = v.Items,
							amount = amount,
							labels = labels,
							price = price
						})
						end
					end
				end
			else
				if Config.esxVersion == 'legacy' then
					local amount = math.random(v.MinAmount, v.MaxAmount)
					local price = math.random(v.PriceMin, v.PriceMax)*amount
					local labels = v.ItemsLabel
					table.insert(elements, {
						label = (v.ItemsLabel.. ' | <span style="color:green;">Vendre</span>'),
						item = v.Items,
						amount = amount,
						labels = labels,
						price = price
					})
				end
			end
		end
	end
	count = 0
	for i = 1, #elements do
		count = count + 1
	end
	if count ~= 0 then
		ESX.UI.Menu.Open('native', GetCurrentResourceName(), 'drug', {
			title    = _U("menu_title"),
			align    = Config.SellMenuAlign,
			elements = elements
		}, function(data, menu)
		menu.close()
		TriggerServerEvent('devcore_drugsell:offer', ped, data.current.item, data.current.price, data.current.labels, data.current.amount)
		end, function(data, menu)
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			IsSell = false
		FreezeEntityPosition(oldped, false)
		ClearPedTasks(oldped)
		SetPedAsNoLongerNeeded(oldped)
		menuOpen = false
		selling = false
			--ESX.UI.Menu.CloseAll()

		end)
	else
		ESX.ShowNotification('Vous n\'avez rien à vendre sur vous !')
		IsSell = false
		menuOpen = false
		selling = false
	end
end

RegisterNetEvent('devcore_drugsell:c_startofferscant')
AddEventHandler('devcore_drugsell:c_startofferscant', function()
	ESX.ShowNotification('Vous n\'en avez pas assez sur vous pour conclure l\'offre !')
	IsSell = false
	menuOpen = false
	selling = false
	ClearPedTasks(oldped)
	FreezeEntityPosition(oldped, false)
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

RegisterNetEvent('devcore_drugsell:c_startoffers')
AddEventHandler('devcore_drugsell:c_startoffers', function(ped, item, price, labels, amount)
	for i , model in pairs(Config.ThiefNpc) do
	if GetEntityModel(ped) == GetHashKey(model) then
		thief = true
		local randomRobGang= math.random(1, Config.randomRobGang)
		if randomRobGang == Config.randomRobGang then
			local playerPed = PlayerPedId()
			thief = true
			local playerheadingrob = GetEntityHeading(GetPlayerPed(-1))
			local playerlocationrob = GetEntityForwardVector(PlayerPedId())
			local playerCoordsrob = GetEntityCoords(GetPlayerPed(-1))
			local weapon = GetHashKey("WEAPON_PISTOL")
			local xhr, yhr, zhr   = table.unpack(playerCoordsrob + playerlocationrob * 1.0)
			if not IsPedInAnyVehicle(playerPed, true) then
			SetEntityCoords(ped, xhr-0.7, yhr+0.3, zhr-0.7)
			SetEntityHeading(ped, playerheadingrob+180.0)
			end
			--ESX.UI.Menu.CloseAll()
			Citizen.Wait(100)
			playerAnim(playerPed,"random@mugging3","handsup_standing_base", -1)
			SetEntityAsMissionEntity(ped, true, false)
			FreezeEntityPosition(ped, false)
			pos = GetEntityCoords(ped, true)
			rot = GetEntityHeading(ped)
			SetPedCombatAttributes(ped, 46, true)
			SetPedAmmo(ped, GetHashKey("WEAPON_PISTOL"), math.random(20, 100))
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_PISTOL"), true)
			playAnim( "reaction@intimidation@1h" )
			TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos, 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
			Citizen.Wait(2000)
			playerAnim(ped,"random@countryside_gang_fight","biker_02_stickup_loop", -1)
			robStart(ped, item, amount)
		else
			thief = true
			price = price*1.1
			OfferStart(ped, item, price, labels, amount)
		end
	end
	
end
	if thief == false then
	OfferStart(ped, item, price, labels, amount)
	end
end)


function robStart(ped, item, amount)
	while true do
		Citizen.Wait(1)
	if not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
		local playerheadingrob = GetEntityHeading(GetPlayerPed(-1))
			local playerlocationrob = GetEntityForwardVector(PlayerPedId())
			local playerCoordsrob = GetEntityCoords(GetPlayerPed(-1))
			local xhr, yhr, zhr   = table.unpack(playerCoordsrob + playerlocationrob * 1.0)
		SetEntityHeading(oldped, playerheadingrob+180.0)
		local playerPed = PlayerPedId()
		if IsPedArmed(playerPed, 7) then
			ClearPedTasks(playerPed)
			local player = GetPlayerPed(-1)
			sell = false
			selling = false
			FreezeEntityPosition(ped, false)
			ClearPedTasks(ped)
			IsSell = false
			bargain = true
			Citizen.Wait(2000)
			TaskShootAtEntity(ped, player, 5000, "FIRING_PATTERN_FULL_AUTO")
			break
		else
		local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))
		ESX.ShowHelpNotification(_U('rob'))
		ShowFloatingHelpNotification(_U('RobMess'), vector3(playerX, playerY, playerZ))
			if IsControlJustPressed(1, Config.GiveDrugsButton) then
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
				Citizen.Wait(1000)
				playerAnim(playerPed,"mp_common","givetake1_a", 1800)
				Citizen.Wait(1000)
				TriggerServerEvent('devcore_drugsell:robgive', item, amount)
				FreezeEntityPosition(ped, false)
				ClearPedTasks(ped)
				TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
				Citizen.Wait(100)
				sell = false
				selling = false
				IsSell = false
				bargain = true
				break
			end
			if IsControlJustPressed(1, Config.Run) then
				local player = GetPlayerPed(-1)
				local randomthiefshooting = math.random(1, Config.thiefshooting)
				if randomthiefshooting == Config.thiefshooting then
					ClearPedTasks(playerPed)
					sell = false
					selling = false
					FreezeEntityPosition(ped, false)
					ClearPedTasks(ped)
					IsSell = false
					bargain = true
					Citizen.Wait(3000)
					TaskShootAtEntity(ped, player, 6000, "FIRING_PATTERN_FULL_AUTO")
					Citizen.Wait(6000)
					TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
					break
				else
				ClearPedTasks(playerPed)
				sell = false
				selling = false
				IsSell = false
				bargain = true
				FreezeEntityPosition(ped, false)
				ClearPedTasks(ped)
				Citizen.Wait(2000)
				TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
				break
				end
			end
			end
		end

	end
end


function OfferStart(ped, item, price, labels, amount)
	--ESX.UI.Menu.CloseAll()
	SetEntityAsMissionEntity(ped, true, false)
	FreezeEntityPosition(oldped, false)
	local player = GetPlayerPed(-1)
	sell = true
	oldped = ped
	while true do
		Citizen.Wait(1)
		if sell then
			local pos = GetEntityCoords(ped)
			pos1 = GetEntityCoords(ped)
			local player = GetPlayerPed(-1)
			local playerPed = PlayerPedId()
			IsPedHeadtrackingEntity(ped, playerPed)
			local vehicle = GetVehiclePedIsIn(player, false)
			local playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		if distance > 3 or Config.SellInCar and IsPedInVehicle(player, vehicle, true) and distance > 7 then
					sell = false
					IsSell = false
					SetPedAsNoLongerNeeded(oldped)
					selling = false
					FreezeEntityPosition(ped, false)
					return
			end
		if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then 
			ESX.ShowHelpNotification(_U('sell'))
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))
			ShowFloatingHelpNotification(('Je te donne ' ..price.. '$ pour '  ..amount.. 'pochon'), vector3(playerX, playerY, playerZ))
		end
	if bargain == true and IsControlJustPressed(1, Config.BargainButton) then
		local randomBargain = math.random(1, Config.PercentBargain)
		if randomBargain == Config.PercentBargain then
		price = price*1.05

		bargain = false
		else
		playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
		bargain = true
		sell = false
		SetPedAsNoLongerNeeded(oldped)
		selling = false
		FreezeEntityPosition(oldped, false)
		IsSell = false
		bargain = true
		break
	end
end
			if IsControlJustPressed(1, Config.AcceptOfferButton) then
				SetEntityAsMissionEntity(ped)
				TaskStandStill(ped, 100.0)
				sellanim(ped)
				selling = false
				sell = false
				TriggerServerEvent('devcore_drugsell:selling', item, price, amount, labels)
				IsSell = false
				FreezeEntityPosition(oldped, false)
				bargain = true
				break
			elseif IsControlJustPressed(1, Config.CancelOffer) then
					sell = false
					SetPedAsNoLongerNeeded(oldped)
					selling = false
					FreezeEntityPosition(oldped, false)
					IsSell = false
					bargain = true
				break
			end
		end
	end
end

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end


function sellanim(ped)
	IsSell = true
	local player = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local xp,yp,zp = table.unpack(GetEntityCoords(ped))
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local playerheadingsell = GetEntityHeading(GetPlayerPed(-1))
	local playerlocation = GetEntityForwardVector(PlayerPedId())
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	if Config.SellInCar and IsPedInVehicle(player, vehicle, true) then
	playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	playerAnim(ped,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	Citizen.Wait(2000)
	playerAnim(playerPed,"mp_common","givetake1_a", 1800)
	playerAnim(ped,"mp_common","givetake1_a", 1800)
	Citizen.Wait(1800)
	SetPedAsNoLongerNeeded(oldped)
	FreezeEntityPosition(oldped, false)
	IsSell = false
	else
	IsSell = true
	local xh, yh, zh   = table.unpack(playerCoords + playerlocation * 1.0)
	SetEntityCoords(ped, xh, yh, zh-0.7)
	SetEntityHeading(ped, playerheadingsell+210.0)
	Citizen.Wait(500)
	FreezeEntityPosition(oldped, true)
	playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	playerAnim(ped,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	Citizen.Wait(2000)
	playerAnim(playerPed,"mp_common","givetake1_a", 1800)
	playerAnim(ped,"mp_common","givetake1_a", 1800)
	Citizen.Wait(1800)
	SetPedAsNoLongerNeeded(oldped)
	FreezeEntityPosition(oldped, false)
	IsSell = false
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsSell then

			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(0, Keys['U'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job
			DisableControlAction(0, Keys['X'], true) -- Job
			DisableControlAction(0, Keys['G'], true) -- Job
			DisableControlAction(0, Keys['F11'], true) -- Job
			DisableControlAction(0, Keys['F9'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

		else
			Citizen.Wait(500)
		end
	end
end)