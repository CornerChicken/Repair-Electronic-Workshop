--!strict

local Players = game:GetService("Players")

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

local function applyRandomFriendToNPC(player: Player, npcModel: Model)
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

return applyRandomFriendToNPC