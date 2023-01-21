--[[ DON'T EDIT THIS // NE PAS MODIFIER ]]--
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
--[[ DON'T EDIT THIS // NE PAS MODIFIER ]]--

ConfigHunting                          = {}
ConfigHunting.lang                     = 'fr' --[[ YOU CAN CHOOSE YOUR LanguageHunting BETWEEN fr AND en // VOUS POUVEZ CHOISIR VOTRE LANGUE ENTRE fr ET en ]]--
--LanguageHunting                        = Locales[ConfigHunting.lang]                    
ConfigHunting.notificationTexture      = "CHAR_LAMAR"
ConfigHunting.notificationIconType     = 1
ConfigHunting.useWeapon                = true

LanguageHunting = {
    ['sender']              = "Club de chasse",
    ['subject']             = "~b~Chasse",
    ['actionMessage']       = "Appuyez sur E pour ~y~dépecer l'animal",
    ['harvestMessage']      = "Vous venez de récupéré: ~y~x",
    ['notKnife']            = "Vous devez avoir un couteau ~y~pour dépecer l'animal !",
    ['progressBarMessage']  = "Dépeçage de l'animal en cours ...",
    ['inventory_full']      = "Vous n'avez pas ~r~assez d'espace libre dans votre inventaire~w~.",
    ['depessing']           = "Vous venez juste de dépecer ~y~un %s~w~.",
    ['harvestMessage']      = "~y~x",
    
    --[[ LISTE DES ANIMAUX ]]--
    ["boar"]                = "Sanglier",
    ["chickenhawk"]         = "Faucon",
    ["cormorant"]           = "Cormoran",
    ["coyote"]              = "Coyote",
    ["deer"]                = "Cerf",
    ["cow"]                = "Vache",
    ["pig"]                = "Cochon",
    ["mtlion"]              = "Cougar",
    ["rabbit"]              = "Lapin",
    --[[ LISTE DES ANIMAUX ]]--

    --[[ LISTE DES NOM DES ITEMS ]]--
    ['itemLabel_meat']      = "Viande",
    --[[ LISTE DES NOM DES ITEMS ]]--
}

--[[
    IF YOU USE THIS SCRIPT / SI TU UTILISES CE SCRIPT
    https://github.com/EthanPeacock/progressBars      
]]--
ConfigHunting.useProgresseBar          = true

ConfigHunting.keys                     = {
    ["interact"]                = Keys["E"],       -- Key for interact
}
ConfigHunting.WeaponList               = {
    {
        name        = "WEAPON_KNIFE", 
        required    = true,
    },
    {
        name        = "WEAPON_MACHETE",
        required    = true,
    },
    {
        name        = "WEAPON_DAGGER",
        required    = true,
    },
    {
        name        = "WEAPON_SWITCHBLADE",
        required    = true,
    }
}
ConfigHunting.Animals                  = {
    boar = {
        name            = 'boar', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_boar', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_boar'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["boar"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 4,
                drop    = 10000,
            },
            {
                item    = "trophy_boar",
                label   = "Trophé Sanglier",
                min     = 1,
                max     = 1,
                drop    = 5,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },

    chickenhawk = {
        name            = 'chickenhawk', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_chickenhawk', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_chickenhawk'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["chickenhawk"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 3,
                drop    = 10000
            },
        },
    },
    cormorant = {
        name            = 'cormorant', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_cormorant', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_cormorant'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["cormorant"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 3,
                drop    = 10000
            },
        },
    },
    coyote = {
        name            = 'coyote', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_coyote', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_coyote'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["coyote"],
        butcheringTime  = 8, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 4,
                drop    = 10000,
            },
            {
                item    = "coyote_trophy",
                label   = "Trophé Coyote",
                min     = 1,
                max     = 1,
                drop    = 5,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },
    deer = {
        name            = 'deer', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_deer', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_deer'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["deer"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 4,
                drop    = 10000,
            },
            {
                item    = "trophy_deer",
                label   = "Trophé Cerf",
                min     = 1,
                max     = 1,
                drop    = 5,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },
    cow = {
        name            = 'cow', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_cow', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_cow'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["cow"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 2,
                max     = 6,
                drop    = 10000,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },
    pig = {
        name            = 'pig', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_pig', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_pig'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["pig"],
        butcheringTime  = 10, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 2,
                max     = 6,
                drop    = 10000,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },
    mtlion = {
        name            = 'mtlion', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_mtlion', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_mtlion'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["mtlion"],
        butcheringTime  = 8, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 4,
                drop    = 10000,
            },
            {
                item    = "trophy_cougar",
                label   = "Trophé Cougar",
                min     = 1,
                max     = 1,
                drop    = 5,
            },
            {
                item    = "skin_5",
                label   = "Peau exotique",
                min     = 1,
                max     = 1,
                drop    = 50,
            },
            {
                item    = "skin_4",
                label   = "Peau de qualité supérieure",
                min     = 1,
                max     = 1,
                drop    = 100,
            },
            {
                item    = "skin_3",
                label   = "Peau en bon état",
                min     = 1,
                max     = 1,
                drop    = 200,
            },
            {
                item    = "skin_2",
                label   = "Peau commune",
                min     = 1,
                max     = 1,
                drop    = 1000,
            },
            {
                item    = "skin_1",
                label   = "Peau usée",
                min     = 1,
                max     = 1,
                drop    = 3000,
            },
           
            {
                item    = "skin_0",
                label   = "Peau en lambeau",
                min     = 1,
                max     = 2,
                drop    = 10000,
            },
        },
    },
    rabbit = {
        name            = 'rabbit', --[[ DON'T EDIT THIS ]]--
        model           = 'a_c_rabbit_01', --[[ DON'T EDIT THIS ]]--
        hash            = GetHashKey('a_c_rabbit_01'), --[[ DON'T EDIT THIS ]]--
        label           = LanguageHunting["rabbit"],
        butcheringTime  = 3, -- in seconds
        items           = {
            {
                item    = "meat",
                label   = "Viande",
                min     = 1,
                max     = 3,
                drop    = 10000
            },
        },
    },
}