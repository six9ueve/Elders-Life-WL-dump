ESX = nil
local PlayerData, Timer, HasAlreadyEnteredMarker, ChoppingInProgress, LastZone, isDead, pedIsTryingToChopVehicle, isMenuOpened  = {}, 0, false, false, nil, false, false, false
local CurrentAction, CurrentActionMsg, CurrentActionData, isMenuOpened, isPlayerWhitelisted  = nil, '', {}, false, false
local timing = math.ceil(Timer * 60000)
------------------------------------------------rateur
local DrawDistance = 25.0 -- Change the distance before you can see the marker. Less is better performance.
local EnableBlips = false -- Set to false to disable blips.
local MarkerType = 27
local MarkerColor = { r = 255, g = 0, b = 0 } -- Change the marker color.

-- Set the time (in minutes) during the player is markered
local Timer = 1

local CooldownMinutes = 5

local CallCops = false -- Set to true if you want cops to be alerted when chopping is in progress
local CallCopsPercent = 3 -- (min1) if 1 then cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%.
local CopsRequired = 0
local ShowCopsMisbehave = true --show notification when cops steal too

local NPCEnable = true -- Set to false to disable NPC Ped at shop location.
local NPCHash = 68070371 --Hash of the npc ped. Change only if you know what you are doing.
local NPCShop = { x = 369.323, y = -2453.55, z = 5.130, h = 96.0 } -- Location of the shop For the npc.

local RemovePart = 1000

local GiveBlack = true --- Give dirty cash
local AnyoneCanChop = true -- Pesonal Cars chop ### CAUTION WILL DELETE VEHICLES FROM DATABASE

local Zones = {
  Chopshop = {coords = vector3(2307.921, 4861.095, 40.90), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = 2307.921, y = 4861.095, z = 40.90 }, Size = { x = 5.0, y = 5.0, z = 0.5 }, },
  Chopshop2 = {coords = vector3(2341.083, 2535.391, 45.63), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = 2341.083, y = 2535.391, z = 45.63 }, Size = { x = 5.0, y = 5.0, z = 0.5 }, },
  Chopshop3 = {coords = vector3(1314.93,4315.61,37.23), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = 1314.93, y = 4315.61, z = 37.23 }, Size = { x = 5.0, y = 5.0, z = 0.5 }, },
  Chopshop4 = {coords = vector3(2340.539, 3051.534, 47.15), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = 2340.53, y = 3051.53, z = 47.15 }, Size = { x = 5.0, y = 5.0, z = 0.5 }, },
  StanleyShop = {coords = vector3(369.323,-2453.55, 5.130), name = _U('map_blip_shop'), color = 50, sprite = 120, radius = 25.0, Pos = { x = 369.323, y = -2453.55, z = 5.130}, Size = { x = 3.0, y = 3.0, z = 1.0 }, },
}

RMenu.Add("resell", "princ", RageUI.CreateMenu("ChopShop", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("resell", "princ").Closed = function()
    isMenuOpened = false
end

local Items = {
  -- Item and Price $
  "battery",
  "muffler",
  "hood",
  "trunk",
  "doors",
  "engine",
  "waterpump",
  "oilpump",
  "speakers",
  "rims",
  "subwoofer",
  "steeringwheel",
  "licenseplate",
}


local ItemsPrices = {
  -- Item and Price $
  battery = 150,
  muffler = 120,
  hood = 100,
  trunk = 200,
  doors = 75,
  engine = 250,
  waterpump = 60,
  oilpump = 50,
  speakers = 70,
  rims = 90,
  subwoofer = 25,
  steeringwheel = 20,
  licenseplate = 200
}
-- Jobs in this table are considered as cops
local WhitelistedCops = {
  'police',
  'sheriff'
}
-------------------------------------------------------------------------------------
local function refreshPlayerWhitelisted()

    if not ESX.PlayerData then
        return false
    end

    if not ESX.PlayerData.job then
        return false
    end

    for k,v in ipairs(WhitelistedCops) do
        if v == ESX.PlayerData.job.name then
            return true
        end
    end

    return false
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    isPlayerWhitelisted = refreshPlayerWhitelisted()

end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job

    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('god:setJob2')
AddEventHandler('god:setJob2', function(job2)
    PlayerData.job2 = job2
end)

AddEventHandler('god:onPlayerDeath', function(data)
    isDead = true
    RageUI.CloseAll()
end)

local function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), - 1) == PlayerPedId()
end

