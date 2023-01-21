local files = { female = {}, male = {}}
local jsonFiles = { female = {}, male = {}}

Citizen.CreateThread(function()
	files.female[2] = LoadResourceFile(GetCurrentResourceName(), 'names/female_hair.json')
	files.female[3] = LoadResourceFile(GetCurrentResourceName(), 'names/female_torsos.json')
	files.female[4] = LoadResourceFile(GetCurrentResourceName(), 'names/female_legs.json')
	files.female[6] = LoadResourceFile(GetCurrentResourceName(), 'names/female_shoes.json')
	files.female[7] = LoadResourceFile(GetCurrentResourceName(), 'names/female_accessories.json')
	files.female[8] = LoadResourceFile(GetCurrentResourceName(), 'names/female_undershirts.json')
	files.female[11] = LoadResourceFile(GetCurrentResourceName(), 'names/female_tops.json')
	files.female[12] = LoadResourceFile(GetCurrentResourceName(), 'names/props_female_hats.json')
	files.female[13] = LoadResourceFile(GetCurrentResourceName(), 'names/props_female_glasses.json')
	files.female[14] = LoadResourceFile(GetCurrentResourceName(), 'names/props_female_ears.json')
	files.female[15] = LoadResourceFile(GetCurrentResourceName(), 'names/props_female_watches.json')
	files.female[16] = LoadResourceFile(GetCurrentResourceName(), 'names/props_female_bracelets.json')

	files.male[2] = LoadResourceFile(GetCurrentResourceName(), 'names/male_hair.json')
	files.male[3] = LoadResourceFile(GetCurrentResourceName(), 'names/male_torsos.json')
	files.male[4] = LoadResourceFile(GetCurrentResourceName(), 'names/male_legs.json')
	files.male[6] = LoadResourceFile(GetCurrentResourceName(), 'names/male_shoes.json')
	files.male[7] = LoadResourceFile(GetCurrentResourceName(), 'names/male_accessories.json')
	files.male[8] = LoadResourceFile(GetCurrentResourceName(), 'names/male_undershirts.json')
	files.male[11] = LoadResourceFile(GetCurrentResourceName(), 'names/male_tops.json')
	files.male[12] = LoadResourceFile(GetCurrentResourceName(), 'names/props_male_hats.json')
	files.male[13] = LoadResourceFile(GetCurrentResourceName(), 'names/props_male_glasses.json')
	files.male[14] = LoadResourceFile(GetCurrentResourceName(), 'names/props_male_ears.json')
	files.male[15] = LoadResourceFile(GetCurrentResourceName(), 'names/props_male_watches.json')
	files.male[16] = LoadResourceFile(GetCurrentResourceName(), 'names/props_male_bracelets.json')

	--files.masks = LoadResourceFile(GetCurrentResourceName(), 'names/masks.json')
	for type, typeList in pairs(files) do
		for i,readedFile in pairs(files[type]) do
			jsonFiles[type][i] = json.decode(readedFile)
		end
	end
end)

RegisterCommand('skinnames', function(source, args, rawCommand)
	for EL1, varList in pairs(jsonFiles.female[12]) do
		Citizen.Wait(0)
		for var, data in pairs(varList) do
			print('imask_' .. EL1 .. '_' .. var .. ' : ' .. GetLabelText(data.GXT))
		end
	end
end, false)
