Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('god:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while not ESX.IsPlayerLoaded() do 
        Citizen.Wait(500)
    end

    if ESX.IsPlayerLoaded() then
        Citizen.CreateThread(function()
            -- Parked vehicles.
              local vehicles = {
                --PDW
                {Model= "nero", X= -36.35, Y= -1092.87, Z= 26.3, A= 111.75},
                {Model= "reaper", X= -49.71, Y= -1083.5, Z= 26.3, A= 151.18},
                {Model= "banshee2", X= -42.11, Y= -1101.09, Z= 26.3, A= 290.12},
                {Model= "zentorno", X= -47.56, Y= -1092.12, Z= 26.0, A= 186.34},
                {Model= "infernus2", X= -55.04, Y= -1096.98, Z= 26.3, A= 301.1},

                --MOTO
                {Model= "hdfb", X= 1229.46, Y= 2732.21, Z= 36.97, A= 184.72},                         
                {Model= "gsxr", X= 1220.12, Y= 2730.81, Z= 36.98, A= 216.54}, 

                --LUXURY
                {Model= "nero2", X= 127.00, Y= -156.4422, Z= 53.78, A= 323.694},
                {Model= "komoda", X= 134.088, Y= -160.4047, Z= 53.78, A= 322.92},
                {Model= "buffalo2", X= 141.86, Y= -163.6259, Z= 53.78, A= 358.032},
                {Model= "superd", X= 118.74, Y= -153.90, Z= 59.76, A= 121.14},
                {Model= "xls", X= 114.5689, Y= -146.5313, Z= 59.76, A= 98.79},                
              }

             -- Spawn the secret cars
             for _, item in pairs(vehicles) do
               RequestModel(GetHashKey(item.Model));
               while not HasModelLoaded(GetHashKey(item.Model)) do
                 RequestModel(GetHashKey(item.Model));
                 Wait(1);
              end

              vehicle = CreateVehicle(GetHashKey(item.Model), item.X, item.Y, item.Z, item.A, false, false)
              SetModelAsNoLongerNeeded(vehicle)
              SetVehicleOnGroundProperly(vehicle)
              SetVehRadioStation(vehicle, 'OFF')-----------------
              FreezeEntityPosition(vehicle, true)
              SetVehicleDoorsLocked(vehicle, 2)
             end
        end)



    end
end)