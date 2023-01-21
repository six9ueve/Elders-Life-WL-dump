local JobGofastStarted,checkpoint,checkpoint2,battle,check,spawned,check = false,false,false,false,false,false,false
local del = 0
local drogue,mission,car,gang,fin,pedfin,currentBlip,choixCar,cpt,timer,minutes
Citizen.CreateThread(function()	
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do
		Citizen.Wait(10)
	end
	ESX.TriggerServerCallback('Gofast:GetTriggers', function(Data) Triggers = Data end)
	while Triggers == nil do
		Citizen.Wait(10)	
    end
end)
RegisterNetEvent('Gofast:start')
AddEventHandler('Gofast:start', function()
    if not JobGofastStarted then
	   StartGofast()
       ClearCurrentGofast()
    end
end)
RegisterNetEvent('Gofast:stop')
AddEventHandler('Gofast:stop', function()
    if JobGofastStarted then
        StopGofast()
        ClearCurrentGofast()
    end
end)
function StartGofastThread()
	local Waiter = 7
    local playerPed = PlayerPedId()
    local distance
	Citizen.CreateThread(function()
		while JobGofastStarted do
            if ConfigGoFast.StopWhenDie and GetEntityHealth(playerPed) == 0 then
                StopGofast()
            end
            if mission == nil then
                if ConfigGoFast.Progressbar then
                    exports['progressBars']:startUI(15050, ConfigGoFast.Translation[ConfigGoFast.Language]["Call"])
                end
                ESX.Streaming.RequestAnimDict('amb@world_human_stand_mobile@male@standing@call@enter', function()
                    TaskPlayAnim(playerPed, 'amb@world_human_stand_mobile@male@standing@call@enter', 'enter', -1.0, -1.0, -1, 1, 1, -1, -1, -1)
                end)
                Wait(6500)
                ClearPedTasks(playerPed)
                Wait(50)
                ESX.Streaming.RequestAnimDict('amb@world_human_stand_mobile@male@standing@call@idle_a', function()
                    TaskPlayAnim(playerPed, 'amb@world_human_stand_mobile@male@standing@call@idle_a', 'idle_b', -1.0, -1.0, -1, 1, 1, -1, -1, -1)
                end)
                Wait(4500)
                ESX.Streaming.RequestAnimDict('amb@world_human_stand_mobile@male@standing@call@exit', function()
                    TaskPlayAnim(playerPed, 'amb@world_human_stand_mobile@male@standing@call@exit', 'exit', -1.0, -1.0, -1, 1, 1, -1, -1, -1)
                end)
                Wait(4500)
                ClearPedTasks(playerPed)
                mission = ConfigGoFast.GoFast[GetRandomIntInRange(1, #ConfigGoFast.GoFast)] 
                gang = ConfigGoFast.Gang[GetRandomIntInRange(1, #ConfigGoFast.Gang)]
                showPictureNotificationGF("CHAR_CHEF",ConfigGoFast.Translation[ConfigGoFast.Language]["Contact"],"Contact",nil)
                choixCar = ConfigGoFast.Cars[GetRandomIntInRange(1, #ConfigGoFast.Cars)]
                fin = mission.destination[GetRandomIntInRange(1, #mission.destination)]
                currentBlip = AddBlipForCoord(mission.carDepart)
                SetBlipAsFriendly(currentBlip, 1)
                SetBlipColour(currentBlip, 2)
                SetBlipCategory(currentBlip, 3)
                SetBlipRoute(currentBlip, true)
            else
                local playcoords = GetEntityCoords(playerPed)
                local pedcoords = vector3(0,0,0)
                if DoesEntityExist(pedfin) then
                    pedcoords = GetEntityCoords(pedfin)
                end
                if not checkpoint then
                    distance = GetDistanceBetweenCoords(playcoords, mission.pedDepart.x,mission.pedDepart.y,mission.pedDepart.z, true)
                    if distance > 150 then
                        Waiter = 5000
                    elseif distance < 150 and distance > 50 then
                        if not DoesEntityExist(pedfin) then
                            while not HasModelLoaded(gang) do
                                RequestModel(GetHashKey(gang))
                                Citizen.Wait(0)
                            end
                            while not HasModelLoaded(choixCar.carhash) do
                                RequestModel(GetHashKey(choixCar.carhash))
                                Citizen.Wait(0)
                            end
                            pedfin = CreatePed(4, GetHashKey(gang), mission.pedDepart, true, true)
                            GiveWeaponToPed(pedfin, GetHashKey("WEAPON_SMG"), 250, true, true)
                            SetPedDropsWeaponsWhenDead(pedfin, false)
                            SetPedArmour(pedfin, 10000)
                            SetPedAlertness(pedfin, 0)
                            TaskStartScenarioInPlace(pedfin, "WORLD_HUMAN_LEANING", 0, true)
                            car = CreateVehicle(GetHashKey(choixCar.carhash),mission.carDepart, true, true)
                            SetVehicleMaxModsGoFast(car)
                            SetVehicleDoorsLocked(car, 2)
                        end
                        Waiter = 1000
                    elseif distance < 50 and distance > 20 then
                        if not DoesEntityExist(pedfin) then
                            while not HasModelLoaded(gang) do
                                RequestModel(GetHashKey(gang))
                                Citizen.Wait(0)
                            end
                            while not HasModelLoaded(choixCar.carhash) do
                                RequestModel(GetHashKey(choixCar.carhash))
                                Citizen.Wait(0)
                            end
                            pedfin = CreatePed(4, GetHashKey(gang), mission.pedDepart, true, true)
                            GiveWeaponToPed(pedfin, GetHashKey("WEAPON_SMG"), 250, true, true)
                            SetPedDropsWeaponsWhenDead(pedfin, false)
                            SetPedArmour(pedfin, 10000)
                            SetPedAlertness(pedfin, 0)
                            TaskStartScenarioInPlace(pedfin, "WORLD_HUMAN_LEANING", 0, true)
                            car = CreateVehicle(GetHashKey(choixCar.carhash),mission.carDepart, true, true)
                            SetVehicleMaxModsGoFast(car)
                            SetVehicleDoorsLocked(car, 2)
                        end
                        Waiter = 7
                    elseif distance < 20 and distance > 2 then
                        if not DoesEntityExist(pedfin) then
                            while not HasModelLoaded(gang) do
                                RequestModel(GetHashKey(gang))
                                Citizen.Wait(0)
                            end
                            while not HasModelLoaded(choixCar.carhash) do
                                RequestModel(GetHashKey(choixCar.carhash))
                                Citizen.Wait(0)
                            end
                            pedfin = CreatePed(4, GetHashKey(gang), mission.pedDepart, true, true)
                            GiveWeaponToPed(pedfin, GetHashKey("WEAPON_SMG"), 250, true, true)
                            SetPedDropsWeaponsWhenDead(pedfin, false)
                            SetPedArmour(pedfin, 10000)
                            SetPedAlertness(pedfin, 0)
                            TaskStartScenarioInPlace(pedfin, "WORLD_HUMAN_LEANING", 0, true)
                            car = CreateVehicle(GetHashKey(choixCar.carhash),mission.carDepart, true, true)
                            SetVehicleMaxModsGoFast(car)
                            SetVehicleDoorsLocked(car, 2)
                        end
                        DrawMarker(2, pedcoords.x, pedcoords.y, pedcoords.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                        Waiter = 7
                    elseif distance < 2 then
                        if not DoesEntityExist(pedfin) then
                            while not HasModelLoaded(gang) do
                                RequestModel(GetHashKey(gang))
                                Citizen.Wait(0)
                            end
                            while not HasModelLoaded(choixCar.carhash) do
                                RequestModel(GetHashKey(choixCar.carhash))
                                Citizen.Wait(0)
                            end
                            pedfin = CreatePed(4, GetHashKey(gang), mission.pedDepart, true, true)
                            GiveWeaponToPed(pedfin, GetHashKey("WEAPON_SMG"), 250, true, true)
                            SetPedDropsWeaponsWhenDead(pedfin, false)
                            SetPedArmour(pedfin, 10000)
                            SetPedAlertness(pedfin, 0)
                            TaskStartScenarioInPlace(pedfin, "WORLD_HUMAN_LEANING", 0, true)
                            car = CreateVehicle(GetHashKey(choixCar.carhash),mission.carDepart, true, true)
                            SetVehicleMaxModsGoFast(car)
                            SetVehicleDoorsLocked(car, 2)
                        end
                        DrawMarker(2, pedcoords.x, pedcoords.y, pedcoords.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                        ESX.ShowHelpNotification(ConfigGoFast.Translation[ConfigGoFast.Language]["StartKey"])
                        if IsControlJustReleased(1, 38) then
                            RemoveBlip(currentBlip)
                            ESX.Streaming.RequestAnimDict("mp_arresting", function()
                                TaskPlayAnim(pedfin, "mp_arresting", "a_uncuff", -1.0, -1.0, -1, 0, 1, -1, -1, -1)
                            end)
                            RequestAmbientAudioBank("GENERIC_HI")
                            PlayAmbientSpeech1(pedfin,"GENERIC_HI","SPEECH_PARAMS_STANDARD")
                            ESX.Streaming.RequestAnimDict("mp_arresting", function()
                                TaskPlayAnim(playerPed, "mp_arresting", "a_uncuff", -1.0, -1.0, -1, 0, 1, -1, -1, -1)
                            end)
                            Citizen.Wait(6000)
                            ClearPedTasks(playerPed)
                            SetVehicleDoorsLocked(car, 0)
                            SetPedAsNoLongerNeeded(pedfin)
                            pedfin = nil
                            cpt = choixCar.times[fin.value]*1000
                            currentBlip = AddBlipForCoord(fin.carDestination)
                            showPictureNotificationGF("CHAR_MP_SNITCH",ConfigGoFast.Translation[ConfigGoFast.Language]["Reward"],"Contact",nil)
                            SetBlipAsFriendly(currentBlip, 1)
                            SetBlipColour(currentBlip, 2)
                            SetBlipCategory(currentBlip, 3)
                            SetBlipRoute(currentBlip, true)
                            check = true
                            ThreadTimerGF(cpt)
                            checkpoint = true
                        end
                        Waiter = 2
                    end
                elseif checkpoint and not checkpoint2 then
                    distance = GetDistanceBetweenCoords(playcoords, fin.carDestination, true)
                    if distance < 50 and distance > 2 then
                        Waiter = 7
                        if not DoesEntityExist(pedfin) then
                            pedfin = CreatePed(4, GetHashKey(gang), fin.pedDestination, true, true)
                            GiveWeaponToPed(pedfin, GetHashKey("WEAPON_SMG"), 250, true, true)
                            SetPedDropsWeaponsWhenDead(pedfin, false)
                            SetPedArmour(pedfin, 10000)
                            SetPedAlertness(pedfin, 0)
                            TaskStartScenarioInPlace(pedfin, "WORLD_HUMAN_LEANING", 0, true)
                        end
                        local vehicledel = GetClosestVehicle(fin.carDestination, 10.0, 0, 71)
                        if DoesEntityExist(vehicledel) and del > 11 then
                            DeleteVehicle(vehicledel)
                            del = del + 1
                        end
                        DrawMarker(2, fin.carDestination.x, fin.carDestination.y, fin.carDestination.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                    elseif distance < 2 then
                        Waiter = 2
                        DrawMarker(2, fin.carDestination.x, fin.carDestination.y, fin.carDestination.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                        ESX.ShowHelpNotification(ConfigGoFast.Translation[ConfigGoFast.Language]["StopKey"])
                        if IsControlJustReleased(1, 38) then
                            if GetHashKey(GetVehiclePedIsIn(playerPed,false)) == GetHashKey(car) then
                                battle = true
                            else
                                battle = false
                            end
                            if battle then
                                check = false
                                RemoveBlip(currentBlip)
                                SetVehicleEngineOn(car,false,false,true)
                                if ConfigGoFast.Progressbar then
                                    exports['progressBars']:startUI(5000, ConfigGoFast.Translation[ConfigGoFast.Language]["Validating"])
                                end
                                Citizen.Wait(5000)
                                TaskLeaveVehicle(playerPed, car, 0)
                                SetVehicleDoorsLocked(car, 2)
                                checkpoint2 = true
                            else
                                showPictureNotificationGF("CHAR_MP_SNITCH", ConfigGoFast.Translation[ConfigGoFast.Language]["Angry"],"Contact",nil)
                                TaskCombatPed(pedfin, playerPed, 0, 16)
                                StopGofast()
                            end
                        end
                    else
                        Waiter = 1000
                    end
                elseif checkpoint2 then
                    DrawSubGF(ConfigGoFast.Translation[ConfigGoFast.Language]["GiveKey"],1000)
                    distance = GetDistanceBetweenCoords(playcoords, fin.pedDestination.x,fin.pedDestination.y,fin.pedDestination.z, true)
                    local distancePed = GetEntityCoords(pedfin)
                    if distance > 50 then
                        StopGofast()
                    elseif distance < 50 and distance > 15 then
                        Waiter = 500
                    elseif distance < 15 and distance > 2 then
                        Waiter = 7
                        DrawMarker(2, distancePed.x, distancePed.y, distancePed.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                    elseif distance < 2 then
                        Waiter = 7
                        DrawMarker(2, distancePed.x, distancePed.y, distancePed.z+1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0,128,0, 50, false, true, 2, nil, nil, false)
                        ESX.ShowHelpNotification(ConfigGoFast.Translation[ConfigGoFast.Language]["PressKey"])
                        if IsControlJustReleased(1, 38) then	
                            RemoveBlip(currentBlip)
                            ESX.Streaming.RequestAnimDict("mp_arresting", function()
                                TaskPlayAnim(pedfin, "mp_arresting", "a_uncuff", -1.0, -1.0, -1, 0, 1, -1, -1, -1)
                            end)
                            RequestAmbientAudioBank("GENERIC_HI")
                            PlayAmbientSpeech1(pedfin,"GENERIC_HI","SPEECH_PARAMS_STANDARD")
                            ESX.Streaming.RequestAnimDict("mp_arresting", function()
                                TaskPlayAnim(playerPed, "mp_arresting", "a_uncuff", -1.0, -1.0, -1, 0, 1, -1, -1, -1)
                            end)
                            Citizen.Wait(6000)
                            ClearPedTasks(playerPed)
                            SetPedAsNoLongerNeeded(pedfin)
                            DeleteVehicle(car)
                            TriggerServerEvent(Triggers.Reward)
                            StopGofast()
                        end
                    end 
                end
            end
		Citizen.Wait(Waiter)
		end
	end)
end
function StartOrStopGoFast()
	if JobGofastStarted then
        StopGofast()
    else
        StartGofast()
    end
    ClearCurrentGofast()
end
function StartGofast()
	ShowLoadingPromtGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Start"], 5000, 3)
	JobGofastStarted = true
	StartGofastThread()
end
function StopGofast()
	ShowLoadingPromtGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Stop"], 5000, 3)
	JobGofastStarted = false
    ClearCurrentGofast()
end

function ClearCurrentGofast()
    if DoesEntityExist(car) then 
        DeleteVehicle(car) 
    end
    if DoesBlipExist(currentBlip) then
        RemoveBlip(currentBlip)
    end
    checkpoint,checkpoint2,battle,check,spawned = false,false,false,false,false
    del = 0
    mission,car,gang,fin,pedfin,currentBlip = nil,nil,nil,nil,nil,nil
end

function ShowLoadingPromtGF(msg, time, type)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		BeginTextCommandBusyString("STRING")
		AddTextComponentString(msg)
		EndTextCommandBusyString(type)
		Citizen.Wait(time)

		RemoveLoadingPrompt()
	end)
end
function showPictureNotificationGF(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true)
end
function DrawSubGF(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end
function SetVehicleMaxModsGoFast(vehicle, Livery, color, colorsec, nac, jantes, pc, vitres)
	Livery = (Livery == nil) and 0 or Livery
	if vitres == nil or GetEntityModel(vehicle) == 353883353 then
		vitres = 1
	end
	local props = {
		modArmor        = 4,
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
		modXenon		= true,
		windowTint      = vitres,
		plateIndex      = 1,
		modLivery 		= Livery,
		color1			= color,
		color2 			= colorsec,
		pearlescentColor= nac,
		modFrontWheels  = jantes,
		modFrontBumper  = pc
	}
	ESX.Game.SetVehicleProperties(vehicle, props)
end
function ThreadTimerGF(Secondes)
    local playerPed = PlayerPedId()
    local seconds =  Secondes/1000
    local minutes = ESX.Math.Round(seconds/60)
    local distance = 0
    local Speed = 20 
    seconds = seconds - minutes*60
    if seconds <= 0 then
        seconds = 1 
    end
    TriggerServerEvent('GoFast:sendtopolice', GetVehicleNumberPlateText(car))
    Citizen.CreateThread(function() 
        while check do
            seconds = seconds - 1
            if seconds == 0 then
                seconds = 59
                minutes = minutes - 1
            end
            if minutes == -1 then
                minutes = 0
                seconds = 0
            end
            if minutes == 0 then
                DrawSubGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Time"].."~r~"..seconds.."~s~ \"",1000)
            else
                DrawSubGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Time"]..minutes.."\' "..seconds.." \"",1000)
            end
            if minutes == 0 and seconds == 0 then
                SetVehicleEngineHealth(car, -3800)
                SetVehicleEngineOn(car,false,true,true)
                SetVehicleFuelLevel(car, 4.0)
                while Speed ~= 0 do 
                    Speed = math.ceil(GetEntitySpeed(car)* 3.6)
                    Citizen.Wait(0)
                    DrawSubGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Out"],1000)
                end
                TaskLeaveVehicle(playerPed, car, 0)
                while distance < 30 do 
                    Citizen.Wait(1)
                    DrawSubGF(ConfigGoFast.Translation[ConfigGoFast.Language]["Out2"],1000)
                    distance = GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(car), true)
                end
                Citizen.Wait(2000)
                DeleteVehicle(car)
                StopGofast()
            end
            Citizen.Wait(1000)
        end
    end)
end