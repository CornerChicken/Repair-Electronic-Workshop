--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local PlanckRunService = require(Packages.PlanckRunService)

local deviceData = require(ReplicatedStorage.Shared.Data.DeviceData)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local componentsTypes = require(ReplicatedStorage.Shared.Components.ComponentsTypes)

local Phases = PlanckRunService.Phases

type ComponentsListType = components.ComponentsListType
type BrokenElectronic = componentsTypes.BrokenElectronic

type World = jecs.World

local deviceNames = {}
   
for deviceName in deviceData do
    table.insert(deviceNames, deviceName)
end

local function generateNpcData(world: World)
    for npcId in world:query(components.Npc):without(components.BrokenElectronic) do
        world:set(npcId, components.BrokenElectronic)

        local randomPart = math.random(#deviceNames)
        local brokenElectronic = deviceNames[randomPart]

        local deviceConfig = deviceData[brokenElectronic]

        local randomComponent = math.random(#deviceConfig.ElectronicComponents)
        local brokenElectronicComponent = deviceConfig.ElectronicComponents[randomComponent]

        local updateElectronic = {
            electronicType = brokenElectronic,
            brokenParts = {brokenElectronicComponent}
        } :: BrokenElectronic

        world:set(npcId, components.BrokenElectronic, updateElectronic)
    end
end

return {
    system = generateNpcData,
    phase = Phases.PostUpdate
}
