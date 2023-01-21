--tequilala

Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(coords, -565.00, 276.42, 83.12, true) < 25 then
            SetStaticEmitterEnabled("collision_9qv4ecm", false);  -- TEQUILLA
            Citizen.Wait(0)
        else
            Citizen.Wait(2000)
        end
    end
end)

--SOA
Citizen.CreateThread(function()


RequestIpl("gabz_biker_milo_")

	interiorID = GetInteriorAtCoords(994.47870000, -122.99490000, 73.11467000)
	
	
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "walls_02")
	SetInteriorPropColor(interiorID, "walls_02", 8)
	EnableInteriorProp(interiorID, "Furnishings_02")
	SetInteriorPropColor(interiorID, "Furnishings_02", 8)
	EnableInteriorProp(interiorID, "decorative_02")
	EnableInteriorProp(interiorID, "mural_03")
	EnableInteriorProp(interiorID, "lower_walls_default")
	SetInteriorPropColor(interiorID, "lower_walls_default", 8)
	EnableInteriorProp(interiorID, "mod_booth")
	EnableInteriorProp(interiorID, "gun_locker")
	EnableInteriorProp(interiorID, "cash_small")
	EnableInteriorProp(interiorID, "id_small")
	EnableInteriorProp(interiorID, "weed_small")
	
	RefreshInterior(interiorID)
	
	end
	
end)
--SOA
--casino
Citizen.CreateThread(function()


RequestIpl("vw_casino_main")
	interiorID = GetInteriorAtCoords(1100.00000000,220.00000000,-50.00000000)
	if IsValidInterior(interiorID) then
	EnableInteriorProp(interiorID, "0x30240D11")
	EnableInteriorProp(interiorID, "0xA3C89BB2")
	
		RefreshInterior(interiorID)
	end
end)
--Arcade-bar
local int_arcade1 = GetInteriorAtCoordsWithType(743.26500000,-816.71220000,21.66042000,"int_arcade")
local int_plan1 = GetInteriorAtCoordsWithType(710.87930000,-813.11000000,15.19892000,"int_plan")

RefreshInterior(int_arcade1)
RefreshInterior(int_plan1)

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_flat") --blue shell
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_beams") --brick
EnableInteriorProp(int_arcade1, "entity_set_screens") -- TV sets
EnableInteriorProp(int_arcade1, "entity_set_big_screen") -- big telly
EnableInteriorProp(int_arcade1, "entity_set_constant_geometry") -- glass shelves + bar
EnableInteriorProp(int_arcade1, "entity_set_ret_light_no_neon")
EnableInteriorProp(int_arcade1, "ch_chint02_00_dropped_ceiling")
EnableInteriorProp(int_arcade1, "entity_set_hip_light_no_neon")
EnableInteriorProp(int_arcade1, "arcade_bar")
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_streetx4") --assault rifles
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_mirror") --mirror ceiling

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_carpet") -- carpets
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --dirty shell
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --mud
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") --dirt
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") -- closed vending machines

EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_claw")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_monkey")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_patriot")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_retro")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_brawler")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_racer")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_love")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_cabs")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_gunner") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_teller")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_king") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_strife") --no

EnableInteriorProp(int_arcade1, "entity_set_plushie_01")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_02")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_03")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_04")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_05")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_06")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_07")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_08") -- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_09")-- a toy

DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_01") --signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_02")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_03")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_04")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_05")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_06")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_07")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_08")--signboard

DisableInteriorProp(int_arcade1, "entity_set_mural_option_01") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_02") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_03") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_04") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_05") --wall paint
EnableInteriorProp(int_arcade1, "entity_set_mural_option_06") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_07") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_08") --wall paint

DisableInteriorProp(int_arcade1, "entity_set_floor_option_01") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_02") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_03") --painted floor
EnableInteriorProp(int_arcade1, "entity_set_floor_option_04") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_05") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_06") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_07") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_08")--painted floor

EnableInteriorProp(int_plan1, "set_plan_casino") --casino on the table
EnableInteriorProp(int_plan1, "set_plan_computer") --comp
EnableInteriorProp(int_plan1, "set_plan_keypad")

