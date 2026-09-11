--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)
local ByteNet = require(Packages.bytenet)

local world = require(ReplicatedStorage.Shared.Core.world)
local Network = require(ReplicatedStorage.Shared.Core.Network)

local ComponentRegistry = require(ReplicatedStorage.Shared.Components.ComponentRegistry)

const REPLICATED_COMPONENTS = require(ReplicatedStorage.Shared.Components.ReplicatedComponents)
const COMPONENT_SCHEMAS = require(ReplicatedStorage.Shared.Components.ComponentSchemas)


local pendingChanges = {} :: { [jecs.Id]: { [jecs.Id]: any } }

-- Allow initialize function to run only once
local hooksInitialized = false

local function queueChange(componentsId: jecs.Id, entityId: jecs.Id)
    if not pendingChanges[entityId] then
        pendingChanges[entityId] = {}
    end

    pendingChanges[entityId][componentsId] = world:get(entityId, componentsId)
end

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

    local packetPayload = {} :: any

    for entityId, componentsMap in pendingChanges do
        local entityChanges = {}

        for jecsCompId, rawValue in componentsMap do
            local netId = ComponentRegistry.JecsToNetId[jecsCompId :: any]
            if not netId then continue end -- Skip non-replicated components

            local isRemoved = (rawValue == nil)

            table.insert(entityChanges, {
                netCompId = netId,
                isRemoved = isRemoved,
                value = if not isRemoved then rawValue else nil,
            })
        end

        if #entityChanges > 0 then
            table.insert(packetPayload, {
                entityId = entityId,
                changes = entityChanges,
            })
        end
    end

    print(packetPayload)

    -- Send all changes across the entire world in ONE buffer packet
    if #packetPayload > 0 then
        Network.WorldReplicationPacket.sendToAll(packetPayload)
    end

    -- Send `pendingChanges` to clients using your RemoteEvent/Buffer here
    print("Sending changes: ", pendingChanges)

    -- Clear the queue for the next frame
    table.clear(pendingChanges)
end

return serverReplication