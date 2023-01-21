ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
    InitbrancardSystemStory()
end)

local function cool(time)
    cooldown = true
    SetTimeout(time, function()
        cooldown = false
    end)
end


local cancreate = true
local my = {}
local appeltraite = 0
local isDead = false
local earlySpawnTimer = 30
local DidCall = false
local tableBlip = {}
FirstSpawn = true
local range = false
local coucher = false
local dejaassis = false
local CooldownMinutes = 10
local Timer = 0
local EMSidentity = {}
local VehEMS = false
local VehSelectEMS = false
local spawnedVehicles = {}

local restoreCoords = vector3(343.4211, -572.137, 28.89872)

local function attachEntityOnVehicule(propObject, vehicule, depth, height)
    brancardInVehicule = true
    NetworkRequestControlOfEntity(vehicule)

    AttachEntityToEntity(propObject, vehicule, 0.0, 0.0, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

    while IsEntityAttachedToEntity(propObject, vehicule) and brancardInVehicule do
        local brancarsInVehicule = false
        local playerPos = GetEntityCoords(PlayerPedId())
        local vehiculePos = GetEntityCoords(vehicule)
        local distancePlayerVehicule = #(vehiculePos-playerPos)

        if (GetVehiclePedIsIn(PlayerPedId()) == 0) then
            if distancePlayerVehicule <= 5.0 then
                brancarsInVehicule = true
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir le brancard")
                if IsControlJustPressed(0, 51) then
                    DetachEntity(propObject, true, true)
                    local playerHeading = GetEntityHeading(PlayerPedId())
                    SetEntityHeading(PlayerPedId(), (playerHeading - 180.0))
                    vehiculeIndex[vehicule].brancardCoffre = false
                    attachEntityOnPed(propObject)
                end
            end
        end

        if not brancarsInVehicule then
            Wait(500)
        else
            Wait(1)
        end
    end
end

RegisterNetEvent('medicament')
AddEventHandler('medicament', function()
    if GetGameTimer() - Timer > CooldownMinutes * 60000 then
        Timer = GetGameTimer()
        local health = GetEntityHealth(PlayerPedId())
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 10))
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerServerEvent('god_ambulancejob:medicament')

        local progressbartime = 3000
        ClearPedTasksImmediately(PlayerPedId())

        TriggerEvent("mythic_progbar:client:progress", {
            name = "pansement",
            duration = progressbartime,
            label = "Prise du médicament",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
            },

        }, function(status)
            if not status then
                StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
                ESX.ShowNotification('Vous avez utilisé un médicament')
            end
        end)

        Citizen.Wait(progressbartime)

        FreezeEntityPosition(PlayerPedId(),false)
    else
        ESX.ShowNotification('Ne pas prendre plus d\'une fois par 10 minutes')
    end
end)

RegisterNetEvent('pansementcl')
AddEventHandler('pansementcl', function()
    if GetEntityHealth(PlayerPedId()) < 150 then
        local health = GetEntityHealth(PlayerPedId())
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 30))
        print(newHealth)
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerServerEvent('god_ambulancejob:pansement')

        FreezeEntityPosition(PlayerPedId(),true)

        local progressbartime = math.random(6000, 12000)
        ClearPedTasksImmediately(PlayerPedId())

        TriggerEvent("mythic_progbar:client:progress", {
            name = "pansement",
            duration = progressbartime,
            label = "Pose du pansement",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "anim@gangops@facility@servers@",
                anim = "hotwire",
            },

        }, function(status)
            if not status then
                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                ESX.ShowNotification('Vous avez utilisé un pansement')
            end
        end)

        Citizen.Wait(progressbartime)

        FreezeEntityPosition(PlayerPedId(),false)
    else 
        ESX.ShowNotification('~r~Problème :~w~ Vous ne pouvez plus mettre de pansement !')
    end
end)

