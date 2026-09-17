--!strict
--[[
    Create display GUI
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CurrencyDisplayHudController = require("../UI/Controller/CurrencyDisplayHudController")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local Phase = Planck.Phase

local function currencyDisplayHudController(world)
    CurrencyDisplayHudController.Init(world)
end

return {
    system = currencyDisplayHudController,
    phase = Phase.PostStartup
}