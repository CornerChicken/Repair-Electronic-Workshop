--!strict
local GlobalTypes = require("./GlobalTypes")

type Rarity = GlobalTypes.Rarity

local RarityWeights = {
    Common = 500000, -- 50%
    Uncommon = 250000, -- 25%
    Rare = 120000, -- 12%
    Epic = 70000, -- 7%
    Legendary = 35000, -- 3.5%
    Mythical = 15000, -- 1.5%
    Quantum = 7000, -- 0.7%
    Supernatural = 2000, -- 0.2%
    Cosmic = 700, -- 0.07%
    Singularity = 250, -- 0.025%
    Omega = 50, -- 0.005%

} :: { [Rarity]: number }

return table.freeze(RarityWeights)