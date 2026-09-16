--!strict

local QueueTypes = require("./QueueTypes")

type Queue<any> = QueueTypes.Queue<any>

local function removeValue(npcQueue: Queue<any>, value): boolean
    print("Removing", value, "from queue:", npcQueue.queue, "head:", npcQueue.head, "tail:", npcQueue.tail)
    for i = npcQueue.head, npcQueue.tail - 1 do
        print("checking index", i, "value:", npcQueue.queue[i])
        if npcQueue.queue[i] == value then
            for j = i, npcQueue.tail - 2 do
                npcQueue.queue[j] = npcQueue.queue[j + 1]
            end
            npcQueue.queue[npcQueue.tail - 1] = nil
            npcQueue.tail -= 1
            
            if npcQueue.head == npcQueue.tail then
                npcQueue.head = 1
                npcQueue.tail = 1
            end

            print("Removed successfully, new tail:", npcQueue.tail)
            return true
        end
    end
    warn("removeValue: entity not found in queue")
    return false
end

return removeValue