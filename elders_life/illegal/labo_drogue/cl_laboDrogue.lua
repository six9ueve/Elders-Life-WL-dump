ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setjob2')
AddEventHandler('god:setjob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

local notificationID = 0
local isNearFarm = false
local isAtFarm = false
local currentFarm = nil
local currentFarmData = nil
local currentPersonaldata = nil
local isAtLeave = false
local isInFarm = false
local isAtComputer = false 
local isAtpreparent = false
local ownedFarms = {}
local isDoingMission = false
local gotFarms = false
local LaboIndex = 1
local underattack = false
local attackvalid = false
local jobonline = 0
local havealready = false


local function GiveCarBack(playerPed)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetEntityAsMissionEntity(vehicle)
    DeleteVehicle(vehicle)
end


RMenu.Add("labo_drogue", "princ", RageUI.CreateMenu("Laboratoire", "~b~Menu:", nil, nil, "aLib", "black"))
RMenu:Get("labo_drogue", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ordi_labo_drogue", "princ", RageUI.CreateMenu("Ordinateur", "~b~Menu:", nil, nil, "aLib", "black"))
RMenu:Get("ordi_labo_drogue", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add('ordi_labo_drogue', 'menu_storage3_ameliorer', RageUI.CreateSubMenu(RMenu:Get('ordi_labo_drogue', 'princ'), "Ordinateur", "~b~Menu:"))

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    gotFarms = false
    TriggerServerEvent('myDrugs:getFarmsFromPlayer')

    while not gotFarms do
        Wait(10)
    end

    ESX.TriggerServerCallback('myDrugs:getLastFarm', function(farmID)
        if farmID ~= nil or farmID ~= 0 then
            for k, ownfarm in pairs(ownedFarms) do
                if ownfarm.id == tonumber(farmID) then
                    for k2, farm in pairs(ConfigLaboDrogue.Farms) do
                        if farm.name == ownfarm.name then
                            currentPersonaldata = ownfarm
                            currentFarmData = farm
                            currentFarm = farm.id
                            loadAppereance()
                            isInFarm = true
                            TriggerServerEvent('myDrugs:setPlayerInvisible', currentPersonaldata.id)
                            break
                        end
                    end
                    break
                end
            end
        end
    end)

end)

RegisterNetEvent('myDrugs:attackvalid')
AddEventHandler('myDrugs:attackvalid', function(laboattacked)
    attackvalid = true
    attacklabo = laboattacked
end)

RegisterNetEvent('myDrugs:attackfalse')
AddEventHandler('myDrugs:attackfalse', function()
    attackvalid = false
    attacklabo = nil
end)

Citizen.CreateThread(function()
	
	if ConfigLaboDrogue.Debug then
		TriggerServerEvent('myDrugs:getFarmsFromPlayer')  -- just for Debug
	end
	
    while true do

        if isNearFarm then
            for k, farm in pairs(ConfigLaboDrogue.Farms) do
                if farm.id == currentFarm then
                    break
                end
            end
        elseif isInFarm then
            DrawMarker(27, currentFarmData.bossActions.x, currentFarmData.bossActions.y, currentFarmData.bossActions.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
            if isAtComputer then
                showInfobar('Appuyer sur ~INPUT_CONTEXT~ pour acceder au Pc')
                if IsControlJustReleased(0, 38) then
                    generateComputer()
                end
            end
            DrawMarker(27, currentFarmData.preparent.x, currentFarmData.preparent.y, currentFarmData.preparent.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
            if isAtpreparent then
                showInfobar('Appuyer sur ~INPUT_CONTEXT~ pour préparer les matières première')
                if IsControlJustReleased(0, 38) then
                    generatePeparent()
                end
            end
        end
        if isAtFarm then
            for k, farm in pairs(ConfigLaboDrogue.Farms) do
                if farm.id == currentFarm then
                    if #ownedFarms > 0 then
                        local hasAtLeastOneFarm = 0
                        for k, owned in pairs(ownedFarms) do
                            if ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'sheriff' then
                                if owned.owner == ESX.PlayerData.identifier and owned.name == farm.name then
                                    hasAtLeastOneFarm = 2
                                    attackk = k
                                end
                                if owned.owner ~= ESX.PlayerData.identifier and owned.name == farm.name then
                                    hasAtLeastOneFarm = 1
                                    attackk = k
                                end
                                if owned.job == ESX.PlayerData.job2.name and owned.name == farm.name then
                                    hasAtLeastOneFarm = 2
                                    attackk = k
                                end
                                if owned.job ~= ESX.PlayerData.job2.name and owned.name == farm.name then
                                    hasAtLeastOneFarm = 1
                                    attackk = k
                                end
                                if owned.perquisition == 1 and owned.name == farm.name then
                                    hasAtLeastOneFarm = 3
                                end
                                if attackvalid and attacklabo == farm.name then
                                    hasAtLeastOneFarm = 2
                                    attackk = k
                                end
                                if k == #ownedFarms then
                                    if hasAtLeastOneFarm == 3 then
                                        showInfobar('Laboratoire perquisitionné')
                                    elseif hasAtLeastOneFarm == 2 and ownedFarms[attackk].attack == 0 then
                                        showInfobar('Appuyez sur ~g~E~s~ pour entrer dans le Labo')
                                    elseif hasAtLeastOneFarm == 2 and ownedFarms[attackk].attack == 1 then
                                        showInfobar('Appuyez sur ~g~E~s~ pour arréter l\'attaque du Labo')
                                    elseif hasAtLeastOneFarm == 1 and ownedFarms[attackk].attack == 0 then
                                        showInfobar('Appuyez sur ~g~E~s~ pour attaquer le labo')
                                    elseif hasAtLeastOneFarm == 1 and ownedFarms[attackk].attack == 1 then
                                        showInfobar('Une attaque est en cours sur le labo appuyez sur ~g~E~s~ pour voir le temps restant')
                                    elseif hasAtLeastOneFarm == 0 then
                                        showInfobar('Appuyez sur ~g~E~s~ pour acheter le labo')
                                    end
                                end
                            else
                                if owned.perquisition == 0 and owned.name == farm.name then
                                    showInfobar('Appuyez sur ~g~E~s~ pour perquisitionner le labo')
                                elseif owned.perquisition == 1 and owned.name == farm.name then
                                    showInfobar('Laboratoire perquisitionné')
                                end
                            end
                        end
                    else
                        showInfobar('Appuyez sur ~g~E~s~ pour acheter le labo')
                    end

                    if IsControlJustReleased(0, 38) then
                        if #ownedFarms > 0 then
                            collectgarbage()
                            local hasAtLeastOneFarm = 0
                            for k, owned in pairs(ownedFarms) do
                                if ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'sheriff' then
                                    if owned.owner == ESX.PlayerData.identifier and owned.name == farm.name then
                                        hasAtLeastOneFarm = 2
                                        fork = k
                                    end
                                    if owned.owner ~= ESX.PlayerData.identifier and owned.name == farm.name then
                                        hasAtLeastOneFarm = 1
                                    end
                                    if owned.job == ESX.PlayerData.job2.name and owned.name == farm.name then
                                        hasAtLeastOneFarm = 2
                                        fork = k
                                    end
                                    if owned.job ~= ESX.PlayerData.job2.name and owned.name == farm.name then
                                        hasAtLeastOneFarm = 1
                                        fork = k
                                    end
                                    if owned.perquisition == 1 and owned.name == farm.name then
                                        hasAtLeastOneFarm = 3
                                    end
                                    if attackvalid and attacklabo == farm.name then
                                        hasAtLeastOneFarm = 2
                                        attackk = k
                                    end
                                    if k == #ownedFarms then
                                        if hasAtLeastOneFarm == 2 then
                                            if ownedFarms[fork].attack == 0 then
                                                local playerPed = PlayerPedId()
                                                currentPersonaldata = ownedFarms[fork]
                                                currentFarmData = farm
                                                loadAppereance()
                                                DoScreenFadeOut(1000)
                                                Citizen.Wait(1000)
                                                SetEntityCoords(playerPed, currentFarmData.inside.x, currentFarmData.inside.y, currentFarmData.inside.z, currentFarmData.inside.rot)
                                                DoScreenFadeIn(1500)
                                                isInFarm = true
                                                TriggerServerEvent('myDrugs:setLastLogin', currentPersonaldata)
                                                TriggerServerEvent('myDrugs:setPlayerInvisible', currentPersonaldata.id)
                                                TriggerServerEvent('myDrugs:saveLastFarm', currentPersonaldata.id)  
                                            else
                                                local progressbartime = 10000
                                                ClearPedTasksImmediately(PlayerPedId())
                                                loadAnimDictATM('anim@gangops@facility@servers@')
                                                TriggerEvent("mythic_progbar:client:progress", {
                                                    name = "hack_gate",
                                                    duration = progressbartime,
                                                    label = "Désamorçage de la bombe",
                                                    useWhileDead = false,
                                                    canCancel = false,
                                                    controlDisables = {
                                                        disableMovement = true,
                                                        disableCarMovement = true,
                                                        disableMouse = false,
                                                        disableCombat = true,
                                                    },
                                                    animation = {
                                                        animDict = "anim@gangops@facility@servers@",
                                                        anim = "hotwire",
                                                    },

                                                }, function(status)
                                                    if not status then
                                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                    end
                                                end)
                                                Citizen.Wait(progressbartime)
                                                TriggerServerEvent('myDrugs:CooldownReset', farm)
                                            end                                      
                                        elseif hasAtLeastOneFarm == 1 and ownedFarms[fork].attack == 0 then
                                            buyFarmMenu(farm, 1, nil, ownedFarms[fork].job)
                                        elseif hasAtLeastOneFarm == 1 and ownedFarms[fork].attack == 1 then
                                            TriggerServerEvent('myDrugs:CooldownNotify')
                                        elseif hasAtLeastOneFarm == 0 then
                                            buyFarmMenu(farm, 0, nil, nil)
                                        end
                                    end
                                else
                                    if owned.name == farm.name and owned.perquisition == 0 then
                                        ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                            if count > 0 then
                                                buyFarmMenu(farm, 2, owned.owner, nil)
                                            else
                                                ESX.ShowNotification("Vous n'avez pas de mandat de perquisition")
                                            end
                                        end, "mandat")
                                    end
                                end
                            end
                        else
                            buyFarmMenu(farm, 0, nil, nil)
                        end
                    break
                end
            end
        end
        elseif isAtLeave then
            showInfobar(Translation[ConfigLaboDrogue.Locale]['leave_farm'])

            if IsControlJustReleased(0, 38) then
                for k2, farmToLeave in pairs(ConfigLaboDrogue.Farms) do
                    if currentFarm == farmToLeave.id then
                        local playerPed = PlayerPedId()
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(playerPed, farmToLeave.enter.x, farmToLeave.enter.y, farmToLeave.enter.z)
                        DoScreenFadeIn(1500)
                        
                        TriggerServerEvent('myDrugs:leaveFarm', currentPersonaldata.id)
                        TriggerServerEvent('myDrugs:saveLastFarm', 0)

                        isInFarm = false
                        currentPersonaldata = nil
                        currentFarmData = nil
                        break
                    end
                end
            end

        end
    Citizen.Wait(0)
    end

end)

function loadAppereance()

    local InteriorId = 247297
    if ConfigLaboDrogue.UseIPLs then

        if currentPersonaldata.type == 'weed_pooch_prepare' then
            Citizen.CreateThread(function()

                BikerWeedFarm = exports['elders_ipl']:GetBikerWeedFarmObject()
                BikerWeedFarm.Plant1.Clear(true)
                BikerWeedFarm.Plant2.Clear(true)
                BikerWeedFarm.Plant3.Clear(true)
                BikerWeedFarm.Plant4.Clear(true)
                BikerWeedFarm.Plant5.Clear(true)
                BikerWeedFarm.Plant6.Clear(true)
                BikerWeedFarm.Plant7.Clear(true)
                BikerWeedFarm.Plant8.Clear(true)
                BikerWeedFarm.Plant9.Clear(true)
                BikerWeedFarm.Details.Enable({ "weed_production" }, false)
                BikerWeedFarm.Details.Enable({ "weed_set_up" }, false, false)
                BikerWeedFarm.Details.Enable({ "weed_drying" }, false)
                BikerWeedFarm.Details.Enable({ "weed_chairs" }, false)

                if currentPersonaldata.upgraded == 1 then
                    BikerWeedFarm.Style.Set("weed_standard_equip", false)
                else
                    BikerWeedFarm.Style.Set("weed_upgrade_equip", false)
                end

                if currentPersonaldata.finish > 10 then
                    BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.full, BikerWeedFarm.Plant1.Light.basic)
                end
                if currentPersonaldata.finish > 20 then
                    BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.full, BikerWeedFarm.Plant2.Light.basic)
                end
                if currentPersonaldata.finish > 30 then
                    BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.full, BikerWeedFarm.Plant3.Light.basic)
                end
                if currentPersonaldata.finish > 40 then
                    BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.full, BikerWeedFarm.Plant4.Light.basic)
                end
                if currentPersonaldata.finish > 50 then
                    BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.full, BikerWeedFarm.Plant5.Light.basic)
                end
                if currentPersonaldata.finish > 60 then
                    BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.full, BikerWeedFarm.Plant6.Light.basic)
                end
                if currentPersonaldata.finish > 70 then
                    BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.full, BikerWeedFarm.Plant7.Light.basic)
                end
                if currentPersonaldata.finish > 80 then
                    BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.full, BikerWeedFarm.Plant8.Light.basic)
                end
                if currentPersonaldata.finish > 90 then
                    BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.full, BikerWeedFarm.Plant9.Light.basic)
                end
                RefreshInterior(BikerWeedFarm.interiorId)
            end)

        elseif currentPersonaldata.type == 'meth_pooch_prepare' then

            Citizen.CreateThread(function()

                BikerMethLab = exports['elders_ipl']:GetBikerMethLabObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerMethLab.Style.Set("meth_lab_basic", true)
                else
                    BikerMethLab.Style.Set("meth_lab_upgrade", true)
                end
                RefreshInterior(BikerMethLab.interiorId)
            end)
        elseif currentPersonaldata.type == 'opium_pooch_prepare' then

        elseif currentPersonaldata.type == 'cocaine_pooch_prepare' then

            Citizen.CreateThread(function()

                local ipl = exports["elders_ipl"]:GetBikerCocaineObject()
                        ipl.Details.Enable({ "coke_cut_01" }, false)
                        ipl.Details.Enable({ "coke_cut_02" }, false)
                        ipl.Details.Enable({ "coke_cut_03" }, false)
                        ipl.Details.Enable({ "coke_cut_04" }, false)
                        ipl.Details.Enable({ "coke_cut_05" }, false)
                        if currentPersonaldata.upgraded == 1 then
                            ipl.Style.Set("equipment_basic", true)
                        elseif currentPersonaldata.upgraded == 2 or currentPersonaldata.upgraded == 3 then
                            ipl.Style.Set("equipment_upgrade", true)
                        end
                        if currentPersonaldata.finish > 20 then
                            ipl.Details.Enable({ "coke_cut_01" }, true)
                        end
                        if currentPersonaldata.finish > 40 then
                            ipl.Details.Enable({ "coke_cut_02" }, true)
                        end
                        if currentPersonaldata.finish > 60 then
                            ipl.Details.Enable({ "coke_cut_03" }, true)
                        end
                        if currentPersonaldata.finish > 80 and currentPersonaldata.upgraded == 2 then
                            ipl.Details.Enable({ "coke_cut_04" }, true)
                        end
                        if currentPersonaldata.finish > 90 and currentPersonaldata.upgraded == 2 then
                            ipl.Details.Enable({ "coke_cut_05" }, true)
                        end
                RefreshInterior(ipl.interiorId)
            end)

        end

    end

