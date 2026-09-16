local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

export type StateName = "Idle" | "Repairing" | "Shopping"
type World = Jecs.World

type StateDef = {
    onEnter: (
        world: World,
        player: Jecs.Entity<Player>,
        data: any?
    ) -> (),
    onExit: (
        world: World,
        player: Jecs.Entity<Player>
    ) -> (),
    allowedFrom: { StateName }
}

local States: { [StateName]: StateDef} = {
    Idle = {
        onEnter = function(world, player) end,
        onExit = function(world, player) end,
        allowedFrom = {"Repairing", "Shopping"}
    },
    Repairing = {
        onEnter = function(world, player, workbenchId)
            world:set(player, components.Workbench, workbenchId)
        end,
        onExit = function(world, player)
            world:remove(player, components.Workbench)
        end,
        allowedFrom = {"Idle"}
    },
    Shopping = {
        onEnter = function(world, player, computerId)
            world:set(player, components.ShoppingComputer, computerId)
        end,
        onExit = function(world, player)
            world:remove(player, components.ShoppingComputer)
        end,
        allowedFrom = {"Idle"}
    }
}

return States