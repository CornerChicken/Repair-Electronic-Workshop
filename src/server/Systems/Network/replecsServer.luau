--!strict
--[[
    Send server data to the client using remotes events. This is handle via the modules
    replecs and zap. Replecs caches entity changes and component changes and stores them
    somewhere inside the package. After the given interval, this system will grab the changes
    from replecs and send them across to the client using the remote events created by
    zap.

    Why Zap? Zap provides serialization compatability and network security, which accomplishes
    two things. One, it reduces the network load and ping via serialization. This converts
    data into bytes (in binary) to be sent across to the server. Because serialization allows
    you to create paramenters that ensure a maximum packet size to be sent to the client,
    we can guarantee that network response time will be quick and lightweight. Secondly, 
    zap has built in functions that prevent remote event spamming, a common tactic used by
    exploiters to crash servers. As such, not only are we improving performance but also
    guarding the game against exploiters.

    Difference between reliable and unreliable remote events:

    Reliable - Guaranteed to send data and will error if it can't
    Unreliable - Not guaranteed that client will receive data
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local PlanckRunService = require(Packages.PlanckRunService)

local replicator = require(ServerScriptService.Server.Core.replicator)
local zap = require(ServerScriptService.Server.Core.zap)

local interval = require(ReplicatedStorage.Shared.Utilities.interval)

local Phases = PlanckRunService.Phases

local updatesInterval = interval(1 / 20)
local unreliableInterval = interval(1 / 30)

local function replecsServer()
    if updatesInterval() then
        for player, buf, variants in replicator:collect_updates() do
			zap.OnReliableUpdates.Fire(player, buf, variants)
		end
    end

    if unreliableInterval() then
        for player, buf, variants in replicator:collect_unreliable() do
			zap.OnUnreliableUpdates.Fire(player, buf, variants)
		end
    end
end

return {
    system = replecsServer,
    phase = Phases.Last
}

