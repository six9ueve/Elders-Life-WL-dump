CurrentWeather = ConfigVsyncR.StartWeather
local lastWeather = CurrentWeather
local baseTime = ConfigVsyncR.BaseTime
local timeOffset = ConfigVsyncR.TimeOffset
local timer = 0
local freezeTime = ConfigVsyncR.FreezeTime
local blackout = ConfigVsyncR.Blackout

RegisterNetEvent('Elders_SyncTime:updateWeather')
AddEventHandler('Elders_SyncTime:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        SetBlackout(blackout)
        SetArtificialLightsState(blackout)
        SetArtificialLightsStateAffectsVehicles(false)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
        Citizen.Wait(750) -- Wait 0 seconds to prevent crashing.
    end
end)

RegisterNetEvent('Elders_SyncTime:updateTime')
AddEventHandler('Elders_SyncTime:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(50)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Elders_SyncTime:requestSync')
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('Elders_SyncTime:notify')
AddEventHandler('Elders_SyncTime:notify', function(message, blink)
    ShowNotification(message, blink)
end)
