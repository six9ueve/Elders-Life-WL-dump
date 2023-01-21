ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()


end)

local function ShowHelpNotification(text)
	AddTextEntry("HelpNotification", text)
    DisplayHelpTextThisFrame("HelpNotification", false)
end

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local function coolcoolmec(time)
    cooldown = true
    Citizen.SetTimeout(time,function()
        cooldown = false
    end)
end

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(playerData)
    isLoggedIn = true
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setJob2')
AddEventHandler('god:setJob2', function(job2)
    PlayerData.job2 = job2
end)

local function openInfo_orga()
    local main = RageUI.CreateMenu('', 'Informateur')
        RageUI.Visible(main, not RageUI.Visible(main))
        while main do
            Citizen.Wait(0)
            RageUI.IsVisible(main, true, true, true, function()  
				for _,v in pairs(Config.Informateur) do
					for _,info in pairs(Config.InformationOrga) do
						RageUI.ButtonWithStyle(info.name, nil, { RightLabel = "~r~"..info.price.."$" }, true, function(Hovered, Active, Selected)
							if (Selected) then
								ESX.TriggerServerCallback('eInfo:CheckMoney', function(hasMoney)
									if hasMoney then
										TriggerEvent("chatMessage", "", {255, 0, 0}, "Informateur : ^7"..info.info)
										ShowNotification("Vous avez payé ~r~"..info.price.."$")
										coolcoolmec(4000) 
									else
										ShowNotification("Vous n'avez pas assez d'argent")
									end
								end, info.price,info.name)
							end
						end)
					end
				end
            end, function()
            end)
            if not RageUI.Visible(main) then
            main = RMenu:DeleteType(main, true)
        end
    end
end

local function openInfo_Famille()
    local main = RageUI.CreateMenu('', 'Informateur')
        RageUI.Visible(main, not RageUI.Visible(main))
        while main do
            Citizen.Wait(0)
            RageUI.IsVisible(main, true, true, true, function()  
				for _,v in pairs(Config.Informateur) do
					for _,info in pairs(Config.InformationFamille) do
						RageUI.ButtonWithStyle(info.name, nil, { RightLabel = "~r~"..info.price.."$" }, true, function(Hovered, Active, Selected)
							if (Selected) then
								ESX.TriggerServerCallback('eInfo:CheckMoney', function(hasMoney)
									if hasMoney then
										TriggerEvent("chatMessage", "", {255, 0, 0}, "Informateur : ^7"..info.info)
										ShowNotification("Vous avez payé ~r~"..info.price.."$")
										coolcoolmec(4000) 
									else
										ShowNotification("Vous n'avez pas assez d'argent")
									end
								end, info.price,info.name)
							end
						end)
					end
				end
            end, function()
            end)
            if not RageUI.Visible(main) then
            main = RMenu:DeleteType(main, true)
        end
    end
end

local function openInfo()
    local main = RageUI.CreateMenu('', 'Informateur')
        RageUI.Visible(main, not RageUI.Visible(main))
        while main do
            Citizen.Wait(0)
            RageUI.IsVisible(main, true, true, true, function()  
				for _,v in pairs(Config.Informateur) do
					for _,info in pairs(Config.Information) do
						RageUI.ButtonWithStyle(info.name, nil, { RightLabel = "~r~"..info.price.."$" }, true, function(Hovered, Active, Selected)
							if (Selected) then
								ESX.TriggerServerCallback('eInfo:CheckMoney', function(hasMoney)
									if hasMoney then
										TriggerEvent("chatMessage", "", {255, 0, 0}, "Informateur : ^7"..info.info)
										ShowNotification("Vous avez payé ~r~"..info.price.."$")
										coolcoolmec(4000) 
									else
										ShowNotification("Vous n'avez pas assez d'argent")
									end
								end, info.price,info.name)
							end
						end)
					end
				end
            end, function()
            end)
            if not RageUI.Visible(main) then
            main = RMenu:DeleteType(main, true)
        end
    end
end

Citizen.CreateThread(function()
	local illegal = PlayerData.job2.name
	for _,v in pairs(Config.Informateur) do
		local model = GetHashKey(v.ped)
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(1) end
		local ped = CreatePed(5, model, v.coords.x, v.coords.y, v.coords.z-1, v.heading, 0, 0)
		SetEntityInvincible(ped, 1)
		FreezeEntityPosition(ped, 1)
		SetBlockingOfNonTemporaryEvents(ped, 1)
	end
	while true do
		local Waiting = 500
		for k,v in pairs(Config.Informateur) do
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			local dst = #(plyCoords - v.coords)
			--local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.coords, true)
			if PlayerData.job2 ~= nil and (PlayerData.job2.name ~= 'unemployed') or (PlayerData.job2.name ~= 'unemployed2') then
				if illegal ~= nil and illegal == 'cartel' or illegal == 'cartel_1' or illegal == 'cartel_2' or illegal == 'cartel_3' or illegal == 'mafia' or illegal == 'mafia_1' or illegal == 'mafia_2' or illegal == 'mafia_3' then

					if dst <= 2.0 then
						Waiting = 1
						ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour parler à l'indic")
						if IsControlJustPressed(1, 38) then
							openInfo_orga()
						end
					end
				end
				if illegal ~= nil and illegal == 'oneil' or illegal == 'famille_1' or illegal == 'famille_2' or illegal == 'biker_2' or illegal == 'gitan' or illegal == 'biker_3' or illegal == 'biker_1' or illegal == 'biker' then

					if dst <= 2.0 then
						Waiting = 1
						ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour parler à l'indic")
						if IsControlJustPressed(1, 38) then
							openInfo_Famille()
						end
					end
				end

					if dst <= 2.0 then
						Waiting = 1
						ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour parler à l'indic")
						if IsControlJustPressed(1, 38) then
							openInfo()
						end
					end
			end
		end
		Citizen.Wait(Waiting)
	end
end)