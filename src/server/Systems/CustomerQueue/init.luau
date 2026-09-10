--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local Utilities = ReplicatedStorage.Shared.Utilities
local TimeUtil = require(Utilities.TimeUtil)

local TimeManager = TimeUtil.TimeManager

local spawnNPC = require("@self/spawnNPC")

type World = jecs.World
type TimeInterval = TimeUtil.TimeInterval
type TimeManager = TimeUtil.TimeManager

const SPAWN_DELAY = 5 -- in seconds

local timeManager = TimeManager.new(true) :: TimeManager

local function CustomerQueue(world, components)
    for entityId, _workshop, owner in world:query(components.Workshop, components.Owner) do
        if not timeManager:search(owner.Name) then
            timeManager:createInterval(owner.Name)
        end

        if timeManager:search(owner.Name):timePassed(SPAWN_DELAY) then
            timeManager:deleteInterval(owner.Name)
            print("[CustomerQueue]: Spawning NPC for " .. owner.Name)
            spawnNPC(entityId)
        end
    end
end

return CustomerQueue