ConsumeFoods = false
ConsumeDrinks = false
InfuseBottle = false
propdrink_net = nil
propinfuse_net = nil
local propfood_net = nil
local serve = false
Glass = false
local UseInfuse = false
alcoholstatus = 0
UseAll = false
ondrink = true

-------ESX----
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
	Citizen.Wait(5000)
	TriggerEvent('god_status:getStatus', 'drunk', function(status)	
		if status.val > 0 then
			startdrunk = ((status.val / 10000) / 100) * 1.2259437055846
			alcoholstatus = startdrunk
			ReductionEffect = true
			AlcoholEffect = true
		else
			alcoholstatus = 0
			ReductionEffect = false
			AlcoholEffect = false
		end
	end)
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)

function DrunkSystemStart(alcohol)
    if alcohol == 1 then
        alcoholstatus = alcoholstatus + 0.0359949
		ReductionEffect = true
		AlcoholEffect = true
		ondrink = false
    end
    if alcohol == 2 then
        alcoholstatus = alcoholstatus + 0.0459949
		ReductionEffect = true
		AlcoholEffect = true
		ondrink = false
    end
    if alcohol == 3 then
        alcoholstatus = alcoholstatus + 0.0559949
		ReductionEffect = true
		AlcoholEffect = true
		ondrink = false
    end
    if alcohol == 4 then
        alcoholstatus = alcoholstatus + 0.0659949
		ReductionEffect = true
		AlcoholEffect = true
		ondrink = false
    end
    if alcohol == 5 then
        alcoholstatus = alcoholstatus + 0.0759949
		ReductionEffect = true
		AlcoholEffect = true
		ondrink = false
    end
end
-------------
Citizen.CreateThread(function()
  	while true do
  		Citizen.Wait(10000)
  		if ondrink and alcoholstatus < 0.12 then
  			TriggerEvent('god_status:set', 'drunk', 0)
    		alcoholstatus = 0
			ReductionEffect = false
			AlcoholEffect = false
  		end
    	if alcoholstatus > 0.12 then
    		drunkstatus = ((alcoholstatus * 100) / 1.2259437055846) * 10000
    		TriggerEvent('god_status:set', 'drunk', drunkstatus)
		end
  	end
end)

Citizen.CreateThread(function()
  	while true do
  		Citizen.Wait(10000)
  		if ondrink == false then
  			Citizen.Wait(120000)
  			ondrink = true
  		end
  	end
end)

RegisterNetEvent('devcore_needs_v2:client:cleardrunk')
AddEventHandler('devcore_needs_v2:client:cleardrunk', function()
	TriggerEvent('god_status:set', 'drunk', 0)
	alcoholstatus = 0
	ReductionEffect = false
	AlcoholEffect = false
end)

