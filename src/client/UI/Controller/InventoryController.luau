--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local Fusion = require(Packages.Fusion)
local scoped = Fusion.scoped

local InventoryState = require("../State/InventoryState")
local HardwareInventory = require("../View/HardwareInventory")

-- Components
local Header = require("../Components/Header")

local InventoryController = {}

function InventoryController.Init(world)
	-- Create scope
	local scope = scoped(Fusion, {
		Header = Header
	})

	-- Create state
	InventoryState.init(scope)

	-- Mount Fusion UI to PlayerGui
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local guiInstance = HardwareInventory(scope)
	guiInstance.Parent = playerGui

	-- System function run inside your client scheduler step
	--[[
    return function()
		for entity, inventoryComponent in world:query() do
			-- Sync Jecs data directly to the Fusion state object
			InventoryState.InventoryData:set(inventoryComponent.Items)
		end
	end
    ]]
end

return InventoryController