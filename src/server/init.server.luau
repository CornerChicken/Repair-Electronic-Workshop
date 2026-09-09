--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local SystemsRegistry = require(ReplicatedStorage.Shared.Core.SystemsRegistry)
local ComponentsLoader = require(ReplicatedStorage.Shared.Core.ComponentsLoader)

local ComponentsList = require(ReplicatedStorage.Shared.Components.ComponentsList)

type World = jecs.World

local world: World = jecs.world()

do
    local components = ComponentsList(world)
    ComponentsLoader(world, components)

    RunService.Heartbeat:connect(function()
        for _, system in pairs(SystemsRegistry["server" :: "server"]) do
            system(world, components)
        end
    end)
end