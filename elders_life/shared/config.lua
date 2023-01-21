Config = {}
Config.Locale = 'fr'
Config.WasherPrice = 50



-- Holster
ConfigHolster = {
    cooldown = 500,
    Weapons = {
        "WEAPON_COMBATPISTOL",
        "WEAPON_STUNGUN",
        "WEAPON_PISTOL",
    }
}

cfg = {
    deformationMultiplier = -1,                 -- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch. Visual damage does not sync well to other players.
    deformationExponent = 1.0,                  -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
    collisionDamageExponent = 1.0,              -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

    damageFactorEngine = 2.5,                   -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
    damageFactorBody = 2.5,                 -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
    damageFactorPetrolTank = 30.0,              -- Sane values are 1 to 200. Higher values means more damage to vehicle. A good starting point is 64
    engineDamageExponent = 0.4,                 -- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
    weaponsDamageMultiplier = 0.124,                -- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
    degradingHealthSpeedFactor = 7.4,           -- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
    cascadingFailureSpeedFactor = 1.5,          -- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

    degradingFailureThreshold = 677.0,          -- Below this value, slow health degradation will set in
    cascadingFailureThreshold = 360.0,          -- Below this value, health cascading failure will set in
    engineSafeGuard = 100.0,                    -- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

    torqueMultiplierEnabled = true,             -- Decrease engine torque as engine gets more and more damaged

    limpMode = false,                           -- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
    limpModeMultiplier = 0.15,                  -- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

    preventVehicleFlip = true,                  -- If true, you can't turn over an upside down vehicle

    sundayDriver = true,                        -- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
    sundayDriverAcceleratorCurve = 7.5,         -- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
    sundayDriverBrakeCurve = 5.0,               -- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

    displayBlips = false,                       -- Show blips for mechanics locations

    compatibilityMode = false,                  -- prevents other scripts from modifying the fuel tank health to avoid random engine failure with BVA 2.01 (Downside is it disabled explosion prevention)

    randomTireBurstInterval = 0,                -- Number of minutes (statistically, not precisely) to drive above 22 mph before you get a tire puncture. 0=feature is disabled


    -- Class Damagefactor Multiplier
    -- The damageFactor for engine, body and Petroltank will be multiplied by this value, depending on vehicle class
    -- Use it to increase or decrease damage for each class

    classDamageMultiplier = {
        [0] =   0.45,       --  0: Compacts
                0.45,       --  1: Sedans
                0.45,       --  2: SUVs
                0.45,       --  3: Coupes
                0.45,       --  4: Muscle
                0.45,       --  5: Sports Classics
                0.45,       --  6: Sports
                0.45,       --  7: Super
                0.0001,     --  8: Motorcycles
                0.35,       --  9: Off-road
                0.45,       --  10: Industrial
                0.45,       --  11: Utility
                0.45,       --  12: Vans
                0.45,       --  13: Cycles
                0.45,       --  14: Boats
                0.45,       --  15: Helicopters
                0.45,       --  16: Planes
                0.45,       --  17: Service
                0.45,       --  18: Emergency
                0.45,       --  19: Military
                0.45,       --  20: Commercial
                0.45            --  21: Trains
    }
}



--[[

    -- Alternate configuration values provided by ImDylan93 - Vehicles can take more damage before failure, and the balance between vehicles has been tweaked.
    -- To use: comment out the settings above, and uncomment this section.

cfg = {

    deformationMultiplier = -1,                 -- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
    deformationExponent = 1.0,                  -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
    collisionDamageExponent = 1.0,              -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

    damageFactorEngine = 5.1,                   -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
    damageFactorBody = 5.1,                     -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
    damageFactorPetrolTank = 61.0,              -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 64
    engineDamageExponent = 1.0,                 -- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
    weaponsDamageMultiplier = 0.124,            -- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
    degradingHealthSpeedFactor = 7.4,           -- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
    cascadingFailureSpeedFactor = 1.5,          -- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

    degradingFailureThreshold = 677.0,          -- Below this value, slow health degradation will set in
    cascadingFailureThreshold = 310.0,          -- Below this value, health cascading failure will set in
    engineSafeGuard = 100.0,                    -- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

    torqueMultiplierEnabled = true,             -- Decrease engine torge as engine gets more and more damaged

    limpMode = false,                           -- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
    limpModeMultiplier = 0.15,                  -- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

    preventVehicleFlip = true,                  -- If true, you can't turn over an upside down vehicle

    sundayDriver = true,                        -- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
    sundayDriverAcceleratorCurve = 7.5,         -- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
    sundayDriverBrakeCurve = 5.0,               -- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

    displayBlips = true,                        -- Show blips for mechanics locations

    classDamageMultiplier = {
        [0] =   1.0,        --  0: Compacts
                1.0,        --  1: Sedans
                1.0,        --  2: SUVs
                0.95,       --  3: Coupes
                1.0,        --  4: Muscle
                0.95,       --  5: Sports Classics
                0.95,       --  6: Sports
                0.95,       --  7: Super
                0.27,       --  8: Motorcycles
                0.7,        --  9: Off-road
                0.25,       --  10: Industrial
                0.35,       --  11: Utility
                0.85,       --  12: Vans
                1.0,        --  13: Cycles
                0.4,        --  14: Boats
                0.7,        --  15: Helicopters
                0.7,        --  16: Planes
                0.75,       --  17: Service
                0.85,       --  18: Emergency
                0.67,       --  19: Military
                0.43,       --  20: Commercial
                1.0         --  21: Trains
    }
}

]]--





-- End of Main Configuration

-- Configure Repair system

-- id=446 for wrench icon, id=72 for spraycan icon

repairCfg = {
    mechanics = {
        {name="Mechanic", id=446, r=25.0, x=-337.0,  y=-135.0,  z=39.0},    -- LSC Burton
        {name="Mechanic", id=446, r=25.0, x=-1155.0, y=-2007.0, z=13.0},    -- LSC by airport
        {name="Mechanic", id=446, r=25.0, x=734.0,   y=-1085.0, z=22.0},    -- LSC La Mesa
        {name="Mechanic", id=446, r=25.0, x=1177.0,  y=2640.0,  z=37.0},    -- LSC Harmony
        {name="Mechanic", id=446, r=25.0, x=108.0,   y=6624.0,  z=31.0},    -- LSC Paleto Bay
        {name="Mechanic", id=446, r=18.0, x=538.0,   y=-183.0,  z=54.0},    --  Hawic
        {name="Mechanic", id=446, r=15.0, x=1774.0,  y=3333.0,  z=41.0},    -- Mechanic Sandy Shores Airfield
        {name="Mechanic", id=446, r=15.0, x=1143.0,  y=-776.0,  z=57.0},    -- Mechanic Mirror Park
        {name="Mechanic", id=446, r=30.0, x=2508.0,  y=4103.0,  z=38.0},    -- Mechanic East Joshua Rd.
        {name="Mechanic", id=446, r=16.0, x=2006.0,  y=3792.0,  z=32.0},    -- Mechanic Sandy Shores gas station
        {name="Mechanic", id=446, r=25.0, x=484.0,   y=-1316.0, z=29.0},    -- Hayes Auto, Little Bighorn Ave.
        {name="Mechanic", id=446, r=33.0, x=-1419.0, y=-450.0,  z=36.0},    -- Hayes Auto Body Shop, Del Perro
        {name="Mechanic", id=446, r=33.0, x=268.0,   y=-1810.0, z=27.0},    -- Hayes Auto Body Shop, Davis
    --  {name="Mechanic", id=446, r=24.0, x=288.0,   y=-1730.0, z=29.0},    -- Hayes Auto, Rancho (Disabled, looks like a warehouse for the Davis branch)
        {name="Mechanic", id=446, r=27.0, x=1915.0,  y=3729.0,  z=32.0},    -- Otto's Auto Parts, Sandy Shores
        {name="Mechanic", id=446, r=45.0, x=-29.0,   y=-1665.0, z=29.0},    -- Mosley Auto Service, Strawberry
        {name="Mechanic", id=446, r=44.0, x=-212.0,  y=-1378.0, z=31.0},    -- Glass Heroes, Strawberry
        {name="Mechanic", id=446, r=33.0, x=258.0,   y=2594.0,  z=44.0},    -- Mechanic Harmony
        {name="Mechanic", id=446, r=18.0, x=-32.0,   y=-1090.0, z=26.0},    -- Simeons
        {name="Mechanic", id=446, r=25.0, x=-211.0,  y=-1325.0, z=31.0},    -- Bennys
        {name="Mechanic", id=446, r=25.0, x=903.0,   y=3563.0,  z=34.0},    -- Auto Repair, Grand Senora Desert
        {name="Mechanic", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}     -- Auto Shop, Grand Senora Desert
    },

    fixMessages = {
        "You put the oil plug back in",
        "You stopped the oil leak using chewing gum",
        "You repaired the oil tube with gaffer tape",
        "You tightened the oil pan screw and stopped the dripping",
        "You kicked the engine and it magically came back to life",
        "You removed some rust from the spark tube",
        "You yelled at your vehicle, and it somehow had an effect"
    },
    fixMessageCount = 7,

    noFixMessages = {
        "You checked the oil plug. It's still there",
        "You looked at your engine, it seemed fine",
        "You made sure that the gaffer tape was still holding the engine together",
        "You turned up the radio volume. It just drowned out the weird engine noises",
        "You added rust-preventer to the spark tube. It made no difference",
        "Never fix something that ain't broken they said. You didn't listen. At least it didn't get worse"
    },
    noFixMessageCount = 6
}

RepairEveryoneWhitelisted = true
RepairWhitelist =
{
    "steam:123456789012345",
    "steam:000000000000000",
    "ip:192.168.0.1"            -- not sure if ip whitelist works?
}

Config.Locale = 'fr'
Config.AdminByID        = false -- Set to true if you want to set the access to the commands only to certain people (otherwise the permissions will be to ace access)
Config.DynamicWeather   = false -- Set this to false if you don't want the weather to change automatically every 10 minutes.

-- On server start
Config.StartWeather     = 'EXTRASUNNY' -- Default weather                       default: 'EXTRASUNNY'
Config.BaseTime         = 8 -- Time                                             default: 8
Config.TimeOffset       = 0 -- Time offset                                      default: 0
Config.FreezeTime       = false -- freeze time                                  default: false
Config.Blackout         = false -- Set blackout                                 default: false
Config.NewWeatherTimer  = 40 -- Time (in minutes) between each weather change   default: 10

Config.Locale           = 'fr' -- Languages : en, fr, pt, tr, pt_br

Config.Admins = { -- Only if Config.AdminByID is set to true
    'steam/license:STEAMID/LICENSE', -- EXAMPLE : steam:110000145959807 or license:1234975140128921327
}

Config.Ace = { -- Only if Config.AdminByID is set to false
    'command', -- LEAVE BY DEFAULT TO GIVE ACCESS TO ADMINS AND SUPERADMINS IF U DIDN'T TOUCH ADMIN SYSTEM.
    --'vsyncr', -- Gives access to weather/time commands only to groups that have access to 'vsyncr' in your server.cfg (like this: add_ace group.admin vsyncr allow)
    --'yourgroupaccess', -- add_ace group.yourgroup yourgroupaccess allow
}

Config.AvailableWeatherTypes = { -- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}



------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
                                                        --Connect queue
----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
Config.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
Config.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
Config.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
Config.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
Config.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
Config.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
Config.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
Config.Points = {
    {'steam:110000103623205', 10000},
    {'steam:11000010a38d480', 10000},
    {'steam:110000114f38c5d', 10000},
    {'steam:11000011d074e5f', 10000},
    {'steam:11000013d92e241', 10000}
}

----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

-- Si steam n'est pas détecté / If steam is not detected
Config.NoSteam = "Steam n'a pas été détecté. Veuillez (re)lancer Steam et FiveM, puis réessayer."
Config.NoDiscord = "Discord n'a pas été détecté. Veuillez (re)lancer Discord et FiveM, puis réessayer."
-- Config.NoSteam = "Steam was not detected. Please (re)launch Steam and FiveM, and try again."

-- Message d'attente / Waiting text
Config.EnRoute = "Vous êtes en route. Vous avez déjà parcouru"
-- Config.EnRoute = "You are on the road. You have already traveled"

-- "points" traduits en langage RP / "points" for RP purpose
Config.PointsRP = "kilomètres"
-- Config.PointsRP = "kilometers"

-- Position dans la file / position in the queue
Config.Position = "Vous êtes en position "
-- Config.Position = "You are in position "

-- Texte avant les emojis / Text before emojis
Config.EmojiMsg = "Si les emojis sont figés, relancez votre client : "
-- Config.EmojiMsg = "If the emojis are frozen, restart your client: "

-- Quand le type gagne à la loterie / When the player win the lottery
Config.EmojiBoost = "!!! Youpi, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " gagnés !!!"
-- Config.EmojiBoost = "!!! Yippee, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " won !!!"

-- Anti-spam message / anti-spam text
Config.PleaseWait_1 = "Veuillez patienter "
Config.PleaseWait_2 = " secondes. La connexion se lancera automatiquement !"
-- Config.PleaseWait_1 = "Please wait "
-- Config.PleaseWait_2 = " seconds. The connection will start automatically!"

-- Me devrait jamais s'afficher / Should never be displayed
Config.Accident = "Oups, vous venez d'avoir un accident... Si cela se reproduit, vous pouvez en informer le support :)"
-- Config.Accident = "Oops, you just had an accident ... If it happens again, you can inform the support :)"

-- En cas de points négatifs / In case of negative points
Config.Error = " ERREUR : RELANCEZ LA ROCADE ET CONTACTEZ LE SUPPORT DU SERVEUR "
-- Config.Error = " ERROR : RESTART THE QUEUE SYSTEM AND CONTACT THE SUPPORT "


Config.EmojiList = {
    '🐌', 
    '🐍',
    '🐎', 
    '🐑', 
    '🐒',
    '🐘', 
    '🐙', 
    '🐛',
    '🐜',
    '🐝',
    '🐞',
    '🐟',
    '🐠',
    '🐡',
    '🐢',
    '🐤',
    '🐦',
    '🐧',
    '🐩',
    '🐫',
    '🐬',
    '🐲',
    '🐳',
    '🐴',
    '🐅',
    '🐈',
    '🐉',
    '🐋',
    '🐀',
    '🐇',
    '🐏',
    '🐐',
    '🐓',
    '🐕',
    '🐖',
    '🐪',
    '🐆',
    '🐄',
    '🐃',
    '🐂',
    '🐁',
    '🔥'
}

ConfigPlateLetters  = 3
ConfigPlateNumbers1  = 2
ConfigPlateNumbers  = 3
ConfigPlateUseSpace = true

ConfigBlips = {
    blips = {
        {id = 60, name = "[ETAT] | LSPD", color = 0,  pos = vector3(-562.30,-116.12,42.25)},
        {id = 60, name = "[ETAT] | BCSO", color = 0,  pos = vector3(1853.22, 3688.53, 29.81)}, 
        {id = 675, name = "[ETAT] | VIP", color = 46,  pos = vector3(-223.257,6243.088,31.492)},         
        {id = 419, name = "[ETAT] | Gouvernement", color = 0,  pos = vector3(-580.0892, -206.5182, 38.16893)}, 
        {id = 61, name = "[ETAT] | Hopital", color = 0,  pos = vector3(314.04, -603.06, 43.29)}, 
        {id = 475, name = "[ENTREPRISE] | CoffeeShop", color = 25,  pos = vector3(-1333.744, -1231.743, 5.94)}, 
        {id = 475, name = "[ENTREPRISE] | RockFord Records", color = 57,  pos = vector3(-1020.33, -262.09, 39.03)}, 
        {id = 93,  name = "[BAR] | Paradise", color = 27,  pos = vector3(-3037.06, 37.15, 10.11)},
        {id = 93,  name = "[BAR] | Black Wood", color = 27,  pos = vector3(-304.98, 6266.31, 31.52)}, 
        {id = 93,  name = "[BAR] | Yellow Jack", color = 27,  pos = vector3(2000.02, 3045.76, 47.21)}, 
        {id = 93, name = "[BAR] | Unicorn", color = 27,  pos = vector3(125.551,-1296.827,28.269)}, 
        {id = 93,  name = "[BAR] | Tequi-la-la", color = 27,  pos = vector3(-556.686,  284.964,- 82.176)}, 
        {id = 93,  name = "[BAR] | Music Locker", color = 27,  pos = vector3(-1184.027, -1159.105,-82.176)}, 
        {id = 475, name = "[ENTREPRISE] | O'Tacos", color = 75,  pos = vector3(417.675,-1912.077,-100)}, 
        {id = 93,  name = "[ENTREPRISE] | SteinWay", color = 27,  pos = vector3(1945.306,3841.887,-132.12)}, 
        {id = 475,  name = "[ENTREPRISE] | Pearl", color = 75,  pos = vector3(-1843.367, -1186.351, 0)}, 
        {id = 475,  name = "[ENTREPRISE] | City Wok", color = 75,  pos = vector3(-163.0599, 304.949, 0)}, 
        {id = 475, name = "[ENTREPRISE] | Pop Diners", color = 75,  pos = vector3(1583.018,6460.617,25.014)}, 
        {id = 475,  name = "[ENTREPRISE] | Mosley's Auto", color = 5,  pos = vector3(-54.6065,71.38982,-70.891)}, 
        {id = 475, name = "[ENTREPRISE] | Ferme O'neil", color = 19,  pos = vector3(1790.16,4603.12,-100)}, 
        {id = 475, name = "[ENTREPRISE] | BurgerShot", color = 0,    pos = vector3(-1192.236,-892.3857,-100)},
        {id = 475, name = "[ENTREPRISE] | Boulangerie", color = 75,    pos = vector3(-1262.271, -288.445, 37.384)},  
        {id = 446, name = "[ENTREPRISE] | Auto Exotic", color = 5, pos = vector3(550.07,-181.86,54.49)}, 
        {id = 446, name = "[ENTREPRISE] | Stickers", color = 5, pos = vector3(733.17,-1086.259,22.16)}, 
        {id = 446, name = "[ENTREPRISE] | Benny's", color = 5, pos = vector3(-212.81, -1331.43, 23.14)}, 
        {id = 446, name = "[ENTREPRISE] | LS Custom", color = 5, pos = vector3(-304.62, -119.985, 38.00)}, 
        {id = 475, name = "[ENTREPRISE] | DownTown Taxi", color = 5, pos = vector3(894.77,-172.169, 73.68)}, 
        {id = 446, name = "[ENTREPRISE] | Paleto Motors", color = 5, pos = vector3(7.07,6453.089,30.58)}, 
        {id = 475,  name = "[ENTREPRISE] | Vignoble", color = 19, pos = vector3(-1889.615, 2045.458, 148.286)}, 
        {id = 475,  name = "[ENTREPRISE] | Redwood Inc.", color = 19, pos = vector3(2896.27, 4419.62, 50.28)}, 
        {id = 475,  name = "[ENTREPRISE] | River Ranch", color = 19, pos = vector3(1542.871, 2221.411, 77.768)},
        {id = 475,  name = "[ENTREPRISE] | Distillerie", color = 19, pos = vector3(88.76, 6348.53, 31.74)},
        {id = 475,  name = "[ENTREPRISE] | Mine", color = 19, pos = vector3(2702.339, 2774.945, 37.87)},  
        {id = 475,  name = "[ENTREPRISE] | Brasserie", color = 19, pos = vector3(-65.50, 6440.29, 31.50)}, 
        {id = 475,  name = "[ENTREPRISE] | Chicken Job", color = 19, pos = vector3(-75.61, 6250.65, 31.08)},
        {id = 475,  name = "[ENTREPRISE] | Pizzeria", color = 19, pos = vector3(-1466.796,-342.800,43.780)}, 
        {id = 475,  name = "[ENTREPRISE] | Weazel News", color = 0, pos = vector3(-586.666,-926.7887,36.83)}, 
        {id = 475,  name = "[ENTREPRISE] | Sunrise Auto", color = 5, pos = vector3(116.8245,-140.270,54.85)}, 
        {id = 475,  name = "[ENTREPRISE] | MotorSport", color = 5, pos = vector3(-40.61,-1090.23,27.27)}, 
        {id = 475,  name = "[ENTREPRISE] | Larry\'s Motorcyle", color = 5, pos = vector3(1218.57,2728.699,38.00)}, 
        {id = 475,  name = "[ETAT] | Concessionaire Avion", color = 5, pos = vector3(-928.6401,-2994.45,19.84)},
        {id = 475,  name = "[ETAT] | Concessionaire Camion", color = 5, pos = vector3(900.2665,-1154.765,25.160)},
        {id = 475,  name = "[ETAT] | Concessionaire Bateau", color = 5, pos = vector3(-706.85, -1321.998, 5.1)},
        {id = 93,  name = "[BAR] | Bahama mamas", color = 75, pos = vector3(-1367.82,-613.52,29.32)},
        {id = 446, name = "[ENTREPRISE] | Samcro", color = 5, pos = vector3(1027.23, -2526.503, 28.29844)},  
        {name="[ENTREPRISE] | Dynasty 8", color=1, id=475, pos = vector3( 114.20, -875.57, 28.29)}, 
    },

}

configbrancard = {

    brancard = "v_med_emptybed",

    getAllowedJob = {
        "ambulance",
    },

    vehicule = {
        {vehiculeName = "ambulance", zone = 4.0, depth = -2.5, height = 0.5},
        {vehiculeName = "ambulance2", zone = 4.0},
        {vehiculeName = "ambulance3", zone = 4.0},
        {vehiculeName = 'lsambulance', zone = 4.0}
    },
}

