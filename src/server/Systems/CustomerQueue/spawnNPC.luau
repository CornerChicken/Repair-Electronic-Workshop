--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)

local world = require(ReplicatedStorage.Shared.Core.world)
local component = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Assets = ServerStorage.Assets
local npcTemplate = Assets:FindFirstChild("npcTemplate") :: Model

local applyRandomFriendToNPC = require("./applyRandomFriendToNPC")
local generateNPCData = require("./generateNPCData")

local pair = Jecs.pair
local ChildOf = Jecs.ChildOf

type World = Jecs.World
type ComponentsListType = component.ComponentsListType

local function spawnNPC(workshopId, components: ComponentsListType)
    local player = world:get(workshopId, components.Owner) :: Player
    local friendsIds = applyRandomFriendToNPC(player)
    
    local random = math.random(#friendsIds)
    local randomFriendId = friendsIds[random]

    local clone = npcTemplate:Clone()
    local Humanoid = clone:FindFirstChild("Humanoid") :: Humanoid
    clone.Parent = workspace

    -- Create entity, assign component instance and owner
    local npcId = world:entity()
    world:set(npcId, components.Instance, clone)
    world:set(npcId, components.Owner, player)
    world:set(npcId, Jecs.Name, "NPC")

    local success, humanoidDescription = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(randomFriendId)
    end)

    if success and humanoidDescription then
        local humanoid = clone:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ApplyDescriptionAsync(humanoidDescription)
        end
    else
        warn("Failed to load appearance for UserId: " .. tostring(randomFriendId))
    end

    generateNPCData(npcId, components)

    for spawnPointId in world:query(components.NPCSpawn, pair(ChildOf, workshopId)) do
        local instance = world:get(spawnPointId, components.Instance)
        clone:PivotTo(instance.CFrame)
    end

    Humanoid:MoveTo(Vector3.new(-28.75, 3.5, 69.625))
    
end

return spawnNPC