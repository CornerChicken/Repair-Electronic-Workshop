    local function deepClear(t)
        if type(t) ~= "table" then return end
        for k, v in pairs(t) do
            if type(v) == "table" then
                deepClear(v) -- Recursively clear nested tables
            end
            t[k] = nil -- Remove reference to value/child table
        end
    end

    return deepClear