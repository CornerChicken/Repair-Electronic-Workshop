--!strict
--[[
    Create stats in leaderboard
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local Phase = Planck.Phase

local LocalPlayer = Players.LocalPlayer

local function createLeaderboard(world)
    local leaderStats = Instance.new("Folder")
    leaderStats.Name = "leaderstats"
    leaderStats.Parent = LocalPlayer

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = 0
    cash.Parent = leaderStats
end

return {
    system = createLeaderboard,
    phase = Phase.PreStartup
}