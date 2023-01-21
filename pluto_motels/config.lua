Config = {}

-- [General Settings] -- 
Config.AutoDatabaseCreator = true -- Once this script has been started once with this turned on true you can put it to false, this runs the code to create a database in databaseCreator.lua
Config.EnableKeySystem = false -- This is set to true if you have the resource Pluto-Keys.
Config.NewESX = true -- Set this to true if you have the final esx version.
Config.DiscInventory = false -- Enable if you use disc inventorhud or want to use their ui for storage.
Config.EnableDebug = false

-- [Motel Settings] --
Config.RentTimer = 24 -- Time in hours, time between payments if rent mode is enabled.
Config.AutoRemoveRoom = Config.RentTimer * 3 -- This will remove the room after 7 missed payments.
Config.StoreCash = false -- Enable if you want player to be able to store cash in storage.
Config.StoreBlackMoney = true -- Enable if you want player to be able to store black money in storage.
Config.KeyPrice = 10 -- Price to purchase extra key.
Config.RaidJob = "police" -- The job you need to have to raid if you have raid enabled.
Config.RaidJob2 = "sheriff" -- The job you need to have to raid if you have raid enabled.
Config.RaidTimer = 30 -- Time in seconds that it takes for a police man to open up the door.
Config.RaidEnabled = true -- Enable this if you want police to have the ability to raid rooms.
Config.RobEnabled = true
Config.CancelRoomCommand = "rendrechambre" -- Set to false if you don't want to have the ability to cancel room.

