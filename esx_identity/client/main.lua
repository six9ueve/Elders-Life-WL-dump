local guiEnabled = false
local myIdentity = {}
local myIdentifiers = {}
local hasIdentity = false
local isDead = false
local open = 1

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('god:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

AddEventHandler('playerSpawnedambu', function(spawn)
	isDead = false
end)

function EnableGui(state)
	SetNuiFocus(state, state)
	guiEnabled = state
	showCam(state)
	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end

local camera = nil
		
function showCam(bool)
	if bool then
		DestroyAllCams(true)
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 344.3341, -998.8612, -98.19622,
                              0, 0, 0, 40.00, false, 0)
		PointCamAtCoord(camera, -986.61447, 0, -186.61447)
		SetCamActive(camera, true)
		RenderScriptCams(true, false, 1, true, false)
	else
		RenderScriptCams(false, true, 500, true, true)
		SetCamActive(camera, false);
		DestroyCam(camera, true);

		camera = nil
	end
end

RegisterNetEvent('god_identity:showRegisterIdentity')
AddEventHandler('god_identity:showRegisterIdentity', function()
	--if open == 1 then
	--	open = 0
	--else
		if not isDead then
			EnableGui(true)
		end
	--end
end)

RegisterNetEvent('god_identity:identityCheck')
AddEventHandler('god_identity:identityCheck', function(identityCheck)
	hasIdentity = identityCheck
end)

RegisterNetEvent('god_identity:saveID')
AddEventHandler('god_identity:saveID', function(data)
	myIdentifiers = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
		
	else
		TriggerEvent('chat:addMessage', { args = { '^1[IDENTITY]', '^1You must create your first character in order to play' } })
	end
end)

RegisterNUICallback('register', function(data, cb)
	local reason = ""
	myIdentity = data
	for theData, value in pairs(myIdentity) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)
			
			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Date de naissance invalide"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Taille invalide!"
					break
				end
			else
				reason = "Taille invalide!"
				break
			end
		end
	end
	
	if reason == "" then
		EnableGui(false)
		TriggerServerEvent('god_identity:setIdentity', data, myIdentifiers)
		--Citizen.Wait(500)
		--TriggerEvent('god_skin:openSaveableMenu', myIdentifiers.id)
	else
	    TriggerEvent('notifications_server:on', reason)

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if guiEnabled then
			FreezeEntityPosition(PlayerPedId(), true)
			DisplayHud(false)
			--DisplayRadar(false)
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		else
			FreezeEntityPosition(PlayerPedId(), false)
			DisplayHud(true)
			--DisplayRadar(true)
			Citizen.Wait(500)
		end
	end
end)

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'Dein Name ist zu lang oder zu kurz!'
	end
	
	-- Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Bitte verwende keine Sonderzeichen!'
	end

	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return 'Dein Name hat zuviele Leerzeichen!'
	end
	
	if spacesWithUpper ~= spacesInName then
		return 'Dein Name muss mit einem Großbustaben starten!'
	end

	return ''
end

RegisterNetEvent("nuiclose")
AddEventHandler("nuiclose", function()
	SetNuiFocus(false, false)
end)