ESX = nil

local ConfigPoleDance = {}

ConfigPoleDance['PoleDance'] = { 
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(108.716, -1286.8, 28.56), ['Number'] = '1'},
        {['Position'] = vector3(1002.95, -2533.90, 29.02), ['Number'] = '2'}
    }
}

local Strings = {
    ['Pole_Dance'] = '[~p~E~w~] Dancer',
}

TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)

local FishyDEV = false
local LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

Citizen.CreateThread(function()
    while true do
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 108.71, -1287.10, 28.56, true) < 5 or GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1003.047, -2534.475, 29.02, true) < 5  then
            interval = 1
            if ConfigPoleDance['PoleDance']['Enabled'] then
                for k, v in pairs(ConfigPoleDance['PoleDance']['Locations']) do
                    if #(GetEntityCoords(PlayerPedId()) - v['Position']) <= 1.0 then
                        ESX.ShowFloatingHelpNotification(Strings['Pole_Dance'], v['Position'])
                        if IsControlJustReleased(0, 51) and not FishyDEV then
    					    FishyDEV = true
                            LoadDict('mini@strip_club@pole_dance@pole_dance' .. v['Number'])
                            local scene = NetworkCreateSynchronisedScene(v['Position'], vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                            NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'mini@strip_club@pole_dance@pole_dance' .. v['Number'], 'pd_dance_0' .. v['Number'], 1.5, -4.0, 1, 1, 1148846080, 0)
                            NetworkStartSynchronisedScene(scene)
    					elseif IsControlJustReleased(0, 51) and FishyDEV then
    						FishyDEV = false
    						ClearPedTasksImmediately(PlayerPedId())
                        end
                    end
                end
            end
        else
            interval = 1000
        end
        Citizen.Wait(interval)
    end
end)