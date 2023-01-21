Config = {}

Config.Locale = 'fr'

Config.EarCigCommand = 'earcig'
------------- 
Config.EnableGiveArmor = false
Config.EnableGiveStress = true
Config.afterSmoking = true -- true if you want armor and stress after smoking false if you want armor and stress after each exhale
------------ 
Config.CigaretteExhale = 0.15
Config.CigarExhale = 0.15
Config.JointExhale = 0.15
Config.VapeExhale = 0.4
Config.BongExhale = 0.4
------------
Config.JointSmoke = 0.03
Config.CigarSmoke = 0.05
Config.CigaretteSmoke = 0.03

Config.SizeRemove = {min = 1, max = 2} -- how much size is removed after one exhalation
Config.ExhaleTime = {min = 1000, max = 1500}
------------- BUTTONS 
Config.DisableCombatButtons = true -- Deactivates the attack buttons while smoking
Config.SmokeButton = 144
Config.ThrowButton = 22
Config.MouthButton = 114
Config.HandButton = 114
Config.GiveButton = 121
Config.ConfirmGiveButton = 38
Config.CancelGiveButton = 22
-------------

function StressTrigger(stress)
    TriggerEvent('god_status:remove', 'stress', stress)
end


------------
Config.Lighter = 'lighter' -- a add in bdd
--Vape
Config.ItemVapeLiquid = 'liquid'
Config.MaxLiquid = 6
Config.AddLiquidInVape = 3 -- How much ml is added after pouring the liquid into the vape
Config.VapeSizeRemove = 0.5 -- How much ml of liquid is removed from the vape after one coating
--Bong
Config.MaxWeed = 3 -- Max g weed in bong
Config.AddWeedInBong = 1 -- how much g is added to the bong after one grass
Config.BongSizeRemove = 1 -- How much g of grass is removed from the bong after one coating
--

Config.CigarettePack = { -- set the pack items here and which items you get from the pack
    {PackItem = "malborapack",  CigaretteItem = 'malbora', Amount = 10},-- a add in bdd
    {PackItem = "ocb_paperpack",  CigaretteItem = 'malbora', Amount = 10},-- a add in bdd
}

Config.OCBPack = { -- set the pack items here and which items you get from the pack
    {PackItem = "ocb_paperpack",  CigaretteItem = 'ocb_paper', Amount = 10},-- a add in bdd
}

Config.Smoke = {
    {Item = "gitanes",  Prop = 'prop_cigar_01', Armor = 5, Stress = 500, Size = 20, Type = 'cigar', Time = 120, effect = 9},--
    {Item = "malbora",  Prop = 'ng_proc_cigarette01a', Armor = 5, Stress = 500, Size = 20, Type = 'cigarette', Time = 120, effect = 9},--
    --{Item = "vape",  Prop = 'ba_prop_battle_vape_01', Armor = 5, Stress = 5, Size = 0, Type = 'vape', Time = 0, effect = 9},--
    {Item = "bong",  Prop = 'prop_bong_01', Armor = 5, Stress = 1000, Size = 0, Type = 'bong', Time = 30, effect = 9},--
    {Item = "splif",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 9},--
    {Item = "splifopium",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 9},
    {Item = "joint_Haze",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 4},
    {Item = "joint_LDW",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 2},
    {Item = "joint_cbd",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 5},
    {Item = "joint_Skunk",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 7},
    {Item = "joint_harlequin",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 1},
    {Item = "joint_white_bud",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 2},
    {Item = "joint_whitewidow",  Prop = 'prop_sh_joint_01', Armor = 5, Stress = 500, Size = 20, Type = 'joint', Time = 120, effect = 3},
}

Config.BongReloadItems = {
    {Items = "meth_pooch", ItemsLabel = "Pochon de meth"},
    {Items = "weed_pooch", ItemsLabel = "Pochon de weed"},
    {Items = "pochon_harlequin", ItemsLabel = "Pochon de Harlequin"},
    {Items = "pochon_white_widow", ItemsLabel = "Pochon de White Widow"},
    {Items = "pochon_skunk", ItemsLabel = "Pochon de Skunk"},
    {Items = "pochon_haze", ItemsLabel = "Pochon de Haze"},
    {Items = "pochon_white_bud", ItemsLabel = "Pochon de WhiteBud"},
    {Items = "pochon_ldw", ItemsLabel = "Pochon de LDW"},
}

--Rollings joints
Config.Rollingpaper = 'ocb_paper'-- a add in bdd

Config.ItemWeed = {    -- Weed bag
	'opium_pooch',
    'weed_pooch'
}
-------------------------