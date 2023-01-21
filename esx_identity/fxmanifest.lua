fx_version 'adamant'

game 'gta5'

description 'ESX Identity'

version '1.1.0'
lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/jquery.js',
	'html/style.css',
	'html/bg.jpg',
	'html/elLogo.jpg',
	'html/node_modules/bootstrap/dist/js/bootstrap.min.js',
	'html/node_modules/popper.js/dist/popper.min.js',
	'html/node_modules/jquery/dist/jquery.min.js',
}

dependency 'es_extended'






