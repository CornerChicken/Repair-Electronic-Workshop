--!strict
local createQueue = require("@self/createQueue")
local dequeue = require("@self/dequeue")
local enqueue = require("@self/enqueue")
local size = require("@self/size")
local QueueTypes = require("@self/QueueTypes")

local QueueUtil = {}

QueueUtil.createQueue = createQueue
QueueUtil.dequeue = dequeue
QueueUtil.enqueue = enqueue
QueueUtil.size = size

export type Queue = QueueTypes.Queue<any>

return QueueUtil