local Players = game:GetService("Players")
local InventoryState = require("../State/InventoryState")
local HardwareInventory = require("../View/HardwareInventory")

local InventoryController = {}

function InventoryController.Init(world)
	-- Mount Fusion UI to PlayerGui
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local guiInstance = HardwareInventory()
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