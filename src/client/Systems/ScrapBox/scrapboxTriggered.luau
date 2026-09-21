--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)

local Zap = require(ReplicatedStorage.Shared.Core.zap)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Phase = Planck.Phase

type World = jecs.World

local SCRAPBOX_COOLDOWN = 3

local playerCooldown = os.clock()

local function scrapboxTriggered(world: World)
    world:added(components.ScrapboxTrigger, function(entity, id) 
        if (os.clock() - playerCooldown) > SCRAPBOX_COOLDOWN then
            playerCooldown = os.clock()
            print("Scrapbox triggered by: ", game.Players.LocalPlayer.Name)
            Zap.OnScrapboxTriggered.Fire()
        end
        world:remove(entity, id)
    end)
end

return {
    system = scrapboxTriggered,
    phase = Phase.PreStartup
}