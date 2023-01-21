ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true
local  MainLootIndex = 1

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("weazel", "princ", RageUI.CreateMenu("Weazel News", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("weazel", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("weazel", "vestiaire", RageUI.CreateMenu("Weazel News", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("weazel", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("weazel", "mixo", RageUI.CreateSubMenu(RMenu:Get("weazel", "princ"), "Weazel News", "~b~Menu job :"))
RMenu:Get("weazel", "mixo").Closed = function()end

RMenu.Add("weazel", "changetenue", RageUI.CreateSubMenu(RMenu:Get("weazel", "vestiaire"), "Weazel News", "~b~Menu job :"))
RMenu:Get("weazel", "changetenue").Closed = function()end

RMenu.Add("weazel", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("weazel", "vestiaire"), "Weazel News", "~b~Menu job :"))
RMenu:Get("weazel", "deletetenue").Closed = function()end

local function openMenuweazelF6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("weazel", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("weazel", "princ"),true,true,true,function()     
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    weazelinteract = true else weazelinteract = false
                end   
                RageUI.ButtonWithStyle("Annonce Ouverture", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('Ouvre:Weazel')
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Fermeture", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('Ferme:Weazel')
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        TriggerServerEvent('Recru:Weazel')
                    end
                end)   
                RageUI.ButtonWithStyle("Annonce Personalisée", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('perso:Weazel', msg)                            
                        end
                    end
                end)        
                RageUI.Separator('~y~↓ Citoyen ↓')
                RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, weazelinteract,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_weazelnews', 'weazel', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                            end
                        end
                    end
                end)
                RageUI.List("Sortir un équipement", {"Caméra", "Micro avec perche", "Micro"},MainLootIndex, nil, {}, true,  function(_,_,s,Index)
                            MainLootIndex = Index
                            if s then
                                if Index == 1 then
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                    ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez sortie une caméra !", 'Weazel News')
                                    Citizen.CreateThread(function()
                                        local fov_max = 70.0
                                        local fov_min = 5.0
                                        local zoomspeed = 10.0
                                        local speed_lr = 8.0
                                        local speed_ud = 8.0
                                        local camera = false
                                        local fov = (fov_max+fov_min)*0.5
                                        RequestModel(GetHashKey("prop_v_cam_01"))
                                        while not HasModelLoaded(GetHashKey("prop_v_cam_01")) do
                                            Citizen.Wait(100)
                                        end
                                        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                                        local camspawned = CreateObject(GetHashKey("prop_v_cam_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
                                        local netid = ObjToNet(camspawned)
                                        SetNetworkIdExistsOnAllMachines(netid, true)
                                        NetworkSetNetworkIdDynamic(netid, true)
                                        SetNetworkIdCanMigrate(netid, false)
                                        AttachEntityToEntity(camspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), "missfinale_c2mcs_1", 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
                                        cam_net = netid
                                        goodCams = true
                                        while goodCams do
                                            Wait(0)
                                            ESX.ShowHelpNotification("- Appuyez sur ~INPUT_CONTEXT~ pour filmer\n- Appuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour tout arrêter")
                                            if IsControlJustPressed(0, 186) then
                                                goodCams = false
                                                newscamera = false
                                                ClearTimecycleModifier()
                                                fov = (fov_max+fov_min)*0.5
                                                RenderScriptCams(false, false, 0, 1, 0)
                                                SetScaleformMovieAsNoLongerNeeded(scaleform)
                                                DestroyCam(cam2, false)
                                                SetNightvision(false)
                                                SetSeethrough(false)
                                                ClearPedSecondaryTask(PlayerPedId())
                                                DetachEntity(NetToObj(cam_net), 1, 1)
                                                DeleteEntity(NetToObj(cam_net))
                                                cam_net = nil
                                                ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez ranger votre équipement !", 'Weazel News')
                                                break
                                            end
                                            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                                                RequestAnimDict("missfinale_c2mcs_1")
                                                Citizen.Wait(100)
                                            end
                                            if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
                                                TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) 
                                                TaskPlayAnim(GetPlayerPed(PlayerId()), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, -1, -1, 50, 0, 0, 0, 0)
                                            end
                                            DisablePlayerFiring(PlayerId(), true)
                                            DisableControlAction(0,25,true)
                                            DisableControlAction(0, 44,  true)
                                            DisableControlAction(0,37,true)
                                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                                            if IsControlJustReleased(1, 38) then
                                                newscamera = true
                                                SetTimecycleModifier("default")
                                                SetTimecycleModifierStrength(0.3)
                                                local scaleform = RequestScaleformMovie("security_camera")
                                                local scaleform2 = RequestScaleformMovie("breaking_news")
                                                while not HasScaleformMovieLoaded(scaleform) do Citizen.Wait(10) end
                                                while not HasScaleformMovieLoaded(scaleform2) do Citizen.Wait(10) end                             
                                                local cam2 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                                                AttachCamToEntity(cam2, PlayerPedId(), 0.0,0.0,1.0, true)
                                                SetCamRot(cam2, 2.0,1.0,GetEntityHeading(PlayerPedId()))
                                                SetCamFov(cam2, fov)
                                                RenderScriptCams(true, false, 0, 1, 0)
                                                PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
                                                PushScaleformMovieFunction(scaleform2, "breaking_news")
                                                PopScaleformMovieFunctionVoid()
                                                while newscamera and not IsEntityDead(PlayerPedId()) and (GetVehiclePedIsIn(PlayerPedId()) == GetVehiclePedIsIn(PlayerPedId())) and true do
                                                    if IsControlJustPressed(1, 177) then
                                                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                                        newscamera = false
                                                    end
                                                    SetEntityRotation(PlayerPedId(), 0, 0, new_z,2, true)
                                                    local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                                                    local rightAxisX = GetDisabledControlNormal(0, 220)
                                                    local rightAxisY = GetDisabledControlNormal(0, 221)
                                                    local rotation = GetCamRot(cam2, 2)
                                                    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
                                                        new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
                                                        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
                                                        SetCamRot(cam2, new_x, 0.0, new_z, 2)
                                                    end
                                                    if not (IsPedSittingInAnyVehicle(PlayerPedId())) then
                                                        if IsControlJustPressed(0,241) then
                                                            fov = math.max(fov - zoomspeed, fov_min)
                                                        end
                                                        if IsControlJustPressed(0,242) then
                                                            fov = math.min(fov + zoomspeed, fov_max)
                                                        end
                                                        local current_fov = GetCamFov(cam2)
                                                        if math.abs(fov-current_fov) < 0.1 then
                                                            fov = current_fov
                                                        end
                                                        SetCamFov(cam2, current_fov + (fov - current_fov)*0.05)
                                                    else
                                                        if IsControlJustPressed(0,17) then
                                                            fov = math.max(fov - zoomspeed, fov_min)
                                                        end
                                                        if IsControlJustPressed(0,16) then
                                                            fov = math.min(fov + zoomspeed, fov_max)
                                                        end
                                                        local current_fov = GetCamFov(cam2)
                                                        if math.abs(fov-current_fov) < 0.1 then
                                                            fov = current_fov
                                                        end
                                                        SetCamFov(cam2, current_fov + (fov - current_fov)*0.05)
                                                    end                                    
                                                    HideHelpTextThisFrame()
                                                    HideHudAndRadarThisFrame()
                                                    HideHudComponentThisFrame(1)
                                                    HideHudComponentThisFrame(2)
                                                    HideHudComponentThisFrame(3)
                                                    HideHudComponentThisFrame(4)
                                                    HideHudComponentThisFrame(6)
                                                    HideHudComponentThisFrame(7)
                                                    HideHudComponentThisFrame(8)
                                                    HideHudComponentThisFrame(9)
                                                    HideHudComponentThisFrame(13)
                                                    HideHudComponentThisFrame(11)
                                                    HideHudComponentThisFrame(12)
                                                    HideHudComponentThisFrame(15)
                                                    HideHudComponentThisFrame(18)
                                                    HideHudComponentThisFrame(19)
                                                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                                                    DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
                                                    SetTextColour(255, 255, 255, 255)
                                                    SetTextFont(8)
                                                    SetTextScale(1.2, 1.2)
                                                    SetTextWrap(0.0, 1.0)
                                                    SetTextCentre(false)
                                                    SetTextDropshadow(0, 0, 0, 0, 255)
                                                    SetTextEdge(1, 0, 0, 0, 205)
                                                    SetTextEntry("STRING")
                                                    AddTextComponentString("BREAKING NEWS")
                                                    DrawText(0.2, 0.85)                                                    
                                                    local camHeading = GetGameplayCamRelativeHeading()
                                                    local camPitch = GetGameplayCamRelativePitch()
                                                    if camPitch < -70.0 then
                                                        camPitch = -70.0
                                                    elseif camPitch > 42.0 then
                                                        camPitch = 42.0
                                                    end
                                                    camPitch = (camPitch + 70.0) / 112.0
                                                    if camHeading < -180.0 then
                                                        camHeading = -180.0
                                                    elseif camHeading > 180.0 then
                                                        camHeading = 180.0
                                                    end
                                                    camHeading = (camHeading + 180.0) / 360.0
                                                    Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Pitch", camPitch)
                                                    Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Heading", camHeading * -1.0 + 1.0)
                                                    Citizen.Wait(10)
                                                end
                                                newscamera = false
                                                ClearTimecycleModifier()
                                                fov = (fov_max+fov_min)*0.5
                                                RenderScriptCams(false, false, 0, 1, 0)
                                                SetScaleformMovieAsNoLongerNeeded(scaleform)
                                                DestroyCam(cam2, false)
                                                SetNightvision(false)
                                                SetSeethrough(false)
                                            end
                                        end
                                    end)
                                elseif Index == 2 then
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                    ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez sortie un micro !", 'Weazel News')
                                    Citizen.CreateThread(function()
                                        RequestModel(GetHashKey("prop_v_bmike_01"))
                                        while not HasModelLoaded(GetHashKey("prop_v_bmike_01")) do
                                            Citizen.Wait(100)
                                        end
                                        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                                        local bmicspawned = CreateObject(GetHashKey("prop_v_bmike_01"), plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)
                                        local netid = ObjToNet(bmicspawned)
                                        SetNetworkIdExistsOnAllMachines(netid, true)
                                        NetworkSetNetworkIdDynamic(netid, true)
                                        SetNetworkIdCanMigrate(netid, false)
                                        AttachEntityToEntity(bmicspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), -0.08, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) 
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), "missfra1", "mcs2_crew_idle_m_boom", 1.0, -1, -1, 50, 0, 0, 0, 0)
                                        bmic_net = netid
                                        holdingBmic = true
                                        while holdingBmic do
                                            Citizen.Wait(0)
                                            while not HasAnimDictLoaded("missfra1") do
                                                RequestAnimDict("missfra1")
                                                Citizen.Wait(100)
                                            end
                                            if not IsEntityPlayingAnim(PlayerPedId(), "missfra1", "mcs2_crew_idle_m_boom", 3) then
                                                TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) 
                                                TaskPlayAnim(GetPlayerPed(PlayerId()), "missfra1", "mcs2_crew_idle_m_boom", 1.0, -1, -1, 50, 0, 0, 0, 0)
                                            end
                                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour ranger votre équipement")
                                            if IsControlJustPressed(0, 186) then
                                                ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez ranger votre équipement !", 'Weazel News')
                                                ClearPedSecondaryTask(PlayerPedId())
                                                DetachEntity(NetToObj(bmic_net), 1, 1)
                                                DeleteEntity(NetToObj(bmic_net))
                                                bmic_net = nil
                                                holdingBmic = false
                                                break
                                            end
                                            DisablePlayerFiring(PlayerId(), true)
                                            DisableControlAction(0,25,true)
                                            DisableControlAction(0, 44,  true)
                                            DisableControlAction(0,37,true)
                                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                                            if (IsPedInAnyVehicle(PlayerPedId(), -1) and GetPedVehicleSeat(PlayerPedId()) == -1) or IsPedCuffed(PlayerPedId()) then
                                                ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez ranger votre équipement !", 'Weazel News')
                                                ClearPedSecondaryTask(PlayerPedId())
                                                DetachEntity(NetToObj(bmic_net), 1, 1)
                                                DeleteEntity(NetToObj(bmic_net))
                                                bmic_net = nil
                                                holdingBmic = false
                                                break
                                            end
                                        end
                                    end)
                                elseif Index == 3 then
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                    ESX.ShowNotification("~b~WEAZEL-NEWS~s~\n- Vous avez sortie un micro avec perche !", 'Weazel News')
                                    Citizen.CreateThread(function()
                                        RequestModel(GetHashKey("p_ing_microphonel_01"))
                                        while not HasModelLoaded(GetHashKey("p_ing_microphonel_01")) do
                                            Citizen.Wait(100)
                                        end
                                        while not HasAnimDictLoaded("missheistdocksprep1hold_cellphone") do
                                            RequestAnimDict("missheistdocksprep1hold_cellphone")
                                            Citizen.Wait(100)
                                        end
                                        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                                        local micspawned = CreateObject(GetHashKey("p_ing_microphonel_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
                                        local netid = ObjToNet(micspawned)
                                        SetNetworkIdExistsOnAllMachines(netid, true)
                                        NetworkSetNetworkIdDynamic(netid, true)
                                        SetNetworkIdCanMigrate(netid, false)
                                        AttachEntityToEntity(micspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
                                        TaskPlayAnim(GetPlayerPed(PlayerId()), "missheistdocksprep1hold_cellphone", "hold_cellphon", 1.0, -1, -1, 50, 0, 0, 0, 0)
                                        mic_net = netid
                                        holdingMic = true
                                        while holdingMic do
                                            Citizen.Wait(0)
                                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour ranger votre équipement")
                                            if IsControlJustPressed(0, 186) then
                                                ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
                                                DetachEntity(NetToObj(mic_net), 1, 1)
                                                DeleteEntity(NetToObj(mic_net))
                                                mic_net = nil
                                                holdingMic = false
                                            end
                                        end
                                    end)
                                end
                            end
                        end)
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuweazelVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("weazel", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("weazel", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("weazel", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("weazel", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("weazel", "changetenue"),true,true,true,function()
                RageUI.Separator('↓ Mes tenues ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerOutfit', function(clothes)
                                        TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                        TriggerEvent('god_skin:setLastSkin', skin)
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('god_skin:save', skin)
                                        end)
                                    end, v.value)
                                end)
                               ESX.ShowNotification("Vous venez de mettre la tenue "..v.label.." !", 'Dressing')
  
                            end
                        end)
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("weazel", "deletetenue"),true,true,true,function()
                RageUI.Separator('↓ Supprimer une tenue ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent('god_eden_clotheshop:removeOutfit', v.value)
                                ESX.ShowNotification("Vous venez de supprimer la tenue "..v.label.."~s~ !", 'Dressing')

                                RageUI.GoBack()
                            end
                        end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(ConfigWeazel.points) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "weazelnews" then
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local pos = v.vestiaire
                if #(plyCoords - pos) < 15 then
                    interval = 1
                    DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                    if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                        if IsControlJustPressed(1,51) then
                            openMenuweazelVestiaire()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('weazelnews', function()
    if ESX.PlayerData.job.name == "weazelnews" then
        openMenuweazelF6()
    end
end)

RegisterKeyMapping('weazelnews', 'Menu Job : weazelnews', 'keyboard', 'F6')