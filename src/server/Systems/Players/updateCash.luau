--!strict
--[[
    Update leaderboard cash
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Phase = Planck.Phase

type World = jecs.World

local function _updateLeaderboard(world: World, entity, value)
    if world:has(entity, components.PlayerData) then
        local player = world:get(entity, components.Player) :: Player
        local leaderstats = player:FindFirstChild("leaderstats") :: Instance
        local cashValue = leaderstats:FindFirstChild("Cash") :: IntValue
        cashValue.Value = value
    end
end

local function updateCash(world: World)
    world:added(components.Cash, function(entity, _id, value)
        _updateLeaderboard(world, entity, value)
    end)
    world:changed(components.Cash, function(entity, _id, value)
        _updateLeaderboard(world, entity, value)
    end)
end

return {
    system = updateCash,
    phase = Phase.Startup
}