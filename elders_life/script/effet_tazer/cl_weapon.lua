local holstered = true
local canFire = true
local currWeapon = nil
local isHolsteringEnable = true

AddEventHandler("god:onPlayerSpawn", function()
	SetPedSuffersCriticalHits(playerPed, false)
end)

--Désactivation headshot
Citizen.CreateThread(function()
	while true do
		SetPedSuffersCriticalHits(playerPed, false)
		Citizen.Wait(10 * 1000)
	end
end)

--stun tazer
local offScreen = false
local offScreenVerySoon = false

local function stunGun()
	local playerPed = PlayerPedId()
	ESX.Streaming.RequestAnimSet("move_m@drunk@verydrunk")
	offScreenVerySoon = true
	DoScreenFadeOut(800)
	repeat
		Citizen.Wait(50)
	until IsScreenFadedOut()
	offScreen = true
	DoScreenFadeIn(0)
	SetPedMinGroundTimeForStungun(playerPed, 15000)
	SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
	SetTimecycleModifier("spectator5")
	SetPedIsDrunk(playerPed, true)
	Citizen.Wait(15000)
	SetPedMotionBlur(playerPed, true)
	DoScreenFadeOut(0)
	offScreen = false
	offScreenVerySoon = false
	DoScreenFadeIn(800)
	Citizen.Wait(60000)
	DoScreenFadeOut(800)
	Citizen.Wait(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(playerPed, 0)
	SetPedIsDrunk(playerPed, false)
	SetPedMotionBlur(playerPed, false)
	DoScreenFadeIn(800)
end

Citizen.CreateThread(function()
	 while true do
		Citizen.Wait(0)
		if offScreen then
			DrawRect(0.5, 0.5, 3.0, 3.0, 0, 0, 0, 255)
		elseif not offScreenVerySoon then
			Citizen.Wait(400)
		end
	 end
end)

local toBeProofNow = false
Citizen.CreateThread(function()
	 while true do
		if IsPedBeingStunned(PlayerPedId()) then
			stunGun()
		end
		SetEntityProofs(PlayerPedId(), false, false, toBeProofNow, false, false, false, false, false)
		ClearEntityLastDamageEntity(PlayerPedId())
		Citizen.Wait(200)
	 end
end)