--Client config only
CConfig = { }

CConfig.AddonTables = { 
    --[1] = { coords = vector3(1972.95, 3055.78, 46.90), heading = 242.57 }
    --[2] = { coords = vector3(1990.92, 3066.04, 47.04), heading = 0.00 },
}

CConfig.ShotTime = 20
CConfig.ProximityToGame = 2.0 -- Proximy to move in a zone of 10 when you created a game
CConfig.ProximityToAccept = 5.0 -- Distance to accept a game
CConfig.UsingTarget = false -- If you use qtarget or not
CConfig.TargetName = 'qtarget' -- Name of the target resource (They are compatible)

CConfig.ValuesToHit = {
    [1] = 100,
    [2] = 200,
    [3] = 500,
    [4] = 700,
}

CConfig.Reach0Start = {
    [1] = 201,
    [2] = 301,
    [3] = 501,
    [4] = 701,
}

CConfig.ShakeLevel = 4 -- The average shake level

CConfig.ShakeMin = -8 -- The minimum shake
CConfig.ShakeMax = 8 -- The maximum shake