local function MaxSeats(vehicle)
    local vehpas = GetVehicleNumberOfPassengers(vehicle)
    return vehpas
end


local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
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

local function VehiclePartsRemoval()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn( ped, false )
    local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(PlayerPedId(), false), 'door_dside_r')
    local bonnet = GetEntityBoneIndexByName(GetVehiclePedIsIn(PlayerPedId(), false), 'bonnet')
    local boot = GetEntityBoneIndexByName(GetVehiclePedIsIn(PlayerPedId(), false), 'boot')
    SetVehicleEngineOn(vehicle, false, false, true)
    SetVehicleUndriveable(vehicle, false)
    if ChoppingInProgress == true then
        Citizen.Wait(RemovePart)
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 0, false, false)
    end
    Citizen.Wait(1000)
    if ChoppingInProgress == true then
        Citizen.Wait(RemovePart)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 0, true)
    end
    Citizen.Wait(1000)
    if ChoppingInProgress == true then
        Citizen.Wait(RemovePart)
        SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 1, false, false)
    end
    Citizen.Wait(1000)
    if ChoppingInProgress == true then
        Citizen.Wait(RemovePart)
        SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 1, true)
    end
    Citizen.Wait(1000)
    if rearLeftDoor ~= -1 then
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 2, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 2, true)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 3, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 3, true)
        end
    end
    Citizen.Wait(1000)
    if bonnet ~= -1 then
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 4, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),4, true)
        end
    end
    Citizen.Wait(1000)
    if boot ~= -1 then
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 5, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(RemovePart)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),5, true)
        end
    end
    Citizen.Wait(1000)
    Citizen.Wait(RemovePart)
    if ChoppingInProgress == true then
        local vehicle =  GetVehiclePedIsIn( ped, false )
        if vehicle then
            local vehPlate = GetVehicleNumberPlateText(vehicle)
            ESX.TriggerServerCallback('Lenzh_chopshop:OwnedCar', function(owner)
                if owner then
                    ESX.ShowNotification("Le démontage de la voiture volée est fini...", false, true, g)
                    DeleteVehicle(vehicle)
                else
                    ESX.ShowNotification("Le démontage de la voiture est fini...", false, true, g)
                    DeleteVehicle(vehicle)
                end
            end, vehPlate)
        end
        TriggerServerEvent("Lenzh_chopshop:ChopRewards")
    end
end

local function OpenShopMenu()
    local elements = {}
    ESX.TriggerServerCallback('Lenzh_chopshop:getPlayerInventory', function(inventory)


        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]
            local price = ItemsPrices[item.name]            
            if price and item.count > 0 then
                table.insert(elements, {
                  label = ('x%s %s - <span style="color:green;">%s(Prix Unitaire)</span>'):format(item.count, item.label, _U('item', ESX.Math.GroupDigits(price))),
                  price = price,
                  name = item.name,
                  nombre = item.count
                })
            end
        end

        if isMenuOpened then return end
        isMenuOpened = true
        RageUI.Visible(RMenu:Get("resell", "princ"), true)

            Citizen.CreateThread(function()

                while isMenuOpened do
                    RageUI.IsVisible(RMenu:Get('resell', 'princ'), true, true, true, function()
                        if #elements > 0 then
                            for k, v in pairs(elements) do                            
                                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = '~b~Vendre'}, true,function(a,h,s)
                                        if s then
                                            local amount = KeyboardInput("atmos", "Quantité :", "", 6)
                                            amount = tonumber(amount)
                                            if amount == nil then 
                                                ESX.ShowNotification("~r~Problème~s~ : Case vide !")
                                                RageUI.CloseAll()
                                                isMenuOpened = false
                                            end
                                            if amount <= v.nombre then
                                                TriggerServerEvent('Lenzh_chopshop:sell', v.name, amount)
                                                RageUI.CloseAll()
                                                isMenuOpened = false
                                                else
                                                ESX.ShowNotification("~r~Problème~s~ : Pas assez de produit !")
                                                RageUI.CloseAll()
                                                isMenuOpened = false
                                            end                           

                                        end
                                    end)
                            end
                        else
                                        RageUI.Separator("")
                                        RageUI.Separator("~r~Pas d'objets à vendre !")
                                        RageUI.Separator("")

                        end
                    end)

                    Citizen.Wait(0)
                end
                CurrentAction     = 'StanleyShop'
                CurrentActionMsg  = _U('open_shop')
                CurrentActionData = {}
            end)
    end)
