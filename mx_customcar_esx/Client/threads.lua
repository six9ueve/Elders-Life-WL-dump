dist_marker = 10000.0
next_marker = nil
next_dist = 1000.0
dist_ped = 4.0
open = false

CreateThread(function()
    -- Create blips in map
    --CreateIcons()

    while true do
        -- if not open then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local shortest_dist = 10000.0
            local blip_found = false
        
            for i, k in pairs(custom_car_blips) do 
                dist_marker = #(pos - k.coords)
                if dist_marker < dist_ped and dist_marker < shortest_dist then
                    next_marker = k
                    next_dist = dist_marker
                    shortest_dist = dist_marker   
                    blip_found = true   
                end
            end

            if not blip_found then
                dist_marker = 10000.0
                next_marker = nil
                next_dist = 1000.0
            end
        if open then
            InvalidateIdleCam()
            InvalidateVehicleIdleCam()
        end
        Wait(2000)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1

        if next_marker ~= nil then
            local dist = next_dist
            if dist < dist_ped and (next_marker.permission == ESX.GetPlayerData().job.name or next_marker.permission == 'admin') then
                if not open then
                    if enable_display_info then
                        DisplayHelpText(texts.display_blip_ingame)
                    end

                    if enable_DrawMarker then
                        DrawMarker(27, next_marker.coords.x, next_marker.coords.y, next_marker.coords.z-0.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 2, "GolfPutting", nil, false)
                    end
                end
            end
        else
            if open then
                TriggerEvent("Mx :: CloseCustomCar")
            end
            sleep = 2000
        end

        if open then
            sleep = 2000
        end
        Wait(sleep)
    end
end)
