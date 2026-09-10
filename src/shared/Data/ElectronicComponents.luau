--[[
Components:
CPU
GPU
RAM
HDD
SSD
Motherboard

]]

local globalTypes = require("./GlobalTypes")

type Rarity = globalTypes.Rarity

type ElectronicComponent = {
    rarity: Rarity,
    cost: number,
    value: number
}

local ELECTRONIC_COMPONENTS = {
    CPU = {
        Rusty = {
            rarity = "Common",
            cost = 5,
            value = 7
        },
        Faulty = {
            rarity = "Common",
            cost = 25,
            value = 30
        },
        Old = {
            rarity = "Common",
            cost = 50,
            value = 70
        },
        Refurbished = {
            rarity = "Common",
            cost = 100,
            value = 150
        },

        New = {
            rarity = "Uncommon",
            cost = 300,
            value = 450
        },
        Polished = {
            rarity = "Uncommon",
            cost = 500,
            value = 700
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 850,
            value = 1200
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 1500,
            value = 2000
        },

        Pristine = {
            rarity = "Rare",
            cost = 4500,
            value = 5500
        },
        Deluxe = {
            rarity = "Rare",
            cost = 6800,
            value = 8000
        },
        Charged = {
            rarity = "Rare",
            cost = 10000,
            value = 14000
        },
        Supercharged = {
            rarity = "Rare",
            cost = 16000,
            value = 22000
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 26000,
            value = 36000
        },
        Industrial = {
            rarity = "Epic",
            cost = 42000,
            value = 58000
        },
        Prototype = {
            rarity = "Epic",
            cost = 70000,
            value = 95000
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 115000,
            value = 155000
        },

        Experimental = {
            rarity = "Legendary",
            cost = 190000,
            value = 260000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 310000,
            value = 420000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 500000,
            value = 680000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 820000,
            value = 1100000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 1350000,
            value = 1800000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 2200000,
            value = 3000000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 3600000,
            value = 4900000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 5900000,
            value = 8000000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 9800000,
            value = 13200000
        },
        Astral = {
            rarity = "Quantum",
            cost = 16000000,
            value = 21500000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 26000000,
            value = 35000000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 43000000,
            value = 58000000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 71000000,
            value = 96000000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 115000000,
            value = 155000000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 190000000,
            value = 255000000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 310000000,
            value = 420000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 510000000,
            value = 690000000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 840000000,
            value = 1130000000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 1380000000,
            value = 1860000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 2280000000,
            value = 3080000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 3750000000,
            value = 5060000000
        },
        Void = {
            rarity = "Singularity",
            cost = 6180000000,
            value = 8340000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 10200000000,
            value = 13770000000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 16800000000,
            value = 22680000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 27700000000,
            value = 37400000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 45700000000,
            value = 61700000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 75400000000,
            value = 101800000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 124400000000,
            value = 167900000000
        }
    },

    GPU = {
        Rusty = {
            rarity = "Common",
            cost = 7,
            value = 10
        },
        Faulty = {
            rarity = "Common",
            cost = 35,
            value = 42
        },
        Old = {
            rarity = "Common",
            cost = 70,
            value = 98
        },
        Refurbished = {
            rarity = "Common",
            cost = 140,
            value = 210
        },

        New = {
            rarity = "Uncommon",
            cost = 420,
            value = 630
        },
        Polished = {
            rarity = "Uncommon",
            cost = 700,
            value = 980
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 1200,
            value = 1680
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 2100,
            value = 2800
        },

        Pristine = {
            rarity = "Rare",
            cost = 6300,
            value = 7700
        },
        Deluxe = {
            rarity = "Rare",
            cost = 9500,
            value = 11200
        },
        Charged = {
            rarity = "Rare",
            cost = 14000,
            value = 19600
        },
        Supercharged = {
            rarity = "Rare",
            cost = 22400,
            value = 30800
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 36400,
            value = 50400
        },
        Industrial = {
            rarity = "Epic",
            cost = 58800,
            value = 81200
        },
        Prototype = {
            rarity = "Epic",
            cost = 98000,
            value = 133000
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 161000,
            value = 217000
        },

        Experimental = {
            rarity = "Legendary",
            cost = 266000,
            value = 364000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 434000,
            value = 588000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 700000,
            value = 952000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 1148000,
            value = 1540000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 1890000,
            value = 2520000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 3080000,
            value = 4200000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 5040000,
            value = 6860000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 8260000,
            value = 11200000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 13720000,
            value = 18480000
        },
        Astral = {
            rarity = "Quantum",
            cost = 22400000,
            value = 30100000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 36400000,
            value = 49000000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 60200000,
            value = 81200000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 99400000,
            value = 134400000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 161000000,
            value = 217000000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 266000000,
            value = 357000000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 434000000,
            value = 588000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 714000000,
            value = 966000000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 1176000000,
            value = 1582000000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 1932000000,
            value = 2604000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 3192000000,
            value = 4312000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 5250000000,
            value = 7084000000
        },
        Void = {
            rarity = "Singularity",
            cost = 8652000000,
            value = 11676000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 14280000000,
            value = 19278000000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 23520000000,
            value = 31752000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 38780000000,
            value = 52360000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 63980000000,
            value = 86380000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 105560000000,
            value = 142520000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 174160000000,
            value = 235060000000
        }
    },

    RAM = {
        Rusty = {
            rarity = "Common",
            cost = 2,
            value = 2
        },
        Faulty = {
            rarity = "Common",
            cost = 8,
            value = 10
        },
        Old = {
            rarity = "Common",
            cost = 15,
            value = 22
        },
        Refurbished = {
            rarity = "Common",
            cost = 30,
            value = 45
        },

        New = {
            rarity = "Uncommon",
            cost = 90,
            value = 135
        },
        Polished = {
            rarity = "Uncommon",
            cost = 150,
            value = 210
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 255,
            value = 360
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 450,
            value = 600
        },

        Pristine = {
            rarity = "Rare",
            cost = 1350,
            value = 1650
        },
        Deluxe = {
            rarity = "Rare",
            cost = 2040,
            value = 2400
        },
        Charged = {
            rarity = "Rare",
            cost = 3000,
            value = 4200
        },
        Supercharged = {
            rarity = "Rare",
            cost = 4800,
            value = 6600
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 7800,
            value = 10800
        },
        Industrial = {
            rarity = "Epic",
            cost = 12600,
            value = 17400
        },
        Prototype = {
            rarity = "Epic",
            cost = 21000,
            value = 28500
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 34500,
            value = 46500
        },

        Experimental = {
            rarity = "Legendary",
            cost = 57000,
            value = 78000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 93000,
            value = 126000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 150000,
            value = 204000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 246000,
            value = 330000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 405000,
            value = 540000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 660000,
            value = 900000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 1080000,
            value = 1470000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 1770000,
            value = 2400000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 2940000,
            value = 3960000
        },
        Astral = {
            rarity = "Quantum",
            cost = 4800000,
            value = 6450000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 7800000,
            value = 10500000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 12900000,
            value = 17400000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 21300000,
            value = 28800000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 34500000,
            value = 46500000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 57000000,
            value = 76500000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 93000000,
            value = 126000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 153000000,
            value = 207000000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 252000000,
            value = 339000000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 414000000,
            value = 558000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 684000000,
            value = 924000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 1125000000,
            value = 1518000000
        },
        Void = {
            rarity = "Singularity",
            cost = 1854000000,
            value = 2502000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 3060000000,
            value = 4131000000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 5040000000,
            value = 6804000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 8310000000,
            value = 11220000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 13710000000,
            value = 18510000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 22620000000,
            value = 30540000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 37320000000,
            value = 50370000000
        }
    },

    HDD = {
        Rusty = {
            rarity = "Common",
            cost = 1,
            value = 1
        },
        Faulty = {
            rarity = "Common",
            cost = 5,
            value = 6
        },
        Old = {
            rarity = "Common",
            cost = 10,
            value = 14
        },
        Refurbished = {
            rarity = "Common",
            cost = 20,
            value = 30
        },

        New = {
            rarity = "Uncommon",
            cost = 60,
            value = 90
        },
        Polished = {
            rarity = "Uncommon",
            cost = 100,
            value = 140
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 170,
            value = 240
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 300,
            value = 400
        },

        Pristine = {
            rarity = "Rare",
            cost = 900,
            value = 1100
        },
        Deluxe = {
            rarity = "Rare",
            cost = 1360,
            value = 1600
        },
        Charged = {
            rarity = "Rare",
            cost = 2000,
            value = 2800
        },
        Supercharged = {
            rarity = "Rare",
            cost = 3200,
            value = 4400
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 5200,
            value = 7200
        },
        Industrial = {
            rarity = "Epic",
            cost = 8400,
            value = 11600
        },
        Prototype = {
            rarity = "Epic",
            cost = 14000,
            value = 19000
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 23000,
            value = 31000
        },

        Experimental = {
            rarity = "Legendary",
            cost = 38000,
            value = 52000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 62000,
            value = 84000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 100000,
            value = 136000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 164000,
            value = 220000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 270000,
            value = 360000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 440000,
            value = 600000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 720000,
            value = 980000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 1180000,
            value = 1600000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 1960000,
            value = 2640000
        },
        Astral = {
            rarity = "Quantum",
            cost = 3200000,
            value = 4300000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 5200000,
            value = 7000000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 8600000,
            value = 11600000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 14200000,
            value = 19200000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 23000000,
            value = 31000000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 38000000,
            value = 51000000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 62000000,
            value = 84000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 102000000,
            value = 138000000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 168000000,
            value = 226000000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 276000000,
            value = 372000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 456000000,
            value = 616000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 750000000,
            value = 1012000000
        },
        Void = {
            rarity = "Singularity",
            cost = 1236000000,
            value = 1668000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 2040000000,
            value = 2754000000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 3360000000,
            value = 4536000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 5540000000,
            value = 7480000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 9140000000,
            value = 12340000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 15080000000,
            value = 20360000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 24880000000,
            value = 33580000000
        }
    },

    SSD = {
        Rusty = {
            rarity = "Common",
            cost = 2,
            value = 3
        },
        Faulty = {
            rarity = "Common",
            cost = 11,
            value = 14
        },
        Old = {
            rarity = "Common",
            cost = 23,
            value = 32
        },
        Refurbished = {
            rarity = "Common",
            cost = 45,
            value = 68
        },

        New = {
            rarity = "Uncommon",
            cost = 135,
            value = 203
        },
        Polished = {
            rarity = "Uncommon",
            cost = 225,
            value = 315
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 383,
            value = 540
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 675,
            value = 900
        },

        Pristine = {
            rarity = "Rare",
            cost = 2025,
            value = 2475
        },
        Deluxe = {
            rarity = "Rare",
            cost = 3060,
            value = 3600
        },
        Charged = {
            rarity = "Rare",
            cost = 4500,
            value = 6300
        },
        Supercharged = {
            rarity = "Rare",
            cost = 7200,
            value = 9900
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 11700,
            value = 16200
        },
        Industrial = {
            rarity = "Epic",
            cost = 18900,
            value = 26100
        },
        Prototype = {
            rarity = "Epic",
            cost = 31500,
            value = 42750
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 51750,
            value = 69750
        },

        Experimental = {
            rarity = "Legendary",
            cost = 85500,
            value = 117000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 139500,
            value = 189000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 225000,
            value = 306000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 369000,
            value = 495000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 607500,
            value = 810000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 990000,
            value = 1350000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 1620000,
            value = 2205000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 2655000,
            value = 3600000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 4410000,
            value = 5940000
        },
        Astral = {
            rarity = "Quantum",
            cost = 7200000,
            value = 9675000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 11700000,
            value = 15750000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 19350000,
            value = 26100000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 31950000,
            value = 43200000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 51750000,
            value = 69750000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 85500000,
            value = 114750000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 139500000,
            value = 189000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 229500000,
            value = 310500000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 378000000,
            value = 508500000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 621000000,
            value = 837000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 1026000000,
            value = 1386000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 1687500000,
            value = 2277000000
        },
        Void = {
            rarity = "Singularity",
            cost = 2781000000,
            value = 3753000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 4590000000,
            value = 6196500000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 7560000000,
            value = 10206000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 12465000000,
            value = 16830000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 20565000000,
            value = 27765000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 33930000000,
            value = 45810000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 55980000000,
            value = 75555000000
        }
    },

    Motherboard = {
        Rusty = {
            rarity = "Common",
            cost = 3,
            value = 4
        },
        Faulty = {
            rarity = "Common",
            cost = 15,
            value = 18
        },
        Old = {
            rarity = "Common",
            cost = 30,
            value = 42
        },
        Refurbished = {
            rarity = "Common",
            cost = 60,
            value = 90
        },

        New = {
            rarity = "Uncommon",
            cost = 180,
            value = 270
        },
        Polished = {
            rarity = "Uncommon",
            cost = 300,
            value = 420
        },
        Upgraded = {
            rarity = "Uncommon",
            cost = 510,
            value = 720
        },
        Overclocked = {
            rarity = "Uncommon",
            cost = 900,
            value = 1200
        },

        Pristine = {
            rarity = "Rare",
            cost = 2700,
            value = 3300
        },
        Deluxe = {
            rarity = "Rare",
            cost = 4080,
            value = 4800
        },
        Charged = {
            rarity = "Rare",
            cost = 6000,
            value = 8400
        },
        Supercharged = {
            rarity = "Rare",
            cost = 9600,
            value = 13200
        },

        LiquidCooled = {
            rarity = "Epic",
            cost = 15600,
            value = 21600
        },
        Industrial = {
            rarity = "Epic",
            cost = 25200,
            value = 34800
        },
        Prototype = {
            rarity = "Epic",
            cost = 42000,
            value = 57000
        },
        MilitaryGrade = {
            rarity = "Epic",
            cost = 69000,
            value = 93000
        },

        Experimental = {
            rarity = "Legendary",
            cost = 114000,
            value = 156000
        },
        Superconductive = {
            rarity = "Legendary",
            cost = 186000,
            value = 252000
        },
        Fusion = {
            rarity = "Legendary",
            cost = 300000,
            value = 408000
        },
        Synaptic = {
            rarity = "Legendary",
            cost = 492000,
            value = 660000
        },
        
        Photonic = {
            rarity = "Mythical",
            cost = 810000,
            value = 1080000
        },
        ZeroPoint = {
            rarity = "Mythical",
            cost = 1320000,
            value = 1800000
        },
        SubAtomic = {
            rarity = "Mythical",
            cost = 2160000,
            value = 2940000
        },
        Chrono = {
            rarity = "Mythical",
            cost = 3540000,
            value = 4800000
        },

        Entangled = {
            rarity = "Quantum",
            cost = 5880000,
            value = 7920000
        },
        Astral = {
            rarity = "Quantum",
            cost = 9600000,
            value = 12900000
        },
        Antimatter = {
            rarity = "Quantum",
            cost = 15600000,
            value = 21000000
        },
        Tachyon = {
            rarity = "Quantum",
            cost = 25800000,
            value = 34800000
        },

        Anomalous = {
            rarity = "Supernatural",
            cost = 42600000,
            value = 57600000
        },
        Alien = {
            rarity = "Supernatural",
            cost = 69000000,
            value = 93000000
        },
        Spectral = {
            rarity = "Supernatural",
            cost = 114000000,
            value = 153000000
        },
        Paradoxical = {
            rarity = "Supernatural",
            cost = 186000000,
            value = 252000000
        },

        Stellar = {
            rarity = "Cosmic",
            cost = 306000000,
            value = 414000000
        },
        Galactic = {
            rarity = "Cosmic",
            cost = 504000000,
            value = 678000000
        },
        Nebulous = {
            rarity = "Cosmic",
            cost = 828000000,
            value = 1116000000
        },
        Supernova = {
            rarity = "Cosmic",
            cost = 1368000000,
            value = 1848000000
        },
        
        Gravitational = {
            rarity = "Singularity",
            cost = 2250000000,
            value = 3036000000
        },
        Void = {
            rarity = "Singularity",
            cost = 3708000000,
            value = 5004000000
        },
        Collapsed = {
            rarity = "Singularity",
            cost = 6120000000,
            value = 8262000000
        },
        Horizon = {
            rarity = "Singularity",
            cost = 10080000000,
            value = 13608000000
        },

        Absolute = {
            rarity = "Omega",
            cost = 16620000000,
            value = 22440000000
        },
        Genesis = {
            rarity = "Omega",
            cost = 27420000000,
            value = 37020000000
        },
        Primordial = {
            rarity = "Omega",
            cost = 45240000000,
            value = 61080000000
        },
        Transcendent = {
            rarity = "Omega",
            cost = 74640000000,
            value = 100740000000
        }
    }
} :: { [string]: { [string]: ElectronicComponent } }

return ELECTRONIC_COMPONENTS 