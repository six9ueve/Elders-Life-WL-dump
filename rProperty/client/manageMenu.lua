ESX                     = nil
ouvreferme = false

Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Cfg_Property.openManageProperty = function(pK,pV)
    RMenu.Add("nProperty_Manage", "main_menu", RageUI.CreateMenu("COFFRE","INTÉRACTIONS"))
    RMenu.Add("nProperty_Manage", "deposit", RageUI.CreateSubMenu(RMenu:Get("nProperty_Manage", "main_menu"), "COFFRE", "INTÉRACTIONS"))
    RMenu.Add("nProperty_Manage", "take", RageUI.CreateSubMenu(RMenu:Get("nProperty_Manage", "main_menu"), "COFFRE", "INTÉRACTIONS"))
    RMenu:Get("nProperty_Manage", "main_menu").Closed = function()
        Cfg_Property.main_Menu.manageMenuIsOpen = false 
    end
    if Cfg_Property.main_Menu.manageMenuIsOpen then
        RageUI.CloseAll()
        Cfg_Property.main_Menu.manageMenuIsOpen = false
    else
        Cfg_Property.main_Menu.manageMenuIsOpen = true
        RageUI.Visible(RMenu:Get("nProperty_Manage", "main_menu"), true)
        Citizen.CreateThread(function()
            Cfg_Property.changeColorIndex()
            Cfg_Property.ServerSide(Cfg_Property.Prefix..":refreshPropertyInventory", pV.propertyID)
            while Cfg_Property.main_Menu.manageMenuIsOpen do
                Citizen.Wait(0)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "main_menu"), function()
                    if Cfg_Property.main_Menu.Colors ~= nil then
                        if Cfg_Property.main_Menu.pWeight ~= nil then
                            RageUI.Separator("↓ Poids du coffre : "..Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors]..Cfg_Property.ESXLoaded.Math.Round(Cfg_Property.main_Menu.pWeight/1000,1).."/"..Cfg_Property.ESXLoaded.Math.Round(tonumber(pV.stockCapacity), 1).."~s~ - KG ↓")
                        end
                        RageUI.Button("Déposer dans le coffre", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                Cfg_Property.main_Menu.pInv = nil
                                Cfg_Property.main_Menu.totalCount = 0
                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":refreshPropertyInventory", pV.propertyID)
                            end
                        }, RMenu:Get("nProperty_Manage", "deposit"))
                        RageUI.Button("Prendre dans le coffre", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                Cfg_Property.main_Menu.propertyInv = nil
                                Cfg_Property.main_Menu.totalCount = 0
                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":refreshPropertyInventory", pV.propertyID)
                            end
                        }, RMenu:Get("nProperty_Manage", "take"))
                    end
                end)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "deposit"), function()
                    if Cfg_Property.main_Menu.pInv ~= nil then
                        RageUI.List("Trier votre inventaire", {"Objet", "Argent"}, Cfg_Property.main_Menu.trItemsIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Cfg_Property.main_Menu.trItemsIndex = Index
                                Cfg_Property.main_Menu.totalCount = 0
                            end,
                            onSelected = function()
                            end,
                        })
                        if Cfg_Property.main_Menu.trItemsIndex == 1 then
                            for k,v in pairs(Cfg_Property.main_Menu.pInv.pInventory) do
                                if v.count > 0 then
                                    Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                    local wItems = {}
                                    wItems[k] = Cfg_Property.DefaultWeight
                                    if Cfg_Property.itemsWeight[v.name] ~= nil then
                                        wItems[k] = Cfg_Property.itemsWeight[v.name]
                                    end
                                    RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..v.count.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = tonumber(Cfg_Property.Keyboard())
                                            if countPut ~= nil then
                                                if countPut <= v.count then
                                                    if Cfg_Property.ESXLoaded.Math.Round(Cfg_Property.main_Menu.pWeight/1000+wItems[k]*countPut/1000, 1) <= Cfg_Property.ESXLoaded.Math.Round(tonumber(pV.stockCapacity), 1) then
                                                        if v.name == 'ankletracker' then
                                                            Visual.Popup({message = "Vous ne pouvez pas enlever le bracelet GPS"})
                                                        else
                                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":depositInProperty", pV.propertyID, v.name, v.label, countPut, "item")
                                                            Visual.Popup({message = "Vous avez déposé~b~ "..countPut.."~s~ - "..v.label.." dans le coffre."})
                                                        end
                                                    else
                                                        Visual.Popup({message = "Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                                    end
                                                else
                                                    Visual.Popup({message = "Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            end
                        --[[elseif Cfg_Property.main_Menu.trItemsIndex == 2 then
                            for k,v in pairs(Cfg_Property.main_Menu.pInv.pLoadout) do
                                Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                local wItems = {}
                                wItems[k] = Cfg_Property.DefaultWeight
                                if Cfg_Property.itemsWeight[v.name] ~= nil then
                                    wItems[k] = Cfg_Property.itemsWeight[v.name]
                                end
                                RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..k.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        local itemWeight = Cfg_Property.DefaultWeight
                                        if Cfg_Property.itemsWeight[v.name] ~= nil then
                                            itemWeight = Cfg_Property.itemsWeight[v.name]
                                        end
                                        if Cfg_Property.ESXLoaded.Math.Round(Cfg_Property.main_Menu.pWeight/1000+wItems[k]/1000, 1) <= Cfg_Property.ESXLoaded.Math.Round(tonumber(pV.stockCapacity), 1) then
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":depositInProperty", pV.propertyID, v.name, v.label, 1, "weapon", v.ammo)
                                            Visual.Popup({message = "Vous avez déposé~b~ 1~s~ - "..v.label.." dans le coffre."})
                                        else
                                            Visual.Popup({message = "Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                        end
                                    end
                                })
                            end]]--
                        else
                            if tonumber(Cfg_Property.main_Menu.pInv.pMoney) > 0 then
                                Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                local wItems = {}
                                wItems["black_money"] = Cfg_Property.DefaultWeight
                                if Cfg_Property.itemsWeight["black_money"] ~= nil then
                                    wItems["black_money"] = Cfg_Property.itemsWeight["black_money"]
                                end
                                RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..tonumber(Cfg_Property.main_Menu.pInv.pMoney).."$~s~] - Argent sale", nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        local countPut = tonumber(Cfg_Property.Keyboard())
                                        if countPut ~= nil then
                                            if countPut <= tonumber(Cfg_Property.main_Menu.pInv.pMoney) then
                                                local itemWeight = Cfg_Property.DefaultWeight
                                                if Cfg_Property.itemsWeight["black_money"] ~= nil then
                                                    itemWeight = Cfg_Property.itemsWeight["black_money"]
                                                end
                                                if Cfg_Property.ESXLoaded.Math.Round(Cfg_Property.main_Menu.pWeight/1000+wItems["black_money"]/1000, 1) <= Cfg_Property.ESXLoaded.Math.Round(tonumber(pV.stockCapacity), 1) then
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":depositInProperty", pV.propertyID, "black_money", "Argent sale", countPut, "money", nil)
                                                    Visual.Popup({message = "Vous avez déposé~r~ "..countPut.."$~s~ - d'argent sale dans le coffre."})
                                                else
                                                    Visual.Popup({message = "~r~Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                                end
                                            else
                                                Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                            end
                                        else
                                            Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                        end
                                    end
                                })
                            end
                        end
                        if Cfg_Property.main_Menu.totalCount == 0 then
                            RageUI.Separator("")
                            RageUI.Separator(Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Cette partie de votre inventaire est vide !")
                            RageUI.Separator("") 
                        end
                    end
                end)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "take"), function()
                    if Cfg_Property.main_Menu.propertyInv ~= nil then
                        RageUI.List("Trier votre coffre", {"Objet", "Argent"}, Cfg_Property.main_Menu.trItemsIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Cfg_Property.main_Menu.trItemsIndex = Index
                                Cfg_Property.main_Menu.totalCount = 0
                            end,
                            onSelected = function()
                            end,
                        })
                        if Cfg_Property.main_Menu.trItemsIndex == 1 then
                            for k,v in pairs(Cfg_Property.main_Menu.propertyInv.Inv) do
                                if v.count > 0 then
                                    Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                    RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..v.count.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = tonumber(Cfg_Property.Keyboard())
                                            if countPut ~= nil then
                                                if countPut <= v.count then
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":takeInProperty", pV.propertyID, k, countPut, "item")
                                                    Visual.Popup({message = "Vous avez retiré~b~ "..countPut.."~s~ - "..v.label.." du coffre."})
                                                else
                                                    Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            end
                        elseif Cfg_Property.main_Menu.trItemsIndex == 2 then
                            for k,v in pairs(Cfg_Property.main_Menu.propertyInv.Loadout) do
                                Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..v.count.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":takeInProperty", pV.propertyID, k, 1, "weapon")
                                        Visual.Popup({message = "Vous avez retiré~b~ 1~s~ - "..v.label.." du coffre."})
                                    end
                                })
                            end
                        else
                            for k,v in pairs(Cfg_Property.main_Menu.propertyInv.Money) do
                                if tonumber(v.money) > 0 then
                                    Cfg_Property.main_Menu.totalCount = Cfg_Property.main_Menu.totalCount+1
                                    RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..tonumber(v.money).."$~s~] - Argent sale", nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = tonumber(Cfg_Property.Keyboard())
                                            if countPut ~= nil then
                                                if countPut <= tonumber(v.money) then
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":takeInProperty", pV.propertyID, "black_money", countPut, "money")
                                                    Visual.Popup({message = "Vous avez retiré~r~ "..countPut.."$~s~ - d'argent sale du coffre."})
                                                else
                                                    Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~r~Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            end
                        end
                        if Cfg_Property.main_Menu.totalCount == 0 then
                            RageUI.Separator("")
                            RageUI.Separator(Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Cette partie de votre coffre est vide !")
                            RageUI.Separator("") 
                        end
                    end
                end)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "players"), function()
                    if #Cfg_Property.main_Menu.playersInProperty[pV.propertyID] <= 0 then
                        RageUI.Separator("")
                        RageUI.Separator(Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Aucun joueur présent dans votre propriété !")
                        RageUI.Separator("") 
                    else
                        for k,v in pairs(Cfg_Property.main_Menu.playersInProperty[pV.propertyID]) do
                            if v.pIdentifier == pV.owner then
                                RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors].."PROPRIÉTAIRE".."~s~] - "..v.pName, nil, {RightLabel = "→→"}, false, {
                                })
                            else
                                RageUI.List("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..k.."~s~] - "..v.pName, {"Attribuer clé", "Retirer clé", "Expulser"}, Cfg_Property.main_Menu.manageIndex, nil, {RightLabel = "→→"}, true, {
                                    onListChange = function(Index, Items)
                                        Cfg_Property.main_Menu.manageIndex = Index
                                    end,
                                    onSelected = function()
                                        if Cfg_Property.main_Menu.manageIndex == 1 then
                                            for k2,v2 in pairs(json.decode(pV.pKeys)) do
                                                if v.pIdentifier == k2 then
                                                    Cfg_Property.Popup("~r~La personne posséde déjà un double des clés")
                                                    return 
                                                end
                                            end
                                            Cfg_Property.Popup("Vous avez attribué les doubles des clés à : ~b~"..v.pName)
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":addKeyProperty", pV.propertyID, v.pIdentifier)
                                        elseif Cfg_Property.main_Menu.manageIndex  == 2 then
                                            for k2,v2 in pairs(json.decode(pV.pKeys)) do
                                                if v.pIdentifier == k2 then
                                                    Cfg_Property.Popup("Vous avez retiré les doubles des clés à : ~b~"..v.pName)
                                                    Cfg_Property.ServerSide(Cfg_Property.Prefix..":removeKeyProperty", pV.propertyID, v.pIdentifier)
                                                    return
                                                end
                                            end
                                            Cfg_Property.Popup("~r~La personne ne posséde pas les clés")
                                        else
                                            Cfg_Property.Popup("Vous avez expulser : ~b~"..v.pName)
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":kickFromProperty", pV.propertyID, v.pIdentifier) 
                                        end
                                    end,
                                })
                            end
                        end
                    end
                end)
            end
        end)
    end
