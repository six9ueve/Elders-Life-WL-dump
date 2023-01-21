local passengerDriveBy = true

Citizen.CreateThread(function()
    while true do
        interval = 750
        playerPed = PlayerPedId()
        car = GetVehiclePedIsIn(playerPed, false)
        if IsPedInAnyVehicle(playerPed, false) then
            if car then
                interval = 1
                if GetPedInVehicleSeat(car, -1) == playerPed then
                    SetPlayerCanDoDriveBy(PlayerId(), false)
                elseif passengerDriveBy and GetEntitySpeed(car, false) <= 25 then
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                else
                    SetPlayerCanDoDriveBy(PlayerId(), false)
                end
            end
        end
        Wait(interval)
    end
end)