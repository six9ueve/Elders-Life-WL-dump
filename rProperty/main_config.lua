Cfg_Property = {
    Prefix = "nProperty",
    Credit = "Elders-Life",
    ESXEvent = "god:getSharedObject",
    ESXLoaded = nil,
    ServerSide = TriggerServerEvent,
    ClientSide = TriggerClientEvent,
    InSide = TriggerEvent,
    prt = print,
    ActualityProperty = {},
    DefaultWeight = 1000, -- 1KG
    pInProperty = {},
    main_Menu = {
        totalCount = 0,
        menuIsOpen = false,
        viewMenuIsOpen = false,
        manageIndex = 1,
        trIndex = 1,
        trItemsIndex = 1,
        intIndex = 1,
        gIndex = 1,
        stockIndex = 1,
        pIndex = 1,
        tIndex = 1,
        pDressingIndex =1,
        createdProperty = {
            pNumber = 1,
            gPlaces = 2,
            stockCapacity = 50,
            security = 0,
        },
        markersPreview = {},
        pDressing = {},
        playersInProperty = {},
        securityLevel = {1,2,3},
        capacityList = {1500,3000,5000,7500,10000,15000,17500,20000},
        garagePlacesList = {2,4,6,10},--19
        propertyList = {
            {
                label = "Motel",
                interiorEntry = {pos = vector3(151.30, -1007.70, -98.99), heading = 357.0},
                interiorExit = {pos = vector3(151.30, -1007.70, -98.99), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(151.3306, -1003.132, -98.99995), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(151.8233, -1001.056, -98.99998), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(154.8071, -1005.867, -98.99995), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(151.30, -1007.70, -98.99), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Maison Pauvre",
                interiorEntry = {pos = vector3(266.05, -1007.20, -101.00), heading = 16.52},
                interiorExit = {pos = vector3(266.05, -1007.20, -101.00), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(261.3669, -1002.563, -99.00859), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(259.6676, -1003.984, -99.00859), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(265.8891, -999.3527, -99.00859), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(266.05, -1007.20, -101.00), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Maison",
                interiorEntry = {pos = vector3(346.52, -1012.61, -99.19), heading = 0.7},
                interiorExit = {pos = vector3(346.52, -1012.61, -99.19), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(351.2698, -999.2122, -99.19618), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(350.8228, -993.5939, -99.19618), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(349.804, -1007.462, -99.19618), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(346.52, -1012.61, -99.19), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Middle Orange",
                interiorEntry = {pos = vector3(-17.17, -587.86, 90.11), heading = 333.98},
                interiorExit = {pos = vector3(-17.17, -587.86, 90.11), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-26.63897, -587.4516, 90.1235), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-38.34729, -583.3716, 83.9182), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-28.4853, -591.0581, 90.1177), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-18.53, -591.68, 90.11), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Loft Bois",
                interiorEntry = {pos = vector3(-603.2761, 58.9940, 98.20), heading = 94.7919},
                interiorExit = {pos = vector3(-603.2761, 58.9940, 98.20), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-621.7205,54.5690,97.5994), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-594.6408,56.4901,96.9996), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-625.2537, 55.3731, 97.5994), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-603.2761, 58.9940, 98.20), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Moderne Bois",
                interiorEntry = {pos = vector3(-787.0505, 315.6589, 187.9134), heading = 275.2489},
                interiorExit = {pos = vector3(-787.0505, 315.6589, 187.9134), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-795.2843,326.9575,187.3133), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-797.827,327.4725,190.716), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-798.831, 327.6901, 187.3133), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-787.0505, 315.6589, 187.9134), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Moderne Rouge",
                interiorEntry = {pos = vector3(-773.9712, 342.0773, 196.6892), heading = 91.64},
                interiorExit = {pos = vector3(-773.9712, 342.0773, 196.6892), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-765.6948,330.8384,196.0861), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-763.0523,330.1532,199.4863), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-762.0436, 330.1865, 196.0861), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-773.9712, 342.0773, 196.6892), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Luxe Mauve",
                interiorEntry = {pos = vector3(-859.85, 691.153, 152.86), heading = 207.98},
                interiorExit = {pos = vector3(-859.85, 691.153, 152.86), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-858.2318, 697.5743, 145.253), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-855.321, 680.1635, 149.0529), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-857.3516, 701.2546, 145.253), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-859.85, 691.153, 152.86), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                } 
            },
            {
                label = "Luxe Noir",
                interiorEntry = {pos = vector3(-174.1976, 497.8127, 137.6538), heading = 188.8576},
                interiorExit = {pos = vector3(-174.1976, 497.8127, 137.6538), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-175.0734,493.6637,130.0437), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-167.4053,487.9109,133.8439), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-175.1072, 489.8234, 130.0437), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-174.1976, 497.8127, 137.6538), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Bureau Blanc",
                interiorEntry = {pos = vector3(-1399.768, -480.4406, 72.0421), heading = 272.2344},
                interiorExit = {pos = vector3(-1399.768, -480.4406, 72.0421), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-1375.211,-467.5707,72.0422), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-1380.995,-471.0691,72.0421), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-1367.808, -480.3927, 72.0422), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-1399.768, -480.4406, 72.0421), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Bureau Monochrome",
                interiorEntry = {pos = vector3(-141.1936, -613.8115, 168.8206), heading = 188.3627},
                interiorExit = {pos = vector3(-141.1936, -613.8115, 168.8206), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-128.9679,-638.769,168.8206), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-132.4289,-632.8312,168.8206), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-142.2527, -645.7009, 168.8205), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-141.1936, -613.8115, 168.8206), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Bureau Bois",
                interiorEntry = {pos = vector3(-79.0555, -833.3438, 243.3857), heading = 340.2287},
                interiorExit = {pos = vector3(-79.0555, -833.3438, 243.3857), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-78.9609,-805.6443,243.3857), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-78.5093,-812.4595,243.3857), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-64.2173, -805.1782, 243.3861), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-79.0555, -833.3438, 243.3857), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Bureau Béton",
                interiorEntry = {pos = vector3(-1582.892, -558.5564, 108.5228), heading = 208.2365},
                interiorExit = {pos = vector3(-1582.892, -558.5564, 108.5228), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(-1559.932,-574.2686,108.5271), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(-1565.924,-570.6941,108.523), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(-1567.689, -586.7667, 108.523), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(-1582.892, -558.5564, 108.5228), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Grand Entrepot",
                interiorEntry = {pos = vector3(1026.5056,-3099.8320,-38.99), heading = 101.65},
                interiorExit = {pos = vector3(1026.5056,-3099.8320,-38.99), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(1003.565,-3102.871,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(997.8798, -3091.899, -38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(994.9932, -3096.426, -38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(1026.5056,-3099.8320,-38.99), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Entrepot Moyen",
                interiorEntry = {pos = vector3(1048.5067,-3097.0817,-38.9999), heading = 101.65},
                interiorExit = {pos = vector3(1048.5067,-3097.0817,-38.9999), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(1055.519,-3102.643,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(1048.79,-3103.96,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(1049.379, -3095.076, -38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(1048.5067,-3097.0817,-38.9999), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            },
            {
                label = "Petit Entrepot",
                interiorEntry = {pos = vector3(1088.1834,-3099.3547,-38.9999), heading = 101.65},
                interiorExit = {pos = vector3(1088.1834,-3099.3547,-38.9999), colorsMarker = {r = 0, g = 255, b = 0}},
                pStock = {pos = vector3(1097.771,-3096.482,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pDressing = {pos = vector3(1102.594,-3101.807,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                pGestion = {pos = vector3(1088.44,-3101.53,-38.99), colorsMarker = {r = 255, g = 0, b = 0}},
                viewMarkers = {
                    {pos =  vector3(1088.1834,-3099.3547,-38.9999), colorsMarker = {r = 0, g = 255, b = 0}, helpMessage = "~b~TYPE D'INTÉRACTION~s~\n- Point de sortie de la propriété"},
                }
            }
        }
    },
    garageInteriorsInfos = {
        [2] = {
            tpPos = vector3(178.69, -1006.31, -99.0), 
            tpExit = vector3(178.69, -1006.31, -99.0), 
            vehiculeSpawner = {
                {pos = vector3(175.22, -1003.46, -99.0), heading = 183.32},
                {pos = vector3(171.07, -1003.78, -99.), heading = 180.28}
            }, 
        },
        [4] = {
            tpPos = vector3(206.88, -1018.4, -99.0), 
            tpExit = vector3(206.88, -1018.4, -99.0), 
            vehiculeSpawner= {
                {pos = vector3(194.50, -1016.14, -99.0), heading = 180.13},
                {pos = vector3(194.57, -1022.32, -99.0), heading = 180.13},
                {pos = vector3(202.21, -1020.14, -99.0), heading = 90.13},
                {pos = vector3(202.21, -1023.32, -99.0), heading = 90.13}
            }
        },
        [6] = {
            tpPos = vector3(206.79, -999.08, -99.0), 
            tpExit = vector3(206.79, -999.08, -99.0), 
            vehiculeSpawner = {
                {pos = vector3(203.82, -1004.63, -99.0), heading = 88.05},
                {pos = vector3(194.16, -1004.63, -99.0), heading = 266.42},
                {pos = vector3(193.83, -1000.63, -99.0), heading = 266.42},
                {pos = vector3(202.62, -1000.63, -99.0), heading = 88.05},
                {pos = vector3(193.83, -997.01, -99.0), heading = 266.42},
                {pos = vector3(202.62, -997.01, -99.0), heading = 88.05},
            },
        },
        [10] = {
            tpPos = vector3(240.71, -1004.96, -99.0), 
            tpExit = vector3(240.71, -1004.96, -99.0), 
            vehiculeSpawner = {
                {pos = vector3(233.47, -982.57, -99.0), heading = 90.1},
                {pos = vector3(233.47, -987.57, -99.0), heading = 90.1},
                {pos = vector3(233.47, -992.57, -99.0), heading = 90.1},
                {pos = vector3(233.47, -997.57, -99.0), heading = 90.1},
                {pos = vector3(233.47, -1002.57, -99.0), heading = 90.1},
                {pos = vector3(223.55, -982.57, -99.0), heading = 266.36},
                {pos = vector3(223.55, -987.57, -99.0), heading = 266.36},
                {pos = vector3(223.55, -992.57, -99.0), heading = 266.36},
                {pos = vector3(223.55, -997.57, -99.0), heading = 266.36},
                {pos = vector3(223.55, -1002.57, -99.0), heading = 266.36},
            },
        },
        [19] = {
            tpPos = vector3(-91.56,-821.11,221.0), 
            tpExit = vector3(-91.56,-821.11,221.0), 
            vehiculeSpawner = {
                {pos = vector3(-68.224518, -825.543274, 221.406281), heading = 108.41},
                {pos = vector3(-71.026946, -821.806641, 221.508163), heading = 139.52},
                {pos = vector3(-75.358902, -819.733276, 221.497177), heading = 169.68},
                {pos = vector3(-80.601181, -818.75647, 221.913025), heading = 175.71},
                {pos = vector3(-70.150597, -835.635193, 221.914963), heading = 46.0},
                {pos = vector3(-67.643822, -830.637146, 221.343704), heading = 81.77},
                {pos = vector3(-68.225082, -825.542664, 226.891388), heading = 111.73},
                {pos = vector3(-71.024559, -821.80481, 227.046005), heading = 140.98},
                {pos = vector3(-75.358917, -819.732361, 226.853409), heading = 160.14},
                {pos = vector3(-80.600929, -818.756042, 226.842514), heading = 160.14},
                {pos = vector3(-85.163536, -817.908081, 227.258423), heading = 188.21},
                {pos = vector3(-70.151001, -835.635498, 226.890625), heading =  43.37},
                {pos = vector3(-67.639793, -830.638672, 227.045715), heading = 81.21},
                {pos = vector3(-70.12, -835.57, 232.199112), heading =  51.41},
                {pos = vector3(-67.15, -830.66, 232.39183), heading =  72.89},
                {pos = vector3(-68.71, -824.33, 232.237), heading = 118.8},
                {pos = vector3(-74.15, -820.24, 232.258423), heading = 159.37},
                {pos = vector3(-80.83, -819.46, 232.034805), heading = 199.22},
                {pos = vector3(-85.18, -820.65, 232.604095), heading = 217.44},
            },
        },
    },
    Bureau_action = {
        {gestion = vector3(95.079, -877.8493, 30.124)}
    },
    itemsWeight = {
        ["sac_conservation"] = 110,
        ["defib"] = 250,
        ["water"] = 110,
        ["bread"] = 80,
                        -----------PIECE AUTO----------
        --2jzengine = 4000, 
        ["bielles"]  = 110,   
                        -------- vol  
        ["Xbox"]   = 110, 
                        -----------CASSE----------
        ["battery"] = 1000,
        ["coffre"]  = 400,
        ["doors"]   = 2500,
        ["engine"]  = 2500,
        ["hood"]    = 2500,
        ["steeringwheel"] = 2500,
        ["trunk"] = 2500,

                        -----------vigne----------
        ["raisin"] = 450,
        ["jus_raisin"] = 200,
        ["vine"] = 200,
        ["grand_cru"] = 200,
                        -----------brasserie----------
        ["houblon"] = 450,
        ["orge"] = 450,
        ["malt"] = 450,
        ["bierenoel"]= 200,
        ["biereblonde"] = 200,
        ["bierebrune"] = 200,
        ["biereambree"] = 200,
                        -----------Distillerie----------
        ["alcool"] = 450,
        ["potato"] = 450,
        ["plante"] = 450,
        ["canneasucre"] = 450,
        ["malt"] = 450,
        ["whisky"] = 200,
        ["vodka"] = 200,
        ["rhum"] = 200,
        ["jager"] = 200,
        ["agave"] = 450,
                        ------------tabac -------------
        ["tabacblond"] = 450,
        ["tabacbrun"] = 450,
        ["tabacblondsec"] = 400,
        ["tabacbrunsec"] = 400,
        ["gitanes"] = 200,
        ["malbora"] = 200,
    --------------drogues-----------
        ["hydrochloric"] = 280,
        ["hydrochloric_bottle"] = 280,
        ["sodiumhydroxide"] = 280,
        ["sulfuricacid"] = 280,
        ["sulfuricacid_bottle"] = 280,
        ["cocaleaves"] = 300,
        ["coca_decouper"] = 280,
        ["coca_traiter"] = 280,
        ["esrar_islenmis"] = 280,
        ["esrar_islenmis2"] = 280,  
        ["meth_pooch"] = 80,
        ["trimmedweed"] = 300,
        ["weed_pooch"] = 80,
        ["cocaine_pooch"] = 80,

        ["advancedrifle"] = 7500,
        ["assaultrifle"] = 7500,
        ["assaultrifle_mk2"] = 7500,
        ["assaultshotgun"] = 7500,
        ["autoshotgun"] = 7500,
        ["assaultsmg"] = 7500,
        ["bullpuprifle"] = 7500,
        ["bullpuprifle_mk2"] = 7500,
        ["bullpupshotgun"] = 7500,
        ["carbinerifle"] = 7500,
        ["carbinerifle_mk2"] = 7500,
        ["combatmg"] = 7500,
        ["combatmg_mk2"] = 7500,
        ["combatpdw"] = 7500,
        ["combatshotgun"] = 7500,
        ["compactlauncher"] = 7500,
        ["compactrifle"] = 7500,
        ["dbshotgun"] = 7500,
        ["doubleaction"] = 7500,
        ["firework"] = 7500,
        ["gusenberg"] = 7500,
        ["heavyshotgun"] = 7500,
        ["heavysniper"] = 7500,
        ["heavysniper_mk2"] = 7500,
        ["hominglauncher"] = 7500,
        ["marksmanpistol"] = 7500,
        ["marksmanrifle"] = 7500,
        ["marksmanrifle_mk2"] = 7500,
        ["militaryrifle"] = 7500,
        ["minigun"] = 7500,
        ["minismg"] = 7500,
        ["pumpshotgun"] = 7500,
        ["pumpshotgun_mk2"] = 7500,
        ["revolver_mk2"] = 7500,
        ["sniperrifle"] = 7500,

        ["appistol"] = 2200,
        ["ceramicpistol"] = 2200,
        ["combatpistol"] = 2200,
        ["heavypistol"] = 2200,
        ["machinepistol"] = 2200,
        ["pistol50"] = 2200,
        ["pistol"] = 2200,
        ["pistol_mk2"] = 2200,

        ["bat"] = 750,
        ["battleaxe"] = 750,
        ["bottle"] = 750,
        ["crowbar"] = 750,
        ["kevlar"] = 750,
        ["knuckle"] = 750,
        ["machete"] = 750,
    },
}