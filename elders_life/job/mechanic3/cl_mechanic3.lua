ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true
local InRepair = false
local InNettoyage = false
local FarmIndex = 1
local InPlyZone = false
local PlyIsInAction = false
local totalcount = 0
local NumberRecup = 0
local qIndex = 1
local CraftIndex = 1
local quantity = {}
local MyInv = {}
local AllItems = {
        [1] = {"vices", "box", "fer"},
        [2] = {"produit", "lustreur", "chiffon"},
    }
local Color = nil
local Load = 0.0

local function GetInvItems(type)
    if type then
        ESX.TriggerServerCallback("elderslife:GetPlyIsHasItems", function(count, qty)
            hasitems = count
            hasitemqty = qty
        end, AllItems[1])
    else
        ESX.TriggerServerCallback("elderslife:GetPlyIsHasItems", function(count, qty)
            hasitemstwo = count
            hasitemqtytwo = qty
        end, AllItems[2])
    end
end

local function getAllItems()
    MyInv = {}
    MyInv = ESX.GetPlayerData().inv
    GetInvItems(true)
    GetInvItems(false)
    quantity = {}
    for i=1, 100 do
        table.insert(quantity, i)
    end
end

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("mechanic3", "princ", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "princ").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mechanic3", "mecano_farm_menu", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "mecano_farm_menu").Closed = function()
    isMenuOpened = false
end
RMenu.Add("mechanic3", "craft_main", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "craft_main").Closed = function()
    isMenuOpened = false
end
RMenu.Add("mechanic3", "vestiaire", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mechanic3", "mecano_menu_props", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "mecano_menu_props").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mechanic3", "Magasin", RageUI.CreateMenu("LS Custom", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("mechanic3", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("mechanic3", "changetenue", RageUI.CreateSubMenu(RMenu:Get("mechanic3", "vestiaire"), "LS Custom", "~b~Menu job :"))
RMenu:Get("mechanic3", "changetenue").Closed = function()end

RMenu.Add("mechanic3", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("mechanic3", "vestiaire"), "LS Custom", "~b~Menu job :"))
RMenu:Get("mechanic3", "deletetenue").Closed = function()end

RMenu.Add("mechanic3", "mecano_menu_props_gest", RageUI.CreateSubMenu(RMenu:Get("mechanic3", "mecano_menu_props"), "LS Custom", "~b~Menu job :"))
RMenu:Get("mechanic3", "mecano_menu_props_gest").Closed = function()end

RMenu.Add("mechanic3", "craft_main_chargement", RageUI.CreateSubMenu(RMenu:Get("mechanic3", "craft_main"), "LS Custom", "~b~Menu job :"))
RMenu:Get("mechanic3", "craft_main_chargement").Closed = function()end

RegisterNetEvent("elderslife:onCleankit")
AddEventHandler("elderslife:onCleankit", function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local posVeh = GetEntityCoords(vehicle)
    local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(posVeh.x, posVeh.y, posVeh.z), true)
    if dist < 2.0 then
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
        Citizen.CreateThread(function()
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(PlayerPedId())
            ShowNotification("Le v??hicule a ??t?? ~g~nettoy??~s~ !")
        end)    
    else
        ShowNotification("~r~Aucun v??hicule ?? proximit?? !")
        TriggerServerEvent("elderslife:ReturnKitnet")
    end
end)

local function openMagasinMechanic3()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mechanic3", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("mechanic3", "Magasin"),true,true,true,function()
                RageUI.Separator('??? Outil ???')
                    for k, v in pairs(Configmechanic3.outil) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end
                RageUI.Separator('??? Moteur ???')
                    for k, v in pairs(Configmechanic3.moteur) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end 
                RageUI.Separator('??? Boite ???')
                    for k, v in pairs(Configmechanic3.boite) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end   
                RageUI.Separator('??? Pneu ???')
                    for k, v in pairs(Configmechanic3.pneu) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end 
                RageUI.Separator('??? Suspension ???')
                    for k, v in pairs(Configmechanic3.suspension) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end  
                RageUI.Separator('??? Bougie ???')
                    for k, v in pairs(Configmechanic3.bougie) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end 
                RageUI.Separator('??? Huile ???')
                    for k, v in pairs(Configmechanic3.huile) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end  
                RageUI.Separator('??? Frein ???')
                    for k, v in pairs(Configmechanic3.frein) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end 
                RageUI.Separator('??? Turbo ???')
                    for k, v in pairs(Configmechanic3.turbo) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end
                RageUI.Separator('??? Piece ???')
                    for k, v in pairs(Configmechanic3.piece) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_mechanic3', v.value, v.price , amount)                            
                            end
                        end)                        
                    end       
            end, function()end, 1)

            Wait(0)
        end
    end)
