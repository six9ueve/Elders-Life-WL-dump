Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
unProcessedMoneySheets = unProcessedMoneySheets or 0
moneySheets = moneySheets or 0
cuttedMoney = cuttedMoney or 0
isProducingSheets = false
isCountingMoney = false
producingTime = ConfigWashlab.ProducingTime
countingTime = ConfigWashlab.CountingTime
heure = 0
PlayerData                = {}
local bouton_presse = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()


end)

function heure_IRLWashlab()
    TriggerServerEvent('checkRealTime')
    SetTimeout(60*1000, heure_IRLWashlab)
end

RegisterNetEvent("realtime:event")
AddEventHandler("realtime:event", function(h, m, s)            
heure = h
end)

--[[AddEventHandler('onResourceStart', function(resource)
	isLoggedIn = true
end)]]--

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(playerData)
    isLoggedIn = true
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setJob2')
AddEventHandler('god:setJob2', function(job2)
    PlayerData.job2 = job2
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId() 
        local playerPosition = GetEntityCoords(playerPed)
        local PlayerData = ESX.GetPlayerData()

        
        -- WASH START
    if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.start.x, ConfigWashlab.Locations.washinglab.process.start.y, ConfigWashlab.Locations.washinglab.process.start.z, true) < 50) then
    
        if PlayerData.job2 ~= nil and PlayerData.job2.name == 'cartel' or PlayerData.job2.name == 'cartel_1' or PlayerData.job2.name == 'cartel_2' or PlayerData.job2.name == 'cartel_3' or PlayerData.job2.name == 'mafia' or PlayerData.job2.name == 'mafia_1' or PlayerData.job2.name == 'mafia_2' or PlayerData.job2.name == 'mafia_3' then
                if ConfigWashlab.CloseHourWash < ConfigWashlab.OpenHourWash then
                        if (heure >= ConfigWashlab.OpenHourWash and heure < 24) or (heure <= ConfigWashlab.CloseHourWash -1 and heure > 0) then
                            if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.start.x, ConfigWashlab.Locations.washinglab.process.start.y, ConfigWashlab.Locations.washinglab.process.start.z, true) < 1.5) then
                                DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.start.x, ConfigWashlab.Locations.washinglab.process.start.y, ConfigWashlab.Locations.washinglab.process.start.z+0.15, '~g~E~w~ - charger la machine')
                                if IsControlJustReleased(0, Keys["E"]) and not bouton_presse then
                                    bouton_presse = true
                                    ESX.TriggerServerCallback('god_washlab:callback:getBlackMoneyAmount', function(amount)

                                        if amount >= 2500 and amount <= 50000 then
                                            if unProcessedMoneySheets < 50000 and moneySheets < 50000 then
                                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                                                exports['progressBars']:startUI(ConfigWashlab.WaitingTime, "Chargement de la machine...")
                                                Citizen.Wait(ConfigWashlab.WaitingTime)
                                                unProcessedMoneySheets = unProcessedMoneySheets + amount
                                                TriggerServerEvent('god_washlab:server:removeBlackMoney', amount)
                                                startProducingTimerWashlab(amount)
                                                ClearPedTasksImmediately(playerPed)
                                                Citizen.Wait(500)

                                                bouton_presse = false
                                            else
                                                ESX.ShowAdvancedNotification('EldersLife', 'Blanchiement', 'La machine est complètement chargée...', 'CHAR_ELDERS', 10)
                                                Citizen.Wait(500)
                                                bouton_presse = false
                                            end
                                        else
                                            ESX.ShowAdvancedNotification('EldersLife', 'Blanchiement', 'Cette machine peut contenir 2,5K$ minimum et 50K$ maximum.', 'CHAR_ELDERS', 10)
                                            Citizen.Wait(500)
                                            bouton_presse = false
                                        end
                                    end)
                                end
                            end
                        else        
                                if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.start.x, ConfigWashlab.Locations.washinglab.process.start.y, ConfigWashlab.Locations.washinglab.process.start.z, true) < 2) then
                                DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.start.x, ConfigWashlab.Locations.washinglab.process.start.y, ConfigWashlab.Locations.washinglab.process.start.z, "Machine arreté, redémarre à ~r~" .. ConfigWashlab.OpenHourWash ..":00")
                                end
                        end
                end        

                -- WASH TIMER
                if isProducingSheets and producingTime > 0 then
                    if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.timer.x, ConfigWashlab.Locations.washinglab.process.timer.y, ConfigWashlab.Locations.washinglab.process.timer.z, true) < 2.5) then
                        DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.timer.x, ConfigWashlab.Locations.washinglab.process.timer.y, ConfigWashlab.Locations.washinglab.process.timer.z+0.28, 'Montant: ~g~$' .. unProcessedMoneySheets .. '~w~')
                        DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.timer.x, ConfigWashlab.Locations.washinglab.process.timer.y, ConfigWashlab.Locations.washinglab.process.timer.z+0.15, 'Production: ~y~' .. producingTime .. ' secondes~w~')
                    end
                end

                -- WASH MACHINE OUTPUT
                if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.output.x, ConfigWashlab.Locations.washinglab.process.output.y, ConfigWashlab.Locations.washinglab.process.output.z, true) < 2.5) then
                    DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.output.x, ConfigWashlab.Locations.washinglab.process.output.y, ConfigWashlab.Locations.washinglab.process.output.z+0.15, 'Sortie: ~y~$' .. moneySheets .. '~w~ en planche à billet')
                end

                -- WASH CUTTER
                if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.cutter.x, ConfigWashlab.Locations.washinglab.process.cutter.y, ConfigWashlab.Locations.washinglab.process.cutter.z, true) < 2.5) then
                    DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.cutter.x, ConfigWashlab.Locations.washinglab.process.cutter.y, ConfigWashlab.Locations.washinglab.process.cutter.z+0.25, 'Planches: ~y~' .. moneySheets .. '~w~')
                    DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.cutter.x, ConfigWashlab.Locations.washinglab.process.cutter.y, ConfigWashlab.Locations.washinglab.process.cutter.z+0.15, '~g~E~w~ - Commencer la coupe')
                    if IsControlJustReleased(0, Keys["E"]) then
                        if moneySheets >= 1000 then
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            exports['progressBars']:startUI(ConfigWashlab.WaitingTime, "Découpe...")
                            Citizen.Wait(ConfigWashlab.WaitingTime)
                            moneySheets = moneySheets - 1000
                            cuttedMoney = cuttedMoney + 1000
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowAdvancedNotification('EldersLife', 'Blanchiement', 'Il n\'y a pas assez de feuilles...', 'CHAR_ELDERS', 10)
                        end 
                    end
                end

                -- WASH COUNTER
                if (GetDistanceBetweenCoords(playerPosition, ConfigWashlab.Locations.washinglab.process.counter.x, ConfigWashlab.Locations.washinglab.process.counter.y, ConfigWashlab.Locations.washinglab.process.counter.z, true) < 2.5) then
                    DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.counter.x, ConfigWashlab.Locations.washinglab.process.counter.y, ConfigWashlab.Locations.washinglab.process.counter.z+0.25, 'Montant coupé: ~y~$' .. cuttedMoney .. '~w~')
                    if isCountingMoney and countingTime > 0 then
                        DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.counter.x, ConfigWashlab.Locations.washinglab.process.counter.y, ConfigWashlab.Locations.washinglab.process.counter.z+0.15, 'Processus de comptage: ~y~' .. countingTime .. ' secondes~w~')
                    else
                        DrawText3DWashlab(ConfigWashlab.Locations.washinglab.process.counter.x, ConfigWashlab.Locations.washinglab.process.counter.y, ConfigWashlab.Locations.washinglab.process.counter.z+0.15, '~g~E~w~ - Compter les billets')
                    end
                    if IsControlJustReleased(0, Keys["E"]) then
                        if cuttedMoney > 0 then
                            if not isCountingMoney then
                                startCountingTimerWashlab(cuttedMoney)                           
                                unProcessedMoneySheets = unProcessedMoneySheets - 50000
                            else
                                ESX.ShowAdvancedNotification('EldersLife', 'Blanchiement', 'Essai pas de m\'arnaqué sur le temps enculé...', 'CHAR_ELDERS', 10)
                            end
                        else
                            ESX.ShowAdvancedNotification('EldersLife', 'Blanchiement', 'Il n\'y a plus d\'argent à compter...', 'CHAR_ELDERS', 10)
                        end
                    end
                end
            end
        else
        Citizen.Wait(500)
        end
    end
end)

startProducingTimerWashlab = function(amount)
    isProducingSheets = true
    Citizen.CreateThread(function()
        while isProducingSheets do
            producingTime = producingTime - 1
            if producingTime <= 0 then
                moneySheets = moneySheets + amount
                isProducingSheets = false
                producingTime = producingTime + ConfigWashlab.ProducingTime
            end
            Citizen.Wait(1000)
        end
    end)
end

startCountingTimerWashlab = function(amount)
    isCountingMoney = true
    Citizen.CreateThread(function()
        while isCountingMoney do
            countingTime = countingTime - 1
            if countingTime <= 0 then
                cuttedMoney = cuttedMoney - amount
                TriggerServerEvent('god_washlab:server:giveCleanMoney', amount)
                TriggerServerEvent('LOG_BLANCHIEMENT', amount*0.83)
                isCountingMoney = false
                countingTime = countingTime + ConfigWashlab.CountingTime
            end
            Citizen.Wait(1000)
        end
    end)
end

DrawText3DWashlab = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

heure_IRLWashlab()