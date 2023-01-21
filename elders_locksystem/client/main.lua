ESX = nil
blipDoorHack = {}
Doors = {}
local enablePanel = false
local isLockpicking = false
local showDoorID = false

local infoOn = false
local coordsText = "" 
local headingText = ""
local modelText = ""

local aimInfo = {}
local door1Info = {}
local door2Info = {}
local textCoords

local PlayerJob = 'nojob'
local PlayerJob2 = 'nojob'
local securityJobs = {}
local pressedButton = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	for k,v in pairs(Config.SecurityJob) do
		securityJobs[v] = true
	end
end)

RegisterNetEvent('god:setJobdoor')
AddEventHandler('god:setJobdoor', function(job)
    PlayerJob = job
end)

RegisterNetEvent('god:setJobdoor2')
AddEventHandler('god:setJobdoor2', function(job2)
    PlayerJob2 = job2
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerJob = xPlayer.job.name
    PlayerJob2 = xPlayer.job2.name
end)

RegisterNetEvent('elders_locksystem:loadDoors')
AddEventHandler('elders_locksystem:loadDoors', function(doors)
	local serverDoors = doors

	for doorIndex ,doorItem in pairs(serverDoors) do
		if doorItem.door2_coords then
			AddDoorToSystem(doorItem.doorID, doorItem.door1_hash, vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
			DoorSystemSetDoorState(doorItem.doorID, tonumber(doorItem.locked))

			AddDoorToSystem(doorItem.doorID + 1000, doorItem.door2_hash, vector3(doorItem.door2_coords.x, doorItem.door2_coords.y, doorItem.door2_coords.z))
			DoorSystemSetDoorState(doorItem.doorID + 1000, tonumber(doorItem.locked))
		else
			AddDoorToSystem(doorItem.doorID, doorItem.door1_hash, vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
			DoorSystemSetDoorState(doorItem.doorID, tonumber(doorItem.locked))
		end
		
		Doors[tostring(doorItem.doorID)] = doorItem
	end
end)

RegisterNetEvent('elders_locksystem:deleteDoor')
AddEventHandler('elders_locksystem:deleteDoor', function(doorID)
	if Doors[tostring(doorID)] ~= nil then
		local doorItem = Doors[tostring(doorID)]
		if doorItem.door2_coords then
			AddDoorToSystem(doorItem.doorID, doorItem.door1_hash, vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
			DoorSystemSetDoorState(doorItem.doorID, 0)

			AddDoorToSystem(doorItem.doorID + 1000, doorItem.door2_hash, vector3(doorItem.door2_coords.x, doorItem.door2_coords.y, doorItem.door2_coords.z))
			DoorSystemSetDoorState(doorItem.doorID + 1000, 0)
		else
			AddDoorToSystem(doorItem.doorID, doorItem.door1_hash, vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
			DoorSystemSetDoorState(doorItem.doorID, 0)
		end
		Doors[tostring(doorID)] = nil
	end
end)

RegisterNetEvent('elders_locksystem:setDoorState')
AddEventHandler('elders_locksystem:setDoorState', function(doorID, state, electric)
	if Doors[doorID] ~= nil then
		Doors[doorID].locked = state
		DoorSystemSetDoorState(tonumber(doorID), state)
		if Doors[doorID].door2_coords ~= nil then
			DoorSystemSetDoorState(tonumber(doorID) + 1000, state)
		end
	end
end)

RegisterNetEvent('elders_locksystem:setBlip')
AddEventHandler('elders_locksystem:setBlip', function(position, doorNumber)
	if securityJobs[PlayerJob] then
		blipDoorHack[doorNumber] = nil
		blipDoorHack[doorNumber] = AddBlipForCoord(position.x, position.y, position.z)

		SetBlipSprite(blipDoorHack[doorNumber], 161)
		SetBlipScale(blipDoorHack[doorNumber], 2.0)
		SetBlipColour(blipDoorHack[doorNumber], 5)

		PulseBlip(blipDoorHack[doorNumber])
		ESX.ShowNotification(_U('hacking_started'))
	end
end)

RegisterNetEvent('elders_locksystem:killBlip')
AddEventHandler('elders_locksystem:killBlip', function(doorNumber, type)
	if securityJobs[PlayerJob] then
		RemoveBlip(blipDoorHack[doorNumber])
		if type and type == 'failed' then
			ESX.ShowNotification(_U('hacking_failed'))
		elseif type and type == 'finished' then
			ESX.ShowNotification(_U('hack_finished'))
		end
	end
end)

RegisterNetEvent('elders_locksystem:currentlyhacking')
AddEventHandler('elders_locksystem:currentlyhacking', function(mycb)
	mycb = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",3,19,mycb1)
end)

Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(1)
		letSleep = true
		playerCoords = GetEntityCoords(PlayerPedId())
		
		if isLockpicking then
			local playerPed = PlayerPedId()
			letSleep = false
			if IsControlJustReleased(0, Config.CancelLockpickKey) or IsPedDeadOrDying(playerPed) then
				isLockpicking = false
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				exports['progressBars']:closeUI()
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.0, 'lockpick', 0.0)
				pressedButton = false
			end
			DisableAllControlActions(0)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			EnableControlAction(0, 3, true)
			EnableControlAction(0, 4, true)
			EnableControlAction(0, Config.CancelLockpickKey, true)
			FreezeEntityPosition(playerPed, true)
		end
		
		for index ,doorItem in pairs(Doors) do
		
			if showDoorID then
				local distance = #(playerCoords - vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
				if distance <= 20.0 then
					DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, 'ID : ' .. doorItem.doorID, 1.0)
					letSleep = false
				end				
			else
				local distance = #(playerCoords - vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z))
				if distance <= (doorItem.distance * 1.0) then
		
					letSleep = false
					
					local size, lockIcon = 1, _U('unlocked')

					if doorItem.size then
						size = doorItem.size 
					end

					if doorItem.locked == 1 then
						lockIcon = _U('locked') 
					end
								
					if doorItem.pincode ~= '' then
						if doorItem.authorized_jobs[PlayerJob] or doorItem.authorized_jobs[PlayerJob2] then
							DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, _U('press_button', _U('enter_password') .. lockIcon), 0.50)
						else
							if doorItem.locked == 1 then
								if doorItem.unlockable then
									DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, lockIcon .. _U('press_button', _U('enter_password') .. _U('or') .. _U('press_for_hack')) , 0.50)
								else
									DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, '', 0.50)
								end
							else
								DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, '', 0.50)
							end
						end
					else
						if doorItem.authorized_jobs[PlayerJob] or doorItem.authorized_jobs[PlayerJob2] then
							DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, _U('press_button', lockIcon), 0.50)
						else
							if doorItem.unlockable then
								if doorItem.locked == 1 then
									if doorItem.isgate then
										DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, lockIcon .. _U('press_for_hack'), 0.50)
									else
										DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, lockIcon .. _U('press_for_lockpick'), 0.50)
									end
								else
									DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, '', 0.50)
								end
							else
								DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.3, '', 0.50)
							end
						end
					end

					function mycb1(success, timeremaining)
						if success then
							doorItem.locked = 0
							pressedButton = false
							TriggerServerEvent('elders_locksystem:updateState', doorItem.doorID, doorItem.locked, true)
							TriggerEvent('mhacking:hide')
						else
							TriggerServerEvent('elders_locksystem:fail', doorItem.doorID)
							TriggerEvent('mhacking:hide')
							pressedButton = false
						end
					end
					if IsControlJustReleased(0, Config.HackAndLockpickKey) and doorItem.unlockable and pressedButton == false and doorItem.authorized_jobs[PlayerJob] == nil and doorItem.authorized_jobs[PlayerJob2] == nil then
						local door1, door2
						local door1 = GetClosestObjectOfType(vector3(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z), 1.0, doorItem.door1_hash, false, false, false)
						if doorItem.door2_coords ~= nil then
							door2 = GetClosestObjectOfType(vector3(doorItem.door2_coords.x, doorItem.door2_coords.y, doorItem.door2_coords.z), 1.0, doorItem.door2_hash, false, false, false)
						end
						
						if door1 then
							local distanceToPlayer = #(playerCoords - GetEntityCoords(door1))
							local distanceToPlayer2
							if door2 then
								distanceToPlayer2 = #(playerCoords - GetEntityCoords(door2))
							end
							
					if IsControlJustReleased(0, Config.HackAndLockpickKey) then
						print(doorItem.unlockable)
						print(pressedButton)
						print(PlayerJob)
						print(doorItem.authorized_jobs[PlayerJob])
						print(doorItem.authorized_jobs[PlayerJob2])
					end
							
							if (doorItem.isgate == false and distanceToPlayer < 1 or (door2 ~= nil and distanceToPlayer2 < 1)) or (doorItem.isgate and distanceToPlayer < 5) then
								pressedButton = true
								if doorItem.locked == 1 then
									ESX.TriggerServerCallback("elders_locksystem:checkPlayerInventory", function(result)
										if result ~= false then
											if result == "lockpick" then
												LockPick(doorItem.doorID)
											else
												if Config.KeycardCanBeBreak then
													local chance = math.random(1,100)
													if chance < Config.KeycardChance then
														TriggerServerEvent('elders_locksystem:hack', doorItem.door1_coords, doorItem.doorID)
													else
														TriggerServerEvent('elders_locksystem:removeItem', 'keycard')
														ESX.ShowNotification(_U('keycard_broken'))
														pressedButton = false														
													end
												else
													TriggerServerEvent('elders_locksystem:hack', doorItem.door1_coords, doorItem.doorID)
												end
											end
										else
											pressedButton = false
										end
									end, doorItem.pincode, doorItem.isgate)
								else
									pressedButton = false
								end
							else
								ESX.ShowNotification(_U('you_must_be_close'))
							end
						else
							ESX.ShowNotification(_U('you_must_be_close'))
						end
					end
					
					if IsControlJustReleased(0, 38) then
						if doorItem.pincode ~= '' then
							toggleField(true, doorItem.pincode, doorItem.doorID, doorItem.locked, false)
						else
							if doorItem.authorized_jobs[PlayerJob] or doorItem.authorized_jobs[PlayerJob2] then
								if doorItem.locked == 1 then
									doorItem.locked = 0
								else
									doorItem.locked = 1
								end
								TriggerServerEvent('elders_locksystem:updateState', doorItem.doorID, doorItem.locked, false) -- Broadcast new state of the door to everyone
							end
						end	
					end
				end
			end	
		end
		
        if infoOn then                                  
            letSleep = false                             
            local player = PlayerPedId()                 
            if IsPlayerFreeAiming(PlayerId()) then        
                local entity = getEntity(PlayerId())        
                local coords = GetEntityCoords(entity)      
                local heading = GetEntityHeading(entity)    
                local model = GetEntityModel(entity)       
                coordsText = coords                      
                headingText = heading                     
                modelText = model                        
				aimInfo = {
					coords  = coords,
					heading = heading,
					hash    = model
				}
            end
			
			DrawInfos("Coordonnés : " .. coordsText .. "\nHeading : " .. headingText .. "\nHash : " .. modelText)
        end
		
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

