CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'qbcore' then
        local SharedObject = promise:new()

        TriggerEvent('rcore_stickers:shared:getSharedObject', function(object)
            SharedObject:resolve(object)
        end)

        local QBCore = Citizen.Await(SharedObject)

        ShowNotification = function(text)
            QBCore.Functions.Notify(text, nil, 5000)
        end
    else
        if Config.Framework and string.len(Config.Framework) ~= 0 then
            if string.strtrim(string.lower(Config.Framework)) ~= 'esx' and string.strtrim(string.lower(Config.Framework)) ~= 'other' then
                print("^1================ WARNING ================^7")
                print("^7Choose your ^2framework^7 in the config!^7")
                print("^1================ WARNING ================^7")
            end
        end
    end
end)