end

Cfg_Property.openGestionProperty = function(pK,pV,exitpos)
    RMenu.Add("nProperty_Manage", "main_menu", RageUI.CreateMenu("Propriété","INTÉRACTIONS"))
    RMenu.Add("nProperty_Manage", "players", RageUI.CreateSubMenu(RMenu:Get("nProperty_Manage", "main_menu"), "Propriété", "INTÉRACTIONS"))
    RMenu.Add("nProperty_Manage", "security_level", RageUI.CreateSubMenu(RMenu:Get("nProperty_Manage", "main_menu"), "Propriété", "INTÉRACTIONS"))

    RMenu.Add("nProperty_Manage", "keys", RageUI.CreateSubMenu(RMenu:Get("nProperty_Manage", "main_menu"), "Propriété", "INTÉRACTIONS"))
    RMenu:Get("nProperty_Manage", "main_menu").Closed = function()
        Cfg_Property.main_Menu.manageMenuIsOpen = false 
    end
    if Cfg_Property.main_Menu.manageMenuIsOpen then
        RageUI.CloseAll()
        Cfg_Property.main_Menu.manageMenuIsOpen = false
    else
        Cfg_Property.main_Menu.manageMenuIsOpen = true
        RageUI.Visible(RMenu:Get("nProperty_Manage", "main_menu"), true)
        Citizen.CreateThread(function()
            Cfg_Property.changeColorIndex()
            while Cfg_Property.main_Menu.manageMenuIsOpen do
                Citizen.Wait(0)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "main_menu"), function()
                    if Cfg_Property.main_Menu.Colors ~= nil then
                        RageUI.Button("Ouvrir/Fermer", nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        for k,v in pairs(Cfg_Property.main_Menu.playersInProperty[pV.propertyID]) do
                                            if pV.owner == Cfg_Property.pIdentifier then
                                                Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":ouvrefermeretour", function(ouvreferme)
                                                    if ouvreferme then
                                                        Cfg_Property.Popup("~g~Vous avez ouvert votre propriété!")
                                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvreferme", pV.propertyID, false)
                                                    else
                                                        Cfg_Property.Popup("~g~Vous avez fermé votre propriété!")
                                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvreferme", pV.propertyID, true)
                                                    end
                                                end, pV.propertyID)
                                                RageUI.CloseAll()
                                            else
                                                for k2,v2 in pairs(json.decode(pV.pKeys)) do
                                                    if v.pIdentifier == k2 then
                                                        Cfg_Property.ESXLoaded.TriggerServerCallback(Cfg_Property.Prefix..":ouvrefermeretour", function(ouvreferme)
                                                            if ouvreferme then
                                                                Cfg_Property.Popup("~g~Vous avez ouvert la propriété!")
                                                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvreferme", pV.propertyID, false)
                                                            else
                                                                Cfg_Property.Popup("~g~Vous avez fermé la propriété!")
                                                                Cfg_Property.ServerSide(Cfg_Property.Prefix..":ouvreferme", pV.propertyID, true)
                                                            end
                                                        end, pV.propertyID)
                                                        RageUI.CloseAll() 
                                                    end
                                                end
                                            end
                                        end
                                    end
                                })
                        RageUI.Button("Gestion des joueurs - [~b~"..#Cfg_Property.main_Menu.playersInProperty[pV.propertyID].."~s~]", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                        }, RMenu:Get("nProperty_Manage", "players"))  
                        RageUI.Button("Changer ma serrure", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        Cfg_Property.Popup("~r~Changement de ta serrure!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":removeKeyPropertyAll", pV.propertyID)
                                    end
                                })
                        RageUI.Button("Changer Niveau Sécurité - Actuel [~b~"..pV.security.."~s~]", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                        }, RMenu:Get("nProperty_Manage", "security_level"))  
                        RageUI.Button("Sécuriser la maison (Police)", nil, {RightLabel = "→→"}, Cfg_Property.ESXLoaded.PlayerData.job.name == "police" or Cfg_Property.ESXLoaded.PlayerData.job.name == "sheriff", {
                                    onSelected = function()
                                        Cfg_Property.Popup("~g~Vous avez sécurisé la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":fermemaisonpolice", pV.propertyID)
                                    end
                                })
                        RageUI.Button("Vendre ma maison (Irréversible!)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        Cfg_Property.Popup("~g~Vous avez vendu votre maison!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":vendremaison", pV.propertyID)
                                        Citizen.Wait(500)
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":exitProperty", pV.propertyID)
                                        SetEntityCoords(PlayerPedId(), exitpos, false, false, false, false)
                                    end
                                })
                    end
                end)
                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "security_level"), function()
                    if pV.security == '0' then
                        RageUI.Button("Installer une Sécurité niveau 1 ( 15000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 1 de sécurité pour la propriété !")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 1)
                                        RageUI.CloseAll()
                                    end
                        })
                        RageUI.Button("Installer une Sécurité niveau 2 ( 30000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 2 de sécurité pour la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 2)
                                        RageUI.CloseAll()
                                    end
                        })
                        RageUI.Button("Installer une Sécurité niveau 3 ( 60000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 3 de sécurité pour la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 3)
                                        RageUI.CloseAll()
                                    end
                        })                            
                    end
                    if pV.security == '1' then 
                        RageUI.Button("Installer une Sécurité niveau 2 ( 30000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 2 de sécurité pour la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 2)
                                        RageUI.CloseAll()
                                    end
                        })
                        RageUI.Button("Installer une Sécurité niveau 3 ( 60000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 3 de sécurité pour la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 3)
                                        RageUI.CloseAll()
                                    end
                        })                            
                    end
                    if pV.security == '2' then       
                        RageUI.Button("Installer une Sécurité niveau 3 ( 60000$)", nil, {RightLabel = "→→"}, pV.owner == Cfg_Property.pIdentifier, {
                                    onSelected = function()
                                        --Cfg_Property.Popup("~r~Vous avez acheté le Niveau 3 de sécurité pour la propriété!")
                                        Cfg_Property.ServerSide(Cfg_Property.Prefix..":addSecurityLevel", pV.propertyID, 3)
                                        RageUI.CloseAll()
                                    end
                        })                            
                    end
                    if pV.security == '3' then       
                        RageUI.Separator("")
                        RageUI.Separator(Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Niveau de sécurité Maximum !")
                        RageUI.Separator("")                           
                    end                    
                end)

                RageUI.IsVisible(RMenu:Get("nProperty_Manage", "players"), function()
                    if #Cfg_Property.main_Menu.playersInProperty[pV.propertyID] <= 0 then
                        RageUI.Separator("")
                        RageUI.Separator(Cfg_Property.main_Menu.Colors[Cfg_Property.main_Menu.MainColors].."Aucun joueur présent dans votre propriété !")
                        RageUI.Separator("") 
                    else
                        for k,v in pairs(Cfg_Property.main_Menu.playersInProperty[pV.propertyID]) do
                            if v.pIdentifier == pV.owner then
                                RageUI.Button("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors].."PROPRIÉTAIRE".."~s~] - "..v.pName, nil, {RightLabel = "→→"}, false, {
                                })
                            else
                                RageUI.List("["..Cfg_Property.main_Menu.ColorsTwo[Cfg_Property.main_Menu.MainColors]..k.."~s~] - "..v.pName, {"Attribuer clé", "Expluser"}, Cfg_Property.main_Menu.manageIndex, nil, {RightLabel = "→→"}, true, {
                                    onListChange = function(Index, Items)
                                        Cfg_Property.main_Menu.manageIndex = Index
                                    end,
                                    onSelected = function()
                                        if Cfg_Property.main_Menu.manageIndex == 1 then
                                            for k2,v2 in pairs(json.decode(pV.pKeys)) do
                                                if v.pIdentifier == k2 then
                                                    Cfg_Property.Popup("~r~La personne posséde déjà un double des clés")
                                                    return 
                                                end
                                            end
                                            Cfg_Property.Popup("Vous avez attribué les doubles des clés à : ~b~"..v.pName)
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":addKeyProperty", pV.propertyID, v.pIdentifier)
                                        else
                                            Cfg_Property.Popup("Vous avez expulser : ~b~"..v.pName)
                                            Cfg_Property.ServerSide(Cfg_Property.Prefix..":kickFromProperty", pV.propertyID, v.pIdentifier) 
                                        end
                                    end,
                                })
                            end
                        end
                    end
                end)
            end
        end)
    end
end