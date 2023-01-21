ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local Succses = false
local IsInVehicle = false
local Bridge = false
local FCW = true
local IsInHotwire = false

local function PlayHotwireAnimation()
    local animDict = "anim@veh@std@panto@ds@base"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, "hotwire", -8.0, -8, -1, 1, 0, 0, 0, 0)
end

local function PlayLockpickingAnimation()
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, "machinic_loop_mechandplayer", -8.0, -8, -1, 1, 0, 0, 0, 0)
end

local function StartLockpicking(closeveh)
    SetNuiFocus(true, true)
    SendNUIMessage({
        showPlayerMenu = true
    })
    vehiclelog = GetVehicleNumberPlateText(closeveh)
end

local function DrawText3D(coord, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(coord.x, coord.y, coord.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords()) 
    local scale = 0.3
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
    end
end

RegisterNetEvent('lockpickcar:startlockpicking')
AddEventHandler('lockpickcar:startlockpicking', function()
    local ped = PlayerPedId()
    local pedc = GetEntityCoords(ped)
    local closeveh = GetClosestVehicle(pedc.x, pedc.y, pedc.z, 5.0, 0 ,71)
    local lockstatus = GetVehicleDoorLockStatus(closeveh)
    local windowscoords = GetWorldPositionOfEntityBone(closeveh, GetEntityBoneIndexByName(closeveh, "window_lf"))
    if GetDistanceBetweenCoords(pCoords, PartsCoords, true) < 4.5 then
        if lockstatus == 2 then
            ESX.TriggerServerCallback('lockpickcar:getItemAmount', function(quantity)
                if quantity >= 1 then
                    StartLockpicking(closeveh)
                    PlayLockpickingAnimation()                        
                else
                    ESX.ShowNotification("Vous n'avez pas de Lockpick", 'Problème')
                end
            end, 'lockpick')
        else
            ESX.ShowNotification('Vehicle non vérouillé')
        end
    else
        ESX.ShowNotification('Pas de véhicule à proximité')
    end
end)

Citizen.CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local Vehicle = GetClosestVehicle(pCoords.x, pCoords.y, pCoords.z, 5.0, 0, 71)
        local vCoords = GetEntityCoords(Vehicle)
        local PartsCoords = GetWorldPositionOfEntityBone(Vehicle, GetEntityBoneIndexByName(Vehicle, "window_lf"))

        if PartsCoords == vector3(0,0,0) then
            PartsCoords = vCoords
        end

        if GetDistanceBetweenCoords(pCoords, PartsCoords, true) < 4.5 and GetVehicleDoorLockStatus(Vehicle) == 2 then
            sleep = 5
            --isCloseLockedVehicle = true
            --DrawText3D(vector3(PartsCoords.x, PartsCoords.y, PartsCoords.z-0.28), "[~g~E~w~] ~y~Lockpick")
            if Succses then 
                SetVehicleDoorsLocked(Vehicle, 0)
                ClearPedTasksImmediately(PlayerPedId())
                Citizen.Wait(10)
                TaskEnterVehicle(PlayerPedId(), Vehicle, 10000, -1, 1, 1, 0)
                IsInVehicle = true
                Bridge = true
                SetVehicleEngineOn(Vehicle, false, true, true)
                Succses = false
            end
            --[[if IsControlJustPressed(0, 38) then 
                ESX.TriggerServerCallback('lockpick:getItemAmount', function(quantity)
                    if quantity >= 1 then
                        StartLockpicking()
                        PlayLockpickingAnimation()                        
                    else
                        ESX.ShowNotification("Vous n'avez pas de Lockpick", 'Problème')
                    end
                end, 'lockpick')
            end]]--
        else    
            sleep = 500
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do 
        if IsInVehicle == true then 
            sleep = 5
            if FCW == true then 
                Citizen.Wait(2000)
                FCW = false
            end
            local PVeh = GetVehiclePedIsIn(PlayerPedId(), false)
            local GetPlayerInVehicle = IsPedInVehicle(PlayerPedId(), PVeh, true)
            if GetPlayerInVehicle == false then
                SetHornEnabled(PVeh, true)
                SetVehicleEngineOn(Vehicle, true, true, false)
                IsInVehicle = false
            elseif GetPlayerInVehicle == 1 and IsInHotwire == false and Bridge == true then
                local WheelCoords = GetWorldPositionOfEntityBone(PVeh, GetEntityBoneIndexByName(PVeh, "seat_dside_f"))
                DrawText3D(vector3(WheelCoords.x, WheelCoords.y, WheelCoords.z+0.4), "[~g~E~w~] ~y~Faire les fils")
                SetHornEnabled(PVeh, false)
                if IsControlJustPressed(0, 38) then 
                    IsInHotwire = true
                    Bridge = false
                    FCW = true
                    IsInHotwire = false
                    IsInVehicle = false
                    ExecuteCommand("asjıhıuqtguaıwgdhauıyg176213187")
                    PlayHotwireAnimation()
                end
            end
        else
            sleep = 2000 
        end
        Citizen.Wait(sleep)
    end
end)

--function SendPoliceAlert()

RegisterNUICallback('win', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		showPlayerMenu = false
	})
    Succses = true
    TriggerServerEvent('lockpick:log', vehiclelog)
end)

RegisterNUICallback('lose', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		showPlayerMenu = false
	})
    ClearPedTasksImmediately(PlayerPedId())
end)
ClearPedTasksImmediately(PlayerPedId())