ConfigLspd = {
    clothes = {
        normal = {
            [0] = {
                label = "Reprendre sa tenue civil",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
        },
        specials2 = {
            [8] = {
                label = "Defcon 2",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 52,  ['tshirt_2'] = 0,
                        ['torso_1'] = 321,   ['torso_2'] = 12,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 21,
                        ['pants_1'] = 61,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 2,
                        ['shoes_1'] = 52,   ['shoes_2'] = 0,
                        ['chain_1'] = 0,    ['chain_2'] = 0,
                    },
                },
                onEquip = function()
                end
            },

            [9] = {
                label = "SWAT Intervention",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 21, ['tshirt_2'] = 0,
                        ['torso_1'] = 62, ['torso_2'] = 5,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 175,
                        ['pants_1'] = 61, ['pants_2'] = 2,
                        ['shoes_1'] = 63, ['shoes_2'] = 0,
                        ['chain_1'] = 141, ['chain_2'] = 0,
                        ['bproof_1'] = 14, ['bproof_2'] = 4
                    },
                    female = {
                        ['tshirt_1'] = 35, ['tshirt_2'] = 1,
                        ['torso_1'] = 211, ['torso_2'] = 5,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 35,
                        ['pants_1'] = 106, ['pants_2'] = 0,
                        ['shoes_1'] = 52, ['shoes_2'] = 0,
                        ['chain_1'] = 128, ['chain_2'] = 0,
                        ['bproof_1'] = 3, ['bproof_2'] = 4
                    },
                },
                onEquip = function()
                end
            },

            [10] = {
                label = "GTU Intervention",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 211,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 176,
                        ['pants_1'] = 61,   ['pants_2'] = 2,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 141,    ['chain_2'] = 0,
                        ['bproof_1'] = 14,  ['bproof_2'] = 0
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 211,   ['torso_2'] = 4,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 35,
                        ['pants_1'] = 106,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 128,    ['chain_2'] = 0,
                        ['bproof_1'] = 23,  ['bproof_2'] = 3
                    },

                },
                onEquip = function()
                end
            },

            [11] = {
                label = "Marry",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 110, ['tshirt_2'] = 1,
                        ['torso_1'] = 261, ['torso_2'] = 0,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 24,
                        ['pants_1'] = 62, ['pants_2'] = 1,
                        ['shoes_1'] = 71, ['shoes_2'] = 0,
                        ['chain_1'] = 91, ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 201, ['tshirt_2'] = 0,
                        ['torso_1'] = 440, ['torso_2'] = 0,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 27,
                        ['pants_1'] = 76, ['pants_2'] = 1,
                        ['shoes_1'] = 68, ['shoes_2'] = 0,
                        ['chain_1'] = 3, ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },

            [12] = {
                label = "ASD",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 110,  ['tshirt_2'] = 1,
                        ['torso_1'] = 166,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 21,
                        ['pants_1'] = 54,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                        ['torso_1'] = 153,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 22,
                        ['pants_1'] = 74,   ['pants_2'] = 0,
                        ['shoes_1'] = 52,   ['shoes_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },
        },
        specials = {
            [1] = {
                label = "Cadet",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 53,  ['tshirt_2'] = 0,
                        ['torso_1'] = 61,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 11,
                        ['pants_1'] = 55,   ['pants_2'] = 3,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 0,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 3,    ['chain_2'] = 1,
                    },
                },
                onEquip = function()
                end
            },

            [2] = {
                label = "Officier I a III",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 28,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,
                        ['pants_1'] = 65,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },

            [3] = {
                label = "Officier III+I",
                minimum_grade = 4, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 28,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,   ['bags_1'] = 0,
                        ['pants_1'] = 65,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 2,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },
            [4] = {
                label = "Sergent",
                minimum_grade = 8, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 27,   ['torso_2'] = 4,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 65,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 4,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },
                },
                onEquip = function()
                end
            },

            [5] = {
                label = "Lieutenant",
                minimum_grade = 10, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 27,   ['torso_2'] = 6,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 65,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 5,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },
            [6] = {
                label = "Capitaine",
                minimum_grade = 12, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 27,   ['torso_2'] = 7,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 4,
                        ['pants_1'] = 65,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 6,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 86,   ['pants_2'] = 3,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },
            [7] = {
                label = "Chief",
                minimum_grade = 16, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 1,
                        ['torso_1'] = 28,   ['torso_2'] = 19,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 23,
                        ['pants_1'] = 76,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 91,    ['chain_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 77,  ['tshirt_2'] = 0,
                        ['torso_1'] = 50,   ['torso_2'] = 18,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 96,   ['pants_2'] = 1,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['helmet_1'] = -1,  ['helmet_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                    },

                },
                onEquip = function()
                end
            },
        },
        grades = {
            [0] = {
                label = "Gilet Par Balle Lourd",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 32,  ['bproof_2'] = 0
                    },
                    female = {
                        ['bproof_1'] = 34,  ['bproof_2'] = 0
                    }
                },
                onEquip = function()
                end
            },

            [1] = {
                label = "Gilet Par Balle Tactique",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 12,  ['bproof_2'] = 0
                    },
                    female = {
                        ['bproof_1'] = 11,  ['bproof_2'] = 0
                    }
                },
                onEquip = function()
                end
            },

            [3] = {
                label = "Gilet Jaune LSPD",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 22,  ['bproof_2'] = 0
                    },
                    female = {
                        ['bproof_1'] = 31,  ['bproof_2'] = 0
                    }
                },
                onEquip = function()
                end
            },

            [2] = {
                label = "Gilet Par Balle Non Visible",
                value = 100,
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bproof_1'] = 0,
                    },
                    female = {
                        ['bproof_1'] = 0,
                    },
                },
                onEquip = function()
                end
            },


                [4] = {
                    label = "Enlever",
                    value = 0,
                    minimum_grade = 0, -- grade minmum pour prendre la tenue
                    variations = {
                        male = {
                            ['bproof_1'] = 0,
                        },
                        female = {
                            ['bproof_1'] = 0,
                        },
                    },
                    onEquip = function()
                    end


            },

        },

    },
        points ={
            vestiaire = vector3(-562.30,-116.12,42.25),
            vestiaire1 = vector3(1849.96, 3690.36, 29.81),
            vestiaire2 = vector3(1779.04, 2546.73, 45.79),
            armurerie = vector3(-547.104,-109.978,37.865),
            extra = vector3(-611.8067,-126.561,33.75),
            DepotPlainte = vector3(-565.9864,-128.496,38.43),
            LirePlainte = vector3(-571.59,-131.58,38.43),
            AchatVehicle = vector3(-625.53, -102.88, 33.89),
            InsideShop = vector3(-600.02, 56.80, 120.00),
            AppelLSPD = vector3(-564.20, -126.61, 38.43),
        },
        AuthorizedVehicles = {
            Shared = {
                { model = 'policeb1', label = 'policeb1', price = 5000 },
                { model = 'policeb2', label = 'policeb2', price = 5000 },
                { model = 'policefug2', label = 'policefug2', price = 5000 },
                { model = 'policefug', label = 'policefug', price = 5000 },
                { model = 'policefelon', label = 'policefelon', price = 5000 },
                { model = 'police2b', label = 'police2b', price = 5000 },
                { model = 'police3umk', label = 'Cruiser bana', price = 5000 },
                { model = 'police3a', label = 'Cruiser', price = 5000 },
                { model = 'police3slick', label = 'Fpiu', price = 5000 },
                { model = 'pinnaclep', label = 'pinnaclep', price = 5000 }, 
                { model = 'swatstalker', label = 'swatstalker', price = 5000 },
                { model = 'polsadlerk9', label = 'polsadlerk9', price = 5000 }, 
                { model = 'polalamoold', label = 'polalamoold', price = 5000 },
                { model = 'lspdb', label = 'lspdb', price = 5000 },     
                { model = 'polriot', label = 'polriot', price = 5000 },
                { model = 'pscout', label = 'pscout', price = 5000 },
                { model = 'pscoutnew', label = 'pscoutnew', price = 5000 },
                { model = 'polspeedo', label = 'polspeedo', price = 5000 },
                { model = 'poleveron', label = 'poleveron', price = 5000 },
                { model = 'policeslick', label = 'policeslick', price = 5000 },
                { model = 'dominatorsis', label = 'dominatorsis', price = 5000 },   
                { model = 'lspdstanierdp98', label = 'lspdstanierdp98', price = 5000 },
                { model = 'lspdscoutdpgnd', label = 'lspdscoutdpgnd', price = 5000 },   
                { model = 'lspdyanktondp', label = 'lspdyanktondp', price = 5000 },
                { model = 'lspdmeritdp05m', label = 'lspdmeritdp05m', price = 5000 },
                { model = 'trubuffalo', label = 'trubuffalo', price = 5000 },
                { model = 'buffaloslh', label = 'buffaloslh', price = 5000 },
                { model = 'apolicecoq', label = 'apolicecoq', price = 5000 },
                { model = 'pbus', label = 'pbus', price = 5000 },
            }
        },

        AuthorizedHelicopters = {
            boss = {
                {model = 'POLMAV', label = 'Hélicoptère', price = 5000}
            }
        },
        PropsName = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Herse", obj = "p_ld_stinger_s", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
        },
        armurerie = {
                {nom = "Alcotest", arme = "alcotester", minimum_grade = 0, restockprice = 0},
                {nom = "Menotte", arme = "menottes", minimum_grade = 0, restockprice = 0},
                {nom = "Clef Menotte", arme = "clef", minimum_grade = 0, restockprice = 0},
                {nom = "Tablette", arme = "tablet_police", minimum_grade = 0, restockprice = 0},
                {nom = "Radio", arme = "radio", minimum_grade = 0, restockprice = 0},
                {nom = "Lampe", arme = "flashlight", minimum_grade = 0, restockprice = 0},
                {nom = "Matraque", arme = "nightstick", minimum_grade = 0, restockprice = 0},
                {nom = "Tazer", arme = "stungun", minimum_grade = 0, restockprice = 0},
                {nom = "Glock", arme = "combatpistol", minimum_grade = 1, restockprice = 0},
                {nom = "Pistol", arme = "pistol", minimum_grade = 1, restockprice = 0},
                {nom = "Radar", arme = "vintagepistol", minimum_grade = 1, restockprice = 0},
                {nom = "SMG", arme = "smg", minimum_grade = 2, restockprice = 0},
                {nom = "G36", arme = "specialcarbine", minimum_grade = 8, restockprice = 0},
                {nom = "Fusil à pompe", arme = "pumpshotgun", minimum_grade = 10, restockprice = 0},
                {nom = "Sniper", arme = "sniperrifle", minimum_grade = 18, restockprice = 0},
                {nom = "Grenade Fumigène", arme = "smokegrenade", minimum_grade = 8, restockprice = 0},
                {nom = "Balle de 9mm", arme = "pistol_ammo", minimum_grade = 1, restockprice = 0},
                {nom = "Balle de Smg", arme = "smg_ammo", minimum_grade = 2, restockprice = 0},
                {nom = "Balle de 7.62m", arme = "rifle_ammo", minimum_grade = 8, restockprice = 0},
                {nom = "Cartouche" , arme = "shotgun_ammo", minimum_grade = 10, restockprice = 0},
                {nom = "Boite de munitions 9mm", arme = "pistol_ammo_box", minimum_grade = 1, restockprice = 0},
                {nom = "Boite de munitions Smg", arme = "smg_ammo_box", minimum_grade = 2, restockprice = 0},
                {nom = "Boite de munitions 7.62m", arme = "rifle_ammo_box", minimum_grade = 8, restockprice = 0},
                {nom = "Boite de munitions Cartouche" , arme = "shotgun_ammo_box", minimum_grade = 10, restockprice = 0},
                {nom = "Boite de munitions Sniper", arme = "sniper_ammo", minimum_grade = 18, restockprice = 0},
                {nom = "Fusée de détresse", arme = "flare", minimum_grade = 18, restockprice = 0},

    },
}

ConfigBCSO = {
    clothes = {
        normal = {
            [0] = {
                label = "Reprendre sa tenue civil",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
        },
        specials = {
            [0] = {
                label = "Reprendre sa tenue civil",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
            [1] = {
                label = "Probatory Deputy",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 195,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 0,
                        ['pants_1'] = 82,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 27,    ['chain_2'] = 0,
                        ['bproof_1'] = 22,  ['bproof_2'] = 3,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 200,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0,
                ['bproof_1'] = 22,  ['bproof_2'] = 3,
                    },
                },
                onEquip = function()
                end
            },

            [2] = {
                label = "RCP",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 29,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 48,
                        ['pants_1'] = 82,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 14,  ['bproof_2'] = 1,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 49,   ['torso_2'] = 1,
                        ['decals_1'] = 101,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 0,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0
                    },

                },
                onEquip = function()
                end
            },

            [3] = {
                label = "HP",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 53,  ['tshirt_2'] = 1,
                        ['torso_1'] = 30,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 37,   ['torso_2'] = 0,
                        ['decals_1'] = 101,   ['decals_2'] = 0,
                        ['arms'] = 145,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 62,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            [4] = {
                label = "HP VIR",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 81,  ['tshirt_2'] = 3,
                        ['torso_1'] = 288,   ['torso_2'] = 3,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 37,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 95,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 437,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 145,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },
                },
                onEquip = function()
                end
            },

            [5] = {
                label = "PR",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 53,  ['tshirt_2'] = 0,
                        ['torso_1'] = 301,   ['torso_2'] = 5,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 100,
                        ['pants_1'] = 82,   ['pants_2'] = 0,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 49,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            [6] = {
                label = "Sergent",
                minimum_grade = 6, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 38,   ['torso_2'] = 8,
                        ['decals_1'] = 25,   ['decals_2'] = 2,
                        ['arms'] = 39,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 26,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 35,   ['torso_2'] = 1,
                        ['decals_1'] = 101,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 96,   ['pants_2'] = 1,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            [7] = {
                label = "Master Sergent",
                minimum_grade = 7, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 1,
                        ['torso_1'] = 38,   ['torso_2'] = 8,
                        ['decals_1'] = 25,   ['decals_2'] = 3,
                        ['arms'] = 39,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 35,   ['torso_2'] = 5,
                        ['decals_1'] = 101,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            
            [8] = {
                label = "Lieutenant",
                minimum_grade = 9, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 38,   ['torso_2'] = 8,
                        ['decals_1'] = 58,   ['decals_2'] = 6,
                        ['arms'] = 39,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 26,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                        ['torso_1'] = 49,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            
            [9] = {
                label = "Capitaine",
                minimum_grade = 10, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                        ['torso_1'] = 38,   ['torso_2'] = 8,
                        ['decals_1'] = 58,   ['decals_2'] = 7,
                        ['arms'] = 39,
                        ['pants_1'] = 82,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 26,    ['chain_2'] = 0,
                        ['bproof_1'] = 26,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
                        ['torso_1'] = 35,   ['torso_2'] = 6,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            
            [10] = {
                label = "EM",
                minimum_grade = 11, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 148,  ['tshirt_2'] = 3,
                        ['torso_1'] = 174,   ['torso_2'] = 18,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 175,
                        ['pants_1'] = 79,   ['pants_2'] = 4,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 20,    ['chain_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                        ['torso_1'] = 49,   ['torso_2'] = 0,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 14,
                        ['pants_1'] = 99,   ['pants_2'] = 0,
                        ['shoes_1'] = 53,   ['shoes_2'] = 0,
                        ['chain_1'] = 2,    ['chain_2'] = 0
                    },

                },
                onEquip = function()
                end
            },
            
            [11] = {
                label = "Intervention",
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 53,  ['tshirt_2'] = 0,
                        ['torso_1'] = 321,   ['torso_2'] = 3,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 20,
                        ['pants_1'] = 61,   ['pants_2'] = 1,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 141,    ['chain_2'] = 0,
                        ['bproof_1'] = 32,  ['bproof_2'] = 2,
                    },
                    female = {
                        ['tshirt_1'] = 35, ['tshirt_2'] = 1,
                        ['torso_1'] = 155, ['torso_2'] = 4,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 40,
                        ['pants_1'] = 99, ['pants_2'] = 0,
                        ['shoes_1'] = 22, ['shoes_2'] = 0,
                        ['chain_1'] = 128, ['chain_2'] = 0,
                        ['bproof_1'] = 23, ['bproof_2'] = 1
                    },
                    onEquip = function()
                    end
                }
            },
            
            [12] = {
                label = "SRT",
                minimum_grade = 1, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['tshirt_1'] = 64,  ['tshirt_2'] = 0,
                        ['torso_1'] = 321,   ['torso_2'] = 3,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 20,
                        ['pants_1'] = 61,   ['pants_2'] = 4,
                        ['shoes_1'] = 63,   ['shoes_2'] = 0,
                        ['chain_1'] = 141,  ['chain_2'] = 0,
                        ['bproof_1'] = 39, ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 35, ['tshirt_2'] = 0,
                        ['torso_1'] = 211, ['torso_2'] = 5,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 35,
                        ['pants_1'] = 106, ['pants_2'] = 0,
                        ['shoes_1'] = 53, ['shoes_2'] = 0,
                        ['chain_1'] = 128, ['chain_2'] = 0
                    },
                    onEquip = function()
                    end
                },
            },

                [13] = {
                    label = "CID",
                    minimum_grade = 1, -- grade minmum pour prendre la tenue
                    variations = {
                        male = {
                            ['tshirt_1'] = 193,  ['tshirt_2'] = 0,
                            ['torso_1'] = 49,   ['torso_2'] = 3,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 26,
                            ['pants_1'] = 58,   ['pants_2'] = 0,
                            ['shoes_1'] = 9,   ['shoes_2'] = 2,
                            ['chain_1'] = 93,    ['chain_2'] = 0,
                            ['bproof_1'] = 33,  ['bproof_2'] = 2,
                        },
                        female = {
                            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                            ['torso_1'] = 211,   ['torso_2'] = 2,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 35,
                            ['pants_1'] = 99,   ['pants_2'] = 1,
                            ['shoes_1'] = 22,   ['shoes_2'] = 0,
                            ['chain_1'] = 5,    ['chain_2'] = 0,
                            ['bproof_1'] = 37,  ['bproof_2'] = 0
                        },

                    },
                    onEquip = function()
                    end
                },

                [14] = {
                    label = "CID Intervention",
                    minimum_grade = 1, -- grade minmum pour prendre la tenue
                    variations = {
                        male = {
                            ['tshirt_1'] = 148,  ['tshirt_2'] = 3,
                            ['torso_1'] = 321,   ['torso_2'] = 4,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 21,
                            ['pants_1'] = 61,   ['pants_2'] = 2,
                            ['shoes_1'] = 63,   ['shoes_2'] = 0,
                            ['chain_1'] = 141,    ['chain_2'] = 0,
                            ['bproof_1'] = 0,  ['bproof_2'] = 0,
                        },
                        female = {
                            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                            ['torso_1'] = 186,   ['torso_2'] = 2,
                            ['decals_1'] = 0,   ['decals_2'] = 0,
                            ['arms'] = 27,
                            ['pants_1'] = 77,   ['pants_2'] = 0,
                            ['shoes_1'] = 22,   ['shoes_2'] = 0,
                            ['chain_1'] = 107,    ['chain_2'] = 0,
                            ['bproof_1'] = 16,  ['bproof_2'] = 0
                        },

                    },
                    onEquip = function()
                    end
                },

                [15] = {
                    label = "Mary",
                    minimum_grade = 1, -- grade minmum pour prendre la tenue
                    variations = {
                        male = {
                            ['tshirt_1'] = 110, ['tshirt_2'] = 1,
                            ['torso_1'] = 294, ['torso_2'] = 3,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 39,
                            ['pants_1'] = 62, ['pants_2'] = 2,
                            ['shoes_1'] = 71, ['shoes_2'] = 0,
                            ['chain_1'] = 150, ['chain_2'] = 0,
                            ['bproof_1'] = 30,  ['bproof_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 201, ['tshirt_2'] = 0,
                            ['torso_1'] = 440, ['torso_2'] = 1,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 27,
                            ['pants_1'] = 76, ['pants_2'] = 2,
                            ['shoes_1'] = 68, ['shoes_2'] = 0,
                            ['chain_1'] = 3, ['chain_2'] = 0,
                            ['bproof_1'] = 23,  ['bproof_2'] = 1
                        },
                        onEquip = function()
                        end
                    },
                },

                   [16] = {
                        label = "AUSO",
                        minimum_grade = 1, -- grade minmum pour prendre la tenue
                        variations = {
                            male = {
                                ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
                                ['torso_1'] = 367,   ['torso_2'] = 2,
                                ['decals_1'] = 0,   ['decals_2'] = 0,
                                ['arms'] = 26,
                                ['pants_1'] = 139,   ['pants_2'] = 0,
                                ['shoes_1'] = 63,   ['shoes_2'] = 0,
                                ['chain_1'] = 20,    ['chain_2'] = 0,
                                ['bproof_1'] = 25,  ['bproof_2'] = 0
                            },
                            female = {
                                ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                                ['torso_1'] = 171,   ['torso_2'] = 1,
                                ['decals_1'] = 93,   ['decals_2'] = 1,
                                ['arms'] = 9,
                                ['pants_1'] = 83,   ['pants_2'] = 1,
                                ['shoes_1'] = 53,   ['shoes_2'] = 0,
                            },
                            onEquip = function()
                            end
                        },
                    },
                    
                    [17] = {
                        label = "Cérémonie",
                        minimum_grade = 0, -- grade minmum pour prendre la tenue
                        variations = {
                            male = {
                                ['tshirt_1'] = 53,  ['tshirt_2'] = 1,
                                ['torso_1'] = 301,   ['torso_2'] = 3,
                                ['decals_1'] = 0,   ['decals_2'] = 0,
                                ['arms'] = 81,
                                ['pants_1'] = 55,   ['pants_2'] = 2,
                                ['shoes_1'] = 94,   ['shoes_2'] = 1,
                                ['chain_1'] = 26,    ['chain_2'] = 0,
                                ['bproof_1'] = 49,  ['bproof_2'] = 0
                            },
                            female = {
                                ['tshirt_1'] = 194,  ['tshirt_2'] = 0,
                                ['torso_1'] = 49,   ['torso_2'] = 9,
                                ['decals_1'] = 0,   ['decals_2'] = 0,
                                ['arms'] = 100,
                                ['pants_1'] = 86,   ['pants_2'] = 0,
                                ['shoes_1'] = 87,   ['shoes_2'] = 0,
                                ['bproof_1'] = 26,  ['bproof_2'] = 0,
                            },
                            onEquip = function()
                            end
                        },
                    },
        },
        grades = {
            [0] = {
                label = "Gilet Par Balle",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 32,  ['bproof_2'] = 2
                    },
                    female = {
                        ['bproof_1'] = 23,  ['bproof_2'] = 1
                    }
                },
                onEquip = function()
                end
            },

            [1] = {
                label = "Gilet Tactique",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 14,  ['bproof_2'] = 1
                    },
                    female = {
                        ['bproof_1'] = 34,  ['bproof_2'] = 2
                    }
                },
                onEquip = function()
                end
            },

            [2] = {
                label = "Gilet Jaune BCSO",
                value = 100,
                minimum_grade = 0,
                variations = {
                    male = {
                        ['bproof_1'] = 22,  ['bproof_2'] = 3
                    },
                    female = {
                        ['bproof_1'] = 31,  ['bproof_2'] = 3
                    }
                },
                onEquip = function()
                end
            },

            [3] = {
                label = "Gilet non visible",
                value = 100,
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bproof_1'] = 0,
                    },
                    female = {
                        ['bproof_1'] = 0,
                    },
                },
                onEquip = function()
                end
            },

            [4] = {
                label = "Enlever",
                value = 0,
                minimum_grade = 0, -- grade minmum pour prendre la tenue
                variations = {
                    male = {
                        ['bproof_1'] = 0,
                    },
                    female = {
                        ['bproof_1'] = 0,
                    },
                },
                onEquip = function()
                end
            }

        },

    },
        points ={
            vestiaire = vector3(1845.515, 3693.375, 34.27),
            vestiaire1 = vector3(-561.17, -119.12, 42.25),
            vestiaire2 = vector3(1780.89, 2549.33, 45.79),
            armurerie = vector3(1860.319, 3688.497, 34.27),
            extra = vector3(1871.02, 3704.30, 33.54),
            DepotPlainte = vector3(1849.284, 3684.621, 34.21),
            LirePlainte = vector3(1852.973, 3688.674, 34.21),
            AchatVehicle = vector3(1881.28, 3709.29, 33.17),
            InsideShop = vector3(1877.53, 3705.11, 39.50),
            AppelBCSO = vector3(1853.01, 3686.50, 34.22),
        },

        AuthorizedVehicles = {
            Shared = {
                { model = 'polalamor', label = 'polalamor', price = 5000 },
                { model = 'polbuffalor', label = 'polbuffalor', price = 5000 },
                { model = 'polcarar', label = 'polcarar', price = 5000 },
                { model = 'polcoquetter', label = 'polcoquetter', price = 5000 },
                { model = 'poldmntr', label = 'poldmntr', price = 5000 },
                { model = 'polfugitiver', label = 'polfugitiver', price = 5000 },
                { model = 'polgauntletr', label = 'polgauntletr', price = 5000 },
                { model = 'polgresleyr', label = 'polgresleyr', price = 5000 },
                { model = 'polscoutr', label = 'polscoutr', price = 5000 },
                { model = 'polstanierr', label = 'polstanierr', price = 5000 },
                { model = 'lspdstanierdp98', label = 'lspdstanierdp98', price = 5000 },
                { model = 'lspdscoutdpgnd', label = 'lspdscoutdpgnd', price = 5000 },
                { model = 'lspdmeritdp05m', label = 'lspdmeritdp05m', price = 5000 },
                { model = 'trubuffalo', label = 'trubuffalo', price = 5000 },
                { model = 'policeb1', label = 'policeb1', price = 5000 },
                { model = 'policeb2', label = 'policeb2', price = 5000 },
                { model = 'pbus', label = 'pbus', price = 5000 },
            }
        },

        AuthorizedHelicopters = {
            boss = {
                {model = 'POLMAV', label = 'Hélicoptère', price = 5000}
            }
        };

        PropsName = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Herse", obj = "p_ld_stinger_s", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
        },
        armurerie = {
                {nom = "Alcotest", arme = "alcotester", minimum_grade = 0, restockprice = 0},
                {nom = "Menotte", arme = "menottes", minimum_grade = 0, restockprice = 0},
                {nom = "Clef Menotte", arme = "clef", minimum_grade = 0, restockprice = 0},
                {nom = "Tablette", arme = "tablet_police", minimum_grade = 0, restockprice = 0},
                {nom = "Radio", arme = "radio", minimum_grade = 0, restockprice = 0},
                {nom = "Lampe", arme = "flashlight", minimum_grade = 0, restockprice = 0},
                {nom = "Matraque", arme = "nightstick", minimum_grade = 0, restockprice = 0},
                {nom = "Tazer", arme = "stungun", minimum_grade = 0, restockprice = 0},
                {nom = "Glock", arme = "combatpistol", minimum_grade = 1, restockprice = 0},
                {nom = "Pistol", arme = "pistol", minimum_grade = 1, restockprice = 0},
                {nom = "Radar", arme = "vintagepistol", minimum_grade = 1, restockprice = 0},
                {nom = "SMG", arme = "smg", minimum_grade = 2, restockprice = 0},
                {nom = "G36", arme = "specialcarbine", minimum_grade = 8, restockprice = 0},
                {nom = "Fusil à pompe", arme = "pumpshotgun", minimum_grade = 10, restockprice = 0},
                {nom = "Mousquet", arme = "musket", minimum_grade = 9, restockprice = 0},
                {nom = "Sniper", arme = "sniperrifle", minimum_grade = 13, restockprice = 0},
                {nom = "Grenade Fumigène", arme = "smokegrenade", minimum_grade = 8, restockprice = 0},
                {nom = "Balle de 9mm", arme = "pistol_ammo", minimum_grade = 1, restockprice = 0},
                {nom = "Balle de Smg", arme = "smg_ammo", minimum_grade = 2, restockprice = 0},
                {nom = "Balle de 7.62m", arme = "rifle_ammo", minimum_grade = 8, restockprice = 0},
                {nom = "Cartouche" , arme = "shotgun_ammo", minimum_grade = 10, restockprice = 0},
                {nom = "Boite de munitions 9mm", arme = "pistol_ammo_box", minimum_grade = 1, restockprice = 0},
                {nom = "Boite de munitions Smg", arme = "smg_ammo_box", minimum_grade = 2, restockprice = 0},
                {nom = "Boite de munitions 7.62m", arme = "rifle_ammo_box", minimum_grade = 8, restockprice = 0},
                {nom = "Boite de munitions Cartouche" , arme = "shotgun_ammo_box", minimum_grade = 10, restockprice = 0},
                {nom = "Boite de munitions Sniper", arme = "sniper_ammo", minimum_grade = 13, restockprice = 0},
                {nom = "Fusée de détresse", arme = "flare", minimum_grade = 13, restockprice = 0},

    },
}