function getEntity(player)                                          
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)   
    return entity                                                   
end                                                                 

function DrawInfos(text)
    SetTextColour(255, 255, 255, 255)   
    SetTextFont(4)                      
    SetTextScale(0.6, 0.6)              
    SetTextWrap(0.0, 1.0)               
    SetTextCentre(false)                
    SetTextDropshadow(0, 0, 0, 0, 255)  
    SetTextEdge(50, 0, 0, 0, 255)       
    SetTextOutline()                    
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.51)               
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function toggleField(enable, pincode, k, locked, hacked)

  SetNuiFocus(enable, enable)
  enablePanel = enable

  SendNUIMessage({
    type = "enableui",
    enable = enable,
	pincode = pincode,
	doorindex = k,
	locked = locked,
	hacked = hacked,
  })

end

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('try', function(data, cb)
    
	SetNuiFocus(false, false)
	
	local inserted_code = data.inserted_code
	local doorindex = data.doorindex
	local locked = data.locked
	if locked == 1 then
		locked = 0
	else
		locked = 1
	end
	local hacked = data.hacked
	
	if inserted_code == data.pincode then
	
		TriggerServerEvent('elders_locksystem:updateState', doorindex, locked, false) 
		
		cb('ok')
	else
		ESX.ShowNotification(_U('wrong_code'))
		cb('ok')
	end
end)

