
local AnimationDuration = -1
local ChosenAnimation = ""
local ChosenDict = ""
local IsInAnimation = false
local MostRecentChosenAnimation = ""
local MostRecentChosenDict = ""
local MovementType = 0
local PlayerGender = "male"
local PlayerHasProp = false
local PlayerProps = {}
local PlayerParticles = {}
local SecondPropEmote = false
local PtfxNotif = false
local PtfxPrompt = false
local PtfxWait = 500
local PtfxNoProp = false

Citizen.CreateThread(function()
  while true do
    if IsInAnimation then
      if IsPedInAnyVehicle(PlayerPedId(), true)  then
        EmoteCancel()
      end

      if IsPedShooting(PlayerPedId()) then
        EmoteCancel()
      end

      if PtfxPrompt then
        if not PtfxNotif then
            SimpleNotify(PtfxInfo)
            PtfxNotif = true
        end
        if IsControlPressed(0, 47) then
          local NetEntityId = nil
          if PtfxNoProp then
            NetEntityId = NetworkGetNetworkIdFromEntity(PlayerPedId())
          else
            NetEntityId = NetworkGetNetworkIdFromEntity(prop)
          end
          TriggerServerEvent("EldersEmotes:SyncPtfx", CurrentEmoteName, NetEntityId)
          Wait(PtfxWait)
        end
      end

      if IsControlPressed(0, 73) and not IsControlPressed(0, 61) and not IsControlPressed(0, 19) then
        EmoteCancel()
      end
    else
      Citizen.Wait(500)
    end
    Citizen.Wait(1)
  end
end)

RegisterNetEvent("EldersEmotes:SyncPtfxcl")
AddEventHandler("EldersEmotes:SyncPtfxcl", function(EmoteName, NetEntityId)
  PtfxSync(EmoteName, NetEntityId)
end)

function PtfxSync(EmoteName, NetEntityId)
  local PtfxName = EmoteName.AnimationOptions.PtfxName
  local Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)

  PtfxThis(EmoteName.AnimationOptions.PtfxAsset)
  local TmpPtfx = StartParticleFxLoopedOnEntityBone(PtfxName, NetworkGetEntityFromNetworkId(NetEntityId), Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
  SetParticleFxLoopedColour(TmpPtfx, 1.0, 1.0, 1.0)
  Wait(EmoteName.AnimationOptions.PtfxWait)
  StopParticleFxLooped(TmpPtfx, false)
end

RegisterCommand('emotebind', function(source, args, raw) EmoteBindStart(source, args, raw) end)

RegisterCommand('OpenEmotesMenu', function() 
    if isDead then 
        return 
    else
        OpenEmotesMenu()
    end
end)


RegisterCommand('EmoteCancel', function() EmoteCancel() end)
RegisterKeyMapping('EmoteCancel', 'Arreter l\'animation', 'keyboard', 'X')

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/e', 'Jouer une animtion de votre choix', {{ name= "Nom de l'animation", help= "nom de l'animation."}})
    TriggerEvent('chat:addSuggestion', '/emotebind', 'Ajouter une animation à une touche', {{ name= "Touche", help= "num4, num5, num6, num7. num8, num9. Numpad entre 4-9 !"}, { name="Nom de l'émote", help="bong,sit ou toute emote valide."}})
end)

