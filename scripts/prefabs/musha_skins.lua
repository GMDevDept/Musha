return MakeCharacterSkin("musha", "musha_none", {
    name = "Normal",
    des = "",
    quotes = "",
    base_prefab = "musha",
    assets = {
        Asset("ANIM", "anim/musha/musha_normal.zip"),
        Asset("ANIM", "anim/musha/ghost_musha_build.zip"),
    },
    build_name_override = "musha_normal",
    rarity = "Timeless",
    skins = { normal_skin = "musha_normal", ghost_skin = "ghost_musha_build" },
    skin_tags = { "musha", "BASE", "CHARACTER" },
}),

    MakeCharacterSkin("musha", "musha_full", {
        name = "Full",
        des = "",
        quotes = "",
        base_prefab = "musha",
        assets = {
            Asset("ANIM", "anim/musha/musha_full.zip"),
            Asset("ANIM", "anim/musha/ghost_musha_build.zip"),
        },
        build_name_override = "musha_full",
        rarity = "Loyal",
        skins = { normal_skin = "musha_full", ghost_skin = "ghost_musha_build" },
        skin_tags = { "musha", "BASE", "CHARACTER" },
    }),

    MakeCharacterSkin("musha", "musha_valkyrie", {
        name = "Valkyrie",
        des = "",
        quotes = "",
        base_prefab = "musha",
        assets = {
            Asset("ANIM", "anim/musha/musha_valkyrie.zip"),
            Asset("ANIM", "anim/musha/ghost_musha_build.zip"),
        },
        build_name_override = "musha_valkyrie",
        rarity = "Elegant",
        skins = { normal_skin = "musha_valkyrie", ghost_skin = "ghost_musha_build" },
        skin_tags = { "musha", "BASE", "CHARACTER" },
    }),

    MakeCharacterSkin("musha", "musha_berserk", {
        name = "Berserk",
        des = "",
        quotes = "",
        base_prefab = "musha",
        assets = {
            Asset("ANIM", "anim/musha/musha_berserk.zip"),
            Asset("ANIM", "anim/musha/ghost_musha_build.zip"),
        },
        build_name_override = "musha_berserk",
        rarity = "Spiffy",
        skins = { normal_skin = "musha_berserk", ghost_skin = "ghost_musha_build" },
        skin_tags = { "musha", "BASE", "CHARACTER" },
    })
