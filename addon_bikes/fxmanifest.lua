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
    '**/vehicles.meta'
})

data_file('CONTENT_UNLOCKING_META_FILE')('**/contentunlocks.meta')
data_file('HANDLING_FILE')('**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('**/vehicles.meta')
data_file('CARCOLS_FILE')('**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('**/vehiclelayouts.meta')

--[[fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

files {

    'mxv/carvariations.meta',
    'mxv/carcols.meta',
    'mxv/vehicles.meta',

    'zxr/carvariations.meta',
    'zxr/vehicles.meta',

    'sxf/carvariations.meta',
    'sxf/carcols.meta',
    'sxf/vehicles.meta',

    'grom/carvariations.meta',
    'grom/carcols.meta',
    'grom/vehicles.meta',

    'brz/carvariations.meta',
    'brz/vehicles.meta',

    'ltr450/carvariations.meta',
    'ltr450/vehicles.meta',

    'mxvsm/carvariations.meta',
    'mxvsm/carcols.meta',
    'mxvsm/vehicles.meta',

    'superduke/carvariations.meta',
    'superduke/carcols.meta',
    'superduke/vehicles.meta',

    'sxfsm/carvariations.meta',
    'sxfsm/carcols.meta',
    'sxfsm/vehicles.meta',

    'tmsm/carvariations.meta',
    'tmsm/vehicles.meta',

    'goldw_data/vehicles.meta',
    'goldw_data/carcols.meta',
    'goldw_data/carvariations.meta',

    'gsxr_data/vehicles.meta',
    'gsxr_data/carcols.meta',
    'gsxr_data/carvariations.meta',

    'h2_data/vehicles.meta',
    'h2_data/carcols.meta',
    'h2_data/carvariations.meta',

    'r1_data/vehicles.meta',
    'r1_data/carcols.meta',
    'r1_data/carvariations.meta',

    'rmz_data/vehicles.meta',
    'rmz_data/carvariations.meta',

    't_max/vehicles.meta',

    'r6_data/vehicles.meta',
    'r6_data/carcols.meta',
    'r6_data/carvariations.meta',

    'spirit/vehicles.meta',
    'spirit/carcols.meta',
    'spirit/carvariations.meta',

    'softail/vehicles.meta',
    'softail/carcols.meta',
    'softail/carvariations.meta',

    'diavel/vehicles.meta',

    'harley1/vehicles.meta',
    'harley1/carvariations.meta',

    'harley2/vehicles.meta',
    'harley2/carvariations.meta',

    'harley3/vehicles.meta',
    'harley3/carvariations.meta',

    'mobilete/vehicles.meta',
    'mobilete/carcols.meta',
    'mobilete/carvariations.meta',

    'augustaF4/vehicles.meta',
    'augustaF4/carcols.meta',
    'augustaF4/carvariations.meta',

    'Y1700MAX/vehicles.meta',
    'Y1700MAX/carvariations.meta',

    'z1000/vehicles.meta',
    'z1000/carcols.meta',
    'z1000/carvariations.meta',

    'KTM_exc530/vehicles.meta',
    'KTM_exc530/carvariations.meta',

    's1000drag/vehicles.meta',
    's1000drag/carcols.meta',
    's1000drag/carvariations.meta',

    'tenere/vehicles.meta',
    'tenere/carcols.meta',
    'tenere/carvariations.meta',

    'BMW_S1000RR/vehicles.meta',
    'BMW_S1000RR/carcols.meta',
    'BMW_S1000RR/carvariations.meta',

    'Quad_450/vehicles.meta',
    'Quad_450/carcols.meta',
    'Quad_450/carvariations.meta',

    'R1_1998/vehicles.meta',
    'R1_1998/carcols.meta',
    'R1_1998/carvariations.meta',

    'Dyna/vehicles.meta',
    'Dyna/carcols.meta',
    'Dyna/carvariations.meta',

    'crucero/vehicles.meta',
    'crucero/carcols.meta',
    'crucero/carvariations.meta',

    'harleyvr/vehicles.meta',
    'harleyvr/carcols.meta',
    'harleyvr/carvariations.meta',

    'Harley_VROD/vehicles.meta',
    'Harley_VROD/carcols.meta',
    'Harley_VROD/carvariations.meta',

    'Harley_RoadKing/vehicles.meta',
    'Harley_RoadKing/carcols.meta',
    'Harley_RoadKing/carvariations.meta',

    'moto_shingon/vehicles.meta',
    'moto_shingon/carcols.meta',
    'moto_shingon/carvariations.meta',

data_file 'VEHICLE_VARIATION_FILE' 'tmsm/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'tmsm/vehicles.meta'

data_file 'CARCOLS_FILE' 'mxv/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mxv/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'mxv/vehicles.meta'

data_file 'VEHICLE_VARIATION_FILE' 'zxr/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'zxr/vehicles.meta'

data_file 'CARCOLS_FILE' 'sxf/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'sxf/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'sxf/vehicles.meta'

data_file 'CARCOLS_FILE' 'grom/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'grom/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'grom/vehicles.meta'

data_file 'CARCOLS_FILE' 'superduke/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'superduke/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'superduke/vehicles.meta'

data_file 'CARCOLS_FILE' 'fc/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'fc/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'fc/vehicles.meta'

data_file 'VEHICLE_VARIATION_FILE' 'brz/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'brz/vehicles.meta'

data_file 'VEHICLE_VARIATION_FILE' 'ltr450/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'ltr450/vehicles.meta'

data_file 'CARCOLS_FILE' 'mxvsm/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mxvsm/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'mxvsm/vehicles.meta'

data_file 'CARCOLS_FILE' 'sxfsm/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'sxfsm/carvariations.meta'
data_file 'VEHICLE_METADATA_FILE' 'sxfsm/vehicles.meta'

data_file 'VEHICLE_METADATA_FILE' 'goldw_data/vehicles.meta'
data_file 'CARCOLS_FILE' 'goldw_data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'goldw_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'gsxr_data/vehicles.meta'
data_file 'CARCOLS_FILE' 'gsxr_data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'gsxr_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'h2_data/vehicles.meta'
data_file 'CARCOLS_FILE' 'h2_data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'h2_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'r1_data/vehicles.meta'
data_file 'CARCOLS_FILE' 'r1_data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'r1_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'rmz_data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'rmz_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 't_max/vehicles.meta'

data_file 'VEHICLE_METADATA_FILE' 'r6_data/vehicles.meta'
data_file 'CARCOLS_FILE' 'r6_data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'r6_data/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'softail/vehicles.meta'
data_file 'CARCOLS_FILE' 'softail/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'softail/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'spirit/vehicles.meta'
data_file 'CARCOLS_FILE' 'spirit/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'spirit/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'diavel/vehicles.meta'

data_file 'VEHICLE_METADATA_FILE' 'harley1/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'harley1/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'harley2/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'harley2/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'harley3/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'harley3/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'mobilete/vehicles.meta'
data_file 'CARCOLS_FILE' 'mobilete/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'mobilete/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'augustaF4/vehicles.meta'
data_file 'CARCOLS_FILE' 'augustaF4/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'augustaF4/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'Y1700MAX/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Y1700MAX/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'z1000/vehicles.meta'
data_file 'CARCOLS_FILE' 'z1000/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'z1000/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'KTM_exc530/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'KTM_exc530/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 's1000drag/vehicles.meta'
data_file 'CARCOLS_FILE' 's1000drag/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 's1000drag/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'tenere/vehicles.meta'
data_file 'CARCOLS_FILE' 'tenere/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'tenere/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'BMW_S1000RR/vehicles.meta'
data_file 'CARCOLS_FILE' 'BMW_S1000RR/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'BMW_S1000RR/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'Quad_450/vehicles.meta'
data_file 'CARCOLS_FILE' 'Quad_450/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Quad_450/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'R1_1998/vehicles.meta'
data_file 'CARCOLS_FILE' 'R1_1998/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'R1_1998/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'Dyna/vehicles.meta'
data_file 'CARCOLS_FILE' 'Dyna/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Dyna/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'crucero/vehicles.meta'
data_file 'CARCOLS_FILE' 'crucero/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'crucero/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'harleyvr/vehicles.meta'
data_file 'CARCOLS_FILE' 'harleyvr/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'harleyvr/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'Harley_VROD/vehicles.meta'
data_file 'CARCOLS_FILE' 'Harley_VROD/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Harley_VROD/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'Harley_RoadKing/vehicles.meta'
data_file 'CARCOLS_FILE' 'Harley_RoadKing/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'Harley_RoadKing/carvariations.meta'

data_file 'VEHICLE_METADATA_FILE' 'moto_shingon/vehicles.meta'
data_file 'CARCOLS_FILE' 'moto_shingon/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'moto_shingon/carvariations.meta']]--