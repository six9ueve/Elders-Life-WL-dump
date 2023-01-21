local OpenLoc = false
local locmenu = false
local ConfigSpawnBase = { 
{pos= vector3(1855.133,2592.289,45.1552)},
{pos=vector3(-1114.638,-1687.32,4.51)}
}

local locationsSpawn = { 
{   pos= vector3(-1052.488,-2712.395,13.66)}, 
{   pos= vector3(233.0854492188,-751.3107910156,34.64)}, 
{   pos= vector3(-1272.194,-644.4275,26.81)}, 
{   pos= vector3(-171.880,214.995,89.225)}, 
{   pos= vector3(1997.2288,3778.3107910156,32.23)}, 
{   pos= vector3(1706.66,4793.281,41.98)}, 
{   pos= vector3(-189.540,6236.496,31.49)}, 
}

local locations4 = { -- coordsIn = Marker au sol | coordsOut = spawn du vehicule | 150 = heading
    {pos= vector3(-1612.1522,-1126.4547,2.3193), spawn= vector3(-1630.7325,-1147.1173,0.50)},
    {pos= vector3(-265.894,6633.076,7.507), spawn= vector3(-285.625,6606.151,0.515)},
    {pos= vector3(-1507.021,1502.819,115.288), spawn= vector3(-1536.218,1510.280,109.710)}
}

local telepherique1 = {
    {pos= vector3(-739.6201,5595.4140,41.6545)}
}
--téléphérique
local telepherique2 = {
    {pos= vector3(444.7795,5572.0200,781.1888)}
}

local locationsCayo = { -- coordsIn = Marker au sol | coordsOut = spawn du vehicule | 150 = heading
{pos= vector3(4518.95,-4463.76,4.18), spawn= vector3(4518.95,-4463.76,4.18)},
{pos= vector3(4986.83,-5178.22,2.50), spawn= vector3(4986.83,-5178.22,2.50)}
}

local locationsKART = { -- coordsIn = Marker au sol | coordsOut = spawn du vehicule | 150 = heading
{pos= vector3(-126.62,-2147.48,16.70), spawn= vector3(-126.62,-2147.48,16.70)}
}



RMenu.Add('location', 'main', RageUI.CreateMenu("LOCATIONS", "LOCATION DE VÉHICULE", nil, nil, "aLib", "black"))
RMenu:Get('location', 'main').Closed = function()OpenLoc = false RenderScriptCams(0, 1, 1200, 0, 0) end
RMenu.Add('location_menu', 'location_menu_main', RageUI.CreateMenu("TELEPHERIQUE", "LISTE", nil, nil, "aLib", "black"))
RMenu.Add('locationb_menu', 'locationb_menu_main', RageUI.CreateMenu("LOCATIONS", "LISTE DES BATEAUX", nil, nil, "aLib", "black"))
RMenu:Get('location_menu', 'location_menu_main').Closed = function()locmenu = false end
RMenu:Get('locationb_menu', 'locationb_menu_main').Closed = function()locmenu = false end

local function CamLoc()
    coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x+5.5, coords.y+1.5, coords.z+1.0)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.1)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 2000, 1, 1)
end

