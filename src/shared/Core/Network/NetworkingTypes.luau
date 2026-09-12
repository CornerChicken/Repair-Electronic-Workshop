--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

export type Snapshot = {
    [string]: {
        set: { jecs.Entity<any> }?,
        values: { any }?,
        removed: { jecs.Entity<any> }?,
        pair: { false },
    }
}

return {}