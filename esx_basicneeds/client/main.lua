ESX          = nil
local IsDead = false
local IsAnimated = false
diag = 0
locksound = false
pillused = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('god_basicneeds:resetStatus', function()
	TriggerEvent('god_status:set', 'hunger', 500000)
	TriggerEvent('god_status:set', 'thirst', 500000)
	TriggerEvent('god_status:set', 'stress', 500000)
end)

AddEventHandler('playerSpawned', function()

	if IsDead then
		TriggerEvent('god_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('playerSpawnedambu', function(spawn)

	if IsDead then
		TriggerEvent('god_basicneeds:resetStatus')
	end
	
	isDead = false
end)

RegisterNetEvent('god_basicneeds:stamina')
AddEventHandler('god_basicneeds:stamina', function(prop_name)
local round = 0
 	while true do
 		if round <= 120 then
		    Citizen.Wait(500)
		    ResetPlayerStamina(PlayerId())
		    round = round + 1
		else
			break
		end
	end
end)

RegisterNetEvent('god_basicneeds:staminavodka')
AddEventHandler('god_basicneeds:staminavodka', function(prop_name)
local round = 0
 	while true do
 		if round <= 360 then
		    Citizen.Wait(500)
		    ResetPlayerStamina(PlayerId())
		    round = round + 1
		else
			break
		end
	end
end)

AddEventHandler('god_status:loaded', function(status)
	TriggerEvent('god_status:registerStatus', 'hunger', 1000000, '#CFAD0F',
		function(status)
			return false
		end,
		function(status)
			status.remove(1800)
		end
	)

	TriggerEvent('god_status:registerStatus', 'thirst', 1000000, '#0C98F1',
		function(status)
			return false
		end,
		function(status)
			status.remove(2000)
		end
	)

	TriggerEvent('god_status:registerStatus', 'stress', 1000000, '#cadfff', 
		function(status)
			return false
		end, 
		function(status)
			status.add(1)
	end)

	TriggerEvent('god_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
        return false
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('god_status:getStatus', 'hunger', function(status)
				if status.val >= 50000 then
					diag = 0
				end
				if status.val < 50000 and diag == 0 then
					ESX.ShowNotification("Vous allez mourir de faim si vous ne mangez pas...")
					diag = 1
				end
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end

				end

			end)

			TriggerEvent('god_status:getStatus', 'thirst', function(status)
				if status.val >= 50000 then
					diag = 0
				end
				if status.val < 50000 and diag == 0 then
					ESX.ShowNotification("Vous allez mourir de soif si vous ne buvez pas...")
					diag = 1
				end
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 2
					else
						health = health - 1
					end

				end

			end)

		end

	end)

	Citizen.CreateThread(function()

		while true do

			Wait(0)

			local playerPed = PlayerPedId()
			
			if IsEntityDead(playerPed) and not IsDead then
				IsDead = true
			end

		end

	end)

end)

AddEventHandler('god_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('god_basicneeds:onEat')
AddEventHandler('god_basicneeds:onEat', function(prop_name)
    if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_burger_01'
    	IsAnimated = true
	    local playerPed = PlayerPedId()
	    Citizen.CreateThread(function()
	        local x,y,z = table.unpack(GetEntityCoords(playerPed))
	        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
	        RequestAnimDict('mp_player_inteat@burger')
	        while not HasAnimDictLoaded('mp_player_inteat@burger') do
	            Wait(0)
	        end
	        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
	        Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
	        DeleteObject(prop)
	    end)
	end
end)

RegisterNetEvent('god_basicneeds:onDrink')
AddEventHandler('god_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		local playerPed = PlayerPedId()
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)			
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('god_basicneeds:pillule')
AddEventHandler('god_basicneeds:pillule', function()
	ESX.ShowNotification('Tu as utilisé une pillule de l\'oublie !')
	ExecuteCommand("me As utilisé une pillule de l\'oublie !")
	Citizen.CreateThread(function()
    	while true do
	       Citizen.Wait(0)      
	            if pillused == true then
				
					StartScreenEffect("DeathFailOut", 0, 0)
					if not locksound then
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
					locksound = true
					pillused = true
					end
					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

					if HasScaleformMovieLoaded(scaleform) then
						Citizen.Wait(0)

					PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					BeginTextComponent("STRING")
					AddTextComponentString('~b~Vous tombez dans l\'oublie... Vous reviendrez bientot à vous....')
					EndTextComponent()
					PopScaleformMovieFunctionVoid()

				    Citizen.Wait(100)
					PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                    while pillused == true do
					  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					  SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
					  DisablePlayerFiring(PlayerId(), true)
					  Citizen.Wait(0)
                    end

				  StopScreenEffect("DeathFailOut")
				  locksound = false

				end
			end
	    end
	end)
	TriggerServerEvent('pillule')
end)

RegisterNetEvent('god_basicneeds:stoppill')
AddEventHandler('god_basicneeds:stoppill', function()
        stopPill()
end)

function stopPill()
    pillused = false
end

RegisterNetEvent('god_optionalneeds:onDrink')
AddEventHandler('god_optionalneeds:onDrink', function()
  
  local playerPed = PlayerPedId()
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)

end)