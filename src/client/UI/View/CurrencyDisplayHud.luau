--!strict
local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
local CurrencyDisplayState = require("../State/CurrencyDisplayState")

local Children = Fusion.Children

type Scope = Fusion.Scope<any>

local function CurrencyDisplayHud(scope: Fusion.Scope<any>)
	return scope:New "ScreenGui" {
		Name = "CurrencyDisplayHud",
		ResetOnSpawn = false,
		
        [Children] = {
            scope:New "UIAspectRatioConstraint" {},

            scope:New "Frame" {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(1, 0.5),
                Size = UDim2.fromScale(0.144, 0.066),
                BackgroundTransparency = 1,

                [Children] = {
                    scope:CurrencyDisplay {
                        Image = "rbxassetid://93215845935171",
                        Balance = scope:Computed(function(use)
                            return use(CurrencyDisplayState.Currencies.Cash)
                        end),
                        TextColor = Color3.fromRGB(236, 201, 63)
                    }
                }
            }
        }
	}
end

return CurrencyDisplayHud