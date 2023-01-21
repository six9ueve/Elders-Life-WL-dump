Configadmin = {
    weaponitem = true,

    maxplayers = "264",
    tppoint = {
        {name = "Toit rouge", pos = vector3(-40.42106628418,-297.99307250977,63.072483062744)},
        {name = "Maze Bank", pos = vector3(-72.178611755371,-814.68304443359,326.16928100586)},
    },
    armes = { -- rajouter weapon_ devant les armes si vous les avez pas en items
        {name = "pistol", label = "Pistolet"},
        {name = "firework", label = "Lance Artifice"},
        {name = "firework_ammo", label = "Munition Artifice"}
    },
    text = {
        haut = "Haut",
        bas = "Bas",
        orientation = "Gauche/Droite",
        verticale = "Avancer/Reculer",
        vitesse = "Choisir la vitesse",
    },
    controls = {
        goUp = 22,
        goDown = 36,
        turnLeft = 34,
        turnRight = 35,
        goForward = 32,
        goBackward = 33,
        changeSpeed = 254,
    },
    speeds = {
        { label = "Trés lent", speed = 0},
        { label = "Lent", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Rapide", speed = 4},
        { label = "Trés rapide", speed = 6},
        { label = "Extrement rapide", speed = 10},
        { label = "Extrement rapide v2.0", speed = 20},
        { label = "Vitesse max", speed = 25}
    },
    offsets = {
        y = 0.5,
        z = 0.2,
        h = 3,
    },
    StaffTenue ={
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 388,   ['torso_2'] = 1,
            ['pants_1'] = 144,   ['pants_2'] = 1,
            ['shoes_1'] = 116,   ['shoes_2'] = 1,
            ['mask_1'] = 151,   ['mask_2'] = 1,
            ['arms'] = 13,
        },
        female = {
            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
            ['torso_1'] = 412,   ['torso_2'] = 1,
            ['arms'] = 10,
            ['pants_1'] = 166,   ['pants_2'] = 1,
            ['shoes_1'] = 109,   ['shoes_2'] = 8,
            ['mask_1'] = 147,   ['mask_2'] = 1,
        }
    },
    permissions = { -- -1 pour tout les grades
        ["gestion_joueurs"] = {"mod", "admin", "superadmin"},
        ["gestion_joueurs_job"] = {"mod", "admin", "superadmin"},
        ["player_blips"] = {"superadmin"},
        ["gestion_reports"] = -1,
        ["option_perso"] = {"mod", "admin", "superadmin"},
        ["option_veh"] = {"mod", "admin", "superadmin"},
        ["option_ped"] = {"mod", "admin", "superadmin"},
        ["action_tp"] = {"mod", "admin", "superadmin"},
        ["spec_mod"] = {"mod", "admin", "superadmin"},
        ["action_heal"] = {"mod", "admin", "superadmin"},
        ["action_revive"] = {"mod", "admin", "superadmin"},
        ["give_money"] = {"mod", "admin", "superadmin"},
        ["player_info"] = {"mod", "admin", "superadmin"},
        ["car_action"] = {"mod", "admin", "superadmin"},
        ["give_item"] = {"mod", "admin", "superadmin"},
        ["give_weapon"] = {"mod", "admin", "superadmin"},
        ["kick_action"] = {"mod", "admin", "superadmin"},
        ["wipe_action"] = {"mod", "admin", "superadmin"},
        ["action_delreport"] = {"mod", "admin", "superadmin"},
        ["action_fuel"] = {"mod", "admin", "superadmin"},
        ["action_flipveh"] = {"mod", "admin", "superadmin"},
        ["action_delveh"] = {"mod", "admin", "superadmin"},
        ["action_repairveh"] = {"mod", "admin", "superadmin"},
        ["action_openveh"] = {"mod", "admin", "superadmin"},
    }
}

ConfigBan = {
    -- Permission ban
    PermForBan = {"mod", "admin", "superadmin", "dev"},

    -- Weebhook
    SendLogToDiscord = "https://discord.com/api/webhooks/992098367641489479/TzYokzdCxc_roX2fUWiu5YO5HtxmG0gFtxhBQSRRLBHjAEwnPJ9GMM9mgd-VYNYa13bK"
}