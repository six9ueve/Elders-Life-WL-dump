Config = {}

--Don't Touch
Config.CurrentV = "1.1 HD" --Don't Touch

--Important Configs
Config.OLDESX = false --If using old esx

Config.Discord = false --If you want discord logs
Config.Reward = false --Log for rewards
Config.RobEnd = false --Log for robbery ending
Config.Selling = false --Log for selling
Config.Fabricating = false --Log for fabricating
Config.StartingD = false --Log for starting the robbery
Config.FailHack = false --Log for fail hack start
Config.DoorsD = false --Log for doors

Config.PoliceJob = 'police' --Police job name
Config.PoliceJob2 = 'sheriff' --Police job name
Config.NotifiedJobs = {
    'police', 'sheriff'
}
Config.NeededCops = 0 --Needed Cops to Rob
Config.RobTime = 30 --How long you have to wait till it can be robbed again (mins)
Config.WaitTime = 20 --How long it waits to re lock doors (mins)

--Item Configs
Config.TakeHackDev = false --Take Hacking device upon use
Config.TakeExpDev = true --Take Explosive Device upon use
Config.TakeLockpick = true --Take lockpick upon use

--Marker Configs
Config.Use3dMarkers = true --If you want 3d markers
Config.Text3DHeight = 0.3 --How much higher the text is from the marker
Config.SeeMarkerDist = 4 --How close you have to be to see the marker

Config.StartMarkerNum = 2 
Config.StartMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.StartMarkerColor = {r = 155, g = 66, b = 245}

Config.KPadMarkerNum = 2
Config.KPadMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.KPadMarkerColor = {r = 155, g = 66, b = 245}

Config.ExpMarkerNum = 2
Config.ExpMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.ExpMarkerColor = {r = 155, g = 66, b = 245}

Config.KeyMarkerNum = 2
Config.KeyMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.KeyMarkerColor = {r = 245, g = 66, b = 66}

Config.DepositMarkerNum = 2
Config.DepositMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.DepositMarkerColor = {r = 92, g = 174, b = 250}

Config.SellMarkerNum = 2
Config.SellMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.SellMarkerColor = {r = 92, g = 174, b = 250}

Config.FabMarkerNum = 2
Config.FabMarkerSize = {x = 0.4, y = 0.4, z = 0.2}
Config.FabMarkerColor = {r = 92, g = 174, b = 250}

--Door Configs
Config.CloseDoorCheck = 6 --How close you have to be for doors to start checking
Config.MaxDoorDist = 1.5 --How close you have to be to interact and see 3d text

--Bank Configs
Config.BankLoc = vector3(-110.32842254639, 6465.474609375, 31.62670135498) --Bank location
Config.CloseRob = 50 --How close you have to be to the loaction above to keep robbing

--Lockpick Configs
Config.LockPickTime = 5 --How long it takes to lockpick
Config.LockPick1 = vector3(-109.3857421875, 6468.201171875, 31.62671661377) --Lockpick location 1
Config.LockPickHead1 = 46.3 --Lockpick 1 heading
Config.LockPick2 = vector3(-105.68743133545, 6474.9165039062, 31.62670135498) --Lockpick location 2
Config.LockPickHead2 = 314.2 --Lockpick 2 heading

--Keypad Configs
Config.KeyPadLoc = vector3(-105.56369018555, 6471.990234375, 31.62671661377) --Key Pad Location 
Config.KeyPadAnimLoc = vector3(-105.56369018555, 6471.990234375, 31.62671661377) --Key Pad Animation Location
Config.KeyPadClose = 1 --How close you have to be to key pad to start
Config.KeyPadHeading = 52.81 --Key pad heading
Config.KeyPadTime = 4 --How long it takes to hack key pad (seconds)

--Explosion Configs
Config.HaveExplosion = true --If there is an explosion in game (Suggest to turn off if you have anticheat)
Config.DoorLoc = vector3(-105.38372802734, 6472.7309570312, 31.626714706421) --Placement Location for c4
Config.DoorClose = 0.75 --How close you have to be to place c4
Config.DoorAnimLoc = vector3(-104.93422393799, 6472.2350585938, 31.626714706421) --Placing c4 animation location
Config.DoorHeading = 46.51 --Heading for placing c4
Config.DoorETime = 15 --How long it takes to place c4 (seconds)
Config.BombHeading = 45.0 -- Heading for the c4
Config.ExplodeTimer = 10 --How long until the c4 explodes
Config.CloseExplode = 50 --How close you have to be for the c4 and notification
Config.Explosion = 10.0 --How much damage the explosion does

