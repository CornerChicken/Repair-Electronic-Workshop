local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

export type ButtonProps = {
	Name: string?,
	Text: string,
	Size: UDim2?,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	BackgroundColor3: Color3?,
	StrokeColor: Color3?,
	TextColor3: Color3?,
	TextSize: number?,
	CornerRadius: number?,
	OnClick: () -> ()?,
}

local function Button(props: ButtonProps)
	local isHovered = Value(false)
	local isPressed = Value(false)

	-- Spring physics for cartoon scale bounce
	local scaleSpring = Spring(Computed(function()
		if isPressed:get() then
			return 0.95
		elseif isHovered:get() then
			return 1.05
		end
		return 1.0
	end), 30, 0.5)

	return New "TextButton" {
		Name = props.Name or "Button",
		Size = props.Size or UDim2.new(1, 0, 0, 44),
		Position = props.Position or UDim2.new(0, 0, 0, 0),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		BackgroundColor3 = props.BackgroundColor3 or Color3.fromRGB(0, 170, 255),
		Font = Enum.Font.FredokaOne,
		Text = props.Text or "BUTTON",
		TextColor3 = props.TextColor3 or Color3.fromRGB(255, 255, 255),
		TextSize = props.TextSize or 16,
		AutoButtonColor = false,

		[OnEvent "MouseEnter"] = function()
			isHovered:set(true)
		end,
		[OnEvent "MouseLeave"] = function()
			isHovered:set(false)
			isPressed:set(false)
		end,
		[OnEvent "MouseButton1Down"] = function()
			isPressed:set(true)
		end,
		[OnEvent "MouseButton1Up"] = function()
			isPressed:set(false)
		end,
		[OnEvent "MouseButton1Click"] = function()
			if props.OnClick then
				props.OnClick()
			end
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, props.CornerRadius or 10),
			},
			New "UIStroke" {
				Thickness = 2.5,
				Color = props.StrokeColor or Color3.fromRGB(20, 25, 40),
			},
			New "UIScale" {
				Scale = scaleSpring,
			},
		},
	}
end

return Button