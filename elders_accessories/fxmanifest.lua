fx_version 'adamant'

game 'gta5'

shared_scripts {
	'utils.lua',
	'config.lua',
}

client_scripts {
	'client.lua',
	'names.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

dependencies {
	'es_extended',
	'skinchanger',
	'esx_skin',
}

files {
	'names/*.json'
}