end

local function openMenumechanic3Fabrication()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mechanic3", "craft_main"), true)
        getAllItems()
        Citizen.CreateThread(function()
            while isMenuOpened do
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.IsVisible(RMenu:Get('mechanic3', "craft_main"), true, true, true, function()
                    RageUI.List("Type :", {"Kits de r??paration", "Outils de nettoyages"}, CraftIndex, nil, {},true,  function(_,_,s,Index)
                        CraftIndex = Index
                    end)
                    RageUI.List("Quantit?? :", quantity, qIndex, nil, {}, true, function(_,_,s,Index)
                        qIndex = Index
                    end)
                    if CraftIndex == 1 then
                        RageUI.Separator("??? ~b~Requirements ~s~???")
                        for i = 1, #MyInv, 1 do
                            for k,v in pairs(AllItems[1]) do
                                if MyInv[i].name == v then
                                    if MyInv[i].count < qIndex*5 then Color = "~r~" else Color = "~b~" end
                                    RageUI.Separator(MyInv[i].label.." : "..Color..MyInv[i].count.."~s~/"..qIndex*5)
                                end
                            end
                        end
                        if not hasitems then
                            RageUI.Separator("~r~Vous ne pouvez pas ~s~fabriquer ce mat??riel")
                            RageUI.ButtonWithStyle("Fabriquer les kits de r??paration",nil, {RightLabel = "??????"}, false, function(_,_,s)
                            end)
                        else
                            if qIndex*5 <= hasitemqty[1] and qIndex*5 <= hasitemqty[2] and qIndex*5 <= hasitemqty[3] then
                                RageUI.Separator("Quantit?? de fabrication : ~b~"..qIndex.."~s~ - Kits")
                            else
                                RageUI.Separator("Quantit?? de fabrication : ~r~"..qIndex.."~s~ - Kits")
                            end
                            RageUI.ButtonWithStyle("Fabriquer les kits de r??paration", nil, {RightLabel = "??????"}, qIndex*5 <= hasitemqty[1] and qIndex*5 <= hasitemqty[2] and qIndex*5 <= hasitemqty[3], function(_,_,s)
                                if s then
                                    TypeSell = true
                                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                end
                            end, RMenu:Get("mechanic3", "craft_main_chargement"))
                        end
                    elseif CraftIndex == 2 then
                        RageUI.Separator("??? ~b~Requirements ~s~???")
                        for i = 1, #MyInv, 1 do
                            for k,v in pairs(AllItems[2]) do
                                if MyInv[i].name == v then
                                    if MyInv[i].count < qIndex*5 then Color = "~r~" else Color = "~b~" end
                                    RageUI.Separator(MyInv[i].label.." : "..Color..MyInv[i].count.."~s~/"..qIndex*5)
                                end
                            end
                        end
                        if not hasitemstwo then
                            RageUI.Separator("~r~Vous ne pouvez pas ~s~fabriquer ce mat??riel")
                            RageUI.ButtonWithStyle("Fabriquer les outils de nettoyages",nil, {RightLabel = "??????"}, false, function(_,_,s)
                            end)
                        else
                            if qIndex*5 <= hasitemqtytwo[1] and qIndex*5 <= hasitemqtytwo[2] and qIndex*5 <= hasitemqtytwo[3] then
                                RageUI.Separator("Quantit?? de fabrication : ~b~"..qIndex.."~s~ - Outils")
                            else
                                RageUI.Separator("Quantit?? de fabrication : ~r~"..qIndex.."~s~ - Outils")
                            end
                            RageUI.ButtonWithStyle("Fabriquer les outils de nettoyages",nil, {RightLabel = "??????"}, qIndex*5 <= hasitemqtytwo[1] and qIndex*5 <= hasitemqtytwo[2] and qIndex*5 <= hasitemqtytwo[3], function(_,_,s)
                                if s then
                                    TypeSell = false
                                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                end
                            end, RMenu:Get("mechanic3", "craft_main_chargement"))
                        end  
                    end                  
                end)
                RageUI.IsVisible(RMenu:Get("mechanic3", "craft_main_chargement"), true, true, true, function()
                    if TypeSell then label = "Kits de r??paration" else label = "Outils de nettoyages" end
                    RageUI.Separator("Type de fabrication : ~b~"..label)
                    RageUI.Separator("Quantit?? : ~b~"..qIndex)
                    RageUI.PercentagePanel(Load or 0.0, "Fabrication en cours (~b~" .. math.floor(Load*100) .. "%~s~)", "", "", function(_, a, Percent)
                        if Load < 1.0 then
                            Load = Load+0.0006
                        else
                            RageUI.GoBack()
                            ClearPedTasksImmediately(PlayerPedId())
                            Load = 0.0
                            if TypeSell then
                                TriggerServerEvent("elderslife:SellAllsMateriaux", AllItems[1], "repairkit", qIndex)
                            else
                                TriggerServerEvent("elderslife:SellAllsMateriaux", AllItems[2], "kitnet", qIndex)
                            end
                            getAllItems()
                        end
                    end)
                end)
            Wait(0)
            end
            
        end)    
