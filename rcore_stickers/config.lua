Config = {}

Config.Language = 'EN' -- [ 'EN' ] Custom locales can be added to locale.lua
Config.Database = 'mysql-async' --[ 'mysql-async' / 'oxmysql' / 'ghmattimysql' ] Choose your sql driver (leave empty for standalone)
Config.Framework = 'esx' --[ 'esx' / 'qbcore' / 'other' ] Choose your framework (leave empty for standalone)

Config.FrameworkTriggers = {
    notify = 'god:showNotification', -- [ ESX = 'god:showNotification'    QBCore = 'QBCore:Notify' ] Set the notification event, if left blank, default will be used
    object = 'god:getSharedObject', --[ ESX = 'god:getSharedObject'    QBCore = 'QBCore:GetObject' ] Set the shared object event, if left blank, default will be used (deprecated for QBCore)
    resourceName = 'es_extended', -- [ ESX = 'es_extended'    QBCore = 'qb-core' ] Set the resource name, if left blank, automatic detection will be performed
}

Config.FrameworkSQLTables = {
    table = 'owned_vehicles', --[ ESX = 'owned_vehicles'    QBCore = 'player_vehicles' ] Set the name of the table where you store player vehicles, if left blank, default will be used
    identifier = 'owner', --[ ESX = 'owner'    QBCore = 'citizenid' ] Set the identifier used in that table, if left blank, default will be used
}

Config.Accessibility = {
    event = true, -- Enable this if you want to open the menu by triggering event (rcore_stickers:openMenu)

    restricted = false, -- Enable to restrict the whole script for certain players (IsPlayerAllowedScript function in framework/your_framework.lua)

    anyone = false, -- Everyone can use place and edit stickers
    owner = false, -- Only the owner of the vehicle can place and edit stickers
    jobs = true, -- Only players with certain job can place and edit stickers
}

-- Related to settings above
Config.AllowedJobs = {
    -- Example:
    police = true,
    stickers = true,
}

Config.EditorOptions = {
    loadDistance = 50.0, -- The distance at which the stickers will start displaying
    maxDistance = 10.0, -- The maximum distance the player can go away from the vehicle when in editor mode
    maxStickers = 6, -- The maximum amount of stickers on a single vehicle, please do note that there cannot be more than 56 stickers rendered at the same time
    maxScale = 6.0, -- The maximum scale of the sticker in editor
    minScale = 0.1, -- The minimum scale of the sticker in editor
}

Config.Controls = {}

-- Controls used in the sticker editor, you can find the controls codes here https://docs.fivem.net/docs/game-references/controls/
Config.Controls['EDITOR_CONFIRM']      = 176 -- Enter
Config.Controls['EDITOR_CANCEL']       = 177 -- Backspace
Config.Controls['EDITOR_REMOVE']       = 178 -- Delete
Config.Controls['EDITOR_SPEED']        = 155 -- Left Shift
Config.Controls['EDITOR_LOCK']         = 171 -- Capslock
Config.Controls['EDITOR_MIRROR']       = 132 -- Left Ctrl
Config.Controls['EDITOR_SCALE_UP']     = 181 -- Scrollwheel Up
Config.Controls['EDITOR_SCALE_DOWN']   = 180 -- Scrollwheel Down
Config.Controls['EDITOR_ROTATE_LEFT']  = 174 -- Arrow Left
Config.Controls['EDITOR_ROTATE_RIGHT'] = 175 -- Arrow Right

Config.Text = {}

-- All text labels used in this script
Config.Text['EDITOR_PLACE']      = 'Emplacement ($%s)'
Config.Text['EDITOR_SCALE']      = 'Taille (%sx)'
Config.Text['EDITOR_ROTATE']     = 'Rotation (%s°)'
Config.Text['EDITOR_SPEED']      = 'Vitesse (Hold)'
Config.Text['EDITOR_LOCK_ON']    = 'Vérouiller position (On)'
Config.Text['EDITOR_LOCK_OFF']   = 'Vérouiller position (Off)'
Config.Text['EDITOR_MIRROR_ON']  = 'Miroire (On)'
Config.Text['EDITOR_MIRROR_OFF'] = 'Miroire (Off)'
Config.Text['EDITOR_REMOVE']     = 'Retirer'
Config.Text['EDITOR_CANCEL']     = 'Annuler'

