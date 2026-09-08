--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Jecs = require(ReplicatedStorage.Packages.jecs)
local SystemsRegistry = require(ReplicatedStorage.Shared.Core.SystemsRegistry)

type World = Jecs.World

local world: World = Jecs.world()

RunService.Heartbeat:connect(function()
    for _, system in pairs(SystemsRegistry) do
        system(world)
    end
end)