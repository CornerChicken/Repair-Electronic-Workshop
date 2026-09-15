local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)

local Value = Fusion.Value

return {
	ActiveTab = Value("RAM"),
	IsOpen = Value(false),
	InventoryData = Value({
		RAM = {},
		GPU = {},
		CPU = {},
		Storage = {},
		Motherboard = {},
		Cooler = {},
	}),
}