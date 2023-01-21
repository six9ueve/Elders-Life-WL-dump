fx_version "adamant"
game"gta5"

client_scripts {
	"client.lua",
}

server_scripts {
	'@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
	"server.lua",
}

ui_page "html/index.html"

files {
	"html/index.html",
	"html/script.js",
	"html/ui.js",
	"html/style.css",
	"html/winaudio.mp3",
	"html/loseaudio.mp3",
}