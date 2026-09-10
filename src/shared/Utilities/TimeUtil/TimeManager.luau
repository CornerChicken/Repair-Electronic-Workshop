--!strict
local Players = game:GetService("Players")

local TimeInterval = require("./TimeInterval")

local TimeManager = {}
TimeManager.__index = TimeManager

export type TimeManager = typeof(setmetatable({} :: {
        _timeMap: { [string]: TimeInterval },
        _isPlayer: boolean,
        _playerAdded: RBXScriptConnection?
    },
    TimeManager
))

type TimeInterval = TimeInterval.TimeInterval

function TimeManager.new(isPlayer: boolean): TimeManager
    local self = setmetatable({}, TimeManager)

    self._timeMap = {}
    self._isPlayer = isPlayer

    if isPlayer then
        Players.PlayerRemoving:Connect(function(player)
            self:deleteInterval(player.Name)
        end)
    end

    return self
end

function TimeManager:deleteInterval(key: string)
    self._timeMap[key]:Destroy()
    self._timeMap[key] = nil    
end

function TimeManager:createInterval(key: string)
    self._timeMap[key] = TimeInterval.new()
end

function TimeManager:search(key: string): TimeInterval
    return self._timeMap[key]
end

function TimeManager:Destroy()
    for _, interval in pairs(self._timeMap) do
        if interval then
            interval:Destroy()
        end
    end

    for _, value in self do
		if typeof(value) == "RBXScriptConnection" then
			value:Disconnect()
			continue
        end
	end

    setmetatable(self, nil)
end

return TimeManager