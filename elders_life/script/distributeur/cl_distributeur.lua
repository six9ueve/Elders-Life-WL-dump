ESX = nil

local bendingMachines = {-654402915,-1034034125}
local bendingMachines2 = {1114264700}
local bendingMachines3 = {992069095,-1317235795}

local distX, distY, distZ = 0, 0, 0
local dist2X, dist2Y, dist2Z = 0, 0, 0


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local candybox = 
{
    { keyValue = 'A1', value = "crunch", label = 'Crunch', price = 25},
    { keyValue = 'B1', value = "crunchies", label = 'Crunchies', price = 25},
    { keyValue = 'C1', value = "butterfinger", label = 'Butterfinger', price = 25},
    { keyValue = 'D1', value = "knoppers", label = 'Knoppers', price = 25},
    { keyValue = 'E1', value = "reeses", label = 'Reese\'s', price = 25},
    { keyValue = 'F1', value = "twix", label = 'Twix', price = 25}

}

local candybox2 = 
{
    { keyValue = 'A1', value = "water", label = 'Bouteille D\'eau', price = 65},
    { keyValue = 'B1', value = "crush_orange", label = 'Crush Orange', price = 65},
    { keyValue = 'C1', value = "drpepper", label = 'Dr.Pepper', price = 65},
    { keyValue = 'D1', value = "crush_raisin", label = 'Crush Raisin', price = 65},
    { keyValue = 'E1', value = "big_red", label = 'Big-Red', price = 65},
    { keyValue = 'F1', value = "pepsi", label = 'Pepsi', price = 65}
}

RMenu.Add("distributeur", "achat", RageUI.CreateMenu("Distributeur", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("distributeur", "achat").Closed = function()
    isMenuOpened = false
end

RMenu.Add("distributeur1", "achat", RageUI.CreateMenu("Distributeur", "~b~Menu :", nil, nil, "aLib", "black"))
RMenu:Get("distributeur1", "achat").Closed = function()
    isMenuOpened = false
end

local function VendingMachineMenu()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("distributeur", "achat"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("distributeur", "achat"),true,true,true,function()
                RageUI.Separator('↓ Achat Friandise ↓')
                for k,v in pairs(candybox) do
                    RageUI.ButtonWithStyle("~b~Friandise~w~ : "..v.label.. " | ~b~Prix~w~ : "..v.price.." ~g~$" , nil, {RightLabel = "→→→"}, true, function(h, a, s)
                         if s then
                                    local amount = KeyboardInput("Prix", "Nombre", "", 6)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("Elders_distributeur:buyVendingItem",v.price,v.value,amount)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    else
                                        ESX.ShowNotification("Montant Invalide", 'Problème')
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end                                    
                        end                    
                    end) 
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

local function VendingMachineMenu2()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("distributeur1", "achat"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("distributeur1", "achat"),true,true,true,function()
                RageUI.Separator('↓ Achat Boisson ↓')
                for k,v in pairs(candybox2) do
                    RageUI.ButtonWithStyle("~b~Boisson~w~ : "..v.label.. " | ~b~Prix~w~ : "..v.price.." ~g~$" , nil, {RightLabel = "→→→"}, true, function(h, a, s)
                         if s then
                                    local amount = KeyboardInput("Prix", "Nombre", "", 6)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("Elders_distributeur:buyVendingItem",v.price,v.value,amount)
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    else
                                        ESX.ShowNotification("Montant Invalide", 'Problème')
                                        RageUI.CloseAll()
                                        isMenuOpened = false
                                    end                                    
                        end                    
                    end) 
                end
            end, function()end, 1)
            Wait(0)
        end
    end)
end

RegisterNetEvent('distributeur:OpenMenu')
AddEventHandler('distributeur:OpenMenu', function()
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for i = 1, #bendingMachines do
                local bendingMachine = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, bendingMachines[i], false, false, false)
                local bendingMachinesPos = GetEntityCoords(bendingMachine)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, bendingMachinesPos.x, bendingMachinesPos.y, bendingMachinesPos.z, true)
                if dist < 2 then
                    local loc = vector3(bendingMachinesPos.x, bendingMachinesPos.y, bendingMachinesPos.z)                    
                    distX, distY, distZ = bendingMachinesPos.x, bendingMachinesPos.y, bendingMachinesPos.z                     
                    VendingMachineMenu()
                end                
            end
end)

RegisterNetEvent('distributeur:OpenMenu2')
AddEventHandler('distributeur:OpenMenu2', function()
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for i = 1, #bendingMachines2 do
                local bendingMachine2 = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, bendingMachines2[i], false, false, false)
                local bendingMachinesPos2 = GetEntityCoords(bendingMachine2)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, bendingMachinesPos2.x, bendingMachinesPos2.y, bendingMachinesPos2.z, true)
                if dist < 2 then
                    local loc = vector3(bendingMachinesPos2.x, bendingMachinesPos2.y, bendingMachinesPos2.z)                    
                    dist2X, dist2Y, dist2Z = bendingMachinesPos2.x, bendingMachinesPos2.y, bendingMachinesPos2.z                     
                    VendingMachineMenu2()
                end                
            end
end)

RegisterNetEvent('distributeur:OpenMenu3')
AddEventHandler('distributeur:OpenMenu3', function()
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)

            for i = 1, #bendingMachines3 do
                local bendingMachine3 = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, bendingMachines3[i], false, false, false)
                local bendingMachinesPos3 = GetEntityCoords(bendingMachine3)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, bendingMachinesPos3.x, bendingMachinesPos3.y, bendingMachinesPos3.z, true)
                if dist < 2 then
                    local loc = vector3(bendingMachinesPos3.x, bendingMachinesPos3.y, bendingMachinesPos3.z)                    
                    dist3X, dist3Y, dist3Z = bendingMachinesPos3.x, bendingMachinesPos3.y, bendingMachinesPos3.z                     
                    VendingMachineMenu2()
                end                
            end
end)

