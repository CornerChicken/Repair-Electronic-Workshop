--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local PlancksRunService = require(Packages.PlanckRunService)

local Utilities = ReplicatedStorage.Shared.Utilities
local TimeUtil = require(Utilities.TimeUtil)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local ChildOf = jecs.ChildOf
local pair = jecs.pair
local Phases = PlancksRunService.Phases

type World = jecs.World
type TimeInterval = TimeUtil.TimeInterval
type TimeManager = TimeUtil.TimeManager

local function loadNpcSpawns(world)
    -- Queries all workshops with owners
    for entityId in world:query(components.Owner):with(components.Workshop) do
        -- Queries all spawn points not paired with workshops
        for spawnPointId in world:query(components.NPCSpawn):without(pair(ChildOf, entityId)) do
            local instance = world:get(spawnPointId, components.Instance)
            if instance:IsDescendantOf(world:get(entityId, components.Instance)) then
                world:add(spawnPointId, pair(ChildOf, entityId))
            end
        end
    end
end

return {
    system = loadNpcSpawns,
    phase = Phases.PreUpdate
}