ConfigPrison = {

    points = {
        {gestion = vector3(1832.1, 2584.8, 45.95)},
        {champs = vector3(1776.99, 2598.876, 45.79)},
        {lavage = vector3(1776.0, 2594.57, 45.79)},
        {cuisson = vector3(1781.78, 2591.8, 45.79)},
        {vente = vector3(1780.6, 2583.0, 45.79)},
        {repassage = vector3(1780.33, 2613.93, 50.54)},
        {pliage = vector3(1777.24, 2618.02, 50.54)},
        {nettoyage = vector3(1767.30, 2590.02, 45.79)},
        {balayage = vector3(1779.69, 2573.70, 45.79)},
    },
    nourriture = {
        {label = "Pomme de terre", value = "pearl_patate", price =0},
    },
    ["Exterieur"] = { 
        ["x"] = 1845.6022949219, 
        ["y"] = 2585.8029785156, 
        ["z"] = 45.672061920166, 
        ["h"] = 92.469093322754, 
        ["goal"] = { 
            "Poste de sécurité" 
        } 
    }

}
ConfigGang = {
    GangsList = {
        -- Gangs
        {
          orga = false,
          gangname = "gang_2",
          backmarket = vector3(555.05,2792.115,38.19),
          vestiaire = vector3(448.59, -1587.85, 35.33)
        },
        {
          orga = false,
          gangname = "ballas",
          backmarket = vector3(555.05,2792.115,38.19),
          vestiaire = vector3(80.08, -1968.835, 20.13)
        },
        {
          orga = false,
          gangname = "gang_1",
          backmarket = vector3(555.05,2792.115,38.19),
          vestiaire = vector3(95.80, 54.260, 72.52)
        },
        {
          orga = false,
          gangname = "famille_1",
          backmarket = vector3(555.05,2792.115,38.19),
          vestiaire = vector3(153.22, -3014.64, 6.04)
        },
        {
          orga = false,
          gangname = "famille_2",
          backmarket = vector3(555.05,2792.115,38.19),
          vestiaire = vector3(-1051.624, 307.1539, 70.668)
        },
        {
          orga = false,
          gangname = "crips_gang",
          backmarket = vector3(-1576.18,-216.5473,48.57),
          vestiaire = vector3(115.14, -1967.85, 20.33)
        },
        {
            orga = false,
            gangname = "th410",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(472.2, -1775.5, 28.07)
        },
        {
            orga = true,
            gangname = "biker",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(984.1525, -91.30212, 73.84)
        },
        {
            orga = true,
            gangname = "biker_1",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(1027.72, -2542.71, 27.29)
        },
        {
            orga = true,
            gangname = "biker_2",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-87.78, 6510.015, 34.52)
        },
        {
            orga = true,
            gangname = "biker_3",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(901.715,3577.619,28.91)
        },
        {
            orga = false,
            gangname = "black_discipline",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-1145.06, -1514.61, 9.63)
        },
        {
            orga = false,
            gangname = "blood",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-1557.00,-397.80,47.20)
        },
        {
            orga = false,
            gangname = "crips",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-340.20, 52.23, 43.22)
        },
        {
            orga = false,
            gangname = "families",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-123.76, -1563.83, 36.35)
        },
        {
            orga = false,
            gangname = "gitan",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(1336.55,4307.13,37.12)
        },
        {
            orga = false,
            gangname = "hippie",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(2329.92, 2575.34, 45.68)
        },
        {
            orga = false,
            gangname = "mara",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(1301.08, -1745.63, 54.27)
        },
        {
            orga = false,
            gangname = "mara18",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(1439.33, -1482.28, 66.61)
        },
        {
            orga = false,
            gangname = "marabunta",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(369.73, -1800.72, 28.22)
        },
        {
            orga = false,
            gangname = "oneil",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(2441.392, 4984.02, 45.81)
        },
        {
            orga = false,
            gangname = "vagos",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(356.798, -2033.506, 21.39)
        },
        {
            orga = false,
            gangname = "black_disciple",
            backmarket = vector3(555.05,2792.115,38.19),
            vestiaire = vector3(-1150.8884277344,-1513.4874267578,9.6327276229858)
        },
        -- Orga
        {
            orga = true,
            gangname = "cartel",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(567.50,-2779.99,5.09)
        },
        {
            orga = true,
            gangname = "cartel_1",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(-307.32, -1315.61, 30.26)
        },
        {
            orga = true,
            gangname = "cartel_2",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(-66.15, 989.22, 233.57)
        },
        {
            orga = true,
            gangname = "mafia",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(391.03, -13.947, 85.673)
        },
        {
            orga = true,
            gangname = "mafia_2",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(1403.08,1139.68,116.52)
        },
        {
            orga = true,
            gangname = "mafia_1",
            backmarket = vector3(556.008, 2795.722, 38.19),
            vestiaire = vector3(-1790.751, 438.0039, 127.364)
        },
    },
    objets = {
        {label = "Table", model = "prop_table_para_comb_02"},
        {label = "Chaise", model = "prop_table_03_chr"},
        {label = "BBQ", model = "prop_bbq_5"}
    },
    blackmarket = {
        {label = "Pistolet Lourd", model = "heavypistol", price = 45000},
        {label = "Calibre 50", model = "pistol50", price = 60000},
        {label = "Revolver ", model = "revolver", price = 65000},
        {label = "Pistolet Mitrailleur (TECH9)", model = "machinepistol", price = 150000},
        {label = "Mini SMG (SKORPION)", model = "minismg", price = 130000},
        {label = "Fusil Compact (AK-U)", model = "compactrifle", price = 450000},
        {label = "Fusil d'Assaut (AK-47)", model = "assaultrifle", price = 600000},
        {label = "Carabine d'Assaut (M4)", model = "carbinerifle", price = 625000},
        {label = "Gusenberg", model = "gusenberg", price = 800000},
        {label = "Fusil Sniper", model = "sniperrifle", price = 2500000},
        {label = "Grenade Fumigène", model = "smokegrenade", price = 4000},
        {label = "Cocktail Molotov", model = "molotov", price = 5000},

    },
    blackmarketbiker = {
        {label = "SNS Pistolet", model = "snspistol", price = 15000},
        {label = "Pistol", model = 'pistol', price = 20000},
        {label = "Micro SMG", model = 'microsmg', price = 130000},
        {label = "Canon scié", model = "sawnoffshotgun", price = 200000},
        {label = "Fusil Double Canon", model = "dbshotgun", price = 200000},
        {label = "Cocktail Molotov", model = "molotov", price = 5000},

    }
}

ConfigUnicorn = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(98.72,-1290.84,24.20)}
    },
    annonces = {
        {label = "Ouverture", msg = "L'Unicorn est désormais ~g~Ouvert~s~ !"},
        {label = "Fermeture", msg = "L'Unicorn est désormais ~r~Fermé~s~ !"},
    },
    chancecraft = 10
}

Configtacos = {
    cuisine = {
        {label = "Cornet de Frite", value = "frite"},
        {label = "Tacos", value = "tacos"},
        {label = "Salade Mexicaine", value = "salade"},
        {label = "Burrito", value = "buritto"},
        {label = "Nachos", value = "nachos"},
    },
    nourriture = {
        {label = "Pomme de terre", value = "potato", price =6},
        {label = "Galette", value = "Galette_tacos", price =3},
        {label = "Sauces", value = "sauces", price =3},
        {label = "Steak Surgelé", value = "fburger", price =10},
        {label = "Fromage", value = "cheese", price =3},
        {label = "Nuggets", value = "nugget", price =10},
        {label = "Tomates", value = "ctomato", price =5},
        {label = "Poulet", value = "fvburger", price =6},
        {label = "Salade", value = "clettuce", price =3},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
    },
    points = {
        vestiaire = vector3(419.49,-1920.871,24.47),
        shop = vector3(46.48, -1749.645, 28.63),
        cuisine = vector3(427.1623,-1917.87,24.47),
        cuisine1 = vector3(424.98,-1920.014,24.47)
    },
}
ConfigPearl = {
    cuisine = {
        {label = "Entrecote", value = "entrecote"},
        {label = "Dos de Cabillaud", value = "doscabillaud"},
        {label = "Salade de la Mer", value = "salademer"},
        {label = "Sushi à la Française", value = "sushifr"},
        {label = "Moules Frites", value = "moulesfrite"},
        {label = "Soupe de poisson", value = "soupe"},
    },
    nourriture = {
        {label = "Steak", value = "pearl_steak", price =6},
        {label = "Tomate", value = "pearl_tomate", price =3},
        {label = "Patate", value = "pearl_patate", price =4},
        {label = "Cabillaud", value = "pearl_poisson", price =6},
        {label = "Salade", value = "pearl_salade", price =3},
        {label = "Moules", value = "pearl_moules", price =5},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
    },
    points = {
        vestiaire = vector3(-1837.948,-1180.989,13.32),
        shop = vector3(62.763,-1728.57, 28.61),
        cuisine = vector3(-1842.092,-1185.494,13.32),
        cuisine1 = vector3(-1842.599,-1188.192,13.32)
    },
}
Configcitywok = {
    cuisine = {
        {label = "riz", value = "cuire_riz"},
        {label = "nouilles", value = "cuire_nouilles"},
        {label = "Maki au Saumon", value = "maki_saumon"},
        {label = "Sushi au Saumon", value = "sushi_saumon"},
        {label = "Maki au Thon", value = "maki_thon"},
        {label = "Sushi au Thon", value = "sushi_thon"},
        {label = "Porc au Caramel", value = "porc_caramel"},
        {label = "Nems au porc", value = "nems_porc"},
        {label = "Nems au poulet", value = "nems_poulet"},
        {label = "Rouleau de printemps", value = "Rouleau_printemps"},
        {label = "Nouille sauté au Poulet", value = "nouille_poulet"},
    },
    nourriture = {
        {label = "Riz", value = "riz", price =3},
        {label = "Nouille", value = "nouille", price =3},
        {label = "Galette de riz", value = "galetteriz", price =2},
        {label = "Feuille de brick", value = "feuille_brick", price =2},
        {label = "Wasabi", value = "wasabi", price =3},
        {label = "Crevette", value = "crevette", price =7},
        {label = "Porc", value = "porc", price =6},
        {label = "Poulet", value = "poulet", price =6},
        {label = "Caramel", value = "caramel", price =3},
        {label = "Laitue", value = "lettuce", price =3},
        {label = "Boite de Thon", value = "boite_thon", price =7},
        {label = "Saumon", value = "saumon", price =7},
        {label = "Feuille d'algue", value = "feuille_algue", price =5},
        {label = "Sauce Soja", value = "sauce_soja", price =2},

    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
    },
    points = {
        vestiaire = vector3(-173.452, 304.717, 99.92),
        shop = vector3(62.763,-1728.57, 28.61),
        cuisine = vector3(-177.84,304.647,96.45),
        cuisine1 = vector3(-176.945,302.394,96.46)
    },
}

ConfigMosley = {

    points = {
        {vestiaire = vector3(-50.64,76.69,70.90)}
    },
}
Configstudioraps = {

    points = {
        {vestiaire = vector3(-1004.249,-265.0858,43.799)}
    },
}

ConfigDoj = {

    points = {
        {vestiaire = vector3(-541.2917,-200.8282,46.655)}
    },

}
ConfigTaxi = {

    points = {
        {vestiaire = vector3(894.77,-172.169, 73.68)}
    },
    priceMission = {
        account = "Money", -- COMPTE OU L'ARGENT APR7S MISSION CE RETROUVE
        pourcentEntreprise = 50, -- POURCENTAGE SUR 100 DE L'ARGENT GAGNE QUI VA DIRECT DANS L'ENTREPRISE
        min = 20, -- RECOMPENSE MINI EN ARGENT D'UNE MISSION
        max = 80, -- RECOMPENSE MAXI EN ARGENT D'UNE MISSION
    },
    vehicule = {
            {label = "Ford Cruiser", name = "taxi"}
        },
    uniform ={
         male = {
            ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
            ['torso_1'] = 450,    ['torso_2'] = 0,
            ['decals_1'] = 0,    ['decals_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 28,    ['pants_2'] = 11,
            ['shoes_1'] = 17,    ['shoes_2'] = 0,
            ['chain_1'] = 0,     ['chain_2'] = 0,
            ['helmet_1'] = -1,   ['helmet_2'] = 0,
            ['bags_1'] = 0
        },
        female = {
            ['tshirt_1'] = 1,  ['tshirt_2'] = 3,
            ['torso_1'] = 169,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 6,
            ['pants_1'] = 97,   ['pants_2'] = 2,
            ['shoes_1'] = 48,   ['shoes_2'] = 9,
            ['chain_1'] = 146,  ['chain_2'] = 0,
            ['bags_1'] = 51,    ['glasses_1'] = 5
            }
        },

}

ConfigStickers = {

    points = {
        {vestiaire = vector3(731.88, -1073.03, 28.19)}
    },
    uniform ={
         male = {
            ['tshirt_1'] = 91,   ['tshirt_2'] = 0,
            ['torso_1'] = 447,    ['torso_2'] = 8,
            ['decals_1'] = 0,    ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 139,    ['pants_2'] = 1,
            ['shoes_1'] = 89,    ['shoes_2'] = 0,
            ['chain_1'] = 0,     ['chain_2'] = 0,
            ['helmet_1'] = -1,   ['helmet_2'] = 0,
            ['bags_1'] = 0
        },
        female = {
            ['tshirt_1'] = 232,  ['tshirt_2'] = 0,
            ['torso_1'] = 469,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 76,
            ['pants_1'] = 174,   ['pants_2'] = 0,
            ['shoes_1'] = 120,   ['shoes_2'] = 6,
            ['chain_1'] = 146,  ['chain_2'] = 0,
            ['bags_1'] = 51,    ['glasses_1'] = 5
            }
        },
}
ConfigLingot = {

    points = {
        {achat = vector3(252.432,220.974,106.28)}
    },
}
ConfigLTDgroove = {

    points = {
        {vestiaire = vector3(24.88,-1339.48,28.49)}
    },
}
ConfigLTDBallas = {

    points = {
        {vestiaire = vector3(-42.41, -1749.72, 28.42)}
    },
}
ConfigWeazel= {

    points = {
        {vestiaire = vector3(-565.546,-917.0298,22.87)}
    },
}

ConfigBoulangerie = {
    cuisine = {
        {label = "Sandwich Jambon Beurre", value = "sdwjambonbeurre"},
        {label = "Sandwich Emmental", value = "sdwemmental"},
        {label = "Sandwich Poulet", value = "sdwpoulet"},
        {label = "Pain Bagnat", value = "painbagnat"},
        {label = "Croissant", value = "croissant"},
        {label = "Pain au chocolat", value = "painauchocolat"},
        {label = "Eclair au chocolat", value = "eclairchoco"},
        {label = "Eclair au café", value = "eclaircafe"},

    },
    nourriture = {
        {label = "Beurre", value = "beurre", price =8},
        {label = "Jambon", value = "jambon", price =3},
        {label = "Fromage", value = "cheese", price =4},
        {label = "Poulet", value = "poulet", price =8},
        {label = "Tomate", value = "tomato", price =3},
        {label = "Pâte", value = "pate2", price =5},
        {label = "Salade", value = "lettuce", price =8},
        {label = "Saucisse", value = "saucisse", price =8},
        {label = "Thon", value = "thon", price =4},
        {label = "Chocolat", value = "choco", price =8},
        {label = "Crème", value = "creme", price =4},
        {label = "Oeuf Dur", value = "oeufdur", price =4},
        {label = "Pain", value = "bread", price =5},

    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Perrier", value = "perrier", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
        {label = "Cafe expresso", value = "cafe", price =8},
        {label = "Cappuccino", value = "cappuccino", price =8},
        {label = "Thé", value = "the", price =8},
        {label = "Chocolat chaud", value = "chocochaud", price =8},        
    },

    points = {
        vestiaire = vector3(-1265.65,-287.404,36.39),
        shop = vector3(54.62, -1738.997, 28.59),
        cuisine = vector3(-1262.721,-283.5858,36.38),
        cuisine1 = vector3(-1263.186,-281.314,36.38)
    },
}

ConfigBeanmachine = {
    cuisine = {
        {label = "Sandwich Jambon Beurre", value = "sdwjambonbeurre"},
        {label = "Sandwich Emmental", value = "sdwemmental"},
        {label = "Sandwich Poulet", value = "sdwpoulet"},
        {label = "Pain Bagnat", value = "painbagnat"},
        {label = "Croissant", value = "croissant"},
        {label = "Pain au chocolat", value = "painauchocolat"},
        {label = "Eclair au chocolat", value = "eclairchoco"},
        {label = "Eclair au café", value = "eclaircafe"},

    },
    nourriture = {
        {label = "Beurre", value = "beurre", price =8},
        {label = "Jambon", value = "jambon", price =3},
        {label = "Fromage", value = "cheese", price =4},
        {label = "Poulet", value = "poulet", price =8},
        {label = "Tomate", value = "tomato", price =3},
        {label = "Pâte", value = "pate2", price =5},
        {label = "Salade", value = "lettuce", price =8},
        {label = "Saucisse", value = "saucisse", price =8},
        {label = "Thon", value = "thon", price =4},
        {label = "Chocolat", value = "choco", price =8},
        {label = "Crème", value = "creme", price =4},
        {label = "Oeuf Dur", value = "oeufdur", price =4},
        {label = "Pain", value = "bread", price =5},

    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Perrier", value = "perrier", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
        {label = "Cafe expresso", value = "cafe", price =8},
        {label = "Cappuccino", value = "cappuccino", price =8},
        {label = "Thé", value = "the", price =8},
        {label = "Chocolat chaud", value = "chocochaud", price =8},        
    },

    points = {
        vestiaire = vector3(-1265.65,-287.404,36.39),
        shop = vector3(54.62, -1738.997, 28.59),
        cuisine = vector3(-1262.721,-283.5858,36.38),
        cuisine1 = vector3(-1263.186,-281.314,36.38)
    },
}

ConfigPizzeria = {
    cuisine = {
        {label = "Pizza reine", value = "reine"},
        {label = "Pizza au 5 fromages", value = "5fromages"},
        {label = "Pizza au barbecue", value = "barbecue"},
        {label = "Pizza au saumon", value = "saumons"},
        {label = "Pizza orientale", value = "orientale"},
        {label = "Pizza calzone", value = "calzone"},
    },
    nourriture = {
        {label = "Pate à Pizza", value = "pate", price =4},
        {label = "Ingrédient pour Pizza", value = "ing", price =6},
        {label = "Crepe", value = "crepe", price =4},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Perrier", value = "perrier", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
        {label = "Cafe expresso", value = "cafe", price =8},
        {label = "Cappuccino", value = "cappuccino", price =8},
        {label = "Thé", value = "the", price =8},
        {label = "Chocolat chaud", value = "chocochaud", price =8},        
    },
    points = {
        vestiaire = vector3(-1463.389,-343.991,43.780),
        shop = vector3(62.763, -1728.57, 28.61),
        cuisine = vector3(-1466.796,-342.800,43.780),
        cuisine5 = vector3(-1466.79,-346.307,43.780)
    },
}

ConfigPopdinners = {
    cuisine = {
        {label = "Cornet de Frite", value = "frite"},
        {label = "Sandwich Némo", value = "nemo"},
        {label = "Sandwich Shark", value = "shark"},
        {label = "Sandwich Bambi", value = "bambi"},
        {label = "Sandwich King", value = "king"},
        {label = "HotDog", value = "hotdog"},
    },
    nourriture = {
        {label = "Pomme de terre", value = "potato", price =8},
        {label = "Pain", value = "bread", price =3},
        {label = "Salade", value = "pearl_salade", price =4},
        {label = "Steak Surgelé", value = "fburger", price =8},
        {label = "Fromage", value = "cheese", price =3},
        {label = "Tomates", value = "tomato", price =5},
        {label = "Poisson", value = "fish", price =8},
        {label = "Saucisse", value = "saucisse", price =8},
        {label = "Sauces", value = "sauces", price =4},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},

        
    },

    points = {
        vestiaire = vector3(1583.018,6460.617,25.014),
        shop = vector3(-59.144, 6524.251, 30.490),
        cuisine = vector3(1592.315,6456.063,25.015),
        cuisine1 = vector3(1587.87,6458.099,25.01)
    },
}
Configferme_o = {
    cuisine = {
        {label = "Steak surgelé", value = "steack"},
        {label = "Soupes aux légumes", value = "soupe"},
        {label = "Barquette de poireaux", value = "b_p"},
        {label = "Barquette de carottes", value = "b_c"},

    },
    nourriture = {
        {label = "Cagette en bois", value = "barquette", price =5},
        {label = "Bocaux", value = "bocaux", price =5},
    },

    points = {
        {vestiaire = vector3(1785.26,4593.84,36.68)},
        {shop = vector3(-13.39684, 6480.395, 30.42)},
        {traitement = vector3(2569.980,4667.176,33.076)},
        {champ = vector3(2237.397,5047.421,44.27)},
        {champ_1 = vector3(2187.662,5177.129,56.79)},
        {champ_2 = vector3(2069.699,4919.748,40.02)},
        {Pos = vector3(2237.397,5047.421,44.27)},
        {Pos = vector3(2187.662,5177.129,56.79)},
        {Pos = vector3(2069.699,4919.748,40.02)},
        {Pos = vector3(-57.059,6522.217,30.49)},
        {vente = vector3(-57.059,6522.217,30.49)},


    },
    uniform ={
        male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] =  0,
                ['torso_1'] = 144,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 74,
                ['pants_1'] = 77,   ['pants_2'] = 0,
                ['shoes_1'] = 12,   ['shoes_2'] = 6,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 22,  ['tshirt_2'] =  4,
                ['torso_1'] = 25,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 12,
                ['pants_1'] = 10,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }

}

ConfigBahamas = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(-1367.82,-613.52,29.32)}       
    },
    chancecraft = 10
}
ConfigParadise = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(-2995.08, 40.88, 6.96)}       
    },
    chancecraft = 10
}
Configgalaxys = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(-1182.708,-1151.745,1.35)}       
    },
    chancecraft = 10
}
ConfigBlackwood = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(-302.38,6274.994,30.526)}       
    },
    chancecraft = 10
}

ConfigSteinway = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(1952.52,3831.14,34.50)}       
    },
    chancecraft = 10
}
ConfiYellowJack = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(2000.02, 3045.76, 46.21 )}       
    },
    chancecraft = 10
}
ConfigTequilala = {
    mixologie = {
        {label = "Jäger Bomb", value = "jagerbomb"},
        {label = "Golem", value = "golem"},
        {label = "Whisky Coca", value = "whiskycoca"},
        {label = "Rhum Coca", value = "rhumcoca"},
        {label = "Vodka Energy", value = "vodkaenergy"},
        {label = "Vodka Fruit", value = "vodkafruit"},
        {label = "Rhum Fruit", value = "rhumfruit"},
        {label = "TeqPaf", value = "teqpaf"},
        {label = "Mojito", value = "mojito"},
        {label = "Mix Apéro", value = "mixapero"},
        {label = "Mètre de shooters", value = "metreshooter"},
        {label = "Jäger Cerbere", value = "jagercerbere"},
    },
    points = {
        {vestiaire = vector3(-565.46, 279.709, 81.975 )}       
    },
    chancecraft = 10
}

