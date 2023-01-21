DEBUG_RAY = false
cliqued = false

PLAYER_NAME_HEAP = {}

SCALEFORM_ID_MIN = 3
SCALEFORM_ID_MAX = 12

SPRAY_FORWARD_OFFSET = 0.035

FORBIDDEN_MATERIALS = {
    [1913209870] = true,
    [-1595148316] = true,
    [510490462] = true,
    [909950165] = true,
    [-1907520769] = true,
    [-1136057692] = true,
    [509508168] = true,
    [1288448767] = true,
    [-786060715] = true,
    [-1931024423] = true,
    [-1937569590] = true,
    [-878560889] = true,
    [1619704960] = true,
    [1550304810] = true,
    [951832588] = true,
    [2128369009] = true,
    [-356706482] = true,
    [1925605558] = true,
    [-1885547121] = true,
    [-1942898710] = true,
    [312396330] = true,
    [1635937914] = true,
    [-273490167] = true,
    [1109728704] = true,
    [223086562] = true,
    [1584636462] = true,
    [-461750719] = true,
    [1333033863] = true,
    [-1286696947] = true,
    [-1833527165] = true,
    [581794674] = true,
    [-913351839] = true,
    [-2041329971] = true,
    [-309121453] = true,
    [-1915425863] = true,
    [1429989756] = true,
    [673696729] = true,
    [244521486] = true,
    [435688960] = true,
    [-634481305] = true,
    [-1634184340] = true,
}

SPRAYS = {}

RegisterNetEvent('rcore_spray:setSprays')
AddEventHandler('rcore_spray:setSprays', function(s)
    SPRAYS = s
end)

CreateThread(function()
    TriggerServerEvent('rcore_spray:playerSpawned')
end)

Citizen.CreateThread(function()
    local disabledKeys = {
        14, 15, 16, 17, 261, 262
    }

    while true do
        
        interval = 750
        local scaleformHandleIdx = SCALEFORM_ID_MIN
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, spray in pairs(SPRAYS) do
            if (spray.color or spray.image) and #(coords - spray.realLocation) < 100.0 then
                DrawSpray(PLAYER_NAME_HEAP[scaleformHandleIdx], spray)
                interval = 1
                scaleformHandleIdx = scaleformHandleIdx + 1

                if scaleformHandleIdx >= SCALEFORM_ID_MAX then
                    break
                end
            end
        end

        if IsSpraying then
            interval = 1
            for _, key in pairs(disabledKeys) do
                DisableControlAction(0, key, true)
            end

            local rayEndCoords, rayNormal, fwdVector = FindRaycastedSprayCoords()

            if rayEndCoords and rayNormal then
                local sprayCoords = rayEndCoords + fwdVector * SPRAY_FORWARD_OFFSET

                local realScale
                local realFont

                if SprayImageDict then
                    realScale = SprayScale * FastImageMap[SprayImageDict .. SprayImage].scale
                else
                    realScale = SprayScale * FONTS[SprayFont].sizeMult
                end

                if SprayFont then
                    realFont = FONTS[SprayFont].font
                end

                DrawSpray(PLAYER_NAME_HEAP[SCALEFORM_ID_MAX], {
                    location = sprayCoords,
                    rotation = rayNormal, 
                    
                    scale = realScale,
                    text = FormattedSprayText,
                    font = realFont,
                    color = SprayColorHex,

                    imageDict = SprayImageDict,
                    image = SprayImage,
                })

                if IsControlPressed(0, 201) and cliqued == false then-- or IsDisabledControlPressed(0, 176) then
                    cliqued = true
                    Citizen.CreateThread(function()
                        PersistSpray()
                        
                        IsSpraying = false
                        SprayText = ''
                        SprayImageDict = nil
                        SprayImage = nil
                    end)
                    SendNUIMessage({
                        type = 'hide'
                    })
                    Citizen.Wait(50)
                    cliqued = false
                end
            end

            if IsDisabledControlPressed(0, 262) then
                interval = 1
                SprayScale = math.max(SprayScaleMin, SprayScale - 0.5)
            elseif IsDisabledControlPressed(0, 261) then
                interval = 1
                SprayScale = math.min(SprayScaleMax, SprayScale + 0.5)
            elseif IsControlPressed(0, 177) or IsDisabledControlPressed(0, 177) then
                interval = 1
                IsSpraying = false
                SprayText = ''
                SprayImageDict = nil
                SprayImage = nil
                SendNUIMessage({
                    type = 'back'
                })
                SetNuiFocus(true, true)
            end
        end
        Citizen.Wait(interval)
    end
end)

rotCam = nil
wantedSprayLocation = nil
wantedSprayRotation = nil
currentSprayRotation = nil
wantedSprayScale = nil

currentSprayLocation = nil
currentSprayRotation = nil
currentSprayScale = nil

currentComputedRotation = vector3(0,0,0)
currentComputedLocation = vector3(0,0,0)

Citizen.CreateThread(function()
    rotCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local ttl = 30

    while true do
        
        interval = 750
        if wantedSprayLocation and wantedSprayRotation and wantedSprayScale and IsSpraying then
            interval = 1
            if ttl >= 0 then
                ttl = ttl - 1
            end

            if (not currentSprayLocation or #(currentSprayLocation - wantedSprayLocation) > 0.001) or currentSprayRotation ~= wantedSprayRotation or currentSprayScale ~= wantedSprayScale or not currentSprayRotation or ttl < 0 then
                ttl = 30
                RunRecomputeTick()
            end
        end
        Wait(interval)
    end
end)

function RunRecomputeTick()
    local wantedSprayRotationFixed = vector3(
        wantedSprayRotation.x, 
        wantedSprayRotation.y, 
        wantedSprayRotation.z + 0.03
    )

    local computedPos, computedRot = GetRotationThruCamera(wantedSprayLocation, wantedSprayRotationFixed, wantedSprayScale)

    currentSprayLocation = wantedSprayLocation
    currentSprayRotation = wantedSprayRotation
    currentComputedLocation = computedPos
    currentComputedRotation = computedRot
    currentSprayScale = wantedSprayScale
end

if Framework.STANDALONE then
    RegisterCommand('removespray', function(source, args)
        TriggerEvent('rcore_spray:removeClosestSpray')
    end, false)
end

Citizen.CreateThread(function() 
    while true do
        LoadAllSprayScaleforms()
        Wait(5000)
	end 
end)

function LoadAllSprayScaleforms()
    for i = SCALEFORM_ID_MIN, SCALEFORM_ID_MAX do
        Wait(0)
        local paddedI = i

        if paddedI < 10 then
            paddedI = "0" .. paddedI
        end

        if not PLAYER_NAME_HEAP[i] or not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) then
            PLAYER_NAME_HEAP[i] = RequestScaleformMovieInteractive("PLAYER_NAME_" .. paddedI)
            while not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) do Citizen.Wait(0) end
        end
    end
end

function rgbToHex(rgb)
	local hexadecimal = ''

	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, d in pairs(IMAGES) do
            SetStreamedTextureDictAsNoLongerNeeded(d.dict)
        end
	end
end)
