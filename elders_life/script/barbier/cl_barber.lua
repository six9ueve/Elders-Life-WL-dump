ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

    local compBarber = {}
    local i = {}

    RMenu.Add("coiffeur_main", "main_menu", RageUI.CreateMenu("Coiffeur", "INTÉRACTIONS",nil,nil, "aLib", "black"))
    RMenu:Get("coiffeur_main", "main_menu").Closed = function()
    FinCreator()
    RenderScriptCams(0, 1, 1000, 1, 1)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DestroyAllCams(true)  
    TriggerEvent("skinchanger:loadSkin", LastSkin)
    BarberMenu = false
end

local hasAlreadyEnteredMarker, lastZone, currentAction, currentActionMsg, hasPaid

ConfigBarber = {
    vector3(-814.3, -183.8, 36.6),
    vector3(136.8, -1708.4, 28.3),
    vector3(-1282.6, -1116.8, 6.0),
    vector3(1931.5, 3729.7, 31.8),
    vector3(1212.8, -472.9, 65.2),
    vector3(-32.9, -152.3, 56.1),
    vector3(-278.1, 6228.5, 30.7)
}

AddEventHandler('god_barbershop:hasEnteredMarker', function(zone)
    currentAction = 'shop_menu'
    currentActionMsg = 'appuez sur ~INPUT_CONTEXT~ pour accéder au menu'
end)

AddEventHandler('god_barbershop:hasExitedMarker', function(zone)
    currentAction = nil
    RageUI.CloseAll()

    if not hasPaid then
        ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end
end)

-- Create Blips
Citizen.CreateThread(function()
    for k,v in ipairs(ConfigBarber) do
        local blip = AddBlipForCoord(v)

        SetBlipSprite (blip, 71)
        SetBlipScale (blip, 0.6)
        SetBlipColour (blip, 51)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('[ETAT] | Barbier')
        EndTextCommandSetBlipName(blip)
    end
end)

-- Enter / Exit marker events and draw marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(PlayerPedId()), nil, nil, true

        for k,v in ipairs(ConfigBarber) do
            local distance = #(playerCoords - v)

            if distance < 25 then
                letSleep = false
                DrawMarker(1, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 102, 102, 204, 100, false, true, 2, false, nil, nil, false)

                if distance < 1.5 then
                    isInMarker, currentZone = true, k
                end
            end
        end

        if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
            hasAlreadyEnteredMarker, lastZone = true, currentZone
            TriggerEvent('god_barbershop:hasEnteredMarker', currentZone)
        end

        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('god_barbershop:hasExitedMarker', lastZone)
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

-- Key controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if currentAction then
            ESX.ShowHelpNotification(currentActionMsg)

            if IsControlJustReleased(0, 38) then
                if currentAction == 'shop_menu' then
                    OpenBarberMenu()
                end

                currentAction = nil
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function SaveSkinInBarber()
    ESX.TriggerServerCallback('god_barbershop:CheckClothesMoney', function(good)
        if good then
            TriggerEvent("skinchanger:getSkin", function(skin)
                TriggerServerEvent("god_skin:save", skin)
                LastSkin = skin
            end)
            ESX.ShowNotification("~g~COIFFEUR~s~\n- Vous avez payé ~g~50$")
            hasPaid = true
            RenderScriptCams(0, 1, 1000, 1, 1)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            DestroyAllCams(true)  
            TriggerEvent('trew_hud_ui:hud')
            BarberMenu = false
            RageUI.CloseAll()
            Wait(200)
            FinCreator()
        else
            TriggerEvent("skinchanger:loadSkin", LastSkin)
            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent sur vous !")
        end
    end, 50) 
end

function ClothesSkinRota()
    RUIText({message = "Vous pouvez appuyer sur ~b~ESPACE~s~ pour tourner votre personnage."})
    if IsControlJustPressed(0, 22) then
        SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1))+45)
    end
end

