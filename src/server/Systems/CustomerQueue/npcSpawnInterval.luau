--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local PlancksRunService = require(Packages.PlanckRunService)

local Utilities = ReplicatedStorage.Shared.Utilities
local TimeUtil = require(Utilities.TimeUtil)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local TimeManager = TimeUtil.TimeManager

local ChildOf = jecs.ChildOf
local pair = jecs.pair
local Phases = PlancksRunService.Phases

type World = jecs.World
type TimeInterval = TimeUtil.TimeInterval
type TimeManager = TimeUtil.TimeManager

const SPAWN_DELAY = 5 -- in seconds

local timeManager = TimeManager.new(true) :: TimeManager

local function npcSpawnInterval(world)
    -- Queries all workshops with owners
    for workshopId, owner in world:query(components.Owner, components.Workshop) do
        if not timeManager:search(owner.Name) then
            timeManager:createInterval(owner.Name)
        end
    

        if timeManager:search(owner.Name):timePassed(SPAWN_DELAY) then
            timeManager:deleteInterval(owner.Name)
            print("[CustomerQueue]: Spawning NPC for " .. owner.Name)
            
            for spawnPointId in world:query(components.NPCSpawn):with(pair(ChildOf, workshopId)) do
                world:add(spawnPointId, components.Spawn)
            end
        end
    end
end

return {
    system = npcSpawnInterval,
    phase = Phases.PreUpdate
}