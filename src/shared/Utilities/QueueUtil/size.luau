--!strict

local QueueTypes = require("./QueueTypes")

type Queue = QueueTypes.Queue<any>

local function size(npcQueue: Queue): number
    return npcQueue.tail - npcQueue.head
end

return size