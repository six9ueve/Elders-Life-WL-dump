Config = {

-------------------------------------------------------------
-- IMPORTANT  
-- All parts need to be added to inventory
-- Custom vehicle sounds for engines (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
-------------------------------------------------------------

WhitelistedJobs = { -- Put jobs you want to use mechanic_tools
    'mechanic',
    'mechanic2',
    'mechanic3',
    'mechanic4',
    'mechanic5',
    'police',
    'sheriff'
},

WearRate = 350000, -- The rate parts wear off (Higher the value less wear on the parts)
UseMiles = false, -- If set to false it will use kilometers
UseRelativeValues = true, -- If set to true cars performance wouldnt be affected with stock parts. Otherwise stock car parts will make the car slower
UseT1gerMechanic = false, -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this
DetectDistance = 3.0, -- Distance where vehicles are being detected
OnlyOwnedVehicles = true, -- Script excludes not owned cars

--Times to repair/install certain parts in miliseconds
EngineRepairTime = 30000, 
EngineInstallTime = 60000,

TurboRepairTime = 15000, 
TurboInstallTime = 25000,

NitroInstallTime = 10000,

OilInstallTime = 5000,

TransmissionInstallTime = 45000,
TransmissionRepairTime = 30000,

TireRepairTime = 10000,
TireInstallTime = 15000,

BreaksInstallTime = 15000,
BreaksRepairTime = 20000,

SuspensionInstallTime = 20000,
SuspensionRepairTime = 25000,


SparkPlugsInstallTime = 5000,
SparkPlugsRepairTime = 5000,


MechanicWorkshop = { -- Mechanic Workshops where mechanics can use MechanicWorkshopAccess

    {coords = vector3(32.6378,6488.987,31.00), radius = 5.0},--mechanic2
    {coords = vector3(-222.3664,-1331.203,30.28), radius = 5.0},--mechanic
    {coords = vector3(547.39,-175.264,54.49), radius = 5.0},--mechanic4
    {coords = vector3(-312.929, -125.0995, 39.21875), radius = 5.0},--mechanic3
    {coords = vector3(1027.386, -2526.558, 27.38272), radius = 5.0},--mechanic5
    {coords = vector3(2520.32,-306.64,92.50), radius = 8.0}--POLICE


},

--Check engine, Low oil, Mileage location on screen
InfoBottom = 1,
InfoRight = 1,


-- Parts of vehicle certain condicions can access! For example with mechanic tool box you will be able to access parts mentioned in MechanicTools
-- PART LIST (engine, oil, brakes, suspension, turbo, nitro )

BearHandsAccessCommand = 'inspect',
BearHandsAccess = {
    ['oil'] = true
},

ToolBoxAccess = {
	['oil'] = true,
	['nitro'] = false,
    ['tires'] = true,
	['sparkplugs'] = true
},

MechanicToolsAccess = {
    ['oil'] = true,
	['nitro'] = false,
    ['tires'] = true,
	['brakes'] = true,
    ['suspension'] = true,
	['sparkplugs'] = true
},

MechanicWorkshopAccess = {
    ['oil'] = true,
    ['nitro'] = false,
    ['tires'] = true,
    ['brakes'] = true,
    ['suspension'] = true,
    ['engine'] = true,
    ['transmission'] = true,
    ['turbo'] = true,
	['sparkplugs'] = true
},


-- Parts that your vehicle will be able to use to modify its performance on the road. These parts also need to be added to the item databse.
-- usability - is to exclude some parts to be used on some vehicles exclusive is usually car spawn code
-- power - depends if using relative values but it will increase vehicles power
-- durability - (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
-- repair - enter ingrediants to fix up the part. If part is at 0 percent you will need to replace.

Turbos = { -- Turbos affect your car speed at higher rpm's. When turbos break you lose power

    ['turbo_lvl_1'] = {
        label = "GARETT TURBO", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 7.0,
        durability = 100.0,
        repair = {
            ['chra2'] = {amount = 1, label = "Einhell", reusable = false}
        }
    },

    ['turbo_lvl_2'] = {
        label = "KKK TURBO", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 15.0,
        durability = 100.0,
        repair = {
            ['chra3'] = {amount = 1, label = "KKK", reusable = false}
        }
    },

    ['turbo_lvl_3'] = {
        label = "KKK B TURBO", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 25.0,
        durability = 100.0,
        repair = {
            ['chra3'] = {amount = 1, label = "KKK B", reusable = false}
        }
    },

    ['stock_turbo'] = {
        label = "STANDARD", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 0.0,
        durability = 95.0,
        repair = {
            ['chra1'] = {amount = 1, label = "Eisen", reusable = false}
        }
    }

},

NitroKey = 'LEFTSHIFT', -- Key to use nitro when available

Nitros = { -- Nitro affect vehicle power and increases vehicle wear during usage

    ['nos'] = {
        label = "NOS", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 100.0,
        durability = 10.0 -- Here enter seconds until nitro will run out
    }

},

Transmissions = {

['stock_transmission'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 0.9,
    drivingwheels = 'DEFAULT',
    durability = 90.0,
    repair = {
            ['huiletransmission'] = {amount = 1, label = "Huile TRW", reusable = false}
        }
},

['race_transmission'] = {
    label = "T. RWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 1.5,
    drivingwheels = 'RWD',
    durability = 50.0,
    repair = {
            ['planetaire'] = {amount = 2, label = "Planetaire", reusable = false},
            ['huiletransmission'] = {amount = 1, label = "Huile TRW", reusable = false}
        }
},
['race_transmission_4wd'] = {
    label = "T. AWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 2.0,
    drivingwheels = 'AWD', -- FWD RWD AWD
    durability = 50.0,
    repair = {
            ['planetaire'] = {amount = 4, label = "Planetaire", reusable = false},
            ['huiletransmission'] = {amount = 1, label = "Huile TRW", reusable = false}
        }
},

['race_transmission_fwd'] = {
    label = "T. FWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 1.5,
    drivingwheels = 'FWD', -- FWD RWD 4WD
    durability = 50.0,
    repair = {
            ['planetaire'] = {amount = 2, label = "Planetaire", reusable = false},
            ['huiletransmission'] = {amount = 1, label = "Huile TRW", reusable = false}
        }
}

},

Suspensions = { -- Suspension will affect handling and will look super cool. Decrease power to lower the vehicle and give better handling.

['stock_suspension'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = 0,
    traction = 0,
    durability = 90.0,
    repair = {
            ['ressortsusp'] = {amount = 4, label = "Ressort", reusable = false}
        }
},

['race_suspension'] = {
    label = "RACE", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = -0.03,
    traction = 1.0,
    durability = 50.0,
    repair = {
            ['ressortsusp'] = {amount = 4, label = "Ressort", reusable = false},
            ['coupellessusp'] = {amount = 4, label = "Coupelle", reusable = false}
        }
}



},

Oils = { -- Oils keep your car cool and happy if oil runs out car parts will start to wear off fast.

['stock_oil'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 10.0,
},

['shell_oil'] = {
    label = "SHELL", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 50.0,
}

},



Engines = { -- Engines will make your car faster and will give it a different sound. Increase power to make car faster. 

    ['stock_engine'] = {
            label = "STANDARD", 
            power = 0.0,
            durability = 90.0,
            usability = {exclusive = {}, vehicletypes = {}},
            sound = "DEFAULT",
            repair = {
                ['piston'] = {amount = 4, label = "Piston", reusable = false}
            }
    }, 

    ['v6engine'] = {
            label = "V6", 
            power = 1.5,
            durability = 75.0,
            usability = {exclusive = {}, vehicletypes = {}},
            sound = "brabus850", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
            repair = {
                ['distribution'] = {amount = 1, label = "Distribution", reusable = false},
                ['piston'] = {amount = 6, label = "Piston", reusable = false}
            }
    }, 

    ['v8engine'] = {
            label = "V8", 
            power = 3.0,
            durability = 75.0,
            usability = {exclusive = {}, vehicletypes = {}},
            sound = "brabus850", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
            repair = {
                ['bielles'] = {amount = 8, label = "Bielle", reusable = false},
                ['distribution'] = {amount = 1, label = "Distribution", reusable = false},
                ['piston'] = {amount = 8, label = "Piston", reusable = false}
            }
    }, 

    ['2jzengine'] = {
            label = "2JZ", 
            power = 6.0,
            durability = 75.0,
            usability = {exclusive = {}, vehicletypes = {}},
            sound = "toysupmk4", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
            repair = {
                ['bielles'] = {amount = 8, label = "Bielle", reusable = false},
                ['chemises'] = {amount = 8, label = "Chemise", reusable = false},
                ['volantm'] = {amount = 1, label = "Volant M", reusable = false},
                ['piston'] = {amount = 8, label = "Piston", reusable = false}
            }
    }, 

    ['2jzengineb'] = {
            label = "2JZ B", 
            power = 6.0,
            durability = 75.0,
            usability = {exclusive = {}, vehicletypes = {}},
            sound = "toysupmk4", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
            repair = {
                ['bielles'] = {amount = 8, label = "Bielle", reusable = false},
                ['chemises'] = {amount = 8, label = "Chemise", reusable = false},
                ['volantm'] = {amount = 1, label = "Volant M", reusable = false},
                ['piston'] = {amount = 8, label = "Piston", reusable = false}
            }
    }

},
 
Tires = { -- Tires affect your cars handling when launching and in corners. Increase traction for better grip or decrease for more drift. When they wear off you will drive without tires lol

['stock_tires'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = -0.04,
    width = 0.0,
    size = 0.0,
    lowspeedtraction = 0.0,
    durability = 90.0,
    repair = {
            ['champignonpneu'] = {amount = 2, label = "Champignon", reusable = false}
        }
},

['michelin_tires'] = {
    label = "MICHELIN", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = 0.5,
    width = 0.0,
    size = 0.0,
    lowspeedtraction = 1.5,
    durability = 60.0,
    repair = {
            ['champignonpneu'] = {amount = 4, label = "Champignon", reusable = false}
        }
}


},

Brakes = { -- Brakes allow you to stop your car. Increase power to make brakes more affective. When brakes break you will lose ability to break 

['stock_brakes'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 1.0,
    durability = 50.0,
    repair = {
            ['plaquettefrein'] = {amount = 4, label = "Plaquette", reusable = false}
        }
},

['race_brakes'] = {
    label = "RACE", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 2.0,
    durability = 25.0,
    repair = {
            ['plaquettefrein'] = {amount = 8, label = "Plaquette", reusable = false}
        }
},

},

SparkPlugs = { -- Spark Plugs affect your car ignition. This will cause the vehicle to switch the engine off randomly

    ['stock_sparkplugs'] = {
        label = "STANDARD", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 60.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 25.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 10000, -- min time when engine turns off in ms
		maxfail = 50000, -- max time when engine turns off in ms
    },
	['ngk_sparkplugs'] = {
        label = "NGK", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 90.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 15.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 20000, -- min time when engine turns off in ms
		maxfail = 60000, -- max time when engine turns off in ms
    }

},

--en
Text = {

    ['hood_closed'] = 'Capot Fermé!',
    ['mechanic_action_complete'] = 'Réparation terminée',
    ['mechanic_action_started'] = 'Réparation commencé',
    ['wrong_job'] = 'Mauvais Job',
    ['not_enough'] = 'Pas assez de matériel',
	
	--Added
	['vehicle_locked'] = 'Véhicule fermé!',
	['vehicle_nearby'] = 'Pas de véhicule proche!',
	['vehicle_notonlift'] = 'Véhicule pas sur le pont élévateur!',
	['vehicle_notoncarjack'] = 'Véhicule pas sur le cric!',
	
	--Parts Stuff
	['install_engine'] = '[~r~E~w~] installer moteur',
	['repair_engine'] = '[~r~E~w~] réparer moteur',
	['installing_engine'] = '~r~installation moteur commencé',
	['repairing_engine'] = '~r~réparation moteur commencé',
	['install_turbo'] = '[~r~E~w~] installer turbo',
	['repair_turbo'] = '[~r~E~w~] réparer turbo',
	['installing_turbo'] = '~r~installation turbo commencé',
	['repairing_turbo'] = '~r~réparation turbo commencé',
	['install_nitro'] = '[~r~E~w~] installer nitro',
	['repair_nitro'] = '[~r~E~w~] réparer nitro',
	['installing_nitro'] = '~r~installation nitro commencé',
	['repairing_nitro'] = '~r~réparation nitro commencé',
	['exchange_oil'] = '[~r~E~w~] changer huile',
	['refill_oil'] = '[~r~E~w~] ajouter huile',
	['refilling_oil'] = '~r~ajout huile en cour',
	['exchanging_oil'] = '~r~changement huile en cour',
	['install_transmission'] = '[~r~E~w~] installer transmission',
	['repair_transmission'] = '[~r~E~w~] réparer transmission',
	['installing_transmission'] = '~r~installation transmission commencé',
	['repairing_transmission'] = '~r~réparation transmission commencé',
	['install_tire'] = '[~r~E~w~] installer pneu',
	['install_brakes'] = '[~r~E~w~] installer frein',
	['install_suspension'] = '[~r~E~w~] installer suspension',
	
		
	--New
	['install_sparkplugs'] = '[~r~E~w~] installer bougies'
}

}



function SendTextMessage(msg)

        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
        --exports['mythic_notify']:SendAlert('inform', msg)

end
