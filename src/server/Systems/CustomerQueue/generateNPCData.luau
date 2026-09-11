local ReplicatedStorage = game:GetService("ReplicatedStorage")

local deviceData = require(ReplicatedStorage.Shared.Data.DeviceData)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local componentsTypes = require(ReplicatedStorage.Shared.Components.ComponentsTypes)

type ComponentsListType = components.ComponentsListType
type BrokenElectronic = componentsTypes.BrokenElectronic

local world = require(ReplicatedStorage.Shared.Core.world)

local deviceNames = {}
    for deviceName, _ in deviceData do
        table.insert(deviceNames, deviceName)
    end

local function generateNPCData(npcId: number, component: ComponentsListType)
    world:set(npcId, component.BrokenElectronic)

    local randomPart = math.random(#deviceNames)
    local brokenElectronic = deviceNames[randomPart]

    local deviceConfig = deviceData[brokenElectronic]

    local randomComponent = math.random(#deviceConfig.ElectronicComponents)
    local brokenElectronicComponent = deviceConfig.ElectronicComponents[randomComponent]

    local updateElectronic: BrokenElectronic = {
        electronicType = brokenElectronic,
        brokenParts = {brokenElectronicComponent}
    }

    world:set(npcId, component.BrokenElectronic, updateElectronic)
end

return generateNPCData