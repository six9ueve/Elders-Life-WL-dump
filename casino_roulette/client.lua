ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(100)
	end
end)


function changeBetAmount(amount)
	currentBetAmount = amount
end

function getGenericTextInput(type)
	if type == nil then
		type = ''
	end
	AddTextEntry('FMMC_MPM_NA', tostring(type))
	DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', tostring(type), '', '', '', '', 30)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0)
		Wait(0)
	end
	if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
	end
	return false
end

Citizen.CreateThread(function()
	while not closetocasino do
		Citizen.Wait(500)
	end

	for index, data in pairs(Config.Tables) do
		createRouletteTables(index, data, true)
		RequestAnimDict('anim_casino_b@amb@casino@games@roulette@table')
		RequestAnimDict('anim_casino_b@amb@casino@games@roulette@dealer_female')
		RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
		RequestAnimDict('anim_casino_b@amb@casino@games@roulette@player')
	end
	
	while true do
		if ESX then
			if selectedRulett ~= nil then
				SetTextScale(0.45, 0.45)
				SetTextFont(fontid)
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				AddTextComponentSubstringPlayerName('~w~La partie démarre dans : ~b~'..seconds..' ~w~secondes.')
				EndTextCommandDisplayText(0.6, 0.7500)
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
		Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
	while true do
		local letSleep = true
		if ESX then
			local playerpos = GetEntityCoords(PlayerPedId())
			if closetocasino and selectedRulett == nil then
				for k, v in pairs(Roulettes) do
					if DoesEntityExist(v.tableObject) then
						local objcoords = GetEntityCoords(v.tableObject)
						local dist = Vdist(playerpos, objcoords)
						if dist < 2.2 then
							letSleep = false
							local closestChairData = getClosestChairData(v.tableObject)
							if closestChairData == nil then
								break
							end
							DrawMarker(20, closestChairData.position + vector3(0.0, 0.0, 1.0), 0.0 , 0.0, 0.0, 180.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 255, false, true, 2, true, nil, nil, false)
							helpText('Appuyez sur  ~INPUT_CONTEXT~ pour jouer a la roulette. ~n~Minimum: ~y~'..v.data.minBet..'~w~ Jetons~n~Maximum: ~y~'..v.data.maxBet..'~w~ Jetons')
							if IsControlJustPressed(0, 38) then
								ESX.TriggerServerCallback('vns-roulette:server:seatused',function(used)
									if not used then
										SELECTED_CHAIR_ID = closestChairData.chairId
										CURRENT_CHAIR_DATA = closestChairData
										SITTING_SCENE = NetworkCreateSynchronisedScene(closestChairData.position, closestChairData.rotation, 2, 1, 0, 1065353216, 0, 1065353216)
										RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
										while not HasAnimDictLoaded('anim_casino_b@amb@casino@games@shared@player@') do
											Citizen.Wait(1)
										end
										local randomSit = ({'sit_enter_left', 'sit_enter_right'})[math.random(1, 2)]
										NetworkAddPedToSynchronisedScene(PlayerPedId(), SITTING_SCENE, 'anim_casino_b@amb@casino@games@shared@player@', randomSit, 2.0, -2.0, 13, 16, 2.0, 0)
										NetworkStartSynchronisedScene(SITTING_SCENE)
										SetPlayerControl(PlayerId(), 0, 0)
										startRulett(k, closestChairData.chairId)
										Citizen.Wait(4000)
										SetPlayerControl(PlayerId(), 1, 0)
									end
								end, k, closestChairData.chairId)
							end
							break
						end
					else
						for rulettIndex, data in pairs(Config.Tables) do
							createRouletteTables(rulettIndex, data, false)
						end
					end
				end
			end
		end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
	end
end)

function casinoNuiUpdateGame(rulettIndex, ido, statusz)
	if selectedRulett == rulettIndex then
		if not statusz then
			seconds = ido
		else
			seconds = 0
		end
	end
end

function addRandomClothes(ped)
	local r = math.random(1,9)
	if r == 1 then
		SetPedComponentVariation(ped, 0, 4, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 0, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
	elseif r == 2 then
		SetPedComponentVariation(ped, 0, 3, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 3 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 0, 1, 3)
		SetPedComponentVariation(ped, 3, 0, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
	elseif r == 4 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 1, 0)
		SetPedComponentVariation(ped, 3, 3, 3, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 5 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 4, 1, 0)
		SetPedComponentVariation(ped, 3, 2, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		
	elseif r == 6 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 7 then
		SetPedComponentVariation(ped, 0, 1, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 1, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 8 then
		SetPedComponentVariation(ped, 0, 2, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 0, 0)
		SetPedComponentVariation(ped, 3, 2, 3, 0)
		SetPedComponentVariation(ped, 4, 0, 0, 0)
		SetPedComponentVariation(ped, 6, 0, 0, 0)
		SetPedComponentVariation(ped, 7, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 2, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 9 then
		SetPedComponentVariation(ped, 0, 2, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 2, 1, 0)
		SetPedComponentVariation(ped, 3, 3, 3, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 3, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	elseif r == 10 then
		SetPedComponentVariation(ped, 0, 3, 0, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 0, 0)
		SetPedComponentVariation(ped, 3, 0, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 1, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
		SetPedPropIndex(ped, 1, 0, 0, false)
	elseif r == 11 then
		SetPedComponentVariation(ped, 0, 3, 1, 0)
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 2, 3, 1, 0)
		SetPedComponentVariation(ped, 3, 1, 1, 0)
		SetPedComponentVariation(ped, 4, 1, 0, 0)
		SetPedComponentVariation(ped, 6, 1, 0, 0)
		SetPedComponentVariation(ped, 7, 2, 0, 0)
		SetPedComponentVariation(ped, 8, 1, 0, 0)
		SetPedComponentVariation(ped, 10, 0, 0, 0)
		SetPedComponentVariation(ped, 11, 0, 0, 0)
	end
end

function helpText(text)
	AddTextEntry('roulettecasinohelp', text)
	BeginTextCommandDisplayHelp('roulettecasinohelp')
	EndTextCommandDisplayHelp(0, false, true, 1)
end