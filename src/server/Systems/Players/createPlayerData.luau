--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)
local replecs = require(Packages.replecs)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local onEvent = Planck.onEvent
local hasNewEvent, collectEvents = onEvent(Players.PlayerAdded)

type World = jecs.World

local DEFAULT_CASH: number = 0

local function createPlayerData(world: World)
    for _, player in collectEvents() do
        local playerEntity = world:entity()
        world:set(playerEntity, jecs.Name, "PlayerDataEntity")
        world:add(playerEntity, replecs.Networked)
        world:set(playerEntity, components.Player, player)
        world:add(playerEntity, components.PlayerData)

        -- Add player data components here
        world:set(playerEntity, components.Cash, DEFAULT_CASH)
        world:set(playerEntity, components.PlayerState, "Idle")
        
        -- Replication to client
        world:add(playerEntity, jecs.pair(replecs.reliable, components.Cash))
        world:add(playerEntity, jecs.pair(replecs.reliable, components.Player))
        world:add(playerEntity, jecs.pair(replecs.reliable, components.PlayerData))
        world:add(playerEntity, jecs.pair(replecs.reliable, components.Owner))
        world:add(playerEntity, jecs.pair(replecs.reliable, components.Workbench))
    end
end

return {
    system = createPlayerData,
    runConditions = { hasNewEvent }
}