Config.Text['ERROR_WRONG_ENTITY']    = 'Vous pouvez placer des autocollants uniquement sur les véhicules.'
Config.Text['ERROR_NO_ACCESS_PLACE'] = 'Vous ne pouvez pas poser d\'autocollants sur ce véhicule.'
Config.Text['ERROR_NO_ACCESS_EDIT']  = 'You cannot edit stickers on this vehicle.'
Config.Text['ERROR_NO_ENTITY']       = 'Vous ne pouvez pas modifier les autocollants sur ce véhicule.'
Config.Text['ERROR_OUT_OF_RANGE']    = 'Vous êtes allé trop loin du véhicule.'
Config.Text['ERROR_MAX_STICKERS']    = 'Ce véhicule a déjà atteint le nombre maximum d\'autocollants.'
Config.Text['ERROR_NO_STICKERS']     = 'Ce véhicule n\'a pas d\'autocollants.'
Config.Text['ERROR_NO_MONEY']        = 'Vous n\'avez pas assez d\'argent pour cet autocollant.'
Config.Text['ERORR_NOT_ALLOWED']     = 'Vous n\'êtes pas autorisé à placer cet autocollant.'

Config.Text['SUCCESS_PLACED']  = 'L\'autocollant a été placé avec succès.'
Config.Text['SUCCESS_EDITED']  = 'L\'autocollant a été modifié avec succès.'
Config.Text['SUCCESS_REMOVED'] = 'L\'autocollant a été supprimé avec succès.'

Config.Text['MENU_BUTTON_ADD']   = 'Ajouter'
Config.Text['MENU_BUTTON_EDIT']  = 'Modifier'
Config.Text['MENU_BUTTON_PRICE'] = '~g~$%s'
Config.Text['MENU_BUTTON_FREE']  = '~g~Gratuit'

Config.Text['MENU_MAIN_TITLE']        = 'AUTOCOLLANTS'
Config.Text['MENU_MAIN_SUBTITLE']     = 'Option'
Config.Text['MENU_EDIT_SUBTITLE']     = 'Autocollants existants' 
Config.Text['MENU_CATEGORY_SUBTITLE'] = 'Categories'