end

local function GetZoneFarmedMecano(type, zone)
    InZoneFarm = true
    while InZoneFarm do
        Citizen.Wait(0)
        for k,v in pairs(Configmechanic3[type][zone].MarkerPos) do
            local dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos, true)
            if dst < 20.0 then
                if not v.InDrawking then
                    if not PlyIsInAction and dst < 10.0 then
                        ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', "Vous ??tes arriv?? dans la zone, vous pouvez d??sormais commencer votre r??colte de ~b~mat??riaux", 'CHAR_ELDERS', 10)
                    end
                    ShowNotification("Nombre de points trait??s :\n~b~ - "..NumberRecup.."~s~/"..#Configmechanic3[type][zone].MarkerPos)
                    DrawMarker(22, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, 1, 1, 2, 0, nil, nil, 0)
                    if dst < 1.5 then
                        if not PlyIsInAction then
                            HelpNotif(v.notif)
                            if IsControlJustPressed(0, 38) then
                                InPlyZone = true
                                PlyIsInAction = true
                                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                Citizen.Wait(15000)
                                local number = math.random(7, 12)
                                ClearPedTasksImmediately(PlayerPedId())
                                v.InDrawking = true
                                PlyIsInAction = false
                                totalcount = totalcount+1
                                NumberRecup = NumberRecup+1
                                TriggerServerEvent("elderslife:AddPlyInvFarm", v.item, number)
                            end
                        end
                    end
                end
            end
            if InPlyZone then
                if dst > 60.0 then
                    for _,del in pairs(Configmechanic3[type][zone].MarkerPos) do
                        del.InDrawking = false
                    end
                    totalcount = 0
                    PlyIsInAction = false
                    InPlyZone = false
                    for _,blips in pairs(BlipsFarmMecano) do
                        RemoveBlip(blips)
                        BlipsFarmMecano = {}
                        NumberRecup = 0
                        ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', "~r~Vous avez quitt?? la zone.~s~ Mission termin??e !", 'CHAR_ELDERS', 10)
                    end
                    InZoneFarm = false
                end
                if totalcount == #Configmechanic3[type][zone].MarkerPos then
                    for _,del in pairs(Configmechanic3[type][zone].MarkerPos) do
                        del.InDrawking = false
                    end                    
                    totalcount = 0
                    PlyIsInAction = false
                    InPlyZone = false
                    for _,blips in pairs(BlipsFarmMecano) do
                        RemoveBlip(blips)
                        BlipsFarmMecano = {}
                        NumberRecup = 0
                        ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', "~g~Mission termin??e !~s~ Vous avez ramasser tout les mat??riaux !", 'CHAR_ELDERS', 10)
                    end
                    InZoneFarm = false
                end
            end
        end
    end
end
local function openMenumechanic3Kit()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mechanic3", "mecano_farm_menu"), true)

        Citizen.CreateThread(function()
            while isMenuOpened do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(RMenu:Get("mechanic3",'mecano_farm_menu'),true,true,true,function()
                    RageUI.List("Type :", {"Kits de r??paration", "Outils de nettoyages"}, FarmIndex, nil, {}, true, function(_,_,s, Index)
                        FarmIndex = Index
                    end)
                    if FarmIndex == 1 then
                        RageUI.ButtonWithStyle("R??cup??rer des Kits de r??paration", nil, {RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                InPlyZone = false
                                BlipsFarmMecano = {}
                                local i = math.random(1, #Configmechanic3["Kit"].RandomPos)
                                local RandomZone = Configmechanic3["Kit"].RandomPos[i]
                                Blips = AddBlipForCoord(RandomZone.pos)
                                SetBlipScale(Blips, 0.6)
                                SetBlipSprite(Blips, 501)
                                SetBlipColour(Blips, 3)
                                SetBlipRoute(Blips, true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString("Mecano | R??cup??ration kits de r??paration")
                                EndTextCommandSetBlipName(Blips)
                                table.insert(BlipsFarmMecano, Blips)
                                ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', "~b~Vous pouvez d??sormais vous diriger sur place ~s~! Le GPS a ??t?? mis sur votre carte.", 'CHAR_ELDERS', 10)
                                RageUI.CloseAll()
                                isMenuOpened = false
                                GetZoneFarmedMecano("Kit", RandomZone.marker)
                            end
                        end)
                    elseif FarmIndex == 2 then
                        RageUI.ButtonWithStyle("R??cup??rer des Outils de nettoyages", nil, {RightLabel = "??????" }, true, function(_,_,s)
                            if s then
                                InPlyZone = false
                                BlipsFarmMecano = {}
                                local i = math.random(1, #Configmechanic3["Outils"].RandomPos)
                                local RandomZone = Configmechanic3["Outils"].RandomPos[i]
                                Blips = AddBlipForCoord(RandomZone.pos)
                                SetBlipScale(Blips, 0.6)
                                SetBlipSprite(Blips, 501)
                                SetBlipColour(Blips, 3)
                                SetBlipRoute(Blips, true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString("Mecano | R??cup??ration outils de nettoyages")
                                EndTextCommandSetBlipName(Blips)
                                table.insert(BlipsFarmMecano, Blips)
                                ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', '~b~Vous pouvez d??sormais vous diriger sur place ~s~! Le GPS a ??t?? mis sur votre carte.', 'CHAR_ELDERS', 10)
                                RageUI.CloseAll()
                                isMenuOpened = false
                                GetZoneFarmedMecano("Outils", RandomZone.marker)
                            end
                        end)
                    end
                end)
                Wait(0)
            end
    end)
end

local function openMenumechanic3F6()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mechanic3", "princ"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("mechanic3", "princ"),true,true,true,function() 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    mechanic3interact = true else mechanic3interact = false
                end 
                RageUI.ButtonWithStyle("Obtenir le magasin pi??ces", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                    if s then                        
                        SetNewWaypoint(-677.139, -2459.324, 13.944)  
                        ESX.ShowNotification("Regarde sur la carte, je te l'ai indiqu??.")
                    end
                end)
                RageUI.Separator('~y~??? Annonces ???')
                RageUI.ButtonWithStyle("Annonce Personnalis??", nil, {RightLabel = "?????????"}, not cooldown,function(a,h,s)
                    if s then
                        local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                        if msg and msg ~= "" then
                            TriggerServerEvent('Perso:mechanic3',msg)                            
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Annonce Ouvertures", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ouvre:mechanic3')
                                    end
                end)     
                RageUI.ButtonWithStyle("Annonce Fermetures", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Ferme:mechanic3')
                                    end
                end)  
                RageUI.ButtonWithStyle("Annonce Recrutement", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                                    if s then
                                        TriggerServerEvent('Recru:mechanic3')
                                    end
                end)                       
                RageUI.Separator('??? ~y~Int??raction(s) ~s~???')
                RageUI.ButtonWithStyle("??mettre une facture ?? la personne", nil, {RightLabel = "?????????"}, mechanic3interact,function(a,h,s)
                    if h then
                        MarquerJoueur()
                        if s then
                            local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                            amount = tonumber(amount)
                            if amount ~= nil then
                                ESX.ShowNotification("Vous avez bien envoy?? la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic3', 'LS Custom', amount)
                            else
                                ESX.ShowNotification("Montant Invalide", 'Probl??me')
                            end
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Crocheter le v??hicule", nil, {RightLabel = "??????"}, true, function(_,a,s)
                            if a then 
                                GetCloseVehi()
                            end
                            if s then
                                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                    ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Vous ne pouvez pas crocheter ?? l\'int??rieur d\'un v??hicule !', 'CHAR_ELDERS', 10)
                                    return
                                end
                                if DoesEntityExist(ESX.Game.GetVehicleInDirection()) then
                                    ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            if GetVehicleDoorLockStatus(ESX.Game.GetVehicleInDirection()) == 2 then
                                                TriggerServerEvent('elderslife:removeInvItems',"kitcroche",1)
                                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                                ShowLoadingMessage("Crochetage du v??hicule...", 1, 10000)
                                                Citizen.Wait(10000)
                                                ClearPedTasksImmediately(PlayerPedId())
                                                SetVehicleDoorsLocked(ESX.Game.GetVehicleInDirection(), 0)
                                                SetVehicleDoorsLockedForAllPlayers(ESX.Game.GetVehicleInDirection(), false)
                                                ClearPedTasksImmediately(PlayerPedId())
                                                ESX.ShowAdvancedNotification('LS Custom', '~b~Information(s)', 'Le v??hicule ?? ??t?? crocheter !', 'CHAR_ELDERS', 10)
                                                RageUI.CloseAll()
                                                isMenuOpened= false
                                            else
                                                ESX.ShowAdvancedNotification("LS Custom", "~b~Information(s)", "Le v??hicule n'est pas ferm?? ou un sabot est pos?? !", "CHAR_ELDERS", 1)
                                            end
                                        else
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', '~r~Vous n\'avez pas de kit de crochetage sur vous !', 'CHAR_ELDERS', 10)
                                            InRepair = false
                                        end
                                    end, "kitcroche")
                                else
                                    ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Aucun v??hicule ?? proximit?? !', 'CHAR_ELDERS', 10)
                                end
                            end                            
                end)
                RageUI.ButtonWithStyle("R??parer le moteur du v??hicule", nil, {RightLabel = "??????"}, true, function(_,a,s)
                            if a then 
                                GetCloseVehi()
                            end
                            if s then
                                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                    ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Vous ne pouvez pas r??parer ?? l\'int??rieur d\'un v??hicule !', 'CHAR_ELDERS', 10)
                                    return
                                end
                                   ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            TriggerServerEvent("elderslife:removeInvItems", "repairkit", 1)
                                            veh = ESX.Game.GetClosestVehicle()
                                            RageUI.CloseAll()
                                            isMenuOpened= false
                                            InRepair = true
                                            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                            Citizen.Wait(10000)
                                            --SetVehicleFixed(veh)
                                            --SetVehicleDeformationFixed(veh)
                                            SetVehicleEngineHealth(veh, 1000.0)
                                            SetVehicleUndriveable(veh, false)
                                            ClearPedTasksImmediately(PlayerPedId())
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Le v??hicule a ??t?? ~b~r??par??~s~ !', 'CHAR_ELDERS', 10)
                                            InRepair = false
                                        else
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', '~r~Vous n\'avez pas de kit de r??paration sur vous !', 'CHAR_ELDERS', 10)
                                            InRepair = false
                                        end
                                    end, "repairkit")
                            end                            
                end)
                RageUI.ButtonWithStyle("R??parer la carosserie du v??hicule", nil, {RightLabel = "??????"}, true, function(_,a,s)
                            if a then 
                                GetCloseVehi()
                            end
                            if s then
                                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                    ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Vous ne pouvez pas r??parer ?? l\'int??rieur d\'un v??hicule !', 'CHAR_ELDERS', 10)
                                    return
                                end
                                   ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            TriggerServerEvent("elderslife:removeInvItems", "repairkit", 1)
                                            veh = ESX.Game.GetClosestVehicle()
                                            RageUI.CloseAll()
                                            isMenuOpened= false
                                            InRepair = true
                                            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                            Citizen.Wait(10000)
                                            SetVehicleFixed(veh)
                                            SetVehicleDeformationFixed(veh)
                                            ClearPedTasksImmediately(PlayerPedId())
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Le v??hicule a ??t?? ~b~r??par??~s~ !', 'CHAR_ELDERS', 10)
                                            InRepair = false
                                        else
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', '~r~Vous n\'avez pas de kit de r??paration sur vous !', 'CHAR_ELDERS', 10)
                                            InRepair = false
                                        end
                                    end, "repairkit")
                            end                            
                end)
                RageUI.ButtonWithStyle("N??ttoyer le v??hicule", nil, {RightLabel = "??????"}, true, function(_,a,s)
                            if a then 
                                GetCloseVehi()
                            end
                            if s then
                                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                    ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Vous ne pouvez pas nettoyer ?? l\'int??rieur d\'un v??hicule !', 'CHAR_ELDERS', 10)
                                    return
                                end
                                   ESX.TriggerServerCallback("elderslife:getInvPlyItems", function(count)
                                        if count > 0 then
                                            veh = ESX.Game.GetClosestVehicle()
                                            RageUI.CloseAll()
                                            isMenuOpened= false
                                            InNettoyage = true
                                            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
                                            Citizen.CreateThread(function()
                                                TriggerServerEvent("elderslife:removeInvItems", "kitnet", 1)
                                                Citizen.Wait(10000)
                                                SetVehicleDirtLevel(veh, 0)
                                                ClearPedTasksImmediately(PlayerPedId())
                                                ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', 'Le v??hicule a ??t?? ~g~nettoy??~s~ !', 'CHAR_ELDERS', 10)
                                                InNettoyage = false                                                
                                            end)
                                        else
                                            ESX.ShowAdvancedNotification('LS Custom', 'Information(s)', '~r~Vous n\'avez pas de kit de n??ttoyage sur vous !', 'CHAR_ELDERS', 10)
                                            InNettoyage = false
                                        end
                                    end, "kitnet")
                            end                            
                end)
                RageUI.Separator("??? ~y~Autre(s) ~s~???")
                RageUI.ButtonWithStyle("Menu objet(s)", nil, {RightLabel = "??????"}, true, function(_,_,s)
                end, RMenu:Get("mechanic3", "mecano_menu_props"))
            end, function()end, 1)
               RageUI.IsVisible(RMenu:Get("mechanic3",'mecano_menu_props'),true,true,true,function()
                    RageUI.ButtonWithStyle("Menu objet(s)", nil, {RightLabel = "??????"}, true, function(_,_,s)
                        if s then
                            mechanic3Props = {}
                            ESX.TriggerServerCallback('elderslife:getProps', function(props)
                                mechanic3Props = props
                            end)
                        end
                    end, RMenu:Get("mechanic3", "mecano_menu_props_gest"))
                    for _,v in pairs(Configmechanic3.Props) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "??????"}, not v.Cooldown_object , function(_,_,s)
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
                RageUI.IsVisible(RMenu:Get("mechanic3",'mecano_menu_props_gest'),true,true,true,function()
                    if #mechanic3Props == 0 then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucun objet(s) n'a ??t?? pos?? !")
                        RageUI.Separator("")
                    end
                    for k,v in pairs(mechanic3Props) do
                        RageUI.ButtonWithStyle("[~b~"..k.."~s~] - ".."Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))), nil, {RightLabel =  "~r~Ranger ~s~??????"}, GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(NetworkGetEntityFromNetworkId(v)), true) < 3.0, function(_, a, s)
                            if a then
                                local entity = NetworkGetEntityFromNetworkId(v)
                                local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(22, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if s then
                                RemoveObj(v, k)
                                TriggerServerEvent("elderslife:refreshProps", k)
                                mechanic3Props = {}
                                ESX.TriggerServerCallback('elderslife:getProps', function(props)
                                    mechanic3Props = props
                                end)
                            end
                        end)
                    end
                end)
            Wait(0)
        end
    end)
