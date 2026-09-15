--!strict
--[[
    Send current replicated entities list to a new player when they join game.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local replicator = require(ServerScriptService.Server.Core.replicator)
local zap = require(ServerScriptService.Server.Core.zap)

local Phase = Planck.Phase

local function replicateAll()
    zap.WaitForServer.SetCallback(function(player: Player): (buffer?, unknown)
        if replicator:is_player_ready(player) then
            return nil, nil
        end
        replicator:mark_player_ready(player)
        local buf, variants = replicator:get_full(player)
        print("GETTING FULL FOR", player, buffer.len(buf))
        
        return buf, variants
    end)
end

return {
    system = replicateAll,
    phase = Phase.PreStartup
}

