fx_version 'bodacious'
games { 'gta5' }

client_scripts {
	'@es_extended/client/shared/common.lua',
    '@es_extended/client/shared/natives.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'client/main.lua',
	'config.lua',
}

server_scripts {
	'@es_extended/server/shared/common.lua',
    '@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'server/server.lua',
	'config.lua'
}

ui_page('ui/ui.html')

files {
    'ui/ui.html',
    'ui/panel.css',
	'ui/panel.js',
	'ui/sound3.mp3',
	'ui/panel2.jpg'
}

dependencies {
    'es_extended'
}