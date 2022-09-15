local foodlist = require("preparedfoods")
local additionalfoods = require("preparedfoods_warly")

for k, v in pairs(additionalfoods) do
    foodlist[k] = v
end

local fishlist = {
    "pondfish",
    "pondeel",
    "wobster_sheller_land",
    "oceanfish_medium_1_inv",
    "oceanfish_medium_2_inv",
    "oceanfish_medium_3_inv",
    "oceanfish_medium_4_inv",
    "oceanfish_medium_5_inv",
    "oceanfish_medium_6_inv",
    "oceanfish_medium_7_inv",
    "oceanfish_medium_8_inv",
    "oceanfish_medium_9_inv",
    "oceanfish_small_1_inv",
    "oceanfish_small_2_inv",
    "oceanfish_small_3_inv",
    "oceanfish_small_4_inv",
    "oceanfish_small_5_inv",
    "oceanfish_small_6_inv",
    "oceanfish_small_7_inv",
    "oceanfish_small_8_inv",
    "oceanfish_small_9_inv",
}

local treasurechests = {
    gift_birth = {
        container = "treasurechest",
        loots = {
            axe = {
                prefab = "axe",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            pickaxe = {
                prefab = "pickaxe",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            hammer = {
                prefab = "hammer",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            backpack = {
                prefab = "backpack_blueprint",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            armorwood = {
                prefab = "armorwood",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            amulet = {
                prefab = "amulet",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            tophat = {
                prefab = "tophat",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            bundlewrap = {
                prefab = "bundlewrap",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            reskin_tool = {
                prefab = "reskin_tool",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    gift_shadow = {
        container = "treasurechest",
        loots = {
            waxwelljournal = {
                prefab = "waxwelljournal",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            nightsword = {
                prefab = "nightsword",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    gift_book = {
        container = "bookstation",
        loots = {
            book_bees = {
                prefab = "book_bees",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_sleep = {
                prefab = "book_sleep",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_light = {
                prefab = "book_light",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_research_station = {
                prefab = "book_research_station",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_silviculture = {
                prefab = "book_silviculture",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_horticulture = {
                prefab = "book_horticulture",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
            book_webber = {
                prefab = "book_webber",
                chance = 0.7,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    gemchest = {
        container = "treasurechest",
        loots = {
            redgem = {
                prefab = "redgem",
                chance = 1,
                lootcount = 2,
                lootcountmax = 4,
            },
            bluegem = {
                prefab = "bluegem",
                chance = 1,
                lootcount = 2,
                lootcountmax = 4,
            },
            purplegem = {
                prefab = "purplegem",
                chance = 1,
                lootcount = 1,
                lootcountmax = 3,
            },
            greengem = {
                prefab = "greengem",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            greengem2 = {
                prefab = "greengem",
                chance = 0.25,
                lootcount = 1,
                lootcountmax = 1,
            },
            orangegem = {
                prefab = "orangegem",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            orangegem2 = {
                prefab = "orangegem",
                chance = 0.25,
                lootcount = 1,
                lootcountmax = 1,
            },
            yellowgem = {
                prefab = "yellowgem",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            yellowgem2 = {
                prefab = "yellowgem",
                chance = 0.25,
                lootcount = 1,
                lootcountmax = 1,
            },
            opalpreciousgem = {
                prefab = "opalpreciousgem",
                chance = 0.02,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    foodbox = {
        container = "icebox",
        loots = {
            food1 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food2 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food3 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food4 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food5 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food6 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food7 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food8 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
            food9 = {
                prefab = GetRandomItem(foodlist).name,
                chance = 1,
                lootcount = 1,
                lootcountmax = 2,
            },
        },
    },

    seedbag = {
        container = "seedpouch",
        loots = {
            seed1 = {
                prefab = "carrot_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed2 = {
                prefab = "corn_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed3 = {
                prefab = "pumpkin_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed4 = {
                prefab = "eggplant_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed5 = {
                prefab = "durian_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed6 = {
                prefab = "pomegranate_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed7 = {
                prefab = "dragonfruit_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed8 = {
                prefab = "watermelon_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed9 = {
                prefab = "tomato_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed10 = {
                prefab = "potato_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed11 = {
                prefab = "asparagus_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed12 = {
                prefab = "onion_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed13 = {
                prefab = "garlic_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
            seed14 = {
                prefab = "pepper_seeds",
                chance = 1,
                lootcount = 3,
                lootcountmax = 3,
            },
        },
    },

    bossloots = {
        container = "dragonflychest",
        loots = {
            deerclops_eyeball = {
                prefab = "deerclops_eyeball",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            minotaurhorn = {
                prefab = "minotaurhorn",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            bearger_fur = {
                prefab = "bearger_fur",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            goose_feather = {
                prefab = "goose_feather",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            shroom_skin = {
                prefab = "shroom_skin",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            malbatross_beak = {
                prefab = "malbatross_beak",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            malbatross_feathered_weave = {
                prefab = "malbatross_feathered_weave",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            trunk_winter = {
                prefab = "trunk_winter",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            steelwool = {
                prefab = "steelwool",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            lightninggoathorn = {
                prefab = "lightninggoathorn",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
        extraloots = {
            crawlingnightmare = {
                type = "enemy",
                prefab = "crawlingnightmare",
                chance = 1,
                lootcount = 3,
                lootcountmax = 6,
            },
            nightmarebeak = {
                type = "enemy",
                prefab = "nightmarebeak",
                chance = 1,
                lootcount = 5,
                lootcountmax = 10,
            },
        },
    },

    resourcepack = {
        container = "treasurechest",
        loots = {
            cutgrass = {
                prefab = "cutgrass",
                chance = 1,
                lootcount = 1,
                lootcountmax = 40,
            },
            twigs = {
                prefab = "twigs",
                chance = 1,
                lootcount = 1,
                lootcountmax = 40,
            },
            flint = {
                prefab = "flint",
                chance = 1,
                lootcount = 1,
                lootcountmax = 40,
            },
            rocks = {
                prefab = "rocks",
                chance = 1,
                lootcount = 1,
                lootcountmax = 40,
            },
            log = {
                prefab = "log",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            goldnugget = {
                prefab = "goldnugget",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            charcoal = {
                prefab = "charcoal",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            cutreeds = {
                prefab = "cutreeds",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            nitre = {
                prefab = "nitre",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
        },
    },

    zoo = {
        container = "treasurechest",
        loots = {
            bird = {
                prefab = "robin",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            butterfly = {
                prefab = "butterfly",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            bee1 = {
                prefab = "bee",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            rabbit = {
                prefab = "rabbit",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            mole = {
                prefab = "mole",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            carrat = {
                prefab = "carrat",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            lightcrab = {
                prefab = "lightcrab",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            lightflier = {
                prefab = "lightflier",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            moonbutterfly = {
                prefab = "moonbutterfly",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            bird2 = {
                prefab = "robin_winter",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            mosquito = {
                prefab = "mosquito",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            bird3 = {
                prefab = "crow",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            bird4 = {
                prefab = "canary",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
            bee2 = {
                prefab = "killerbee",
                chance = 0.6,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    aquarium = {
        container = "treasurechest",
        loots = {
            fish1 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish2 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish3 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish4 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish5 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish6 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish7 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish8 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            fish9 = {
                prefab = GetRandomItem(fishlist),
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
    },

    spiderden = {
        container = "treasurechest",
        loots = {
            spider1 = {
                prefab = "spider",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider2 = {
                prefab = "spider_warrior",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider3 = {
                prefab = "spider_hider",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider4 = {
                prefab = "spider_spitter",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider5 = {
                prefab = "spider_dropper",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider6 = {
                prefab = "spider_moon",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider7 = {
                prefab = "spider_healer",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spider8 = {
                prefab = "spider_water",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
            spidereggsack = {
                prefab = "spidereggsack",
                chance = 1,
                lootcount = 1,
                lootcountmax = 1,
            },
        },
        extraloots = {
            spiderqueen = {
                type = "enemy",
                prefab = "spiderqueen",
                chance = 0.2,
                lootcount = 1,
                lootcountmax = 3,
            },
        },
    },

    shit = {
        container = "treasurechest",
        loots = {
            poop = {
                prefab = "poop",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            guano = {
                prefab = "guano",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            spoiled_food = {
                prefab = "spoiled_food",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            rottenegg = {
                prefab = "rottenegg",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            spoiled_fish = {
                prefab = "spoiled_fish",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
            wetgoop = {
                prefab = "wetgoop",
                chance = 1,
                lootcount = 1,
                lootcountmax = 20,
            },
        },
        extraloots = {
            poop = {
                type = "item",
                prefab = "poop",
                chance = 1,
                lootcount = 1,
                lootcountmax = 10,
            },
            guano = {
                type = "item",
                prefab = "guano",
                chance = 1,
                lootcount = 1,
                lootcountmax = 10,
            },
        },
    },
}

local weightedtable = {
    gemchest = 8,
    foodbox = 12,
    seedbag = 8,
    bossloots = 2,
    resourcepack = 12,
    zoo = 4,
    aquarium = 4,
    spiderden = 4,
    shit = 2,
}

return { treasurechests, weightedtable }