Config.Motels = {
    --[[{ -- Breze Sandy Motel
        ["motelName"] = "The Motor Motel", -- Name that appears in map as a blip.
        ["motelPosition"] = vector3(1142.3671875, 2664.0708007813, 38.160991668701), -- Position of motel.
        ["doorHash"] = -1663022887,
        ["doorOffset"] = vector3(-1.0, 0.0, 0.0),
        ["motelPrice"] = 25, -- Price to buy if rentMode is false or the price you pay for the rent every time.
        ["rentMode"] = true, -- If true then rooms are only rented, if set to false you buy the room and no other charges are made afterwards.
        ["roomFinish"] = "sandy_motel",
        ["furniture"] = {
            ["drawer"] = {
                ["restricted"] = true, -- If this should only be accesed by owner of room set to true
                ["offset"] = vector3(2.4, 1.6, -1.4), -- Offsets coords from door to set position of furniture.
                ["text"] = "Stash", -- Text that appears in 3D Text.
                ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                ["callback"] = function(interiorId, furnitureName)
                    OpenStash(interiorId, furnitureName)
                end
            },
            ["nightstand"] = {
                ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                ["offset"] = vector3(0.9, -3.8, -1.8), -- Offsets coords from door to set position of furniture.
                ["text"] = "Nightstand", -- Text that appears in 3D Text.
                ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                ["callback"] = function(interiorId, furnitureName)
                    OpenStash(interiorId, furnitureName)
                end
            },
            ["wardrobe"] = {
                ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                ["offset"] = vector3(2.85, -0.9, -1.4), -- Offsets coords from door to set position of furniture.
                ["text"] = "Wardrobe",
                ["callback"] = function(interiorId, furnitureName)
                    Wardrobe()
                end
            },
            ["manager"] = {
                ["restricted"] = true,-- If this should only be accesed by owner of room set to true
                ["offset"] = vector3(0.4, 4.6, -1.4), -- Offsets coords from door to set position of furniture.
                ["text"] = "Room managment",
                ["callback"] = function(interiorId, roomNumber, motelData)
                    RoomManagment(interiorId, roomNumber, motelData)
                end
            },
        }
    },]]--
      { --GABZ PINK CAGE
         ["motelName"] = "Pink Cage Motel", -- Name that appears in map as a blip.
         ["motelPosition"] = vector3(324.10665893555, -208.66101074219, 54.086624145508), -- Position of motel.
         ["doorHash"] = -1156992775,
         ["doorOffset"] = vector3(1.0, 0.0, 0.0),
         ["motelPrice"] = 200, -- Price to buy if rentMode is false or the price you pay for the rent every time.
         ["rentMode"] = true, -- If true then rooms are only rented, if set to false you buy the room and no other charges are made afterwards.
         ["furniture"] = {
             ["drawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(0.25, -2.0, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Coffre", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             --[[["bedroomDrawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(3.6, 0.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Stash", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             ["nightstand"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(4.5, -3.2, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Nightstand", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },]]--
             ["wardrobe"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(-0.25, 2.5, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Dressing",
                 ["callback"] = function(interiorId, furnitureName)
                     Wardrobe()
                 end
             },
             ["manager"] = {
                 ["restricted"] = true,-- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(-1.4, 0.5, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Manager la chambre",
                 ["callback"] = function(interiorId, roomNumber, motelData)
                     RoomManagment(interiorId, roomNumber, motelData)
                 end
             },
         }
     },
      { --sandy
         ["motelName"] = "Sandy Motel", -- Name that appears in map as a blip.
         ["motelPosition"] = vector3(368.71, 2632.84, 44.49), -- Position of motel.
         ["doorHash"] = -384231627,
         ["doorOffset"] = vector3(0.5, 0.0, 0.0),
         ["motelPrice"] = 300, -- Price to buy if rentMode is false or the price you pay for the rent every time.
         ["rentMode"] = true, -- If true then rooms are only rented, if set to false you buy the room and no other charges are made afterwards.
         ["furniture"] = {
             ["drawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(5.0, 2.5, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Coffre", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             --[[["bedroomDrawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(3.6, 0.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Stash", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             ["nightstand"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(4.5, -3.2, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Nightstand", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },]]--
             ["wardrobe"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(6.0, -1.0, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Dressing",
                 ["callback"] = function(interiorId, furnitureName)
                     Wardrobe()
                 end
             },
             ["manager"] = {
                 ["restricted"] = true,-- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(2.0, 1.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Manager la chambre",
                 ["callback"] = function(interiorId, roomNumber, motelData)
                     RoomManagment(interiorId, roomNumber, motelData)
                 end
             },
         }
     },
     { --Paleto
        ["motelName"] = "Vespucci Motel", -- Name that appears in map as a blip.
         ["motelPosition"] = vector3(-1317.16, -929.36, 11.00), -- Position of motel.
         ["doorHash"] = -580006562,
         ["doorOffset"] = vector3(-0.5, 0.0, 0.0),
         ["motelPrice"] = 300, -- Price to buy if rentMode is false or the price you pay for the rent every time.
         ["rentMode"] = true, -- If true then rooms are only rented, if set to false you buy the room and no other charges are made afterwards.
         ["furniture"] = {
             ["drawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(-1.0, 2.5, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Coffre", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             --[[["bedroomDrawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(3.6, 0.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Stash", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             ["nightstand"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(4.5, -3.2, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Nightstand", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },]]--
             ["wardrobe"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(0.0, -2.0, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Dressing",
                 ["callback"] = function(interiorId, furnitureName)
                     Wardrobe()
                 end
             },
             ["manager"] = {
                 ["restricted"] = true,-- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(1.0, 1.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Manager la chambre",
                 ["callback"] = function(interiorId, roomNumber, motelData)
                     RoomManagment(interiorId, roomNumber, motelData)
                 end
             },
         }
     },
    { --Paleto
         ["motelName"] = "Bay View Motel", -- Name that appears in map as a blip.
         ["motelPosition"] = vector3(-697.52, 5771.67, 17.30), -- Position of motel.
         ["doorHash"] = -664582244,
         ["doorOffset"] = vector3(0.0, 0.0, 0.0),
         ["motelPrice"] = 200, -- Price to buy if rentMode is false or the price you pay for the rent every time.
         ["rentMode"] = true, -- If true then rooms are only rented, if set to false you buy the room and no other charges are made afterwards.
         ["furniture"] = {
             ["drawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(2.0, -2.0, -0.5), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Coffre", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             --[[["bedroomDrawer"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(3.6, 0.3, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Stash", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },
             ["nightstand"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(4.5, -3.2, -1.0), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Nightstand", -- Text that appears in 3D Text.
                 ["type"] = "storage", -- Set the type to storage if you want to be able to store stuff.
                 ["callback"] = function(interiorId, furnitureName)
                     OpenStash(interiorId, furnitureName)
                 end
             },]]--
             ["wardrobe"] = {
                 ["restricted"] = false, -- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(-1.0, -3.5, -0.5), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Dressing",
                 ["callback"] = function(interiorId, furnitureName)
                     Wardrobe()
                 end
             },
             ["manager"] = {
                 ["restricted"] = true,-- If this should only be accesed by owner of room set to true
                 ["offset"] = vector3(0.5, -0.5, -0.5), -- Offsets coords from door to set position of furniture.
                 ["text"] = "Manager la chambre",
                 ["callback"] = function(interiorId, roomNumber, motelData)
                     RoomManagment(interiorId, roomNumber, motelData)
                 end
             },
         }
     },
}

Config.RoomFinishes = { -- These are the interior designs you can change to in the room.
    {
        ["name"] = "Default design", -- Name that appears in menu.
        ["finish"] = "sandy_motel", -- Do not touch if you don't know what this is.
        ["price"] = 1 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Blue theme", -- Name that appears in menu.
        ["finish"] = "sandy_motel2", -- Do not touch if you don't know what this is.
        ["price"] = 2 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Dirty white", -- Name that appears in menu.
        ["finish"] = "sandy_motel3", -- Do not touch if you don't know what this is.
        ["price"] = 3 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Cream", -- Name that appears in menu.
        ["finish"] = "sandy_motel4", -- Do not touch if you don't know what this is.
        ["price"] = 4 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Modern dark grey", -- Name that appears in menu.
        ["finish"] = "sandy_motel5", -- Do not touch if you don't know what this is.
        ["price"] = 5 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Retro theme", -- Name that appears in menu.
        ["finish"] = "sandy_motel6", -- Do not touch if you don't know what this is.
        ["price"] = 6 -- The price it cost to change to this interior.
    },
    {
        ["name"] = "Modern cream", -- Name that appears in menu.
        ["finish"] = "sandy_motel7", -- Do not touch if you don't know what this is.
        ["price"] = 7 -- The price it cost to change to this interior.
    }
}

Config.autoweight = 1000

Config.maxweight = 300000

Config.localWeight = {
    ["sac_conservation"] = 110,
    ["defib"] = 250,
    ["water"] = 110,
    ["bread"] = 80,
                    -----------PIECE AUTO----------
    --2jzengine = 4000, 
    ["bielles"]  = 110,   
                    -------- vol  
    ["Xbox"]   = 110, 
                    -----------CASSE----------
    ["battery"] = 1000,
    ["coffre"]  = 400,
    ["doors"]   = 2500,
    ["engine"]  = 2500,
    ["hood"]    = 2500,
    ["steeringwheel"] = 2500,
    ["trunk"] = 2500,

                    -----------vigne----------
    ["raisin"] = 450,
    ["jus_raisin"] = 200,
    ["vine"] = 200,
    ["grand_cru"] = 200,
                    -----------brasserie----------
    ["houblon"] = 450,
    ["orge"] = 450,
    ["malt"] = 450,
    ["bierenoel"]= 200,
    ["biereblonde"] = 200,
    ["bierebrune"] = 200,
    ["biereambree"] = 200,
    ["agave"] = 450,
                    -----------Distillerie----------
    ["alcool"] = 450,
    ["potato"] = 450,
    ["plante"] = 450,
    ["canneasucre"] = 450,
    ["malt"] = 450,
    ["whisky"] = 200,
    ["vodka"] = 200,
    ["rhum"] = 200,
    ["jager"] = 200,
                    ------------tabac -------------
    ["tabacblond"] = 450,
    ["tabacbrun"] = 450,
    ["tabacblondsec"] = 400,
    ["tabacbrunsec"] = 400,
    ["gitanes"] = 200,
    ["malbora"] = 200,
--------------drogues-----------
    ["hydrochloric"] = 280,
    ["hydrochloric_bottle"] = 280,
    ["sodiumhydroxide"] = 280,
    ["sulfuricacid"] = 280,
    ["sulfuricacid_bottle"] = 280,
    ["cocaleaves"] = 300,
    ["coca_decouper"] = 280,
    ["coca_traiter"] = 280,
    ["esrar_islenmis"] = 280,
    ["esrar_islenmis2"] = 280,  
    ["meth_pooch"] = 80,
    ["trimmedweed"] = 300,
    ["weed_pooch"] = 80,
    ["cocaine_pooch"] = 80,

    ["advancedrifle"] = 7500,
    ["assaultrifle"] = 7500,
    ["assaultrifle_mk2"] = 7500,
    ["assaultshotgun"] = 7500,
    ["autoshotgun"] = 7500,
    ["assaultsmg"] = 7500,
    ["bullpuprifle"] = 7500,
    ["bullpuprifle_mk2"] = 7500,
    ["bullpupshotgun"] = 7500,
    ["carbinerifle"] = 7500,
    ["carbinerifle_mk2"] = 7500,
    ["combatmg"] = 7500,
    ["combatmg_mk2"] = 7500,
    ["combatpdw"] = 7500,
    ["combatshotgun"] = 7500,
    ["compactlauncher"] = 7500,
    ["compactrifle"] = 7500,
    ["dbshotgun"] = 7500,
    ["doubleaction"] = 7500,
    ["firework"] = 7500,
    ["gusenberg"] = 7500,
    ["heavyshotgun"] = 7500,
    ["heavysniper"] = 7500,
    ["heavysniper_mk2"] = 7500,
    ["hominglauncher"] = 7500,
    ["marksmanpistol"] = 7500,
    ["marksmanrifle"] = 7500,
    ["marksmanrifle_mk2"] = 7500,
    ["militaryrifle"] = 7500,
    ["minigun"] = 7500,
    ["minismg"] = 7500,
    ["pumpshotgun"] = 7500,
    ["pumpshotgun_mk2"] = 7500,
    ["revolver_mk2"] = 7500,
    ["sniperrifle"] = 7500,

    ["appistol"] = 2200,
    ["ceramicpistol"] = 2200,
    ["combatpistol"] = 2200,
    ["heavypistol"] = 2200,
    ["machinepistol"] = 2200,
    ["pistol50"] = 2200,
    ["pistol"] = 2200,
    ["pistol_mk2"] = 2200,

    ["bat"] = 750,
    ["battleaxe"] = 750,
    ["bottle"] = 750,
    ["crowbar"] = 750,
    ["kevlar"] = 750,
    ["knuckle"] = 750,
    ["machete"] = 750,
}