end

local function ChopVehicle()
        ESX.ShowNotification("patiente un peu.....")
            local seats = MaxSeats(vehicle)
            if seats ~= 0 then
                ESX.ShowNotification(_U("Cannot_Chop_Passengers"), false, true)
            elseif GetGameTimer() - Timer > CooldownMinutes * 60000 then
                Timer = GetGameTimer()
                --ESX.TriggerServerCallback('Lenzh_chopshop:anycops', function(anycops)
                    --if anycops >= CopsRequired then
                        --if CallCops then
                        --    local randomReport = math.random(1, CallCopsPercent)
                        --
                        --    if randomReport == CallCopsPercent then
                                --TriggerEvent('Lenzh_chopshop:StartNotifyPD')
                        --        serverid = GetPlayerServerId(PlayerId())
                        --        TriggerServerEvent('Lenzh_chopshop:GetPlayerID', serverid)
                        --        pedIsTryingToChopVehicle = true
                        --    end
                        --end
                        local ped = PlayerPedId()
                        local vehicle = GetVehiclePedIsIn( ped, false )
                        ChoppingInProgress = true
                        local vehPlate = GetVehicleNumberPlateText(vehicle)
                        local model = GetEntityModel(vehicle)
                        local displaytext = GetDisplayNameFromVehicleModel(model)
                        TriggerServerEvent('chopchoplog', vehPlate, displaytext)
                        ESX.ShowNotification("Bouge pas, démontage en cours.....")

                        VehiclePartsRemoval()
                        if not HasAlreadyEnteredMarker then
                            HasAlreadyEnteredMarker = true
                            ChoppingInProgress = false
                            ESX.ShowNotification(_U'ZoneLeft', false, true)

                            SetVehicleAlarmTimeLeft(vehicle, 60000)
                        end
                    --else
                    --    ESX.ShowNotification(_U('not_enough_cops'))
                    --end
                --end)
            else
                local timerNewChop = CooldownMinutes * 60000 - (GetGameTimer() - Timer)
                local TotalTime = math.floor(timerNewChop / 60000)
                if TotalTime >= 0 then
                    ESX.ShowNotification("Reviens dans " ..TotalTime.. " minute(s)")
                elseif TotalTime <= 0 then
                    ESX.ShowNotification(_U('cooldown'.. TotalTime))
                end
            end
        end

-- Display Marker
Citizen.CreateThread(function()
    while true do
        interval = 750
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local letSleep = true

        for k,v in pairs(Zones) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)
               
            if MarkerType ~= -1 and distance < DrawDistance then
                interval = 1
                DrawMarker(MarkerType, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, MarkerColor.r, MarkerColor.g, MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
                letSleep = false
            end
        end
        if letSleep then
            Citizen.Wait(500)
        end
        Citizen.Wait(interval)
    end
end)

local function CreateBlipCircle(coords, text, radius, color, sprite)

    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    if EnableBlips == true then
        for k,zone in pairs(Zones) do
            CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
        end
    end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        interval = 750
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local isInMarker  = false
        local currentZone = nil
        local letSleep = true
        for k,v in pairs(Zones) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if distance < v.Size.x then
                interval = 1
                isInMarker  = true
                currentZone = k
            end

        end
        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            interval = 1
            HasAlreadyEnteredMarker = true
            LastZone                = currentZone
            TriggerEvent('Lenzh_chopshop:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            interval = 1
            HasAlreadyEnteredMarker = false
            TriggerEvent('Lenzh_chopshop:hasExitedMarker', LastZone)
        end
        Citizen.Wait(interval)
    end
end)

AddEventHandler('Lenzh_chopshop:hasEnteredMarker', function(zone)
    if zone == 'Chopshop' and IsDriver() then
        CurrentAction     = 'Chopshop'
        CurrentActionMsg  = _U('press_to_chop')
        CurrentActionData = {}
    elseif zone == 'Chopshop2' and IsDriver() then
        CurrentAction     = 'Chopshop2'
        CurrentActionMsg  = _U('press_to_chop')
        CurrentActionData = {}
    elseif zone == 'Chopshop3' and IsDriver() then
        CurrentAction     = 'Chopshop3'
        CurrentActionMsg  = _U('press_to_chop')
        CurrentActionData = {}
    elseif zone == 'Chopshop4' and IsDriver() then
        CurrentAction     = 'Chopshop4'
        CurrentActionMsg  = _U('press_to_chop')
        CurrentActionData = {}
    elseif zone == 'StanleyShop' then
        CurrentAction     = 'StanleyShop'
        CurrentActionMsg  = _U('open_shop')
        CurrentActionData = {}
    end
end)

