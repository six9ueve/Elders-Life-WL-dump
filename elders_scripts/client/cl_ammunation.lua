ESX = nil

local isMenuOpened = false
local ppa = false

local function createBlipAmmu(pos,id, onlyShortRange, name,color)
    local blip = AddBlipForCoord(pos)
    SetBlipSprite(blip, id)
    SetBlipScale  (blip, 0.6)
    SetBlipAsShortRange(blip, onlyShortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    SetBlipColour(blip, color)
    return blip
end

Citizen.CreateThread(function()
    for k, v in pairs(Configammunation.points) do
        createBlipAmmu(v.pos, 433, 0.6, "Ammunation", 6)

        --CreateBlip(v.pos, 433, 6, 0.6, "Ammunation")
        --local ped = aFram.SpawnPed("mp_m_weapexp_01", v.pos)
        local ped = CreatePed(9, "mp_m_weapexp_01",v.pos, 148.05, false, false)

        FreezeEntityPosition(ped, true)
    end
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

local function checkLicense()
    ESX.TriggerServerCallback('god_license:checkLicense', function(hasWeaponLicense)
        ppa = hasWeaponLicense
    end, GetPlayerServerId(PlayerId()), 'weapon')
end 

RMenu.Add("atmos", "ammunation", RageUI.CreateMenu("Ammunation", "~b~Stock :", nil, nil, "aLib", "black"))
RMenu:Get("atmos", "ammunation").Closed = function()
	FreezeEntityPosition(PlayerPedId(), false)
	isMenuOpened = false
end

RMenu.Add("atmos", "blanches", RageUI.CreateSubMenu(RMenu:Get("atmos", "ammunation"), "Ammunation", "~b~Stock :"))
RMenu:Get("atmos", "blanches").Closed = function()end

RMenu.Add("atmos", "legeres", RageUI.CreateSubMenu(RMenu:Get("atmos", "ammunation"), "Ammunation", "~b~Stock :"))
RMenu:Get("atmos", "legeres").Closed = function()end

RMenu.Add("atmos", "letal", RageUI.CreateSubMenu(RMenu:Get("atmos", "ammunation"), "Ammunation", "~b~Stock :"))
RMenu:Get("atmos", "letal").Closed = function()end

RMenu.Add("ammunation", "divers", RageUI.CreateSubMenu(RMenu:Get("atmos", "ammunation"), "Ammunation", "~b~Stock :"))
RMenu:Get("ammunation", "divers").Closed = function()end

local function openMenuArme()
	
	FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

	RageUI.Visible(RMenu:Get("atmos","ammunation"), true)

	Citizen.CreateThread(function()
        while isMenuOpened do 
            RageUI.IsVisible(RMenu:Get("atmos","ammunation"),true,true,true,function()
                RageUI.Separator('↓ Magasin ↓')
                RageUI.ButtonWithStyle("Arme PPA", nil, {RightLabel = "→→→"}, ppa,function(a,h,s)
                end, RMenu:Get("atmos", "letal"))
                RageUI.ButtonWithStyle("Armes blanches", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("atmos", "blanches"))
                RageUI.ButtonWithStyle("Couteaux", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("atmos", "legeres"))
                RageUI.ButtonWithStyle("Divers", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                end, RMenu:Get("ammunation", "divers"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos", "blanches"),true,true,true,function()
                RageUI.Separator('↓ Armes blanches ↓')
                for g, v in pairs(Configammunation.blanches) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = v.price.." $"}, true,function(a,h,s)
                        if s then
                            if selected1 ~= g then
                                selected1 = g
                                TriggerServerEvent("aAmmuncation:achatarme1", selected1)
                            end
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos", "legeres"),true,true,true,function()
                RageUI.Separator('↓ Couteaux ↓')
                for b, v in pairs(Configammunation.legeres) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = v.price.." $"}, true,function(a,h,s)
                        if s then
                            if selected2 ~= b then
                                selected2 = b
                                TriggerServerEvent("aAmmuncation:achatarme2", selected2)
                            end
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos", "letal"),true,true,true,function()
                RageUI.Separator('↓ Arme PPA ↓')
                for c, v in pairs(Configammunation.letal) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = v.price.." $"}, true,function(a,h,s)
                        if s then
                            if selected3 ~= c then
                                selected3 = c
                                TriggerServerEvent("aAmmuncation:achatarme3", selected3)
                            end
                        end
                    end)
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("ammunation", "divers"),true,true,true,function()
                RageUI.Separator('↓ Divers ↓')
                for k, v in pairs(Configammunation.divers) do
                    RageUI.ButtonWithStyle(v.name, nil, {RightLabel = v.price.." $"}, true,function(a,h,s)
                        if s then
                            selected4 = k
                            TriggerServerEvent("aAmmuncation:achatarme4", selected4)
                        end
                    end)
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k, v in pairs(Configammunation.points) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.pos)
            if dist <= 2.5 and not isMenuOpened then
                interval = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler avec l'armurier")
                if IsControlJustPressed(1,51) then
                    checkLicense()
                    openMenuArme()
                end
            end
        end
    Citizen.Wait(interval)
    end
end)