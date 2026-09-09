--!strict

local Players = game:GetService("Players")

local npcs = {}

local function applyRandomFriendToNPC(player: Player, npcModel: Model)
    local success, friendPages = pcall(function()
        return Players:GetFriendsAsync(player.UserId)
    end)
end

local function CustomerQueue()

end

return CustomerQueue