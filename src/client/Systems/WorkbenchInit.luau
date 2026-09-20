--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)
local Planck = require(Packages.Planck)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local Phase = Planck.Phase

type World = Jecs.World

local function WorkbenchInit(world: World)
    task.spawn(function()
        print("WorkshopInit running")
        world:added(components.Client, function(entity)
            local workshopInstance = world:get(entity, components.Instance) :: Instance
            print(workshopInstance)
            local workbench = workshopInstance:WaitForChild("Workbench") :: any
            local workbenchMat = workbench:WaitForChild("WorkbenchMat")
            print(workbench)
            local prompt = Instance.new("ProximityPrompt")

            prompt.ActionText = "Use"
            prompt.ObjectText = "Workbench"
            prompt.KeyboardKeyCode = Enum.KeyCode.E
            prompt.HoldDuration = 0.5
            prompt.Parent = workbenchMat

            prompt.Triggered:Connect(function(player)
                print("Workbench triggered by: ", player)
                world:add(entity, components.WorkbenchTrigger)
            end)     
        end)
    end)
end

return {
    system = WorkbenchInit,
    phase = Phase.PreStartup,
}

