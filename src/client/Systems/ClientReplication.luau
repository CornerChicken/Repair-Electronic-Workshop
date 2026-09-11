--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local Network = require(ReplicatedStorage.Shared.Core.Network)
local ComponentRegistry = require(ReplicatedStorage.Shared.Components.ComponentRegistry)

local world = require(ReplicatedStorage.Shared.Core.world)

local ServerToClientEntity = {}

local function getClientEntity(serverEntityId: jecs.Id | number): number
    if not ServerToClientEntity[serverEntityId] then
        ServerToClientEntity[serverEntityId] = world:entity()
        world:add(ServerToClientEntity[serverEntityId], jecs.pair(jecs.OnDelete, jecs.Delete))
    end

    return ServerToClientEntity[serverEntityId]
end

Network.WorldReplicationPacket.listen(function(entitiesList)
    for _, entityData in entitiesList do
        if entityData.isDespawned then
            print("[CLIENT]: DESPAWNING!")
            local clientEntity = ServerToClientEntity[entityData.entityId]
            if clientEntity then
                world:delete(clientEntity) -- Cleans up entity and ALL components in Jecs
                ServerToClientEntity[entityData.entityId] = nil
            end
            continue
        end

        local clientEntity = getClientEntity(entityData.entityId)

        for _, change in entityData.changes do
            local clientJecsId = ComponentRegistry.NetIdToJecs[change.netCompId]
            if not clientJecsId then continue end

            if change.isRemoved then
                world:remove(clientEntity, clientJecsId)
            else
                if change.value == nil then
                    world:set(clientEntity, clientJecsId) -- Tag
                else
                    world:set(clientEntity, clientJecsId, change.value) -- Data Component
                end
            end
        end
    end
end)

local function clientReplication()
    return
end

return clientReplication