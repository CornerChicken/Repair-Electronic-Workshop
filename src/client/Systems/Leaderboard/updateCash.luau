--!strict
--[[
    Update leaderboard cash
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Phase = Planck.Phase

type World = jecs.World

local LocalPlayer = Players.LocalPlayer

local function _updateLeaderboard(world, entity, value)
    if world:has(entity, components.PlayerData) then
        local learderstats = LocalPlayer:FindFirstChild("leaderstats")
        local cashValue = learderstats:FindFirstChild("Cash")
        cashValue.Value = value
    end
end

local function updateCash(world: World)
    world:added(components.Cash, function(entity, id, value)
        _updateLeaderboard(world, entity, value)
    end)
    world:changed(components.Cash, function(entity, id, value)
        _updateLeaderboard(world, entity, value)
    end)
end

return {
    system = updateCash,
    phase = Phase.Startup
}