end

Citizen.CreateThread(function()

    while true do
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)

        isNearFarm = false
        isAtFarm = false
        isAtLeave = false
        isAtComputer = false
        isAtpreparent = false

        for k, farm in pairs(ConfigLaboDrogue.Farms) do
            local distance = Vdist(playerCoords, farm.enter.x, farm.enter.y, farm.enter.z)
            

            if distance < 5.0 then
                isNearFarm = true
                currentFarm = farm.id
            end
            if distance < 1.0 then
                isAtFarm = true
            end
            if isInFarm then
                local distanceLeave = Vdist(playerCoords, farm.inside.x, farm.inside.y, farm.inside.z)
                local distanceToComputer = Vdist(playerCoords, farm.bossActions.x, farm.bossActions.y, farm.bossActions.z)
                local distanceTopreparent = Vdist(playerCoords, farm.preparent.x, farm.preparent.y, farm.preparent.z)
                if distanceLeave < 2.3 then
                    isAtLeave = true
                elseif distanceToComputer < 1.4 then
                    isAtComputer = true
                elseif distanceTopreparent < 1.4 then
                    isAtpreparent = true
                end
            end

        end

        

    Citizen.Wait(350)
    end

end)



function buyFarmMenu(farmData, attack, ownerjob, attackjob)
    collectgarbage()
    if isMenuOpened then return end
    isMenuOpened = true

    if attackjob ~= nil then
        ESX.TriggerServerCallback('myDrugs:CheckOnline', function(onlinejob)
            jobonline = onlinejob
        end, attackjob)
    end

    Citizen.Wait(300)


    RageUI.Visible(RMenu:Get("labo_drogue", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            if attack == 0 then
                RageUI.IsVisible(RMenu:Get("labo_drogue", "princ"),true,true,true,function()
                    RageUI.Separator(Translation[ConfigLaboDrogue.Locale]['menu_buy_farm'])
                    RageUI.Separator(Translation[ConfigLaboDrogue.Locale]['menu_buy_price']..'~b~'..farmData.price .. '~g~$')
                    if farmData.type == 'weed_pooch_prepare' then
                        if ESX.PlayerData.job2.name ~= 'oneil' and ESX.PlayerData.job2.name ~= 'gitan' and ESX.PlayerData.job2.name ~= 'biker_3'  and ESX.PlayerData.job2.name ~= 'famille_1'and ESX.PlayerData.job2.name ~= 'famille_2' and ESX.PlayerData.job2.name ~= 'biker_2' and ESX.PlayerData.job2.name ~= 'biker_1' and ESX.PlayerData.job2.name ~= 'biker' and ESX.PlayerData.job2.name ~= 'cartel' and ESX.PlayerData.job2.name ~= 'cartel_1' and ESX.PlayerData.job2.name ~= 'cartel_2' and ESX.PlayerData.job2.name ~= 'cartel_3' and ESX.PlayerData.job2.name ~= 'mafia' and ESX.PlayerData.job2.name ~= 'mafia_1' and ESX.PlayerData.job2.name ~= 'mafia_2' and ESX.PlayerData.job2.name ~= 'mafia_3' then
                            RageUI.ButtonWithStyle("Laboratoire Weed", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    TriggerServerEvent('myDrugs:buyFarm', farmData)
                                    RageUI.CloseAll()    
                                    isMenuOpened = false                                       
                                end
                            end)  
                        else
                            RageUI.Separator("~r~Vous ne pouvez pas acheter ce labo...")
                        end
                    elseif farmData.type == 'meth_pooch_prepare' then
                        if ESX.PlayerData.job2.name == 'cartel' or ESX.PlayerData.job2.name == 'cartel_1' or ESX.PlayerData.job2.name == 'cartel_2' or ESX.PlayerData.job2.name == 'cartel_3' or ESX.PlayerData.job2.name == 'mafia' or ESX.PlayerData.job2.name == 'mafia_1' or ESX.PlayerData.job2.name == 'mafia_2' or ESX.PlayerData.job2.name == 'mafia_3' then
                            RageUI.ButtonWithStyle("Laboratoire Meth", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    TriggerServerEvent('myDrugs:buyFarm', farmData)  
                                    RageUI.CloseAll()    
                                    isMenuOpened = false
                                end
                            end) 
                        else
                            RageUI.Separator("~r~Vous ne pouvez pas acheter ce labo...")
                        end
                    elseif farmData.type == 'cocaine_pooch_prepare' then
                        if ESX.PlayerData.job2.name == 'oneil' or ESX.PlayerData.job2.name == 'gitan' or ESX.PlayerData.job2.name == 'biker_3'  or ESX.PlayerData.job2.name == 'famille_1'or ESX.PlayerData.job2.name == 'famille_2' or ESX.PlayerData.job2.name == 'biker_2' or ESX.PlayerData.job2.name == 'biker_1' or ESX.PlayerData.job2.name == 'biker' or ESX.PlayerData.job2.name == 'cartel' or ESX.PlayerData.job2.name == 'cartel_1' or ESX.PlayerData.job2.name == 'cartel_2' or ESX.PlayerData.job2.name == 'cartel_3' or ESX.PlayerData.job2.name == 'mafia' or ESX.PlayerData.job2.name == 'mafia_1' or ESX.PlayerData.job2.name == 'mafia_2' or ESX.PlayerData.job2.name == 'mafia_3' then
                            RageUI.ButtonWithStyle("Achat Laboratoire Cocaine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    TriggerServerEvent('myDrugs:buyFarm', farmData)  
                                    RageUI.CloseAll()    
                                    isMenuOpened = false                                      
                                end
                            end) 
                        else
                            RageUI.Separator("~r~Vous ne pouvez pas acheter ce labo...")
                        end
                    elseif farmData.type == 'opium_pooch_prepare' then
                        if ESX.PlayerData.job2.name ~= 'cartel' and ESX.PlayerData.job2.name ~= 'cartel_1' and ESX.PlayerData.job2.name ~= 'cartel_2' and ESX.PlayerData.job2.name ~= 'cartel_3' and ESX.PlayerData.job2.name ~= 'mafia' and ESX.PlayerData.job2.name ~= 'mafia_1' and ESX.PlayerData.job2.name ~= 'mafia_2' and ESX.PlayerData.job2.name ~= 'mafia_3' then
                            RageUI.ButtonWithStyle("Achat Laboratoire Opium", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    TriggerServerEvent('myDrugs:buyFarm', farmData)  
                                    RageUI.CloseAll()    
                                    isMenuOpened = false                                      
                                end
                            end) 
                        else
                            RageUI.Separator("~r~Vous ne pouvez pas acheter ce labo...")
                        end
                    end
                    end, function()end, 1)
            elseif attack == 1 then
                RageUI.IsVisible(RMenu:Get("labo_drogue", "princ"),true,true,true,function()
                    if jobonline >= 5 then
                        if farmData.type == 'weed_pooch_prepare' then
                            RageUI.ButtonWithStyle("Attaquer le labo de Weed", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            RageUI.CloseAll()    
                                            isMenuOpened = false    
                                            TriggerServerEvent("elderslife:removeInvItems", "atm_explosive", 1)
                                            TaskPlantBomb(PlayerPedId(), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                                            Citizen.Wait(500)
                                            local progressbartime = 10000
                                            ClearPedTasksImmediately(PlayerPedId())
                                            loadAnimDictATM('anim@gangops@facility@servers@')
                                            TriggerEvent("mythic_progbar:client:progress", {
                                                name = "hack_gate",
                                                duration = progressbartime,
                                                label = "Pose de la bombe",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                },
                                                animation = {
                                                    animDict = "anim@gangops@facility@servers@",
                                                    anim = "hotwire",
                                                },

                                            }, function(status)
                                                if not status then
                                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                end
                                            end)
                                            Citizen.Wait(progressbartime)
                                            TriggerServerEvent("myDrugs:CooldownServer", true, farmData, attackjob, ESX.PlayerData.job2.name, jobonline) 
                                        else
                                            ESX.ShowNotification("Vous n'avez pas d'explosif sur vous")
                                        end
                                    end, "atm_explosive")
                                end
                            end)  
                        elseif farmData.type == 'meth_pooch_prepare' then
                            RageUI.ButtonWithStyle("Attaquer le labo de Meth", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            RageUI.CloseAll()    
                                            isMenuOpened = false    
                                            TriggerServerEvent("elderslife:removeInvItems", "atm_explosive", 1)
                                            TaskPlantBomb(PlayerPedId(), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                                            Citizen.Wait(500)
                                            local progressbartime = 10000
                                            ClearPedTasksImmediately(PlayerPedId())
                                            loadAnimDictATM('anim@gangops@facility@servers@')
                                            TriggerEvent("mythic_progbar:client:progress", {
                                                name = "hack_gate",
                                                duration = progressbartime,
                                                label = "Pose de la bombe",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                },
                                                animation = {
                                                    animDict = "anim@gangops@facility@servers@",
                                                    anim = "hotwire",
                                                },

                                            }, function(status)
                                                if not status then
                                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                end
                                            end)
                                            Citizen.Wait(progressbartime)
                                            TriggerServerEvent("myDrugs:CooldownServer", true, farmData, attackjob, ESX.PlayerData.job2.name, jobonline) 
                                        else
                                            ESX.ShowNotification("Vous n'avez pas d'explosif sur vous")
                                        end
                                    end, "atm_explosive")                                  
                                end
                            end) 
                        elseif farmData.type == 'cocaine_pooch_prepare' then
                            RageUI.ButtonWithStyle("Attaquer le labo de Cocaine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            RageUI.CloseAll()    
                                            isMenuOpened = false    
                                            TriggerServerEvent("elderslife:removeInvItems", "atm_explosive", 1)
                                            TaskPlantBomb(PlayerPedId(), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                                            Citizen.Wait(500)
                                            local progressbartime = 10000
                                            ClearPedTasksImmediately(PlayerPedId())
                                            loadAnimDictATM('anim@gangops@facility@servers@')
                                            TriggerEvent("mythic_progbar:client:progress", {
                                                name = "hack_gate",
                                                duration = progressbartime,
                                                label = "Pose de la bombe",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                },
                                                animation = {
                                                    animDict = "anim@gangops@facility@servers@",
                                                    anim = "hotwire",
                                                },

                                            }, function(status)
                                                if not status then
                                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                end
                                            end)
                                            Citizen.Wait(progressbartime)
                                            TriggerServerEvent("myDrugs:CooldownServer", true, farmData, attackjob, ESX.PlayerData.job2.name, jobonline) 
                                        else
                                            ESX.ShowNotification("Vous n'avez pas d'explosif sur vous")
                                        end
                                    end, "atm_explosive")                                  
                                end
                            end)
                        elseif farmData.type == 'opium_pooch_prepare' then
                            RageUI.ButtonWithStyle("Attaquer le labo de Cocaine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            RageUI.CloseAll()    
                                            isMenuOpened = false    
                                            TriggerServerEvent("elderslife:removeInvItems", "atm_explosive", 1)
                                            TaskPlantBomb(PlayerPedId(), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                                            Citizen.Wait(500)
                                            local progressbartime = 10000
                                            ClearPedTasksImmediately(PlayerPedId())
                                            loadAnimDictATM('anim@gangops@facility@servers@')
                                            TriggerEvent("mythic_progbar:client:progress", {
                                                name = "hack_gate",
                                                duration = progressbartime,
                                                label = "Pose de la bombe",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                },
                                                animation = {
                                                    animDict = "anim@gangops@facility@servers@",
                                                    anim = "hotwire",
                                                },

                                            }, function(status)
                                                if not status then
                                                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                end
                                            end)
                                            Citizen.Wait(progressbartime)
                                            TriggerServerEvent("myDrugs:CooldownServer", true, farmData, attackjob, ESX.PlayerData.job2.name, jobonline) 
                                        else
                                            ESX.ShowNotification("Vous n'avez pas d'explosif sur vous")
                                        end
                                    end, "atm_explosive")                                  
                                end
                            end) 
                        end
                    else
                        RageUI.Separator("~r~Pas assez de défenseur en ligne...")
                    end

                    end, function()end, 1)
            elseif attack == 2 then
                RageUI.IsVisible(RMenu:Get("labo_drogue", "princ"),true,true,true,function()
                    if farmData.type == 'weed_pooch_prepare' then
                        RageUI.ButtonWithStyle("Perquisitionner le labo de Weed", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                RageUI.CloseAll()    
                                isMenuOpened = false    
                                TriggerServerEvent("elderslife:removeInvItems", "mandat", 1)
                                TriggerServerEvent('myDrugs:perquisFarm', farmData) 
                                local progressbartime = 10000
                                ClearPedTasksImmediately(PlayerPedId())
                                loadAnimDictATM('anim@gangops@facility@servers@')
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "hack_gate",
                                    duration = progressbartime,
                                    label = "Perquisition du labo en cours",
                                    useWhileDead = false,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                    },

                                }, function(status)
                                    if not status then
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    end
                                end)
                                Citizen.Wait(progressbartime)                        
                            end
                        end)  
                    elseif farmData.type == 'meth_pooch_prepare' then
                        RageUI.ButtonWithStyle("Perquisitionner le labo de Meth", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                RageUI.CloseAll()    
                                isMenuOpened = false    
                                TriggerServerEvent("elderslife:removeInvItems", "mandat", 1)
                                TriggerServerEvent('myDrugs:perquisFarm', farmData) 
                                local progressbartime = 10000
                                ClearPedTasksImmediately(PlayerPedId())
                                loadAnimDictATM('anim@gangops@facility@servers@')
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "hack_gate",
                                    duration = progressbartime,
                                    label = "Perquisition du labo en cours",
                                    useWhileDead = false,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                    },

                                }, function(status)
                                    if not status then
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    end
                                end)
                                Citizen.Wait(progressbartime)  
                            end
                        end) 
                    elseif farmData.type == 'cocaine_pooch_prepare' then
                        RageUI.ButtonWithStyle("Perquisitionner le labo de Cocaine", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                RageUI.CloseAll()    
                                isMenuOpened = false    
                                TriggerServerEvent("elderslife:removeInvItems", "mandat", 1)
                                TriggerServerEvent('myDrugs:perquisFarm', farmData) 
                                local progressbartime = 10000
                                ClearPedTasksImmediately(PlayerPedId())
                                loadAnimDictATM('anim@gangops@facility@servers@')
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "hack_gate",
                                    duration = progressbartime,
                                    label = "Perquisition du labo en cours",
                                    useWhileDead = false,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                    },

                                }, function(status)
                                    if not status then
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    end
                                end)
                                Citizen.Wait(progressbartime)                                     
                            end
                        end)
                    elseif farmData.type == 'opium_pooch_prepare' then
                        RageUI.ButtonWithStyle("Perquisitionner le labo d\'opium", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                RageUI.CloseAll()    
                                isMenuOpened = false    
                                TriggerServerEvent("elderslife:removeInvItems", "mandat", 1)
                                TriggerServerEvent('myDrugs:perquisFarm', farmData) 
                                local progressbartime = 10000
                                ClearPedTasksImmediately(PlayerPedId())
                                loadAnimDictATM('anim@gangops@facility@servers@')
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "hack_gate",
                                    duration = progressbartime,
                                    label = "Perquisition du labo en cours",
                                    useWhileDead = false,
                                    canCancel = false,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                    },

                                }, function(status)
                                    if not status then
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                    end
                                end)
                                Citizen.Wait(progressbartime)                                    
                            end
                        end) 
                    end

                    end, function()end, 1)
            end
            Wait(0)
        end
    end)
