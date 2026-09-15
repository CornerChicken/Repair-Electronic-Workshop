local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local replecs = require(Packages.replecs)
local world = require("./world")

return replecs.create(world)