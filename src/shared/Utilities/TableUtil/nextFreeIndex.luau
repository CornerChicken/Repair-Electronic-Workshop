--!strict
--[[
    Returns the index of the next onoccupied key in the table
]]

local function nextFreeIndex<T>(tab: { T }, start: number): number
    local currentIndex = start
    while true do
        if tab[start] == nil then
            return currentIndex
        end
        currentIndex += 1
    end
end

return nextFreeIndex