--!strict
local QueueTypes = require("./QueueTypes")

type Queue = QueueTypes.Queue<any>

local function enqueue(npcQueue: Queue, item)
    npcQueue.queue[npcQueue.tail] = item
    npcQueue.tail += 1
    return npcQueue
end

return enqueue