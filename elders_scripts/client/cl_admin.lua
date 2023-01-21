ESX = nil
attach = false
suivitext = "Suivre"

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)


local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local function GetCloseVehi()
    local player = PlayerPedId()
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 15.0, 0, 70)
    local vCoords = GetEntityCoords(vehicle)
    DrawMarker(20, vCoords.x, vCoords.y, vCoords.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
end

-- Voir les noms
local gamerTags = {}
local function showNames(bool)
    isNameShown = bool
    if isNameShown then
        Citizen.CreateThread(function()
            while isNameShown do
                local plyPed = PlayerPedId()
                for _, player in pairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    if ped ~= plyPed then
                        if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 1500.0 then
                            gamerTags[player] = CreateFakeMpGamerTag(ped, ('[%s] %s'):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, '', 0)
                            SetMpGamerTagAlpha(gamerTags[player], 0, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 2, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 4, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 7, 255)
                            SetMpGamerTagVisibility(gamerTags[player], 0, true)
                            SetMpGamerTagVisibility(gamerTags[player], 2, true)
                            SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
                            SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
                            SetMpGamerTagColour(gamerTags[player], 7, 55)
                            if NetworkIsPlayerTalking(player) then
                                SetMpGamerTagHealthBarColour(gamerTags[player], 211)
                                SetMpGamerTagColour(gamerTags[player], 4, 211)
                                SetMpGamerTagColour(gamerTags[player], 0, 211)
                            else
                                SetMpGamerTagHealthBarColour(gamerTags[player], 0)
                                SetMpGamerTagColour(gamerTags[player], 4, 0)
                                SetMpGamerTagColour(gamerTags[player], 0, 0)
                            end
                            if DecorExistOn(ped, "staffl") then
                                SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
                            end
                            if mpDebugMode then
                                print(json.encode(DecorExistOn(ped, "staffl")).." - "..json.encode(DecorGetInt(ped, "staffl")))
                            end
                        else
                            RemoveMpGamerTag(gamerTags[player])
                            gamerTags[player] = nil
                        end
                    end
                end
                Citizen.Wait(100)
            end
            for k,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end)
    end
end

local noclipActive = false

local index = 1

 local function NoClip()
    if attach == false then
        noclipActive = not noclipActive

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            noclipEntity = PlayerPedId()
        end

        SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
        FreezeEntityPosition(noclipEntity, noclipActive)
        SetEntityInvincible(noclipEntity, noclipActive)
        SetVehicleRadioEnabled(noclipEntity, not noclipActive)
        NetworkSetEntityInvisibleToNetwork(noclipEntity, noclipActive)
        SetEntityCanBeDamaged(noclipEntity, not noclipActive)
        if not noclipActive then
            SetEntityAlpha(noclipEntity, 255, false)
        else
            SetEntityAlpha(noclipEntity, 50, false)
        end
        SetEntityVisible(noclipEntity, not noclipActive, false)
    else
        ESX.ShowNotification("~y~[Staff]~s~ : Arrétez le suivi de joueur avant de sortir du NoClip !")
    end
end

-- ped list
local ListePed = {
    "a_f_m_beach_01",
    "a_f_m_bevhills_01",
    "a_f_m_bevhills_02",
    "a_f_m_bodybuild_01",
    "a_f_m_business_02",
    "a_f_m_downtown_01",
    "a_f_m_eastsa_01",
    "a_f_m_eastsa_02",
    "a_f_m_fatbla_01",
    "a_f_m_fatcult_01",
    "a_f_m_fatwhite_01",
    "a_f_m_ktown_01",
    "a_f_m_ktown_02",
    "a_f_m_prolhost_01",
    "a_f_m_salton_01",
    "a_f_m_skidrow_01",
    "a_f_m_soucent_01",
    "a_f_m_soucent_02",
    "a_f_m_soucentmc_01",
    "a_f_m_tourist_01",
    "a_f_m_tramp_01",
    "a_f_m_trampbeac_01",
    "a_f_o_genstreet_01",
    "a_f_o_indian_01",
    "a_f_o_ktown_01",
    "a_f_o_salton_01",
    "a_f_o_soucent_01",
    "a_f_o_soucent_02",
    "a_f_y_beach_01",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_bevhills_03",
    "a_f_y_bevhills_04",
    "a_f_y_business_01",
    "a_f_y_business_02",
    "a_f_y_business_03",
    "a_f_y_business_04",
    "a_f_y_clubcust_01",
    "a_f_y_clubcust_02",
    "a_f_y_clubcust_03",
    "a_f_y_eastsa_01",
    "a_f_y_eastsa_02",
    "a_f_y_eastsa_03",
    "a_f_y_epsilon_01",
    "a_f_y_femaleagent",
    "a_f_y_fitness_01",
    "a_f_y_fitness_02",
    "a_f_y_genhot_01",
    "a_f_y_golfer_01",
    "a_f_y_hiker_01",
    "a_f_y_hippie_01",
    "a_f_y_hipster_01",
    "a_f_y_hipster_02",
    "a_f_y_hipster_03",
    "a_f_y_hipster_04",
    "a_f_y_indian_01",
    "a_f_y_juggalo_01",
    "a_f_y_runner_01",
    "a_f_y_rurmeth_01",
    "a_f_y_scdressy_01",
    "a_f_y_skater_01",
    "a_f_y_soucent_01",
    "a_f_y_soucent_02",
    "a_f_y_soucent_03",
    "a_f_y_tennis_01",
    "a_f_y_topless_01",
    "a_f_y_tourist_01",
    "a_f_y_tourist_02",
    "a_f_y_vinewood_01",
    "a_f_y_vinewood_02",
    "a_f_y_vinewood_03",
    "a_f_y_vinewood_04",
    "a_f_y_yoga_01",
    "a_f_y_gencaspat_01",
    "a_f_y_smartcaspat_01",
    "a_m_m_acult_01",
    "a_m_m_afriamer_01",
    "a_m_m_beach_01",
    "a_m_m_beach_02",
    "a_m_m_bevhills_01",
    "a_m_m_bevhills_02",
    "a_m_m_business_01",
    "a_m_m_eastsa_01",
    "a_m_m_eastsa_02",
    "a_m_m_farmer_01",
    "a_m_m_fatlatin_01",
    "a_m_m_genfat_01",
    "a_m_m_genfat_02",
    "a_m_m_golfer_01",
    "a_m_m_hasjew_01",
    "a_m_m_hillbilly_01",
    "a_m_m_hillbilly_02",
    "a_m_m_indian_01",
    "a_m_m_ktown_01",
    "a_m_m_malibu_01",
    "a_m_m_mexcntry_01",
    "a_m_m_mexlabor_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_m_polynesian_01",
    "a_m_m_prolhost_01",
    "a_m_m_rurmeth_01",
    "a_m_m_salton_01",
    "a_m_m_salton_02",
    "a_m_m_salton_03",
    "a_m_m_salton_04",
    "a_m_m_skater_01",
    "a_m_m_skidrow_01",
    "a_m_m_socenlat_01",
    "a_m_m_soucent_01",
    "a_m_m_soucent_02",
    "a_m_m_soucent_03",
    "a_m_m_soucent_04",
    "a_m_m_stlat_02",
    "a_m_m_tennis_01",
    "a_m_m_tourist_01",
    "a_m_m_tramp_01",
    "a_m_m_trampbeac_01",
    "a_m_m_tranvest_01",
    "a_m_m_tranvest_02",
    "a_m_o_acult_01",
    "a_m_o_acult_02",
    "a_m_o_beach_01",
    "a_m_o_genstreet_01",
    "a_m_o_ktown_01",
    "a_m_o_salton_01",
    "a_m_o_soucent_01",
    "a_m_o_soucent_02",
    "a_m_o_soucent_03",
    "a_m_o_tramp_01",
    "a_m_y_acult_01",
    "a_m_y_acult_02",
    "a_m_y_beach_01",
    "a_m_y_beach_02",
    "a_m_y_beach_03",
    "a_m_y_beachvesp_01",
    "a_m_y_beachvesp_02",
    "a_m_y_bevhills_01",
    "a_m_y_bevhills_02",
    "a_m_y_breakdance_01",
    "a_m_y_busicas_01",
    "a_m_y_business_01",
    "a_m_y_business_02",
    "a_m_y_business_03",
    "a_m_y_clubcust_01",
    "a_m_y_clubcust_02",
    "a_m_y_clubcust_03",
    "a_m_y_cyclist_01",
    "a_m_y_dhill_01",
    "a_m_y_downtown_01",
    "a_m_y_eastsa_01",
    "a_m_y_eastsa_02",
    "a_m_y_epsilon_01",
    "a_m_y_epsilon_02",
    "a_m_y_gay_01",
    "a_m_y_gay_02",
    "a_m_y_genstreet_01",
    "a_m_y_genstreet_02",
    "a_m_y_golfer_01",
    "a_m_y_hasjew_01",
    "a_m_y_hiker_01",
    "a_m_y_hippy_01",
    "a_m_y_hipster_01",
    "a_m_y_hipster_02",
    "a_m_y_hipster_03",
    "a_m_y_indian_01",
    "a_m_y_jetski_01",
    "a_m_y_juggalo_01",
    "a_m_y_ktown_01",
    "a_m_y_ktown_02",
    "a_m_y_latino_01",
    "a_m_y_methhead_01",
    "a_m_y_mexthug_01",
    "a_m_y_motox_01",
    "a_m_y_motox_02",
    "a_m_y_musclbeac_01",
    "a_m_y_musclbeac_02",
    "a_m_y_polynesian_01",
    "a_m_y_roadcyc_01",
    "a_m_y_runner_01",
    "a_m_y_runner_02",
    "a_m_y_salton_01",
    "a_m_y_skater_01",
    "a_m_y_skater_02",
    "a_m_y_soucent_01",
    "a_m_y_soucent_02",
    "a_m_y_soucent_03",
    "a_m_y_soucent_04",
    "a_m_y_stbla_01",
    "a_m_y_stbla_02",
    "a_m_y_stlat_01",
    "a_m_y_stwhi_01",
    "a_m_y_stwhi_02",
    "a_m_y_sunbathe_01",
    "a_m_y_surfer_01",
    "a_m_y_vindouche_01",
    "a_m_y_vinewood_01",
    "a_m_y_vinewood_02",
    "a_m_y_vinewood_03",
    "a_m_y_vinewood_04",
    "a_m_y_yoga_01",
    "a_m_m_mlcrisis_01",
    "a_m_y_gencaspat_01",
    "a_m_y_smartcaspat_01",
    "a_c_boar",
    "a_c_cat_01",
    "a_c_chickenhawk",
    "a_c_chimp",
    "a_c_chop",
    "a_c_cormorant",
    "a_c_cow",
    "a_c_coyote",
    "a_c_crow",
    "a_c_deer",
    "a_c_dolphin",
    "a_c_fish",
    "a_c_hen",
    "a_c_humpback",
    "a_c_husky",
    "a_c_killerwhale",
    "a_c_mtlion",
    "a_c_pig",
    "a_c_pigeon",
    "a_c_poodle",
    "a_c_pug",
    "a_c_rabbit_01",
    "a_c_rat",
    "a_c_retriever",
    "a_c_rhesus",
    "a_c_rottweiler",
    "a_c_seagull",
    "a_c_sharkhammer",
    "a_c_sharktiger",
    "a_c_shepherd",
    "a_c_stingray",
    "a_c_westy",
    "cs_amandatownley",
    "cs_andreas",
    "cs_ashley",
    "cs_bankman",
    "cs_barry",
    "cs_beverly",
    "cs_brad",
    "cs_bradcadaver",
    "cs_carbuyer",
    "cs_casey",
    "cs_chengsr",
    "cs_chrisformage",
    "cs_clay",
    "cs_dale",
    "cs_davenorton",
    "cs_debra",
    "cs_denise",
    "cs_devin",
    "cs_dom",
    "cs_dreyfuss",
    "cs_drfriedlander",
    "cs_fabien",
    "cs_fbisuit_01",
    "cs_floyd",
    "cs_guadalope",
    "cs_gurk",
    "cs_hunter",
    "cs_janet",
    "cs_jewelass",
    "cs_jimmyboston",
    "cs_jimmydisanto",
    "cs_joeminuteman",
    "cs_johnnyklebitz",
    "cs_josef",
    "cs_josh",
    "cs_karen_daniels",
    "cs_lamardavis",
    "cs_lazlow",
    "cs_lazlow_2",
    "cs_lestercrest",
    "cs_lifeinvad_01",
    "cs_magenta",
    "cs_manuel",
    "cs_marnie",
    "cs_martinmadrazo",
    "cs_maryann",
    "cs_michelle",
    "cs_milton",
    "cs_molly",
    "cs_movpremf_01",
    "cs_movpremmale",
    "cs_mrk",
    "cs_mrs_thornhill",
    "cs_mrsphillips",
    "cs_natalia",
    "cs_nervousron",
    "cs_nigel",
    "cs_old_man1a",
    "cs_old_man2",
    "cs_omega",
    "cs_orleans",
    "cs_paper",
    "cs_patricia",
    "cs_priest",
    "cs_prolsec_02",
    "cs_russiandrunk",
    "cs_siemonyetarian",
    "cs_solomon",
    "cs_stevehains",
    "cs_stretch",
    "cs_tanisha",
    "cs_taocheng",
    "cs_taostranslator",
    "cs_tenniscoach",
    "cs_terry",
    "cs_tom",
    "cs_tomepsilon",
    "cs_tracydisanto",
    "cs_wade",
    "cs_zimbor",
    "csb_abigail",
    "csb_agent",
    "csb_alan",
    "csb_anita",
    "csb_anton",
    "csb_avon",
    "csb_ballasog",
    "csb_bogdan",
    "csb_bride",
    "csb_bryony",
    "csb_burgerdrug",
    "csb_car3guy1",
    "csb_car3guy2",
    "csb_chef",
    "csb_chef2",
    "csb_chin_goon",
    "csb_cletus",
    "csb_cop",
    "csb_customer",
    "csb_denise_friend",
    "csb_dix",
    "csb_djblamadon",
    "csb_englishdave",
    "csb_fos_rep",
    "csb_g",
    "csb_groom",
    "csb_grove_str_dlr",
    "csb_hao",
    "csb_hugh",
    "csb_imran",
    "csb_jackhowitzer",
    "csb_janitor",
    "csb_maude",
    "csb_money",
    "csb_mp_agent14",
    "csb_mrs_r",
    "csb_mweather",
    "csb_ortega",
    "csb_oscar",
    "csb_paige",
    "csb_popov",
    "csb_porndudes",
    "csb_prologuedriver",
    "csb_prolsec",
    "csb_ramp_gang",
    "csb_ramp_hic",
    "csb_ramp_hipster",
    "csb_ramp_marine",
    "csb_ramp_mex",
    "csb_rashcosvki",
    "csb_reporter",
    "csb_roccopelosi",
    "csb_screen_writer",
    "csb_sol",
    "csb_stripper_01",
    "csb_stripper_02",
    "csb_talcc",
    "csb_talmm",
    "csb_tonya",
    "csb_tonyprince",
    "csb_trafficwarden",
    "csb_undercover",
    "csb_vagspeak",
    "csb_agatha",
    "csb_avery",
    "csb_brucie2",
    "csb_thornton",
    "csb_tomcasino",
    "csb_vincent",
    "g_f_importexport_01",
    "g_f_importexport_01",
    "g_f_y_ballas_01",
    "g_f_y_families_01",
    "g_f_y_lost_01",
    "g_f_y_vagos_01",
    "g_m_importexport_01",
    "g_m_m_armboss_01",
    "g_m_m_armgoon_01",
    "g_m_m_armlieut_01",
    "g_m_m_chemwork_01",
    "g_m_m_chiboss_01",
    "g_m_m_chicold_01",
    "g_m_m_chigoon_01",
    "g_m_m_chigoon_02",
    "g_m_m_korboss_01",
    "g_m_m_mexboss_01",
    "g_m_m_mexboss_02",
    "g_m_y_armgoon_02",
    "g_m_y_azteca_01",
    "g_m_y_ballaeast_01",
    "g_m_y_ballaorig_01",
    "g_m_y_ballasout_01",
    "g_m_y_famca_01",
    "g_m_y_famdnf_01",
    "g_m_y_famfor_01",
    "g_m_y_korean_01",
    "g_m_y_korean_02",
    "g_m_y_korlieut_01",
    "g_m_y_lost_01",
    "g_m_y_lost_02",
    "g_m_y_lost_03",
    "g_m_y_mexgang_01",
    "g_m_y_mexgoon_01",
    "g_m_y_mexgoon_02",
    "g_m_y_mexgoon_03",
    "g_m_y_pologoon_01",
    "g_m_y_pologoon_02",
    "g_m_y_salvaboss_01",
    "g_m_y_salvagoon_01",
    "g_m_y_salvagoon_02",
    "g_m_y_salvagoon_03",
    "g_m_y_strpunk_01",
    "g_m_y_strpunk_02",
    "g_m_m_casrn_01",
    "mp_f_bennymech_01",
    "mp_f_boatstaff_01",
    "mp_f_cardesign_01",
    "mp_f_chbar_01",
    "mp_f_cocaine_01",
    "mp_f_counterfeit_01",
    "mp_f_deadhooker",
    "mp_f_execpa_01",
    "mp_f_execpa_02",
    "mp_f_forgery_01",
    "mp_f_freemode_01",
    "mp_f_helistaff_01",
    "mp_f_meth_01",
    "mp_f_misty_01",
    "mp_f_stripperlite",
    "mp_f_weed_01",
    "mp_g_m_pros_01",
    "mp_m_avongoon",
    "mp_m_boatstaff_01",
    "mp_m_bogdangoon",
    "mp_m_claude_01",
    "mp_m_cocaine_01",
    "mp_m_counterfeit_01",
    "mp_m_exarmy_01",
    "mp_m_execpa_01",
    "mp_m_famdd_01",
    "mp_m_fibsec_01",
    "mp_m_forgery_01",
    "mp_m_freemode_01",
    "mp_m_g_vagfun_01",
    "mp_m_marston_01",
    "mp_m_meth_01",
    "mp_m_niko_01",
    "mp_m_securoguard_01",
    "mp_m_shopkeep_01",
    "mp_m_waremech_01",
    "mp_m_weapexp_01",
    "mp_m_weapwork_01",
    "mp_m_weed_01",
    "mp_s_m_armoured_01",
    "s_f_m_fembarber",
    "s_f_m_maid_01",
    "s_f_m_shop_high",
    "s_f_m_sweatshop_01",
    "s_f_y_airhostess_01",
    "s_f_y_bartender_01",
    "s_f_y_baywatch_01",
    "s_f_y_clubbar_01",
    "s_f_y_cop_01",
    "s_f_y_factory_01",
    "s_f_y_hooker_01",
    "s_f_y_hooker_02",
    "s_f_y_hooker_03",
    "s_f_y_migrant_01",
    "s_f_y_movprem_01",
    "s_f_y_ranger_01",
    "s_f_y_scrubs_01",
    "s_f_y_sheriff_01",
    "s_f_y_shop_low",
    "s_f_y_shop_mid",
    "s_f_y_stripper_01",
    "s_f_y_stripper_02",
    "s_f_y_stripperlite",
    "s_f_y_sweatshop_01",
    "s_f_y_casino_01",
    "s_m_m_ammucountry",
    "s_m_m_armoured_01",
    "s_m_m_armoured_02",
    "s_m_m_autoshop_01",
    "s_m_m_autoshop_02",
    "s_m_m_bouncer_01",
    "s_m_m_ccrew_01",
    "s_m_m_chemsec_01",
    "s_m_m_ciasec_01",
    "s_m_m_cntrybar_01",
    "s_m_m_dockwork_01",
    "s_m_m_doctor_01",
    "s_m_m_fiboffice_01",
    "s_m_m_fiboffice_02",
    "s_m_m_fibsec_01",
    "s_m_m_gaffer_01",
    "s_m_m_gardener_01",
    "s_m_m_gentransport",
    "s_m_m_hairdress_01",
    "s_m_m_highsec_01",
    "s_m_m_highsec_02",
    "s_m_m_janitor",
    "s_m_m_lathandy_01",
    "s_m_m_lifeinvad_01",
    "s_m_m_linecook",
    "s_m_m_lsmetro_01",
    "s_m_m_mariachi_01",
    "s_m_m_marine_01",
    "s_m_m_marine_02",
    "s_m_m_migrant_01",
    "s_m_m_movalien_01",
    "s_m_m_movprem_01",
    "s_m_m_movspace_01",
    "s_m_m_paramedic_01",
    "s_m_m_pilot_01",
    "s_m_m_pilot_02",
    "s_m_m_postal_01",
    "s_m_m_postal_02",
    "s_m_m_prisguard_01",
    "s_m_m_scientist_01",
    "s_m_m_security_01",
    "s_m_m_snowcop_01",
    "s_m_m_strperf_01",
    "s_m_m_strpreach_01",
    "s_m_m_strvend_01",
    "s_m_m_trucker_01",
    "s_m_m_ups_01",
    "s_m_m_ups_02",
    "s_m_o_busker_01",
    "s_m_y_airworker",
    "s_m_y_ammucity_01",
    "s_m_y_armymech_01",
    "s_m_y_autopsy_01",
    "s_m_y_barman_01",
    "s_m_y_baywatch_01",
    "s_m_y_blackops_01",
    "s_m_y_blackops_02",
    "s_m_y_blackops_03",
    "s_m_y_busboy_01",
    "s_m_y_chef_01",
    "s_m_y_clown_01",
    "s_m_y_clubbar_01",
    "s_m_y_construct_01",
    "s_m_y_construct_02",
    "s_m_y_cop_01",
    "s_m_y_dealer_01",
    "s_m_y_devinsec_01",
    "s_m_y_dockwork_01",
    "s_m_y_doorman_01",
    "s_m_y_dwservice_01",
    "s_m_y_dwservice_02",
    "s_m_y_factory_01",
    "s_m_y_fireman_01",
    "s_m_y_garbage",
    "s_m_y_grip_01",
    "s_m_y_hwaycop_01",
    "s_m_y_marine_01",
    "s_m_y_marine_02",
    "s_m_y_marine_03",
    "s_m_y_mime",
    "s_m_y_pestcont_01",
    "s_m_y_pilot_01",
    "s_m_y_prismuscl_01",
    "s_m_y_prisoner_01",
    "s_m_y_ranger_01",
    "s_m_y_robber_01",
    "s_m_y_sheriff_01",
    "s_m_y_shop_mask",
    "s_m_y_strvend_01",
    "s_m_y_swat_01",
    "s_m_y_uscg_01",
    "s_m_y_valet_01",
    "s_m_y_waiter_01",
    "s_m_y_waretech_01",
    "s_m_y_winclean_01",
    "s_m_y_xmech_01",
    "s_m_y_xmech_02",
    "s_m_y_casino_01",
    "s_m_y_westsec_01",
    "hc_driver",
    "hc_gunman",
    "hc_hacker",
    "ig_abigail",
    "ig_agent",
    "ig_amandatownley",
    "ig_andreas",
    "ig_ashley",
    "ig_avon",
    "ig_ballasog",
    "ig_bankman",
    "ig_barry",
    "ig_benny",
    "ig_bestmen",
    "ig_beverly",
    "ig_brad",
    "ig_bride",
    "ig_car3guy1",
    "ig_car3guy2",
    "ig_casey",
    "ig_chef",
    "ig_chef2",
    "ig_chengsr",
    "ig_chrisformage",
    "ig_clay",
    "ig_claypain",
    "ig_cletus",
    "ig_dale",
    "ig_davenorton",
    "ig_denise",
    "ig_devin",
    "ig_dix",
    "ig_djblamadon",
    "ig_djblamrupert",
    "ig_djblamryans",
    "ig_djdixmanager",
    "ig_djgeneric_01",
    "ig_djsolfotios",
    "ig_djsoljakob",
    "ig_djsolmanager",
    "ig_djsolmike",
    "ig_djsolrobt",
    "ig_djtalaurelia",
    "ig_djtalignazio",
    "ig_dom",
    "ig_dreyfuss",
    "ig_drfriedlander",
    "ig_englishdave",
    "ig_fabien",
    "ig_fbisuit_01",
    "ig_floyd",
    "ig_g",
    "ig_groom",
    "ig_hao",
    "ig_hunter",
    "ig_janet",
    "ig_jay_norris",
    "ig_jewelass",
    "ig_jimmyboston",
    "ig_jimmyboston_02",
    "ig_jimmydisanto",
    "ig_joeminuteman",
    "ig_johnnyklebitz",
    "ig_josef",
    "ig_josh",
    "ig_karen_daniels",
    "ig_kerrymcintosh",
    "ig_kerrymcintosh_02",
    "ig_lacey_jones_02",
    "ig_lamardavis",
    "ig_lazlow",
    "ig_lazlow_2",
    "ig_lestercrest",
    "ig_lestercrest_2",
    "ig_lifeinvad_01",
    "ig_lifeinvad_02",
    "ig_magenta",
    "ig_malc",
    "ig_manuel",
    "ig_marnie",
    "ig_maryann",
    "ig_maude",
    "ig_michelle",
    "ig_milton",
    "ig_molly",
    "ig_money",
    "ig_mp_agent14",
    "ig_mrk",
    "ig_mrs_thornhill",
    "ig_mrsphillips",
    "ig_natalia",
    "ig_nervousron",
    "ig_nigel",
    "ig_old_man1a",
    "ig_old_man2",
    "ig_omega",
    "ig_oneil",
    "ig_orleans",
    "ig_ortega",
    "ig_paige",
    "ig_paper",
    "ig_patricia",
    "ig_popov",
    "ig_priest",
    "ig_prolsec_02",
    "ig_ramp_gang",
    "ig_ramp_hic",
    "ig_ramp_hipster",
    "ig_ramp_mex",
    "ig_rashcosvki",
    "ig_roccopelosi",
    "ig_russiandrunk",
    "ig_sacha",
    "ig_screen_writer",
    "ig_siemonyetarian",
    "ig_sol",
    "ig_solomon",
    "ig_stevehains",
    "ig_stretch",
    "ig_talcc",
    "ig_talina",
    "ig_talmm",
    "ig_tanisha",
    "ig_taocheng",
    "ig_taostranslator",
    "ig_tenniscoach",
    "ig_terry",
    "ig_tomepsilon",
    "ig_tonya",
    "ig_tonyprince",
    "ig_tracydisanto",
    "ig_trafficwarden",
    "ig_tylerdix",
    "ig_tylerdix_02",
    "ig_vagspeak",
    "ig_wade",
    "ig_zimbor",
    "player_one",
    "player_two",
    "player_zero",
    "ig_agatha",
    "ig_avery",
    "ig_brucie2",
    "ig_thornton",
    "ig_tomcasino",
    "ig_vincent",
    "u_f_m_corpse_01",
    "u_f_m_miranda",
    "u_f_m_miranda_02",
    "u_f_m_promourn_01",
    "u_f_o_moviestar",
    "u_f_o_prolhost_01",
    "u_f_y_bikerchic",
    "u_f_y_comjane",
    "u_f_y_corpse_01",
    "u_f_y_corpse_02",
    "u_f_y_danceburl_01",
    "u_f_y_dancelthr_01",
    "u_f_y_dancerave_01",
    "u_f_y_hotposh_01",
    "u_f_y_jewelass_01",
    "u_f_y_mistress",
    "u_f_y_poppymich",
    "u_f_y_poppymich_02",
    "u_f_y_princess",
    "u_f_y_spyactress",
    "u_f_m_casinocash_01",
    "u_f_m_casinoshop_01",
    "u_f_m_debbie_01",
    "u_f_o_carol",
    "u_f_o_eileen",
    "u_f_y_beth",
    "u_f_y_lauren",
    "u_f_y_taylor",
    "u_m_m_aldinapoli",
    "u_m_m_bankman",
    "u_m_m_bikehire_01",
    "u_m_m_doa_01",
    "u_m_m_edtoh",
    "u_m_m_fibarchitect",
    "u_m_m_filmdirector",
    "u_m_m_glenstank_01",
    "u_m_m_griff_01",
    "u_m_m_jesus_01",
    "u_m_m_jewelsec_01",
    "u_m_m_jewelthief",
    "u_m_m_markfost",
    "u_m_m_partytarget",
    "u_m_m_prolsec_01",
    "u_m_m_promourn_01",
    "u_m_m_rivalpap",
    "u_m_m_spyactor",
    "u_m_m_streetart_01",
    "u_m_m_willyfist",
    "u_m_o_filmnoir",
    "u_m_o_finguru_01",
    "u_m_o_taphillbilly",
    "u_m_o_tramp_01",
    "u_m_y_abner",
    "u_m_y_antonb",
    "u_m_y_babyd",
    "u_m_y_baygor",
    "u_m_y_burgerdrug_01",
    "u_m_y_chip",
    "u_m_y_corpse_01",
    "u_m_y_cyclist_01",
    "u_m_y_danceburl_01",
    "u_m_y_dancelthr_01",
    "u_m_y_dancerave_01",
    "u_m_y_fibmugger_01",
    "u_m_y_guido_01",
    "u_m_y_gunvend_01",
    "u_m_y_hippie_01",
    "u_m_y_imporage",
    "u_m_y_juggernaut_01",
    "u_m_y_justin",
    "u_m_y_mani",
    "u_m_y_militarybum",
    "u_m_y_paparazzi",
    "u_m_y_party_01",
    "u_m_y_pogo_01",
    "u_m_y_prisoner_01",
    "u_m_y_proldriver_01",
    "u_m_y_rsranger_01",
    "u_m_y_sbike",
    "u_m_y_smugmech_01",
    "u_m_y_staggrm_01",
    "u_m_y_tattoo_01",
    "u_m_y_zombie_01",
    "u_m_m_blane",
    "u_m_m_curtis",
    "u_m_m_vince",
    "u_m_o_dean",
    "u_m_y_caleb",
    "u_m_y_croupthief_01",
    "u_m_y_gabriel",
    "u_m_y_ushi"
}

local function getPlayerInv(player)
    Items = {}
    ArgentSale = {}
    ArgentPropre = {}
    job1 = ''
    job2 = ''

    ESX.TriggerServerCallback('aAdmin:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
                break
            end
        end
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'money' and data.accounts[i].money > 0 then
                table.insert(ArgentPropre, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'money',
                    itemType = 'item_cash',
                    amount   = data.accounts[i].money
                })
                break
            end
        end
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
        job1 = data.jobs1
        job2 = data.jobs2
    end, player)

