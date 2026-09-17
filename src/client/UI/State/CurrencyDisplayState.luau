local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)

local CurrencyDisplayState = {} :: any

local START_CASH = 0

function CurrencyDisplayState.init(scope: Fusion.Scope<any>)
	CurrencyDisplayState.Currencies = {
        Cash = scope:Value(START_CASH)
    }
end

return CurrencyDisplayState