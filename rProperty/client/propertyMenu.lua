Cfg_Property.openPropertyMenu = function(pK,pV)
    RMenu.Add("nProperty_Owned", "main_menu", RageUI.CreateMenu("Propriété","INTÉRACTIONS"))
    RMenu:Get("nProperty_Owned", "main_menu").Closed = function()
        Cfg_Property.main_Menu.ownedMenuIsOpen = false 
    end
    if Cfg_Property.main_Menu.ownedMenuIsOpen then
        RageUI.CloseAll()
        Cfg_Property.main_Menu.ownedMenuIsOpen = false
    else
        Cfg_Property.main_Menu.ownedMenuIsOpen = true
        RageUI.Visible(RMenu:Get("nProperty_Owned", "main_menu"), true)
        Citizen.CreateThread(function()
            Cfg_Property.changeColorIndex()
            while Cfg_Property.main_Menu.ownedMenuIsOpen do
                Citizen.Wait(0)
                RageUI.IsVisible(RMenu:Get("nProperty_Owned", "main_menu"), function()
                    if Cfg_Property.main_Menu.Colors ~= nil then
                        RageUI.Separator("↓ "..Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Information(s) ~s~↓")
                        RageUI.Separator("Numéro de votre propriété : ~b~"..pV.label)
                        RageUI.Separator("Rue : ~b~"..GetStreetNameFromHashKey(GetStreetNameAtCoord(json.decode(pV.pEnterPos).x,json.decode(pV.pEnterPos).y, json.decode(pV.pEnterPos).z)))
                        --RageUI.Separator("Garage : ~b~"..#json.decode(pV.pVehicules).."/"..pV.gPlaces.."~s~ - places disponible")
                        RageUI.Separator("Niveau de sécurité : ~b~"..pV.security.."")
                        RageUI.Separator("↓ "..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors].."Intéraction(s) ~s~↓")
                        RageUI.Button("Entrer dans votre propriété", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                RageUI.CloseAll()
                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                Cfg_Property.main_Menu.ownedMenuIsOpen = false
                                Cfg_Property.inPropertyOwned(pK,pV)
                            end,
                        })
                    end
                end)
            end
        end)
    end
end

hasCloched = false

Cfg_Property.openPropertySonneMenu = function(pK,pV)
    RMenu.Add("nProperty_Owned", "main_menu", RageUI.CreateMenu("Propriété","INTÉRACTIONS"))
    RMenu:Get("nProperty_Owned", "main_menu").Closed = function()
        Cfg_Property.main_Menu.ownedMenuIsOpen = false 
    end
    if Cfg_Property.main_Menu.ownedMenuIsOpen then
        RageUI.CloseAll()
        Cfg_Property.main_Menu.ownedMenuIsOpen = false
    else
        Cfg_Property.main_Menu.ownedMenuIsOpen = true
        RageUI.Visible(RMenu:Get("nProperty_Owned", "main_menu"), true)
        Citizen.CreateThread(function()
            Cfg_Property.changeColorIndex()
            while Cfg_Property.main_Menu.ownedMenuIsOpen do
                Citizen.Wait(0)
                RageUI.IsVisible(RMenu:Get("nProperty_Owned", "main_menu"), function()
                    if Cfg_Property.main_Menu.Colors ~= nil then
                        RageUI.Separator("↓ "..Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Information(s) ~s~↓")
                        if Cfg_Property.ESXLoaded.PlayerData.job.name == "realestateagent" then
                            RageUI.Separator("Propriétaire : ~b~"..pV.name)
                        end
                        RageUI.Separator("Numéro de la propriété : ~b~"..pV.label)
                        RageUI.Separator("Rue : ~b~"..GetStreetNameFromHashKey(GetStreetNameAtCoord(json.decode(pV.pEnterPos).x,json.decode(pV.pEnterPos).y, json.decode(pV.pEnterPos).z)))
                        RageUI.Separator("↓ "..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors].."Intéraction(s) ~s~↓")
                        RageUI.Button("Sonner à la propriété", nil, {RightLabel = "→→"}, pV.ouvreferme, {
                            onSelected = function()
                                RageUI.CloseAll()
                                if not hasCloched then
                                    hasCloched = true
                                    Cfg_Property.Popup("Vous sonner à la propriété !")
                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":clochInProperty", pV.propertyID, pV.pNumber)
                                    Citizen.SetTimeout(7500, function()
                                        hasCloched = false
                                    end)
                                else
                                    Cfg_Property.Popup("~r~Veuillez patienter avant de re-sonner !")
                                end
                            end,
                        })
                        RageUI.Button("Entrer dans la propriété", nil, {RightLabel = "→→"}, not pV.ouvreferme, {
                            onSelected = function()
                                RageUI.CloseAll()
                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                Cfg_Property.inPropertyOwned(pK,pV)
                            end,
                        })
                        RageUI.Button("Cambrioler la propriété", nil, {RightLabel = "→→"}, pV.ouvreferme, {
                            onSelected = function()
                                RageUI.CloseAll()
                                Citizen.Wait(250)
                                Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":verifepolice", function(cops)
                                    if cops then
                                        Citizen.Wait(125)
                                        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":checkifonline", function(online)
                                            if online then
                                                Citizen.Wait(125)
                                                Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":GetSecurity", function(security)
                                                    if security == '0' then
                                                        Cfg_Property.brokesecure1(pK,pV)
                                                    elseif security == '1' then
                                                        Cfg_Property.brokesecure2(pK,pV)
                                                    elseif security == '2' then
                                                        Cfg_Property.brokesecure3(pK,pV)
                                                    elseif security == '3' then
                                                        Cfg_Property.brokesecure4(pK,pV)
                                                    end
                                                end, pV.propertyID)
                                            else
                                                Cfg_Property.Popup("~r~Le propriétaire de la maison dors à l'intérieur !")
                                            end
                                        end, pV.propertyID)
                                    else
                                        Cfg_Property.Popup("~r~Pas assez de flics en service !")
                                    end
                                end)
                            end,
                        })
                        RageUI.Button("Perquisitioner la propriété", nil, {RightLabel = "→→"}, Cfg_Property.ESXLoaded.PlayerData.job.name == "police" or Cfg_Property.ESXLoaded.PlayerData.job.name == "sheriff", {
                            onSelected = function()
                                RageUI.CloseAll()
                                    Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":CheckLicense", function(license)
                                        if license then
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", GetEntityCoords(PlayerPedId()), true)
                                            Cfg_Property.inPropertyOwned(pK,pV)
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvremaisoncambriolage", pV.propertyID)
                                            Cfg_Property.Popup("~r~Vous etes rentré avec votre mandat de perquisition !")
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":deletemandat", 'mandat')
                                            Cfg_Property.ServerSide("Elders_log:perquisition", "```"..GetPlayerName(PlayerId()).." vient de perquisitionner la propriété numéro "..pV.label.."\n```")
                                        else
                                            Cfg_Property.Popup("~r~Vous n'avez pas de mandat de perquisition !")
                                        end
                                    end, 'mandat')
                            end,
                        })
                    end
                end)
            end
        end)
    end
