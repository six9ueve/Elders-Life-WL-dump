fx_version 'adamant'
game 'gta5'
description 'VNS Casino Slots Machine'
version '2.1.4'
lua54 'yes'


server_scripts {
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
	'server.lua',
	'config.lua',
	'locales/*.lua',
	'stream/*',
}

dependency 'es_extended'