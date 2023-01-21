ESX = nil

cachedData = {
	["houseData"] = {},
	["Cameras"] = {}
}

Citizen.CreateThread(function()
	
	while not ESX do

		TriggerEvent("god:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end
	
	if ESX.IsPlayerLoaded() then
		DecorRegister('instance', 3)
		FetchHouseData()
	end

end)

RegisterNetEvent("god:playerLoaded")
AddEventHandler("god:playerLoaded", function(xPlayer)
	ESX.PlayerData = xPlayer
	DecorRegister('instance', 3)
	FetchHouseData()
end)

RegisterNetEvent("god:setJob")
AddEventHandler("god:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterCommand("fetch", function()
	FetchHouseData()
end)

RegisterNetEvent("burglary:eventHandler")
AddEventHandler("burglary:eventHandler", function(response, eventData)
	if response == "lockpick_house" then
		cachedData["houseData"][eventData["houseId"]] = {
			["Lootables"] = {}
		}
		--if Config.Coords[eventData["houseId"]].South then
			if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" then
				ESX.ShowNotification("Cambriolage " .. Config.Coords[eventData["houseId"]]["Info"] .. ", position envoyée.")
				CreateBlip(eventData)
			end
		--else
			if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "sheriff" then
				ESX.ShowNotification("Cambriolage " .. Config.Coords[eventData["houseId"]]["Info"] .. ", position envoyée.")
				CreateBlip(eventData)
			end
		--end
		
	elseif response == "lock_house" then
		cachedData["houseData"][eventData["houseId"]] = {
			["locked"] = true
		}
		if ESX.PlayerData["job"]["name"] == "police" or ESX.PlayerData["job"]["name"] == "sheriff" then
			if DoesBlipExist(cachedData[eventData["houseId"]]) then
				RemoveBlip(cachedData[eventData["houseId"]])
			end
			ESX.ShowNotification("Porte vérouillée et alarme désactivée")
		end
	elseif response == "loot_place" then
		cachedData["houseData"][eventData["houseId"]]["Lootables"][eventData["lootSpot"]] = true
	else	
 		print("Wrong event handler: " .. response)
	end
end)

Citizen.CreateThread(function()
	Wait(500)
	
	while true do
		
		local sleep = 500
		local pedCoords = GetEntityCoords(PlayerPedId())
		
		for id,data in pairs(Config.Coords) do
			
			local dstcheck = #(data["Pos"] - pedCoords)
			local text = data["Info"]

			if dstcheck <= 5.5 then
				sleep = 5
				if dstcheck <= 1.3 then
					if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" or ESX.PlayerData["job"]["name"] == "sheriff" then
						text = "[~b~E~s~] " .. (cachedData["houseData"][id] and "Entrer | [~r~G~s~] Vérouiller." or "Crocheter") .. " \n" .. data["Info"]
						if IsControlJustReleased(0, 38) then
							if not cachedData["houseData"][id] then
								ESX.TriggerServerCallback("aCambriolage:veriflockpick", function(data)
									if data then
										ESX.TriggerServerCallback("burglary:isHouseRobbable", function(robbable)
											if robbable then BeginLockpick(id, data)
											else ESX.ShowNotification("Pas assez de policiers.")
											end
										end)
									else
										ESX.ShowNotification("Vous n'avez pas de Lockpick.")
									end
								end)
							elseif cachedData["houseData"][id] and not cachedData["houseData"][id]["locked"] then
								EnterHouse(id, data)
							else
								ESX.ShowNotification("Il semble que vous ne puissiez pas crocheter cette porte.")
							end
						elseif IsControlJustReleased(0, 58) then
							if cachedData["houseData"][id] and not cachedData["houseData"][id]["locked"] then
								LockHouse(id, data, "Vérouiller." or "Crocheter")
							else
								ESX.ShowNotification("Déjà vérouillée!")
							end
						end
					else
						text = "[~b~E~s~] " .. (cachedData["houseData"][id] and "Entrer" or "Crocheter") .. " \n" .. data["Info"]
						if IsControlJustReleased(0, 38) then
							if not cachedData["houseData"][id] then
								local south = data["South"]
								ESX.TriggerServerCallback("aCambriolage:veriflockpick", function(data)
									if data then
										ESX.TriggerServerCallback("burglary:isHouseRobbable", function(robbable)
											if robbable then
												BeginLockpick(id, data)
												local playerPed = PlayerPedId()
												local coords = GetEntityCoords(playerPed, true)
												TriggerServerEvent('cambriolage:alertepolice', coords)
											else
												ESX.ShowNotification("Pas assez de policiers.")
											end
										end, south)
									else
										ESX.ShowNotification("Tu as besoin d'un kit de crochetage.")
									end
								end)
							elseif cachedData["houseData"][id] and not cachedData["houseData"][id]["locked"] then
								EnterHouse(id, data)
							else
								ESX.ShowNotification("Il semble que vous ne puissiez pas crocheter cette porte.")
							end
						end
					end
				end
				if Config.EnableHouseText then ESX.Game.Utils.DrawText3D(data["Pos"], text, 0.6) end
				DrawMarker(6, data["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
			end
			
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('cambriolage:alertePolice')
AddEventHandler('cambriolage:alertePolice', function(coords)
	ESX.ShowAdvancedNotification('Centrale', '~b~Demande d\'intervention', '~b~Info : ~w~Cambriolage\n~b~Individu : ~w~Inconnu\n~b~Localisation : ~s~Zone sur GPS', "CHAR_CALL911", 2)
	local alpha = 250
	local gunshotBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
	SetBlipHighDetail(gunshotBlip, true)
	SetBlipColour(gunshotBlip, 1)
	SetBlipAlpha(gunshotBlip, alpha)
	SetBlipAsShortRange(gunshotBlip, true)
	while alpha ~= 0 do
		Wait(15 * 4)
		alpha = alpha - 1
		SetBlipAlpha(gunshotBlip, alpha)

		if alpha == 0 then
			RemoveBlip(gunshotBlip)
			return
		end
	end
end)