ConfigBurgershot = {
    cuisine = {
      --{label = "Hamburger simple", value = 'shamburger'},
      --{label = "Hamburger complet", value = 'hamburger'},
      {label = "The Simply", value = 'simply'},
      {label = "The Prickly", value = 'prickly'},
      {label = "The Double Shot", value = 'doubleshot'},
      {label = "The Glorious", value = 'glorious'},
      {label = "The Bleeder", value = 'bleeder'},
      {label = "Heart Stopper", value = 'heartstopper'},
      {label = "Chicken Mexicain", value = 'tacosmex'},
      {label = "Chicken Wrap", value = 'chickenwrap'},
      {label = "Goat Cheese Wrap", value = 'goatwrap'},
      {label = "Cornet de frite", value = 'fritebs'},
    },
    nourriture = {
        {label = "Salade", value = "clettuce", price =3},
        {label = "Tomate", value = "ctomato", price =3},
        {label = "Fromage", value = "ccheese", price =4},
        {label = "Pomme de terre", value = "potato", price =3},
        {label = "Steack cru", value = "fburger", price =6},
        {label = "Poulet", value = "fvburger", price =6},
        {label = "Pain", value = "bread", price =4},
        {label = "Galette", value = "wrap", price =4},
        {label = "Fromage de chèvre", value = "ccheesegoat", price =4},
        {label = "Glace Chocolat", value = "icechoco", price =4},
        {label = "Glace Vanille", value = "icevanille", price =4},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
        {label = "Boissons Burger Shot", value = "boissonsbs", price =8},
    },
    points = {
        vestiaire = vector3(-1181.348,-900.476,12.97),
        shop = vector3(28.51, -1769.771, 28.58),
        cuisine = vector3(-1197.649,-897.405,12.97),
        cuisine1 = vector3(-1196.42,-900.251,12.97)

    },
}
ConfigCoffeeshop = {
    cuisine = {
      {label = "Pochon Harlequin", value = 'pch'},
      {label = "Pochon White Widow", value = 'pcww'},
      {label = "Pochon Skunk", value = 'pcsk'},
      {label = "Pochon Haze", value = 'pchz'},
      {label = "Pochon WhiteBud", value = 'pcwb'},
      {label = "Pochon LDW", value = 'pcldw'},
      {label = "Brownie au chocolat", value = 'brownie'},
      {label = "Cake à la banane", value = 'cake'},
      {label = "Pancake au sirop d’érable", value = 'pancake'},
      {label = "Space-Brownie", value = 'spaceb'},
      {label = "Space-Cake", value = 'spacec'},
      {label = "Space-Pancake", value = 'spacep'},
      {label = "Space-Coffee", value = 'spaceco'},
      {label = "Space-Tea", value = 'spacet'},
      {label = "Joint pure Harlequin", value = 'jointH'},
      {label = "Joint pure White Widow", value = 'JointWW'},
      {label = "Joint pure Haze", value = 'JointHaze'},
      {label = "Joint pure WhiteBud", value = 'JointWB'},
      {label = "Joint pure LDW", value = 'JointLDW'},
      {label = "Joint pure Skunk", value = 'JointSkunk'},
      {label = "Joint CBD", value = 'JointCBD'},
    },
    nourriture = {        
        {label = "Feuilles OCB (pack)", value = "ocb_paperpack", price =50},
        {label = "Sac de conservation", value = "sac_conservation", price =1},
        {label = "Préparation à gâteau", value = "prepa_gateau", price =3},
        {label = "Love 66", value = "love66", price =6},
        {label = "Hawaï", value = "hawai", price =6},
        {label = "Lady Killer", value = "ladykiller", price =6},
        {label = "Red Mix", value = "redmix", price =6},
        {label = "Fresh Coco", value = "freshcoco", price =6},
        {label = "Bang", value = "bang", price =15},
        {label = "Chicha", value = "hookah", price =25},
    },
    boisson = {
        {label = "Crush Orange", value = "crush_orange", price =8},
        {label = "Crush Raisin", value = "crush_raisin", price =8},
        {label = "Dr.Pepper", value = "drpepper", price =8},
        {label = "Energy Drink", value = "energy", price =8},
        {label = "Ice Tea", value = "icetea", price =8},
        {label = "Pepsi", value = "pepsi", price =8},
        {label = "Café", value = "cafe", price =8},
        {label = "Thé", value = "the", price =8},
        {label = "Bouteille D'eau", value = "water", price =8},
        {label = "Boissons Burger Shot", value = "boissonsbs", price =8},
    },
    points = {
        vestiaire = vector3(-1338.19,-1239.97,5.00),
        shop = vector3(45.973, -1749.077, 28.62),
        recolte = vector3(-1338.87,-1237.824,8.72),
        cuisine = vector3(-1344.285,-1220.814,8.72),
        cuisine1 = vector3(-1342.88,-1220.115,8.72)
    },
    workszone = {
        {pos = vector3(-1338.176,-1218.496,8.720),Heading = 321.24,anim = "e mechanic3"},
        {pos = vector3(-1337.002,-1220.511,8.720),Heading = 321.24,anim = "e mechanic3"},
        {pos = vector3(-1336.046,-1223.218,8.720),Heading = 321.24,anim = "e mechanic3"},
        {pos = vector3(-1338.221,-1224.265,8.720),Heading = 321.24,anim = "e mechanic3"},
        {pos = vector3(-1338.203,-1221.814,8.720),Heading = 321.24,anim = "e mechanic3"}
    },
}

ConfigVignoble = {
    points = {
        {vestiaire = vector3(-1874.65, 2053.71, 140.06)},
        {champ = vector3(-1859.31, 2245.89, 83.25)},
        {champ_1 = vector3(-1770.94, 2249.71, 85.50)},
        {champ_2 = vector3(-1867.02, 2191.57, 105.20)},
        {champ_3 = vector3(-1754.98, 2174.22, 114.30)},
        {traitement = vector3(-1930.73, 2055.15, 139.81)},
        {traitement_1 = vector3(162.87, 2286.69, 93.15)},
        {traitement_2 = vector3(161.7515, 2282.72, 92.93)},
        {vente = vector3(1036.54, -2111.41, 31.59)},
        {vente_1 = vector3(1040.10, -2115.59, 31.59)},
        {Pos = vector3(-1859.31, 2245.89, 83.25)},--champs 11
        {Pos = vector3(-1770.94, 2249.71, 85.50)},--champs 12 
        {Pos = vector3(-1867.02, 2191.57, 105.20)},--champs 13
        {Pos = vector3(-1754.98, 2174.22, 114.30)},--champs 14
        {Pos = vector3(-1930.73, 2055.15, 139.81)},--traitement 15
        {Pos = vector3(162.87, 2286.69, 93.15)},--traitement 16
        {Pos = vector3(161.7515, 2282.72, 92.93)}, --traitement 17
        {Pos = vector3(1036.54, -2111.41, 31.59)},--traitement 18
        {Pos = vector3(1040.10, -2115.59, 31.59)},--traitement 19
    },
}

ConfigDistillerie = {
    points = {
        {vestiaire = vector3(88.76, 6348.53, 31.74)},
        {champ = vector3(2642.05, 4751.36, 34.70)},
        {champ_1 = vector3(1763.42, 4991.03, 50.560)},
        {champ_2 = vector3(1844.14, 4809.24, 43.5 )},
        {champ_3 = vector3(543.02, 6500.23, 29.93)},        
        {traitement = vector3(107.144, 6342.194, 31.74)},
        {traitement_1 = vector3(105.799, 6345.187, 31.74)},
        {traitement_2 = vector3(104.261, 6348.366, 31.74)},
        {vente = vector3(-239.99, -224.23, 36.51)},
        {vente_1 = vector3(-239.99, -224.23, -136.51)},
        {Pos = vector3(2642.05, 4751.36, 34.70)},--champs 11
        {Pos = vector3(1763.42, 4991.03, 50.560)},--champs 12 
        {Pos = vector3(1844.14, 4809.24, 43.5)},--champs 13
        {Pos = vector3(543.02, 6500.23, 29.93)},--champs 14
        {Pos = vector3(107.144, 6342.194, 31.74)},--traitement 15
        {Pos = vector3(105.799, 6345.187, 31.74)},--traitement 16
        {Pos = vector3(104.261, 6348.366, 31.74)}, --traitement 17
        {Pos = vector3(-239.99, -224.23, 36.51)},--vente 18
        {Pos = vector3(-239.99, -224.23, -136.51)},--vente 19
        {champ_4 = vector3(1961.00, 5185.02, 47.94)},
        {Pos = vector3(1961.00, 5185.02, 47.94)},--champ_4 21
    },
    uniform ={
        male = {
             ['tshirt_1'] = 69,   ['tshirt_2'] = 0,
            ['torso_1'] = 144,    ['torso_2'] = 0,
            ['decals_1'] = 0,    ['decals_2'] = 0,
            ['arms'] = 74,
            ['pants_1'] = 117,    ['pants_2'] = 3,
            ['shoes_1'] = 65,    ['shoes_2'] = 0,
            ['chain_1'] = 0,     ['chain_2'] = 0,
            ['helmet_1'] = 0,   ['helmet_2'] = 0,
            ['bags_1'] = 51
        },
        female = {
            ['tshirt_1'] = 232,  ['tshirt_2'] = 0,
            ['torso_1'] = 469,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 76,
            ['pants_1'] = 174,   ['pants_2'] = 0,
            ['shoes_1'] = 120,   ['shoes_2'] = 6,
            ['chain_1'] = 146,  ['chain_2'] = 0,
            ['bags_1'] = 51,    ['glasses_1'] = 5
        }
    }
}

Configbrasseur = {
    points = {
        {vestiaire = vector3(-65.50, 6440.29, 31.50)},
        {champ = vector3(517.95, 6489.69, 30.27)},
        {champ_1 = vector3(517.81, 6480.06, 30.27)},
        {champ_2 = vector3(517.69, 6466.60, 30.27 )},
        {champ_3 = vector3(543.47, 6500.13, 29.92)}, 
        {champ_4 = vector3(526.27, 6507.63, 29.56)}, 

        {traitement = vector3(-54.98, 6429.77, 32.69)},
        {traitement_1 = vector3(-57.16,  6433.12,  33.16)},
        {vente = vector3(-239.99, -224.23, 36.51)},
        {vente_1 = vector3(-239.99, -224.23, -136.51)},

        {Pos = vector3(517.95, 6489.69, 30.27)},--champs 11
        {Pos = vector3(517.81, 6480.06, 30.27)},--champs 12 
        {Pos = vector3(517.69, 6466.60, 30.27)},--champs 13
        {Pos = vector3(543.47, 6500.13, 29.92)},--champs 14
        {Pos = vector3(526.27, 6507.63, 29.56)},--champs 15

        {Pos = vector3(-54.98, 6429.77, 32.69)},--traitement 16
        {Pos = vector3(-57.16,  6433.12,  33.16)}, --traitement 17

        {Pos = vector3(-239.99, -224.23, 36.51)},--vente 18
        {Pos = vector3(-239.99, -224.23, -136.51)}--vente 19
    },
    uniform ={
        male = {
             ['tshirt_1'] = 69,   ['tshirt_2'] = 0,
            ['torso_1'] = 144,    ['torso_2'] = 0,
            ['decals_1'] = 0,    ['decals_2'] = 0,
            ['arms'] = 74,
            ['pants_1'] = 117,    ['pants_2'] = 3,
            ['shoes_1'] = 65,    ['shoes_2'] = 0,
            ['chain_1'] = 0,     ['chain_2'] = 0,
            ['helmet_1'] = 0,   ['helmet_2'] = 0,
            ['bags_1'] = 51
        },
        female = {
            ['tshirt_1'] = 232,  ['tshirt_2'] = 0,
            ['torso_1'] = 469,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 76,
            ['pants_1'] = 174,   ['pants_2'] = 0,
            ['shoes_1'] = 120,   ['shoes_2'] = 6,
            ['chain_1'] = 146,  ['chain_2'] = 0,
            ['bags_1'] = 51,    ['glasses_1'] = 5
        }
    }
}

ConfigRanch = {
    points = {
        {vestiaire = vector3(1542.871, 2221.411, 77.768)},
        {champ = vector3(986.983, -2180.966, 30.051)},
        {champ_1 = vector3(1220.97, 1897.56, 77.93)},
        {champ_2 = vector3(851.96, 2131.92, 52.28)},
        {traitement = vector3(1554.816, 2183.381, 78.913)},
        {traitement_1 = vector3(1551.804, 2163.853, 78.943)},
        {traitement_2 = vector3(1542.59, 2178.86, 78.81)},
        {vente = vector3(2467.41, 4100.94, 38.06)},
        {vente_1 = vector3(1040.10, -2115.59, 31.59)},
        {Pos = vector3(986.983, -2180.966, 30.051)},--champs 10
        {Pos = vector3(1220.97, 1897.56, 77.93)},--champs 11 
        {Pos = vector3(851.96, 2131.92, 52.28)},--champs 12
        {Pos = vector3(1554.816, 2183.381, 78.913)},--traitement 13
        {Pos = vector3(1551.804, 2163.853, 78.943)},--traitement 14
        {Pos = vector3(1542.59, 2178.86, 78.81)}, --traitement 15
        {Pos = vector3(2467.41, 4100.94, 38.06)},--vente 16
        {Pos = vector3(1040.10, -2115.59, 31.59)},--vente 17

    },
    uniform ={
        male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] =  0,
                ['torso_1'] = 343,   ['torso_2'] = 5,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 160,   ['pants_2'] = 1,
                ['shoes_1'] = 63,   ['shoes_2'] = 0,
                ['bags_1'] = 92,  ['bags_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 22,  ['tshirt_2'] =  4,
                ['torso_1'] = 25,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 12,
                ['pants_1'] = 10,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }
}

ConfigTabac = {
    points = {
        {vestiaire = vector3(2896.27, 4419.62, 50.28)},
        {champ = vector3(2241.65, 4777.55, 40.13)},
        {traitement = vector3(2886.13, 4506.14, 47.50)},
        {traitement_1 = vector3(2919.96, 4478.39, 47.50)},
        {vente = vector3(473.160, -1952.310, 24.57)},
        {Pos = vector3(2241.65, 4777.55, 40.13)},--champs 11
        {Pos = vector3(2886.13, 4506.14, 47.50)},--traitement 12
        {Pos = vector3(2919.96, 4478.39, 47.50)},--traitement 13
        {Pos = vector3(473.160, -1952.310, 24.57)},--traitement 14
    },
    uniform ={
        male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] =  0,
                ['torso_1'] = 343,   ['torso_2'] = 5,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 160,   ['pants_2'] = 1,
                ['shoes_1'] = 63,   ['shoes_2'] = 0,
                ['bags_1'] = 92,  ['bags_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 22,  ['tshirt_2'] =  4,
                ['torso_1'] = 25,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 12,
                ['pants_1'] = 10,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }
}

Configforge = {
    points = {
        {vestiaire = vector3(2702.339, 2774.945, 37.87)},
        {champ = vector3(2937.59, 2794.61, 40.58)},
        {champ1 = vector3(2945.93, 2801.61, 41.20)},
        {champ2 = vector3(2932.79, 2795.27, 40.68)},
        {traitement = vector3(286.750, 2843.975,  44.00)},
        {traitement_1 = vector3(1068.136, -2004.624,32.08)},
        {vente = vector3(-630.548, -229.059, 37.85)},
        {Pos = vector3(2937.59, 2794.61, 40.58)},--champs 8
        {Pos = vector3(2945.93, 2801.61, 41.20)},--champs 9
        {Pos = vector3(2932.79, 2795.27, 40.68)},--champs 10
        {Pos = vector3(286.750, 2843.975,  43.704)},--traitement 11
        {Pos = vector3(1068.136, -2004.624,32.08)},--traitement 12
        {Pos = vector3(-630.548, -229.059, 37.05)},--vente 13
    },
    uniform ={
        male = {
                ['tshirt_1'] = 74,  ['tshirt_2'] =  0,
                ['torso_1'] = 5,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['helmet_1'] = 0,   ['helmet_2'] = 0,
                ['bags_1'] = 0,   ['bags_2'] = 0,
                ['arms'] = 5,
                ['pants_1'] = 49,   ['pants_2'] = 0,
                ['shoes_1'] = 134,   ['shoes_2'] = 0,
                ['bags_1'] = 92,  ['bags_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 0,  ['tshirt_2'] =  0,
                ['torso_1'] = 56,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['helmet_1'] = 11,   ['helmet_2'] = 0,
                ['bags_1'] = 0,   ['bags_2'] = 0,
                ['arms'] = 63,
                ['pants_1'] = 36,   ['pants_2'] = 0,
                ['shoes_1'] = 27,   ['shoes_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }
}

ConfigChicken = {
    points = {
        {vestiaire = vector3(-75.61, 6250.65, 31.08)},
        {champ = vector3(2553.81, 4669.04, 33.98)},
        {traitement = vector3(-83.62, 6226.13, 31.09)},
        {traitement_1 = vector3(-101.52, 6208.44, 31.09)},
        {vente = vector3(-3169.523, 1034.65, 20.8388)},
        {Pos = vector3(2553.81, 4669.04, 33.98)},--champs 6
        {Pos = vector3(-83.62, 6226.13, 31.09)},--traitement 7
        {Pos = vector3(-101.52, 6208.44, 31.09)},--traitement 8
        {Pos = vector3(-3169.523, 1034.65, 20.8388)},--vente 9
    },
    uniform ={
        male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] =  0,
                ['torso_1'] = 144,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 79,   ['pants_2'] = 4,
                ['shoes_1'] = 135,   ['shoes_2'] = 0,
                ['bags_1'] = 92,  ['bags_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 0,  ['tshirt_2'] =  0,
                ['torso_1'] = 56,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 12,
                ['pants_1'] = 36,   ['pants_2'] = 0,
                ['shoes_1'] = 27,   ['shoes_2'] = 0,
                ['helmet_1'] = 11,   ['helmet_2'] = 0,
                ['bags_1'] = 0,   ['bags_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }
}

ConfigGouv = {

    points = {
        {vestiaire = vector3(-574.2808, -213.7366, 41.83658)}
    },

    uniform ={
        male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] =  0,
                ['torso_1'] = 144,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 74,
                ['pants_1'] = 77,   ['pants_2'] = 0,
                ['shoes_1'] = 12,   ['shoes_2'] = 6,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 22,  ['tshirt_2'] =  4,
                ['torso_1'] = 25,   ['torso_2'] = 4,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 12,
                ['pants_1'] = 10,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 11,  ['chain_2'] = 2
        },
    }
}

--Blackmarket
ConfigBlackmarket = {

    items = {
        {nom = "Disqueuse", arme = "disqueuse", prix = 2500},
        {nom = "Tenue Hazmat (noir)", arme = "hazmat", prix = 1500},
        {nom = "Jumelles", arme = "jumelles", prix = 100},
        {nom = "Ordinateur de Hack", arme = "laptop_h", prix = 2500},
        {nom = "Explosif", arme = "atm_explosive", prix = 500},
        {nom = "Clef encryptée", arme = "decryptionkey3", prix = 500},
        {nom = "Carte Gruppe 6", arme = "securitygreen", prix = 3500},
        {nom = "Tenue Hazmat (jaune)", arme = "hazmat1", prix = 1500},
        {nom = "Waze radar", arme = "waze", prix = 1500},
        {nom = "Crochet Menottes", arme = "crochet", prix = 500},
        {nom = "Menottes", arme = "menottes", prix = 250},
        {nom = "Carte Fleeca", arme = "id_card_f", prix = 350},
        {nom = "Carte Sécurisé", arme = "secure_card", prix = 350},
        {nom = "Lockpick", arme = "lockpick", prix = 50},
        {nom = "Charge Thermique", arme = "thermal_charge", prix = 5000},
        {nom = "Cagoule", arme = "headbag", prix = 100},
        {nom = "Spray", arme = "spray", prix = 1000},        
        {nom = "Boîte Munition SMG", arme = "smg_ammo_box", prix = 500},
        {nom = "Boite Munition fusil assaut", arme = "rifle_ammo_box", prix = 1200},
        {nom = "Boite Munition Pistolet", arme = "pistol_ammo_box", prix = 600},
        {nom = "Boîte de Cal.12", arme = "shotgun_ammo_box", prix = 750},
        {nom = "Sniper Munition" , arme = "sniper_ammo", prix = 2000},
    },

    pos = vector3(3831.04, 4440.29, 2.81) 
}

--PAWNSHOP
ConfigPawn = {}
ConfigPawn.MenuAlign = "top-left"
ConfigPawn.PawnshopItems = {
    gps = 50,
    livre = 15,
    stylo = 5,
    fourchette = 5,
    cuillere = 5,
    paquet_mouchoir = 2,
    tournevis = 5,
    nokia3310 = 35,
    magasine_porno = 5,
    montre = 125,
    pcportable = 400,
    ps5 = 350,
    Xbox = 300,
    collier = 550,
    chevaliere = 550,
    boucle_orreille = 600,
    diamond = 1200,
    ecrou = 1,
    vis = 1,
    morceau_fer = 1,
    morceau_alu = 1
}
ConfigPawn.GiveBlack = true -- give black money? if disabled it'll give regular cash.
ConfigPawn.PawnshopLocation =  {x = 1011.13, y = -2873.66, z = 38.16}
ConfigPawn.EnableOpeningHours = true -- Enable opening hours? If disabled you can always open the pawnshop.
ConfigPawn.OpenHour = 18 -- From what hour should the pawnshop be open?
ConfigPawn.CloseHour = 12 -- From what hour should the pawnshop be closed?
--PAWNSHOP

ConfigMechanic = {

    points = {
        vestiaire = vector3(-212.81, -1331.43, 23.14),
        craft = vector3(-199.350, -1315.686, 31.089),
        shop = vector3(-677.139, -2459.324, 13.944),
        craft1 = vector3(-240.96, -1327.016, 30.90)

    },
    outil = {        
        {label = "Kit de crochetage", value = "kitcroche", price =100},
    },
    moteur = {        
        {label = "Moteur Stock", value = "stock_engine", price =14000},
        {label = "Moteur 2JZ", value = "2jzengine", price =35000},
        {label = "Moteur V6", value = "v6engine", price =25000},
        {label = "Moteur V8", value = "v8engine", price =30000},

    },
    boite = {        
        {label = "Transmission stock", value = "stock_transmission", price =10000},
        {label = "Transmission RWD", value = "race_transmission", price =15000},
        {label = "Transmission 4WD", value = "race_transmission_4wd", price =20000},
        {label = "Transmission FWD", value = "race_transmission_fwd", price =15000},

    },
    pneu = {
        {label = "Stock Tires", value = "stock_tires", price =500},
        {label = "Pneu Michelin", value = "michelin_tires", price =1500},

    },
    suspension = {
        {label = "Suspension stock", value = "stock_suspension", price =3500},
        {label = "Suspension course", value = "race_suspension", price =5000},
    },
    bougie = {
        {label = "Bougies Stock", value = "stock_sparkplugs", price =40},
        {label = "Bougies NGK", value = "ngk_sparkplugs", price =120},
    },
    huile = {
        {label = "Huile Stock", value = "stock_oil", price =100},
        {label = "Huile Shell", value = "shell_oil", price =150},
    },
    frein = {
        {label = "Freins Stock", value = "stock_brakes", price =8500},
        {label = "Freins course", value = "race_brakes", price =15000},

    },
    turbo = {
        {label = "Turbo Standard", value = "stock_turbo", price =7500},
        {label = "GARETT Turbo", value = "turbo_lvl_1", price =15000},
        {label = "KKK Turbo", value = "turbo_lvl_2", price =25000},

    },
    piece = {   
        {label = "Repairkit", value = "repairkit", price =150},
        {label = "Kit de Nettoyage", value = "kitnet", price =150},      
        {label = "Caisse mécano", value = "mechanic_tools", price =50},
        {label = "Bielle", value = "bielles", price =500},
        {label = "Champignon pneu", value = "champignonpneu", price =50},
        {label = "Chemise", value = "chemises", price =500},
        {label = "CHRA Eisen", value = "chra1", price =250},
        {label = "CHRA Einhell", value = "chra2", price =500},
        {label = "CHRA KKK", value = "chra3", price =750},        
        {label = "Coupelle", value = "coupellessusp", price =150},
        {label = "Kit Distribution", value = "distribution", price =500},
        {label = "Huile TRW", value = "huiletransmission", price =50},       
        {label = "Piston", value = "piston", price =500},
        {label = "Planetaire", value = "planetaire", price =500},
        {label = "Plaquettes freins", value = "plaquettefrein", price =200},
        {label = "Ressort", value = "ressortsusp", price =350},
        {label = "Volant Moteur", value = "volantm", price =250},
    },
    uniform ={
        male = {
                ['tshirt_1'] = 170,  ['tshirt_2'] =  0,
                ['torso_1'] = 167,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 69,   ['pants_2'] = 1,
                ['shoes_1'] = 7,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 96,  ['tshirt_2'] =  0,
                ['torso_1'] = 229,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 4,   ['pants_2'] = 0,
                ['shoes_1'] = 33,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0
        },
    },
    Props = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
            },
    ["Kit"] = {
                            RandomPos = {
                                {pos = vector3(-421.0725, -1711.332, 19.44624), marker = 1},
                                {pos = vector3(1071.378, -1954.675, 31.01424), marker = 2},
                                {pos = vector3(1282.257, -2558.783, 43.82122), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(649.6512, 246.419, 103.4239)},
                                {pos = vector3(-372.2838, 194.2171, 84.06175)},
                                {pos = vector3(-1349.485, -760.427, 22.45949)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                   {pos = vector3(-422.6056, -1720.776, 19.34138), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-432.4007, -1716.573, 19.02037), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-424.7239, -1702.372, 19.13883), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-442.5357, -1709.676, 18.81032), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-427.7648, -1722.837, 19.09597), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-447.4926, -1710.009, 18.75542), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-454.721, -1694.33, 19.12934), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-460.8257, -1701.962, 18.83744), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-433.8107, -1696.845, 18.97789), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(1078.205, -1954.091, 31.03113), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.863, -1945.098, 31.15836), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1075.195, -1942.649, 31.06912), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1070.357, -1943.969, 31.01718), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.019, -1960.49, 31.01425), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1083.085, -1967.218, 31.01464), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1085.712, -1974.577, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1089.337, -1972.286, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1067.682, -1949.054, 31.0154), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(1290.482, -2560.956, 44.10447), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1287.365, -2564.047, 44.32512), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1280.803, -2562.81, 43.83899), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1273.019, -2557.589, 43.02376), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1274.929, -2562.517, 43.33635), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1263.441, -2570.566, 43.06508), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1257.932, -2571.241, 42.71659), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1254.068, -2564.189, 42.71593), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1252.836, -2572.677, 42.7176), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                        },
    ["Outils"] = {
                            RandomPos = {
                                {pos = vector3(1538.487, -2090.507, 77.06601), marker = 1},
                                {pos = vector3(830.6019, -792.2642, 26.25615), marker = 2},
                                {pos = vector3(-607.7554, -1791.797, 23.58924), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(-1014.476, -1514.375, 6.519115)},
                                {pos = vector3(719.1, -2102.802, 29.64572)},
                                {pos = vector3(1193.902, -1248.165, 35.36293)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                    {pos = vector3(1552.609, -2079.08, 77.09324), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1553.592, -2092.192, 77.1666), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1541.18, -2108.49, 77.15497), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1538.582, -2110.899, 77.00853), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1535.126, -2127.014, 76.90005), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1513.789, -2123.29, 76.29295), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1517.657, -2095.278, 76.91996), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1512.037, -2100.095, 76.7349), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(826.1683, -797.3613, 26.19792), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(823.3937, -800.4865, 26.38397), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(824.2275, -794.3958, 26.33616), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(822.5736, -778.2212, 26.17545), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(828.5271, -773.1341, 26.22028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(837.7119, -800.3875, 26.27251), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(836.3965, -806.6812, 26.28794), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(-611.3302, -1787.671, 23.68258), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-617.0615, -1790.3, 23.71638), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-603.3737, -1789.386, 23.71678), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(-601.5659, -1783.068, 23.63999), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-597.7784, -1777.64, 23.21074), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-593.2486, -1780.056, 22.8525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                 },
                            },
                        },
}

