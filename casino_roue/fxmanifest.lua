fx_version 'adamant'
game 'gta5'
description 'VNS Lucky Wheel'
version '1.5.7'
lua54 'yes'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'client.lua',
}

escrow_ignore {
  '**/*',
  '*',
}

dependency 'es_extended'