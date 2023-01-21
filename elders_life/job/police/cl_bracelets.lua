ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.esxGet, function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RMenu.Add('police_menu', 'police_bracelet_main', RageUI.CreateMenu("Bracelet", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu:Get('police_menu', 'police_bracelet_main').Closed = function()LSPD.BraceletLSPD = false end
RMenu.Add('police_menu', 'police_braceletput_main', RageUI.CreateMenu("Bracelet", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu:Get('police_menu', 'police_braceletput_main').Closed = function()LSPD.BraceletputLSPD = false end
RMenu.Add('police_menu', 'police_braceletgest_main', RageUI.CreateMenu("Bracelet", "INTÉRACTIONS", nil,nil, "aLib", "black"))
RMenu:Get('police_menu', 'police_braceletgest_main').Closed = function()LSPD.BraceletgestLSPD = false end

Blips = {}
ClientRegisterougeBracelet = {}

PoliceStationsB = {
    LSPD = {
        Cloakrooms = {
            vector3(-546.68, -113.09, 43.00),
            vector3(1853.16, 3685.70, 28.22),
        },
    },
}

RegisterNetEvent('fl_policejob:updateBracelet')
AddEventHandler('fl_policejob:updateBracelet', function(RegisterougeBracelet)
    ClientRegisterougeBracelet = RegisterougeBracelet
    local random = 30
    local playerPos = GetEntityCoords(PlayerPedId())

    if #(playerPos.xy - PoliceStationsB.LSPD.Cloakrooms[1].xy) > 15 and ESX.PlayerData.job.name == 'police' then
        for BraceletID,Bracelet in pairs(RegisterougeBracelet) do
            if Blips[BraceletID] then
                RemoveBlip(Blips[BraceletID])
                Blips[BraceletID] = nil
            end

            if Blips[1000000000 + BraceletID] then
                RemoveBlip(Blips[1000000000 + BraceletID])
                Blips[1000000000 + BraceletID] = nil
            end
        end

        return
    end

    if #(playerPos.xy - PoliceStationsB.LSPD.Cloakrooms[2].xy) > 15 and ESX.PlayerData.job.name == 'sheriff' then
        for BraceletID,Bracelet in pairs(RegisterougeBracelet) do
            if Blips[BraceletID] then
                RemoveBlip(Blips[BraceletID])
                Blips[BraceletID] = nil
            end

            if Blips[1000000000 + BraceletID] then
                RemoveBlip(Blips[1000000000 + BraceletID])
                Blips[1000000000 + BraceletID] = nil
            end
        end

        return
    end

    for BraceletID,Bracelet in pairs(ClientRegisterougeBracelet) do
        if Bracelet.isActive and Bracelet.lastPosition then
            local coords = json.decode(Bracelet.lastPosition)
            if not coords or not coords.x or (coords.x == 0 and coords.y == 0 and coords.z == 0) or type(coords) == 'nil' or coords == nil then
                coords = {x = -5000.0, y = -5000.0, z = 0.0}
            end

            if Bracelet.currentPosition then
                coords.x = coords.x + math.random(-random, random)
                coords.y = coords.y + math.random(-random, random)
                coords.z = coords.z + math.random(-random, random)
            end

            local zoneBlip = nil
            if Blips[BraceletID] then
                zoneBlip = Blips[BraceletID]
                SetBlipCoords(zoneBlip, coords.x, coords.y, coords.z)
            else
                zoneBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 70.0)
                Blips[BraceletID] = zoneBlip
            end

            SetBlipAlpha(zoneBlip, 120)
            SetBlipDisplay(zoneBlip, 3)

            if Bracelet.currentPosition then
                SetBlipColour(zoneBlip, 80)
            else
                SetBlipColour(zoneBlip, 85)
            end

            local humanBlip = nil
            if Blips[1000000000 + BraceletID] then
                humanBlip = Blips[1000000000 + BraceletID]
                SetBlipCoords(humanBlip, coords.x, coords.y, coords.z)
            else
                humanBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
                Blips[1000000000 + BraceletID] = humanBlip
            end

            SetBlipAlpha(humanBlip, 180)
            SetBlipSprite(humanBlip, 480)
            SetBlipScale(humanBlip, 0.8)
            SetBlipShrink(humanBlip, 1)
            SetBlipCategory(humanBlip, 7)
            SetBlipDisplay(humanBlip, 3)
            SetBlipAsShortRange(humanBlip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Bracelet.info)
            EndTextCommandSetBlipName(humanBlip)

            if Bracelet.currentPosition then
                SetBlipColour(humanBlip, 80)
            else
                SetBlipColour(humanBlip, 85)
            end
        else
            if Blips[BraceletID] then
                RemoveBlip(Blips[BraceletID])
                Blips[BraceletID] = nil
            end

            if Blips[1000000000 + BraceletID] then
                RemoveBlip(Blips[1000000000 + BraceletID])
                Blips[1000000000 + BraceletID] = nil
            end
        end
    end
end)

RegisterNetEvent('fl_policejob:useBracelet')
AddEventHandler('fl_policejob:useBracelet', function(Bracelet, UseItem)

    if not Bracelet then error('Use no bracelet') end
    local lastUser = Bracelet.info
    if not lastUser then lastUser = 'Aucun' end

    local elements = {
        {label = 'Numéro bracelet : ' .. Bracelet.id, value = 'info'},
        {label = 'Dernier utilisateur : ' .. lastUser, value = 'info'},
    }

    local player = GetPlayerFromServerId(Bracelet.idserv)

    if Bracelet.isActive and Bracelet.lastPosition then
        table.insert(elements, {label = 'Enlever le bracelet', value = 'remove'})
    elseif UseItem then
        table.insert(elements, {label = 'Mettre le bracelet à un individu', value = 'put'})
    end

    if not LSPD.BraceletLSPD then
        LSPD.BraceletLSPD = true
        RageUI.Visible(RMenu:Get('police_menu', 'police_bracelet_main'), true)
        Citizen.CreateThread(function()
            while LSPD.BraceletLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_bracelet_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→" }, true, function(h,a,s)
                            if s then
                                if v.value == 'info' then
                                elseif v.value == 'remove' then
                                    RageUI.CloseAll()
                                    LSPD.BraceletLSPD = false
                                    if not Bracelet.lastPosition then
                                        ESX.ShowNotification('~r~Impossible d\'intéragir avec un bracelet hors du réseau...')
                                    end
                                    TriggerServerEvent('fl_policejob:removeBracelet', Bracelet.id)
                                elseif v.value == 'put' then
                                    RageUI.CloseAll()
                                    LSPD.BraceletLSPD = false
                                    PutBracelet(Bracelet)
                                else
                                    print('Unknown button bracelet_info' .. tostring(data.current.value))
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    end
end)

function PutBracelet(Bracelet)
    local elements = {}
    local closePlayers = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 2.0);

    for _,anyPlayer in pairs(closePlayers) do
        if anyPlayer ~= PlayerId() then
            table.insert(elements, {label = GetPlayerName(anyPlayer), value = anyPlayer})
        end
    end

    if #closePlayers == 0 then
        table.insert(elements, {label = 'Aucun joueurs ...', value = 'nope'})
    end

    if not LSPD.BraceletputLSPD then
        LSPD.BraceletputLSPD = true
        RageUI.Visible(RMenu:Get('police_menu', 'police_braceletput_main'), true)
        Citizen.CreateThread(function()
            while LSPD.BraceletputLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_braceletput_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→" }, true, function(h,a,s)
                            if s then
                                if v.value == 'nope' then 

                                else
                                    TriggerServerEvent('fl_policejob:putBracelet', Bracelet.id, GetPlayerServerId(v.value))
                                    RageUI.CloseAll()
                                    LSPD.BraceletputLSPD = false
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

RegisterNetEvent('fl_policejob:manageBracelet')
AddEventHandler('fl_policejob:manageBracelet', function()
    local elements = {}
    for BraceletID,Bracelet in pairs(ClientRegisterougeBracelet) do
        local braceletInfo = ''
        if Bracelet.info then
            if Bracelet.isActive then
                braceletInfo = 'Actif'
            else
                braceletInfo = 'Inactif'
            end
            braceletInfo = braceletInfo .. ' (' .. Bracelet.info .. ')'
        end
        table.insert(elements, {label = 'Bracelet n°' .. BraceletID .. ' ' .. braceletInfo, braceletId = BraceletID})
    end

    if #elements == 0 then
        table.insert(elements, {label = 'Aucun bracelet...', braceletId = 999999999999})
    end

    if not LSPD.BraceletgestLSPD then
        LSPD.BraceletgestLSPD = true
        RageUI.Visible(RMenu:Get('police_menu', 'police_braceletgest_main'), true)
        Citizen.CreateThread(function()
            while LSPD.BraceletgestLSPD do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("police_menu",'police_braceletgest_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→" }, true, function(h,a,s)
                            if s then
                                if v.braceletId == 999999999999 then 

                                else
                                    RageUI.CloseAll()
                                    LSPD.BraceletgestLSPD = false
                                    TriggerEvent('fl_policejob:useBracelet', ClientRegisterougeBracelet[v.braceletId])
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent('fl_policejob:coupeBracelet')
AddEventHandler('fl_policejob:coupeBracelet', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and playerDistance <= 3.0 then
        TriggerServerEvent('fl_policejob:coupeBraceletsv', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('fl_policejob:showpos')
AddEventHandler('fl_policejob:showpos', function(pos)
    local PlayerData = ESX.GetPlayerData()
    local blip = nil
    position = json.decode(pos)

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" then
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(position.x, position.y, position.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(('Bracelet Coupé'))
            EndTextCommandSetBlipName(blip)

            PulseBlip(blip)
            Citizen.Wait(60000)
            RemoveBlip(blip)
        end
    end
end)