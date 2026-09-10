--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local ComponentsList = require(ReplicatedStorage.Shared.Components.ComponentsList)

type World = jecs.World
type ComponentsListType = ComponentsList.ComponentsListType

local isInitialized = false

local function init(world: World, components: ComponentsListType)
    print("[WorkshopOwnership]: Initializing")
    isInitialized = true

    for _, player in ipairs(Players:GetPlayers()) do
        for entityId in world:query(components.Workshop)
            :without(components.Owner)
        do
            print("[WorkshopOwnership]: Assigned workshop to new owner " .. player.Name)
            world:set(entityId, components.Owner, player)
            break
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        for entityId in world:query(components.Workshop)
            :without(components.Owner) 
        do
            print("[WorkshopOwnership]: Assigned workshop to new owner " .. player.Name)
            world:set(entityId, components.Owner, player)
            break
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        for entityId, _, ownerId in world:query(components.Workshop, components.Owner) do
            if ownerId == player then
                world:remove(entityId, components.Owner)
            end
        end
    end)
end

local function WorkshopOwnership(world, components)
    if not isInitialized then
        init(world, components)
    end
end

return WorkshopOwnership
