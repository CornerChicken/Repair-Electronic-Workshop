--!strict
--[[
    This module allows you to perform checks to see if a given amount of time has passed.
    For example, you have a script that runs every frame, and you want to check if a
    certain interval has passed before you can spawn another part. In this case,
    you would do:

        local spawnInterval = interval(5) -- For 5 second delay

        if spawnInterval() then -- Make sure to add parantheses to spawnInterval()
            -- Spawn a part
        end
]]

local function interval(s: number): () -> (boolean)
	local pin: number = nil

	local function throttle(): boolean
		if not pin then
			pin = os.clock()
		end

		local elapsed = os.clock() - pin > s
		if elapsed then
			pin = os.clock()
		end

		return elapsed
	end
	return throttle
end

return interval
