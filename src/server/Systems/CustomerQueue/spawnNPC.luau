--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)

local ComponentsList = require(ReplicatedStorage.Shared.Components.ComponentsList)

local Assets = ServerStorage.Assets
local npcTemplate = Assets:FindFirstChild("npcTemplate") :: Model

local applyRandomFriendToNPC = require("./applyRandomFriendToNPC")

type World = Jecs.World
type ComponentsListType = ComponentsList.ComponentsListType

local function spawnNPC(world: World, components: ComponentsListType, workshopId: number)
    local player = world:get(workshopId, components.Owner) :: Player
    local friendsIds = applyRandomFriendToNPC(player)
    
    local random = math.random(#friendsIds)
    local randomFriendId = friendsIds[random]

    local clone = npcTemplate:Clone()
    clone.Parent = workspace

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
    
end

return spawnNPC