RegisterCommand('e', function(source, args, raw) EmoteCommandStart(source, args, raw) end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    DestroyAllProps()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ResetPedMovementClipset(PlayerPedId())
  end
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function PtfxStart()
    if PtfxNoProp then
      PtfxAt = PlayerPedId()
    else
      PtfxAt = prop
    end
    UseParticleFxAssetNextCall(PtfxAsset)
    Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
    SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
    table.insert(PlayerParticles, Ptfx)
end

function PtfxStop()
  for a,b in pairs(PlayerParticles) do
    StopParticleFxLooped(b, false)
    table.remove(PlayerParticles, a)
  end
end

function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    if CurrentWeightCapacitor then
    TriggerServerEvent('god:updateWeight', CurrentWeightCapacitor, false)
    CurrentWeightCapacitor = nil
  end
    PlayerHasProp = false
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    local iter = function () 
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function PtfxThis(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        RequestNamedPtfxAsset(asset)
        Wait(10)
    end
    UseParticleFxAssetNextCall(asset)
end  
  
function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end  

function OnEmotePlay(EmoteName)
    CurrentEmoteName = EmoteName
    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if InVehicle == 1 then
        return
      end
    if not DoesEntityExist(GetPlayerPed(-1)) then
      return false
    end
    ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
    AnimationDuration = -1
    if PlayerHasProp then
      DestroyAllProps()
    end
    if ChosenDict == "Expression" then
      SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
      return
    end
    if ChosenDict == "MaleScenario" or "Scenario" then 
      CheckGender()
      if ChosenDict == "MaleScenario" then if InVehicle then return end
        if PlayerGender == "male" then
          ClearPedTasks(GetPlayerPed(-1))
          TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
          IsInAnimation = true
        end return
      elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
        BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
        ClearPedTasks(GetPlayerPed(-1))
        TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
        IsInAnimation = true
        return
      elseif ChosenDict == "Scenario" then if InVehicle then return end
        ClearPedTasks(GetPlayerPed(-1))
        TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
        IsInAnimation = true
      return end 
    end
    LoadAnim(ChosenDict)
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteLoop then
        MovementType = 1
      if EmoteName.AnimationOptions.EmoteMoving then
        MovementType = 51
    end
    elseif EmoteName.AnimationOptions.EmoteMoving then
      MovementType = 51
    elseif EmoteName.AnimationOptions.EmoteMoving == false then
      MovementType = 0
    elseif EmoteName.AnimationOptions.EmoteStuck then
      MovementType = 50
    end
    else
      MovementType = 0
    end
    if InVehicle == 1 then
      MovementType = 51
    end
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteDuration == nil then 
        EmoteName.AnimationOptions.EmoteDuration = -1
        AttachWait = 0
      else
        AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
        AttachWait = EmoteName.AnimationOptions.EmoteDuration
      end
      if EmoteName.AnimationOptions.PtfxAsset then
        PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
        PtfxName = EmoteName.AnimationOptions.PtfxName
        if EmoteName.AnimationOptions.PtfxNoProp then
          PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
        else
          PtfxNoProp = false
        end
        Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
        PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
        PtfxWait = EmoteName.AnimationOptions.PtfxWait
        PtfxNotif = false
        PtfxPrompt = true
        PtfxThis(PtfxAsset)
      else
        PtfxPrompt = false
      end
    end
    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.Prop then
          PropName = EmoteName.AnimationOptions.Prop
          PropBone = EmoteName.AnimationOptions.PropBone
          PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
          if EmoteName.AnimationOptions.SecondProp then
            SecondPropName = EmoteName.AnimationOptions.SecondProp
            SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
            SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
            SecondPropEmote = true
          else
            SecondPropEmote = false
          end
          Wait(AttachWait)
          AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
          if SecondPropEmote then
            AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
          end
            if EmoteName.AnimationOptions.WeightCapacitor then
              if CurrentWeightCapacitor ~= nil then
                TriggerServerEvent('god:updateWeight', CurrentWeightCapacitor, false)
                CurrentWeightCapacitor = nil
              end

              TriggerServerEvent('god:updateWeight', EmoteName.AnimationOptions.WeightCapacitor, true)
              CurrentWeightCapacitor = EmoteName.AnimationOptions.WeightCapacitor
            end
      end
    end
end

function CheckGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")
    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        PlayerGender = "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
        PlayerGender = "female"
    end
end

local walkdemarche = nil

function WalkMenuStart(name)
    RequestWalking(name)
    SetPedMovementClipset(PlayerPedId(), name, 0.2)
    RemoveAnimSet(name)
    TriggerServerEvent('Elders_demarche:update', name)
    walkdemarche = name
end

local appuictrl = false

RegisterNetEvent('elders_demarche:accroupi')
AddEventHandler('elders_demarche:accroupi', function()
    if not appuictrl then
        appuictrl = true
    else
        appuictrl = false
        WalkMenuStart(walkdemarche)
    end
end)
  
function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end 
end
    
function EmoteCancel()
    if ChosenDict == "MaleScenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
    elseif ChosenDict == "Scenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
    end
    PtfxNotif = false
    PtfxPrompt = false
    if IsInAnimation then
        PtfxStop()
        ClearPedTasks(GetPlayerPed(-1))
        DestroyAllProps()
        IsInAnimation = false
    end
end

function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

function GetPedInFront()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12, plyPed, 7)
    local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
    return ped2
end

function MearbysOnCommand(source, args, raw)
  local NearbysCommand = ""
  for a in pairsByKeys(DP.Shared) do
    NearbysCommand = NearbysCommand .. ""..a..", "
  end
  EmoteChatMessage(NearbysCommand)
  EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
end

function SimpleNotify(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

local isRequestAnim = false
local requestedemote = ''

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end