local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(100)
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("Elderssheriff:radarRemoveBlips")
AddEventHandler("Elderssheriff:radarRemoveBlips", function(RemoveBlips, BlipsID, BlipsCoords)
    while RemoveBlips do
        Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, BlipsCoords.x, BlipsCoords.y, BlipsCoords.z)
        if dist <= 5.0 then
            RemoveBlip(BlipsID)
            ESX.ShowAdvancedNotification("Central", "Information(s)", "Vous êtes arrivés à destination ! ", "CHAR_CALL911", 1)
            RemoveBlips = false
            break
        end
    end
end)

RegisterNetEvent("Elderssheriff:TakeAppelHelp")
AddEventHandler("Elderssheriff:TakeAppelHelp", function(pos, job)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
    ESX.ShowAdvancedNotification("Central", "Information(s)", "Un membre de la "..job.." réclame des unités, rendez-vous sur-place !", "CHAR_CALL911", 1)
    local BlipsRenfort = AddBlipForCoord(pos)
    SetBlipSprite(BlipsRenfort, 161)
    SetBlipScale(BlipsRenfort, 0.5)
    SetBlipColour(BlipsRenfort, 1)
    SetBlipRoute(BlipsRenfort, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Réclamation renfort | BCSO")
    EndTextCommandSetBlipName(BlipsRenfort)
    Wait(70 * 1000)
    RemoveBlip(BlipsRenfort)
end)

RegisterNetEvent("Elderssheriff:SendSoundPlaque")
AddEventHandler("Elderssheriff:SendSoundPlaque", function()
    PlaySoundFrontend(l_57, "Background_Loop", "CB_RADIO_SFX", 1)
    Wait(2000)
    PlaySoundFrontend(l_A74, "Change_Station_Loud", "Radio_Soundset", 1)
    Wait(1000)
    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    Wait(1000)
    PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
    Wait(1000)
    PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
end)

RegisterNetEvent("Elderssheriff:BCSOAlerte")
AddEventHandler("Elderssheriff:BCSOAlerte", function(coords, raison, matricule)
    if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CALL911', 1)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
        textrenfort = 'Demande [~b~Légère~s~]'
        sprite = 161
        scale = 0.5
    elseif raison == 'grande' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CALL911', 1)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
        textrenfort = 'Demande [~o~Importante~s~]'
        sprite = 161
        scale = 0.7
	elseif raison == 'allcops' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 1)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 47
        textrenfort = 'Demande [~o~URGENTE~s~]'
        sprite = 161
        scale = 1.5
    elseif raison == 'pause' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Agent: ~g~'..matricule..'\n~w~Code: ~g~10-6\n~w~Information: ~g~Pause de service', 'CHAR_CALL911', 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif raison == 'standby' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Agent: ~g~'..matricule..'\n~w~Code: ~g~10-12\n~w~Information: ~g~Standby, en attente de dispatch.', 'CHAR_CALL911', 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    elseif raison == 'control' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Agent: ~g~'..matricule..'\n~w~Code: ~g~10-48\n~w~Information: ~g~Contrôle routier en cours.', 'CHAR_CALL911', 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        color = 2
        textrenfort = 'Info [~b~Contrôle routier en cours~s~]'
        sprite = 161
        scale = 0.5
    elseif raison == 'refus' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Agent: ~g~'..matricule..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Refus d\'obtempérer / Délit de fuite en cours.', 'CHAR_CALL911', 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        color = 2
        textrenfort = 'Info [~b~Délit de fuite en cours~s~]'
        sprite = 161
        scale = 0.5
    elseif raison == 'crime' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", 'Agent: ~g~'..matricule..'\n~w~Code: ~g~10-31\n~w~Information: ~g~Crime en cours / poursuite en cours.', 'CHAR_CALL911', 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        color = 2
        textrenfort = 'Info [~b~Crime en cours~s~]'
        sprite = 161
        scale = 0.5
    end 
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, sprite)
    SetBlipScale(blipId, scale)
    SetBlipColour(blipId, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(textrenfort)
    EndTextCommandSetBlipName(blipId)
    Wait(70 * 1000)
    RemoveBlip(blipId)
end)

