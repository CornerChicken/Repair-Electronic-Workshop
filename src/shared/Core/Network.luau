--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local ByteNet = require(Packages.bytenet)

return ByteNet.defineNamespace("Replication", function()
	return {
    WorldReplicationPacket = ByteNet.definePacket({
        value = ByteNet.array(ByteNet.struct({
            entityId = ByteNet.uint16,
            isDespawned = ByteNet.bool,
            changes = ByteNet.array(ByteNet.struct({
                netCompId = ByteNet.uint8,
                isRemoved = ByteNet.bool,
                value = ByteNet.unknown,
            })),
        })),
        reliabilityType = "unreliable", -- UDP for low-latency batch updates
    })
}
end)