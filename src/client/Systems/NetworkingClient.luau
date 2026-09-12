--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local Utilities = ReplicatedStorage.Shared.Utilities
local collect = require(Utilities.collect)

local remotes = require(ReplicatedStorage.Shared.Core.Network.NetworkingRemotes)

type Entity = jecs.Entity<any>

-- this is just an example, you need an actually populated map
local components: { [string]: jecs.Id } = {}

local clientIds: {[Entity]: jecs.Entity<nil> } = {}

local function ecsEnsureEntity(world: jecs.World, id: Entity)
	local e = 0 :: any

	local serverId = id
    -- Convert serverId into clientId
	local deserializedId = clientIds[serverId]

    -- If the clientId doesn't exist, create a new one
	if deserializedId then
		if deserializedId == 0::any then
			local newId = world:entity()
			clientIds[serverId] = newId
			deserializedId = newId
		end
	else
        -- Check if current clientId = serverId is occupied on clieant
        -- Secondly, check if the entity does exist with the right component but is missing a name
		if not world:exists(serverId)
			or (world:contains(serverId) and not world:get(serverId, jecs.Name))
		then
            -- If so, make a new entity
			deserializedId = world:entity()
		else
			if world:contains(serverId) and world:get(serverId, jecs.Name) then
				deserializedId = serverId
			else
				deserializedId = world:entity()
			end
		end
        -- In summary, only create a new entity if there isn't an existing one

        -- Updated serverId -> clientId table
		clientIds[serverId] = deserializedId
	end

    -- Return the clientId
	e = deserializedId :: Entity 
	return e
end

-- local rel_render = `e{jecs.ECS_ID(rel)}v{jecs.ECS_GENERATION(rel)}`
-- local tgt_render = `e{jecs.ECS_ID(tgt)}v{jecs.ECS_GENERATION(tgt)}`
-- local function ecs_deser_pairs_str(world, token)
-- 	local tokens = string.split(token, ",")
-- 	local rel = tonumber(tokens[1]) :: jecs.Entity
-- 	local tgt = tonumber(tokens[2]) :: jecs.Entity

-- 	rel = ecs_ensure_entity(world, rel)
--
-- 	tgt = ecs_ensure_entity(world, tgt)

-- 	return jecs.pair(rel, tgt)
-- end

-- Collect actively updates the snapshot table per frame when the replication event fires
local snapshots = collect(remotes.replication.OnClientEvent)

return function(world: jecs.World)
    -- If a component in the client world is tagged with a Destroy, then destroy
	for entity in world:each(components.Destroy) do
		clientIds[entity] = nil
	end

    -- Loop through our snapshots of transmitted data
    for snapshot in snapshots do
        -- Loop through the snapshot dictionary, with serverId, map
        for serverId, map in snapshot do
            -- Reconvert serverId into a numbers
        	local id = (tonumber(serverId) :: any) :: Entity
            -- Check if entity is a pair or not and deserialize (convert into clientId)
            id = ecsEnsureEntity(world, id)
            -- if not id then
            --    	id = ecs_deser_pairs_str(world, ser_id)
            -- else
            --    	id = ecs_ensure_entity(world, id)
            -- end

            -- Check client for a component of NetworkedMembers
            local members = world:get(id, components.NetworkedMembers)

            -- Get entities to update
            local set = map.set
            if set then
                if jecs.is_tag(world, id) then
                   	for _, entity in set do
                        -- Get the entityId on the client
                       	entity = ecsEnsureEntity(world, entity)
                  		world:add(entity, id)
                   	end
                else
	                local values = map.values :: { any }
                    -- Loop through entities
	                for i, entity in set do
						entity = ecsEnsureEntity(world, entity)
                        -- Map entity value position to entity position in table
						local value = values[i]
						if members then
							for _, member in members do
								local data = value[member] :: { Entity } | Entity -- targets
								if typeof(data) == "table" then
									for pos, tgt in data :: { Entity } do
										data[pos] = ecsEnsureEntity(world, tgt)
									end
								else
									value[member] = ecsEnsureEntity(world, id)(world, data :: any)
								end
							end
						end
						world:set(entity, id, value)
                   	end
			    end
            end

            local removed = map.removed

            -- Handle removed entities
            if removed then
                for _, entity in removed do
                    -- Get entity and remove
                    entity = ecsEnsureEntity(world, entity)
                    world:remove(entity, id)
                end
            end
        end
    end
end

