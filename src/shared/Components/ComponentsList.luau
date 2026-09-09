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

export type ComponentsListType = {
    -- Components
    Cash: Jecs.Entity<number>,
    Multiplier: Jecs.Entity<number>,
    Duration: Jecs.Entity<number>,
    Chance: Jecs.Entity<number>,
    Item: Jecs.Entity<Item>,
    GameState: Jecs.Entity<GameState>,
    WealthStatus: Jecs.Entity<WealthStatus>,
    BrokenElectronic: Jecs.Entity<BrokenElectronic>,
    Owner: Jecs.Entity<Player>,

    -- Tags (components with no data use nil)
    ElectronicPart: Jecs.Entity<nil>,
    Screwdriver: Jecs.Entity<nil>,
    Cable: Jecs.Entity<nil>,
    Cloth: Jecs.Entity<nil>,
    Tools: Jecs.Entity<nil>,
    Workshop: Jecs.Entity<nil>,
}

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
    } :: ComponentsListType

    return list
end

return ComponentsList
