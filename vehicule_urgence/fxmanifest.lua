fx_version('bodacious')
game('gta5')

client_scripts({
    'client/main.lua'
})

files({
    'data/**/carcols.meta',
    'data/**/carvariations.meta',
    'data/**/contentunlocks.meta',
    'data/**/handling.meta',
    'data/**/vehiclelayouts.meta',
    'data/**/vehicles.meta'
})

data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')
































--[[fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

data_file 'CARCOLS_FILE' 'data/pinnacle_lspd/carcols.meta'
data_file 'HANDLING_FILE' 'data/pinnacle_lspd/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/pinnacle_lspd/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/pinnacle_lspd/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/police_2/carcols.meta'
data_file 'HANDLING_FILE' 'data/police_2/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/police_2/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/police_2/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/police_felon/carcols.meta'
data_file 'HANDLING_FILE' 'data/police_felon/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/police_felon/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/police_felon/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/police_lspd/carcols.meta'
data_file 'HANDLING_FILE' 'data/police_lspd/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/police_lspd/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/police_lspd/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/police1_lspd/carcols.meta'
data_file 'HANDLING_FILE' 'data/police1_lspd/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/police1_lspd/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/police1_lspd/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/EMS1/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/EMS1/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/EMS1/carvariations.meta'
data_file 'HANDLING_FILE' 'data/EMS1/handling.meta'


data_file 'CARCOLS_FILE' 'data/EMS2/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/EMS2/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/EMS2/carvariations.meta'
data_file 'HANDLING_FILE' 'data/EMS2/handling.meta'


data_file 'CARCOLS_FILE' 'data/EMS3/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/EMS3/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/EMS3/carvariations.meta'
data_file 'HANDLING_FILE' 'data/EMS3/handling.meta'


data_file 'VEHICLE_LAYOUTS_FILE'   'data/bcsog/vehiclelayouts.meta'
data_file 'HANDLING_FILE'          'data/bcsog/handling.meta'
data_file 'VEHICLE_METADATA_FILE'  'data/bcsog/vehicles.meta'
data_file 'CARCOLS_FILE'           'data/bcsog/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/bcsog/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/lspd_car/carcols.meta'
data_file 'HANDLING_FILE' 'data/lspd_car/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/lspd_car/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/lspd_car/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/banaliser/carcols.meta'
data_file 'HANDLING_FILE' 'data/banaliser/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/banaliser/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/banaliser/carvariations.meta'

data_file 'VEHICLE_LAYOUTS_FILE' 'data/as332/vehiclelayouts.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/as332/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/as332/vehicles.meta'

data_file 'CARCOLS_FILE' 'data/limo/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/limo/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/limo/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/suv/carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/suv/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/suv/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE'   'data/weazel_18charg/vehicles.meta'
data_file 'CARCOLS_FILE' 			'data/weazel_18charg/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'data/weazel_18charg/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 	'data/weazel_21inter/vehicles.meta'
data_file 'CARCOLS_FILE' 			'data/weazel_21inter/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'data/weazel_21inter/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE'   'data/weazel_WR1500/vehicles.meta'
data_file 'CARCOLS_FILE'            'data/weazel_WR1500/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'  'data/weazel_WR1500/carvariations.meta'

data_file 'CARCOLS_FILE' 'data/moto_police/carcols.meta'
data_file 'HANDLING_FILE' 'data/moto_police/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/moto_police/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/moto_police/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'data/4x4EMS/vehicles.meta'



files {
	'data/4x4EMS/vehicles.meta',

	'data/pinnacle_lspd/carcols.meta',
	'data/pinnacle_lspd/handling.meta',
	'data/pinnacle_lspd/vehicles.meta',
	'data/pinnacle_lspd/carvariations.meta',

	'data/police_2/carcols.meta',
	'data/police_2/handling.meta',
	'data/police_2/vehicles.meta',
	'data/police_2/carvariations.meta',

	'data/police_felon/carcols.meta',
	'data/police_felon/handling.meta',
	'data/police_felon/vehicles.meta',
	'data/police_felon/carvariations.meta',

	'data/police_lspd/carcols.meta',
	'data/police_lspd/handling.meta',
	'data/police_lspd/vehicles.meta',
	'data/police_lspd/carvariations.meta',

	'data/police1_lspd/carcols.meta',
	'data/police1_lspd/handling.meta',
	'data/police1_lspd/vehicles.meta',
	'data/police1_lspd/carvariations.meta',

	'data/EMS1/carcols.meta',
	'data/EMS1/vehicles.meta',
	'data/EMS1/carvariations.meta',

	'data/EMS2/carcols.meta',
	'data/EMS2/vehicles.meta',
	'data/EMS2/carvariations.meta',

	'data/EMS3/carcols.meta',
	'data/EMS3/vehicles.meta',
	'data/EMS3/carvariations.meta',

	'data/bcsog/carcols.meta',
	'data/bcsog/carvariations.meta',
	'data/bcsog/handling.meta',
	'data/bcsog/vehiclelayouts.meta',
	'data/bcsog/vehicles.meta',

	'data/lspd_car/carcols.meta',
	'data/lspd_car/handling.meta',
	'data/lspd_car/vehicles.meta',
	'data/lspd_car/carvariations.meta',

	'data/banaliser/carcols.meta',
	'data/banaliser/handling.meta',
	'data/banaliser/vehicles.meta',
	'data/banaliser/carvariations.meta',

	'data/as332/vehicles.meta',
	'data/as332/carvariations.meta',
	'data/as332/vehiclelayouts.meta',

	'data/limo/carcols.meta',
	'data/limo/vehicles.meta',
	'data/limo/carvariations.meta',

	'data/suv/carcols.meta',
	'data/suv/vehicles.meta',
	'data/suv/carvariations.meta',

	'data/weazel_18charg/vehicles.meta',
    'data/weazel_18charg/carcols.meta',
    'data/weazel_18charg/carvariations.meta',
    'data/weazel_21inter/vehicles.meta',
    'data/weazel_21inter/carcols.meta',
    'data/weazel_21inter/carvariations.meta',
    'data/weazel_WR1500/vehicles.meta',
    'data/weazel_WR1500/carcols.meta',
    'data/weazel_WR1500/carvariations.meta',

    'data/moto_police/carcols.meta',
	'data/moto_police/handling.meta',
	'data/moto_police/vehicles.meta',
	'data/moto_police/carvariations.meta',
}]]--