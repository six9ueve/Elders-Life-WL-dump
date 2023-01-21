-- Name of defibrillator item in database
local defibItemName = 'defib'

Citizen.CreateThread(function()
	while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
	end
end)

RegisterNetEvent("defib:useDefib")
AddEventHandler("defib:useDefib", function(ambulancesConnected)

  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  --if ambulancesConnected > 0 then
    --ESX.ShowNotification("EMS en ligne, contactez les ne prennez pas de risque!")
  if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.ShowNotification("Personne à coté.")
  else
    ESX.TriggerServerCallback('elderslife:getInvPlyItems', function(qtty)
      if qtty > 0 then
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)
        local random = math.random(1,3)
        
        if health == 0 then
            if random == 1 then
                local playerPed = PlayerPedId()          
                ESX.ShowNotification("Reanimation en progression ...")
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(30000)
                ClearPedTasks(playerPed)
                
                TriggerServerEvent('god_ambulancejob:defib')
                --TriggerServerEvent('god_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                ESX.ShowNotification("Vous avez mal placé le défibrilateur, la personne est toujours morte.")

            else
                local playerPed = PlayerPedId()          
                ESX.ShowNotification("Reanimation en progression ...")
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(30000)
                ClearPedTasks(playerPed)
                
                TriggerServerEvent('god_ambulancejob:defib')
                TriggerServerEvent('ambulance:revive', GetPlayerServerId(closestPlayer))
                ESX.ShowNotification("Vous avez été réanimé, rendez vous à l'hôpital pour effectuer le suivi de vos soins.")
            end
        else
          ESX.ShowNotification("Cette personne ne nécéssite pas de réanimation.")
        end
      else
        ESX.ShowNotification("Vous n'avez pas de défibrilateur.")
      end
    end, defibItemName)
  end
end)
