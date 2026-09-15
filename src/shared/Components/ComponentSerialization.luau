--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local replecs = require(Packages.replecs)

local world = require(ReplicatedStorage.Shared.Core.world)
local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

type Data = {
    can_serialize: number,
    cannot_serialize: Instance,
}

type SerdesTable = {
    serialize: (value: any) -> buffer,
    deserialize: (buf: buffer) -> any,

    bytespan: number?,
    includes_variants: boolean?,
}

local ComponentSer: { [string]: SerdesTable } = {
    Cash = {
        serialize = function(value: number)
            local buf = buffer.create(8)
            buffer.writef64(buf, 0, value)
            print(buf)
            return buf
        end,
        deserialize = function(buf: buffer)
            local cash = buffer.readf64(buf, 0)
            return cash
        end,
        bytespan = 8,
    }
}

-- Load serialization tables
do
    for name, serdesTable in ComponentSer do
        world:set(components[name], replecs.serdes, serdesTable)
    end
end

return ComponentSer