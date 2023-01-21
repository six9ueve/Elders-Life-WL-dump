ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
    ESX.PlayerData = ESX.GetPlayerData()
end

local ClothesIndex = 1
local ClothesIndexCam = 1
local DressingIndex = 1
local GetPlyDressing = {}
local i = {}
local comp = {}
ConfigClothesShop = {
    {pos = vector3(72.254, -1399.102, 28.376)},
    {pos = vector3(-703.776, -152.258, 36.415)},
    {pos = vector3(-167.863, -298.969, 38.733)},
    {pos = vector3(428.694, -800.106, 28.491)},
    {pos = vector3(-829.413, -1073.710, 10.328)},
    {pos = vector3(-1447.797, -242.461, 48.820)},
    {pos = vector3(11.632, 6514.224, 30.877)},
    {pos = vector3(123.646, -219.440, 53.557)},
    {pos = vector3(1696.291, 4829.312, 41.063)},
    {pos = vector3(618.093, 2759.629, 41.088)},
    {pos = vector3(1190.550, 2713.441, 37.222)},
    {pos = vector3(-1193.429, -772.262, 16.324)},
    {pos = vector3(-3172.496, 1048.133, 19.863)},
    {pos = vector3(-1108.441, 2708.923, 18.107)},
    {pos = vector3(-556.425,-120.503,41.254)},
    {pos = vector3(1849.641, 3695.34, 33.27)},--sheriff sandy
    {pos = vector3(1776.89,2548.33,44.79)},
}

ShowHelpNotification = function(text)
    AddTextEntry("HelpNotification", text)
    DisplayHelpTextThisFrame("HelpNotification", false)
end

RMenu.Add('clothes_menu', 'clothes_menu_main', RageUI.CreateMenu("Vêtement", "INTÉRACTIONS", nil, nil, "aLib", "black"))
RMenu.Add('clothes_menu', "clothes_menu_list", RageUI.CreateSubMenu(RMenu:Get('clothes_menu', 'clothes_menu_main'), "Vêtement", "INTÉRACTIONS"))
RMenu.Add('clothes_menu', "clothes_saved", RageUI.CreateSubMenu(RMenu:Get('clothes_menu', 'clothes_menu_main'), "Vêtement", "INTÉRACTIONS"))
RMenu:Get('clothes_menu', 'clothes_menu_main').Closed = function()
    FinCreator()
    RenderScriptCams(0, 1, 1000, 1, 1)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DestroyAllCams(true)  
    TriggerEvent('skinchanger:loadSkin', LastSkin)     
    ClothesMenu = false
end
RMenu:Get('clothes_menu', 'clothes_menu_list').Closed = function()
    TriggerEvent('skinchanger:loadSkin', LastSkin)
end

function refreshIndex()
    comp = {}
    restrict = {
            'tshirt_1',
            'tshirt_2',
            'torso_1',
            'torso_2',          
            'decals_1',
            'decals_2',
            'pants_1',
            'pants_2',          
            'shoes_1',
            'shoes_2',
            'chain_1',
            'chain_2',
            'arms',
            'bproof_1',
            'bproof_2',
            'watches_1',
            'watches_2',
            'bracelets_1',
            'bracelets_2',
    }
    TriggerEvent("skinchanger:getData", function(comp_, max)
        for i=1, #comp_, 1 do
            local found = false
            for j=1, #restrict, 1 do
                if comp_[i].name == restrict[j] then
                    found = true
                end
            end
            if found then
                table.insert(comp, comp_[i])
            end
        end
        for k,v in pairs(comp) do
            if v.value ~= 0 then
                i[v.name] = v.value+1
            else
                i[v.name] = 1
            end
            for i,value in pairs(max) do
                if i == v.name then
                    comp[k].max = value
                    comp[k].table = {}
                    for i = 0, value do
                        table.insert(comp[k].table, i)
                    end
                    break
                end
            end
        end
    end)
end

function SavePersoClohtes()
    ESX.TriggerServerCallback('elders_clothes:CheckClothesMoney', function(good)
        if good then
            TriggerEvent("skinchanger:getSkin", function(skin)
                TriggerServerEvent("god_skin:save", skin)
                LastSkin = skin
            end)
            ESX.ShowNotification("Achat de vêtement :\nArticle : ~b~Vêtement(s)~s~\nPrix : ~g~150$")
            SetPedArmour(GetPlayerPed(-1), 0)
            RenderScriptCams(0, 1, 1000, 1, 1)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            DestroyAllCams(true)  
            
            
            ClothesMenu = false
            RageUI.CloseAll()
            Wait(200)
            FinCreator()
        else
            TriggerEvent("skinchanger:loadSkin", LastSkin)
            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent sur vous !")
        end
    end, 150) 
end