end

function generatePeparent()
    if currentFarmData.type == 'weed_pooch_prepare' then
        TriggerServerEvent('myDrugs:weedprocess')
    elseif currentFarmData.type == 'meth_pooch_prepare' then
        TriggerServerEvent('myDrugs:metprocess')
    elseif currentFarmData.type == 'cocaine_pooch_prepare' then
        TriggerServerEvent('myDrugs:cokeprocess')
    elseif currentFarmData.type == 'opium_pooch_prepare' then
        TriggerServerEvent('myDrugs:opiumprocess')
    end
end

function generateComputer()
    --_menuPool:Remove()
    collectgarbage()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ordi_labo_drogue", "princ"), true)

    local level = currentPersonaldata.upgraded
    local storeCapacity = ConfigLaboDrogue.StoreCapacity[level]
    local finishCapacity = ConfigLaboDrogue.FinishCapacity[level]

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("ordi_labo_drogue", "princ"),true,true,true,function()
                RageUI.Separator(Translation[ConfigLaboDrogue.Locale]['menu_computer_level'] .. currentPersonaldata.upgraded)
                RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_computer_produced'], Translation[ConfigLaboDrogue.Locale]['menu_computer_produced_desc'], {RightLabel = currentPersonaldata.finish .. '/' .. finishCapacity}, true,function(a,h,s) --{RightLabel = math.floor(currentPersonaldata.finish / finishCapacity * 100) .. '% / ' .. currentPersonaldata.finish .. 'Kg'}, true,function(a,h,s)               
                    if s then
                        local res_amount = KeyboardInput("atmos", "Retiré :", "", 1000)
                        if tonumber(res_amount) then
                            local quantity = tonumber(res_amount)
                            if quantity <= currentPersonaldata.finish then
                                TriggerServerEvent('myDrugs:giveFinalItem', currentPersonaldata.id, quantity, currentPersonaldata.type)
                            else
                                ShowNotification(Translation[ConfigLaboDrogue.Locale]['menu_computer_notenoughdrugs'])
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_computer_storage'], Translation[ConfigLaboDrogue.Locale]['menu_computer_storage_desc'], {RightLabel = currentPersonaldata.store .. '/' .. storeCapacity}, true,function(a,h,s)               end)--{RightLabel = math.floor(currentPersonaldata.store / storeCapacity * 100) .. '%'}, true,function(a,h,s)               end)
                RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_storage_input'],Translation[ConfigLaboDrogue.Locale]['menu_storage_input_desc'], {RightLabel = "→→→"}, true,function(a,h,s)
                                if s then
                                    local res_amount = KeyboardInput("atmos", 'Combien doit etre stocker?', "", 1000) 
                                    if tonumber(res_amount) then
                                        local quantity = tonumber(res_amount)
                                        TriggerServerEvent('myDrugs:store', currentFarmData.type, currentPersonaldata.id, storeCapacity, quantity)
                                    end
                                end
                        end) 
                RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod'],Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod_desc'], {RightLabel = "→→→"}, true,function()
                        end,RMenu:Get('ordi_labo_drogue','menu_storage3_ameliorer'))
                if currentFarmData.name == attacklabo then
                    if currentFarmData.name == 'PMeth' then
                        if ESX.PlayerData.job2.name == 'cartel' or ESX.PlayerData.job2.name == 'cartel_1' or ESX.PlayerData.job2.name == 'cartel_2' or ESX.PlayerData.job2.name == 'cartel_3' or ESX.PlayerData.job2.name == 'mafia' or ESX.PlayerData.job2.name == 'mafia_1' or ESX.PlayerData.job2.name == 'mafia_2' or ESX.PlayerData.job2.name == 'mafia_3' then
                            RageUI.ButtonWithStyle('Changer la serrure du labo','Changer la serrure pour prendre le labo sous controle', {RightLabel = "~r~" .. currentFarmData.price / 2 .. '$'}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('myDrugs:adoptlabo', currentFarmData, ESX.PlayerData.job2.name, currentFarmData.price / 2) 
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                            end)
                        end
                    end
                    if currentFarmData.name == 'GCoke' then
                        if ESX.PlayerData.job2.name == 'oneil' or ESX.PlayerData.job2.name == 'gitan' or ESX.PlayerData.job2.name == 'biker_3'  or ESX.PlayerData.job2.name == 'famille_1'or ESX.PlayerData.job2.name == 'famille_2' or ESX.PlayerData.job2.name == 'biker_2' or ESX.PlayerData.job2.name == 'biker_1' or ESX.PlayerData.job2.name == 'biker' or ESX.PlayerData.job2.name == 'cartel' or ESX.PlayerData.job2.name == 'cartel_1' or ESX.PlayerData.job2.name == 'cartel_2' or ESX.PlayerData.job2.name == 'cartel_3' or ESX.PlayerData.job2.name == 'mafia' or ESX.PlayerData.job2.name == 'mafia_1' or ESX.PlayerData.job2.name == 'mafia_2' or ESX.PlayerData.job2.name == 'mafia_3' then
                            RageUI.ButtonWithStyle('Changer la serrure du labo','Changer la serrure pour prendre le labo sous controle', {RightLabel = "~r~" .. currentFarmData.price / 2 .. '$'}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('myDrugs:adoptlabo', currentFarmData, ESX.PlayerData.job2.name, currentFarmData.price / 2) 
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                            end)
                        end
                    end
                    if currentFarmData.name == 'GOpium' then
                        if ESX.PlayerData.job2.name ~= 'cartel' and ESX.PlayerData.job2.name ~= 'cartel_1' and ESX.PlayerData.job2.name ~= 'cartel_2' and ESX.PlayerData.job2.name ~= 'cartel_3' and ESX.PlayerData.job2.name ~= 'mafia' and ESX.PlayerData.job2.name ~= 'mafia_1' and ESX.PlayerData.job2.name ~= 'mafia_2' and ESX.PlayerData.job2.name ~= 'mafia_3' then
                            RageUI.ButtonWithStyle('Changer la serrure du labo','Changer la serrure pour prendre le labo sous controle', {RightLabel = "~r~" .. currentFarmData.price / 2 .. '$'}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('myDrugs:adoptlabo', currentFarmData, ESX.PlayerData.job2.name, currentFarmData.price / 2) 
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                            end)
                        end
                    end
                    if currentFarmData.name == 'GWeed' then
                        if ESX.PlayerData.job2.name ~= 'oneil' and ESX.PlayerData.job2.name ~= 'gitan' and ESX.PlayerData.job2.name ~= 'biker_3'  and ESX.PlayerData.job2.name ~= 'famille_1'and ESX.PlayerData.job2.name ~= 'famille_2' and ESX.PlayerData.job2.name ~= 'biker_2' and ESX.PlayerData.job2.name ~= 'biker_1' and ESX.PlayerData.job2.name ~= 'biker' and ESX.PlayerData.job2.name ~= 'cartel' and ESX.PlayerData.job2.name ~= 'cartel_1' and ESX.PlayerData.job2.name ~= 'cartel_2' and ESX.PlayerData.job2.name ~= 'cartel_3' and ESX.PlayerData.job2.name ~= 'mafia' and ESX.PlayerData.job2.name ~= 'mafia_1' and ESX.PlayerData.job2.name ~= 'mafia_2' and ESX.PlayerData.job2.name ~= 'mafia_3' then
                            RageUI.ButtonWithStyle('Changer la serrure du labo','Changer la serrure pour prendre le labo sous controle', {RightLabel = "~r~" .. currentFarmData.price / 2 .. '$'}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('myDrugs:adoptlabo', currentFarmData, ESX.PlayerData.job2.name, currentFarmData.price / 2) 
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end
                            end)
                        end
                    end
                end
                end, function()end, 1)
   

                RageUI.IsVisible(RMenu:Get("ordi_labo_drogue",'menu_storage3_ameliorer'),true,true,true,function()
                    RageUI.Separator(Translation[ConfigLaboDrogue.Locale]['menu_computer_level'] .. currentPersonaldata.upgraded)
                    if currentPersonaldata.upgraded == 1 then
                        RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod_level2'], Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod_level2_desc'], {RightLabel = '~r~' .. (currentFarmData.price / 2) .. '$'}, true,function(a,h,s)
                            if s then 
                                TriggerServerEvent('myDrugs:upgradeFarm', currentPersonaldata.id, 2, (currentFarmData.price / 2))
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end) 
                        RageUI.Separator("~g~Capacité actuelle  :")
                        RageUI.Separator("~b~Capacité de stockage  : "..ConfigLaboDrogue.FinishCapacity[currentPersonaldata.upgraded] .. 'pochons')
                        RageUI.Separator("~b~Vitesse de production  : "..ConfigLaboDrogue.ProduceRate[currentPersonaldata.upgraded] .. 'pochons / h')
                        RageUI.Separator("~g~Capacité après upgrade  : ")
                        RageUI.Separator("~b~Capacité de stockage  : "..ConfigLaboDrogue.FinishCapacity[currentPersonaldata.upgraded + 1] .. 'pochons')
                        RageUI.Separator("~b~Vitesse de production  : "..ConfigLaboDrogue.ProduceRate[currentPersonaldata.upgraded + 1] .. 'pochons / h')

                    elseif currentPersonaldata.upgraded == 2 then
                        RageUI.ButtonWithStyle(Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod_level2'], Translation[ConfigLaboDrogue.Locale]['menu_upgrade_prod_level2_desc'], {RightLabel = '~r~' .. (currentFarmData.price / 2) .. '$'}, true,function(a,h,s)
                            if s then 
                                TriggerServerEvent('myDrugs:upgradeFarm', currentPersonaldata.id, 3, (currentFarmData.price / 2))
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end) 
                        RageUI.Separator("~g~Capacité actuelle  :")
                        RageUI.Separator("~b~Capacité de stockage  : "..ConfigLaboDrogue.FinishCapacity[currentPersonaldata.upgraded] .. 'pochons')
                        RageUI.Separator("~b~Vitesse de production  : "..ConfigLaboDrogue.ProduceRate[currentPersonaldata.upgraded] .. 'pochons / h')
                        RageUI.Separator("~g~Capacité après upgrade  : ")
                        RageUI.Separator("~b~Capacité de stockage  : "..ConfigLaboDrogue.FinishCapacity[currentPersonaldata.upgraded + 1] .. 'pochons')
                        RageUI.Separator("~b~Vitesse de production  : "..ConfigLaboDrogue.ProduceRate[currentPersonaldata.upgraded + 1] .. 'pochons / h')
                    elseif currentPersonaldata.upgraded == 3 then
                        RageUI.Separator("~b~Amélioration Maximum atteinte")
                        RageUI.Separator("~g~Capacité actuelle  :")
                        RageUI.Separator("~b~Capacité de stockage  : "..ConfigLaboDrogue.FinishCapacity[currentPersonaldata.upgraded] .. 'pochons')
                        RageUI.Separator("~b~Vitesse de production  : "..ConfigLaboDrogue.ProduceRate[currentPersonaldata.upgraded] .. 'pochons / h')
                    end
                end, function()end, 1)
            Wait(0)
        end
    end)  