function VehiculeMarker()
    local pos = GetEntityCoords(PlayerPedId())
    local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
    pos = GetEntityCoords(veh)
    local target, distance = ESX.Game.GetClosestVehicle()
    if distance <= 3.0 then
        DrawMarker(22, pos.x, pos.y, pos.z+1.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 0, 0, 170, 0, 1, 2, 1, nil, nil, 0)
    end
end

function spawnHelicoBCSO(ped, car)
	local hash = GetHashKey(car)
	local p = vector3(449.2597, -980.9709, 43.6914)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end
		local vehicle = CreateVehicle(hash, p.x, p.y, p.z, 329.99, true, false)
    end)
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

function CreateClothsCam(state, job)
    if not state then
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityCoordsNoOffset(PlayerPedId(), 462.89318847656, -996.52752685547, 30.689493179321, 0.0, 0.0, 0.0)
        SetEntityHeading(PlayerPedId(), 112.3)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(cam, 457.44262695313, -998.07556152344, 32.595050811768)
        SetCamFov(cam, 25.0)
        SetCamActive(cam, true)
        PointCamAtEntity(cam, PlayerPedId(), 0, 0, 0, true)
        RenderScriptCams(1, 1, 2000, 1, 1)
        DisplayRadar(false)
    else
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityCoordsNoOffset(PlayerPedId(), -569.4171, -110.3439, 33.87862, 0.0, 0.0, 0.0)
        SetEntityHeading(PlayerPedId(), 163.3)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(cam, -570.5958, -113.9101, 34.1)
        SetCamFov(cam, 30.0)
        SetCamActive(cam, true)
        PointCamAtEntity(cam, PlayerPedId(), 0, 0, 0, true)
        RenderScriptCams(1, 1, 2000, 1, 1)
        DisplayRadar(false)
    end
end

function ChangeCameraBCSO(x,y,z,r)
    camera = true
    DoScreenFadeOut(800)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, r.x, r.y, r.z, 2)
    RenderScriptCams(1, 1, 2500, 1, 1)
    DisplayRadar(false)
    Wait(500)
    SetTimecycleModifier("scanline_cam_cheap")
    SetTimecycleModifierStrength(2.0)
    Wait(1000)
    SetFocusEntity(PlayerPedId())
    DoScreenFadeIn(5000)
    SetFocusArea(x, y, z, x, y, z)
    while camera do
        Wait(1)
        DrawScaleformMovieFullscreen(CreateInstuctionScaleform("instructional_buttons", {[1] = "Orienter à droite", [2] = "Orienter à gacuhe", [3] = "Zoomer", [4] = "Dezoomer", [5] = "Quitter"}), 255, 255, 255, 255, 0)
        if IsControlJustPressed(0, 174) then
            local getCameraRot = GetCamRot(cam, 2)
            SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 2.5, 2)
        elseif IsControlJustPressed(0, 175) then
            local getCameraRot = GetCamRot(cam, 2)
            SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 2.5, 2)
        elseif IsControlJustPressed(0, 27) then
            local getCameraFov = GetCamFov(cam)
            SetCamFov(cam, getCameraFov-4)
        elseif IsControlJustPressed(0, 173) then
            local getCameraFov = GetCamFov(cam)
            SetCamFov(cam, getCameraFov+4)
        elseif IsControlJustPressed(0, 177) then
            camera = false
            CloseCameraCamera(true)
            DisplayRadar(true)
        end
    end
end

function CloseCameraCamera(activate)
    if activate then
        DoScreenFadeOut(800)
        DestroyAllCams(true)
        RenderScriptCams(0, 1, 2000, 1, 1)
        SetFocusEntity(PlayerPedId())
        Wait(1000)
        ClearTimecycleModifier("scanline_cam_cheap")
        DoScreenFadeIn(5000)
    else
        ClearTimecycleModifier("scanline_cam_cheap")
        DestroyAllCams(true)
        RenderScriptCams(0, 1, 1000, 1, 1)
        SetFocusEntity(PlayerPedId())
    end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)
            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)
        return vehicleProps
    end
end

function DeleteClothsCam()
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, 1, 2000, 1, 1)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    DisplayRadar(true)
end

function round(num, dec)
	local mult = 10^(dec or 0)
	return math.floor(num * mult + 0.5) / mult
end

local vitesse_flash				= 0
local vitesse_flash				= nil
local is_flashed 				= false
local speedlimit				= 0
local PedSpeed					= 0
local maxSpeed = 0
local i 						= 0
local timeout					= 0
local RadarInfosBCSO = {}
local Flashled = {}
local RadarPlaced = {}

