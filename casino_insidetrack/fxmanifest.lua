fx_version 'adamant'
game 'gta5'
description 'VNS Inside Track - ESX'
version '1.0.3'
lua54 'yes'

client_scripts {
	'config.lua',
    'locked.lua',
    'client.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

escrow_ignore {
  'config.lua',
  'client.lua',
  'server.lua',
}