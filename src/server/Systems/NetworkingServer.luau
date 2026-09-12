--!strict
--[[
    This script will handle replicatating data to the players, so that they can also read
    entity data.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local Utilities = ReplicatedStorage.Shared.Utilities
local collect = require(Utilities.collect)

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local NetworkingTypes = require(ReplicatedStorage.Shared.Core.Network.NetworkingTypes)
local Remotes = require(ReplicatedStorage.Shared.Core.Network.NetworkingRemotes)

type World = jecs.World
type Entity = jecs.Entity<any>

type Snapshot = NetworkingTypes.Snapshot

local REPLICATED_COMPONENTS = require(ReplicatedStorage.Shared.Components.ReplicatedComponents)

local function networkingSend(world: World)
	-- Load replicated components
    for _, repComponent in REPLICATED_COMPONENTS do
        local componentId = components[repComponent]
        assert(componentId, "[ERROR] Component not found: " .. repComponent)
        
        world:add(componentId, components.Networked)
    end


    local storages = {} :: { [Entity]: { [Entity]: any } }
    local networkedComponents = {} :: { Entity }

    -- Look through entities with the Networked component
    for component in world:each(components.Networked) do
        -- Retrieve the name of the component
        local name = world:get(component, jecs.Name)

        -- Error if invalid component
		if components[name] == nil then
			error("Invalid component:" .. tostring(name))
		end

        -- Create an empty table in the storage variable for the component
        storages[component] = {}

        -- Add the component to the list of networked components
        table.insert(networkedComponents, component)
    end

    for _, component in networkedComponents do
        -- Retrieve networked component name
		local name = world:get(component, jecs.Name)
		if not name or not components[name] then
			error(`Networked Component (%id{component}%name{name})`)
		end

        -- Determine if the component is a tag
		local is_tag = jecs.is_tag(world, component)

         -- Get the storage container for the component
		local storage = storages[component]

        -- Create signals for added and changed events, which map the entity id to the value
		if is_tag then
			world:added(component, function(entity)
				storage[entity] = true
			end)
		else
			world:added(component, function(entity, _, value)
				storage[entity] = value
			end)
			world:changed(component, function(entity, _, value)
				storage[entity] = value
			end)
		end

        -- Tell the client to remove entity
        world:removed(component, function(entity)
            storage[entity] = "jecs.Remove"
		end)
    end

    -- Connect to playersAdded event, when references will always have updated list of new players
    local playersAdded = collect(Players.PlayerAdded)

    return function()
        local snapshotTemplate
        local setIdsTemplate: { Entity }
    
        -- In the future maybe it should be requested by the player instead when they
        -- are ready to receive the replication. Otherwise streaming could be complicated
        -- with intances references being nil.}

         -- Loop through list of new players since last frame to update them
        for player in playersAdded do
            if not snapshotTemplate then
                snapshotTemplate, setIdsTemplate = {} :: Snapshot, {}

                -- Look through the storage and create a template for all new players who join
				for component in storages do
                    local setValues = {}
					local setN = 0

                    -- Query for the components (Creates List)
					local q = world:query(component)
					local is_tag = jecs.is_tag(world, component)
					for _, archetype in q:archetypes() do
						local entities = archetype.entities
						local entities_len = #entities
                        -- Copy all of the entities into the template of ids
						table.move(entities, 1, entities_len, setN + 1, setIdsTemplate)
                        -- Copy all of the the entityIds into the set_values[] if its not a tag
						if not is_tag then
							local column = archetype.columns_map[component]
							table.move(column, 1, entities_len, setN + 1, setValues)
						end

                        -- Update the new length fo the table
						setN += entities_len
					end

                    -- Copy the template into this set table
					local set = table.move(setIdsTemplate, 1, setN, 1, table.create(setN))

                    -- Create a map that puts set to the table, or nil if it doesn't exist
					local map = {
	                    set = if setN > 0 then set else nil,
	                    values = if setN > 0 then setValues else nil,
	                } :: any

                    -- Create template snapshot (tostring because only string dictionaries can be sent to the client)
                    
				   	snapshotTemplate[tostring(component)] = map
                end
            end

            -- Send the template to the client
            Remotes.replication:FireClient(player, snapshotTemplate)
        end

        local snapshot = {} :: Snapshot
        local setIds = {}
        local removedIds = {}

        -- Go through all component entities with component
        for component, storage in storages do
		    local setValues = {} :: { any }
		    local setN = 0
		    local removedN = 0
			local componentIsTag = jecs.is_tag(world, component)


		    for e, v in storage do
		        if v ~= "jecs.Remove" then
                    -- Assign Ids and values: 2x2 array
		            setN += 1
		            setIds[setN] = e
		            setValues[setN] = if componentIsTag then 0 else v
		        else
                    -- Added id of entity to be removed
		            removedN += 1
		            removedIds[removedN] = e
		        end
		    end

            -- Reset the storage
		    table.clear(storage)

            local dirty = false

            -- Only send remote event if there are updates to be sent to the client
            if setN > 0 or removedN > 0 then
            	dirty = true
            end

            if dirty then
                -- Copy removed ids to a table
            	local removed = table.move(removedIds, 1, removedN, 1, {}) :: { Entity }
                -- Copy dry ids to a table
             	local set = table.move(setIds, 1, setN, 1, {}) :: { Entity }

              	-- local ser_id: string = nil :: any

				-- if jecs.IS_PAIR(component) then
				-- 	ser_id = `{jecs.pair_first(world, component)},{jecs.pair_second(world, component)}`
				-- else
				-- 	ser_id = tostring(component)
				-- end

                -- Create map
				local map = {
                    set = if setN > 0 then set else nil,
                    values = if setN > 0 then setValues else nil,
                    removed = if removedN > 0 then removed else nil,
                }

				if jecs.IS_PAIR(component) then
					map.relation = jecs.pair_first(world, component)
					map.target = jecs.pair_second(world, component)
					map.pair = true
				end

				snapshot[tostring(component)] = map :: any
	        end
        end

        -- Check if table has at least 1 item
        if next(snapshot) ~= nil then
        	Remotes.replication:FireAllClients(snapshot)
			--print(snapshot)
        end
    end  
end

return networkingSend