Configmechanic2 = {

    points = {
        vestiaire = vector3(11.69,6459.81,31.58),
        craft = vector3(47.41,6467.94,31.42),
        shop = vector3(1695.294, 6430.292, 32.667),
        craft1 = vector3(22.49,6464.59,31.49)

    },
    outil = {        
        {label = "Kit de crochetage", value = "kitcroche", price =100},
    },
     moteur = {        
        {label = "Moteur Stock", value = "stock_engine", price =14000},
        {label = "Moteur 2JZ", value = "2jzengine", price =35000},
        {label = "Moteur V6", value = "v6engine", price =25000},
        {label = "Moteur V8", value = "v8engine", price =30000},

    },
    boite = {        
        {label = "Transmission stock", value = "stock_transmission", price =10000},
        {label = "Transmission RWD", value = "race_transmission", price =15000},
        {label = "Transmission 4WD", value = "race_transmission_4wd", price =20000},
        {label = "Transmission FWD", value = "race_transmission_fwd", price =15000},

    },
    pneu = {
        {label = "Stock Tires", value = "stock_tires", price =500},
        {label = "Pneu Michelin", value = "michelin_tires", price =1500},

    },
    suspension = {
        {label = "Suspension stock", value = "stock_suspension", price =3500},
        {label = "Suspension course", value = "race_suspension", price =5000},
    },
    bougie = {
        {label = "Bougies Stock", value = "stock_sparkplugs", price =40},
        {label = "Bougies NGK", value = "ngk_sparkplugs", price =120},
    },
    huile = {
        {label = "Huile Stock", value = "stock_oil", price =100},
        {label = "Huile Shell", value = "shell_oil", price =150},
    },
    frein = {
        {label = "Freins Stock", value = "stock_brakes", price =8500},
        {label = "Freins course", value = "race_brakes", price =15000},

    },
    turbo = {
        {label = "Turbo Standard", value = "stock_turbo", price =7500},
        {label = "GARETT Turbo", value = "turbo_lvl_1", price =15000},
        {label = "KKK Turbo", value = "turbo_lvl_2", price =25000},

    },
    piece = { 
        {label = "Repairkit", value = "repairkit", price =150},
        {label = "Kit de Nettoyage", value = "kitnet", price =150},        
        {label = "Caisse mécano", value = "mechanic_tools", price =50},
        {label = "Bielle", value = "bielles", price =500},
        {label = "Champignon pneu", value = "champignonpneu", price =50},
        {label = "Chemise", value = "chemises", price =500},
        {label = "CHRA Eisen", value = "chra1", price =250},
        {label = "CHRA Einhell", value = "chra2", price =500},
        {label = "CHRA KKK", value = "chra3", price =750},        
        {label = "Coupelle", value = "coupellessusp", price =150},
        {label = "Kit Distribution", value = "distribution", price =500},
        {label = "Huile TRW", value = "huiletransmission", price =50},       
        {label = "Piston", value = "piston", price =500},
        {label = "Planetaire", value = "planetaire", price =500},
        {label = "Plaquettes freins", value = "plaquettefrein", price =200},
        {label = "Ressort", value = "ressortsusp", price =350},
        {label = "Volant Moteur", value = "volantm", price =250},
    },
    uniform ={
        male = {
                ['tshirt_1'] = 170,  ['tshirt_2'] =  0,
                ['torso_1'] = 167,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 69,   ['pants_2'] = 1,
                ['shoes_1'] = 7,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 96,  ['tshirt_2'] =  0,
                ['torso_1'] = 229,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 4,   ['pants_2'] = 0,
                ['shoes_1'] = 33,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0
        },
    },
    Props = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
            },
    ["Kit"] = {
                            RandomPos = {
                                {pos = vector3(2133.243, 4783.883, 40.97028), marker = 1},
                                {pos = vector3(303.6764, 2833.965, 43.4451), marker = 2},
                                {pos = vector3(851.627, 2161.864, 52.26286), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(803.1234, 2174.746, 53.07085)},
                                {pos = vector3(620.423, 2800.427, 41.94175)},
                                {pos = vector3(1738.525, 3028.899, 63.14882)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                   {pos = vector3(2126.1, 4774.92, 40.97028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(2129.813, 4773.582, 40.97028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(2127.775, 4769.252, 40.97029), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(2138.596, 4771.518, 41.01968), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(2143.295, 4771.974, 41.05291), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(2141.526, 4776.938, 40.97134), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(2145.484, 4776.734, 40.97237), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(2141.635, 4789.21, 40.97033), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(2142.038, 4775.925, 40.97028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(311.6429, 2820.913, 43.43736), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(306.4899, 2821.135, 43.44664), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(297.9877, 2815.559, 43.43645), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(295.4817, 2820.449, 43.43605), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(289.7449, 2819.811, 43.43525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(287.3185, 2823.354, 44.97559), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(290.5955, 2826.411, 43.43604), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(287.8481, 2837.344, 43.54416), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(284.7073, 2841.741, 43.64242), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(852.8259, 2165.624, 52.27988), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(855.3129, 2165.035, 52.27939), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(841.1766, 2168.089, 52.2817), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(838.834, 2162.151, 52.31635), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(836.3207, 2167.6, 52.27772), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(835.0413, 2177.595, 52.31567), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(841.7034, 2174.639, 52.2804), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(826.9197, 2174.073, 52.27336), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(852.3455, 2169.953, 52.27988), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                        },
                        ["Outils"] = {
                            RandomPos = {
                                {pos = vector3(190.6401, 2796.6, 45.65519), marker = 1},
                                {pos = vector3(364.4759, 3411.955, 36.3857), marker = 2},
                                {pos = vector3(88.20467, 6519.218, 31.32419), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(2403.486, 3127.828, 48.15289)},
                                {pos = vector3(2662.356, 3468.164, 55.93456)},
                                {pos = vector3(2455.361, 4058.356, 38.06467)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                    {pos = vector3(182.6561, 2797.049, 45.65517), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(181.6845, 2802.264, 45.65517), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(197.4321, 2804.166, 45.65518), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "aluminium"},
                                    {pos = vector3(213.2856, 2806.511, 45.65518), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(211.5017, 2796.903, 45.65518), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(202.5272, 2781.181, 45.65525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "aluminium"},
                                    {pos = vector3(211.8693, 2780.224, 45.65527), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(372.1011, 3414.344, 36.40862), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(376.7895, 3409.547, 36.40523), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(380.1907, 3406.686, 36.4057), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "aluminium"},
                                    {pos = vector3(359.7986, 3404.91, 36.4035), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(353.2856, 3407.505, 36.40799), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(361.4257, 3401.055, 36.40355), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "aluminium"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(97.94817, 6518.157, 31.28429), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(100.067, 6522.307, 31.27663), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(100.8219, 6510.899, 31.50574), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(80.98336, 6491.131, 31.37011), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(84.9249, 6490.867, 31.65895), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(59.75193, 6500.743, 31.69661), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(52.6997, 6506.875, 31.4254), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(50.2016, 6514.452, 31.50449), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                 },
                            },
                        },
}

Configmechanic3 = {

    points = {
        vestiaire = vector3(-349.8613, -123.6246, 39.053),
        craft = vector3(-346.1288, -128.609, 39.00973),
        shop = vector3(-677.139, -2459.324, 13.944),
        craft1 = vector3(-320.2317, -120.4783, 39.00969)

    },
    outil = {        
        {label = "Kit de crochetage", value = "kitcroche", price =100},
    },
     moteur = {        
        {label = "Moteur Stock", value = "stock_engine", price =14000},
        {label = "Moteur 2JZ", value = "2jzengine", price =35000},
        {label = "Moteur V6", value = "v6engine", price =25000},
        {label = "Moteur V8", value = "v8engine", price =30000},

    },
    boite = {        
        {label = "Transmission stock", value = "stock_transmission", price =10000},
        {label = "Transmission RWD", value = "race_transmission", price =15000},
        {label = "Transmission 4WD", value = "race_transmission_4wd", price =20000},
        {label = "Transmission FWD", value = "race_transmission_fwd", price =15000},

    },
    pneu = {
        {label = "Stock Tires", value = "stock_tires", price =500},
        {label = "Pneu Michelin", value = "michelin_tires", price =1500},

    },
    suspension = {
        {label = "Suspension stock", value = "stock_suspension", price =3500},
        {label = "Suspension course", value = "race_suspension", price =5000},
    },
    bougie = {
        {label = "Bougies Stock", value = "stock_sparkplugs", price =40},
        {label = "Bougies NGK", value = "ngk_sparkplugs", price =120},
    },
    huile = {
        {label = "Huile Stock", value = "stock_oil", price =100},
        {label = "Huile Shell", value = "shell_oil", price =150},
    },
    frein = {
        {label = "Freins Stock", value = "stock_brakes", price =8500},
        {label = "Freins course", value = "race_brakes", price =15000},

    },
    turbo = {
        {label = "Turbo Standard", value = "stock_turbo", price =7500},
        {label = "GARETT Turbo", value = "turbo_lvl_1", price =15000},
        {label = "KKK Turbo", value = "turbo_lvl_2", price =25000},

    },
    piece = {   
        {label = "Repairkit", value = "repairkit", price =150},
        {label = "Kit de Nettoyage", value = "kitnet", price =150},     
        {label = "Caisse mécano", value = "mechanic_tools", price =50},
        {label = "Bielle", value = "bielles", price =500},
        {label = "Champignon pneu", value = "champignonpneu", price =50},
        {label = "Chemise", value = "chemises", price =500},
        {label = "CHRA Eisen", value = "chra1", price =250},
        {label = "CHRA Einhell", value = "chra2", price =500},
        {label = "CHRA KKK", value = "chra3", price =750},        
        {label = "Coupelle", value = "coupellessusp", price =150},
        {label = "Kit Distribution", value = "distribution", price =500},
        {label = "Huile TRW", value = "huiletransmission", price =50},       
        {label = "Piston", value = "piston", price =500},
        {label = "Planetaire", value = "planetaire", price =500},
        {label = "Plaquettes freins", value = "plaquettefrein", price =200},
        {label = "Ressort", value = "ressortsusp", price =350},
        {label = "Volant Moteur", value = "volantm", price =250},
    },
    uniform ={
        male = {
                ['tshirt_1'] = 170,  ['tshirt_2'] =  0,
                ['torso_1'] = 167,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 69,   ['pants_2'] = 1,
                ['shoes_1'] = 7,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 96,  ['tshirt_2'] =  0,
                ['torso_1'] = 229,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 4,   ['pants_2'] = 0,
                ['shoes_1'] = 33,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0
        },
    },
    Props = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
            },
    ["Kit"] = {
                            RandomPos = {
                                {pos = vector3(-421.0725, -1711.332, 19.44624), marker = 1},
                                {pos = vector3(1071.378, -1954.675, 31.01424), marker = 2},
                                {pos = vector3(1282.257, -2558.783, 43.82122), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(649.6512, 246.419, 103.4239)},
                                {pos = vector3(-372.2838, 194.2171, 84.06175)},
                                {pos = vector3(-1349.485, -760.427, 22.45949)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                   {pos = vector3(-422.6056, -1720.776, 19.34138), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-432.4007, -1716.573, 19.02037), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-424.7239, -1702.372, 19.13883), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-442.5357, -1709.676, 18.81032), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-427.7648, -1722.837, 19.09597), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-447.4926, -1710.009, 18.75542), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-454.721, -1694.33, 19.12934), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-460.8257, -1701.962, 18.83744), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-433.8107, -1696.845, 18.97789), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(1078.205, -1954.091, 31.03113), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.863, -1945.098, 31.15836), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1075.195, -1942.649, 31.06912), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1070.357, -1943.969, 31.01718), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.019, -1960.49, 31.01425), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1083.085, -1967.218, 31.01464), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1085.712, -1974.577, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1089.337, -1972.286, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1067.682, -1949.054, 31.0154), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(1290.482, -2560.956, 44.10447), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1287.365, -2564.047, 44.32512), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1280.803, -2562.81, 43.83899), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1273.019, -2557.589, 43.02376), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1274.929, -2562.517, 43.33635), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1263.441, -2570.566, 43.06508), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1257.932, -2571.241, 42.71659), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1254.068, -2564.189, 42.71593), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1252.836, -2572.677, 42.7176), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                        },
    ["Outils"] = {
                            RandomPos = {
                                {pos = vector3(1538.487, -2090.507, 77.06601), marker = 1},
                                {pos = vector3(830.6019, -792.2642, 26.25615), marker = 2},
                                {pos = vector3(-607.7554, -1791.797, 23.58924), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(-1014.476, -1514.375, 6.519115)},
                                {pos = vector3(719.1, -2102.802, 29.64572)},
                                {pos = vector3(1193.902, -1248.165, 35.36293)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                    {pos = vector3(1552.609, -2079.08, 77.09324), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1553.592, -2092.192, 77.1666), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1541.18, -2108.49, 77.15497), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1538.582, -2110.899, 77.00853), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1535.126, -2127.014, 76.90005), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1513.789, -2123.29, 76.29295), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1517.657, -2095.278, 76.91996), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1512.037, -2100.095, 76.7349), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(826.1683, -797.3613, 26.19792), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(823.3937, -800.4865, 26.38397), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(824.2275, -794.3958, 26.33616), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(822.5736, -778.2212, 26.17545), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(828.5271, -773.1341, 26.22028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(837.7119, -800.3875, 26.27251), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(836.3965, -806.6812, 26.28794), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(-611.3302, -1787.671, 23.68258), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-617.0615, -1790.3, 23.71638), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-603.3737, -1789.386, 23.71678), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(-601.5659, -1783.068, 23.63999), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-597.7784, -1777.64, 23.21074), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-593.2486, -1780.056, 22.8525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                 },
                            },
                        },
}

Configmechanic4 = {

    points = {
        vestiaire = vector3(550.07,-181.86,54.49),
        craft = vector3(550.49,-189.31,54.49),
        shop = vector3(-677.139, -2459.324, 13.944),
        craft1 = vector3(546.03,-166.75,54.49)

    },
    outil = {        
        {label = "Kit de crochetage", value = "kitcroche", price =100},
    },
     moteur = {        
        {label = "Moteur Stock", value = "stock_engine", price =14000},
        {label = "Moteur 2JZ", value = "2jzengine", price =35000},
        {label = "Moteur V6", value = "v6engine", price =25000},
        {label = "Moteur V8", value = "v8engine", price =30000},

    },
    boite = {        
        {label = "Transmission stock", value = "stock_transmission", price =10000},
        {label = "Transmission RWD", value = "race_transmission", price =15000},
        {label = "Transmission 4WD", value = "race_transmission_4wd", price =20000},
        {label = "Transmission FWD", value = "race_transmission_fwd", price =15000},

    },
    pneu = {
        {label = "Stock Tires", value = "stock_tires", price =500},
        {label = "Pneu Michelin", value = "michelin_tires", price =1500},

    },
    suspension = {
        {label = "Suspension stock", value = "stock_suspension", price =3500},
        {label = "Suspension course", value = "race_suspension", price =5000},
    },
    bougie = {
        {label = "Bougies Stock", value = "stock_sparkplugs", price =40},
        {label = "Bougies NGK", value = "ngk_sparkplugs", price =120},
    },
    huile = {
        {label = "Huile Stock", value = "stock_oil", price =100},
        {label = "Huile Shell", value = "shell_oil", price =150},
    },
    frein = {
        {label = "Freins Stock", value = "stock_brakes", price =8500},
        {label = "Freins course", value = "race_brakes", price =15000},

    },
    turbo = {
        {label = "Turbo Standard", value = "stock_turbo", price =7500},
        {label = "GARETT Turbo", value = "turbo_lvl_1", price =15000},
        {label = "KKK Turbo", value = "turbo_lvl_2", price =25000},

    },
    piece = {  
        {label = "Repairkit", value = "repairkit", price =150},
        {label = "Kit de Nettoyage", value = "kitnet", price =150},       
        {label = "Caisse mécano", value = "mechanic_tools", price =50},
        {label = "Bielle", value = "bielles", price =500},
        {label = "Champignon pneu", value = "champignonpneu", price =50},
        {label = "Chemise", value = "chemises", price =500},
        {label = "CHRA Eisen", value = "chra1", price =250},
        {label = "CHRA Einhell", value = "chra2", price =500},
        {label = "CHRA KKK", value = "chra3", price =750},        
        {label = "Coupelle", value = "coupellessusp", price =150},
        {label = "Kit Distribution", value = "distribution", price =500},
        {label = "Huile TRW", value = "huiletransmission", price =50},       
        {label = "Piston", value = "piston", price =500},
        {label = "Planetaire", value = "planetaire", price =500},
        {label = "Plaquettes freins", value = "plaquettefrein", price =200},
        {label = "Ressort", value = "ressortsusp", price =350},
        {label = "Volant Moteur", value = "volantm", price =250},
    },
    uniform ={
        male = {
                ['tshirt_1'] = 170,  ['tshirt_2'] =  0,
                ['torso_1'] = 167,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 69,   ['pants_2'] = 1,
                ['shoes_1'] = 7,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 96,  ['tshirt_2'] =  0,
                ['torso_1'] = 229,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 4,   ['pants_2'] = 0,
                ['shoes_1'] = 33,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0
        },
    },
    Props = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
            },
    ["Kit"] = {
                            RandomPos = {
                                {pos = vector3(-421.0725, -1711.332, 19.44624), marker = 1},
                                {pos = vector3(1071.378, -1954.675, 31.01424), marker = 2},
                                {pos = vector3(1282.257, -2558.783, 43.82122), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(649.6512, 246.419, 103.4239)},
                                {pos = vector3(-372.2838, 194.2171, 84.06175)},
                                {pos = vector3(-1349.485, -760.427, 22.45949)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                   {pos = vector3(-422.6056, -1720.776, 19.34138), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-432.4007, -1716.573, 19.02037), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-424.7239, -1702.372, 19.13883), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-442.5357, -1709.676, 18.81032), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-427.7648, -1722.837, 19.09597), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-447.4926, -1710.009, 18.75542), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-454.721, -1694.33, 19.12934), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-460.8257, -1701.962, 18.83744), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-433.8107, -1696.845, 18.97789), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(1078.205, -1954.091, 31.03113), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.863, -1945.098, 31.15836), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1075.195, -1942.649, 31.06912), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1070.357, -1943.969, 31.01718), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.019, -1960.49, 31.01425), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1083.085, -1967.218, 31.01464), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1085.712, -1974.577, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1089.337, -1972.286, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1067.682, -1949.054, 31.0154), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(1290.482, -2560.956, 44.10447), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1287.365, -2564.047, 44.32512), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1280.803, -2562.81, 43.83899), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1273.019, -2557.589, 43.02376), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1274.929, -2562.517, 43.33635), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1263.441, -2570.566, 43.06508), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1257.932, -2571.241, 42.71659), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1254.068, -2564.189, 42.71593), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1252.836, -2572.677, 42.7176), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                        },
    ["Outils"] = {
                            RandomPos = {
                                {pos = vector3(1538.487, -2090.507, 77.06601), marker = 1},
                                {pos = vector3(830.6019, -792.2642, 26.25615), marker = 2},
                                {pos = vector3(-607.7554, -1791.797, 23.58924), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(-1014.476, -1514.375, 6.519115)},
                                {pos = vector3(719.1, -2102.802, 29.64572)},
                                {pos = vector3(1193.902, -1248.165, 35.36293)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                    {pos = vector3(1552.609, -2079.08, 77.09324), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1553.592, -2092.192, 77.1666), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1541.18, -2108.49, 77.15497), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1538.582, -2110.899, 77.00853), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1535.126, -2127.014, 76.90005), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1513.789, -2123.29, 76.29295), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1517.657, -2095.278, 76.91996), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1512.037, -2100.095, 76.7349), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(826.1683, -797.3613, 26.19792), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(823.3937, -800.4865, 26.38397), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(824.2275, -794.3958, 26.33616), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(822.5736, -778.2212, 26.17545), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(828.5271, -773.1341, 26.22028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(837.7119, -800.3875, 26.27251), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(836.3965, -806.6812, 26.28794), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(-611.3302, -1787.671, 23.68258), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-617.0615, -1790.3, 23.71638), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-603.3737, -1789.386, 23.71678), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(-601.5659, -1783.068, 23.63999), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-597.7784, -1777.64, 23.21074), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-593.2486, -1780.056, 22.8525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                 },
                            },
                        },
}

