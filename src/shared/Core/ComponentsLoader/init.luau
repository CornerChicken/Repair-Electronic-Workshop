--!strict
--[[
    Load roblox instance tags inside of CollectionService
]]

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage.Packages
local jecs = require(Packages.jecs)

local ComponentsList = require("../../Shared/Components/ComponentsList")

local _createEntity = require("@self/_createEntity")

type World = jecs.World
type ComponentsListType = ComponentsList.ComponentsListType

local COLLECTION_TAGS = require("../Data/CollectionTags")

local runtimeType: "server" | "client"

local function ComponentsLoader(world: World, components: ComponentsListType)
    -- Figure out if this is being used by server or client
    if RunService:IsServer() then
        runtimeType = "server"
    elseif RunService:IsClient() then
        runtimeType = "client"
    end

    -- Loop through existing game instances with allowed tags
    for _, tag in ipairs(COLLECTION_TAGS) do
        local taggedItems = CollectionService:GetTagged(tag)
        for _, item: Instance in ipairs(taggedItems) do
            _createEntity(world, components, tag, item, runtimeType)
        end

         -- Add new tags when instances are tagged during runtime
        CollectionService:GetInstanceAddedSignal(tag):connect(function(item)
            _createEntity(world, components, tag, item, runtimeType)
        end)

        -- Remove entities when instances are removed form the game
        --  (we are assuming that all all tagged based entities require instances
        CollectionService:GetInstanceRemovedSignal(tag):connect(function(item)
            if runtimeType == "server" then
                local serverId = item:GetAttribute("serverId")
                if serverId ~= nil then
                    -- Delete all components attached to entity
                    world:delete(serverId)
                end
            elseif runtimeType == "client" then
                local clientId = item:GetAttribute("clientId")
                if clientId ~= nil then
                    -- Delete all components attached to entity
                    world:delete(clientId)
                end
            end
        end)
    end
end

return ComponentsLoader