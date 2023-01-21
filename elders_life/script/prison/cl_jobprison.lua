local repassageState = false
local pliageState = false
local balayageState = false

local RepassageZone = {
    vector3(1784.12, 2613.52, 50.55),
    vector3(1784.17, 2614.82, 50.55),
    vector3(1784.13, 2616.12, 50.55),
    vector3(1784.09, 2617.60, 50.55)
}

local PliageZone = {
    vector3(1767.35, 2611.31, 50.54),
    vector3(1768.46, 2611.30, 50.54),
    vector3(1769.30, 2611.36, 50.54),
    vector3(1770.55, 2611.36, 50.54),
    vector3(1766.46, 2619.05, 50.54),
    vector3(1767.92, 2619.11, 50.54),
    vector3(1768.93, 2619.11, 50.54),
    vector3(1770.16, 2619.00, 50.54)
}

local NettoyageZone = {
    vector3(1764.44, 2584.00, 44.79),
    vector3(1764.57, 2580.47, 44.79),
    vector3(1762.13, 2580.01, 44.79),
    vector3(1762.23, 2583.46, 44.79),
    vector3(1763.42, 2586.22, 44.79),
    vector3(1762.12, 2598.55, 44.79)
}

local BalayageZone = {
    vector3(1784.308, 2577.831, 45.56),
    vector3(1785.106, 2583.599, 45.56),
    vector3(1777.177, 2584.173, 45.56),
    vector3(1774.084, 2580.552, 45.56),
    vector3(1773.105, 2572.916, 45.56),
    vector3(1784.648, 2573.399, 45.56),
    vector3(1783.893, 2589.325, 45.56),
    vector3(1774.059, 2588.392, 45.56)
}

function OpenMagasin_prison()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("prison", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("prison", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Nourriture ↓')
                    for k, v in pairs(ConfigPrison.nourriture) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                    if amount == nil then
                                        ESX.ShowNotification("Montant Invalide", 'Problème')
                                        return
                                    end
                                    TriggerServerEvent('elders_prison:shop', v.value, v.price , amount)    
                                    RageUI.CloseAll()
                                    isMenuOpened = false                        
                            end
                        end)
                    end                
            end, function()end, 1)
            Wait(0)
        end
    end)
end

function OpenLavage_patate()
    nettoyage = false
    if not nettoyage then
        nettoyage = true
        animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
        TriggerServerEvent('elders_prison:lavage',"lavage")
            Citizen.Wait(12000)
        nettoyage = false
    else
        ESX.ShowNotification("Tu as pas fini de lavé les pommes de terres", 'Problème')
    end
end

function OpenCuisson_patate()
    cuisson = false
    if not cuisson then
        nettoyage = true
        animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
        TriggerServerEvent('elders_prison:lavage',"cuit_patate")
            Citizen.Wait(12000)
        cuisson = false
    else
        ESX.ShowNotification("Tu as pas fini de cuire les pommes de terres", 'Problème')
    end
end

