fx_version 'cerulean'
games { 'gta5' }

author 'Frozen'
description 'POKER SYSTEM CREATED BY FROZEN'

server_scripts {
    'cred.lua',
    'core/server.lua',
    'server-editme.lua'
}

client_scripts {
    'core/client.lua',
    'client-editme.lua'
} 

server_scripts {
    'evaluator/PokerEvaluator.js', 'evaluator/HandRanks.dat'
}

shared_scripts { 'locale.lua', 'config.lua'}

server_script '@mysql-async/lib/MySQL.lua'

ui_page "html/index.html"

files {
    "html/css/*",
    "html/js/*",
    "html/index.html",
    "html/img/*"
}