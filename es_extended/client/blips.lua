local locationsBlips = { 
{ id = 269, name = "[ETAT] | Location", color = 27,  pos= vector3(-1052.488,-2712.395,13.66)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,  pos= vector3(233.0854492188,-751.3107910156,34.64)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,  pos= vector3(-1272.194,-644.4275,26.81)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,   pos= vector3(-171.880,214.995,89.225)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,   pos= vector3(1997.2288,3778.3107910156,32.23)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,   pos= vector3(1706.66,4793.281,41.98)}, 
{ id = 269, name = "[ETAT] | Location", color = 27,   pos= vector3(-189.540,6236.496,31.49)},
{ id = 269, name = "[ETAT] | Location Vélo", color = 27,   pos= vector3(1855.133,2592.289,45.1552)},
{ id = 269, name = "[ETAT] | Location Vélo", color = 27,   pos=vector3(-1114.638,-1687.32,4.51)}, 
{ id = 269, name = "[ETAT] | Location Bateau", color = 27,	pos= vector3(-1612.1522,-1126.4547,2.3193)},
{ id = 269, name = "[ETAT] | Location Bateau", color = 27,	pos= vector3(-265.894,6633.076,7.507)},
{ id = 269, name = "[ETAT] | Location Bateau", color = 27, 	pos= vector3(-1507.021,1502.819,115.288)},
{ id = 269, name = "[ETAT] | Télépherique", color = 27,	pos= vector3(-739.6201,5595.4140,41.6545)},
{ id = 269, name = "[ETAT] | Télépherique", color = 27, pos= vector3(444.7795,5572.0200,781.1888)},
{ id = 269, name = "[ETAT] | Location 4x4", color = 27,	pos= vector3(4518.95,-4463.76,4.18)},
{ id = 269, name = "[ETAT] | Location 4x4", color = 27,	pos= vector3(4986.83,-5178.22,2.50)},
{ id = 269, name = "[ETAT] | Location Kart", color = 27,	pos= vector3(-126.62,-2147.48,16.70)},
}

Citizen.CreateThread(function()
    for _,v in pairs(locationsBlips) do
        v.loc = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(v.loc, v.id)
        SetBlipDisplay(v.loc, 4)
        SetBlipScale(v.loc, 0.6)
        SetBlipColour(v.loc, v.color)
        SetBlipAsShortRange(v.loc, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(v.loc)
    end   
end)