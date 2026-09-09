local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage.Packages
local Assets = ServerStorage.Assets

local npcTemplate = Assets:WaitForChild("npcTemplate")

local Jecs = require(Packages.jecs)
local applyRandomFriendToNPC = require(script.Parent.CustomerQueue.applyRandomFriendToNPC)

type World = Jecs.World

local function spawnNPC(world: World, workshopId, components)
    local player = world:get(workshopId, components.Owner)
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
            humanoid:ApplyDescription(humanoidDescription)
        end
    else
        warn("Failed to load appearance for UserId: " .. tostring(randomFriendId))
    end
    
end

return spawnNPC