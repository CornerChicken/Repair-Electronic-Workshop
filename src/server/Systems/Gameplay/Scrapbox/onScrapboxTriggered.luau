--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local Zap = require(ServerScriptService.Server.Core.zap)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local RarityWeights = require(ReplicatedStorage.Shared.Data.RarityWeights)

local Phase = Planck.Phase

type World = jecs.World

local SCRAPBOX_COOLDOWN = 3 -- seconds
local TOTAL_WEIGHT = 0

local playerCooldowns = {} :: { [Player]: number}

local function onScrapboxTriggered(world: World)
    -- Load total rarity weight
    for _, weight in RarityWeights do
	    TOTAL_WEIGHT += weight
    end

    local function spinItem()
        local roll = math.random() * TOTAL_WEIGHT
        local counter = 0

        for rarity, weight in RarityWeights do
            counter += weight
            if roll <= counter then
                return rarity
            end
        end
        return "Common"
    end

    Zap.OnScrapboxTriggered.SetCallback(function(player: Player)
        if playerCooldowns[player] == nil or (os.clock() - playerCooldowns[player]) > SCRAPBOX_COOLDOWN then
            playerCooldowns[player] = os.clock()
            print("Spinning: " .. spinItem())
        end
    end)

    Players.PlayerRemoving:Connect(function(player: Player)
        playerCooldowns[player] = nil
    end)
end

return {
    system = onScrapboxTriggered,
    phase = Phase.Startup
}