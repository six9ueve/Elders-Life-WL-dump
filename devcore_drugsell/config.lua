Config = {}

--v0.05

Config.Locale = 'fr'


Config.Command = 'dealer'
Config.esxVersion = 'final' --write your esx version '1.2' , '1.1', 'final', 'legacy'
--buttons - https://docs.fivem.net/docs/game-references/controls/
Config.OfferButton = 38   -- N
Config.GiveDrugsButton = 38  -- N
Config.Run = 113  -- G
Config.BargainButton= 316   -- PAGE UP
Config.AcceptOfferButton= 38 -- N
Config.CancelOffer = 113   -- G
Config.CancelSellButton = 113 -- G
----
Config.CallCopsPercent = 5 -- (min1) if there is 1 buyer, he always calls the police=100%, 2=50%, 3=33%, 4=25%, 5=20%

Config.randomReject = 3 -- (min1) if 1 buyer always refuses =100%, 2=50%, 3=33%, 4=25%, 5=20%

Config.PercentBargain = 4  -- if there is 1 then the buyer always raises the price =100%, 2=50%, 3=33%, 4=25%, 5=20%

Config.randomRobGang = 5 -- chance of robbery =100%, 2=50%, 3=33%, 4=25%, 5=20%

Config.thiefshooting = 3 -- Percentage of shooting. After clicking the run away =100%, 2=50%, 3=33%, 4=25%, 5=20%
----
Config.Cooldown = 60000 -- 60s cooldown for command
Config.RequiredPoliceOnline = 0 -- Set how many police officers are needed in the city
Config.blipTime = 30   -- Blip display time
Config.GiveBlack = true
Config.mugshotnotify = false -- enable display of suspect during shelf notification
Config.PoliceSalesMan = true -- true - If you want a police officer can not sell drugs
Config.PoliceDatabaseName = 'police'
Config.PoliceDatabaseName2 = 'sheriff'
Config.SellMenuAlign = 'top-left'

Config.SellInCar = false -- Allow sale from the vehicle

Config.ThiefNpc = { -- 
  "csb_ortega",
  "csb_ramp_gang",
  "g_m_importexport_01",
  "g_m_y_famca_01",
  "g_m_y_ballaeast_01",
  "g_m_y_ballaorig_01",
  "g_m_y_ballasout_01",
  "g_m_y_famdnf_01",
  "g_m_y_famfor_01",
  "g_m_y_korean_01",
  "g_m_y_lost_01",
  "g_m_y_lost_02",
  "g_m_y_lost_03",
  "g_m_y_mexgoon_01",
  "g_m_y_mexgoon_02",
  "g_m_y_mexgoon_03",
  "g_m_y_pologoon_01",
  "g_m_y_pologoon_02",
  "g_m_y_salvaboss_01",
  "g_m_y_salvagoon_01",
  "g_m_m_armgoon_01"

}

Config.BlacklistNPC = { -- https://wiki.rage.mp/index.php?title=Peds
  "s_m_o_busker_01",
  "ig_abigail"
}

Config.SellNpcItems = {
    {Items = "weed_pooch", ItemsLabel = "Pochon de Weed", PriceMin = 80, PriceMax = 200, MinAmount = 1, MaxAmount = 3 },
    {Items = "meth_pooch", ItemsLabel = "Pochon de Meth", PriceMin = 330, PriceMax = 450, MinAmount = 1, MaxAmount = 2 },
    {Items = "opium_pooch", ItemsLabel = "Pochon Opium", PriceMin = 180, PriceMax = 280, MinAmount = 1, MaxAmount = 3 },
    {Items = "cocaine_pooch", ItemsLabel = "Pochon de Cocaine", PriceMin = 250, PriceMax = 350, MinAmount = 1, MaxAmount = 2 },
}
