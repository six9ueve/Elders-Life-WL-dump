ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
    TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(100)
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end

CopsPlyBlips = {}
local removeIndex  = 1
local arrayIndexSecu = 1
local arraysecu = {
    'Afficher',
    'Cacher'
}

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("EldersPolice:waitingForPlaque")
AddEventHandler("EldersPolice:waitingForPlaque", function()
    Citizen.Wait(8000)
    waitingForPlaque = false
    ClearPedTasks(PlayerPedId())
end)

local spawnedVehicles = {}

local restoreCoords = vector3(-624.75,-102.55,33.89)

LSPD = {
    playerItem = {},
    FineLister = {},
    playerWeapon = {},
    playerBlackMoney = {},
    RadarPlaced = {},
    Radar = {},
    SaisieActif = {},
    quantity = {},
    LoadoutActif = {},
    VehList = {},
    ZonesCam = {"Place des cubes", "Quartiers", "Pacifique banque"},
    inServicePolice = false,
    MenuLSPD = false,
    sServiceInfos = false,
    GarageLSPD = false,
    Extra = false,
    GestPlainte = false,
    Helico = false,
    GarageShop = false,
    PlainteActif = false,
    VestiaireLSPD = false,
    Camera = false,
    Saisie = false,
    AmmuLSPD = false,
    VehLSPD = false,
    VehSelectLSPD = false,
    BraceletLSPD = false,
    BraceletputLSPD = false,
    BraceletgestLSPD = false,
    Index = 1,
    IndexFine = 1,
    Matricule = 1,
    IndexCustom = 1,
    ChangerCam = 1,
    ZonesCamIndex = 1,
    selecQuantity = 1,
    MyMatricule = "Aucun",
    VehiculeInfos = nil,
    ObjetSaisie = {
        [1] = {"weed","weed_pochon","coke","coke_pochon","meth","meth_pochon","opium","opium_pochon","lsd","lsd_pochon","cokeq","cokeq_pochon","weedq1","weddq_pochon","medoc","resine","resine_pochon","ipad","airpods","jouer","tvsamsmung","ordip","iphonex","chrgportable","cgnvidia","montreluxe"},
        [2] = {"WEAPON_DAGGER", "WEAPON_MACHETE", "WEAPON_BOTTLE", "WEAPON_CROWBAR", "WEAPON_HATCHET", "WEAPON_KNUCKLE", "WEAPON_WRENCH", "WEAPON_BATTLEAXE", "WEAPON_POOLCUE", "WEAPON_PISTOL","WEAPON_VINTAGEPISTOL","WEAPON_HEAVYPISTOL","WEAPON_DOUBLEACTION","WEAPON_MICROSMG","WEAPON_MACHINEPISTOL","WEAPON_MINISMG","WEAPON_COMBATPDW","WEAPON_ASSAULTSMG","WEAPON_SAWNOFFSHOTGUN","WEAPON_DBSHOTGUN","WEAPON_BULLPUPSHOTGUN","WEAPON_AUTOSHOTGUN","WEAPON_BULLPUPRIFLE","WEAPON_SPECIALCARBINE","WEAPON_COMPACTRIFLE","WEAPON_GUSENBERG","WEAPON_MOLOTOV","WEAPON_FLARE","WEAPON_ASSAULTRIFLE"},
    }
}

