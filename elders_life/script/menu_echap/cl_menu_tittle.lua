local players = math.random(10,30)

RegisterNetEvent("elders_utils:GetNumPlayers")
AddEventHandler("elders_utils:GetNumPlayers", function(num)
    players = num
end)

Citizen.CreateThread(function()
    while true do
        local name = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
        TriggerServerEvent("elders_utils:GetNumPlayers")

        SetDiscordAppId(761221197685850112)
        SetDiscordRichPresenceAsset("logo_elders")
        SetDiscordRichPresenceAssetText("Elder's Life Rp");
        SetDiscordRichPresenceAssetSmallText('https://discord.gg/eldersliferp')
        SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. players .. " joueur(s) en ligne")
        SetDiscordRichPresenceAction(0, "💬 Discord", "https://discord.gg/eldersliferp");
        SetDiscordRichPresenceAction(1, " 🎮 Se connecter", "fivem://connect/cfx.re/4r5zoo");


        AddTextEntry('PM_SCR_MAP', '~b~Carte de Los Santos')
        AddTextEntry('PM_SCR_GAM', '~r~Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', '~g~Logs')
        AddTextEntry('PM_SCR_SET', '~p~Configuration')
        AddTextEntry('PM_SCR_STA', '~b~Statistiques')
        AddTextEntry('PM_SCR_GAL', '~y~Galerie')
        AddTextEntry('PM_SCR_RPL', '~y~Éditeur ∑')
        AddTextEntry('PM_PANE_CFX', '~y~Elders Life')
        AddTextEntry('FE_THDR_GTAO', "~w~Elders Life ~m~| ~b~discord.gg/8pzkh9GNAq ~m~| ~b~ID : ~w~".. GetPlayerServerId(PlayerId()) .." ~m~| ~b~".. players .. "~w~/~b~256 ~w~joueurs ~b~en ligne")
        AddTextEntry('PM_PANE_LEAVE', '~p~Se déconnecter de Elders Life');
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
        local opti = #GetActivePlayers()*2
        Citizen.Wait(opti+120*1000)
    end
end)