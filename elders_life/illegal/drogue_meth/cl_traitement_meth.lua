local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local CircleZones = {
	WeedField = {coords = vector3(-2948.28, 441.8, 15.26), name = 'blip_weedfield', color = 25, sprite = 496, radius = 30.0},
	WeedField2 = {coords = vector3(2655.30, 1592.20, 24.49), name = 'blip_weedfield', color = 25, sprite = 496, radius = 30.0},
	WeedProcessing = {coords = vector3(582.9591, 151.337, 96.78), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	DrugDealer = {coords = vector3(213.86, -148.74, 58.81), name = 'blip_drugdealer', color = 6, sprite = 378, radius = 25.0},
}


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

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob2')
AddEventHandler('god:setJob2', function(job2)

  PlayerData.job2 = job2
end)

isLoggedIn 						= true
local menuOpen					= false
local wasOpen 					= false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local il_traite 				= false
local il_traite_1 				= false
local il_traite_2  				= false
local il_traite_3				= false
PlayerData                = {}



-------------------------COORD CRAFT SODIUM
local sellX4 = 587.082  
local sellY4 = 158.2738
local sellZ4 = 96.78
------------------------Coord craf acide
local  WeedFieldX5 = 1319.284
local  WeedFieldY5 = -2547.344
local  WeedFieldZ5 = 46.55
------------------------Coord craf acide SULFURIQUE
local  WeedField2X5 = -488.893
local  WeedField2Y5 = 5273.754
local  WeedField2Z5 = 81.04
-------------------------------

local isPickingUp, isProcessing, isProcessing2 = false, false, false


local function DrawText3D2_meth(x, y, z, text)
  
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

local function DrawText3D_meth(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end
----------------------------------------------------------------------------------
local function Traitement_acide_hydrocloric()
	if not il_traite then
	        ESX.TriggerServerCallback('WS:CheckItem', function(data)
	            local player = PlayerPedId()
	            il_traite = true
	            Citizen.Wait(500)

	            local finished = exports["reload-skillbar"]:taskBar(6000,math.random(10,20))
	            if finished ~= 100 then
	                TriggerServerEvent('traitement_meth:removeitem', 'hydrochloric_bottle', 1)
	                il_traite = false
	                ClearPedTasksImmediately(player)
	                ESX.ShowNotification('Tu va trop vite!')
	                    else
							Citizen.Wait(1000)
							text = 'Traitement d\'acide hydrochloric'		
							TriggerServerEvent('drogue', text)
	                        TriggerServerEvent('WS_meth:meth_Hydrocloric')
	                        il_traite = false
	                        ClearPedTasks(player)
	                        ESX.ShowNotification('Vous avez remplis une bouteilles avec succès!')
	                    end
	        end, "hydrochloric_bottle", 1)
	    end
end

local function traitement_acide_sulfurique()
	if not il_traite_1 then
        ESX.TriggerServerCallback('WS:CheckItem', function(data)
            local player = PlayerPedId()
            il_traite_1 = true
            Citizen.Wait(500)

            local finished = exports["reload-skillbar"]:taskBar(6000,math.random(10,20))
            if finished ~= 100 then
                TriggerServerEvent('traitement_meth:removeitem', 'sulfuricacid_bottle', 1)
                il_traite_1 = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Tu va trop vite!')
                    else
						Citizen.Wait(1000)
						text = 'Traitement d\'acide sulfurique'		
						TriggerServerEvent('drogue', text)
                        TriggerServerEvent('WS_meth:meta_sodium')
                        il_traite_1 = false
                        ClearPedTasks(player)
                        ESX.ShowNotification('Vous avez remplis 1 bouteilles avec succès!')
                    end
        end, "sulfuricacid_bottle", 1)
    end   
end

-------------------------------------------animazione più craft-----------------------------------------------------
local function traitement_hydroxyde_sodium()
	if not il_traite_2 then
        ESX.TriggerServerCallback('WS:CheckItem', function(data)
            local player = PlayerPedId()
            il_traite_2 = true
            Citizen.Wait(500)

            local finished = exports["reload-skillbar"]:taskBar(6000,math.random(10,20))
            if finished ~= 100 then
                TriggerServerEvent('traitement_meth:removeitem', 'sac_conservation', 1)
                il_traite_2 = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Tu va trop vite!')
            else
				Citizen.Wait(1000)
				text = 'Traitement de sodium hydroxide'		
				TriggerServerEvent('drogue', text)
				TriggerServerEvent('craft:sodium')
				il_traite_2 = false
				ClearPedTasks(player)
				ESX.ShowNotification('Vous avez recupéré un sodium hydroxide avec succès!')
			end
        end, "sac_conservation", 1)
    end   
end

local function fabrication_meth()
	  -- simple animations to loop while process is taking place
	if PlayerData.job2 ~= nil and PlayerData.job2.name == 'cartel' or PlayerData.job2.name == 'cartel_1' or PlayerData.job2.name == 'cartel_2' or PlayerData.job2.name == 'cartel_3' or PlayerData.job2.name == 'mafia' or PlayerData.job2.name == 'mafia_1' or PlayerData.job2.name == 'mafia_2' or PlayerData.job2.name == 'mafia_3' then
		if not il_traite_3 then
		        ESX.TriggerServerCallback('WS:CheckItem', function(data)
		            Citizen.Wait(25)
		        ESX.TriggerServerCallback('WS:CheckItem', function(data)
		       		Citizen.Wait(25)
		        ESX.TriggerServerCallback('WS:CheckItem', function(data)
		        	Citizen.Wait(25)
		            local player = PlayerPedId()
		            il_traite_3 = true
		            Citizen.Wait(500)

		            local finished = exports["reload-skillbar"]:taskBar(6000,math.random(10,20))
		            if finished ~= 100 then
		                TriggerServerEvent('traitement_meth:removeitem', 'sulfuricacid', 1)
		                	        	Citizen.Wait(25)
		               	TriggerServerEvent('traitement_meth:removeitem', 'hydrochloric', 1)
		               		        	Citizen.Wait(25)
		                TriggerServerEvent('traitement_meth:removeitem', 'sodiumhydroxide', 1)

		                il_traite_3 = false
		                ClearPedTasksImmediately(player)
		                ESX.ShowNotification('Tu va trop vite!')
		                    else
		                    	text = 'Dernier traitement de meth'		
								TriggerServerEvent('drogue', text)
		                        TriggerServerEvent('drugs_meth:metprocess')
		                        il_traite_3 = false
		                        ClearPedTasks(player)
		                        ESX.ShowNotification('Vous avez recupéré un sachet de meth avec succès!')
		                    end
		        
		        end, "sulfuricacid", 1)
		        end, "hydrochloric", 1)
		        end, "sodiumhydroxide", 1)

		    end
	else
	   ESX.ShowNotification('Vous ne connaissez pas la recette!')
	end  	
end

--[[Citizen.CreateThread(function() --- check that makes sure you have the materials needed to process
	while true do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local sleep = 750        
		local PlayerData = ESX.GetPlayerData()


			if GetDistanceBetweenCoords(coords, CircleZones.WeedProcessing.coords, true) < 10 then
				sleep = 0
			end

			if GetDistanceBetweenCoords(coords, CircleZones.WeedProcessing.coords, true) < 2 then
				DrawMarker(20, CircleZones.WeedProcessing.coords.x, CircleZones.WeedProcessing.coords.y, CircleZones.WeedProcessing.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 100, 0, 0, 0, true, 0, 0, 0)
				
				if not isProcessing then
					DrawText3D_meth(CircleZones.WeedProcessing.coords.x, CircleZones.WeedProcessing.coords.y, CircleZones.WeedProcessing.coords.z, 'Appuyez sur [~g~E~s~] pour fabriquer de la Meth')
				end

					if IsControlJustReleased(0, 38) and not isProcessing then
						fabrication_meth()
					end
			end
		Citizen.Wait(sleep)

	end
end)]]--

-----------------------------------------------PROCESS CRAFT SODIUM-----------------------------------------------
--[[Citizen.CreateThread(function()
    while true do

        local plyCoords = GetEntityCoords(PlayerPedId() , false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX4, sellY4, sellZ4)       
        local vehicled = GetVehiclePedIsIn(PlayerPedId() , true)
        local playerPeds = PlayerPedId()
        local sleep = 750
 
	        if dist <= 3.0 then
			    if GetPedInVehicleSeat(vehicled, -1) == PlayerPedId()  then
	            else
	            	sleep = 0
	                DrawText3D2_meth(sellX4, sellY4, sellZ4,'Appuyez sur [~g~E~s~] pour fabriquer de l\'Hidroxyde de sodium')
	               
	                if IsControlJustPressed(0, Keys['E']) then 

		                local hasBagd7 = false
		                local s1d7 = false

		                ESX.TriggerServerCallback('WS:CheckItem', function(result)
								hasBagd7 = result
								s1d = true
							 if (hasBagd7) then
	                            traitement_hydroxyde_sodium()
	                        else
	                        	ESX.ShowNotification("Ils vous manquent des sacs de conservations!")
	                        end
							end, "sac_conservation", 1)                                                            
	            	end	               
			end
		end	

		Citizen.Wait(sleep)


    end
end)]]--

Citizen.CreateThread(function()
    while true do

        local plyCoords = GetEntityCoords(PlayerPedId() , false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, WeedFieldX5, WeedFieldY5, WeedFieldZ5)       
        local vehicled = GetVehiclePedIsIn(PlayerPedId() , true)
        local playerPeds = PlayerPedId()
        local sleep_WeedFieldX5 = 750
 
	         if dist <= 15.0 then 
	        	sleep_WeedFieldX5 = 0
	  
		        if dist <= 1.5 then
				    if GetPedInVehicleSeat(vehicled, -1) == PlayerPedId()  then
		            else
		                DrawText3D2_meth(WeedFieldX5, WeedFieldY5, WeedFieldZ5,'appuyez sur [~g~E~s~] pour remplir votre bouteille d\'Acide Hydrocloric')
		               
		                if IsControlJustPressed(0, Keys['E']) then  
		                	Traitement_acide_hydrocloric()
		                end	
		               
		            end
				
				end
			end	

		Citizen.Wait(sleep_WeedFieldX5)


    end
end)
-------------------------------------------------ACIDE SULFURIQUE
Citizen.CreateThread(function()
    while true do

        local plyCoords = GetEntityCoords(PlayerPedId() , false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, WeedField2X5, WeedField2Y5, WeedField2Z5)       
        local vehicled = GetVehiclePedIsIn(PlayerPedId() , true)
        local playerPeds = PlayerPedId()
        local sleep_WeedField2X5 = 750
  
	        if dist <= 15.0 then 
	        	sleep_WeedField2X5 = 0
	  
		        if dist <= 1.5 then
				    if GetPedInVehicleSeat(vehicled, -1) == PlayerPedId()  then
		            else
		                DrawText3D2_meth(WeedField2X5, WeedField2Y5, WeedField2Z5,'appuyez sur [~g~E~s~] pour remplir votre bouteille d\'Acide Sulfurique')
		               
		                if IsControlJustPressed(0, Keys['E']) then
		                	traitement_acide_sulfurique()
		                end		               
		            end			
				end
			end
		Citizen.Wait(sleep_WeedField2X5)
    end
end)