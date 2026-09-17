local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local Fusion = require(Packages.Fusion)
local Children = Fusion.Children

type Scope = Fusion.Scope<any>
type UsedAs<T> = Fusion.UsedAs<T>

local LABEL_FONT = Font.fromEnum(Enum.Font.FredokaOne)
local MAX_TEXT_SIZE = 50

local function TabButton(
    scope: Scope,
    props: {
        Image: UsedAs<string>,
        Balance: UsedAs<number>,
        TextColor: UsedAs<Color3>,
    }
): Fusion.Child
	return scope:New "Frame" {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,

        [Children] = {
            scope:New "ImageLabel" {
                Name = "CurrencyIcon",
                Size = UDim2.fromScale(0.25, 1),
                BackgroundTransparency = 1,
                Image = props.Image,
            },
            scope:New "TextLabel" {
                Name = "DisplayLabel",
                Position = UDim2.fromScale(0.33, 0),
                Size = UDim2.fromScale(0.667, 1),
                BackgroundTransparency = 1,

                FontFace = LABEL_FONT,
                TextColor3 = props.TextColor,
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,

                Text = scope:Computed(function(use)
                    return `${tostring(use(props.Balance))}`
                end),

                [Children] = {
                    scope:New "UITextSizeConstraint" {
                        MaxTextSize = MAX_TEXT_SIZE
                    }
                }
            }
        }
    }
end

return TabButton