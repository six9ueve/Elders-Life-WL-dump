Config = {}
Config.Locale = 'fr'

local seconds = 1000

Config.AlarmHacking         = true         -- alarme si hack
Config.ChanceOfAlarm        = 80           -- chance avoir alarme
Config.SecurityJob          = {'police', 'sheriff'}    -- jobs avec alarme
Config.LockPickTimer        = 10 * seconds -- temps lockpick
Config.LockpickChance       = 70           -- lockpick chance
Config.LockpickCanGetBroken = true         -- casse lockpick
Config.KeycardCanBeBreak    = true        -- carte de hack peut etre perdu
Config.KeycardChance        = 90           -- chance reussite hack carte
Config.HackAndLockpickKey   = 74           -- H
Config.CancelLockpickKey    = 73           -- X

--[[ commands

	aimdoor, -- viser porte pour coordonées
	savedoor1, -- sauvegarder coordonnées porte 1
	savedoor2, -- faire aimdoor puis ca si deuxieme porte
	cleardoors, -- reset toutes les values
	mycoords, -- commande pour set le texte ou il devra etre
	createdoor, -- commande pour creer la porte
	doorid, -- voir les id porte
	dvdoor, -- supprimmer une porte avec les id
	codedoor, -- voir code porte avec id

]]--
