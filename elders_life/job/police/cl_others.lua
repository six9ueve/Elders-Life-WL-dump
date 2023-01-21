ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(100)
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end

local shield = false

RegisterNetEvent("shield:TogglePoliceShield")
AddEventHandler("shield:TogglePoliceShield", function(nombre)
  Citizen.CreateThread(function()
    if not shield then
      if nombre == 1 then
          propName = "prop_jpolice_shield"
      elseif nombre == 2 then
          propName  = "prop_jsheriff_shield"
      elseif nombre == 3 then
          propName = "prop_jswat_shield"
      elseif nombre == 4 then
          propName = "prop_jfib_shield"
      elseif nombre == 5 then
          propName = "prop_jnoose_shield"
      end
      local ped = PlayerPedId() 
      local coords = GetEntityCoords(ped)
      local prop = GetHashKey(propName)

      local dict = "weapons@first_person@aim_rng@generic@light_machine_gun@combat_mg@"
      local name = "wall_block_low"

      while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
        RequestAnimDict(dict)
      end

      RequestModel(prop)
      while not HasModelLoaded(prop) do
        Citizen.Wait(100)
      end

      local attachProps = CreateObject(prop, coords,  true,  false,  false)
      local netid = ObjToNet(attachProps)

      TaskPlayAnim(ped,dict,name,1.0,4.0,-1,49,0,0,0,0)
      AttachEntityToEntity(attachProps,ped,GetPedBoneIndex(ped, 57005),0.21,0.01,0.11,-72.0,85.0,80.0, false, false, false, true, 2, true)

      shield_net = netid
      shield = true
    else
      shield = false
      ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
      SetModelAsNoLongerNeeded(prop)
      SetEntityAsMissionEntity(attachProps, true, false)
      DetachEntity(NetToObj(shield_net), 1, 1)
      DeleteEntity(NetToObj(shield_net))
      shield_net = nil
    end
  end)
end)

local shieldActive = false
local shieldEntity = nil
local hadPistol = false
local propName = nil

local ResultSearch = {}
local OthersMenu = {
    Sit = {
        dict = "creatures@rottweiler@amb@world_dog_sitting@base",
        anims = { 
            base = "base"
        }
    },
    VehicleEnter = {
        dict = "creatures@rottweiler@in_vehicle@van",
        anims = {
            get_in = "get_in"
        }
    },
    DoorIndicies = {
        ["BackL"] = 2,
        ["BackR"] = 3
    },
    DoorBones = {
        ["BackL"] = "door_dside_r",
        ["BackR"] = "door_dside_f"
    },
    DoorSeats = {
        ["BackL"] = "seat_dside_r",
        ["BackR"] = "seat_pside_r"
    },
    EnteredDoor = nil,
    EnteredDoorBone = nil,
    MountedVehicle = nil ,
    Load = 0.0,
    Index = 1,
    IndexTwo = 1,
    BouclierIndex = 1,
}

local function GetClosestVehicleDoor(pos, vehicle)
  local closestBonePos = nil
  local closestDoor = nil
  local closestDistance = nil
  for k, v in pairs(OthersMenu.DoorIndicies) do
    local doorBone = OthersMenu.DoorBones[k]
    local doorBoneIndex = GetEntityBoneIndexByName(vehicle, doorBone)
    local bonePos = GetWorldPositionOfEntityBone(vehicle, doorBoneIndex)
    if bonePos then
        local distance = Vdist2(pos.x, pos.y, pos.z, bonePos.x, bonePos.y, bonePos.z)
            if closestDistance == nil or closestDistance > distance then
                closestBonePos = bonePos
                closestDoor = k
                closestDistance = distance
            end
        end
    end
    return closestBonePos, closestDoor, closestDistance
end

