Init = function()
	ESX.TriggerServerCallback("pluto_motels:fetchMotelRooms", function(fetchedMotels)
		if fetchedMotels then
			cachedData["motelRooms"] = fetchedMotels
		else
			Trace(fetchedMotels)
		end
	end)
end

OpenStash = function(interiorId, storageName)
	if Config.DiscInventory then
		TriggerEvent("disc-inventoryhud:openInventory", {
			["type"] = "pluto_motels",
			["owner"] = interiorId .. " - " .. storageName
		})
	else
		StashMenu(interiorId, storageName)
	end
end

RaidRoom = function(roomId)
	RequestAnimDict('missheistfbisetup1')
    while not HasAnimDictLoaded('missheistfbisetup1') do
        Wait(0)
    end
	local timer = 0
    TaskPlayAnim(cachedData["ped"], 'missheistfbisetup1', 'hassle_intro_loop_f', 8.0, -8, -1, 11, 0, 0, 0, 0)
	Wait(600)
	DrawBusySpinner("Forcage de la porte en cours...")
	while true do
        if IsEntityPlayingAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 3) then
            timer = timer+10
            if math.floor((timer / 1000) / Config.RaidTimer * 100) >= 100 then
				cachedData["motelRooms"][roomId]["roomLocked"] = 0
				DoorSystemSetDoorState(cachedData["doorHandle"], 0, true, true)
				TriggerServerEvent("pluto_motels:syncDoorState", roomId, 0)
				TriggerServerEvent("pluto_motels:deletemandat", 'mandat')
				ClearPedTasksImmediately(PlayerPedId())
                break
            end
        else
            ESX.ShowNotification('Vous avez annulé la perquisition.')
            break
        end
        Wait(0)
    end
	RemoveLoadingPrompt()
end

RaidRoom3 = function(roomId)
	ESX.TriggerServerCallback("pluto_motels:GetItemVol", function(quantity)
        if quantity >= 1 then
        	TriggerEvent('pluto_motels:encourcabriolagechambre')
            TriggerEvent('ultra-fingerprint', 2, 80, function(outcome, reason)
                if outcome == 1 then
                	cachedData["motelRooms"][roomId]["roomLocked"] = 0
					DoorSystemSetDoorState(cachedData["doorHandle"], 0, true, true)
					TriggerServerEvent("pluto_motels:syncDoorState", roomId, 0)
                end
            end)
        else
            ESX.ShowNotification("~r~Vous n'avez pas d'ordinateur de hacking !")
        end
    end, 'laptop_h') 
end

encourcabriolagechambre = false

RegisterNetEvent("pluto_motels:encourcabriolagechambre")
AddEventHandler("pluto_motels:encourcabriolagechambre", function(coords)
    Citizen.CreateThread(function()
        if not encourcabriolagechambre then
            encourcabriolagechambre = true
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed, true)
            TriggerServerEvent("pluto_motels:alertepolice", coords)
            Citizen.Wait(60000)
            encourcabriolagechambre = false
        end
    end)
end)

RegisterNetEvent("pluto_motels:alertePolice")
AddEventHandler("pluto_motels:alertePolice", function(coords)
    ESX.ShowAdvancedNotification('Centrale', '~b~Demande d\'intervention', '~b~Info : ~w~Cambriolage de chambre\n~b~Individu : ~w~Inconnu\n~b~Localisation : ~s~Zone sur GPS', "CHAR_CALL911", 2)
    local alpha = 250
    local gunshotBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
    SetBlipHighDetail(gunshotBlip, true)
    SetBlipColour(gunshotBlip, 1)
    SetBlipAlpha(gunshotBlip, alpha)
    SetBlipAsShortRange(gunshotBlip, true)
    while alpha ~= 0 do
        Wait(45 * 4)
        alpha = alpha - 1
        SetBlipAlpha(gunshotBlip, alpha)

        if alpha == 0 then
            RemoveBlip(gunshotBlip)
            return
        end
    end
end)