RMenu.Add('police_menu', 'police_menu_main', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_inter', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_veh', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_veh_infos', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_veh'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_fouille', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_inter'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_identity', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_inter'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_codes', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_service', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_bill_no', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_inter'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_fine', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_inter'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_fine_gest', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_fine'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_props', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_licenses', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_props_gest', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_props'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_radar_main', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_menu_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_radar_gest', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_radar_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_radar_selec', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_radar_gest'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_radar_infos', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_radar_main'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_zone_infos', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_codes'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_radar_infos_gest', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_radar_infos'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'vestiaire_main', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_amu_main', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_veh_main', RageUI.CreateMenu("LSPD", "VEHICULES", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_vehselect_main', RageUI.CreateMenu("LSPD", "VEHICULES", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_plainte_main', RageUI.CreateMenu("PLAINTE", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_plainte_gest', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_plainte_gest_main', RageUI.CreateSubMenu(RMenu:Get('police_menu', 'police_plainte_gest'), "LSPD", "INT??RACTIONS"))
RMenu.Add('police_menu', 'police_extra_main', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('police_menu', 'police_camera_main', RageUI.CreateMenu("LSPD", "INT??RACTIONS", nil,nil, "aLib", "black"))
RMenu:Get('police_menu', 'vestiaire_main').Closed = function()LSPD.VestiaireLSPD = false ClearPedTasks(PlayerPedId()) DeleteClothsCam() FinCreator() end
RMenu:Get('police_menu', 'police_menu_main').Closed = function()LSPD.MenuLSPD = false end
RMenu:Get('police_menu', 'police_amu_main').Closed = function()LSPD.AmmuLSPD = false end
RMenu:Get('police_menu', 'police_veh_main').Closed = function()LSPD.VehLSPD = false end
RMenu:Get('police_menu', 'police_vehselect_main').Closed = function()LSPD.VehSelectLSPD = false DeleteSpawnedVehicles() ESX.Game.Teleport(PlayerPedId(), restoreCoords) end
RMenu:Get('police_menu', 'police_plainte_main').Closed = function()LSPD.PlainteActif = false end
RMenu:Get('police_menu', 'police_plainte_gest').Closed = function()LSPD.GestPlainte = false end
RMenu:Get('police_menu', 'police_extra_main').Closed = function()LSPD.Extra = false end
RMenu:Get('police_menu', 'police_camera_main').Closed = function()LSPD.Camera = false CloseCameraCamera(false) end

local SetDown = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
}

function getPlayerInvLSPD(player)
    LSPD.playerItem = {}
    LSPD.playerBlackMoney = {}

    ESX.TriggerServerCallback('elderslife:GetPlyData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(LSPD.playerBlackMoney, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })

                break
            end
        end

        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(LSPD.playerItem, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player), true)
end

CopsLicenses = {
    PDC = {},
    MOTO = {},
    TRUCK = {},
    PPA = {},
    AIRPLANE = {},
}

function GetPlyLicenses(ply)
    ESX.TriggerServerCallback('EldersPolice:GetPlyLicenses', function(pdc)
        CopsLicenses.PDC = pdc
    end, "drive", ply)
    ESX.TriggerServerCallback('EldersPolice:GetPlyLicenses', function(moto)
        CopsLicenses.MOTO = moto
    end, "drive_bike", ply)
    ESX.TriggerServerCallback('EldersPolice:GetPlyLicenses', function(camion)
        CopsLicenses.TRUCK = camion
    end, "drive_truck", ply)
    ESX.TriggerServerCallback('EldersPolice:GetPlyLicenses', function(ppa)
        CopsLicenses.PPA = ppa
    end, "weapon", ply)
    ESX.TriggerServerCallback('EldersPolice:GetPlyLicenses', function(airplane)
        CopsLicenses.AIRPLANE = airplane
    end, "aircraft", ply)
end

function OpenLSPDClothes()
	if not LSPD.VestiaireLSPD then
		LSPD.VestiaireLSPD = true
		RageUI.Visible(RMenu:Get('police_menu', 'vestiaire_main'), true)
        Citizen.CreateThread(function()
            while LSPD.VestiaireLSPD do
                Citizen.Wait(1)
                for i=1,256 do
                    if NetworkIsPlayerActive(i) then
                        SetEntityVisible(GetPlayerPed(i), false, false)
                        SetEntityVisible(PlayerPedId(), true, true)
                        SetEntityNoCollisionEntity(GetPlayerPed(i), PlayerPedId(), false)
                    end
                end
                RageUI.IsVisible(RMenu:Get('police_menu', "vestiaire_main"), true, true, true, function()
                    if not LSPD.inServicePolice and LSPD.MyMatricule == "Aucun" then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Vous devez prendre votre service !")
                        RageUI.Separator("")
                    else
                           for index,infos in pairs(ConfigLspd.clothes.normal) do
                                RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
                                    if s then
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            local vest
                                            if skin.sex == 0 then
                                                vest = infos.variations.male
                                            else
                                                vest = infos.variations.female
                                            end
                                            TriggerEvent('skinchanger:loadClothes', skin,vest)
                                        end)
                                        ESX.ShowAdvancedNotification("Elders Life", "Information(s)", "Vous avez ??quiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end
                            RageUI.Separator("~o~Gestion G.P.B")
                            for index,infos in pairs(ConfigLspd.clothes.grades) do
                                RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
                                    if s then
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            local vest
                                            if skin.sex == 0 then

                                                vest = infos.variations.male
                                            else
                                                vest = infos.variations.female
                                            end
                                            SetPedArmour(PlayerPedId(), infos.value)
                                            TriggerEvent('skinchanger:loadClothes', skin,vest)
                                        end)
                                        ESX.ShowAdvancedNotification("Elders Life", "Information(s)", "Vous avez ??quiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end
                            RageUI.Separator("~o~Uniformes")
                            for index,infos in pairs(ConfigLspd.clothes.specials) do
                                RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
                                    if s then
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            local vest
                                            if skin.sex == 0 then
                                                vest = infos.variations.male
                                            else
                                                vest = infos.variations.female
                                            end
                                            TriggerEvent('skinchanger:loadClothes', skin,vest)
                                        end)
                                        ESX.ShowAdvancedNotification("Elders Life", "Information(s)", "Vous avez ??quiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end
                        RageUI.Separator("~o~Sp??cialisations")
                         for index,infos in pairs(ConfigLspd.clothes.specials2) do
                                    RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
                                        if s then
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                local vest
                                                if skin.sex == 0 then
                                                    vest = infos.variations.male
                                                else
                                                    vest = infos.variations.female
                                                end
                                                TriggerEvent('skinchanger:loadClothes', skin,vest)
                                            end)
                                            ESX.ShowAdvancedNotification("Elders Life", "Information(s)", "Vous avez ??quiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                        end
                                    end)
                                end                        
                    end
                end)
            end
        end)
    end
end

WeaponsLSPD = {
    ListAccsWeapon = {},
    Comp = {},
    Hash = {},
    IndexAccsWeapon = 1,
    Lock = false,
    ListArmes = {
        {hash = "WEAPON_PISTOL", label = "Pistolet de combat", compName = {
            {model = "Clip par d??faut", comp = "COMPONENT_PISTOL_CLIP_01"}, 
            {model = "Clip prolong??", comp = "COMPONENT_PISTOL_CLIP_02"}, 
            {model = "Lampe de poche", comp = "COMPONENT_AT_PI_FLSH"}, 
        }},
        {hash = "WEAPON_COMBATPISTOL", label = "Pistolet de combat", compName = {
            {model = "Clip par d??faut", comp = "COMPONENT_COMBATPISTOL_CLIP_01"}, 
            {model = "Clip prolong??", comp = "COMPONENT_COMBATPISTOL_CLIP_02"}, 
            {model = "Lampe de poche", comp = "COMPONENT_AT_PI_FLSH"}, 
            {model = "Silencieux", comp = "COMPONENT_AT_PI_SUPP"},  
        }},        
        {hash = "WEAPON_PUMPSHOTGUN", label = "Fusil ?? pompe", compName = {
            {model = "Lampe de poche", comp = "COMPONENT_AT_AR_FLSH"}, 
        }},
        {hash = "WEAPON_SMG", label = "SMG", compName = {
            {model = "Lampe de poche", comp = "COMPONENT_AT_AR_FLSH"}, 
            {model = "Clip par d??faut", comp = "COMPONENT_SMG_CLIP_01"}, 
            {model = "Clip prolong??", comp = "COMPONENT_SMG_CLIP_02"},
        }},
        {hash = "WEAPON_SPECIALCARBINE", label = "Fusil ?? carabine [G36]", compName = {
            {model = "Clip par d??faut", comp = "COMPONENT_SPECIALCARBINE_CLIP_01"}, 
            {model = "Clip prolong??", comp = "COMPONENT_SPECIALCARBINE_CLIP_02"}, 
            {model = "Lunette", comp = "COMPONENT_AT_SCOPE_MEDIUM"},  
            {model = "Silencieux", comp = "COMPONENT_AT_AR_SUPP_02"}, 
            {model = "Grip", comp = "COMPONENT_AT_AR_AFGRIP"}, 
        }},    
    }
}

function OpenAmmuLSPD()
    if not LSPD.AmmuLSPD then
        LSPD.AmmuLSPD = true
        RageUI.Visible(RMenu:Get('police_menu', 'police_amu_main'), true)
        Citizen.CreateThread(function()
            while LSPD.AmmuLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_amu_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("D??poser ses armes de services",nil, {RightLabel = "??????"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent("police:removealleweapon")
                        end
                    end)
                    RageUI.Separator("??? ~b~Liste des accessoires ~s~???")
                    for k,v in pairs(WeaponsLSPD.ListArmes) do
                        if GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                            WeaponsLSPD.ListAccsWeapon = {}
                            RageUI.Separator("Arme actuellement : ~b~"..v.label)
                            WeaponsLSPD.Lock = true
                            for _,i in pairs(v.compName) do
                                table.insert(WeaponsLSPD.ListAccsWeapon, i.model)
                            end
                        end
                        if not GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                            WeaponsLSPD.Lock = false
                        end
                    end
                    if not IsPedArmed(PlayerPedId(), 4) then
                        RageUI.Separator("~r~Vous portez actuellement aucune arme !")
                        WeaponsLSPD.Lock = false
                    else
                        if not WeaponsLSPD.Lock then
                            RageUI.Separator("~y~Cette arme ne peut pas ??tre modifier !")
                        end
                    end
                    RageUI.ButtonWithStyle("Accessoires d'arme par-d??faut", nil, {RightLabel = "??????" }, WeaponsLSPD.Lock, function(_,_,s)
                        if s then
                            for k,v in pairs(WeaponsLSPD.ListArmes) do
                                for _,i in pairs(v.compName) do
                                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), i.comp)
                                end
                            end
                        end
                    end)
                    RageUI.List("Accessoires d'arme", WeaponsLSPD.ListAccsWeapon, WeaponsLSPD.IndexAccsWeapon, nil, {}, WeaponsLSPD.Lock, function(_,_,s,Index)
                        WeaponsLSPD.IndexAccsWeapon = Index
                        if s then
                            for k,v in pairs(WeaponsLSPD.ListArmes) do
                                for active,i in pairs(v.compName) do
                                    if active == Index and GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                                        GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(v.hash), GetHashKey(i.comp))
                                        ESX.ShowAdvancedNotification("Elders Life", "Information(s)", "Vous avez ??quiper l'??quipement !", "CHAR_ELDERS", 1)
                                    end
                                end
                            end
                        end
                    end)
                    RageUI.Separator("??? ~b~Liste des armes ~s~???")
                    for k,v in pairs(ConfigLspd.armurerie) do
                        if ESX.PlayerData.job.grade >= v.minimum_grade then
                            RageUI.ButtonWithStyle(v.nom,nil, {RightLabel = "??????"}, not v.giveweapon, function(_,_,s)
                                if s then
                                    TriggerServerEvent("Elders_log:ArmurerieLSPD", webhook, "```"..tostring(GetPlayerName(PlayerId())).." ?? pris l'objet  -> "..v.nom.." dans l'amurerie ```")
                                    TriggerServerEvent("police:takeweapon", v.arme)
                                    v.giveweapon = true
                                    Citizen.SetTimeout(2000, function() v.giveweapon = false end)
                                end
                            end)
                        end
                    end
                end)
            end
        end)
    end
end

