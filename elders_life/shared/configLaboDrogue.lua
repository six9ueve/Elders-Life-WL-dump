ConfigLaboDrogue = {}
Translation = {}

ConfigLaboDrogue.Debug = true -- when this is activated, you can restart the script
ConfigLaboDrogue.Locale = 'en' -- de or en

ConfigLaboDrogue.UseIPLs = true -- needs bob74_ipl

ConfigLaboDrogue.StoreCapacity = {
    240,
    480,
    1000,
}

ConfigLaboDrogue.FinishCapacity = {
    240,
    480,
    1000,
}

-- Produce rate per hour
ConfigLaboDrogue.ProduceRate = {
    11,
    16,
    21,
}

ConfigLaboDrogue.WeedItem = 'weed_pooch' -- name of the final drug item
ConfigLaboDrogue.MethItem = 'meth_pooch'
ConfigLaboDrogue.CokeItem = 'cocaine_pooch'
ConfigLaboDrogue.OpiumItem = 'opium_pooch'

ConfigLaboDrogue.Farms = {
    {id = 1, type = "weed_pooch_prepare", name = "GWeed", label = "Laboratoire Weed", price = 150000, enter = {x = 1722.45, y = 4734.84, z = 41.60}, inside = {x = 1064.67, y = -3182.66, z = -40.16, rot = 133.74}, bossActions = {x = 1044.02, y = -3194.92, z = -38.16}, preparent = {x = 1039.17, y = -3205.81, z = -38.16}},
    {id = 2, type = "meth_pooch_prepare", name = "PMeth", label = "Laboratoire Meth", price = 500000, enter = {x = -1989.95, y = -330.81, z = 31.50}, inside = {x = 997.3, y = -3200.57, z = -37.39, rot = 260.1}, bossActions = {x = 1002.09, y = -3195.21, z = -38.99}, preparent = {x = 1005.74, y = -3200.23, z = -38.51}},
    {id = 3, type = "cocaine_pooch_prepare", name = "GCoke", label = "Laboratoire Coke", price = 300000, enter = {x = 2932.08, y = 4624.39, z = 48.00}, inside = {x = 1088.61, y = -3187.81, z = -39.99, rot = 180.0}, bossActions = {x = 1087.4, y = -3194.22, z = -38.99}, preparent = {x = 1087.29, y = -3197.40, z = -38.99}},
    {id = 4, type = "opium_pooch_prepare", name = "GOpium", label = "Laboratoire opium", price = 200000, enter = {x = -841.29, y = 5401.21, z = 34.00}, inside = {x = 572.639, y = -3090.53, z = -30.42, rot = 352.0}, bossActions = {x = 573.8015, y = -3084.534, z = -29.42}, preparent = {x = 573.8145, y = -3080.729, z = -29.42}},
}

