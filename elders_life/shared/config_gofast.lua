ConfigGoFast = {}

-- Start method
ConfigGoFast.UseCommand = "gofast" -- Set it to false if you dont want to use it by a command (need to restart your server to works)
ConfigGoFast.UseCommandStop = "stopgofast" -- Set it to false if you dont want to use it by a command (need to restart your server to works)
ConfigGoFast.UseItem = false -- Set a object to start the job (example : ConfigGoFast.UseItem = "ticket" ) you need to restart the server to apply an item 
-- Options
ConfigGoFast.Progressbar = true -- Set it to false if you dont want to use progressbar (its a optional dependency)
ConfigGoFast.StopWhenDie = true -- [true or false] to stop the mission when the player died 
ConfigGoFast.Language = "FR" -- FR or EN by default 

ConfigGoFast.ItemReward = "ecrou" -- If you want a item as a reward 
ConfigGoFast.QttyReward = 20  -- The number of items you want the player to earn (works with ItemReward)

ConfigGoFast.cops = 4
ConfigGoFast.pricelaunch = 1500
ConfigGoFast.CashReward = 8500 -- if you want cash as a reward for the player
ConfigGoFast.CashType = "black_money" -- set it to "black_money" for black money
ConfigGoFast.Gang = {"g_m_y_pologoon_01","g_m_m_chicold_01","g_m_y_armgoon_02","g_f_importexport_01","g_m_y_salvagoon_01","s_m_y_dealer_01"} -- hashKey of the delivery gangs peds 
ConfigGoFast.Cars = {
    { -- one block equals to one car , this one is the jugular with all the remaining time for each destination
        carhash = "jugular",
        times = {
            ["paleto1"] = 270,
            ["paleto2"] = 285,
            ["paleto3"] = 305,
            ["sandy2"] = 230,
            ["sandy3"] = 230,
            ["sandy4"] = 295,
            ["ville1"] = 295,
            ["ville2"] = 295,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "furia",
        times = {
            ["paleto1"] = 295,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 295,
            ["ville1"] = 290,
            ["ville2"] = 295,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 275,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "zentorno",
        times = {
            ["paleto1"] = 285,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 295,
            ["ville1"] = 290,
            ["ville2"] = 285,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "paragon",
        times = {
            ["paleto1"] = 295,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 290,
            ["ville1"] = 290,
            ["ville2"] = 290,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "tempesta",
        times = {
            ["paleto1"] = 285,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 285,
            ["ville1"] = 290,
            ["ville2"] = 285,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "furia",
        times = {
            ["paleto1"] = 295,
            ["paleto2"] = 300,
            ["paleto3"] = 300,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 285,
            ["ville1"] = 290,
            ["ville2"] = 285,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "nero2",
        times = {
            ["paleto1"] = 285,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 285,
            ["ville1"] = 290,
            ["ville2"] = 285,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "t20",
        times = {
            ["paleto1"] = 285,
            ["paleto2"] = 300,
            ["paleto3"] = 310,
            ["sandy2"] = 250,
            ["sandy3"] = 235,
            ["sandy4"] = 285,
            ["ville1"] = 290,
            ["ville2"] = 285,
            ["ville3"] = 275,
            ["ville4"] = 215,
            ["ville5"] = 265,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
    {
        carhash = "tyrant",
        times = {
            ["paleto1"] = 315,
            ["paleto2"] = 340,
            ["paleto3"] = 350,
            ["sandy2"] = 280,
            ["sandy3"] = 265,
            ["sandy4"] = 315,
            ["ville1"] = 320,
            ["ville2"] = 315,
            ["ville3"] = 290,
            ["ville4"] = 245,
            ["ville5"] = 295,
            ["ville6"] = 295,
            ["ville7"] = 295,
        }
    },
}
ConfigGoFast.GoFast = {
    { -- quai
        pedDepart = vector4(121.54817, -3215.05347, 4.99054, 267.11856),
        carDepart = vector4(125.60387, -3213.9004, 5.90881, 355.70413),
        destination = {
            { 
                pedDestination = vector4(111.2443, 6631.03076, 30.78724, 138.9205),
                carDestination = vector3(110.26018, 6626.52001, 30.78724),
                value = "paleto1"
            },
            {
                pedDestination = vector4(-1581.11475, 5174.50439, 18.5485, 194.69224),
                carDestination = vector3(-1581.1681, 5169.56445, 19.56498),
                value = "paleto2",
            },
            {
                pedDestination = vector4(-358.63495, 6061.63232, 30.50012, 48.74296),
                carDestination = vector3(-356.53766, 6068.46093, 31.23451),
                value = "paleto3",
            },
            {
                pedDestination = vector4(1958.2218, 5172.32421, 47.63907, 21.4625),
                carDestination = vector3(1963.25305, 5168.53369, 47.63907),
                value = "sandy2",
            },
            {
                pedDestination = vector4(2711.33056, 4127.13867, 42.87777, 354.97866),
                carDestination = vector3(2712.18041, 4133.47265, 43.94182),
                value = "sandy3",
            },
            { -- a changer sur le 2
                pedDestination = vector4(1300.78112, 4318.81298, 37.15715, 307.44116),
                carDestination = vector3(1303.3822, 4322.76855, 38.01123),
                value = "sandy4",
            },
        },
    },
    { -- grapeseed
        pedDepart = vector4(1719.14208, 4677.2246, 42.65578, 89.21725),
        carDepart = vector4(1710.5531, 4668.40673, 43.17375, 89.12916),
        destination = {
            { 
                pedDestination = vector4(120.9344, -3215.03077, 5.00414, 275.24114),
                carDestination = vector3(124.27144, -3214.83106, 5.93037),
                value = "ville1"
            },
            { 
                pedDestination = vector4(-454.63166, -2435.71607, 5.00078, 229.57968),
                carDestination = vector3(-449.1478, -2440.41602, 6.00078),
                value = "ville2"
            },
            { 
                pedDestination = vector4(-1180.75696, -1777.38892, 2.90846, 309.94598),
                carDestination = vector3(-1177.40479, -1774.58545, 3.84822),
                value = "ville3"
            },
            { 
                pedDestination = vector4(660.24609, 592.96838, 128.24084, 73.83345),
                carDestination = vector3(652.25256, 596.60754, 128.91177),
                value = "ville4"
            },
            { 
                pedDestination = vector4(997.31451, -2360.55274, 29.50955, 351.67922),
                carDestination = vector3(997.94799, -2355.63233, 30.50955),
                value = "ville5"
            },
            { 
                pedDestination = vector4(-3155.40357, 1125.578, 19.85805, 68.69758),
                carDestination = vector3(-3158.05958, 1127.63891, 20.84235),
                value = "ville6"
            },
            { 
                pedDestination = vector4(172.54927, 1243.34326, 221.96023, 286.46676),
                carDestination = vector3(175.90818, 1244.32421, 223.55436),
                value = "ville7"
            },
        },
    },
    { -- casse en ville
        pedDepart = vector4(-433.12009, -1675.60779, 19.02906, 338.62625),
        carDepart = vector4(-432.48447, -1673.37317, 19.02906, 252.4562),
        destination = {
            { 
                pedDestination = vector4(111.2443, 6631.03076, 29.78724, 138.9205),
                carDestination = vector3(110.26018, 6626.52001, 30.78724),
                value = "paleto1"
            },
            {
                pedDestination = vector4(-1581.11475, 5174.50439, 18.5485, 194.69224),
                carDestination = vector3(-1581.1681, 5169.56445, 19.56498),
                value = "paleto2",
            },
            {
                pedDestination = vector4(-358.63495, 6061.63232, 30.50012, 48.74296),
                carDestination = vector3(-356.53766, 6068.46093, 31.23451),
                value = "paleto3",
            },
            {
                pedDestination = vector4(1958.2218, 5172.32421, 47.63907, 21.4625),
                carDestination = vector3(1963.25305, 5168.53369, 47.63907),
                value = "sandy2",
            },
            {
                pedDestination = vector4(2711.33056, 4127.13867, 42.87777, 354.97866),
                carDestination = vector3(2712.18041, 4133.47265, 43.94182),
                value = "sandy3",
            },
            {
                pedDestination = vector4(1300.78112, 4318.81298, 37.15715, 307.44116),
                carDestination = vector3(1303.3822, 4322.76855, 38.01123),
                value = "sandy4",
            },
        },
    },
}
ConfigGoFast.Translation = {
    ["FR"] = {
        ["Start"] = "Début de mission ",
        ["Stop"] = "Fin de mission ",
        ["Call"] = "Appel en cours",
        ["Contact"] = "J'ai une voiture spéciale à te faire livrer. Voilà sa position.",
        ["StartKey"] = "Appuyez ~INPUT_CONTEXT~ pour prendre les clefs",
        ["Reward"] = "Amène moi le vehicule pour récupérer ta récompense",
        ["StopKey"] = "Appuyez ~INPUT_CONTEXT~ pour valider le GoFast",
        ["Validating"] = "Valide le GoFast",
        ["Angry"] = "Tu as essayer de me baiser? Ce n'est pas ma voiture !",
        ["GiveKey"] = "Rends les clefs au contact",
        ["PressKey"] = "Appuyez sur ~INPUT_CONTEXT~ pour rendre les clefs",
        ["ObjectReward"] = "Vous avez reçu "..ConfigGoFast.ItemReward,
        ["MoneyReward"] = "Vous avez reçu",
        ["Time"] = "Temps restant = ",
        ["Out"] = "Descendez de la voiture",
        ["Out2"] = "Eloignez-vous"
    },
    ["EN"] = {
        ["Start"] = "Mission started ",
        ["Stop"] = "Mission ended ",
        ["Call"] = "Call in progress ",
        ["Contact"] = "I have a special car for you to deliver. This is its location.",
        ["StartKey"] = "Press ~INPUT_CONTEXT~ to take the keys",
        ["Reward"] = "Bring me the vehicle to collect your reward",
        ["StopKey"] = "Press ~INPUT_CONTEXT~ to validate the gofast",
        ["Validating"] = "Gofast validation",
        ["Angry"] = "Do you really try to fuck me?",
        ["GiveKey"] = "Return the keys to the contact",
        ["PressKey"] = "Press ~INPUT_CONTEXT~ to return the keys",
        ["ObjectReward"] = "You have ~g~received ~s~"..ConfigGoFast.ItemReward,
        ["MoneyReward"] = "You have received",
        ["Time"] = "Time left = ",
        ["Out"] = "Get out of the car",
        ["Out2"] = "Get away"
    }
}