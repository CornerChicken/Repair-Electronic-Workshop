--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local ByteNet = require(Packages.bytenet)

local Schemas = {
	Owner = ByteNet.string
}

return Schemas