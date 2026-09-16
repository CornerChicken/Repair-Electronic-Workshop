local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)

local START_TAB = "RAM"
local START_ISOPEN = true

export type InventoryData = {
	RAM: { [number]: any },
	GPU: { [number]: any },
	CPU: { [number]: any },
	Storage: { [number]: any },
	Motherboard: { [number]: any },
	Cooler: { [number]: any },
}

local InventoryState = {} :: any

function InventoryState.init(scope: Fusion.Scope<any>)
	InventoryState.ActiveTab = scope:Value(START_TAB)
	InventoryState.IsOpen = scope:Value(START_ISOPEN)
	InventoryState.InventoryData = scope:Value({
		RAM = {},
			GPU = {},
			CPU = {},
			Storage = {},
			Motherboard = {},
			Cooler = {},
	}  :: InventoryData)
end

return InventoryState