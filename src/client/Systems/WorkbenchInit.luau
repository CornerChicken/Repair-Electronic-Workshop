--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local world = Jecs.world()

type World = Jecs.World

local function WorkbenchInit()
    world:changed(components.Owner, function(entity, id, value)
        
    end)
end

return WorkbenchInit