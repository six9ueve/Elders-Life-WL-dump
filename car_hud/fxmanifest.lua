fx_version 'adamant'

game 'gta5'
lua54 'yes'
-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/seatbelt.png",
	"ui/assets/seatbelt.svg",
	"ui/assets/cruise.svg",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js",
	"ui/sound/*.ogg"
}

-- Client Scripts
client_scripts {
	"client.lua",
	"config.lua",
}

dependencies {
	'es_extended'
}
