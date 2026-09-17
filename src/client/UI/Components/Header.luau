--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)

local Children = Fusion.Children
local Child = Fusion.Child

local HEADER_ROTATION = 90
local HEADER_TEXTLABEL_POSITION = UDim2.fromScale(0.029, 0)
local HEADER_TEXTLABEL_SIZE = UDim2.fromScale(0.912, 1)

local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local TEXT_SIZE = 24
local TEXT_FONT = Font.fromEnum(Enum.Font.FredokaOne)

type Scope = Fusion.Scope<any>
type UsedAs<T> = Fusion.UsedAs<T>

local function Header(
    scope: Scope,
    props: {
        Gradient: UsedAs<ColorSequence>?,
        Size: UsedAs<UDim2>?,
        Text: UsedAs<string>?
    }
): Fusion.Child

	return scope:New "Frame" {
		Name = "Header",
            Size = props.Size,

            [Children] = Child {
                scope:New "UICorner" { CornerRadius = UDim.new(0, 16) },
                scope:New "UIGradient" {
                    Color = props.Gradient,
                    Rotation = HEADER_ROTATION,
                },
                scope:New "TextLabel" {
                    Name = "HeaderText",
                    BackgroundTransparency = 1,
                    Position = HEADER_TEXTLABEL_POSITION,
                    Size = HEADER_TEXTLABEL_SIZE,

                    Text = props.Text,
                    FontFace = TEXT_FONT,
                    TextColor3 = TEXT_COLOR,
                    TextSize = TEXT_SIZE,
                    TextXAlignment = Enum.TextXAlignment.Left,

                    [Children] = Child {
                        scope:New "UIStroke" {
                            Color = Color3.fromRGB(120, 60, 0),
                            Thickness = 2,
                        }
                    }
                }
        }
	}
end

return Header