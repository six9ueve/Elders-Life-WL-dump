local markerType = 1 -- Change to a Marker of your choice - https://docs.fivem.net/docs/game-references/markers/

local markerColorR = 10 -- Change Marker color here (RED)
local markerColorG = 255 -- Change Magithrker color here (GREEN)
local markerColorB = 255 -- Change Marker color here (BLUE)

local afterBurn = 1000 -- How long should the Marker be drawn after the range has been changed?

local isDrawing = false -- don't touch!
local curProx = 0.0 -- don't touch!

RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(range)
    isDrawing = true
    curProx = tonumber(range)
    CreateThread(function() 
     drawMarker()
    end)
    Wait(afterBurn)
    isDrawing = false
end)

function drawMarker()
    while isDrawing do
        local posPlayer = GetEntityCoords(PlayerPedId())
        DrawMarker(1, posPlayer.x, posPlayer.y, posPlayer.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, (curProx * 2), (curProx * 2), 1.0, markerColorR, markerColorG, markerColorB, 150, false, false, 2, false, false, false, false)
        Wait(1)
    end
end