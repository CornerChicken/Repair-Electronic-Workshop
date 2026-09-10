local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jabby = require(Packages.jabby)-- your path to jabby here!

local client = jabby.obtain_client()

jabby.set_check_function(function(player)
		return true
	end)


local function create_widget(_, state: Enum.UserInputState)
    if state ~= Enum.UserInputState.Begin then return end
    client.spawn_app(client.apps.home, nil)
end

ContextActionService:BindAction("Open Jabby Home", create_widget, false, Enum.KeyCode.F4)
