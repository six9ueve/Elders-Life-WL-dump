local depessing, oldAnimal = false, nil
local IsAnimated = false
local entities = {} 
local hasPlacedBaitRecently = false

local function showNotification(message)
	AddTextEntry('dspNotification', message)
	BeginTextCommandThefeedPost('dspNotification')
    EndTextCommandThefeedPostMessagetext(ConfigHunting.notificationTexture, ConfigHunting.notificationTexture, false, ConfigHunting.notificationIconType, LanguageHunting['sender'], LanguageHunting['subject'])
	EndTextCommandThefeedPostTicker(false, true)
end
local function showInfo(info)
	SetTextComponentFormat("STRING")
	AddTextComponentString(info)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end
local function GetPedInFront()
    local player            = PlayerId()
    local plyPed            = GetPlayerPed(player)
    local plyPos            = GetEntityCoords(plyPed, false)
    local plyOffset         = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle         = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
    local _, _, _, _, ped   = GetShapeTestResult(rayHandle)

    return ped
end
local function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y    = World3dToScreen2d(x,y,z)
    local factor            = #text / 370
    local px,py,pz          = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end
local function hasValidWeapon(weaponSelected)
    local result
    for k,v in pairs(ConfigHunting.WeaponList) do
        if (v.required and weaponSelected == GetHashKey(v.name)) then
            result = k
            break
        end
    end
    return result
end
local function isAnAnimal(hash)
    local result
    for k,v in pairs(ConfigHunting.Animals) do
        if (string.upper(tostring(v.hash)) == string.upper(tostring(hash))) then
            result = k
            break
        end
    end
    return result
end


local function interact()
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

    depessing           = true
    oldAnimal           = targetAnimal
    local Animal        = ConfigHunting.Animals[isAnAnimal(GetEntityModel(oldAnimal))]

    if (Animal) then
        local message = LanguageHunting['depessing']
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 2, false, false, false)
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 2, false, false, false)

        if (ConfigHunting.useProgresseBar) then exports['progressBars']:startUI(Animal.butcheringTime * 1000, LanguageHunting['progressBarMessage']) end
        Citizen.Wait(Animal.butcheringTime * 1000)
        DeleteEntity(oldAnimal)
        ClearPedTasksImmediately(PlayerPedId())
        
        TriggerServerEvent('dsp_hunting:requestReward', Animal)
        --showNotification(message:gsub("%%s", Animal.label))
    end

    targetAnimal = nil
    depessing = false
end
RegisterNetEvent('dsp_hunting:showMessage')
AddEventHandler('dsp_hunting:showMessage', function(message)
    showNotification(message)
end)

RegisterNetEvent('dsp_hunting:placingBait')
AddEventHandler('dsp_hunting:placingBait', function()
    
    

	if hasPlacedBaitRecently == false then
	
	
    local player = PlayerPedId() 
    local pos = GetEntityCoords(player,1)
	
    baitPosition = {x = pos.x, y=pos.y}

        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        if not IsAnimated then
            IsAnimated = true
            if (ConfigHunting.useProgresseBar) then exports['progressBars']:startUI(7000, 'Pose de l\'âppat en cours...') end
            TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 2, false, false, false)
            TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 2, false, false, false)
        end
			hasPlacedBaitRecently = true
            Citizen.Wait(7000)
            IsAnimated = false
            ClearPedTasksImmediately(PlayerPedId())
			showNotification("Appât de chasse utilisé")
			TriggerServerEvent('dsp_hunting:giveBackBait', 0)
			
			Citizen.Wait(30000)
			showNotification("Tu peux reposer un bait")
			hasPlacedBaitRecently = false
	
	elseif hasPlacedBaitRecently == true then
	
	showNotification("Vous ne pouvez pas faire cela.")
		
	end
end)