RaidRoom2 = function(roomId)
	RequestAnimDict('missheistfbisetup1')
    while not HasAnimDictLoaded('missheistfbisetup1') do
        Wait(0)
    end
	local timer = 0
    TaskPlayAnim(cachedData["ped"], 'missheistfbisetup1', 'hassle_intro_loop_f', 8.0, -8, -1, 11, 0, 0, 0, 0)
	Wait(600)
	DrawBusySpinner("Fermeture de la porte...")
	while true do
        if IsEntityPlayingAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 3) then
            timer = timer+10
            if math.floor((timer / 1000) / Config.RaidTimer * 100) >= 100 then
				cachedData["motelRooms"][roomId]["roomLocked"] = 1
				DoorSystemSetDoorState(cachedData["doorHandle"], 1, true, true)
				TriggerServerEvent("pluto_motels:syncDoorState", roomId, 1)
				ClearPedTasksImmediately(PlayerPedId())
                break
            end
        else
            ESX.ShowNotification('Vous avez annulé la fermeture de la porte.')
            break
        end
        Wait(0)
    end
	RemoveLoadingPrompt()
end

RoomManagment = function(roomId, roomNumber, motelData)
	local menuElements = {}
	local setTime = true
	
	if motelData["roomFinish"] then
		table.insert(menuElements, {
			["label"] = " - Design chambre - ",
		})

		for _, designData in pairs(Config.RoomFinishes) do
			table.insert(menuElements, {
				["label"] = designData["name"] .. " - $" .. designData["price"] .. (cachedData["motelRooms"][roomId]["roomFinish"] == designData["finish"] and " - Current design" or ""),
				["roomFinish"] = designData["finish"],
				["price"] = designData["price"],
				["action"] = cachedData["motelRooms"][roomId]["roomFinish"] == designData["finish"] and "currentDesign" or "changeDesign"
			})
		end
	end

	table.insert(menuElements, {
		["label"] = " - Paiement chambre - ",
	})
	
	if Config.EnableKeySystem then
		table.insert(menuElements, {
			["label"] = "Acheter une clef en plus $" ..Config.KeyPrice,
			["action"] = "key"
		})
	end

	local setTime = true

	if motelData["rentMode"] then
		setTime = false
		ESX.TriggerServerCallback("pluto_motels:fetchRentTime", function(fetchedTime, error)
			if fetchedTime then
				local h, m = ConvertTime(cachedData["motelRooms"][roomId]["hourtake"] - fetchedTime)
				local missedPayment = fetchedTime > cachedData["motelRooms"][roomId]["hourtake"] or false
				local payments = MissedPayments(fetchedTime, cachedData["motelRooms"][roomId]["hourtake"])
				-- local paymentLabel = missedPayment and (days > 1 and days .. " days " (hours > 0 and " and " .. hours .. (hours > 1 "hours " or "hour ")) .. " pay now." or hours .. " hours since payment.") or .. "payment missed, pay now." or "Next payment is in " .. (h > 0 and h .. " hours and " .. math.floor(m) .. " minutes" or math.floor(m) .. " minutes")
				local paymentLabel = missedPayment and "You have " .. (payments > 1 and payments .. " missed payments" or payments .."missed payment")  or "Next payment is in " .. (h > 0 and h .. " hours and " .. math.floor(m) .. " minutes" or math.floor(m) .. " minutes")
				table.insert(menuElements, {
					["label"] = paymentLabel,
					["time"] = fetchedTime,
					["missedPayments"] = payments or 0,
					["action"] = "payment"
				})
				setTime = true
			else
				Trace(error)
			end
		end, roomId)
	end

	table.insert(menuElements, {
		["label"] = " - Quitter sa chambre - ",
	})
	table.insert(menuElements, {
		["label"] = " - Dehors et /rendrechambre - ",
	})

	while not setTime do
		Citizen.Wait(0)
	end

	ESX.UI.Menu.Open("native", GetCurrentResourceName(), "management_menu", {
		["title"]    = "Room managment",
		["align"]    = "center",
		["elements"] = menuElements
	}, function(menuData, menuHandle)
		local current = menuData["current"]

		if current["action"] == "payment" then
			if current["missedPayments"] > 0 then
				local input = OpenInput("Combien de nuit(s)? ", "input")
				while input == nil do
			    Wait(0)
			    end
				local amount = tonumber(input) * 24
				if amount > 0 then
				DrawBusySpinner("processing transaction...")
					ESX.TriggerServerCallback("pluto_motels:payRent", function(proccesed)
						while not proccesed do
							Citizen.Wait(0)
						end
						RemoveLoadingPrompt()
						ESX.ShowNotification("Vous avez payé votre chambre")--. $" ..motelData["motelPrice"] * current["missedPayments"])
					end, roomId, current["missedPayments"], motelData, amount)
				else
					ESX.ShowNotification("Vous ne pouvez pas entrer un nombre inférieur à 1")
				end
			else
				local h, m = ConvertTime(cachedData["motelRooms"][roomId]["hourtake"] - current["time"]) 

				ESX.ShowNotification("La chambre est déjà payé pour l'instant, revenez dans " .. (h > 0 and h .. "hours and " .. math.floor(m) .. " minutes" or math.floor(m) .. " minutes") .. " to pay.")
			end

			menuHandle.close()
		elseif current["action"] == "changeDesign" then
			cachedData["previewingDesign"] = true
			local previewInterior = GetInteriorFromEntity(cachedData["ped"])
			local pedCoords = GetEntityCoords(cachedData["ped"])
			DoScreenFadeOut(1200)
			Citizen.Wait(1200)
			DeactivateInteriorEntitySet(previewInterior, cachedData["motelRooms"][roomId]["roomFinish"])
			ActivateInteriorEntitySet(previewInterior, current["roomFinish"])
			Wait(250)
			RefreshInterior(previewInterior)
			DoScreenFadeIn(1200)
			DrawBusySpinner("Prévisualisation de l'intérieur...")
			menuHandle.close()
			while cachedData["previewingDesign"] do
				fetchDoor = false
				Citizen.Wait(0)

				local dstCheck = #(GetEntityCoords(cachedData["ped"]) - pedCoords)

				if IsControlJustReleased(0, 74) then
					ESX.TriggerServerCallback("pluto_motels:updateInteriorFinish", function(changed, errorMessage)
						if changed then
							cachedData["previewingDesign"] = false
						else
							ESX.ShowNotification(errorMessage)
							cachedData["previewingDesign"] = false
						end
					end, current["price"], roomId, cachedData["motelRooms"][roomId]["roomFinish"], current["roomFinish"])
				elseif IsControlJustReleased(0, 177) then
					DoScreenFadeOut(1200)
					Citizen.Wait(1500)
					DoScreenFadeIn(1500)
					DeactivateInteriorEntitySet(previewInterior, current["roomFinish"])
					RefreshInterior(previewInterior)
					cachedData["previewingDesign"] = false
				end
				if dstCheck > 10.0 then
					DeactivateInteriorEntitySet(previewInterior, current["roomFinish"])
					ActivateInteriorEntitySet(previewInterior, cachedData["motelRooms"][roomId]["roomFinish"])
					RefreshInterior(previewInterior)
					ESX.ShowNotification("Vous etes parti trop loin.")
					cachedData["previewingDesign"] = false
				end
				ESX.ShowHelpNotification("Pressez ~INPUT_VEH_HEADLIGHT~ pour confirmer l'achat ou ~INPUT_CELLPHONE_CANCEL~ pour annuler.")
			end
			RefreshInterior(previewInterior)
			RemoveLoadingPrompt()
		elseif current["action"] == "currentDesign" then
			ESX.ShowNotification("Vous avez déjà ce design.")
		elseif current["action"] == "key" then
			if cachedData["motelRooms"][roomId]["roomOwner"] == ESX.PlayerData["identifier"] then
				ESX.TriggerServerCallback("pluto_motels:canBuyKey", function(buykey)
					if buykey then
						exports["pluto-keys"]:AddKey({
							["label"] = motelData["motelName"] .. " - room " .. roomNumber,
							["keyId"] = "room-" .. roomId,
							["uuid"] = NetworkGetRandomInt()
						})
					else
						ESX.ShowNotification("Vous n'avez pas assez d'argent.")
					end
				end)	
			end
		else
			menuHandle.close()
		end	
		menuHandle.close()
	end, function(menuData, menuHandle)

		menuHandle.close()
	end)
