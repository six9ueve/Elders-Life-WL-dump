fx_version 'bodacious'
game 'gta5'
lua54 'yes'

shared_scripts {
    "shared/*.lua"
}

server_scripts {
    '@es_extended/locale.lua',
    '@es_extended/server/shared/common.lua',
    '@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    'server/**/*.lua',
}

client_scripts {
    '@es_extended/client/shared/common.lua',
    '@es_extended/client/shared/natives.lua',
    "lib/RageUI/RMenu.lua",
    "lib/RageUI/menu/RageUI.lua",
    "lib/RageUI/menu/Menu.lua",
    "lib/RageUI/menu/MenuController.lua",
    "lib/RageUI/components/*.lua",
    "lib/RageUI/menu/elements/*.lua",
    "lib/RageUI/menu/items/*.lua",
    "lib/RageUI/menu/panels/*.lua",
    "lib/RageUI/menu/windows/*.lua",

    "client/*.lua",
}

ui_page('index.html')
dependency 'es_extended'