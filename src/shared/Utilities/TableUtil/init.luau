--!strict
local deepClear = require("@self/deepClear")
local match = require(script.match)

local TableUtil = {}

TableUtil.deepClear = deepClear
TableUtil.match = match

return TableUtil