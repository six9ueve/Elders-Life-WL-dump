fx_version 'bodacious'
game 'gta5'

shared_scripts {
	'config.lua',
}

server_scripts {
	--'@es_extended/server/shared/common.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/client/shared/common.lua',
	--'@es_extended/client/shared/natives.lua',
	'client/classes/status.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
}

files {
    'weapons/weapons.meta',
    'weapons/loadouts.meta',
    'weapons/explosion.ymt',
    'weapons/recul/weaponautoshotgun.meta',
    'weapons/recul/weaponbullpuprifle.meta',
    'weapons/recul/weaponcombatpdw.meta',
    'weapons/recul/weaponcompactrifle.meta',
    'weapons/recul/weapondbshotgun.meta',
    'weapons/recul/weaponfirework.meta',
    'weapons/recul/weapongusenberg.meta',
    'weapons/recul/weaponheavypistol.meta',
    'weapons/recul/weaponheavyshotgun.meta',
    'weapons/recul/weaponmachinepistol.meta',
    'weapons/recul/weaponmarksmanpistol.meta',
    'weapons/recul/weaponmarksmanrifle.meta',
    'weapons/recul/weaponminismg.meta',
    'weapons/recul/weaponmusket.meta',
    'weapons/recul/weaponrevolver.meta',
    'weapons/recul/weapons_assaultrifle_mk2.meta',
    'weapons/recul/weapons_bullpuprifle_mk2.meta',
    'weapons/recul/weapons_carbinerifle_mk2.meta',
    'weapons/recul/weapons_combatmg_mk2.meta',
    'weapons/recul/weapons_heavysniper_mk2.meta',
    'weapons/recul/weapons_marksmanrifle_mk2.meta',
    'weapons/recul/weapons_pumpshotgun_mk2.meta',
    'weapons/recul/weapons_revolver_mk2.meta',
    'weapons/recul/weapons_smg_mk2.meta',
    'weapons/recul/weapons_snspistol_mk2.meta',
    'weapons/recul/weapons_specialcarbine_mk2.meta',
    'weapons/recul/weaponsnspistol.meta',
    'weapons/recul/weaponspecialcarbine.meta',
    'weapons/recul/weaponvintagepistol.meta',
    'weapons/recul/weapon_combatshotgun.meta',
    'weapons/recul/weapon_militaryrifle.meta',
    'weapons/melee/weaponknuckle.meta',
    'weapons/melee/weaponswitchblade.meta',
    'weapons/melee/weaponbottle.meta',
    'weapons/melee/weaponpoolcue.meta',
}

--- Weapons ---

data_file 'WEAPONINFO_FILE_PATCH' 'weapons/weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponautoshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponbullpuprifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponcompactrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapondbshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponfirework.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapongusenberg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponheavyshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponmachinepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponmarksmanpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponmarksmanrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponminismg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponmusket.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_assaultrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_bullpuprifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_carbinerifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_combatmg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_heavysniper_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_marksmanrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_pumpshotgun_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_revolver_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_smg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_snspistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapons_specialcarbine_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponsnspistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponspecialcarbine.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weaponvintagepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapon_combatshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/recul/weapon_militaryrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/melee/weaponknuckle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/melee/weaponswitchblade.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/melee/weaponbottle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/melee/weaponpoolcue.meta'