fx_version 'adamant'
game 'gta5'
description 'VNS Casino Roulette ESX'
version '1.0.6'
lua54 'yes'

shared_scripts {
	'locales/en.lua',
	'config.lua',
}

server_scripts {
	'locked/server.lua',
	'server.lua',
}

client_scripts {
	'locked/client.lua',
	'client.lua',
}

escrow_ignore {
	'server.lua',
	'client.lua',
	'config.lua',
	'locales/*.lua',
}
dependency '/assetpacks'