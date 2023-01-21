ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj)
        ESX = obj
        end)
    end
end)

-- Horn
local horn_count = 500

-- Open Nui and enter information
RegisterNetEvent("Mx :: OpenCustomCar")
AddEventHandler("Mx :: OpenCustomCar", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local veh, pos_veh = GetClosestVehicle(coords)
    local vehin = GetVehiclePedIsIn(ped, false)

    if DoesEntityExist(veh) then
        open = true
        vehicle_id = veh
        vehicle_dist = pos_veh
        if vehicle_dist < ped_dist_to_vehicle then
            SetVehicleModKit(vehicle_id, 0)
            SetVehicleLights(vehicle_id, 3)

            if CustomFree then
                for i,k in pairs(Modifications) do
                    k.price = 'Free'
                end
            end

            -- The function below will disable the customizations that the car does not have, that is, it will only show the customizations you can change in the vehicle
            GetModsExist()

            current_custom = ESX.Game.GetVehicleProperties(vehicle_id) 

            -- Open nui and change focus (Enable mouse)
            SetNuiFocus(true,true)
            SendNUIMessage({
                ui = 'Interface',
                NuiOpen = true,
                NameResource = GetCurrentResourceName(),

                pos_x = pos_x,
                pos_y = pos_y,
                scale = scale,
                opacity = opacity,

                Modifications = Modifications,
                custom_price = custom_price,

                texts = texts,
                vehicle_plate = current_custom.plate,
                vehicle_model = GetDisplayNameFromVehicleModel(current_custom.model),
                info_car = {GetVehicleEngineHealth(vehicle_id), GetVehicleBodyHealth(vehicle_id), GetVehicleFuelLevel(vehicle_id), GetVehicleDirtLevel(vehicle_id)},

                EngineTypes = EngineTypes,
                BreakTypes = BreakTypes,
                TransmissionTypes = TransmissionTypes,
                SuspensionsType = SuspensionsType,
                ArmourTypes = ArmourTypes,
                PlateTypes = PlateTypes,
                BoostTypes = BoostTypes,
                WindowsType = WindowsType,
            })
            
            if vehin > 0 then
                Nui_Cams(true, true)
            end
        end
    end
end)

-- Close the nui
RegisterNetEvent("Mx :: CloseCustomCar")
AddEventHandler("Mx :: CloseCustomCar", function()
    SetNuiFocus(false,false)
    SendNUIMessage({
        ui = 'Interface',
        NuiOpen = false,
    })

    if vehicle_id ~= 1 and current_custom ~= nil and DoesEntityExist(vehicle_id) then
        SetProperVehicle(vehicle_id, current_custom)
        
    end

    ActiveCam = false
    open = false

    vehicle_id = -1
    current_custom = {}
    new_custom = {}
    custom_price = 0

    Nui_Cams(false, true)
end)

RegisterNUICallback('CloseNui', function(data, cb)  
    TriggerEvent("Mx :: CloseCustomCar")
    cb('ok')
end)

-- Set the mods on the vehicle
RegisterNUICallback('SetVehicleMod', function(data, cb)
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            local mod_index = data.mx.mod_index
            local num_mod = tonumber(data.mx.num)
            local custom_tires = data.mx.customtires

            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle_id)
            if mod_index == 'pearlescent_color' then
                SetVehicleExtraColours(vehicle_id, num_mod, wheelColor) 
            elseif mod_index == 'wheel_color' then
                SetVehicleExtraColours(vehicle_id, pearlescentColor, num_mod) 
            elseif mod_index == 'dashboard_color' then -- ADDED
                SetVehicleDashboardColor(vehicle_id, num_mod)
            elseif mod_index == 'interior_color' then -- ADDED
                SetVehicleInteriorColor(vehicle_id, num_mod)
            elseif mod_index == 'plateIndex' then -- ADDED
                SetVehicleNumberPlateTextIndex(vehicle_id, num_mod)
            elseif mod_index == 'windows_tint' then
                SetVehicleWindowTint(vehicle_id, num_mod)
            elseif mod_index == 'xenon_colors' then
                SetVehicleXenonLightsColour(vehicle_id, num_mod)
            elseif mod_index == 'extras' then
                if data.mx.num[2] then
                    SetVehicleExtra(vehicle_id, tonumber(data.mx.num[1]), 0)
                else
                    SetVehicleExtra(vehicle_id, tonumber(data.mx.num[1]), 1)
                end
            else
                local class = GetVehicleClass(vehicle_id)  
                if class == 8 and tonumber(mod_index) == 23 or tonumber(mod_index) == 24 then -- MOTO
                    SetVehicleWheelType(vehicle_id, 6)
                    SetVehicleMod(vehicle_id, 23, num_mod, custom_tires) 
                    SetVehicleMod(vehicle_id, 24, num_mod, custom_tires) 
                else
                    if tonumber(mod_index) == 48 then -- LIVERY's
                        SetVehicleMod(vehicle_id, 48, num_mod, false)
                        SetVehicleLivery(vehicle_id, num_mod)
                    elseif tonumber(mod_index) == 14 then -- Horns
                        SetVehicleMod(vehicle_id, tonumber(mod_index), num_mod, custom_tires) 
                        SetVehicleLights(vehicle_id, 3)

                        horn_count = 0
                        if IsHornActive(vehicle_id) then
                            StartVehicleHorn(vehicle_id,0,-1,false)
                        end
                        
                        horn_count = 500
                        while horn_count > 1 do
                            SetControlNormal(0,86,1.0)
                            Wait(1)
                            horn_count = horn_count - 1
                        end
                        StartVehicleHorn(vehicle_id, 4000, "HELDDOWN", true)
                    else
                        SetVehicleMod(vehicle_id, tonumber(mod_index), num_mod, custom_tires) 
                    end
                end
            end
        end
    end
    cb('ok')
