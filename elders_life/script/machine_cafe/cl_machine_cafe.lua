ESX = nil

local coffeeMachine = {690372739 }
local IsAnimated = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('coffeMachina:Boire')
AddEventHandler('coffeMachina:Boire', function()
        if not IsAnimated then
            local ped = PlayerPedId() 
            local pos = GetEntityCoords(ped)

            for i = 1, #coffeeMachine do
                local machineCoffee = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, coffeeMachine[i], false, false, false)
                local machineCoffeePos = GetEntityCoords(machineCoffee)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, machineCoffeePos.x, machineCoffeePos.y, machineCoffeePos.z, true)

                if dist < 2 then
                    local loc = vector3(machineCoffeePos.x, machineCoffeePos.y, machineCoffeePos.z + 1.0)
                    

                        if not IsAnimated then
                            prop_name = prop_name or 'p_amb_coffeecup_01'
                            IsAnimated = true

                            TriggerEvent('god_status:add', 'thirst', 20000)

                            Citizen.CreateThread(function()
                                local playerPed = PlayerPedId()
                                local x,y,z = table.unpack(GetEntityCoords(playerPed))
                                local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                                local boneIndex = GetPedBoneIndex(playerPed, 18905)
                                AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
                    
                                ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                                    Citizen.Wait(5000)

                                    TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

                                    Citizen.Wait(5000)
                                    IsAnimated = false
                                    ClearPedSecondaryTask(playerPed)
                                    DeleteObject(prop)
                                end)
                            end)
                        end
                end
            end
        end

end)