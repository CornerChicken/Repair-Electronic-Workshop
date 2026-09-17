--!strict
--[[
    Create stats in leaderboard
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)
local PlankRunService = require(Packages.PlanckRunService)

local Phases = PlankRunService.Phases

local onEvent = Planck.onEvent
local hasNewEvent, collectEvents = onEvent(Players.PlayerAdded)

local function createLeaderboard(_world)
    for _, player in collectEvents() do
        local leaderStats = Instance.new("Folder")
        leaderStats.Name = "leaderstats"
        leaderStats.Parent = player

        local cash = Instance.new("IntValue")
        cash.Name = "Cash"
        cash.Value = 0
        cash.Parent = leaderStats
    end
end

return {
    system = createLeaderboard,
    phase = Phases.First,
    runConditions = { hasNewEvent }
}