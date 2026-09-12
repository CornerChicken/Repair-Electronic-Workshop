--!strict
--[[
    Create and return the remote events needed to send information from the server
    to the client.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkingTypes = require("./NetworkingTypes")

local RemotesFolder = ReplicatedStorage.Remotes

-- We want to create a type for the roblox RemoteEvents, but only expose the functions
-- Furthermore, we want this to both represent "reliable" or "unreliable" remote types
-- We can just copy the functions from the roblox RemoteEvent objects
type Remote<T...> = {
    FireAllClients: (Remote<T...>, T...) -> (),
    FireClient: (Remote<T...>, Player, T...) -> (),
    FireServer: (Remote<T...>, T...) -> (),
    OnClientEvent: RBXScriptSignal<T...>,
    OnServerEvent: RBXScriptSignal<(Player, T...)>
}

type Snapshot = NetworkingTypes.Snapshot

-- Ensure that we have the remote event in the remotes folder
local function streamEnsure(name: string)
    local remote = RemotesFolder:FindFirstChild(name)
    if not remote then
        remote = Instance.new("RemoteEvent")
        remote.Name = name
        remote.Parent = RemotesFolder
    end
    return remote
end

-- Ensure that we have our unreliable event in the remotes folder
local function datagramEnsure(name: string)
    local remote = RemotesFolder:FindFirstChild(name)
    if not remote then
        remote = Instance.new("UnreliableRemoteEvent")
        remote.Name = name
        remote.Parent = RemotesFolder
    end
    return remote
end

return {
    input = datagramEnsure("Input") :: Remote<string>,
    replication = streamEnsure("Replication") :: Remote<Snapshot>
}