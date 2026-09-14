--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Planck = require(Packages.Planck)

local world = require("./world")

local Scheduler = Planck.Scheduler
local onEvent = Planck.onEvent

local PlanckJabby = require(Packages.PlanckJabby)
local jabbyPlugin = PlanckJabby.new()

local PlanckRunService = require(Packages.PlanckRunService)
local runServicePlugin = PlanckRunService.Plugin

local scheduler = Scheduler.new(world)
    :addPlugin(jabbyPlugin)
    :addPlugin(runServicePlugin)

return scheduler

