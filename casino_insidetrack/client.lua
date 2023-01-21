ESX          = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local cooldown = 60
local tick = 0
local checkRaceStatus = false
local insideTrackActive = false
local Tracks = {}
selectedTrack = nil
SELECTED_CHAIR_ID = nil
CURRENT_CHAIR_DATA = nil
local closetoTrack = false
local zentony = 0

function GetItems()
	ESX.TriggerServerCallback('horse:checkitem', function(quantity)
		zentony = quantity
	end)
end


local function OpenInsideTrack()
	LocalPlayer.state:set("inv_busy", true, true)
    if insideTrackActive then
        return
    end
    insideTrackActive = true
    VNSTracks.Scaleform = RequestScaleformMovie('HORSE_RACING_CONSOLE')

    while not HasScaleformMovieLoaded(VNSTracks.Scaleform) do
        Wait(0)
    end
    DisplayHud(false)
    SetPlayerControl(PlayerId(), false, 0)
	while not RequestScriptAudioBank('DLC_VINEWOOD/CASINO_GENERAL') do
        Wait(0)
    end
    VNSTracks:ShowMainScreen()
    VNSTracks:SetMainScreenCooldown(cooldown)
    VNSTracks:AddHorses()
    VNSTracks:DrawInsideTrack()
    VNSTracks:HandleControls()
end

local function LeaveInsideTrack()
	LocalPlayer.state:set("inv_busy", false, true)
    insideTrackActive = false
    DisplayHud(true)
    SetPlayerControl(PlayerId(), true, 0)
    SetScaleformMovieAsNoLongerNeeded(VNSTracks.Scaleform)
    VNSTracks.Scaleform = -1
	SITTING_SCENE = NetworkCreateSynchronisedScene(CURRENT_CHAIR_DATA.position, CURRENT_CHAIR_DATA.rotation, 2, 1, 0, 1065353216, 0, 1065353216)
	RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
	while not HasAnimDictLoaded('anim_casino_b@amb@casino@games@shared@player@') do
		Citizen.Wait(1)
	end
	local randomSit = ({'exit_left', 'exit_right'})[math.random(1, 2)]
	NetworkAddPedToSynchronisedScene(PlayerPedId(),SITTING_SCENE,'anim_casino_b@amb@casino@games@shared@player@',randomSit,2.0,-2.0,13,16,2.0,0)
	NetworkStartSynchronisedScene(SITTING_SCENE)
	TriggerServerEvent('casino:track:notUsing', selectedTrack)
	selectedTrack = nil
end

function VNSTracks:DrawInsideTrack()
    Citizen.CreateThread(function()
        while insideTrackActive do
            Wait(0)
            local xMouse, yMouse = GetDisabledControlNormal(2, 239), GetDisabledControlNormal(2, 240)
            tick = (tick + 10)
            if (tick == 1000) then
                if (cooldown == 1) then
                    cooldown = 60
                end
                cooldown = (cooldown - 1)
                tick = 0
                VNSTracks:SetMainScreenCooldown(cooldown)
            end
            BeginScaleformMovieMethod(VNSTracks.Scaleform, 'SET_MOUSE_INPUT')
            ScaleformMovieMethodAddParamFloat(xMouse)
            ScaleformMovieMethodAddParamFloat(yMouse)
            EndScaleformMovieMethod()
            DrawScaleformMovieFullscreen(VNSTracks.Scaleform, 255, 255, 255, 255)
        end
    end)
end

