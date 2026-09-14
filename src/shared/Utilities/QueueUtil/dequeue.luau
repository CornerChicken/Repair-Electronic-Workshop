--!strict
local QueueTypes = require("./QueueTypes")

type Queue = QueueTypes.Queue<any>

local function dequeue(npcQueue: Queue)
    if npcQueue.head >= npcQueue.tail then return nil end

    if npcQueue.queue[npcQueue.head] then
        local npc = npcQueue.queue[npcQueue.head]
        npcQueue.queue[npcQueue.head] = nil
        npcQueue.head += 1

        if npcQueue.head == npcQueue.tail then
            npcQueue.head = 1
            npcQueue.tail = 1
        end

        return npc
    else
        warn("Could not find valid item in npcQueue head")
        return
    end
end

return dequeue