end)

-- Arrow wheel model in the vehicle
RegisterNUICallback('SetVehicleWheelType', function(data, cb)
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            local min = 0
            local max = 0

            local class = GetVehicleClass(vehicle_id)  
            if class == 8 then -- MOTO
                SetVehicleWheelType(vehicle_id, 6)
                max = GetNumVehicleMods(vehicle_id, 24)
            else
                SetVehicleWheelType(vehicle_id, tonumber(data.mx.type_wheel))
                max = GetNumVehicleMods(vehicle_id, 23)
            end
            GetMinMaxMods(min, max) 
        end
    end
    cb('ok')
end)

-- Get the vehicle color in RGB
RegisterNUICallback('ColorPicker', function(data, cb) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            local colorPrimary, colorSecondary = GetVehicleColours(vehicle_id)
            if data.mx.type_color == "(P)" then
                SetVehicleColours(vehicle_id, tonumber(data.mx.id_color), colorSecondary)
                SetVehicleCustomPrimaryColour(vehicle_id, tonumber(data.mx.r), tonumber(data.mx.g), tonumber(data.mx.b))
            elseif data.mx.type_color == "(S)" then
                SetVehicleColours(vehicle_id, colorPrimary, tonumber(data.mx.id_color))
                SetVehicleCustomSecondaryColour(vehicle_id, tonumber(data.mx.r), tonumber(data.mx.g), tonumber(data.mx.b))
            end
        end
    end
    cb('ok')
end)

-- Enable or disable turbo
RegisterNUICallback('Mod_TurboEnable', function(data, cb) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            ToggleVehicleMod(vehicle_id, 18, data.mx.modon)
        end
    end
    cb('ok')
end)

-- Repair or clean the vehicle
RegisterNUICallback('Mod_Repair', function(data, cb) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            if data.mx.mod == 'repair' then
                --TriggerServerEvent("Mx :: SaveCustomRepair", 150)
                SetVehicleFixed(vehicle_id)
            elseif data.mx.mod == 'clean' then
                SetVehicleDirtLevel(vehicle_id, 0.0)
                --TriggerServerEvent("Mx :: SaveCustomClean", 150)
            end
        end
    end
    cb('ok')
end)

RegisterNetEvent("Mx :: repair")
AddEventHandler("Mx :: repair", function()
    local ped = PlayerPedId()
    local vehin = GetVehiclePedIsIn(ped, false)

    if DoesEntityExist(vehin) then
        SetVehicleFixed(vehin)
        TriggerEvent('Mx :: CustomCarNotification', 'Vous avez payé et réparé le véhicule')
    end
end)

RegisterNetEvent("Mx :: clean")
AddEventHandler("Mx :: clean", function()
    local ped = PlayerPedId()
    local vehin = GetVehiclePedIsIn(ped, false)

    if DoesEntityExist(vehin) then
        SetVehicleDirtLevel(vehin, 0.0)
        TriggerEvent('Mx :: CustomCarNotification', 'Vous avez payé et néttoyé le véhicule')
    end
end)

-- Check current mod and display in nui
RegisterNUICallback('IsToggleModOn', function(data, cb) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            local ModON = IsToggleModOn(vehicle_id, tonumber(data.mx.ModON))
            SendNUIMessage({
                ui = 'IsToggleModOn',
                ModON = ModON,
            })
        end
    end
    cb('ok')
end)