function VNSTracks:HandleControls()
	GetItems()
    Citizen.CreateThread(function()
        while insideTrackActive do
            Wait(0)
            if IsControlJustPressed(2, 194) or IsControlJustPressed(2, 200) or IsControlJustPressed(2, 202) or IsControlJustPressed(2, 322) then
                LeaveInsideTrack()
				VNSTracks.CurrentHorse = -1
				VNSTracks.HorsesValue = {}
				VNSTracks.HorsesPositions = {}
            end
            if IsControlJustPressed(2, 237) then
                local button = VNSTracks:GetMouseClickedButton()
                if VNSTracks.ChooseHorseVisible then
                    if (button ~= 12) and (button ~= -1) then
                        VNSTracks.CurrentHorse = (button - 1)
						VNSTracks.CurrentBet = Config.MinBet
						mult = VNSTracks.HorsesValue[VNSTracks.CurrentHorse]
						if not mult or mult <= 0 then mult = Config.MinBet end
                        VNSTracks:ShowBetScreen(VNSTracks.CurrentHorse, zentony, VNSTracks.CurrentBet * mult)
                        VNSTracks.ChooseHorseVisible = false
                    end
                end
                if (button == 15) then
                    VNSTracks:ShowRules()
                end
                if (button == 12) then
                    if VNSTracks.ChooseHorseVisible then
                        VNSTracks.ChooseHorseVisible = false
                    end
                    if VNSTracks.BetVisible then
                        VNSTracks:ShowHorseSelection()
                        VNSTracks.BetVisible = false
                        VNSTracks.CurrentHorse = -1
                    else
                        VNSTracks:ShowMainScreen()
                    end
                end
                if (button == 1) then
                    VNSTracks:ShowHorseSelection()
                end
                if (button == 10) then
					VNSTracks.CurrentGain = (VNSTracks.CurrentBet * VNSTracks.HorsesValue[VNSTracks.CurrentHorse])
					TriggerServerEvent('horse:removechips', VNSTracks.CurrentBet)
                    VNSTracks:StartRace()
                    checkRaceStatus = true
                end
                if (button == 8) then
                    if ((VNSTracks.CurrentBet + Config.ChangeBet) < zentony) and ((VNSTracks.CurrentBet + Config.ChangeBet) <= Config.MaxBet) then
                        VNSTracks.CurrentBet = (VNSTracks.CurrentBet + Config.ChangeBet)
                        VNSTracks.CurrentGain = (VNSTracks.CurrentBet * VNSTracks.HorsesValue[VNSTracks.CurrentHorse])
                        VNSTracks:UpdateBetValues(VNSTracks.CurrentHorse, VNSTracks.CurrentBet, zentony, VNSTracks.CurrentGain)
                    end
                end
                if (button == 9) then
                    if (VNSTracks.CurrentBet > Config.ChangeBet) then
                        VNSTracks.CurrentBet = (VNSTracks.CurrentBet - Config.ChangeBet)
                        VNSTracks.CurrentGain = (VNSTracks.CurrentBet * VNSTracks.HorsesValue[VNSTracks.CurrentHorse])
                        VNSTracks:UpdateBetValues(VNSTracks.CurrentHorse, VNSTracks.CurrentBet, zentony, VNSTracks.CurrentGain)
                    end
                end
                if (button == 13) then
                    VNSTracks:ShowMainScreen()
                end
                while checkRaceStatus do
                    Wait(0)
                    BeginScaleformMovieMethod(VNSTracks.Scaleform, 'GET_RACE_IS_COMPLETE')
                    local raceReturnValue = EndScaleformMovieMethodReturnValue()
                    while not IsScaleformMovieMethodReturnValueReady(raceReturnValue) do
                        Wait(0)
                    end
                    local raceFinished = GetScaleformMovieMethodReturnValueBool(raceReturnValue)
                    if (raceFinished) then
						if VNSTracks.HorsesPositions[1] == VNSTracks.CurrentHorse then
							TriggerServerEvent('casino:track:givechips', VNSTracks.CurrentBet * VNSTracks.HorsesValue[VNSTracks.CurrentHorse], selectedTrack)
							VNSTracks:UpdateBetValues(VNSTracks.CurrentHorse, VNSTracks.CurrentBet, zentony, VNSTracks.CurrentGain)	
						end
                        VNSTracks.HorsesValue = {}
						GetItems()
                        VNSTracks:ShowResults()
                        VNSTracks.CurrentHorse = -1
                        VNSTracks.HorsesPositions = {}
                        checkRaceStatus = false
						VNSTracks:AddHorses()
						VNSTracks:UpdateBetValues(VNSTracks.CurrentHorse, VNSTracks.CurrentBet, zentony, VNSTracks.CurrentGain)
                    end
                end
            end
        end
    end)
end





Citizen.CreateThread(function()
	local trackChairs = {}
	while not closetoTrack do
		Citizen.Wait(1000)
	end
	local playerPed = PlayerPedId()
	local objects = VNSGetObjects()
	local closestDistance, closestObject = -1, -1
	local filter, coords = 'vw_prop_casino_track_chair_01', Config.Coords
	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end
	for i=1, #objects, 1 do
		local foundObject = false
		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])
			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					local data = {
						pos = GetEntityCoords(objects[i]),
						prop = 'vw_prop_casino_track_chair_01',
					}
					table.insert(trackChairs, data)
				end
			end
		end
	end
	table.sort(trackChairs, function(a,b) return a.pos.x < b.pos.x end)
	table.sort(trackChairs, function(a,b) return a.pos.y < b.pos.y end)
	table.sort(trackChairs, function(a,b) return a.pos.z < b.pos.z end)
	for k,v in pairs(trackChairs) do
		createTrackChairs(k, v)
	end
end)

createTrackChairs = function(index, data)
	local self = {}
    self.index = index
    self.data = data
	self.tableObject = GetClosestObjectOfType(data.pos,0.8,GetHashKey(self.data.prop),0,0,0)
	Tracks[self.index] = self
