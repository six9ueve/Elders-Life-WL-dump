local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
ESX                     = nil

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)

	ESX.TriggerServerCallback('elders_shops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			ConfigShopsItems.Zones[k].Items = v
		end
	end)
end)

RMenu.Add("shop", "princ", RageUI.CreateMenu("Shop", "~b~Choix :", nil, nil, "aLib", "black"))
RMenu:Get("shop", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("shop", "ordre", RageUI.CreateSubMenu(RMenu:Get("shop", "princ"), "Shop", "~b~Paiement :"))
RMenu:Get("shop", "ordre").Closed = function()end

local function OpenShopMenuItems(zone)
		local elements = {}
		for i=1, #ConfigShopsItems.Zones[zone].Items, 1 do
			local item = ConfigShopsItems.Zones[zone].Items[i]

			if item.limit == -1 then
				item.limit = 100
			end
			local items = {}

			for i = 1, 10 do
				table.insert(items, i)
			end

			table.insert(elements, {
				label = item.label .. ' ~g~' .. '$' .. ESX.Math.GroupDigits(item.price ),
				label_real = item.label,
				item = item.item,
				price = item.price,

				type = 'list',
				items = items,
			})
		end

		if isMenuOpened then return end
	    isMenuOpened = true

	    RageUI.Visible(RMenu:Get("shop", "princ"), true)

	    Citizen.CreateThread(function()
	        while isMenuOpened do
	            RageUI.IsVisible(RMenu:Get("shop", "princ"),true,true,true,function()
	            	for k, v in pairs(elements) do
		            	RageUI.ButtonWithStyle(v.label, nil, {RightLabel = 'Acheter'}, true,function(a,h,s)
		                    if s then
		                    	local amount = KeyboardInput("atmos", "Combien voulais vous de cet objet : ("..v.label_real..")", "", 3)
		                    	if amount == nil then
                                        ESX.ShowNotification("Montant Invalide", 'Problème')
                                      	RageUI.CloseAll()
		                        		isMenuOpened = false
                                else
                                
	                            	amount = tonumber(amount)

	                            	if amount > 0 then
		                                achat = v
		                                index = amount
		                            else
		                                ESX.ShowNotification("Montant Invalide", 'Problème')
		                                RageUI.CloseAll()
			                        	isMenuOpened = false
		                            end
		                        end    
			                end
		                end, RMenu:Get("shop", "ordre"))
		            end
	            end, function()end, 1)
				RageUI.IsVisible(RMenu:Get("shop", "ordre"),true,true,true,function()
					RageUI.ButtonWithStyle('Acheter '..index..'x '..achat.label_real..' pour $ '..ESX.Math.GroupDigits(achat.price * index), nil, {RightLabel = 'Espèce'}, true,function(a,h,s)
	                    if s then
	                        TriggerServerEvent('elders_shops:buyItem', 'money', achat.item, index, zone)
	                        RageUI.CloseAll()
		                       isMenuOpened = false
	                    end
	                end)
	                if zone ~= 'Black3' and zone ~= 'Black_market' then
		                RageUI.ButtonWithStyle('Acheter '..index..'x '..achat.label_real..' pour $ '..ESX.Math.GroupDigits(achat.price * index), nil, {RightLabel = 'CB'}, true,function(a,h,s)
		                    if s then
		                        ESX.TriggerServerCallback('god_billing:hasTooManyBills', function(hasTooManyBills)
									if hasTooManyBills then
										ESX.ShowNotification('~r~La banque vous interdit les retraits avec autant de facture impayé !')
										return
									end
									TriggerServerEvent('elders_shops:buyItem', 'bank', achat.item, index, zone)
								end)
								RageUI.CloseAll()
		                        isMenuOpened = false
		                    end
		                end)
		            end
	            end, function()end, 1)
	            Wait(0)
	        end
	        CurrentAction = 'shop_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin'
			CurrentActionData = {zone = zone}
	    end)
		
end

AddEventHandler('elders_shops:hasEnteredMarker', function(zone)
	CurrentAction = 'shop_menu'
	CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin'
	CurrentActionData = {zone = zone}
end)

AddEventHandler('elders_shops:hasExitedMarker', function(zone)
	CurrentAction = nil
	RageUI.CloseAll()
	isMenuOpened = false
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = nil

		for k,v in pairs(ConfigShopsItems.Zones) do
			for i = 1, #v.Pos, 1 do
				if(#(coords - vector3(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)) < ConfigShopsItems.Size.x) then
					isInMarker = true
					ShopItems = v.Items
					currentZone = k
					LastZone = k
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('elders_shops:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('elders_shops:hasExitedMarker', LastZone)
		end

		if not isInMarker then
			Citizen.Wait(200)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = true
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(ConfigShopsItems.Zones) do
			for i = 1, #v.Pos, 1 do
				if #(v.Pos[i]  - playerCoords) < 20 then
					sleep = false
					DrawMarker(22,  v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)					
				end
			end
		end

		if sleep then
			Citizen.Wait(500)
		end

		Citizen.Wait(0)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'shop_menu' then
						OpenShopMenuItems(CurrentActionData.zone)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)