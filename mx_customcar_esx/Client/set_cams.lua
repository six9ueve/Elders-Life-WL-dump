cam = nil
gameplaycam = nil

CamerasConfigs = {
    -- Spoiler 
    [0] = {osso = 'boot', cam = {valor = 'back', x = 0.5, y = -1.6,z = 1.3}},

    -- Front bumpers
    [1] = {osso = 'bumper_f', cam = {valor = 'front', x = 0.1, y = 0.6,z = 0.4}},

    -- Rear bumpers
    [2] = {osso = 'bumper_r', cam = {valor = 'back', x = 0.5, y = -1.6,z = 0.4}},

    -- Skirts
    [3] = {osso = 'neon_r'},

    -- Exhaust
    [4] = {osso = 'exhaust', cam = {valor = 'back', x = 0.5, y = -1.6,z = 0.4}},

    -- Roll cage
    [5] = {osso = 'seat_dside_f', cam = {valor = 'front-top', x = 0.1, y = -1.5,z = 0.5}},

    -- Grille 
    [6] = {osso = 'bumper_f', cam = {valor = 'front', x = 0.1, y = 0.6,z = 0.4}},

    -- Hood 
    [7] = {osso = 'bonnet'},

    -- Fenders
    [8] = {osso = 'wheel_rf'},

    -- Right Fender
    [9] = {osso = 'roof', cam = {valor = 'front-top', x = 0.5, y = -2.6,z = 1.5}},

    -- Roof
    [10] = {osso = 'roof', cam = {valor = 'front-top', x = 0.5, y = -2.6,z = 1.5}},

    -- Engine
    [11] = {osso = 'engine', acao = "abrir_capo"},

    -- Brakes
    [12] = {osso = 'wheel_rf'},

    -- Transmission
    [13] = {osso = 'engine'},

    -- Horn
    [14] = {osso = 'bumper_f', cam = {valor = 'front', x = 3.5, y = 1.0,z = 1.5}},

    -- Suspension
    [15] = {osso = 'wheel_rf'},

    -- Armor
    [16] = {osso = 'bodyshell'},

    -- Turbo
    [18] = {osso = 'engine'},

    -- Headlights
    [22] = {osso = 'headlight_r'},

    -- Front Wheels
    [23] = {osso = 'wheel_rf'},

    -- Back Wheels
    [24] = {osso = 'wheel_lr'},

    -- Plate holder
    [25] = {osso = 'exhaust', cam = {valor = 'front', x = 0.1, y = 0.6,z = 0.4}},

    -- Vanity plates
    [26] = {osso = 'exhaust',cam = {valor = 'front', x = 0.1, y = 0.6,z = 0.4}},

    -- Trim
    [27] = {osso = 'bumper_f'},

    -- Ornaments
    [28] = {osso = 'seat_dside_f'},

    -- Dashboard
    [29] = {osso = 'seat_dside_f'},

    -- Dial
    [30] = {osso = 'seat_dside_f', cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}},

    -- Door speaker
    [31] = {osso = 'door_dside_f'},

    -- Seats
    [32] = {osso = 'seat_dside_f'},

    -- Steering wheel
    [33] = {osso = 'seat_dside_f', cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}},

    -- Shift leavers
    [34] = {cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}, osso = 'steeseat_dside_fring'},

    -- Plaques
    [35] = {cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}, osso = 'steeseat_dside_fring'},

    -- Speakers
    [36] = {osso = 'door_dside_f'},

    -- Trunk
    [37] = {osso = 'boot'},

    -- Hydraulics
    [38] = {osso = 'wheel_rf'},

    -- Engine block
    [39] = {osso = 'engine', acao = 'abrir_capo'},

    -- Air filter
    [40] = {osso = 'engine', acao = 'abrir_capo'},

    -- Struts
    [41] = {osso = 'engine', acao = 'abrir_capo'},

    -- Arch cover
    [42] = {osso = 'engine', acao = 'abrir_capo'},

    -- Aerials
    [43] = {cam = {valor = 'front', x = 0.5, y = 0.6,z = 0.4}},

    -- Trim
    [44] = {osso = 'boot'},

    -- Tank
    [45] = {osso = 'chassis', cam = {valor = 'front', x = 0.2, y = 0.3,z = 0.1}},

    -- Windows
    [46] = {osso = 'window_lf1', cam = {valor = 'right', x = 0.8, y = 0.8,z = 0.8}},

    -- Liveries
    [48] = {osso = 'chassis', cam = {valor = 'front', x = -2.1, y = 0.6,z = 1.1}},
    
    ['repair'] = {osso = '', cam = {valor = 'front', x = 0.0, y = 2.0,z = 1.5}},
    ['plateIndex'] = {osso = 'boot', cam = {valor = 'back', x = 0.5, y = -1.6,z = 1.3}},
    ['veh_color'] = {osso = '', cam = {valor = 'front', x = 3.5, y = 1.0,z = 1.5}},
    ['wheel_color'] = {osso = 'wheel_rf'},
    ['turbo'] = {osso = 'wheel_rf'},
    ['tyres_smoke'] = {osso = 'boot', cam = {valor = 'back', x = 0.5, y = -1.6,z = 1.3}},
    ['pearlescent_color'] = {osso = '', cam = {valor = 'front', x = -2.0, y = 1.0, z = 1.5}},
    ['xenon_colors'] = {osso = 'boot', cam = {valor = 'front', x = 0.1, y = 1.25,z = 0.4}},
    ['plate'] = {osso = 'boot'},
    ['neon_color'] = {osso = 'boot', cam = {valor = 'middle', x = 2.1, y = 2.1,z = -0.1}},
    ['windows_tint'] = {osso = 'boot', cam = {valor = 'left', x = -1.0, y = -0.0,z = 0.9}},
    ['extras'] = {osso = 'boot', cam = {valor = 'left', x = -1.0, y = -0.0,z = 0.9}},
    ['dashboard_color'] = {osso = 'seat_dside_f', cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}},
    ['interior_color'] = {osso = 'seat_dside_f', cam = {valor = 'left', x = -0.2, y = -0.5,z = 0.9}},
}

