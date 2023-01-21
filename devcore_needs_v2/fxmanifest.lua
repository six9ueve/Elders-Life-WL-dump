fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'devcore - by bary - discord - https://discord.gg/zcG9KQj3sa'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'configs/*.lua',
	'server/*.lua'
}

escrow_ignore {
	'client/c_main.lua',
	'server/s_main.lua',
	'configs/*.lua',
	'fxmanifest.lua',
	'README.txt',
	'*.sql',
	'icons/*.png'
  }

client_scripts {
	'configs/*.lua',
	'client/*.lua',
}
dependency '/assetpacks'