local zones = {
	vector3(582.8617, 152.3304, 96.783), ----- meth
	vector3(-328.51, -2446.41, 7.35), ----- coco
	vector3(28.93, 3667.11, 40.44), ----- opium
}

notifIn = false
notifOut = false
local closestZone = 1
local torse = nil
local mask = nil
local pants = nil
local shoes = nil

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		TriggerEvent('skinchanger:getSkin', function(skin)
			torse = skin['torso_1']
			mask = skin['mask_1']
			pants = skin['pants_1']
			shoes = skin['shoes_1']
	  	end)
		Citizen.Wait(10000)
	end
end)



Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(500)
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
		if dist <= 8.0 then 
			if not notifIn then	
                --ESX.ShowNotification("Vous êtes en zone safe")
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
                --ESX.ShowNotification("Vous n'êtes plus en zone safe")
				notifOut = true
				notifIn = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if (torse == 168 or torse == 173) and (pants == 70 or pants == 85) and (shoes == 62 or shoes == 78) and (mask == 191 or mask == 187) then
			--ESX.ShowNotification("Vous êtes protégé")
		else
			if notifIn then
				local playerPed = PlayerPedId()
				local prevHealth = GetEntityHealth(playerPed)
				local health = prevHealth
				health = health - 1
				if health ~= prevHealth then
					SetEntityHealth(playerPed, health)
				end
					ESX.ShowNotification("Vous n'avez pas de tenue HAZMAT. SORTEZ!!")
			end
		end
	end
end)