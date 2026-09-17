--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)
local replecs = require(Packages.replecs)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local QueueUtil = require(ReplicatedStorage.Shared.Utilities.QueueUtil)

local Phase = Planck.Phase

type World = jecs.World
type ComponentsListType = components.ComponentsListType

local function WorkshopOwnership(world: World)
    print("[WorkshopOwnership]: Initializing")
    for _, player in ipairs(Players:GetPlayers()) do
        for entityId in world:query(components.Workshop)
            :without(components.Owner)
        do
            print("[WorkshopOwnership]: Assigned workshop to new owner " .. player.Name)
            world:set(entityId, components.Owner, player)
            world:set(entityId, jecs.Name, "WorkshopEntity")
            world:set(entityId, components.NpcQueue, QueueUtil.createQueue({}))
            break
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        for entityId in world:query(components.Workshop)
            :without(components.Owner) 
        do
            print("[WorkshopOwnership]: Assigned workshop to new owner " .. player.Name)
            world:set(entityId, components.Owner, player)
            world:set(entityId, jecs.Name, "WorkshopEntity")
            world:set(entityId, components.NpcQueue, QueueUtil.createQueue({}))

            world:add(entityId, replecs.Networked)
            world:add(entityId, jecs.pair(replecs.reliable, components.Instance))
            world:add(entityId, jecs.pair(replecs.reliable, components.Owner))
            world:add(entityId, jecs.pair(replecs.reliable, components.Workshop))
            break
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        for entityId, _, ownerId in world:query(components.Workshop, components.Owner) do
            if ownerId == player then
                world:remove(entityId, components.Owner)
            end
            world:remove(entityId, components.NpcQueue)
        end
    end)
end

return {
    system = WorkshopOwnership,
    phase = Phase.Startup,
}