local function OpenOthersMenu()
    RMenu.Add("cops_others_menu", "menu_main", RageUI.CreateMenu("Spécial | K-9", "INTÉRACTIONS", nil,nil, "aLib", "black"))
    RMenu.Add('cops_others_menu', 'search_main', RageUI.CreateSubMenu(RMenu:Get('cops_others_menu', 'menu_main'), "Spécial | K-9", "INTÉRACTIONS"))
    RMenu.Add('cops_others_menu', 'search_load', RageUI.CreateSubMenu(RMenu:Get('cops_others_menu', 'search_main'), "Spécial | K-9", "INTÉRACTIONS"))
    RMenu:Get("cops_others_menu", "menu_main").Closed = function()
        othersmenu = false
    end
    if not othersmenu then
        othersmenu = true
        RageUI.Visible(RMenu:Get('cops_others_menu', 'menu_main'), true)
        Citizen.CreateThread(function()
            while othersmenu do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("cops_others_menu", "menu_main"), true, true, true, function()
                    RageUI.List("Type :",  {"Chien", "Bouclier"}, OthersMenu.IndexTwo, nil, {}, true, function(_,_,s,Index)
                        OthersMenu.IndexTwo = Index
                    end)
                    if OthersMenu.IndexTwo == 1 then
                        if DoesEntityExist(policeDog) then IndexLock = true else IndexLock = false end
                        local player, distance = ESX.Game.GetClosestPlayer()
                        RageUI.ButtonWithStyle("Demande au chien de venir",nil, {RightLabel = "→→"}, not DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if not DoesEntityExist(policeDog) then
                                    RequestModel(GetHashKey("a_c_shepherd"))
                                    while not HasModelLoaded(GetHashKey("a_c_shepherd")) do Wait(0) end
                                    policeDog = CreatePed(4, GetHashKey("a_c_shepherd"), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                                    SetEntityAsMissionEntity(policeDog, true, true)
                                    RageUI.Popup({
                                        message = "~g~Vous avez demander ~s~à votre chien de venir !",
                                    })
                                else
                                    RageUI.Popup({
                                        message = "~r~Vous avez déjà votre chien !",
                                    })
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien de rentrer",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    DeleteEntity(policeDog)
                                    RageUI.Popup({
                                        message = "~g~Vous avez demander ~s~à votre chien de rentrer !",
                                    })
                                else
                                    RageUI.Popup({
                                        message = "~r~Vous n'avez pas de chien !",
                                    })
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien de me suivre",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                        ClearPedTasks(policeDog)
                                        TaskFollowToOffsetOfEntity(policeDog, PlayerPedId(), 0.0, 0.0, 0.0, 5.0, -1, 0.0, true)
                                        RageUI.Popup({message = "~b~Votre chien vous suit !",})
                                    else
                                        RageUI.Popup({message = "~r~Vous n'avez pas de chien à proximité !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien d'arrêter de me suivre",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                        ClearPedTasks(policeDog)
                                        RageUI.Popup({message = "~b~Votre chien vous suit désormais plus !",})
                                    else
                                        RageUI.Popup({message = "~r~Vous n'avez pas de chien à proximité !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.List("Dire au chien d'aboyer", {"Aboyement N°1", "Aboyement N°2", "Aboyement N°3"}, OthersMenu.Index, nil, {}, IndexLock, function(_,_,s,Index)
                            OthersMenu.Index = Index
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if Index == 1 then
                                        ClearPedTasks(policeDog)
                                        RequestAnimDict("creatures@rottweiler@amb@world_dog_barking@idle_a")
                                        while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_barking@idle_a") do Citizen.Wait(0) end
                                        TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a", 8.0, -4.0, -1, 2, -8.0, false, false, false)
                                    elseif Index == 2 then
                                        ClearPedTasks(policeDog)
                                        RequestAnimDict("creatures@rottweiler@amb@world_dog_barking@idle_a")
                                        while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_barking@idle_a") do Citizen.Wait(0) end
                                        TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_b", 8.0, -4.0, -1, 2, -8.0, false, false, false)
                                    elseif Index == 3 then
                                        ClearPedTasks(policeDog)
                                        RequestAnimDict("creatures@rottweiler@amb@world_dog_barking@idle_a")
                                        while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_barking@idle_a") do Citizen.Wait(0) end
                                        TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_c", 8.0, -4.0, -1, 2, -8.0, false, false, false)
                                    end
                                    Citizen.CreateThread(function()
                                        Citizen.Wait(6000)
                                        ClearPedTasks(policeDog)
                                    end)
                                else                               
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Demande au chien de s'assoire",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                        if IsEntityPlayingAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                            ClearPedTasks(policeDog)
                                        else
                                            while not HasAnimDictLoaded("rcmnigel1c") do Wait(0) RequestAnimDict("rcmnigel1c") end
                                            TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                            Wait(2000)
                                            while not HasAnimDictLoaded("creatures@rottweiler@amb@world_dog_sitting@base") do Wait(0) RequestAnimDict("creatures@rottweiler@amb@world_dog_sitting@base") end
                                            TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                                        end
                                    else
                                        RageUI.Popup({message = "~r~Vous n'avez pas de chien à proximité !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Faire une recherche de drogues",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog) and not IsPedDeadOrDying(policeDog) and GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 and distance ~= -1 and distance <= 3.0 and not IsPedInAnyVehicle(GetPlayerPed(player), true), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if not IsPedDeadOrDying(policeDog) then
                                        if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                            local player, distance = ESX.Game.GetClosestPlayer()
                                            if distance ~= -1 then
                                                if distance <= 3.0 then
                                                    if not IsPedInAnyVehicle(GetPlayerPed(player), true) then
                                                        ResultSearch = {}
                                                        ESX.TriggerServerCallback("EldersLifeDog:SearchClosestDrugs", function(Search)
                                                            ResultSearch = Search
                                                        end, GetPlayerServerId(player))
                                                    end
                                                else
                                                    RageUI.Popup({message = "~r~Aucun individu à proximité !",})
                                                end
                                            else
                                                RageUI.Popup({message = "~r~Aucun individu à proximité !",})
                                            end
                                        end
                                    else
                                        RageUI.Popup({message = "~r~Votre chien n'est pas en bonne santé !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end, RMenu:Get("cops_others_menu", "search_load"))
                        RageUI.ButtonWithStyle("Dire au chien d'attaquer",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog) and not IsPedDeadOrDying(policeDog) and GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 and distance ~= -1 and distance <= 3.0 and not IsPedInAnyVehicle(GetPlayerPed(player), true), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if not IsPedDeadOrDying(policeDog) then
                                        if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                            local player, distance = ESX.Game.GetClosestPlayer()
                                            if distance ~= -1 then
                                                if distance <= 3.0 then
                                                    local playerPed = GetPlayerPed(player)
                                                    if not IsPedInCombat(policeDog, playerPed) then
                                                        if not IsPedInAnyVehicle(playerPed, true) then
                                                            TaskCombatPed(policeDog, playerPed, 0, 16)
                                                        end
                                                    else
                                                        ClearPedTasksImmediately(policeDog)
                                                    end
                                                else
                                                    RageUI.Popup({message = "~r~Aucun individu à proximité !",})
                                                end
                                            else
                                                RageUI.Popup({message = "~r~Aucun individu à proximité !",})
                                            end
                                        end
                                    else
                                        RageUI.Popup({message = "~r~Votre chien n'est pas en bonne santé !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien d'arrêter d'attaquer",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog) and IsPedInCombat(policeDog, GetPlayerPed(player)), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if not IsPedDeadOrDying(policeDog) then
                                        ClearPedTasksImmediately(policeDog)
                                    else
                                        RageUI.Popup({message = "~r~Votre chien n'est pas en bonne santé !",})
                                    end
                                else
                                    RageUI.Popup({message = "~r~Vous n'avez pas de chien !",})
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien de monter dans le véhicule",nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(h, a, s)
                            if s then
                                if DoesEntityExist(policeDog) then
                                    if not IsPedDeadOrDying(policeDog) then
                                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                                ClearPedTasks(policeDog)
                                                local fwv = GetEntityForwardVector(GetVehiclePedIsIn(PlayerPedId(), true))
                                                local fvX, fvY = fwv.x * 1.2, fwv.y * 1.2
                                                local playerPos = GetEntityCoords(PlayerPedId())
                                                local pos, door, distance = GetClosestVehicleDoor(playerPos, GetVehiclePedIsIn(PlayerPedId(), true))
                                                local seat = OthersMenu.DoorSeats[door]
                                                local doorIndex = OthersMenu.DoorIndicies[door]
                                                local doorBone = OthersMenu.DoorBones[door]
                                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), true), doorIndex, false, false)
                                                if pos then
                                                    TaskGoToCoordAnyMeans(policeDog, pos.x - fvX, pos.y - fvY, pos.z, 2.0, 0, 0, 786603, 0.25)
                                                else
                                                    local vehiclePos = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), true))
                                                    TaskGoToCoordAnyMeans(policeDog, vehiclePos.x - fvX, vehiclePos.y - fvY, vehiclePos.z, 2.0, 0, 0, 786603, 0.25)
                                                end
                                                Citizen.Wait(1500)
                                                TaskTurnPedToFaceEntity(policeDog, GetVehiclePedIsIn(PlayerPedId(), true), -1)
                                                Citizen.Wait(2000)
                                                local SitAnim = OthersMenu.Sit
                                                local VehicleAnim = OthersMenu.VehicleEnter
                                                RequestAnimDict(SitAnim.dict)
                                                RequestAnimDict(VehicleAnim.dict)
                                                local loadThresh = GetGameTimer() + 5000
                                                while not HasAnimDictLoaded(SitAnim.dict) and not HasAnimDictLoaded(VehicleAnim.dict) do
                                                Citizen.Wait(0)
                                                    if GetGameTimer() > loadThresh then
                                                        return
                                                    end
                                                end
                                                TaskPlayAnim(policeDog, VehicleAnim.dict, VehicleAnim.anims.get_in, 8.0, -4.0, -1, 2, -8.0, false, false, false)
                                                Citizen.Wait(1500)
                                                local vehSeatBone = GetEntityBoneIndexByName(GetVehiclePedIsIn(PlayerPedId(), true), seat)                                     
                                                AttachEntityToEntity(policeDog, GetVehiclePedIsIn(PlayerPedId(), true), vehSeatBone, 0.0, -0.1, 0.4, 0.0, 0.0, 0.0, 0, false, false, true, 0, true)                                     
                                                Citizen.Wait(250)
                                                TaskPlayAnim(policeDog, SitAnim.dict, SitAnim.anims.base, 8.0, -4.0, -1, 2, -8.0, false, false, false)
                                                Citizen.Wait(250)
                                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), true), doorIndex, false)
                                                OthersMenu.EnteredDoor = doorIndex
                                                OthersMenu.EnteredDoorBone = doorBone
                                                OthersMenu.MountedVehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                            else
                                                RageUI.Popup({message = "~r~Vous n'avez pas de chien à proximité !",})
                                            end
                                        else
                                            RageUI.Popup({message = "~r~Vous devez être dans un véhicule !",})
                                        end
                                    end
                                end
                            end
                        end)
                        RageUI.ButtonWithStyle("Dire au chien de sortir du véhicule", nil, {RightLabel = "→→"}, DoesEntityExist(policeDog), function(_,_,s)
                            if s then
                                if OthersMenu.EnteredDoor == nil or OthersMenu.EnteredDoorBone == nil or OthersMenu.MountedVehicle == nil then
                                    RageUI.Popup({message = "~r~Votre chien n'est pas dans un vehicule !",})
                                else
                                    ClearPedTasks(policeDog)
                                    local vehPos = GetEntityCoords(OthersMenu.MountedVehicle)
                                    local offsetPos = GetWorldPositionOfEntityBone(OthersMenu.MountedVehicle, GetEntityBoneIndexByName(OthersMenu.MountedVehicle, OthersMenu.EnteredDoorBone))
                                    SetVehicleDoorOpen(OthersMenu.MountedVehicle, OthersMenu.EnteredDoor, false, false)
                                    Citizen.Wait(1000)
                                    DetachEntity(policeDog, true, true)
                                    SetEntityCoords(policeDog, offsetPos.x, offsetPos.y, offsetPos.z, 0.0, 0.0, 0.0, false)
                                    Citizen.Wait(1000)
                                    SetVehicleDoorShut(OthersMenu.MountedVehicle, OthersMenu.EnteredDoor, false)
                                    OthersMenu.EnteredDoor = nil
                                    OthersMenu.EnteredDoorBone = nil
                                    OthersMenu.MountedVehicle = nil
                                end
                            end
                        end)
                    elseif OthersMenu.IndexTwo == 2 then
                        local Bouclier = {"LSPD", "Sheriff", "Swat", "FBI", "Noose"}
                        RageUI.List("Sortir votre bouclier", Bouclier, OthersMenu.BouclierIndex, nil,{}, not shieldActive, function(_,_,s,Index)
                            OthersMenu.BouclierIndex = Index
                            if s then
                                --EnableShield(Index)
                                TriggerEvent("shield:TogglePoliceShield",Index)
                                shieldActive = true
                            end
                        end)
                        RageUI.ButtonWithStyle("Ranger votre bouclier", nil, {RightLabel = "→→"}, shieldActive, function(_,_,s)
                            if s then
                                TriggerEvent("shield:TogglePoliceShield",Index)
                                shieldActive = false
                                --DisableShield()
                            end
                        end)
                    end
                end)
                RageUI.IsVisible(RMenu:Get("cops_others_menu", "search_load"), true, true, true, function()
                    RageUI.PercentagePanel(OthersMenu.Load or 0.0, "Recherche en cours (~b~" .. math.floor(OthersMenu.Load*100) .. "%~s~)", "", "", function(_, a, Percent)
                        if OthersMenu.Load < 1.0 then
                            OthersMenu.Load = OthersMenu.Load+0.0025
                        else
                            RageUI.GoBack()
                            OthersMenu.Load = 0.0
                        end
                    end)
                end)
                RageUI.IsVisible(RMenu:Get("cops_others_menu", "search_main"), true, true, true, function()

                    if #ResultSearch <= 0 then RageUI.GoBack() RageUI.Popup({message = "~r~Votre chien n'a pas pu faire sa recherche correctement !",}) end
                    RageUI.Separator("↓ ~b~Résultat de la recherche~s~ ↓")
                    for k,v in pairs(ResultSearch) do
                        RageUI.ButtonWithStyle("Stupéfiant : ~b~"..v.label.."~s~ || Nombre : ~r~"..v.count, nil, {}, true, function() end)
                    end
                end)
            end
        end)
    end
end

RegisterCommand("spe", function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'sheriff' then
            OpenOthersMenu()
        else
            ESX.ShowAdvancedNotification("Elders Life", "~b~Information(s)", "Vous n'êtes pas membre de la LSPD/BSCO !", "CHAR_ELDERS", 1)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
    int = 5000
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
        if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            int = 5
            if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
                SetVehicleTyreBurst(veh, 0, true, 1000.0)
                SetVehicleTyreBurst(veh, 1, true, 1000.0)
                SetVehicleTyreBurst(veh, 2, true, 1000.0)
                SetVehicleTyreBurst(veh, 3, true, 1000.0)
                SetVehicleTyreBurst(veh, 4, true, 1000.0)
                SetVehicleTyreBurst(veh, 5, true, 1000.0)
                SetVehicleTyreBurst(veh, 6, true, 1000.0)
                SetVehicleTyreBurst(veh, 7, true, 1000.0)
            end
        end
    Citizen.Wait(int)
    end
end)