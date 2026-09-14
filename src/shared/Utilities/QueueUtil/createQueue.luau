--!strict
local QueueType = require("./QueueTypes")

type Queue<T> = QueueType.Queue<T>

local function createQueue<T>(tab: {T}): Queue<T>
    return {
        queue = tab,
        head = 1,
        tail = 1
    }
end

return createQueue