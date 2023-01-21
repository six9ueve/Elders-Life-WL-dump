ESX = nil
local voituregive = {}
local fullcustom = false
local curentvehicle_name = ""
local curentvehicle_model = ""
local curentvehicle_finalpoint = 0


------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	TriggerServerEvent('boutique:getpoints')
	if pointjoueur == nil then pointjoueur = 0 end
	while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)

RegisterNetEvent("Boutique:Notification")
AddEventHandler("Boutique:Notification", function(message)
    ESX.ShowNotification("~o~Boutique : " .. message)
end)

local function spawnuniCar_boutique(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -899.62, -3298.74, 13.94, 58.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
	SetVehicleDoorsLocked(vehicle, 4)
	ESX.ShowNotification("Vous avez 20 secondes pour tester le véhicule.")
	local timer = 20
	local breakable = false
	breakable = false
	while not breakable do
		Wait(1000)
		timer = timer - 1
		if timer == 10 then
			ESX.ShowNotification("Il vous reste plus que 10 secondes.")
		end
		if timer == 5 then
			ESX.ShowNotification("Il vous reste plus que 5 secondes.")
		end
		if timer <= 0 then
			local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			DeleteEntity(vehicle)
			ESX.ShowNotification("~r~Vous avez terminé la période d'essai.")
			SetEntityCoords(PlayerPedId(), posessaie)
			breakable = true
			break
		end
	end
end

local function buying_boutique(point)
	if pointjoueur >= point then
		TriggerServerEvent('boutique:deltniop', point)
		Citizen.Wait(300)
		TriggerServerEvent('boutique:getpoints')
	else
		TriggerEvent('god:showNotification', '~r~Tu ne peut pas acheter cet article.')
	end
end

local function give_vehi_boutique(veh)
	TriggerEvent('god:showAdvancedNotification', 'Boutique', '', 'Vous avez reçu votre :\n '..veh.. ' à coté de vous', "CHAR_SOCIAL_CLUB", 3)
    local plyCoords = GetEntityCoords(PlayerPedId(), false)
    
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = exports.elders_life:GeneratePlate()
            table.insert(voituregive, vehicle)		
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
			TriggerServerEvent('shop:vehiculeboutique', vehicleProps, plate)
	end)
end 

---- discord : https://discord.gg/pRXCnA8

local function gmoney_boutique(w,n)
	TriggerEvent('god:showAdvancedNotification', '~o~Boutique', '', 'Vous avez reçu vos :\n'..n, "CHAR_SOCIAL_CLUB", 3)
	TriggerServerEvent('give:money', w)
end

local function FullVehicleBoost_boutique(vehicle)
	SetVehicleModKit(vehicle, 0)
	SetVehicleMod(vehicle, 14, 0, true)
	SetVehicleNumberPlateTextIndex(vehicle, 5)
	ToggleVehicleMod(vehicle, 18, true)
	SetVehicleColours(vehicle, 0, 0)
	SetVehicleModColor_2(vehicle, 5, 0)
	SetVehicleExtraColours(vehicle, 111, 111)
	SetVehicleWindowTint(vehicle, 2)
	ToggleVehicleMod(vehicle, 22, true)
	SetVehicleMod(vehicle, 23, 11, false)
	SetVehicleMod(vehicle, 24, 11, false)
	SetVehicleWheelType(vehicle, 120)
	SetVehicleWindowTint(vehicle, 3)
	ToggleVehicleMod(vehicle, 20, true)
	SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
	LowerConvertibleRoof(vehicle, true)
	SetVehicleIsStolen(vehicle, false)
	SetVehicleIsWanted(vehicle, false)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleNeedsToBeHotwired(vehicle, false)
	SetCanResprayVehicle(vehicle, true)
	SetPlayersLastVehicle(vehicle)
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	SetVehicleTyresCanBurst(vehicle, false)
	SetVehicleWheelsCanBreak(vehicle, false)
	SetVehicleCanBeTargetted(vehicle, false)
	SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
	SetVehicleHasStrongAxles(vehicle, true)
	SetVehicleDirtLevel(vehicle, 0)
	SetVehicleCanBeVisiblyDamaged(vehicle, false)
	IsVehicleDriveable(vehicle, true)
	SetVehicleEngineOn(vehicle, true, true)
	SetVehicleStrong(vehicle, true)
	RollDownWindow(vehicle, 0)
	RollDownWindow(vehicle, 1)
	
	SetPedCanBeDraggedOut(PlayerPedId(), false)
	SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
	SetPedRagdollOnCollision(PlayerPedId(), false)
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedDecorations(PlayerPedId())
	SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
