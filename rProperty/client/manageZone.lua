local isMenuOpened = false

RMenu.Add("property", "pointsorti", RageUI.CreateMenu("Garage", "~b~Vehicule :", nil, nil, "aLib", "black"))
RMenu:Get("property", "pointsorti").Closed = function()
    isMenuOpened = false
end

RMenu.Add("property", "pointsortichoice", RageUI.CreateSubMenu(RMenu:Get("property", "pointsorti"), "Garage", "~b~Choix :"))
RMenu:Get("property", "pointsortichoice").Closed = function()end

Cfg_Property.LoadActualityProperty = function(identifier)
    Citizen.CreateThread(function()
        while Cfg_Property.ESXLoaded == nil do
            Cfg_Property.InSide(Cfg_Property.ESXEvent, function(esxEvent) Cfg_Property.ESXLoaded = esxEvent end)
            Citizen.Wait(0)
        end
        while true do
            
            local interactWait = 750
            for k,v in pairs(Cfg_Property.ActualityProperty) do

                if v.owner == nil then
                    local visitePropertyDistance = {}
                    visitePropertyDistance["pEnter"] = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, true)
                    if visitePropertyDistance["pEnter"]  < 10.0 then
                        interactWait = 1
                        DrawMarker(20, json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, false, true, true, false, false, false, false, false)
                        if visitePropertyDistance["pEnter"] < 1.5 then
                            Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
                            if IsControlJustPressed(0, 38) then
                                Cfg_Property.openViewMenu(k,v)
                            end
                        end
                    end
                else
                    if v.owner == identifier or Cfg_Property.hasAcess[v.propertyID] then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, true) < 8.0 then
                            interactWait = 1
                            DrawMarker(20, json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, false, true, true, false, false, false, false, false)
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, true) < 1.5 then
                                Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec votre propriété ~b~"..v.label)
                                if IsControlJustPressed(0, 38) then
                                    Cfg_Property.openPropertyMenu(k,v)
                                end
                            end
                        elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.gEnterPos).x, json.decode(v.gEnterPos).y, json.decode(v.gEnterPos).z, true) < 8.0 then
                            interactWait = 1
                            DrawMarker(20, json.decode(v.gEnterPos).x, json.decode(v.gEnterPos).y, json.decode(v.gEnterPos).z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, false, true, true, false, false, false, false, false)
                            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then   
                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.gEnterPos).x, json.decode(v.gEnterPos).y, json.decode(v.gEnterPos).z, true) < 4 then
                                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule dans votre garage")
                                    if IsControlJustPressed(0, 38) then
                                        Cfg_Property.ESXLoaded.TriggerServerCallback('rproperty:getvehicle', function(number)
                                            if (tonumber(v.gPlaces) - number) <= 0 then
                                                Cfg_Property.Popup("Votre garage ne contient pas d'emplacement libre pour stocker ce véhicule !")
                                            else
                                                local props = Cfg_Property.ESXLoaded.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
                                                Cfg_Property.ESXLoaded.TriggerServerCallback('rproperty:storeVehicle', function(stored)
                                                    if stored == 'stored' then
                                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addVehiculeInProperty", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)), Cfg_Property.ESXLoaded.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false)), v.propertyID)
                                                        DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
                                                    elseif stored == 'notowned' then
                                                        Cfg_Property.Popup("~r~Ce véhicule ne vous appartient pas !")
                                                    end
                                                end, props)
                                            end
                                        end, v.propertyID)
                                    end
                                end
                            else
                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.gEnterPos).x, json.decode(v.gEnterPos).y, json.decode(v.gEnterPos).z, true) < 3 then
                                    if not isMenuOpened then
                                        Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec votre garage")
                                    end
                                    if IsControlJustPressed(0, 38) and not isMenuOpened then
                                        if isMenuOpened then return end
                                        isMenuOpened = true

                                        RageUI.Visible(RMenu:Get("property", "pointsorti"), true)

                                        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..':getVehicles', function(vehicles)
                                            tablevehiclesproperty = {}
                                            if not table.empty(vehicles) then
                                                tablevehiclesproperty = vehicles
                                            else
                                                tablevehiclesproperty = nil
                                            end
                                        end, v.propertyID)

                                        Citizen.Wait(250)

                                        Citizen.CreateThread(function()
                                            while isMenuOpened do
                                                RageUI.IsVisible(RMenu:Get("property", "pointsorti"),function()
                                                    if tablevehiclesproperty ~= nil then
                                                        for k, v in pairs(tablevehiclesproperty) do
                                                            local vehicleProps = json.decode(v.vehicle)
                                                            local vehicleHash = vehicleProps.model
                                                            if v.vehiclename then
                                                                vehicleName = v.vehiclename                 
                                                            else
                                                                vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                                                            end
                                                            RageUI.Button(vehicleName, nil, {RightLabel = ""}, true, {
                                                                onSelected = function()
                                                                    CarProps = json.decode(v.vehicle)
                                                                end
                                                            }, RMenu:Get("property", "pointsortichoice"))
                                                        end
                                                    else
                                                        RageUI.Button('Aucun Véhicule', nil, {RightLabel = ""}, true, {
                                                            onSelected = function()
                                                                RageUI.CloseAll()
                                                                isMenuOpened = false
                                                            end
                                                        })
                                                    end
                                                end, function()end, 1)
                                                RageUI.IsVisible(RMenu:Get("property", "pointsortichoice"),function()
                                                    RageUI.Button('Sortir le Véhicule', nil, {RightLabel = ""}, true, {
                                                        onSelected = function()
                                                            garage = GetEntityCoords(PlayerPedId())
                                                            SpawnVehicle(CarProps, garage, v.gEnterHeading)
                                                            RageUI.CloseAll()
                                                            isMenuOpened = false
                                                        end
                                                    })
                                                end, function()end, 1)
                                                Wait(0)
                                            end
                                        end)
                                    end
                                    --Cfg_Property.ESXLoaded.TriggerServerCallback('rproperty:playeringarage', function(someoneingarage)
                                    --    occuper = someoneingarage                                        
                                    --end, v.propertyID)
                                    --[[if IsControlJustPressed(0, 38) and not occuper then
                                        Citizen.Wait(100)
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":playeringarageaddrem", v.propertyID, true)
                                        Citizen.Wait(100)
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":SetPlayerInBucket", (100+tonumber(v.propertyID)))
                                        local crtVehicule = {}
                                        Cfg_Property.inGarage = true
                                        Cfg_Property.lastPostion = GetEntityCoords(PlayerPedId())
                                        DoScreenFadeOut(750)
                                        while not IsScreenFadedOut() do Wait(0) end
                                        SetEntityCoords(PlayerPedId(), Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].tpPos)
                                        for vehiculeID,vehicule in pairs(json.decode(v.pVehicules)) do
                                            RequestModel(vehicule.props.model)
                                            while not HasModelLoaded(vehicule.props.model) do
                                                Wait(1)
                                            end
                                            local vehicle = CreateVehicle(vehicule.props.model, Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].vehiculeSpawner[vehiculeID].pos, Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].vehiculeSpawner[vehiculeID].heading, false, false)
                                            Cfg_Property.ESXLoaded.Game.SetVehicleProperties(vehicle, vehicule.props)
                                            SetVehicleUndriveable(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 0)
                                            crtVehicule[vehiculeID] = vehicle
                                        end
                                        DoScreenFadeIn(1500)
                                        while Cfg_Property.inGarage do
                                            Citizen.Wait(0)                 
                                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].tpExit, true) < 10.0 then
                                                DrawMarker(20, Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].tpExit, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 0, 255 ,0, 255, false, true, true, false, false, false, false, false)
                                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Cfg_Property.garageInteriorsInfos[tonumber(v.gPlaces)].tpExit, true) < 3 then
                                                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour sortir de votre garage")
                                                    if IsControlJustPressed(0, 38) then
                                                        Citizen.Wait(100)
                                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":playeringarageaddrem", v.propertyID, false)
                                                        Citizen.Wait(100)
                                                        DoScreenFadeOut(750)
                                                        while not IsScreenFadedOut() do Wait(0) end
                                                        DoScreenFadeIn(800)
                                                        SetEntityCoords(PlayerPedId(), Cfg_Property.lastPostion, false, false, false, false)
                                                        Cfg_Property.inGarage = false
                                                    end
                                                end
                                            end
                                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                                Cfg_Property.HelpNotif("Appuyez sur ~INPUT_FRONTEND_RDOWN~ pour sortir le véhicule du garage")
                                                if IsControlJustPressed(0, 191) then
                                                    Citizen.Wait(100)
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":playeringarageaddrem", v.propertyID, false)
                                                    Citizen.Wait(100)
                                                    local props = Cfg_Property.ESXLoaded.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
                                                    for vehiculeID,vehicule in pairs(json.decode(v.pVehicules)) do
                                                        if props.plate == vehicule.props.plate then
                                                            Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":outVehiculeFromProperty", function (testhave)
                                                                Cfg_Property.inGarage = false
                                                                Citizen.CreateThread(function()
                                                                    DoScreenFadeOut(750)
                                                                    while not IsScreenFadedOut() do Wait(0) end
                                                                    DoScreenFadeIn(800)
                                                                    RequestModel(props.model)
                                                                    while not HasModelLoaded(props.model) do Wait(1) end
                                                                    SetEntityCoords(PlayerPedId(), Cfg_Property.lastPostion, false, false, false, false)
                                                                    coords = GetEntityCoords(PlayerPedId())
                                                                    if testhave then
                                                                        ESX.Game.SpawnVehicle(props.model, {
                                                                        x = coords.x,
                                                                        y = coords.y,
                                                                        z = coords.z + 0.5                                           
                                                                        },(v.gEnterHeading + 0.01), function(callback_vehicle)
                                                                            Cfg_Property.ESXLoaded.Game.SetVehicleProperties(callback_vehicle, props)
                                                                            SetVehicleDoorsLocked(callback_vehicle, 0)
                                                                            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
                                                                            Citizen.Wait(50)
                                                                            TaskLeaveVehicle(PlayerPedId(), callback_vehicle, 16)
                                                                        end)
                                                                    end
                                                                end)
                                                            end, v.propertyID, vehiculeID, props)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        Citizen.SetTimeout(1200, function()
                                            for k,v in pairs(crtVehicule) do
                                                if DoesEntityExist(v) then
                                                    DeleteEntity(v)
                                                end
                                            end
                                        end)
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":SetPlayerInBucket", 0)
                                    end]]--
                                end
                            end
                        end
                    else
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, true) < 10.0 then
                            interactWait = 1
                            DrawMarker(20, json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, false, true, true, false, false, false, false, false)
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), json.decode(v.pEnterPos).x, json.decode(v.pEnterPos).y, json.decode(v.pEnterPos).z, true) < 1.5 then
                                Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
                                if IsControlJustPressed(0, 38) then
                                    Cfg_Property.openPropertySonneMenu(k,v)
                                end
                            end
                        end
                    end
                end
            end
            Citizen.Wait(interactWait)
        end
    end)
end

function SpawnVehicle(vehicleProps, garage, heading)
    ESX.Game.SpawnVehicle(vehicleProps.model, {
        x = garage.x,
        y = garage.y,
        z = garage.z + 0.5                                           
        },heading, function(callback_vehicle)
            ESX.Game.SetVehicleProperties(callback_vehicle, vehicleProps)
            SetVehicleFixed(callback_vehicle)
            SetVehicleProperties(callback_vehicle, vehicleProps)
            SetVehicleDeformationFixed(callback_vehicle)
            SetVehicleEngineHealth(callback_vehicle, vehicleProps.engineHealth)
            SetVehicleDoorsLocked(callback_vehicle, 0)
            SetVehicleFuelLevel(callback_vehicle,vehicleProps.fuelLevel)
            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
            Cfg_Property.ServerSide(Cfg_Property.Prefix..":setvehout", vehicleProps)
        end)
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
    if vehicleProps.vehicleHeadLight then SetVehicleHeadlightsColour(vehicle, vehicleProps.vehicleHeadLight) end
    
end