EnableInteriorProp(int_plan1, "set_plan_hacker")
EnableInteriorProp(int_plan1, "set_plan_mechanic")
EnableInteriorProp(int_plan1, "set_plan_weapons")

EnableInteriorProp(int_plan1, "set_plan_vault")
EnableInteriorProp(int_plan1, "set_plan_wall") --stone wall
EnableInteriorProp(int_plan1, "set_plan_setup") --light for plan
EnableInteriorProp(int_plan1, "set_plan_bed") --the room
DisableInteriorProp(int_plan1, "set_plan_pre_setup") -- trash everywhere
DisableInteriorProp(int_plan1, "set_plan_no_bed") --trash in the bed
EnableInteriorProp(int_plan1, "set_plan_garage")
EnableInteriorProp(int_plan1, "set_plan_scribbles")
EnableInteriorProp(int_plan1, "set_plan_arcade_x4")
EnableInteriorProp(int_plan1, "set_plan_plans")
EnableInteriorProp(int_plan1, "set_plan_plastic_explosives")
EnableInteriorProp(int_plan1, "set_plan_cockroaches")
EnableInteriorProp(int_plan1, "set_plan_electric_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_laser")
EnableInteriorProp(int_plan1, "set_plan_stealth_outfits")
EnableInteriorProp(int_plan1, "set_plan_hacking_device")
EnableInteriorProp(int_plan1, "set_plan_gruppe_sechs_outfits")
EnableInteriorProp(int_plan1, "set_plan_fireman_helmet")
EnableInteriorProp(int_plan1, "set_plan_drone_parts")
EnableInteriorProp(int_plan1, "set_plan_vault_keycard_01a")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01b")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01a")
EnableInteriorProp(int_plan1, "set_plan_vault_drill_alt")
EnableInteriorProp(int_plan1, "set_plan_vault_laser_alt")


Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)



Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA avions
        2141866469, -- Sandy Shores avions
        1409640232, -- Grapeseed avions
        "ng_planes", -- Jet
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- Ils apparaissent sur LSIA et essaient de décoller
        "LUXOR", -- Ils apparaissent sur LSIA et essaient de décoller
        "LUXOR2", -- Ils apparaissent sur LSIA et essaient de décoller
        "JET", -- Ils apparaissent sur LSIA et essaient de décoller et d'atterrir.
        "LAZER", -- Ils apparaissent sur Zancudo et essaient de décoller
        "TITAN", -- Ils apparaissent sur Zancudo et essaient de décoller
        "BARRACKS", -- Conduit régulièrement autour de la surface de l'aéroport de Zancudo
        "BARRACKS2", -- Conduit régulièrement autour de la surface de l'aéroport de Zancudo
        "CRUSADER", -- Conduit régulièrement autour de la surface de l'aéroport de Zancudo
        "RHINO", -- Conduit régulièrement autour de la surface de l'aéroport de Zancudo
        "AIRTUG", -- Apparaît régulièrement sur la surface de l'aéroport LSIA
        "RIPLEY", -- Apparaît régulièrement sur la surface de l'aéroport LSIA
        "BLIMP", -- Les foutus dirigeable
        "BLIMP2", -- dirigeable
        "BLIMP3", -- Dirigeable
        "Buzzard", -- Hélico lambda je sais plus le nom de l'hélico noir qui crash no stop
        "Buzzard2", --
        "Maverick", -- hélico au dessus comico
        "polmav", --
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
    end
end)

--Salle Arcade-bar

local int_arcade1 = GetInteriorAtCoordsWithType(743.26500000,-816.71220000,21.66042000,"int_arcade")
local int_plan1 = GetInteriorAtCoordsWithType(710.87930000,-813.11000000,15.19892000,"int_plan")

RefreshInterior(int_arcade1)
RefreshInterior(int_plan1)

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_flat") --blue shell
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_beams") --brick
EnableInteriorProp(int_arcade1, "entity_set_screens") -- TV sets
EnableInteriorProp(int_arcade1, "entity_set_big_screen") -- big telly
EnableInteriorProp(int_arcade1, "entity_set_constant_geometry") -- glass shelves + bar
EnableInteriorProp(int_arcade1, "entity_set_ret_light_no_neon")
EnableInteriorProp(int_arcade1, "ch_chint02_00_dropped_ceiling")
EnableInteriorProp(int_arcade1, "entity_set_hip_light_no_neon")
EnableInteriorProp(int_arcade1, "arcade_bar")
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_streetx4") --assault rifles
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_ceiling_mirror") --mirror ceiling

DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_carpet") -- carpets
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --dirty shell
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict") --mud
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") --dirt
DisableInteriorProp(int_arcade1, "entity_set_arcade_set_derelict_clean_up") -- closed vending machines

EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_claw")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_monkey")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_patriot")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_retro")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_brawler")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_racer")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_love")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_cabs")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_gunner") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_teller")--no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_king") --no
EnableInteriorProp(int_arcade1, "entity_set_arcade_set_trophy_strife") --no

EnableInteriorProp(int_arcade1, "entity_set_plushie_01")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_02")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_03")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_04")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_05")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_06")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_07")-- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_08") -- a toy
EnableInteriorProp(int_arcade1, "entity_set_plushie_09")-- a toy

DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_01") --signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_02")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_03")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_04")--signboard
DisableInteriorProp(int_arcade1, "entity_set_mural_neon_option_05")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_06")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_07")--signboard
EnableInteriorProp(int_arcade1, "entity_set_mural_neon_option_08")--signboard

DisableInteriorProp(int_arcade1, "entity_set_mural_option_01") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_02") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_03") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_04") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_05") --wall paint
EnableInteriorProp(int_arcade1, "entity_set_mural_option_06") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_07") --wall paint
DisableInteriorProp(int_arcade1, "entity_set_mural_option_08") --wall paint

DisableInteriorProp(int_arcade1, "entity_set_floor_option_01") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_02") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_03") --painted floor
EnableInteriorProp(int_arcade1, "entity_set_floor_option_04") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_05") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_06") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_07") --painted floor
DisableInteriorProp(int_arcade1, "entity_set_floor_option_08")--painted floor

EnableInteriorProp(int_plan1, "set_plan_casino") --casino on the table
EnableInteriorProp(int_plan1, "set_plan_computer") --comp
EnableInteriorProp(int_plan1, "set_plan_keypad")

EnableInteriorProp(int_plan1, "set_plan_hacker")
EnableInteriorProp(int_plan1, "set_plan_mechanic")
EnableInteriorProp(int_plan1, "set_plan_weapons")

EnableInteriorProp(int_plan1, "set_plan_vault")
EnableInteriorProp(int_plan1, "set_plan_wall") --stone wall
EnableInteriorProp(int_plan1, "set_plan_setup") --light for plan
EnableInteriorProp(int_plan1, "set_plan_bed") --the room
DisableInteriorProp(int_plan1, "set_plan_pre_setup") -- trash everywhere
DisableInteriorProp(int_plan1, "set_plan_no_bed") --trash in the bed
EnableInteriorProp(int_plan1, "set_plan_garage")
EnableInteriorProp(int_plan1, "set_plan_scribbles")
EnableInteriorProp(int_plan1, "set_plan_arcade_x4")
EnableInteriorProp(int_plan1, "set_plan_plans")
EnableInteriorProp(int_plan1, "set_plan_plastic_explosives")
EnableInteriorProp(int_plan1, "set_plan_cockroaches")
EnableInteriorProp(int_plan1, "set_plan_electric_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_drill")
EnableInteriorProp(int_plan1, "set_plan_vault_laser")
EnableInteriorProp(int_plan1, "set_plan_stealth_outfits")
EnableInteriorProp(int_plan1, "set_plan_hacking_device")
EnableInteriorProp(int_plan1, "set_plan_gruppe_sechs_outfits")
EnableInteriorProp(int_plan1, "set_plan_fireman_helmet")
EnableInteriorProp(int_plan1, "set_plan_drone_parts")
EnableInteriorProp(int_plan1, "set_plan_vault_keycard_01a")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01b")
EnableInteriorProp(int_plan1, "set_plan_swipe_card_01a")
EnableInteriorProp(int_plan1, "set_plan_vault_drill_alt")
EnableInteriorProp(int_plan1, "set_plan_vault_laser_alt")