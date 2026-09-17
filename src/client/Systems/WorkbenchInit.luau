--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Replicator = require("../Core/replicator")
local Phase = Planck.Phase

type World = Jecs.World

local function WorkbenchInit(world: World)
    print("WorkshopInit running")
    world:added(components.Owner, function(entity, id, value)
        Replicator:after_replication(function()
            print("Detected Owner Change")
            print(value)
            if world:has(entity, components.Workshop) then
                if value == Players.LocalPlayer then
                    local workshopInstance = world:get(entity, components.Instance) :: Instance
                    print(workshopInstance)
                    local workbench = workshopInstance:FindFirstChild("Workbench") :: any
                    local workbenchMat = workbench.WorkbenchMat
                    print(workbench)
                    print(value)

                    local prompt = Instance.new("ProximityPrompt")

                    prompt.ActionText = "Use"
                    prompt.ObjectText = "Workbench"
                    prompt.KeyboardKeyCode = Enum.KeyCode.E
                    prompt.HoldDuration = 0.5
                    prompt.Parent = workbenchMat
                end
            end
        end)
    end)
end

return {
    system = WorkbenchInit,
    phase = Phase.PreStartup,
}

