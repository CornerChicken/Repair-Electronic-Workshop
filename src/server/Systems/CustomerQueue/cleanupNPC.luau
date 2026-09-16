--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local Planck = require(Packages.Planck)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Jecs = require(Packages.jecs)
local QueueUtil = require(ReplicatedStorage.Shared.Utilities.QueueUtil)

local Phase = Planck.Phase
local ChildOf = Jecs.ChildOf

type World = Jecs.World
type Queue = QueueUtil.Queue

local function cleanupNpc(world: World)
    world:removed(components.Npc, function(entity, id, delete)
        if not world:contains(entity) then
            return
        end
        
        local workshopId = world:target(entity, ChildOf) :: Jecs.Id
        if not workshopId then 
            return
        end

        local npcQueue = world:get(workshopId, components.NpcQueue) :: Queue
        if not npcQueue then
            return
        end

        local instance = world:get(entity, components.Instance) :: Instance
        
        QueueUtil.removeValue(npcQueue, entity)

        if instance then
            instance:Destroy()
        end

        if not delete then
            world:delete(entity)
        end
    end)
end

return {
    system = cleanupNpc,
    phase = Phase.Startup
}