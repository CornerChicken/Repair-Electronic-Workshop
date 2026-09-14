--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local PlancksRunService = require(Packages.PlanckRunService)

local Utilities = ReplicatedStorage.Shared.Utilities
local TimeUtil = require(Utilities.TimeUtil)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local TimeManager = TimeUtil.TimeManager

local spawnNPC = require("@self/spawnNPC")
local ChildOf = jecs.ChildOf
local pair = jecs.pair
local Phases = PlancksRunService.Phases

type World = jecs.World
type TimeInterval = TimeUtil.TimeInterval
type TimeManager = TimeUtil.TimeManager

const SPAWN_DELAY = 5 -- in seconds

local timeManager = TimeManager.new(true) :: TimeManager

local function CustomerQueue(world)
    -- Queries all workshops with owners
    for entityId, _workshop, owner in world:query(components.Workshop, components.Owner) do
        if not timeManager:search(owner.Name) then
            timeManager:createInterval(owner.Name)
        end
    
        -- Queries all spawn points not paired with workshops
        for spawnPointId in world:query(components.NPCSpawn):without(pair(ChildOf, entityId)) do
            local instance = world:get(spawnPointId, components.Instance)
            print(instance, "Check 1")
            if instance:IsDescendantOf(world:get(entityId, components.Instance)) then
                print("Check 2")
                world:add(spawnPointId, pair(ChildOf, entityId))
            end
        end

        if timeManager:search(owner.Name):timePassed(SPAWN_DELAY) then
            timeManager:deleteInterval(owner.Name)
            print("[CustomerQueue]: Spawning NPC for " .. owner.Name)
            spawnNPC(entityId, components)
        end
    end
end

return {
    system = CustomerQueue,
    phase = Phases.Update
}