end

StashMenu = function(roomId, storageName)
	local menuElements = {
		{
			["label"] = "Rangement objet",
			["action"] = "store"
		},
	}

	if Config.StoreCash then
		table.insert(menuElements, {
			["label"] = "Rangement cash",
			["action"] = "storeCurrency",
			["currency"] = "cash"
		})
	end
	if Config.StoreBlackMoney then
		table.insert(menuElements, {
			["label"] = "Rangement black money",
			["action"] = "storeCurrency",
			["currency"] = "black_money"
		})
	end

	if Config.StoreCash or Config.StoreBlackMoney then
		table.insert(menuElements, {
			["label"] = " - Coffre - ",
		})
	end
	
	if Config.StoreCash then
		if cachedData["motelRooms"][roomId] and cachedData["motelRooms"][roomId]["roomData"]["roomStorages"][storageName]["cash"] > 0 then
			table.insert(menuElements, {
				["label"] = "Cash: $" .. cachedData["motelRooms"][roomId]["roomData"]["roomStorages"][storageName]["cash"],
				["action"] = "takeCurrency",
				["currency"] = "cash"
			})
		end
	end

	if Config.StoreBlackMoney then
		if cachedData["motelRooms"][roomId]["roomData"]["roomStorages"][storageName]["black_money"] > 0 then
			table.insert(menuElements, {
				["label"] = "Black money: " .. cachedData["motelRooms"][roomId]["roomData"]["roomStorages"][storageName]["black_money"],
				["action"] = "takeCurrency",
				["currency"] = "black_money"
			})
		end
	end
	
	if not roomId then return end

	ESX.TriggerServerCallback("pluto_motels:fetchStorage", function(fetchedStorage, errorMessage)
		
		if fetchedStorage then
			table.insert(menuElements, {
				["label"] = " - OBJETS -",
			})

			for _, itemData in ipairs(fetchedStorage["items"]) do
				if itemData["item"] then
					table.insert(menuElements, {
						["label"] = itemData["amount"] .. " " .. itemData["label"],
						["item"] = itemData["item"],
						["realLabel"] = itemData["label"],
						["amount"] = itemData["amount"],
						["action"] = "take"
					})
				end
			end

			OpenMenu(menuElements, roomId, storageName)
		else
			table.insert(menuElements, {
				["label"] = "Le stockage est vide.",
			})
			OpenMenu(menuElements, roomId, storageName)
		end
	end, roomId, storageName)