--Blip Configs
Config.TempSprite = 459 --Blip Sprite
Config.TempSize = 0.9 --Blip Size
Config.TempColor = 1 --Blip Color
Config.TempPulse = true --Blip Pulse?
Config.TempTime = 1 --How long the blip lasts

Config.BankSprite = 161 --Blip Sprite
Config.BankSize = 0.9 --Blip Size
Config.BankColor = 47 -- Blip Color
Config.BankPulse = true --Blip Pulse?

Config.KeySprite = 498 --Blip Sprite
Config.KeySize = 0.5 --Blip Size
Config.KeyColor = 36 --Blip Color
Config.KeyPulse = false --Blip Pulse?

--Starting Configs
Config.StartLoc = vector3(-109.71394348145, 6483.6015625, 31.468461990356) --Starting Location
Config.StartAnimLoc = vector3(-109.80107116699, 6483.6450195312, 31.468461990356) --Starting Animation Location
Config.StartHeading = 223.01 --Starting Heading
Config.PanelTime = 5 --How long it takes to open hacking device
Config.HackDiff = 5 --How manuy letters are in hack
Config.HackTime = 30 --How long they have to hack (seconds)

--Blip Configs
Config.MapBlips = { --All map blips
    [1] = {
        Name = "Paleto Bank",
        Active = false,
        Sprite = 272,
        Color = 14,
        Loc = vector3(-110.32842254639, 6465.474609375, 31.62670135498)
    }
}

--Guard Configs
Config.Guards = false --If you want guards
Config.FreezeGuards = false --If guards should be frozen in position
Config.GuardAccuracy = 60 --How accurate the guards are (0-100)
Config.GuardModel = 'mp_s_m_armoured_01' --Guard ped model
Config.GuardWeapon = 'WEAPON_STUNGUN' --Guard weapon
Config.GuardLocs = { --All Guard locations
    [1] = {
        Location = vector3(-115.46228027344, 6472.2495117188, 31.626699447632), --Location of guard
        Heading = 190.86, --Heading of guard
        GuardData = nil --DO NOT TOUCH
    },
    [2] = {
        Location = vector3(-112.67437744141, 6464.9052734375, 31.626705169678),
        Heading = 311.74,
        GuardData = nil
    },
    [3] = {
        Location = vector3(-114.47315979004, 6473.89453125, 31.62670135498),
        Heading = 218.0,
        GuardData = nil
    },
    [4] = {
        Location = vector3(-105.62162780762, 6470.4907226562, 31.62670135498),
        Heading = 134.62,
        GuardData = nil
    },
    [5] = {
        Location = vector3(-103.995262146, 6467.599609375, 31.62670135498),
        Heading = 355.56,
        GuardData = nil
    },
    [6] = {
        Location = vector3(-99.447776794434, 6461.4008789062, 31.626708984375),
        Heading = 38.79,
        GuardData = nil
    },
    [7] = {
        Location = vector3(-107.67891693115, 6474.7622070312, 31.626708984375),
        Heading = 241.02,
        GuardData = nil
    },
    [8] = {
        Location = vector3(-104.29618835449, 6474.8564453125, 31.626708984375),
        Heading = 3.95,
        GuardData = nil
    }
}