-- All available stickers
--[[
    You can add your own stickers, all you need is OpenIV and the stickers, let's look how to do that
        Stickers are sorted in categories which you can rename, add or remove
            category - name of the category
            stickers - list of all stickers in this category
        Stickers come with 2 different variants, either stickers that need to be flipped horizontally or text stickers which can stay as they are
        You can upload your own stickers to .ytd file (texture dictionary) using OpenIV
        A sticker needs these properties:
            name - name of the sticker in the .ytd file
            price - price of the sticker (can be set to 0)
            flip - whether or not the sticker has a horizontally flipped equivalent
            dict - name of the texture dictionary where the sticker is located at (without .ytd extension)
        There are two optional properties:
            name2 - name of the horizontally flipped equivalent in the .ytd file (is set only if flip is true)
            premium - this sticker is meant only for premium players, IsPlayerAllowed (located in framework folder) has to return true
]]
Config.Stickers = {
    {
        category = 'Stickers jeu',
        stickers = {
            {
                name = 'Bean Machine Coffee',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Cherenkov Vodka',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'E-Cola',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Globe Oil',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Meteorite',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Pisswasser',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Sprunk',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Stronzo Beer',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
        }
    },
    {
        category = 'Stickers réel',
        stickers = {
            {
                name = '3M',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Audi',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'BMW',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Budweiser',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Burger King',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Castrol',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Caterpillar',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Chevrolet',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Coca Cola',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'FedEx',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ferrari',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ford',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Haas',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Lamborghini',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'McDonald\'s',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mercedes-Benz',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Monster Energy',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mountain Dew',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Pepsi',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Porsche',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Red Bull',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Shell',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Target',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'UPS',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Volkswagen',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
        }
    },
    {
        category = 'Japonais',
        stickers = {
            {
                name = 'Akina Speed Stars',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Fujiwara Tofu',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Initial D',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Legends',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Turbo',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Night Kids',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Red Suns',
                price = 200,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Top Tier Japan',
                price = 200,
                flip = false,
                dict = 'japanese'
            }, 
        }
    },
    {
        category = 'NASCAR',
        stickers = {
            {
                name = 'NASCAR Logo',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Aric Almirola',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Christopher Bell',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Denny Hamlin',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Erik Jones',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Justin Haley',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kurt Busch',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kyle Busch',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Martin Truex Jr',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'William Byron',
                price = 200,
                flip = false,
                dict = 'nascar'
            },
        }
    },
    {
        category = 'Autres',
        stickers = {
            {
                name = 'grosse_tete',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'fox_1',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'fox_2',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'fox_3',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'napoleon',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = '4_bandes',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'CJ',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'qr_code',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'smm',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Medical Use',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Medical Weed',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'akhikam',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'boiserie',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'tribal',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Burning Horse',
                name2 = 'Burning Horse Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Burning Skull',
                name2 = 'Burning Skull Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Cowboy Skull',
                name2 = 'Cowboy Skull Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Drift',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'HOONIGAN',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Jesus',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Mechanic Skull',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Piston Skull',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Pistons',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Red Flame',
                name2 = 'Red Flame Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Textured Skull',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Turbo Slug',
                name2 = 'Turbo Slug Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Umbrella Corporation',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'double_bande',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'cat-jap',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Dooky',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'marque-DC',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'shorty',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'smoke-weed-everyday',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Yellow Flame',
                name2 = 'Yellow Flame Flipped',
                price = 200,
                flip = true,
                dict = 'others'
            }
        }
    },
    {
        category = 'Gang',
        stickers = {
            {
                name = 'brockers',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'rebel biker',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'santa_muerte',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'crips',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'ballas',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'east_side_ballas',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'F4L',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'vagos',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = '410th',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'aztecas',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'mara18',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'marabunta',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'white',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'blackd',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'bloods',
                price = 200,
                flip = false,
                dict = 'gang'
            },
            {
                name = 'families',
                price = 200,
                flip = false,
                dict = 'gang'
            },
        }
    },
    {
        category = 'Entreprise',
        stickers = {
            {
                name = 'fdb_perf',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'paleto_motors',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'river_ranch',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'ems_1',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'ems_2',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'ems_3',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'LSCustom',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'distilerie_paleto',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'K9',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'logo-swat',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'distillerie_fisher',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'dinoco',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'coq',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'Seamair2',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'Seamair',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'ems_gang',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'shorty stickers',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'stickers bcso',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'stickers lspd',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'stickers pia',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'street_garage',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'Burger Shot',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'pizza3',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'auto exotic',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'bahama mamas',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'bennys',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'dinasty8',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'distilerie',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'distilerie_2',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'maisonette',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'mosley',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'paradise',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'pearls',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'tabac',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'taxi',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'tequilala',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'unicorn',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'weazel',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'yellow',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'blackwood',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'stickers',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'steinway',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'boulangerie',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
            {
                name = 'ranch',
                price = 200,
                flip = false,
                dict = 'entreprise'
            },
        }
    },
    {
        category = 'Bikers',
        stickers = {
            {
                name = 'Soa',
                price = 200,
                flip = false,
                dict = 'biker'
            },
            {
                name = 'lost mc',
                price = 200,
                flip = false,
                dict = 'biker'
            },
            {
                name = 'viperz',
                price = 200,
                flip = false,
                dict = 'biker'
            },
            {
                name = 'reaper',
                price = 200,
                flip = false,
                dict = 'biker'
            },
        }
    }
}