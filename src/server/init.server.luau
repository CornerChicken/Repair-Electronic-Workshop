--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local jabby = require(Packages.jabby)

local Core = ReplicatedStorage.Shared.Core
local SystemsRegistry = require(Core.SystemsRegistry)
local ComponentsLoader = require(Core.ComponentsLoader)
local world = require(Core.world)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

type World = jecs.World

do
    for name, component in pairs(components) do
		world:set(component, jecs.Name, name)
	end

    jabby.set_check_function(function()
		return true
	end)


    ComponentsLoader(world, components) 

    jabby.register({
        applet = jabby.applets.world,
        name = "world",
        configuration = {
            world = world :: any-- put your ecs world here
        }
    })

    RunService.Heartbeat:connect(function()
        for _, system in pairs(SystemsRegistry["server" :: "server"]) do
            system(world, components)
        end
    end)
end