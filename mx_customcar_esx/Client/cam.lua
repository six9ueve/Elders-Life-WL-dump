ActiveCam = false

-- Pressing H turns nui focus off
RegisterNUICallback('ActiveCam', function(data, cb)  
    ActiveCam = true
    SetNuiFocus(false,false)
    Nui_Cams(false, false)
    cb('ok')
end)

-- By pressing H, the nui focus is activated.
RegisterCommand(''..'mx_focusCustom', function()
    if ActiveCam then
        SetNuiFocus(true,true)
        ActiveCam = false
        Nui_Cams(true, false)
    end
end, false)
RegisterKeyMapping(''..'mx_focusCustom', ''..'mx_focusCustom', 'keyboard', 'h')