RegisterNetEvent('dsp_hunting:spawningAnimals')
AddEventHandler('dsp_hunting:spawningAnimals', function()

    local player = PlayerPedId() 
    local pos = GetEntityCoords(player,1)
    local ground
    local animal_name = 
        {'a_c_boar', 
        'a_c_chickenhawk',
        'a_c_cormorant',
        'a_c_coyote',
        'a_c_deer',
        'a_c_mtlion',
        'a_c_rabbit_01'
        }
    local i = math.random(1,#animal_name)
    local animal_random = animal_name[i]
    local angle = math.random(0,359)/360*2*math.pi
    local distanceFuite = 5


    if (#entities < 1) then--how many animals to spawn
        RequestModel(animal_random)
        while not HasModelLoaded(animal_random) or not HasCollisionForModelLoaded(animal_random) do
        Wait(1)
        end				 

        posX = baitPosition.x+math.cos(angle)*15
        posY = baitPosition.y+math.sin(angle)*15
        Z = pos.z+999.0
        heading = math.random(0,359)+.0
        
        

        ground,posZ = GetGroundZFor_3dCoord(posX+.0,posY+.0,Z,1)
        
        if(ground) then
            
            
            ped = CreatePed(28, animal_random, posX, posY, posZ, heading, true, true)
            SetEntityAsMissionEntity(ped, true, true)
            
            
            TaskGoStraightToCoord(ped, baitPosition.x - 1, baitPosition.y - 1, baitPosition.z, 0.5, -1, heading, 2)

                        SetModelAsNoLongerNeeded(ped)
                        SetPedAsNoLongerNeeded(ped) -- despawn when player no longer in the area

                        
                        table.insert(entities,ped) 	
                        --print(animal_random.." spawned, number of animal : "..#entities.."/3")
                        Wait(500)

                        Citizen.CreateThread(function()
                            local block = false
                            while DoesEntityExist(ped) ~= nil do
                                Wait(100)
                                if #(GetEntityCoords(player,1) - GetEntityCoords(ped,1)) < distanceFuite and IsPedDeadOrDying(ped) == false and block == false then 
                                    ClearPedTasksImmediately(ped) 
                                    TaskSmartFleePed(ped, player, 9000.0, -1, false, false)

                                    block = true                                                      
                                end

                                for i, ped in pairs(entities) do
                                    if IsPedDeadOrDying(ped) then --Check si l'animal est mort, ne le track plus en suite
                                        
                                        local model = GetEntityModel(ped)
                                        table.remove(entities,i)	
                                        print (ped.." no longer tracked, cause he's dead")

                                        Wait(60000 * 5)
                                        DeleteEntity(ped)
                                        print (ped.." despawn car mort depuis 5minutes+")
                                    end
                                end

                            end
                        end)

                        Wait(60000)
                        for i, pedFor in pairs(entities) do
                            if (pedFor == ped) and not IsPedDeadOrDying(ped) then
                                TaskSmartFleePed(ped, player, 9000.0, -1, false, false)
                                Wait(10000)
                                print (pedFor.." despawn")
                                local model = GetEntityModel(ped)
                                DeleteEntity(ped)
                                table.remove(entities,i)
                            end
                        end
                end
            end

            for i, ped in pairs(entities) do
                if IsEntityInWater(ped) then --if the animal spawns in water it will auto delete
                    local model = GetEntityModel(ped)
                    SetEntityAsNoLongerNeeded(ped)
                    SetModelAsNoLongerNeeded(model)
                    table.remove(entities,i)	
                    
                end
            end
            
            
        ------------------------------------------
    end)




Citizen.CreateThread(function()
    while true do
        interval = 750
        if targetAnimal ~= 0 then
            if IsPedDeadOrDying(targetAnimal)then
                interval = 1
                local pedType = GetPedType(targetAnimal)
                if targetAnimal ~= oldAnimal and not depessing and (pedType == 28) then
                    local pos = GetEntityCoords(targetAnimal)
                    DrawText3Ds(pos.x, pos.y, pos.z, LanguageHunting["actionMessage"])

                    if IsControlJustPressed(1, ConfigHunting.keys['interact']) then
                        if (ConfigHunting.useWeapon) then
                            if (hasValidWeapon(GetSelectedPedWeapon(PlayerPedId()))) then
                                interact()
                            else
                                showNotification(LanguageHunting["notKnife"])
                            end
                        else
                            interact()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local playerPed = PlayerPedId() 

        if not IsPedInAnyVehicle(playerPed) or not IsPedDeadOrDying(playerPed) then
            local animal = GetPedInFront()
            if (IsPedDeadOrDying(animal)) then
                targetAnimal = animal
            end
        else
            Citizen.Wait(500)
        end
    end
end)


