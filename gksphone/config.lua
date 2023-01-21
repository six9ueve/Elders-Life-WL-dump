ESX = exports['es_extended']:getSharedObject()

--- If you get ESX nil error delete above code and run below code --

--ESX = nil
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------------------------------------------------------------------------------------------


-- PHONE SETTINGS --

Config = {}
Config.KeyMapping       = true                 --## This setting is for those using slotted inventory. (Prevents key operation)
Config.OpenPhone        = 'f1'                 --## Phone open key ## https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.RegisterCommand  = "TooglePhone"        --
Config.ItemName         = {
                            "tel",
                            "pink_phone",
                            "gold_phone"
                        }
Config.ChargeItemName       = "powerbank"      -- PowerBank Item Name
Config.PropActive           = true
Config.Locale               = 'fr'
Config.Fahrenheit           = false
Config.DataUsersPhoneNumber = false            -- You can use it if there is phone_number in the users table in the database.
Config.UsableItem           = true             -- If you want to use without items set it to false
Config.AirDropID            = false
Config.AutoMessageDelete    = true             -- Automatically deletes messages (Messages,Mail,Group Messages,Tinder Messages,Yellow Pages)
Config.AutoDeleteTime       = 7                -- How many days ago you want to delete data
Config.TargetExport         = "qtarget"        -- exports["qtarget"]  -- Resource Name
Config.EyeTarget            = false            -- required qtarget
Config.WaitPhone            = 2                -- Cycle time when phone is on
-- PHONE SETTINGS --


-- ESX  --
Config.ESXVersion           = "1.2"            -- ESX Version 1.1 OR 1.2
Config.ESXName              = "esx"            -- if you are using a different ESX name (you may need to change it)
Config.EsxAddonAcc          = 'god_addonaccount:getSharedAccount'   -- if you are using a different ESX name (you may need to change it)
Config.ESXonPlayerDeath     = 'god_ambulancejob:revive'      -- Trigger to be used when the player dies
Config.ESXonPlayerSpawn     = 'playerSpawned'      --  The trigger that should be when the player gets revive
Config.ESXScoietyGetEmployes = "god_society:getEmployees"   -- ESX Scoiety Adjust the triggers accordingly if they are different for you.
Config.ESXScoietySetJob      = "god_society:setJob"         -- ESX Scoiety Adjust the triggers accordingly if they are different for you.
Config.ESXScoietyGetJob      = "god_society:getJob"         -- ESX Scoiety Adjust the triggers accordingly if they are different for you.
-- ESX --


-- SETTINGS REQUIRED TO SPEAK VOICE --


Config.MumbleExport         = "mumble-voip"       -- exports["mumble-voip"]
Config.PMAVoiceExport       = "pma-voice"         -- exports["pma-voice"]
Config.PMAVoice         = false                   -- Use Pma-Voice Resource (Recomended!) https://github.com/AvarianKnight/pma-voice
Config.UseMumbleVoIP    = false                   -- Use Frazzle's Mumble-VoIP Resource https://github.com/FrazzIe/mumble-voip
Config.UseTokoVoIP      = false
Config.SaltyChat        = true                   -- SaltyChat (v2.6)


--- ## CALL COMMAND ### ---

Config.OnlineContactPlayers = false    -- Activate to see active players in the contacts

Config.CallAnswer = "answer"  -- quick answer (registercommand)
Config.EndCall = "endcall"  -- to close call (registercommand)

Config.SpecificNumberOn = false  --- If you want the SpecificNumber function to work, enable it
 -- When this number is called the trigger on the doc page will work.
 -- server : https://docs.gkshop.org/gksphone/developers/server-event#specific-number
 -- client : https://docs.gkshop.org/gksphone/developers/client-event#specific-number
Config.SpecificNumber = {
    ["5555555"] = true
}

--- ### TEBEX - MUSIC - YOUTUBE  ### ---

