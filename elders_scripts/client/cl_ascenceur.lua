--[[
    Elevators for FiveM
    By DoJoMan18 (DoJoMan18.com).
    You can change the keys here, if you change them you have to also change them in the notifications on line 78. For more information see: (https://docs.fivem.net/docs/game-references/controls/)
--]]

local key_floor_up = 188 -- ARROW UP
local key_floor_down = 187 -- ARROW DOWN

--[[
The numbers in the elevators array (line 29) should always count up. Do not leave a gap like this:
    [1] = {
        (coords here)
    },
    [4] = {
        (coords here)
    },
    [10] = {
        (coords here)
    },
]]--

local elevators = {
    [1] = {
        {380.53, -15.21, 82.99, "Garage"},
        {417.30, -10.82, 98.64, "Etage"}
    },
    [2] = {
        {331.15, -592.98, 28.90, "Morgue"},
        {331.16, -592.93, 43.28, "RDC"},
        {335.80, -580.08, 48.24, "Bureau"},
        {335.77, -580.05, 74.07, "Toit"}
    },
}

-- Message in left up corner.
local function MessageUpLeftCorner(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


-- Message above radar.
local function MessageAboveRadar(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

Citizen.CreateThread(function()
    -- turn positions into vectors for faster calculations
    local hola = 1000
    for i = 1, #elevators do
        for k,floor in ipairs(elevators[i]) do
            elevators[i][k] = {vector3(floor[1], floor[2], floor[3]), floor[4]}
        end
    end
    while true do
        local PlayerLocation = GetEntityCoords(PlayerPedId())

        for i = 1, #elevators do
            for k,floor in ipairs(elevators[i]) do
                -- New floor
                local Level = floor[1]
                local distance = #(PlayerLocation - Level)
                if distance < 10 then
                    hola = 0
                    if distance < 1.5 then
                        -- Get the total amount of floors
                        local numFloors = #elevators[i]

                        -- Check if there are floors above and below our current floor
                        local floorUp = nil
                        if k < numFloors then
                            floorUp = elevators[i][k + 1]
                        end
                        local floorDown = nil
                        if k > 1 then
                            floorDown = elevators[i][k - 1]
                        end

                        -- Text to show
                        -- Show current floor
                        local message = "Ascenceur (" .. (floor[2] or "Floor " .. k) .. ")"
                        if floorUp then
                            -- Show prompt to go up
                            message = message .. "~n~" .. "~INPUT_FRONTEND_UP~ " .. (floorUp[2] or "Floor " .. k + 1)
                        end
                        if floorDown then
                            -- Show prompt to go down
                            message = message .. "~n~" .. "~INPUT_FRONTEND_DOWN~ " .. (floorDown[2] or "Floor " .. k - 1)
                        end

                        -- Sent information how to use
                        MessageUpLeftCorner(message)

                        if floorUp ~= nil then
                            if IsControlJustReleased(1, key_floor_up) then
                                -- Lets freeze the user so he can't get away..
                                
                                FreezeEntityPosition(PlayerPedId(), true)
                                Citizen.Wait(500)
                                -- Play some sounds the make the elevator extra cool! :D
                                PlaySoundFrontend(-1, "CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);
                                Citizen.Wait(1500)
                                PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
                                Citizen.Wait(500)
                                PlaySoundFrontend(-1, "OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);

                                -- Is elevator a vehicle elevator?
                                if IsPedInAnyVehicle(PlayerPedId(), true) then
                                    -- Lets teleport the user / vehicle and unfreeze the user.
                                    SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), floorUp[1])
                                    FreezeEntityPosition(PlayerPedId(), false)
                                else
                                    -- Lets teleport the user / vehicle and unfreeze the user.
                                    SetEntityCoords(PlayerPedId(), floorUp[1])
                                    FreezeEntityPosition(PlayerPedId(), false)
                                end
                            end
                        end

                        if floorDown ~= nil then
                            if IsControlJustReleased(1, key_floor_down) then
                                -- Lets freeze the user so he can't get away..
                                FreezeEntityPosition(PlayerPedId(), true)
                                Citizen.Wait(500)
                                -- Play some sounds the make the elevator extra cool! :D
                                PlaySoundFrontend(-1, "CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);
                                Citizen.Wait(1500)
                                PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
                                Citizen.Wait(500)
                                PlaySoundFrontend(-1, "OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);

                                -- Is elevator a vehicle elevator?
                                if IsPedInAnyVehicle(PlayerPedId(), true) then
                                    -- Lets teleport the user / vehicle and unfreeze the user.
                                    SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), floorDown[1])
                                    FreezeEntityPosition(PlayerPedId(), false)
                                else
                                    -- Lets teleport the user / vehicle and unfreeze the user.
                                    SetEntityCoords(PlayerPedId(), floorDown[1])
                                    FreezeEntityPosition(PlayerPedId(), false)
                                end
                            end
                        end
                        -- Get to here but you haven't been teleported? You are not close to an elevator ingame.
                    end
                end
            end
            -- New building
        end
    Citizen.Wait(hola)

    end
end)