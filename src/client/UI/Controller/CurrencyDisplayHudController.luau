--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages

local jecs = require(Packages.jecs)

local Fusion = require(Packages.Fusion)
local scoped = Fusion.scoped

local components = require(ReplicatedStorage.Shared.Components.ComponentsList)

local CurrencyDisplayState = require("../State/CurrencyDisplayState")
local CurrencyDisplayHud = require("../View//CurrencyDisplayHud")

-- Components
local CurrencyDisplay = require("../Components/CurrencyDisplay")

type World = jecs.World
type Entity = jecs.Entity<any>

local CurrencyDisplayHudController = {}

function CurrencyDisplayHudController.Init(world: World)
	-- Create scope
	local scope = scoped(Fusion, {
		CurrencyDisplay = CurrencyDisplay
	})

	-- Create state
	CurrencyDisplayState.init(scope)

	-- Mount Fusion UI to PlayerGui
    task.spawn(function()
        local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
        local guiInstance = CurrencyDisplayHud(scope)
        guiInstance.Parent = playerGui
    end)

	-- System function run inside your client scheduler step
	local function updateCash(value)
		print(value)
		CurrencyDisplayState.Currencies.Cash:set(value)
	end

	world:added(components.Cash, function(entityId: Entity, _cashId, value)
		if world:has(entityId, components.Player) then
			local player = world:get(entityId, components.Player)
			if player == Players.LocalPlayer then
				updateCash(value)
			end
		end
	end)

	world:changed(components.Cash, function(entityId, _cashId, value)
		if world:has(entityId, components.Player) then
			local player = world:get(entityId, components.Player)
			if player == Players.LocalPlayer then
				updateCash(value)
			end
		end
	end)
	
	--[[
    return function()
		for entity, inventoryComponent in world:query() do
			-- Sync Jecs data directly to the Fusion state object
			InventoryState.InventoryData:set(inventoryComponent.Items)
		end
	end
    ]]
end

return CurrencyDisplayHudController