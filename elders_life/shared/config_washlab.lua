ConfigWashlab = {}

ConfigWashlab.WaitingTime = 5000
ConfigWashlab.TakePercentage = true
ConfigWashlab.WashPercentage = 0.83
ConfigWashlab.ProducingTime = math.random(300, 600) -- IN SECONDS, NOT MS (!)
ConfigWashlab.CountingTime = math.random(120, 180) -- IN SECONDS, NOT MS (!)
ConfigWashlab.OpenHourWash = 18 -- From what hour should the pawnshop be open?
ConfigWashlab.CloseHourWash = 00 -- From what hour should the pawnshop be closed?

ConfigWashlab.Locations = {
    washinglab = {

        process = {
            start = vector3(-1105.513, -2243.145, 13.98),
            timer = vector3(-1107.882, -2240.858, 13.9822),
            output = vector3(-1110.527, -2237.953, 13.855),
            cutter = vector3(-1112.577, -2234.948, 12.518),
            counter = vector3(-1115.442, -2229.464, 12.51)
        }
    }
}
