local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local Fusion = require(Packages.Fusion)
local Children = Fusion.Children
local Child = Fusion.Child
local OnEvent = Fusion.OnEvent

local InventoryState = require("../State/InventoryState")


type Scope = Fusion.Scope<any>
type UsedAs<T> = Fusion.UsedAs<T>

type Category = {
	Name: string,
	Color: Color3
}

local TEXT_FONT = Font.fromEnum(Enum.Font.FredokaOne)

local BUTTON_SIZE = UDim2.fromScale(1, 0.133)
local BUTTON_TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local BUTTON_TEXT_SIZE = 16

local MAX_TEXT_SIZE = 30

local function TabButton(
    scope: Scope,
    props: {
        Category: UsedAs<Category>
    }
): Fusion.Child
	local isHovered = scope:Value(false)
	local isActive = scope:Computed(function(use)
		return use(InventoryState.ActiveTab) == (props.Category :: Category).Name
	end)

	local scaleSpring = scope:Spring(scope:Computed(function(use)
		return use(isHovered) and 1.05 or 1.0
	end), 25, 0.6)

	return scope:New "TextButton" {
		Name = (props.Category :: Category).Name .. "Tab",
		Size = BUTTON_SIZE,
		BackgroundColor3 = (props.Category :: Category).Color,
		FontFace = TEXT_FONT,
		Text = (props.Category :: Category).Name,
		TextColor3 = BUTTON_TEXT_COLOR,
		TextSize = BUTTON_TEXT_SIZE,
		TextScaled = true,

		[OnEvent "MouseEnter"] = function()
			isHovered:set(true)
		end,
		[OnEvent "MouseLeave"] = function()
			isHovered:set(false) end,
		[OnEvent "MouseButton1Click"] = function()
			InventoryState.ActiveTab:set((props.Category :: Category).Name)
		end,

		[Children] = Child {
			scope:New "UICorner" {
                CornerRadius = UDim.new(0, 10)
            },
			scope:New "UIScale" {
                Scale = scaleSpring
            },
			scope:New "UITextSizeConstraint" {
				MaxTextSize = MAX_TEXT_SIZE
			},
			scope:New "UIStroke" {
				Thickness = scope:Computed(function(use) return use(isActive) and 4 or 2 end),
				Color = Color3.fromRGB(30, 30, 40)
			},
		}
	}
end

return TabButton