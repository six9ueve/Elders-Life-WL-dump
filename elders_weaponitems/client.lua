ESX                     = nil

local Weapons = {}
local AmmoTypes = {}

local AmmoInClip = {}

local CurrentWeapon = nil

local IsShooting = false
local AmmoBefore = 0

local HasRefreshedLoadout = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

for name,item in pairs(Config.Weapons) do
	Weapons[GetHashKey(name)] = item
end

for name,item in pairs(Config.AmmoTypes) do
	AmmoTypes[GetHashKey(name)] = item
end

function GetAmmoItemFromHash(hash)
	for name,item in pairs(Config.Weapons) do
		if hash == GetHashKey(item.name) then
			if item.ammo then
				return item.ammo
			else
				return nil
			end
		end
	end
	return nil
end

function GetInventoryItem(name)
	--print("GetInventoryItem ->", ESX.GetPlayerData().inv)
	local inventory = ESX.GetPlayerData().inv
	for i=1, #inventory, 1 do
		if inventory[i].name == name then
			return inventory[i]
		end
	end
	return nil
end

function RebuildLoadout()
	HasRefreshedLoadout = true
	local playerPed = PlayerPedId()

	local givedAny = false

	for weaponHash,v in pairs(Weapons) do
		local item = GetInventoryItem(v.item)
		if item and item.count > 0 then
			local ammo = 0
			local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

			if ammoType and AmmoTypes[ammoType] then
				local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
				if ammoItem then
					ammo = ammoItem.count
				end
			end

			if item.name == 'fireextinguisher' then
				ammo = 1000
			end

			if item.name == 'petrolcan' then
				ammo = 100000
			end

			if HasPedGotWeapon(playerPed, weaponHash, false) then
				if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
					SetPedAmmo(playerPed, weaponHash, ammo)
				end
			else
				-- Weapon is missing, give it to the player
				GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
				givedAny = true
			end
		elseif HasPedGotWeapon(playerPed, weaponHash, false) then
			-- Weapon doesn't belong in loadout
			RemoveWeaponFromPed(playerPed, weaponHash)
		end
	end

	if givedAny then
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
	end
end

function RemoveUsedAmmo()
	local playerPed = PlayerPedId()
	local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
	local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]

	if ammoType and ammoType.item then
		local ammoDiff = AmmoBefore - AmmoAfter
		if ammoDiff > 0 then
			TriggerServerEvent('god:discardInventoryItem', ammoType.item, ammoDiff)
		end
	end

	return AmmoAfter
end

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
	Citizen.Wait(10000)
	RebuildLoadout()
end)

RegisterNetEvent('god:restoreLoadout')
AddEventHandler('god:restoreLoadout', function(xPlayer)
	Citizen.Wait(1000)
	RebuildLoadout()
end)

RegisterNetEvent('god:modelChanged')
AddEventHandler('god:modelChanged', function()
	RebuildLoadout()
end)

AddEventHandler('god:onPlayerSpawn', function()
	RebuildLoadout()
end)

AddEventHandler('skinchanger:modelLoaded', function()
	RebuildLoadout()
end)

RegisterNetEvent('god:changedPlayerData')
AddEventHandler('god:changedPlayerData', function(name, count)
	RebuildLoadout()
	if CurrentWeapon then
		AmmoBefore = GetAmmoInPedWeapon(PlayerPedId(), CurrentWeapon)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()

		if CurrentWeapon ~= GetSelectedPedWeapon(playerPed) then
			IsShooting = false
			RemoveUsedAmmo()
			CurrentWeapon = GetSelectedPedWeapon(playerPed)
			AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
		else
			Citizen.Wait(50)
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		if IsPedShooting(playerPed) and not IsShooting then
			IsShooting = true
		elseif IsShooting and IsControlJustReleased(0, 24) then
			IsShooting = false
			AmmoBefore = RemoveUsedAmmo()
		elseif not IsShooting and IsControlJustPressed(0, 45) then
			AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
		else
			Citizen.Wait(50)
		end
	end
end)

Citizen.CreateThread(function()
	local petrolcan = `weapon_petrolcan`
	local HasGotPetrolCanBefore = false
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if HasPedGotWeapon(playerPed, petrolcan, false) and GetAmmoInPedWeapon(playerPed, petrolcan) > 0 then
			HasGotPetrolCanBefore = true
			Citizen.Wait(1000)
		else
			if HasGotPetrolCanBefore then
				Citizen.Wait(10)
      			TriggerServerEvent('god:discardInventoryItem', 'petrolcan', 1)
				HasGotPetrolCanBefore = false
			end
			Citizen.Wait(5000)
		end
	end
end)

RegisterCommand('rebuildloadout', function()
	RebuildLoadout()
	print('Rebuilded loadout')
end, false)