AddEventHandler('Lenzh_chopshop:hasExitedMarker', function(zone)
    if isMenuOpened then
        RageUI.CloseAll()
    end

    CurrentAction = nil
end)


-- Key controls
Citizen.CreateThread(function()
    while true do
        interval = 750
        if CurrentAction ~= nil then
            interval = 1
            ESX.ShowHelpNotification(CurrentActionMsg, true, true)
            if IsControlJustReleased(0, 38) then
                if IsDriver() then
                    if CurrentAction == 'Chopshop' or CurrentAction == 'Chopshop2' or CurrentAction == 'Chopshop3' or CurrentAction == 'Chopshop4' then
                		if PlayerData.job2.name == 'oneil' or PlayerData.job2.name == 'gitan' then
                            ChopVehicle()
						else
                    		ESX.ShowNotification("Tu fous quoi la, t'es pas de la famille, dégage de là avant de prendre du plomb....")
                    	end
                    end
                elseif CurrentAction == 'StanleyShop' then
                    OpenShopMenu()
                end
                CurrentAction = nil
            end
        else
            Citizen.Wait(500)
        end
        Citizen.Wait(interval)
    end
end)

Citizen.CreateThread(function()
    if NPCEnable == true then
        RequestModel(NPCHash)
        while not HasModelLoaded(NPCHash) do
            Wait(1)
        end

        stanley = CreatePed(1, NPCHash, NPCShop.x, NPCShop.y, NPCShop.z, NPCShop.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
        TaskStartScenarioInPlace(stanley, "WORLD_HUMAN_CLIPBOARD", 0, true);
    else
        print('[Lenzh_chopshop: NPC is turned Off]')
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        Citizen.Wait(3000)
        if pedIsTryingToChopVehicle then
            if (isPlayerWhitelisted and ShowCopsMisbehave) or not isPlayerWhitelisted then
                DecorSetInt(playerPed, 'Chopping', 2)

                TriggerServerEvent('Lenzh_chopshop:NotifPos', {
                    x = ESX.Math.Round(playerCoords.x, 1),
                    y = ESX.Math.Round(playerCoords.y, 1),
                    z = ESX.Math.Round(playerCoords.z, 1)
                })
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        if NetworkIsSessionStarted() then
            DecorRegister('Chopping', 3)
            DecorSetInt(PlayerPedId(), 'Chopping', 1)

            return
        end
    end
end)




RegisterNetEvent('Lenzh_chopshop:StartNotifyPD')
AddEventHandler('Lenzh_chopshop:StartNotifyPD', function(serverid)
    local serverid = GetPlayerPed(GetPlayerFromServerId(serverid))
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(serverid)
    ESX.ShowAdvancedNotification(_U('911'), _U('chop'), _U('call'), mugshotStr, 1)
    PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    UnregisterPedheadshot(mugshot)
end)

RegisterNetEvent('Lenzh_chopshop:NotifPosProgress')
AddEventHandler('Lenzh_chopshop:NotifPosProgress', function(targetCoords)
    if isPlayerWhitelisted then
        local alpha = 250
        local ChopBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

        SetBlipHighDetail(ChopBlip, true)
        SetBlipColour(ChopBlip, 17)
        SetBlipAlpha(ChopBlip, alpha)
        SetBlipAsShortRange(ChopBlip, true)

        while alpha ~= 0 do
            Citizen.Wait(5 * 4)
            alpha = alpha - 1
            SetBlipAlpha(ChopBlip, alpha)

            if alpha == 0 then
                RemoveBlip(ChopBlip)
                pedIsTryingToChopVehicle = false
                return
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        if DecorGetInt(PlayerPedId(), 'Chopping') == 2 then
            Citizen.Wait(timing)
            DecorSetInt(PlayerPedId(), 'Chopping', 1)
        end
    end
end)
