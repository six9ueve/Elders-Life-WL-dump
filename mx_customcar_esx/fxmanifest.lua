fx_version 'cerulean'
game 'gta5'

description 'mx_customcar'
version '1.1'

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/img/*.png',
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
    'Server/*',
    'config.lua',
}

client_scripts {
    'Client/*',
	'config.lua',
}


