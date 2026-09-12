--!strict
--[[
    Stashes values from events firing and stores them in a table. This gives scripts
    the ability to update data from an event firing on the scripts own terms.

    For example, lets say you are running a game loop that performs logic every frame. Instead
    of waiting for the playerAdded event to fired whenever a player joins, you can use
    this module to passively store player joins inside a table. Then when the script runs
    its logic on the next frame, it can loop through the table of player joins to perform
    actions on the newly joined player. Furthermore, upon each iteration of the loop a player
    is removed from the table, preventing the same logic from running on a player across
    frames.
]]
local function collect(signal)
	local enqueued = {}

	local i = 0

	local connection = signal:Connect(function(...)
		table.insert(enqueued, { ... })
		i += 1
	end)

	return function(): any
		if i == 0 then
			return
		end

		i -= 1

		local args: any = table.remove(enqueued, 1)

		return unpack(args)
	end, connection
end

type Signal<T... = ...any> = {
    Connect: (self: Signal<T...>, callback: (T...) -> ()) -> RBXScriptConnection,
    ConnectParallel: (self: Signal<T...>, callback: (T...) -> ()) -> RBXScriptConnection,
    Once: (self: Signal<T...>, callback: (T...) -> ()) -> RBXScriptConnection,
    Wait: (self: Signal<T...>) -> (T...)
}

return collect :: <T...>(Signal<T...>) -> (() -> (T...), RBXScriptConnection)