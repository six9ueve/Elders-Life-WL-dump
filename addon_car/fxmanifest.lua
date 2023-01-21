fx_version('bodacious')
game('gta5')

client_scripts({
    'client/main.lua'
})

files({
    '**/carcols.meta',
    '**/carvariations.meta',
    '**/contentunlocks.meta',
    '**/handling.meta',
    '**/vehiclelayouts.meta',
    '**/vehicles.meta',

    'jantes/jdmrimscontentunlocks.meta',
    'jantes/carcols.meta',

})

data_file 'JDM_RIMS_CONTENT_UNLOCKS' 'jantes/jdmrimscontentunlocks.meta'

data_file('CONTENT_UNLOCKING_META_FILE')('**/contentunlocks.meta')
data_file('HANDLING_FILE')('**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('**/vehicles.meta')
data_file('CARCOLS_FILE')('**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('**/vehiclelayouts.meta')






























--[[fx_version 'adamant'
games { 'rdr3', 'gta5' }
lua54 'yes'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


files {

    'p60b40/audioconfig/p60b40_amp.dat10.rel',
    'p60b40/audioconfig/p60b40_game.dat151.rel',
    'p60b40/audioconfig/p60b40_sounds.dat54.rel',
    'p60b40/sfx/dlc_p60b40/p60b40.awc',
    'p60b40/sfx/dlc_p60b40/p60b40_npc.awc',

    'f136/audioconfig/f136_amp.dat10.rel',
	'f136/audioconfig/f136_game.dat151.rel',
	'f136/audioconfig/f136_sounds.dat54.rel',
	'f136/sfx/dlc_f136/f136.awc',
	'f136/sfx/dlc_f136/f136_npc.awc',

	'w211/audioconfig/w211_amp.dat10.rel',
	'w211/audioconfig/w211_game.dat151.rel',
	'w211/audioconfig/w211_sounds.dat54.rel',
	'w211/sfx/dlc_w211/w211.awc',
	'w211/sfx/dlc_w211/w211_npc.awc',

    '918spyeng/audioconfig/918spyeng_amp.dat10.rel',
	'918spyeng/audioconfig/918spyeng_game.dat151.rel',
	'918spyeng/audioconfig/918spyeng_sounds.dat54.rel',
	'918spyeng/sfx/dlc_918spyeng/918spyeng.awc',
	'918spyeng/sfx/dlc_918spyeng/918spyeng_npc.awc',

    'dloader5/vehicles.meta',
    'dloader5/carvariations.meta',

    '370z/vehicles.meta',
    '370z/carvariations.meta',

    'bentley_continental/vehicles.meta',
    'bentley_continental/carvariations.meta',

    'gle63c/vehicles.meta',
    'gle63c/carvariations.meta',

    'plymouth58/vehicles.meta',
    'plymouth58/carvariations.meta',

    'mbbs20/vehicles.meta',
    'mbbs20/carvariations.meta',

    'g63_brabus/vehicles.meta',
    'g63_brabus/carcols.meta',
    'g63_brabus/carvariations.meta',

    'RR-ghost/vehicles.meta',
    'RR-ghost/carcols.meta',
    'RR-ghost/carvariations.meta',

    'mustang_1965/vehicles.meta',
    'mustang_1965/carcols.meta',
    'mustang_1965/carvariations.meta',

    '610dtm/vehicles.meta',
    '610dtm/carcols.meta',
    '610dtm/carvariations.meta',

    'tmodels/carcols.meta',
    'tmodels/carvariations.meta',
    'tmodels/vehicles.meta',

    'q820/carcols.meta',
    'q820/carvariations.meta',
    'q820/vehicles.meta',


    'rmodm8c/vehicles.meta',
    'rmodm8c/carcols.meta',
    'rmodm8c/carvariations.meta',

    'C63AMG/vehicles.meta',
    'C63AMG/carcols.meta',
    'C63AMG/carvariations.meta',

    'aston_dbx/vehicles.meta',
    'aston_dbx/carvariations.meta',

    'taco_chinois/vehicles.meta',
    'taco_burgershot/vehicles.meta',
    'taco_pizzeria_sanchez/vehicles.meta',
    'taco_pearl/vehicles.meta',
    'taco_pop_dinner/vehicles.meta',
    'peel_p50/vehicles.meta',


    'x6m/vehicles.meta',
    'x6m/carcols.meta',
    'x6m/carvariations.meta',

    'modelsS/vehicles.meta',
    'modelsS/carcols.meta',
    'modelsS/carvariations.meta',

    'FastFurious/vehicles.meta',
    'FastFurious/carcols.meta',
    'FastFurious/carvariations.meta',
    'FastFurious/vehiclelayouts.meta',

    'rs7c8/vehicles.meta',
    'rs7c8/carcols.meta',
    'rs7c8/carvariations.meta',

    'multipla1/vehicles.meta',
    'multipla1/carcols.meta',
    'multipla1/carvariations.meta',

    'ford_branco/vehicles.meta',
    'ford_branco/carcols.meta',
    'ford_branco/carvariations.meta',

    'gt63amg/vehicles.meta',
    'gt63amg/carcols.meta',
    'gt63amg/carvariations.meta',

    'nissan_r32/vehicles.meta',
    'nissan_r32/carcols.meta',
    'nissan_r32/carvariations.meta',

    'regalia/vehicles.meta',
    'regalia/carcols.meta',
    'regalia/carvariations.meta',

    'Range_SVR/vehicles.meta',
    'Range_SVR/carvariations.meta',

    'gt500_2020/vehicles.meta',
    'gt500_2020/carvariations.meta',

    'raptor2017/vehicles.meta',
    'raptor2017/carcols.meta',
    'raptor2017/carvariations.meta',

    'c32amg2004/vehicles.meta',
    'c32amg2004/carvariations.meta',

    'f450bennys/vehicles.meta',
    'f450bennys/carcols.meta',
    'f450bennys/carvariations.meta',

    'f550bennys/vehicles.meta',
    'f550bennys/carcols.meta',
    'f550bennys/carvariations.meta',
    'f550bennys/vehiclelayouts.meta',

    'f450_torreto/vehicles.meta',
    'f450_torreto/carcols.meta',
    'f450_torreto/carvariations.meta',

    'f550_torreto/vehicles.meta',
    'f550_torreto/carcols.meta',
    'f550_torreto/carvariations.meta',
    'f550_torreto/vehiclelayouts.meta',

    's500_2021/vehicles.meta',
    's500_2021/carcols.meta',
    's500_2021/carvariations.meta',

    'wrangler_2012/vehicles.meta',
    'wrangler_2012/carcols.meta',
    'wrangler_2012/carvariations.meta',

    'Urus/vehicles.meta',
    'Urus/carcols.meta',
    'Urus/carvariations.meta',
    'Urus/vehiclelayouts.meta',

    'rs6_c7/vehicles.meta',
    'rs6_c7/carcols.meta',
    'rs6_c7/carvariations.meta',
    'rs6_c7/vehiclelayouts.meta',

    'mclaren_720/vehicles.meta',
    'mclaren_720/carcols.meta',
    'mclaren_720/carvariations.meta',
    'mclaren_720/vehiclelayouts.meta',

    '720s/vehicles.meta',
    '720s/carcols.meta',
    '720s/carvariations.meta',
    '720s/vehiclelayouts.meta',

    'porsche911/vehicles.meta',
    'porsche911/carcols.meta',
    'porsche911/carvariations.meta',

    '488/vehicles.meta',
    '488/carcols.meta',
    '488/carvariations.meta',
    '488/vehiclelayouts.meta',

    'a45/vehicles.meta',
    'a45/carcols.meta',
    'a45/carvariations.meta',

    'rs6/vehicles.meta',
    'rs6/carcols.meta',
    'rs6/carvariations.meta',
    'rs6/vehiclelayouts.meta',

    'srt8/vehicles.meta',
    'srt8/carcols.meta',
    'srt8/carvariations.meta',
    'srt8/vehiclelayouts.meta',

    'bmwm760i/vehicles.meta',
    'bmwm760i/carcols.meta',
    'bmwm760i/carvariations.meta',

    'mqgts_data/vehicles.meta',
    'mqgts_data/carcols.meta',
    'mqgts_data/carvariations.meta',

    'dodge_challenger/vehicles.meta',
    'dodge_challenger/carcols.meta',
    'dodge_challenger/carvariations.meta',

    'jzx100/vehicles.meta',
    'jzx100/carcols.meta',
    'jzx100/carvariations.meta',
    'jzx100/vehiclelayouts.meta',

    'bmwg07/vehicles.meta',
    'bmwg07/carcols.meta',
    'bmwg07/carvariations.meta',

    'e46/vehicles.meta',
    'e46/carcols.meta',
    'e46/carvariations.meta',

    'agerars/vehicles.meta',
    'agerars/carcols.meta',
    'agerars/carvariations.meta',

    '1966_novass/carcols.meta',
    '1966_novass/vehicles.meta',
    '1966_novass/carvariations.meta',

    '70coronet/carcols.meta',
    '70coronet/vehicles.meta',
    '70coronet/carvariations.meta',

    'chevelle1970/carcols.meta',
    'chevelle1970/vehicles.meta',
    'chevelle1970/carvariations.meta',

    'ShelbyGT500/carcols.meta',
    'ShelbyGT500/vehicles.meta',
    'ShelbyGT500/carvariations.meta',

    'm2_data/carcols.meta',
    'm2_data/vehicles.meta',
    'm2_data/carvariations.meta',

    'M3E30/carcols.meta',
    'M3E30/vehicles.meta',
    'M3E30/carvariations.meta',

    'M4C/vehicles.meta',
    'M4C/carvariations.meta',

    'M5E60/carcols.meta',
    'M5E60/vehicles.meta',
    'M5E60/carvariations.meta',

    'F90_2018/carcols.meta',
    'F90_2018/vehicles.meta',
    'F90_2018/carvariations.meta',

    'm4gts/carcols.meta',
    'm4gts/vehicles.meta',
    'm4gts/carvariations.meta',

    'aston_victor/vehicles.meta',
    'aston_victor/carvariations.meta',

    'RT70/vehicles.meta',
    'RT70/carvariations.meta',

    'e63brabus/vehicles.meta',
    'e63brabus/carcols.meta',
    'e63brabus/carvariations.meta',
    'e63brabus/vehiclelayouts.meta',

    'brabus_rocket_800/carcols.meta',
    'brabus_rocket_800/vehicles.meta',
    'brabus_rocket_800/carvariations.meta',

    'ferrari_aperta/carcols.meta',
    'ferrari_aperta/vehicles.meta',
    'ferrari_aperta/carvariations.meta',

    'carrera_rs_1973/carcols.meta',
    'carrera_rs_1973/vehicles.meta',
    'carrera_rs_1973/carvariations.meta',

    'svr16/carcols.meta',
  	'svr16/vehicles.meta',
  	'svr16/carvariations.meta',

  	'GMC/carcols.meta',
  	'GMC/vehicles.meta',
  	'GMC/carvariations.meta',

  	'rrs08/carcols.meta',
    'rrs08/vehicles.meta',
    'rrs08/carvariations.meta',

    'rrst/carcols.meta',
    'rrst/vehicles.meta',
    'rrst/carvariations.meta',


    'escalade21/carcols.meta',
    'escalade21/vehicles.meta',
    'escalade21/carvariations.meta',

    'master2019/carcols.meta',
    'master2019/handling.meta',
    'master2019/vehicles.meta',
    'master2019/carvariations.meta', 

    'eldorado1978/carcols.meta',
    'eldorado1978/vehicles.meta',
    'eldorado1978/carvariations.meta',

    'eldorado59/carcols.meta',
    'eldorado59/vehicles.meta',
    'eldorado59/carvariations.meta',

    'bonneville58/carcols.meta',
    'bonneville58/vehicles.meta',
    'bonneville58/carvariations.meta',

    'skylineGTRc110/vehicles.meta',
    'skylineGTRc110/carcols.meta',
    'skylineGTRc110/carvariations.meta',
    'skylineGTRc110/vehiclelayouts.meta',

    'G-Klasse/vehicles.meta',
    'G-Klasse/carcols.meta',
    'G-Klasse/carvariations.meta',
    'G-Klasse/vehiclelayouts.meta',

    'teslapd/vehicles.meta',
    'teslapd/carvariations.meta',

    'lambose/vehicles.meta',
    'lambose/carcols.meta',
    'lambose/carvariations.meta',
    'lambose/vehiclelayouts.meta',

    'Chevrolet_c8/vehicles.meta',
    'Chevrolet_c8/carvariations.meta',

    'rs6c8_no_break/carcols.meta',
    'rs6c8_no_break/vehicles.meta',
    'rs6c8_no_break/carvariations.meta',

    'gts11/carcols.meta',
    'gts11/vehicles.meta',
    'gts11/carvariations.meta',

    'benz/carcols.meta',
    'benz/vehicles.meta',
    'benz/carvariations.meta',

    '18performante/carcols.meta',
    '18performante/vehicles.meta',
    '18performante/carvariations.meta',

    'sprinter/vehicles.meta',
    'sprinter/carcols.meta',
    'sprinter/carvariations.meta',
    'sprinter/vehiclelayouts.meta',

    'bolide/carcols.meta',
    'bolide/vehicles.meta',
    'bolide/carvariations.meta',

    'ngtr35nismo17/carcols.meta',
    'ngtr35nismo17/vehicles.meta',
    'ngtr35nismo17/carvariations.meta',

    'chiron17/carcols.meta',
    'chiron17/vehicles.meta',
    'chiron17/carvariations.meta',

    'toyota_AE86/carcols.meta',
    'toyota_AE86/vehicles.meta',
    'toyota_AE86/carvariations.meta',

    'rx7veilside/carcols.meta',
    'rx7veilside/vehicles.meta',
    'rx7veilside/carvariations.meta',

    'ram1500_2020/carcols.meta',
    'ram1500_2020/vehicles.meta',
    'ram1500_2020/carvariations.meta',

    'r8_2020/carcols.meta',
    'r8_2020/vehicles.meta',
    'r8_2020/carvariations.meta',

    'lexus_lc_500/carcols.meta',
    'lexus_lc_500/vehicles.meta',
    'lexus_lc_500/carvariations.meta',

    'SLR_Mclaren_2005/vehicles.meta',
    'SLR_Mclaren_2005/carvariations.meta',

    'M8GrandCoupe/carcols.meta',
    'M8GrandCoupe/vehicles.meta',
    'M8GrandCoupe/carvariations.meta',

    'pagani_Imola/carcols.meta',
    'pagani_Imola/vehicles.meta',
    'pagani_Imola/carvariations.meta',

    'mustang_gt_2015/carcols.meta',
    'mustang_gt_2015/vehicles.meta',
    'mustang_gt_2015/carvariations.meta',

    'rmodbugatti/carcols.meta',
    'rmodbugatti/vehicles.meta',
    'rmodbugatti/carvariations.meta',

    'rmodsianr/carcols.meta',
    'rmodsianr/vehicles.meta',
    'rmodsianr/carvariations.meta',

    'camaro_zl1_2017/carcols.meta',
    'camaro_zl1_2017/vehicles.meta',
    'camaro_zl1_2017/carvariations.meta',

    'ford_mustang_hpe750/carcols.meta',
    'ford_mustang_hpe750/vehicles.meta',
    'ford_mustang_hpe750/carvariations.meta',

    'dodge_charger_srt_2020/carcols.meta',
    'dodge_charger_srt_2020/vehicles.meta',
    'dodge_charger_srt_2020/carvariations.meta',

    'focusrs/carcols.meta',
    'focusrs/vehicles.meta',
    'focusrs/carvariations.meta',

    'AUDetrongt18/carcols.meta',
    'AUDetrongt18/vehicles.meta',
    'AUDetrongt18/carvariations.meta',

    'lamborghini_centenario_roadster_770r/carcols.meta',
    'lamborghini_centenario_roadster_770r/vehicles.meta',
    'lamborghini_centenario_roadster_770r/carvariations.meta',

    'amg-one/carcols.meta',
    'amg-one/vehicles.meta',
    'amg-one/carvariations.meta',

    'c63_libertywalk_2014/vehicles.meta',
    'c63_libertywalk_2014/carvariations.meta',

    'delta_integrale_1992/carcols.meta',
    'delta_integrale_1992/vehicles.meta',
    'delta_integrale_1992/carvariations.meta',

    'mercedes_SLS_AMG_2011/carcols.meta',
    'mercedes_SLS_AMG_2011/vehicles.meta',
    'mercedes_SLS_AMG_2011/carvariations.meta',

    'i8M_libertywalk/vehicles.meta',
    'i8M_libertywalk/carcols.meta',
    'i8M_libertywalk/carvariations.meta',
    'i8M_libertywalk/vehiclelayouts.meta',

    'rs318/carcols.meta',
    'rs318/vehicles.meta',
    'rs318/carvariations.meta',

    'Mitsubishi_EVO_9/carcols.meta',
    'Mitsubishi_EVO_9/vehicles.meta',
    'Mitsubishi_EVO_9/carvariations.meta',

    'Nissan_350Z_Veilside/carcols.meta',
    'Nissan_350Z_Veilside/vehicles.meta',
    'Nissan_350Z_Veilside/carvariations.meta',

    'Rolls_Royce_Dawn/carcols.meta',
    'Rolls_Royce_Dawn/vehicles.meta',
    'Rolls_Royce_Dawn/carvariations.meta',

    'Cadillac_CTS_V/carcols.meta',
    'Cadillac_CTS_V/vehicles.meta',
    'Cadillac_CTS_V/carvariations.meta',

    'Camaro_SS_2016/carcols.meta',
    'Camaro_SS_2016/vehicles.meta',
    'Camaro_SS_2016/carvariations.meta',
    
    'Mercedes_c63_blackseries/carcols.meta',
    'Mercedes_c63_blackseries/vehicles.meta',
    'Mercedes_c63_blackseries/carvariations.meta',

    'lincoln_navigator/carcols.meta',
    'lincoln_navigator/vehicles.meta',
    'lincoln_navigator/carvariations.meta',

    'Bentley_Continental_2018/carcols.meta',
    'Bentley_Continental_2018/vehicles.meta',
    'Bentley_Continental_2018/carvariations.meta',

    'PorsheGT3/carcols.meta',
    'PorsheGT3/vehicles.meta',
    'PorsheGT3/carvariations.meta',

    'MeganRS18/carcols.meta',
    'MeganRS18/vehicles.meta',
    'MeganRS18/carvariations.meta',

    'Renaullt5_Turbo/carcols.meta',
    'Renaullt5_Turbo/vehicles.meta',
    'Renaullt5_Turbo/carvariations.meta',

    'Ferrari_f50/carcols.meta',
    'Ferrari_f50/vehicles.meta',
    'Ferrari_f50/carvariations.meta',

    'Lambo_lp700/carcols.meta',
    'Lambo_lp700/vehicles.meta',
    'Lambo_lp700/carvariations.meta',

    'Toyota_SupraMKV/carcols.meta',
    'Toyota_SupraMKV/vehicles.meta',
    'Toyota_SupraMKV/carvariations.meta',

    'Ferrari_488_gtb/carcols.meta',
    'Ferrari_488_gtb/vehicles.meta',
    'Ferrari_488_gtb/carvariations.meta',

    'Ferrari_812/carcols.meta',
    'Ferrari_812/vehicles.meta',
    'Ferrari_812/carvariations.meta',

    'Cupra/carcols.meta',
    'Cupra/vehicles.meta',
    'Cupra/carvariations.meta',

    'Ferrari_F40_Competizione/carcols.meta',
    'Ferrari_F40_Competizione/vehicles.meta',
    'Ferrari_F40_Competizione/carvariations.meta',

    'Nissan_GTR_Custom/carcols.meta',
    'Nissan_GTR_Custom/vehicles.meta',
    'Nissan_GTR_Custom/carvariations.meta',

    'Ferrari_250_GTO/carcols.meta',
    'Ferrari_250_GTO/vehicles.meta',
    'Ferrari_250_GTO/carvariations.meta',

    'golf75r/carcols.meta',
    'golf75r/vehicles.meta',
    'golf75r/carvariations.meta',

    'Mercedes_CLK_GTR_98/carcols.meta',
    'Mercedes_CLK_GTR_98/vehicles.meta',
    'Mercedes_CLK_GTR_98/carvariations.meta',

    'Aston_Martin_One77/carcols.meta',
    'Aston_Martin_One77/vehicles.meta',
    'Aston_Martin_One77/carvariations.meta',

    'Porshe_Taycan/carcols.meta',
    'Porshe_Taycan/vehicles.meta',
    'Porshe_Taycan/carvariations.meta',

    'Lamborghini_Terzo_Millennio/carcols.meta',
    'Lamborghini_Terzo_Millennio/vehicles.meta',
    'Lamborghini_Terzo_Millennio/carvariations.meta',

    'Bugtatti_Divo19/carcols.meta',
    'Bugtatti_Divo19/vehicles.meta',
    'Bugtatti_Divo19/carvariations.meta',

    'Maserati_MC12/carcols.meta',
    'Maserati_MC12/vehicles.meta',
    'Maserati_MC12/carvariations.meta',

    'McLaren_P1GT/carcols.meta',
    'McLaren_P1GT/vehicles.meta',
    'McLaren_P1GT/carvariations.meta',

    'BMW_M8_TUN/carcols.meta',
    'BMW_M8_TUN/vehicles.meta',
    'BMW_M8_TUN/carvariations.meta',

    'Bentley_Bentayga/carcols.meta',
    'Bentley_Bentayga/vehicles.meta',
    'Bentley_Bentayga/carvariations.meta',

    'bmwe38/carcols.meta',
    'bmwe38/vehicles.meta',
    'bmwe38/carvariations.meta',

    'Mitsubishi_EVO10/carcols.meta',
    'Mitsubishi_EVO10/vehicles.meta',
    'Mitsubishi_EVO10/carvariations.meta',

    'Ferrari_430/carcols.meta',
    'Ferrari_430/vehicles.meta',
    'Ferrari_430/carvariations.meta',

    'Ford_1940/carcols.meta',
    'Ford_1940/vehicles.meta',
    'Ford_1940/carvariations.meta',

    'impreza2019/carcols.meta',
    'impreza2019/vehicles.meta',
    'impreza2019/carvariations.meta',

    'golf8/carcols.meta',
    'golf8/vehicles.meta',
    'golf8/carvariations.meta',

    'BMW_Serie1/carcols.meta',
    'BMW_Serie1/vehicles.meta',
    'BMW_Serie1/carvariations.meta',

    'McLaren_Senna/carcols.meta',
    'McLaren_Senna/vehicles.meta',
    'McLaren_Senna/carvariations.meta',

    'benze55/carcols.meta',
    'benze55/vehicles.meta',
    'benze55/carvariations.meta',

    'Ferrari_F12_TDF/carcols.meta',
    'Ferrari_F12_TDF/vehicles.meta',
    'Ferrari_F12_TDF/carvariations.meta',
}

data_file 'CARCOLS_FILE' 'escalade21/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'escalade21/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'escalade21/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'q820/vehicles.meta'
data_file 'CARCOLS_FILE' 'q820/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'q820/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'dloader5/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'dloader5/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' '370z/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' '370z/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'bentley_continental/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bentley_continental/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'gle63c/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'gle63c/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'plymouth58/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'plymouth58/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'mbbs20/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mbbs20/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'  'g63_brabus/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'g63_brabus/carvariations.meta'
data_file 'CARCOLS_FILE'           'g63_brabus/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'nissan_r32/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'nissan_r32/carvariations.meta'
data_file 'CARCOLS_FILE'           'nissan_r32/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'regalia/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'regalia/carvariations.meta'
data_file 'CARCOLS_FILE'           'regalia/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'   'mustang_1965/vehicles.meta'
data_file 'CARCOLS_FILE'            'mustang_1965/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'mustang_1965/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   '610dtm/vehicles.meta'
data_file 'CARCOLS_FILE'            '610dtm/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  '610dtm/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'rmodm8c/vehicles.meta'
data_file 'CARCOLS_FILE'            'rmodm8c/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'rmodm8c/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'RR-ghost/vehicles.meta'
data_file 'CARCOLS_FILE'            'RR-ghost/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'RR-ghost/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'C63AMG/vehicles.meta'
data_file 'CARCOLS_FILE'            'C63AMG/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'C63AMG/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'aston_dbx/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'  'aston_dbx/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'taco_chinois/vehicles.meta'
data_file 'VEHICLE_METADATA_FILE'   'taco_burgershot/vehicles.meta'
data_file 'VEHICLE_METADATA_FILE'   'taco_pizzeria_sanchez/vehicles.meta'
data_file 'VEHICLE_METADATA_FILE'   'taco_pearl/vehicles.meta'
data_file 'VEHICLE_METADATA_FILE'   'taco_pop_dinner/vehicles.meta'

data_file 'VEHICLE_METADATA_FILE'   'peel_p50/vehicles.meta'


data_file 'VEHICLE_METADATA_FILE'   'x6m/vehicles.meta'
data_file 'CARCOLS_FILE'            'x6m/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'x6m/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'modelsS/vehicles.meta'
data_file 'CARCOLS_FILE'            'modelsS/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'modelsS/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'FastFurious/vehicles.meta'
data_file 'CARCOLS_FILE'            'FastFurious/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'FastFurious/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'FastFurious/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE' 'rs7c8/vehicles.meta'
data_file 'CARCOLS_FILE'            'rs7c8/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'rs7c8/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'multipla1/vehicles.meta'
data_file 'CARCOLS_FILE'            'multipla1/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'multipla1/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'ford_branco/vehicles.meta'
data_file 'CARCOLS_FILE'            'ford_branco/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'ford_branco/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'gt63amg/vehicles.meta'
data_file 'CARCOLS_FILE'            'gt63amg/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'gt63amg/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'tmodels/vehicles.meta'
data_file 'CARCOLS_FILE'            'tmodels/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'tmodels/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'Range_SVR/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'  'Range_SVR/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'gt500_2020/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE'  'gt500_2020/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'raptor2017/vehicles.meta'
data_file 'CARCOLS_FILE'            'raptor2017/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'raptor2017/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'  'c32amg2004/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'c32amg2004/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'f450bennys/vehicles.meta'
data_file 'CARCOLS_FILE'            'f450bennys/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'f450bennys/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'f550bennys/vehicles.meta'
data_file 'CARCOLS_FILE'            'f550bennys/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'f550bennys/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'f550bennys/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'   'f450_torreto/vehicles.meta'
data_file 'CARCOLS_FILE'            'f450_torreto/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'f450_torreto/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'f550_torreto/vehicles.meta'
data_file 'CARCOLS_FILE'            'f550_torreto/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'f550_torreto/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 	'f550_torreto/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'   's500_2021/vehicles.meta'
data_file 'CARCOLS_FILE'            's500_2021/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  's500_2021/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'wrangler_2012/vehicles.meta'
data_file 'CARCOLS_FILE'            'wrangler_2012/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'wrangler_2012/carvariations.meta'

data_file 'VEHICLE_LAYOUTS_FILE' 'Urus/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'Urus/vehicles.meta'
data_file 'CARCOLS_FILE' 'Urus/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Urus/carvariations.meta'

data_file 'VEHICLE_LAYOUTS_FILE' 'rs6_c7/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'rs6_c7/vehicles.meta'
data_file 'CARCOLS_FILE' 'rs6_c7/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rs6_c7/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'mclaren_720/vehicles.meta'
data_file 'CARCOLS_FILE'            'mclaren_720/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'mclaren_720/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'mclaren_720/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'   '720s/vehicles.meta'
data_file 'CARCOLS_FILE'            '720s/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  '720s/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' '720s/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'  'porsche911/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'porsche911/carvariations.meta'
data_file 'CARCOLS_FILE'           'porsche911/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'   '488/vehicles.meta'
data_file 'CARCOLS_FILE'            '488/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  '488/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' '488/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'  'a45/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'a45/carvariations.meta'
data_file 'CARCOLS_FILE'           'a45/carcols.meta'

data_file 'VEHICLE_LAYOUTS_FILE' 'rs6/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'rs6/vehicles.meta'
data_file 'CARCOLS_FILE' 'rs6/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rs6/carvariations.meta'

data_file 'VEHICLE_LAYOUTS_FILE' 'srt8/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'srt8/vehicles.meta'
data_file 'CARCOLS_FILE' 'srt8/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'srt8/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'  'bmwm760i/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bmwm760i/carvariations.meta'
data_file 'CARCOLS_FILE'           'bmwm760i/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'mqgts_data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mqgts_data/carvariations.meta'
data_file 'CARCOLS_FILE'           'mqgts_data/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'dodge_challenger/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'dodge_challenger/carvariations.meta'
data_file 'CARCOLS_FILE'           'dodge_challenger/carcols.meta'

data_file 'AUDIO_SYNTHDATA' 'p60b40/audioconfig/p60b40_amp.dat'
data_file 'AUDIO_GAMEDATA' 'p60b40/audioconfig/p60b40_game.dat'
data_file 'AUDIO_SOUNDDATA' 'p60b40/audioconfig/p60b40_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'p60b40/sfx/dlc_p60b40'

data_file 'AUDIO_SYNTHDATA' 'f136/audioconfig/f136_amp.dat'
data_file 'AUDIO_GAMEDATA' 'f136/audioconfig/f136_game.dat'
data_file 'AUDIO_SOUNDDATA' 'f136/audioconfig/f136_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'f136/sfx/dlc_f136'

data_file 'AUDIO_SYNTHDATA' 'w211/audioconfig/w211_amp.dat'
data_file 'AUDIO_GAMEDATA' 'w211/audioconfig/w211_game.dat'
data_file 'AUDIO_SOUNDDATA' 'w211/audioconfig/w211_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'w211/sfx/dlc_w211'

data_file 'AUDIO_SYNTHDATA' '918spyeng/audioconfig/918spyeng_amp.dat'
data_file 'AUDIO_GAMEDATA' '918spyeng/audioconfig/918spyeng_game.dat'
data_file 'AUDIO_SOUNDDATA' '918spyeng/audioconfig/918spyeng_sounds.dat'
data_file 'AUDIO_WAVEPACK' '918spyeng/sfx/dlc_918spyeng'

data_file 'VEHICLE_METADATA_FILE'   'jzx100/vehicles.meta'
data_file 'CARCOLS_FILE'            'jzx100/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'jzx100/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'jzx100/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'  'bmwg07/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bmwg07/carvariations.meta'
data_file 'CARCOLS_FILE'           'bmwg07/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'e46/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'e46/carvariations.meta'
data_file 'CARCOLS_FILE'           'e46/carcols.meta'

data_file 'VEHICLE_METADATA_FILE'  'agerars/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'agerars/carvariations.meta'
data_file 'CARCOLS_FILE'           'agerars/carcols.meta'

data_file 'CARCOLS_FILE' '1966_novass/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' '1966_novass/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' '1966_novass/carvariations.meta'

data_file 'CARCOLS_FILE' '70coronet/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' '70coronet/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' '70coronet/carvariations.meta'

data_file 'CARCOLS_FILE' 'chevelle1970/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'chevelle1970/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'chevelle1970/carvariations.meta'

data_file 'CARCOLS_FILE' 'ShelbyGT500/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'ShelbyGT500/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ShelbyGT500/carvariations.meta'

data_file 'CARCOLS_FILE' 'm2_data/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'm2_data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'm2_data/carvariations.meta'

data_file 'CARCOLS_FILE' 'M3E30/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'M3E30/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'M3E30/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'M4C/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'M4C/carvariations.meta'

data_file 'CARCOLS_FILE' 'M5E60/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'M5E60/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'M5E60/carvariations.meta'

data_file 'CARCOLS_FILE' 'F90_2018/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'F90_2018/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'F90_2018/carvariations.meta'

data_file 'CARCOLS_FILE' 'm4gts/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'm4gts/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'm4gts/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'aston_victor/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'aston_victor/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'RT70/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'RT70/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'e63brabus/vehicles.meta'
data_file 'CARCOLS_FILE'            'e63brabus/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'e63brabus/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'e63brabus/vehiclelayouts.meta'

data_file 'CARCOLS_FILE' 'brabus_rocket_800/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'brabus_rocket_800/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'brabus_rocket_800/carvariations.meta'

data_file 'CARCOLS_FILE' 'ferrari_aperta/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'ferrari_aperta/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ferrari_aperta/carvariations.meta'

data_file 'CARCOLS_FILE' 'carrera_rs_1973/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'carrera_rs_1973/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carrera_rs_1973/carvariations.meta'

data_file 'CARCOLS_FILE' 'svr16/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'svr16/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'svr16/carvariations.meta'

data_file 'CARCOLS_FILE' 'GMC/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'GMC/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'GMC/carvariations.meta'

data_file 'CARCOLS_FILE' 'rrs08/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rrs08/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rrs08/carvariations.meta'

data_file 'CARCOLS_FILE' 'rrst/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rrst/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rrst/carvariations.meta'

data_file 'CARCOLS_FILE' 'master2019/carcols.meta'
data_file 'HANDLING_FILE' 'master2019/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'master2019/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'master2019/carvariations.meta'

data_file 'CARCOLS_FILE' 'eldorado1978/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'eldorado1978/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'eldorado1978/carvariations.meta'

data_file 'CARCOLS_FILE' 'eldorado59/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'eldorado59/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'eldorado59/carvariations.meta'

data_file 'CARCOLS_FILE' 'bonneville58/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'bonneville58/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bonneville58/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'skylineGTRc110/vehicles.meta'
data_file 'CARCOLS_FILE'            'skylineGTRc110/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'skylineGTRc110/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'skylineGTRc110/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'   'G-Klasse/vehicles.meta'
data_file 'CARCOLS_FILE'            'G-Klasse/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'G-Klasse/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'G-Klasse/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE'   'sprinter/vehicles.meta'
data_file 'CARCOLS_FILE'            'sprinter/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'sprinter/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'sprinter/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE' 'teslapd/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'teslapd/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'lambose/vehicles.meta'
data_file 'CARCOLS_FILE'            'lambose/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'lambose/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'lambose/vehiclelayouts.meta'

data_file 'VEHICLE_METADATA_FILE' 'Chevrolet_c8/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Chevrolet_c8/carvariations.meta'

data_file 'CARCOLS_FILE' 'rs6c8_no_break/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rs6c8_no_break/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rs6c8_no_break/carvariations.meta'

data_file 'CARCOLS_FILE' 'gts11/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'gts11/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'gts11/carvariations.meta'

data_file 'CARCOLS_FILE' 'benz/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'benz/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'benz/carvariations.meta'

data_file 'CARCOLS_FILE' '18performante/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' '18performante/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' '18performante/carvariations.meta'

data_file 'CARCOLS_FILE' 'bolide/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'bolide/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bolide/carvariations.meta'

data_file 'CARCOLS_FILE' 'ngtr35nismo17/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'ngtr35nismo17/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ngtr35nismo17/carvariations.meta'

data_file 'CARCOLS_FILE' 'chiron17/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'chiron17/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'chiron17/carvariations.meta'

data_file 'CARCOLS_FILE' 'toyota_AE86/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'toyota_AE86/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'toyota_AE86/carvariations.meta'

data_file 'CARCOLS_FILE' 'rx7veilside/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rx7veilside/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rx7veilside/carvariations.meta'

data_file 'CARCOLS_FILE' 'ram1500_2020/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'ram1500_2020/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ram1500_2020/carvariations.meta'

data_file 'CARCOLS_FILE' 'r8_2020/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'r8_2020/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'r8_2020/carvariations.meta'

data_file 'CARCOLS_FILE' 'lexus_lc_500/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'lexus_lc_500/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'lexus_lc_500/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'SLR_Mclaren_2005/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'SLR_Mclaren_2005/carvariations.meta'

data_file 'CARCOLS_FILE' 'M8GrandCoupe/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'M8GrandCoupe/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'M8GrandCoupe/carvariations.meta'

data_file 'CARCOLS_FILE' 'pagani_Imola/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'pagani_Imola/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'pagani_Imola/carvariations.meta'

data_file 'CARCOLS_FILE' 'rmodbugatti/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rmodbugatti/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rmodbugatti/carvariations.meta'

data_file 'CARCOLS_FILE' 'rmodsianr/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rmodsianr/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rmodsianr/carvariations.meta'

data_file 'CARCOLS_FILE' 'camaro_zl1_2017/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'camaro_zl1_2017/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'camaro_zl1_2017/carvariations.meta'

data_file 'CARCOLS_FILE' 'ford_mustang_hpe750/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'ford_mustang_hpe750/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'ford_mustang_hpe750/carvariations.meta'

data_file 'CARCOLS_FILE' 'dodge_charger_srt_2020/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'dodge_charger_srt_2020/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'dodge_charger_srt_2020/carvariations.meta'

data_file 'CARCOLS_FILE' 'focusrs/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'focusrs/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'focusrs/carvariations.meta'

data_file 'CARCOLS_FILE' 'AUDetrongt18/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'AUDetrongt18/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'AUDetrongt18/carvariations.meta'

data_file 'CARCOLS_FILE' 'lamborghini_centenario_roadster_770r/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'lamborghini_centenario_roadster_770r/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'lamborghini_centenario_roadster_770r/carvariations.meta'

data_file 'CARCOLS_FILE' 'amg-one/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'amg-one/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'amg-one/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'c63_libertywalk_2014/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'c63_libertywalk_2014/carvariations.meta'

data_file 'CARCOLS_FILE' 'delta_integrale_1992/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'delta_integrale_1992/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'delta_integrale_1992/carvariations.meta'

data_file 'CARCOLS_FILE' 'mercedes_SLS_AMG_2011/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'mercedes_SLS_AMG_2011/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mercedes_SLS_AMG_2011/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'i8M_libertywalk/vehicles.meta'
data_file 'CARCOLS_FILE'            'i8M_libertywalk/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'i8M_libertywalk/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'i8M_libertywalk/vehiclelayouts.meta'

data_file 'CARCOLS_FILE' 'rs318/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'rs318/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rs318/carvariations.meta'

data_file 'CARCOLS_FILE' 'Mitsubishi_EVO_9/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Mitsubishi_EVO_9/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Mitsubishi_EVO_9/carvariations.meta'

data_file 'CARCOLS_FILE' 'Nissan_350Z_Veilside/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Nissan_350Z_Veilside/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Nissan_350Z_Veilside/carvariations.meta'

data_file 'CARCOLS_FILE' 'Rolls_Royce_Dawn/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Rolls_Royce_Dawn/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Rolls_Royce_Dawn/carvariations.meta'

data_file 'CARCOLS_FILE' 'Cadillac_CTS_V/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Cadillac_CTS_V/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Cadillac_CTS_V/carvariations.meta'

data_file 'CARCOLS_FILE' 'Camaro_SS_2016/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Camaro_SS_2016/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Camaro_SS_2016/carvariations.meta'

data_file 'CARCOLS_FILE' 'Mercedes_c63_blackseries/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Mercedes_c63_blackseries/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Mercedes_c63_blackseries/carvariations.meta'

data_file 'CARCOLS_FILE' 'mustang_gt_2015/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'mustang_gt_2015/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mustang_gt_2015/carvariations.meta'

data_file 'CARCOLS_FILE' 'lincoln_navigator/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'lincoln_navigator/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'lincoln_navigator/carvariations.meta'

data_file 'CARCOLS_FILE' 'Bentley_Continental_2018/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Bentley_Continental_2018/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Bentley_Continental_2018/carvariations.meta'

data_file 'CARCOLS_FILE' 'PorsheGT3/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'PorsheGT3/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'PorsheGT3/carvariations.meta'

data_file 'CARCOLS_FILE' 'MeganRS18/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'MeganRS18/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'MeganRS18/carvariations.meta'

data_file 'CARCOLS_FILE' 'Renaullt5_Turbo/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Renaullt5_Turbo/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Renaullt5_Turbo/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_f50/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_f50/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_f50/carvariations.meta'

data_file 'CARCOLS_FILE' 'Lambo_lp700/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Lambo_lp700/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Lambo_lp700/carvariations.meta'

data_file 'CARCOLS_FILE' 'Toyota_SupraMKV/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Toyota_SupraMKV/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Toyota_SupraMKV/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_488_gtb/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_488_gtb/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_488_gtb/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_812/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_812/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_812/carvariations.meta'

data_file 'CARCOLS_FILE' 'Cupra/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Cupra/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Cupra/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_F40_Competizione/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_F40_Competizione/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_F40_Competizione/carvariations.meta'

data_file 'CARCOLS_FILE' 'Nissan_GTR_Custom/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Nissan_GTR_Custom/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Nissan_GTR_Custom/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_250_GTO/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_250_GTO/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_250_GTO/carvariations.meta'

data_file 'CARCOLS_FILE' 'golf75r/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'golf75r/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'golf75r/carvariations.meta'

data_file 'CARCOLS_FILE' 'Mercedes_CLK_GTR_98/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Mercedes_CLK_GTR_98/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Mercedes_CLK_GTR_98/carvariations.meta'

data_file 'CARCOLS_FILE' 'Aston_Martin_One77/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Aston_Martin_One77/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Aston_Martin_One77/carvariations.meta'

data_file 'CARCOLS_FILE' 'Porshe_Taycan/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Porshe_Taycan/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Porshe_Taycan/carvariations.meta'

data_file 'CARCOLS_FILE' 'Lamborghini_Terzo_Millennio/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Lamborghini_Terzo_Millennio/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Lamborghini_Terzo_Millennio/carvariations.meta'

data_file 'CARCOLS_FILE' 'Bugtatti_Divo19/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Bugtatti_Divo19/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Bugtatti_Divo19/carvariations.meta'

data_file 'CARCOLS_FILE' 'Maserati_MC12/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Maserati_MC12/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Maserati_MC12/carvariations.meta'

data_file 'CARCOLS_FILE' 'McLaren_P1GT/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'McLaren_P1GT/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'McLaren_P1GT/carvariations.meta'

data_file 'CARCOLS_FILE' 'BMW_M8_TUN/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'BMW_M8_TUN/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'BMW_M8_TUN/carvariations.meta'

data_file 'CARCOLS_FILE' 'Bentley_Bentayga/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Bentley_Bentayga/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Bentley_Bentayga/carvariations.meta'

data_file 'CARCOLS_FILE' 'bmwe38/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'bmwe38/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'bmwe38/carvariations.meta'

data_file 'CARCOLS_FILE' 'Mitsubishi_EVO10/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Mitsubishi_EVO10/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Mitsubishi_EVO10/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_430/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_430/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_430/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ford_1940/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ford_1940/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ford_1940/carvariations.meta'

data_file 'CARCOLS_FILE' 'impreza2019/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'impreza2019/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'impreza2019/carvariations.meta'

data_file 'CARCOLS_FILE' 'golf8/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'golf8/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'golf8/carvariations.meta'

data_file 'CARCOLS_FILE' 'BMW_Serie1/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'BMW_Serie1/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'BMW_Serie1/carvariations.meta'

data_file 'CARCOLS_FILE' 'McLaren_Senna/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'McLaren_Senna/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'McLaren_Senna/carvariations.meta'

data_file 'CARCOLS_FILE' 'benze55/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'benze55/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'benze55/carvariations.meta'

data_file 'CARCOLS_FILE' 'Ferrari_F12_TDF/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'Ferrari_F12_TDF/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Ferrari_F12_TDF/carvariations.meta']]--