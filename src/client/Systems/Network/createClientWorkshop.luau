--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Replicator = require("../../Core/replicator")
local Phase = Planck.Phase

type World = Jecs.World

local function createClientWorkshop(world: World)
    task.spawn(function()
        world:added(components.Owner, function(entity, id, value)
            Replicator:after_replication(function()
                if world:has(entity, components.Workshop) then
                    if value == Players.LocalPlayer then
                        world:add(entity, components.Client)
                    end
                end
            end)
        end)
    end)
end

return {
    system = createClientWorkshop,
    phase = Phase.PreStartup,
}

