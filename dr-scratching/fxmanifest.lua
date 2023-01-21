fx_version 'cerulean'
game 'gta5'

lua54 'yes'

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',

    'shared/utils.lua',
    'server/s_main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',

    'client/c_main.lua',
    'client/c_nui.lua',
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/img/*.png',
    'html/img/*.jpg'
}
