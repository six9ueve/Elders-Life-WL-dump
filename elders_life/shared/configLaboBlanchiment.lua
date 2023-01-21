ConfigLaboBlanchiment = {}
TranslationBlanchiment = {}

ConfigLaboBlanchiment.Debug = true -- when this is activated, you can restart the script
ConfigLaboBlanchiment.Locale = 'en' -- de or en

ConfigLaboBlanchiment.UseIPLs = true -- needs bob74_ipl

ConfigLaboBlanchiment.StoreCapacity = {
    240,
    480,
    1000,
}

ConfigLaboBlanchiment.FinishCapacity = {
    240,
    480,
    1000,
}

-- Produce rate per hour
ConfigLaboBlanchiment.ProduceRate = {
    11,
    16,
    21,
}

ConfigLaboBlanchiment.WeedItem = 'money' -- name of the final drug item

ConfigLaboBlanchiment.Farms = {
    {id = 1, type = "black_money", name = "Blanchiment", label = "Laboratoire Blanchiment", price = 150000, enter = {x = -2420.71, y = 3271.04, z = 32.97}, inside = {x = 1137.66, y = -3198.14, z = -48.66, rot = 133.74}, bossActions = {x = 1128.98, y = -3194.45, z = -40.39}},
}

TranslationBlanchiment = {
    ['en'] = {
        ['acceder_computer'] = 'Appuyer ~g~E~s~ pour acceder au pc',
        ['enter_farm'] = 'Appuyer sur  ~g~E~s~ pour ouvrir le menu du laboratoire. ~o~',
        ['enter_farm_2'] = '~s~.',
        ['leave_farm'] = 'Appuyer sur ~g~E~s~ pour sortir du laboratoire',
        ['nothing_produced'] = '~y~Rien ne pouvait être produit en votre absence, car aucune fourniture est stocké.',
        ['successfully_produced'] = '~g~Pendant votre absence, ~w~',
        ['successfully_produced_2'] = '~g~Ont ete produits.',
        ['successfully_produced_3'] = ' ~g~Produit.',
        ['successfully_produced_storageEmpty'] = ' ~g~produit. Les fournitures sont vides!',

        ['get_from_storage'] = '~s~ pris du local.',
        ['farm_bought_title'] = 'Ferme achetée',
        ['farm_bought'] = 'Well! ~g~',
        ['farm_bought_2'] = ' ~s~est maintenant à vous. Bon choix!',

        ['weed'] = '~g~Weed',
        ['meth'] = '~b~Meth',
        ['coke'] = '~w~Coke',
        ['opium'] = '~w~Opium',


        ['supplies'] = 'Provisions',
        ['already_started_mission'] = '~r~Vous avez dejà commence une mission!',
        ['notEnoughMoney'] = '~r~Pas assez de floose va retirer !',

        ['mission_car_changed'] = 'Votre nouveau véhicule ~y~',
        ['mission_car_changed_2'] = ' ~s~est en cours de livraison.',
        ['mission_startLoading'] = 'Hee! Vous devez être ici pour recuperer les fournitures. Nous commençons à charger.',
        ['mission_seller'] = 'Vendeuse',
        ['mission_outofrange'] = '~y~Le véhicule est pas complètement chargé. Retour au vendeur!',
        ['mission_loading'] = 'Le véhicule est en cours de chargement: \n~g~',
        ['mission_loading_2'] = '% ~s~terminer.',
        ['mission_wrongCar'] = 'Je suppose que ce véhicule est pas le bon..',
        ['mission_backToFarm'] = 'Retournez à votre ferme!',

        ['mission_self_plants_bought'] = 'x Provisions ~s~acheter pour ~g~',
        ['mission_self_plants_bought_2'] = '$~s~.',
        ['mission_self_plants_notEnoughMoney'] = 'Les fournitures etaient ~r~décharger~s~, parce que vous n avez pas assez d argent!.',
        ['mission_dou_plants_bought'] = 'x Provisions ~s~etaient ~g~acheter ~s~par votre patron.',
        ['mission_dou_plants_abort'] = '~b~',
        ['mission_dou_plants_abort_2'] = '~s~s La mission etait~r~annuler~s~, parce que vous n avez pas assez d argent.',
        ['mission_dou_plants_abort_target'] = 'La mission etait ~r~avorter~s~, parce que les fournitures n ont pas ete payer.',
        ['mission_dou_plants_arrived'] = 'La livraison avec~g~',
        ['mission_dou_plants_arrived_2'] = ' les fournitures sont arrivées à ce moment.',
        ['mission_dou_plants_arrived_target'] = 'Fournit avec succes ~g~livrer',

        ['mission_press_e_deliver'] = 'Appuye ~g~E~s~ pour decharger les fournitures',
        ['mission_wrongCar_deliver'] = 'Ce n est pas le véhicule que nous avons charger?',

        ['mission_invited'] = 'Vous etiez ~g~inviter ~s~faire une ~b~mission~s~. Appuyer  ~g~E~s~ pour accepter.',
        ['mission_invited_over'] = 'invitation  ~r~expirer~s~!',

        ['menu_enter_farm'] = 'Entrer dans la ferme',
        ['menu_buy_farm'] = 'Acheter le Laboratoire',
        ['menu_buy_name'] = 'Nom:',
        ['menu_buy_type'] = 'Type:',
        ['menu_buy_price'] = 'Prix:',
        ['menu_buy_confirm'] = 'Confirmer',

        ['menu_computer_level'] = 'Level du laboratoire:~r~ ',
        ['menu_computer_produced'] = 'Quantité de drogue emballés',
        ['menu_computer_produced_desc'] = 'Pochon finis et emballés',
        ['menu_computer_storage'] = 'Stockage',
        ['menu_computer_storage_desc'] = 'Des fournitures sont nécessaires pour la production',
        ['menu_computer_takedrugs'] = 'Combien devrait etre retiré?',
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
        ['menu_storage_buy_others_desc'] = 'La personne doit rester à côté de l\'entrer du laboratoire',
        ['menu_storage_inputseeds'] = 'Combien doit etre stocker?',
        ['storagemission_invite'] = 'Cliquez pour demander ~b~',
        ['storagemission_invite_2'] = '~s~',

        ['menu_upgrade'] = 'Améliorer',
        ['menu_upgrade_prod'] = 'Ameliorer le labo',
        ['menu_upgrade_prod_desc'] = 'Augmentez le stockage',
        ['menu_upgrade_prod_level2'] = 'Augmentez le stockage',
        ['menu_upgrade_prod_level2_desc'] = 'Augmentez les performances en améliorant votre équipement',
        ['menu_upgrade_prod_level3'] = 'Ameliorez la sécuriter',
        ['menu_upgrade_prod_level3_desc'] = 'Augmentez les performances en améliorant votre surveillance',
        ['menu_upgrade_level2required'] = 'Niveau 2 requis',
        ['upgraded_title'] = 'Acheter une mise à niveau',
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
        ['menu_access_desc'] = 'Configurer les accès au laboratoire',
        ['menu_access_trust_remove'] = 'Cliquez pour revoquer ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~acces',
        ['menu_addTrusted'] = '~g~Accorder l acces',
        ['menu_access_trust_add'] = 'Cliquez pour accorder ~b~',
        ['menu_access_trust_add_2'] = ' ~s~acces',

        ['menu_access_removed'] = ' ~s~s acces a ete revoquer.',
        ['menu_access_removed_target'] = 'Vous accedez pour ~y~Labi (#',
        ['menu_access_removed_target_2'] = ') a ete revoquer.',
        ['menu_access_granted'] = ' ~s~l accès a ete accorder.',
        ['menu_access_granted_target'] = 'Vous avez desormais acces au ~g~laboratoire (#',
        ['menu_access_granted_target_2'] = ')',
    }

}