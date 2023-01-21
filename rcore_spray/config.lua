-- if "STANDALONE" is on true, nothing under will take effect.
Framework = {
    STANDALONE = false,

    ESX = true,
    QBCORE = false,
}

-- if "DISABLE_MYSQL" is on true, nothing under will take effect.
MySQLFramework = {
    DISABLE_MYSQL = false,

    MYSQL_ASYNC = true,
    GHMATTI_MYSQL = false,
    OXMYSQL = false,
}

-- If True, will use old non-additive rendering style
-- the sprays will look a bit "out of place" and won't blend into it's wall well
UseLegacyRendering = false

Config = {
    SPRAY_PERSIST_DAYS = 10,
    SPRAY_PROGRESSBAR_DURATION = 15000,
    SPRAY_REMOVE_DURATION = 20000,

    SPRAY_CHAR_LIMIT = 9,

    Keys = {
        CANCEL = {code = 177, label = 'INPUT_CELLPHONE_CANCEL'},
    },

    Blacklist = {
        'nigger',
        'niger',
        'nigga',
    },

    Text = {
        CANCEL = 'Cancel',
        SPRAY_ERRORS = {
            NOT_FLAT = 'Cette surface n\'est pas assez plate',
            TOO_FAR = 'La surface est trop loin',
            INVALID_SURFACE = 'Il ne peut pas être pulvérisé sur cette surface',
            AIM = 'Dirigez le spray vers un mur plat',
        },
        NO_SPRAY_NEARBY = 'Il n\'y a pas de spray à proximité à enlever',
        NEED_SPRAY = 'Vous n\'avez pas de spray pour pulvériser',
        WORD_LONG = 'Le mot de pulvérisation peut contenir au plus 15 caractères',
        USAGE = 'Utilisation: /spray <mot>',
        NUI_TEXT = {
            ['text'] = 'TEXT',
            ['image'] = 'IMAGE',
            ['word-not-allowed'] = 'Ce mot est sur liste noire.',
            ['color'] = 'couleur',
            ['spray'] = 'SPRAY',
            ['click-to-select'] = 'CLICK POUR ANNULER',
            ['cancel'] = 'ANNULER',
            ['keybind-spray'] = 'Spray',
            ['keybind-change-size'] = 'Change dimension',
            ['keybind-back'] = 'Retour',
            ['input-placeholder'] = 'Votre texte ici',
            ['default-graffiti'] = 'GRAFFITI',
            ['save-color'] = 'Save',
        }
    }
}

FONTS = {
    {
        font = 'graffiti1',
        label = 'Next Custom',
        allowed = '^[A-Z0-9\\-.]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9\\-.]+',
        sizeMult = 0.35,
    },
    {
        font = 'graffiti2',
        label = 'Dripping Marker',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 1.0,
    },
    {
        font = 'graffiti6',
        label = 'Barrio Santo',
        forceUppercase = true,
        allowed = '^[A-Z0-9]+$',
        allowedInverse = '[^A-Z0-9]+',
        sizeMult = 0.90,
    },
    {
        font = 'graffiti7',
        label = 'Bomb',
        allowed = '^[A-Z0-9!?]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?]+',
        sizeMult = 0.75,
    },
    {
        font = 'graffiti8',
        label = 'Bombing',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.15,
    },
    {
        font = 'graffiti9',
        label = 'Train Gangsta',
        allowed = '^[A-Z0-9?!]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9?!]+',
        sizeMult = 0.6,
    },
    {
        font = 'graffiti10',
        label = 'Street Wrister',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.0,
    },
    {
        font = 'graffiti11',
        label = 'Peinture Fraiche',
        allowed = '^[A-Z0-9!?+\\-*/]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9!?+\\-*/]+',
        sizeMult = 1.0,
    },
    {
        font = 'PricedownGTAVInt',
        label = 'Pricedown',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.75,
    },
}

IMAGES = {
    {
        dict = 'rcore_graffiti',
        name = 'grove',
        scale = 0.17,
        color = {33, 146, 0},
        gangTags = {'gsf'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 752,
        height = 752,
    },
    {
        dict = 'rcore_graffiti',
        name = 'aztecas',
        scale = 0.17,
        color = {214, 101, 41},
        gangTags = {'aztecas'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 640,
        height = 732,
    },
    {
        dict = 'rcore_graffiti',
        name = 'ballas',
        scale = 0.235,
        color = {142, 7, 198},
        gangTags = {'ballas'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 500,
        height = 544,
    },
    {
        dict = 'rcore_graffiti',
        name = 'vagos',
        scale = 0.47,
        color = {164, 103, 65},
        gangTags = {'vagos'}, -- Used for capturing territory when using https://store.rcore.cz/package/4913168
        width = 272,
        height = 272,
    },
}

FastImageMap = {}
for _, d in pairs(IMAGES) do FastImageMap[d.dict .. d.name] = d end

COLORS = {
    {
        basic = 'WHITE',
        hex = 'ffffff',
        rgb = {255, 255, 255},
    },
    {
        basic = 'RED',
        hex = 'c81912',
        rgb = {200, 25, 18},
    },
    {
        basic = 'RED',
        hex = 'f64b3c',
        rgb = {246, 75, 60},
    },
    {
        basic = 'PINK',
        hex = 'f76a8c',
        rgb = {247, 106, 140},
    },
    {
        basic = 'PINK',
        hex = 'fde2e2',
        rgb = {253, 226, 226},
    },
    {
        basic = 'BLUE',
        hex = '000839',
        rgb = {0, 8, 57},
    },
    {
        basic = 'BLUE',
        hex = '005082',
        rgb = {0, 80, 130},
    },
    {
        basic = 'BLUE',
        hex = '00a8cc',
        rgb = {0, 168, 204},
    },
    {
        basic = 'YELLOW',
        hex = 'ffd31d',
        rgb = {255, 211, 29},
    },
    {
        basic = 'YELLOW',
        hex = 'f5fcc1',
        rgb = {245, 252, 193},
    },
    {
        basic = 'GREEN',
        hex = '2b580c',
        rgb = {43, 88, 12},
    },
    {
        basic = 'GREEN',
        hex = '639a67',
        rgb = {99, 154, 103},
    },
    {
        basic = 'ORANGE',
        hex = 'ea6227',
        rgb = {234, 98, 39},
    },
    {
        basic = 'ORANGE',
        hex = 'ffa41b',
        rgb = {255, 164, 27},
    },
    {
        basic = 'BROWN',
        hex = '442727',
        rgb = {68, 39, 39},
    },
    {
        basic = 'BROWN',
        hex = '9c5518',
        rgb = {156, 85, 24},
    },
    {
        basic = 'PURPLE',
        hex = '844685',
        rgb = {132, 70, 133},
    },
    {
        basic = 'PURPLE',
        hex = 'be79df',
        rgb = {190, 121, 223},
    },
    {
        basic = 'GREY',
        hex = 'cccccc',
        rgb = {204, 204, 204},
    },
    {
        basic = 'GREY',
        hex = '323232',
        rgb = {50, 50, 50},
    },
    {
        basic = 'BLACK',
        hex = '000000',
        rgb = {0, 0, 0},
    },
}

SIMPLE_COLORS = {}

for idx, c in pairs(COLORS) do
    SIMPLE_COLORS[idx] = c.rgb
end
