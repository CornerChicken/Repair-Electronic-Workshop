local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

export type ItemData = {
	Name: string,
	Tier: string,
	Qty: string,
	Color: Color3?,
	Icon: string?,
}

type UsedAs<T> = Fusion.UsedAs<T>
type Scope = Fusion.Scope<any>

local TEXT_FONT = Font.fromEnum(Enum.Font.FredokaOne)

local ITEM_SLOT_BACKGROUND_COLOR = Color3.fromRGB(35, 42, 68)

local TIER_TAG_SIZE = UDim2.fromScale(0.357, 0.129)
local TIER_TAG_POSITION = UDim2.fromScale(0.043, 0.043)
local TIER_TAG_BACKGROUND_COLOR3 = Color3.fromRGB(50, 60, 90)
local TIER_TAG_DEFAULT_TEXT = "T1"
local TIER_TAG_TEXT_COLOR3 = Color3.fromRGB(200, 220, 255)
local TIER_TAG_TEXT_SIZE = 11

local DISPLAY_SIZE = UDim2.fromScale(0.914, 0.214)
local DISPLAY_POSITION = UDim2.fromScale(0.043, 0.429)
local DISPLAY_DEFUALT_TEXT = "Unknown Item"
local DISPLAY_TEXT_COLOR3 = Color3.fromRGB(255, 255, 255)
local DISPLAY_TEXT_SIZE = 13

local RARITY_FRAME_SIZE = UDim2.fromScale(1, 0.157)
local RARITY_FRAME_POSITION = UDim2.fromScale(0, 0.843)
local RARITY_FRAME_DEFAULT_BG_COLOR3 = Color3.fromRGB(0, 210, 255)

local RARITY_FRAME_DC_SIZE = UDim2.fromScale(1, 0.455)

local QUANTITY_TAG_SIZE = UDim2.fromScale(0.929, 1)
local QUANTITY_TAG_DEFAULT_TEXT = "x1"
local QUANTITY_TAG_TEXT_COLOR3 = Color3.fromRGB(255, 255, 255)
local QUAMTITY_TAG_TEXT_SIZE = 12

local function ItemSlot(
	scope: Scope,
	props: {
		Index: UsedAs<number>,
		Data: UsedAs<ItemData>,
		OnClick: ((itemData: ItemData) -> ())?,
	}
): Fusion.Child
	local itemData = props.Data :: ItemData
	local isHovered = scope:Value(false)

	-- Hover spring scale for item cards
	local scaleSpring = scope:Spring(
		scope:Computed(function(use)
			return use(isHovered) and 1.04 or 1.0
		end), 25, 0.6)

	return scope:New "ImageButton" {
		Name = "Slot_" .. tostring(props.Index),
		BackgroundColor3 = ITEM_SLOT_BACKGROUND_COLOR,
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
			scope:New "UICorner" {
				CornerRadius = UDim.new(0, 10),
			},
			scope:New "UIStroke" {
				Thickness = 2,
				Color = scope:Computed(function(use)
					return use(isHovered) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 60, 95)
				end),
			},
			scope:New "UIScale" {
				Scale = scaleSpring,
			},

			-- Top-Left Tier Tag Badge (e.g. "T1")
			scope:New "TextLabel" {
				Size = TIER_TAG_SIZE,
				Position = TIER_TAG_POSITION,
				BackgroundColor3 = TIER_TAG_BACKGROUND_COLOR3,
				FontFace = TEXT_FONT,
				Text = itemData.Tier or TIER_TAG_DEFAULT_TEXT,
				TextColor3 = TIER_TAG_TEXT_COLOR3,
				TextSize = TIER_TAG_TEXT_SIZE,

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
				},
			},

			-- Item Display Title
			scope:New "TextLabel" {
				Size = DISPLAY_SIZE,
				Position = DISPLAY_POSITION,
				BackgroundTransparency = 1,
				FontFace = TEXT_FONT,
				Text = itemData.Name or DISPLAY_DEFUALT_TEXT,
				TextColor3 = DISPLAY_TEXT_COLOR3,
				TextSize = DISPLAY_TEXT_SIZE,
				TextWrapped = true,
			},

			-- Rarity & Quantity Footer Banner
			scope:New "Frame" {
				Size = RARITY_FRAME_SIZE,
				Position = RARITY_FRAME_POSITION,
				BackgroundColor3 = itemData.Color or RARITY_FRAME_DEFAULT_BG_COLOR3,

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(0, 10) },
					-- Inner frame to square off top corners of bottom banner
					scope:New "Frame" {
						Size = RARITY_FRAME_DC_SIZE,
						BackgroundColor3 = itemData.Color or RARITY_FRAME_DEFAULT_BG_COLOR3,
						BorderSizePixel = 0,
					},
					scope:New "TextLabel" {
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