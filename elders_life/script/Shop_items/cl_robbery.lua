local blackout = false
local playeralreadyrob = false

local peds = {}
local objects = {}

Citizen.CreateThread(function()
	for _, Shop in pairs(ConfigShopsItems.Shops) do
		local brokenCashRegister = GetClosestObjectOfType(Shop.coords, 5.0, `prop_till_01_dam`)
		if DoesEntityExist(brokenCashRegister) then
			CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, `prop_till_01_dam`, `prop_till_01`, false)
		end
	end
end)

RegisterNetEvent('elders_shops:msgPolice')
AddEventHandler('elders_shops:msgPolice', function(ShopId, robber)
	local PlayerData = ESX.GetPlayerData()
    local blip = nil

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage Superette\n~r~INTERVENTION DEMANDEE, INDIVDU ARME", "CHAR_CALL911", 4)

        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(ConfigShopsItems.Shops[ShopId].coords.x, ConfigShopsItems.Shops[ShopId].coords.y, ConfigShopsItems.Shops[ShopId].coords.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(240000)
            RemoveBlip(blip)
        end
    end

    if PlayerData.job.name == "sheriff" then
        ESX.ShowAdvancedNotification("INFORMATION", "~b~BRAQUAGE EN COURS", "Braquage Superette\n~r~INTERVENTION DEMANDEE, INDIVDU ARME", "CHAR_CALL911", 4)
        --exports["mythic_notify"]:SendAlert("inform", "A bank's alarms are triggered!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(ConfigShopsItems.Shops[ShopId].coords.x, ConfigShopsItems.Shops[ShopId].coords.y, ConfigShopsItems.Shops[ShopId].coords.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(240000)
            RemoveBlip(blip)
        end
    end
end)

RegisterNetEvent('elders_shops:removePickup')
AddEventHandler('elders_shops:removePickup', function(ShopId)
	for i, object in pairs(objects) do
		if object.ShopId == ShopId then
			DeleteObject(object.bag)
			table.remove(objects, i)
		end
	end
end)

local function TalkItems(entity, text, time)
	robbing = false
	local pos = GetEntityCoords(entity)

	local endTime = GetGameTimer() + 1000 * time
	while endTime >= GetGameTimer() do
		ESX.Game.Utils.DrawText3D(vector3(pos.x, pos.y, pos.z + 1.0), text)
		Wait(0)
	end
end

RegisterNetEvent('elders_shops:resetStore')
AddEventHandler('elders_shops:resetStore', function(ShopId)
	local brokenCashRegister = GetClosestObjectOfType(ConfigShopsItems.Shops[ShopId].coords, 5.0, `prop_till_01_dam`)
	if DoesEntityExist(brokenCashRegister) then
		CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, `prop_till_01_dam`, `prop_till_01`, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		TickItems()
	end
end)

function TickItems()
	local me = PlayerPedId()

	if blackout then
		Citizen.Wait(500)
		return
	end

	if not IsPedArmed(me, 4) and not IsPedArmed(me, 1) then
		Citizen.Wait(500)
		return
	end

	local FreeAiming, FreeAimingEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())

	if not FreeAiming then
		Citizen.Wait(100)
		return
	end

	if IsPedDeadOrDying(FreeAimingEntity, true) then
		Citizen.Wait(100)
		return
	end

	if not HasEntityClearLosToEntityInFront(me, FreeAimingEntity, 19) then
		return
	end

	local canRob = nil
	local ShopId = nil
	local Shop = nil
	
	ESX.TriggerServerCallback('elders_shops:canRob', function(result, resultShopId)
		canRob = result
		ShopId = resultShopId
		Shop = ConfigShopsItems.Shops[resultShopId]
	end, PedToNet(FreeAimingEntity))

	local PlayerData2 = ESX.GetPlayerData()

	while canRob == nil do
		Wait(0)
	end

	if canRob == 'unknown' then
		Citizen.Wait(1000)
		return
	elseif canRob == 'no_cops' then
		SetEntityInvincible(FreeAimingEntity, true)
		TalkItems(FreeAimingEntity, "~r~Il n'y a pas assez de policier", 5)
		return
	elseif canRob == 'robbed' then
		TalkItems(FreeAimingEntity, '~g~*Vendeur* ~w~J\'ai déja été braqué! j\'ai plus rien!', 5)
		Wait(5000)
		return
	end

	if not canRob then
		TalkItems(FreeAimingEntity, '~g~*Vendeur* ~r~Mort', 5)
		Wait(5000)
		return
	end

	if playeralreadyrob then 
		TalkItems(FreeAimingEntity, '~r~Tu as a déjà braqué un collègue !', 5)
		return
	end

	TriggerEvent("elders_shops:playeralreadyrob")

	ESX.TriggerServerCallback('elders_shops:gangrobbing', function(result)
		gangrobbing = result
	end)

	Citizen.Wait(500)

	if gangrobbing then
		TalkItems(FreeAimingEntity, '~r~Ton gang a déjà braqué un collègue !', 5)
		return
	end

	TriggerServerEvent("elders_shops:Receivegangrob", PlayerData2.job2.name)

	repeat
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(FreeAimingEntity)
	until NetworkHasControlOfEntity(FreeAimingEntity)

	SetEntityInvincible(FreeAimingEntity, false)
	SetPedHearingRange(FreeAimingEntity, 0.0)
	SetPedSeeingRange(FreeAimingEntity, 0.0)
	SetPedAlertness(FreeAimingEntity, 0.0)
	SetPedFleeAttributes(FreeAimingEntity, 0, 0)
	SetBlockingOfNonTemporaryEvents(FreeAimingEntity, true)
	SetPedCombatAttributes(FreeAimingEntity, 46, true)
	SetPedFleeAttributes(FreeAimingEntity, 0, 0)
	SetEntityAsMissionEntity(FreeAimingEntity, 1, 1)

	robbing = true

	ESX.Streaming.RequestAnimDict('missheist_agency2ahands_up')
	TaskPlayAnim(FreeAimingEntity, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)

	local scared = 0
	while scared < 100 and not IsPedDeadOrDying(FreeAimingEntity) and #(GetEntityCoords(me) - GetEntityCoords(FreeAimingEntity)) <= 7.5 do
		local sleep = 600
		SetEntityAnimSpeed(FreeAimingEntity, "missheist_agency2ahands_up", "handsup_anxious", 1.0)

		if IsPlayerFreeAiming(PlayerId()) then
			sleep = 250
			SetEntityAnimSpeed(FreeAimingEntity, "missheist_agency2ahands_up", "handsup_anxious", 1.3)
		end

		if IsPedArmed(me, 4) and IsControlPressed(0, 24) then
			sleep = 50
			SetEntityAnimSpeed(FreeAimingEntity, "missheist_agency2ahands_up", "handsup_anxious", 1.7)
		end

		RemoveAnimDict('missheist_agency2ahands_up')
		sleep = GetGameTimer() + sleep
		while sleep >= GetGameTimer() and not IsPedDeadOrDying(FreeAimingEntity) do
			Wait(0)
			DrawRect(0.5, 0.5, 0.2, 0.03, 75, 75, 75, 200)
			local draw = scared/500
			DrawRect(0.5, 0.5, draw, 0.03, 0, 221, 255, 200)
		end

		scared = scared + 0.5 
	end

	if #(GetEntityCoords(me) - GetEntityCoords(FreeAimingEntity)) > 7.5 then
		ClearPedTasks(FreeAimingEntity)
		local wait = GetGameTimer()+5000
		while wait >= GetGameTimer() do
			Wait(0)
			ESX.Game.Utils.DrawText3D(GetOffsetFromEntityInWorldCoords(me, 0.0, 1.5, 0.4), '~r~Tu es parti trop loin !')
		end
		return
	end

	if IsPedDeadOrDying(FreeAimingEntity) then
		Wait(5000)
		return
	end

	SetEntityCoords(FreeAimingEntity, Shop.coords)
	ESX.Streaming.RequestAnimDict('mp_am_hold_up')
	TaskPlayAnim(FreeAimingEntity, "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
	RemoveAnimDict('mp_am_hold_up')

	while not IsEntityPlayingAnim(FreeAimingEntity, "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end

	timer = GetGameTimer() + 200
	while timer >= GetGameTimer() do
		if IsPedDeadOrDying(FreeAimingEntity) then
			break
		end
		Wait(0)
	end

	if not IsPedDeadOrDying(FreeAimingEntity) then
		TriggerServerEvent('elders_shops:rob', ShopId)
		local cashRegister = GetClosestObjectOfType(Shop.coords, 5.0, `prop_till_01`)
		if DoesEntityExist(cashRegister) then
			CreateModelSwap(GetEntityCoords(cashRegister), 0.5, `prop_till_01`, `prop_till_01_dam`, false)
		end

		timer = GetGameTimer() + 200
		while timer >= GetGameTimer() do
			if IsPedDeadOrDying(FreeAimingEntity) then
				break
			end
			Wait(0)
		end

		ESX.Streaming.RequestModel(ConfigShopsItems.BagModel)
		local bag = CreateObject(ConfigShopsItems.BagModel, Shop.coords, true, true, false)

		AttachEntityToEntity(bag, FreeAimingEntity, GetPedBoneIndex(FreeAimingEntity, 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
		SetModelAsNoLongerNeeded(ConfigShopsItems.BagModel)
		timer = GetGameTimer() + 10000
		while timer >= GetGameTimer() do
			if IsPedDeadOrDying(FreeAimingEntity) then
				break
			end
			Wait(0)
		end

		if not IsPedDeadOrDying(FreeAimingEntity) then
			DetachEntity(bag, true, false)
			SetEntityHeading(bag, Shop.heading)
			ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
			table.insert(objects, {ShopId = ShopId, bag = bag})
		else
			DeleteObject(bag)
		end
	end

	ESX.Streaming.RequestAnimDict('mp_am_hold_up')
	TaskPlayAnim(FreeAimingEntity, "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
	timer = GetGameTimer() + 2500
	while timer >= GetGameTimer() do Wait(0) end
	TaskPlayAnim(FreeAimingEntity, "mp_am_hold_up", "cower_loop", 8.0, -8.0, -1, 1, 0, false, false, false)

	local stop = 30
	while stop >= 0 do
		Wait(1000)
		stop = stop - 1
	end

	if IsEntityPlayingAnim(FreeAimingEntity, "mp_am_hold_up", "cower_loop", 3) then
		ClearPedTasks(FreeAimingEntity)
	end

	RemoveAnimDict('mp_am_hold_up')
	robbing = false
end

Citizen.CreateThread(function()
	while true do
		Wait(50)
		if #objects > 0 then
			for _, object in pairs(objects) do
				if DoesEntityExist(object.bag) then
					if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(object.bag)) <= 1.5 then
						PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
						TriggerServerEvent('elders_shops:pickUp', object.ShopId)
						Citizen.Wait(2000)
					end
				end
			end
		else
			Citizen.Wait(2000)
		end
	end
end)

RegisterNetEvent('elders_shops:playeralreadyrob')
AddEventHandler('elders_shops:playeralreadyrob', function()
	playeralreadyrob = true
	Wait(ConfigShopsItems.TimePlayer * 60 * 1000)
	playeralreadyrob = false
end)