function RadarBCSO(m)
    if isRadarPlaced then 
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), RadarPos.x, RadarPos.y, RadarPos.z, true) < 1.5 then 
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
               Wait(10)
            end
            TaskPlayAnim(PlayerPedId(), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) 
            Citizen.Wait(2000) 
            SetEntityAsMissionEntity(Radar, false, false)
            DeleteObject(Radar)
            DeleteEntity(Radar)
            Radar = nil
            RadarPos = {}
            RadarAng = 0
            isRadarPlaced = false
            RadarGood = false
            ESX.ShowAdvancedNotification("Central", 'Information(s)', "Votre radar a bien été ranger !", 'CHAR_CALL911', 1)
        else
            ESX.ShowAdvancedNotification("Central", 'Information(s)', "Aucun radar à proximité !", 'CHAR_CALL911', 1)
        end
    else
        maxSpeed = tonumber(KeyboardInput("radar", "Vitesse Max", "", 5))
        Citizen.Wait(200) 
        RadarPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.5, 0)
        RadarAng = GetEntityRotation(PlayerPedId())
        if maxSpeed ~= nil and maxSpeed > 90 then
            RadarGood = true 
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
                Wait(10)
            end
            TaskPlayAnim(PlayerPedId(), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true)
            Citizen.Wait(1500)
            RequestModel("prop_cctv_pole_01a")
            while not HasModelLoaded("prop_cctv_pole_01a") do
                Wait(10)
            end
            Radar = CreateObject(GetHashKey('prop_cctv_pole_01a'), RadarPos.x, RadarPos.y, RadarPos.z - 7, true, true, true) 
            SetEntityRotation(Radar, RadarAng.x, RadarAng.y, RadarAng.z - 115)
            SetEntityAsMissionEntity(Radar, true, true)
            FreezeEntityPosition(Radar, true) 
            isRadarPlaced = true
            TriggerServerEvent("Elderssheriff:AddInfosRadar", RadarPos,maxSpeed)
            local MyPos = GetEntityCoords(PlayerPedId())
            local dst = Vdist(MyPos.x, MyPos.y, MyPos.z, RadarPos.x, RadarPos.y, RadarPos.z)
            local RadarPlaced = {
                pos = {x = RadarPos.x, y = RadarPos.y, z = RadarPos.z},
                maxSpeed = maxSpeed,
                localisation = GetStreetNameFromHashKey(GetStreetNameAtCoord(RadarPos.x, RadarPos.y, RadarPos.z)),
                distance = math.floor(dst+0.5),
                matricule = m,
            }
            TriggerServerEvent("Elderssheriff:AddRadarPlaced", RadarPlaced)
            ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre radar a bien été mise en place ! - Limitation à : [~b~"..maxSpeed.."~s~KM/H]", "CHAR_CALL911", 1)
        else
            ESX.ShowAdvancedNotification("Central", 'Information(s)', "Veuillez rentrer une limitation valide ou une limitation plus élevée !", 'CHAR_CALL911', 1)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            WaitRadar = 5000
            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
                ESX.TriggerServerCallback("Elderssheriff:GetInfosRadar", function(radarinfosbcso)
                    RadarInfosBCSO = radarinfosbcso
                end)
                for k,v in pairs(RadarInfosBCSO) do
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.pos.x, v.pos.y, v.pos.z, true) < 200 then
                        WaitRadar = 1000
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.pos.x, v.pos.y, v.pos.z, true) < 35 then
                            WaitRadar = 50
                            if is_flashed == false and timeout == 0 then
                                speedlimit 	= v.speed + 6
                                PedSpeed 	= GetEntitySpeed(PlayerPedId()) * 3.6
                                if PedSpeed > speedlimit then
                                    vitesse_flash = (GetEntitySpeed(PlayerPedId()) * 3.6)
                                    local price = 0
                                    local speeding = PedSpeed - speedlimit
                                    speeding = round(speeding)
                                    if speeding < 20 then 
                                        price = 120
                                    end
                                    if speeding < 30 then 
                                        price = 150
                                    end
                                    if speeding < 50 then 
                                        price = 200
                                    end
                                    if speeding >= 50 then 
                                        price = 400
                                    end
                                    if is_flashed == false then
                                        local MyPos = GetEntityCoords(PlayerPedId())
                                        local dst = Vdist(MyPos.x, MyPos.y, MyPos.z, v.pos.x, v.pos.y, v.pos.z)
                                        local Flashled = {
                                            plaque = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())),
                                            model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))),
                                            speed = (speeding+speedlimit),
                                            localisation = GetStreetNameFromHashKey(GetStreetNameAtCoord(v.pos.x, v.pos.y, v.pos.z)),
                                            distance = math.floor(dst+0.5),
                                            pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
                                            price = price,
                                        }
                                        if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "sheriff" then
                                            return 
                                        else
                                            TriggerServerEvent("Elderssheriff:AddFlashSpeed", Flashled)
                                            StartScreenEffect('SwitchShortMichaelIn', 400, false)
                                            --ESX.ShowAdvancedNotification("Central", "Information(s)", "Excès de vitesse : \n~b~Vitesse~s~ : "..(speeding+speedlimit).."KM/H\n~b~Limitation~s~ : "..(speedlimit-6).."KM/H\n~b~Facture~s~ : ~g~"..price.."$", "CHAR_CALL911", 1)
                                            TriggerServerEvent("Elderssheriff:SendBillToOnwnerVeh", Flashled.plaque, Flashled.price)
                                            --TriggerServerEvent("Elderssheriff:SendNotifFlashedLSPD")
                                            TriggerServerEvent("Elderssheriff:SendNotifFlashedBCSO")
                                            is_flashed = true
                                            timeout = 85
                                            Citizen.SetTimeout(30000, function()
                                                is_flashed = true
                                                timeout = 0
                                            end)
                                        end
                                    end
                                end
                            end
                        else
                            price 			= 0
                            vitesse_flash 	= 0
                            is_flashed 		= false
                        end
                    end
                end		
            end
            if timeout > 0 then
                timeout = timeout - 1
            end
            Citizen.Wait(WaitRadar)
        end
    end)
