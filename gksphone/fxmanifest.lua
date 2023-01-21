fx_version 'bodacious'
game 'gta5'

description 'GKSPHONE'
version '1.6.4'

lua54 'yes'

ui_page 'html/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/patoche_props_phone.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/gks_charge_normal.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/gks_charge_fast.ytyp'

files {
	'html/*.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/static/config/config.json',
	'html/static/config/lang/*.json',


	'html/static/img/**/*.jpg',
	'html/static/img/**/*.png',
	'html/static/img/**/*.svg',
	'html/static/sound/*.ogg',
	'html/static/sound/*.mp3',
	'html/static/fonts/*.ttf',
	'html/static/fonts/*.otf',
}



client_script {
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",
	"client/prop.lua",
	"client/clientAPI.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/bank.lua",
	"client/twitter.lua",
	"client/yellow.lua",
	"client/instagram.lua",
	"client/valet.lua",
	"client/client2.lua",
	"client/race.lua",
	"client/vehicle_names.lua",
	"client/music.lua",
	-- Charge
	"charge/config.lua",
	"charge/client.lua",
	"charge/prop.lua",
}

server_script {
	--'@oxmysql/lib/MySQL.lua',
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",
	"configAPI.lua",
	"server/server.lua",
	"server/serverAPI/*.lua",
	"server/twitter.lua",
    "server/yellow.lua",
	"server/instagram.lua",
	"server/server2.lua",
	"server/versioncheck.lua",
	-- Charge
	"charge/config.lua",
	"charge/server.lua",
}

-- Client Exports --
exports {
    'CheckFlightMode',
	'PhoneNumber',
	'CheckOpenPhone',
	'ClosePhone',
	'BlockOpenPhone',
	'StartingCall',
	'IsCall',
	'JobDispatch',
}

server_exports {
	'cryptoadd',
	'cryptoremove',
	'GetSourceByPhone'
}


escrow_ignore {
	'locales/*.lua',
	'config.lua',
	'configAPI.lua',
	"server/serverAPI/*.lua",
	'client/prop.lua',
	'client/valet.lua',
	'client/photo.lua',
	'client/clientAPI.lua',
	'client/vehicle_names.lua',
	'client/music.lua',
	"charge/prop.lua",
	"charge/config.lua",
}


dependency '/assetpacks'