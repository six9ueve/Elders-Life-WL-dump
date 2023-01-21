AddEventHandler('god:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end