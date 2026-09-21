--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local Zap = require(ServerScriptService.Server.Core.zap)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Phase = Planck.Phase

type World = jecs.World

local SCRAPBOX_COOLDOWN = 3 -- seconds

local playerCooldowns = {} :: { [Player]: number}

local function onScrapboxTriggered(world: World)
    Zap.OnScrapboxTriggered.SetCallback(function(player: Player)
        if playerCooldowns[player] == nil or (os.clock() - playerCooldowns[player]) > SCRAPBOX_COOLDOWN then
            playerCooldowns[player] = os.clock()
            print("Spinning scrapbox")
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