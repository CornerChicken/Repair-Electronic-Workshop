--!strict

type ELECTRONICS = "OldConsole"

export type Item = {
    name: string,
    ref: Model,
    cost: number
}

export type GameState = {
    timeOfDay: number,
    dayCounter: number
}

export type WealthStatus = "Normal" | "Rich"

export type BrokenElectronic = {
    electronicType: ELECTRONICS,
    brokenParts: { string }
}

local ComponentsTypes = {}

return ComponentsTypes