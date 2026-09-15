local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

export type ItemData = {
	Name: string,
	Tier: string,
	Qty: string,
	Color: Color3?,
	Icon: string?,
}

export type SlotProps = {
	Index: number,
	Data: ItemData,
	OnClick: ((itemData: ItemData) -> ())?,
}

local function ItemSlot(props: SlotProps)
	local itemData = props.Data
	local isHovered = Value(false)

	-- Hover spring scale for item cards
	local scaleSpring = Spring(Computed(function()
		return isHovered:get() and 1.04 or 1.0
	end), 25, 0.6)

	return New "ImageButton" {
		Name = "Slot_" .. tostring(props.Index),
		BackgroundColor3 = Color3.fromRGB(35, 42, 68),
		AutoButtonColor = false,

		[OnEvent "MouseEnter"] = function()
			isHovered:set(true)
		end,
		[OnEvent "MouseLeave"] = function()
			isHovered:set(false)
		end,
		[OnEvent "MouseButton1Click"] = function()
			if props.OnClick then
				props.OnClick(itemData)
			end
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 10),
			},
			New "UIStroke" {
				Thickness = 2,
				Color = Computed(function()
					return isHovered:get() and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 60, 95)
				end),
			},
			New "UIScale" {
				Scale = scaleSpring,
			},

			-- Top-Left Tier Tag Badge (e.g. "T1")
			New "TextLabel" {
				Size = UDim2.new(0, 45, 0, 18),
				Position = UDim2.new(0, 6, 0, 6),
				BackgroundColor3 = Color3.fromRGB(50, 60, 90),
				Font = Enum.Font.FredokaOne,
				Text = itemData.Tier or "T1",
				TextColor3 = Color3.fromRGB(200, 220, 255),
				TextSize = 11,

				[Children] = {
					New "UICorner" { CornerRadius = UDim.new(0, 6) },
				},
			},

			-- Item Display Title
			New "TextLabel" {
				Size = UDim2.new(1, -12, 0, 32),
				Position = UDim2.new(0, 6, 0.45, -10),
				BackgroundTransparency = 1,
				Font = Enum.Font.FredokaOne,
				Text = itemData.Name or "Unknown Item",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 13,
				TextWrapped = true,
			},

			-- Rarity & Quantity Footer Banner
			New "Frame" {
				Size = UDim2.new(1, 0, 0, 22),
				Position = UDim2.new(0, 0, 1, -22),
				BackgroundColor3 = itemData.Color or Color3.fromRGB(0, 210, 255),

				[Children] = {
					New "UICorner" { CornerRadius = UDim.new(0, 10) },
					-- Inner frame to square off top corners of bottom banner
					New "Frame" {
						Size = UDim2.new(1, 0, 0, 10),
						Position = UDim2.new(0, 0, 0, 0),
						BackgroundColor3 = itemData.Color or Color3.fromRGB(0, 210, 255),
						BorderSizePixel = 0,
					},
					New "TextLabel" {
						Size = UDim2.new(1, -8, 1, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.FredokaOne,
						Text = itemData.Qty or "x1",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 12,
						TextXAlignment = Enum.TextXAlignment.Right,
					},
				},
			},
		},
	}
end

return ItemSlot