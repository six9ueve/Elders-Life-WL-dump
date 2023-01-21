--Changement place auto

Citizen.CreateThread(function()
    interval = 750
	while true do
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
                interval = 1 
				if GetIsTaskActive(PlayerPedId(), 165) then
					SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
				end
			end
		end
        Citizen.Wait(interval)
	end
end)
-- MONTER A L'ARRIERE DU VEHICULE

local doors = {
	{"seat_dside_f", -1},
	{"seat_pside_f", 0},
	{"seat_dside_r", 1},
	{"seat_pside_r", 2}
}

local function VehicleInFront(ped)
    local pos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)

    return result
end

Citizen.CreateThread(function()
	while true do
        interval = 750
		local ped = PlayerPedId()
		local running = false
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            interval = 1
            if GetVehiclePedIsIn(ped, false) == 0 then
                if IsControlJustReleased(0, 23) and not running then
                    local vehicle = VehicleInFront(ped)

                    running = true

                    if vehicle ~= nil then
                        local plyCoords = GetEntityCoords(PlayerPedId(), false)
                        local doorDistances = {}

                        for k, door in pairs(doors) do
                            local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
                            local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
                            local distance = #(plyCoords - doorPos)

                            table.insert(doorDistances, distance)
                        end

                        local key, min = 1, doorDistances[1]

                        for k, v in ipairs(doorDistances) do
                            if doorDistances[k] < min then
                                key, min = k, v
                            end
                        end

                        TaskEnterVehicle(ped, vehicle, 0.0, doors[key][2], 1.5, 1, 0)
                    end

                    running = false
                end
            end
        end
        Citizen.Wait(interval)
  	end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/siege1',  'Prendre la place du conducteur', {})
    TriggerEvent('chat:addSuggestion', '/siege2',  'Prendre la place du passager', {})
    TriggerEvent('chat:addSuggestion', '/siege3',  'Prendre la place du passager', {})
    TriggerEvent('chat:addSuggestion', '/siege4',  'Prendre la place du passager', {})
    TriggerEvent('chat:addSuggestion', '/troll',  '[id] [time] [raison]', {})


  end)

RegisterCommand("siege1", function(source, args, user)
    local plyPed = PlayerPedId()
     if IsPedSittingInAnyVehicle(plyPed) then
        local plyVehicle = GetVehiclePedIsIn(plyPed, false)
            CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 
            if CarSpeed <= 40.0 then
                SetPedIntoVehicle(plyPed, plyVehicle, -1)
            end
     end
end)
RegisterCommand("siege2", function(source, args, user)
    local plyPed = PlayerPedId()
     if IsPedSittingInAnyVehicle(plyPed) then
        local plyVehicle = GetVehiclePedIsIn(plyPed, false)
            CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 
            if CarSpeed <= 40.0 then
                SetPedIntoVehicle(plyPed, plyVehicle, 0)
            end
     end
end)
RegisterCommand("siege3", function(source, args, user)
    local plyPed = PlayerPedId()
     if IsPedSittingInAnyVehicle(plyPed) then
        local plyVehicle = GetVehiclePedIsIn(plyPed, false)
            CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 
            if CarSpeed <= 40.0 then
                SetPedIntoVehicle(plyPed, plyVehicle, 1)
            end
     end
end)
RegisterCommand("siege4", function(source, args, user)
    local plyPed = PlayerPedId()
     if IsPedSittingInAnyVehicle(plyPed) then
        local plyVehicle = GetVehiclePedIsIn(plyPed, false)
            CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 
            if CarSpeed <= 40.0 then
                SetPedIntoVehicle(plyPed, plyVehicle, 2)
            end
     end
end)
