ESX = nil

local isMenuOpened = false
local Color = nil
local Load = 0.0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local itemsGang = {
    {item =  "WEAPON_SNOWBALL", label  = "Ramasser une : Brique", name = "Brique", down = false},
    {item =  "WEAPON_BALL", label  = "Ramasser une : Balle", name = "Balle", down = false},
}

local gangsMenuProps = {
    {nom = "Chaise", prop = "bkr_prop_weed_chair_01a"},
    {nom = "Sac pour arme", prop = "prop_gun_case_01"},
    {nom = "Prop meth", prop = "bkr_prop_meth_pseudoephedrine"},
    {nom = "Sac de meth ouvert", prop = "bkr_prop_meth_openbag_01a"},
    {nom = "Gros sac de meth", prop = "bkr_prop_meth_bigbag_04a"},
    {nom = "Gros sac de weed", prop = "bkr_prop_weed_bigbag_03a"},
    {nom = "Weed plante", prop = "bkr_prop_weed_01_small_01a"},
    {nom = "Weed", prop = "bkr_prop_weed_dry_02b"},
    {nom = "Table de weed", prop = "bkr_prop_weed_table_01a"},
    {nom = "Cash", prop = "hei_prop_cash_crate_half_full"},
    {nom = "Valise de cash", prop = "prop_cash_case_02"},
    {nom = "Petite pile de cash", prop = "prop_cash_crate_01"},
    {nom = "Poubelle", prop = "prop_cs_dumpster_01a"},
    {nom = "Canapé", prop = "v_tre_sofa_mess_c_s"},
    {nom = "Canapé 2", prop = "v_res_tre_sofa_mess_a"},
    {nom = "Pile de cash", prop = "bkr_prop_bkr_cashpile_04"},
    {nom = "Pile de cash 2", prop = "bkr_prop_bkr_cashpile_05"},
    {nom = "Block de coke", prop = "bkr_prop_coke_block_01a"},
    {nom = "Coke en bouteille", prop = "bkr_prop_coke_bottle_01a"},
    {nom = "Coke coupé", prop = "bkr_prop_coke_cut_01"},
    {nom = "Bol de coke", prop = "bkr_prop_coke_fullmetalbowl_02"},
}

local function RamasserGangsDivers(weapon, name)
    RequestAnimDict('anim@mp_snowball')
    TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 0, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.Wait(2000)
    FreezeEntityPosition(PlayerPedId(), false)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), 1, false, true)
    ESX.ShowAdvancedNotification('Elders Life', 'Information(s)', "Vous venez de ramasser une ~b~"..name, 'CHAR_ELDERS', 10)
end

function getGangsProps()
    gangsProps = {}
    ESX.TriggerServerCallback('elderslife:getProps', function(props)
        gangsProps = props
    end)
end

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('god:setJob2')
AddEventHandler('god:setJob2', function(job)
    ESX.PlayerData.job2 = job
end)

