--!strict
local TimeInterval = require("@self/TimeInterval")
local TimeManager = require("@self/TimeManager")

export type TimeInterval = TimeInterval.TimeInterval
export type TimeManager = TimeManager.TimeManager

local TimeUtil = {}

TimeUtil.TimeInterval = TimeInterval
TimeUtil.TimeManager = TimeManager

return TimeUtil