Config.TebexTransactionID = "tbx-3282922a36380-c561cc" --- Required for Youtube and Music app. (example : tbx-.....)

-- APP SETTINGS --

Config.TaxiPrice        = 45      -- Taxi Price ( 75$/KM )
Config.TaxiJobCode      = "taxi"  -- Job Code

-- ### BANK APP ### ---
Config.BankTransferCom  = 0     -- Bank transfer commission rate
Config.OfflineBankTransfer = false

-- ### VALE APP ### ---
Config.OwnedVehicles        = "owned_vehicles"    -- ## SQL TABLE NAME (VEHICLES)
Config.ValetOut             = "OUT"               -- ## GARAGE IN OUT OPTION
Config.ValePrice            = 100                 -- Vale Price
Config.ValeNPC              = true                -- Activate if you want the valet to bring the car to you.
Config.ImpoundVale          = true                -- Set to true to not fetch impounded cars


Config.cdGarages            = false   -- Activate if you are using Codesign Garage (https://codesign.pro/package/4206352)
Config.loafGarages          = false   -- Activate if you are using Loaf Garage (https://store.loaf-scripts.com/package/4310876)

Config.ClassList = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

-- ## CAR SELLER ## --
Config.OfflineCarSeller = true
Config.DefaultGarage = "pillboxgarage"  -- The garage where the car will go when a car is purchased
Config.Carhashdebug = false  -- car hash (f8)
Config.CarsSellerBlacklist = {
    [-1216765807] = true, -- car hash and true/false
    [-1236765807] = false
}

-- ### Business APP ### ---

Config.JobGrade           = { -- Business level (Invoice cancellation authorization)
    ["police"] = 1,
    ["ambulance"] = 2,
    ["mechanic"] = 2
}

-- ### House APP ### ---
Config.loafHouse          = false   -- Activate if you are using Loaf House (https://store.loaf-scripts.com/package/4310850)


-- ### YellowPages APP ### ---
Config.YellowpagesPrice = 300

-- ### Twitter APP ### ---
Config.TwitterVerifyCommand = "twitterverify"

-- ### Instagram APP ### ---
Config.InstagramVerifyCommand = "instagramverify"

-- ### Race APP ### ---
Config.RaceAutCommand = "raceaut"
Config.esxcoreaut = "admin"  --- esx 1.2 authorization system

-- ### Charge ### --- (/charge playerid charge(0-100))
Config.ChargeAutCommand = "charge"
Config.esxcorechargeaut = "superadmin"  ---  esx 1.2 authorization system

-- APP SETTINGS --


--## PHONE Box --##
Config.PhoneBox = true
Config.PhoneBoxKey = "E"
Config.PhoneBoxRegCom = "phonebox"
Config.PhoneBoothMoney = { actived = true, money = 500 }
Config.PhoneBoothModel = {
	[1281992692] = true,
    [1158960338] = true,
    [295857659] = true,
    [-78626473] = true,
    [-2103798695] = true,
    [1511539537] = true,
    [-1559354806] = true
}
Config.PhoneBootNumber = "222"


--## Crypto ##--

Config.Crytos = {
    ["bitcoin"] = true,
    ["ethereum"] = true,
    ["tether"] = true,
    ["binance-usd"] = true,
    ["uniswap"] = true,
    ["binancecoi"] = true,
    ["terra-luna"] = true,
    ["avalanche-2"] = true,
    ["cardano"] = true,
    ["ripple"] = true,
    ["usd-coin"] = true,
    ["dogecoin"] = true,
    ["litecoin"] = true,
    ["chainlink"] = true,
    ["stellar"] = true,
    ["tron"] = true,
    ["eos"] = true,
    ["monero"] = true,
    ["iota"] = true
}

---##  Spam ## ---

Config.SpamLimit = 6  -- Default: 6
Config.SpamReset = 10  -- seconds
Config.SpamPlayerKick = true
Config.SpamDropPlayer = "[GKSPHONE] Trop de Spam"