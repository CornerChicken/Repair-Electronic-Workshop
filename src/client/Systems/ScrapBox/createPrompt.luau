--!strict
--[[
    Create scrap box prompt
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Phase = Planck.Phase

local function createPrompt(world)
    task.spawn(function()
        world:added(components.Client, function(entity)
            local workshopInstance = world:get(entity, components.Instance) :: Instance
            local scrapbox = workshopInstance:WaitForChild("Scrapbox")

            local prompt = Instance.new("ProximityPrompt")
            prompt.ActionText = "Use"
            prompt.ObjectText = "Scrapbox"
            prompt.KeyboardKeyCode = Enum.KeyCode.E
            prompt.HoldDuration = 0.5
            prompt.Parent = scrapbox

            prompt.Triggered:Connect(function()
                world:add(entity, components.ScrapboxTrigger)
            end)
        end)
    end)
end

return {
    system = createPrompt,
    phase = Phase.PreStartup
}