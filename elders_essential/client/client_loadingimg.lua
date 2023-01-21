ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('god_loading:screen') --This event put head bag on nearest player
AddEventHandler('god_loading:screen', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
end)    

RegisterNetEvent('god_loading:screenhide') --This event delete head bag from player head
AddEventHandler('god_loading:screenhide', function()
    SendNUIMessage({type = 'closeAll'})
end)