Translation = {
    ['en'] = {
        ['acceder_computer'] = 'Appuyer ~g~E~s~ pour acceder au pc',
        ['enter_farm'] = 'Appuyer sur  ~g~E~s~ pour ouvrir le menu du laboratoire. ~o~',
        ['enter_farm_2'] = '~s~.',
        ['leave_farm'] = 'Appuyer sur ~g~E~s~ pour sortir du laboratoire',
        ['nothing_produced'] = '~y~Rien ne pouvait ??tre produit en votre absence, car aucune fourniture est stock??.',
        ['successfully_produced'] = '~g~Pendant votre absence, ~w~',
        ['successfully_produced_2'] = '~g~Ont ete produits.',
        ['successfully_produced_3'] = ' ~g~Produit.',
        ['successfully_produced_storageEmpty'] = ' ~g~produit. Les fournitures sont vides!',

        ['get_from_storage'] = '~s~ pris du local.',
        ['farm_bought_title'] = 'Ferme achet??e',
        ['farm_bought'] = 'Well! ~g~',
        ['farm_bought_2'] = ' ~s~est maintenant ?? vous. Bon choix!',

        ['weed'] = '~g~Weed',
        ['meth'] = '~b~Meth',
        ['coke'] = '~w~Coke',
        ['opium'] = '~w~Opium',


        ['supplies'] = 'Provisions',
        ['already_started_mission'] = '~r~Vous avez dej?? commence une mission!',
        ['notEnoughMoney'] = '~r~Pas assez de floose va retirer !',

        ['mission_car_changed'] = 'Votre nouveau v??hicule ~y~',
        ['mission_car_changed_2'] = ' ~s~est en cours de livraison.',
        ['mission_startLoading'] = 'Hee! Vous devez ??tre ici pour recuperer les fournitures. Nous commen??ons ?? charger.',
        ['mission_seller'] = 'Vendeuse',
        ['mission_outofrange'] = '~y~Le v??hicule est pas compl??tement charg??. Retour au vendeur!',
        ['mission_loading'] = 'Le v??hicule est en cours de chargement: \n~g~',
        ['mission_loading_2'] = '% ~s~terminer.',
        ['mission_wrongCar'] = 'Je suppose que ce v??hicule est pas le bon..',
        ['mission_backToFarm'] = 'Retournez ?? votre ferme!',

        ['mission_self_plants_bought'] = 'x Provisions ~s~acheter pour ~g~',
        ['mission_self_plants_bought_2'] = '$~s~.',
        ['mission_self_plants_notEnoughMoney'] = 'Les fournitures etaient ~r~d??charger~s~, parce que vous n avez pas assez d argent!.',
        ['mission_dou_plants_bought'] = 'x Provisions ~s~etaient ~g~acheter ~s~par votre patron.',
        ['mission_dou_plants_abort'] = '~b~',
        ['mission_dou_plants_abort_2'] = '~s~s La mission etait~r~annuler~s~, parce que vous n avez pas assez d argent.',
        ['mission_dou_plants_abort_target'] = 'La mission etait ~r~avorter~s~, parce que les fournitures n ont pas ete payer.',
        ['mission_dou_plants_arrived'] = 'La livraison avec~g~',
        ['mission_dou_plants_arrived_2'] = ' les fournitures sont arriv??es ?? ce moment.',
        ['mission_dou_plants_arrived_target'] = 'Fournit avec succes ~g~livrer',

        ['mission_press_e_deliver'] = 'Appuye ~g~E~s~ pour decharger les fournitures',
        ['mission_wrongCar_deliver'] = 'Ce n est pas le v??hicule que nous avons charger?',

        ['mission_invited'] = 'Vous etiez ~g~inviter ~s~faire une ~b~mission~s~. Appuyer  ~g~E~s~ pour accepter.',
        ['mission_invited_over'] = 'invitation  ~r~expirer~s~!',

        ['menu_enter_farm'] = 'Entrer dans la ferme',
        ['menu_buy_farm'] = 'Acheter le Laboratoire',
        ['menu_buy_name'] = 'Nom:',
        ['menu_buy_type'] = 'Type:',
        ['menu_buy_price'] = 'Prix:',
        ['menu_buy_confirm'] = 'Confirmer',

        ['menu_computer_level'] = 'Level du laboratoire:~r~ ',
        ['menu_computer_produced'] = 'Quantit?? de drogue emball??s',
        ['menu_computer_produced_desc'] = 'Pochon finis et emball??s',
        ['menu_computer_storage'] = 'Stockage',
        ['menu_computer_storage_desc'] = 'Des fournitures sont n??cessaires pour la production',
        ['menu_computer_takedrugs'] = 'Combien devrait etre retir???',
        ['menu_computer_notenoughdrugs'] = 'Vous n\'avez pas autant dans le stockage!',

        ['menu_storage'] = 'Se ravitailler',
        ['menu_storage_input'] = 'Stocker dans le laboratoire',
        ['menu_storage_input_desc'] = 'Stockez les fournitures que vous avez dans le laboratoire',
        ['menu_storage_storageLimit'] = '~s~Il ne reste que de la place pour ~y~',
        ['menu_storage_storageLimit_2'] = ' Provisions~s~!',
        ['menu_storage_notenough'] = '~r~Vous n avez pas assez de fournitures!',
        ['menu_storage_buy'] = 'Acheter de la drogues',
        ['menu_storage_buy_desc'] = 'Acheter des fournitures au marcher noir',
        ['menu_storage_buy_self'] = 'Achetez vous-meme des fournitures',
        ['menu_storage_buy_others'] = 'Laisser quelqu un acheter vos fournitures',
        ['menu_storage_buy_others_desc'] = 'La personne doit rester ?? c??t?? de l\'entrer du laboratoire',
        ['menu_storage_inputseeds'] = 'Combien doit etre stocker?',
        ['storagemission_invite'] = 'Cliquez pour demander ~b~',
        ['storagemission_invite_2'] = '~s~',

        ['menu_upgrade'] = 'Am??liorer',
        ['menu_upgrade_prod'] = 'Ameliorer le labo',
        ['menu_upgrade_prod_desc'] = 'Augmentez le stockage',
        ['menu_upgrade_prod_level2'] = 'Augmentez le stockage',
        ['menu_upgrade_prod_level2_desc'] = 'Augmentez les performances en am??liorant votre ??quipement',
        ['menu_upgrade_prod_level3'] = 'Ameliorez la s??curiter',
        ['menu_upgrade_prod_level3_desc'] = 'Augmentez les performances en am??liorant votre surveillance',
        ['menu_upgrade_level2required'] = 'Niveau 2 requis',
        ['upgraded_title'] = 'Acheter une mise ?? niveau',
        ['upgraded'] = 'le ~y~level ~s~a ete ameliorer to ~y~',
        ['upgraded_2'] = ' ~s~. Entrez de nouveau dans la ferme pour voir la progression.',

        ['menu_stats_finished'] = '~b~Capaciter de stockage  :',
        ['menu_stats_storecap'] = '~b~Capaciter de stockage  :',
        ['menu_stats_storecap_desc'] = '~s~4x fournitures = 1x drogues',
        ['menu_stats_productivity'] = '~b~Vitesse de production',

        ['menu_changeVehicle'] = 'Changer de vehicule de mission',
        ['menu_changeVehicle_change'] = 'Cliquez pour selectionner ~b~',
        ['menu_changeVehicle_change2'] = ' ~s~comme vehicule de mission',

        ['menu_access'] = 'Cles ',
        ['menu_access_desc'] = 'Configurer les acc??s au laboratoire',
        ['menu_access_trust_remove'] = 'Cliquez pour revoquer ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~acces',
        ['menu_addTrusted'] = '~g~Accorder l acces',
        ['menu_access_trust_add'] = 'Cliquez pour accorder ~b~',
        ['menu_access_trust_add_2'] = ' ~s~acces',

        ['menu_access_removed'] = ' ~s~s acces a ete revoquer.',
        ['menu_access_removed_target'] = 'Vous accedez pour ~y~Labi (#',
        ['menu_access_removed_target_2'] = ') a ete revoquer.',
        ['menu_access_granted'] = ' ~s~l acc??s a ete accorder.',
        ['menu_access_granted_target'] = 'Vous avez desormais acces au ~g~laboratoire (#',
        ['menu_access_granted_target_2'] = ')',
    }

}