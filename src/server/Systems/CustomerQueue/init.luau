--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local spawnNPC = require("@self/spawnNPC")

type World = jecs.World

local isInitialized = false

local function init(world, components)
    isInitialized = true
    for entityId in world:query(components.Workshop, components.Owner) do
        spawnNPC(world :: World, components, entityId)
    end
end

local function CustomerQueue(world, components)
    if not isInitialized then
        init(world, components)
    end
    
    init(world, components)
end

return CustomerQueue