end


---- discord : https://discord.gg/pRXCnA8

local function Notify_boutique(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

local function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local function KeyboardInput_boutique(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

local function OpenMenuBoutique()
	 if isMenuOpened then return end
    isMenuOpened = true
Citizen.CreateThread(function()
	RageUI.Visible(RMenu:Get('boutique', 'main'), not RageUI.Visible(RMenu:Get('boutique', 'main')))
    while isMenuOpened do
		RageUI.IsVisible(RMenu:Get('boutique', 'main'), true, true, true, function()
	  	RageUI.Separator("~b~Tu as ~r~"..pointjoueur.." ~b~Crédit(s)", nil, {}, true, function(_, _, _) end)

			RageUI.ButtonWithStyle("Véhicules", nil, { RightLabel = "→" },true, function() 
			end, RMenu:Get('boutique', 'vehiclemenu'))

			RageUI.ButtonWithStyle("~r~Quitter", nil, {},true, function(h, a, s)
				if s then
					RageUI.CloseAll()
					isMenuOpened = false
				end
			end)
		end)
	
		RageUI.IsVisible(RMenu:Get('boutique', 'vehiclemenu'), true, true, true, function()
			for k, itemv in pairs(ConfigVIPShop["TRUCK"][1]) do
				RageUI.ButtonWithStyle(itemv.label, nil, { RightLabel = "~r~15000~b~Crédit(s)" },true, function(h, a, s)
					if s then
						curentvehicle_name = itemv.label
						curentvehicle_model = itemv.model
						curentvehicle_point = 15000
						curentvehicle_finalpoint = 15000
					end
				end, RMenu:Get('boutique', 'vehiclemenuparam'))
			end
			for k, itemv in pairs(ConfigVIPShop["TRUCK"][2]) do
				RageUI.ButtonWithStyle(itemv.label, nil, { RightLabel = "~r~25000~b~Crédit(s)" },true, function(h, a, s)
					if s then
						curentvehicle_name = itemv.label
						curentvehicle_model = itemv.model
						curentvehicle_point = 25000
						curentvehicle_finalpoint = 25000
					end
				end, RMenu:Get('boutique', 'vehiclemenuparam'))
			end
		end)

		RageUI.IsVisible(RMenu:Get('boutique', 'vehiclemenuparam'), true, true, true, function()
			RageUI.Separator("~b~"..curentvehicle_name.." ~r~"..curentvehicle_point.." ~b~Crédit(s)", nil, {}, true, function(_, _, _) end)
			RageUI.ButtonWithStyle("Essayer le véhicule", "Permet d'essayer le véhicule 20 secondes", { }, true, function(h, a, s)
				if s then
				 	posessaie = GetEntityCoords(PlayerPedId())
					Wait(500)
					spawnuniCar_boutique(curentvehicle_model)
				end
			end)
			RageUI.ButtonWithStyle("~b~Acheter", nil, {RightLabel = ""}, true, function(h, a, s)
				if s then
					local msg = KeyboardInput("atmos", "Acheter le véhicule (OUI) :", "", 20)
                    if msg and msg == 'OUI' then				
						if pointjoueur >= curentvehicle_finalpoint  then
							give_vehi_boutique(curentvehicle_model)
							buying_boutique(curentvehicle_finalpoint)
							RageUI.CloseAll()
							isMenuOpened = false
						else
							ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
						end	                    
                    end
				end
			end)
			RageUI.Separator("Cout de l'achat: ~r~"..curentvehicle_finalpoint.." ~b~Crédit(s)", nil, {}, true, function(_, _, _) end)
		end)
        Citizen.Wait(0)
    end
end)
end

---------------------------------------------------------------------

RMenu.Add('boutique', 'main', RageUI.CreateMenu("Boutique Elder's Life", "Menu boutique", nil,nil, "aLib", "black"))
RMenu.Add('boutique', 'vehiclemenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Véhicules", "Menu Véhicule"))
RMenu.Add('boutique', 'vehiclemenuparam', RageUI.CreateSubMenu(RMenu:Get('boutique', 'vehiclemenu'), "Paramètres", " "))
RMenu:Get('boutique', 'main').Closable = false

---------------------------------------------------------------------

RegisterNetEvent('boutique:retupoints')
AddEventHandler('boutique:retupoints', function(point)
	pointjoueur = point
end)

RegisterCommand("boutique", function(source, args, user)
	TriggerServerEvent('boutique:getpoints')
	OpenMenuBoutique()
end)