ESX = nil

cachedData = {
	["motelRooms"] = {},
	["blips"] = {}
}

Citizen.CreateThread(function()
	
	while not ESX do

		TriggerEvent("god:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end
	
	if ESX.IsPlayerLoaded() then
		Init()
	end

end)

RegisterNetEvent("god:playerLoaded")
AddEventHandler("god:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
	
	Init()
end)

RegisterNetEvent("god:setJob")
AddEventHandler("god:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 5000

		local ped = PlayerPedId()
		
		if ped ~= cachedData["ped"] then
			cachedData["ped"] = ped
		end

		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)

	if Config.EnableKeySystem and not exports["pluto-keys"] then
		Trace("You have enabled keys and the resource pluto-keys doesn't exist. Make sure to start pluto-keys.")
		Config.EnableKeySystem = false
	end

	while true do
		
		local sleepThread = 500

		local ped = cachedData["ped"]
		cachedData["pedCoords"] = GetEntityCoords(ped)

		for _, motelData in pairs(Config.Motels) do
			
			local motelDistance = #(cachedData["pedCoords"] - motelData["motelPosition"])
			local raidText = nil
			local raidText2 = nil
			local raidText3 = nil

			CreateBlips(motelData)
			
			if motelDistance <= 50.0 then
				if not cachedData["stopSearching"] then
					cachedData["doorHandle"] = GetClosestObjectOfType(cachedData["pedCoords"], 5.0, motelData["doorHash"])
					cachedData["doorCoords"] = GetEntityCoords(cachedData["doorHandle"])
					cachedData["doorRoom"] = GetInteriorFromEntity(cachedData["doorHandle"])
				elseif cachedData["stopSearching"] and not cachedData["doorHandle"] or not cachedData["doorCoords"] or not cachedData["doorRoom"] then
					cachedData["doorHandle"] = GetClosestObjectOfType(cachedData["pedCoords"], 5.0, motelData["doorHash"])
					cachedData["doorCoords"] = GetEntityCoords(cachedData["doorHandle"])
					cachedData["doorRoom"] = GetInteriorFromEntity(cachedData["doorHandle"])
				end
				
				local interiorId = GetInteriorFromEntity(ped)
				local roomId = cachedData["doorCoords"]["y"] .. cachedData["doorCoords"]["x"]  .. cachedData["doorCoords"]["z"]
				local roomNumber = string.sub(cachedData["doorCoords"]["x"], 7, 8) .. string.sub(cachedData["doorCoords"]["y"], 4, 4) .. string.sub(cachedData["doorCoords"]["z"], 2, 2)
				local doorUnlockable = false
				local doorState = DoorSystemGetDoorState(cachedData["doorHandle"])
				local helpText = motelData["rentMode"] and "- Location $" .. (Config.RentTimer >= 24 and motelData["motelPrice"] .. "/jour" or round(motelData["motelPrice"] / cachedData["motelRooms"][roomId]["hourtake"], 2) .. "/heure") or "Buy room for $" .. motelData["motelPrice"] .. "."
				local dstCheck = #(cachedData["pedCoords"] - cachedData["doorCoords"])
				local roomRentable = true

				if not IsDoorRegisteredWithSystem(cachedData["doorHandle"]) then
					AddDoorToSystem(cachedData["doorHandle"], motelData["doorHash"], cachedData["doorCoords"], 0, true, false)

					if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomLocked"] ~= doorState then
						DoorSystemSetDoorState(cachedData["doorHandle"], cachedData["motelRooms"][roomId]["roomLocked"], true, true)
					else
						DoorSystemSetDoorState(cachedData["doorHandle"], true, true, true)
					end
				else
					if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomLocked"] ~= doorState then
						DoorSystemSetDoorState(cachedData["doorHandle"], cachedData["motelRooms"][roomId]["roomLocked"], true, true)
					end
				end
				
				if cachedData["motelRooms"][roomId] then
					roomRentable = false
					helpText = ""

					if Config.EnableKeySystem then
						if exports["pluto-keys"]:HasKey("room-"..roomId) then
							doorUnlockable = true
							helpText = ""
						end
					end
					
					if cachedData["motelRooms"][roomId]["roomOwner"] == ESX.PlayerData["identifier"] then
						local h, m = ConvertTime(cachedData["motelRooms"][roomId]["paymentTimer"]) 
						local latestPayment = cachedData["motelRooms"][roomId]["paymentTimer"]
						helpText = latestPayment > cachedData["motelRooms"][roomId]["hourtake"] and "- Retard de paiement-Payez votre chambre." or "- Paiement OK."
						doorUnlockable = true
					end

					if Config.RaidEnabled and not doorUnlockable and not roomRentable and doorState == 1 then
						if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == Config.RaidJob or ESX.PlayerData["job"]["name"] == Config.RaidJob2 then
							raidText = "Perquisitionner chambre " .. roomNumber
						end
					else
						raidText = nil
					end
					if Config.RaidEnabled and not doorUnlockable and not roomRentable and doorState == 0 then
						if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == Config.RaidJob or ESX.PlayerData["job"]["name"] == Config.RaidJob2 then
							raidText2 = "Fermer chambre " .. roomNumber
						end
					else
						raidText2 = nil
					end
					if Config.RobEnabled and not doorUnlockable and not roomRentable and doorState == 1 then
						if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] ~= Config.RaidJob and ESX.PlayerData["job"]["name"] ~= Config.RaidJob2 then
							raidText3 = "Cambrioler chambre " .. roomNumber
						end
					else
						raidText3 = nil
					end
				end
				
				if motelData["roomFinish"] then
					if not cachedData["previewingDesign"] then
						if not IsInteriorEntitySetActive(cachedData["doorRoom"], cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomFinish"] or motelData["roomFinish"]) then
							ActivateInteriorEntitySet(cachedData["doorRoom"], cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomFinish"] or motelData["roomFinish"])
							if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["oldFinish"] then
								DeactivateInteriorEntitySet(cachedData["doorRoom"], cachedData["motelRooms"][roomId]["oldFinish"])
							end
							RefreshInterior(cachedData["doorRoom"])
						end
					end
				end

				if dstCheck <= 10.0 then
					sleepThread = 0

					if dstCheck <= 4.0 then
						local doorOffset = GetOffsetFromEntityInWorldCoords(cachedData["doorHandle"], motelData["doorOffset"])
						
						if dstCheck <= 1.1 then
							if IsControlJustReleased(0, 47) then
								if doorUnlockable then 
									doorState = doorState == 1 and 0 or 1
									cachedData["motelRooms"][roomId]["roomLocked"] = doorState
									DoorSystemSetDoorState(cachedData["doorHandle"], doorState, true, true)
									TriggerServerEvent("pluto_motels:syncDoorState", roomId, doorState)
								else
									ESX.ShowNotification("Vous ne pouvez pas ouvrir cette porte.")
								end
							end

							if roomRentable and IsControlJustReleased(0, 47) then
								local input = OpenInput("Combien de nuit(s)? ", "input")
								while input == nil do
							    Wait(0)
							    end
								local amount = tonumber(input) * 24
								
								if amount > 0 then
									ESX.TriggerServerCallback("pluto_motels:rentRoom", function(rented, errorMessage)
										if rented then
											if Config.EnableKeySystem then
												exports["pluto-keys"]:AddKey({
													["label"] = motelData["motelName"] .. " - room " .. roomNumber,
													["keyId"] = "room-" .. roomId,
													["uuid"] = NetworkGetRandomInt()
												})
											end
											ESX.ShowNotification("Vous venez de " .. (motelData["rentMode"] and "louer une chambre " or "acheter une chambre ") .. roomNumber)-- .. " for $" .. motelData["motelPrice"])
										else
											ESX.ShowNotification(errorMessage)
										end
									end, roomId, motelData, amount)
								else
									ESX.ShowNotification("Vous ne pouvez pas entrer un nombre inférieur à 1")
								end
							end
							
							if raidText and IsControlJustReleased(0, 74) then
								ESX.TriggerServerCallback("pluto_motels:CheckLicense", function(license)
									if license then
										RaidRoom(roomId, cachedData["doorHandle"])                                    
									else
                                        ESX.ShowNotification("Vous n'avez pas de mandat de perquisition")
                                    end
								end, 'mandat')
							end

							if raidText2 and IsControlJustReleased(0, 74) then
								RaidRoom2(roomId, cachedData["doorHandle"])
							end

							if raidText3 and IsControlJustReleased(0, 74) then
								ESX.TriggerServerCallback("pluto_motels:checkifonline", function(license)
									if license then
										RaidRoom3(roomId, cachedData["doorHandle"])                                    
									else
                                        ESX.ShowNotification("Quelqu'un dors à l'intérieur")
                                    end
								end, roomId)
							end

							if doorUnlockable or roomRentable or raidText or raidText2 or raidText3 then
								local displayText = not roomRentable and raidText and "Pressez ~INPUT_VEH_HEADLIGHT~ pour " or not roomRentable and raidText2 and "Pressez ~INPUT_VEH_HEADLIGHT~ pour " or not roomRentable and raidText3 and "Pressez ~INPUT_VEH_HEADLIGHT~ pour " or "Pressez ~INPUT_DETONATE~ pour "
								displayText = displayText .. (doorUnlockable and (doorState == 1 and "ouvrir la chambre." or "fermer la chambre.") or roomRentable and (motelData["rentMode"] and "louer une chambre." or "acheter une chambre.") or raidText and (not roomRentable and raidText or "") or raidText2 and (not roomRentable and raidText2 or "") or raidText3 and (not roomRentable and raidText3 or "") or "")
								HelpNotification(displayText)
							end
						end

						DrawScriptText(doorOffset, "Chambre " ..  roomNumber .. " - " ..(doorState == 1 and "~r~Fermée~s~ " or "~g~Ouverte~s~ ") .. helpText)
					end
					
					if interiorId ~= 0 then

						cachedData["stopSearching"] = true

						inRoom = true

						for furnitureName, furnitureData in pairs(motelData["furniture"]) do
							local furnitureCoords = GetOffsetFromInteriorInWorldCoords(interiorId, furnitureData["offset"])
							local furnitureDistance = #(cachedData["pedCoords"] - furnitureCoords)

							if not furnitureData["restricted"] then
								if furnitureDistance <= 1.0 then
									if IsControlJustReleased(0, 38) then
										furnitureData["callback"](roomId, furnitureName, motelData)
									end
									HelpNotification("Pressez ~INPUT_CONTEXT~ pour ouvrir "..furnitureData["text"])
								end
								DrawScriptText(furnitureCoords, furnitureData["text"])
							else
								if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomOwner"] == ESX.PlayerData["identifier"] then
									if furnitureDistance <= 1.0 then
										if IsControlJustReleased(0, 38) then
											furnitureData["callback"](roomId, furnitureName, motelData)
										end
										HelpNotification("Pressez ~INPUT_CONTEXT~ pour ouvrir "..furnitureData["text"])
									end
									DrawScriptText(furnitureCoords, furnitureData["text"])
								end
							end
						end
					else
						cachedData["stopSearching"] = false
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

if Config.CancelRoomCommand then
	RegisterCommand(Config.CancelRoomCommand, function()
		local roomId = cachedData["doorCoords"]["y"] .. cachedData["doorCoords"]["x"]  .. cachedData["doorCoords"]["z"]
		
		for _, motelData in pairs(Config.Motels) do
			if #(cachedData["pedCoords"] - motelData["motelPosition"]) <= 50.0 then
				if #(cachedData["pedCoords"] - cachedData["doorCoords"]) <= 2.0 then
					if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomOwner"] == ESX.PlayerData["identifier"] then
						if GetInteriorFromEntity(cachedData["ped"]) == 0 then
							ESX.TriggerServerCallback("pluto_motels:cancelRoom", function(canceled)
								if canceled then
									ESX.ShowNotification("Cette chambre ne vous appartient plus.")
									cachedData["motelRooms"][roomId]["roomLocked"] = 1
									DoorSystemSetDoorState(cachedData["doorHandle"], 1, true, true)
									TriggerServerEvent("pluto_motels:syncDoorState", roomId, 1)
								end
							end, roomId, motelData)
						else
							ESX.ShowNotification("Sortez de la chambre et soyez sure que personne est à l'intérieur.")
						end
					else
						ESX.ShowNotification("Cette chambre n'est pas à vous.")
					end
				else
					ESX.ShowNotification("Soyez pret de la porte.")
				end
			end
		end
	end)
end

RegisterNetEvent("pluto_motels:syncRooms")
AddEventHandler("pluto_motels:syncRooms", function(motelData)
	if motelData then
		cachedData["motelRooms"] = motelData
	end
end)

RegisterNetEvent("pluto_motels:syncDoorState")
AddEventHandler("pluto_motels:syncDoorState", function(roomId, roomLocked)
	cachedData["motelRooms"][roomId]["roomLocked"] = roomLocked
end)

RegisterNetEvent("pluto_motels:changeInteriorFinish")
AddEventHandler("pluto_motels:changeInteriorFinish", function(roomId, interiorId, oldInterior, newInterior)
	DeactivateInteriorEntitySet(interiorId, oldInterior)
	ActivateInteriorEntitySet(interiorId, newInterior)
	RefreshInterior(interiorId)
end)