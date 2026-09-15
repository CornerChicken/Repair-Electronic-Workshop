--!strict
--[[
    Retrieve server data once player joins the game
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local replicator = require("../../Core/replicator")
local zap = require(ReplicatedStorage.Shared.Core.zap)

local Phase = Planck.Phase

local function requestAll(world)
    task.spawn(function()
        local buf, variants = zap.WaitForServer.Call()

        if buf then
            replicator:apply_full(buf, variants :: any)
        end
    end)
end

return {
    system = requestAll,
    phase = Phase.PreStartup
}