RegisterNetEvent('devcore_needs_v2:client:UseFoods')
AddEventHandler('devcore_needs_v2:client:UseFoods', function(item, label, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, consumeall, size, bitemin, bitemax, status, stress)
	itemuse = item
	if ConsumeDrinks or InfuseBottle or Glass or ConsumeFoods then
		TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['already'])
	else

		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		ConsumeFoods = true

			propfood = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propfood, playerPed, GetPedBoneIndex(playerPed, 18905), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
			local netid = ObjToNet(propfood)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propfood_net = netid
	

		while true do
			Citizen.Wait(1)
			if ConsumeFoods then 

				FoodScaleform("instructional_buttons", consumeall)

				if Config.DisableCombatButtons then
					DisableControlAction(0,229, true)
					DisableControlAction(0,223, true)
					DisableControlAction(0,142, true)
					DisableControlAction(0,25, true)
					DisableControlAction(0,347, true)
					end


				if size <= 15 then
					ClearPedTasks(playerPed)
					Citizen.Wait(500)
					DetachEntity(NetToObj(propfood_net), 1, 1)
					Citizen.Wait(500)
					DeleteEntity(NetToObj(propfood_net))
					propfood_net = nil
					ConsumeFoods = false

					break
				end
					if IsPedDeadOrDying(playerPed, true) then
						ClearPedTasks(playerPed)
						Citizen.Wait(500)
						DetachEntity(NetToObj(propfood_net), 1, 1)
						Citizen.Wait(500)
						DeleteEntity(NetToObj(propfood_net))
						propfood_net = nil
						ConsumeFoods = false
						alcoholstatus = 0.0
						AlcoholEffect = false
						ReductionEffect = false
						ResetPedMovementClipset(GetPlayerPed(-1), 0)
						ClearTimecycleModifier()
						ResetScenarioTypesEnabled()
						SetPedIsDrunk(GetPlayerPed(-1), false)
						SetPedMotionBlur(GetPlayerPed(-1), false)
						break
					end

			if IsControlJustPressed(0, Config.UseButton) then
				local bite = math.random(bitemin, bitemax)
				playAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger', 2000)
				Citizen.Wait(2000)
				ClearPedTasks(playerPed)
				size = size - bite
				if Config.EnableStatus then
				TriggerEvent('devcore_needs_v2:client:Status', Config.HungerName, status)
				end
				if Config.EnableStressSystem then
					TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
					end
			end

			if IsControlJustPressed(0, Config.UseAllButton) and not consumeall == false  then
				UseAllFood(item, label, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, consumeall, size, bitemin, bitemax, status, stress)
			end

			if IsControlJustPressed(0, Config.Throw) then
				ClearPedTasks(playerPed)
				Citizen.Wait(100)
				DetachEntity(NetToObj(propfood_net), 1, 1)
				Citizen.Wait(100)
				DeleteEntity(NetToObj(propfood_net))
				propfood_net = nil
				ConsumeFoods = false
					break
			end
			

			if not serve and IsControlJustPressed(0, Config.ServeButton) then
				serve = true
				while true do
					Citizen.Wait(1)
				GiveScaleform("instructional_buttons")
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 2.5 then
					target_id = GetPlayerPed(closestPlayer)
					playerX, playerY, playerZ = table.unpack(GetEntityCoords(target_id))
					DrawMarker(0, playerX, playerY, playerZ+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 10, 255, 0, 100, true, true, 2, true, false, false, false)
					if IsControlJustPressed(0, Config.ServeConfirmButton) then
					
					if closestPlayer ~= -1 and closestDistance <= 2.5 then
					TriggerServerEvent('devcore_needs_v2:server:ReceiverFood', GetPlayerServerId(closestPlayer), item, label, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, consumeall, size, bitemin, bitemax, status, stress)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propfood_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propfood_net))
					propfood_net = nil
					ConsumeFoods = false
					break
					end
				end
			end
				if serve == true and IsControlJustPressed(0, Config.ServeCancelButton) then
					serve = false
					break
				end
			end
		end

	else
		break
	end
end

end
end)


