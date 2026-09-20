--!strict
--[[
    Create scrap box prompt
]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local client = require(ReplicatedStorage.Packages._Index["pepeeltoro41_replecs@0.4.0-rc.3"].replecs.client)
local Planck = require(Packages.Planck)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local replicator = require("../../Core/replicator")

local Phase = Planck.Phase

local function createPrompt(world)
    task.spawn(function()
        task.spawn(function()
            world:added(components.Owner, function(entity, id, value)
                replicator:after_replication(function()
                    if world:has(entity, components.Workshop) then
                        if value == Players.LocalPlayer then
                            local workshopInstance = world:get(entity, components.Instance) :: Instance
                            local scrapbox = workshopInstance:WaitForChild("Scrapbox")

                            local prompt = Instance.new("ProximityPrompt")
                            prompt.ActionText = "Use"
                            prompt.ObjectText = "Scrapbox"
                            prompt.KeyboardKeyCode = Enum.KeyCode.E
                            prompt.HoldDuration = 0.5
                            prompt.Parent = scrapbox

                            prompt.Triggered:Connect(function(player)
                                print("Scrapbox triggered by: ", player)
                                world:add(entity, components.ScrapboxTrigger)
                            end)
                        end
                    end
                end)
            end)
     end)
    end)
end

return {
    system = createPrompt,
    phase = Phase.PreStartup
}