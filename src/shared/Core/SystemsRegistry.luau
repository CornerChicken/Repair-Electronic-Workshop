--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)

local ComponentsList = require(ReplicatedStorage.Shared.Components.ComponentsList)

local WorkshopOwnership = require(ServerScriptService.Server.Systems.WorkshopOwnership)
local CustomerQueue = require(ServerScriptService.Server.Systems.CustomerQueue)

type ComponentsListType = ComponentsList.ComponentsListType
type RuntimeType = "server" | "client" | "shared"
type SystemsMap = { [string]: (World, ComponentsListType) -> () }
type World = Jecs.World

-- Place all system requires here
local Systems = {
    server = {
        WorkshopOwnership = WorkshopOwnership,
        CustomerQueue = CustomerQueue,
    }
} :: { [RuntimeType]: SystemsMap } 

return Systems