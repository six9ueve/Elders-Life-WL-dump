RegisterNUICallback('VehDoors', function(data, cb)  
    TriggerEvent("Mx :: PortasVehAnimation", tonumber(data.mx.door))
end)

RegisterNetEvent("Mx :: SyncLockVehPortas")
AddEventHandler("Mx :: SyncLockVehPortas", function(net, door_id) 
	if NetworkDoesNetworkIdExist(net) then
        local _idnet = NetToVeh(net)
        if DoesEntityExist(_idnet) then
            local isopen = GetVehicleDoorAngleRatio(_idnet,door_id)
            if isopen == 0.0 then
                SetVehicleDoorOpen(_idnet , door_id)
            else
                SetVehicleDoorShut(_idnet , door_id)
            end
        end
	end
end)

RegisterNetEvent("Mx :: PortasVehAnimation")
AddEventHandler("Mx :: PortasVehAnimation", function(door_id) 
    if DoesEntityExist(vehicle_id) then
        if vehicle_dist < ped_dist_to_vehicle then
            NetworkRequestControlOfEntity(vehicle_id) 
            TriggerServerEvent("Mx :: SyncLockVehPortas", NetworkGetNetworkIdFromEntity(vehicle_id), door_id)
        end
    end
end)