--!strict
--[[
    Load inventory UI
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryController = require("../UI/Controller/InventoryController")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local Phase = Planck.Phase

local function inventoryController(world)
    InventoryController.Init(world)
end

return {
    system = inventoryController,
    phase = Phase.PreStartup
}