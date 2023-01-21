fx_version 'adamant'
game 'gta5'

client_scripts {
	"config.lua",
	"client/functions.lua",
	"client/main.lua",
	"client/instance.lua"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/main.lua"
}