end

local function openMenumechanic3Vestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("mechanic3", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("mechanic3", "vestiaire"),true,true,true,function()
                RageUI.Separator('??? Garde robe ???')
                RageUI.ButtonWithStyle("Tenue de Travail", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                    if s then   
                            TriggerEvent('skinchanger:getSkin', function(skin)  
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, Configmechanic3.uniform.male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, Configmechanic3.uniform.female)
                                end
                            end)
                    end
                end)  
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("mechanic3", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "?????????"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("mechanic3", "deletetenue"))
                RageUI.Separator('??? Tenues ???')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("mechanic3", "changetenue"),true,true,true,function()
                RageUI.Separator('??? Mes tenues ???')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "?????????"}, true,function(a,h,s)
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
            RageUI.IsVisible(RMenu:Get("mechanic3", "deletetenue"),true,true,true,function()
                RageUI.Separator('??? Supprimer une tenue ???')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "?????????"}, true,function(a,h,s)
                            if s then
                                TriggerServerEvent('god_eden_clotheshop:removeOutfit', v.value)
                                ESX.ShowNotification("Vous venez de supprimer la tenue "..v.label.."~s~ !", 'Dressing')

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

Citizen.CreateThread(function()
    while true do
        interval = 750
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "mechanic3" then
                local playerPos = GetEntityCoords(PlayerPedId(), false)
                local pos = Configmechanic3.points.vestiaire
                local distancePlayerMagasin = #(playerPos - pos)
                if distancePlayerMagasin < 15 then
                    interval = 0
                    DrawMarker(22,  Configmechanic3.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerMagasin <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au Magasin")
                        if IsControlJustPressed(1,51) then
                            openMenumechanic3Vestiaire()
                        end
                    end
                end
                local pos1 = Configmechanic3.points.craft
                local distancePlayerCraft = #(playerPos - pos1)
                if distancePlayerCraft < 15 then
                    interval = 0
                    DrawMarker(22,  Configmechanic3.points.craft, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerCraft <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au farm")
                        if IsControlJustPressed(1,51) then
                            openMenumechanic3Kit()
                        end
                    end
                end
                local pos2 = Configmechanic3.points.craft1
                local distancePlayerCraft1 = #(playerPos - pos2)
                if distancePlayerCraft1 < 15 then
                    interval = 0
                    DrawMarker(22,  Configmechanic3.points.craft1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    if distancePlayerCraft1 <= 1.2 and not isMenuOpened then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der a la fabrication")
                        if IsControlJustPressed(1,51) then
                            openMenumechanic3Fabrication()
                        end
                    end
                end
                local pos3 = Configmechanic3.points.shop
                local distancePlayerShop = #(playerPos - pos3)
                if distancePlayerShop < 15 then
                    if ESX.PlayerData.job.grade >= 3 then
                        interval = 0
                        DrawMarker(22,  Configmechanic3.points.shop, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                        if distancePlayerShop <= 1.2 and not isMenuOpened then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acc??der au shop")
                            if IsControlJustPressed(1,51) then
                                openMagasinMechanic3()
                            end
                        end
                    end
                end
            end
        Citizen.Wait(interval)
    end
end)

RegisterCommand('mechanic3', function()
    if ESX.PlayerData.job.name == "mechanic3" then
        openMenumechanic3F6()
    end
end)

RegisterKeyMapping('mechanic3', 'Menu Job : LS Custom', 'keyboard', 'F6')