end

-- no clip

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

local function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, Configadmin.controls.goUp, true))
    ButtonMessage(Configadmin.text.haut)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, Configadmin.controls.goDown, true))
    ButtonMessage(Configadmin.text.bas)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, Configadmin.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, Configadmin.controls.turnLeft, true))
    ButtonMessage(Configadmin.text.orientation)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, Configadmin.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, Configadmin.controls.goForward, true))
    ButtonMessage(Configadmin.text.verticale)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, Configadmin.controls.changeSpeed, true))
    ButtonMessage(Configadmin.text.vitesse.." ("..Configadmin.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 74, true)
end

local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
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

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

local isMenuOpened = false
local InStaff = false
local playerrank = 'user'
local filterArray = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
local filter = 1
local voiture = {"Spawn", "Give"}
local array1 = {
    "Cash",
    "Banque",
    "Sale"
}
local arrayIndex1 = 1
local arrayIndex3 = 1
local filtreplayer = nil

local listeitem = {}
local report = {}
local nombrereport = 0
local PlayersBlips = {}
local SetBlips = false

-- Perm système
local function canUse(permission, playerRank)
    if playerrank == "user" then
        return false
    end
    if type(Configadmin.permissions[permission]) ~= "table" then
        return true
    end
    for k,rank in pairs(Configadmin.permissions[permission]) do
        if rank == playerrank then
            return true
        end
    end
    return false
