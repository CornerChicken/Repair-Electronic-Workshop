--!strict
--[[
    Add the player model to the player collision group
]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Phase = Planck.Phase.Startup

type World = jecs.World
type ComponentsListType = components.ComponentsListType

local PLAYER_COLLISION_GROUP = "Character"
local NPC_COLLISION_GROUP = "NPC"

local playerEvents = {}

local function onDescendantAdded(descendant)
	-- Set collision group for any part descendant
	if descendant:IsA("BasePart") then
		descendant.CollisionGroup = PLAYER_COLLISION_GROUP
	end
end

local function onCharacterAdded(character)
	-- Process existing and new descendants for physics setup
	for _, descendant in character:GetDescendants() do
		onDescendantAdded(descendant)
	end

    character.DescendantAdded:Connect(onDescendantAdded)
end

local function playerCollisions()
    -- Register collision groups
    workspace:RegisterCollisionGroup(PLAYER_COLLISION_GROUP)
    workspace:RegisterCollisionGroup(NPC_COLLISION_GROUP)
    workspace:CollisionGroupSetCollidable(PLAYER_COLLISION_GROUP, NPC_COLLISION_GROUP, false)

    -- Set collisions
    Players.PlayerAdded:Connect(function(player)
        local charAdded = player.CharacterAdded:Connect(onCharacterAdded)
        playerEvents[player] = charAdded
    end)

    -- Disconnect event when playe   leaves
    Players.PlayerRemoving:Connect(function(player)
        playerEvents[player]:Disconnect()
        playerEvents[player] = nil
    end)
end

return {
    system = playerCollisions,
    phase = Phase.PreStartup,
}
