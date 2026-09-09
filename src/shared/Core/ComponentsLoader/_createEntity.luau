local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

type World = jecs.World

local pair = jecs.pair

local function _createEntity(world: World, components, tag: string, item: Instance, runtimeType: "server" | "client")
    local newEntity = world:entity()
    world:set(newEntity, components.Instance, item)
    world:add(newEntity, components[tag])
    -- Remove entities when instances are removed form the game
    --  (we are assuming that all all tagged based entities require instances
    world:add(newEntity, pair(jecs.OnDelete, jecs.Delete))
            
     if runtimeType == "server" then
        item:SetAttribute("serverId", newEntity)
     elseif runtimeType == "client" then
        item:SetAttribute("clientId", newEntity)
    end
end

return _createEntity