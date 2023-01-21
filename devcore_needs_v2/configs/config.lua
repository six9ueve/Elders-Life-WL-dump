Config = {}

--v2.0
--Support https://discord.gg/zcG9KQj3sa

Config.PlacedDrinks = {} -- dont touch

--Main
Config.Language = 'fr'
Config.ItemTester = 'alcotester' -- Item for alcohol tester
Config.Test3dColor = {169, 41, 255, 255} -- 3D text Color
Config.DrunkDriving = true --true if you want to enable difficult drunken driving
Config.EnableStressSystem = true
Config.EnableStatus = true --if you use god_status, type true and for food and drink you can set how much it will gain when you bite into the food
Config.MaxDrinkCount = 11  -- Maximum amount of objects placed on the ground
Config.EnableHideButton = true -- true if you want to enable the option to make 3d text disappear
Config.DisableCombatButtons = true
--Buttons
Config.UseButton = 38
Config.UseAllButton = 11
Config.Throw = 105
Config.ServeButton = 121
Config.HideGlass = 317
Config.InfuseButton = 10
Config.ServeConfirmButton = 38
Config.ServeCancelButton = 73
Config.PlaceButton = 58
Config.TakePlacedDrink = 38
Config.PlaceConfirmButton = 38
Config.PlaceCancelButton = 105
Config.AlcotestUseButton = 38
Config.AlcotestCancelButton = 105
Config.HideButton = 58

-----------------------------
function Notify(style, message) -- here put notify trigger
    exports['mythic_notify']:DoHudText(style, message)
    -- exports['okokNotify']:Alert('NEEDS', message, 5000, style)  -- EXAMPLE
end

-----
Config.ThirstName = 'thirst'
Config.HungerName = 'hunger'
-----
function Status(need, status) -- here place status trigger
    TriggerEvent('god_status:add', need, status)
end

function RemoveStress(stress) -- Here put stress trigger
    TriggerEvent("god_status:remove", "stress", stress)
end