--KeyCard Configs
Config.KeyBlips = true --If the keycard seacrh locations should have blips
Config.MaxDist = 15 --Max Distance to Start Search Locations
Config.SearchTime = 5 --How long it takes to search (seconds)
Config.MaxDistKey = 10 --Max Distance to start checking closeness 
Config.ShowDistKey = 0.85 --Show distance for 3D Text
Config.keyblips = { --All Keycard locations
    [1] = {
        Loc = vector3(-113.7530670166, 6473.70703125, 31.626707077026), --Location of keycard search
        AnimLoc = vector3(-113.7530670166, 6473.70703125, 31.626707077026), --Animation Location
        Heading = 316.26, --Heading for ped
        BlipUsed = false, --Don't touch
        BlipData = nil --Don't touch
    },

    [2] = {
        Loc = vector3(-113.35146331787, 6472.1362304688, 31.626707077026),
        AnimLoc = vector3(-113.35146331787, 6472.1362304688, 31.626707077026),
        Heading = 136.38,
        BlipUsed = false,
        BlipData = nil
    },

    [3] = {
        Loc = vector3(-112.26692962646, 6471.068359375, 31.62670135498),
        AnimLoc = vector3(-112.26692962646, 6471.068359375, 31.62670135498),
        Heading = 136.38,
        BlipUsed = false,
        BlipData = nil
    },

    [4] = {
        Loc = vector3(-111.21822357178, 6470.0092773438, 31.626707077026),
        AnimLoc = vector3(-111.21822357178, 6470.0092773438, 31.626707077026),
        Heading = 136.38,
        BlipUsed = false,
        BlipData = nil
    },

    [5] = {
        Loc = vector3(-112.22463989258, 6472.287109375, 31.626703262329),
        AnimLoc = vector3(-112.22463989258, 6472.287109375, 31.626703262329),
        Heading = 321.68,
        BlipUsed = false,
        BlipData = nil
    },

    [6] = {
        Loc = vector3(-110.80892944336, 6470.7890625, 31.626703262329),
        AnimLoc = vector3(-110.80892944336, 6470.7890625, 31.626703262329),
        Heading = 321.68,
        BlipUsed = false,
        BlipData = nil
    }
}

Config.doors = { --Door configs! (DONT CHANGE THESE)

    {
        objName = 'v_ilev_cbankcountdoor01', 
        objCoords  = {x = -108.9147, y = 6469.104, z = 31.91028},
        textCoords = {x = -108.9147, y = 6469.104, z = 31.91028},
        authorizedJobs = { 'police' },
        heading = 44.700256347656
    },

    {
        objName = 'v_ilev_cbankvauldoor01',
        objCoords  = {x = -104.6049, y = 6473.443, z = 31.79532},
        textCoords = {x = -104.6049, y = 6473.443, z = 31.79532},
        authorizedJobs = { 'police' },
        heading = 48.00003051758
    },

    {
        objName = 'v_ilev_cbankvaulgate02',
        objCoords = {x = -106.4713, y = 6476.157, z = 31.9548},
        textCoords = {x = -106.4713, y = 6476.157, z = 31.9548},
        authorizedJobs = { 'police' },
        heading = 1
    }
}

--Deposit Box Configs
Config.PickupTime = 2 --How long it takes to search a deposit box (seconds)
Config.MaxDistDep = 10 --How close you have to be to start searching closeness
Config.ShowDistDep = 0.85 --How close you have to be to search deposit box
Config.MoneyACC = 'black_money' --Account money reward goes to
Config.MoneyR = {firstnum = 10000, secondnum = 15000} --Random Number for money

Config.DepSprite = 586 --Deposit Box Blip Sprite
Config.DepPulse = false --Does blip pulse?
Config.DepSize = 0.5 --Deposit Box Blip Size
Config.DepColor = 53 --Deposit Box Blip Color

