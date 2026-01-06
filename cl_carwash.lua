QBCore = exports['qb-core']:GetCoreObject()
local washingVehicle = false

-- Function to wash vehicle
local function washCar()
    local ped = PlayerPedId()
    local veh = nil

    -- Try to get the vehicle player is in
    if IsPedInAnyVehicle(ped, false) then
        veh = GetVehiclePedIsIn(ped, false)
    else
        -- If not in a vehicle, find the nearest one in front of the player
        local pos = GetEntityCoords(ped)
        veh = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70) -- 5m radius, any type
    end

    if not veh or veh == 0 then
        QBCore.Functions.Notify('No vehicle nearby to wash!', 'error')
        return
    end

    local success = lib.callback.await("zerx_carwash:server:canAfford", false)
    if not success then return end

    washingVehicle = true

    QBCore.Functions.Progressbar("wash_car", "Washing vehicle..", Config.WashTime, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        SetVehicleDirtLevel(veh, 0.0)
        WashDecalsFromVehicle(veh, 1.0)
        washingVehicle = false
        QBCore.Functions.Notify('Your car is now clean!', 'success')
    end)
end

-- Car wash location
local carWashLoc = vec3(29.34, -1394.04, 29.58)

-- Add interact zone
exports.interact:AddInteraction({
    coords = carWashLoc,
    radius = 5.0, -- Bigger radius so you see it approaching
    options = {
        {
            label = "Wash Vehicle",
            icon = "fa-solid fa-car",
            canInteract = function()
                local ped = PlayerPedId()
                -- Check if a vehicle is nearby (in or out)
                local veh = IsPedInAnyVehicle(ped, false) and GetVehiclePedIsIn(ped, false) or GetClosestVehicle(GetEntityCoords(ped), 5.0, 0, 70)
                return veh ~= 0 and not washingVehicle
            end,
            action = function()
                washCar()
            end
        }
    },
    debug = true
})

-- Add map blip
local washBlip = AddBlipForCoord(carWashLoc.x, carWashLoc.y, carWashLoc.z)
SetBlipSprite(washBlip, 100)
SetBlipDisplay(washBlip, 4)
SetBlipScale(washBlip, 0.75)
SetBlipAsShortRange(washBlip, true)
SetBlipColour(washBlip, 37)
BeginTextCommandSetBlipName("STRING")
AddTextComponentSubstringPlayerName("Strawberry Car Wash")
EndTextCommandSetBlipName(washBlip)
