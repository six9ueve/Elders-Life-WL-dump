CreateThread(function()
    if Config.Framework == nil or string.len(Config.Framework) == 0 then
        ShowNotification = function(text)
            BeginTextCommandThefeedPost('STRING')
            AddTextComponentSubstringPlayerName(text)
            EndTextCommandThefeedPostTicker(true, true)
        end

        RegisterNetEvent('rcore_stickers:showNotification')
        AddEventHandler('rcore_stickers:showNotification', ShowNotification)
    end
end)