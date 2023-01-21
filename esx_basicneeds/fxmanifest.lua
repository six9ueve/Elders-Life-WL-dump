fx_version 'adamant'
game 'gta5'
description 'ESX Basic Needs'
lua54 'yes'
version '1.0.1'

server_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua',
	'client/stress.lua'
}
