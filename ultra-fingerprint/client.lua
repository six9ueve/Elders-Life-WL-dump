local drawSprite = DrawSprite

local isFPGameEnabled = false

local callbackFn

local taskTime = 0 --in seconds
local time
local isTextureLoaded = false

local totalFPTask = 1
local activeFPTask = 1

local componentGeneratedPattern
local tempComponentPattern = {}

local activeComponentSelection = 1
local activeSubComponentSelection = {}

local isProcessing = false
local playerWon = false
local resultDecided = false

local countDownUITimer

local texDicts = {
	'mpfclone_retro',
	'mpfclone_retro_background',
	'mpfclone_retro_correct',
	'mpfclone_retro_life',
	'mpfclone_retro_loading',
	'mpfclone_retro_messages',
	'mpfclone_retro_numbers',
	'mpfclone_retro_printfull1',
	'mpfclone_retro_printfull2',
	'mpfclone_retro_printfull3',
	'mpfclone_retro_printfull4',
	'mpfclone_retro_printfull5',
	'mpfclone_retro_printfull6',
	'mpfclone_retro_printfull7',
	'mpfclone_retro_printfull8',
	'mpfclone_retro_scrambler'
}


local countDownUI = {
	0.205,
	0.211,
	0.217,
	0.223,
	0.229,
	0.235,
	0.241,
	0.247,
	0.2535,
	0.2595,
	0.265,
	0.271,
	0.277,
	0.283,
	0.289,
	0.295,
	0.301,
	0.307,
	0.313,
	0.3193,
	0.325,
	0.331,
	0.337,
	0.343,
	0.349,
	0.355,
	0.361,
	0.367,
	0.373,
	0.3786,
	0.385,
	0.391,
	0.3975,
	0.4035,
	0.409,
	0.415,
	0.422,
	0.428,
	0.434,
	0.44,
	0.446
}

local decypherFPUI = {
	0.535,
	0.605,
	0.675,
	0.745
}

local componentUI = {
	0.36,
	0.43,
	0.50,
	0.57,
	0.64,
	0.71,
	0.78,
	0.85
}


CreateThread(function()
	for i=1,#texDicts do
		Wait(0)
		RequestStreamedTextureDict(texDicts[i], true)
		while not HasStreamedTextureDictLoaded(texDicts[i]) do
			Wait(0)
		end
	end
	hasTextureLoaded = true
end)


function unloadAssets()
	for i=1,#texDicts do
		Wait(0)
		SetStreamedTextureDictAsNoLongerNeeded(texDicts[i])
	end
end


function secondsToString(seconds)
	local seconds = tonumber(seconds)
	local hours = string.format("%02.f", math.floor(seconds/3600));
	local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
	local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));

	local time={}
	mins:gsub(".",function(c) table.insert(time,c) end)
	secs:gsub(".",function(c) table.insert(time,c) end)
	return time
end


function shuffle(t)
	local tbl = {}
	for i = 1, #t do
		Wait(0)
		tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
		Wait(0)
		math.randomseed(GetGameTimer()*GetFrameTime())
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	if table.concat(t) == table.concat(tbl) then
		tbl = shuffle(t)
	end
	return tbl
end


