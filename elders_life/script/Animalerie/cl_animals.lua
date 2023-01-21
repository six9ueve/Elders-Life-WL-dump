ESX                     = nil
local ped = nil
local model, object, animation = {}, {}, {}
local status = 100
local objCoords
local come = 0
local isAnimalAttached, getball, inanimation, balle = false ,false, false, false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	ESX.Streaming.RequestModel('a_c_rottweiler') -- chien
	ESX.Streaming.RequestModel('a_c_cat_01') -- chat
	ESX.Streaming.RequestModel('a_c_coyote') -- loup
	ESX.Streaming.RequestModel('a_c_rabbit_01') -- lapin
	ESX.Streaming.RequestModel('a_c_husky') -- husky
	ESX.Streaming.RequestModel('a_c_pig') -- cochon
	ESX.Streaming.RequestModel('a_c_poodle') -- caniche
	ESX.Streaming.RequestModel('a_c_pug') -- carlin
	ESX.Streaming.RequestModel('a_c_retriever') -- labrador
	ESX.Streaming.RequestModel('a_c_shepherd') -- berger
	ESX.Streaming.RequestModel('a_c_panther') -- panther
	ESX.Streaming.RequestModel('a_c_westy') -- westie
	ESX.Streaming.RequestModel('a_c_mtlion') -- cougar
end)

RegisterCommand('menuAnimals', function()
	OpenAnimalsMenu()
end, false)

RegisterKeyMapping('menuAnimals', 'Menu Animal', 'keyboard', 'F11')