end
	
	
Citizen.CreateThread(function()
	while true do
		local letSleep = true
		local playerpos = GetEntityCoords(PlayerPedId())
		if closetoTrack and selectedTrack == nil then
			for k, v in pairs(Tracks) do
				if DoesEntityExist(v.tableObject) then
					local Offset = GetObjectOffsetFromCoords(GetEntityCoords(v.tableObject), GetEntityHeading(v.tableObject),0.0, -0.8, 0.0)
					if #(playerpos - Offset) <= 1.8 then
						letSleep = false
						local closestChairData = getClosestChairData(v.tableObject)
						if closestChairData == nil then
							break
						end
						if Config.UseDrawMarker then
							DrawMarker(20,closestChairData.position + vector3(0.0, 0.0, 1.0),0.0,0.0,0.0,180.0,0.0,0.0,0.2,0.2,0.2,255,255,255,255,false,true,2,true,nil,nil,false)
						end
						DrawText3Ds(closestChairData.position.x, closestChairData.position.y, closestChairData.position.z+1.2, '~g~E~w~ - Jouez')
						if IsControlJustPressed(0, 38) then
							ESX.TriggerServerCallback('casino:track:isSeatUsed',function(used)
								if used == false then
									SELECTED_CHAIR_ID = closestChairData.chairId
									CURRENT_CHAIR_DATA = closestChairData
									SITTING_SCENE = NetworkCreateSynchronisedScene(closestChairData.position, vector3(closestChairData.rotation.x, closestChairData.rotation.y, closestChairData.rotation.z-90.0), 0, 1, 0, 1065353216, 0, 1065353216)
									RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
									while not HasAnimDictLoaded('anim_casino_b@amb@casino@games@shared@player@') do
										Citizen.Wait(1)
									end
									local randomSit = ({'sit_enter_left', 'sit_enter_right'})[math.random(1, 2)]
									NetworkAddPedToSynchronisedScene(PlayerPedId(),SITTING_SCENE,'anim_casino_b@amb@casino@games@shared@player@',randomSit,2.0,-2.0,13,16,2.0,0)
									NetworkStartSynchronisedScene(SITTING_SCENE)
									selectedTrack = v.index
									Citizen.Wait(3500)
									OpenInsideTrack()
								end
							end,v.index)
						end
					end
				else
					local trackChairs = {}
					while not closetoTrack do
						Citizen.Wait(500)
					end
					local playerPed = PlayerPedId()
					local objects = VNSGetObjects()
					local closestDistance, closestObject = -1, -1
					local filter, coords = 'vw_prop_casino_track_chair_01', Config.Coords
					if type(filter) == 'string' then
						if filter ~= '' then
							filter = {filter}
						end
					end
					for i=1, #objects, 1 do
						local foundObject = false
						if filter == nil or (type(filter) == 'table' and #filter == 0) then
							foundObject = true
						else
							local objectModel = GetEntityModel(objects[i])
							for j=1, #filter, 1 do
								if objectModel == GetHashKey(filter[j]) then
									local data = {
										pos = GetEntityCoords(objects[i]),
										prop = 'vw_prop_casino_track_chair_01',
									}
									table.insert(trackChairs, data)
								end
							end
						end
					end
					table.sort(trackChairs, function(a,b) return a.pos.x < b.pos.x end)
					table.sort(trackChairs, function(a,b) return a.pos.y < b.pos.y end)
					table.sort(trackChairs, function(a,b) return a.pos.z < b.pos.z end)
					for k,v in pairs(trackChairs) do
						createTrackChairs(k, v)
					end
				end
			end
			if #Tracks == 0 then
				local trackChairs = {}
				while not closetoTrack do
					Citizen.Wait(500)
				end
				local playerPed = PlayerPedId()
				local objects = VNSGetObjects()
				local closestDistance, closestObject = -1, -1
				local filter, coords = 'vw_prop_casino_track_chair_01', Config.Coords
				if type(filter) == 'string' then
					if filter ~= '' then
						filter = {filter}
					end
				end
				for i=1, #objects, 1 do
					local foundObject = false
					if filter == nil or (type(filter) == 'table' and #filter == 0) then
						foundObject = true
					else
						local objectModel = GetEntityModel(objects[i])
						for j=1, #filter, 1 do
							if objectModel == GetHashKey(filter[j]) then
								local data = {
									pos = GetEntityCoords(objects[i]),
									prop = 'vw_prop_casino_track_chair_01',
								}
								table.insert(trackChairs, data)
							end
						end
					end
				end
				table.sort(trackChairs, function(a,b) return a.pos.x < b.pos.x end)
				table.sort(trackChairs, function(a,b) return a.pos.y < b.pos.y end)
				table.sort(trackChairs, function(a,b) return a.pos.z < b.pos.z end)
				for k,v in pairs(trackChairs) do
					createTrackChairs(k, v)
				end
			end
		end
		if letSleep then
			Citizen.Wait(500)
		end
		Citizen.Wait(0)
	end
end)

function getClosestChairData(tableObject)
    local localPlayer = PlayerPedId()
    local playerpos = GetEntityCoords(localPlayer)
    if DoesEntityExist(tableObject) then
        local objcoords = GetEntityCoords(tableObject)
		local dist = Vdist(playerpos, objcoords)
		if dist < 1.6 then
			return {
				position = objcoords,
				rotation = GetEntityRotation(tableObject),
				chairId = 1,
				obj = tableObject
			}
		end
    end
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		if #(Config.Coords - GetEntityCoords(PlayerPedId())) <= 10.0 then
			closetoTrack = true
		else
			closetoTrack = false
		end
		Citizen.Wait(500)
	end
end)

function helpText(text)
	Citizen.CreateThread(function()
		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end)
end