-----------------------------
Config.Foods = {
    ["brownie"] = {-- item give name
        Label = "Brownie au chocolat",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["cake"] = {-- item give name
        Label = "Cake à la banane",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["pancake"] = {-- item give name
        Label = "Pancake au sirop d’érable",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["space_brownie"] = {-- item give name
        Label = "Space-Brownie",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["space_cake"] = {-- item give name
        Label = "Space-Cake",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["space_pancake"] = {-- item give name
        Label = "Space-Pancake",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["ribs"] = {-- item give name
        Label = "Ribs",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["cote_boeuf"] = {-- item give name
        Label = "Cote de Boeuf",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["poulet_roti"] = {-- item give name
        Label = "Poulet Roti",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["croissant"] = {-- item give name
        Label = "Croissant",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["painauchocolat"] = {-- item give name
        Label = "Pain au chocolat",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["eclairchoco"] = {-- item give name
        Label = "Eclair Chocolat",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["eclaircafe"] = {-- item give name
        Label = "Eclair Café",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["flanpatissier"] = {-- item give name
        Label = "Flan Patissier",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 30000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_poissonsoupe"] = {-- item give name
        Label = "Soupe de poisson",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_salade_mer"] = {-- item give name
        Label = "Salade de la Mer",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["nachos"] = {-- item give name
        Label = "Nachos",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["salade_mex"] = {-- item give name
        Label = "Salade Méxicaine",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["buritto"] = {-- item give name
        Label = "Buritto",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_moulefrite"] = {-- item give name
        Label = "Moules Frites",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_entrecote"] = {-- item give name
        Label = "Entrecote",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_doscabillaud"] = {-- item give name
        Label = "Dos de Cabillaud",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["pearl_sushi"] = {-- item give name
        Label = "Sushi",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["fish"] = {-- item give name
        Label = "Poisson",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 10000, --example
        RemoveStress = 5000, --example
    },
    ["nuggets4"] = {-- item give name
        Label = "Nugget x4",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 25000, --example
        RemoveStress = 5000, --example
    },
    ["nuggets10"] = {-- item give name
        Label = "Nugget x10",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 50000, --example
        RemoveStress = 5000, --example
    },
    ["crepe"] = {-- item give name
        Label = "Crepe",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 10000, --example
        RemoveStress = 5000, --example
    },
    ["saucisson"] = {-- item give name
        Label = "Saucisson",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["grapperaisin"] = {-- item give name
        Label = "Grappe de raisin",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["raisin"] = {-- item give name
        Label = "Raisin",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["maki_saumon"] = {-- item give name
        Label = "Maki Saumon",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["maki_thon"] = {-- item give name
        Label = "Maki Thon",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sushi_thon"] = {-- item give name
        Label = "Sushi Thon",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sushi_saumon"] = {-- item give name
        Label = "Sushi Saumon",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["porc_caramel"] = {-- item give name
        Label = "Porc au caramel",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["nems_porc"] = {-- item give name
        Label = "Nems Porc",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["nems_poulet"] = {-- item give name
        Label = "Nems Poulet",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["rouleau_printemps"] = {-- item give name
        Label = "Rouleau de printemps",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["nouille_poulet"] = {-- item give name
        Label = "Nouille poulet",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["reine"] = {-- item give name
        Label = "Pizza Reine",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["5fromages"] = {-- item give name
        Label = "Pizza 5 fromages",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["barbecue"] = {-- item give name
        Label = "Pizza Barbecue",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["saumons"] = {-- item give name
        Label = "Pizza Saumon",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["orientale"] = {-- item give name
        Label = "Pizza Orientale",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["calzone"] = {-- item give name
        Label = "Calzone",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["soupe_legume"] = {-- item give name
        Label = "Soupe de légume",
        Prop = 'prop_food_bs_burg1', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 35000, --example
        RemoveStress = 5000, --example
    },
    ["simply"] = {-- item give name
        Label = "The Simply",
        Prop = 'nels_burger_simply_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 100.0, yrot = 76.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["prickly"] = {-- item give name
        Label = "The Prickly",
        Prop = 'nels_burger_prickly_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = -0.03, xrot = 100.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["doubleshot"] = {-- item give name
        Label = "The Double Shot",
        Prop = 'nels_burger_double_shot_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0, yrot = 196.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["glorious"] = {-- item give name
        Label = "The Glorious",
        Prop = 'nels_burger_glorious_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0, yrot = 196.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["bleeder"] = {-- item give name
        Label = "The Bleeder",
        Prop = 'nels_burger_bleeder_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 360, yrot = 196.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["heartstopper"] = {-- item give name
        Label = "Heart Stopper",
        Prop = 'nels_burger_fabulous_6lb_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0, yrot = 200.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["tacosmex"] = {-- item give name
        Label = "Chicken Mecican",
        Prop = 'nels_tacos_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["chickenwrap"] = {-- item give name
        Label = "Chicken Wrap",
        Prop = 'nels_chicken_wrap_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 30, yrot = -20.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["goatwrap"] = {-- item give name
        Label = "Goat Cheese Wrap",
        Prop = 'nels_goat_wrap_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 30, yrot = -20.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["icechoco"] = {-- item give name
        Label = "Glace Chocolat",
        Prop = 'nels_ice_cream_meteorite_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0, yrot = 96.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["icevanille"] = {-- item give name
        Label = "Glace Vanille",
        Prop = 'nels_ice_cream_orang_otan_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0, yrot = 96.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["fritebs"] = {-- item give name
        Label = "Frites",
        Prop = 'nels_fries_box_prop', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 100, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["bread"] = {-- item give name
        Label = "Pain",
        Prop = 'v_res_fa_bread03', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 6000, --example
        RemoveStress = 5000, --example
    },
    ["hamburger"] = {-- item give name
        Label = "Hamburger",
        Prop = 'prop_cs_burger_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["shamburger"] = {-- item give name
        Label = "Burger Simple",
        Prop = 'prop_cs_burger_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["vhamburger"] = {-- item give name
        Label = "Niglo Burger",
        Prop = 'prop_cs_burger_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sandwich"] = {-- item give name
        Label = "Sandwich",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 35000, --example
        RemoveStress = 5000, --example
    },
    ["sandwitch_bambi"] = {-- item give name
        Label = "Sandwitch Bambi",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sandwitch_shark"] = {-- item give name
        Label = "Sandwich Shark",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sandwitch_king"] = {-- item give name
        Label = "Sandwich King",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sandwitch_nemo"] = {-- item give name
        Label = "Sandwich Nemo",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sdwjambonbeurre"] = {-- item give name
        Label = "Sandwich Jambon Beurre",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sdwemmental"] = {-- item give name
        Label = "Sandwich Emmental",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["sdwpoulet"] = {-- item give name
        Label = "Sandwich Poulet",
        Prop = 'prop_sandwich_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["painbagnat"] = {-- item give name
        Label = "Pain Bagnat",
        Prop = 'prop_food_burg2', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["bolcacahuetes"] = {-- item give name
        Label = "Cacahuettes",
        Prop = 'prop_peanut_bowl_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["bolchips"] = {-- item give name
        Label = "Chips",
        Prop = 'v_ret_ml_chips2', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["bolnoixcajou"] = {-- item give name
        Label = "Noix de cajou",
        Prop = 'prop_peanut_bowl_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["bolpistache"] = {-- item give name
        Label = "Pistache",
        Prop = 'prop_peanut_bowl_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["mixapero"] = {-- item give name
        Label = "Mix Apero",
        Prop = 'v_ret_ml_chips4', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 7500, --example
        RemoveStress = 5000, --example
    },
    ["chips"] = {-- item give name
        Label = "Cornet de frites",
        Prop = 'prop_food_chips', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = -50.0, yrot = 16.0, zrot = 60.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 25000, --example
        RemoveStress = 5000, --example
    },
    ["twix"] = { -- item give name prop_food_bs_burger2
        Label = "Twix",
        Prop = 'prop_choc_meto', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["crunchies"] = { -- item give name
        Label = "Crunchies",
        Prop = 'prop_choc_meto', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["crunch"] = { -- item give name
        Label = "Crunch",
        Prop = 'prop_choc_meto', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["butterfinger"] = { -- item give name
        Label = "Butterfinger",
        Prop = 'prop_choc_meto', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["knoppers"] = { -- item give name
        Label = "Knoppers",
        Prop = 'prop_choc_ego', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["reeses"] = { -- item give name
        Label = "Reeses",
        Prop = 'prop_choc_ego', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 50.0, yrot = 30.0, zrot = 260.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 80, -- in grams
        Bite = {min = 7, max = 9},
        AddStatus = 8000, --example
        RemoveStress = 5000, --example
    },
    ["hotdog"] = { -- item give name
        Label = "Hotdog",
        Prop = 'prop_cs_hotdog_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0.0, yrot = -140.0, zrot = -140.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
    ["tacos"] = { -- item give name
        Label = "Tacos",
        Prop = 'prop_taco_01', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.13, y = 0.05, z = 0.02, xrot = 0.0, yrot = -140.0, zrot = -140.0}, -- position for placing prop in hand
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Size = 220, -- in grams
        Bite = {min = 21, max = 23},
        AddStatus = 70000, --example
        RemoveStress = 5000, --example
    },
}


Config.Drinks = { -- chercher a remplacer
    ["boissonsbs"] = { -- item give name
        Label = "Boisson",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'nels_soda_prop', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.02, y = -0.01, z = -0.03, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 5000, --example
    },
    ["beer"] = { -- item give name
        Label = "Piswasser",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["biereblonde"] = { -- item give name
        Label = "Bière Blonde",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["bierebrune"] = { -- item give name
        Label = "Bière Brune",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["bierenoel"] = { -- item give name
        Label = "Bière Fruitée",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["biereambree"] = { -- item give name
        Label = "Bière Ambrée",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["coronabeer"] = { -- item give name
        Label = "Corona",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_amb_beer_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.01, xrot = 18.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 10000, --example
        RemoveStress = 1000, --example
    },
    ["water"] = { -- item give name
        Label = "Eau",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'ba_prop_club_water_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.02, y = -0.01, z = -0.14, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 20000, --example
        RemoveStress = 5000, --example
    },
    ["perrier"] = { -- item give name
        Label = "Perrier",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'ba_prop_club_water_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.02, y = -0.01, z = -0.14, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 20000, --example
        RemoveStress = 5000, --example
    },
    ["cafe"] = { -- item give name
        Label = "Café",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["space_cafe"] = { -- item give name
        Label = "Space Café",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["cappuccino"] = { -- item give name
        Label = "Cappuccino",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["the"] = { -- item give name
        Label = "Thé",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["space_the"] = { -- item give name
        Label = "Sapce Thé",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["chocochaud"] = { -- item give name
        Label = "Chocolat Chaud",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_ing_coffeecup_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 250, -- in ml
        GlassSize = false, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 24, max = 26},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["icetea"] = { -- item give name
        Label = "Ice Tea",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'v_res_tt_can03', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["limonade"] = { -- item give name
        Label = "Limonade",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'v_res_tt_can03', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["drpepper"] = { -- item give name
        Label = "Dr Pepper",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'v_res_tt_can03', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["soda"] = { -- item give name
        Label = "Soda",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_ecola_can', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["energy"] = { -- item give name
        Label = "Energy Drinks",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'sf_prop_sf_can_01a', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["pepsi"] = { -- item give name
        Label = "Pepsi",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_ecola_can', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["big_red"] = { -- item give name
        Label = "Big Red",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_ecola_can', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["jus_raisin"] = { -- item give name
        Label = "Jus de raisin",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_orang_can_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["jusfruit"] = { -- item give name
        Label = "Jus de fruits",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_orang_can_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["crush_orange"] = { -- item give name
        Label = "Crush Orange",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_orang_can_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["crush_raisin"] = { -- item give name
        Label = "Crush Raisin",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_orang_can_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.02, xrot = 05.0, yrot = -10.0, zrot = 0.0},
        Size = 330, -- in ml
        GlassSize = false, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 32, max = 34},
        Alcohol = 0, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 25000, --example
        RemoveStress = 1000, --example
    },
    ["whisky"] = { -- item give name
        Label = "Whisky",
        Type = 'largebottle', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_whiskey_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_cs_shot_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'shot_mount_whisky', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true,
        ConsumeAll = false, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.17, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 400, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 39, max = 41},
        Alcohol = 5, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 35000, --example
        RemoveStress = 1000, --example
    },
    ["martini"] = { -- item give name
        Label = "Martini",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["vodkaenergy"] = { -- item give name
        Label = "Vodka Energy",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["whiskycoca"] = { -- item give name
        Label = "Whisky Coca",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["golem"] = { -- item give name
        Label = "Golem",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["mojito"] = { -- item give name
        Label = "Mojito",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["rhumcoca"] = { -- item give name
        Label = "Rhum Coca",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["rhumfruit"] = { -- item give name
        Label = "Planteur",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["rhum"] = { -- item give name
        Label = "Rhum",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["jager"] = { -- item give name
        Label = "Jager",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["teqpaf"] = { -- item give name
        Label = "Teq Paf",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["tequila"] = { -- item give name
        Label = "Tequilla",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["vodka"] = { -- item give name
        Label = "Vodka",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["vodkafruit"] = { -- item give name
        Label = "Vodka fruit",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["jagercerbere"] = { -- item give name
        Label = "Jager Cerbere",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["metreshooter"] = { -- item give name
        Label = "Meter shooter",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["jagerbomb"] = { -- item give name
        Label = "Jager Bomb",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["grand_cru"] = { -- item give name
        Label = "Grand Cru",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["vine"] = { -- item give name
        Label = "Vin",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    ["champagne"] = { -- item give name
        Label = "Champagne",
        Type = 'drink', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        GlassProp = '', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = '', -- The item you get when you clean a shot or wine into your inventory
        Infuse = false,
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.01, y = -0.01, z = -0.07, xrot = 360.0, yrot = 0.0, zrot = 0.0},
        Size = 40, --ml
        GlassSize = 40, -- -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 5000, --example
    },
    --[[["tequila"] = { -- item give name
        Label = "Tequila",
        Type = 'largebottle', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_tequila_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_cs_shot_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'shot_tequila', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.23, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 500, --ml
        GlassSize = 30, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 30, max = 30},
        Alcohol = 3, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },
    ["nogo_vodka"] = { -- item give name
        Label = "Nogo vodka",
        Type = 'largebottle', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_vodka_bottle', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_cs_shot_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'shot_nogo_vodka', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.28, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 500, --ml
        GlassSize = 30, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 30, max = 30},
        Alcohol = 3, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },
    ["costa_del_perro"] = { -- item give name
        Label = "Costa del perro",
        Type = 'wine', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_wine_bot_01', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_wine_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'glass_costa_del_perro', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.02, y = -0.009, z = -0.26, xrot = 05.0, yrot = -10.0, zrot = 25.0},
        Size = 500, --ml
        GlassSize = 100, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },
    ["rockford_hill"] = { -- item give name
        Label = "Rockford hill",
        Type = 'wine', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_wine_bot_02', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_wine_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'glass_rockford_hill', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.01, z = -0.28, xrot = 0.2, yrot = -03.0, zrot = 0.0},
        Size = 500, --ml
        GlassSize = 100, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },
    ["vinewood_red"] = { -- item give name
        Label = "Vinewood red",
        Type = 'wine', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_wine_rose', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_wine_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'glass_vinewood_red', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.009, z = -0.29, xrot = 0.2, yrot = -06.0, zrot = 0.0},
        Size = 500, --ml
        GlassSize = 100, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },
    ["vinewood_blanc"] = { -- item give name
        Label = "Vinewood blanc",
        Type = 'wine', -- type = 'drink' or 'wine' or 'largebottle'
        Prop = 'prop_wine_white', -- Here are the props https://forge.plebmasters.de/
        GlassProp = 'p_wine_glass_s', -- Prop which you will hold in your hand after pouring shot or wine into a glass
        GiveHideItem = 'glass_vinewood_blanc', -- The item you get when you clean a shot or wine into your inventory
        Infuse = true, -- True if you want to enable pouring into a glass / shot or wine
        ConsumeAll = true, -- true if you want to enable the automatic food / drink button
        Place = false, -- True if you want to allow the item to be placed on the ground
        Position = {x = 0.0, y = -0.02, z = -0.28, xrot = 0.2, yrot = -03.0, zrot = 0.0},
        Size = 500, --ml
        GlassSize = 100, -- ml -- Number of ml taken from the bottle after pouring into a small glass
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 100000, --example
        RemoveStress = 1000, --example
    },]]--
}


Config.Glass = {
    ["shot_mount_whisky"] = { -- item give name
        Label = 'Shot whisky',
        Type = 'shot', -- type = 'shot' or 'wine'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = 0.03, z = 0.02, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 40, -- in ml 
        Bite = {min = 9, max = 11},
        Alcohol = 2, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 18000, --example
        RemoveStress = 1000, --example
    },
    --[[["shot_nogo_vodka"] = { -- item give name
        Label = 'Shot Nogo Vodka',
        Type = 'shot', -- type = 'shot' or 'wine'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = 0.03, z = 0.02, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 30, -- in ml 
        Bite = {min = 30, max = 30},
        Alcohol = 1,
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },
    ["shot_tequila"] = { -- item give name
        Label = 'Shot Tequilya',
        Type = 'shot', -- type = 'shot' or 'wine'
        Prop = 'p_cs_shot_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = 0.03, z = 0.02, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 30, -- in ml 
        Bite = {min = 30, max = 30},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },
    ["glass_costa_del_perro"] = { -- item give name
        Label = 'Glass Costa Del Perro',
        Type = 'wine', -- type = 'shot' or 'wine'
        Prop = 'p_wine_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = -0.03, z = 0.03, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 100, -- in ml 
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },
    ["glass_rockford_hill"] = { -- item give name
        Label = 'Glass Rockford Hill Reserve',
        Type = 'wine', -- type = 'shot' or 'wine'
        Prop = 'p_wine_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = -0.03, z = 0.03, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 100, -- in ml 
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },
    ["glass_vinewood_red"] = { -- item give name
        Label = 'Glass Vinewood Red Zinfadel',
        Type = 'wine', -- type = 'shot' or 'wine'
        Prop = 'p_wine_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = -0.03, z = 0.03, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 100, -- in ml 
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },
    ["glass_vinewood_blanc"] = { -- item give name
        Label = 'Glass Vinewood Sauvignon Blanc',
        Type = 'wine', -- type = 'shot' or 'wine'
        Prop = 'p_wine_glass_s', -- Here are the props https://forge.plebmasters.de/
        Position = {x = 0.11, y = -0.03, z = 0.03, xrot = 250.0, yrot = 0.0, zrot = 0.0},
        Size = 100, -- in ml 
        Bite = {min = 10, max = 15},
        Alcohol = 1, -- Alcohol level : 0 = no alcohol , 1 min / 5 max
        AddStatus = 5000, --example
        RemoveStress = 1000, --example
    },]]--
}
