function CreateClothesCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesCamProche()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesCamNormal()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesCamEloignez()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.50, coords.y, coords.z+0.50)
    SetCamFov(cam, 60.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesShoesCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.7)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.7)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesPantsCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesArmsCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.15)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.15)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesBasiqueCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateClothesFaceCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y, coords.z+0.5)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateAccsCam(state)
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    if state == 1 then
        SetCamCoord(cam, coords.x-2.0, coords.y, coords.z+0.5)
        SetCamFov(cam, 30.0)
        PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    elseif state == 2 then
        SetCamCoord(cam, coords.x, coords.y+1.5, coords.z+0.5)
        SetCamFov(cam, 30.0)
        PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    elseif state == 3 then
        SetCamCoord(cam, coords.x, coords.y-1.5, coords.z+0.5)
        SetCamFov(cam, 30.0)
        PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    elseif state == 4 then
        SetCamCoord(cam, coords.x+2.0, coords.y, coords.z+0.5)
        SetCamFov(cam, 25.0)
        PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    end
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function ClothesSkinRota()
    RUIText({message = "Vous pouvez appuyer sur ~b~ESPACE~s~ pour tourner votre personnage."})             
    if IsControlJustPressed(0, 22) then
        SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1))+45)
    end
end