function refreshBarberIndex()
    compBarber = {}
    restrictBarber = {
		'beard_1',
		'beard_2',
		'beard_3',
		'beard_4',
		'hair_1',
		'hair_2',
		'hair_color_1',
		'hair_color_2',
		'eyebrows_1',
		'eyebrows_2',
		'eyebrows_3',
		'eyebrows_4',
		'makeup_1',
		'makeup_2',
		'makeup_3',
		'makeup_4',
		'lipstick_1',
		'lipstick_2',
		'lipstick_3',
		'lipstick_4',
    }
    TriggerEvent("skinchanger:getData", function(comp_, max)
        compBarber = {}
        for i=1, #comp_, 1 do
            local found = false
            for j=1, #restrictBarber, 1 do
                if comp_[i].name == restrictBarber[j] then
                    found = true
                end
            end
            if found then
                table.insert(compBarber, comp_[i])
            end
        end
        for k,v in pairs(compBarber) do
            if v.value ~= 0 then
                i[v.name] = v.value+1
            else
                i[v.name] = 1
            end
            for i,value in pairs(max) do
                if i == v.name then
                    compBarber[k].max = value
                    compBarber[k].table = {}
                    for i = 0, value do
                        table.insert(compBarber[k].table, i)
                    end
                    break
                end
            end
        end
    end)
end

function OpenBarberMenu()
    hasPaid = false
    TriggerEvent('skinchanger:getSkin', function(skin)
        LastSkin = skin
    end)
    compBarber = {}
    restrictBarber = {
		'beard_1',
		'beard_2',
		'beard_3',
		'beard_4',
		'hair_1',
		'hair_2',
		'hair_color_1',
		'hair_color_2',
		'eyebrows_1',
		'eyebrows_2',
		'eyebrows_3',
		'eyebrows_4',
		'makeup_1',
		'makeup_2',
		'makeup_3',
		'makeup_4',
		'lipstick_1',
		'lipstick_2',
		'lipstick_3',
		'lipstick_4',
    }
    TriggerEvent("skinchanger:getData", function(comp_, max)
        compBarber = {}
        for i=1, #comp_, 1 do
            local found = false
            for j=1, #restrictBarber, 1 do
                if comp_[i].name == restrictBarber[j] then
                    found = true
                end
            end
            if found then
                table.insert(compBarber, comp_[i])
            end
        end
        for k,v in pairs(compBarber) do
            if v.value ~= 0 then
                i[v.name] = v.value+1
            else
                i[v.name] = 1
            end
            for i,value in pairs(max) do
                if i == v.name then
                    compBarber[k].max = value
                    compBarber[k].table = {}
                    for i = 0, value do
                        table.insert(compBarber[k].table, i)
                    end
                    break
                end
            end
        end
    end)
    DestroyAllCams(true)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam,  coords.x-2.0, coords.y, coords.z+0.6)
    SetCamFov(cam, 20.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.6)
    RenderScriptCams(1, 1, 2200, 1, 1)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1))/coords.x+100)
    if not BarberMenu then
        BarberMenu = true
        RageUI.Visible(RMenu:Get('coiffeur_main', 'main_menu'), true)
        Citizen.CreateThread(function()
            while BarberMenu do
                Citizen.Wait(1)
                FreezeEntityPosition(GetPlayerPed(-1), true)
                for i=1,256 do
                    if NetworkIsPlayerActive(i) then
                        SetEntityVisible(GetPlayerPed(i), false, false)
                        SetEntityVisible(PlayerPedId(), true, true)
                        SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
                    end
                end
                ClothesSkinRota()
                RageUI.IsVisible(RMenu:Get("coiffeur_main", "main_menu"), true, true, true, function()
                    ClothesSkinRota()
                    for k,v in pairs(compBarber) do
                        if v.table[1] ~= nil then
                            RageUI.List(v.label, v.table, i[v.name], nil, {}, true, function(_,_,s,Index)
                                if s then
                                    SaveSkinInBarber()
                                end
                                end, function(Index)
                                    if Index ~= nil then
                                        refreshBarberIndex()
                                        i[v.name] = Index
                                        TriggerEvent("skinchanger:change", v.name, Index - 1)
                                    end
                                end)
                            end
                        end
                    end)
                end
            end)
        end
    end
end)