DecorRegister("Yay", 4)
Heading = 209.00
pedHash = "a_f_y_business_02"


zone = {
    Lifeinveders = vector3(-266.73, -960.29, 30.22),
    Chantier = vector3(-509.94, -1001.59, 22.55),
    Jardinier = vector3(-1347.78, 113.09, 55.37),
    ups = vector3(-315.054, -1031.749, 30.53),
    poubelle = vector3(-321.21, -1545.29, 31.01),
    chomage = vector3(-234.61, -920.83, 32.31),


}

local travailleZone = {
    {
        zone = vector3(-509.94, -1001.59, 22.55),
        nom = "Chantier",
        blip = 175,
        couleur = 44,
    },
    {
        zone = vector3(-1347.78, 113.09, 55.37),
        nom = "Golf",
        blip = 109,
        couleur = 43,   
    },

}


Citizen.CreateThread(function()
    LoadModel(pedHash)
    local ped = CreatePed(2, GetHashKey(pedHash), zone.Lifeinveders, Heading, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, 1)

    local blip = AddBlipForCoord(zone.Lifeinveders)
    SetBlipSprite(blip, 590)
    SetBlipScale(blip, 0.6)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    for k,v in pairs(travailleZone) do
        local blip = AddBlipForCoord(v.zone)
        SetBlipSprite(blip, v.blip)
        SetBlipScale(blip, 0.6)
        SetBlipShrink(blip, true)
        SetBlipColour(blip, v.couleur)
        SetBlipAsShortRange(blip, true)


        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.nom)
        EndTextCommandSetBlipName(blip)
    end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Emploi intérimaire")
    EndTextCommandSetBlipName(blip)
end)


function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end
end