--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)
local PlanckRunService = require(Packages.PlanckRunService)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)
local QueueUtil = require(ReplicatedStorage.Shared.Utilities.QueueUtil)

local Assets = ServerStorage.Assets
local npcTemplate = Assets:FindFirstChild("npcTemplate") :: Model

local pair = Jecs.pair
local ChildOf = Jecs.ChildOf
local Phases = PlanckRunService.Phases

type World = Jecs.World

local NPC_COLLISION_GROUP = "NPC"

-- Iterate through friends pages
local function iterPageItems(pages)
    return coroutine.wrap(function()
        local pagenum = 1
        while true do
            for _, friend in ipairs(pages:GetCurrentPage()) do
                coroutine.yield(friend.Id)
            end
            if pages.IsFinished then
                break
            end
            pages:AdvanceToNextPageAsync()
            pagenum = pagenum + 1
        end
    end)
end

-- Get friend ids
local function applyRandomFriendToNPC(player: Player)
    local friendsIds = {}
    local success, friendPages = pcall(function()
        return Players:GetFriendsAsync(player.UserId)
    end)

    if not success then
        warn("Failed to fetch friends.")
    end

    for id in iterPageItems(friendPages) do
        table.insert(friendsIds, id)
    end

    return friendsIds
end

local function spawnNpc(world: World)
    for spawnId, spawnTag in world:query(components.Spawn, pair(ChildOf, Jecs.Wildcard)) do
        -- Remove spawn tag
        world:remove(spawnId, components.Spawn)

        -- Extract workshopId from pair
        local workshopId = world:target(spawnId, ChildOf)
        local npcQueue = world:get(workshopId, components.NpcQueue)
        
        -- Safety just in case a player leaves game
        if world:has(workshopId, components.Owner) and QueueUtil.size(npcQueue) < 3 then
            local player = world:get(workshopId, components.Owner) :: Player

            local clone = npcTemplate:Clone()
            local humanoid = clone:FindFirstChild("Humanoid") :: Humanoid
            clone.Parent = workspace
            
            -- Set collision group
            for _, descendant in clone:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.CollisionGroup = NPC_COLLISION_GROUP
                end
            end

            -- Move NPC
            local instance = world:get(spawnId, components.Instance)
            clone:PivotTo(instance.CFrame)

            -- Create entity, assign component instance and owner
            local npcId = world:entity()
            world:set(npcId, components.Instance, clone)
            world:add(npcId, components.Npc)
            world:add(npcId, pair(ChildOf, workshopId))
            world:set(npcId, Jecs.Name, "NPC")

            -- Load NPC
            task.spawn(function() -- Scheduler doesn't allow for script yielding
                local friendsIds = applyRandomFriendToNPC(player) -- The :GetFriendsAsync causes yielding
                
                local random = math.random(#friendsIds)
                local randomFriendId = friendsIds[random]
                local success, humanoidDescription = pcall(function()
                    return Players:GetHumanoidDescriptionFromUserId(randomFriendId)
                end)

                if success and humanoidDescription then
                    
                    if humanoid then
                        humanoid:ApplyDescriptionAsync(humanoidDescription)

                            -- Set collision group
                        for _, descendant in clone:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                descendant.CollisionGroup = NPC_COLLISION_GROUP
                            end
                        end
                    end                    
                else
                    warn("Failed to load appearance for UserId: " .. tostring(randomFriendId))
                end
            end)
        end   
    end
end

return {
    system = spawnNpc,
    phase = Phases.Update,
}