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

RegisterNetEvent("Elderssheriff:waitingForPlaque")
AddEventHandler("Elderssheriff:waitingForPlaque", function()
    Citizen.Wait(8000)
    waitingForPlaque = false
    ClearPedTasks(PlayerPedId())
end)

local spawnedVehicles = {}

local restoreCoords = vector3(-624.75,-102.55,33.89)

BCSO = {
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
    inServicesheriff = false,
    MenuBCSO = false,
    sServiceInfos = false,
    GarageBCSO = false,
    Extra = false,
    GestPlainte = false,
    Helico = false,
    GarageShop = false,
    PlainteActif = false,
    VestiaireBCSO = false,
    Camera = false,
    Saisie = false,
    AmmuBCSO = false,
    VehBCSO = false,
    VehSelectBCSO = false,
    BraceletBCSO = false,
    BraceletputBCSO = false,
    BraceletgestBCSO = false,
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

RMenu.Add('sheriff_menu', 'sheriff_menu_main', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_inter', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_veh', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_veh_infos', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_veh'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_fouille', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_inter'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_identity', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_inter'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_codes', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_service', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_bill_no', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_inter'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_fine', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_inter'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_fine_gest', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_fine'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_props', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_licenses', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_props_gest', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_props'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_radar_main', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_radar_gest', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_radar_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_radar_selec', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_radar_gest'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_radar_infos', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_radar_main'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_zone_infos', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_codes'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_radar_infos_gest', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_radar_infos'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'vestiaire_main', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_amu_main', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_veh_main', RageUI.CreateMenu("LSSD", "VEHICULES", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_vehselect_main', RageUI.CreateMenu("LSSD", "VEHICULES", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_plainte_main', RageUI.CreateMenu("PLAINTE", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_plainte_gest', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_plainte_gest_main', RageUI.CreateSubMenu(RMenu:Get('sheriff_menu', 'sheriff_plainte_gest'), "LSSD", "INTÉRACTIONS"))
RMenu.Add('sheriff_menu', 'sheriff_extra_main', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu.Add('sheriff_menu', 'sheriff_camera_main', RageUI.CreateMenu("LSSD", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu:Get('sheriff_menu', 'vestiaire_main').Closed = function()BCSO.VestiaireBCSO = false ClearPedTasks(PlayerPedId()) DeleteClothsCam() FinCreator() end
RMenu:Get('sheriff_menu', 'sheriff_menu_main').Closed = function()BCSO.MenuBCSO = false end
RMenu:Get('sheriff_menu', 'sheriff_amu_main').Closed = function()BCSO.AmmuBCSO = false end
RMenu:Get('sheriff_menu', 'sheriff_veh_main').Closed = function()BCSO.VehBCSO = false end
RMenu:Get('sheriff_menu', 'sheriff_vehselect_main').Closed = function()BCSO.VehSelectBCSO = false DeleteSpawnedVehicles() ESX.Game.Teleport(PlayerPedId(), restoreCoords) end
RMenu:Get('sheriff_menu', 'sheriff_plainte_main').Closed = function()BCSO.PlainteActif = false end
RMenu:Get('sheriff_menu', 'sheriff_plainte_gest').Closed = function()BCSO.GestPlainte = false end
RMenu:Get('sheriff_menu', 'sheriff_extra_main').Closed = function()BCSO.Extra = false end
RMenu:Get('sheriff_menu', 'sheriff_camera_main').Closed = function()BCSO.Camera = false CloseCameraCamera(false) end

local SetDown = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
}

function getPlayerInvBCSO(player)
    BCSO.playerItem = {}
    BCSO.playerBlackMoney = {}

    ESX.TriggerServerCallback('elderslife:GetPlyData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(BCSO.playerBlackMoney, {
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
                table.insert(BCSO.playerItem, {
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

BcsoLicenses = {
    PDC = {},
    MOTO = {},
    TRUCK = {},
    PPA = {},
    AIRPLANE = {},
}

function GetPlyLicensesbcso(ply)
    ESX.TriggerServerCallback('Elderssheriff:GetPlyLicenses', function(pdc)
        BcsoLicenses.PDC = pdc
    end, "drive", ply)
    ESX.TriggerServerCallback('Elderssheriff:GetPlyLicenses', function(moto)
        BcsoLicenses.MOTO = moto
    end, "drive_bike", ply)
    ESX.TriggerServerCallback('Elderssheriff:GetPlyLicenses', function(camion)
        BcsoLicenses.TRUCK = camion
    end, "drive_truck", ply)
    ESX.TriggerServerCallback('Elderssheriff:GetPlyLicenses', function(ppa)
        BcsoLicenses.PPA = ppa
    end, "weapon", ply)
    ESX.TriggerServerCallback('Elderssheriff:GetPlyLicenses', function(airplane)
        BcsoLicenses.AIRPLANE = airplane
    end, "aircraft", ply)
end

function OpenBCSOClothes()
	if not BCSO.VestiaireBCSO then
		BCSO.VestiaireBCSO = true
		RageUI.Visible(RMenu:Get('sheriff_menu', 'vestiaire_main'), true)
        Citizen.CreateThread(function()
            while BCSO.VestiaireBCSO do
                Citizen.Wait(1)
                for i=1,256 do
                    if NetworkIsPlayerActive(i) then
                        SetEntityVisible(GetPlayerPed(i), false, false)
                        SetEntityVisible(PlayerPedId(), true, true)
                        SetEntityNoCollisionEntity(GetPlayerPed(i), PlayerPedId(), false)
                    end
                end
                RageUI.IsVisible(RMenu:Get('sheriff_menu', "vestiaire_main"), true, true, true, function()
                    if not BCSO.inServicesheriff and BCSO.MyMatricule == "Aucun" then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Vous devez prendre votre service !")
                        RageUI.Separator("")
                    else
                           for index,infos in pairs(ConfigBCSO.clothes.normal) do
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
                                        ESX.ShowAdvancedNotification("Elders Life", "~b~Information(s)", "Vous avez équiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end
                            RageUI.Separator("~o~Gestion G.P.B")
                            for index,infos in pairs(ConfigBCSO.clothes.grades) do
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
                                        ESX.ShowAdvancedNotification("Elders Life", "~b~Information(s)", "Vous avez équiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end
                            RageUI.Separator("~o~Uniformes")
                            for index,infos in pairs(ConfigBCSO.clothes.specials) do
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
                                        ESX.ShowAdvancedNotification("Elders Life", "~b~Information(s)", "Vous avez équiper la tenue : ~b~"..infos.label, "CHAR_ELDERS", 1) 
                                    end
                                end)
                            end                      
                    end
                end)
            end
        end)
    end
end

WeaponsBCSO = {
    ListAccsWeapon = {},
    Comp = {},
    Hash = {},
    IndexAccsWeapon = 1,
    Lock = false,
    ListArmes = {
        {hash = "WEAPON_PISTOL", label = "Pistolet de combat", compName = {
            {model = "Clip par défaut", comp = "COMPONENT_PISTOL_CLIP_01"}, 
            {model = "Clip prolongé", comp = "COMPONENT_PISTOL_CLIP_02"}, 
            {model = "Lampe de poche", comp = "COMPONENT_AT_PI_FLSH"}, 
        }},
        {hash = "WEAPON_COMBATPISTOL", label = "Pistolet de combat", compName = {
            {model = "Clip par défaut", comp = "COMPONENT_COMBATPISTOL_CLIP_01"}, 
            {model = "Clip prolongé", comp = "COMPONENT_COMBATPISTOL_CLIP_02"}, 
            {model = "Lampe de poche", comp = "COMPONENT_AT_PI_FLSH"}, 
            {model = "Silencieux", comp = "COMPONENT_AT_PI_SUPP"},  
        }},        
        {hash = "WEAPON_PUMPSHOTGUN", label = "Fusil à pompe", compName = {
            {model = "Lampe de poche", comp = "COMPONENT_AT_AR_FLSH"}, 
        }},
        {hash = "WEAPON_SMG", label = "SMG", compName = {
            {model = "Lampe de poche", comp = "COMPONENT_AT_AR_FLSH"}, 
            {model = "Clip par défaut", comp = "COMPONENT_SMG_CLIP_01"}, 
            {model = "Clip prolongé", comp = "COMPONENT_SMG_CLIP_02"},
        }},
        {hash = "WEAPON_SPECIALCARBINE", label = "Fusil à carabine [G36]", compName = {
            {model = "Clip par défaut", comp = "COMPONENT_SPECIALCARBINE_CLIP_01"}, 
            {model = "Clip prolongé", comp = "COMPONENT_SPECIALCARBINE_CLIP_02"}, 
            {model = "Lunette", comp = "COMPONENT_AT_SCOPE_MEDIUM"},  
            {model = "Silencieux", comp = "COMPONENT_AT_AR_SUPP_02"}, 
            {model = "Grip", comp = "COMPONENT_AT_AR_AFGRIP"}, 
        }},    
    }
}

function OpenAmmuBCSO()
    if not BCSO.AmmuBCSO then
        BCSO.AmmuBCSO = true
        RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_amu_main'), true)
        Citizen.CreateThread(function()
            while BCSO.AmmuBCSO do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_amu_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Déposer ses armes de services",nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent("sheriff:removealleweapon")
                        end
                    end)
                    RageUI.Separator("↓ ~b~Liste des accessoires ~s~↓")
                    for k,v in pairs(WeaponsBCSO.ListArmes) do
                        if GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                            WeaponsBCSO.ListAccsWeapon = {}
                            RageUI.Separator("Arme actuellement : ~b~"..v.label)
                            WeaponsBCSO.Lock = true
                            for _,i in pairs(v.compName) do
                                table.insert(WeaponsBCSO.ListAccsWeapon, i.model)
                            end
                        end
                        if not GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                            WeaponsBCSO.Lock = false
                        end
                    end
                    if not IsPedArmed(PlayerPedId(), 4) then
                        RageUI.Separator("~r~Vous portez actuellement aucune arme !")
                        WeaponsBCSO.Lock = false
                    else
                        if not WeaponsBCSO.Lock then
                            RageUI.Separator("~y~Cette arme ne peut pas être modifier !")
                        end
                    end
                    RageUI.ButtonWithStyle("Accessoires d'arme par-défaut", nil, {RightLabel = "→→" }, WeaponsBCSO.Lock, function(_,_,s)
                        if s then
                            for k,v in pairs(WeaponsBCSO.ListArmes) do
                                for _,i in pairs(v.compName) do
                                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), i.comp)
                                end
                            end
                        end
                    end)
                    RageUI.List("Accessoires d'arme", WeaponsBCSO.ListAccsWeapon, WeaponsBCSO.IndexAccsWeapon, nil, {}, WeaponsBCSO.Lock, function(_,_,s,Index)
                        WeaponsBCSO.IndexAccsWeapon = Index
                        if s then
                            for k,v in pairs(WeaponsBCSO.ListArmes) do
                                for active,i in pairs(v.compName) do
                                    if active == Index and GetHashKey(v.hash) == GetSelectedPedWeapon(PlayerPedId()) then
                                        GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(v.hash), GetHashKey(i.comp))
                                        ESX.ShowAdvancedNotification("Elders Life", "~b~Information(s)", "Vous avez équiper l'équipement !", "CHAR_ELDERS", 1)
                                    end
                                end
                            end
                        end
                    end)
                    RageUI.Separator("↓ ~b~Liste des armes ~s~↓")
                    for k,v in pairs(ConfigBCSO.armurerie) do                        
                        if ESX.PlayerData.job.grade >= v.minimum_grade then
                            RageUI.ButtonWithStyle(v.nom,nil, {RightLabel = "→→"}, not v.giveweapon, function(_,_,s)
                                if s then
                                    TriggerServerEvent("Elders_log:ArmurerieBCSO", webhook, "```"..tostring(GetPlayerName(PlayerId())).." à pris l'objet  -> "..v.nom.." dans l'amurerie ```")
                                    TriggerServerEvent("sheriff:takeweapon", v.arme)
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

function OpenF6sheriff()
	if BCSO.MenuBCSO then
		BCSO.MenuBCSO = false
        StopMenuBCSO()
    else
        BCSO.MenuBCSO = true
		RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), true)
        Citizen.CreateThread(function()
            local onCopsBLips = 1
            while BCSO.MenuBCSO do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_menu_main'),true,true,true,function()
                    RageUI.Separator("↓ ~b~Statut de service ~s~↓")
                    RageUI.List("Status de service", {"Prendre", "Quitter"}, BCSO.Index, nil, {},true,  function(_,_,s,Index)
                    BCSO.Index = Index
                    if s then
                        if Index == 1 then
                            if BCSO.inServicesheriff then
                                ESX.ShowAdvancedNotification("Central", '~b~Information(s)', "Vous êtes déjà en service !", 'CHAR_CALL911', 1)
                            else
                                BCSO.MyMatricule = tonumber(KeyboardInput("Matricule", "Matricule", "", 5))
                                if BCSO.MyMatricule ~= nil and BCSO.MyMatricule > 199 and BCSO.MyMatricule < 400 then
                                    TriggerServerEvent('Elderssheriff:AddCopsService', BCSO.MyMatricule)
                                    BCSO.inServicesheriff = true
                                    BCSO.sServiceInfos = true
                                    PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                    TriggerServerEvent('ambulance:setjobAmbulance', 'sheriff')
                                    TriggerEvent('god:setJobdoor', 'sheriff')
                                else
                                    ESX.ShowAdvancedNotification("Central", '~b~Information(s)', "Veuillez rentrer un matricule valide !", 'CHAR_CALL911', 1)
                                end
                            end
                            elseif Index == 2 then
                                TriggerServerEvent('Elderssheriff:RemoveCopsService')
                                BCSO.inServicesheriff = false
                                BCSO.sServiceInfos = false
                                BCSO.MyMatricule = "Aucun"
                                BCSOCopsActive = false
                                for k,v in pairs(CopsPlyBlips) do
                                    RemoveBlip(v)
                                end
                                PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
                                TriggerServerEvent('ambulance:setjobAmbulance', 'offsheriff')
                                TriggerEvent('god:setJobdoor', 'offsheriff')
                            end
                        end
                    end)

                    if BCSO.inServicesheriff then
                    
                    if BCSO.sServiceInfos then
                        sService = "~g~En service"
                    else
                        sService = "~r~Hors-service"
                    end
                    RageUI.Separator("Status service : "..sService)
                    RageUI.Separator("Votre matricule est : [~b~"..BCSO.MyMatricule.."~s~]")
                    RageUI.Separator("↓ ~y~Actions ~s~↓")
                    RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                        if s then
                            local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                            if msg and msg ~= "" then
                                TriggerServerEvent('perso:sheriff', msg)                            
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Annonce Personnalisé Illégale", nil, {RightLabel = "→→→"}, not cooldown,function(a,h,s)
                        if s then
                            local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                            if msg and msg ~= "" then
                                TriggerServerEvent('perso2:sheriff', msg)                            
                            end
                        end
                    end)
                    RageUI.Separator("↓ ~y~Actions ~s~↓")
                    --[[if ESX.PlayerData.job.grade >= 10 then
                        RageUI.List("Afficher les agent(s) en service", {"ON", "OFF"}, onCopsBLips, nil, {}, true, function(_,_,s,Index)
                            onCopsBLips = Index
                            if s then
                                if Index == 1 then
                                    BCSOCopsActive = true
                                    RageUI.Popup({
                                        message = "~b~BCSO~s~\n- Les agent(s) en service sont désormais affichés sur votre GPS !",
                                    })
                                else
                                    BCSOCopsActive = false
                                    for k,v in pairs(CopsPlyBlips) do
                                        RemoveBlip(v)
                                    end
                                    RageUI.Popup({
                                        message = "~b~BCSO~s~\n- Les agent(s) en service ne sont plus affichés sur votre GPS !",
                                    })
                                end
                            end
                        end)
                    end]]--
                    RageUI.Separator("↓ ~o~Intéractions ~s~↓")

                    RageUI.ButtonWithStyle("Intéractions citoyen", nil, { RightLabel = "→→" }, BCSO.sServiceInfos, function()
                    end, RMenu:Get('sheriff_menu', 'sheriff_inter'))

                    RageUI.ButtonWithStyle("Intéractions véhicule", nil, { RightLabel = "→→" }, BCSO.sServiceInfos, function()
                    end, RMenu:Get('sheriff_menu', 'sheriff_veh'))

                    RageUI.ButtonWithStyle("Intéractions BCSO", nil, { RightLabel = "→→" },BCSO.sServiceInfos, function()
                    end, RMenu:Get('sheriff_menu', 'sheriff_codes'))
                    
                    RageUI.ButtonWithStyle("Intéractions radar", nil, { RightLabel = "→→" },BCSO.sServiceInfos, function()
                    end, RMenu:Get('sheriff_menu', 'sheriff_radar_main'))

                    RageUI.ButtonWithStyle("Intéractions object(s)", nil, { RightLabel = "→→" },BCSO.sServiceInfos, function()
                    end, RMenu:Get('sheriff_menu', 'sheriff_props'))

                    if ESX.PlayerData.job.grade >= 6 then
                        RageUI.ButtonWithStyle("Agent(s) en service", nil, { RightLabel = "→→" },BCSO.sServiceInfos, function(_,_,s)
                            if s then
                                BCSOInService = {}
                                ESX.TriggerServerCallback('Elderssheriff:GetCopsInService', function(Service)
                                    BCSOInService = Service 
                                end)
                            end
                        end, RMenu:Get('sheriff_menu', 'sheriff_service'))
                    end
                end
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_service'),true,true,true,function()
                for k,v in pairs(BCSOInService) do
                    RageUI.ButtonWithStyle("→→ Agent : "..v.Grade.." || Matricule : [~b~"..v.Matricule.."~s~]", "Prise de service à : "..v.Date , {}, true , function()
                    end)
                end
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_radar_main'),true,true,true,function()
                RageUI.ButtonWithStyle("Mettre en place un radar", nil, { RightLabel = "→→" }, not RadarGood, function(_,_,s)
                    if s then
                        RadarBCSO(BCSO.MyMatricule)
                    end
                end)
                RageUI.ButtonWithStyle("Ranger le radar mise en place", nil, { RightLabel = "→→" }, RadarGood, function(_,a,s)
                    if a then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), RadarPos.x, RadarPos.y, RadarPos.z, true) < 10.0 then
                            DrawMarker(22, RadarPos.x, RadarPos.y, RadarPos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                        end
                    end
                    if s then
                        RadarBCSO()
                    end
                end)
                RageUI.ButtonWithStyle("Information(s) sur les radar(s) placé(s)", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    if s then
                        BCSO.RadarPlaced = {}
                        ESX.TriggerServerCallback("Elderssheriff:GetRadarPlaced", function(placed)
                            BCSO.RadarPlaced = placed
                        end)
                    end
                end, RMenu:Get('sheriff_menu', 'sheriff_radar_infos'))
                RageUI.ButtonWithStyle("Liste des véhicule(s) flasher", nil, { RightLabel = "→→" },  true, function(_,_,s)
                    if s then
                        BCSO.Radar = {}
                        ESX.TriggerServerCallback("Elderssheriff:GetFlashList", function(radar)
                            BCSO.Radar = radar
                        end)
                    end
                end, RMenu:Get('sheriff_menu', 'sheriff_radar_gest'))
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_radar_infos'),true,true,true,function()
                RageUI.Separator("Nombre de radar(s) placé(s) : [~b~"..#BCSO.RadarPlaced.."~s~]")
                local found = 0
                for k,v in pairs(BCSO.RadarPlaced) do
                    found = found + 1
                end
                if found > 0 then
                    BCSO.RadarPlaced = BCSO.RadarPlaced
                else
                    RageUI.Separator("")
                    RageUI.Separator("~b~Aucun radar n'a été placé !")
                    RageUI.Separator("")
                end
                for k,v in pairs(BCSO.RadarPlaced) do
                    RageUI.ButtonWithStyle("[~b~"..k.."~s~] || [~b~"..v.maxSpeed.. "~s~KM/H] - Radar || ~b~"..v.localisation, nil, { RightLabel = "→→" }, GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos.x, v.pos.y, v.pos.z, true) < 1.5, function(_,a,s)
                        if a then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos.x, v.pos.y, v.pos.z, true) < 10.0 then
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if s then
                                RadarPlacedSelec = v
                                kSelected = k
                            end
                        end                  
                    end, RMenu:Get("sheriff_menu", "sheriff_radar_infos_gest"))
                end
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_radar_gest'),true,true,true,function()
                RageUI.Separator("Nombre de véhicule(s) flasher : [~b~"..#BCSO.Radar.."~s~]")
                local found = 0
                for k,v in pairs(BCSO.Radar) do
                    found = found + 1
                end
                if found > 0 then
                    BCSO.Radar = BCSO.Radar
                else
                    RageUI.Separator("")
                    RageUI.Separator("~b~Aucun véhicule n'a été flashé !")
                    RageUI.Separator("")
                end
                for k,v in pairs(BCSO.Radar) do
                    RageUI.ButtonWithStyle("[~b~"..k.."~s~] - Radar || "..v.localisation, nil, { RightLabel = "→→" }, true, function(_,_,s)  
                        if s then
                            RadarSelected = v
                            kSelec = k
                        end                  
                    end, RMenu:Get("sheriff_menu", "sheriff_radar_selec"))
                end
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_radar_infos_gest'),true,true,true,function()
                RageUI.Separator("Radar numéro : N°~y~"..kSelected)
                RageUI.Separator("Placer par : Matricule - [~b~"..RadarPlacedSelec.matricule.."~s~]")
                RageUI.Separator("Limitation : ~b~"..RadarPlacedSelec.maxSpeed.."KM/H")
                RageUI.Separator("Localisation : ~b~"..RadarPlacedSelec.localisation)
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_radar_selec'),true,true,true,function()
                RageUI.Separator("Radar numéro : N°~y~"..kSelec)
                RageUI.Separator("Model : ~b~"..RadarSelected.model)
                RageUI.Separator("Propriétaire : ~b~"..RadarSelected.proprio)
                RageUI.Separator("Plaque : ~b~"..RadarSelected.plaque)
                RageUI.Separator("Vitesse : ~b~"..RadarSelected.speed.."KM/H")
                RageUI.Separator("Localisation : ~b~"..RadarSelected.localisation)
                RageUI.Separator("Distance : à [~b~"..RadarSelected.distance.."~s~] - Mètre(s)")
                RageUI.Separator("Date : ~b~"..RadarSelected.date)
                RageUI.Separator("la personne a été facturé : ~b~"..RadarSelected.price.."$")
                RageUI.ButtonWithStyle("Mettre la position sur le GPS", nil, { RightLabel = "→→" },  true, function(_,_,s)
                    if s then
                        SpeedBlips = AddBlipForCoord(RadarSelected.pos.x,RadarSelected.pos.y,RadarSelected.pos.z)
                        SetBlipSprite(SpeedBlips, 564)
                        SetBlipScale(SpeedBlips, 0.5)
                        SetBlipColour(SpeedBlips, 68)
                        SetBlipRoute(SpeedBlips,  true)
                        TriggerEvent("Elderssheriff:radarRemoveBlips", true, SpeedBlips, {x = RadarSelected.pos.x, y = RadarSelected.pos.y, z = RadarSelected.pos.z})	
                        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "La positon a bien été mise sur votre GPS !", "CHAR_CALL911", 1)
                    end
                end)
                RageUI.ButtonWithStyle("Supprimé l'archive", nil, { RightLabel = "→→" },  true, function(_,_,s)
                    if s then
                        TriggerServerEvent("Elderssheriff:RemoveFlashSpeed", kSelec)
                        BCSO.Radar = {}
                        ESX.TriggerServerCallback("Elderssheriff:GetFlashList", function(radar)
                            BCSO.Radar = radar
                        end)
                        ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous avez supprimé l'archive !", "CHAR_CALL911", 1)
                        RageUI.GoBack()
                    end
                end)
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_props'),true,true,true,function()

                RageUI.ButtonWithStyle("Liste des object(s) placés", false , {RightLabel = "→→"}, true , function(_,_,s)
                    if s then
                        BCSOProps = {}
                        ESX.TriggerServerCallback('elderslife:getProps', function(props)
                            BCSOProps = props
                        end)
                    end
                end, RMenu:Get("sheriff_menu", "sheriff_props_gest"))

                for k,v in pairs(ConfigBCSO.PropsName) do
                    RageUI.ButtonWithStyle(v.name, false , {RightLabel = "→→"}, not v.Cooldown_object , function(_,_,s)
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

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_props_gest'),true,true,true,function()
                if #BCSOProps == 0 then
                    RageUI.Separator("")
                    RageUI.Separator("~r~Aucun objet(s) n'a été posé !")
                    RageUI.Separator("")
                else
                    for k,v in pairs(BCSOProps) do
                        RageUI.ButtonWithStyle("[~b~"..k.."~s~] - ".."Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))), nil, {RightLabel =  "~r~Ranger ~s~→→"}, GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(NetworkGetEntityFromNetworkId(v)), true) < 3.0, function(_, a, s)
                            if a then
                                local entity = NetworkGetEntityFromNetworkId(v)
                                local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(22, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if s then
                                RemoveObj(v, k)
                                TriggerServerEvent("elderslife:refreshProps", k)
                                BCSOProps = {} 
                                ESX.TriggerServerCallback('elderslife:getProps', function(props)
                                    BCSOProps = props 
                                end)
                            end
                        end)
                    end
                end
            end)

            RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_inter'),true,true,true,function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        RageUI.ButtonWithStyle("Prendre la carte d'identité", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                plyIdentity = nil
                                getInformations(closestPlayer)
                            end
                        end, RMenu:Get('sheriff_menu', 'sheriff_identity'))
                    else
                        RageUI.ButtonWithStyle("Prendre la carte d'identité", nil, { RightLabel = "→→" }, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                            end
                        end)
                    end

                    RageUI.List("Retiré un permis", {"Voiture", "Moto", "Camion", "PPA", "Aviation"}, removeIndex , nil, {}, true,  function(_,a,s,Index)
                        removeIndex = Index
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur(closestPlayer)
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                RageUI.Popup({
                                    message = "~r~Aucun(e) individu à proximité !",
                                })
                            else
                                if Index == 1 then
                                    RageUI.Popup({
                                    message = "BCSO\n- Vous avez ~r~retiré~s~ le permis : ~b~Voiture~s~ à la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive")
                                elseif Index == 2 then
                                    RageUI.Popup({
                                    message = "BCSO\n- Vous avez ~r~retiré~s~ le permis : ~b~Moto~s~ à la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive_bike")
                                elseif Index == 3 then
                                    RageUI.Popup({
                                    message = "BCSO\n- Vous avez ~r~retiré~s~ le permis : ~b~Camion~s~ à la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "drive_truck")
                                elseif Index == 4 then
                                    RageUI.Popup({
                                    message = "BCSO\n- Vous avez ~r~retiré~s~ le permis : ~b~PPA~s~ à la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "weapon")
                                else
                                    RageUI.Popup({
                                    message = "BCSO\n- Vous avez ~r~retiré~s~ le permis : ~b~Aviation~s~ à la personne !",
                                    })
                                    TriggerServerEvent("god_license:removeLicense", GetPlayerServerId(closestPlayer), "aircraft")
                                end
                            end
                        end
                    end)
                    
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        RageUI.ButtonWithStyle("Fouiller la personne", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                --getPlayerInvBCSO(closestPlayer)
                                RageUI.CloseAll()
                                ExecuteCommand("me fouille l'individu")
                                ExecuteCommand('robpolice567842')
                            end
                        end)--, RMenu:Get('sheriff_menu', 'sheriff_fouille'))
                    else
                        RageUI.ButtonWithStyle("Fouiller la personne", nil, { RightLabel = "→→" }, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                            end
                        end)
                    end

                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            RageUI.ButtonWithStyle("Gérer les amende(s) impayés", nil, { RightLabel = "→→" }, true, function(h,a,s)
                                if a then
                                    MarquerJoueur(closestPlayer)
                                end
                                if s then
                                    BillsNoPay = {}
                                    ESX.TriggerServerCallback("Elderssheriff:GetTargetBills", function(bills)
                                        BillsNoPay = bills
                                    end, GetPlayerServerId(closestPlayer))
                                end
                            end, RMenu:Get("sheriff_menu", "sheriff_bill_no"))
                        else
                            RageUI.ButtonWithStyle("Gérer les amende(s) impayés", nil, { RightLabel = "→→" }, true, function(h,a,s)
                                if s then
                                    ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1) 
                                end
                            end)
                        end

                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            RageUI.ButtonWithStyle("Gérer les license(s)", nil, { RightLabel = "→→" }, true, function(h,a,s)
                                if a then
                                    MarquerJoueur(closestPlayer)
                                end
                                if s then
                                    GetPlyLicensesbcso(GetPlayerServerId(closestPlayer))
                                end
                            end, RMenu:Get("sheriff_menu", "sheriff_licenses"))
                        else
                            RageUI.ButtonWithStyle("Gérer les license(s)", nil, { RightLabel = "→→" }, true, function(h,a,s)
                                if s then
                                    ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1) 
                                end
                            end)
                        end

                        RageUI.ButtonWithStyle("Émettre une amende", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                        end, RMenu:Get("sheriff_menu", "sheriff_fine"))

                        RageUI.ButtonWithStyle("Escorter la personne", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('god_handcuffs:drag', GetPlayerServerId(closestPlayer))
                                else
                                    ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                                end
                            end
                        end)    

                        RageUI.ButtonWithStyle("Mettre la personne dans le véhicule", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    local target, distance = ESX.Game.GetClosestPlayer()
                                    TriggerServerEvent('god_handcuffs:putInVehicle', GetPlayerServerId(target))
                                else
                                    ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("Sortir la personne du véhicule", nil, { RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                MarquerJoueur(closestPlayer)
                            end
                            if s then
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    local target, distance = ESX.Game.GetClosestPlayer()
                                    TriggerServerEvent('god_handcuffs:OutVehicle', GetPlayerServerId(target))
                                else
                                    ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle('T.I.G.', nil, {RightLabel = "→"}, true, function(_, a, s)
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
                                        ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
                                    end
                                else
                                    ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
                                end
                            end
                        end)

                        if ESX.PlayerData.job.grade >= 8 then
                            RageUI.Separator("↓ ~o~ Licences~s~ ↓")
                            RageUI.ButtonWithStyle('Donner le PPA', nil, {RightLabel = "→"}, true, function(h,a,s)
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
                                    ESX.ShowNotification("~g~Licences~s~: PPA Donné au citoyen")
                                end
                            end)
                            RageUI.ButtonWithStyle('Donner la licence aviation', nil, {RightLabel = "→"}, true, function(h,a,s)
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
                                    ESX.ShowNotification("~g~Licences~s~: Licence aviation donné au citoyen")
                                end
                            end)
                        end
                        RageUI.Separator("↓ ~o~ Bracelets~s~ ↓")

                        RageUI.ButtonWithStyle("Gestion de bracelets", 'Accédez aux bracelets', { RightLabel = "→" }, true, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                TriggerEvent('fl_policejob:manageBracelet')
                            end
                        end)
                        if ESX.PlayerData.job.grade >= 2 then
                            RageUI.ButtonWithStyle("Créer un bracelet", 'Accédez aux bracelets', { RightLabel = "→" }, true, function(_,_,s)
                                if s then
                                    RageUI.CloseAll()
                                    TriggerServerEvent('fl_policejob:createBracelet')
                                end
                            end)
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_licenses'),true,true,true,function()
                        if BcsoLicenses.PDC == true then
                            RageUI.ButtonWithStyle("Permis de conduire", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis de conduire ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if BcsoLicenses.MOTO == true then
                            RageUI.ButtonWithStyle("Permis moto", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis moto", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if BcsoLicenses.TRUCK == true then
                            RageUI.ButtonWithStyle("Permis poids lourd", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end) 
                        else
                            RageUI.ButtonWithStyle("Permis poids lourd", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)
                        end
                        if BcsoLicenses.PPA == true then
                            RageUI.ButtonWithStyle("Permis de port d'arme(s) ", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end)  
                        else
                            RageUI.ButtonWithStyle("Permis de port d'arme(s) ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)  
                        end
                        if BcsoLicenses.AIRPLANE == true then
                            RageUI.ButtonWithStyle("Permis aviation ", nil, {RightLabel = "~g~Acquis"}, true, function(h, a, s)
                            end)  
                        else
                            RageUI.ButtonWithStyle("Permis aviation ", nil, {RightLabel = "~r~Non-Acquis"}, true, function(h, a, s)
                            end)  
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_bill_no'),true,true,true,function()
                        local found = 0
                        for k,v in pairs(BillsNoPay) do
                            found = found + 1
                        end
                        if found > 0 then
                            BillsNoPay = BillsNoPay
                            RageUI.Separator("↓ ~y~Liste des amendes impayées ~s~↓")
                        else
                            RageUI.Separator("")
                            RageUI.Separator("~r~Aucune amende impayée trouvée !")
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

                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_fouille'),true,true,true,function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
                        RageUI.Separator("↓ Argent(s) sale ↓")
                        for k,v  in pairs(BCSO.playerBlackMoney) do
                            RageUI.ButtonWithStyle("[~r~"..v.label.."~s~$] - ".."Argent sale :", nil, {RightLabel = "→→"}, true, function(_, a, s)
                                if s then
                                    local combien = KeyboardInput("atmos", "Quantité :", "", 30)
                                    if combien == nil then 
                                        ESX.ShowNotification("~r~Problème~s~ : Case vide !")
                                    else
                                        if tonumber(combien) > v.amount then
                                            ESX.ShowAdvancedNotification("Central","~b~Information(s)","Quantité invalide.", "CHAR_CALL911", 1)
                                        else
                                            TriggerServerEvent('elderslife:ConfiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                        end
                                    end
                                    RageUI.GoBack()
                                end
                            end)
                        end
                        RageUI.Separator("↓ Objet(s) ↓")
                        for k,v  in pairs(BCSO.playerItem) do
                            RageUI.ButtonWithStyle("[~b~"..v.right.."~s~] - "..v.label, nil, {RightLabel =  "→→"}, true, function(_, a, s)
                                if s then
                                    local combien = KeyboardInput("atmos", "Quantité :", "", 30)
                                    if combien == nil then 
                                        ESX.ShowNotification("~r~Problème~s~ : Case vide !")
                                    else
                                        if tonumber(combien) > v.amount then
                                            ESX.ShowAdvancedNotification("Central","~b~Information(s)","Quantité invalide.", "CHAR_CALL911", 1)
                                        else
                                            TriggerServerEvent('elderslife:ConfiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                        end
                                    end
                                    RageUI.GoBack()
                                end
                            end)
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_identity'),true,true,true,function()
                        if plyIdentity then
                            RageUI.ButtonWithStyle("Nom : ", nil, {RightLabel = plyIdentity.firstname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Prénom : ", nil, {RightLabel = plyIdentity.lastname}, true, function(h, a, s)
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
                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_codes'),true,true,true,function()

                        RageUI.ButtonWithStyle("Prendre une pause de service", false , {RightLabel = "→→"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "pause", BCSO.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)
                        
                        RageUI.ButtonWithStyle("Standby - en attente de dispatch", false , {RightLabel = "→→"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "standby", BCSO.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Contrôle routier en cours", false , {RightLabel = "→→"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "control", BCSO.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.ButtonWithStyle("Refus d'obtempérer || Délit de fuite", false , {RightLabel = "→→"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "refus", BCSO.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.ButtonWithStyle("Crime - en cours || Poursuite en cours", false , {RightLabel = "→→"}, not SetDown[0], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "crime", BCSO.MyMatricule)
                                SetDown[0] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[0] = false
                                end)
                            end
                        end)

                        RageUI.Separator("↓ ~b~Demande de renfort ~s~↓")
                        
                        RageUI.ButtonWithStyle("Petite demande de renforts", false , {RightLabel = "→→"}, not SetDown[1], function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "petit")
                                SetDown[1] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[1] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Grande demande de renforts", false , {RightLabel = "→→"}, not SetDown[2] , function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "grande")
                                SetDown[2] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[2] = false
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Demande de toutes les unités", false , {RightLabel = "→→"}, not SetDown[3] , function(_,_,s)
                            if s then
                                local coords = GetEntityCoords(PlayerPedId())
                                TriggerServerEvent('Elderssheriff:CallNotifBCSO', coords, "allcops")
                                SetDown[3] = true
                                Citizen.SetTimeout((6000), function()
                                    SetDown[3] = false
                                end)
                            end
                        end)
                        RageUI.Separator("↓ ~b~Autres type de demande ~s~↓")
                        RageUI.ButtonWithStyle("Demande de renfort urgente à la [~b~EMS~s~]", nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre demande d'unité(s) a été envoyé avec succès !", "CHAR_CALL911", 1)
                                PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
                                TriggerServerEvent("Elderssheriff:HelpNotifsRenfort", "ambulance", GetEntityCoords(PlayerPedId()), "BCSO")
                            end
                        end)
                        RageUI.ButtonWithStyle("Demande de renfort urgente à la [~b~LSPD~s~]", nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                ESX.ShowAdvancedNotification("Central", "Information(s)", "Votre demande d'unité(s) a été envoyé avec succès !", "CHAR_CALL911", 1)
                                PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
                                PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
                                TriggerServerEvent("Elderssheriff:HelpNotifsRenfort", "police", GetEntityCoords(PlayerPedId()), "BCSO")
                            end
                        end)

                        RageUI.Separator("↓ ~b~Zone d'arret ~s~↓")
                            RageUI.ButtonWithStyle('Mettre zone de sécurité', nil, {RightLabel = "→"}, true, function(h,a,s)
                                if s then
                                    TriggerEvent('elders_sheriff:promptSpeedzone', numerozone)
                                    RageUI.CloseAll()
                                end
                            end)
                        RageUI.List("Zone de sécurité", arraysecu, arrayIndexSecu, nil, {}, true, function(h, a, s, i) arrayIndexSecu = i
                                if s then
                                    if arrayIndexSecu == 1 then
                                        TriggerEvent('elders_sheriff:toggleSpeedzoneDraw', true)
                                    elseif arrayIndexSecu == 2 then
                                        TriggerEvent('elders_sheriff:toggleSpeedzoneDraw', false)
                                    end
                                end
                            end)

       
                    end)
                    RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_veh'),true,true,true,function()
                    RageUI.ButtonWithStyle("Information(s) sur le véhicule", nil, { RightLabel = "→→" }, true, function(h,a,s)
                        local getVeh = ESX.Game.GetVehicleProperties(ESX.Game.GetVehicleInDirection())
                        if a then
                            VehiculeMarker()
                        end
                        if s then
                            BCSO.VehiculeInfos = nil
                            ESX.TriggerServerCallback('Elderssheriff:getVehiculehInfos', function(Infos)
                                BCSO.VehiculeInfos = Infos
                            end, getVeh.plate, GetDisplayNameFromVehicleModel(getVeh.model))
                            waitingForPlaque = true
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                LoadAnimDict("amb@code_human_sheriff_investigate@idle_a")
                                TaskPlayAnim(PlayerPedId(), "amb@code_human_sheriff_investigate@idle_a", "idle_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0) 
                                TriggerServerEvent("Elderssheriff:SendSoundPlaque")
                                TriggerServerEvent("Elders_log:FouilleVehicleBCSO", webhook, "```"..tostring(GetPlayerName(PlayerId())).." à fait une recherche de plaque sur le véhicule -> "..getVeh.plate.."```")
                            end
                        end
                    end,RMenu:Get('sheriff_menu', 'sheriff_veh_infos'))
    
                    --[[RageUI.ButtonWithStyle("Mettre le véhicule en fourrière", nil, {RightLabel = "→→"},true, function(h, a, s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                local getVeh = ESX.Game.GetVehicleProperties(ESX.Game.GetVehicleInDirection())
                                if getVeh ~= nil then
                                    TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                    ShowLoadingMessage("Mise en fourrière du véhicule...", 1, 6500)
                                    Wait(6500)
                                    DeleteEntity(ESX.Game.GetClosestVehicle())
                                    ClearPedTasks(PlayerPedId())
                                    TriggerServerEvent('eden_garage:ChangeStateFrompoundJob', getVeh.plate, true)
                                    TriggerServerEvent("Elders_log:fourriereVehicleBCSO", webhook, "```"..tostring(GetPlayerName(PlayerId())).." à mis le véhicule -> "..getVeh.plate.." en fourrière ```")
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le véhicule à été mis en fourrière !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Aucun véhicule à proximité !", "CHAR_CALL911", 1)
                            end
                        end
                    end)]]--

                    RageUI.ButtonWithStyle("Crocheter le véhicule", nil, { RightLabel = "→→" }, true, function(h,a,s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous ne pouvez pas crocheter à l'intérieur d'un véhicule !", "CHAR_CALL911", 1)
                                return
                            end
                            if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                if GetVehicleDoorLockStatus(ESX.Game.GetVehicleInDirection()) ~= 3 then
                                    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                    ShowLoadingMessage("Crochetage du véhicule...", 1, 10000)
                                    Citizen.Wait(10000)
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleDoorsLocked(ESX.Game.GetVehicleInDirection(), 0)
                                    SetVehicleDoorsLockedForAllPlayers(ESX.Game.GetVehicleInDirection(), false)
                                    ClearPedTasksImmediately(PlayerPedId())
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le véhicule a été crocheter !", "CHAR_CALL911", 1)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le véhicule a un sabot posé !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Aucun véhicule à proximité !", "CHAR_CALL911", 1)
                            end
                        end
                    end)

                    --[[RageUI.ButtonWithStyle("Poser un sabot au véhicule", nil, { RightLabel = "→→" }, true, function(h,a,s)
                        if a then 
                            VehiculeMarker()
                        end
                        if s then
                            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous ne pouvez pas poser un sabot à l'intérieur d'un véhicule !", "CHAR_CALL911", 1)
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
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous avez posé un sabot sur le véhicule jusqu'à la tempête !", "CHAR_CALL911", 1)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Le véhicule possède déjà un sabot !", "CHAR_CALL911", 1)
                                end
                            else
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Aucun véhicule à proximité !", "CHAR_CALL911", 1)
                            end
                        end
                    end)]]--
                end)

                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_veh_infos'),true,true,true,function()
                    if BCSO.VehiculeInfos then
                        if BCSO.VehiculeInfos.plate == nil then
                            RageUI.Separator("")
                            RageUI.Separator("~r~Aucun véhicule à proximité !")
                            RageUI.Separator("")
                        else
                            if waitingForPlaque then
                                TriggerEvent("Elderssheriff:waitingForPlaque")                               
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "~b~Analyse~s~ en cours...\nRécupération des données, veuillez patentiez !", "CHAR_CALL911", 1)
                                RageUI.Separator("")
                                RageUI.Separator("~b~Vérification des informations...")
                                RageUI.Separator("")
                            end
                            local owner = ""
                            if not BCSO.VehiculeInfos.owner then owner = "Inconnu" else owner = BCSO.VehiculeInfos.owner end
                            if not waitingForPlaque then
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Information(s)~s~ reçus.\n~b~Propriétaire : ~s~"..owner.."\n~b~Model : ~s~"..BCSO.VehiculeInfos.model.."\n~b~Plaque : ~s~"..BCSO.VehiculeInfos.plate, "CHAR_CALL911", 1)
                                RageUI.Separator("~b~Propriétaire du véhicule : ~s~"..owner)
                                RageUI.Separator("~b~Model du véhicule : ~s~"..BCSO.VehiculeInfos.model)
                                RageUI.Separator("~b~Plaque d'imatriculation : ~s~"..BCSO.VehiculeInfos.plate)
                            end
                        end
                    end
                end)

                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_fine'),true,true,true,function()
                    RageUI.ButtonWithStyle("Amende personalisé", false , {RightLabel = "→→"}, true , function(_,_,s)
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
                                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(player), 'society_sheriff', raison, montant)                                                
                                                TriggerServerEvent("Elderssheriff:sSendLogs", tostring(GetPlayerName(PlayerId())).." à envoyé une amende de **"..montant.."$** pour la raison : "..raison, 22)
                                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous avez envoyé une amende de : ~b~"..montant.. " $ ~s~pour : ~b~" ..raison, "CHAR_CALL911", 1)
                                            else
                                                ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)

                    RageUI.List("Catégorie : ", {{ Name = "Circulation", Value = 1 },{Name = "Petites Contraventions", Value = 2 },{Name = "Moyennes Contraventions", Value = 3 },{Name = "Grandes Contraventions", Value = 4 },}, BCSO.IndexFine, nil, {}, true, function(_,a,s,Index)
                        BCSO.IndexFine = Index
                        if s then
                            BCSO.FineLister = {}
                            ESX.TriggerServerCallback('Elderssheriff:getFineList', function(fines)
                                for k,fine in ipairs(fines) do
                                    table.insert(BCSO.FineLister, {label = fine.label, amount = ESX.Math.GroupDigits(fine.amount)})
                                end
                            end, BCSO.IndexFine - 1)                           
                        end
                    end)
                    for k,v in pairs(BCSO.FineLister) do
                        RageUI.ButtonWithStyle(v.label, false , {RightLabel = "~b~"..v.amount.."$"}, true , function(_,_,s)
                            if s then
                                Label = v.label
                                Amount = v.amount
                            end
                        end, RMenu:Get("sheriff_menu", "sheriff_fine_gest"))
                    end
                end)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_fine_gest'),true,true,true,function()
                    RageUI.Separator("Montant : [~b~"..Amount.."$~s~] | "..Label.."")
                    RageUI.ButtonWithStyle("Donner l'amende", false , {RightLabel = "→→"}, true , function(_,a,s)
                        if s then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_sheriff', Label, Amount)
                                TriggerServerEvent("Elderssheriff:sSendLogs", tostring(GetPlayerName(PlayerId())).." à envoyé une amende de **"..Amount.."$** pour la raison : "..Label, 22)
                                ESX.ShowAdvancedNotification("Central","~b~Information(s)","Vous avez envoyé une amende à la personne", "CHAR_CALL911", 1)
                            else
                                ESX.ShowAdvancedNotification("Central","~b~Information(s)","Aucun individu(s) à proximitée.", "CHAR_CALL911", 1)
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

function OpenBCSOExtra()
	if not BCSO.Extra then
		BCSO.Extra = true
		RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_extra_main'), true)
        Citizen.CreateThread(function()
            while BCSO.Extra do
                Citizen.Wait(1)

                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_extra_main'),true,true,true,function()
                    RageUI.List("Type", {"Extra", "Livery"}, BCSO.IndexCustom, nil, {}, true, function(_,_,s,Index)
                        BCSO.IndexCustom = Index
                    end)
                    if BCSO.IndexCustom == 1 then
                        local elements = {}
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        for id=0, 12 do
                            if DoesExtraExist(vehicle, id) then
                                local state = IsVehicleExtraTurnedOn(vehicle, id) 
                                if state then
                                    table.insert(elements, {
                                        label = "Supplémentaire : N°"..id..""..('<span style="color:green;">%s</span>'):format(""),
                                        value = id,
                                        state = not state,
                                        status = "ON"
                                    })
                                else
                                    table.insert(elements, {
                                        label = "Supplémentaire : N°"..id..""..('<span style="color:red;">%s</span>'):format(""),
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
                            RageUI.Separator("~r~Ce véhicule ne comporte")
                            RageUI.Separator("~r~pas de supplément(s) !")
                            RageUI.Separator("")
                        end
                        for k,v in pairs(elements) do
                            RageUI.ButtonWithStyle(v.label, nil,{RightLabel = v.status}, true, function(_,_,s)
                                if s then
                                    SetVehicleExtra(vehicle, v.value, not v.state)
                                    local newData = v
                                    if v.state then
                                        newData.label = "Supplémentaire : N°"..v.value..""..('<span style="color:green;">%s</span>'):format("")
                                    else
                                        newData.label = "Supplémentaire : N°"..v.value..""..('<span style="color:red;">%s</span>'):format("")
                                    end
                                    newData.state = not v.state
                                end
                            end)
                        end
                    elseif BCSO.IndexCustom == 2 then
                        local livery = {}
                        local vehicle = GetVehiclePedIsIn(PlayerPedId())
                        local liveryCount = GetVehicleLiveryCount(vehicle)
                        for i = 1, liveryCount do
                        local state = GetVehicleLivery(vehicle) 
                        local text
                            if state == i then
                                text = "Modèle : N°"..i..""..('<span style="color:green;">%s</span>'):format("")
                            else
                                text = "Modèle : N°"..i..""..('<span style="color:red;">%s</span>'):format("")
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
                            RageUI.Separator("~r~Ce véhicule ne comporte pas de modèle(s) !")
                            RageUI.Separator("")
                        end
                        for k,v in pairs(livery) do
                            RageUI.ButtonWithStyle(v.label, nil,{RightLabel = "→→"}, true, function(_,_,s)
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

function OpenGestPlainteMenuBCSO()
    PlainteActif = {}
    ESX.TriggerServerCallback('Elderssheriff:GetPlainte', function(plainte)
        PlainteActif = plainte 
    end)
    if not BCSO.GestPlainte then
		BCSO.GestPlainte = true
		RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_plainte_gest'), true)
        Citizen.CreateThread(function()
            while BCSO.GestPlainte do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_plainte_gest'),true,true,true,function()
                local found = 0
                    for k,v in pairs(PlainteActif) do
                        found = found + 1
                    end
                    if found > 0 then
                        PlainteActif = PlainteActif
                        RageUI.Separator("↓ ~b~Gestion des plainte(s) ~s~↓")
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucune plainte déposée !")
                        RageUI.Separator("")
                    end
                    for k,v in pairs(PlainteActif) do
                        RageUI.ButtonWithStyle("[~b~"..k.."~s~] - "..v.name.. " || "..v.date, nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                selectPlainte = v
                                selecK = k
                            end
                        end, RMenu:Get("sheriff_menu", "sheriff_plainte_gest_main"))
                    end
                end)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_plainte_gest_main'),true,true,true,function()
                    RageUI.Separator("Prénom/Nom : ~b~"..selectPlainte.name)
                    RageUI.Separator("Date de naissance : ~b~"..selectPlainte.dtn)
                    RageUI.Separator("Numéro de téléphone : ~b~"..selectPlainte.numero)
                    RageUI.Separator("Éffectué à : ~b~"..selectPlainte.date)
                    RageUI.ButtonWithStyle("Description : ", selectPlainte.text, {}, true, function() end)
                    RageUI.ButtonWithStyle("Supprimé la plainte", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Vous avez supprimé la plainte de la base de données !", "CHAR_CALL911", 1)
                            TriggerServerEvent("Elderssheriff:RemovePlainte", selecK)
                            PlainteActif = {}
                            ESX.TriggerServerCallback('Elderssheriff:GetPlainte', function(plainte)
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

function OpenPlainteMenuBCSO()
    if not BCSO.PlainteActif then
		BCSO.PlainteActif = true
		RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_plainte_main'), true)
        Citizen.CreateThread(function()
            while BCSO.PlainteActif do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_plainte_main'),true,true,true,function()

                    RageUI.Separator("↓ ~b~Dépot de plainte ~s~↓")
                    RageUI.ButtonWithStyle("Nom", nil, {RightLabel = nom or "→→"}, true, function(_,_,s)
                        if s then
                            nom = KeyboardInput("atmos", "Nom", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Prénom", nil, {RightLabel = prenom or "→→"}, true, function(_,_,s)
                        if s then
                            prenom = KeyboardInput("atmos", "Prénom", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Date de naissance", nil, {RightLabel = dtn or "→→"}, true, function(_,_,s)
                        if s then
                            dtn = KeyboardInput("atmos", "Date de naissance", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Numéro de téléphone", nil, {RightLabel = tel or "→→"}, true, function(_,_,s)
                        if s then
                            tel = KeyboardInput("atmos", "Numéro de téléphone", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Description", nil, {RightLabel = text or "→→"}, true, function(_,_,s)
                        if s then
                            text = KeyboardInput("atmos", "Déscription", "", 200)
                        end
                    end)
                    RageUI.ButtonWithStyle("Transmettre la plainte", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            if text == "" or text == nil or nom == "" or nom == nil or prenom == "" or prenom == nil or dtn == "" or  dtn == nil or tel == "" or tel == nil then
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Veuillez rentrer une plainte valide ! ", "CHAR_CALL911", 1)
                            else
                                local InsterData = {
                                    text = text,
                                    name = nom.." - "..prenom,
                                    dtn = dtn,
                                    tel = tel,
                                }
                                TriggerServerEvent("Elders_log:PlainteMenuBCSO", webhook, "```"..nom.." - "..prenom.." vient de faire un dépot de plainte pour la raison : **"..text.."** - Téléphone **"..tel.."```")
                                ESX.ShowAdvancedNotification("Central", "~b~Information(s)", "Votre plainte a été transmise au Nom de :\nNom : ~b~"..nom.."~s~\nPrénom : ~b~"..prenom, "CHAR_CALL911", 1)
                                TriggerServerEvent("Elderssheriff:AddPlainte", InsterData)
                                BCSO.PlainteActif = false
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

function OpenVehicleSpawnerMenuBCSO(station)
    local playerCoords = GetEntityCoords(PlayerPedId())
    PlayerData = ESX.GetPlayerData()
    if not BCSO.VehBCSO then
        BCSO.VehBCSO = true
        RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_veh_main'), true)
        Citizen.CreateThread(function()
            while BCSO.VehBCSO do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_veh_main'),true,true,true,function()
                    RageUI.Separator("↓ ~b~Types de véhicules ~s~↓")
                    RageUI.ButtonWithStyle("Véhicules", nil, {RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            local shopElements, shopCoords = {}
                            shopCoords = ConfigBCSO.points.InsideShop
                            if #ConfigBCSO.AuthorizedVehicles['Shared'] > 0 then
                                for k,vehicle in ipairs(ConfigBCSO.AuthorizedVehicles['Shared']) do
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
                    RageUI.ButtonWithStyle("Hélicoptère", nil, {RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            local shopElements, shopCoords = {}
                            shopCoords = ConfigBCSO.points.InsideShop
                            local authorizedHelicopters = ConfigBCSO.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]
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
                                ESX.ShowNotification("Vous n'avez pas l'autorisation d'acheter des hélicoptère")
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
    restoreCoords = restoreCoords
    local playerPed = PlayerPedId()
    if not BCSO.VehSelectBCSO then
        BCSO.VehSelectBCSO = true
        thismodel = nil
        RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_vehselect_main'), true)
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
            while BCSO.VehSelectBCSO do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("sheriff_menu",'sheriff_vehselect_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→" }, true, function(h,a,s)
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

                                ESX.TriggerServerCallback('god_sheriffjob:buyJobVehicle', function (bought)
                                    if bought then
                                        ESX.ShowNotification('Vehicule transféré au garage')

                                        RageUI.CloseAll()
                                        BCSO.VehSelectBCSO = false
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isInShopMenu then
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Citizen.Wait(1000)
        end
    end
end)

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

function StopMenuBCSO()
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_menu_main'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_inter'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_codes'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_fouille'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_identity'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_veh'), false)
    RageUI.Visible(RMenu:Get('sheriff_menu', 'sheriff_veh_infos'), false)
end

RegisterCommand('OpenF6sheriff', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job.name == 'offsheriff' then
        if isDead then 
            return 
        else
            OpenF6sheriff()
        end
    end
end)

RegisterKeyMapping('OpenF6sheriff', "Menu Intéraction | LSSD", 'keyboard', 'F6')
end)

Citizen.CreateThread(function()
    while true do
        interval = 750
        plyCoords = GetEntityCoords(PlayerPedId(), false)

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "sheriff" or ESX.PlayerData.job.name == "offsheriff" then
            local pos = ConfigBCSO.points.vestiaire
            if #(plyCoords - pos) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenBCSOClothes()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.vestiaire1
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.vestiaire1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenBCSOClothes()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.vestiaire2
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.vestiaire2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        OpenBCSOClothes()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.armurerie
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.armurerie, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à l'armurerie")
                    if IsControlJustPressed(1,51) then
                        OpenAmmuBCSO()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.extra
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.extra, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au extra")
                    if IsControlJustPressed(1,51) then
                        OpenBCSOExtra()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.LirePlainte
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.LirePlainte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au gestion des plaintes")
                    if IsControlJustPressed(1,51) then
                        OpenGestPlainteMenuBCSO()
                    end
                end
            end
            local pos1 = ConfigBCSO.points.AchatVehicle
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.AchatVehicle, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter des véhicules")
                    if IsControlJustPressed(1,51) then
                        OpenVehicleSpawnerMenuBCSO('BCSO')
                    end
                end
            end

        end

        local pos1 = ConfigBCSO.points.DepotPlainte
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.DepotPlainte, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au déposer plainte")
                    if IsControlJustPressed(1,51) then
                        OpenPlainteMenuBCSO()
                    end
                end
            end
        local pos1 = ConfigBCSO.points.AppelBCSO
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  ConfigBCSO.points.AppelBCSO, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour appeler le BCSO")
                    if IsControlJustPressed(1,51) then
                        ServiceBCSO()
                    end
                end
            end
        Citizen.Wait(interval)
    end
end)

function ServiceBCSO()
    local servpopo = RageUI.CreateMenu("Accueil LSSD", "Que puis-je faire pour vous ?")
    servpopo:SetRectangleBanner(0,0,0,255)
    RageUI.Visible(servpopo, not RageUI.Visible(servpopo))
    while servpopo do
        Citizen.Wait(0)
            RageUI.IsVisible(servpopo, true, true, true, function()

            RageUI.ButtonWithStyle("Appeler un agent sheriff ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then  
                TriggerServerEvent("genius2:sendcallBCSO")
                RageUI.Popup({message = "<C>~b~Votre appel à bien été pris en compte"})
                end
            end)

            
    end, function()
    end)
    
        if not RageUI.Visible(servpopo) then
            servpopo = RMenu:DeleteType("servpopo", true)
        end
    end
end