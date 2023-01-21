RegisterNetEvent('elders_tenue_perso:settenuehaz')
AddEventHandler('elders_tenue_perso:settenuehaz', function()
  if UseTenu then
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
       local clothesSkin = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 168, ['torso_2'] = 1,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 191, ['mask_2'] = 0,
        ['arms'] = 72,
        ['pants_1'] = 70, ['pants_2'] = 1,
        ['shoes_1'] = 62, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      else
        local clothesSkin = {
        ['tshirt_1'] = 14, ['tshirt_2'] = 0,
        ['torso_1'] = 173, ['torso_2'] = 1,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 187, ['mask_2'] = 0,
        ['arms'] = 79,
        ['pants_1'] = 85, ['pants_2'] = 1,
        ['shoes_1'] = 78, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = PlayerPedId()
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else
    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('god:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

RegisterNetEvent('elders_tenue_perso:settenuehaz1')
AddEventHandler('elders_tenue_perso:settenuehaz1', function()
  if UseTenu then
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
       local clothesSkin = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
        ['torso_1'] = 168, ['torso_2'] = 2,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 191, ['mask_2'] = 0,
        ['arms'] = 72,
        ['pants_1'] = 70, ['pants_2'] = 2,
        ['shoes_1'] = 62, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      else
        local clothesSkin = {
        ['tshirt_1'] = 14, ['tshirt_2'] = 0,
        ['torso_1'] = 173, ['torso_2'] = 2,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 187, ['mask_2'] = 0,
        ['arms'] = 79,
        ['pants_1'] = 85, ['pants_2'] = 2,
        ['shoes_1'] = 78, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = PlayerPedId()
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else
    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('god_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('god:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)