end)

-- Speedzones

local Speedzones = {}
local DrawSpeedzones = false
local InstructionScaleform = nil

AddEventHandler('elders_sheriff:toggleSpeedzoneDraw', function(boolean)
    DrawSpeedzones = boolean
    if DrawSpeedzones then
        InDrawSpeedzones()
        ESX.ShowNotification('~g~Affichage des zones d\'arrêt NPC')
    else
        InDrawSpeedzones()
        ESX.ShowNotification('~r~Zones d\'arrêt NPC masquées')
    end
end)


local sizeMax = 50.0
AddEventHandler('elders_sheriff:promptSpeedzone', function()
    local BeforougerawSpeedzones = DrawSpeedzones
    DrawSpeedzones = true
    InDrawSpeedzones()
    local placed = false
    local size = 1.0

    InitInstructionScaleform()

    repeat
        DrawMarker(25, GetEntityCoords(PlayerPedId()) + vector3(0,0,-0.95), 0, 0, 0, GetEntityRotation(PlayerPedId()), size * 2.0, size * 2.0, 1.0, 10, 10, 10, 255, false, false, 2, false, nil, nil, false)
        DrawScaleformMovieFullscreen(InstructionScaleform, 255, 255, 255, 255, 0);


        if IsControlPressed(0, 172) then -- UP
            if size <= sizeMax then
                size = size + 0.1
            end
        elseif IsControlPressed(0, 173) then -- DOWN
            if size >= 1.0 then
                size = size - 0.08
            end
        end

        if IsControlJustReleased(1, 348) or IsControlJustPressed(1, 201) then
            placed = true
        end

        if IsControlJustReleased(1, 194) or IsPedInAnyVehicle(PlayerPedId(), true) then -- Cancel
            ESX.ShowNotification('~r~Zone d\'arrêt annulée')
            DrawSpeedzones = BeforougerawSpeedzones
            InDrawSpeedzones()
            TriggerEvent('elders_sheriff:finishedPlacingSpeedzone')
            return
        end

        Citizen.Wait(0)
    until placed
    TriggerServerEvent('elders_sheriff:addSpeedzone', GetEntityCoords(PlayerPedId()), size)
    DrawSpeedzones = BeforougerawSpeedzones
    InDrawSpeedzones()
end)