end

RegisterNetEvent("aScripts:updatereport")
AddEventHandler("aScripts:updatereport", function(reportTable, nbreport, type)
    report = reportTable
    nombrereport = nbreport
    if rank ~= "user" then
        if InStaff then
            if type == "arriv" then
                ESX.ShowNotification('~y~[Staff]~s~ : Vous avez un nouveau report !')
            end
        end
    end
end)

local function GetPlayers()
    players = {}
    pnombre = 0
    ESX.TriggerServerCallback("aAdmin:getplayers", function(result, nbplayers)
        players = result
        pnombre = nbplayers
    end)
    return players, pnombre
end

local function GetPlayersJob()
    playersjob = {}
    pnombrejob = 0
    ESX.TriggerServerCallback("aAdmin:getplayersjob", function(result2, nbplayersjob)
        playersjob = result2
        pnombrejob = nbplayersjob
    end)
    return playersjob, pnombrejob
end

RMenu.Add("admin", "principal", RageUI.CreateMenu("Staff Menu", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("admin", "principal").Closed = function()
    isMenuOpened = false
    filtreplayer = nil
end

RMenu.Add('admin', 'joueurs', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion joueurs :"))
RMenu:Get('admin', 'joueurs').Closed = function()end

RMenu.Add('admin', 'joueursjob', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion joueurs Job :"))
RMenu:Get('admin', 'joueursjob').Closed = function()end

RMenu.Add('admin', 'gestionjoueurs', RageUI.CreateSubMenu(RMenu:Get('admin', 'joueurs'), 'Staff Menu', "~b~Gestion joueurs :"))
RMenu:Get('admin', 'gestionjoueurs').Closed = function()end

RMenu.Add('admin', 'givearme', RageUI.CreateSubMenu(RMenu:Get('admin', 'gestionjoueurs'), 'Staff Menu', "~b~Gestion armes :"))
RMenu:Get('admin', 'givearme').Closed = function()end

RMenu.Add('admin', 'item', RageUI.CreateSubMenu(RMenu:Get('admin', 'gestionjoueurs'), 'Staff Menu', "~b~Gestion items :"))
RMenu:Get('admin', 'item').Closed = function()end

RMenu.Add('admin', 'infojoueur', RageUI.CreateSubMenu(RMenu:Get('admin', 'gestionjoueurs'), 'Staff Menu', "~b~Info joueur :"))
RMenu:Get('admin', 'infojoueur').Closed = function()end

RMenu.Add('admin', 'report', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion reports :"))
RMenu:Get('admin', 'report').Closed = function()end

RMenu.Add('admin', 'gestionreport', RageUI.CreateSubMenu(RMenu:Get('admin', 'report'), 'Staff Menu', "~b~Gestion reports :"))
RMenu:Get('admin', 'gestionreport').Closed = function()end

RMenu.Add('admin', 'optionpeds', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion peds :"))
RMenu:Get('admin', 'optionpeds').Closed = function()end

RMenu.Add('admin', 'optionperso', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion personel :"))
RMenu:Get('admin', 'optionperso').Closed = function()end

RMenu.Add('admin', 'optionveh', RageUI.CreateSubMenu(RMenu:Get('admin', 'principal'), 'Staff Menu', "~b~Gestion véhicules :"))
RMenu:Get('admin', 'optionveh').Closed = function()end

local function openMenuAdmin()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("admin","principal"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            if players ~= nil then
                RageUI.IsVisible(RMenu:Get("admin","principal"),true,true,true,function()
                    RageUI.Checkbox("Activer/Desactiver mode staff", nil, bol, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                        bol = c;
                    end, function()
                        InStaff = true
                        if playerrank ~= "superadmin" then
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configadmin.StaffTenue.male)
                                elseif skin.sex == 1 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configadmin.StaffTenue.female)
                                end
                            end)
                        end
                    end, function()
                        InStaff = false
                        if playerrank ~= "superadmin" then
                            ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
                    if InStaff then
                        RageUI.Separator('↓ Gestions ↓')
                        RageUI.ButtonWithStyle("Gestion Joueurs (~r~"..pnombre.."~s~)", nil, {RightLabel = "→→→"}, canUse("gestion_joueurs", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'joueurs'))
                        RageUI.ButtonWithStyle("Gestion Joueurs Job (~r~"..pnombrejob.."~s~)", nil, {RightLabel = "→→→"}, canUse("gestion_joueurs_job", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'joueursjob'))
                        RageUI.ButtonWithStyle("Gestion Reports (~r~"..nombrereport.."~s~)", nil, {RightLabel = "→→→"}, canUse("gestion_reports", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'report'))
                        RageUI.Separator('↓ Options ↓')
                        RageUI.ButtonWithStyle("Options Personnel", nil, {RightLabel = "→→→"}, canUse("option_perso", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'optionperso'))
                        RageUI.ButtonWithStyle("Options Véhicules", nil, {RightLabel = "→→→"}, canUse("option_veh", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'optionveh'))
                        RageUI.ButtonWithStyle("Options Peds", nil, {RightLabel = "→→→"}, canUse("option_ped", playerrank),function(a,h,s)
                        end, RMenu:Get('admin', 'optionpeds'))
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','joueursjob'),true,true,true,function()
                    RageUI.ButtonWithStyle("Filtre", nil, {RightLabel = filtreplayer}, true,function(a,h,s)
                        if s then
                            filtreplayer = KeyboardInput("atmos", "Nom du joueur", "", 4)
                            if filtreplayer ~= nil then
                                filtreplayer = filtreplayer
                            else
                                filtreplayer = nil
                            end
                        end
                    end)
                    RageUI.Separator('↓ Joueurs en service: '..pnombrejob..' ↓')
                    for k, v in spairs(playersjob, function(t,a,b) return t[b].id > t[a].id end) do
                        yes = v.name
                        idzdzd = v.id
                        grdzdoup = v.job
                        if filtreplayer == nil then
                            RageUI.ButtonWithStyle(" [~b~"..idzdzd.."~s~] [~b~"..grdzdoup.."~s~] "..yes, nil, {RightLabel = ''}, true,function(a,h,s)
                            end)
                        elseif starts(yes:lower(), filtreplayer:lower()) then
                            RageUI.ButtonWithStyle(" [~b~"..idzdzd.."~s~] [~b~"..grdzdoup.."~s~] "..yes, nil, {RightLabel = ''}, true,function(a,h,s)
                            end)
                        end
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','joueurs'),true,true,true,function()
                    RageUI.ButtonWithStyle("Filtre", nil, {RightLabel = filtreplayer}, true,function(a,h,s)
                        if s then
                            filtreplayer = KeyboardInput("atmos", "Nom du joueur", "", 4)
                            if filtreplayer ~= nil then
                                filtreplayer = filtreplayer
                            else
                                filtreplayer = nil
                            end
                        end
                    end)
                    RageUI.Separator('↓ Joueurs : '..pnombre.."/"..Configadmin.maxplayers..' ↓')
                    for k, v in spairs(players, function(t,a,b) return t[b].id > t[a].id end) do
                        yes = v.name
                        idzdzd = v.id
                        grdzdoup = v.group
                        if filtreplayer == nil then
                            RageUI.ButtonWithStyle(" [~b~"..idzdzd.."~s~] [~b~"..grdzdoup.."~s~] "..yes, nil, {RightLabel = '→'}, true,function(a,h,s)
                                if s then
                                    name = v.name
                                    id = v.id
                                    group = v.group
                                end
                            end, RMenu:Get('admin', 'gestionjoueurs'))
                        elseif starts(yes:lower(), filtreplayer:lower()) then
                            RageUI.ButtonWithStyle(" [~b~"..idzdzd.."~s~] [~b~"..grdzdoup.."~s~] "..yes, nil, {RightLabel = '→'}, true,function(a,h,s)
                                if s then
                                    name = v.name
                                    id = v.id
                                    group = v.group
                                end
                            end, RMenu:Get('admin', 'gestionjoueurs'))
                        end
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','gestionjoueurs'),true,true,true,function()
                    RageUI.Separator('↓ Player : ~b~'..name..'~s~ ↓')
                    RageUI.Separator('↓ Message ↓')
                    RageUI.ButtonWithStyle("Envoyer un message", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local message = KeyboardInput("atmos", "Message :", "", 50)
                            if message ~= nil then
                                TriggerServerEvent("aAdmin:message", message, id)
                                ESX.ShowNotification("Vous avez envoyé un message au joueur")
                            end
                        end
                    end)
                    RageUI.Separator('↓ TP ↓')
                    RageUI.ButtonWithStyle("TP sur moi", nil, {RightLabel = "→→→"}, canUse("action_tp", playerrank),function(a,h,s)
                        if s then
                            if attach == false then
                                TriggerServerEvent('aAdmin:bring', id, GetEntityCoords(PlayerPedId()))
                            else
                                ESX.ShowNotification("~y~[Staff]~s~ : Désactivez le suivi du joueur !")
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("TP sur lui", nil, {RightLabel = "→→→"}, canUse("action_tp", playerrank),function(a,h,s)
                        if s then
                            if attach == false then
                                TriggerServerEvent('aAdmin:goto', id)
                            else
                                ESX.ShowNotification("~y~[Staff]~s~ : Désactivez le suivi du joueur !")
                            end
                        end
                    end)
                    for k,v in pairs(Configadmin.tppoint) do
                        RageUI.ButtonWithStyle("TP "..v.name, nil, {RightLabel = '→→→'}, canUse("action_tp", playerrank),function(a,h,s)
                            if s then
                                if attach == false then
                                    TriggerServerEvent('aAdmin:tppoint', id, v.pos)
                                else
                                    ESX.ShowNotification("~y~[Staff]~s~ : Désactivez le suivi du joueur !")
                                end
                            end
                        end)
                    end
                    RageUI.Separator('↓ Actions ↓')
                    --RageUI.ButtonWithStyle("Mod Spectateur", nil, {RightLabel = "→→→"}, canUse("spec_mod", playerrank),function(a,h,s)
                    --    if s then
                    --        local target = GetPlayerFromServerId(id)
                    --        if GetPlayerPed(target) then
                    --            inspec = true
                    --            NetworkSetInSpectatorMode(true, GetPlayerPed(target))
                    --            ESX.ShowNotification("~y~[Staff]~s~ : Mod Spectateur activé !")
                    --            ESX.ShowNotification("~y~[Staff]~s~ : Appuyez sur ~b~E~s~ pour arrêter le mod spectateur!")
                    --        else
                    --            ESX.ShowNotification("~r~Problème~s~ : ID invalide !")
                    --        end
                    --    end
                    --end)
                    RageUI.ButtonWithStyle(suivitext, nil, {RightLabel = "→→→"}, canUse("action_heal", playerrank),function(a,h,s)
                        if s then
                            if noclipActive then
                                if not attach then
                                    suivitext = "Ne Plus Suivre"
                                    target = GetPlayerFromServerId(id)
                                    xtarget = GetPlayerPed(target)
                                    if target == -1 then
                                        ESX.ShowNotification("~y~[Staff]~s~ : Vous devez être proche du joueur !")
                                    else
                                        AttachEntityToEntity(PlayerPedId(), xtarget, -1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                        attach = true
                                    end
                                else
                                    suivitext = "Suivre"
                                    DetachEntity(PlayerPedId(), true, false)
                                    attach = false
                                end
                            else
                                ESX.ShowNotification("~y~[Staff]~s~ : Vous devez être en NoClip pour suivre un joueur !")
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Heal", nil, {RightLabel = "→→→"}, canUse("action_heal", playerrank),function(a,h,s)
                        if s then
                            TriggerServerEvent('aAdmin:transheal', id)
                        end
                    end)
                    RageUI.ButtonWithStyle("Revive", nil, {RightLabel = "→→→"}, canUse("action_revive", playerrank),function(a,h,s)
                        if s then
                            ExecuteCommand('revive '..id)
                        end
                    end)
                    RageUI.ButtonWithStyle("Skin", nil, {RightLabel = "→→→"}, canUse("action_revive", playerrank),function(a,h,s)
                        if s then
                            ExecuteCommand('skinplayer '..id)
                            ESX.ShowNotification("~y~[Staff]~s~ : Skin effectué !")
                        end
                    end)
                    RageUI.List("Give argent", array1, arrayIndex1, nil, {}, canUse("give_money", playerrank), function(h, a, s, i) arrayIndex1 = i
                        if s then
                            amount = KeyboardInput("atmos", "Montant :", "", 9)
                            if amount ~= nil then
                                amount = tonumber(amount)
                                if type(amount) == 'number' then
                                    TriggerServerEvent('aAdmin:givemoney', id, arrayIndex1, amount)
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Info joueur", nil, {RightLabel = "→→→"}, canUse("player_info", playerrank),function(a,h,s)
                        if s then
                            getPlayerInv(id)
                        end
                    end, RMenu:Get('admin', 'infojoueur'))
                    RageUI.Separator("--------------------------------")
                    RageUI.List("Voiture", voiture, arrayIndex3, nil, {}, canUse("car_action", playerrank), function(h, a, s, i) arrayIndex3 = i
                        if s then
                            if arrayIndex3 == 1 then
                                local voiture = KeyboardInput("atmos", "Model :", "", 15)
                                if voiture ~= nil then
                                    TriggerServerEvent("aAdmin:transcar", voiture, id)
                                    ESX.ShowNotification("~y~[Staff]~s~ : Spawn effectué !")
                                end
                            else
                                local voiture = KeyboardInput("atmos", "Model :", "", 15)
                                if voiture ~= nil then
                                    TriggerServerEvent("aAdmin:givecar", voiture, id)
                                    ESX.ShowNotification("~y~[Staff]~s~ : Give effectué !")
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Donner item", nil, {RightLabel = '→→→'}, canUse("give_item", playerrank),function(a,h,s) end, RMenu:Get('admin', 'item'))
                    RageUI.ButtonWithStyle("Donner arme", nil, {RightLabel = '→→→'}, canUse("give_weapon", playerrank),function(a,h,s) end, RMenu:Get('admin', 'givearme'))
                    RageUI.Separator("--------------------------------")
                    RageUI.ButtonWithStyle("~r~Kick", nil, {RightBadge = RageUI.BadgeStyle.Alert}, canUse("kick_action", playerrank),function(a,h,s)
                        if s then
                            local raison = KeyboardInput("atmos", "Raison :", "", 15)
                            if raison ~= nil then
                                TriggerServerEvent("aAdmin:kickplayer", id, raison)
                                ESX.ShowNotification("~y~[Staff]~s~ : Kick effectué !")
                            end  
                        end
                    end)
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin', 'givearme'),true,true,true,function()
                    RageUI.Separator('↓ Armes ↓')
                    for k, v in pairs(Configadmin.armes) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent("aScript:giveweapon", id, v.name)
                            end
                        end)
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','item'),true,true,true,function()
                    RageUI.List("Filtre:", filterArray, filter, nil, {}, true, function(_, _, _, i) filter = i end)
                    RageUI.Separator('↓ Items ↓')
                    for k, v in pairs(listeitem) do
                        if starts(v.label:lower(), filterArray[filter]:lower()) then
                            RageUI.ButtonWithStyle(v.label, nil, { RightLabel = "→→→"}, true, function(_, _, s)
                                if s then
                                    local quantite = KeyboardInput("atmos", "Quantité :", "", 4)
                                    if quantite ~= nil then
                                        quantite = tonumber(quantite)
                                        if type(quantite) == 'number' then
                                            TriggerServerEvent("aScript:giveitem", id, v.name, quantite)
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','infojoueur'),true,true,true,function()
                    for k, v in pairs(ArgentPropre) do
                        RageUI.ButtonWithStyle("Argent :", nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.label).."$"}, true, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("atmos", 'Combien ?' , '', 8)
                                if combien ~= nil then
                                    if tonumber(combien) > v.amount then
                                        ESX.ShowNotification("~r~Problème~s~ : Quantité invalide !")
                                    else
                                        TriggerServerEvent('aAdmin:confiscatePlayerItem', id, v.itemType, v.value, tonumber(combien))
                                        RageUI.GoBack()
                                        isMenuOpened = false
                                    end
                                end
                            end
                        end)
                    end
                    for k,v  in pairs(ArgentSale) do
                        RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.label).."$"}, true, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("atmos", 'Combien ?' , '', 8)
                                if combien ~= nil then
                                    if tonumber(combien) > v.amount then
                                        ESX.ShowNotification("~r~Problème~s~ : Quantité invalide !")
                                    else
                                        TriggerServerEvent('aAdmin:confiscatePlayerItem', id, v.itemType, v.value, tonumber(combien))
                                        RageUI.GoBack()
                                        isMenuOpened = false
                                    end
                                end
                            end
                        end)
                    end
                    RageUI.Separator("Job 1 : "..job1)
                    RageUI.Separator("Job 2 : "..job2)
                    RageUI.Separator("↓ Objets ↓")
                    for k,v  in pairs(Items) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~x"..v.right}, true, function(_, _, s)
                            if s then
                                local combien = KeyboardInput("atmos", 'Combien ?' , '', 8)
                                if combien ~= nil then
                                    if tonumber(combien) > v.amount then
                                        ESX.ShowNotification("~r~Problème~s~ : Quantité invalide !")
                                    else
                                        TriggerServerEvent('aAdmin:confiscatePlayerItem', id, v.itemType, v.value, tonumber(combien))
                                        RageUI.GoBack()
                                        isMenuOpened = false
                                    end
                                end
                            end
                        end)
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin','report'),true,true,true,function()
                    if nombrereport ~= 0 then
                        RageUI.Separator('↓ Report en cours : '..nombrereport..' ↓')
                        for k, v in pairs(report) do
                            RageUI.ButtonWithStyle(" [~b~"..v.id.."~s~] "..v.name, "~b~Raison~s~ : "..v.reason, {RightLabel = v.createdAt}, true,function(a,h,s)
                                if s then
                                    name = v.name
                                    reportid = v.id
                                end
                            end, RMenu:Get('admin', 'gestionreport'))
                        end
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucun report en cours...")
                        RageUI.Separator("")
                    end
                end, function()end, 1)
                    RageUI.IsVisible(RMenu:Get('admin', 'gestionreport'),true,true,true,function()
                        if report[reportid] then
                            RageUI.Separator('↓ Report de : '..name..' ↓')
                            RageUI.ButtonWithStyle("TP sur moi", nil, {RightLabel = "→→→"}, canUse("action_tp", playerrank), player,function(a,h,s)
                                if s then
                                    TriggerServerEvent('aAdmin:bring', reportid, GetEntityCoords(PlayerPedId()))
                                end
                            end)
                            RageUI.ButtonWithStyle("TP sur lui", nil, {RightLabel = "→→→"}, canUse("action_tp", playerrank),function(a,h,s)
                                if s then
                                    TriggerServerEvent('aAdmin:goto', reportid)
                                end
                            end)
                            for k,v in pairs(Configadmin.tppoint) do
                                RageUI.ButtonWithStyle("TP "..v.name, nil, {RightLabel = '→→→'}, canUse("action_tp", playerrank),function(a,h,s)
                                    if s then
                                        TriggerServerEvent('aAdmin:tppoint', reportid, v.pos)
                                    end
                                end)
                            end
                            RageUI.Separator("--------------------------------")
                            RageUI.ButtonWithStyle("Revive", nil, {RightLabel = "→→→"}, canUse("action_revive", playerrank),function(a,h,s)
                                if s then
                                    ExecuteCommand('revive '..reportid)
                                end
                            end)
                            RageUI.Separator("--------------------------------")
                            RageUI.ButtonWithStyle("~r~Supprimer report", nil, {RightBadge = RageUI.BadgeStyle.Alert}, canUse("action_delreport", playerrank),function(a,h,s)
                                if s then
                                    TriggerServerEvent("aAdmin:deletereport", reportid)
                                    RageUI.GoBack()
                                end
                            end)
                        else
                            RageUI.Separator('')
                            RageUI.Separator('~r~Report expiré')
                            RageUI.Separator('')
                        end
                    end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin', 'optionpeds'),true,true,true,function()
                    RageUI.Separator('↓ Actions ped ↓')
                    RageUI.ButtonWithStyle("Reprendre son ped", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0
                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                                        TriggerEvent('skinchanger:loadSkin', skin)
                                    end)
                                end)
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Changer Ped (Par nom)", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            local ped = KeyboardInput("atmos", "Model du ped :", "", 20)
                            if ped ~= nil then
                                local j1 = PlayerId()
                                local p1 = GetHashKey(ped)
                                RequestModel(p1)
                                while not HasModelLoaded(p1) do
                                    Wait(100)
                                end
                                SetPlayerModel(j1, p1)
                                SetModelAsNoLongerNeeded(p1)
                            else
                                ESX.ShowNotification("~r~Problème~s~ : Model invalide !")
                            end
                        end
                    end)
                    RageUI.Separator('↓ Peds liste ↓')
                    RageUI.List("Filtre :", filterArray, filter, nil, {}, true, function(_, _, _, i) filter = i end)
                    for k, v in pairs(ListePed) do
                        if starts(v:lower(), filterArray[filter]:lower()) then
                            RageUI.ButtonWithStyle(v, nil, {RightLabel = "→→→"}, true, function(_, _, s)
                                if s then
                                    local j1 = PlayerId()
                                    local p1 = GetHashKey(v)
                                    RequestModel(p1)
                                    while not HasModelLoaded(p1) do
                                        Wait(100)
                                    end
                                    SetPlayerModel(j1, p1)
                                    SetModelAsNoLongerNeeded(p1)
                                    if v == 'a_c_mtlion' then -- you need this if the model in an animal, otherwise you will be invisible
                                        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 0)
                                        Wait(200)
                                        SetPedComponentVariation(PlayerPedId(), 0, 0, 1, 0)
                                        Wait(200)
                                    end
                                end
                            end)
                        end
                    end
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin', 'optionperso'),true,true,true,function()
                    RageUI.Separator('↓ Actions personnels ↓')
                    RageUI.Checkbox("Activer/Desactiver NoClip", nil, noclip, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                        noclip = c;
                    end, function()
                        NoClip()
                    end, function()
                        NoClip()
                    end)
                    RageUI.Checkbox("Activer/Desactiver Invinsibilité", nil, invin, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                        invin = c;
                        end, function()
                            local ped = PlayerPedId()
                            SetEntityInvincible(ped, true)
                        end, function()
                            local ped = PlayerPedId()
                            SetEntityInvincible(ped, false)
                        end)
                    RageUI.Checkbox("Activer/Desactiver Invisibilité", nil, invi, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                        invi = c;
                    end, function()
                        local ped = PlayerPedId()
                        SetEntityVisible(ped, false)
                    end, function()
                        local ped = PlayerPedId()
                        SetEntityVisible(ped, true)
                    end)
                    RageUI.Checkbox("Activer/Desactiver les noms", nil, affichname, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                        affichname = c;
                    end, function()
                        showNames(true)
                    end, function()
                        showNames(false)
                    end)
                    if canUse("player_blips", playerrank) then  
                        RageUI.Checkbox("Activer/Desactiver les blips", nil, blipsplayer, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
                            blipsplayer = c;
                        end, function()
                            SetBlips = true
                        end, function()
                            SetBlips = false
                        end)
                    end
                    RageUI.ButtonWithStyle("TP sur le marker", nil, {RightLabel = "→→→"}, canUse("action_tp", playerrank),function(a,h,s)
                        if s then
                            local WaypointHandle = GetFirstBlipInfoId(8)
                            if DoesBlipExist(WaypointHandle) then
                                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                                for height = 1, 1000 do
                                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                    if foundGround then
                                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                        break
                                    end
                                    Citizen.Wait(0)
                                end
                            end
                        end
                    end)
                end, function()end, 1)
                RageUI.IsVisible(RMenu:Get('admin', 'optionveh'),true,true,true,function()
                    RageUI.Separator('↓ Actions véhicules ↓')
                    RageUI.ButtonWithStyle("Remplir réservoir véhicule", nil, {RightLabel = "→→→"}, canUse("action_fuel", playerrank),function(a,h,s)
                        if s then
                        end
                        if h then
                            GetCloseVehi()
                            if s then
                                if IsPedInAnyVehicle(PlayerPedId()) then
                                    local vehicle = GetVehiclePedIsIn(PlayerPedId())
                                    TriggerEvent("aAdmin:fuel", vehicle, 100)
                                else
                                    local vehicle,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                                    if dist4 < 6 then
                                        TriggerEvent("aAdmin:fuel", vehicle, 100)
                                    end
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Retourner véhicule", nil, {RightLabel = "→→→"}, canUse("action_flipveh", playerrank),function(a,h,s)
                        if h then
                            GetCloseVehi()
                            if s then
                                local player = PlayerPedId()
                                posdepmenu = GetEntityCoords(player)
                                carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
                                if carTargetDep ~= nil then
                                    platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
                                end
                                local playerCoords = GetEntityCoords(PlayerPedId())
                                playerCoords = playerCoords + vector3(0, 2, 0)
                                SetEntityCoords(carTargetDep, playerCoords)
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Supprimer véhicule", nil, {RightLabel = "→→→"}, canUse("action_delveh", playerrank),function(a,h,s)
                        if h then
                            GetCloseVehi()
                            if s then
                                local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                                if dist4 < 6 then
                                    DeleteEntity(veh)
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Réparer véhicule", nil, {RightLabel = "→→→"}, canUse("action_repairveh", playerrank),function(a,h,s)
                        if h then
                            if not IsPedInAnyVehicle(PlayerPedId()) then
                                GetCloseVehi()
                            end
                            if s then
                                if IsPedInAnyVehicle(PlayerPedId()) then
                                    local vehicle = GetVehiclePedIsIn(PlayerPedId())
                                    SetVehicleEngineHealth(vehicle, 9999)
                                    SetVehiclePetrolTankHealth(vehicle, 9999)
                                    SetVehicleFixed(vehicle)
                                else
                                    local vehicle,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                                    if dist4 < 6 then
                                        SetVehicleEngineHealth(vehicle, 9999)
                                        SetVehiclePetrolTankHealth(vehicle, 9999)
                                        SetVehicleFixed(vehicle)
                                    end
                                end
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Ouvrir véhicule", nil, {RightLabel = "→→→"}, canUse("action_openveh", playerrank),function(a,h,s)
                        if h then
                            GetCloseVehi()
                            if s then
                                local vehicle,dist4 = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId(), false))
                                if dist4 < 6 then
                                    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                    SetVehicleDoorsLocked(vehicle, 0)
                                end
                            end
                        end
                    end)
                end, function()end, 1)
            end
            Wait(0)
        end
    end)
