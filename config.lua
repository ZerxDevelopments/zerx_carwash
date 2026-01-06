QBCore = exports['qb-core']:GetCoreObject()

Config = {}

Config.WashTime = 10000 -- Duration in ms
Config.Cost = 50        -- Price to wash car

-- Car wash locations
Config.CarWashLocs = {
    {
        Blip = vec3(26.41, -1392.05, 29.36),
        Label = "Strawberry Car Wash",
    },
    {
        Blip = vec3(173.79, -1736.7, 29.29),
        Label = "Davis Car Wash",
    },
    {
        Blip = vec3(-74.21, 6427.75, 31.44),
        Label = "Paleto Car Wash",
    },
    {
        Blip = vec3(1362.69, 3591.81, 34.5),
        Label = "Sandy Car Wash",
    },
    {
        Blip = vec3(-699.84, -932.68, 18.59),
        Label = "Little Seoul Car Wash",
    },
}