RegisterNetEvent('god:playerLoaded')
AddEventHandler('god:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('god:setJob')
AddEventHandler('god:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add("ambulance", "ambulance_menu_main", RageUI.CreateMenu("EMS", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ambulance", "ambulance_menu_main").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ambulance", "vestiaire", RageUI.CreateMenu("EMS", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ambulance", "vestiaire").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ambulance", "Magasin", RageUI.CreateMenu("EMS", "~b~Menu job :", nil, nil, "aLib", "black"))
RMenu:Get("ambulance", "Magasin").Closed = function()
    isMenuOpened = false
end

RMenu.Add("ambulance", "death_call", RageUI.CreateMenu("Demande d'EMS", "~b~Demande d'aide", nil, nil, "aLib", "black"))
RMenu:Get("ambulance", "death_call").Closed = function()
    MenuOpen = false
end

RMenu.Add("ambulance", "ambulance_interappels", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_interappels").Closed = function()end

RMenu.Add("ambulance", "ambulance_appels", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_appels").Closed = function()end

RMenu.Add("ambulance", "ambulance_props", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_props").Closed = function()end

RMenu.Add("ambulance", "ambulance_gestionprops", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_props").Closed = function()end

RMenu.Add("ambulance", "ambulance_inter", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_inter").Closed = function()end

RMenu.Add("ambulance", "ambulance_intersupp", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "ambulance_intersupp").Closed = function()end

RMenu.Add("ambulance", "regarderidentiteems", RageUI.CreateSubMenu(RMenu:Get("ambulance", "ambulance_menu_main"), "EMS", "~b~Identité :"))
RMenu:Get("ambulance", "regarderidentiteems").Closed = function()end

RMenu.Add("ambulance", "changetenue", RageUI.CreateSubMenu(RMenu:Get("ambulance", "vestiaire"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "changetenue").Closed = function()end

RMenu.Add("ambulance", "deletetenue", RageUI.CreateSubMenu(RMenu:Get("ambulance", "vestiaire"), "EMS", "~b~Menu job :"))
RMenu:Get("ambulance", "deletetenue").Closed = function()end

RMenu.Add('ambulance', 'ambulance_veh_main', RageUI.CreateMenu("EMS", "VEHICULES", nil,nil, "aLib", "black"))
RMenu:Get('ambulance', 'ambulance_veh_main').Closed = function()VehEMS = false end

RMenu.Add('ambulance', 'ambulance_vehselect_main', RageUI.CreateMenu("EMS", "VEHICULES", nil,nil, "aLib", "black"))
RMenu:Get('ambulance', 'ambulance_vehselect_main').Closed = function()VehSelectEMS = false DeleteSpawnedVehiclesEMS() ESX.Game.Teleport(PlayerPedId(), restoreCoords) end

Citizen.CreateThread(function()
    RequestAnimDict("mini@cpr@char_a@cpr_def")
    RequestAnimDict("mini@cpr@char_a@cpr_str")
    RequestAnimDict("mini@cpr@char_b@cpr_def")
    RequestAnimDict("mini@cpr@char_b@cpr_str")
end)

AddEventHandler('onClientMapStart', function()
    Citizen.Wait(10000)
    exports.spawnmanager:setAutoSpawn(false)
    Citizen.Trace("RPDeath: Autospawn disabled!")
end)

RegisterNetEvent('ambulance:CheckIfDeath')
AddEventHandler('ambulance:CheckIfDeath', function()
    isDead = false
    MenuOpen = false
    if FirstSpawn then
      --  exports.spawnmanager:setAutoSpawn(false) -- disable respawn
        FirstSpawn = false
    end
        ESX.TriggerServerCallback('ambulance:getDeathStatus', function(shouldDie)
            if shouldDie == true then
                ESX.ShowAdvancedNotification('EMS', 'Information(s)', 'Vous avez été mis dans le coma de force, car vous avez quitté le serveur dans le coma...', 'CHAR_CALL911', 10)
                OnPlayerDeath()
            end
        end)        
end)

function openMenuDeath()
    if not MenuOpen then 
        MenuOpen = true
        RageUI.Visible(RMenu:Get('ambulance', 'death_call'), not RageUI.Visible(RMenu:Get('ambulance', 'death_call')))
            Citizen.CreateThread(function()
                while MenuOpen do
                    RageUI.IsVisible(RMenu:Get('ambulance', 'death_call'), true, true, true, function()
                        if not DidCall then
                            RageUI.ButtonWithStyle("Appuyez sur ~g~ENTRER~s~ pour demander un ~b~EMS.", nil, {}, true, function(_, _, s)
                                if s then
                                    DidCall = true
                                    TriggerServerEvent('ambulance:ajoutappel', mynom.firstname.. " " ..mynom.lastname, GetEntityCoords(PlayerPedId()), "0")
                                    TriggerServerEvent('ambulance:AppelNotifs')
                                    ESX.ShowAdvancedNotification('Ambulance', 'Information(s)', '~g~Votre appel EMS ~s~à bien été envoyé.\nUn peu de patience !', 'CHAR_CALL911', 10)
                                end
                            end)
                            RageUI.Separator("↓ Problème(s) ? ↓")
                            RageUI.Separator("Votre ID est le : ~b~"..tostring(GetPlayerServerId(PlayerId())))
    
                        else
                            if earlySpawnTimer > 0 then
                                RageUI.Separator("~r~Vous êtes dans le coma.")
                                RageUI.Separator("")
                                RageUI.Separator("Votre ID est le : ~b~"..tostring(GetPlayerServerId(PlayerId())))
                                RageUI.Separator("")
                                if earlySpawnTimer == 1 then
                                    RageUI.Separator("Temps restant avant le transport automatique :")
                                    RageUI.Separator("Dans ~b~moins d'une ~s~minute(s).")
                                else  
                                    RageUI.Separator("Temps restant avant le transport automatique :")
                                    RageUI.Separator("Dans ~b~"..earlySpawnTimer.."~s~ minute(s).")
                                end
                                RageUI.Separator("")
                                RageUI.Separator("Votre appel à ~b~été envoyé aux EMS ~s~disponible.")
                            else
                                RageUI.Separator("")
                                RageUI.Separator("Ou voulez-vous être transporté ?")
                                RageUI.Separator("")
                                RageUI.ButtonWithStyle("Hôpital [SUD] en Ville.", nil, {RightLabel = "→→"}, true, function(_, a, s)
                                    if s then
                                        choix = 1
                                        DoScreenFadeOut(800)
                                        RemoveItemsAfterRPDeath(choix)
                                        earlySpawnTimer = 30
                                    end
                                end)
                                RageUI.ButtonWithStyle("Hôpital [NORD] au Nord.", nil, {RightLabel = "→→"}, true, function(_, a, s)
                                    if s then
                                        choix = 2
                                        DoScreenFadeOut(800)
                                        RemoveItemsAfterRPDeath(choix)
                                        earlySpawnTimer = 30
                                    end
                                end) 
                            end
                        end
                    end)
                    Citizen.Wait(0)
                end
            MenuOpen = false
        end)
    end
end

function RemoveItemsAfterRPDeath(choix)
    TriggerServerEvent('ambulance:setDeathStatus', 0)
    isDead = false
    EndDeathCam()
    DisplayRadar(true)
    RageUI.CloseAll()
    MenuOpen = false
    TriggerEvent("ambulance:reviveComa", choix)
    ESX.ShowAdvancedNotification('EMS', 'Information(s)', 'Vous avez été réanimé d\'urgence...', 'CHAR_CALL911', 10)
    Normal()
    TriggerServerEvent('JD_logs:uniteX', choix)
end

RegisterNetEvent('ambulance:reviveComa')
AddEventHandler('ambulance:reviveComa', function(choix)
    local coords1 = vector3(327.10,-592.08,43.28) 
    local coords2 = vector3(-267.13,6322.43,32.40)
    TriggerServerEvent('ambulance:setDeathStatus', 0)
    RageUI.CloseAll()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Citizen.Wait(50)
    end
    local formattedCoords
    if choix == 1 then
    formattedCoords = {
        x = coords1.x,
        y = coords1.y,
        z = coords1.z
        }
    else
        formattedCoords = {
            x = coords2.x,
            y = coords2.y,
            z = coords2.z
        }
    end
    ESX.SetPlayerData('lastPosition', formattedCoords)
    TriggerServerEvent('god:updateLastPosition', formattedCoords)
    RespawnPed(PlayerPedId(), formattedCoords)
    StopScreenEffect('DeathFailOut')
    DoScreenFadeIn(800)
    isDead = false    
    EndDeathCam()
    MenuOpen = false
    DidCall = false
    earlySpawnTimer = 30
    Normal()
    TriggerEvent("god_status:add", "thirst", 1000000)
    TriggerEvent("god_status:add", "hunger", 1000000)
    TriggerEvent("god_status:remove", "stress", 1000000)
end)

function getProps()
    sProps = {}
    ESX.TriggerServerCallback('elderslife:getProps', function(props)
        sProps = props
    end)
end

function OnPlayerDeath()
    isDead = true
    RageUI.CloseAll()
    Wait(500)
    ClearPedTasksImmediately(PlayerPedId())
    TriggerServerEvent('ambulance:setDeathStatus', 1)
    ESX.TriggerServerCallback('ambulance:getmyname', function(myname)mynom = myname end)
    openMenuDeath()
    Citizen.CreateThread(function()
        while isDead do
            Wait(0)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 168, true) 
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 318, true)
            DisableControlAction(0, 327, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 344, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true) 
            DisableControlAction(0, 327, true)
            DisableControlAction(0, 167, true)
        end
    end)

    Citizen.CreateThread(function()
        while isDead and earlySpawnTimer > 0 do 
            if earlySpawnTimer > 0 then
                earlySpawnTimer = earlySpawnTimer - 1
            end
            Citizen.Wait(60000)
        end
    end)

    Citizen.CreateThread(function()
        while true do 
            if isDead then
                SetTimecycleModifier('damage')
                Citizen.Wait(2)
            else
                Normal()
                break
            end
        end
    end)
end

function getAppEms()
    sAppEms = {}
    ESX.TriggerServerCallback("ambulance:getAppEms", function(AppEms)
        sAppEms = AppEms
    end)
end

function StopMenu()
    RageUI.Visible(RMenu:Get('ambulance', 'ambulance_menu_main'), false)
end

local EMS = {
    Index = 1,
}

function getIdentity(player)
    ESX.TriggerServerCallback('ambulance:getNameInDB', function(data)
        EMSidentity = data
    end, player)
end

local function openMenuambulanceF6()
    if ambulancemenu then
        ambulancemenu = false
        StopMenu()
    else
        ambulancemenu = true
        RageUI.Visible(RMenu:Get('ambulance', 'ambulance_menu_main'), true)
        Citizen.CreateThread(function()
            while ambulancemenu do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_menu_main'),true,true,true,function()
                    RageUI.Separator("↓ ~b~Statut de service ~s~↓")
                    RageUI.Separator("↓ ~b~Job ~w~"..ESX.PlayerData.job.label.." ↓")
                    RageUI.List("Status de service", {"Prendre", "Quitter"}, EMS.Index, nil, {},true,  function(_,_,s,Index)
                        EMS.Index = Index
                        if s then
                            if Index == 1 then
                                inServiceAmbulance = true
                                ShowNotification("STATUT\nVous avez ~b~pris~s~ votre service")
                                TriggerServerEvent('ambulance:setjobAmbulance', 'ambulance')
                                TriggerEvent('god:setJobdoor', 'ambulance')
                            elseif Index == 2 then
                                inServiceAmbulance = false
                                ShowNotification("STATUT\nVous avez ~r~quitté~s~ votre service")
                                TriggerServerEvent('ambulance:setjobAmbulance', 'offambulance')
                                TriggerEvent('god:setJobdoor', 'offambulance')
                            end
                        end
                    end)
                    if inServiceAmbulance then
                        --[[RageUI.ButtonWithStyle("Tablette EMS", nil, { RightLabel = "→→" }, true, function(_,_,s)
                            if s then
                                
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end)]]--
                        RageUI.Separator("↓ ~y~Actions ~s~↓")
                        RageUI.ButtonWithStyle("[ANNONCE] Prendre son service", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                            if s then
                                codesCooldown = true
                                TriggerServerEvent("elderslife:jobAnnonce", "LSMC", "Un EMS vient de prendre son service !\nEMS ~g~disponible.", "CHAR_CALL911")
                                Citizen.SetTimeout(5000, function() codesCooldown = false end)
                            end
                        end)
                        RageUI.ButtonWithStyle("[ANNONCE] Quitter son service", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                            if s then
                                codesCooldown = true
                                TriggerServerEvent("elderslife:jobAnnonce", "LSMC", "Un EMS vient de quitter son service !\nEMS ~r~indisponible.", "CHAR_CALL911")
                                Citizen.SetTimeout(5000, function() codesCooldown = false end)
                            end
                        end)
                        RageUI.ButtonWithStyle("[ANNONCE] LSMC non disponible", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                            if s then
                                codesCooldown = true
                                TriggerServerEvent("elderslife:jobAnnonce", "LSMC", "Les EMS sont désormais ~r~indisponibles", "CHAR_CALL911")
                                Citizen.SetTimeout(5000, function() codesCooldown = false end)
                            end
                        end)
                        RageUI.ButtonWithStyle("[ANNONCE] LSMC disponible", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                            if s then
                                codesCooldown = true
                                TriggerServerEvent("elderslife:jobAnnonce", "LSMC", "Un EMS vient de prendre son service !\nEMS ~g~disponible.", "CHAR_CALL911")
                                Citizen.SetTimeout(5000, function() codesCooldown = false end)
                            end
                        end)
                        RageUI.ButtonWithStyle("Annonce Personnalisé", nil, {RightLabel = "→→→"}, not codesCooldown,function(a,h,s)
                            if s then
                                local msg = KeyboardInput("atmos", "Annonce :", "", 100)
                                if msg and msg ~= "" then
                                    codesCooldown = true
                                    TriggerServerEvent('elderslife:persoambulance', msg)   
                                    Citizen.SetTimeout(5000, function() codesCooldown = false end)                         
                                end
                            end
                        end)
                        RageUI.Separator("↓ ~o~Interactions ~s~↓")

                        RageUI.ButtonWithStyle("Interactions citoyen", nil, { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('ambulance', 'ambulance_inter'))
                        RageUI.ButtonWithStyle("Liste des appels", "Gestion des appels", { RightLabel = "→→" }, true, function(h, a, s)
                            if s then
                                getAppEms()
                            end
                        end, RMenu:Get('ambulance', 'ambulance_appels'))

                        RageUI.ButtonWithStyle("Interactions supplémentaire", nil, { RightLabel = "→→" }, true, function(h, a, s)
                            if s then
                                ESX.TriggerServerCallback("ambulance:getmyname", function(myname)my = myname end)
                            end
                        end, RMenu:Get('ambulance', 'ambulance_intersupp'))

                        RageUI.ButtonWithStyle("Matériels/Objets EMS", nil, { RightLabel = "→→" }, true, function(h, a, s)
                            if s then
                                getProps()
                            end
                        end, RMenu:Get('ambulance', 'ambulance_props'))
                    end
                end)

                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_inter'),true,true,true,function()
                    RageUI.ButtonWithStyle("Mettre la personne en tenue", nil, {RightLabel = "→→"}, true, function(_, a, s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ShowNotification("~r~Aucun(e) individu à proximité !")
                            else
                                TriggerServerEvent('ambulance:setskinsv', GetPlayerServerId(closestPlayer))
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Diagnostic de la personne", nil, {RightLabel = "→→"}, true, function(_, a, s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            ExecuteCommand("diagnosis")
                            RageUI.CloseAll()
                            isMenuOpened = false
                        end
                    end)
                    RageUI.ButtonWithStyle("Vérifier la vie de la personne", nil, {RightLabel = "→→"}, true, function(_, a, s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ShowNotification("~r~Aucun(e) individu à proximité !")
                            else
                                local health = GetEntityHealth(GetPlayerPed(closestPlayer))
                                ShowNotification("~g~Niveau de vie : "..health.."/200")
                                RageUI.CloseAll()
                                isMenuOpened = false
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Identité de la personne", nil, {RightLabel = '→→'}, true,function(_,a,s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            getIdentity(GetPlayerServerId(closestPlayer))
                        end
                    end,RMenu:Get("ambulance", "regarderidentiteems"))
                    RageUI.ButtonWithStyle("Réanimer la personne", nil, {RightLabel = "→→"}, true, function(_, a, s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ShowNotification("~r~Aucun(e) individu à proximité !")
                            else
                                RevivePly(closestPlayer)
                                SetFocusEntity(PlayerPedId())
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Soigner la personne", nil, {RightLabel = "→→"}, true, function(_, a, s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                        end
                        if s then
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ShowNotification("~r~Aucun(e) individu à proximité !")
                            else
                                ESX.TriggerServerCallback('elderslife:getInvPlyItems', function(quantity)
                                    if quantity > 0 then
                                        LoadAnim("amb@world_human_bum_standing@twitchy@base")
                                        local closestPlayerPed = GetPlayerPed(closestPlayer)
                                        local health = GetEntityHealth(closestPlayerPed)
                                        if health > 0 then
                                            ShowNotification("~g~Vous êtes entrain de soigner~s~ le patient !")
                                            --TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                            TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_standing@twitchy@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
                                            Citizen.Wait(10000)
                                            ClearPedTasks(PlayerPedId())
                                            TriggerServerEvent('ambulance:removeItem', 'bandage')
                                            TriggerServerEvent('ambulance:heal', GetPlayerServerId(closestPlayer), 'small')
                                            --TriggerServerEvent(Config_sCore.Prefix..":AddMoneySell", 250)
                                            ShowNotification("Vous avez soigné le patient.\n~g~Vous avez reçu 250$")
                                        else
                                            ShowNotification("~r~Aucun(e) individu inconscient à proximité !")
                                        end
                                    else
                                        ShowNotification("~r~ous n'avez pas de bandage sur vous !")
                                    end
                                end, 'bandage')
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "→→"}, true, function(_,a,s)
                        local closestPlayer,closestDistance = ESX.Game.GetClosestPlayer()
                        if a then
                            MarquerJoueur()
                            if s then
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    ShowNotification("~r~Aucun(e) individu à proximité !")
                                else
                                    local amount = KeyboardInput("atmos", "Montant de la facture :", "", 6)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        ESX.ShowNotification("Vous avez bien envoyé la facture de <span style='color:#47cf73'>"..amount.."$</span> !", 'Banque')
                                        TriggerServerEvent('god_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Ambulance', amount)
                                    else
                                        ESX.ShowNotification("Montant Invalide", 'Problème')
                                    end
                                end
                            end
                        end
                    end)
                end)
                RageUI.IsVisible(RMenu:Get('ambulance', 'regarderidentiteems'), true, true, true, function()
                    RageUI.Separator("↓ [~b~ Carte d'identité ~s~] ↓")
                        for k,v in pairs(EMSidentity) do
                            RageUI.ButtonWithStyle("Nom : ", nil, {RightLabel = v.lastname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Prénom : ", nil, {RightLabel = v.firstname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Date de naissance : ", nil, {RightLabel = v.dateofbirth}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Taille : ", nil, {RightLabel = v.height}, true, function(h, a, s)
                            end)
                            if v.sex == 'm' then
                                RageUI.ButtonWithStyle("Genre : ", nil, {RightLabel = "Homme"}, true, function(h, a, s)
                            end) 
                        else
                            if v.sex == 'f' then
                                RageUI.ButtonWithStyle("Genre : ", nil, {RightLabel = "Femme"}, true, function(h, a, s)
                                end) 
                            end
                        end
                    end
                end)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_intersupp'),true,true,true,function()
                    RageUI.Separator("↓ Option ↓")
                    RageUI.ButtonWithStyle("Supprimer les [Blips] des appels coma", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            removeAllBlips()
                        end
                    end)
                    RageUI.Separator("↓ Actions ↓")
                    RageUI.ButtonWithStyle("Demande d'effectif(s) : ~b~Légère", nil, { RightLabel = "→→" }, not legere, function(_,_,s)
                        if s then
                            legere = true 
                            TriggerServerEvent('ambulance:AlerteAmbu', GetEntityCoords(PlayerPedId()), "petit")
                            TriggerServerEvent('ambulance:AlerteNotif', "petit", my.firstname.. " " ..my.lastname)
                            Citizen.SetTimeout(10000, function() legere = false end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Demande d'éffectif(s) : ~o~Importante", nil, { RightLabel = "→→" }, not grande, function(_,_,s)
                        if s then
                            grande = true 
                            TriggerServerEvent('ambulance:AlerteAmbu', GetEntityCoords(PlayerPedId()), "grande")
                            TriggerServerEvent('ambulance:AlerteNotif', "grande", my.firstname.. " " ..my.lastname)
                            Citizen.SetTimeout(10000, function() grande = false end)
                        end
                    end)
                end)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_appels'),true,true,true,function()
                    RageUI.Separator("Nombre d'appel(s) accomplis : ~b~"..appeltraite)
                    local found = 0
                    for k,v in pairs(sAppEms) do
                        found = found + 1
                    end
                    if found > 0 then
                        sAppEms = sAppEms
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Il y a actuellement aucun appel EMS :(")
                        RageUI.Separator("")
                    end
                    for k,v in pairs(sAppEms) do
                        local label
                        if v.state == "1" then
                            label = "~g~EN COURS ~s~→→"
                        else
                            label = "~r~EN ATTENTE ~s~→→"
                        end
                        RageUI.ButtonWithStyle("["..k.."] - [~b~"..v.nom.."~s~] ", nil, {RightLabel = label}, true, function(_, a, s)
                            if s then
                                appelselec = v
                                kselec = k
                            end
                        end, RMenu:Get('ambulance', 'ambulance_interappels'))
                    end  
                end)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_props'),true,true,true,function()
                    RageUI.ButtonWithStyle("Gestion des objets", nil, {RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            getProps()
                        end
                    end, RMenu:Get("ambulance", "ambulance_gestionprops"))

                    RageUI.ButtonWithStyle("Chaise roulante", nil, {RightLabel =  "~b~Poser ~s~→→"}, true, function(_, _, s)
                        if s then
                            SpawnObj("prop_wheelchair_01")
                        end
                    end)
                    RageUI.ButtonWithStyle("Brancard", nil, {RightLabel =  "~b~Poser ~s~→→"}, true, function(_, _, s)
                        if s then
                            SpawnObj("v_med_emptybed")
                        end
                    end)
                    RageUI.ButtonWithStyle("Défibrillateur", nil, {RightLabel =  "~b~Poser ~s~→→"}, true, function(_, _, s)
                        if s then
                            SpawnObj("prop_ld_case_01")
                        end
                    end)
                    RageUI.ButtonWithStyle("Sac Paramedic", nil, {RightLabel =  "~b~Poser ~s~→→"}, true, function(_, _, s)
                        if s then
                            SpawnObj("prop_cs_shopping_bag")
                        end
                    end)
                end)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_gestionprops'),true,true,true,function()
                    if #sProps == 0 then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Vous n'avez posé aucun objet(s) !")
                        RageUI.Separator("")
                    else
                        for k,v in pairs(sProps) do
                            RageUI.ButtonWithStyle("Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {RightLabel =  "~r~Ranger ~s~→→"}, true, function(_, a, s)
                                if a then
                                    local entity = NetworkGetEntityFromNetworkId(v)
                                    local ObjCoords = GetEntityCoords(entity)
                                    DrawMarker(22, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                                end
                                if s then
                                    RemoveObj(v, k)
                                    TriggerServerEvent('elderslife:refreshProps', k)
                                    getProps()
                                end
                            end)
                        end
                    end
                end)
                RageUI.IsVisible(RMenu:Get('ambulance', 'ambulance_interappels'), true, true, true, function()
                    RageUI.Separator("~b~Nom du Patient : ~s~"..appelselec.nom)
                    RageUI.Separator("~b~Date de l'appel : ~s~"..appelselec.heure)
                    local status
                    if appelselec.state == "1" then
                        status = "~g~EN COURS"
                    else
                        status = "~r~EN ATTENTE"
                    end
                    RageUI.Separator("~b~Status : ~s~"..status)
                    RageUI.ButtonWithStyle("Prendre en charge l'appel", nil, { RightLabel = "~b~Prendre ~s~→→" }, not appelselec.pris, function(_, _,s)
                        if s then
                            TriggerServerEvent("ambulance:refreshStatus", kselec, appelselec.state)
                            getAppEms()
                            appelselec.pris = true
                        end
                    end)
                    RageUI.ButtonWithStyle("Clôturer l'appel", nil, { RightLabel = "~r~Clôturer ~s~→→" }, appelselec.pris, function(_, _,s)
                        if s then
                            TriggerServerEvent("ambulance:refreshAPP",kselec)
                            appeltraite = appeltraite + 1
                            getAppEms()
                            RageUI.GoBack()
                            appelselec.pris = false
                        end
                    end)
                    RageUI.Separator(" ↓ ~g~Actions ↓ ")
                    RageUI.ButtonWithStyle("Mettre un point sur le GPS", nil, {RightLabel = "→→"}, appelselec.pris, function(_, a, s)
                        if s then
                            blipsForPayerDead(appelselec.coords)
                        end
                    end)
                    RageUI.ButtonWithStyle("Envoyer un message", nil, {RightLabel = "→→"}, appelselec.pris, function(_, _, s)
                        if s then
                            local message = KeyboardInput("atmos", "Message :", "", 100)
                            TriggerServerEvent("ambulance:sendmessageEMS", appelselec.Id, message)
                        end
                    end)
                end)         
            end
        end)
    end
end

local function openMenuambulanceVestiaire()

    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ambulance", "vestiaire"), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            RageUI.IsVisible(RMenu:Get("ambulance", "vestiaire"),true,true,true,function()
                RageUI.Separator('↓ Tenues Travail ↓')
                for k, v in pairs(ConfigambulanceUniforms) do
                    if k == ESX.PlayerData.job.grade_name then
                        RageUI.ButtonWithStyle("Tenue par grade", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                            if s then
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    if skin.sex == 0 then
                                        if ConfigambulanceUniforms[k].male ~= nil then
                                            TriggerEvent('skinchanger:loadClothes', skin, ConfigambulanceUniforms[k].male)
                                        end

                                    else
                                        if ConfigambulanceUniforms[k].female ~= nil then
                                            TriggerEvent('skinchanger:loadClothes', skin, ConfigambulanceUniforms[k].female)
                                        end
                                    end
                                end)
                            end
                        end)
                    end
                end
                RageUI.Separator("--------------------------------")
                for k, v in pairs(ConfigambulanceUniforms2) do
                    RageUI.ButtonWithStyle(k, nil, {RightLabel = "→→→"}, true,function(a,h,s)
                        if s then
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                if skin.sex == 0 then
                                    if ConfigambulanceUniforms2[k].male ~= nil then
                                        TriggerEvent('skinchanger:loadClothes', skin, ConfigambulanceUniforms2[k].male)
                                    end

                                else
                                    if ConfigambulanceUniforms2[k].female ~= nil then
                                        TriggerEvent('skinchanger:loadClothes', skin, ConfigambulanceUniforms2[k].female)
                                    end
                                end
                            end)
                        end
                    end)
                end
                RageUI.Separator('↓ Garde robe ↓')
                RageUI.ButtonWithStyle("Changer de tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("ambulance", "changetenue"))
                RageUI.ButtonWithStyle("Supprimer une tenue", nil, {RightLabel = "→→→"}, true,function(a,h,s)
                    if s then
                        ESX.TriggerServerCallback('god_eden_clotheshop:getPlayerDressing', function(dressing)
                            mestenues = {}
                            for i=1, #dressing, 1 do
                                table.insert(mestenues, {label = dressing[i], value = i})
                            end
                        end)
                    end
                end, RMenu:Get("ambulance", "deletetenue"))
                RageUI.Separator('↓ Tenues ↓')
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("ambulance", "changetenue"),true,true,true,function()
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
            RageUI.IsVisible(RMenu:Get("ambulance", "deletetenue"),true,true,true,function()
                RageUI.Separator('↓ Supprimer une tenue ↓')
                if mestenues ~= nil then
                    for k, v in pairs(mestenues) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→→"}, true,function(a,h,s)
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

local function openMenuambulanceArmoire()
    if isMenuOpened then return end
    isMenuOpened = true

    RageUI.Visible(RMenu:Get("ambulance", "Magasin"), true)
    Citizen.CreateThread(function()
        while isMenuOpened do
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.IsVisible(RMenu:Get("ambulance", "Magasin"),true,true,true,function()
                RageUI.Separator('↓ Kit ↓')
                    for k, v in pairs(Configambulance.kit) do
                        RageUI.ButtonWithStyle("Acheter un(e) ~b~"..v.label, nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(v.price).."$"}, true,function(a,h,s)
                            if s then
                                local amount = KeyboardInput("atmos", "Nombre :", "", 6)
                                amount = tonumber(amount)
                                if amount == nil then
                                ESX.ShowNotification("Montant Invalide", 'Problème')
                                return
                                end
                                TriggerServerEvent('elders_life:!:shop_ambulance', v.value, v.price , amount)                            
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
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "offambulance" then
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local pos = Configambulance.points.vestiaire
            if #(plyCoords - pos) < 15 then
                interval = 1
                DrawMarker(22,  Configambulance.points.vestiaire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        openMenuambulanceVestiaire()
                    end
                end
            end
            local pos1 = Configambulance.points.armoire
            if #(plyCoords - pos1) < 15 then
                interval = 1
                DrawMarker(22,  Configambulance.points.armoire, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos1) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la pharmacie")
                    if IsControlJustPressed(1,51) then
                        openMenuambulanceArmoire()
                    end
                end
            end
            local pos2 = Configambulance.points.AchatVehicle
            if #(plyCoords - pos2) < 15 then
                interval = 1
                DrawMarker(22,  Configambulance.points.AchatVehicle, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos2) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter des véhicules")
                    if IsControlJustPressed(1,51) then
                        OpenVehicleSpawnerMenuEMS('EMS')
                    end
                end
            end
            local pos3 = Configambulance.points.vestiairenord
            if #(plyCoords - pos3) < 15 then
                interval = 1
                DrawMarker(22,  Configambulance.points.vestiairenord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos3) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        openMenuambulanceVestiaire()
                    end
                end
            end
            local pos4 = Configambulance.points.armoirenord
            if #(plyCoords - pos4) < 15 then
                interval = 1
                DrawMarker(22,  Configambulance.points.armoirenord, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                if #(plyCoords - pos4) <= 1.2 and not isMenuOpened then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la pharmacie")
                    if IsControlJustPressed(1,51) then
                        openMenuambulanceArmoire()
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function OpenVehicleSpawnerMenuEMS(station)
    local playerCoords = GetEntityCoords(PlayerPedId())
    PlayerData = ESX.GetPlayerData()
    if ESX.PlayerData.job.grade < 7 then 
        ESX.ShowNotification("~r~Problème~s~ : Vous n'avez pas le grade requis")
    else
        if not VehEMS then
            VehEMS = true
            RageUI.Visible(RMenu:Get('ambulance', 'ambulance_veh_main'), true)
            Citizen.CreateThread(function()
                while VehEMS do
                    Citizen.Wait(1)
                    RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_veh_main'),true,true,true,function()
                        RageUI.Separator("↓ ~b~Types de véhicules ~s~↓")
                        RageUI.ButtonWithStyle("Véhicules", nil, {RightLabel = "→→" }, true, function(_,_,s)
                            if s then
                                local shopElements, shopCoords = {}
                                shopCoords = Configambulance.points.InsideShop
                                if #Configambulance.AuthorizedVehicles['Shared'] > 0 then
                                    for k,vehicle in ipairs(Configambulance.AuthorizedVehicles['Shared']) do
                                        table.insert(shopElements, {
                                            label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, ESX.Math.GroupDigits(vehicle.price)),
                                            name  = vehicle.label,
                                            model = vehicle.model,
                                            price = vehicle.price,
                                            typeveh  = 'car'
                                        })
                                    end
                                end
                                OpenShopMenuEMS(shopElements, playerCoords, shopCoords)
                            end
                        end)
                        RageUI.ButtonWithStyle("Hélicoptère", nil, {RightLabel = "→→" }, true, function(_,_,s)
                            if s then
                                local shopElements, shopCoords = {}
                                shopCoords = Configambulance.points.InsideShop
                                local authorizedHelicopters = Configambulance.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]
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
                                    OpenShopMenuEMS(shopElements, playerCoords, shopCoords)
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
end

function OpenShopMenuEMS(elements, restoreCoords, shopCoords)
    restoreCoords = restoreCoords
    local playerPed = PlayerPedId()
    if not VehSelectEMS then
        VehSelectEMS = true
        thismodel = nil
        RageUI.Visible(RMenu:Get('ambulance', 'ambulance_vehselect_main'), true)
        Citizen.CreateThread(function()
            WaitForVehicleToLoadEMS(elements[1].model)
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
            while VehSelectEMS do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get("ambulance",'ambulance_vehselect_main'),true,true,true,function()
                    for k,v in ipairs(elements) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→→" }, true, function(h,a,s)
                            if a then
                                if v.model ~= thismodel then
                                    DeleteSpawnedVehiclesEMS()
                                    WaitForVehicleToLoadEMS(v.model)
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

                                ESX.TriggerServerCallback('ambulance:buyJobVehicle', function (bought)
                                    if bought then
                                        ESX.ShowNotification('Vehicule transféré au garage')

                                        RageUI.CloseAll()
                                        VehSelectEMS = false
                                        DeleteSpawnedVehiclesEMS()
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

function DeleteSpawnedVehiclesEMS()
    while #spawnedVehicles > 0 do
        local vehicle = spawnedVehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(spawnedVehicles, 1)
    end
end

function WaitForVehicleToLoadEMS(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
            DisableAllControlActions(0)

            drawLoadingTextEMS('Chargement du model...', 255, 255, 255, 255)
        end
    end
end

function drawLoadingTextEMS(text, red, green, blue, alpha)
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

AddEventHandler('god:onPlayerDeath', function(data)
    if not FirstSpawn then
        OnPlayerDeath()
    end
end)

local Uniformspatient = {
    blouse = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1']  = 205, ['torso_2']  = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms']     = 15, ['pants_1']  = 51,
            ['pants_2']  = 0,   ['shoes_1']  = 5,
            ['shoes_2']  = 0,  ['chain_1']  = 0,
            ['chain_2']  = 0
        },
        female = {
            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
            ['torso_1'] = 46, ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 9,
            ['pants_1'] = 5, ['pants_2'] = 10,
            ['shoes_1'] = 5, ['shoes_2'] = 0,
            ['chain_1'] = 1, ['chain_2'] = 0,
        }
    }
}

RegisterNetEvent("ambulance:setskin")
AddEventHandler("ambulance:setskin", function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Uniformspatient['blouse'].male)
        else
            TriggerEvent('skinchanger:loadClothes', skin, Uniformspatient['blouse'].female)
        end
    end)
end)

RegisterNetEvent("elderslife:PlayCPR")
AddEventHandler("elderslife:PlayCPR", function(playerheading, playercoords, playerlocation)

    ClampGameplayCamPitch(0.0, -90.0)
    local heading = 0.0
    local coords = GetEntityCoords(PlayerPedId())
    local x, y, z = table.unpack(playercoords + playerlocation)
    NetworkResurrectLocalPlayer(x, y, z, playerheading, true, false)
    SetEntityHeading(PlayerPedId(), playerheading - 270.0)
    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_b@cpr_def", "cpr_intro", 8.0, 8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(14900)
    for i=1, 15, 1 do
        Citizen.Wait(900)
        TaskPlayAnim(PlayerPedId(), "mini@cpr@char_b@cpr_str", "cpr_pumpchest", 8.0, 8.0, -1, 0, 0, false, false, false)
    end
    TaskPlayAnim(PlayerPedId(), "mini@cpr@char_b@cpr_str", "cpr_success", 8.0, 8.0, -1, 0, 0, false, false, false)
end)

RegisterNetEvent('ambulance:heal')
AddEventHandler('ambulance:heal', function(healType, quiet)
    local maxHealth = GetEntityMaxHealth(PlayerPedId())
    if healType == 'small' then
        local health = GetEntityHealth(PlayerPedId())
        -- local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
        SetEntityHealth(PlayerPedId(), maxHealth)
    end
    if not quiet then
        ShowNotification("~g~Vous avez fini de soigner~s~ le patient !")
    end
end)

function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(ped, false)
    IsDead = false
    ClearPedBloodDamage(ped)
end

RegisterNetEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    TriggerServerEvent('ambulance:setDeathStatus', 0)
    RageUI.CloseAll()
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        ESX.SetPlayerData('lastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })
        TriggerServerEvent('god:updateLastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })
        RespawnPed(playerPed, {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })
        StopScreenEffect('DeathFailOut')
        isDead = false    
        EndDeathCam()
        MenuOpen = false
        DidCall = false
        earlySpawnTimer = 30
        Normal()
        DoScreenFadeIn(800)
        TriggerEvent("god_status:add", "thirst", 1000000)
        TriggerEvent("god_status:add", "hunger", 1000000)
        TriggerEvent("god_status:remove", "stress", 1000000)
    end)
end)

function Normal()
    local playerPed = PlayerPedId()
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    SetPedMotionBlur(playerPed, false)
end

RegisterNetEvent('ambulance:ambulance:Alerte')
AddEventHandler('ambulance:ambulance:Alerte', function(coords, raison)
    if raison == 'petit' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        textrenfort = 'Demande [~b~Légère~s~]'
        sprite = 161
        scale = 0.5
    elseif raison == 'grande' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
        PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
        PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
        textrenfort = 'Demande [~o~Importante~s~]'
        sprite = 161
        scale = 0.7
    end
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, sprite)
    SetBlipScale(blipId, scale)
    SetBlipColour(blipId, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(textrenfort)
    EndTextCommandSetBlipName(blipId)
    Wait(70 * 1000)
    RemoveBlip(blipId)
end)

function blipsForPayerDead(coord)
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(coord.x, coord.y, coord.z)
        SetBlipSprite(blip, 409)
        SetBlipAsShortRange(blip, false)
        SetBlipColour(blip, 3)
        SetBlipScale(blip, 0.7)
        SetBlipCategory(blip, 12)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[ACCIDENT] Patient")
        EndTextCommandSetBlipName(blip)
        SetBlipRoute(blip,  true)
        active = true
        TriggerEvent("removeBlips", active, blip, coord)
        table.insert(tableBlip, blip)
    end)
end

function removeAllBlips()
    for k, v in pairs(tableBlip) do
        RemoveBlip(v)
    end
    tableBlip = {}
end

RegisterCommand('ambulance', function()
    if ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "offambulance" then
        openMenuambulanceF6()
    end
end)

RegisterKeyMapping('ambulance', 'Menu Job : ambulance', 'keyboard', 'F6')

------------------------- chaise roulante

Citizen.CreateThread(function()
    while true do
        local sleep = 500

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        local closestObject = GetClosestObjectOfType(pedCoords, 0.7, GetHashKey("prop_wheelchair_01"), false)

        if DoesEntityExist(closestObject) then
            sleep = 1

            local wheelChairCoords = GetEntityCoords(closestObject)
            local wheelChairForward = GetEntityForwardVector(closestObject)
            
            local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
            local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)

            if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.0 then
                DrawText3Ds(sitCoords, "Appuyez sur ~b~[G]~w~pour vous assoir sur le fauteuil", 0.4)

                if IsControlJustPressed(0, 58) then
                    Sit(closestObject)
                end
            end

            if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.0 then
                if dejaassis == false then
                    DrawText3Ds(pickupCoords, "Appuyez sur ~b~[G]~w~pour pousser le fauteuil", 0.4)

                    if IsControlJustPressed(0, 58) then
                        PickUp(closestObject)
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

Sit = function(wheelchairObject)
    dejaassis = true
    local closestPlayer, closestPlayerDist = GetClosestPlayer()
    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
            ShowNotification("Quelqu\'un est déjà assis sur ce fauteuil!")
            return
        end
    end
    LoadAnim("missfinale_c2leadinoutfin_c_int")
    AttachEntityToEntity(PlayerPedId(), wheelchairObject, 0, 0, 0.0, 0.4, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(wheelchairObject)
    while IsEntityAttachedToEntity(PlayerPedId(), wheelchairObject) do
        Citizen.Wait(5)
        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
            ClearPedTasks(PlayerPedId())
        end
        if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 3) then
            TaskPlayAnim(PlayerPedId(), 'missfinale_c2leadinoutfin_c_int', '_leadin_loop2_lester', 8.0, 8.0, -1, 69, 1, false, false, false)
        end
        ESX.ShowHelpNotification("~INPUT_VEH_DUCK~ pour vous lever")
        if IsControlJustPressed(0, 73) then
            DetachEntity(PlayerPedId(), true, true)
            local x, y, z = table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * - 0.7)
            SetEntityCoords(PlayerPedId(), x,y,z)
            ClearPedTasks(PlayerPedId())
        end
    end
end

PickUp = function(wheelchairObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
            ShowNotification("Impossible ! \nQuelqu\'un utilise déjà ce fauteuil !")
            return
        end
    end
    NetworkRequestControlOfEntity(wheelchairObject)
    LoadAnim("anim@heists@box_carry@")
    AttachEntityToEntity(wheelchairObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0, -0.3, -0.73, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
    while IsEntityAttachedToEntity(wheelchairObject, PlayerPedId()) do
        Citizen.Wait(5)
        if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end
        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(wheelchairObject, true, true)
            ClearPedTasks(PlayerPedId())
        end
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            DetachEntity(wheelchairObject, true, true)
            ClearPedTasks(PlayerPedId())
        end
        ESX.ShowHelpNotification("~INPUT_VEH_DUCK~ pour lacher la chaise")
        if IsControlJustPressed(0, 73) then
            DetachEntity(wheelchairObject, true, true)
            ClearPedTasks(PlayerPedId())
        end
    end
end

DrawText3Ds = function(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

LoadAnim = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(1)
    end
end

-------------------------- brancard ----------------------

local starter, playerBrancard, brancardInVehicule, object = false, false, false, nil
local vehiculeIndex = {}

local function attachEntityOnPed(propObject)
    playerBrancard = true
    NetworkRequestControlOfEntity(propObject)

    LoadAnim("anim@heists@box_carry@")
    
    AttachEntityToEntity(propObject, PlayerPedId(), PlayerPedId(), 0.0, 1.6, -0.43 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

    while IsEntityAttachedToEntity(propObject, PlayerPedId()) and playerBrancard do
        Citizen.Wait(1)
        local playerPos = GetEntityCoords(PlayerPedId())

        if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
            TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(PlayerPedId()) then
            ClearPedTasksImmediately(PlayerPedId())
            DetachEntity(propObject, true, true)
        end

        if range == false then
            ESX.ShowHelpNotification("~INPUT_VEH_DUCK~ pour lacher le brancard")
            if IsControlJustPressed(0, 73) then
                ClearPedTasksImmediately(PlayerPedId())
                Wait(100)
                DetachEntity(propObject, true, true)
                playerBrancard = false
            end
        end

        for k,v in pairs(configbrancard.vehicule) do
            local vehiculeInZone = GetClosestVehicle(playerPos, 7.0, GetHashKey(v.vehiculeName), 18)
            if not vehiculeIndex[vehiculeInZone] then
                vehiculeIndex[vehiculeInZone] = {vehicule = vehiculeInZone, brancardCoffre = false}
                if vehiculeIndex[vehiculeInZone].vehicule ~= 0 then
                    if not vehiculeIndex[vehiculeInZone].brancardCoffre then
                        local vehiculeZone = (GetEntityCoords(vehiculeIndex[vehiculeInZone].vehicule) + GetEntityForwardVector(vehiculeIndex[vehiculeInZone].vehicule) * -v.zone)
                        local dst = #(vehiculeZone-playerPos)

                        if dst <= 1.5 then
                            range = true
                            ESX.ShowHelpNotification("~INPUT_DETONATE~ pour ranger dans le brancard")
                            if IsControlJustPressed(0, 47) then
                                ClearPedTasksImmediately(PlayerPedId())
                                DetachEntity(propObject, true, true)
                                playerBrancard = false
                                vehiculeIndex[vehiculeInZone].brancardCoffre = true
                                attachEntityOnVehicule(propObject, vehiculeIndex[vehiculeInZone].vehicule, v.depth, v.height)
                            end
                        else
                            range = false
                        end
                    end
                end
            else
                if vehiculeIndex[vehiculeInZone].vehicule ~= 0 then
                    if not vehiculeIndex[vehiculeInZone].brancardCoffre then
                        local vehiculeZone = (GetEntityCoords(vehiculeIndex[vehiculeInZone].vehicule) + GetEntityForwardVector(vehiculeIndex[vehiculeInZone].vehicule) * -v.zone)
                        local dst = #(vehiculeZone-playerPos)

                        if dst <= 1.5 then
                            range = true
                            ESX.ShowHelpNotification("~INPUT_DETONATE~ pour ranger dans le brancard")
                            if IsControlJustPressed(0, 47) then
                                ClearPedTasksImmediately(PlayerPedId())
                                DetachEntity(object, true, true)
                                playerBrancard = false
                                vehiculeIndex[vehiculeInZone].brancardCoffre = true
                                attachEntityOnVehicule(propObject, vehiculeIndex[vehiculeInZone].vehicule, v.depth, v.height)
                            end
                        else
                            range = false
                        end
                    end
                end
            end
        end

    end
end

function InitbrancardSystemStory()
    starter = true

    Citizen.CreateThread(function()
        while starter do
            local playerInAmbulance = false
            local playerPos = GetEntityCoords(PlayerPedId())

            for k,v in pairs(configbrancard.getAllowedJob) do
                if ESX.PlayerData.job.name == v then
                    for k,v in pairs(configbrancard.vehicule) do
                        local vehiculeInZone = GetClosestVehicle(playerPos, 7.0, GetHashKey(v.vehiculeName), 18)
                        if not vehiculeIndex[vehiculeInZone] then
                            vehiculeIndex[vehiculeInZone] = {vehicule = vehiculeInZone, brancardCoffre = false}
                            if vehiculeIndex[vehiculeInZone].vehicule ~= 0 then
                                if not vehiculeIndex[vehiculeInZone].brancardCoffre then
                                    local vehiculeZone = (GetEntityCoords(vehiculeIndex[vehiculeInZone].vehicule) + GetEntityForwardVector(vehiculeIndex[vehiculeInZone].vehicule) * -v.zone)
                                    local distancePlayerVehicule = #(vehiculeZone-playerPos)

                                    if distancePlayerVehicule <= 1 then
                                        playerInAmbulance = true
                                        if not playerBrancard then
                                            if not IsEntityAttachedToEntity(entityModel, PlayerPedId()) then
                                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir le brancard")
                                                if IsControlJustPressed(0, 51) then
                                                    local entityModel = GetHashKey(configbrancard.brancard)
                                                    while not HasModelLoaded(entityModel) do
                                                        RequestModel(entityModel)
                                                        Citizen.Wait(1)
                                                    end
                                                    local playerHeading = GetEntityHeading(PlayerPedId())
                                                    local brancardObject = CreateObject(entityModel, playerPos, true)
                                                    SetEntityHeading(PlayerPedId(), (playerHeading - 180.0))
                                                    object = brancardObject
                                                    vehiculeIndex[vehiculeInZone].brancardCoffre = false
                                                    attachEntityOnPed(brancardObject)
                                                end
                                            else
                                                ESX.ShowNotification("Impossible vous avez déjà un brancard !")
                                            end
                                        end
                                    end
                                end
                            end
                        --[[else
                            if vehiculeIndex[vehiculeInZone].vehicule ~= 0 then
                                if not vehiculeIndex[vehiculeInZone].brancardCoffre then
                                    local vehiculeZone = (GetEntityCoords(vehiculeIndex[vehiculeInZone].vehicule) + GetEntityForwardVector(vehiculeIndex[vehiculeInZone].vehicule) * -v.zone)
                                    local distancePlayerVehicule = #(vehiculeZone-playerPos)

                                    if distancePlayerVehicule <= 1 then
                                        playerInAmbulance = true
                                        if not playerBrancard then
                                            if not IsEntityAttachedToEntity(entityModel, PlayerPedId()) then
                                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir le brancard")
                                                if IsControlJustPressed(0, 51) then
                                                    local entityModel = GetHashKey(configbrancard.brancard)
                                                    while not HasModelLoaded(entityModel) do
                                                        RequestModel(entityModel)
                                                        Citizen.Wait(1)
                                                    end
                                                    local playerHeading = GetEntityHeading(PlayerPedId())
                                                    local brancardObject = CreateObject(entityModel, playerPos, true)
                                                    SetEntityHeading(PlayerPedId(), (playerHeading - 180.0))
                                                    object = brancardObject
                                                    vehiculeIndex[vehiculeInZone].brancardCoffre = false
                                                    attachEntityOnPed(brancardObject)
                                                end
                                            else
                                                ESX.ShowNotification("Impossible vous avez déjà un brancard !")
                                            end
                                        end
                                    end
                                end
                            end]]--
                        end
                    end
                end
            end

            local brancardEntity = GetClosestObjectOfType(playerPos, 1.0, GetHashKey('v_med_emptybed'), false)

            if DoesEntityExist(brancardEntity) then
                local brancardPos = GetEntityCoords(brancardEntity)
                local brancardForward = GetEntityForwardVector(brancardEntity)
                local brancardCoords = (brancardPos + brancardForward)
                local distancePlayerBrancard = #(brancardCoords-playerPos)

                if distancePlayerBrancard <= 5 then 
                    playerInAmbulance = true
                    if not IsEntityAttachedToEntity(brancardEntity, PlayerPedId()) then
                        if distancePlayerBrancard <= 3 then
                            ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour pousser le brancard / ~INPUT_DETONATE~ pour monter dans le brancard")
                            if IsControlJustPressed(0, 51) then
                                attachEntityOnPed(brancardEntity)
                            end
                            if IsControlJustPressed(0, 47) then
                                coucher = true
                                LoadAnim("savecouch@")
                                AttachEntityToEntity(PlayerPedId(), brancardEntity, PlayerPedId(), 0, 0, 0.7, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
                                TaskPlayAnim(PlayerPedId(), "savecouch@", "t_sleep_loop_couch", 8.0, 8.0, -1, 1, 0, false, false, false)
                            end
                        end
                    end

                    if IsControlJustPressed(0, 73) then
                        coucher = false
                        DetachEntity(PlayerPedId(), true, true)
                        ClearPedTasksImmediately(PlayerPedId())
                    end

                    if coucher == true then
                        ESX.ShowHelpNotification("~INPUT_VEH_DUCK~ pour se lever du brancard")
                    end
                end
            end
 
            if not playerInAmbulance then
                Wait(500)
            else
                Wait(1)
            end
        end
    end)
end

RegisterCommand("debugbrancard", function()
    vehiculeIndex = {}
    DeleteEntity(object)
    playerBrancard = false
    brancardInVehicule = false
    object = nil
end, false)