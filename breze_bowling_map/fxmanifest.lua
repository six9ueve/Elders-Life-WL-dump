fx_version 'cerulean'
games { 'gta5' }
author 'Breeze'
this_is_a_map 'yes'
files {
    'interiorproxies.meta'
}
  
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

provide 'breze_bowling'

lua54 'yes'

escrow_ignore {
    'stream/*',
}

dependency '/assetpacks'