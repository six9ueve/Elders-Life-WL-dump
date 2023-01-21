files {
    'index.html',
    'style.css',
    'images/*',
    'script.js',
    'vue.min.js',
    'music/loading.mp3',
}

loadscreen 'index.html'

loadscreen_manual_shutdown "yes"

client_script "client.lua"

fx_version 'cerulean'
games {'gta5'}