RegisterNetEvent('devcore_needs_v2:client:UseDrinks')
AddEventHandler('devcore_needs_v2:client:UseDrinks', function(item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
			if ConsumeFoods or ConsumeDrinks or InfuseBottle or Glass then
				TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['already'])
			else

	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))

	ConsumeDrinks = true
		if type == 'drink' then
			propdrink = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propdrink, playerPed, GetPedBoneIndex(playerPed, 28422), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
			local netid = ObjToNet(propdrink)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propdrink_net = netid
		end
		if type == 'wine' then
			propdrink = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propdrink, playerPed, GetPedBoneIndex(playerPed, 28422), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
			local netid = ObjToNet(propdrink)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propdrink_net = netid
		end

		if type == 'largebottle' then
			propdrink = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propdrink, playerPed, GetPedBoneIndex(playerPed, 28422), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
			local netid = ObjToNet(propdrink)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propdrink_net = netid
		end


		while true do
			Citizen.Wait(1)
				if ConsumeDrinks then

					if not IsPedInAnyVehicle(playerPed, true) and IsEntityPlayingAnim(playerPed, "amb@code_human_wander_drinking_fat@beer@male@base", "static", 3)~= 1 then
						TaskPlayAnim( playerPed, "amb@code_human_wander_drinking_fat@beer@male@base", "static", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						ESX.Streaming.RequestAnimDict("amb@code_human_wander_drinking_fat@beer@male@base", function()
							TaskPlayAnim( playerPed, "amb@code_human_wander_drinking_fat@beer@male@base", "static", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						end)
					end

					DrinksScaleform("instructional_buttons", type, infuse, consumeall, place)

					if Config.DisableCombatButtons then
						DisableControlAction(0,229, true)
						DisableControlAction(0,223, true)
						DisableControlAction(0,142, true)
						DisableControlAction(0,25, true)
						DisableControlAction(0,347, true)
						end

				if size <= 15 then
					ClearPedTasks(playerPed)
					Citizen.Wait(200)
					DetachEntity(NetToObj(propdrink_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propdrink_net))
					propdrink_net = nil
					ConsumeDrinks = false
					break
				end

				if IsPedDeadOrDying(playerPed, true) then
					ClearPedTasks(playerPed)
					Citizen.Wait(500)
					DetachEntity(NetToObj(propdrink_net), 1, 1)
					Citizen.Wait(500)
					DeleteEntity(NetToObj(propdrink_net))
					propdrink_net = nil
					ConsumeDrinks = false
					alcoholstatus = 0.0
					AlcoholEffect = false
					ReductionEffect = false
					ResetPedMovementClipset(GetPlayerPed(-1), 0)
					ClearTimecycleModifier()
					ResetScenarioTypesEnabled()
					SetPedIsDrunk(GetPlayerPed(-1), false)
					SetPedMotionBlur(GetPlayerPed(-1), false)
					break
				end


					if IsControlJustPressed(0, Config.UseButton) then
						if alcoholstatus >= 1.2259437055846 then
							TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['no'])
						else
					local bite = math.random(bitemin, bitemax)
					playAnim('amb@code_human_wander_drinking@male@idle_a', 'idle_c', 3000)
					Citizen.Wait(3000)
					ClearPedTasks(playerPed)
					size = size - bite
					if Config.EnableStatus then
						TriggerEvent('devcore_needs_v2:client:Status', Config.ThirstName, status)
						end
					if Config.EnableStressSystem then
						TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
						end
					if alcohol ~= 0 then
					DrunkSystemStart(alcohol)
					end
				end
			end
					if IsControlJustPressed(0, Config.UseAllButton) and not consumeall == false  then
						UseAlldrink(item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
				end
				if IsControlJustPressed(0, Config.Throw) then
					ClearPedTasks(playerPed)
					Citizen.Wait(200)
					DetachEntity(NetToObj(propdrink_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propdrink_net))
					propdrink_net = nil
					ConsumeDrinks = false
					UseAll = false
				break
				end
				if infuse == true and IsControlJustPressed(0, Config.InfuseButton) then
					ConsumeDrinks = false
					UseInfuse = true
					size = size - glasssize 
					TriggerEvent('devcore_needs_v2:client:Infuse', item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
					ClearPedTasks(playerPed)
					DetachEntity(NetToObj(propdrink_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propdrink_net))
					propdrink_net = nil
					UseAll = false
				end
				if place == true and IsControlJustPressed(0, Config.PlaceButton) then
					SetPosition(item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
				end
				if not serve and IsControlJustPressed(0, Config.ServeButton) then
					serve = true
					while true do
						Citizen.Wait(1)
					GiveScaleform("instructional_buttons")
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 2.5 then
						target_id = GetPlayerPed(closestPlayer)
						playerX, playerY, playerZ = table.unpack(GetEntityCoords(target_id))
						DrawMarker(0, playerX, playerY, playerZ+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 10, 255, 0, 100, true, true, 2, true, false, false, false)
						if IsControlJustPressed(0, Config.ServeConfirmButton) then
						
						if closestPlayer ~= -1 and closestDistance <= 2.5 then
						TriggerServerEvent('devcore_needs_v2:server:Receiver', GetPlayerServerId(closestPlayer), item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
						ClearPedTasks(playerPed)
						Citizen.Wait(100)
						DetachEntity(NetToObj(propdrink_net), 1, 1)
						Citizen.Wait(100)
						DeleteEntity(NetToObj(propdrink_net))
						propdrink_net = nil
						ConsumeDrinks = false
						UseAll = false
						serve = false
						break
						end
					end
				end
					if serve == true and IsControlJustPressed(0, Config.ServeCancelButton) then
						serve = false
						break
					end
				end
				end
			else
				if not ConsumeDrinks then
					break
				end
			end

		end
	end 
end)

RegisterNetEvent('devcore_needs_v2:client:Infuse')
AddEventHandler('devcore_needs_v2:client:Infuse', function(item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
		if ConsumeFoods or ConsumeDrinks or InfuseBottle or Glass then
				TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['already'])
			else

				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				InfuseBottle = true
			if type == 'wine' then
					propinfuse = CreateObject(GetHashKey(glassprop), x, y, z+0.2,  true,  true, true)
					AttachEntityToEntity(propinfuse, playerPed, GetPedBoneIndex(playerPed, 18905), 0.11, -0.03, 0.03, 250.0, 0.0, 0.0, true, true, false, true, 1, true)
					local netid = ObjToNet(propinfuse)
					SetNetworkIdExistsOnAllMachines(netid, true)
					NetworkSetNetworkIdDynamic(netid, true)
					SetNetworkIdCanMigrate(netid, false)
					propinfuse_net = netid
			end
			if type == 'largebottle' then
				propinfuse = CreateObject(GetHashKey(glassprop), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(propinfuse, playerPed, GetPedBoneIndex(playerPed, 18905), 0.11, 0.03, 0.02, 250.0, 0.0, 0.0, true, true, false, true, 1, true)
				local netid = ObjToNet(propinfuse)
				SetNetworkIdExistsOnAllMachines(netid, true)
				NetworkSetNetworkIdDynamic(netid, true)
				SetNetworkIdCanMigrate(netid, false)
				propinfuse_net = netid
		end

		if type == 'drink' then
			propinfuse = CreateObject(GetHashKey(glassprop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propinfuse, playerPed, GetPedBoneIndex(playerPed, 18905), 0.11, -0.03, 0.03, 250.0, 0.0, 0.0, true, true, false, true, 1, true)
			local netid = ObjToNet(propinfuse)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propinfuse_net = netid
	end

		while true do
			Citizen.Wait(1)
			if InfuseBottle then 
				if not IsPedInAnyVehicle(playerPed, true) and IsEntityPlayingAnim(playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3)~= 1 then
					TaskPlayAnim( playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					ESX.Streaming.RequestAnimDict("anim@heists@humane_labs@finale@keycards", function()
						TaskPlayAnim( playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end)
				end

				InfuseScaleform("instructional_buttons", type, infuse, consumeall)

				if Config.DisableCombatButtons then
					DisableControlAction(0,229, true)
					DisableControlAction(0,223, true)
					DisableControlAction(0,142, true)
					DisableControlAction(0,25, true)
					DisableControlAction(0,347, true)
					end

				if glasssize <= 15 then
					ClearPedTasks(playerPed)
					Citizen.Wait(500)
					DetachEntity(NetToObj(propinfuse_net), 1, 1)
					Citizen.Wait(300)
					DeleteEntity(NetToObj(propinfuse_net))
					propinfuse_net = nil
					ConsumeDrinks = false
					InfuseBottle = false
					if UseInfuse == true then
					TriggerEvent('devcore_needs_v2:client:UseDrinks', item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
					UseInfuse = false
					break
					end
					break
				end
				if IsPedDeadOrDying(playerPed, true) then
					ClearPedTasks(playerPed)
					Citizen.Wait(500)
					DetachEntity(NetToObj(propinfuse_net), 1, 1)
					Citizen.Wait(300)
					DeleteEntity(NetToObj(propinfuse_net))
					propinfuse_net = nil
					ConsumeDrinks = false
					InfuseBottle = false
					UseInfuse = false
					alcoholstatus = 0.0
					AlcoholEffect = false
					ReductionEffect = false
					ResetPedMovementClipset(GetPlayerPed(-1), 0)
					ClearTimecycleModifier()
					ResetScenarioTypesEnabled()
					SetPedIsDrunk(GetPlayerPed(-1), false)
					SetPedMotionBlur(GetPlayerPed(-1), false)
					break
				end

			if IsControlJustPressed(0, Config.UseButton) then
				if alcoholstatus >= 1.2259437055846 then
					TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['no'])
				else
				local bite = math.random(bitemin, bitemax)
				playAnim('mp_player_inteat@pnq', 'loop', 1000)
				Citizen.Wait(1000)
				glasssize = glasssize - bite
				if Config.EnableStatus then
					TriggerEvent('devcore_needs_v2:client:Status', Config.ThirstName, status)
					end
				if Config.EnableStressSystem then
				TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
				end
				if alcohol ~= 0 then
					DrunkSystemStart(alcohol)
					end
			end
		end

			if IsControlJustPressed(0, Config.Throw) then
					ClearPedTasks(playerPed)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propinfuse_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propinfuse_net))
					propinfuse_net = nil
					ConsumeDrinks = false
					InfuseBottle = false
					if UseInfuse == true then
					TriggerEvent('devcore_needs_v2:client:UseDrinks', item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
					UseInfuse = false
					break
				end
					break
			end
			if IsControlJustPressed(0, Config.HideGlass) then
				ClearPedTasks(playerPed)
				Citizen.Wait(100)
				DetachEntity(NetToObj(propinfuse_net), 1, 1)
				Citizen.Wait(100)
				DeleteEntity(NetToObj(propinfuse_net))
				propinfuse_net = nil
				ConsumeDrinks = false
				InfuseBottle = false
				UseInfuse = false
				size = size -glasssize
				TriggerServerEvent('devcore_needs_v2:server:AddItem', giveitem)
				TriggerEvent('devcore_needs_v2:client:UseDrinks', item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
		break
		end

			if not serve and IsControlJustPressed(0, Config.ServeButton) then
				serve = true
				while true do
					Citizen.Wait(1)
				GiveScaleform("instructional_buttons")
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 2.5 then
					target_id = GetPlayerPed(closestPlayer)
					playerX, playerY, playerZ = table.unpack(GetEntityCoords(target_id))
					DrawMarker(0, playerX, playerY, playerZ+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 10, 255, 0, 100, true, true, 2, true, false, false, false)
					if IsControlJustPressed(0, Config.ServeConfirmButton) then
					
					if closestPlayer ~= -1 and closestDistance <= 2.5 then
					TriggerServerEvent('devcore_needs_v2:server:ReceiverInfuse', GetPlayerServerId(closestPlayer), item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
					ClearPedTasks(playerPed)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propinfuse_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propinfuse_net))
					propinfuse_net = nil
					ConsumeDrinks = false
					InfuseBottle = false
					serve = false
					if UseInfuse == true then
						TriggerEvent('devcore_needs_v2:client:UseDrinks', item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
						UseInfuse = false
					end
					break
					end
				end
			end
				if serve == true and IsControlJustPressed(0, Config.ServeCancelButton) then
					serve = false
					break
				end
			end
		end

			else
				break
			end
		end

	end
end)


RegisterNetEvent('devcore_needs_v2:client:UseGlass')
AddEventHandler('devcore_needs_v2:client:UseGlass', function(item, label, type, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, bitemin, bitemax, alcohol, status, stress)
		if ConsumeFoods or ConsumeDrinks or InfuseBottle or Glass then
				TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['already'])
			else

				local playerPed = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(playerPed))
				Glass = true
			if type == 'wine' then
					propglass = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
					AttachEntityToEntity(propglass, playerPed, GetPedBoneIndex(playerPed, 18905), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
					local netid = ObjToNet(propglass)
					SetNetworkIdExistsOnAllMachines(netid, true)
					NetworkSetNetworkIdDynamic(netid, true)
					SetNetworkIdCanMigrate(netid, false)
					propglass_net = netid
			end
			if type == 'shot' then
				propglass = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
				AttachEntityToEntity(propglass, playerPed, GetPedBoneIndex(playerPed, 18905), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
				local netid = ObjToNet(propglass)
				SetNetworkIdExistsOnAllMachines(netid, true)
				NetworkSetNetworkIdDynamic(netid, true)
				SetNetworkIdCanMigrate(netid, false)
				propglass_net = netid
		end

		if type == 'drink' then
			propglass = CreateObject(GetHashKey(prop), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(propglass, playerPed, GetPedBoneIndex(playerPed, 18905), positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, true, true, false, true, 1, true)
			local netid = ObjToNet(propglass)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			propglass_net = netid
	end

		while true do
			Citizen.Wait(1)
			if Glass then
				if not IsPedInAnyVehicle(playerPed, true) and IsEntityPlayingAnim(playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3)~= 1 then
					TaskPlayAnim( playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					ESX.Streaming.RequestAnimDict("anim@heists@humane_labs@finale@keycards", function()
						TaskPlayAnim( playerPed, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end)
				end

				GlassScaleform("instructional_buttons", type)

				if Config.DisableCombatButtons then
					DisableControlAction(0,229, true)
					DisableControlAction(0,223, true)
					DisableControlAction(0,142, true)
					DisableControlAction(0,25, true)
					DisableControlAction(0,347, true)
					end

				if size <= 15 then
					ClearPedTasks(playerPed)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propglass_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propglass_net))
					propglass_net = nil
					Glass = false
					break
				end
				if IsPedDeadOrDying(playerPed, true) then
					ClearPedTasks(playerPed)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propglass_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propglass_net))
					propglass_net = nil
					Glass = false
					alcoholstatus = 0.0
					AlcoholEffect = false
					ReductionEffect = false
					ResetPedMovementClipset(GetPlayerPed(-1), 0)
					ClearTimecycleModifier()
					ResetScenarioTypesEnabled()
					SetPedIsDrunk(GetPlayerPed(-1), false)
					SetPedMotionBlur(GetPlayerPed(-1), false)
					break
				end

			if IsControlJustPressed(0, Config.UseButton) then
				if alcoholstatus >= 1.2259437055846 then
					TriggerEvent('devcore_needs_v2:client:notify', 'error', Languages[Config.Language]['no'])
				else
				local bite = math.random(bitemin, bitemax)
				playAnim('mp_player_inteat@pnq', 'loop', 1000)
				Citizen.Wait(1000)
				ClearPedTasks(playerPed)
				size = size - bite
				if Config.EnableStatus then
					TriggerEvent('devcore_needs_v2:client:Status', Config.ThirstName, status)
					end
				if Config.EnableStressSystem then
					TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
					end
				if alcohol ~= 0 then
					DrunkSystemStart(alcohol)
				end
			end
		end

			if IsControlJustPressed(0, Config.Throw) then
					ClearPedTasks(playerPed)
					Citizen.Wait(100)
					DetachEntity(NetToObj(propglass_net), 1, 1)
					Citizen.Wait(100)
					DeleteEntity(NetToObj(propglass_net))
					propglass_net = nil
					Glass = false
			break
			end

			if not serve and IsControlJustPressed(0, Config.ServeButton) then
				serve = true
				while true do
					Citizen.Wait(1)
				GiveScaleform("instructional_buttons")
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 2.5 then
					target_id = GetPlayerPed(closestPlayer)
					playerX, playerY, playerZ = table.unpack(GetEntityCoords(target_id))
					DrawMarker(0, playerX, playerY, playerZ+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 10, 255, 0, 100, true, true, 2, true, false, false, false)
					if IsControlJustPressed(0, Config.ServeConfirmButton) then
					
					if closestPlayer ~= -1 and closestDistance <= 2.5 then
					TriggerServerEvent('devcore_needs_v2:server:ReceiverGlass', GetPlayerServerId(closestPlayer), item, label, type, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, bitemin, bitemax, alcohol, status, stress)
					ClearPedTasks(playerPed)
					Citizen.Wait(1000)
					DetachEntity(NetToObj(propglass_net), 1, 1)
					Citizen.Wait(2000)
					DeleteEntity(NetToObj(propglass_net))
					propglass_net = nil
					Glass = false
					serve = false
					break
					end
				end
			end
				if serve == true and IsControlJustPressed(0, Config.ServeCancelButton) then
					serve = false
					break
				end
			end
		end

			else
				break
			end
		end

	end
end)


RegisterNetEvent('devcore_needs_v2:client:RemoveStress')
AddEventHandler('devcore_needs_v2:client:RemoveStress', function(stress)
	RemoveStress(stress)
end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
if UseAll then
		local playerPed = PlayerPedId()
		CancelScaleform("instructional_buttons", type, infuse, consumeall, serve, UseAll)
		if ConsumeDrinks == true and IsControlJustPressed(0, Config.Throw) then
		UseAll = false
		ConsumeDrinks = false
		ClearPedTasks(playerPed)
		Citizen.Wait(500)
		DetachEntity(NetToObj(propdrink_net), 1, 1)
		Citizen.Wait(500)
		DeleteEntity(NetToObj(propdrink_net))
		propdrink_net = nil
		end
		if ConsumeFoods == true and IsControlJustPressed(0, Config.Throw) then
			UseAll = false
			ClearPedTasks(playerPed)
			Citizen.Wait(500)
			DetachEntity(NetToObj(propfood_net), 1, 1)
			Citizen.Wait(500)
			DeleteEntity(NetToObj(propfood_net))
			propfood_net = nil
			ConsumeFoods = false	
			end
	else
		Citizen.Wait(2000)
		end
	end
end)

function UseAlldrink(item, label, type, prop, glassprop, giveitem, infuse, consumeall, place, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, size, glasssize, bitemin, bitemax, alcohol, status, stress)
	UseAll = true
	while true do
		Citizen.Wait(3000)
	if UseAll then
		local playerPed = PlayerPedId()
	local bite = math.random(bitemin, bitemax)
		playAnim('amb@code_human_wander_drinking@male@idle_a', 'idle_c', 3000)

			size = size - bite
			if Config.EnableStressSystem then
				TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
				end
				if Config.EnableStatus then
					TriggerEvent('devcore_needs_v2:client:Status', Config.ThirstName, status)
				end
				if alcohol ~= 0 then
					DrunkSystemStart(alcohol)
				end
			if size <= 15 then
				ClearPedTasks(playerPed)
				Citizen.Wait(1000)
				DetachEntity(NetToObj(propdrink_net), 1, 1)
				Citizen.Wait(500)
				DeleteEntity(NetToObj(propdrink_net))
				propdrink_net = nil
				ConsumeDrinks = false
				UseAll = false
			break
			end
			if alcohol >= 1.2259437055846 then
				ClearPedTasks(playerPed)
				Citizen.Wait(1000)
				DetachEntity(NetToObj(propdrink_net), 1, 1)
				Citizen.Wait(500)
				DeleteEntity(NetToObj(propdrink_net))
				propdrink_net = nil
				ConsumeDrinks = false
				UseAll = false
				break
			end
			if IsPedDeadOrDying(playerPed, true) then
				ClearPedTasks(playerPed)
				Citizen.Wait(1000)
				DetachEntity(NetToObj(propdrink_net), 1, 1)
				Citizen.Wait(500)
				DeleteEntity(NetToObj(propdrink_net))
				propdrink_net = nil
				ConsumeDrinks = false
				UseAll = false
				alcoholstatus = 0.0
				AlcoholEffect = false
				ReductionEffect = false
				ResetPedMovementClipset(GetPlayerPed(-1), 0)
				ClearTimecycleModifier()
				ResetScenarioTypesEnabled()
				SetPedIsDrunk(GetPlayerPed(-1), false)
				SetPedMotionBlur(GetPlayerPed(-1), false)
				break
			end
		else
			Citizen.Wait(500)
				break
		end
	end
end


function UseAllFood(item, label, prop, positionx, positiony, positionz, positionxrot, positionyrot, positionzrot, consumeall, size, bitemin, bitemax, status, stress)
	UseAll = true
	while true do
	Citizen.Wait(time)
	if UseAll then
		local playerPed = PlayerPedId()
	local bite = math.random(bitemin, bitemax)
		playAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger', 2300)

			size = size - bite
			if Config.EnableStressSystem then
				TriggerEvent('devcore_needs_v2:client:RemoveStress', stress)
				end
				if Config.EnableStatus then
					TriggerEvent('devcore_needs_v2:client:Status', Config.HungerName, status)
				end
time = math.random(4000, 8000)

			if size <= 15 then
				ClearPedTasks(playerPed)
				Citizen.Wait(1000)
				DetachEntity(NetToObj(propfood_net), 1, 1)
				Citizen.Wait(500)
				DeleteEntity(NetToObj(propfood_net))
				propfood_net = nil
				ConsumeFoods = false
				UseAll = false
			break
			end
			if IsPedDeadOrDying(playerPed, true) then
				ClearPedTasks(playerPed)
				Citizen.Wait(1000)
				DetachEntity(NetToObj(propfood_net), 1, 1)
				Citizen.Wait(500)
				DeleteEntity(NetToObj(propfood_net))
				propfood_net = nil
				ConsumeFoods = false
				UseAll = false
				alcoholstatus = 0.0
				AlcoholEffect = false
				ReductionEffect = false
				ResetPedMovementClipset(GetPlayerPed(-1), 0)
				ClearTimecycleModifier()
				ResetScenarioTypesEnabled()
				SetPedIsDrunk(GetPlayerPed(-1), false)
				SetPedMotionBlur(GetPlayerPed(-1), false)
				break
			end
		else
			Citizen.Wait(500)
				break
		end
	end
end

minusphase4 = 0.014048
maxhigh = 0.9309426647617
minhigh = 0.1249949
ondrugs = false

Citizen.CreateThread(function(source)
	while true do
		Citizen.Wait(5000)
		local player = PlayerId()

		if ConsumeFoods and not ondrugs and (itemuse == 'space_cake' or itemuse == 'space_pancake' or itemuse == 'space_brownie') then
			ondrugs = true
			multiplier = maxhigh
		end
	  	if ondrugs then
			SetTimecycleModifier("spectator5")
			SetTimecycleModifierStrength(multiplier)
			multiplier = multiplier - minusphase4
			if multiplier < minhigh	then
				ondrugs = false
				ClearTimecycleModifier()
			end
		end
	end
end)