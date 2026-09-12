--!strict
local components = require("./ComponentsList")

local REPLICATED_COMPONENTS = require("./ReplicatedComponents")

local Serializers = require("./ComponentSchemas")


-- Alphabetically sort component names for deterministic Network IDs on Client & Server
local sortedNames = {}
for name in REPLICATED_COMPONENTS do
    table.insert(sortedNames, name)
end
table.sort(sortedNames)

local JecsToNetId: { [number]: number } = {}
local NetIdToJecs: { [number]: number } = {}
local NetIdSerializers: { [number]: any? } = {}

for netId, name in sortedNames do
    local jecsId = components[name]
    JecsToNetId[jecsId] = netId
    NetIdToJecs[netId] = jecsId
    NetIdSerializers[netId] = Serializers[name]
end

return {
    JecsToNetId = JecsToNetId,
    NetIdToJecs = NetIdToJecs,
    NetIdSerializers = NetIdSerializers,
}