function randNum(n, a, b)
	local numbers = {}
	for i = a, b do
		Wait(0)
		numbers[i] = i
	end

	for i = 1, #numbers - 1 do
		Wait(0)
		local j = math.random(i, #numbers)
		numbers[i], numbers[j] = numbers[j], numbers[i]
	end
	numbers = shuffle(numbers)
	return {table.unpack(numbers, 1, n)}
end

 
function generateRandomFingerprint(levels)
	local randomFPs = {}
	math.randomseed(GetGameTimer())
	randomFPs = randNum(levels, 1,8)
	return randomFPs
end


function generateRandomComponentPattern()
	local randomPattern = {}
	math.randomseed(GetGameTimer()*3.77)
	randomPattern = randNum(8,1,8)
	return randomPattern
end

function showBackgroundLayer()
	-- Setup background layer
	drawSprite('mpfclone_retro_background', 'fingerprint_hacking_minigame_background', 0.5, 0.5, 1.0, 1.0, 0.0, 25, 146, 66, 1.0)
	drawSprite('mpfclone_retro', 'pixel_overlay', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 1.0)
end


function showTimer()
	drawSprite('mpfclone_retro_numbers', 'fingerprint_hacking_minigame_numbers_0'..time[1], 0.285, 0.145, 0.016, 0.04, 0.0, 255, 255, 255, 1.0)
	drawSprite('mpfclone_retro_numbers', 'fingerprint_hacking_minigame_numbers_0'..time[2], 0.305, 0.145, 0.016, 0.04, 0.0, 255, 255, 255, 1.0)
	drawSprite('mpfclone_retro_numbers', 'fingerprint_hacking_minigame_numbers_colon', 0.325, 0.145, 0.016, 0.04, 0.0, 255, 255, 255, 1.0)
	drawSprite('mpfclone_retro_numbers', 'fingerprint_hacking_minigame_numbers_0'..time[3], 0.345, 0.145, 0.016, 0.04, 0.0, 255, 255, 255, 1.0)
	drawSprite('mpfclone_retro_numbers', 'fingerprint_hacking_minigame_numbers_0'..time[4], 0.365, 0.145, 0.016, 0.04, 0.0, 255, 255, 255, 1.0)

end


function generateComponentPattern()
	componentGeneratedPattern = generateRandomComponentPattern() 
	for i=1,8 do
		tempComponentPattern[i] = i
	end
end


function drawComponents()
	for i=1,8 do
		drawSprite('mpfclone_retro_printfull'..randomFPTasks[activeFPTask], 'fingerprint_hacking_minigame_fingerprints_0'..randomFPTasks[activeFPTask]..'_slice_0'..componentGeneratedPattern[tempComponentPattern[i]], 0.325, componentUI[i], 0.24, 0.05, 0.0, 25, 146, 66, 1.0)
	end
end


function showProcessing()
	local drawbar = 1
	isProcessing = true

	local barPos = {
		0.4,
		0.42,
		0.44,
		0.46,
		0.48,
		0.5,
		0.52,
		0.54,
		0.56,
		0.58,
		0.6
	}
	
	CreateThread(function()
		for i=1,10 do
			Wait(math.random(250,350))
			drawbar = drawbar + 1
		end
	end)

	CreateThread(function()
		SendNUIMessage({type  = 'audio', audioType = 'processing'})
		while drawbar < 11 do
			Wait(0)
			drawSprite('mpfclone_retro_loading', 'fingerprint_hacking_minigame_loading_window', 0.5, 0.5, 0.25, 0.1, 0.0, 255, 255, 255, 1.0)
			for i=1, drawbar do
				drawSprite('mpfclone_retro_loading', 'fingerprint_hacking_minigame_loading_bar_segment', barPos[i], 0.515, 0.02, 0.025, 0.0, 255, 255, 255, 1.0)
			end
		end
		isProcessing = false
	end)
end

function showErrorDialog()
	local flash = true
	local switch = true
	isProcessing = true
	CreateThread(function()
		while flash do
			Wait(0)
			if switch then
				drawSprite('mpfclone_retro_messages', 'fingerprint_hacking_minigame_messages_incorrect_00', 0.5, 0.5, 0.35, 0.15, 0.0, 255, 255, 255, 1.0)
			else
				drawSprite('mpfclone_retro_messages', 'fingerprint_hacking_minigame_messages_incorrect_01', 0.5, 0.5, 0.35, 0.15, 0.0, 255, 255, 255, 1.0)
			end
		end
	end)
	
	CreateThread(function()
		local isTimeUp = 0
		SendNUIMessage({type  = 'audio', audioType = 'dialog'})
		while flash do
			Wait(300)
			isTimeUp = isTimeUp + 300
			if switch then
				switch = false
			else
				switch = true
			end

			if isTimeUp >= 3000 then
				flash = false
				isProcessing = false
			end
		end
	end)

end

function showSuccessDialog()
	local flash = true
	local switch = true
	isProcessing = true
	CreateThread(function()
		while flash do
			Wait(0)
			if switch then
				drawSprite('mpfclone_retro_correct', 'fingerprint_hacking_minigame_messages_correct_00', 0.5, 0.5, 0.35, 0.15, 0.0, 255, 255, 255, 1.0)
			else
				drawSprite('mpfclone_retro_correct', 'fingerprint_hacking_minigame_messages_correct_01', 0.5, 0.5, 0.35, 0.15, 0.0, 255, 255, 255, 1.0)
			end
		end
	end)
	
	CreateThread(function()
		local isTimeUp = 0
		SendNUIMessage({type  = 'audio', audioType = 'dialog'})
		while flash do
			Wait(300)
			isTimeUp = isTimeUp + 300
			if switch then
				switch = false
			else
				switch = true
			end

			if isTimeUp >= 3000 then
				flash = false
				isProcessing = false
			end
		end
	end)
end


function manageKeyPress()

	DisableControlAction(0, 32, true) -- W key
	DisableControlAction(0, 34, true) -- A key
	DisableControlAction(0, 31, true) -- S key
	DisableControlAction(0, 30, true) -- D key
	DisableControlAction(0, 24, true) -- Left click
	DisableControlAction(0, 25, true) -- Right click

	if not isProcessing then
		if IsControlJustPressed(0, 172) then	-- Arrow up
			if activeComponentSelection > 1 and activeComponentSelection <= 8 then
				activeComponentSelection = activeComponentSelection - 1
				SendNUIMessage({type  = 'audio', audioType = 'verticalMove', keypress = 'up'})
			end

		elseif IsControlJustPressed(0, 173) then	-- Arrow down
			if activeComponentSelection < 8 and activeComponentSelection >= 1 then
				activeComponentSelection = activeComponentSelection + 1
				SendNUIMessage({type  = 'audio', audioType = 'verticalMove', keypress = 'down'})
			end

		elseif IsControlJustPressed(0, 174) then	-- Arrow left
			if tempComponentPattern[activeComponentSelection] > 1 then
				tempComponentPattern[activeComponentSelection] = tempComponentPattern[activeComponentSelection] - 1
				SendNUIMessage({type  = 'audio', audioType = 'horizontalMove', keypress = 'left'})
			end
			
		elseif IsControlJustPressed(0, 175) then	-- Arrow right
			if tempComponentPattern[activeComponentSelection] < 8 then
				tempComponentPattern[activeComponentSelection] = tempComponentPattern[activeComponentSelection] + 1
				SendNUIMessage({type  = 'audio', audioType = 'horizontalMove', keypress = 'right'})
			end

		elseif IsControlJustPressed(0, 194) then	-- Backspace key
			showErrorDialog()
			CreateThread(function()
				Wait(2900)
				callbackFn(0, 'Player cancelled')
				resultDecided = true
				isFPGameEnabled = false
			end)
			
		elseif IsControlJustPressed(0, 191) then	-- Enter key
			local submittedPattern = {}

			for i=1,8 do
				submittedPattern[i] = componentGeneratedPattern[tempComponentPattern[i]]
			end

			if table.concat(submittedPattern) == '12345678' then
				showProcessing()

				CreateThread(function()
					Wait(3000)
					showSuccessDialog()
					Wait(3000)

					if activeFPTask < totalFPTask then
						activeFPTask = activeFPTask + 1
						generateComponentPattern()
					elseif activeFPTask >= totalFPTask then
						SendNUIMessage({type  = 'success'})
						playerWon = true
						isFPGameEnabled = false
						resultDecided = true
						callbackFn(1, 'Hack successful')
					end
				end)
			else
				showProcessing()

				CreateThread(function()
					Wait(3000)
					showErrorDialog()
				end)
			end
		end
	end
end


function startGame()
	CreateThread(function()
		while not hasTextureLoaded do
			Wait(0)
		end

		SendNUIMessage({type  = 'intro'})
		Wait(3000)

		time = secondsToString(taskTime)

		CreateThread(function()
			while taskTime > 0 and isFPGameEnabled do
				Wait(1000)
				taskTime = taskTime - 1
				time = secondsToString(taskTime)
			end
		end)

		CreateThread(function()
			local timerWait = taskTime / countDownUITimer
			while countDownUITimer > 0 and isFPGameEnabled do
				Wait(timerWait*1000)
				countDownUITimer = countDownUITimer - 1
			end

			if not playerWon and not resultDecided then
				SendNUIMessage({type  = 'fail'})
				callbackFn(0, 'Time ran out')
			end

			if isFPGameEnabled then
				resultDecided = true
				CreateThread(function()
					showErrorDialog()
					Wait(3000)
					isFPGameEnabled = false
				end)
			end
		end)
		
		CreateThread(function()
			while countDownUITimer > 0 and isFPGameEnabled do
				Wait(0)
				for i=1, countDownUITimer do
					drawSprite('mpfclone_retro_scrambler', 'fingerprint_hacking_minigame_scrambler_dot', countDownUI[i], 0.237, 0.004, 0.012, 0.0, 25, 146, 66, 1.0)
				end
			end
		end)
		
		while isFPGameEnabled do
			Wait(0)

			-- Setup background layer
			showBackgroundLayer()
			-- Show timer
			showTimer()
			
			-- Show all fingerprint tagert levels
			for i=1,totalFPTask do
				if i == activeFPTask then
					drawSprite('mpfclone_retro_printfull'..randomFPTasks[i], 'fingerprint_hacking_minigame_fingerprints_0'..randomFPTasks[i], decypherFPUI[i], 0.183, 0.055, 0.11, 0.0, 255, 255, 255, 1.0)
					drawSprite('mpfclone_retro', 'decyphered_selector', decypherFPUI[i], 0.183, 0.06, 0.12, 0.0, 255, 255, 255, 1.0)
				else
					drawSprite('mpfclone_retro_printfull'..randomFPTasks[i], 'fingerprint_hacking_minigame_fingerprints_0'..randomFPTasks[i], decypherFPUI[i], 0.183, 0.055, 0.11, 0.0, 15, 74, 40, 1.0)
					drawSprite('mpfclone_retro', 'decyphered_selector', decypherFPUI[i], 0.183, 0.06, 0.12, 0.0, 15, 74, 40, 1.0)
				end
			end

			--Scrable background
			drawSprite('mpfclone_retro_scrambler', 'fingerprint_hacking_minigame_scrambler_background', 0.326, 0.237, 0.25, 0.02, 0.0, 15, 74, 40, 1.0)

			-- Show active fingerprint tagert at large scale
			drawSprite('mpfclone_retro_printfull'..randomFPTasks[activeFPTask], 'fingerprint_hacking_minigame_fingerprints_0'..randomFPTasks[activeFPTask], 0.635, 0.6, 0.3, 0.6, 0.0, 25, 146, 66, 1.0)
			
			drawComponents()

			drawSprite('mpfclone_retro', 'selectorframe', 0.325, componentUI[activeComponentSelection], 0.24, 0.05, 0.0, 255, 255, 255, 1.0)
			
			manageKeyPress()
		end
	end)
end


AddEventHandler("ultra-fingerprint", function(levels, time, returnFn)
	
	if levels and time and returnFn then
		callbackFn = returnFn

		if levels < 0 or levels > 4 then
			callbackFn(-1,'Invalid levels passed')
			return
		end

		if time < 10 or time > 300 then
			callbackFn(-1,'Invalid time passed')
			return
		end

		taskTime = tonumber(time)
		totalFPTask = tonumber(levels)
		activeFPTask = 1
		activeComponentSelection = 1
		isProcessing = false
		playerWon = false
		resultDecided = false

		if not isFPGameEnabled then
			isFPGameEnabled = true

			randomFPTasks = generateRandomFingerprint(totalFPTask)
			countDownUITimer = #countDownUI
			generateComponentPattern()
		
			startGame()
		else
			isFPGameEnabled = false
		end
	else
		callbackFn(-1,'Invalid parameters passed')
	end

end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		unloadAssets()
	end
end)
