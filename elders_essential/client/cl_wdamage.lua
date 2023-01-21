Citizen.CreateThread(function()
    for k, v in pairs(Configwdamage.weapon) do
        SetWeaponDamageModifier(GetHashKey(v.model), v.multipli)
    end
end)