function LockPick(doorIndex)
	isLockpicking = true
	local Timer = Config.LockPickTimer

	while not HasAnimDictLoaded("mini@safe_cracking") do
		RequestAnimDict("mini@safe_cracking")
		Wait(0)
	end
	
	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "idle_base", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.7)
	exports['progressBars']:startUI(Config.LockPickTimer, "Pick Locking")

	while Timer > 0 and isLockpicking do
		Timer = Timer - 1000
		Citizen.Wait(1000)
	end
	
	if isLockpicking then
		local chance = math.random(1,100)
		if chance < Config.LockpickChance then
			local door = Doors[doorIndex]
			TriggerServerEvent('elders_locksystem:updateState', doorIndex, false, false)	
		else
			if Config.LockpickCanGetBroken then
				TriggerServerEvent('elders_locksystem:removeItem', 'lockpick')
				ESX.ShowNotification(_U('broken_lockpick'))
			else
				ESX.ShowNotification(_U('failed_to_open'))
			end
		end
		
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.0, 'lockpick', 0.0)
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
		isLockpicking = false
		pressedButton = false
	end	
end

RegisterCommand('aimdoor', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			infoOn = true
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('cleardoors', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			infoOn = false
			aimInfo = {}
			door1Info = {}
			door2Info = {}
			textCoords = nil
			ESX.ShowNotification(_U('all_doors_clear'))
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('savedoor1', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			if aimInfo.coords ~= nil then
				door1Info = aimInfo
				ESX.ShowNotification(_U('door1_saved'))
			end
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('savedoor2', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			if door1Info.coords ~= nil then
				if aimInfo.coords ~= nil then
					door2Info = aimInfo
					ESX.ShowNotification(_U('door2_saved'))
				end
			else
				ESX.ShowNotification(_U('need_set_door1'))	
			end
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('mycoords', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			local coords = GetEntityCoords(PlayerPedId())
			textCoords = vector3(coords.x, coords.y, coords.z + 1.0)
			ESX.ShowNotification(_U('you_have_set_coords'))
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('createdoor', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			if door1Info.coords ~= nil then
				if textCoords then
					SetNuiFocus(true, true)
					
					if door2Info.coords ~= nil then
						SendNUIMessage({
							type = "createdoor",
							door1 = door1Info,
							door2 = door2Info,
							textCoords = textCoords,
							enable = true
						})
					else
						SendNUIMessage({
							type = "createdoor",
							door1 = door1Info,
							door2 = nil,
							textCoords = textCoords,
							enable = true
						})
					end
				else
					ESX.ShowNotification(_U('you_did_not_set_coords'))
				end
			else
				ESX.ShowNotification(_U('you_did_not_set_doors'))
			end
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterNUICallback('makingdoor', function(data, cb)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			SetNuiFocus(false, false)
			
			TriggerServerEvent("elders_locksystem:makingdoor", data)
			aimInfo = {}
			door1Info = {}
			door2Info = {}
			textCoords = nil
			infoOn = false
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterNUICallback('cancelmakingdoor', function(data, cb)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			SetNuiFocus(false, false)
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('doorid', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			showDoorID = not showDoorID
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('dvdoor', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			if tonumber(args[1]) then
				TriggerServerEvent("elders_locksystem:deleteDoor", tonumber(args[1]))
			else
				ESX.ShowNotification(_U('insert_correct_id'))
			end
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

RegisterCommand('codedoor', function(source, args)
	ESX.TriggerServerCallback("elders_locksystem:verifrank", function(rank)
	    if rank == "superadmin" then
			if tonumber(args[1]) then
				TriggerServerEvent("elders_locksystem:codeDoor", tonumber(args[1]))
			else
				ESX.ShowNotification(_U('insert_correct_id'))
			end
	    else
	        ESX.ShowNotification("~r~Problème~s~ : Vous ne pouvez pas effectuer cette commande !~")
	    end
	end)
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 215)
	AddTextComponentString(text)
	DrawText(_x, _y) 
end