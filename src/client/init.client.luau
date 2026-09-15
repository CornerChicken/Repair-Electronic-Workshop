local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local replicator = require("@self/Core/replicator")
replicator:init()

local startup = require(ReplicatedStorage.Shared.Core.startup)

type SystemTable<U...> = Planck.SystemTable<U...>

local systems = {} :: SystemTable<any>

local function addSystems(folder)
    for _, system in folder:GetDescendants() do
        if not system:IsA("ModuleScript") then
            continue
        end

        table.insert(systems, require(system))
    end
end

--addSystems(ReplicatedStorage.Shared.Systems)
addSystems(script.Systems)

print(systems)

startup(systems)