RMenu.Add("gang", "blackmarket", RageUI.CreateMenu("BlackMarket", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("gang", "blackmarket").Closed = function()
    isMenuOpened = false
end

RMenu.Add("gang", "interaction", RageUI.CreateMenu("Gang/Orga", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("gang", "interaction").Closed = function()
    isMenuOpened = false
end

RMenu.Add("gang", "vestiaire", RageUI.CreateMenu("Vestiaire", "~b~Actions :", nil, nil, "aLib", "black"))
RMenu:Get("gang", "vestiaire").Closed = function()
    isMenuOpened = false
    FreezeEntityPosition(PlayerPedId(), false)
end

RMenu.Add("gang", "citoyens", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
RMenu:Get("gang", "citoyens").Closed = function()end

RMenu.Add("gang", "objets", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
RMenu:Get("gang", "objets").Closed = function()end

RMenu.Add("gang", "gangs_props", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
RMenu:Get("gang", "gangs_props").Closed = function()end

RMenu.Add("gang", "gangs_gestionprops", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
RMenu:Get("gang", "gangs_gestionprops").Closed = function()end

--RMenu.Add("gang", "objets", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
--RMenu:Get("gang", "objets").Closed = function()end

RMenu.Add("gang", "iventoryplayer", RageUI.CreateSubMenu(RMenu:Get("gang", "interaction"), "Gang/Orga", "~b~Actions"))
RMenu:Get("gang", "iventoryplayer").Closed = function()end

RMenu.Add("gang", "changetenue", RageUI.CreateSubMenu(RMenu:Get("gang", "vestiaire"), "Vestiaire", "~b~Actions"))
RMenu:Get("gang", "changetenue").Closed = function()end

RMenu.Add("gang", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("gang", "vestiaire"), "Vestiaire", "~b~Actions"))
RMenu:Get("gang", "deletetenue").Closed = function()end

RMenu.Add("gang", "craft_chargement", RageUI.CreateSubMenu(RMenu:Get("gang", "blackmarket"), "BlackMarket", "~b~Actions"))
RMenu:Get("gang", "craft_chargement").Closed = function()end

 local function CouperCheveux()
    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
    if count > 0 then
        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~=-1 and distance <= 2.0 then
            FreezeEntityPosition(GetPlayerPed(-1), true)
            local a,b,x,d = GetEntityMatrix(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(player))))
            SetEntityCoords(GetPlayerPed(-1),d+b*.45-a*.1-x*.9)
            SetEntityHeading(GetPlayerPed(-1),GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerId(player))))+15.0)
            if IsPedInAnyVehicle(GetPlayerPed(-1)) then ESX.ShowHelpNotification("~r~ATTENTION~s~\n- Vous ne pouvez faire cette action dans un véhicule !") return end
            ClearPedTasks(GetPlayerPed(-1))
            if not HasAnimDictLoaded("missfam6ig_8_ponytail") then
                if not DoesAnimDictExist("missfam6ig_8_ponytail") then return end
                RequestAnimDict("missfam6ig_8_ponytail")
                while not HasAnimDictLoaded("missfam6ig_8_ponytail") do
                    Citizen.Wait(10)
                end
            end
            TaskPlayAnim(GetPlayerPed(-1), "missfam6ig_8_ponytail", "ig_7_loop_michael", 8.0, -8.0, -1, 1, 1, 0, 0, 0, 0)
            ESX.ShowHelpNotification("Vous avez utilisé une paire de ~b~ciseaux~s~ !")
            TriggerServerEvent("EldersGang:CutHairPlayerServer", GetPlayerServerId(player))
            TriggerServerEvent("elderslife:removeInvItems", "ciseau", 1)
            local ciseauObject = CreateObject(GetHashKey("p_cs_scissors_s"), GetEntityCoords(GetPlayerPed(-1)), true, true, true)
            SetNetworkIdCanMigrate(ObjToNet(ciseauObject), false)
            AttachEntityToEntity(ciseauObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0, 0, 0, 0, 0, 0, true, true, false, true, 1, false)
            Citizen.Wait(12500)
            ClearPedTasks(GetPlayerPed(-1))
            RemoveAnimDict("missfam6ig_8_ponytail")
            DeleteEntity(ciseauObject)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            ESX.ShowHelpNotification("~r~ATTENTION~s~\n- Vous avez ~r~coupé~s~ les cheveux de la personne.")
        else
            ESX.ShowHelpNotification("~r~Aucun individu(s) à proximité !")
        end
    else
        ESX.ShowAdvancedNotification('Elders Life', '~b~Information(s)', '~r~Vous n\'avez pas de ciseaux sur vous !', 'CHAR_ELDERS', 10)
        
    end
    end, "ciseau")
end

RegisterNetEvent("EldersGang:CutHairPlayer")
AddEventHandler("EldersGang:CutHairPlayer", function()
    ClearPedTasks(GetPlayerPed(-1))
    SetPedCanPlayAmbientBaseAnims(GetPlayerPed(-1), true)
    if not HasAnimDictLoaded("missfam6ig_8_ponytail") then
        if not DoesAnimDictExist("missfam6ig_8_ponytail") then return end
        RequestAnimDict("missfam6ig_8_ponytail")
        while not HasAnimDictLoaded("missfam6ig_8_ponytail") do
            Citizen.Wait(10)
        end
    end
    TaskPlayAnim(GetPlayerPed(-1), "missfam6ig_8_ponytail", "ig_7_loop_lazlow", 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    Citizen.Wait(12500)
    ESX.ShowHelpNotification("~r~ATTENTION~s~\n- Vos cheveux viennent d'être ~r~coupé~s~ par une personne !")
    TriggerEvent("skinchanger:change", "hair_1", 0)
    SetPedToRagdoll(GetPlayerPed(-1),1000,1000,0,0,0,0)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent("god_skin:save", skin)
    end)
end)

local function openMenuBlackMarket()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("gang","blackmarket"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("gang","blackmarket"),true,true,true,function()
                RageUI.Separator('↓ Stock ↓')
                if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == "biker_1" or ESX.PlayerData.job2.name == "famille_1" or ESX.PlayerData.job2.name == "famille_2" or ESX.PlayerData.job2.name == "biker_2" or ESX.PlayerData.job2.name == "biker_3" or ESX.PlayerData.job2.name == "biker" then
                    for k, v in pairs(ConfigGang.blackmarketbiker) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                achat = true
                                selectweapon = k
                                --TriggerServerEvent('aGang:achatarme', selectweapon, "biker")
                            end
                        end,RMenu:Get("gang", "craft_chargement"))
                    end
                else
                    for k, v in pairs(ConfigGang.blackmarket) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                achat = true
                                selectweapon = k
                                --TriggerServerEvent('aGang:achatarme', selectweapon)
                            end
                        end,RMenu:Get("gang", "craft_chargement"))
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang", "craft_chargement"), true, true, true, function()
                    if achat then label = "Achat en cours..." end
                    RageUI.Separator("Action : ~b~"..label)
                    RageUI.PercentagePanel(Load or 0.0, "Fabrication en cours (~b~" .. math.floor(Load*100) .. "%~s~)", "", "", function(_, a, Percent)
                        if Load < 1.0 then
                            Load = Load+0.0003
                        else
                            RageUI.GoBack()
                            ClearPedTasksImmediately(PlayerPedId())
                            Load = 0.0
                            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == "biker_1" or ESX.PlayerData.job2.name == "famille_1" or ESX.PlayerData.job2.name == "famille_2" or ESX.PlayerData.job2.name == "biker_2" or ESX.PlayerData.job2.name == "biker_3" or ESX.PlayerData.job2.name == "biker" then
                                TriggerServerEvent('aGang:achatarme', selectweapon, "biker")
                            else
                                TriggerServerEvent('aGang:achatarme', selectweapon)
                            end
                        end
                    end)
                end)
            Wait(0)
        end
    end)
