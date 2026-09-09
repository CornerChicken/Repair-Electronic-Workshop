--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local ComponentsTypes = require(script.Parent.ComponentsTypes)

type World = Jecs.World
type Item = ComponentsTypes.Item
type GameState = ComponentsTypes.GameState
type WealthStatus = ComponentsTypes.WealthStatus
type BrokenElectronic = ComponentsTypes.BrokenElectronic

local function ComponentsList(world: World)
    local list = { 
        -- Components
        Cash = world:component() :: Jecs.Id<number>,
        Multiplier = world:component() :: Jecs.Id<number>,
        Duration = world:component() :: Jecs.Id<number>,
        Chance = world:component() :: Jecs.Id<number>,
        Item = world:component() :: Jecs.Id<Item>,
        GameState = world:component() :: Jecs.Id<GameState>,
        WealthStatus = world:component() :: Jecs.Id<WealthStatus>,
        BrokenElectronic = world:component() :: Jecs.Id<BrokenElectronic>,
        Owner = world:component() :: Jecs.Id<Player>,

        -- Tags
        ElectronicPart = Jecs.tag(),
        Screwdriver = Jecs.tag(),
        Cable = Jecs.tag(),
        Cloth = Jecs.tag(),
        Tools = Jecs.tag(),
        Workshop = Jecs.tag()
    }

    return list
end

return ComponentsList