end

Wardrobe = function()
	ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)

		local elements = {}

		for i=1, #dressing, 1 do
		  table.insert(elements, {label = dressing[i], value = i})
		end

		ESX.UI.Menu.Open(
			'native', GetCurrentResourceName(), 'player_dressing',
			{
				title    = "Garde robe",
				align    = 'right',
				elements = elements,
			},
			function(data, menu)

				TriggerEvent('skinchanger:getSkin', function(skin)

				ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerOutfit', function(clothes)

					TriggerEvent('skinchanger:loadClothes', skin, clothes)
					TriggerEvent('god_skin:setLastSkin', skin)

					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('god_skin:save', skin)
					end)
					
					ESX.ShowNotification("Vétements changés.")
					HasLoadCloth = true

				end, data.current.value)

				end)
			end,
		function(data, menu)
			menu.close()
		end)
	end)
end

OpenMenu = function(menuElements, roomId, storageName)
	Trace(storageName)
	ESX.UI.Menu.Open("native", GetCurrentResourceName(), "storage_menu", {
		["title"]    = "Coffre",
		["align"]    = "center",
		["elements"] = menuElements
	}, function(menuData, menuHandle)
		local current = menuData["current"]

		if current["action"] == "store" then
			local inventoryTable = {}
			local inventory = ESX.GetPlayerData().inv

			for i=1, #inventory, 1 do
				if inventory[i]["count"] > 0 then
					table.insert(inventoryTable, {
						["label"] = inventory[i]["label"] .. " - " .. inventory[i]["count"],
						["realLabel"] = inventory[i]["label"],
						["amount"] = inventory[i]["count"],
						["item"] = inventory[i]["name"],
						["action"] = "insert"
					})
				end
			end
			menuHandle.close()
			Wait(250)
			OpenMenu(inventoryTable, roomId, storageName)
		elseif current["action"] == "take" then
			menuHandle.close()
			local input = OpenInput("Combien voulez vous en stocker, vous en avez " .. current["amount"], "input")
			local amount = tonumber(input)

			if amount and amount > 0 then
				ESX.TriggerServerCallback("pluto_motels:updateStorage", function(stored, errorMessage)
					if stored then
						ESX.ShowNotification("Vous avez pris " .. amount .. " ".. current["realLabel"])
					else
						ESX.ShowNotification(errorMessage)
					end
				end, roomId, {
					["storageName"] = storageName,
					["take"] = true,
					["itemData"] = {
						["itemName"] = current["item"],
						["itemLabel"] = current["realLabel"],
						["itemAmount"] = amount
					}
				})
			else
				ESX.ShowNotification("Entrez un nombre correct.")
			end
		elseif current["action"] == "insert" then
			menuHandle.close()
			local input = OpenInput("Combien voulez vous en déposer, vous en avez " .. current["amount"], "input")
			local amount = tonumber(input)

			print(current["item"])

			if current["item"] == 'ankletracker' then
				ESX.ShowNotification("Vous ne pouvez pas enlever un bracelet GPS")
			else

				if amount and amount > 0 then

					ESX.TriggerServerCallback("pluto_motels:updateStorage", function(stored, errorMessage)
						if stored then
							ESX.ShowNotification("Vous avez rangé " .. amount .. " ".. current["realLabel"])
						else
							ESX.ShowNotification(errorMessage)
						end
					end, roomId, {
						["storageName"] = storageName,
						["store"] = true,
						["itemData"] = {
							["itemName"] = current["item"],
							["itemLabel"] = current["realLabel"],
							["itemAmount"] = amount
						}
					})
				else
					ESX.ShowNotification("Entrez un nombre correct.")
				end

			end
		elseif current["action"] == "storeCurrency" then
			menuHandle.close()
			local input = OpenInput("Combien " .. (current["currency"] == "cash" and "de cash voulez vous ranger?" or "de black money voulez vous ranger?"), "input")
			local amount = tonumber(input)

			if amount and amount > 0 then

				ESX.TriggerServerCallback("pluto_motels:updateStorage", function(stored, errorMessage)
					if stored then
						ESX.ShowNotification("Vous avez rangé " .. amount .. " ".. (current["currency"] == "cash" and "cash" or "black money"))
					else
						ESX.ShowNotification(errorMessage)
					end
				end, roomId, {
					["storageName"] = storageName,
					[current["action"]] = true,
					["currency"] = current["currency"],
					["amount"] = amount
				})
				
			else
				ESX.ShowNotification("Entrez un montant correct.")
			end
		elseif current["action"] == "takeCurrency" then
			menuHandle.close()
			local input = OpenInput("Combien " .. (current["currency"] == "cash" and "de cash voulez vous prendre?" or "de black money voulez vous prendre?"), "input")
			local amount = tonumber(input)

			if amount and amount > 0 then

				ESX.TriggerServerCallback("pluto_motels:updateStorage", function(stored, errorMessage)
					if stored then
						ESX.ShowNotification("Vous avez pris " .. amount .. " ".. (current["currency"] == "cash" and "cash" or "black money"))
					else
						ESX.ShowNotification(errorMessage)
					end
				end, roomId, {
					["storageName"] = storageName,
					[current["action"]] = true,
					["currency"] = current["currency"],
					["amount"] = amount
				})
				
			else
				ESX.ShowNotification("Entrez un montant correct.")
			end
		end
	end, function(menuData, menuHandle)

		menuHandle.close()
	end)
