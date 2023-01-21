ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

RegisterKeyMapping('+openmainenu', 'Ouvrir menu principal', 'keyboard', 'F5')


RegisterKeyMapping('+elders_emotes_bind4', '/emotebind num4 <emote>', 'keyboard', 'NUMPAD4')
RegisterKeyMapping('+elders_emotes_bind5', '/emotebind num5 <emote>', 'keyboard', 'NUMPAD5')
RegisterKeyMapping('+elders_emotes_bind6', '/emotebind num6 <emote>', 'keyboard', 'NUMPAD6')
RegisterKeyMapping('+elders_emotes_bind7', '/emotebind num7 <emote>', 'keyboard', 'NUMPAD7')
RegisterKeyMapping('+elders_emotes_bind8', '/emotebind num8 <emote>', 'keyboard', 'NUMPAD8')
RegisterKeyMapping('+elders_emotes_bind9', '/emotebind num9 <emote>', 'keyboard', 'NUMPAD9')



--COMMANDE CONNAITRE LES VARIABLES GLOBALS

--[[for key, value in next, _G do
  print(key .. " = " .. tostring(value))
end]]--

Citizen.CreateThread(function()
    for _,v in pairs(ConfigBlips.blips) do
        v.blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(v.blip, v.id)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.6)
        SetBlipColour(v.blip, v.color)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(v.blip)
    end   
end)

function RUIText(text)
    ClearPrints()
    SetTextEntry_2("STRING")
    if (text.message ~= nil) then
        AddTextComponentString(tostring(text.message))
    end
    if (text.time_display ~= nil) then
        DrawSubtitleTimed(tonumber(text.time_display), 1)
    else
        DrawSubtitleTimed(10, 1)
    end
    if (text.sound ~= nil) then
        if (text.sound.audio_name ~= nil) then
            if (text.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, text.sound.audio_name, text.sound.audio_ref, true)
            end
        end
    end
end

function FinCreator()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), true, true)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), true)
        end
    end
end

function getInformations(player)
    ESX.TriggerServerCallback('elderslife:GetPlyData', function(data)
        plyIdentity = data
    end, GetPlayerServerId(player), false)
end

function ShowLoadingMessage(text, spinnerType, timeMs)
    Citizen.CreateThread(function()
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandBusyspinnerOn(spinnerType)
        Wait(timeMs)
        RemoveLoadingPrompt()
    end)
end

function LoadAnimDict(dictname)
    if not HasAnimDictLoaded(dictname) then
        RequestAnimDict(dictname) 
        while not HasAnimDictLoaded(dictname) do 
            Citizen.Wait(1)
        end
    end
end

function MarquerJoueur()
    local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
    local pos = GetEntityCoords(ped)
    local target, distance = ESX.Game.GetClosestPlayer()
    if distance <= 3.0 then
        DrawMarker(20, pos.x, pos.y, pos.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
    end
end

function GetCloseVehi()
    local player = PlayerPedId()
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(20, vCoords.x, vCoords.y, vCoords.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
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

function invjoueur(player)
    Items = {}
    ESX.TriggerServerCallback('asteinway:getOtherPlayerData', function(data)
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    amount   = data.inventory[i].count,
                    weight   = data.inventory[i].weight
                })
            end
        end
    end, player)
end

function getPlayerInv(player)
    Items = {}
    Liquide = {}
    ArgentSale = {}

    ESX.TriggerServerCallback('aGang:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'money' and data.accounts[i].money > 0 and data.accounts[i].money > 20000 then
                table.insert(Liquide, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_cash',
                    amount   = data.accounts[i].money
                })

                break
            end
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })

                break
            end
        end
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
    local generatedPlate
    local doBreak = false

    while true do
        Citizen.Wait(2)
        math.randomseed(GetGameTimer())
        if ConfigPlateUseSpace then
            generatedPlate = string.upper(GetRandomNumber(ConfigPlateNumbers1) .. GetRandomLetter(ConfigPlateLetters) .. GetRandomNumber(ConfigPlateNumbers))
        else
            generatedPlate = string.upper(GetRandomNumber(ConfigPlateNumbers1) .. GetRandomLetter(ConfigPlateLetters) .. GetRandomNumber(ConfigPlateNumbers))
        end

        ESX.TriggerServerCallback('elderslife:isPlateTaken', function (isPlateTaken)
            if not isPlateTaken then
                doBreak = true
            end
        end, generatedPlate)

        if doBreak then
            break
        end
    end

    return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
    local callback = 'waiting'

    ESX.TriggerServerCallback('elderslife:isPlateTaken', function(isPlateTaken)
        callback = isPlateTaken
    end, plate)

    while type(callback) == 'string' do
        Citizen.Wait(0)
    end

    return callback
end

function GetRandomNumber(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

function SpawnObj(object)
    local coords, forward = GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId())
    local objectCoords = (coords + forward * 1.0)
    local Entity = nil
    SpawnObject(object, objectCoords, function(object)
        SetEntityCoords(object, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(object, GetEntityHeading(PlayerPedId()))
        PlaceObjectOnGroundProperly(object)
        Entity = object
        Wait(1)
    end)
    Wait(1)
    while Entity == nil do Wait(1) end
    TriggerServerEvent('elderslife:Props', NetworkGetNetworkIdFromEntity(Entity))
    SetEntityHeading(Entity, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(Entity)
    local placed = false
    while not placed do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId())
        local objectCoords = (coords + forward * 2.0)
        SetEntityCoords(Entity, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Entity, GetEntityHeading(PlayerPedId()))
        PlaceObjectOnGroundProperly(Entity)
        SetEntityAlpha(Entity, 170, 170)
        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour placer l'objet")
        SetEntityCollision(Entity, 0, 0)
        if IsControlJustReleased(1, 38) then
            placed = true
        end
    end
    FreezeEntityPosition(Entity, true)
    SetEntityInvincible(Entity, true)
    ResetEntityAlpha(Entity)
    SetEntityCollision(Entity, 1, 1)
end

function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)
        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            TriggerServerEvent("elderslife:DeleteEntity", NetworkGetNetworkIdFromEntity(entity))
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function SpawnObject(model, coords, cb)
    local model = GetHashKey(model)

    Citizen.CreateThread(function()
        RequestModels(model)
        Wait(1)
        local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

        if cb then
            cb(obj)
        end
    end)