local function NewSelectPos()
    local pos = RepassageZone
    selectRandomPos = pos[math.random(1, #pos)]
    blip = AddBlipForCoord(selectRandomPos)
    SetBlipSprite (blip, 430)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Repassage")
    EndTextCommandSetBlipName(blip)
end

local function StartRepAction()
    local pPed = PlayerPedId()
    ExecuteCommand("e mechanic4")
    Wait(5000)
    ClearPedTasksImmediately(pPed)
    addtache()
    RemoveBlip(blip)
    NewSelectPos()
end

local function NewSelectPos2()
    local pos = PliageZone
    selectRandomPos2 = pos[math.random(1, #pos)]
    blip = AddBlipForCoord(selectRandomPos2)
    SetBlipSprite (blip, 430)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Pliage")
    EndTextCommandSetBlipName(blip)
end

local function StartPliAction()
    local pPed = PlayerPedId()
    local lib, anim = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer'
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(pPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(5000)
        ClearPedTasksImmediately(pPed)
        RemoveBlip(blip)
        addtache()
        NewSelectPos2()
    end)
end

local function NewSelectPos3()
    local pos = NettoyageZone
    selectRandomPos3 = pos[math.random(1, #pos)]
    blip = AddBlipForCoord(selectRandomPos3)
    SetBlipSprite (blip, 430)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Nettoyage")
    EndTextCommandSetBlipName(blip)
end

local function StartNettAction()
    local pPed = PlayerPedId()
    SetEntityCoords(PlayerPedId(), selectRandomPos3, false, false, false, true)
    TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
    Wait(2700)
    ClearPedTasksImmediately(pPed)
    RemoveBlip(blip)
    addtache()
    NewSelectPos3()
end

local function NewSelectPos4()
    local pos = BalayageZone
    selectRandomPos4 = pos[math.random(1, #pos)]
    blip = AddBlipForCoord(selectRandomPos4)
    SetBlipSprite (blip, 430)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Balayage")
    EndTextCommandSetBlipName(blip)
end

local function StartBalayAction()
    local lib, anim = 'move_mop', 'idle_scrub_small_player'
    local pPed = PlayerPedId()
    ESX.Streaming.RequestAnimDict(lib, function()
        balait = CreateObject(GetHashKey("prop_tool_broom"), 0, 0, 0, true, true, true) 
        AttachEntityToEntity(balait, pPed, GetPedBoneIndex(pPed, 10706), 0.1, 0.65, -0.35, 90.0, -90.0, 35.0, true, true, false, true, 1, true)
        TaskPlayAnim(pPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(2700)
        TaskPlayAnim(pPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(2700)
        ClearPedTasksImmediately(pPed)
        DeleteEntity(balait)
        RemoveBlip(blip)
        addtache()
        NewSelectPos4()
    end)
end

local a = 0

function addtache()
    a = a + 1
    if a == 5 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 10 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 20 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 30 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 40 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 50 then 
        TriggerEvent('god:showNotification', '~r~'..a..'~w~/60 Taches ~b~effectuée~s~!')         
    end
    if a == 60 then 
        TriggerEvent('god:showNotification', 'Toutes les taches sont faites, vous pouvez recommencer ou arréter...')
        TriggerServerEvent('elders_prison:FinTache')
        a = 0
    end
end

function OpenRepassage_prison()
    a = 0
    if repassageState then
        ESX.ShowNotification("Tu as déja commencé as repasser", 'Problème')
        return
    end
    repassageState = true
    Citizen.CreateThread(function()
        NewSelectPos()
        while repassageState do 
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed)
            local dist = #(pCoords - selectRandomPos)

            if dist > 2.0 then 
                RageUI.Text({message = "Vous êtes à ~b~"..math.round(dist).."m~s~ de la zone."})
            end

            if dist < 20.0 then
                DrawMarker(22, selectRandomPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                if dist < 2.0 then
                    ESX.ShowHelpNotification("Faites ~INPUT_CONTEXT~ pour ~b~repasser~s~.")
                    if IsControlJustPressed(0, 38) then 
                        StartRepAction()
                    end
                end
            end
            Wait(1)
        end
    end)
end

function StartPliage()
    a = 0
    if pliageState then
        ESX.ShowNotification("Tu as déja commencé as plier", 'Problème')
        return
    end
    pliageState = true
    Citizen.CreateThread(function()
        NewSelectPos2()
        while pliageState do 
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed)
            local dist = #(pCoords - selectRandomPos2)

            if dist > 2.0 then 
                RageUI.Text({message = "Vous êtes à ~b~"..math.round(dist).."m~s~ de la zone."})
            end

            if dist < 20.0 then
                DrawMarker(22, selectRandomPos2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                if dist < 2.0 then
                    ESX.ShowHelpNotification("Faites ~INPUT_CONTEXT~ pour ~b~plier~s~.") 
                    if IsControlJustPressed(0, 38) then 
                        StartPliAction()
                    end
                end
            end
            Wait(1)
        end
    end)
end

function StartNettoyage()
    a = 0
    if nettoyageState then
        ESX.ShowNotification("Tu as déja commencé as néttoyer", 'Problème')
        return
    end
    nettoyageState = true
    Citizen.CreateThread(function()
        NewSelectPos3()
        while nettoyageState do 
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed)
            local dist = #(pCoords - selectRandomPos3)

            if dist > 2.0 then 
                RageUI.Text({message = "Vous êtes à ~b~"..math.round(dist).."m~s~ de la zone."})
            end

            if dist < 20.0 then
                DrawMarker(22, selectRandomPos3.x, selectRandomPos3.y, selectRandomPos3.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                if dist < 2.0 then
                    ESX.ShowHelpNotification("Faites ~INPUT_CONTEXT~ pour ~b~nettoyer~s~ la zone.") 
                    if IsControlJustPressed(0, 38) then 
                        StartNettAction()
                    end
                end
            end
            Wait(1)
        end
    end)
end

function StartBalayage()
    a = 0
    if balayageState then
        ESX.ShowNotification("Tu as déja commencé as balayer", 'Problème')
        return
    end
    balayageState = true 
    Citizen.CreateThread(function()
        NewSelectPos4()
        while balayageState do 
            local pPed = PlayerPedId()
            local pCoords = GetEntityCoords(pPed)
            local dist = #(pCoords - selectRandomPos4)

            if dist > 2.0 then 
                RageUI.Text({message = "Vous êtes à ~b~"..math.round(dist).."m~s~ de la zone."})
            end

            if dist < 20.0 then
                DrawMarker(22, selectRandomPos4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0) 
                if dist < 2.0 then
                    ESX.ShowHelpNotification("Faites ~INPUT_CONTEXT~ pour ~b~balayer~s~ la zone.") 
                    if IsControlJustPressed(0, 38) then 
                        StartBalayAction()
                    end
                end
            end
            Wait(1)
        end
    end)
end

function FinBalayage_prison()
    if balayageState then
        ESX.ShowNotification("Tu as arrété de balayer", 'Problème')
        balayageState = false
        RemoveBlip(blip)
    end
end

function FinNettoyage_prison()
    if nettoyageState then
        ESX.ShowNotification("Tu as arrété de nettoyer", 'Problème')
        nettoyageState = false
        RemoveBlip(blip)
    end
end

function FinPliage_prison()
    if pliageState then
        ESX.ShowNotification("Tu as arrété de plier", 'Problème')
        pliageState = false
        RemoveBlip(blip)
    end
end

function FinRepassage_prison()
    if repassageState then
        ESX.ShowNotification("Tu as arrété de repasser", 'Problème')
        repassageState = false
        RemoveBlip(blip)
    end
end

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = PlayerPedId() ;
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = animObj

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end