end

CreateBlips = function(motelData)
	if not cachedData["blips"][motelData["motelName"]] then
		cachedData["blips"][motelData["motelName"]] = AddBlipForCoord(motelData["motelPosition"])
		SetBlipDisplay(cachedData["blips"][motelData["motelName"]], 4)
		SetBlipScale(cachedData["blips"][motelData["motelName"]], 0.6)
		SetBlipSprite(cachedData["blips"][motelData["motelName"]], 350)
		BeginTextCommandSetBlipName("STRING")
		SetBlipColour(cachedData["blips"][motelData["motelName"]], 47)
		SetBlipAsShortRange(cachedData["blips"][motelData["motelName"]], true)
		AddTextComponentString(motelData["motelName"])
		EndTextCommandSetBlipName(cachedData["blips"][motelData["motelName"]])
	end
end

HelpNotification = function(msg)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

DrawButtons = function(buttonsToDraw)
	local instructionScaleform = RequestScaleformMovie("instructional_buttons")

	while not HasScaleformMovieLoaded(instructionScaleform) do
		Wait(0)
	end

	PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
	PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
	PushScaleformMovieFunctionParameterBool(0)
	PopScaleformMovieFunctionVoid()

	for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
		PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(buttonIndex - 1)

		PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
		PushScaleformMovieFunctionParameterString(buttonValues["label"])
		PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PushScaleformMovieFunctionParameterInt(-1)
	PopScaleformMovieFunctionVoid()
	DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

