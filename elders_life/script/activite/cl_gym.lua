local Keys = {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0
ESX                             = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local Exercises = {
    ["Pompe"] = {
        ["idleDict"] = "amb@world_human_push_ups@male@idle_a",
        ["idleAnim"] = "idle_c",
        ["actionDict"] = "amb@world_human_push_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 1100,
        ["enterDict"] = "amb@world_human_push_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 3050,
        ["exitDict"] = "amb@world_human_push_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3400,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 3,
    },
    ["Abdos"] = {
        ["idleDict"] = "amb@world_human_sit_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@world_human_sit_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@world_human_sit_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@world_human_sit_ups@male@exit",
        ["exitAnim"] = "exit", 
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
    ["Traction"] = {
        ["idleDict"] = "amb@prop_human_muscle_chin_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_muscle_chin_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3000,
        ["enterDict"] = "amb@prop_human_muscle_chin_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 1600,
        ["exitDict"] = "amb@prop_human_muscle_chin_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
}

local Locations = {      -- REMINDER. If you want it to set coords+heading then enter heading, else put nil ( ["h"] )
    {["x"] = -1200.08, ["y"] = -1571.15, ["z"] = 4.6115 - 0.98, ["h"] = 214.37, ["exercise"] = "Traction"},
    {["x"] = -1205.0118408203, ["y"] = -1560.0671386719,["z"] = 4.614236831665 - 0.98, ["h"] = nil, ["exercise"] = "Abdos"},
    {["x"] = -1203.3094482422, ["y"] = -1570.6759033203, ["z"] = 4.6079330444336 - 0.98, ["h"] = nil, ["exercise"] = "Pompe"},
    --{["x"] = -1206.76, ["y"] = -1572.93, ["z"] = 4.61 - 0.98, ["h"] = nil, ["exercise"] = "Pushups"},
    -- ^^ You can add more locations like this
}

local Blips = {
    [1] = {["x"] = -1201.0078125, ["y"] = -1568.3903808594, ["z"] = 4.6110973358154, ["id"] = 311, ["color"] = 49, ["scale"] = 0.7, ["text"] = "Gym"},
}


Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Locations) do
                local pos = Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 20 then
                    sleep = 0
                    if dist <= 3 and not exercising then                         
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[~g~E~s~] " .. pos["exercise"])
                        if IsControlJustPressed(0, Keys["E"]) then
                            startExercise(Exercises[pos["exercise"]], pos)
                            TriggerEvent("god_status:remove", "stress", 10000)
                        end
                    end                       
                else
                Citizen.Wait(2000)	
                end
            end
        Citizen.Wait(sleep)
    end
end)

function startExercise(animInfo, pos)
    local playerPed = PlayerPedId()

    LoadDict(animInfo["idleDict"])
    LoadDict(animInfo["enterDict"])
    LoadDict(animInfo["exitDict"])
    LoadDict(animInfo["actionDict"])

    if pos["h"] ~= nil then
        SetEntityCoords(playerPed, pos["x"], pos["y"], pos["z"])
        SetEntityHeading(playerPed, pos["h"])
    end

    TaskPlayAnim(playerPed, animInfo["enterDict"], animInfo["enterAnim"], 8.0, -8.0, animInfo["enterTime"], 0, 0.0, 0, 0, 0)
    Citizen.Wait(animInfo["enterTime"])

    canExercise = true
    exercising = true

    Citizen.CreateThread(function()
        while exercising do
            Citizen.Wait(8)
            if procent <= 24.99 then
                color = "~r~"
            elseif procent <= 49.99 then
                color = "~o~"
            elseif procent <= 74.99 then
                color = "~b~"
            elseif procent <= 100 then
                color = "~g~"
            end
            DrawText2D(0.505, 0.925, 1.0,1.0,0.33, "Pourcentage: " .. color..procent .. "%", 255, 255, 255, 255)
            DrawText2D(0.505, 0.95, 1.0,1.0,0.33, "Appuyez sur  ~g~[SPACE]~w~ pour t'entrainer", 255, 255, 255, 255)
            DrawText2D(0.505, 0.975, 1.0,1.0,0.33, "Appuyez sur ~r~[DELETE]~w~ pour arreter", 255, 255, 255, 255)
        end
    end)

    Citizen.CreateThread(function()
        while canExercise do
            Citizen.Wait(8)
            local playerCoords = GetEntityCoords(playerPed)
            if procent <= 99 then
                TaskPlayAnim(playerPed, animInfo["idleDict"], animInfo["idleAnim"], 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to train
                    canExercise = false
                    TaskPlayAnim(playerPed, animInfo["actionDict"], animInfo["actionAnim"], 8.0, -8.0, animInfo["actionTime"], 0, 0.0, 0, 0, 0)
                    AddProcent(animInfo["actionProcent"], animInfo["actionProcentTimes"], animInfo["actionTime"] - 70)
                    canExercise = true
                end
                if IsControlJustPressed(0, Keys["DELETE"]) then -- press delete to exit training
                    ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                end
            else
                ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                -- Here u can put a event to update some sort of skill or something.
                -- this is when u finished your exercise
            end
        end
    end)
end

RegisterCommand("footing", function()
    motionProcent = 0
    doingMotion = not doingMotion  

    Citizen.CreateThread(function()
        while doingMotion do
            Citizen.Wait(7) 
            if IsPedSprinting(PlayerPedId()) then
                motionProcent = motionProcent + 9
            elseif IsPedRunning(PlayerPedId()) then
                motionProcent = motionProcent + 6
            elseif IsPedWalking(PlayerPedId()) then
                motionProcent = motionProcent + 3
            end
            
            DrawText2D(0.505, 0.95, 1.0,1.0,0.4, "~b~Pourcentage:~w~ " .. tonumber(string.format("%.1f", motionProcent/1000)) .. "%", 255, 255, 255, 255)
            if motionProcent >= 100000 then
                doingMotion = false
                motionProcent = 0
                ESX.ShowNotification('Tu as fini ta session.', 'Activité')
            end
        end
    end)

    if doingMotion then
        motionTimesDone = motionTimesDone + 1
        if motionTimesDone <= 2 then
            ESX.ShowNotification('Tu as commencé ta session.', 'Activité')
        else
           ESX.ShowNotification('Tu es trop fatigué pour refaire du sport.', 'Activité')
            doingMotion = false
        end
    else
    	ESX.ShowNotification('Tu as arreté ta session.', 'Activité')
    end
end)

function ExitTraining(exitDict, exitAnim, exitTime)
    TaskPlayAnim(PlayerPedId(), exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    Citizen.Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

function AddProcent(amount, amountTimes, time)
    for i=1, amountTimes do
        Citizen.Wait(time/amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
      
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    for i=1, #Blips, 1 do
        local Blip = Blips[i]
        blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
        SetBlipSprite(blip, Blip["id"])
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, Blip["color"])
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Blip["text"])
        EndTextCommandSetBlipName(blip)
    end
end)

function Notify(msg)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end
