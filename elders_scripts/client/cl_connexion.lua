ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(500)
    end
end)

local function openMenuConnexion()
    TriggerEvent("god_loading:screenhide")
    DoScreenFadeIn(10000)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(cam, Configconnexion.camcoords)
    SetCamRot(cam, 0.0, 0.0, Configconnexion.heading)
    SetCamFov(cam, 70.0)
    ShakeCam(cam, "HAND_SHAKE", 0.1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true)
    DisplayRadar(false)

                    ESX.ShowNotification("~g~Veuillez patienter, nous préparons votre personnage...")
                    Citizen.Wait(8000)
                    DestroyCam(cam, false)
                    RenderScriptCams(false, true, 1500, false, false)
                    SetEntityVisible(PlayerPedId(), true)
                    TriggerEvent('god:playerLoadedHUD')
                    FreezeEntityPosition(PlayerPedId(), false)
                    DisplayRadar(true)
                    spawn = false
                    isMenuOpened = false
                    TriggerEvent('ambulance:CheckIfDeath')
                    Citizen.Wait(1000)
                    TriggerEvent('elders_demarche:lancement')
end


local spawn = true

AddEventHandler("playerSpawned", function()
    Citizen.Wait(1000)
    if spawn then
        TriggerServerEvent("aSpawnpoint:requestlife")
        Citizen.Wait(500)
        ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, jobSkin)
            if skin == nil then
                spawn = false
            else
                local isMale = skin.sex == 0
                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                    ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end)
            end
        end)
        Citizen.Wait(3000)
        if spawn then
            openMenuConnexion()
        else
            TriggerEvent("god_loading:screenhide")
            DoScreenFadeIn(10000)
        end
    end
end)

RMenu.Add("connexion", "princ", RageUI.CreateMenu(Configconnexion.name, "~b~Options :", nil, nil, "aLib", "black"))
RMenu:Get("connexion", "princ").Closed = function()
    isMenuOpened = false
end

RMenu:Get("connexion", "princ").Closable = false