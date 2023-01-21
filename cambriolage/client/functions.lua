GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent("burglary:globalEvent", options)
end

FetchHouseData = function()
    ESX.TriggerServerCallback("burglary:fetchData", function(data)
        cachedData["houseData"] = data
    end)
end

BeginLockpick = function(id, data)
    RequestAnimDict('missheistfbisetup1')
    while not HasAnimDictLoaded('missheistfbisetup1') do
        Wait(0)
    end
    local timer = 0
    TaskPlayAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 8.0, -8, -1, 11, 0, 0, 0, 0)
    Wait(50)
    while true do
        if IsEntityPlayingAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 3) then
            timer = timer+10
            if math.floor((timer / 1000) / Config.LockPickTime * 100) >= 100 then
                ClearPedTasksImmediately(PlayerPedId())
                GlobalFunction("lockpick_house", {
                    ["houseId"] = id,
                    ["saveData"] = true
                })
                break
            end
        else
            ESX.ShowNotification('Crochetage annulé...')
            break
        end
        drawTxt(0.97, 0.6, 1.0, 1.0, 0.5, "Crochetage... ~b~" .. math.floor((timer / 1000) / Config.LockPickTime * 100) .. "~s~%", 255, 255, 255, 255)
        Wait(0)
    end
end

LockHouse = function(id, data, croched)
    while not HasAnimDictLoaded('missheistfbisetup1') do
        RequestAnimDict('missheistfbisetup1')
        Wait(0)
    end
    local timer = 0
    TaskPlayAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 8.0, -8, -1, 11, 0, 0, 0, 0)
    Wait(50)
    while true do
        if IsEntityPlayingAnim(PlayerPedId(), 'missheistfbisetup1', 'hassle_intro_loop_f', 3) then
            timer = timer+10
            if math.floor((timer / 1000) / Config.LockTime * 100) >= 100 then
                ClearPedTasksImmediately(PlayerPedId())
                GlobalFunction("lock_house", {
                    ["houseId"] = id,
                    ["saveData"] = true
                })
                break
            end
        else
            ESX.ShowNotification('Tu as arrêtés de crocheter la porte...')
            break
        end
        drawTxt(0.97, 0.6, 1.0, 1.0, 0.5, "".. croched .."... ~b~" .. math.floor((timer / 1000) / Config.LockTime * 100) .. "~s~%", 255, 255, 255, 255)
        Wait(0)
    end
end

EnterHouse = function(id, data)
    local type = Config.Interiors[data["HouseType"]]
    
    DoScreenFadeOut(1200)
    while IsScreenFadingOut() do
        Wait(0)
    end
    JoinInstance(id, data)
    SetEntityCoords(PlayerPedId(), type["Exit"])
    DoScreenFadeIn(1200)
    cachedData["InsideHouse"] = true
    
    Citizen.CreateThread(function()
        
        while cachedData["InsideHouse"] do

            local sleep = 500
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dstcheck = GetDistanceBetweenCoords(pedCoords, type["Exit"], true)
            local text = "Exit"

            if dstcheck <= 5.5 then
                sleep = 5
                if dstcheck <= 1.3 then
                    text = "[~b~E~s~] Exit"
                    if IsControlJustReleased(0, 38) then
                        ExitHouse(id, data)
                    end
                end
                ESX.Game.Utils.DrawText3D(type["Exit"], text, 0.6)
                DrawMarker(6, type["Exit"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
            end
            
            
            for LootablesId, LootablesData in pairs(type["Lootables"]) do
                
                local dstcheck = GetDistanceBetweenCoords(pedCoords, LootablesData["Pos"], true)
                local text = LootablesId

                if dstcheck <= 2.5 then
                    sleep = 5
                    if dstcheck <= 1.3 then
                        text = "[~b~E~s~] Fouille " .. LootablesId
                        if IsControlJustReleased(0, 38) then
                            if not cachedData["houseData"][id]["Lootables"][LootablesId] then
                                LootPlace(data, id, LootablesId, LootablesData)
                            else
                                ESX.ShowNotification("Déjà fouillé...")
                            end
                        end
                    end
                    ESX.Game.Utils.DrawText3D(LootablesData["Pos"], text, 0.6)
                    DrawMarker(6, LootablesData["Pos"]-vector3(0.0,0.0,0.975), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 55, 100, 200, 155, 0, false, false, 0, false, false, false, false)
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

CreateBlip = function(eventData)
    cachedData[eventData["houseId"]] = AddBlipForCoord(Config.Coords[eventData["houseId"]]["Pos"])
    SetBlipSprite(cachedData[eventData["houseId"]], 418)
    SetBlipScale(cachedData[eventData["houseId"]], 1.0)
	SetBlipColour(cachedData[eventData["houseId"]], 1)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Coords[eventData["houseId"]]["Info"])
    EndTextCommandSetBlipName(cachedData[eventData["houseId"]])
    PulseBlip(cachedData[eventData["houseId"]])
end

LootPlace = function(data, id, LootablesId, LootablesData)
    TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_BUM_BIN", LootablesData["Pos"], LootablesData["Heading"], 0, false, false)

    cachedData["startedSearching"] = GetGameTimer()

    while GetGameTimer() - cachedData["startedSearching"] < Config.SearchTime do
        Citizen.Wait(5)

        if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
            ESX.ShowNotification("Tu as arrêté de chercher.")
    
            return
        end

        drawTxt(0.97, 0.6, 1.0, 1.0, 0.5, "Fouille... " ..LootablesId, 255, 255, 255, 255)
    end

    GlobalFunction("loot_place", {
        ["saveData"] = true,
        ["houseId"] = id,
        ["lootSpot"] = LootablesId
    })

    ESX.TriggerServerCallback("burglary:lootItem", function(loot)
        if loot then
            ESX.ShowNotification("Tu as trouvé un(e) " ..loot)
        end
    end)

    ClearPedTasks(PlayerPedId())
end

CreateCameras = function(houseData)
    local configData = Config.Interiors[houseData["HouseType"]]["Cameras"]
    
    for id, data in ipairs(configData) do

        cachedData["Cameras"][id] = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", data["Pos"], data["Rotation"], 80.0)

    end
end

ExitHouse = function(id, data)
    DoScreenFadeOut(1200)
    while IsScreenFadingOut() do
        Wait(0)
    end
    SetEntityCoords(PlayerPedId(), Config.Coords[id]["Pos"])
    SetEntityHeading(PlayerPedId(), Config.Coords[id]["Heading"])
    DoScreenFadeIn(1200)
    cachedData["InsideHouse"] = false
    ExitInstance()
end

drawTxt = function(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

HasLockPick = function()
    ESX.TriggerServerCallback("aCambriolage:veriflockpick", function(data)
        hold = data
        if hold then
            return true
        else
            ESX.ShowNotification("~r~Problème~s~ : Vous n'avez pas l'item nécessaire !")
            return false
        end
    end )
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

DrawButtons = function(buttonsToDraw)
	Citizen.CreateThread(function()
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
	end)
end