function Nui_Cams(on, move)
    if set_cams then
        if on then
            -- Cam on
            gameplaycam = GetRenderingCam()
            if not IsCamActive(cam) then
                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
                CreateModCam()

                if move then
                    ControlCam('front-top',-2.5,0.1,1.3)
                end
            else
                CreateModCam()
                SetCamActive(cam, true)

                if move then
                    ControlCam('front-top',-2.5,0.1,1.3)
                end
            end
        elseif not on then
            -- Cam off
            RenderScriptCams( 0, 1, 1000, 0, 0)
            SetCamActive(gameplaycam, false)
            EnableGameplayCam(true)

            DestroyCam(cam, true)
            DestroyCam(gameplaycam, true)
        end
    end
end

function ControlCam(val,x,y,z) -- OK
    if set_cams then
        control = val
        SetCamActive(cam, true)
        local entity = GetVehiclePedIsIn(PlayerPedId(),false)
        if entity > 0 then
            local dimension = GetModelDimensions(GetEntityModel(entity))
            local l,w,h = dimension.y*-2, dimension.x*-2, dimension.z*-2
            SetCamCoord(cam, CamOption(val,x,y,z,entity,w,l,h))
            PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(entity, 0, 0, 0))
            RenderScriptCams( 1, 1, 1500, 0, 0)
        end
    end
end

function BoneCamera(bone)
    if set_cams then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
        if vehicle > 0 then
            CreateModCam()
            SetCamActive(cam, true)
            if bone ~= -1 and GetEntityBoneIndexByName(vehicle, bone) then
                local offset = GetOffsetFromEntityGivenWorldCoords(vehicle, GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, bone)))
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, offset.x + 1, offset.y + 1, offset.z +1))
                SetCamCoord(cam, x, y, z)
                PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(vehicle, 0, offset.y, offset.z))
                RenderScriptCams( 1, 1, 1100, 0, 0)
            end
        end
    end
end

function CreateModCam() -- OK
    if set_cams then
        SetCamCoord(cam,GetGameplayCamCoords())
        SetCamRot(cam, GetGameplayCamRot(2), 2)
        RenderScriptCams( 0, 1, 1000, 0, 0)
        SetCamActive(gameplaycam, true)
        EnableGameplayCam(true)
        SetCamActive(cam, false)
    end
end

function CamOption(val,x,y,z,entity,w,l,h)
    if set_cams then
        local view = {
            ['left'] = {-(w/2) + x, y, z},
            ['right'] = {(w/2) + x, y, z},
            ['front'] = {x, (l/2)+ y, z},
            ['front-top'] = {x, (l/2) + y,(h) + z},
            ['back'] = {x, -(l/2) + y,z},
            ['back-top'] = {x, -(l/2) + y,(h/2) + z},
            ['middle'] = {x, y, (h/2) + z},
        }
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(entity, table.unpack(view[val])))
        return x,y,z
    end
end