end

Cfg_Property.inPropertyOwned = function(pK,pV)
    Citizen.CreateThread(function()
        Cfg_Property.ServerSide(Cfg_Property.Prefix..":enterInProperty", pV.propertyID)
        Cfg_Property.Popup("Vous êtes entrer dans la propriété : ~b~"..pV.label)
        local actualityP = Cfg_Property.main_Menu.propertyList[tonumber(pV.pNumber)]
        Cfg_Property.main_Menu.onVisiting = true
        Cfg_Property.main_Menu.lastPos = GetEntityCoords(PlayerPedId())
        Citizen.Wait(100)
        SetEntityCoords(PlayerPedId(), actualityP.interiorEntry.pos, false, false, false, false)
        SetEntityHeading(PlayerPedId(), actualityP.interiorEntry.heading)
        while Cfg_Property.main_Menu.onVisiting do
            Citizen.Wait(0)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.interiorExit.pos, true) < 10.0 then
                DrawMarker(20, actualityP.interiorExit.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, actualityP.interiorExit.colorsMarker.r, actualityP.interiorExit.colorsMarker.g, actualityP.interiorExit.colorsMarker.b, 255, false, true, true, false, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.interiorExit.pos, true) < 1.2 then
                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour sortir de votre propriété")
                    if IsControlJustPressed(0, 38) then
                        Cfg_Property.main_Menu.onVisiting = false
                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":savepositionhouse", nil, false)
                    end
                end
            end 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pStock.pos, true) < 10.0 then
                DrawMarker(20, actualityP.pStock.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, actualityP.pStock.colorsMarker.r, actualityP.pStock.colorsMarker.g, actualityP.pStock.colorsMarker.b, 255, false, true, true, false, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pStock.pos, true) < 1.2 then
                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour accéder au coffre")
                    if IsControlJustPressed(0, 38) then
                        Cfg_Property.openManageProperty(pK,pV)
                    end
                end          
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pDressing.pos, true) < 10.0 then
                DrawMarker(20, actualityP.pDressing.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, actualityP.pDressing.colorsMarker.r, actualityP.pDressing.colorsMarker.g, actualityP.pDressing.colorsMarker.b, 255, false, true, true, false, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pDressing.pos, true) < 1.2 then
                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour accéder à votre dressing")
                    if IsControlJustPressed(0, 38) then
                        Cfg_Property.openPropertyDressing(pK,pV)
                    end
                end          
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pGestion.pos, true) < 10.0 then
                DrawMarker(20, actualityP.pGestion.pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, actualityP.pGestion.colorsMarker.r, actualityP.pGestion.colorsMarker.g, actualityP.pGestion.colorsMarker.b, 255, false, true, true, false, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), actualityP.pGestion.pos, true) < 1.2 then
                    Cfg_Property.HelpNotif("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la gestion de la propriété")
                    if IsControlJustPressed(0, 38) then
                        Cfg_Property.openGestionProperty(pK,pV,Cfg_Property.main_Menu.lastPos)
                    end
                end          
            end
        end
        Cfg_Property.ServerSide(Cfg_Property.Prefix..":exitProperty", pV.propertyID)
        Cfg_Property.Popup("Vous êtes sortie de la propriété : ~b~"..pV.label)
        SetEntityCoords(PlayerPedId(), Cfg_Property.main_Menu.lastPos, false, false, false, false)
        actualityP = nil
    end)
end