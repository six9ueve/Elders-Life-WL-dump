PlayerData = {}
myFramework = nil
radioProp = nil
radioPropModel = `prop_cs_hand_radio`
isDead = false
raidoOn = false

if Config.framework == "esx" then
	Citizen.CreateThread(function()
		while myFramework == nil do
			TriggerEvent('god:getSharedObject', function(obj) myFramework = obj end)
			Citizen.Wait(0)
		end
		while myFramework.GetPlayerData().job == nil do Citizen.Wait(100) end
		PlayerData = myFramework.GetPlayerData()
	end)

	RegisterNetEvent('god:playerLoaded')
	AddEventHandler('god:playerLoaded', function()
		PlayerData = myFramework.GetPlayerData()
	end)

	RegisterNetEvent('god:setJob')
	AddEventHandler('god:setJob', function(job)
		PlayerData.job = job
	end)
elseif Config.framework == "qb" then
    Citizen.CreateThread(function()
		myFramework = exports['qb-core']:GetCoreObject()
		while myFramework.Functions.GetPlayerData().job == nil do Citizen.Wait(100) end
		PlayerData = myFramework.Functions.GetPlayerData()
	end)

	RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = myFramework.Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
        PlayerData.job = job
    end)

	RegisterNetEvent('Radio.Set')
    AddEventHandler('Radio.Set', function(bool)
		if not bool then
			TriggerEvent("tgiann-radio:onRadioDrop")
		end
    end)
end

function showNotification(msg)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(0,1)
end

function playRadioAnimAndProp()
	local ped = PlayerPedId()
	deleteRadioProp()
	RequestAnimDictFunction("cellphone@", function() -- animasyon oynatma
		TaskPlayAnim(ped, "cellphone@", "cellphone_text_read_base", 3.0, 3.0, -1, 49, 0, false, false, false)
		loadPropDict(radioPropModel)
		radioProp = CreateObject(radioPropModel, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, ped, GetPedBoneIndex(ped, 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
		SetModelAsNoLongerNeeded(radioPropModel)
	end)
end

function removeRadioAnimAndProp()
	ClearPedTasks(PlayerPedId())
	deleteRadioProp()
	radioProp = nil
end

function loadPropDict(model)
	if not HasModelLoaded(radioPropModel) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(500)
		end
	end
end

function deleteRadioProp()
	if DoesEntityExist(radioProp) then
		ClearPedTasks(PlayerPedId())
		DeleteEntity(radioProp)
	end
end

function permControl(i) 
	local job = false
	if PlayerData.job then
		if Config.restrictChannel[i].jobs then
			for x=1, #Config.restrictChannel[i].jobs do
				if PlayerData.job.name == Config.restrictChannel[i].jobs[x] then
					job = true
					break
				end
			end
		end
	end
	return job
end

Citizen.CreateThread(function()
	if Config.framework == "esx" then
		AddEventHandler('god:onPlayerDeath', function(data)
			isDead = true
			if Config.LeaveRadioDie and raidoOn then
				radioLeave(true)
			end
		end)
		
		AddEventHandler('playerSpawned', function(spawn)
			isDead = false
		end)
		
		RegisterNetEvent('ambulance:revive')
		AddEventHandler('ambulance:revive', function(bool)
			isDead = false
		end)

		while Config.UseOxInv and Config.LeaveRadioDrop do
			if raidoOn then
				local ox_inventory = exports.ox_inventory
				local count = ox_inventory:Search('count', Config.ItemName)
				if count < 1 then
					radioLeave(true)
				end
			end
			Wait(1000)
		end
	elseif Config.framework == "qb" then
		RegisterNetEvent('tgiann-radio:isDead')
		AddEventHandler('tgiann-radio:isDead', function(bool)
			isDead = bool
			if isDead and Config.LeaveRadioDie and raidoOn then
				radioLeave(true)
			end
		end)
	else 
		while true do
			Wait(0)
			if NetworkIsPlayerActive(PlayerId()) then
				local playerPed = PlayerPedId()
				if IsPedFatallyInjured(playerPed) and not isDead then				
					isDead = true
					if Config.LeaveRadioDie and raidoOn then
						radioLeave(true)
					end
				elseif not IsPedFatallyInjured(playerPed) then
					isDead = false
				end
			end
		end
	end
end)
