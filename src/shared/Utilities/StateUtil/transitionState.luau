--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local States = require("./allowedTransitions")
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

type World = Jecs.World
type StateName = States.StateName

local function transitionTo(world: World, player: Jecs.Entity<Player>, newState: StateName, data: any?)
    local currentState = (world:get(player, components.PlayerState) or "Idle") :: any

    local def = States[newState]
    if not table.find(def.allowedFrom, currentState) then
        warn("Invalid transition from:", currentState, "to", newState)
        return
    end

    States[currentState].onExit(world, player)
    world:set(player, components.PlayerState, newState)
    def.onEnter(world, player, data)
end

return transitionTo