end

-- functions
Citizen.CreateThread(function()
    while true do
        interval = 750
        if InStaff then
            interval = 1
            RageUI.Text({message = " ~s~Mode modération actif : ~r~"..playerrank.."~s~ \n Report en cours : ~r~"..nombrereport})           
        end
        Wait(interval)
    end
end)

local voituregive = {}

RegisterNetEvent('aAdmin:registervehicle')
AddEventHandler('aAdmin:registervehicle', function(veh)
    local plyCoords = GetEntityCoords(PlayerPedId(), false)
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(veh, plyCoords, 90.0, function (vehicle)
        local plate = exports.elders_life:GeneratePlate()
        table.insert(voituregive, vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
        vehicleProps.plate = plate
        SetVehicleDoorsLocked(vehicle, 0)
        SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
        TriggerServerEvent('aAdmin:insertcar', vehicleProps, plate)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)
    ESX.ShowNotification("~y~[Staff]~s~ : Le staff  vous a give un(e) "..veh.." !")
end)

RegisterNetEvent('aAdmin:setcoords')
AddEventHandler('aAdmin:setcoords', function(coords)
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
end)

RegisterNetEvent('aAdmin:spawncar')
AddEventHandler('aAdmin:spawncar', function(voiture, coords)
    local model = GetHashKey(voiture)
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(10) end
    local vehicle = CreateVehicle(model, coords, 90.0, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleDoorsLocked(vehicle, 0)
end)

RegisterNetEvent('aAdmin:heal')
AddEventHandler('aAdmin:heal', function()
    SetEntityHealth(PlayerPedId(), 200)
end)

-- OpenMenu
RegisterCommand('admin', function()
    ESX.TriggerServerCallback("aAdmin:verifrank", function(rank)
        if rank ~= "user" then
            ESX.TriggerServerCallback('aAdmin:listeitem', function(keys2)
                listeitem = keys2
            end)
            playerrank = rank
            GetPlayers()
            GetPlayersJob()
            openMenuAdmin()
        else
            ESX.ShowNotification("~r~Problème~s~ : Vous n'êtes pas administrateur !~")
        end
    end)
end)

RegisterCommand('addminnoclip', function()
    ESX.TriggerServerCallback("aAdmin:verifrank", function(rank)
        if rank ~= "user" then
            NoClip()
        else
            ESX.ShowNotification("~r~Problème~s~ : Vous n'êtes pas administrateur !")
        end
    end)
end)

RegisterCommand('tpm', function()
    ESX.TriggerServerCallback("aAdmin:verifrank", function(rank)
        if rank ~= "user" then
            if attach == true then
                DetachEntity(PlayerPedId(), true, false)
                attach = false
                ESX.ShowNotification("~y~[Staff]~s~ : Le suivi du joueur a été désactivé !")
            end  
            local WaypointHandle = GetFirstBlipInfoId(8)
            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                        break
                    end
                    Citizen.Wait(0)
                end
            end
        else
            ESX.ShowNotification("~r~Problème~s~ : Vous n'êtes pas administrateur !")
        end
    end)
end)

RegisterKeyMapping('admin', 'Staff : Menu', 'keyboard', 'F2')
RegisterKeyMapping('addminnoclip', 'Staff : NoClip', 'keyboard', 'F3')
TriggerEvent('chat:addSuggestion', '/admin', 'Ouvrir le menu administrateur', {})
TriggerEvent('chat:addSuggestion', '/addminnoclip', 'Passer en mod NoClip', {})

Citizen.CreateThread(function()
    while true do
        interval = 750
        if inspec then
            SetEntityVisible(PlayerPedId(), false)
            SetEntityInvincible(PlayerPedId(), true)
            interval = 1
            if IsControlJustPressed(0, 51) then
                NetworkSetInSpectatorMode(false, PlayerPedId())
                inspec = false
                SetEntityVisible(PlayerPedId(), true)
                SetEntityInvincible(PlayerPedId(), false)
                ESX.ShowNotification("~y~[Staff]~s~ : Mod Spectateur désactivé !")
            end
        end
        if noclipActive then
            interval = 1
            SetLocalPlayerVisibleLocally(true)
        end
        Wait(interval)
    end
end)

Citizen.CreateThread(function()

    buttons = setupScaleform("instructional_buttons")

    currentSpeed = Configadmin.speeds[index].speed
    while true do
        interval = 750
        if noclipActive then
            interval = 1
            DrawScaleformMovieFullscreen(buttons)

            local yoff = 0.0
            local zoff = 0.0

            if IsControlJustPressed(1, Configadmin.controls.changeSpeed) then
                if index ~= 8 then
                    index = index+1
                    currentSpeed = Configadmin.speeds[index].speed
                else
                    currentSpeed = Configadmin.speeds[1].speed
                    index = 1
                end
                setupScaleform("instructional_buttons")
            end

            DisableControls()

            if IsDisabledControlPressed(0, Configadmin.controls.goForward) then
                yoff = Configadmin.offsets.y
            end

            if IsDisabledControlPressed(0, Configadmin.controls.goBackward) then
                yoff = -Configadmin.offsets.y
            end

            if IsDisabledControlPressed(0, Configadmin.controls.turnLeft) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+Configadmin.offsets.h)
            end

            if IsDisabledControlPressed(0, Configadmin.controls.turnRight) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-Configadmin.offsets.h)
            end

            if IsDisabledControlPressed(0, Configadmin.controls.goUp) then
                zoff = Configadmin.offsets.z
            end

            if IsDisabledControlPressed(0, Configadmin.controls.goDown) then
                zoff = -Configadmin.offsets.z
            end

            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
        end
        Citizen.Wait(interval)
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(750)
        if SetBlips then
            local players = GetActivePlayers()
            for k,v in pairs(players) do
                local ped = GetPlayerPed(v)
                if not PlayersBlips[ped] then
                    local blip = AddBlipForEntity(ped)
                    PlayersBlips[ped] = blip
                    SetBlipScale(blip, 0.8)
                    if IsPedOnAnyBike(ped) then
                        SetBlipSprite(blip, 226)
                    elseif IsPedInAnyHeli(ped) then
                        SetBlipSprite(blip, 422)
                    elseif IsPedInAnyPlane(ped) then
                        SetBlipSprite(blip, 307)
                    elseif IsPedInAnyVehicle(ped, false) then
                        SetBlipSprite(blip, 523)
                    else
                        SetBlipSprite(blip, 1)
                    end
                    if IsPedInAnyPoliceVehicle(ped) then
                        SetBlipSprite(blip, 56)
                        SetBlipColour(blip, 3)
                    end
                    BeginTextCommandSetBlipName('STRING')
                    AddTextComponentString("Joueur(s)")
                    EndTextCommandSetBlipName(blip)
                end
            end
        else
            for k,v in pairs(PlayersBlips) do
                RemoveBlip(v)
            end
        end
    end
end)

RegisterNetEvent("stickers:max")
AddEventHandler("stickers:max", function()
    TriggerEvent('rcore_stickers:openMenu')
end)

RegisterCommand('coords', function(source, args, rawCommand)
    local coords = GetEntityCoords(PlayerPedId())
    print(coords)
    print(GetEntityHeading(PlayerPedId()))
end)