ConvertTime = function(h)
	local minutes = h * 60
	local hours = 0

	while minutes > 60 do
		minutes = minutes - 60
		hours = hours + 1
	end

	return hours, minutes
end

MissedPayments = function(h, data)
	local payments = 0
	local hours = h

	while hours >= data do
		hours = hours - data
		payments = payments + 1
	end

	return payments > 0 and payments or false
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        if settings == nil then
            TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
        else 
            local speed = 1.0
            local speedMultiplier = -1.0
            local duration = 1.0
            local flag = 0
            local playbackRate = 0

            if settings["speed"] then
                speed = settings["speed"]
            end

            if settings["speedMultiplier"] then
                speedMultiplier = settings["speedMultiplier"]
            end

            if settings["duration"] then
                duration = settings["duration"]
            end

            if settings["flag"] then
                flag = settings["flag"]
            end

            if settings["playbackRate"] then
                playbackRate = settings["playbackRate"]
            end

            TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)

            while not IsEntityPlayingAnim(ped, dict, anim, 3) do
                Citizen.Wait(0)
            end
        end
    
        RemoveAnimDict(dict)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

LoadModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

CleanupModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)  
		end
	end
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["size"] or vector3(1.0, 1.0, 1.0), markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, markerData["bob"] and true or false, true, 2, false, false, false, false)
end

DrawScriptText = function(coords, text)
	local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 370
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

OpenInput = function(label, type)
	AddTextEntry(type, label)

	DisplayOnscreenKeyboard(1, type, "", "", "", "", "", 30)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Wait(0)
	end

	if GetOnscreenKeyboardResult() then
	  	return GetOnscreenKeyboardResult()
	end
end

function round(x, decimals)
	-- This should be less naive about multiplication and division if you are 
	-- care about accuracy around edges like: numbers close to the higher
	-- values of a float or if you are rounding to large numbers of decimals.
    local n = 10^(decimals or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end