-- Get the neon color in RGB
RegisterNUICallback('NeonColorPicker', function(data, cb)
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            if(data.mx.neonEnabled) then
                SetVehicleNeonLightEnabled(vehicle_id, 0, data.mx.neonEnabled[1])
                SetVehicleNeonLightEnabled(vehicle_id, 1, data.mx.neonEnabled[2])
                SetVehicleNeonLightEnabled(vehicle_id, 2, data.mx.neonEnabled[3])
                SetVehicleNeonLightEnabled(vehicle_id, 3, data.mx.neonEnabled[4])
                SetVehicleNeonLightsColour(vehicle_id, tonumber(data.mx.r), tonumber(data.mx.g), tonumber(data.mx.b))
            end
        end
    end
    cb('ok')
end)

-- Get the smoke color of the vehicle in RGB
RegisterNUICallback('Mod_ColorPicker', function(data, cb)
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            ToggleVehicleMod(vehicle_id, 20, data.mx.modon) 
            SetVehicleTyreSmokeColor(vehicle_id, tonumber(data.mx.r), tonumber(data.mx.g), tonumber(data.mx.b)) 
        end
    end
    cb('ok')
end)

-- Enable or disable xenon
RegisterNUICallback('Mod_XenonEnable', function(data, cb)
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            ToggleVehicleMod(vehicle_id, 22, data.mx.modon)
            SetVehicleLights(vehicle_id, 3)
        end
    end
    cb('ok')
end)


--## Gets

-- Calculates the price of all parts installed in the vehicle
RegisterNUICallback('CalculateTotalPrice', function(data, cb) 
    CalculateCost()

    custom_price = ESX.Math.Round(custom_price)

    if DoesEntityExist(vehicle_id) then
        SetVehicleDoorShut(vehicle_id,4)

        if data.mx.mod_index == 14 then -- horns
            if IsHornActive(vehicle_id) then
                horn_count = 0
                StartVehicleHorn(vehicle_id,0,-1,false)
            end
        end

        SendNUIMessage({
            ui = 'CalculateTotalPrice',
            custom_price = custom_price,
            info_car = {GetVehicleEngineHealth(vehicle_id), GetVehicleBodyHealth(vehicle_id), GetVehicleFuelLevel(vehicle_id), GetVehicleDirtLevel(vehicle_id)},
        })
    end
    cb('ok')
end)

-- Takes and displays the extras that the vehicle has
RegisterNUICallback('GetExtrasVeh', function(data, cb)  
    local extras = {}
    for extraId=0, 12 do
        if DoesExtraExist(vehicle_id, extraId) then
            local state = IsVehicleExtraTurnedOn(vehicle_id, extraId) == 1
            extras[tostring(extraId)] = state
        end
    end

    SendNUIMessage({
        ui = 'GetExtrasVeh',
        extras = extras,
    })
    cb('ok')
end)

-- Get the minimum and maximum mods a vehicle has
RegisterNUICallback('GetMinMaxMods', function(data, cb) 
    if CamerasConfigs[data.mx.id_mod].osso ~= nil then
        BoneCamera(CamerasConfigs[data.mx.id_mod].osso,0.0,0.0,0.0)
    end

    if CamerasConfigs[data.mx.id_mod].cam ~= nil then
        local v = CamerasConfigs[data.mx.id_mod].cam
        ControlCam(v.valor,v.x,v.y,v.z)
    else
        control = nil
    end

    if CamerasConfigs[data.mx.id_mod].acao ~= nil then
        if CamerasConfigs[data.mx.id_mod].acao == 'abrir_capo' then
            SetVehicleDoorOpen(vehicle_id,4,false,false)
        end
    end

    if data.mx.id_mod ~= '' or tonumber(data.mx.id_mod) then
        local min = -1
        local max = 20

        if data.mx.id_mod == 'windows_tint' then
            min = -1
            max = 5
        elseif tonumber(data.mx.id_mod) then
            if tonumber(data.mx.id_mod) == 48 then -- Liverys
                min = -1
                max = GetVehicleLiveryCount(vehicle_id)

                if max == -1 or max == 0 then
                    max = GetNumVehicleMods(vehicle_id, 48) - 1
                end
            else
                max = GetNumVehicleMods(vehicle_id, tonumber(data.mx.id_mod)) - 1
            end
        end
        GetMinMaxMods(min, max) 
    end
    cb('ok')
end)

-- Takes and displays the current mod on the nui of each vehicle
RegisterNUICallback('GetVehicleMod', function(data, cb) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            local num = -1
            if data.mx.mod_index == "windows_tint" then
                num = GetVehicleWindowTint(vehicle_id)
            else
                num = GetVehicleMod(vehicle_id, tonumber(data.mx.mod_index))
            end
            SendNUIMessage({
                ui = 'GetVehicleMod',
                numMod = num,
            })
        end
    end
    cb('ok')
end)