RegisterNetEvent('elders_sheriff:addSpeedzone')
AddEventHandler('elders_sheriff:addSpeedzone', function(whoCreated, pos, size)
    local zoneIndex = AddSpeedZoneForCoord(pos.x, pos.y, pos.z, size, 0.0, false)
    table.insert(Speedzones, {
        whoCreated = whoCreated,
        pos = pos,
        size = size,
        zoneIndex = zoneIndex,
    })
    if whoCreated == GetPlayerServerId(PlayerId()) then
        ESX.ShowNotification('~g~Zone d\'arrêt placée')
        TriggerEvent('elders_sheriff:finishedPlacingSpeedzone')
    end
end)

RegisterNetEvent('elders_sheriff:removeSpeedzone')
AddEventHandler('elders_sheriff:removeSpeedzone', function(whoDeleted, deletedSpeedZone)
    for i,speedZone in pairs(Speedzones) do
        if speedZone.pos == deletedSpeedZone.pos then
            Speedzones[i] = nil
        end
    end
    RemoveSpeedZone(deletedSpeedZone.zoneIndex)
    if deletedSpeedZone.whoCreated ~= whoDeleted and deletedSpeedZone.whoCreated == GetPlayerServerId(PlayerId()) then
        ESX.ShowNotification('~r~Votre zone d\'arrêt a été supprimée')
    end
    if whoDeleted == GetPlayerServerId(PlayerId()) then
        ESX.ShowNotification('~r~Zone d\'arrêt supprimée')
    end
end)

function InitInstructionScaleform()
    InstructionScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS");
    repeat
        Citizen.Wait(0)
    until HasScaleformMovieLoaded(InstructionScaleform)

    BeginScaleformMovieMethod(InstructionScaleform, "CLEAR_ALL");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(InstructionScaleform, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(6);
    PushScaleformMovieMethodParameterString("~INPUT_FRONTEND_ACCEPT~");
    PushScaleformMovieMethodParameterString("~INPUT_MAP_POI~");
    PushScaleformMovieMethodParameterString("Poser la zone d'arrêt");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(InstructionScaleform, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(5);
    PushScaleformMovieMethodParameterString("~INPUT_FRONTEND_RRIGHT~");
    PushScaleformMovieMethodParameterString("Annuler");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(InstructionScaleform, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(4);
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_UP~");
    PushScaleformMovieMethodParameterString("Agrandir la zone");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(InstructionScaleform, "SET_DATA_SLOT");
    ScaleformMovieMethodAddParamInt(3);
    PushScaleformMovieMethodParameterString("~INPUT_CELLPHONE_DOWN~");
    PushScaleformMovieMethodParameterString("Réduire la zone");
    EndScaleformMovieMethod();

    BeginScaleformMovieMethod(InstructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS");
    ScaleformMovieMethodAddParamInt(0);
    EndScaleformMovieMethod();
end

function DrawSpeedzone(Speedzone, Selected)
    if Selected then
        DrawMarker(25, Speedzone.pos + vector3(0,0,-0.95), 0, 0, 0, 0, 0, 0, Speedzone.size * 2.0, Speedzone.size * 2.0, 1.0, 127, 0, 0, 200, false, false, 2, false, nil, nil, false)
    else
        DrawMarker(25, Speedzone.pos + vector3(0,0,-0.95), 0, 0, 0, 0, 0, 0, Speedzone.size * 2.0, Speedzone.size * 2.0, 1.0, 0, 0, 127, 127, false, false, 2, false, nil, nil, false)
    end
end

function InDrawSpeedzones()
    if not DrawSpeedzones then return end

    Citizen.CreateThread(function()
        while DrawSpeedzones do
            Citizen.Wait(0)
            local playerPos = GetEntityCoords(PlayerPedId())
            local closest, closestDistance = nil, 1000

            for _,Speedzone in pairs(Speedzones) do
                local distance = #(Speedzone.pos - playerPos)
                if distance < 30 then
                    DrawSpeedzone(Speedzone, false)
                    if distance < closestDistance then
                        closestDistance = distance
                        closest = Speedzone
                    end
                end
            end

            if closest and closestDistance < closest.size then
                DrawSpeedzone(closest, true)
                ESX.ShowHelpNotification('~INPUT_CELLPHONE_OPTION~ pour supprimer la zone d\'arrêt NPC')
                if IsControlJustReleased(1, 178) then
                    TriggerServerEvent('elders_sheriff:removeSpeedzone', closest)
                end
            end
        end
    end)
end