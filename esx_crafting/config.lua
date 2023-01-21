Crafting = {}
--[[
    You can add or remove if you want, be sure to use the right format like this:
    ["item_name"] = {
        label = "Item Label",
        needs = {
            ["item_to_use_name"] = {label = "Item Use Label", count = 1}, 
            ["item_to_use_name2"] = {label = "Item Use Label", count = 2},
        },
        threshold = 0,
    },

    #! 
        Threshold level is a level that gets saved (in the database) by crafting, if you craft succefully you gain points, if you fail you lose points.
        The threshold level can be changed to your liking.
    #!

    Also if you don't have the items below make sure to remove it and create your own version.
]]--
Crafting.Items = {
    ["splifopium"] = {
        label = "Splif Opium",
        needs = {
            ["ocb_paper"] = {label = "Feuille OCB", count = 1},
            ["opium_pooch"] = {label = "Opium", count = 1},
            ["malbora"] = {label = "Cigarette", count = 1},
        },
        threshold = 0,
    },
    ["splif"] = {
        label = "Splif Weed",
        needs = {
            ["ocb_paper"] = {label = "Feuille OCB", count = 1},
            ["weed_pooch"] = {label = "Weed", count = 1},
            ["malbora"] = {label = "Cigarette", count = 1},
        },
        threshold = 0,
    },
}