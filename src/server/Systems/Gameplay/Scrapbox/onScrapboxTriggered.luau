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
local ElectronicComponents = require(ReplicatedStorage.Shared.Data.ElectronicComponents)
local GlobalTypes = require(ReplicatedStorage.Shared.Data.GlobalTypes)

local Phase = Planck.Phase

type World = jecs.World
type Rarity = GlobalTypes.Rarity
type ElectronicComponent = ElectronicComponents.ElectronicComponent

local SCRAPBOX_COOLDOWN = 3 -- seconds
local TOTAL_WEIGHT = 0
local ITEM_LIST = {} :: { [Rarity]: { string } }

local playerCooldowns = {} :: { [Player]: number}

local function onScrapboxTriggered(world: World)
    -- Load total rarity weight
    for rarity: Rarity, weight in RarityWeights do
	    TOTAL_WEIGHT += weight
        ITEM_LIST[rarity] = {}
    end

    -- Load items
    for _, group in ElectronicComponents do
        for name, item in group do
            table.insert(ITEM_LIST[item.rarity], name)
        end
    end

    local function rollRarity(): Rarity
        local roll = math.random() * TOTAL_WEIGHT
        local counter = 0

        for rarity: Rarity, weight in RarityWeights do
            counter += weight
            if roll <= counter then
                return rarity
            end
        end
        return "Common"
    end

    local function spinItem(): string
        local rarity = rollRarity() :: any
        local random = math.random(1, #ITEM_LIST[rarity])

        print("Spinning: " .. ITEM_LIST[rarity][random] .. ":" .. rarity)

        return ITEM_LIST[rarity][random]
    end

    Zap.OnScrapboxTriggered.SetCallback(function(player: Player)
        if playerCooldowns[player] == nil or (os.clock() - playerCooldowns[player]) > SCRAPBOX_COOLDOWN then
            playerCooldowns[player] = os.clock()
            spinItem()
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