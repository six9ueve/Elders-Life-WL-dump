ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

------------- Light Diving suit
RegisterNetEvent('god_tenues:settenueplongee')
AddEventHandler('god_tenues:settenueplongee', function()
		TriggerEvent('skinchanger:getSkin', function(skin)
    		if skin.sex == 0 then
        		local clothesSkin = {
            		['tshirt_1'] = 138, ['tshirt_2'] = 0,
            		['torso_1'] = 155, ['torso_2'] = 0,
            		['arms'] = 100,
            		['pants_1'] = 124, ['pants_2'] = 0,
            		['shoes_1'] = 19, ['shoes_2'] = 0,
            		['chain_1'] = 0, ['chain_2'] = 0,
            		['bags_1'] = 0, ['bags_2'] = 0,
        		}
        		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    		else
        		local clothesSkin = {
            		['tshirt_1'] = 195, ['tshirt_2'] = 6,
					['ears_1'] = -1, ['ears_2'] = 0,
            		['torso_1'] = 374, ['torso_2'] 	= 15,
            		['decals_1'] = 0,  ['decals_2'] = 0,
            		['mask_1'] = 0, ['mask_2'] 	= 0,
            		['arms'] = 223,
            		['pants_1'] = 142, ['pants_2'] 	= 21,
            		['shoes_1'] = 98, ['shoes_2'] 	= 21,
            		['helmet_1']= -1, ['helmet_2'] 	= 0,
            		['bags_1'] = 0, ['bags_2']	= 0,
					['glasses_1'] = 32, ['glasses_2'] = 6,
					['chain_1'] = 5, ['chain_2'] = 0,
            		['bproof_1'] = 0,  ['bproof_2'] = 0
        		}
        		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        	end
        	local playerPed = PlayerPedId()
			SetEnableScuba(PlayerPedId(),true)
			SetPedMaxTimeUnderwater(PlayerPedId(), 400.00)
    	end)
end)