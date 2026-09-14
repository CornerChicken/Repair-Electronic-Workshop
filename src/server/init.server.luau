local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local startup = require(ReplicatedStorage.Shared.Core.startup)

type SystemTable<U...> = Planck.SystemTable<U...>

local systems = {} :: SystemTable<any>

local function addSystems(folder)
    for _, system in folder:GetChildren() do
        if not system:IsA("ModuleScript") then
            continue
        end

        table.insert(systems, require(system))
    end
end

--addSystems(ReplicatedStorage.Shared.Systems)
addSystems(ServerScriptService.Server.Systems)

startup(systems)