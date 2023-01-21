disPlayerNames = 5
keyToToggleIDs = 274

playerDistances = {}
showIDsAboveHead = false

Citizen.CreateThread(function()
    while true do
        for id = 0, 255 do
            if GetPlayerPed(id) ~= PlayerPedId() then
                x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[id] = distance
            end
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        interval = 500
        if IsControlPressed(0, keyToToggleIDs) then
            for id = 0, 255 do 
                if NetworkIsPlayerActive(id) then
                    if GetPlayerPed(id) ~= PlayerPedId() then
                        if (playerDistances[id] < disPlayerNames) then
                            x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 105,155,102)
                            else
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 255,255,255)
                            end
                        end  
                    end
                end
            end
            interval = 0
        end
        Citizen.Wait(interval)
    end
end)

function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end