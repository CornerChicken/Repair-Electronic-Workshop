--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local REPLICATED_COMPONENTS = {
    Owner = components.Owner
} :: { [string]: jecs.Id }

return REPLICATED_COMPONENTS