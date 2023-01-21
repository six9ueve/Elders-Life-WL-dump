RMenu.Add('LifeInvaders', 'main', RageUI.CreateMenu("Elders Interim", " "))
RMenu:Get('LifeInvaders', 'main'):SetSubtitle("~b~Elders Jobs central d'intérim")
RMenu:Get('LifeInvaders', 'main').EnableMouse = false;
RMenu:Get('LifeInvaders', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local metier = {
    chantier = {
    	job = "chantier",
        nom = "Travailler sur le chantier",
        desc = "Viens travailler au chantier, avoir des muscles dans les bras est obligatoire ! Pas pour les feignants ! ~g~aucun diplôme demandé.",
        coords = zone.Chantier,
    },
    jardinier = {
    	job = "jardinier",
        nom = "Nettoyer le terrain de golf",
        desc = "Viens aider les jardiniers du golf à faire leur travaille ! Travaille assez posé dans un environnement agréable, véhicule fourni sans diplôme demandé.",
        coords = zone.Jardinier,
    },
    ups = {
        job = "Livreur",
        nom = "Livrer des colis",
        desc = "Viens aider à livrer des colis dans la ville ! Véhicule fourni, tenue aussi, ~g~ PERMIS OBLIGATOIRE.",
        coords = zone.ups,
    },
    Chomage = {
        job = "chomeur",
        nom = "Se mettre au chomage",
        desc = "Vous ne voulez plus travailler, mettez vous au chomage !",
        coords = zone.chomage,
    },
    poubelle = {
        job = "eboueur",
        nom = "Travailler en tant qu'éboueur",
        desc = "Viens travailler en tant qu'éboueur !",
        coords = zone.poubelle,
    },
}


RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), zone.Lifeinveders, true)
    if distance <= 4.0 then
        HelpMsg("Appuyer sur [ ~b~E~w~ ] pour chercher un emploi.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('LifeInvaders', 'main'), not RageUI.Visible(RMenu:Get('LifeInvaders', 'main')))
            CreateCamera()
        end
    else
    Citizen.Wait(1000)
    end

    if RageUI.Visible(RMenu:Get('LifeInvaders', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
        
            for _,v in pairs(metier) do
                RageUI.Button(v.nom, v.desc, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    	TriggerServerEvent('duty:setjobANPE', v.job)
                        SetNewWaypoint(v.coords)
                        RageUI.Visible(RMenu:Get('LifeInvaders', 'main'), not RageUI.Visible(RMenu:Get('LifeInvaders', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        RageUI.Popup({
                            message = "Vous avez choisis de ~b~"..v.nom.."~w~ ? Très bien, je vous ai donné les coordonées GPS sur votre téléphone. ~g~Merci d'utiliser les services Elders-Jobs !",
                            sound = {
                                audio_name = "BASE_JUMP_PASSED",
                                audio_ref = "HUD_AWARDS",
                            }
                        })
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end
end, 1)

