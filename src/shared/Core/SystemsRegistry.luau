--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Jecs = require(Packages.jecs)

export type SystemsMap = { [string]: (World) -> () }
export type World = Jecs.World

-- Place all system requires here
local Systems: SystemsMap = {
    -- test = TestSystem
}

return Systems