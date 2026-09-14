--!strict
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local jabby = require(Packages.jabby)

local Core = ReplicatedStorage.Shared.Core
local ComponentsLoader = require(Core.ComponentsLoader)
local world = require(Core.world)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local scheduler = require(ReplicatedStorage.Shared.Core.scheduler)

type World = jecs.World

return function(systems)
    ComponentsLoader(world, components) 

    -- Load systems into scheduler
    if #systems ~= 0 then
        scheduler:addSystems(systems)
    end

    -- Allow debugging (will need to disable this in the future to prevent players from
    -- interacting with this)
    jabby.set_check_function(function()
		return true
	end)

    if RunService:IsClient() then
        local client = jabby.obtain_client()

        local function createWidget(_, state: Enum.UserInputState)
            if state ~= Enum.UserInputState.Begin then return end
            client.spawn_app(client.apps.home, nil)
        end

        ContextActionService:BindAction("Open Jabby Home", createWidget, false, Enum.KeyCode.F4)

    end

    jabby.register({
        applet = jabby.applets.world,
        name = "world",
        configuration = {
            world = world-- put your ecs world here
        }
    })
end