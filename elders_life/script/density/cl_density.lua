local DensityMultiplier = 0.4
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetPedDensityMultiplierThisFrame(DensityMultiplier)
        SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)

        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
        SetPedSuffersCriticalHits(PlayerPedId(), false)
        DisablePlayerVehicleRewards(PlayerId())
        SetPedHelmet(PlayerPedId(), false)
        if IsPedOnFoot(PlayerPedId() ) then 
            SetRadarZoom(1100)
        elseif IsPedInAnyVehicle(PlayerPedId() , true) then
            SetRadarZoom(1100)
        end
     --------------KARTING
        ClearAreaOfVehicles(-85.162, -2067.108, 21.797, 1000, false, false, false, false, false)  
        RemoveVehiclesFromGeneratorsInArea(-85.162 - 90.0, -2067.108 - 90.0, 21 - 90.0, -85.162 + 90.0, 2067.108 + 90.0, 21 + 90.0)
      -------------KARTING          
        --full stamina
        RestorePlayerStamina(PlayerId(), 1.0)
        --régénération de vie a 0
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

        if IsPedArmed(PlayerPedId(), 4 | 2) then 
            if IsAimCamActive() then 
                DisableControlAction(0, 22, true)
            end 
        end 
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(13)
        --HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(20)
    end
end)