function OpenClothesMenu()
    TriggerEvent('skinchanger:getSkin', function(skin)
        LastSkin = skin
    end)
    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', LastSkin)
    end)
    
    local coords = GetEntityCoords(GetPlayerPed(-1))
    SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1))/coords.x+100)
    if not ClothesMenu then
        ClothesMenu = true
        RageUI.Visible(RMenu:Get('clothes_menu', 'clothes_menu_main'), true)
        Citizen.CreateThread(function()
            while ClothesMenu do
                FreezeEntityPosition(GetPlayerPed(-1), true)
                Citizen.Wait(1)
                    for i=1,256 do
                        if NetworkIsPlayerActive(i) then
                            SetEntityVisible(GetPlayerPed(i), false, false)
                            SetEntityVisible(GetPlayerPed(-1), true, true)
                            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
                        end
                    end
                    ClothesSkinRota()
                    RageUI.IsVisible(RMenu:Get("clothes_menu",'clothes_menu_main'),true,true,true,function()
                        CreateClothesCam()
                        RageUI.ButtonWithStyle("Liste des tenues enregistrée(s)", nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                GetPlyDressing = {}
                                ESX.TriggerServerCallback('elders_clothes:GetPlyDressing', function(mydressing)
                                    GetPlyDressing = mydressing
                                end)
                            end
                        end, RMenu:Get("clothes_menu", "clothes_saved"))
                        RageUI.ButtonWithStyle("Enregistrer une tenue", nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                local donator = ESX.PlayerData.donator
                                local MaximumTenue = 10
                                ESX.TriggerServerCallback('EldersLife:CountTenue', function(dressing)
                                    if (donator == 1) then 
                                         MaximumTenue = 15
                                    
                                    elseif (donator == 2) then 
                                         MaximumTenue = 20
                                    
                                    elseif (donator == 3) then  
                                         MaximumTenue = 40
                                    end
                                    if dressing < MaximumTenue then
                                        OuftfitName = KeyboardInput("atmos", "Nom de votre tenue :", "", 10)
                                            if OuftfitName == nil or OuftfitName == "" or OuftfitName == " " then 
                                                ESX.ShowNotification("~r~Veuillez saisir un nom valide !")
                                            else
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    TriggerServerEvent("elders_clothes:SaveOutfit", OuftfitName, skin)
                                                end) 
                                                ESX.ShowNotification("Vous avez enregistré une nouvelle tenue sous le nom : ~b~"..OuftfitName)
                                                RageUI.CloseAll()
                                                ClothesMenu = false
                                        end
                                    else
                                        ESX.ShowNotification('Vous avez déja trop de tenues enregistrées.')
                                    end
                                end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Faire une tenue", nil, {RightLabel = "→→"}, true, function(_,_,s)
                            if s then
                                comp = {}
                                restrict = {
                                    'tshirt_1',
                                    'tshirt_2',
                                    'torso_1',
                                    'torso_2',          
                                    'decals_1',
                                    'decals_2',
                                    'pants_1',
                                    'pants_2',          
                                    'shoes_1',
                                    'shoes_2',
                                    'chain_1',
                                    'chain_2',
                                    'arms',
                                    'bproof_1',
                                    'bproof_2',
                                    'watches_1',
                                    'watches_2',
                                    'bracelets_1',
                                    'bracelets_2'
                                }
                                TriggerEvent("skinchanger:getData", function(comp_, max)
                                    for i=1, #comp_, 1 do
                                        local found = false
                                        for j=1, #restrict, 1 do
                                            if comp_[i].name == restrict[j] then
                                                found = true
                                            end
                                        end
                                        if found then
                                            table.insert(comp, comp_[i])
                                        end
                                    end
                                    for k,v in pairs(comp) do
                                        if v.value ~= 0 then
                                            i[v.name] = v.value+1
                                        else
                                            i[v.name] = 1
                                        end
                                        for i,value in pairs(max) do
                                            if i == v.name then
                                                comp[k].max = value
                                                comp[k].table = {}
                                                for i = 0, value do
                                                    table.insert(comp[k].table, i)
                                                end
                                                break
                                            end
                                        end
                                    end
                                end)
                            end
                        end, RMenu:Get("clothes_menu", "clothes_menu_list"))
                    end)
                    RageUI.IsVisible(RMenu:Get("clothes_menu",'clothes_saved'),true,true,true,function()
                        CreateClothesCam()
                        local donator = ESX.PlayerData.donator
                        local found = 0
                        for k,v in pairs(GetPlyDressing) do
                            found = found+1
                        end
                        if found > 0 then
                            RageUI.Separator('↓ ~b~Liste des tenue(s)~s~ ↓')
                            RageUI.Separator("[~b~"..#GetPlyDressing.."~s~] -  Tenue(s) dans votre dressing")
                        else
                            RageUI.Separator("")
                            RageUI.Separator("~r~Vous n'avez pas de tenue dans le dressing !")
                            RageUI.Separator("")
                        end
                        if donator > 0 then
                                for k,v in pairs(GetPlyDressing) do
                                    RageUI.List("[~b~"..k.."~s~] - Tenue : "..v, {"Mettre", "Effacer"}, DressingIndex, nil, {}, true, function(_,_,s,Index)
                                        DressingIndex = Index
                                        if s then
                                            if Index == 1 then
                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                    ESX.TriggerServerCallback('elders_clothes:GetPlyOutfit', function(clothes)
                                                        TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                                        TriggerEvent('god_skin:setLastSkin', skin)
                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                            TriggerServerEvent('god_skin:save', skin)
                                                            LastSkin = skin
                                                        end)
                                                    end, k)                                                    
                                                end)
                                                ESX.ShowNotification("Vous avez mis votre tenue : ~b~"..v)
                                                SetPedArmour(GetPlayerPed(-1), 0)
                                            elseif Index == 2 then
                                                TriggerServerEvent('elders_clothes:DeleteOutfit', k)
                                                GetPlyDressing = {}
                                                ESX.TriggerServerCallback('elders_clothes:GetPlyDressing', function(mydressing)
                                                    GetPlyDressing = mydressing
                                                end)
                                               ESX.ShowNotification("Vous avez effacer la tenue : ~b~"..v)
                                            end
                                        end
                                    end)
                                end
                        else
                            for k,v in pairs(GetPlyDressing) do
                                RageUI.List("[~b~"..k.."~s~] - Tenue : "..v, {"Mettre", "Effacer"}, DressingIndex, nil, {}, true, function(_,_,s,Index)
                                    DressingIndex = Index
                                    if s then
                                        if Index == 1 then
                                            TriggerEvent('skinchanger:getSkin', function(skin)
                                                ESX.TriggerServerCallback('elders_clothes:GetPlyOutfit', function(clothes)
                                                    TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                                    TriggerEvent('god_skin:setLastSkin', skin)
                                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                                        TriggerServerEvent('god_skin:save', skin)
                                                        LastSkin = skin
                                                    end)
                                                end, k)
                                            end)
                                            ESX.ShowNotification("Vous avez mis votre tenue : ~b~"..v)
                                            SetPedArmour(GetPlayerPed(-1), 0)
                                        elseif Index == 2 then
                                            TriggerServerEvent('elders_clothes:DeleteOutfit', k)
                                            GetPlyDressing = {}
                                            ESX.TriggerServerCallback('elders_clothes:GetPlyDressing', function(mydressing)
                                                GetPlyDressing = mydressing
                                            end)
                                           ESX.ShowNotification("Vous avez effacer la tenue : ~b~"..v)
                                        end
                                    end
                                end)
                            end
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("clothes_menu",'clothes_menu_list'),true,true,true,function()
                        RageUI.List("Type de caméra", {"Proche", "Normal", "Éloignez", "Visages", "Haut", "Bas", "Chaussure"}, ClothesIndexCam, nil, {}, true, function(_,a,s,Index)
                            ClothesIndexCam = Index
                        end)
                        if ClothesIndexCam == 1 then
                            DestroyAllCams(true)
                            CreateClothesCamProche()
                        elseif ClothesIndexCam == 2 then
                            DestroyAllCams(true)
                            CreateClothesCamNormal()
                        elseif ClothesIndexCam == 3 then
                            DestroyAllCams(true)
                            CreateClothesCamEloignez()
                        elseif ClothesIndexCam == 4 then
                            DestroyAllCams(true)
                            CreateClothesFaceCam()
                        elseif ClothesIndexCam == 5 then
                            DestroyAllCams(true)
                            CreateClothesBasiqueCam()
                        elseif ClothesIndexCam == 6 then
                            DestroyAllCams(true)
                            CreateClothesPantsCam()
                        elseif ClothesIndexCam == 7 then
                            DestroyAllCams(true)
                            CreateClothesShoesCam()
                        end
                        for k,v in pairs(comp) do
                            if v.table[1] ~= nil then
                              RageUI.List(v.label, v.table, i[v.name], nil, {}, true, function(_,_,s,Index)
                                if s then
                                    SavePersoClohtes()
                                end
                                end, function(Index)
                                    if Index ~= nil then
                                        refreshIndex()
                                        i[v.name] = Index
                                        TriggerEvent("skinchanger:change", v.name, Index - 1)
                                    end
                                end)
                            end
                        end
                    end)
                end
            end)
        end
    end
end)

-- Create Blips
Citizen.CreateThread(function()
    for k,v in ipairs(ConfigClothesShop) do
        local blip = AddBlipForCoord(v.pos)

        SetBlipSprite (blip, 73)
        SetBlipScale (blip, 0.6)
        SetBlipColour (blip, 47)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('[ETAT] | Magasin de vetement')
        EndTextCommandSetBlipName(blip)
    end
end)


Citizen.CreateThread(function()
    while true do
                local OthersWait = 500
                    for _,v in pairs(ConfigClothesShop) do
                        local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos, true)
                        if dist < 10 then 
                            OthersWait = 1
                                DrawMarker(22, v.pos.x, v.pos.y, v.pos.z+0.8, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                            if dist < 1.5 then
                                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ accéder au magasin de vêtements")
                                if IsControlJustPressed(1, 51) then 
                                    OpenClothesMenu() 
                                end
                            end
                        end
                    end
        Citizen.Wait(OthersWait)
    end
end)