Config.Deposits = { --All Deposit Locations
    [1] = {
        Loc = vector3(-106.70166778564, 6473.0361328125, 31.626712799072), --Location
        Heading = 142.64, --Heading for animation
        AnimType = 1, --Anim type 1 = stand 2 = over table
        Datastore = nil --DONT TOUCH
    },

    [2] = {
        Loc = vector3(-107.62915802002, 6473.982421875, 31.626712799072),
        Heading = 142.64,
        AnimType = 1,
        Datastore = nil
    },

    [3] = {
        Loc = vector3(-103.46611785889, 6474.9379882812, 31.666612625122),
        Heading = 228.14,
        AnimType = 1,
        Datastore = nil
    },

    [4] = {
        Loc = vector3(-102.27933502197, 6476.1201171875, 31.665992736816),
        Heading = 228.14,
        AnimType = 1,
        Datastore = nil
    },

    [5] = {
        Loc = vector3(-103.65283203125, 6476.2319335938, 31.626720428467),
        Heading = 41.47,
        AnimType = 2,
        Datastore = nil
    },

    [6] = {
        Loc = vector3(-102.407371521, 6477.4282226562, 31.675458908081),
        Heading = 318.98,
        AnimType = 1,
        Datastore = nil
    },
    
    [7] = {
        Loc = vector3(-103.97202301025, 6477.5732421875, 31.62671661377),
        Heading = 132.36,
        AnimType = 2,
        Datastore = nil
    },

    [8] = {
        Loc = vector3(-104.24034118652, 6479.23046875, 31.62671661377),
        Heading = 316.81,
        AnimType = 1,
        Datastore = nil
    },

    [9] = {
        Loc = vector3(-105.28981781006, 6479.1811523438, 31.663667678833),
        Heading = 46.46,
        AnimType = 1,
        Datastore = nil
    },

    [10] = {
        Loc = vector3(-105.2380065918, 6477.830078125, 31.62671661377),
        Heading = 225.23,
        AnimType = 2,
        Datastore = nil
    }
}

Config.Sayings = { --All sayings in script!
    [1] = "[~r~G~w~] ~r~Locked",
    [2] = "[~g~G~w~] ~g~Unlocked",
    [3] = "~r~Locked",
    [4] = "~g~Unlocked",
    [5] = "Press [~y~G~w~] to start ~r~lockpicking~w~ door!",
    [6] = "Press [~g~E~w~] to disable security systems!",
    [7] = "Hacking Security",
    [8] = "Go and find the ~p~keycard~w~ to get into the vault!",
    [9] = "Hack failed! Police have been dispatched your location!",
    [10] = "Paleto Security Alarm",
    [11] = "Someone just triggered the ~r~Security System~w~ at ~g~Paleto Bay Bank~w~!",
    [12] = "Paleto Bank Robbery",
    [13] = "Someone is ~b~robbing ~w~the ~y~Paleto Bank~w~!",
    [14] = "Press [~r~E~w~] to search for ~y~keycard~w~!",
    [15] = "Possible Keycard Location",
    [16] = "You found the ~b~keycard~w~! ~y~Insert~w~ into the ~r~vault door~w~!",
    [17] = "Did not find ~b~keycard~w~!",
    [18] = "Can not rob! Robbery on Cooldown!",
    [19] = "Can not rob! There must be~r~ ",
    [20] = " ~b~cops ~w~on to rob!",
    [21] = "Press [~p~E~w~] to insert ~b~keycard~w~!",
    [22] = "Disabling Vault Lock",
    [23] = "Press [~r~E~w~] to place ~y~c4~w~!",
    [24] = "Planting Explosive!",
    [25] = "~y~Explosive~w~ will blow up in~r~ ",
    [26] = " ~w~seconds!",
    [27] = "Go and ~b~steal~w~ all the ~g~items~w~ in the ~y~deposit boxes~w~!",
    [28] = "Press [~y~E~w~] to ~g~loot ~r~deposit box~w~!",
    [29] = "Looting Deposit Box",
    [30] = "Action Impossible",
    [31] = "Inventory full, can not loot!",
    [32] = "~r~Robbery~w~ ended at ~y~Paleto Bank~w~!",
    [33] = "Deposit Box",
    [34] = "Lockpicking Door",
    [35] = "You need a ~r~lockpick~w~ to lockpick the door!",
    [36] = "You need a ~y~hacking device~w~ to start ~r~robbery~w~!",
    [37] = "You need an ~g~explosive device~w~ to blow up the ~r~door~w~!",
    [38] = "Robbery canceled! You walked far away from the robbery!",
    [39] = "Robbery Canceled",
    [40] = "Press [~y~E~w~] fabricate ~r~Bank Bonds~w~",
    [41] = "Press [~g~G~w~] fabricate ~r~House Deeds~w~",
    [42] = "Press [~b~E~w~] sell all ~g~Bank Bonds~w~ and ~y~House Deeds~w~",
    [43] = "Fabricating",
    [44] = "You need more bonds or deeds to fabricate!",
    [45] = "You have no bonds or deeds to sell!",
    [46] = "You failed!"
}