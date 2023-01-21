local PlayerData              = {}
ESX                           = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end

  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
  PlayerData.job = job
end)

local nbItem = 0

local coef = 0.2

local isInJobLiv = false
livr = 0
local isToHouse = false
local isToLiv = false
local paie = 0

local pourboire = 0
local posibilite = 0
local px = 0
local py = 0
local pz = 0

function giveposliv()
  livr = math.random(1, 65)

  px = ConfigLivraison.livpt[livr].x
  py = ConfigLivraison.livpt[livr].y
  pz = ConfigLivraison.livpt[livr].z
  return {x = px, y = py, z = pz}
end

Citizen.CreateThread(function()
  while true do

    interval = 750
    for k, v in pairs(ConfigLivraison.Configjob.job) do
      if PlayerData.job and PlayerData.job.name == v.jobname then  
        interval = 5
          if isInJobLiv == false then
                DrawMarker(1,v.location, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)
            
                if GetDistanceBetweenCoords(v.location, GetEntityCoords(PlayerPedId() ,true)) < 1.5 then
                    HelpTextliv("Appuyez sur ~INPUT_CONTEXT~ pour lancer les livraisons",0,1,0.5,0.8,0.6,255,255,255,255)
                    if IsControlJustPressed(1,38) then
                        notif = true
                        isInJobLiv = true
                        isToHouse = true

                        while true do
                          thepos = giveposliv()
                          px = thepos.x
                          py = thepos.y
                          pz = thepos.z
                          distance = ESX.Math.Round((GetDistanceBetweenCoords(v.location, px,py,pz)))
                          if distance < 2000 then
                            break
                          end
                        end

                        paie = distance * coef / 4

                        goliv(livr)
                        donneliv = false
                        
                    end
                  end
          end

          if isToHouse == true then

            while notif == true do
              ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Direction : client pour la livraison !', 'CHAR_ELDERS', 10)

              notif = false

              i = 1
            end

            if donneliv == false then
              nbItem = math.random(1, 3)
              --TriggerServerEvent("elders_livraison:itemadd", nbItem)
              ESX.ShowAdvancedNotification('EldersLife', 'Livraison', "Vous avez "..nbItem.." livraison(s) à faire !", 'CHAR_ELDERS', 10)
              donneliv = true
            end

            DrawMarker(1,px,py,pz, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(PlayerPedId() ,true)) < 1.5 then
              HelpTextliv("Appuyez sur ~INPUT_CONTEXT~ pour livrer",0,1,0.5,0.8,0.6,255,255,255,255)

              if IsControlJustPressed(1,38) then

                notif2 = true
                posibilite = math.random(1, 100)
                alivre = true

                --TriggerServerEvent("elders_livraison:itemrm")
                nbItem = nbItem - 1

                if (posibilite > 1) and (posibilite < 90) then

                  pourboire = math.random(15, 25)
                  ESX.ShowAdvancedNotification('EldersLife', 'Livraison', "Un petit pourboire : " .. pourboire .. "$", 'CHAR_ELDERS', 10)
                  TriggerServerEvent("elders_livraison:pourboire", pourboire)

                end

                RemoveBlip(liv)
                Wait(250)
                if nbItem == 0 then
                  isToHouse = false
                  isToLiv = true
                else
                  ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Livraison réussi : La livraison suivante est prete...', 'CHAR_ELDERS', 10)
                  isToHouse = true
                  isToLiv = false
                  while true do
                    thepos = giveposliv()
                    px = thepos.x
                    py = thepos.y
                    pz = thepos.z
                    distance = ESX.Math.Round((GetDistanceBetweenCoords(v.location, px,py,pz)))
                    if distance < 2000 then
                      break
                    end
                  end
                  paie = distance * coef / 4

                  goliv(livr)
                end


              end
            end
          end

          if isToLiv == true then
            while notif2 == true do
              SetNewWaypoint(v.location)
              ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Direction la société! Merci de votre travail', 'CHAR_ELDERS', 10)
              notif2 = false

            end

            DrawMarker(1,v.location, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(v.location, GetEntityCoords(PlayerPedId() ,true)) < 1.5 and alivre == true then
              HelpTextliv("Appuyez sur ~INPUT_CONTEXT~ pour recuperer d'autres livraisons",0,1,0.5,0.8,0.6,255,255,255,255)

                if IsControlJustPressed(1,38) then

                    alivre = false
                    isInJobLiv = true
                    isToHouse = true
                    donneliv = false
                    isToLiv = false
                    while true do
                      thepos = giveposliv()
                      px = thepos.x
                      py = thepos.y
                      pz = thepos.z
                      distance = ESX.Math.Round((GetDistanceBetweenCoords(v.location, px,py,pz)))
                      if distance < 2000 then
                        break
                      end
                    end
                    paie = distance * coef / 4
                    ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Direction : client pour la livraison', 'CHAR_ELDERS', 10)
                    goliv(livr)

                end
            
            end
          end
          if IsEntityDead(PlayerPedId() ) then

            isInJobLiv = false
            livr = 0
            isToHouse = false
            isToLiv = false

            paie = 0
            px = 0
            py = 0
            pz = 0
            RemoveBlip(liv)

          end
      end
    end
    Citizen.Wait(interval)
  end
end)



Citizen.CreateThread(function()
  while true do

  interval = 750
    for k, v in pairs(ConfigLivraison.Configjob.job) do
      if PlayerData.job and PlayerData.job.name == v.jobname then  
        interval = 5

          if isInJobLiv == true then

            DrawMarker(1,v.locationfin, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)

            if GetDistanceBetweenCoords(v.locationfin, GetEntityCoords(PlayerPedId() ,true)) < 1.5 then
              HelpTextliv("Appuyez sur ~INPUT_CONTEXT~ pour arreter la livraison",0,1,0.5,0.8,0.6,255,255,255,255)

              if IsControlJustPressed(1,38) then
                --TriggerServerEvent('elders_livraison:deleteAll')
                isInJobLiv = false
                livr = 0
                isToHouse = false
                isToLiv = false
                RemoveBlip(liv)
                SetWaypointOff()

                paie = 0
                px = 0
                py = 0
                pz = 0

                if alivre == true then

                  ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Merci d\'avoir travaillé, bonne journée', 'CHAR_ELDERS', 10)
                  SetWaypointOff()

                  alivre = false
                else
                  ESX.ShowAdvancedNotification('EldersLife', 'Livraison', 'Merci quand même (pour rien), bonne journée', 'CHAR_ELDERS', 10)
                end
              end
            end
          end
      end
    end
    Citizen.Wait(interval)
  end
end)

function goliv(livr)
  liv = AddBlipForCoord(px,py,pz)
  SetBlipSprite(liv, 1)
  SetNewWaypoint(px,py)
end

function roundliv(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function HelpTextliv(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end