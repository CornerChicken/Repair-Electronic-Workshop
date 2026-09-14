local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local replecs = require(Packages.replecs)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local REPLICATED_COMPONENTS = require(ReplicatedStorage.Shared.Components.ReplicatedComponents)

-- Preregister 'replecs' components (reasoning is described in replecs documentation)
require(Packages.replecs)

-- Preregister Components
do
    for name, component in components do
        jecs.meta(component, jecs.Name, name)
    end
end

local world = jecs.world() :: jecs.World

-- Attach shared component tag (signals to network that component should be replicated to client)
do
    for _, name in REPLICATED_COMPONENTS do
        assert(components[name], `Cannot replicate component ({name}) because it doesn't exist`)
        world:add(world:add(components[name], replecs.shared))
    end
end

return world