function OpenF6Police()
	if LSPD.MenuLSPD then
		LSPD.MenuLSPD = false
        StopMenuPolice()
    else
        LSPD.MenuLSPD = true
		RageUI.Visible(RMenu:Get('police_menu', 'police_menu_main'), true)
        Citizen.CreateThread(function()
            local onCopsBLips = 1
            while LSPD.MenuLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_menu_main'),true,true,true,function()
                    RageUI.Separator("??? ~b~Statut de service ~s~???")
                    RageUI.List("Status de service", {"Prendre", "Quitter"}, LSPD.Index, nil, {},true,  function(_,_,s,Index)
                    LSPD.Index = Index
                    if s then
                        if Index == 1 then
                            if LSPD.inServicePolice then
                                ESX.ShowAdvancedNotification("Central", 'Information(s)', "Vous ??tes d??j?? en service !", 'CHAR_CALL911', 1)
                            else
                                LSPD.MyMatricule = tonumber(KeyboardInput("Matricule", "Matricule", "", 5))
                                if LSPD.MyMatricule ~= nil and LSPD.MyMatricule < 100 then
                                    TriggerServerEvent('EldersPolice:AddCopsService', LSPD.MyMatricule)
                                    LSPD.inServicePolice = true
                                    LSPD.sServiceInfos = true
                                    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                    TriggerServerEvent('ambulance:setjobAmbulance', 'police')
                                    TriggerEvent('god:setJobdoor', 'police')
                                else
                                    ESX.ShowAdvancedNotification("Central", 'Information(s)', "Veuillez rentrer un matricule valide !", 'CHAR_CALL911', 1)
                                end
                            end
                            elseif Index == 2 then
                                TriggerServerEvent('EldersPolice:RemoveCopsService')
                                LSPD.inServicePolice = false
                                LSPD.sServiceInfos = false
                                LSPD.MyMatricule = "Aucun"
                                LSPDCopsActive = false
                                for k,v in pairs(CopsPlyBlips) do
                                    RemoveBlip(v)
                                end
                                PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
                                TriggerServerEvent('ambulance:setjobAmbulance', 'offpolice')
                                TriggerEvent('god:setJobdoor', 'offpolice')
                            end
                        end
                    end)

                    if LSPD.inServicePolice then
                    
                    if LSPD.sServiceInfos then
                        sService = "~g~En service"
                    else
                        sService = "~r~Hors-service"
                    end
                    RageUI.Separator("Status service : "..sService)
                    RageUI.Separator("Votre matricule est : [~b~"..LSPD.MyMatricule.."~s~]")
                    RageUI.Separator("??? ~y~Actions ~s~???")
                    RageUI.ButtonWithStyle("Annonce Personnalis??", nil, {RightLabel = "?????????"}, not cooldown,function(a,h,s)
                        if s then
                            local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                            if msg and msg ~= "" then
                                TriggerServerEvent('perso:police', msg)                            
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Annonce Personnalis?? Ill??gale", nil, {RightLabel = "?????????"}, not cooldown,function(a,h,s)
                        if s then
                            local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                            if msg and msg ~= "" then
                                TriggerServerEvent('perso2:police', msg)                            
                            end
                        end
                    end)
                    RageUI.Separator("??? ~y~Actions ~s~???")
                    --[[if ESX.PlayerData.job.grade >= 10 then
                        RageUI.List("Afficher les agent(s) en service", {"ON", "OFF"}, onCopsBLips, nil, {}, true, function(_,_,s,Index)
                            onCopsBLips = Index
                            if s then
                                if Index == 1 then
                                    LSPDCopsActive = true
                                    RageUI.Popup({
                                        message = "~b~LSPD~s~\n- Les agent(s) en service sont d??sormais affich??s sur votre GPS !",
                                    })
                                else
                                    LSPDCopsActive = false
                                    for k,v in pairs(CopsPlyBlips) do
                                        RemoveBlip(v)
                                    end
                                    RageUI.Popup({
                                        message = "~b~LSPD~s~\n- Les agent(s) en service ne sont plus affich??s sur votre GPS !",
                                    })
                                end
                            end
                        end)
                    end]]--
                    RageUI.Separator("??? ~o~Int??ractions ~s~???")

                    RageUI.ButtonWithStyle("Int??ractions citoyen", nil, { RightLabel = "??????" }, LSPD.sServiceInfos, function()
                    end, RMenu:Get('police_menu', 'police_inter'))

                    RageUI.ButtonWithStyle("Int??ractions v??hicule", nil, { RightLabel = "??????" }, LSPD.sServiceInfos, function()
                    end, RMenu:Get('police_menu', 'police_veh'))

                    RageUI.ButtonWithStyle("Int??ractions LSPD", nil, { RightLabel = "??????" },LSPD.sServiceInfos, function()
                    end, RMenu:Get('police_menu', 'police_codes'))
                    
                    RageUI.ButtonWithStyle("Int??ractions radar", nil, { RightLabel = "??????" },LSPD.sServiceInfos, function()
                    end, RMenu:Get('police_menu', 'police_radar_main'))

                    RageUI.ButtonWithStyle("Int??ractions object(s)", nil, { RightLabel = "??????" },LSPD.sServiceInfos, function()
                    end, RMenu:Get('police_menu', 'police_props'))

                    if ESX.PlayerData.job.grade >= 8 then
                        RageUI.ButtonWithStyle("Agent(s) en service", nil, { RightLabel = "??????" },LSPD.sServiceInfos, function(_,_,s)
                            if s then
                                LSPDInService = {}
                                ESX.TriggerServerCallback('EldersPolice:GetCopsInService', function(Service)
                                    LSPDInService = Service 
                                end)
                            end
                        end, RMenu:Get('police_menu', 'police_service'))
                    end
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_service'),true,true,true,function()
                for k,v in pairs(LSPDInService) do
                    RageUI.ButtonWithStyle("?????? Agent : "..v.Grade.." || Matricule : [~b~"..v.Matricule.."~s~]", "Prise de service ?? : "..v.Date , {}, true , function()
                    end)
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_radar_main'),true,true,true,function()
                RageUI.ButtonWithStyle("Mettre en place un radar", nil, { RightLabel = "??????" }, not RadarGood, function(_,_,s)
                    if s then
                        RadarLSPD(LSPD.MyMatricule)
                    end
                end)
                RageUI.ButtonWithStyle("Ranger le radar mise en place", nil, { RightLabel = "??????" }, RadarGood, function(_,a,s)
                    if a then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), RadarPos.x, RadarPos.y, RadarPos.z, true) < 10.0 then
                            DrawMarker(22, RadarPos.x, RadarPos.y, RadarPos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                        end
                    end
                    if s then
                        RadarLSPD()
                    end
                end)
                RageUI.ButtonWithStyle("Information(s) sur les radar(s) plac??(s)", nil, { RightLabel = "??????" }, true, function(_,_,s)
                    if s then
                        LSPD.RadarPlaced = {}
                        ESX.TriggerServerCallback("EldersPolice:GetRadarPlaced", function(placed)
                            LSPD.RadarPlaced = placed
                        end)
                    end
                end, RMenu:Get('police_menu', 'police_radar_infos'))
                RageUI.ButtonWithStyle("Liste des v??hicule(s) flasher", nil, { RightLabel = "??????" },  true, function(_,_,s)
                    if s then
                        LSPD.Radar = {}
                        ESX.TriggerServerCallback("EldersPolice:GetFlashList", function(radar)
                            LSPD.Radar = radar
                        end)
                    end
                end, RMenu:Get('police_menu', 'police_radar_gest'))
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_radar_infos'),true,true,true,function()
                RageUI.Separator("Nombre de radar(s) plac??(s) : [~b~"..#LSPD.RadarPlaced.."~s~]")
                local found = 0
                for k,v in pairs(LSPD.RadarPlaced) do
                    found = found + 1
                end
                if found > 0 then
                    LSPD.RadarPlaced = LSPD.RadarPlaced
                else
                    RageUI.Separator("")
                    RageUI.Separator("~b~Aucun radar n'a ??t?? plac?? !")
                    RageUI.Separator("")
                end
                for k,v in pairs(LSPD.RadarPlaced) do
                    RageUI.ButtonWithStyle("[~b~"..k.."~s~] || [~b~"..v.maxSpeed.. "~s~KM/H] - Radar || ~b~"..v.localisation, nil, { RightLabel = "??????" }, GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos.x, v.pos.y, v.pos.z, true) < 1.5, function(_,a,s)
                        if a then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos.x, v.pos.y, v.pos.z, true) < 10.0 then
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if s then
                                RadarPlacedSelec = v
                                kSelected = k
                            end
                        end                  
                    end, RMenu:Get("police_menu", "police_radar_infos_gest"))
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_radar_gest'),true,true,true,function()
                RageUI.Separator("Nombre de v??hicule(s) flasher : [~b~"..#LSPD.Radar.."~s~]")
                local found = 0
                for k,v in pairs(LSPD.Radar) do
                    found = found + 1
                end
                if found > 0 then
                    LSPD.Radar = LSPD.Radar
                else
                    RageUI.Separator("")
                    RageUI.Separator("~b~Aucun v??hicule n'a ??t?? flash?? !")
                    RageUI.Separator("")
                end
                for k,v in pairs(LSPD.Radar) do
                    RageUI.ButtonWithStyle("[~b~"..k.."~s~] - Radar || "..v.localisation, nil, { RightLabel = "??????" }, true, function(_,_,s)  
                        if s then
                            RadarSelected = v
                            kSelec = k
                        end                  
                    end, RMenu:Get("police_menu", "police_radar_selec"))
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_radar_infos_gest'),true,true,true,function()
                RageUI.Separator("Radar num??ro : N??~y~"..kSelected)
                RageUI.Separator("Placer par : Matricule - [~b~"..RadarPlacedSelec.matricule.."~s~]")
                RageUI.Separator("Limitation : ~b~"..RadarPlacedSelec.maxSpeed.."KM/H")
                RageUI.Separator("Localisation : ~b~"..RadarPlacedSelec.localisation)
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_radar_selec'),true,true,true,function()
                RageUI.Separator("Radar num??ro : N??~y~"..kSelec)
                RageUI.Separator("Model : ~b~"..RadarSelected.model)
                RageUI.Separator("Propri??taire : ~b~"..RadarSelected.proprio)
                RageUI.Separator("Plaque : ~b~"..RadarSelected.plaque)
                RageUI.Separator("Vitesse : ~b~"..RadarSelected.speed.."KM/H")
                RageUI.Separator("Localisation : ~b~"..RadarSelected.localisation)
                RageUI.Separator("Distance : ?? [~b~"..RadarSelected.distance.."~s~] - M??tre(s)")
                RageUI.Separator("Date : ~b~"..RadarSelected.date)
                RageUI.Separator("la personne a ??t?? factur?? : ~b~"..RadarSelected.price.."$")
                RageUI.ButtonWithStyle("Mettre la position sur le GPS", nil, { RightLabel = "??????" },  true, function(_,_,s)
                    if s then
                        SpeedBlips = AddBlipForCoord(RadarSelected.pos.x,RadarSelected.pos.y,RadarSelected.pos.z)
                        SetBlipSprite(SpeedBlips, 564)
                        SetBlipScale(SpeedBlips, 0.5)
                        SetBlipColour(SpeedBlips, 68)
                        SetBlipRoute(SpeedBlips,  true)
                        TriggerEvent("EldersPolice:radarRemoveBlips", true, SpeedBlips, {x = RadarSelected.pos.x, y = RadarSelected.pos.y, z = RadarSelected.pos.z})	
                        ESX.ShowAdvancedNotification("Central", "Information(s)", "La positon a bien ??t?? mise sur votre GPS !", "CHAR_CALL911", 1)
                    end
                end)
                RageUI.ButtonWithStyle("Supprim?? l'archive", nil, { RightLabel = "??????" },  true, function(_,_,s)
                    if s then
                        TriggerServerEvent("EldersPolice:RemoveFlashSpeed", kSelec)
                        LSPD.Radar = {}
                        ESX.TriggerServerCallback("EldersPolice:GetFlashList", function(radar)
                            LSPD.Radar = radar
                        end)
                        ESX.ShowAdvancedNotification("Central", "Information(s)", "Vous avez supprim?? l'archive !", "CHAR_CALL911", 1)
                        RageUI.GoBack()
                    end
                end)
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_props'),true,true,true,function()

                RageUI.ButtonWithStyle("Liste des object(s) plac??s", false , {RightLabel = "??????"}, true , function(_,_,s)
                    if s then
                        LSPDProps = {}
                        ESX.TriggerServerCallback('elderslife:getProps', function(props)
                            LSPDProps = props
                        end)
                    end
                end, RMenu:Get("police_menu", "police_props_gest"))

                for k,v in pairs(ConfigLspd.PropsName) do
                    RageUI.ButtonWithStyle(v.name, false , {RightLabel = "??????"}, not v.Cooldown_object , function(_,_,s)
                        if s then
                            SpawnObj(v.obj)
                            v.Cooldown_object = true
                            Citizen.SetTimeout((1000*3), function()
                                v.Cooldown_object = false
                            end)
                        end
                    end)
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_props_gest'),true,true,true,function()
                if #LSPDProps == 0 then
                    RageUI.Separator("")
                    RageUI.Separator("~r~Aucun objet(s) n'a ??t?? pos?? !")
                    RageUI.Separator("")
                else
                    for k,v in pairs(LSPDProps) do
                        RageUI.ButtonWithStyle("[~b~"..k.."~s~] - ".."Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))), nil, {RightLabel =  "~r~Ranger ~s~??????"}, GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(NetworkGetEntityFromNetworkId(v)), true) < 3.0, function(_, a, s)
                            if a then
                                local entity = NetworkGetEntityFromNetworkId(v)
                                local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(22, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if s then
                                RemoveObj(v, k)
                                TriggerServerEvent("elderslife:refreshProps", k)
                                LSPDProps = {} 
                                ESX.TriggerServerCallback('elderslife:getProps', function(props)
                                    LSPDProps = props 
                                end)
                            end
                        end)
                    end
                end
            end)

            RageUI.IsVisible(RMenu:Get("police_menu",'police_inter'),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        RageUI.ButtonWithStyle("Prendre la carte d'identit??", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                plyIdentity = nil
                                getInformations(closestPlayer)
                            end
                        end, RMenu:Get('police_menu', 'police_identity'))
                    else
                        RageUI.ButtonWithStyle("Prendre la carte d'identit??", nil, { RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                            end
                        end)
                    end

                    RageUI.List("Retirer un permis", {"Voiture", "Moto", "Camion", "PPA", "Aviation"}, removeIndex , nil, {}, true,  function(_,a,s,Index)
                        removeIndex = Index
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur(closestPlayer)
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                RageUI.Popup({
                                    message = "~r~Aucun(e) individu ?? proximit?? !",
                                })
                            else
                                if Index == 1 then
                                    RageUI.Popup({
                                    message = "LSPD\n- Vous avez ~r~retir??~s~ le permis : ~b~Voiture~s~ ?? la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive")
                                elseif Index == 2 then
                                    RageUI.Popup({
                                    message = "LSPD\n- Vous avez ~r~retir??~s~ le permis : ~b~Moto~s~ ?? la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive_bike")
                                elseif Index == 3 then
                                    RageUI.Popup({
                                    message = "LSPD\n- Vous avez ~r~retir??~s~ le permis : ~b~Camion~s~ ?? la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive_truck")
                                elseif Index == 4 then
                                    RageUI.Popup({
                                    message = "LSPD\n- Vous avez ~r~retir??~s~ le permis : ~b~PPA~s~ ?? la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "weapon")
                                else
                                    RageUI.Popup({
                                    message = "LSPD\n- Vous avez ~r~retir??~s~ le permis : ~b~Aviation~s~ ?? la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "aircraft")
                                end
                            end
                        end
                    end)
                    
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        RageUI.ButtonWithStyle("Fouiller la personne", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                --getPlayerInvLSPD(closestPlayer)
                                RageUI.CloseAll()
                                ExecuteCommand("me fouille l'individu")
                                ExecuteCommand('robpolice567842')
                            end
                        end)--, RMenu:Get('police_menu', 'police_fouille'))
                    else
                        RageUI.ButtonWithStyle("Fouiller la personne", nil, { RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                            end
                        end)
                    end

                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            RageUI.ButtonWithStyle("G??rer les amende(s) impay??s", nil, { RightLabel = "??????" }, true, function(h,a,s)
                                if a then
                                    MarquerJoueur(closestPlayer)
                                end
                                if s then
                                    BillsNoPay = {}
                                    ESX.TriggerServerCallback("EldersPolice:GetTargetBills", function(bills)
                                        BillsNoPay = bills
                                    end, GetPlayerServerId(closestPlayer))
                                end
                            end, RMenu:Get("police_menu", "police_bill_no"))
                        else
                            RageUI.ButtonWithStyle("G??rer les amende(s) impay??s", nil, { RightLabel = "??????" }, true, function(h,a,s)
                                if s then
                                    ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1) 
                                end
                            end)
                        end

                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            RageUI.ButtonWithStyle("G??rer les license(s)", nil, { RightLabel = "??????" }, true, function(h,a,s)
                                if a then
                                    MarquerJoueur(closestPlayer)
                                end
                                if s then
                                    GetPlyLicenses(GetPlayerServerId(closestPlayer))
                                end
                            end, RMenu:Get("police_menu", "police_licenses"))
                        else
                            RageUI.ButtonWithStyle("G??rer les license(s)", nil, { RightLabel = "??????" }, true, function(h,a,s)
                                if s then
                                    ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1) 
                                end
                            end)
                        end

                        RageUI.ButtonWithStyle("??mettre une amende", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                        end, RMenu:Get("police_menu", "police_fine"))

                        RageUI.ButtonWithStyle("Escorter la personne", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('god_handcuffs:drag', GetPlayerServerId(closestPlayer))
                                else
                                    ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                                end
                            end
                        end)    

                        RageUI.ButtonWithStyle("Mettre la personne dans le v??hicule", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    local target, distance = ESX.Game.GetClosestPlayer()
                                    TriggerServerEvent('god_handcuffs:putInVehicle', GetPlayerServerId(target))
                                else
                                    ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("Sortir la personne du v??hicule", nil, { RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    local target, distance = ESX.Game.GetClosestPlayer()
                                    TriggerServerEvent('god_handcuffs:OutVehicle', GetPlayerServerId(target))
                                else
                                    ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle('T.I.G.', nil, {RightLabel = "???"}, true, function(_, a, s)
                            local player, distance = ESX.Game.GetClosestPlayer()
                            if a then
                                MarquerJoueur()
                            end
                            if s then
                                if distance ~= -1 then
                                    if distance <= 3.0 then
                                        nombre = KeyboardInput("atmos", "Nombre de travail", "", 4)
                                        if nombre == nil then
                                            ESX.ShowNotification('Le nombre de services n\'est pas valide.')
                                        else
                                            TriggerServerEvent("god_communityservice:sendToCommunityService", GetPlayerServerId(player), tonumber(nombre))
                                        end
                                    else
                                        ESX.ShowNotification("~r~Probl??mes~s~: Aucun joueur ?? proximit??e")
                                    end
                                else
                                    ESX.ShowNotification("~r~Probl??mes~s~: Aucun joueur ?? proximit??e")
                                end
                            end
                        end)

                        if ESX.PlayerData.job.grade >= 8 then
                            RageUI.Separator("??? ~o~ Licences~s~ ???")
                            RageUI.ButtonWithStyle('Donner le PPA', nil, {RightLabel = "???"}, true, function(h,a,s)
                                if a then
                                    target = GetPlayerServerId(ESX.Game.GetClosestPlayer())
                                    MarquerJoueur()
                                end
                                if s then
                                    TriggerServerEvent('god_license:addLicense', target, 'weapon', function()
                                        TriggerServerEvent('god_license:getLicenses', target, function(licenses)
                                            TriggerEvent('god_dmvschool:loadLicenses', target, licenses)
                                        end)
                                    end)
                                    ESX.ShowNotification("~g~Licences~s~: PPA Donn?? au citoyen")
                                end
                            end)
                            RageUI.ButtonWithStyle('Donner la licence aviation', nil, {RightLabel = "???"}, true, function(h,a,s)
                                if a then
                                    target = GetPlayerServerId(ESX.Game.GetClosestPlayer())
                                    MarquerJoueur()
                                end
                                if s then
                                    TriggerServerEvent('god_license:addLicense', target, 'aircraft', function()
                                        TriggerServerEvent('god_license:getLicenses', target, function(licenses)
                                            TriggerEvent('god_dmvschool:loadLicenses', target, licenses)
                                        end)
                                    end)
                                    ESX.ShowNotification("~g~Licences~s~: Licence aviation donn?? au citoyen")
                                end
                            end)
                        end
                        RageUI.Separator("??? ~o~ Bracelets~s~ ???")
                        RageUI.ButtonWithStyle("Gestion de bracelets", 'Acc??dez aux bracelets', { RightLabel = "???" }, true, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                TriggerEvent('fl_policejob:manageBracelet')
                            end
                        end)
                        if ESX.PlayerData.job.grade >= 2 then
                            RageUI.ButtonWithStyle("Cr??er un bracelet", 'Acc??dez aux bracelets', { RightLabel = "???" }, true, function(_,_,s)
                                if s then
                                    RageUI.CloseAll()
                                    TriggerServerEvent('fl_policejob:createBracelet')
                                end
                            end)
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get("police_menu",'police_licenses'),true,true,true,function()
                        if CopsLicenses.PDC == true then
                            RageUI.ButtonWithStyle("Permis de conduire", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis de conduire ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if CopsLicenses.MOTO == true then
                            RageUI.ButtonWithStyle("Permis moto", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis moto", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if CopsLicenses.TRUCK == true then
                            RageUI.ButtonWithStyle("Permis poids lourd", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis poids lourd", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if CopsLicenses.PPA == true then
                            RageUI.ButtonWithStyle("Permis de port d'arme(s) ", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end)  
                        else
                            RageUI.ButtonWithStyle("Permis de port d'arme(s) ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)  
                        end
                        if CopsLicenses.AIRPLANE == true then
                            RageUI.ButtonWithStyle("Permis aviation ", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end)  
                        else
                            RageUI.ButtonWithStyle("Permis aviation ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)  
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get("police_menu",'police_bill_no'),true,true,true,function()
                        local found = 0
                        for k,v in pairs(BillsNoPay) do
                            found = found + 1
                        end
                        if found > 0 then
                            BillsNoPay = BillsNoPay
                            RageUI.Separator("??? ~y~Liste des amendes impay??es ~s~???")
                        else
                            RageUI.Separator("")
                            RageUI.Separator("~r~Aucune amende impay??e trouv??e !")
                            RageUI.Separator("")
                        end
                        for k,v in pairs(BillsNoPay) do
                            if v ~= nil then
                                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.amount.."$"}, true , function(h, a, s)
                                    if s then 
                                        local msg = KeyboardInput("atmos", "Supprimer la facture (OUI) :", "", 20)
                                        if msg and msg == 'OUI' then
                                            TriggerServerEvent('bill:delete', BillsNoPay[k].id)  
                                            RageUI.CloseAll()                         
                                        end
                                    end
                                end)
                            end
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get("police_menu",'police_fouille'),true,true,true,function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
                        RageUI.Separator("??? Argent(s) sale ???")
                        for k,v  in pairs(LSPD.playerBlackMoney) do
                            RageUI.ButtonWithStyle("[~r~"..v.label.."~s~$] - ".."Argent sale :", nil, {RightLabel = "??????"}, true, function(_, a, s)
                                if s then
                                    local combien = KeyboardInput("atmos", "Quantit?? :", "", 30)
                                    if combien == nil then 
                                        ESX.ShowNotification("~r~Probl??me~s~ : Case vide !")
                                    else
                                        if tonumber(combien) > v.amount then
                                            ESX.ShowAdvancedNotification("Central","Information(s)","Quantit?? invalide.", "CHAR_CALL911", 1)
                                        else
                                            TriggerServerEvent('elderslife:ConfiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                        end
                                    end
                                    RageUI.GoBack()
                                end
                            end)
                        end
                        RageUI.Separator("??? Objet(s) ???")
                        for k,v  in pairs(LSPD.playerItem) do
                            RageUI.ButtonWithStyle("[~b~"..v.right.."~s~] - "..v.label, nil, {RightLabel =  "??????"}, true, function(_, a, s)
                                if s then
                                    local combien = KeyboardInput("atmos", "Quantit?? :", "", 30)
                                    if combien == nil then 
                                        ESX.ShowNotification("~r~Probl??me~s~ : Case vide !")
                                    else
                                        if tonumber(combien) > v.amount then
                                            ESX.ShowAdvancedNotification("Central","Information(s)","Quantit?? invalide.", "CHAR_CALL911", 1)
                                        else
                                            TriggerServerEvent('elderslife:ConfiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                        end
                                    end
                                    RageUI.GoBack()
                                end
                            end)
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("police_menu",'police_identity'),true,true,true,function()
                        if plyIdentity then
                            RageUI.ButtonWithStyle("Nom : ", nil, {RightLabel = plyIdentity.firstname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Pr??nom : ", nil, {RightLabel = plyIdentity.lastname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Date de naissance : ", nil, {RightLabel = plyIdentity.dob}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Taille : ", nil, {RightLabel = plyIdentity.height}, true, function(h, a, s)
                            end)
                            if plyIdentity.sex == 'm' then
                                RageUI.ButtonWithStyle("Genre : ", nil, {RightLabel = "Homme"}, true, function(h, a, s)
                                end) 
                            else
                                if plyIdentity.sex == 'f' then
                                    RageUI.ButtonWithStyle("Genre : ", nil, {RightLabel = "Femme"}, true, function(h, a, s)
                                    end)
                                end
                            end
                            --RageUI.ButtonWithStyle("Emploi : ", nil, {RightLabel = plyIdentity.job.." | "..plyIdentity.grade}, true, function(h, a, s)
                            --end)
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("police_menu",'police_codes'),true,true,true,function()

                        RageUI.ButtonWithStyle("Prendre une pause de service", false , {RightLabel = "??????"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "pause", LSPD.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)
                        
                        RageUI.ButtonWithStyle("Standby - en attente de dispatch", false , {RightLabel = "??????"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "standby", LSPD.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Contr??le routier en cours", false , {RightLabel = "??????"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "control", LSPD.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.ButtonWithStyle("Refus d'obtemp??rer || D??lit de fuite", false , {RightLabel = "??????"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "refus", LSPD.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.ButtonWithStyle("Crime - en cours || Poursuite en cours", false , {RightLabel = "??????"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "crime", LSPD.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.Separator("??? ~b~Demande de renfort ~s~???")
                        
                        RageUI.ButtonWithStyle("Petite demande de renforts", false , {RightLabel = "??????"}, not SetDown[1], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "petit")
                                SetDown[1] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[1] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Grande demande de renforts", false , {RightLabel = "??????"}, not SetDown[2] , function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "grande")
                                SetDown[2] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[2] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Demande de toutes les unit??s", false , {RightLabel = "??????"}, not SetDown[3] , function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('EldersPolice:CallNotifLSPD', coords, "allcops")
                                SetDown[3] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[3] = false
                                end)
                            end
                        end)
                        RageUI.Separator("??? ~b~Autres type de demande ~s~???")
                        RageUI.ButtonWithStyle("Demande de renfort urgente ?? la [~b~EMS~s~]", nil, {RightLabel = "??????"}, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre demande d'unit??(s) a ??t?? envoy?? avec succ??s !", "CHAR_CALL911", 1)
                                PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
                                TriggerServerEvent("EldersPolice:HelpNotifsRenfort", "ambulance", GetEntityCoords(PlayerPedId()), "LSPD")
                            end
                        end)
                        RageUI.ButtonWithStyle("Demande de renfort urgente ?? la [~b~BCSO~s~]", nil, {RightLabel = "??????"}, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre demande d'unit??(s) a ??t?? envoy?? avec succ??s !", "CHAR_CALL911", 1)
                                PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
                                TriggerServerEvent("EldersPolice:HelpNotifsRenfort", "sheriff", GetEntityCoords(PlayerPedId()), "LSPD")
                            end
                        end)

                        RageUI.Separator("??? ~b~Zone d'arret ~s~???")
                            RageUI.ButtonWithStyle('Mettre zone de s??curit??', nil, {RightLabel = "???"}, true, function(h,a,s)
                                if s then
                                    TriggerEvent('elders_police:promptSpeedzone', numerozone)
                                    RageUI.CloseAll()
                                end
                            end)
                        RageUI.List("Zone de s??curit??", arraysecu, arrayIndexSecu, nil, {}, true, function(h, a, s, i) arrayIndexSecu = i
                                if s then
                                    if arrayIndexSecu == 1 then
                                        TriggerEvent('elders_police:toggleSpeedzoneDraw', true)
                                    elseif arrayIndexSecu == 2 then
                                        TriggerEvent('elders_police:toggleSpeedzoneDraw', false)
                                    end
                                end
                            end)

       
                    end)
                    RageUI.IsVisible(RMenu:Get("police_menu",'police_veh'),true,true,true,function()
                    RageUI.ButtonWithStyle("Information(s) sur le v??hicule", nil, { RightLabel = "??????" }, true, function(h,a,s)
                        local getVeh = ESX.Game.GetVehicleProperties(ESX.Game.GetVehicleInDirection())
                        if a then
                            VehiculeMarker()
                        end
                        if s then
                            LSPD.VehiculeInfos = nil
                            ESX.TriggerServerCallback('EldersPolice:getVehiculehInfos', function(Infos)
                                LSPD.VehiculeInfos = Infos
                            end, getVeh.plate, GetDisplayNameFromVehicleModel(getVeh.model))
                            waitingForPlaque = true
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                LoadAnimDict("amb@code_human_police_investigate@idle_a")
                                TaskPlayAnim(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0) 
                                TriggerServerEvent("EldersPolice:SendSoundPlaque")
                                TriggerServerEvent("Elders_log:FouilleVehicleLSPD", webhook, "```"..tostring(GetPlayerName(PlayerId())).." ?? fait une recherche de plaque sur le v??hicule -> "..getVeh.plate.."```")
                            end
                        end
                    end,RMenu:Get('police_menu', 'police_veh_infos'))
    
                    --[[RageUI.ButtonWithStyle("Mettre le v??hicule en fourri??re", nil, {RightLabel = "??????"},true, function(h, a, s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                local getVeh = ESX.Game.GetVehicleProperties(ESX.Game.GetVehicleInDirection())
                                if getVeh ~= nil then
                                    TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                    ShowLoadingMessage("Mise en fourri??re du v??hicule...", 1, 6500)
                                    Wait(6500)
                                    DeleteEntity(ESX.Game.GetClosestVehicle())
                                    ClearPedTasks(PlayerPedId())
                                    TriggerServerEvent('eden_garage:ChangeStateFrompoundJob', getVeh.plate, true)
                                    TriggerServerEvent("Elders_log:fourriereVehicleLSPD", webhook, "```"..tostring(GetPlayerName(PlayerId())).." ?? mis le v??hicule -> "..getVeh.plate.." en fourri??re ```")
                                    ESX.ShowAdvancedNotification("Central", "Information(s)", "Le v??hicule ?? ??t?? mis en fourri??re !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Aucun v??hicule ?? proximit?? !", "CHAR_CALL911", 1)
                            end
                        end
                    end)]]--

                    RageUI.ButtonWithStyle("Crocheter le v??hicule", nil, { RightLabel = "??????" }, true, function(h,a,s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Vous ne pouvez pas crocheter ?? l'int??rieur d'un v??hicule !", "CHAR_CALL911", 1)
                                return
                            end
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                if GetVehicleDoorLockStatus(ESX.Game.GetVehicleInDirection()) ~= 3 then
                                    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                    ShowLoadingMessage("Crochetage du v??hicule...", 1, 10000)
                                    Citizen.Wait(10000)
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleDoorsLocked(ESX.Game.GetVehicleInDirection(), 0)
                                    SetVehicleDoorsLockedForAllPlayers(ESX.Game.GetVehicleInDirection(), false)
                                    ClearPedTasksImmediately(PlayerPedId())
                                    ESX.ShowAdvancedNotification("Central", "Information(s)", "Le v??hicule a ??t?? crocheter !", "CHAR_CALL911", 1)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le v??hicule a un sabot !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Aucun v??hicule ?? proximit?? !", "CHAR_CALL911", 1)
                            end
                        end
                    end)

                    --[[RageUI.ButtonWithStyle("Poser un sabot au v??hicule", nil, { RightLabel = "??????" }, true, function(h,a,s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous ne pouvez pas poser un sabot ?? l'int??rieur d'un v??hicule !", "CHAR_CALL911", 1)
                                return
                            end
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                if GetVehicleDoorLockStatus(ESX.Game.GetVehicleInDirection()) ~= 3 then
                                    ExecuteCommand('e mechanic3')
                                    Citizen.Wait(10000)
                                    ClearPedTasks(PlayerPedId())
                                    SetVehicleDoorsLockedForAllPlayers(ESX.Game.GetVehicleInDirection(), true)
                                    Citizen.Wait(1000)
                                    SetVehicleDoorsLocked(ESX.Game.GetVehicleInDirection(), 3)
                                    coords = GetEntityCoords(PlayerPedId(), false);
                                    RequestModel(GetHashKey("prop_alarm_01"))
                                    Object = CreateObject(GetHashKey("prop_alarm_01"), coords.X, coords.Y, coords.Z, true, true, true)
                                    boneIndex = GetEntityBoneIndexByName(ESX.Game.GetVehicleInDirection(), "wheel_lf")
                                    SetEntityHeading(Object, 0.0)
                                    SetEntityRotation(Object, 60.0, 20.0, 10.0, 1, true)
                                    AttachEntityToEntity(Object, ESX.Game.GetVehicleInDirection(), boneIndex, -0.15, 0.00, 0.00, 180.0, 200.0, 90.0, true, true, false, false, 2, true)
                                    SetEntityRotation(Object, 60.0, 20.0, 10.0, 1, true)
                                    SetEntityAsMissionEntity(Object, true, true)
                                    FreezeEntityPosition(Object, true)
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous avez pos?? un sabot sur le v??hicule jusqu'?? la temp??te!", "CHAR_CALL911", 1)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le v??hicule poss??de d??j?? un sabot !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Aucun v??hicule ?? proximit?? !", "CHAR_CALL911", 1)
                            end
                        end
                    end)]]--
                end)

                RageUI.IsVisible(RMenu:Get("police_menu",'police_veh_infos'),true,true,true,function()
                    if LSPD.VehiculeInfos then
                        if LSPD.VehiculeInfos.plate == nil then
                            RageUI.Separator("")
                            RageUI.Separator("~r~Aucun v??hicule ?? proximit?? !")
                            RageUI.Separator("")
                        else
                            if waitingForPlaque then
                                TriggerEvent("EldersPolice:waitingForPlaque")                               
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "~b~Analyse~s~ en cours...\nR??cup??ration des donn??es, veuillez patentiez !", "CHAR_CALL911", 1)
                                RageUI.Separator("")
                                RageUI.Separator("~b~V??rification des informations...")
                                RageUI.Separator("")
                            end
                            local owner = ""
                            if not LSPD.VehiculeInfos.owner then owner = "Inconnu" else owner = LSPD.VehiculeInfos.owner end
                            if not waitingForPlaque then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Information(s)~s~ re??us.\n~b~Propri??taire : ~s~"..owner.."\n~b~Model : ~s~"..LSPD.VehiculeInfos.model.."\n~b~Plaque : ~s~"..LSPD.VehiculeInfos.plate, "CHAR_CALL911", 1)
                                RageUI.Separator("~b~Propri??taire du v??hicule : ~s~"..owner)
                                RageUI.Separator("~b~Model du v??hicule : ~s~"..LSPD.VehiculeInfos.model)
                                RageUI.Separator("~b~Plaque d'imatriculation : ~s~"..LSPD.VehiculeInfos.plate)
                            end
                        end
                    end
                end)

                RageUI.IsVisible(RMenu:Get("police_menu",'police_fine'),true,true,true,function()
                    RageUI.ButtonWithStyle("Amende personalis??", false , {RightLabel = "??????"}, true , function(_,_,s)
                        if s then
                            local player, distance = ESX.Game.GetClosestPlayer()
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Raison de l'amende")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de l'amende :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de l'amende")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de l'amende:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            if player ~= -1 and distance <= 3.0 then
                                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(player), 'society_police', raison, montant)                                                
                                                TriggerServerEvent("EldersPolice:sSendLogs", tostring(GetPlayerName(PlayerId())).." ?? envoy?? une amende de **"..montant.."$** pour la raison : "..raison, 22)
                                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Vous avez envoy?? une amende de : ~b~"..montant.. " $ ~s~pour : ~b~" ..raison, "CHAR_CALL911", 1)
                                            else
                                                ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    RageUI.List("Cat??gorie : ", {{ Name = "Circulation", Value = 1 },{Name = "Petites Contraventions", Value = 2 },{Name = "Moyennes Contraventions", Value = 3 },{Name = "Grandes Contraventions", Value = 4 },}, LSPD.IndexFine, nil, {}, true, function(_,a,s,Index)
                        LSPD.IndexFine = Index
                        if s then
                            LSPD.FineLister = {}
                            ESX.TriggerServerCallback('EldersPolice:getFineList', function(fines)
                                for k,fine in ipairs(fines) do
                                    table.insert(LSPD.FineLister, {label = fine.label, amount = ESX.Math.GroupDigits(fine.amount)})
                                end
                            end, LSPD.IndexFine - 1)                           
                        end
                    end)
                    for k,v in pairs(LSPD.FineLister) do
                        RageUI.ButtonWithStyle(v.label, false , {RightLabel = "~b~"..v.amount.."$"}, true , function(_,_,s)
                            if s then
                                Label = v.label
                                Amount = v.amount
                            end
                        end, RMenu:Get("police_menu", "police_fine_gest"))
                    end
                end)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_fine_gest'),true,true,true,function()
                    RageUI.Separator("Montant : [~b~"..Amount.."$~s~] | "..Label.."")
                    RageUI.ButtonWithStyle("Donner l'amende", false , {RightLabel = "??????"}, true , function(_,a,s)
                        if s then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', Label, Amount)
                                TriggerServerEvent("EldersPolice:sSendLogs", tostring(GetPlayerName(PlayerId())).." ?? envoy?? une amende de **"..Amount.."$** pour la raison : "..Label, 22)
                                ESX.ShowAdvancedNotification("Central","Information(s)","Vous avez envoy?? une amende ?? la personne", "CHAR_CALL911", 1)
                            else
                                ESX.ShowAdvancedNotification("Central","Information(s)","Aucun individu(s) ?? proximit??e.", "CHAR_CALL911", 1)
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

function OpenLSPDExtra()
	if not LSPD.Extra then
		LSPD.Extra = true
		RageUI.Visible(RMenu:Get('police_menu', 'police_extra_main'), true)
        Citizen.CreateThread(function()
            while LSPD.Extra do
                Citizen.Wait(1)

                RageUI.IsVisible(RMenu:Get("police_menu",'police_extra_main'),true,true,true,function()
                    RageUI.List("Type", {"Extra", "Livery"}, LSPD.IndexCustom, nil, {}, true, function(_,_,s,Index)
                        LSPD.IndexCustom = Index
                    end)
                    if LSPD.IndexCustom == 1 then
                        local elements = {}
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        for id=0, 12 do
                            if DoesExtraExist(vehicle, id) then
                                local state = IsVehicleExtraTurnedOn(vehicle, id) 
                                if state then
                                    table.insert(elements, {
                                        label = "Suppl??mentaire : N??"..id..""..('<span style="color:green;">%s</span>'):format(""),
                                        value = id,
                                        state = not state,
                                        status = "ON"
                                    })
                                else
                                    table.insert(elements, {
                                        label = "Suppl??mentaire : N??"..id..""..('<span style="color:red;">%s</span>'):format(""),
                                        value = id,
                                        state = not state,
                                        status = "OFF"
                                    })
                                end
                            end
                        end
                        local found = 0
                        for k,v in pairs(elements) do
                            found = found + 1
                        end
                        if found > 0 then
                            elements = elements
                        else
                            RageUI.Separator("")
                            RageUI.Separator("~r~Ce v??hicule ne comporte")
                            RageUI.Separator("~r~pas de suppl??ment(s) !")
                            RageUI.Separator("")
                        end
                        for k,v in pairs(elements) do
                            RageUI.ButtonWithStyle(v.label, nil,{RightLabel = v.status}, true, function(_,_,s)
                                if s then
                                    SetVehicleExtra(vehicle, v.value, not v.state)
                                    local newData = v
                                    if v.state then
                                        newData.label = "Suppl??mentaire : N??"..v.value..""..('<span style="color:green;">%s</span>'):format("")
                                    else
                                        newData.label = "Suppl??mentaire : N??"..v.value..""..('<span style="color:red;">%s</span>'):format("")
                                    end
                                    newData.state = not v.state
                                end
                            end)
                        end
                    elseif LSPD.IndexCustom == 2 then
                        local livery = {}
                        local vehicle = GetVehiclePedIsIn(PlayerPedId())
                        local liveryCount = GetVehicleLiveryCount(vehicle)
                        for i = 1, liveryCount do
                        local state = GetVehicleLivery(vehicle) 
                        local text
                            if state == i then
                                text = "Mod??le : N??"..i..""..('<span style="color:green;">%s</span>'):format("")
                            else
                                text = "Mod??le : N??"..i..""..('<span style="color:red;">%s</span>'):format("")
                            end
                            table.insert(livery, {
                                label = text,
                                value = i,
                                state = not state
                            }) 
                            end
                        local found = 0
                        for k,v in pairs(livery) do
                            found = found + 1
                        end
                        if found > 0 then
                            livery = livery
                        else
                            RageUI.Separator("")
                            RageUI.Separator("~r~Ce v??hicule ne comporte pas de mod??le(s) !")
                            RageUI.Separator("")
                        end
                        for k,v in pairs(livery) do
                            RageUI.ButtonWithStyle(v.label, nil,{RightLabel = "??????"}, true, function(_,_,s)
                                if s then
                                    SetVehicleLivery(vehicle, v.value, not v.state)
                                    local newData = v
                                    if v.state then
                                        newData.label = "Livery: "..v.value.." | "..('<span style="color:green;">%s</span>'):format("")
                                    else
                                        newData.label = "Livery: "..v.value.." | "..('<span style="color:red;">%s</span>'):format("")
                                    end
                                    newData.state = not v.state
                                end
                            end)
                        end
                    end
                end)
            end
        end)
    end
end

function OpenGestPlainteMenu()
    PlainteActif = {}
    ESX.TriggerServerCallback('EldersPolice:GetPlainte', function(plainte)
        PlainteActif = plainte 
    end)
    if not LSPD.GestPlainte then
		LSPD.GestPlainte = true
		RageUI.Visible(RMenu:Get('police_menu', 'police_plainte_gest'), true)
        Citizen.CreateThread(function()
            while LSPD.GestPlainte do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_plainte_gest'),true,true,true,function()
                local found = 0
                    for k,v in pairs(PlainteActif) do
                        found = found + 1
                    end
                    if found > 0 then
                        PlainteActif = PlainteActif
                        RageUI.Separator("??? ~b~Gestion des plainte(s) ~s~???")
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucune plainte d??pos??e !")
                        RageUI.Separator("")
                    end
                    for k,v in pairs(PlainteActif) do
                        RageUI.ButtonWithStyle("[~b~"..k.."~s~] - "..v.name.. " || "..v.date, nil, {RightLabel = "??????"}, true, function(_,_,s)
                            if s then
                                selectPlainte = v
                                selecK = k
                            end
                        end, RMenu:Get("police_menu", "police_plainte_gest_main"))
                    end
                end)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_plainte_gest_main'),true,true,true,function()
                    RageUI.Separator("Pr??nom/Nom : ~b~"..selectPlainte.name)
                    RageUI.Separator("Date de naissance : ~b~"..selectPlainte.dtn)
                    RageUI.Separator("Num??ro de t??l??phone : ~b~"..selectPlainte.numero)
                    RageUI.Separator("??ffectu?? ?? : ~b~"..selectPlainte.date)
                    RageUI.ButtonWithStyle("Description : ", selectPlainte.text, {}, true, function() end)
                    RageUI.ButtonWithStyle("Supprim?? la plainte", nil, {RightLabel = "??????"}, true, function(_,_,s)
                        if s then
                            ESX.ShowAdvancedNotification("Central", "Information(s)", "Vous avez supprim?? la plainte de la base de donn??es !", "CHAR_CALL911", 1)
                            TriggerServerEvent("EldersPolice:RemovePlainte", selecK)
                            PlainteActif = {}
                            ESX.TriggerServerCallback('EldersPolice:GetPlainte', function(plainte)
                                PlainteActif = plainte 
                            end)
                            RageUI.GoBack()
                        end
                    end)
                end)
            end
        end)
    end
end

function OpenPlainteMenu()
    if not LSPD.PlainteActif then
		LSPD.PlainteActif = true
		RageUI.Visible(RMenu:Get('police_menu', 'police_plainte_main'), true)
        Citizen.CreateThread(function()
            while LSPD.PlainteActif do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_plainte_main'),true,true,true,function()

                    RageUI.Separator("??? ~b~D??pot de plainte ~s~???")
                    RageUI.ButtonWithStyle("Nom", nil, {RightLabel = nom or "??????"}, true, function(_,_,s)
                        if s then
                            nom = KeyboardInput("atmos", "Nom", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Pr??nom", nil, {RightLabel = prenom or "??????"}, true, function(_,_,s)
                        if s then
                            prenom = KeyboardInput("atmos", "Pr??nom", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Date de naissance", nil, {RightLabel = dtn or "??????"}, true, function(_,_,s)
                        if s then
                            dtn = KeyboardInput("atmos", "Date de naissance", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Num??ro de t??l??phone", nil, {RightLabel = tel or "??????"}, true, function(_,_,s)
                        if s then
                            tel = KeyboardInput("atmos", "Num??ro de t??l??phone", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Description", nil, {RightLabel = text or "??????"}, true, function(_,_,s)
                        if s then
                            text = KeyboardInput("atmos", "D??scription", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Transmettre la plainte", nil, {RightLabel = "??????"}, true, function(_,_,s)
                        if s then
                            if text == "" or text == nil or nom == "" or nom == nil or prenom == "" or prenom == nil or dtn == "" or  dtn == nil or tel == "" or tel == nil then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Veuillez rentrer une plainte valide ! ", "CHAR_CALL911", 1)
                            else
                                local InsterData = {
                                    text = text,
                                    name = nom.." - "..prenom,
                                    dtn = dtn,
                                    tel = tel,
                                }
                                TriggerServerEvent("Elders_log:PlainteMenu", webhook, "```"..nom.." - "..prenom.." vient de faire un d??pot de plainte pour la raison : **"..text.."** - T??l??phone **"..tel.."```")
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre plainte a ??t?? transmise au Nom de :\nNom : ~b~"..nom.."~s~\nPr??nom : ~b~"..prenom, "CHAR_CALL911", 1)
                                TriggerServerEvent("EldersPolice:AddPlainte", InsterData)
                                LSPD.PlainteActif = false
                                RageUI.CloseAll()
                                text,name,nom,prenom,dtn,tel = nil,nil,nil,nil,nil,nil
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

function OpenVehicleSpawnerMenuLSPD(station)
    local playerCoords = GetEntityCoords(PlayerPedId())
    PlayerData = ESX.GetPlayerData()
    if ESX.PlayerData.job.grade < 18 then 
        ESX.ShowNotification("~r~Probl??me~s~ : Vous n'avez pas le grade requis")
    else
        if not LSPD.VehLSPD then
            LSPD.VehLSPD = true
            RageUI.Visible(RMenu:Get('police_menu', 'police_veh_main'), true)
            Citizen.CreateThread(function()
                while LSPD.VehLSPD do
                    Citizen.Wait(1)
                    RageUI.IsVisible(RMenu:Get("police_menu",'police_veh_main'),true,true,true,function()
                        RageUI.Separator("??? ~b~Types de v??hicules ~s~???")
                        RageUI.ButtonWithStyle("V??hicules", nil, {RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                local shopElements, shopCoords = {}
                                shopCoords = ConfigLspd.points.InsideShop
                                if #ConfigLspd.AuthorizedVehicles['Shared'] > 0 then
                                    for k,vehicle in ipairs(ConfigLspd.AuthorizedVehicles['Shared']) do
                                        table.insert(shopElements, {
                                            label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, ESX.Math.GroupDigits(vehicle.price)),
                                            name  = vehicle.label,
                                            model = vehicle.model,
                                            price = vehicle.price,
                                            typeveh  = 'car'
                                        })
                                    end
                                end
                                OpenShopMenu(shopElements, playerCoords, shopCoords)
                            end
                        end)
                        RageUI.ButtonWithStyle("H??licopt??re", nil, {RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                local shopElements, shopCoords = {}
                                shopCoords = ConfigLspd.points.InsideShop
                                local authorizedHelicopters = ConfigLspd.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]
                                if authorizedHelicopters == nil then authorizedHelicopters = {} end
                                if #authorizedHelicopters > 0 then
                                    for k,vehicle in ipairs(authorizedHelicopters) do
                                        table.insert(shopElements, {
                                            label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, ESX.Math.GroupDigits(vehicle.price)),
                                            name  = vehicle.label,
                                            model = vehicle.model,
                                            price = vehicle.price,
                                            livery = vehicle.livery or nil,
                                            typeveh  = 'airplane'
                                        })
                                    end
                                    OpenShopMenu(shopElements, playerCoords, shopCoords)
                                else
                                    ESX.ShowNotification("Vous n'avez pas l'autorisation d'acheter des h??licopt??re")
                                end
                            end
                        end)
                    end)
                end
            end)
        end
    end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
    restoreCoords = restoreCoords
    local playerPed = PlayerPedId()
    if not LSPD.VehSelectLSPD then
        LSPD.VehSelectLSPD = true
        thismodel = nil
        RageUI.Visible(RMenu:Get('police_menu', 'police_vehselect_main'), true)
        Citizen.CreateThread(function()
            WaitForVehicleToLoad(elements[1].model)
            SetEntityCoords(PlayerPedId() , shopCoords)
            ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
                table.insert(spawnedVehicles, vehicle)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                FreezeEntityPosition(vehicle, true)

                if elements[1].livery then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleLivery(vehicle,elements[1].livery)
                end
            end)
            while LSPD.VehSelectLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_vehselect_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "??????" }, true, function(h,a,s)
                            if a then
                                if v.model ~= thismodel then
                                    DeleteSpawnedVehicles()
                                    WaitForVehicleToLoad(v.model)
                                    SetEntityCoords(PlayerPedId() , shopCoords)
                                    ESX.Game.SpawnLocalVehicle(v.model, shopCoords, 0.0, function(vehicle)
                                        table.insert(spawnedVehicles, vehicle)
                                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                        FreezeEntityPosition(vehicle, true)
                                        if v.livery then
                                            SetVehicleModKit(vehicle, 0)
                                            SetVehicleLivery(vehicle, v.livery)
                                        end
                                    end)
                                    thismodel = v.model
                                end
                            end
                            if s then
                                local newPlate = exports['elders_life']:GeneratePlate()
                                local vehicle  = GetVehiclePedIsIn(playerPed, false)
                                local props    = ESX.Game.GetVehicleProperties(vehicle)
                                props.plate    = newPlate

                                ESX.TriggerServerCallback('god_policejob:buyJobVehicle', function (bought)
                                    if bought then
                                        ESX.ShowNotification('Vehicule transf??r?? au garage')

                                        RageUI.CloseAll()
                                        LSPD.VehSelectLSPD = false
                                        DeleteSpawnedVehicles()
                                        FreezeEntityPosition(playerPed, false)
                                        SetEntityVisible(playerPed, true)

                                        ESX.Game.Teleport(playerPed, restoreCoords)
                                    else
                                        ESX.ShowNotification('Vous avez pas argent')
                                    end
                                end, props, v.typeveh)
                            end
                        end)
                    end
                end)
            end
        end)
    end



end

function DeleteSpawnedVehicles()
    while #spawnedVehicles > 0 do
        local vehicle = spawnedVehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(spawnedVehicles, 1)
    end
end

function WaitForVehicleToLoad(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
            DisableAllControlActions(0)

            drawLoadingText('Chargement du model...', 255, 255, 255, 255)
        end
    end
end

function drawLoadingText(text, red, green, blue, alpha)
    SetTextFont(4)
    SetTextScale(0.0, 0.5)
    SetTextColour(red, green, blue, alpha)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.5)
end

function StopMenuPolice()
    RageUI.Visible(RMenu:Get('police_menu', 'police_menu_main'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_inter'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_codes'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_fouille'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_identity'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_veh'), false)
    RageUI.Visible(RMenu:Get('police_menu', 'police_veh_infos'), false)
end

RegisterCommand('OpenF6Police', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'offpolice' then
        if isDead then 
            return 
        else
            OpenF6Police()
        end
    end
end)

RegisterKeyMapping('OpenF6Police', "Menu Int??raction | LSPD", 'keyboard', 'F6')
end)

Citizen.CreateThread(function()
    while true do
        interval = 750
        plyCoords = GetEntityCoords(PlayerPedId(), false)

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "offpolice" then
            local pos = ConfigLspd.points.vestiaire
            if #(plyCoords - pos) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenLSPDClothes()
                    end
                end
            end
            local pos1 = ConfigLspd.points.vestiaire1
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.vestiaire1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenLSPDClothes()
                    end
                end
            end
            local pos1 = ConfigLspd.points.vestiaire2
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.vestiaire2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenLSPDClothes()
                    end
                end
            end
            local pos1 = ConfigLspd.points.armurerie
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.armurerie, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der ?? l'armurerie")
                    if IsControlJustPressed(1,51) then
                        OpenAmmuLSPD()
                    end
                end
            end
            local pos1 = ConfigLspd.points.extra
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.extra, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au extra")
                    if IsControlJustPressed(1,51) then
                        OpenLSPDExtra()
                    end
                end
            end
            local pos1 = ConfigLspd.points.LirePlainte
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.LirePlainte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au gestion des plaintes")
                    if IsControlJustPressed(1,51) then
                        OpenGestPlainteMenu()
                    end
                end
            end
            local pos1 = ConfigLspd.points.AchatVehicle
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.AchatVehicle, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter des v??hicules")
                    if IsControlJustPressed(1,51) then
                        OpenVehicleSpawnerMenuLSPD('LSPD')
                    end
                end
            end

        end

        local pos1 = ConfigLspd.points.DepotPlainte
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.DepotPlainte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au d??poser plainte")
                    if IsControlJustPressed(1,51) then
                        OpenPlainteMenu()
                    end
                end
            end
        local pos1 = ConfigLspd.points.AppelLSPD
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigLspd.points.AppelLSPD, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour appeler le LSPD")
                    if IsControlJustPressed(1,51) then
                        ServiceLSPD()
                    end
                end
            end
        Citizen.Wait(interval)
    end
end)

function ServiceLSPD()
    local servpopo = RageUI.CreateMenu("Accueil LSPD", "Que puis-je faire pour vous ?")
    servpopo:SetRectangleBanner(0,0,0,255)
    RageUI.Visible(servpopo, not RageUI.Visible(servpopo))
    while servpopo do
        Citizen.Wait(0)
            RageUI.IsVisible(servpopo, true, true, true, function()

            RageUI.ButtonWithStyle("Appeler un agent de LSPD ", nil, {RightLabel = "???"},true, function(Hovered, Active, Selected)
                if (Selected) then  
                TriggerServerEvent("genius2:sendcallLSPD")
                RageUI.Popup({message = "<C>~b~Votre appel ?? bien ??t?? pris en compte"})
                end
            end)

            
    end, function()
    end)
    
        if not RageUI.Visible(servpopo) then
            servpopo = RMenu:DeleteType("servpopo", true)
        end
    end
end