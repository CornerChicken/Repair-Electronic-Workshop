--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Jecs = require(Packages.jecs)

type World = Jecs.World

local function ComponentsTags(world: World)
    local list = {
        ElectronicPart = Jecs.tag(),
        Screwdriver = Jecs.tag(),
        Cable = Jecs.tag(),
        Cloth = Jecs.tag(),
        Tools = Jecs.tag(),
        Workshop = Jecs.tag()
    }

    return list
end

return ComponentsTags