end

RegisterNetEvent('myDrugs:receiveFarms')
AddEventHandler('myDrugs:receiveFarms', function(farmOwnerServer, steamID)

	for k2, farm in pairs(farmOwnerServer) do
		--if farm.owner == steamID then
		
			ownedFarms[#ownedFarms + 1] = farm
		
		--end
		for k3, trusted in pairs(farm.trusted) do
			if trusted.steamID == steamID then
				ownedFarms[#ownedFarms + 1] = farm
			end
		end
	end
    --ownedFarms = farmOwnerServer
    gotFarms = true
    --currentPersonaldata = ownedFarms[1]

end)

RegisterNetEvent('myDrugs:updateFarms')
AddEventHandler('myDrugs:updateFarms', function(line, farmOwnerUpdated)

    for k, v in pairs(ownedFarms) do
        if v.id == farmOwnerUpdated.id then
            ownedFarms[k] = farmOwnerUpdated
            currentPersonaldata = farmOwnerUpdated
        break
        end
    end
end)

RegisterNetEvent('myDrugs:deleteFarm')
AddEventHandler('myDrugs:deleteFarm', function(toDeleteID)

    for k, v in pairs(ownedFarms) do
        if v.id == toDeleteID then
            table.remove(ownedFarms, k)
        break
        end
    end
end)

RegisterNetEvent('myDrugs:explosion')
AddEventHandler('myDrugs:explosion', function(coords)
    AddExplosion(coords.x, coords.y, coords.z, EXPLOSION_STICKYBOMB, 4.0, true, false, 10.0)
end)

RegisterNetEvent('myDrugs:setNewFarmOwned')
AddEventHandler('myDrugs:setNewFarmOwned', function(farmOwnerNew, owner_res)

    --print(farmOwnerNew.id)

    table.insert(ownedFarms, {
        id = farmOwnerNew.id,
        owner = owner_res,
        name = farmOwnerNew.name,
        type = farmOwnerNew.type,
        upgraded = 1,
        vehicle = 1,
        store = 0,
        finish = 0,
        perquisition = 0,
        attack = farmOwnerNew.attack,
        job = farmOwnerNew.job,
        lastlogin = 0,
    })
end)

RegisterNetEvent('myDrugs:msg')
AddEventHandler('myDrugs:msg', function(message)
    ShowNotification(message)

end)

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	return DrawNotification(false, true)
end

local vanishedUser = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if isInFarm then
			for k, user in pairs(vanishedUser) do
				if user ~= playerPed then
					--SetEntityLocallyInvisible(user)
					--SetEntityNoCollisionEntity(playerPed,  user,  true)
					SetEntityLocallyInvisible(user)
                    SetEntityVisible(user, false, 0)
                    SetEntityNoCollisionEntity(playerPed, user, true)
				end

			end
		end

	end

end)

RegisterNetEvent('myDrugs:setPlayerInvisible')
AddEventHandler('myDrugs:setPlayerInvisible', function(playerEnter)

	
	local otherPlayer = GetPlayerFromServerId(playerEnter)
	
	if otherPlayer ~= nil then
		local otherPlayerPed = GetPlayerPed(otherPlayer)
		table.insert(vanishedUser, otherPlayerPed)
	end

end)

RegisterNetEvent('myDrugs:setPlayerVisible')
AddEventHandler('myDrugs:setPlayerVisible', function(playerEnter)


	local otherPlayer = GetPlayerFromServerId(playerEnter)
	local otherPlayerPed = GetPlayerPed(otherPlayer)
	
	for k, vanish in pairs(vanishedUser) do
		if vanish == otherPlayerPed then
			table.remove(vanishedUser, k)
		end
	end

end)
