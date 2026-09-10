--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)

local world = require("../Core/world")

local ComponentsTypes = require("./ComponentsTypes")

type World = Jecs.World
type Item = ComponentsTypes.Item
type GameState = ComponentsTypes.GameState
type WealthStatus = ComponentsTypes.WealthStatus
type BrokenElectronic = ComponentsTypes.BrokenElectronic

export type ComponentsListType = {
    -- Components
    BrokenElectronic: Jecs.Entity<BrokenElectronic>,
    Cash: Jecs.Entity<number>,
    Chance: Jecs.Entity<number>,
    Duration: Jecs.Entity<number>,
    GameState: Jecs.Entity<GameState>,
    Instance: Jecs.Entity<Instance>,
    Item: Jecs.Entity<Item>,
    Multiplier: Jecs.Entity<number>,
    Owner: Jecs.Entity<Player>,
    WealthStatus: Jecs.Entity<WealthStatus>,

    -- Tags (components with no data use nil)
    Cable: Jecs.Entity<nil>,
    Cloth: Jecs.Entity<nil>,
    ElectronicPart: Jecs.Entity<nil>,
    Screwdriver: Jecs.Entity<nil>,
    Tools: Jecs.Entity<nil>,
    Workshop: Jecs.Entity<nil>,
}

local ComponentsList = { 
        -- Components
        BrokenElectronic = world:component() :: Jecs.Id<BrokenElectronic>,
        Cash = world:component() :: Jecs.Id<number>,
        Chance = world:component() :: Jecs.Id<number>,
        Duration = world:component() :: Jecs.Id<number>,
        GameState = world:component() :: Jecs.Id<GameState>,
        Instance = world:component() :: Jecs.Id<Instance>,
        Item = world:component() :: Jecs.Id<Item>,
        Multiplier = world:component() :: Jecs.Id<number>,
        Owner = world:component() :: Jecs.Id<Player>,
        WealthStatus = world:component() :: Jecs.Id<WealthStatus>,

        -- Tags
        ElectronicPart = Jecs.tag(),
        Cable = Jecs.tag(),
        Cloth = Jecs.tag(),
        Screwdriver = Jecs.tag(),
        Tools = Jecs.tag(),
        Workshop = Jecs.tag()
    } :: ComponentsListType

return table.freeze(ComponentsList)