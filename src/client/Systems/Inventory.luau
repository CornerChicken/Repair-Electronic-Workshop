--!strict
--[[
    Create stats in leaderboard
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryController = require("../UI/Controller/InventoryController")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local Phase = Planck.Phase

local LocalPlayer = Players.LocalPlayer

local function inventoryController(world)
    local inventoryController = InventoryController.Init(world)
end

return {
    system = inventoryController(),
    phase = Phase.PreStartup
}