end

function RequestModels(modelHash)
    if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then
        return "Cone"
    elseif hash == GetHashKey("prop_barrier_work05") then
        return "Barrière"
    elseif hash == GetHashKey("p_ld_stinger_s") then
        return "Herse"
    elseif  hash == GetHashKey("v_med_emptybed") then
        return "Brancard"
    elseif  hash == GetHashKey("prop_ld_case_01") then
        return "Défibrillateur "
    elseif  hash == GetHashKey("prop_cs_shopping_bag") then
        return "Sac paramedic"
    elseif  hash == GetHashKey("prop_wheelchair_01") then
        return "Chaise roulante"
    elseif  hash == GetHashKey("prop_gazebo_02") then
        return "Gazebo"
    elseif  hash == GetHashKey("prop_air_conelight") then
        return "Cone lumière"
    elseif  hash == GetHashKey("prop_fncsec_04a") then
        return "Nadar"
    elseif  hash == GetHashKey("prop_worklight_03a") then
        return "Spot"
    elseif  hash == GetHashKey("prop_fncsec_03b") then
        return "Fence"
    elseif  hash == GetHashKey("prop_plas_barier_01a") then
        return "Bloc"
    elseif  hash == GetHashKey("stt_prop_track_slowdown") then
        return "Slow down"
    elseif  hash == GetHashKey("prop_barrier_work04a") then
        return "Route fermé"
    else
        return hash
    end
end

function HelpNotif(msg)
    AddTextEntry('CoreHelpNotif', msg)
    BeginTextCommandDisplayHelp('CoreHelpNotif')
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function ShowNotification(msg)
    AddTextEntry('Notification', msg)
    SetNotificationTextEntry('Notification')
    DrawNotification(false, true)
end

RegisterNetEvent("elderslife:onCleankit")
AddEventHandler("elderslife:onCleankit", function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local posVeh = GetEntityCoords(vehicle)
    local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(posVeh.x, posVeh.y, posVeh.z), true)
    if dist < 2.0 then
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
        Citizen.CreateThread(function()
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(PlayerPedId())
            ShowNotification("Le véhicule a été ~g~nettoyé~s~ !")
        end)    
    else
        ShowNotification("~r~Aucun véhicule à proximité !")
        TriggerServerEvent("elderslife:ReturnKitnet")
    end
end)

function RevivePly(closestPlayer)
    ESX.TriggerServerCallback('elderslife:getInvPlyItems', function(quantity)
        if quantity > 0 then
            if IsPedDeadOrDying(GetPlayerPed(closestPlayer), 1) then
                SetFocusEntity(GetPlayerPed(closestPlayer))
                TriggerServerEvent("elderslife:PlayCPR", GetPlayerServerId(closestPlayer), GetEntityHeading(PlayerPedId()), GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId()))
                ShowNotification("~g~Réanimation en cours.")
                ClampGameplayCamPitch(0.0, -90.0)
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, 8.0, -1, 0, 0, false, false, false)
                Citizen.Wait(14900)
                for i=1, 15, 1 do
                    Citizen.Wait(900)
                    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 8.0, -1, 0, 0, false, false, false)
                end
                TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_success", 8.0, 8.0, -1, 0, 0, false, false, false)
                Citizen.Wait(33590)



                --TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 8.0, -1, 0, 0, false, false, false)
                --Citizen.Wait(14900)
                --for i=1, 15, 1 do
                --    Citizen.Wait(900)
                --    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 8.0, -1, 0, 0, false, false, false)
                --end
                --TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 8.0, -1, 0, 0, false, false, false)
                --Citizen.Wait(33590)
                TriggerServerEvent('ambulance:removeItem', 'medikit')
                --sCore.TriggerSrv(Config_sCore.Prefix..":AddMoneySell", 500)
                --ShowNotification("Vous avez réanimé le patient.\n~g~Vous avez reçu 500$")
                TriggerServerEvent('ambulance:revive', GetPlayerServerId(closestPlayer))
            else
                ShowNotification("~r~Aucun(e) individu à proximité !")
            end
        else
            ShowNotification("~r~Vous n'avez pas de kit de réanimation.")
        end
    end, 'medikit')
end

local cam = nil
local isDead = false
local angleY = 0.0
local angleZ = 0.0

function ProcessNewPosition()
    local mouseX = 0.0
    local mouseY = 0.0
    if (IsInputDisabled(0)) then
        mouseX = GetDisabledControlNormal(1, 1) * 8.0
        mouseY = GetDisabledControlNormal(1, 2) * 8.0
    else
        mouseX = GetDisabledControlNormal(1, 1) * 1.5
        mouseY = GetDisabledControlNormal(1, 2) * 1.5
    end
    angleZ = angleZ - mouseX
    angleY = angleY + mouseY 
    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
    local pCoords = GetEntityCoords(PlayerPedId())
    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (1.5 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (1.5 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (1.5 + 0.5)
    }
    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
    local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    local maxRadius = 1.5
    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < 1.5 + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
    end
    local offset = {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }
    local pos = {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }
    return pos
end

function EndDeathCam()
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    cam = nil
end