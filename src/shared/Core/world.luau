local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)


local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local REPLICATED_COMPONENTS = require(ReplicatedStorage.Shared.Components.ReplicatedComponents)

-- Preregister 'replecs' components (reasoning is described in replecs documentation)
local replecs = require(Packages.replecs)
-- Preregister Components
do
    for name, component in components do
        jecs.meta(component, jecs.Name, name)
    end
end

local world = jecs.world() :: jecs.World

-- Attach shared component tag (signals to network that component should be replicated to client)
do
    for _, component in components do
        world:add(component, replecs.shared)
    end
end

return world