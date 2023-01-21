Config = {



    UseESX = true,
    ESXTrigg = "god:getSharedObject",

    Informateur = {
        {
            name = "Informateur n°1", 
            coords = vector3(-1912.67,1388.13,219.14), 
            heading = 263.80, 
            ped = "cs_orleans"
        },
    },

    InformationOrga = {
        {
            name = "Numéro Porte Blanchiement", 
            price = 100000, 
            info = "Le code de la porte est : 0799."
        },

        {
            name = "Numéro Porte Labo cocaine", 
            price = 50000, 
            info = "Le code de la porte est : 1207."
        },
        {
            name = "Numéro Porte Labo Meth", 
            price = 50000, 
            info = "Le code de la porte est : 9010."
        },
    },

    InformationFamille = {

        {
            name = "Numéro Porte Labo cocaine", 
            price = 50000, 
            info = "Le code de la porte est : 1207."
        },

        {
            name = "Numéro Porte Labo Opium", 
            price = 50000, 
            info = "Le code de la porte est : 9547."
        },

        {
            name = "Numéro Porte Labo Weed", 
            price = 50000, 
            info = "Le code de la porte est : 0973."
        },        
    },


    Information = {

        {
            name = "Numéro Porte Labo Weed", 
            price = 50000, 
            info = "Le code de la porte est : 0973."
        },
        {
            name = "Numéro Porte Labo Opium", 
            price = 50000, 
            info = "Le code de la porte est : 9547."
        },
    },
}


if Config.UseESX == true then 
    if IsDuplicityVersion() then 
        ESX = nil
        TriggerEvent(Config.ESXTrigg, function(obj) ESX = obj end)
    else
        ESX = nil
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent(Config.ESXTrigg, function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    end
end