end

local function openMenuInteraction()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("gang","interaction"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("gang","interaction"),true,true,true,function()
                RageUI.Separator('↓ Options '..ESX.PlayerData.job2.label..' ↓')
                RageUI.ButtonWithStyle("Intéractions Citoyens", nil, {RightLabel = "→→→"}, true,function(a,h,s) end, RMenu:Get("gang", "citoyens"))
                RageUI.ButtonWithStyle("Gestions Objets", nil, {RightLabel = "→→→"}, true,function(a,h,s) end, RMenu:Get("gang", "objets"))

                --RageUI.ButtonWithStyle("Placer objets", nil, {RightLabel = "→→→"}, true,function(a,h,s) end, RMenu:Get("gang", "objets"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang", "objets"),true,true,true,function()
                RageUI.ButtonWithStyle("Menu objet(s)",nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            getGangsProps()
                        end
                end, RMenu:Get("gang", "gangs_props"))

            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang",'gangs_props'),true,true,true,function()
                    RageUI.ButtonWithStyle("Gestion des objet(s)", nil, {RightLabel = "→→" }, true, function(_, a, s)
                        if s then
                            getGangsProps()
                        end
                    end, RMenu:Get("gang", "gangs_gestionprops"))

                    for k,v in pairs(gangsMenuProps) do
                        RageUI.ButtonWithStyle(v.nom, nil, {RightLabel =  "~b~Poser ~s~→→"}, true, function(_, a, s)
                            if s then
                                SpawnObj(v.prop)
                            end
                        end)
                    end
                end)

            RageUI.IsVisible(RMenu:Get("gang",'gangs_gestionprops'),true,true,true,function()
                    if #gangsProps == 0 then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Vous n'avez pas poser d'objet(s) !")
                        RageUI.Separator("")
                    else
                        for k,v in pairs(gangsProps) do
                            RageUI.ButtonWithStyle("Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {RightLabel =  "~r~Ranger ~s~→→"}, true, function(_, a, s)
                                if a then
                                    local entity = NetworkGetEntityFromNetworkId(v)
                                    local ObjCoords = GetEntityCoords(entity)
                                    DrawMarker(22, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                                end
                                if s then
                                    RemoveObj(v, k)
                                    TriggerServerEvent("elderslife:refreshProps", k) 
                                    getGangsProps()
                                end
                            end)
                        end
                    end
                end)
            RageUI.IsVisible(RMenu:Get("gang", "citoyens"),true,true,true,function()
                RageUI.Separator('↓ Intéraction ↓')
                RageUI.ButtonWithStyle("Fouiller", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if h then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            menu = 'citoyens'
                        else
                            menu = 'iventoryplayer'
                        end
                    end
                    if s then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification("Personnes autour", 'Problème')
                        else
                            getPlayerInv(closestPlayer)
                            ExecuteCommand("me fouille l'individu !")
                        end
                    end
                end, RMenu:Get("gang", menu))
                RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification("Personnes autour", 'Problème')
                        else
                            TriggerServerEvent("god_handcuffs:draggang", GetPlayerServerId(closestPlayer))
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Mettre dans le véhicule", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification("Personnes autour", 'Problème')
                        else
                            TriggerServerEvent('god_handcuffs:putInVehiclegang', GetPlayerServerId(closestPlayer))
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification("Personnes autour", 'Problème')
                        else
                            TriggerServerEvent('god_handcuffs:OutVehiclegang', GetPlayerServerId(closestPlayer))
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Coupé les cheveux de la personne", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then                        
                        CouperCheveux() 
                        RageUI.CloseAll()
                        isMenuOpened = false                       
                    end
                end)
                for k,v in pairs(itemsGang) do
                        RageUI.ButtonWithStyle(v.label,nil, {RightLabel = "→→"}, not v.down, function(_,_,s)
                            if s then
                                if not isFreezed then
                                    v.down = true
                                    Citizen.SetTimeout((30000), function()
                                        v.down = false
                                    end)
                                    RamasserGangsDivers(v.item, v.name)
                                    RageUI.CloseAll()
                                    isMenuOpened = false
                                else
                                    ESX.ShowHelpNotification("Oh, n'essayes-tu pas de tricher ? pas bien !")
                                end
                            end
                        end)
                    end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang", "iventoryplayer"),true,true,true,function()
                RageUI.Separator('↓ Argent ↓')
                for k, v in pairs(ArgentSale) do
                    RageUI.ButtonWithStyle("Argent sale", nil, {RightLabel = "Quantité : ~r~x"..v.amount.."$"}, true,function(a,h,s) end)
                end
                RageUI.Separator('↓ Items ↓')
                for k, v in pairs(Items) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Quantité : ~r~x"..v.amount}, true,function(a,h,s) end)
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function openMenuVestiaireGang()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("gang", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("gang", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Vestiaire ↓')
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("gang", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("gang", "deletetenue"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang", "changetenue"),true,true,true,function()
                RageUI.Separator('↓ Mes tenues ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerOutfit', function(clothes)
                                        TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                        TriggerEvent('god_skin:setLastSkin', skin)
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('god_skin:save', skin)
                                        end)
                                    end, v.value)
                                end)
                               ESX.ShowNotification("Vous venez de mettre la tenue "..v.label.." !", 'Dressing')
                            end
                        end)
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("gang", "deletetenue"),true,true,true,function()
                RageUI.Separator('↓ Supprimer une tenue ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent('god_eden_clotheshop:removeOutfit', v.value)
                                ESX.ShowNotification("Vous venez de supprimer la tenue "..v.label.." !", 'Dressing')
                                RageUI.GoBack()
                            end
                        end)
                    end
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function isNight()
    local hour = GetClockHours()
    if hour >= 0 and hour <= 6 then
        return true
    end
end

local function heure_IRL()
    TriggerServerEvent('checkRealTimesv')
    SetTimeout(60*1000, heure_IRL)
end

heure_IRL()

RegisterNetEvent("realtime:cl")
AddEventHandler("realtime:cl", function(h, m, s)            
heure = h
end)

Citizen.CreateThread(function()
    Citizen.Wait(2500)
    while true do
        interval = 750
        for k, v in pairs(ConfigGang.GangsList) do
            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.gangname then
                if v.orga then
                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.gangname and ESX.PlayerData.job2.grade_name == "boss" then
                        local plyCoords = GetEntityCoords(PlayerPedId(), false)
                        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.backmarket)
                        if dist <= 15 then
                            interval = 1
                            DrawMarker(22,  v.backmarket, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist <= 1.2 and not isMenuOpened then
                                if isNight() then
                                    if (heure >= 18 and heure < 24) or (heure <= 1) then
                                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le BlackMarket "..ESX.PlayerData.job2.label)
                                        if IsControlJustPressed(1,51) then
                                            openMenuBlackMarket()
                                        end
                                    else
                                        ESX.ShowHelpNotification("Le black Market est fermé (ouvert IRL de 18h à 01h)")
                                    end
                                else
                                   ESX.ShowHelpNotification("Le black Market est fermé (ouvert ingame de 00h à 06h)")
                                end
                            end
                        end
                    end
                end
                if v.vestiaire then
                    local plyCoords = GetEntityCoords(PlayerPedId(), false)
                    local dist1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.vestiaire)
                    if dist1 <= 15 then
                        interval = 1
                        DrawMarker(1, v.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 120, 120, 240, 100, false, true, 2, false, false, false, false)
                        if dist1 <= 1.2 and not isMenuOpened then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le vestiaire "..ESX.PlayerData.job2.label)
                            if IsControlJustPressed(1,51) then
                                openMenuVestiaireGang()
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('gang/orga', function()
    for k, v in pairs(ConfigGang.GangsList) do
        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.gangname then
            openMenuInteraction()
        end
    end
end)

RegisterKeyMapping('gang/orga', 'Menu Gang/Orga', 'keyboard', 'F9')
