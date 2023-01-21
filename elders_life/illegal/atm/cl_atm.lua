ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local RobbingATM = false
local Exploded = false
local coords = nil
local atmEntity = nil 
local allowedtime = 0 
local secs = 60 

local function isNightATM()
	local hour = GetClockHours()
	if hour >= 0 and hour <= 6 then
		return true
	end
end

local function OnHackDone(success)
    if success then
		TriggerServerEvent("osm-atmrobbery:success")	
		ESX.ShowNotification("Casse terminé avec succès!")
		RobbingATM = false
		Exploded = false
		coords = nil
    else	
		ESX.ShowNotification("Casse raté!")
		RobbingATM = false
		Exploded = false
		coords = nil
	end
end

local function TimerATM()
	CreateThread(function()
		while true do
			Wait(1000)
			allowedtime = allowedtime - 1
			
			if allowedtime < 0 then 
				Wait(50)
				break
			end

			if allowedtime ~= 0 then 
				if secs ~= 0 then 
					secs = secs - 1
				else 
					secs = 60
					secs = secs - 1 
				end
			end
			if allowedtime == 0  then
				secs = 0 
			end
		end
	end)
end

local function drawTxtATM(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- Starting ATM Robbery:
local function startRobbingATM()
	ESX.TriggerServerCallback("osm-atmrobbery:GetCooldown", function(undercd)
		if not undercd then
			ESX.TriggerServerCallback('osm-atmrobbery:getHackerDevice', function(hackerdevice)
				if hackerdevice then
					TriggerServerEvent("osm-atmrobbery:CooldownServer", true)
					RobbingATM = true
					
					local player = PlayerPedId()
					local playerPos = GetEntityCoords(player)
						
					FreezeEntityPosition(player,true)

					ClearPedTasksImmediately(player)
				    GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_stickybomb"), 1, false, true)

					Citizen.Wait(500)

					TaskPlantBomb(PlayerPedId(), coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))

					Citizen.Wait(500)

					local progressbartime = math.random(6000, 12000)
					ClearPedTasksImmediately(player)

					loadAnimDictATM('anim@gangops@facility@servers@')

					TriggerEvent("mythic_progbar:client:progress", {
						name = "hack_gate",
						duration = progressbartime,
						label = "Pose de la bombe",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "anim@gangops@facility@servers@",
							anim = "hotwire",
						},

					}, function(status)
						if not status then
							StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
							ESX.ShowNotification('Pose terminé!')
						end
					end)

					Citizen.Wait(progressbartime)

					FreezeEntityPosition(player,false)

					local time = 6
					while time > 0 do 
						ESX.ShowNotification("Explosion dans " .. time .. "..")
						Citizen.Wait(1000)
						time = time - 1
					end

					AddExplosion(coords.x, coords.y, coords.z, EXPLOSION_STICKYBOMB, 4.0, true, false, 10.0)

					TriggerServerEvent("atmrobbery:s_police_notify", playerPos)

					Exploded = true
					
					TriggerServerEvent('osm-atmrobbery:StartFlaresAtEntity', coords)
					
					TriggerEvent("osm-atmrobbery:RobTimer")
					
				else
					RobbingATM = false
				end
			end)
		else
			RobbingATM = false
			TriggerServerEvent("osm-atmrobbery:CooldownNotify")
		end
	end)
end
		
RegisterNetEvent('osm-atmrobbery:itemUsedStart')
AddEventHandler('osm-atmrobbery:itemUsedStart', function()
	local pos = GetEntityCoords(PlayerPedId())
	if not RobbingATM then
		if ConfigATM.OnlyNight then 
			if isNightATM() then 
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed, true)
				for k, v in pairs(ConfigATM.ATMModels) do
					local hash = GetHashKey(v)
					local atm = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 1.5)
					if atm then 
						atmEntity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, hash, false, 0.0, 0.0)
						startRobbingATM()
						coords = playerCoords
					end
				end
			else
				ESX.ShowNotification('Les casses ATM se font que de nuit !')
			end
		else
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed, true)
			for k, v in pairs(ConfigATM.ATMModels) do
				local hash = GetHashKey(v)
				local atm = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 1.5)
				if atm then 
					atmEntity = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, hash, false, 0.0, 0.0)
					startRobbingATM()
					coords = playerCoords
				end
			end
		end
	end
end)

RegisterNetEvent('osm-atmrobbery:itemUsedHacking')
AddEventHandler('osm-atmrobbery:itemUsedHacking', function()
	if RobbingATM and Exploded then 
		-- TriggerEvent('open:minigame', OnHackDone)
		TriggerEvent('ultra-voltlab', 60, function(result,reason)
			-- time: Time in seconds which player has. Min is 10, Max is 60
				if result == 1 then
					OnHackDone(true)
				else
					OnHackDone(false)
				end
			end)
	elseif not Exploded then 
		ESX.ShowNotification('Vous devez faire exploser l\'ATM avant de le décrypter.')
	end
end)

function loadAnimDictATM(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

RegisterNetEvent("osm-atmrobbery:PoliceAlert")
AddEventHandler("osm-atmrobbery:PoliceAlert", function(playerPos)
	local PlayerData = ESX.GetPlayerData()
    local blip = nil

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage ATM\n~r~INTERVENTION DEMANDEE", "CHAR_CALL911", 4)

        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(playerPos.x, playerPos.y, playerPos.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(60000)
            RemoveBlip(blip)
        end
    end

    if PlayerData.job.name == "sheriff" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage ATM\n~r~INTERVENTION DEMANDEE", "CHAR_CALL911", 4)
        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(playerPos.x, playerPos.y, playerPos.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(60000)
            RemoveBlip(blip)
        end
    end
end)


RegisterNetEvent('osm-atmrobbery:client:StartFlaresAtEntity')
AddEventHandler('osm-atmrobbery:client:StartFlaresAtEntity', function(coords)		
		Citizen.Wait(2000)

		RequestWeaponAsset(GetHashKey("weapon_flare")) 
		while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
			Wait(0)
		end
		if coords ~= nil then 
			ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z, coords.x+0.0001, coords.y+0.0001, coords.z, 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0) 
			ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z, coords.x+0.0001, coords.y+0.0001, coords.z, 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0)
		end
end)

------------------------

RegisterNetEvent("osm-atmrobbery:RobTimer")
AddEventHandler("osm-atmrobbery:RobTimer", function()
	Exploded = true
	ESX.ShowNotification('Connectez votre clef encryptée au programme de l\'ATM.')
	CreateThread(function()
		while RobbingATM do 
			Wait(5)
			drawTxtATM('Temps restant pour le vol: ' ..math.ceil((allowedtime/60) - 1).. " Minutes " .. secs .. " Secondes ",4,0.5,0.93,0.50,255,255,255,180)

			if allowedtime < 0 then
				RobbingATM = false
				Exploded = false
				coords = {}
			end
		end
	end)

	allowedtime = ConfigATM.RobberyTime * 60 
	secs = 60

	Wait(50)
	TimerATM()
end)