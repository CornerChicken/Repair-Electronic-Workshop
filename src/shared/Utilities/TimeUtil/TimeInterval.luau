--!strict
local TimeInterval = {}
TimeInterval.__index = TimeInterval

export type TimeInterval = typeof(setmetatable({} :: {
        _currentTime: number,
    },
    TimeInterval
))

function TimeInterval.new(): TimeInterval
    local self = setmetatable({}, TimeInterval)

    self._currentTime = os.clock()

    return self :: TimeInterval
end

function TimeInterval:timePassed(interval: number): boolean
    local currentTime = os.clock()
    if currentTime - self._currentTime >= interval then
        return true
    else
        return false
    end
end

function TimeInterval:Destroy()
    setmetatable(self, nil)
end

return TimeInterval