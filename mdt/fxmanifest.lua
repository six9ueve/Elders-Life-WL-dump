fx_version 'cerulean'
game 'gta5'
lua54 'yes'

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/main.css",
    "ui/styles/police.css",
    "ui/badges/police.png",
    "ui/footer.png",
    "ui/mugshot.png"
}

server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    "sv_mdt.lua",
    "sv_vehcolors.lua"
}

client_script "cl_mdt.lua"