local function SpawnVeh(car, pos, heading)
    local hash = GetHashKey(car)
    Citizen.CreateThread(function()
        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(10) end
        local vehicle = CreateVehicle(hash, pos.x, pos.y, pos.z, heading, true, false)
        SetVehicleFuelLevel(vehicle, 100)
        SetVehicleFixed(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetVehicleDoorsLocked(vehicle, 0)
    end)
end

local function OpenLocMenuVelo(v)
	if not OpenLoc then
		OpenLoc = true
		RageUI.Visible(RMenu:Get('location', 'main'), true)
	Citizen.CreateThread(function()
		while OpenLoc do
			Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
                    RageUI.Separator("↓ ~b~Véhicule deux-roues ~s~↓")
                    RageUI.ButtonWithStyle("BMX | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("bmx", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Cruiser | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("cruiser", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                end
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Fixter | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("fixter", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                    RageUI.ButtonWithStyle("Scorcher | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("scorcher", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                    RageUI.ButtonWithStyle("Rribike | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("tribike", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                    RageUI.ButtonWithStyle("Tribike | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("tribike", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                    RageUI.ButtonWithStyle("Tribike2 | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("tribike2", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                    RageUI.ButtonWithStyle("Tribike3 | Vélo | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                             ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("tribike3", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true
                                    end
                            end)    
                        end
                    end)
                end)
			end
		end)
	end
end

local function OpenLocMenuSpawn(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location', 'main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
                    RageUI.Separator("↓ ~b~Véhicule deux-roues ~s~↓")
                    RageUI.ButtonWithStyle("Faggio | Scooter | 150$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneySpawn", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("faggio", v.pos, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)
                        end
                    end)                      
                end)
            end
        end)
    end
end

local function OpenLocMenuSpawnJet(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location', 'main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
                    RageUI.Separator("↓ ~b~Véhicule Jet Ski ~s~↓")
                    RageUI.ButtonWithStyle("jet ski | Bateau | 50$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneyVelo", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("seashark", v.spawn, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)
                        end
                    end)                      
                end)
            end
        end)
    end
end
local function Opentelepherique1(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location_menu', 'location_menu_main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location_menu', 'location_menu_main'), true, true, true, function()
                    RageUI.ButtonWithStyle("Téléphérique --- [ 5 $ ]", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneytelepherique", function(success)
                                if success then
                                        exports['progressBars']:startUI(20 * 1000, 'Vous prenez le téléphérique, veuillez patienter  ...')
                                        Citizen.Wait(20 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SetEntityCoords(PlayerPedId() , 449.1991, 5572.1684, 780.1888)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                    end
                                end)
                        end
                    end)                      
                end)
            end
        end)
    end
end
local function Opentelepherique2(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location_menu', 'location_menu_main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location_menu', 'location_menu_main'), true, true, true, function()
                    RageUI.ButtonWithStyle("Téléphérique --- [ 5 $ ]", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneytelepherique", function(success)
                                if success then
                                        exports['progressBars']:startUI(20 * 1000, 'Vous prenez le téléphérique, veuillez patienter  ...')
                                        Citizen.Wait(20 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SetEntityCoords(PlayerPedId() , -741.719, 5595.351, 40.6545)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                    end
                                end)
                        end
                    end)                      
                end)
            end
        end)
    end
end
local function OpenLocMenuSpawnCayot(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location', 'main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
                    RageUI.Separator("↓ ~b~Véhicule ~s~↓")
                    RageUI.ButtonWithStyle("Pickup | 4X4 | 150$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneySpawn", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("bodhi2", v.spawn, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)

                        end
                    end)  
                RageUI.ButtonWithStyle("Buggy | 4X4 | 150$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneySpawn", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("bifta", v.spawn, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)
                            
                        end
                    end)  
                RageUI.ButtonWithStyle("Quad | 4X4 | 150$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneySpawn", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("blazer", v.spawn, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)                            
                        end
                    end)                   
                end)
            end
        end)
    end
end
local function OpenLocMenuSpawnKart(v)
    if not OpenLoc then
        OpenLoc = true
        RageUI.Visible(RMenu:Get('location', 'main'), true)
    Citizen.CreateThread(function()
        while OpenLoc do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()
                    RageUI.Separator("↓ ~b~Véhicule ~s~↓")
                    RageUI.ButtonWithStyle("Kart | 4X4 | 150$", nil, {RightLabel = "→→"}, not SpawnVehicule, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback("EldersLocation:checkLocMoneySpawn", function(success)
                                if success then
                                        exports['progressBars']:startUI(5 * 1000, 'Chargement des éléments en cours..')
                                        Citizen.Wait(5 * 1000)
                                        DoScreenFadeOut(800)
                                        Wait(1000)
                                        DoScreenFadeIn(800)
                                        SpawnVeh("veto2", v.spawn, 0.70)
                                        RenderScriptCams(0, 1, 2000, 0, 0)
                                        RageUI.CloseAll()
                                        OpenLoc = false
                                        SpawnVehicule = true                                        
                                    end
                                end)

                        end
                    end)                     
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
                local OthersWait = 500               
                local plyCoords = GetEntityCoords(PlayerPedId(), false)

                    for _,v in pairs(locationsCayo) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu Location")
                                if IsControlJustPressed(1, 51) then 
                                    OpenLocMenuSpawnCayot(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(locationsKART) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu Location")
                                if IsControlJustPressed(1, 51) then 
                                    OpenLocMenuSpawnKart(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(telepherique2) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu téléphérique")
                                if IsControlJustPressed(1, 51) then 
                                    Opentelepherique2(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(telepherique1) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu téléphérique")
                                if IsControlJustPressed(1, 51) then 
                                    Opentelepherique1(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(locations4) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu Location")
                                if IsControlJustPressed(1, 51) then 
                                    OpenLocMenuSpawnJet(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(locationsSpawn) do
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu Location")
                                if IsControlJustPressed(1, 51) then 
                                    OpenLocMenuSpawn(v) 
                                end
                            end
                        end
                    end
                    for _,v in pairs(ConfigSpawnBase) do                         
                        local dist = #(plyCoords - v.pos)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ Pour ouvrir le menu Location de Vélo")
                                if IsControlJustPressed(1, 51) then 
                                    OpenLocMenuVelo(v) 
                                end
                            end
                        end
                    end
        Citizen.Wait(OthersWait)
    end
end)

