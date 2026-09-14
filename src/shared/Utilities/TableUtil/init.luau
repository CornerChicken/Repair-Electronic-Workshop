--!strict
local deepClear = require("@self/deepClear")
local match = require("@self/match")
local nextFreeIndex = require("@self/nextFreeIndex")


local TableUtil = {}

TableUtil.deepClear = deepClear
TableUtil.match = match
TableUtil.nextFreeIndex = nextFreeIndex

return TableUtil