Configmechanic5 = {

    points = {
        vestiaire = vector3(1037.839, -2518.373, -28.29844),
        craft = vector3(1037.254, -2525.784, 28.29844),
        shop = vector3(-677.139, -2459.324, 13.944),
        craft1 = vector3(1037.839, -2518.373, 28.29844)

    },
    outil = {        
        {label = "Kit de crochetage", value = "kitcroche", price =100},
    },
    moteur = {        
        {label = "Moteur Stock", value = "stock_engine", price =14000},
        {label = "Moteur 2JZ", value = "2jzengine", price =35000},
        {label = "Moteur V6", value = "v6engine", price =25000},
        {label = "Moteur V8", value = "v8engine", price =30000},

    },
    boite = {        
        {label = "Transmission stock", value = "stock_transmission", price =10000},
        {label = "Transmission RWD", value = "race_transmission", price =15000},
        {label = "Transmission 4WD", value = "race_transmission_4wd", price =20000},
        {label = "Transmission FWD", value = "race_transmission_fwd", price =15000},

    },
    pneu = {
        {label = "Stock Tires", value = "stock_tires", price =500},
        {label = "Pneu Michelin", value = "michelin_tires", price =1500},

    },
    suspension = {
        {label = "Suspension stock", value = "stock_suspension", price =3500},
        {label = "Suspension course", value = "race_suspension", price =5000},
    },
    bougie = {
        {label = "Bougies Stock", value = "stock_sparkplugs", price =40},
        {label = "Bougies NGK", value = "ngk_sparkplugs", price =120},
    },
    huile = {
        {label = "Huile Stock", value = "stock_oil", price =100},
        {label = "Huile Shell", value = "shell_oil", price =150},
    },
    frein = {
        {label = "Freins Stock", value = "stock_brakes", price =8500},
        {label = "Freins course", value = "race_brakes", price =15000},

    },
    turbo = {
        {label = "Turbo Standard", value = "stock_turbo", price =7500},
        {label = "GARETT Turbo", value = "turbo_lvl_1", price =15000},
        {label = "KKK Turbo", value = "turbo_lvl_2", price =25000},

    },
    piece = {   
        {label = "Repairkit", value = "repairkit", price =150},
        {label = "Kit de Nettoyage", value = "kitnet", price =150},      
        {label = "Caisse mécano", value = "mechanic_tools", price =50},
        {label = "Bielle", value = "bielles", price =500},
        {label = "Champignon pneu", value = "champignonpneu", price =50},
        {label = "Chemise", value = "chemises", price =500},
        {label = "CHRA Eisen", value = "chra1", price =250},
        {label = "CHRA Einhell", value = "chra2", price =500},
        {label = "CHRA KKK", value = "chra3", price =750},        
        {label = "Coupelle", value = "coupellessusp", price =150},
        {label = "Kit Distribution", value = "distribution", price =500},
        {label = "Huile TRW", value = "huiletransmission", price =50},       
        {label = "Piston", value = "piston", price =500},
        {label = "Planetaire", value = "planetaire", price =500},
        {label = "Plaquettes freins", value = "plaquettefrein", price =200},
        {label = "Ressort", value = "ressortsusp", price =350},
        {label = "Volant Moteur", value = "volantm", price =250},
    },
    uniform ={
        male = {
                ['tshirt_1'] = 170,  ['tshirt_2'] =  0,
                ['torso_1'] = 167,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 69,   ['pants_2'] = 1,
                ['shoes_1'] = 7,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0

            },
        female = {
                ['tshirt_1'] = 96,  ['tshirt_2'] =  0,
                ['torso_1'] = 229,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 4,   ['pants_2'] = 0,
                ['shoes_1'] = 33,   ['shoes_2'] = 0,
                ['chain_1'] = -1,  ['chain_2'] = 0
        },
    },
    Props = {
                {name = "Cône", obj = "prop_roadcone02a", Cooldown_object = false},
                {name = "Barrière", obj = "prop_barrier_work05", Cooldown_object = false},
                {name = "Gazebo", obj = "prop_gazebo_02", Cooldown_object = false},
                {name = "Cone lumière", obj = "prop_air_conelight", Cooldown_object = false},
                {name = "Nadar", obj = "prop_fncsec_04a", Cooldown_object = false},
                {name = "Spot", obj = "prop_worklight_03a", Cooldown_object = false},
                {name = "Fence", obj = "prop_fncsec_03b", Cooldown_object = false},
                {name = "Bloc", obj = "prop_plas_barier_01a", Cooldown_object = false},
                {name = "Slow down", obj = "stt_prop_track_slowdown", Cooldown_object = false},
                {name = "Route fermé", obj = "prop_barrier_work04a", Cooldown_object = false},
            },
    ["Kit"] = {
                            RandomPos = {
                                {pos = vector3(-421.0725, -1711.332, 19.44624), marker = 1},
                                {pos = vector3(1071.378, -1954.675, 31.01424), marker = 2},
                                {pos = vector3(1282.257, -2558.783, 43.82122), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(649.6512, 246.419, 103.4239)},
                                {pos = vector3(-372.2838, 194.2171, 84.06175)},
                                {pos = vector3(-1349.485, -760.427, 22.45949)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                   {pos = vector3(-422.6056, -1720.776, 19.34138), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-432.4007, -1716.573, 19.02037), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-424.7239, -1702.372, 19.13883), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-442.5357, -1709.676, 18.81032), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-427.7648, -1722.837, 19.09597), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                   {pos = vector3(-447.4926, -1710.009, 18.75542), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-454.721, -1694.33, 19.12934), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                   {pos = vector3(-460.8257, -1701.962, 18.83744), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                   {pos = vector3(-433.8107, -1696.845, 18.97789), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(1078.205, -1954.091, 31.03113), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.863, -1945.098, 31.15836), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1075.195, -1942.649, 31.06912), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1070.357, -1943.969, 31.01718), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1078.019, -1960.49, 31.01425), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1083.085, -1967.218, 31.01464), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1085.712, -1974.577, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1089.337, -1972.286, 31.01466), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1067.682, -1949.054, 31.0154), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(1290.482, -2560.956, 44.10447), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1287.365, -2564.047, 44.32512), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1280.803, -2562.81, 43.83899), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1273.019, -2557.589, 43.02376), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1274.929, -2562.517, 43.33635), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1263.441, -2570.566, 43.06508), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                    {pos = vector3(1257.932, -2571.241, 42.71659), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "box"},
                                    {pos = vector3(1254.068, -2564.189, 42.71593), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "vices"},
                                    {pos = vector3(1252.836, -2572.677, 42.7176), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Kits de réparation", item = "fer"},
                                 },
                            },
                        },
    ["Outils"] = {
                            RandomPos = {
                                {pos = vector3(1538.487, -2090.507, 77.06601), marker = 1},
                                {pos = vector3(830.6019, -792.2642, 26.25615), marker = 2},
                                {pos = vector3(-607.7554, -1791.797, 23.58924), marker = 3},
                            },
                            SellRandomPos = {
                                {pos = vector3(-1014.476, -1514.375, 6.519115)},
                                {pos = vector3(719.1, -2102.802, 29.64572)},
                                {pos = vector3(1193.902, -1248.165, 35.36293)}, 
                            },
                            [1] = {
                                MarkerPos = {
                                    {pos = vector3(1552.609, -2079.08, 77.09324), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1553.592, -2092.192, 77.1666), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1541.18, -2108.49, 77.15497), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1538.582, -2110.899, 77.00853), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1535.126, -2127.014, 76.90005), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(1513.789, -2123.29, 76.29295), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(1517.657, -2095.278, 76.91996), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(1512.037, -2100.095, 76.7349), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                },
                            },
                            [2] = {
                                MarkerPos = {
                                    {pos = vector3(826.1683, -797.3613, 26.19792), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(823.3937, -800.4865, 26.38397), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(824.2275, -794.3958, 26.33616), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(822.5736, -778.2212, 26.17545), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(828.5271, -773.1341, 26.22028), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(837.7119, -800.3875, 26.27251), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(836.3965, -806.6812, 26.28794), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                 },
                            },
                            [3] = {
                                MarkerPos = {
                                    {pos = vector3(-611.3302, -1787.671, 23.68258), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-617.0615, -1790.3, 23.71638), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-603.3737, -1789.386, 23.71678), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                    {pos = vector3(-601.5659, -1783.068, 23.63999), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "chiffon"},
                                    {pos = vector3(-597.7784, -1777.64, 23.21074), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "produit"},
                                    {pos = vector3(-593.2486, -1780.056, 22.8525), notif = "Appuyez sur ~INPUT_CONTEXT~ pour récupérer les matériaux", InDrawking = false, label = "Outils de crochetages", item = "lustreur"},
                                 },
                            },
                        },
}

Configambulance = {

    points = {
        vestiaire = vector3(314.04, -603.06, 43.29),
        armoire = vector3(305.93, -579.91, 43.28),
        vestiairenord = vector3(-270.03, 6319.53, 32.42),
        armoirenord = vector3(-252.51, 6319.39, 32.40),
        AchatVehicle = vector3(343.4211, -572.137, 28.89872),
        InsideShop = vector3(351.8263, -559.3986, 35.22884)
    },
    AuthorizedVehicles = {
        Shared = {
            { model = 'ems', label = 'ems', price = 5000 },
            { model = 'lsambulance', label = 'lsambulance', price = 5000 },
            { model = 'ambucara', label = 'ambucara', price = 5000 },ambucara
        }
    },

    AuthorizedHelicopters = {
        boss = {
            {model = 'POLMAV', label = 'Hélicoptère', price = 5000}
        }
    },
    kit = {
        {label = "Médicament", value = "medicament", price =0},
        {label = "Medikit", value = "medikit", price =0},
        {label = "Bandage", value = "bandage", price =0},
        {label = "Pansement", value = "pansement", price =0},
        {label = "Plongee courte", value = "plongee1", price =0},       
        {label = "Plongee longue", value = "plongee2", price =0},
    },
}

