--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local QueueUtil = require(ReplicatedStorage.Shared.Utilities.QueueUtil)

local ChildOf = Jecs.ChildOf
local pairs = Jecs.pair

type World = Jecs.World
type ComponentsListType = components.ComponentsListType
type Queue = QueueUtil.Queue


local function queueNPC(world: World)
    for npc in world:query(components.Npc, pairs(ChildOf, Jecs.Wildcard)):without(components.InQueue) do
        local workshopId = world:target(npc, ChildOf) :: Jecs.Id
        local npcQueue = world:get(workshopId, components.NpcQueue) :: Queue
        QueueUtil.enqueue(npcQueue, npc)
        world:add(npc, components.InQueue)
        print("Enqueued", npc, "queue now:", npcQueue.queue, "head:", npcQueue.head, "tail:", npcQueue.tail)
    end
end

return queueNPC