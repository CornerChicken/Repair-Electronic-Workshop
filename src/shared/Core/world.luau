local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

-- Preregister Components
do
    for name, component in pairs(components) do
        jecs.meta(component, jecs.Name, name)
    end
end

local world = jecs.world() :: jecs.World

return world