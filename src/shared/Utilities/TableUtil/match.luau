--!strict

local function match<T>(tab: { T }, val: T)
    for _, value in ipairs(tab) do
        if value == val then
            return true -- Found it!
        end
    end
    return false -- Not found
end

return match