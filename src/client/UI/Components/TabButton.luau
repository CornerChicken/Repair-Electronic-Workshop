local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)

local InventoryState = require("../State/InventoryState")

local New = Fusion.New
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Children = Fusion.Children
local Value = Fusion.Value

local function TabButton(category)
	local isHovered = Value(false)
	local isActive = Computed(function()
		return InventoryState.ActiveTab:get() == category.Name
	end)

	local scaleSpring = Spring(Computed(function()
		return isHovered:get() and 1.05 or 1.0
	end), 25, 0.6)

	return New "TextButton" {
		Name = category.Name .. "Tab",
		Size = UDim2.new(1, 0, 0, 48),
		BackgroundColor3 = category.Color,
		Font = Enum.Font.FredokaOne,
		Text = category.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,

		[Fusion.OnEvent "MouseEnter"] = function() isHovered:set(true) end,
		[Fusion.OnEvent "MouseLeave"] = function() isHovered:set(false) end,
		[Fusion.OnEvent "MouseButton1Click"] = function() InventoryState.ActiveTab:set(category.Name) end,

		[Children] = {
			New "UICorner" { CornerRadius = UDim.new(0, 10) },
			New "UIScale" { Scale = scaleSpring },
			New "UIStroke" {
				Thickness = Computed(function() return isActive:get() and 4 or 2 end),
				Color = Computed(function()
					return isActive:get() and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 40)
				end),
			},
		}
	}
end

return TabButton