RMenu.Add("animalerie", "princ", RageUI.CreateMenu("Animalerie", "~b~Achat chien :", nil, nil, "aLib", "black"))
RMenu:Get("animalerie", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("menuanimal", "princ", RageUI.CreateMenu("Animal", "~b~Choix :", nil, nil, "aLib", "black"))
RMenu:Get("menuanimal", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("menuanimal", "ordre", RageUI.CreateSubMenu(RMenu:Get("menuanimal", "princ"), "Animal", "~b~Ordre :"))
RMenu:Get("menuanimal", "ordre").Closed = function()end

local function OpenPetShop()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("animalerie", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("animalerie", "princ"),true,true,true,function()
            	for k, v in pairs(ConfigAnimal.PetShop) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "$"..ESX.Math.GroupDigits(v.price)}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('elders_animals:buyPet', function(boughtPed)
								if boughtPed then
									RageUI.CloseAll()
                        			isMenuOpened = false
								end
							end, v.pet)
                        end
                    end)
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

function OpenAnimalsMenu()
	if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("menuanimal", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("menuanimal", "princ"),true,true,true,function()
            	if come == 1 then 
	            	RageUI.ButtonWithStyle("Taux de Faim :", nil, {RightLabel = status.."%"}, true,function(a,h,s)
	                    if s then
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
	                RageUI.ButtonWithStyle("Donner à manger", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                        local inventory = ESX.GetPlayerData().inv
							local coords1 = GetEntityCoords(PlayerPedId())
							local coords2 = GetEntityCoords(ped)
							local distance = #(coords1 - coords2)
							local count = 0
							for i=1, #inventory, 1 do
								if inventory[i].name == 'croquettes' then
									count = inventory[i].count
								end
							end
							if distance < 5 then
								if count >= 1 then
									if status < 100 then
										status = status + math.random(2, 15)
										ESX.ShowNotification('Vous avez nourri votre animal')
										TriggerServerEvent('elders_animals:consumePetFood')
										if status > 100 then
											status = 100
										end
									else
										ESX.ShowNotification('Votre animal n\'a plus faim.')
									end
								else
									ESX.ShowNotification('~r~Tu n\'as pas de nourriture pour ton animal ! ~s~')
								end
							else
								ESX.ShowNotification('~r~Votre animal est trop loin ! ~s~')
							end
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
	                RageUI.ButtonWithStyle("Attacher / Détacher votre animal", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                        if not IsPedSittingInAnyVehicle(ped) then
								if isAnimalAttached == false then
									AttachAnimal()
									isAnimalAttached = true
									ESX.ShowNotification('~g~Vous avez attaché votre animal !~s~')
								else
									DetachAnimal()
									isAnimalAttached = false
									ESX.ShowNotification('~g~Vous avez détaché votre animal !~s~')
								end
								else
								ESX.ShowNotification('~r~On attache pas un animal dans un vehicule !~s~')
							end
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
	                if isInVehicle then
		                RageUI.ButtonWithStyle("Faire décendre de la voiture", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                        local playerPed = PlayerPedId()
								local vehicle = GetVehiclePedIsUsing(playerPed)
								local coords = GetEntityCoords(playerPed)
								local distance = #(coords - GetEntityCoords(ped))
								if not isInVehicle then
									if IsPedSittingInAnyVehicle(playerPed) then
										if distance < 8 then
											AttachAnimal()
											Citizen.Wait(200)
											if IsVehicleSeatFree(vehicle, 1) then
												SetPedIntoVehicle(ped, vehicle, 1)
												isInVehicle = true
											elseif IsVehicleSeatFree(vehicle, 2) then
												isInVehicle = true
												SetPedIntoVehicle(ped, vehicle, 2)
											elseif IsVehicleSeatFree(vehicle, 0) then
												isInVehicle = true
												SetPedIntoVehicle(ped, vehicle, 0)
											end
										else
											ESX.ShowNotification('~r~Votre animal est trop loin du véhicule ! ~s~')
										end
									else
										ESX.ShowNotification('vous devez être dans un vehicule !')
									end
								end
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
		            else
		                RageUI.ButtonWithStyle("Faire monter dans la voiture", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                        local playerPed = PlayerPedId()
								local vehicle = GetVehiclePedIsUsing(playerPed)
								local coords = GetEntityCoords(playerPed)
								local distance = #(coords - GetEntityCoords(ped))
								if not isInVehicle then
									if IsPedSittingInAnyVehicle(playerPed) then
										if distance < 8 then
											AttachAnimal()
											Citizen.Wait(200)
											if IsVehicleSeatFree(vehicle, 1) then
												SetPedIntoVehicle(ped, vehicle, 1)
												isInVehicle = true
											elseif IsVehicleSeatFree(vehicle, 2) then
												isInVehicle = true
												SetPedIntoVehicle(ped, vehicle, 2)
											elseif IsVehicleSeatFree(vehicle, 0) then
												isInVehicle = true
												SetPedIntoVehicle(ped, vehicle, 0)
											end
										else
											ESX.ShowNotification('~r~Votre animal est trop loin du véhicule ! ~s~')
										end
									else
										ESX.ShowNotification('vous devez être dans un vehicule !')
									end
								end
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
		            end
	                RageUI.ButtonWithStyle("Donner un ordre", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                end, RMenu:Get("menuanimal", "ordre"))
	        else
                RageUI.ButtonWithStyle("Appeler votre animal", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('elders_animals:getPet', function(pet)
							if pet == '' then
								ESX.ShowNotification('~r~Vous n\'avez pas d\'animal !')
							elseif pet == 'chien' then
								model = `a_c_rottweiler`
								come = 1
								CallAnimal()
							elseif pet == 'chat' then
								model = `a_c_cat_01`
								come = 1
								CallAnimal()
							elseif pet == 'loup' then
								model = `a_c_coyote`
								come = 1
								CallAnimal()
							elseif pet == 'lapin' then
								model = `a_c_rabbit_01`
								come = 1
								CallAnimal()
							elseif pet == 'husky' then
								model = `a_c_husky`
								come = 1
								CallAnimal()
							elseif pet == 'caniche' then
								model = `a_c_poodle`
								come = 1
								CallAnimal()
							elseif pet == 'carlin' then
								model = `a_c_pug`
								come = 1
								CallAnimal()
							elseif pet == 'labrador' then
								model = `a_c_retriever`
								come = 1
								CallAnimal()
							elseif pet == 'berger' then
								model = `a_c_shepherd`
								come = 1
								CallAnimal()
							elseif pet == 'westie' then
								model = `a_c_westy`
								come = 1
								CallAnimal()
							elseif pet == 'panther' then
								model = `a_c_panther`
								come = 1
								CallAnimal()
							elseif pet == 'cougar' then
								model = `a_c_mtlion`
								come = 1
								CallAnimal()
							else
								ESX.ShowNotification('~r~Animal inconnu ...')
							end
						end)
                        RageUI.CloseAll()
                        isMenuOpened = false
                    end
                end)
            end
            end, function()end, 1)
			RageUI.IsVisible(RMenu:Get("menuanimal", "ordre"),true,true,true,function()
				if not inanimation then
					if pet ~= 'chat' then
						RageUI.ButtonWithStyle("Allez chercher la balle", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	local pedCoords = GetEntityCoords(ped)
								object = GetClosestObjectOfType(pedCoords, 190.0, `w_am_baseball`)
								if DoesEntityExist(object) then
									balle = true
									objCoords = GetEntityCoords(object)
									TaskGoToCoordAnyMeans(ped, objCoords, 5.0, 0, 0, 786603, 0xbf800000)
									local GroupHandle = GetPlayerGroup(PlayerId())
									SetGroupSeparationRange(GroupHandle, 1.9)
									SetPedNeverLeavesGroup(ped, false)
									ESX.ShowNotification('Votre animal va chercher la balle')
								else
									ESX.ShowNotification('Il n\'y a pas de ~b~balles~s~')
								end
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					end
					RageUI.ButtonWithStyle("Suis moi", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                    	TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.0, 0.0, 1.0, 1.0, 10.0, 1000.0, true)
							ESX.ShowNotification('Votre animal vous suis')
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
					RageUI.ButtonWithStyle("Au pieds", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                    	TaskGoToCoordAnyMeans(ped, GetEntityCoords(PlayerPedId()), 5.0, 0, 0, 786603, 0xbf800000)
							ESX.ShowNotification('Votre animal vient au pied')
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
					RageUI.ButtonWithStyle("A la niche", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                    	local GroupHandle = GetPlayerGroup(PlayerId())
							local coords = GetEntityCoords(PlayerPedId())
							ESX.ShowNotification('Votre Animal rentre à la Niche')
							SetGroupSeparationRange(GroupHandle, 1.9)
							SetPedNeverLeavesGroup(ped, false)
							TaskGoToCoordAnyMeans(ped, coords.x + 40, coords.y, coords.z, 5.0, 0, 0, 786603, 0xbf800000)
							RageUI.CloseAll()
	                        isMenuOpened = false
	                        come = 0
							Citizen.Wait(5000)
							DeleteEntity(ped)
	                    end
	                end)
	                if pet == 'chien' then
						RageUI.ButtonWithStyle("Assis", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@rottweiler@amb@world_dog_sitting@base')
								TaskPlayAnim(ped, 'creatures@rottweiler@amb@world_dog_sitting@base', 'base' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
		                RageUI.ButtonWithStyle("Couché", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@rottweiler@amb@sleep_in_kennel@')
								TaskPlayAnim(ped, 'creatures@rottweiler@amb@sleep_in_kennel@', 'sleep_in_kennel' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					elseif pet == 'chat' then
						RageUI.ButtonWithStyle("Couché", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@cat@amb@world_cat_sleeping_ground@idle_a')
								TaskPlayAnim(ped, 'creatures@cat@amb@world_cat_sleeping_ground@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					elseif pet == 'loup' then
						RageUI.ButtonWithStyle("Couché", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@coyote@amb@world_coyote_rest@idle_a')
								TaskPlayAnim(ped, 'creatures@coyote@amb@world_coyote_rest@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					elseif pet == 'carlin' then
						RageUI.ButtonWithStyle("Assis", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@carlin@amb@world_dog_sitting@idle_a')
								TaskPlayAnim(ped, 'creatures@carlin@amb@world_dog_sitting@idle_a', 'idle_b' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					elseif pet == 'labrador' then
						RageUI.ButtonWithStyle("Assis", nil, {RightLabel = "→→→"}, true,function(a,h,s)
		                    if s then
		                    	ESX.Streaming.RequestAnimDict('creatures@retriever@amb@world_dog_sitting@idle_a')
								TaskPlayAnim(ped, 'creatures@retriever@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
								inanimation = true
		                        RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
					end
				else
					RageUI.ButtonWithStyle("Debout", nil, {RightLabel = "→→→"}, true,function(a,h,s)
	                    if s then
	                    	ClearPedTasks(ped)
							inanimation = false
							ESX.ShowNotification('Votre animal se lève')
	                        RageUI.CloseAll()
	                        isMenuOpened = false
	                    end
	                end)
				end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)

		if balle then
			local coords1 = GetEntityCoords(PlayerPedId())
			local coords2 = GetEntityCoords(ped)
			local distance = #(objCoords - coords2)
			local distance2 = #(coords1 - coords2)

			if distance < 0.5 then
				local boneIndex = GetPedBoneIndex(ped, 17188)
				AttachEntityToEntity(object, ped, boneIndex, 0.120, 0.010, 0.010, 5.0, 150.0, 0.0, true, true, false, true, 1, true)
				TaskGoToCoordAnyMeans(ped, coords1, 5.0, 0, 0, 786603, 0xbf800000)
				balle = false
				getball = true
			end
		elseif getball then
			local coords1 = GetEntityCoords(PlayerPedId())
			local coords2 = GetEntityCoords(ped)
			local distance2 = #(coords1 - coords2)

			if distance2 < 1.5 then
				DetachEntity(object,false,false)
				Citizen.Wait(50)
				SetEntityAsMissionEntity(object)
				DeleteEntity(object)
				GiveWeaponToPed(PlayerPedId(), `WEAPON_BALL`, 1, false, true)
				local GroupHandle = GetPlayerGroup(PlayerId())
				SetGroupSeparationRange(GroupHandle, 999999.9)
				SetPedNeverLeavesGroup(ped, true)
				SetPedAsGroupMember(ped, GroupHandle)
				getball = false
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

function AttachAnimal()
	SetGroupSeparationRange(GetPlayerGroup(PlayerId()), 1.9)
	SetPedNeverLeavesGroup(ped, false)
	FreezeEntityPosition(ped, true)
end

function DetachAnimal()
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 999999.9)
	SetPedNeverLeavesGroup(ped, true)
	SetPedAsGroupMember(ped, GroupHandle)
	FreezeEntityPosition(ped, false)
end

function CallAnimal()
	local playerPed = PlayerPedId()
	local LastPosition = GetEntityCoords(playerPed)
	local GroupHandle = GetPlayerGroup(PlayerId())

	ESX.Streaming.RequestAnimDict('rcmnigel1c')

	TaskPlayAnim(playerPed, 'rcmnigel1c', 'hailing_whistle_waive_a' ,8.0, -8, -1, 120, 0, false, false, false)

	Citizen.SetTimeout(2000, function()
		ped = CreatePed(28, model, LastPosition.x +1, LastPosition.y +1, LastPosition.z -1, 1, 1)

		SetPedAsGroupLeader(playerPed, GroupHandle)
		SetPedAsGroupMember(ped, GroupHandle)
		SetPedNeverLeavesGroup(ped, true)
		SetPedCanBeTargetted(ped, false)
		SetEntityAsMissionEntity(ped, true,true)

		status = math.random(40, 90)
		Citizen.Wait(5)
		AttachAnimal()
		Citizen.Wait(5)
		DetachAnimal()

		if not DoesEntityExist(ped) then
			ESX.ShowNotification('~r~Votre animal semble ne pas vouloir sortir (bug...)')
			ped = nil
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(60000, 120000))

		if come == 1 then
			status = status - 1
		end

		if status == 0 then
			TriggerServerEvent('elders_animals:petDied')
			DeleteEntity(ped)
			ESX.ShowNotification('votre animal est mort de faim !')
			come = 3
			status = "die"
		end
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(ConfigAnimal.Zones.PetShop.Pos.x, ConfigAnimal.Zones.PetShop.Pos.y, ConfigAnimal.Zones.PetShop.Pos.z)

	SetBlipSprite(blip, ConfigAnimal.Zones.PetShop.Sprite)
	SetBlipDisplay(blip, ConfigAnimal.Zones.PetShop.Display)
	SetBlipScale(blip, ConfigAnimal.Zones.PetShop.Scale)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Animalerie')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coord = GetEntityCoords(PlayerPedId())

		if #(coord - ConfigAnimal.Zones.PetShop.Pos) < 2 then
			ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour acceder a l\'animalerie.')

			if IsControlJustReleased(0, 38) then
				OpenPetShop()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function (resourceName)
	if resourceName ~= GetCurrentResourceName() then return end
	if ped ~= nil then
		DeleteEntity(ped)
	end
end)