ConfigambulanceUniforms = {
    secouriste = {
        male = {
            ['tshirt_1'] = 168, ['tshirt_2'] = 0,
            ['torso_1'] = 56, ['torso_2'] = 6,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 96,
            ['pants_1'] = 156, ['pants_2'] = 0,
            ['shoes_1'] = 63, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 61, ['chain_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 231,  ['tshirt_2'] = 0,
            ['torso_1'] = 74,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 180,   ['pants_2'] = 0,
            ['shoes_1'] = 78,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 40,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0
        },
    },
    paramedic = {
        male = {
            ['tshirt_1'] = 168,  ['tshirt_2'] = 0,
            ['torso_1'] = 420,   ['torso_2'] = 0,
            ['decals_1'] = 72,   ['decals_2'] = 0,
            ['arms'] = 89,
            ['pants_1'] = 159,   ['pants_2'] = 1,
            ['shoes_1'] = 63,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61,    ['chain_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0

        },


        female = {
            ['tshirt_1'] = 231,  ['tshirt_2'] = 0,
            ['torso_1'] = 53,   ['torso_2'] = 0,
            ['decals_1'] = 80,   ['decals_2'] = 0,
            ['arms'] = 104,
            ['pants_1'] = 180,   ['pants_2'] = 1,
            ['shoes_1'] = 78,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 40,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0
        }
    },

    interne = {
        male = {

            ['tshirt_1'] = 168,  ['tshirt_2'] = 0,
            ['torso_1'] = 420,   ['torso_2'] = 7,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 89,
            ['pants_1'] = 159,   ['pants_2'] = 1,
            ['shoes_1'] = 63,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61,    ['chain_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0


        },

        female = {
            ['tshirt_1'] = 231,  ['tshirt_2'] = 0,
            ['torso_1'] = 442,   ['torso_2'] = 7,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 180,   ['pants_2'] = 1,
            ['shoes_1'] = 78,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 40,    ['chain_2'] = 0,
            ['mask_1'] = -1,  ['mask_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0

        }
    },


    doctor = {
        male = {

            ['tshirt_1'] = 168, ['tshirt_2'] = 0,
            ['torso_1'] = 419, ['torso_2'] = 5,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 96,
            ['pants_1'] = 159, ['pants_2'] = 1,
            ['shoes_1'] = 63, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61, ['chain_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2'] = 0

        },


        female = {
            ['tshirt_1'] = 231, ['tshirt_2'] = 0,
            ['torso_1'] = 53, ['torso_2'] = 5,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 180, ['pants_2'] = 1,
            ['shoes_1'] = 78, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 40, ['chain_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0
        }
    },

    chief_doctor = {
        male = {

            ['tshirt_1'] = 165, ['tshirt_2'] = 0,
            ['torso_1'] = 216, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 97,
            ['pants_1'] = 58, ['pants_2'] = 8,
            ['shoes_1'] = 17, ['shoes_2'] = 2,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61, ['chain_2'] = 0,
            ['bproof_1'] = 25, ['bproof_2'] = 0

        },

        female = {
            ['tshirt_1'] = 106, ['tshirt_2'] = 0,
            ['torso_1'] = 219, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 6, ['pants_2'] = 0,
            ['shoes_1'] = 34, ['shoes_2'] = 16,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 40, ['chain_2'] = 3,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = 26, ['bproof_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0
        }
    },
    doctor2 = {
        male = {

            ['tshirt_1'] = 87, ['tshirt_2'] = 3,
            ['torso_1'] = 395, ['torso_2'] = 4,
            ['arms'] = 92,
            ['pants_1'] = 58, ['pants_2'] = 0,
            ['shoes_1'] = 17, ['shoes_2'] = 2,
            ['chain_1'] = 61, ['chain_2'] = 0,
            ['bproof_1'] = 25, ['bproof_2'] = 0,

        },

        female = {

            ['tshirt_1'] = 119, ['tshirt_2'] = 3,
            ['torso_1'] = 202, ['torso_2'] = 0,
            ['arms'] = 105,
            ['pants_1'] = 6, ['pants_2'] = 0,
            ['shoes_1'] = 34, ['shoes_2'] = 16,
            ['chain_1'] = 40, ['chain_2'] = 0,
            ['bproof_1'] = 26, ['bproof_2'] = 0,
        }
    },
    coboss = {
        male = {

            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 394, ['torso_2'] = 9,
            ['arms'] = 96,
            ['pants_1'] = 50, ['pants_2'] = 0,
            ['shoes_1'] = 63, ['shoes_2'] = 0,
            ['chain_1'] = 54, ['chain_2'] = 11,
            ['bags_1'] = 0, ['bags_2'] = 0,

        },

        female = {

            ['tshirt_1'] = 43, ['tshirt_2'] = 0,
            ['torso_1'] = 162, ['torso_2'] = 2,
            ['arms'] = 99,
            ['pants_1'] = 88, ['pants_2'] = 2,
            ['shoes_1'] = 52, ['shoes_2'] = 0,
            ['chain_1'] = 14, ['chain_2'] = 0,
            ['bags_1'] = 21, ['bags_2'] = 10,
        }
    },
    boss = {
        male = {

            ['tshirt_1'] = 47, ['tshirt_2'] = 0,
            ['torso_1'] = 395, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 97,
            ['pants_1'] = 4, ['pants_2'] = 4,
            ['shoes_1'] = 23, ['shoes_2'] = 1,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61, ['chain_2'] = 2,
            ['bproof_1'] = 33, ['bproof_2'] = 5,

        },

        female = {

            ['tshirt_1'] = 81, ['tshirt_2'] = 0,
            ['torso_1'] = 169, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 109,
            ['pants_1'] = 0, ['pants_2'] = 10,
            ['shoes_1'] = 19, ['shoes_2'] = 1,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['bproof_1'] = 32, ['bproof_2'] = 5,
        }
    },
}

ConfigambulanceUniforms2 = {
    Helico = {
        male = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 332, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 31,
            ['pants_1'] = 123, ['pants_2'] = 0,
            ['shoes_1'] = 63,   ['shoes_2'] = 0,
            ['helmet_1'] = 270, ['helmet_2'] = 296,
            ['mask_1'] = -1,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['bproof_1'] = -1, ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 156, ['tshirt_2'] = 0,
            ['torso_1'] = 353, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 25,
            ['pants_1'] = 141, ['pants_2'] = 0,
            ['shoes_1'] = 78,   ['shoes_2'] = 0,
            ['helmet_1'] = 194, ['helmet_2'] = 296,
            ['mask_1'] = -1,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2'] = 0
        }
    },
    Chirurgie = {
        male = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 187, ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 96,
            ['pants_1'] = 75, ['pants_2'] = 1,
            ['shoes_1'] = 23,   ['shoes_2'] = 4,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = 27, ['mask_2'] = 0,
            ['chain_1'] = 61, ['chain_2'] = 2,
            ['bproof_1'] = 0, ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 206, ['tshirt_2'] = 16,
            ['torso_1'] = 46, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 86, ['pants_2'] = 3,
            ['shoes_1'] = 19,   ['shoes_2'] = 2,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 40, ['chain_2'] = 0,
            ['bproof_1'] = -1, ['bproof_2'] = 0
        }
    },
    EMS = {
        male = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 480, ['torso_2'] = 6,
            ['decals_1'] = 72,   ['decals_2'] = 0,
            ['arms'] = 4,
            ['pants_1'] = 19, ['pants_2'] = 1,
            ['shoes_1'] = 23,   ['shoes_2'] = 4,
            ['helmet_1'] = 0, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = 33, ['bproof_2'] = 5,
            ['ears_1'] = -1, ['ears_2'] = -1
        },
        female = {
            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
            ['torso_1'] = 166, ['torso_2'] = 3,
            ['decals_1'] = 80,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 179, ['pants_2'] = 19,
            ['shoes_1'] = 19,   ['shoes_2'] = 1,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['mask_1'] = -1, ['mask_2'] = 0,
            ['bproof_1'] = 32,  ['bproof_2'] = 5,
            ['ears_1'] = -1, ['ears_2'] = -1
        }
    },
    Funeraire = {
        male = {
            ['tshirt_1'] = 48, ['tshirt_2'] = 0,
            ['torso_1'] = 395, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 35,
            ['pants_1'] = 58, ['pants_2'] = 0,
            ['shoes_1'] = 78,   ['shoes_2'] = 9,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 58, ['chain_2'] = 2,
            ['bproof_1'] = 33, ['bproof_2'] = 5
        },
        female = {
            ['tshirt_1'] = 83, ['tshirt_2'] = 2,
            ['torso_1'] = 417, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 40,
            ['pants_1'] = 178, ['pants_2'] = 0,
            ['shoes_1'] = 70,   ['shoes_2'] = 2,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 54, ['chain_2'] = 0,
            ['bproof_1'] = 32, ['bproof_2'] = 5
        }
    },
    Intervention = {
        male = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 56, ['torso_2'] = 6,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 96,
            ['pants_1'] = 160, ['pants_2'] = 0,
            ['shoes_1'] = 126, ['shoes_2'] = 9,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 61, ['chain_2'] = 4,
            ['bproof_1'] = 33, ['bproof_2'] = 5
        },
        female = {
            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
            ['torso_1'] = 53, ['torso_2'] = 7,
            ['decals_1'] = 80, ['decals_2'] = 0,
            ['arms'] = 110,
            ['pants_1'] = 99, ['pants_2'] = 2,
            ['shoes_1'] = 22, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['mask_1'] = -1,
            ['chain_1'] = 40, ['chain_2'] = 2,
            ['bproof_1'] = 32, ['bproof_2'] = 5
        },
    },
}







































-----[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[       CONCESS         ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]------------------
ConcessCardealer = {}
ConcessCardealer.kSelected = nil
ConcessCardealer.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessCardealer.NumberPlate = {}
ConcessCardealer.LettePlate = {}
ConfigCardealerShop = {

    points = {
        achat = vector3(116.8245,-140.270,54.85),
        vestiaire = vector3(138.932,-161.3611,60.488),
        catalogue = vector3(115.837,-156.769,54.855)

    },
    ["Voiture"] = {
        [1] = {
            --compacts
            {label = "Brioso 3", model = "brioso3", price = 5000},
            {label = "Brioso R/A", model = "brioso", price = 5500},
            {label = "Blista", model = "blista", price = 6000},
            {label = "Blista Kanjo", model = "kanjo", price = 8000},
            {label = "Blista Asbo", model = "asbo", price = 8000},
            {label = "Brioso ", model = "brioso2", price = 7000},
            {label = "Club", model = "club", price = 5000},
            {label = "Issi", model = "issi2", price = 8500},
            {label = "Kalahari", model = "kalahari", price = 12000},
            {label = "Panto", model = "panto", price = 5000},
            {label = "Prairie", model = "prairie", price = 10000},
            {label = "Rhapsody", model = "rhapsody", price = 5500},
            {label = "Weevil", model = "weevil", price = 8000},
        },
        [2] = {
            --coupes
            {label = "Cognoscenti Cabrio", model = "cogcabrio", price = 30000},
            {label = "Dinka Kanjo SJ", model = "kanjosj", price = 25000},
            {label = "Exemplar", model = "exemplar", price = 35000},
            {label = "F620", model = "f620", price = 35000},
            {label = "Felon", model = "felon", price = 69000},
            {label = "Felon GT", model = "felon2", price = 75000},
            {label = "Jackal", model = "jackal", price = 30000},
            {label = "Oracle", model = "oracle", price = 25000},
            {label = "Oracle XS", model = "oracle2", price = 30000},
            {label = "Prévion", model = "previon", price = 50000},
            {label = "Sentinel", model = "sentinel", price = 33000},
            {label = "Sentinel XS", model = "sentinel2", price = 34000},
            {label = "Windsor Drop", model = "windsor2", price = 50000},
            {label = "Zion", model = "zion", price = 32000},
            {label = "Zion Cabrio", model = "zion2", price = 35000},

        },
        [3] = {
            --sedans
            {label = "Asea", model = "asea", price = 8000},
            {label = "Cognoscenti", model = "cognoscenti", price = 28500},
            {label = "Emperor", model = "emperor", price = 12000},
            {label = "Fugitive", model = "fugitive", price = 20000},
            {label = "Glendale", model = "glendale", price = 11500},
            {label = "Glendale 2", model = "glendale2", price = 13000},
            {label = "Intruder", model = "intruder", price = 12500},
            {label = "Premier", model = "premier", price = 11500},
            {label = "Primo", model = "primo", price = 12500},
            {label = "Primo Custom", model = "primo2", price = 14000},
            {label = "Regina", model = "regina", price = 9000},
            {label = "Rhinehart", model = "rhinehart", price = 42500},
            {label = "Schafter - 2", model = "schafter2", price = 23000},
            {label = "Stafford", model = "stafford", price = 25000},
            {label = "Stanier", model = "stanier", price = 20000},
            {label = "Stratum", model = "stratum", price = 23000},
            {label = "Stretch", model = "stretch", price = 24500},
            {label = "Super Diamond", model = "superd", price = 24500},
            {label = "Tailgater", model = "tailgater", price = 40000},
            {label = "Tailgater 2", model = "tailgater2", price = 45000},
            {label = "Warrener", model = "warrener", price = 19500},
            {label = "Warrener HKR", model = "warrener2", price = 25000},
            {label = "Washington", model = "washington", price = 22500},           
        },
        [4] = {
            --muscle
            {label = "Blade", model = "blade", price = 25000},
            {label = "Bravado greenwood", model = "greenwood", price = 30500},
            {label = "Buccaneer", model = "buccaneer", price = 20000},
            {label = "Buccaneer Rider", model = "buccaneer2", price = 25500},
            {label = "Chino", model = "chino", price = 23000},
            {label = "Chino Luxe", model = "chino2", price = 25500},
            {label = "Clique", model = "clique", price = 19000},
            {label = "Coquette BlackFin", model = "coquette3", price = 24500},
            {label = "Declasse Vigero ZX", model = "vigero2", price = 34500},
            {label = "Deviant", model = "deviant", price = 25000},
            {label = "Dominator", model = "dominator", price = 32000},
            {label = "Dominator 3", model = "dominator3", price = 32000},
            {label = "Dominator 7", model = "dominator7", price = 35000},
            {label = "Dukes", model = "dukes", price = 23500},
            {label = "Dukes 3", model = "dukes3", price = 19500},
            {label = "Ellie", model = "ellie", price = 25000},
            {label = "Faction", model = "faction", price = 28000},
            {label = "Faction Rider", model = "faction2", price = 30000},
            {label = "Faction XL", model = "faction3", price = 35000},
            {label = "Gauntlet", model = "gauntlet", price = 30000},
            {label = "Gauntlet 3", model = "gauntlet3", price = 25000},
            {label = "Gauntlet 4", model = "gauntlet4", price = 27500},
            {label = "Gauntlet 5", model = "gauntlet5", price = 28000},
            {label = "Hermes", model = "hermes", price = 37500},
            {label = "Hotknife", model = "hotknife", price = 32500},
            {label = "Hustler", model = "hustler", price = 31500},
            {label = "Impaler", model = "impaler", price = 17500},
            {label = "Nightshade", model = "nightshade", price = 35000},
            {label = "Peyote 2", model = "peyote2", price = 25000},
            {label = "Phoenix", model = "phoenix", price = 27500},            
            {label = "Picador", model = "picador", price = 23000},
            {label = "Ruiner 4", model = "ruiner4", price = 40000},
            {label = "Sabre GT", model = "sabregt2", price = 30000},
            {label = "Sabre Turbo", model = "sabregt", price = 27500},
            {label = "Slam Van", model = "slamvan", price = 25000},
            {label = "Slam Van 3", model = "slamvan3", price = 31000},
            {label = "Stallion", model = "stalion", price = 22000},
            {label = "Tampa", model = "tampa", price = 25000},
            {label = "Tulip", model = "tulip", price = 25000},
            {label = "Vamos", model = "vamos", price = 30000},
            {label = "Vigero", model = "vigero", price = 24500},
            {label = "Virgo", model = "virgo", price = 27500},
            {label = "Virgo Classique Custom", model = "virgo2", price = 30000},
            {label = "Voodoo", model = "voodoo", price = 26000},
            {label = "Weevil 2", model = "weevil2", price = 35000},
            {label = "Yosemite", model = "yosemite", price = 21500},
            {label = "Yosemite 2", model = "yosemite2", price = 24000},
            {label = "Yosemite 3", model = "yosemite3", price = 25000},

        },
        [5] = {
            --offroad
            {label = "Bf Injection", model = "bfinjection", price = 23500},
            {label = "Bifta", model = "bifta", price = 26500},
            {label = "Blazer", model = "blazer", price = 7500},
            {label = "Blazer Sport", model = "blazer4", price = 14000},
            {label = "Brawler", model = "brawler", price = 26000},
            {label = "Bubsta 6x6", model = "dubsta3", price = 35000},
            {label = "Caracara 2", model = "caracara2", price = 25500},
            {label = "Deckasse Draugur", model = "draugur", price = 45000},
            {label = "Everon", model = "everon", price = 29500},
            {label = "Freecrawler", model = "freecrawler", price = 35000},
            {label = "Guardian", model = "guardian", price = 32500},
            {label = "Hellion", model = "hellion", price = 17500},
            {label = "Kamacho", model = "kamacho", price = 32500},
            {label = "Outlaw", model = "outlaw", price = 15500},
            {label = "Rebel", model = "rebel2", price = 27500},
            {label = "Riata", model = "riata", price = 27500},
            {label = "Sandking", model = "sandking", price = 35000},
            {label = "Trophytruck", model = "trophytruck", price = 30000},
            {label = "Trophytruck 2", model = "trophytruck2", price = 30000},
            {label = "Vagrant", model = "vagrant", price = 21000},
            {label = "Verus", model = "verus", price = 13000},
            {label = "Winky", model = "winky", price = 19000},
        },
        [6] = {
            --sports
            {label = "9F", model = "ninef", price = 47500},
            {label = "9F Cabrio", model = "ninef2", price = 50000},
            {label = "Alpha", model = "alpha", price = 33000},
            {label = "Banshee", model = "banshee", price = 36000},
            {label = "Banshee2", model = "Banshee2", price = 38500},
            {label = "Benefactor SM722", model = "sm722", price = 45000},
            {label = "Bestia GTS", model = "bestiagts", price = 45000},
            {label = "Buffalo", model = "buffalo", price = 36000},
            {label = "Buffalo S", model = "buffalo2", price = 38500},
            {label = "CalicoGTF", model = "calico", price = 32000},
            {label = "Carbonizzare", model = "carbonizzare", price = 47500},
            {label = "Cinquemilla", model = "cinquemila", price = 50000},
            {label = "Comet", model = "comet2", price = 45000},
            {label = "Comet 5", model = "comet5", price = 46500},
            {label = "Comet Retro Custom", model = "comet3", price = 45000},
            {label = "Comet S2", model = "comet6", price = 40000},
            {label = "Comet S2 Cab", model = "comet7", price = 47000},
            {label = "Comet Safari", model = "comet4", price = 55000},
            {label = "Coquette", model = "coquette", price = 48000},
            {label = "Cypher", model = "cypher", price = 28000},
            {label = "Drafter", model = "drafter", price = 47500},
            {label = "Elegy", model = "elegy2", price = 40000},
            {label = "Elegy Classique", model = "elegy", price = 28000},
            {label = "Euros", model = "euros", price = 35000},
            {label = "Feltzer", model = "feltzer2", price = 45000},
            {label = "FlashGT", model = "flashgt", price = 40000},
            {label = "Furore GT", model = "furoregt", price = 40000},
            {label = "Fusilade", model = "fusilade", price = 42000},
            {label = "Growler", model = "growler", price = 32000},
            {label = "Imorgon", model = "imorgon", price = 30000},
            {label = "Issi 7", model = "issi7", price = 48500},
            {label = "Italirsx", model = "italirsx", price = 65000},
            {label = "Jester", model = "jester", price = 65000},
            {label = "Jester RR", model = "jester4", price = 75000},
            {label = "Jester(Racecar)", model = "jester2", price = 67500},
            {label = "Jugular", model = "jugular", price = 50000},
            {label = "Khamelion", model = "khamelion", price = 37500},
            {label = "Komoda", model = "komoda", price = 50000},
            {label = "Kuruma", model = "kuruma", price = 40000},
            {label = "Lampadati Corsita", model = "corsita", price = 65000},
            {label = "Locust", model = "locust", price = 40000},
            {label = "Lynx", model = "lynx", price = 55000},
            {label = "Mamba", model = "mamba", price = 42000},
            {label = "Massacro", model = "massacro", price = 42500},
            {label = "Massacro(Racecar)", model = "massacro2", price = 45000},
            {label = "Neo", model = "neo", price = 55000},
            {label = "Neon", model = "neon", price = 60000},
            {label = "Obey Omnis u-gt", model = "omnisegt", price = 60000},
            {label = "Omnis", model = "omnis", price = 30000},
            {label = "Paragon", model = "paragon", price = 57500},
            {label = "Pariah", model = "pariah", price = 47500},
            {label = "Penumbra", model = "penumbra", price = 32000},
            {label = "Penumbra 2", model = "penumbra2", price = 34000},
            {label = "Raiden", model = "raiden", price = 48000},
            {label = "Rapid GT", model = "rapidgt", price = 54500},
            {label = "Rapid GT Convertible", model = "rapidgt2", price = 75000},
            {label = "Revolter", model = "revolter", price = 35500},
            {label = "Rt3000", model = "rt3000", price = 50000},
            {label = "Schafter V12", model = "schafter3", price = 48500},
            {label = "Schlagen", model = "schlagen", price = 45000},
            {label = "Sentinel 4", model = "sentinel4", price = 40500},
            {label = "Sentinel3", model = "sentinel3", price = 35500},
            {label = "Seven 70", model = "seven70", price = 54000},
            {label = "Streiter", model = "streiter", price = 28500},
            {label = "Sultan", model = "sultan", price = 22500},
            {label = "Sultan 2", model = "sultan2", price = 25000},
            {label = "Surano", model = "surano", price = 35500},
            {label = "Tampa 2", model = "tampa2", price = 32000},
            {label = "Tropos", model = "tropos", price = 38500},
            {label = "Vectre", model = "vectre", price = 35000},
            {label = "Verlierer", model = "verlierer2", price = 44000},
            {label = "Vstr", model = "vstr", price = 35500},
            {label = "ZR350", model = "ZR350", price = 35000},
            {label = "italigto", model = "italigto", price = 65000},
            {label = "xa21", model = "xa21", price = 65000},
        },
        [7] = {
            --sport classique
            {label = "Ardent", model = "ardent", price = 48000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Btype", model = "btype", price = 50000},
            {label = "Btype", model = "btype", price = 50000},
            {label = "Btype Hotroad", model = "btype2", price = 52500},
            {label = "Btype Luxe", model = "btype3", price = 55000},
            {label = "Casco", model = "casco", price = 49000},
            {label = "cheburek", model = "cheburek", price = 17500},
            {label = "cheetah2", model = "cheetah2", price = 52500},
            {label = "Coquette Classic", model = "coquette2", price = 52500},
            {label = "Dynasty", model = "dynasty", price = 25000},
            {label = "Futo classique", model = "Futo2", price = 18500},
            {label = "fagaloa", model = "fagaloa", price = 25000},
            {label = "GT 500", model = "gt500", price = 45000},
            {label = "infernus2", model = "infernus2", price = 42500},
            {label = "Jester Classique", model = "jester3", price = 40000},
            {label = "Manana", model = "manana", price = 12320},
            {label = "Manana 2", model = "manana2", price = 27500},
            {label = "Michelli GT", model = "michelli", price = 22000},
            {label = "Monroe", model = "monroe", price = 55000},
            {label = "Nebula", model = "nebula", price = 17500},
            {label = "Pigalle", model = "pigalle", price = 22000},
            {label = "Peyote 3", model = "peyote3", price = 34500},
            {label = "Rapid GT3", model = "rapidgt3", price = 135000},
            {label = "Retinue", model = "retinue", price = 26400},
            {label = "Rapid GT3", model = "rapidgt3", price = 35000},
            {label = "Remus", model = "remus", price = 30000},
            {label = "Retinue 2", model = "retinue2", price = 25500},
            {label = "Savestra", model = "savestra", price = 40000},
            {label = "Stirling GT", model = "feltzer3", price = 55000},
            {label = "Stinger", model = "stinger", price = 48500},
            {label = "tornado", model = "tornado", price = 17500},
            {label = "tornado2", model = "tornado2", price = 17500},
            {label = "tornado3", model = "tornado3", price = 17500},
            {label = "tornado4", model = "tornado4", price = 17500},
            {label = "tornado5", model = "tornado5", price = 17500},
            {label = "tornado6", model = "tornado6", price = 17500},
            {label = "Viseris", model = "viseris", price = 50000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Z-Type", model = "ztype", price = 80000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Zion 3", model = "zion3", price = 27500},
        },
        [8] = {
            --super
            {label = "Adder", model = "adder", price = 80000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Autarch", model = "autarch", price = 80000},
            {label = "Banshee 900R", model = "banshee2", price = 64000},
            {label = "Benefactor LM87", model = "lm87", price = 135000},
            {label = "Bullet", model = "bullet", price = 57500},
            {label = "Cyclone", model = "cyclone", price = 65000},
            {label = "Cheetah", model = "cheetah", price = 70000},
            {label = "Deveste", model = "deveste", price = 125000},
            {label = "ETR1", model = "sheava", price = 130000},
            {label = "Entity XF", model = "entityxf", price = 68000},
            {label = "Emerus", model = "emerus", price = 75000},
            {label = "FMJ", model = "fmj", price = 74500},
            {label = "Furia", model = "furia", price = 67500},
            {label = "Infernus", model = "infernus", price = 69000},
            {label = "Ignus", model = "ignus", price = 160000},
            {label = "Krieger", model = "krieger", price = 85000},
            {label = "Osiris", model = "osiris", price = 75500},
            {label = "Pfister", model = "pfister811", price = 70000},
            {label = "Pegasi Torero XO", model = "torero2", price = 60000},
            {label = "Pegasi Torero XO", model = "torero2", price = 60000},
            {label = "Pfister", model = "pfister811", price = 70000},
            {label = "RE-7B", model = "le7b", price = 120000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Reaper", model = "reaper", price = 130000},
            {label = "S80", model = "s80", price = 130000},
            {label = "SC 1", model = "sc1", price = 120000},
            {label = "Sultan RS", model = "sultanrs", price = 95000},
            {label = "T20", model = "t20", price = 150000},
            {label = "Turismo R", model = "turismor", price = 150000},
            {label = "Turismo 2", model = "Turismo2", price = 50000},
            {label = "Tempesta", model = "tempesta", price = 150000},
            {label = "Tezeract", model = "tezeract", price = 120000},
            {label = "Tyrus", model = "tyrus", price = 140000},
            {label = "Vacca", model = "vacca", price = 120000},
            {label = "Voltic", model = "voltic", price = 70000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Visione", model = "visione", price = 150000},
            {label = "X80 Proto", model = "prototipo", price = 150000},
            {label = "Zentorno", model = "zentorno", price = 150000},
            {label = "Zeno", model = "zeno", price = 77500},
            {label = "Zorrusso", model = "zorrusso", price = 140000},
        },
        [9] = {
            --suvs
            {label = "Astron", model = "astron", price = 42000},
            {label = "BJXL", model = "bjxl", price = 30000},
            {label = "Baller", model = "baller2", price = 66000},
            {label = "Baller Sport", model = "baller3", price = 74800},
            {label = "Baller4", model = "baller4", price = 96800},
            {label = 'Baller ST', model = "baller7", price = 47000},
            {label = "Cavalcade2", model = "cavalcade", price = 18480},
            {label = "Cavalcade", model = "cavalcade2", price = 55000},
            {label = "Contender", model = "contender", price = 34000},
            {label = "Dubsta", model = "dubsta", price = 30800},
            {label = "Dubsta Luxuary", model = "dubsta2", price = 66000},
            {label = "Dubsta3", model = "dubsta3", price = 65000},
            {label = "Fhantom", model = "fq2", price = 22000},
            {label = "Grabger", model = "granger", price = 44000},
            {label = "Granger", model = "granger", price = 34500},
            {label = "Gresley", model = "gresley", price = 16720},
            {label = "Habanero", model = "habanero", price = 30000},
            {label = "Huntley S", model = "huntley", price = 74800},
            {label = "i-wagen", model = "iwagen", price = 35000},
            {label = "Landstalker", model = "landstalker", price = 20240},
            {label = "Landstalker 2", model = "landstalker2", price = 32000},
            {label = "Mesa", model = "mesa", price = 15840},
            {label = "Mesa Trail", model = "mesa3", price = 29000},
            {label = "Novak", model = "Novak", price = 30000},
            {label = "Patriot", model = "patriot", price = 79200},
            {label = "Radius", model = "radi", price = 7920},
            {label = "Rancher XL", model = "rancherxl", price = 25000},
            {label = "Rebla", model = "rebla", price = 37500},
            {label = "Rocoto", model = "rocoto", price = 45000},
            {label = "Seminole", model = "seminole", price = 14080},
            {label = "Seminole 2", model = "seminole2", price = 18500},
            {label = "Toros", model = "toros", price = 32000},
            {label = "XLS", model = "xls", price = 61600},
        },
        [10] = {
            --vans
            {label = "Bison", model = "bison", price = 14960},
            {label = "Bobcat XL", model = "bobcatxl", price = 32000},
            {label = "Burrito", model = "burrito3", price = 26400},
            {label = "Burrito 2", model = "gburrito2", price = 27500},
            {label = "Camper", model = "camper", price = 42000},
            {label = "Gang Burrito", model = "gburrito", price = 30800},
            {label = "Journey", model = "journey", price = 13200},
            {label = "Minivan", model = "minivan", price = 12320},
            {label = "Minivan Custom", model = "minivan2", price = 20000},
            {label = "Moonbeam", model = "moonbeam", price = 13200},
            {label = "Moonbeam Rider", model = "moonbeam2", price = 16720},
            {label = "Paradise", model = "paradise", price = 13200},
            {label = "Rumpo", model = "rumpo", price = 26400},        
            {label = "Surfer", model = "surfer", price = 12000},
            {label = "Youga", model = "youga", price = 14960},
            {label = "Youga Luxuary", model = "youga2", price = 23500},
            {label = "Youga 4x4", model = "youga3", price = 24000},
        },
        [11] = {
            -- job
            {label = "boxville Burgershot", model = "boxville_burgershot", price = 50000},
            {label = "Karting", model = "veto2", price = 50000},
            {label = "slamtruck", model = "slamtruck", price = 50000},
            {label = "Stalion2 Burger Shot", model = "stalion2", price = 50000},
            {label = "Taco Burgershot", model = "taco_burgershot", price = 50000},
            {label = "Taco Chinois", model = "taco_china", price = 50000},
            {label = "Taco Peals", model = "taco_pearls", price = 50000},
            {label = "Taco Pop Dinners", model = "taco_pop_dinner", price = 50000},
            {label = "Taco pizzeria", model = "taco_shanchez", price = 50000},
            {label = "Prius Taxi", model = "taxi", price = 50000},
            {label = "towtruck", model = "towtruck", price = 50000},
            {label = "towtruck2", model = "towtruck2", price = 50000},
            {label = "weazelnews van", model = "newsvan2", price = 50000},
            {label = "Younga cutsom", model = "youga4", price = 50000},
        },
        [12] = {
            -- job
            {label = "Audi RS3 SB 2018", model = "rs318", price = 200000},
            {label = "Audi rs7 c8", model = "rs7c8", price = 200000},
            {label = "Mercedes BRABUS 850", model = "brabus850", price = 200000},
            {label = "BMW M5 2020", model = "22m5", price = 210000},
            {label = "BMW M4 GTS", model = "rmodm4gts", price = 200000},
        },
    },
}

ConcessTruck = {}
ConcessTruck.kSelected = nil
ConcessTruck.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessTruck.NumberPlate = {}
ConcessTruck.LettePlate = {}
ConfigTruckShop = {

    points = {
        {achat = vector3(900.2665,-1154.765,25.160)}
    },
    ["TRUCK"] = { 
            [1] = { 
                { label = "Mule 3", model = "mule3", price = 40000 },
                { label = "Mule 1", model = "mule", price = 40000 },
                { label = "Mule 2", model = "mule2", price = 40000 }, 
                { label = "Taco", model = "taco", price = 40000 }, 
                { label = "Boxville 4", model = "boxville4", price = 45000 }, 
                { label = "Boxville 3", model = "boxville3", price = 45000 }, 
                { label = "Boxville 2", model = "boxville2", price = 45000 }, 
                { label = "Boxville 1", model = "boxville", price = 45000 },
                { label = "Benson", model = "benson", price = 55000 }, 
                { label = "Pounder", model = "pounder", price = 55000 }, 
                { label = "Flatbed", model = "flatbed", price = 55000 },
            },
            [2] = { 
                { label = "Phantom Custom", model = "phantom3", price = 110000 },
                { label = "Packer", model = "packer", price = 100000 },
                { label = "Hauler", model = "hauler", price = 100000 }, 
                { label = "Phantom", model = "phantom", price = 105000 }, 
            },
            [3] = { 
                { label = "Rubble", model = "rubble", price = 30000 },
                { label = "Tipper 1", model = "tiptruck", price = 30000 },
                { label = "Tipper 2", model = "tiptruck2", price = 30000 }, 
                { label = "Scrap Truck", model = "scrap", price = 10000 }, 
                { label = "Field Master", model = "tractor2", price = 15000 }, 
                { label = "Mixer 2", model = "mixer2", price = 30000 }, 
                { label = "Mixer 1", model = "mixer", price = 30000 }, 
                { label = "Biff", model = "biff", price = 30000 }, 
            },
            [4] = { 
                { label = "Tanker", model = "tanker", price = 50000 },
                { label = "Remorque 1", model = "trailers2", price = 50000 },
                { label = "Remorque 2", model = "trailers3", price = 50000 },
                { label = "Remorque 3", model = "trailers4", price = 50000 },
                { label = "Remorque 4", model = "trailerlogs", price = 50000 },
                { label = "Plateau", model = "trflat", price = 50000 },
            },
            [5] = { 
                { label = "Festival Bus", model = "pbus2", price = 125000 },
                { label = "Tour Bus", model = "tourbus", price = 35000 },
                { label = "Bus", model = "bus", price = 50000 }, 
                { label = "Dashound", model = "coach", price = 50000 }, 
                { label = "Rental Bus", model = "rentalbus", price = 35000 }, 
                { label = "Airport Bus", model = "airbus", price = 50000 }, 
            }
        }
}

ConcessAir = {}
ConcessAir.kSelected = nil
ConcessAir.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessAir.NumberPlate = {}
ConcessAir.LettePlate = {}
ConfigAirShop = {

    points = {
        {achat = vector3(-928.6401,-2994.45,19.84)}
    },
    ["AIR"] = { 
            [1] = { 
                { label = "Buzzard", model = "buzzard2", price = 500000 },
                { label = "Swift Deluxe", model = "swift2", price = 1250000 },
                { label = "Swift", model = "swift", price = 1000000 }, 
                { label = "SuperVolito Carbon", model = "supervolito2", price = 1250000 }, 
                { label = "SuperVolito", model = "supervolito", price = 1000000 }, 
                { label = "Sea Sparrow", model = "seasparrow", price = 815000 }, 
                { label = "Volatus", model = "volatus", price = 1250000 }, 
                { label = "Maverick", model = "maverick", price = 750000 },
                { label = "Frogger", model = "frogger", price = 800000 }, 
                { label = "Havok", model = "havok", price = 250000 }, 
            },
            [2] = { 
                { label = "Vestra", model = "vestra", price = 950000 },
                { label = "Velum", model = "velum2", price = 450000 },
                { label = "Cuban 800", model = "cuban800", price = 240000 }, 
                { label = "Dodo", model = "dodo", price = 500000 }, 
                { label = "Duster", model = "duster", price = 175000 },
                { label = "Mammatus", model = "mammatus", price = 300000 },
                { label = "Shamal", model = "shamal", price = 1150000 }, 
                { label = "Sea Breeze", model = "seabreeze", price = 850000 },                 
                { label = "Luxor", model = "luxor", price = 1500000 },
                { label = "Ultra Light", model = "microlight", price = 50000 },
                { label = "Luxor Deluxe ", model = "luxor2", price = 1750000 }, 
                { label = "Nimbus", model = "nimbus", price = 900000 }, 
            },
        }
}

ConcessBoat = {}
ConcessBoat.kSelected = nil
ConcessBoat.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessBoat.NumberPlate = {}
ConcessBoat.LettePlate = {}
ConfigBoatShop = {
    price = 10000,

    points = {
        {achat = vector3(-706.85, -1321.998, 5.1)}
    },
    ["BOAT"] = { 
            [1] = { 
                { label = "Dinghy 4Seat", model = "dinghy", price = 22000 },
                { label = "Dinghy 2Seat", model = "dinghy2", price = 20000 },
                { label = "Dinghy Yacht", model = "dinghy4", price = 25000 }, 
                { label = "Jetmax", model = "jetmax", price = 30000 }, 
                { label = "Marquis", model = "marquis", price = 45000 }, 
                { label = "Seashark", model = "seashark", price = 10000 }, 
                { label = "Seashark Yacht", model = "seashark3", price = 10000 }, 
                { label = "Speeder", model = "speeder", price = 40000 },
                { label = "Squalo", model = "squalo", price = 32000 }, 
                { label = "Suntrap", model = "suntrap", price = 34000 }, 
                { label = "Toro", model = "toro", price = 38000 }, 
                { label = "Toro Yacht", model = "toro2", price = 38000 }, 
                { label = "Tropic", model = "tropic", price = 27000 }, 
                { label = "Tropic Yacht", model = "tropic2", price = 27000 }, 
                { label = "Chalutier", model = "tug", price = 80000 }, 
            },
        }
}

-----[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[       CONCESS 2        ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]------------------
ConcessCardealer2 = {}
ConcessCardealer2.kSelected = nil
ConcessCardealer2.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessCardealer2.NumberPlate = {}
ConcessCardealer2.LettePlate = {}
ConfigCardealer2Shop = {

    points = {
        achat = vector3(1223.406,2733.635,37.97),
        vestiaire = vector3(1228.679,2735.96,37.97),
        catalogue = vector3(1218.57,2728.699,38.00)

    },
    ["Voiture"] = {
        [1] = {
            --moto
            {label = "Akuma", model = "AKUMA", price = 12500},
            {label = "Avarus", model = "avarus", price = 14000},
            {label = "BF400", model = "bf400", price = 18750},
            {label = "BMX (velo)", model = "bmx", price = 250},
            {label = "Bagger", model = "bagger", price = 15000},
            {label = "Bati 801", model = "bati", price = 18500},
            {label = "Bati 801RR", model = "bati2", price = 20000},
            {label = "Carbon RS", model = "carbonrs", price = 25000},
            {label = "Chimera", model = "chimera", price = 25700},
            {label = "Cliffhanger", model = "cliffhanger", price = 25600},
            {label = "Cruiser (velo)", model = "cruiser", price = 510},
            {label = "Daemon", model = "daemon", price = 20500},
            {label = "Daemon High", model = "daemon2", price = 22500},
            {label = "Defiler", model = "defiler", price = 21800},
            {label = "Double T", model = "double", price = 28000},
            {label = "Enduro", model = "enduro", price = 15500},
            {label = "Esskey", model = "esskey", price = 16200},
            {label = "Faggio", model = "faggio", price = 1500},
            {label = "Fixter (velo)", model = "fixter", price = 100},
            {label = "Gargoyle", model = "gargoyle", price = 31500},
            {label = "Hakuchou", model = "hakuchou", price = 22222},
            {label = "Hakuchou Sport", model = "hakuchou2", price = 27000},
            {label = "Hexer", model = "hexer", price = 27500},
            {label = "Innovation", model = "innovation", price = 23000},
            {label = "Manchez", model = "manchez", price = 12000},
            {label = "Manchez 2", model = "manchez2", price = 15000},
            {label = "Nemesis", model = "nemesis", price = 17500},
            {label = "Nightblade", model = "nightblade", price = 26700},
            {label = "PCJ-600", model = "pcj", price = 22000},
            {label = "Rat bike", model = "ratbike", price = 20000},
            {label = "Rrocket", model = "rrocket", price = 35000},
            {label = "Ruffian", model = "ruffian", price = 20000},
            {label = "Sanchez", model = "sanchez", price = 8000},
            {label = "Sanchez Sport", model = "sanchez2", price = 8500},
            {label = "Sanctus", model = "sanctus", price = 35000},
            {label = "Scorcher (velo)", model = "scorcher", price = 500},
            {label = "Sovereign", model = "sovereign", price = 25000},
            {label = "Tri bike (velo)", model = "tribike3", price = 520},
            {label = "Vader", model = "vader", price = 20000},
            {label = "Vespa", model = "faggio2", price = 2200},
            {label = "Vortex", model = "Vortex", price = 27500},
            {label = "Woflsbane", model = "wolfsbane", price = 27000},
            {label = "Zombie", model = "zombiea", price = 23600},
            {label = "Zombie Luxuary", model = "zombieb", price = 27000},
            {label = "shotaro", model = "shotaro", price = 35000},
        },
        [2] = {
            --motoimport
            {label = "103 Sport", model = "mobi", price = 3000},
            {label = "Augusta F4", model = "f4rr", price = 25000},
            {label = "Diavel", model = "diavel", price = 25000},
            {label = "Harley 1", model = "hdfb", price = 32000},
            {label = "Harley 2", model = "hdss", price = 25000},
            {label = "Harley 3", model = "hdkn", price = 32000},
            {label = "Y1700 Max", model = "Y1700MAX", price = 25000},
            {label = "Z1000", model = "z1000", price = 37000},
            {label = "goldwing", model = "goldwing", price = 35000},
            {label = "gsxr", model = "gsxr", price = 40000},
            {label = "h2carb", model = "h2carb", price = 65000},
            {label = "msx", model = "msx", price = 25000},
            {label = "mxv450sm", model = "mxv450sm", price = 22000},
            {label = "pitbike", model = "pitbike", price = 10000},
            {label = "r1", model = "r1", price = 42000},
            {label = "r6", model = "r6", price = 35900},
            {label = "rmz2", model = "rmz2", price = 20000},
            {label = "sxf450", model = "sxf450", price = 22000},
            {label = "sxf450sm", model = "sxf450sm", price = 35000},
            {label = "tmaxDX", model = "tmaxDX", price = 30000},
            {label = "tmsm", model = "tmsm", price = 25000},
            {label = "zx10r", model = "zx10r", price = 47000},
        },
    },
}

-----[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[       CONCESS 3        ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]------------------
ConcessCardealer3 = {}
ConcessCardealer3.kSelected = nil
ConcessCardealer3.InfosVeh = {props = nil, entity = nil, model = nil}
ConcessCardealer3.NumberPlate = {}
ConcessCardealer3.LettePlate = {}
ConfigCardealer3Shop = {

    points = {
        achat = vector3(-27.599,-1097.487,27.27),
        vestiaire = vector3(-30.42,-1105.646,27.27),
        catalogue = vector3(-40.61,-1090.23,27.27)

    },
    ["Voiture"] = {
        [1] = {
            --compacts
            {label = "Brioso 3", model = "brioso3", price = 5000},
            {label = "Brioso R/A", model = "brioso", price = 5500},
            {label = "Blista", model = "blista", price = 6000},
            {label = "Blista Kanjo", model = "kanjo", price = 8000},
            {label = "Blista Asbo", model = "asbo", price = 8000},
            {label = "Brioso ", model = "brioso2", price = 7000},
            {label = "Club", model = "club", price = 5000},
            {label = "Issi", model = "issi2", price = 8500},
            {label = "Kalahari", model = "kalahari", price = 12000},
            {label = "Panto", model = "panto", price = 5000},
            {label = "Prairie", model = "prairie", price = 10000},
            {label = "Rhapsody", model = "rhapsody", price = 5500},
            {label = "Weevil", model = "weevil", price = 8000},
        },
        [2] = {
            --coupes
            {label = "Cognoscenti Cabrio", model = "cogcabrio", price = 30000},
            {label = "Dinka Kanjo SJ", model = "kanjosj", price = 25000},
            {label = "Exemplar", model = "exemplar", price = 35000},
            {label = "F620", model = "f620", price = 35000},
            {label = "Felon", model = "felon", price = 69000},
            {label = "Felon GT", model = "felon2", price = 75000},
            {label = "Jackal", model = "jackal", price = 30000},
            {label = "Oracle", model = "oracle", price = 25000},
            {label = "Oracle XS", model = "oracle2", price = 30000},
            {label = "Prévion", model = "previon", price = 50000},
            {label = "Sentinel", model = "sentinel", price = 33000},
            {label = "Sentinel XS", model = "sentinel2", price = 34000},
            {label = "Windsor Drop", model = "windsor2", price = 50000},
            {label = "Zion", model = "zion", price = 32000},
            {label = "Zion Cabrio", model = "zion2", price = 35000},

        },
        [3] = {
            --sedans
            {label = "Asea", model = "asea", price = 8000},
            {label = "Cognoscenti", model = "cognoscenti", price = 28500},
            {label = "Emperor", model = "emperor", price = 12000},
            {label = "Fugitive", model = "fugitive", price = 20000},
            {label = "Glendale", model = "glendale", price = 11500},
            {label = "Glendale 2", model = "glendale2", price = 13000},
            {label = "Intruder", model = "intruder", price = 12500},
            {label = "Premier", model = "premier", price = 11500},
            {label = "Primo", model = "primo", price = 12500},
            {label = "Primo Custom", model = "primo2", price = 14000},
            {label = "Regina", model = "regina", price = 9000},
            {label = "Rhinehart", model = "rhinehart", price = 42500},
            {label = "Schafter - 2", model = "schafter2", price = 23000},
            {label = "Stafford", model = "stafford", price = 25000},
            {label = "Stanier", model = "stanier", price = 20000},
            {label = "Stratum", model = "stratum", price = 23000},
            {label = "Stretch", model = "stretch", price = 24500},
            {label = "Super Diamond", model = "superd", price = 24500},
            {label = "Tailgater", model = "tailgater", price = 40000},
            {label = "Tailgater 2", model = "tailgater2", price = 45000},
            {label = "Warrener", model = "warrener", price = 19500},
            {label = "Warrener HKR", model = "warrener2", price = 25000},
            {label = "Washington", model = "washington", price = 22500},           
        },
        [4] = {
            --muscle
            {label = "Blade", model = "blade", price = 25000},
            {label = "Bravado greenwood", model = "greenwood", price = 30500},
            {label = "Buccaneer", model = "buccaneer", price = 20000},
            {label = "Buccaneer Rider", model = "buccaneer2", price = 25500},
            {label = "Chino", model = "chino", price = 23000},
            {label = "Chino Luxe", model = "chino2", price = 25500},
            {label = "Clique", model = "clique", price = 19000},
            {label = "Coquette BlackFin", model = "coquette3", price = 24500},
            {label = "Declasse Vigero ZX", model = "vigero2", price = 34500},
            {label = "Deviant", model = "deviant", price = 25000},
            {label = "Dominator", model = "dominator", price = 32000},
            {label = "Dominator 3", model = "dominator3", price = 32000},
            {label = "Dominator 7", model = "dominator7", price = 35000},
            {label = "Dukes", model = "dukes", price = 23500},
            {label = "Dukes 3", model = "dukes3", price = 19500},
            {label = "Ellie", model = "ellie", price = 25000},
            {label = "Faction", model = "faction", price = 28000},
            {label = "Faction Rider", model = "faction2", price = 30000},
            {label = "Faction XL", model = "faction3", price = 35000},
            {label = "Gauntlet", model = "gauntlet", price = 30000},
            {label = "Gauntlet 3", model = "gauntlet3", price = 25000},
            {label = "Gauntlet 4", model = "gauntlet4", price = 27500},
            {label = "Gauntlet 5", model = "gauntlet5", price = 28000},
            {label = "Hermes", model = "hermes", price = 37500},
            {label = "Hotknife", model = "hotknife", price = 32500},
            {label = "Hustler", model = "hustler", price = 31500},
            {label = "Impaler", model = "impaler", price = 17500},
            {label = "Nightshade", model = "nightshade", price = 35000},
            {label = "Peyote 2", model = "peyote2", price = 25000},
            {label = "Phoenix", model = "phoenix", price = 27500},            
            {label = "Picador", model = "picador", price = 23000},
            {label = "Ruiner 4", model = "ruiner4", price = 40000},
            {label = "Sabre GT", model = "sabregt2", price = 30000},
            {label = "Sabre Turbo", model = "sabregt", price = 27500},
            {label = "Slam Van", model = "slamvan", price = 25000},
            {label = "Slam Van 3", model = "slamvan3", price = 31000},
            {label = "Stallion", model = "stalion", price = 22000},
            {label = "Tampa", model = "tampa", price = 25000},
            {label = "Tulip", model = "tulip", price = 25000},
            {label = "Vamos", model = "vamos", price = 30000},
            {label = "Vigero", model = "vigero", price = 24500},
            {label = "Virgo", model = "virgo", price = 27500},
            {label = "Virgo Classique Custom", model = "virgo2", price = 30000},
            {label = "Voodoo", model = "voodoo", price = 26000},
            {label = "Weevil 2", model = "weevil2", price = 35000},
            {label = "Yosemite", model = "yosemite", price = 21500},
            {label = "Yosemite 2", model = "yosemite2", price = 24000},
            {label = "Yosemite 3", model = "yosemite3", price = 25000},

        },
        [5] = {
            --offroad
            {label = "Bf Injection", model = "bfinjection", price = 23500},
            {label = "Bifta", model = "bifta", price = 26500},
            {label = "Blazer", model = "blazer", price = 7500},
            {label = "Blazer Sport", model = "blazer4", price = 14000},
            {label = "Brawler", model = "brawler", price = 26000},
            {label = "Bubsta 6x6", model = "dubsta3", price = 35000},
            {label = "Caracara 2", model = "caracara2", price = 25500},
            {label = "Deckasse Draugur", model = "draugur", price = 45000},
            {label = "Everon", model = "everon", price = 29500},
            {label = "Freecrawler", model = "freecrawler", price = 35000},
            {label = "Guardian", model = "guardian", price = 32500},
            {label = "Hellion", model = "hellion", price = 17500},
            {label = "Kamacho", model = "kamacho", price = 32500},
            {label = "Outlaw", model = "outlaw", price = 15500},
            {label = "Rebel", model = "rebel2", price = 27500},
            {label = "Riata", model = "riata", price = 27500},
            {label = "Sandking", model = "sandking", price = 35000},
            {label = "Trophytruck", model = "trophytruck", price = 30000},
            {label = "Trophytruck 2", model = "trophytruck2", price = 30000},
            {label = "Vagrant", model = "vagrant", price = 21000},
            {label = "Verus", model = "verus", price = 13000},
            {label = "Winky", model = "winky", price = 19000},
        },
        [6] = {
            --sports
            {label = "9F", model = "ninef", price = 47500},
            {label = "9F Cabrio", model = "ninef2", price = 50000},
            {label = "Alpha", model = "alpha", price = 33000},
            {label = "Banshee", model = "banshee", price = 36000},
            {label = "Banshee2", model = "Banshee2", price = 38500},
            {label = "Benefactor SM722", model = "sm722", price = 45000},
            {label = "Bestia GTS", model = "bestiagts", price = 45000},
            {label = "Buffalo", model = "buffalo", price = 36000},
            {label = "Buffalo S", model = "buffalo2", price = 38500},
            {label = "CalicoGTF", model = "calico", price = 32000},
            {label = "Carbonizzare", model = "carbonizzare", price = 47500},
            {label = "Cinquemilla", model = "cinquemila", price = 50000},
            {label = "Comet", model = "comet2", price = 45000},
            {label = "Comet 5", model = "comet5", price = 46500},
            {label = "Comet Retro Custom", model = "comet3", price = 45000},
            {label = "Comet S2", model = "comet6", price = 40000},
            {label = "Comet S2 Cab", model = "comet7", price = 47000},
            {label = "Comet Safari", model = "comet4", price = 55000},
            {label = "Coquette", model = "coquette", price = 48000},
            {label = "Cypher", model = "cypher", price = 28000},
            {label = "Drafter", model = "drafter", price = 47500},
            {label = "Elegy", model = "elegy2", price = 40000},
            {label = "Elegy Classique", model = "elegy", price = 28000},
            {label = "Euros", model = "euros", price = 35000},
            {label = "Feltzer", model = "feltzer2", price = 45000},
            {label = "FlashGT", model = "flashgt", price = 40000},
            {label = "Furore GT", model = "furoregt", price = 40000},
            {label = "Fusilade", model = "fusilade", price = 42000},
            {label = "Growler", model = "growler", price = 32000},
            {label = "Imorgon", model = "imorgon", price = 30000},
            {label = "Issi 7", model = "issi7", price = 48500},
            {label = "Italirsx", model = "italirsx", price = 65000},
            {label = "Jester", model = "jester", price = 65000},
            {label = "Jester RR", model = "jester4", price = 75000},
            {label = "Jester(Racecar)", model = "jester2", price = 67500},
            {label = "Jugular", model = "jugular", price = 50000},
            {label = "Khamelion", model = "khamelion", price = 37500},
            {label = "Komoda", model = "komoda", price = 50000},
            {label = "Kuruma", model = "kuruma", price = 40000},
            {label = "Lampadati Corsita", model = "corsita", price = 65000},
            {label = "Locust", model = "locust", price = 40000},
            {label = "Lynx", model = "lynx", price = 55000},
            {label = "Mamba", model = "mamba", price = 42000},
            {label = "Massacro", model = "massacro", price = 42500},
            {label = "Massacro(Racecar)", model = "massacro2", price = 45000},
            {label = "Neo", model = "neo", price = 55000},
            {label = "Neon", model = "neon", price = 60000},
            {label = "Obey Omnis u-gt", model = "omnisegt", price = 60000},
            {label = "Omnis", model = "omnis", price = 30000},
            {label = "Paragon", model = "paragon", price = 57500},
            {label = "Pariah", model = "pariah", price = 47500},
            {label = "Penumbra", model = "penumbra", price = 32000},
            {label = "Penumbra 2", model = "penumbra2", price = 34000},
            {label = "Raiden", model = "raiden", price = 48000},
            {label = "Rapid GT", model = "rapidgt", price = 54500},
            {label = "Rapid GT Convertible", model = "rapidgt2", price = 75000},
            {label = "Revolter", model = "revolter", price = 35500},
            {label = "Rt3000", model = "rt3000", price = 50000},
            {label = "Schafter V12", model = "schafter3", price = 48500},
            {label = "Schlagen", model = "schlagen", price = 45000},
            {label = "Sentinel 4", model = "sentinel4", price = 40500},
            {label = "Sentinel3", model = "sentinel3", price = 35500},
            {label = "Seven 70", model = "seven70", price = 54000},
            {label = "Streiter", model = "streiter", price = 28500},
            {label = "Sultan", model = "sultan", price = 22500},
            {label = "Sultan 2", model = "sultan2", price = 25000},
            {label = "Surano", model = "surano", price = 35500},
            {label = "Tampa 2", model = "tampa2", price = 32000},
            {label = "Tropos", model = "tropos", price = 38500},
            {label = "Vectre", model = "vectre", price = 35000},
            {label = "Verlierer", model = "verlierer2", price = 44000},
            {label = "Vstr", model = "vstr", price = 35500},
            {label = "ZR350", model = "ZR350", price = 35000},
            {label = "italigto", model = "italigto", price = 65000},
            {label = "xa21", model = "xa21", price = 65000},
        },
        [7] = {
            --sport classique
            {label = "Ardent", model = "ardent", price = 48000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Btype", model = "btype", price = 50000},
            {label = "Btype", model = "btype", price = 50000},
            {label = "Btype Hotroad", model = "btype2", price = 52500},
            {label = "Btype Luxe", model = "btype3", price = 55000},
            {label = "Casco", model = "casco", price = 49000},
            {label = "cheburek", model = "cheburek", price = 17500},
            {label = "cheetah2", model = "cheetah2", price = 52500},
            {label = "Coquette Classic", model = "coquette2", price = 52500},
            {label = "Dynasty", model = "dynasty", price = 25000},
            {label = "Futo classique", model = "Futo2", price = 18500},
            {label = "fagaloa", model = "fagaloa", price = 25000},
            {label = "GT 500", model = "gt500", price = 45000},
            {label = "infernus2", model = "infernus2", price = 42500},
            {label = "Jester Classique", model = "jester3", price = 40000},
            {label = "Manana", model = "manana", price = 12320},
            {label = "Manana 2", model = "manana2", price = 27500},
            {label = "Michelli GT", model = "michelli", price = 22000},
            {label = "Monroe", model = "monroe", price = 55000},
            {label = "Nebula", model = "nebula", price = 17500},
            {label = "Pigalle", model = "pigalle", price = 22000},
            {label = "Peyote 3", model = "peyote3", price = 34500},
            {label = "Rapid GT3", model = "rapidgt3", price = 135000},
            {label = "Retinue", model = "retinue", price = 26400},
            {label = "Rapid GT3", model = "rapidgt3", price = 35000},
            {label = "Remus", model = "remus", price = 30000},
            {label = "Retinue 2", model = "retinue2", price = 25500},
            {label = "Savestra", model = "savestra", price = 40000},
            {label = "Stirling GT", model = "feltzer3", price = 55000},
            {label = "Stinger", model = "stinger", price = 48500},
            {label = "tornado", model = "tornado", price = 17500},
            {label = "tornado2", model = "tornado2", price = 17500},
            {label = "tornado3", model = "tornado3", price = 17500},
            {label = "tornado4", model = "tornado4", price = 17500},
            {label = "tornado5", model = "tornado5", price = 17500},
            {label = "tornado6", model = "tornado6", price = 17500},
            {label = "Viseris", model = "viseris", price = 50000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Z-Type", model = "ztype", price = 80000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Zion 3", model = "zion3", price = 27500},
        },
        [8] = {
            --super
            {label = "Adder", model = "adder", price = 80000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Autarch", model = "autarch", price = 80000},
            {label = "Banshee 900R", model = "banshee2", price = 64000},
            {label = "Benefactor LM87", model = "lm87", price = 135000},
            {label = "Bullet", model = "bullet", price = 57500},
            {label = "Cyclone", model = "cyclone", price = 65000},
            {label = "Cheetah", model = "cheetah", price = 70000},
            {label = "Deveste", model = "deveste", price = 125000},
            {label = "ETR1", model = "sheava", price = 130000},
            {label = "Entity XF", model = "entityxf", price = 68000},
            {label = "Emerus", model = "emerus", price = 75000},
            {label = "FMJ", model = "fmj", price = 74500},
            {label = "Furia", model = "furia", price = 67500},
            {label = "Infernus", model = "infernus", price = 69000},
            {label = "Ignus", model = "ignus", price = 160000},
            {label = "Krieger", model = "krieger", price = 85000},
            {label = "Osiris", model = "osiris", price = 75500},
            {label = "Pfister", model = "pfister811", price = 70000},
            {label = "Pegasi Torero XO", model = "torero2", price = 60000},
            {label = "Pegasi Torero XO", model = "torero2", price = 60000},
            {label = "Pfister", model = "pfister811", price = 70000},
            {label = "RE-7B", model = "le7b", price = 120000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Reaper", model = "reaper", price = 130000},
            {label = "S80", model = "s80", price = 130000},
            {label = "SC 1", model = "sc1", price = 120000},
            {label = "Sultan RS", model = "sultanrs", price = 95000},
            {label = "T20", model = "t20", price = 150000},
            {label = "Turismo R", model = "turismor", price = 150000},
            {label = "Turismo 2", model = "Turismo2", price = 50000},
            {label = "Tempesta", model = "tempesta", price = 150000},
            {label = "Tezeract", model = "tezeract", price = 120000},
            {label = "Tyrus", model = "tyrus", price = 140000},
            {label = "Vacca", model = "vacca", price = 120000},
            {label = "Voltic", model = "voltic", price = 70000}, -- prix a validé véhicule non présent sur le fichier sql
            {label = "Visione", model = "visione", price = 150000},
            {label = "X80 Proto", model = "prototipo", price = 150000},
            {label = "Zentorno", model = "zentorno", price = 150000},
            {label = "Zeno", model = "zeno", price = 77500},
            {label = "Zorrusso", model = "zorrusso", price = 140000},
        },
        [9] = {
            --suvs
            {label = "Astron", model = "astron", price = 42000},
            {label = "BJXL", model = "bjxl", price = 30000},
            {label = "Baller", model = "baller2", price = 66000},
            {label = "Baller Sport", model = "baller3", price = 74800},
            {label = "Baller4", model = "baller4", price = 96800},
            {label = 'Baller ST', model = "baller7", price = 47000},
            {label = "Cavalcade2", model = "cavalcade", price = 18480},
            {label = "Cavalcade", model = "cavalcade2", price = 55000},
            {label = "Contender", model = "contender", price = 34000},
            {label = "Dubsta", model = "dubsta", price = 30800},
            {label = "Dubsta Luxuary", model = "dubsta2", price = 66000},
            {label = "Dubsta3", model = "dubsta3", price = 65000},
            {label = "Fhantom", model = "fq2", price = 22000},
            {label = "Grabger", model = "granger", price = 44000},
            {label = "Granger", model = "granger", price = 34500},
            {label = "Gresley", model = "gresley", price = 16720},
            {label = "Habanero", model = "habanero", price = 30000},
            {label = "Huntley S", model = "huntley", price = 74800},
            {label = "i-wagen", model = "iwagen", price = 35000},
            {label = "Landstalker", model = "landstalker", price = 20240},
            {label = "Landstalker 2", model = "landstalker2", price = 32000},
            {label = "Mesa", model = "mesa", price = 15840},
            {label = "Mesa Trail", model = "mesa3", price = 29000},
            {label = "Novak", model = "Novak", price = 30000},
            {label = "Patriot", model = "patriot", price = 79200},
            {label = "Radius", model = "radi", price = 7920},
            {label = "Rancher XL", model = "rancherxl", price = 25000},
            {label = "Rebla", model = "rebla", price = 37500},
            {label = "Rocoto", model = "rocoto", price = 45000},
            {label = "Seminole", model = "seminole", price = 14080},
            {label = "Seminole 2", model = "seminole2", price = 18500},
            {label = "Toros", model = "toros", price = 32000},
            {label = "XLS", model = "xls", price = 61600},
        },
        [10] = {
            --vans
            {label = "Bison", model = "bison", price = 14960},
            {label = "Bobcat XL", model = "bobcatxl", price = 32000},
            {label = "Burrito", model = "burrito3", price = 26400},
            {label = "Burrito 2", model = "gburrito2", price = 27500},
            {label = "Camper", model = "camper", price = 42000},
            {label = "Gang Burrito", model = "gburrito", price = 30800},
            {label = "Journey", model = "journey", price = 13200},
            {label = "Minivan", model = "minivan", price = 12320},
            {label = "Minivan Custom", model = "minivan2", price = 20000},
            {label = "Moonbeam", model = "moonbeam", price = 13200},
            {label = "Moonbeam Rider", model = "moonbeam2", price = 16720},
            {label = "Paradise", model = "paradise", price = 13200},
            {label = "Rumpo", model = "rumpo", price = 26400},        
            {label = "Surfer", model = "surfer", price = 12000},
            {label = "Youga", model = "youga", price = 14960},
            {label = "Youga Luxuary", model = "youga2", price = 23500},
            {label = "Youga 4x4", model = "youga3", price = 24000},
        },
        [11] = {
            -- job
            {label = "boxville Burgershot", model = "boxville_burgershot", price = 50000},
            {label = "Karting", model = "veto2", price = 50000},
            {label = "slamtruck", model = "slamtruck", price = 50000},
            {label = "Stalion2 Burger Shot", model = "stalion2", price = 50000},
            {label = "Taco Burgershot", model = "taco_burgershot", price = 50000},
            {label = "Taco Chinois", model = "taco_china", price = 50000},
            {label = "Taco Peals", model = "taco_pearls", price = 50000},
            {label = "Taco Pop Dinners", model = "taco_pop_dinner", price = 50000},
            {label = "Taco pizzeria", model = "taco_shanchez", price = 50000},
            {label = "Prius Taxi", model = "taxi", price = 50000},
            {label = "towtruck", model = "towtruck", price = 50000},
            {label = "towtruck2", model = "towtruck2", price = 50000},
            {label = "weazelnews van", model = "newsvan2", price = 50000},
            {label = "Younga cutsom", model = "youga4", price = 50000},
        },
        [12] = {
            -- job
            {label = "Mercedes Classe G900 Brabus", model = "2020g900", price = 200000},
            {label = "Cadillac Escalade 2021", model = "cesc21", price = 200000},
            {label = "Lexus LFA", model = "lfa", price = 200000},
            {label = "Maserati GTS", model = "mqgts", price = 210000},
            {label = "Dodge Ram", model = "ram1500", price = 190000},
        },
    },
}

MissionTaxi = {
    {
        pos = vector3(1098.97, -242.57, 69.29),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.3},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1103.08, -371.65, 67.12),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(992.31, -654.98, 57.47),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1173.93, -823.29, 55.01),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1243.01, -1417.40, 34.70),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1266.66, -2036.89, 43.92),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(909.36, -2458.45, 28.23),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(706.98, -2771.57, 6.00),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(152.92, -2587.01, 5.66),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-255.91, -2652.01, 5.65),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-43.32, -2430.10, 5.65),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(365.81, -2204.69, 12.44),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-142.82, -2079.48, 25.43),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-748.10, -1775.18, 29.00),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-691.39, -1421.74, 4.65),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-935.28, -1203.80, 4.79),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-995.89, -1608.29, 4.69),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-1256.97, -1286.72, 3.59),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-1399.78, -929.82, 10.69),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-1625.89, -593.35, 32.95),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-1919.45, -211.63, 35.44),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-3030.83, 113.89, 11.26),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-3094.63, 733.19, 21.08),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-3062.50, 1728.87, 35.87),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-2510.50, 3601.98, 14.03),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-1511.50, 4969.27, 62.09),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-799.89, 5410.93, 33.57),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-799.89, 5410.93, 33.57),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-279.32, 6049.70, 31.16),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(413.92, 6478.11, 28.45),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1580.49, 6444.02, 24.54),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(2577.31, 5078.92, 44.32),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1974.96, 5139.79, 42.86),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1809.49, 4589.46, 36.46),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(2497.63, 4138.71, 38.04),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1890.10, 3699.30, 32.64),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1815.52, 3320.25, 41.82),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1123.56, 2664.17, 37.66),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(265.28, 2602.33, 44.46),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(703.35, 2199.19, 59.05),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-176.64, 1881.35, 197.82),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-749.75, 1164.77, 262.25),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-537.42, 278.79, 82.70),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-461.07, -228.24, 35.78),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-220.88, -437.10, 31.39),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-525.23, -652.98, 32.92),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-300.60, -1145.20, 22.97),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(101.31, -1028.54, 29.07),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-156.28, -895.44, 28.99),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(-61.82, -570.16, 37.67),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(117.62, -49.90, 67.31),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(253.94, 323.29, 105.21),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(545.14, 251.60, 102.78),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(703.65, 661.10, 128.55),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(1077.99, 440.56, 91.40),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(808.22, -30.11, 80.26),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(484.09, -288.64, 46.68),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(181.35, -786.57, 31.34),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(289.46, -952.10, 29.09),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(397.39, -1023.73, 29.09),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(761.74, -1008.55, 25.82),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(781.75, -713.46, 27.94),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(678.86, -409.20, 41.30),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
    {
        pos = vector3(905.88, -243.18, 69.03),
        radius = 15,
        marker = {
            markerType = 1,
            markerTaille = {13.0, 13.0, 0.5},
            markerColor = {255, 0, 0, 255},
        },
        callback = function()
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
            TriggerServerEvent("ElderLife:succesMission")
        end,
    },
}