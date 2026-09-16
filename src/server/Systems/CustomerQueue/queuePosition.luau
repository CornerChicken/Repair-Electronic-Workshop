--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Jecs = require(Packages.jecs)
local QueueUtil = require(ReplicatedStorage.Shared.Utilities.QueueUtil)
local PlanckRunService = require(Packages.PlanckRunService)

local ChildOf = Jecs.ChildOf
local Phase = PlanckRunService.Phases

local OFFSET = -4

type World = Jecs.World
type Queue = QueueUtil.Queue

local function queuePosition(world: World)
    world:added(components.InQueue, function(entity, id)
        local workshopId = world:target(entity, ChildOf) :: Jecs.Id
        local workshopInstance = world:get(workshopId, components.Instance) :: Instance
        local queuePart = workshopInstance:FindFirstChild("RegisterQueue") :: Part
        local queuePartPos = queuePart.Position

        local entityInstance = world:get(entity, components.Instance) :: Instance
        local entityHumanoid = entityInstance:FindFirstChild("Humanoid") :: Humanoid

        local npcQueue = world:get(workshopId, components.NpcQueue) :: Queue
        local queueIndex = QueueUtil.size(npcQueue) - 1

        if queueIndex == 0 then
            entityHumanoid:MoveTo(queuePartPos)
        elseif queueIndex == 1 then
            entityHumanoid:MoveTo(queuePartPos + Vector3.new(0, 0, OFFSET))
        elseif queueIndex == 2 then
            entityHumanoid:MoveTo(queuePartPos + Vector3.new(0, 0, OFFSET * 2))
        end
    end)

    world:removed(components.InQueue, function(entity, id)
        local workshopId = world:target(entity, ChildOf) :: Jecs.Id
        if not workshopId then
            return
        end

        local workshopInstance = world:get(workshopId, components.Instance) :: Instance
        if not workshopInstance then
            return
        end

        local npcQueue = world:get(workshopId, components.NpcQueue) :: Queue
        if not npcQueue then
            return
        end

        local queuePart = workshopInstance:FindFirstChild("RegisterQueue") :: Part
        if not queuePart then
            return
        end
        local queuePartPos = queuePart.Position

        for i = npcQueue.head, npcQueue.tail - 1 do
            local npc = npcQueue.queue[i]
            if npc then
                local entityInstance = world:get(npc, components.Instance) :: Instance
                local entityHumanoid = entityInstance and entityInstance:FindFirstChild("Humanoid") :: Humanoid

                if entityHumanoid then
                    local slot = i - npcQueue.head
                    entityHumanoid:MoveTo(queuePartPos + Vector3.new(0, 0, slot * OFFSET))
                end
            end
        end
    end)
end

return {
    system = queuePosition,
    phase = Phase.PostUpdate,
}