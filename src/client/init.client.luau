--!strict
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local jabby = require(Packages.jabby)-- your path to jabby here!

local Core = ReplicatedStorage.Shared.Core
local NetworkingClient = require("@self/Systems/NetworkingClient")
local ComponentsLoader = require(Core.ComponentsLoader)
local world = require(Core.world)

local client = jabby.obtain_client()

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

type World = jecs.World

jabby.set_check_function(function(player)
		return true
	end)


local function create_widget(_, state: Enum.UserInputState)
    if state ~= Enum.UserInputState.Begin then return end
    client.spawn_app(client.apps.home, nil)
end

ContextActionService:BindAction("Open Jabby Home", create_widget, false, Enum.KeyCode.F4)


do

    ComponentsLoader(world, components) 

    jabby.register({
        applet = jabby.applets.world,
        name = "world",
        configuration = {
            world = world-- put your ecs world here
        }
    })

    jabby.set_check_function(function()
		return true
	end)

    RunService.Heartbeat:connect(function()
        --for _, system in pairs(SystemsRegistry["server" :: "server"]) do
         --   system(world, components)
        --end
        NetworkingClient(world)
    end)
end