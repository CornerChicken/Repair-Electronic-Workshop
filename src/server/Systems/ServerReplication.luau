--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local world = require(ReplicatedStorage.Shared.Core.world)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

const REPLICATED_COMPONENTS = require(ReplicatedStorage.Shared.Data.ReplicatedComponents)

local pendingChanges = {} :: { [jecs.Id]: { [jecs.Id]: any } }

local function queueChange(componentsId: jecs.Id, entityId: jecs.Id)
    if not pendingChanges[entityId] then
        pendingChanges[entityId] = {}
    end

    pendingChanges[entityId][componentsId] = world:get(entityId, componentsId)
end

local hooksInitialized = false
local function initializeHooks()
    if hooksInitialized then return end
    hooksInitialized = true

    for _, componentId in REPLICATED_COMPONENTS do
        -- Jecs automatically passes the entityId that got the component
        world:added(componentId, function(entityId)
            queueChange(componentId, entityId)
        end)

        world:changed(componentId, function(entityId)
            queueChange(componentId, entityId)
        end)

        world:removed(componentId, function(entityId)
            -- world:get returns nil when removed, which is perfect for telling the client to delete it
            queueChange(componentId, entityId) 
        end)
    end
end

local function serverReplication()
    -- Buffer of all data to be sent across the remote event
    -- Ensure global listeners are set up (runs only once)
    initializeHooks()

    -- Check if we have anything to send this frame
    if next(pendingChanges) == nil then return end 

    -- Send `pendingChanges` to clients using your RemoteEvent/Buffer here
    print("Sending changes: ", pendingChanges)

    -- Clear the queue for the next frame
    table.clear(pendingChanges)
end

return serverReplication