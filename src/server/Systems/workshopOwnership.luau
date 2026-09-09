local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage.Packages
local ComponentsFolder = ReplicatedStorage.Shared.Components

local Jecs = require(Packages.jecs)
local ComponentsList = require(ComponentsFolder.ComponentsList)
local ComponentsTags = require(ComponentsFolder.ComponentsTags)

type World = Jecs.World

local function WorkshopOwnership(world: World, components)
    for _, player in ipairs(Players:GetPlayers()) do
        for entityId in world:query(components.Workshop)
            :without(components.Owner)
        do
            world:set(entityId, components.Owner, player)
            break
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        for entityId in world:query(components.Workshop)
            :without(components.Owner) 
        do
            world:set(entityId, components.Owner, player)
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

return WorkshopOwnership