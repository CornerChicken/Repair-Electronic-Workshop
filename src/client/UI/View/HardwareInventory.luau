--!strict
local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
local InventoryState = require("../State/InventoryState")

local Header = require("../Components/Header")
local TabButton = require("../Components/TabButton")
local ItemSlot = require("../Components/ItemSlot")

local peek = Fusion.peek
local Children = Fusion.Children

type Scope = Fusion.Scope<any>

local HEADER_SIZE = UDim2.fromScale(1, 0.114)
local HEADER_GRADIENT = ColorSequence.new(
    Color3.fromRGB(255, 130, 60), -- Original Orange
    Color3.fromRGB(180, 70, 20)
)

local CONTENT_FRAME_POSITION = UDim2.fromScale(0.247, 0.148)
local CONTENT_FRAME_SIZE = UDim2.fromScale(0.729, 0.818)
local CONTENT_FRAME_GRID_CELL_SIZE = UDim2.fromOffset(140, 140)
local CONTENT_FRAME_CELL_PADDING = UDim2.fromOffset(10, 10)

local Categories = {
	{ Name = "RAM", Color = Color3.fromRGB(235, 57, 44) },
	{ Name = "GPU", Color = Color3.fromRGB(85, 230, 120) },
	{ Name = "CPU", Color = Color3.fromRGB(255, 210, 50) },
	{ Name = "Storage", Color = Color3.fromRGB(180, 100, 255) },
	{ Name = "Motherboard", Color = Color3.fromRGB(255, 130, 60) },
	{ Name = "Cooler", Color = Color3.fromRGB(100, 200, 255) },
}
table.freeze(Categories)

local function HardwareInventory(scope: Fusion.Scope<any>)
	local displayedItems = scope:Computed(function(use)
		local tab = use(InventoryState.ActiveTab)
		local data = use(InventoryState.InventoryData)
		return data[tab] or {}
	end)

	return scope:New "ScreenGui" {
		Name = "HardwareInventoryGui",
		ResetOnSpawn = false,
		Enabled = peek(InventoryState.IsOpen),

		[Children] = {
            scope:New "UIAspectRatioConstraint" {},

			scope:New "Frame" {
				Name = "MainFrame",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(0.813, 0.961),
				BackgroundColor3 = Color3.fromRGB(30, 35, 55),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 16) },
                    scope:New "UIStroke" {
                        Color = Color3.fromRGB(18, 22, 26),
                        Thickness = 4,
                    },

                    scope:Header {
                        Gradient = HEADER_GRADIENT,
                        Text = "HARDWARE INVENTORY",
                        Size = HEADER_SIZE,
                    },
					
					-- Left Sidebar (Tabs)
					scope:New "ScrollingFrame" {
						Name = "TabHolder",
						Position = UDim2.fromScale(0.024, 0.148),
						Size = UDim2.fromScale(0.206, 0.818),
						BackgroundTransparency = 1,

                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.fromScale(0, 0),
                        ScrollBarImageColor3 = Color3.fromRGB(0, 90, 102),
                        ScrollBarThickness = 4,

						[Children] = {
							scope:New "UIListLayout" { Padding = UDim.new(0, 8) },
							scope:New "UIPadding" {
								PaddingBottom = UDim.new(0, 4),
								PaddigLeft = UDim.new(0, 4),
								PaddingRight = UDim.new(0, 10),
								PaddingTop = UDim.new(0, 6),
							},
							scope:ForPairs(Categories, function(_, _, index, category)
								return index, TabButton(scope, {
                                    Category = category
                                })
							end)
						}
					},

					-- Right Content Panel (Grid)
					scope:New "Frame" {
						Name = "ContentFrame",
						Position = CONTENT_FRAME_POSITION,
						Size = CONTENT_FRAME_SIZE,
						BackgroundColor3 = Color3.fromRGB(22, 26, 42),

						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(0, 12) },
							scope:New "ScrollingFrame" {
								Size = UDim2.fromScale(0.968, 0.956),
								Position = UDim2.fromScale(0.016, 0.022),
								BackgroundTransparency = 1,

								[Children] = {
									scope:New "UIGridLayout" {
										CellSize = CONTENT_FRAME_GRID_CELL_SIZE,
										CellPadding = CONTENT_FRAME_CELL_PADDING
									},
									scope:ForPairs(displayedItems, function(index, itemData)
										return index, ItemSlot(scope, {
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