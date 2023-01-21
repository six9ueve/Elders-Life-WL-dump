Config = {}
Config.framework = "esx" -- false - "esx" - "qb"
Config.voipScript = "salty" -- "salty" - "mumble" - "pma" - "toko"
Config.useItem = true -- (Need ESX or qb)
Config.ItemName = "radio" -- database item name
Config.EnableRadioKey = true
Config.RaidoKey = "OEM_1" -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.LeaveRadioDie = true -- leave the radio when you die
Config.LeaveRadioDrop = true -- leave the radio channel when you drop the item on the ground(Need ESX or QB)
Config.restrictChannel = { -- (Jobs Need ESX or qb)
    {channel = 1, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 2, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 3, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 4, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 5, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 6, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 7, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 8, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 9, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
    {channel = 10, jobs = {"ambulance", "police","sheriff","gouv","juge","procureur"}},
}
--[[ example
    {channel = 1, acePerms = {"group.police"}},
    {channel = 1, jobs = {"police"}, acePerms = {"group.police"}},
    {channel = 1, jobs = {"police"}},
]]

Config.text = {
    ["frequencyNill"] = "La fréquence est insuffisante",
    ["cantConnect"] = "Vous ne pouvez pas vous connecter à cette fréquence!",
    ["alreadyFrequency"] = "Vous êtes déjà sur cette fréquence.",
    ["notAlreadyFrequency"] = "Vous n'êtes pas sur une fréquence!",
    ["noRadio"] = "tu n'as pas de radio!",
    ["noPerm"] = "Vous ne pouvez pas vous connecter à ce canal.",
    ["leftFrequency"] = "Tu as quitté la fréquence!",
    ["mumbleError"] = "This feature does not work in mumble voip",
    ["connect"] = "Vous vous êtes connecté à la fréquence %s.00 MHz",
    ["leftFrequencyMhz"] = "Tu as quitté la fréquence %s.00 MHz",
}

--[[ 
    example ace permission (https://forum.cfx.re/t/basic-aces-principals-overview-guide/90917)
    add_ace group.jobs group.police allow
    add_ace group.jobs group.ambulance allow
    add_principal identifier.steam:xxxxxxxxx group.jobs
]]

-- Mumble Voip Setting
Config.ActivatorKey = 137 -- Capslock

-- Tokovoip Setting
Config.tokovoipScriptName = "tokovoip_script" -- "tokovoip" - "toko-voip" - "tokovoip-script" - "tokovoip_script"

-- Salty chat
Config.saltyPrimaryRadio = false

--[[ 
Export List
    exports['tgiann-radio']:isRadioOpen()
Client Event List
    tgiann-radio:use    -- Open Radio Event
        TriggerEvent("tgiann-radio:use")
    tgiann-radio:tk     -- Leave Radio Channel
        TriggerEvent("tgiann-radio:tk")
    tgiann-radio:t      -- Join Radio Channel
       TriggerEvent("tgiann-radio:t", "20")
]]