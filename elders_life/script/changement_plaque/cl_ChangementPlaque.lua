local ESX   = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('Elderslife:PlateChange')
AddEventHandler('Elderslife:PlateChange', function()
  local plate = exports.elders_life:GeneratePlate()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if IsPedSittingInAnyVehicle(PlayerPedId()) then
      ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'Vous ne pouvez pas mettre de plaque à l\'intérieur d\'un véhicule !', 'CHAR_ELDERS', 10)
      return
  end
  ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'Installation en cours, bouge pas pour bien la poser!', 'CHAR_ELDERS', 10)
  Citizen.Wait(5000)
      
      if plate ~= nil then
        local vehicle, distance = ESX.Game.GetClosestVehicle(coords)
          if distance ~= -1 and distance <= 3.0 then
              local oldplate = GetVehicleNumberPlateText(vehicle)

              ESX.TriggerServerCallback('Elderslife:updatePlate', function( cb )
                if cb == 'found' then
                  InRepair = true
                  TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                  Citizen.Wait(10000)
                  ClearPedTasksImmediately(PlayerPedId())
                  SetVehicleNumberPlateText(vehicle, plate)
                  InRepair = false
                  plate = nil
                  ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'La plaque à été correctement posée!', 'CHAR_ELDERS', 10)
                elseif cb == 'error' then
                  ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'Impossible de poser la plaque, elle etait défectueuse!', 'CHAR_ELDERS', 10)
                end
              end, oldplate, plate)
          else
            ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'Pas de véhicule à coté!', 'CHAR_ELDERS', 10)
          end
      else
        ESX.ShowAdvancedNotification('Elder\'s Life', '~b~Information(s)', 'Pas possible de mettre une plaque vide', 'CHAR_ELDERS', 10)
      end
end)