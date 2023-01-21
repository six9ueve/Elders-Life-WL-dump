Cfg_Property.brokesecure1 = function(pK,pV)
    Citizen.CreateThread(function()
        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
            if quantity >= 1 then
                Cfg_Property.encourcabriolagemaison()
                local result = exports['lockpick']:startLockpick()
                if result then
                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvremaisoncambriolage", pV.propertyID)
                    Cfg_Property.inPropertyOwned(pK,pV)
                    Cfg_Property.ServerSide("Elders_log:volemaison", "```"..GetPlayerName(PlayerId()).." vient de cambrioler la propriété numéro "..pV.label.."\n```")
                end                       
            else
                Cfg_Property.Popup("~r~Vous n'avez pas de lockpick !")
            end
        end, 'lockpick')
    end)
end

Cfg_Property.brokesecure2 = function(pK,pV)
    Citizen.CreateThread(function()
        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
            if quantity >= 1 then
                Cfg_Property.encourcabriolagemaison()
                local result = exports['lockpick']:startLockpick()
                if result then
                    Citizen.Wait(1000)
                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                        if quantity >= 1 then
                            local success = exports['howdy-hackminigame']:Begin(3, 5000)
                                if success then
                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvremaisoncambriolage", pV.propertyID)
                                    Cfg_Property.inPropertyOwned(pK,pV)
                                    Cfg_Property.ServerSide("Elders_log:volemaison", "```"..GetPlayerName(PlayerId()).." vient de cambrioler la propriété numéro "..pV.label.."\n```")
                                end                       
                        else
                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                        end
                    end, 'laptop_h')
                end                       
            else
                Cfg_Property.Popup("~r~Vous n'avez pas de lockpick !")
            end
        end, 'lockpick')
    end)
end

Cfg_Property.brokesecure3 = function(pK,pV)
    Citizen.CreateThread(function()
        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
            if quantity >= 1 then
                Cfg_Property.encourcabriolagemaison()
                local result = exports['lockpick']:startLockpick()
                if result then
                    Citizen.Wait(1000)
                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                        if quantity >= 1 then
                            local success = exports['howdy-hackminigame']:Begin(3, 5000)
                                if success then
                                    Citizen.Wait(1000)
                                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                                        if quantity >= 1 then
                                            TriggerEvent("datacrack:start", 5, function(output)
                                                if output == true then
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvremaisoncambriolage", pV.propertyID)
                                                    Cfg_Property.inPropertyOwned(pK,pV)
                                                    Cfg_Property.ServerSide("Elders_log:volemaison", "```"..GetPlayerName(PlayerId()).." vient de cambrioler la propriété numéro "..pV.label.."\n```")
                                                end
                                            end)                       
                                        else
                                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                                        end
                                    end, 'laptop_h')
                                end                       
                        else
                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                        end
                    end, 'laptop_h')
                end                       
            else
                Cfg_Property.Popup("~r~Vous n'avez pas de lockpick !")
            end
        end, 'lockpick')
    end)
end

Cfg_Property.brokesecure4 = function(pK,pV)
    Citizen.CreateThread(function()
        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
            if quantity >= 1 then
                Cfg_Property.encourcabriolagemaison()
                local result = exports['lockpick']:startLockpick()
                if result then
                    Citizen.Wait(1000)
                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                        if quantity >= 1 then
                            local success = exports['howdy-hackminigame']:Begin(3, 5000)
                                if success then
                                    Citizen.Wait(1000)
                                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                                        if quantity >= 1 then
                                            TriggerEvent("datacrack:start", 5, function(output)
                                                if output == true then
                                                    Citizen.Wait(1000)
                                                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetItemVol", function(quantity)
                                                        if quantity >= 1 then
                                                            TriggerEvent('ultra-fingerprint', 3, 120, function(outcome, reason)
                                                                if outcome == 1 then
                                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvremaisoncambriolage", pV.propertyID)
                                                                    Cfg_Property.inPropertyOwned(pK,pV)
                                                                    Cfg_Property.ServerSide("Elders_log:volemaison", "```"..GetPlayerName(PlayerId()).." vient de cambrioler la propriété numéro "..pV.label.."\n```")
                                                                end
                                                            end)
                                                        else
                                                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                                                        end
                                                    end, 'laptop_h')                                                
                                                end
                                            end)                       
                                        else
                                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                                        end
                                    end, 'laptop_h')
                                end                       
                        else
                            Cfg_Property.Popup("~r~Vous n'avez pas d'ordinateur de hacking !")
                        end
                    end, 'laptop_h')
                end                       
            else
                Cfg_Property.Popup("~r~Vous n'avez pas de lockpick !")
            end
        end, 'lockpick')
    end)
end

RegisterNetEvent(Cfg_Property.Prefix..":alertePolice")
AddEventHandler(Cfg_Property.Prefix..":alertePolice", function(coords)
    Cfg_Property.ESXLoaded.ShowAdvancedNotification('Centrale', '~b~Demande d\'intervention', '~b~Info : ~w~Cambriolage de maison\n~b~Individu : ~w~Inconnu\n~b~Localisation : ~s~Zone sur GPS', "CHAR_CALL911", 2)
    local alpha = 250
    local gunshotBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
    SetBlipHighDetail(gunshotBlip, true)
    SetBlipColour(gunshotBlip, 1)
    SetBlipAlpha(gunshotBlip, alpha)
    SetBlipAsShortRange(gunshotBlip, true)
    while alpha ~= 0 do
        Wait(45 * 4)
        alpha = alpha - 1
        SetBlipAlpha(gunshotBlip, alpha)

        if alpha == 0 then
            RemoveBlip(gunshotBlip)
            return
        end
    end
end)

encourcabriolagemaison = false

Cfg_Property.encourcabriolagemaison = function()
    Citizen.CreateThread(function()
        if not encourcabriolagemaison then
            encourcabriolagemaison = true
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed, true)
            Cfg_Property.ServerSide(Cfg_Property.Prefix..":alertepolice", coords)
            Citizen.Wait(60000)
            encourcabriolagemaison = false
        end
    end)
end