Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    },

    ['fr'] = {
        ['DJ_interact'] = 'Appuyez sur ~g~E~s~ pour accéder au pupitre DJ ',
        ['title_does_not_exist'] = '~r~Ce titre n\'existe pas !',
    }
}

Config.Locale = 'fr'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'biker_1',
        pos = vector3(1016.09, -2537.25, 29.20),
        requiredJob = nil,
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'cayo',
        pos = vector3(4893.34, -4907.73, 3.40),
        requiredJob = nil,
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Coffee Shop',
        pos = vector3(-1334.035, -1218.28, 5.989173),
        requiredJob = "coffeeshop",
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Coffee Shop',
        pos = vector3(-1375.555, -1241.921, 4.420505),
        requiredJob = "coffeeshop",
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'steinway',
        pos = vector3(1947.52, 3846.06, 31.14),
        requiredJob = "steinway",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'studiorap',
        pos = vector3(-1004.50, -250.68, 39.45),
        requiredJob = "studiorap",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'bahama',
        pos = vector3(-1382.28, -614.251, 31.497),
        requiredJob = "bahama_mamas",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'unicorn',
        pos = vector3(117.58,-1281.66,29.25),
        requiredJob = "unicorn",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'maison10',
        pos = vector3(-369.01, 204.20, 80.94),
        requiredJob = "maison10",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'blackwood',
        pos = vector3(-303.99, 6255.89, 31.76),
        requiredJob = "black_wood",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Paradise',
        pos = vector3(-3027.94, 58.11, 16.79),
        requiredJob = "paradise",
        range = 55.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'pearl',
        pos = vector3(-1841.33, -1186.31, 19.96),
        requiredJob = "pearl",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'tequilala',
        pos = vector3(-550.83, 283.92, 82.97),
        requiredJob = "tequilala",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'studiorap',
        pos = vector3(-560.99, 281.74, 85.68),
        requiredJob = "studiorap",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'studiorap',
        pos = vector3(-1012.198,-289.674,44.791),
        requiredJob = "studiorap",
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'galaxy',
        pos = vector3(-1202.727, -1164.636, 0.154),
        requiredJob = "galaxy",
        range = 35.0,
        volume = 1.0 --[[ do not touch the volume! --]]
    },

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}