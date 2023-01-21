fx_version 'adamant'
game 'gta5'
lua54 'yes'
shared_scripts {
    'shared/*.lua'
}


server_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    '@es_extended/server/shared/common.lua',
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'job/**/sv_*.lua',
    'illegal/**/sv_*.lua',
    'script/**/sv_*.lua',
    'sv_function.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    '@es_extended/client/shared/common.lua',
    '@es_extended/client/shared/natives.lua',
    'locales/*.lua',
    'lib/RageUI/RMenu.lua',
    'lib/RageUI/menu/RageUI.lua',
    'lib/RageUI/menu/Menu.lua',
    'lib/RageUI/menu/MenuController.lua',
    'lib/RageUI/components/*.lua',
    'lib/RageUI/menu/elements/*.lua',
    'lib/RageUI/menu/items/*.lua',
    'lib/RageUI/menu/panels/*.lua',
    'lib/RageUI/menu/windows/*.lua',
    'job/**/cl_*.lua',
    'illegal/**/cl_*.lua',
    'script/**/cl_*.lua',
    'cl_function.lua',
}

dependency 'es_extended'

server_export "IsRolePresent"
server_export "GetRoles"

exports {
    'GetFuel',
    'SetFuel',
    'GeneratePlate'
}