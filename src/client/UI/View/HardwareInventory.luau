local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
local InventoryState = require("../State/InventoryState")
local TabButton = require("../Components/TabButton")
local ItemSlot = require("../Components/ItemSlot")

local New = Fusion.New
local Computed = Fusion.Computed
local ForPairs = Fusion.ForPairs
local Children = Fusion.Children

local Categories = {
	{ Name = "RAM", Color = Color3.fromRGB(0, 210, 255) },
	{ Name = "GPU", Color = Color3.fromRGB(85, 230, 120) },
	{ Name = "CPU", Color = Color3.fromRGB(255, 210, 50) },
	{ Name = "Storage", Color = Color3.fromRGB(180, 100, 255) },
	{ Name = "Motherboard", Color = Color3.fromRGB(255, 130, 60) },
	{ Name = "Cooler", Color = Color3.fromRGB(100, 200, 255) },
}

local function HardwareInventory()
	local displayedItems = Computed(function()
		local tab = InventoryState.ActiveTab:get()
		local data = InventoryState.InventoryData:get()
		return data[tab] or {}
	end)

	return New "ScreenGui" {
		Name = "HardwareInventoryGui",
		ResetOnSpawn = false,
		Enabled = InventoryState.IsOpen,

		[Children] = {
			New "Frame" {
				Name = "MainFrame",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(680, 440),
				BackgroundColor3 = Color3.fromRGB(30, 35, 55),

				[Children] = {
					New "UICorner" { CornerRadius = UDim.new(0, 16) },
					
					-- Left Sidebar (Tabs)
					New "Frame" {
						Name = "TabHolder",
						Position = UDim2.fromOffset(16, 5),
						Size = UDim2.new(0, 140, 1, -80),
						BackgroundTransparency = 1,

						[Children] = {
							New "UIListLayout" { Padding = UDim.new(0, 8) },
							ForPairs(Categories, function(i, category)
								return i, TabButton(category)
							end)
						}
					},

					-- Right Content Panel (Grid)
					New "Frame" {
						Name = "ContentFrame",
						Position = UDim2.fromOffset(168, 65),
						Size = UDim2.new(1, -184, 1, -80),
						BackgroundColor3 = Color3.fromRGB(22, 26, 42),

						[Children] = {
							New "UICorner" { CornerRadius = UDim.new(0, 12) },
							New "ScrollingFrame" {
								Size = UDim2.new(1, -16, 1, -16),
								Position = UDim2.fromOffset(8, 8),
								BackgroundTransparency = 1,

								[Children] = {
									New "UIGridLayout" {
										CellSize = UDim2.fromOffset(140, 140),
										CellPadding = UDim2.fromOffset(10, 10),
									},
									ForPairs(displayedItems, function(index, itemData)
										return index, ItemSlot({
                                            Index = index,
                                            Data = itemData
                                        })
									end)
								}
							}
						}
					}
				}
			}
		}
	}
end

return HardwareInventory