ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--------------------------------------------------------------------------------
local PlayerData = {}
local HasOrder,FirstOrder,SecondOrderPayout,ThirdOrderPayout,PayoutForSeventhOrder = false,false,false,false,false
local number,FirstOrderBlip,Plate = nil,nil,nil
local Vehicle

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	local ped_hash = GetHashKey(ConfigMission.illegalorders['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z, ConfigMission.illegalorders['BossSpawn'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC, true)
	SetPedDiesWhenInjured(BossNPC, false)
	SetPedCanPlayAmbientAnims(BossNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC, false)
	SetEntityInvincible(BossNPC, true)
	FreezeEntityPosition(BossNPC, true)
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local coordsNPC = GetEntityCoords(BossNPC)	
		if ESX.GetPlayerData().job2.name == 'cartel' or ESX.GetPlayerData().job2.name == 'cartel_1' or ESX.GetPlayerData().job2.name == 'cartel_2' or ESX.GetPlayerData().job2.name == 'cartel_3' or ESX.GetPlayerData().job2.name == 'mafia' or ESX.GetPlayerData().job2.name == 'mafia_1' or ESX.GetPlayerData().job2.name == 'mafia_2' or ESX.GetPlayerData().job2.name == 'mafia_3' then

		else
			if(GetDistanceBetweenCoords(coords,ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z, true) < 5.5) then	
				sleep = 5
				if(GetDistanceBetweenCoords(coords,ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z, true) < 1.5) then
					if not HasOrder then
						DrawText3DsMission(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'Appuyez sur [~g~E~w~] pour parler au Boss')
					elseif HasOrder and (SecondOrderPayout or ThirdOrderPayout or PayoutForSeventhOrder) then
						DrawText3DsMission(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'Appuyez sur [~g~E~w~] pour récuperer votre paiement')
					end
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not HasOrder then
						ESX.TriggerServerCallback("inside-illegalorders:GetCooldown", function(undercd)
							if not undercd then
								HasOrder = true
								Order = RandomizeMission(ConfigMission.Orders)
								OrdersMission()
							else
								TriggerServerEvent("inside-illegalorders:CooldownNotify")
							end
						end)
					elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and SecondOrderPayout then				
						ESX.TriggerServerCallback('inside-illegalordersType2:payout', function(money)
							ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
						end)
						HasOrder = false
						SecondOrderPayout = false
						number = nil
						Vehicle = nil
					elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and ThirdOrderPayout then
						ESX.TriggerServerCallback('inside-illegalordersType3:payout', function(money)
							ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
						end)
						HasOrder = false
						ThirdOrderPayout = false
						number = nil
						Vehicle = nil
					elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and PayoutForSeventhOrder then
						ESX.TriggerServerCallback('inside-illegalordersType7:payout', function(money)
							ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
						end)
						HasOrder = false
						PayoutForSeventhOrder = false
						number = nil
						Vehicle = nil
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function OrdersMission()
	local ped = PlayerPedId()
	if Order.name == 'first' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Voiture Boss', 'Quelqu\'un à volé ma voiture, apportez-la-moi', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.FirstOrder['CarSpawn'])		
		ESX.Game.SpawnVehicle(ConfigMission.FirstOrder['CarSpawn'][number].Type, vector3(ConfigMission.FirstOrder['CarSpawn'][number].Pos.x, ConfigMission.FirstOrder['CarSpawn'][number].Pos.y, ConfigMission.FirstOrder['CarSpawn'][number].Pos.z), ConfigMission.FirstOrder['CarSpawn'][number].Pos.h, function(vehicle)
			FirstOrderBlip = AddBlipForCoord(ConfigMission.FirstOrder['CarSpawn'][number].Pos.x, ConfigMission.FirstOrder['CarSpawn'][number].Pos.y, ConfigMission.FirstOrder['CarSpawn'][number].Pos.z)	
			SetBlipSprite (FirstOrderBlip, 1)
			SetBlipDisplay(FirstOrderBlip, 4)
			SetBlipScale  (FirstOrderBlip, 1.0)
			SetBlipColour (FirstOrderBlip, 0)
			SetBlipAsShortRange(FirstOrderBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Voiture Boss')
			EndTextCommandSetBlipName(FirstOrderBlip)
			SetNewWaypoint(ConfigMission.FirstOrder['CarSpawn'][number].Pos.x, ConfigMission.FirstOrder['CarSpawn'][number].Pos.y, ConfigMission.FirstOrder['CarSpawn'][number].Pos.z)
			Vehicle = vehicle
			SetVehicleDoorsLocked(vehicle, 0)
			SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
			Plate = GetVehicleNumberPlateText(vehicle)
			for i, v in pairs(ConfigMission.FirstOrder['CarSpawn'][number].Peds['Peds']) do
				local ped_hash = GetHashKey('g_m_m_mexboss_01')
				RequestModel(ped_hash)
				while not HasModelLoaded(ped_hash) do
					Citizen.Wait(1)
				end
				v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, 0.0, false, true)
				SetEntityHeading(v.ped, v.h)
				SetPedFleeAttributes(v.ped, 0, 0)
				SetPedCombatAttributes(v.ped, 46, 1)
				SetPedCombatAbility(v.ped, 100)
				SetPedCombatMovement(v.ped, 2)
				SetPedCombatRange(v.ped, 2)
				SetPedKeepTask(v.ped, true)
				GiveWeaponToPed(v.ped, GetHashKey('weapon_pistol'),250,false,true)
				SetPedAsCop(v.ped, true)
				SetPedDropsWeaponsWhenDead(v.ped, false)
			end
			FirstOrder()
		end)
	elseif Order.name == 'second' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Drogues Boss', 'Un Looser vend de la drogue sans ma permission, prends-lui', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.SecondOrder['PedSpawn'])
		SecondOrderBlip = AddBlipForCoord(ConfigMission.SecondOrder['PedSpawn'][number].Pos.x, ConfigMission.SecondOrder['PedSpawn'][number].Pos.y, ConfigMission.SecondOrder['PedSpawn'][number].Pos.z)	
		SetNewWaypoint(ConfigMission.SecondOrder['PedSpawn'][number].Pos.x, ConfigMission.SecondOrder['PedSpawn'][number].Pos.y, ConfigMission.SecondOrder['PedSpawn'][number].Pos.z)
		SetBlipSprite (SecondOrderBlip, 1)
		SetBlipDisplay(SecondOrderBlip, 4)
		SetBlipScale  (SecondOrderBlip, 1.0)
		SetBlipColour (SecondOrderBlip, 0)
		SetBlipAsShortRange(SecondOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Dealer')
		EndTextCommandSetBlipName(SecondOrderBlip)	
		
		local ped_hash = GetHashKey(ConfigMission.SecondOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end
		DealerPed = CreatePed(1, ped_hash, ConfigMission.SecondOrder['PedSpawn'][number].Pos.x, ConfigMission.SecondOrder['PedSpawn'][number].Pos.y, ConfigMission.SecondOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetEntityHeading(DealerPed, ConfigMission.SecondOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(DealerPed, true)
		SetPedCanPlayAmbientAnims(DealerPed, true)
		SetPedCanRagdollFromPlayerImpact(DealerPed, false)
		SetEntityInvincible(DealerPed, true)
		startAnimMission(DealerPed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(DealerPed, true)
		SecondOrder()
	elseif Order.name == 'third' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Meurtre Boss', 'Il y a un homme influent en ville, tuez-le pour moi', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.ThirdOrder['PedSpawn'])	
		SetNewWaypoint(ConfigMission.ThirdOrder['PedSpawn'][number].Pos.x, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.y, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.z)	
		ESX.Game.SpawnVehicle(ConfigMission.ThirdOrder['PedSpawn'][number].Car, vector3(ConfigMission.ThirdOrder['PedSpawn'][number].Pos.x, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.y, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.z), ConfigMission.ThirdOrder['PedSpawn'][number].Pos.h, function(vehicle)
			local ped_hash = GetHashKey(ConfigMission.ThirdOrder['PedSpawn'][number].Type)
			RequestModel(ped_hash)
			while not HasModelLoaded(ped_hash) do
				Citizen.Wait(1)
			end
			Vehicle = vehicle
			DealerPed = CreatePed(1, ped_hash, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.x, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.y, ConfigMission.ThirdOrder['PedSpawn'][number].Pos.z+1.0, 0.0, false, true)
			SetPedIntoVehicle(DealerPed, vehicle, -1)
			SetVehicleDoorsLocked(vehicle, 0)
			TaskVehicleDriveWander(DealerPed, vehicle, 25.0, 1)
			ThirdOrderBlip = AddBlipForEntity(DealerPed)
			SetBlipSprite (ThirdOrderBlip, 1)
			SetBlipDisplay(ThirdOrderBlip, 4)
			SetBlipScale  (ThirdOrderBlip, 1.0)
			SetBlipColour (ThirdOrderBlip, 0)
			SetBlipAsShortRange(ThirdOrderBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Personne Importante')
			EndTextCommandSetBlipName(ThirdOrderBlip)
			while true do
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				if IsPedDeadOrDying(DealerPed, 1) then
					ESX.ShowAdvancedNotification('Mission illégal', 'Meurtre Boss', 'Maintenant retourne voir le Boss', 'CHAR_ELDERS', 10)
					SetNewWaypoint(ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z)
					RemoveBlip(ThirdOrderBlip)
					Citizen.Wait(3000)
					DeletePed(DealerPed)
					ThirdOrderPayout = true
					break
				end
				Citizen.Wait(5)
			end
		end)
	elseif Order.name == 'fourth' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Livraison Boss', 'J\'ai des marchandises à livrer, faites-le pour moi s\'il vous plaît', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.FourthOrder['CarSpawn'])		
		ESX.Game.SpawnVehicle(ConfigMission.FourthOrder['CarSpawn'][number].Car, vector3(ConfigMission.FourthOrder['CarSpawn'][number].Pos.x, ConfigMission.FourthOrder['CarSpawn'][number].Pos.y, ConfigMission.FourthOrder['CarSpawn'][number].Pos.z), ConfigMission.FourthOrder['CarSpawn'][number].Pos.h, function(vehicle)
			SetNewWaypoint(ConfigMission.FourthOrder['CarSpawn'][number].Pos.x, ConfigMission.FourthOrder['CarSpawn'][number].Pos.y, ConfigMission.FourthOrder['CarSpawn'][number].Pos.z)
			Vehicle = vehicle
			SetVehicleDoorsLocked(vehicle, 0)
			FourthOrderBlip = AddBlipForEntity(vehicle)
			SetBlipSprite (FourthOrderBlip, 1)
			SetBlipDisplay(FourthOrderBlip, 4)
			SetBlipScale  (FourthOrderBlip, 1.0)
			SetBlipColour (FourthOrderBlip, 0)
			SetBlipAsShortRange(FourthOrderBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Livraison Véhicule')
			EndTextCommandSetBlipName(FourthOrderBlip)

			SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
			Plate = GetVehicleNumberPlateText(vehicle)
			while true do
				local sleep = 250
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				if IsPedInAnyVehicle(ped, false) then
					local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
					if GetVehicleNumberPlateText(vehicle2) == Plate then
						RemoveBlip(FourthOrderBlip)

						FourthOrderBlip = AddBlipForCoord(ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z)	
						SetBlipSprite (FourthOrderBlip, 1)
						SetBlipDisplay(FourthOrderBlip, 4)
						SetBlipScale  (FourthOrderBlip, 1.0)
						SetBlipColour (FourthOrderBlip, 0)
						SetBlipAsShortRange(FourthOrderBlip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('Point de Livraison')
						EndTextCommandSetBlipName(FourthOrderBlip)
						ESX.ShowAdvancedNotification('Mission illégal', 'Livraison Boss', 'Amener le véhicule au point de déchargement', 'CHAR_ELDERS', 10)
						SetNewWaypoint(ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z)

						FourthOrder()
						break
					end
				end
				Citizen.Wait(sleep)
			end
		end)
	elseif Order.name == 'fifth' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Vole Boss', 'Quelqu\'un m\'a trompé, braque son magasin...', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.FifthOrder['PedSpawn'])

		local ped_hash = GetHashKey(ConfigMission.FifthOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end			

		StorePed = CreatePed(1, ped_hash, ConfigMission.FifthOrder['PedSpawn'][number].Pos.x, ConfigMission.FifthOrder['PedSpawn'][number].Pos.y, ConfigMission.FifthOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetNewWaypoint(ConfigMission.FifthOrder['PedSpawn'][number].Pos.x, ConfigMission.FifthOrder['PedSpawn'][number].Pos.y, ConfigMission.FifthOrder['PedSpawn'][number].Pos.z)
		SetEntityHeading(StorePed, ConfigMission.FifthOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(StorePed, true)
		SetPedCanPlayAmbientAnims(StorePed, true)
		SetPedCanRagdollFromPlayerImpact(StorePed, false)
		SetEntityInvincible(StorePed, true)
		startAnimMission(StorePed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(StorePed, true)

		FifthOrderBlip = AddBlipForCoord(ConfigMission.FifthOrder['PedSpawn'][number].Pos.x, ConfigMission.FifthOrder['PedSpawn'][number].Pos.y, ConfigMission.FifthOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (FifthOrderBlip, 1)
		SetBlipDisplay(FifthOrderBlip, 4)
		SetBlipScale  (FifthOrderBlip, 1.0)
		SetBlipColour (FifthOrderBlip, 0)
		SetBlipAsShortRange(FifthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Magasin à Braquer')
		EndTextCommandSetBlipName(FifthOrderBlip)	

		FifthOrder()
	elseif Order.name == 'sixth' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Sabotage Boss', 'Tu dois brûler un bâtiment pour moi !', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.SixthOrder['Place'])

		SixthOrderBlip = AddBlipForCoord(ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z)
		SetNewWaypoint(ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z)	
		SetBlipSprite (SixthOrderBlip, 1)
		SetBlipDisplay(SixthOrderBlip, 4)
		SetBlipScale  (SixthOrderBlip, 1.0)
		SetBlipColour (SixthOrderBlip, 0)
		SetBlipAsShortRange(SixthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Choses nécessaires pour mettre le feu')
		EndTextCommandSetBlipName(SixthOrderBlip)	

		SixthOrder()
	elseif Order.name == 'seventh' then
		TriggerServerEvent("inside-illegalorders:CooldownServer", true)
		ESX.ShowAdvancedNotification('Mission illégal', 'Papiers Boss', 'Tu dois prendre des papiers importants pour moi, mais arrête l\'alarme !', 'CHAR_ELDERS', 10)
		number = math.random(1,#ConfigMission.SeventhOrder['Place'])

		SeventhOrderBlip = AddBlipForCoord(ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z)	
		SetNewWaypoint(ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z)
		SetBlipSprite (SeventhOrderBlip, 1)
		SetBlipDisplay(SeventhOrderBlip, 4)
		SetBlipScale  (SeventhOrderBlip, 1.0)
		SetBlipColour (SeventhOrderBlip, 0)
		SetBlipAsShortRange(SeventhOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Coupe l\'alarme')
		EndTextCommandSetBlipName(SeventhOrderBlip)	

		SeventhOrder()
	end
end

function FirstOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 5
			if(GetDistanceBetweenCoords(coords,ConfigMission.FirstOrder['CarSpawn'][number].Pos.x, ConfigMission.FirstOrder['CarSpawn'][number].Pos.y, ConfigMission.FirstOrder['CarSpawn'][number].Pos.z, true) < 10.5) then
				for i, v in pairs(ConfigMission.FirstOrder['CarSpawn'][number].Peds['Peds']) do
					TaskCombatPed(v.ped, ped, 0, 16)
				end
			end
			if IsPedInAnyVehicle(ped, false) then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
				if GetVehicleNumberPlateText(vehicle) == Plate then
					ESX.ShowAdvancedNotification('Mission illégal', 'Ordre du Boss', 'Maintenant retourne voir le Boss !', 'CHAR_ELDERS', 10)
					RemoveBlip(FirstOrderBlip)
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep2 = 500
							SetNewWaypoint(ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z)
							if(GetDistanceBetweenCoords(coords,ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z, true) < 25.0) then
								sleep2 = 0
								DrawMarker(25, ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z-0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z, true) < 6.0) then
									DrawText3DsMission(ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z+1.4, 'Appuyez sur [~g~E~w~] pour rendre le véhicule')
									if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
										local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

										if GetVehicleNumberPlateText(vehicle) == Plate then
											ESX.Game.DeleteVehicle(vehicle)
											ESX.TriggerServerCallback('inside-illegalordersType1:payout', function(money)
												ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
											end)
											Vehicle = nil
											for i, v in pairs(ConfigMission.FirstOrder['CarSpawn'][number].Peds['Peds']) do
												DeletePed(v.ped)
											end
											Plate = nil
											number = nil
											HasOrder = false
											break
										end
									else
										ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Vous n\'etes pas dans le véhicule du Boss', 'CHAR_ELDERS', 10)
									end
								end
							end
						Citizen.Wait(sleep2)
					end
					break
				end
			end
		Citizen.Wait(sleep)
	end
end

function SecondOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local coordsNPC = GetEntityCoords(DealerPed)
		local sleep = 5
		local frezze = true
		if(GetDistanceBetweenCoords(coords, ConfigMission.SecondOrder['PedSpawn'][number].Pos.x, ConfigMission.SecondOrder['PedSpawn'][number].Pos.y, ConfigMission.SecondOrder['PedSpawn'][number].Pos.z, true) < 5.5) and frezze then
			FreezeEntityPosition(DealerPed, false)
			frezze = false
		end
		if(GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
			local text = true
			if text then
				DrawText3DsMission(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.2, "Appuyez sur [~g~E~w~] pour prendre la drogue")
			end
			if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
				text = false
				TaskTurnPedToFaceEntity(DealerPed, PlayerPedId(), 0.2)	
				startAnimMission(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
				exports.rprogress:Custom({
					Duration = 3000,
					Label = "Prends la drogue...",
					Animation = {
						scenario = "", -- https://pastebin.com/6mrYTdQv
						animationDictionary = "", -- https://alexguirre.github.io/animations-list/
					},
					DisableControls = {
						Mouse = false,
						Player = true,
						Vehicle = true
					}
				})
				Citizen.Wait(3000)
				ClearPedTasks(ped)
				ClearPedTasks(DealerPed)
				TaskGoToCoordAnyMeans(DealerPed, ConfigMission.SecondOrder['PedSpawn'][number].Pos.x+5, ConfigMission.SecondOrder['PedSpawn'][number].Pos.y+5, ConfigMission.SecondOrder['PedSpawn'][number].Pos.z, 1.3)
				ESX.ShowAdvancedNotification('Mission illégal', 'Ordre du Boss', 'Retourne voir le Boss', 'CHAR_ELDERS', 10)
				SetNewWaypoint(ConfigMission.illegalorders['BossSpawn'].Pos.x, ConfigMission.illegalorders['BossSpawn'].Pos.y, ConfigMission.illegalorders['BossSpawn'].Pos.z)
				SecondOrderPayout = true
				RemoveBlip(SecondOrderBlip)
				local displaying = true
				Citizen.CreateThread(function()
					Wait(3000)
					displaying = false
				end)
				inspection = true
				while displaying do
					Wait(0)
					local coordsPed = GetEntityCoords(DealerPed, false)
					local coords = GetEntityCoords(PlayerPedId(), false)
					local dist = Vdist2(coordsPed, coords)
					if dist < 150 then                
						DrawText3DsMission(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Fuck you")
					end
				end	
				Citizen.Wait(3000)
				DeletePed(DealerPed)
				break
			end
		end
	Citizen.Wait(sleep)
	end
end

function ThirdOrder()
	--Done in the orders function
end

function FourthOrder()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 10.5) then
			sleep = 5
			if(GetDistanceBetweenCoords(coords,ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 5.5) then
				DrawMarker(2, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords,ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 2.5) then
					DrawText3DsMission(ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.x, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.y, ConfigMission.FourthOrder['CarSpawn'][number].DeliveryPos.z+1.0, 'Appuyez sur [~g~E~w~] pour livrer le véhicule')
					if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
						local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle2) == Plate then
							RemoveBlip(FourthOrderBlip)
							Plate = nil
							number = nil
							HasOrder = false
							ESX.TriggerServerCallback('inside-illegalordersType4:payout', function(money)
								ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
							end)
							FreezeEntityPosition(Vehicle)
							TaskLeaveVehicle(ped, Vehicle)
							SetVehicleDoorShut(Vehicle)
							Citizen.Wait(3000)
							DeleteVehicle(Vehicle)
							Vehicle = nil
							break
						else 
							ESX.ShowAdvancedNotification('Mission illégal', 'Ordre du Boss', 'Ceci n\'est pas un véhicule de livraison', 'CHAR_ELDERS', 10)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function FifthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		local block = false
		if(GetDistanceBetweenCoords(coords,ConfigMission.FifthOrder['PedSpawn'][number].Pos.x, ConfigMission.FifthOrder['PedSpawn'][number].Pos.y, ConfigMission.FifthOrder['PedSpawn'][number].Pos.z, true) < 5.5) and not block then
			block = true
			FreezeEntityPosition(StorePed, false)	
			SetBlockingOfNonTemporaryEvents(StorePed, false)
			SetPedCanPlayAmbientAnims(StorePed, false)
			SetPedCanRagdollFromPlayerImpact(StorePed, true)
			SetEntityInvincible(StorePed, false)	
		end
		if(GetDistanceBetweenCoords(coords,ConfigMission.FifthOrder['PedSpawn'][number].Pos.x, ConfigMission.FifthOrder['PedSpawn'][number].Pos.y, ConfigMission.FifthOrder['PedSpawn'][number].Pos.z, true) < 10.5) then
			sleep = 5
			if IsPlayerFreeAiming(PlayerId()) then
				local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
				if IsPedFleeing(targetPed) and targetPed == StorePed then
					startAnimMission(StorePed, 'anim@mp_player_intuppersurrender', 'enter')
					local displaying = true
					Citizen.CreateThread(function()
						Wait(3000)
						displaying = false
					end)
					while displaying do
						Wait(0)
						local coordsPed = GetEntityCoords(StorePed, false)             
						DrawText3DsMission(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Prend ce que tu veu ....")
					end	
					ESX.ShowAdvancedNotification('Mission illégal', 'Action illégale', 'Vole le cash', 'CHAR_ELDERS', 10)
					RemoveBlip(FifthOrderBlip)
					FifthOrderBlip = AddBlipForCoord(ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.x, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.y, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.z)	
					SetBlipSprite (FifthOrderBlip, 1)
					SetBlipDisplay(FifthOrderBlip, 4)
					SetBlipScale  (FifthOrderBlip, 0.6)
					SetBlipColour (FifthOrderBlip, 0)
					SetBlipAsShortRange(FifthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Cash')
					EndTextCommandSetBlipName(FifthOrderBlip)						
					while true do
						local ped2 = PlayerPedId()
						local coords3 = GetEntityCoords(ped2)
						if(GetDistanceBetweenCoords(coords3,ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.x, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.y, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 6.5) then
							DrawMarker(25, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.x, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.y, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							if(GetDistanceBetweenCoords(coords3,ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.x, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.y, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 1.5) then
								DrawText3DsMission(ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.x, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.y, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.z+1.4, 'Appuyez sur [~g~E~w~] pour voler')
								if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
									SetEntityHeading(ped2, ConfigMission.FifthOrder['PedSpawn'][number].PosToRob.h)
									startAnimMission(ped2, "anim@gangops@facility@servers@bodysearch@", "player_search")
									exports.rprogress:Custom({
										Duration = 3000,
										Label = "Vole...",
										Animation = {
											scenario = "", -- https://pastebin.com/6mrYTdQv
											animationDictionary = "", -- https://alexguirre.github.io/animations-list/
										},
										DisableControls = {
											Mouse = false,
											Player = true,
											Vehicle = true
										}
									})
									Citizen.Wait(3000)
									ESX.TriggerServerCallback('inside-illegalordersType5:payout', function(money)
										ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
									end)
									Vehicle = nil
									ClearPedTasks(ped2)
									RemoveBlip(FifthOrderBlip)	
									number = nil
									HasOrder = false
									Citizen.Wait(3000)
									DeletePed(StorePed)
									break
								end
							end
						end
						Citizen.Wait(5)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function SixthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3DsMission(ConfigMission.SixthOrder['Place'][number].Pos.x, ConfigMission.SixthOrder['Place'][number].Pos.y, ConfigMission.SixthOrder['Place'][number].Pos.z+1.4, 'Appuyez sur [~g~E~w~] pour prendre les accéssoires pour mettre le feu')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, ConfigMission.SixthOrder['Place'][number].Pos.h)
					startAnimMission(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
					exports.rprogress:Custom({
						Duration = 3000,
						Label = "Prend les accéssoires...",
						Animation = {
							scenario = "", -- https://pastebin.com/6mrYTdQv
							animationDictionary = "", -- https://alexguirre.github.io/animations-list/
						},
						DisableControls = {
							Mouse = false,
							Player = true,
							Vehicle = true
						}
					})
					Citizen.Wait(3000)
					ClearPedTasks(ped)
					ESX.ShowAdvancedNotification('Mission illégal', 'Ordre Illégale', 'Maintenant, prend la direction du batiment.', 'CHAR_ELDERS', 10)
					RemoveBlip(SixthOrderBlip)

					SixthOrderBlip = AddBlipForCoord(ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z)	
					SetNewWaypoint(ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z)

					SetBlipSprite (SixthOrderBlip, 1)
					SetBlipDisplay(SixthOrderBlip, 4)
					SetBlipScale  (SixthOrderBlip, 1.0)
					SetBlipColour (SixthOrderBlip, 0)
					SetBlipAsShortRange(SixthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Endroit ou mettre le feu')
					EndTextCommandSetBlipName(SixthOrderBlip)					
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z, true) < 1.5) then
									DrawText3DsMission(ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z+1.4, 'Appuyez sur [~g~E~w~] pour mettre le feu')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
										startAnimMission(ped, "weapon@w_sp_jerrycan", "fire")
										exports.rprogress:Custom({
											Duration = 3000,
											Label = "Met le feu...",
											Animation = {
												scenario = "", -- https://pastebin.com/6mrYTdQv
												animationDictionary = "", -- https://alexguirre.github.io/animations-list/
											},
											DisableControls = {
												Mouse = false,
												Player = true,
												Vehicle = true
											}
										})
										Citizen.Wait(3000)
										RemoveBlip(SixthOrderBlip)
										ClearPedTasks(ped)
										ESX.ShowAdvancedNotification('Mission illégal', 'Ordre Illégale', 'Tu y mets le feu, fuyez !!!', 'CHAR_ELDERS', 10)
										Citizen.Wait(4000)
										currentFires = {}
										fire = StartScriptFire(ConfigMission.SixthOrder['Place'][number].PosFire.x, ConfigMission.SixthOrder['Place'][number].PosFire.y, ConfigMission.SixthOrder['Place'][number].PosFire.z+0.20, 24, false)
										table.insert(currentFires, fire)
										ESX.TriggerServerCallback('inside-illegalordersType6:payout', function(money)
										ESX.ShowAdvancedNotification('Mission illégal', 'Rapport', 'Putain merci, voici votre paiement '..money.." $", 'CHAR_ELDERS', 10)
										end)
										Vehicle = nil
										number = nil
										HasOrder = false
										StopFire()
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)			
	end
end

function SeventhOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3DsMission(ConfigMission.SeventhOrder['Place'][number].Pos.x, ConfigMission.SeventhOrder['Place'][number].Pos.y, ConfigMission.SeventhOrder['Place'][number].Pos.z+1.4, 'Appuyez sur [~g~E~w~] pour couper le courant')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, ConfigMission.SeventhOrder['Place'][number].Pos.h)
					startAnimMission(ped, "mini@repair", "fixing_a_ped")
					exports.rprogress:Custom({
						Duration = 5000,
						Label = "Coupe le courant...",
						Animation = {
							scenario = "", -- https://pastebin.com/6mrYTdQv
							animationDictionary = "", -- https://alexguirre.github.io/animations-list/
						},
						DisableControls = {
							Mouse = false,
							Player = true,
							Vehicle = true
						}
					})
					Citizen.Wait(5000)
					RemoveBlip(SeventhOrderBlip)
					ESX.ShowAdvancedNotification('Mission illégal', 'Ordre Illégale', 'L\'électricité est coupé, va chercher les papiers...', 'CHAR_ELDERS', 10)
					SeventhOrderBlip = AddBlipForCoord(ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z)						
					SetNewWaypoint(ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z)
					SetBlipSprite (SeventhOrderBlip, 1)
					SetBlipDisplay(SeventhOrderBlip, 4)
					SetBlipScale  (SeventhOrderBlip, 1.0)
					SetBlipColour (SeventhOrderBlip, 0)
					SetBlipAsShortRange(SeventhOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Papers')
					EndTextCommandSetBlipName(SeventhOrderBlip)	
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z, true) < 1.5) then
									DrawText3DsMission(ConfigMission.SeventhOrder['Place'][number].PosTake.x, ConfigMission.SeventhOrder['Place'][number].PosTake.y, ConfigMission.SeventhOrder['Place'][number].PosTake.z+1.4, 'Appuyez sur [~g~E~w~] pour chercher les papiers')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then	
										SetEntityHeading(ped, ConfigMission.SeventhOrder['Place'][number].PosTake.h)
										startAnimMission(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
										exports.rprogress:Custom({
											Duration = 5000,
											Label = "Recherche les papiers nécessaires...",
											Animation = {
												scenario = "", -- https://pastebin.com/6mrYTdQv
												animationDictionary = "", -- https://alexguirre.github.io/animations-list/
											},
											DisableControls = {
												Mouse = false,
												Player = true,
												Vehicle = true
											}
										})
										Citizen.Wait(5000)		
										ClearPedTasks(ped)
										RemoveBlip(SeventhOrderBlip)
										ESX.ShowAdvancedNotification('Mission illégal', 'Ordre Illégale', 'Retourne voir le Boss', 'CHAR_ELDERS', 10)
										SetNewWaypoint(ConfigMission.FirstOrder['BackCar'].Pos.x, ConfigMission.FirstOrder['BackCar'].Pos.y, ConfigMission.FirstOrder['BackCar'].Pos.z)
										PayoutForSeventhOrder = true
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
	Citizen.Wait(sleep)
	end
end

function StopFire()
	Wait(10000)
	for k, v in ipairs(currentFires) do
		RemoveScriptFire(v)
	end
end
 
function RandomizeMission(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

function startAnimMission(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function DrawText3DsMission(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('inside-illegalorders:removecars')
AddEventHandler('inside-illegalorders:removecars', function()
	DeleteVehicle(Vehicle)
end)


