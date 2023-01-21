Config = {}
Config.Locale = 'en'
Config.ESX = 'god:getSharedObject'

Config.Play = {
	Item  = true,			-- Do NOT put true the Money is also true, use one of them
	Money = false,			-- Do NOT put true the Item is also true, use one of them
	
	ItemName = 'jeton_casino',	-- The item name in DB
	AccountMoney = ''		-- Usually the options are "bank", "black_money". Leave empty for cash
}


Config.ItemName = 'jeton_casino' 	-- The chip item in DB

Config.PrintClient = false 	-- Print on client's console the spins in case of object bug
Config.Offset = true 		-- Add propability to stop the spins in wrong position
Config.OffsetNum = 80		-- 30% the sipns will stop offset. Bigger number = less wins

Config.HideUI = false
Config.HideUIEvent = 'pma-voice:toggleui'
Config.ShowUIEvent = 'pma-voice:toggleui'

Config.Mult = { -- Multipliers based on GTA:ONLINE
	['1'] = 25,	
	['2'] = 50,
	['3'] = 75,
	['4'] = 100,
	['5'] = 250,
	['6'] = 500,
	['7'] = 1000,
}


Config.Casino = {
	Center = vector3(1116.40, 236.69, -49.84),		-- The center of the casino
	Radius = 50.0,									-- Radius from the center that has the props (usually 50.0) change it if some slot machines are not working
	
	SlotBets = {
		['vw_prop_casino_slot_01a'] = {
			bet = 1,
			prop1 = 'vw_prop_casino_slot_01a_reels',
			prop2 = 'vw_prop_casino_slot_01b_reels',
		},
		['vw_prop_casino_slot_02a'] = {
			bet = 2,
			prop1 = 'vw_prop_casino_slot_02a_reels',
			prop2 = 'vw_prop_casino_slot_02b_reels',
		},
		['vw_prop_casino_slot_03a'] = {
			bet = 3,
			prop1 = 'vw_prop_casino_slot_03a_reels',
			prop2 = 'vw_prop_casino_slot_03b_reels',
		},
		['vw_prop_casino_slot_04a'] = {
			bet = 4,
			prop1 = 'vw_prop_casino_slot_04a_reels',
			prop2 = 'vw_prop_casino_slot_04b_reels',
		},
		['vw_prop_casino_slot_05a'] = {
			bet = 5,
			prop1 = 'vw_prop_casino_slot_05a_reels',
			prop2 = 'vw_prop_casino_slot_05b_reels',
		},
		['vw_prop_casino_slot_06a'] = {
			bet = 10,
			prop1 = 'vw_prop_casino_slot_06a_reels',
			prop2 = 'vw_prop_casino_slot_06b_reels',
		},
		['vw_prop_casino_slot_07a'] = {
			bet = 25,
			prop1 = 'vw_prop_casino_slot_07a_reels',
			prop2 = 'vw_prop_casino_slot_07b_reels',
		},
		['vw_prop_casino_slot_08a'] = {
			bet = 50,
			prop1 = 'vw_prop_casino_slot_08a_reels',
			prop2 = 'vw_prop_casino_slot_08b_reels',
		},
	}
}








Config.Wins = { -- DO NOT TOUCH IT
	[1] = '2',
	[2] = '3',
	[3] = '6',
	[4] = '2',
	[5] = '4',
	[6] = '1',
	[7] = '6',
	[8] = '5',
	[9] = '2',
	[10] = '1',
	[11] = '3',
	[12] = '6',
	[13] = '7',
	[14] = '1',
	[15] = '4',
	[16] = '5',
}