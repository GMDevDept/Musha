Assets = {
    -- Doesn't change anything ,but if not then error occurs:
    -- [string "scripts/widgets/redux/clothingexplorerpanel..."]:32: attempt to index field 'header' (a nil value)
    -- also occurs when skin related strings are not defined
    Asset("IMAGE", "bigportraits/musha.tex"),
    Asset("ATLAS", "bigportraits/musha.xml"),

    -- Name tag on selection screen
    Asset("IMAGE", "images/names_musha.tex"),
    Asset("ATLAS", "images/names_musha.xml"),

    -- Character full portrait (oval) on selecting screen (for skins)
    Asset("IMAGE", "bigportraits/musha_none.tex"),
    Asset("ATLAS", "bigportraits/musha_none.xml"),
    Asset("IMAGE", "bigportraits/musha_full.tex"),
    Asset("ATLAS", "bigportraits/musha_full.xml"),
    Asset("IMAGE", "bigportraits/musha_valkyrie.tex"),
    Asset("ATLAS", "bigportraits/musha_valkyrie.xml"),
    Asset("IMAGE", "bigportraits/musha_berserk.tex"),
    Asset("ATLAS", "bigportraits/musha_berserk.xml"),

    -- Character craft tab icon (doesn't affect tab menu)
    Asset("IMAGE", "images/avatars/avatar_musha.tex"),
    Asset("ATLAS", "images/avatars/avatar_musha.xml"),

    Asset("IMAGE", "images/avatars/avatar_ghost_musha.tex"),
    Asset("ATLAS", "images/avatars/avatar_ghost_musha.xml"),

    -- Portrait on the right side of toolbar
    Asset("IMAGE", "images/avatars/self_inspect_musha.tex"),
    Asset("ATLAS", "images/avatars/self_inspect_musha.xml"),

    -- Widgets
    Asset("ANIM", "anim/widgets/mana.zip"),
    Asset("ANIM", "anim/widgets/fatigue.zip"),
    Asset("ANIM", "anim/widgets/stamina.zip"),

    -- Stategraphs
    Asset("ANIM", "anim/musha/player_actions_telescope.zip"), -- Treasure sniffing: telescope
    Asset("ANIM", "anim/musha/swap_telescope.zip"), -- Treasure sniffing: telescope
    Asset("ANIM", "anim/musha/player_actions_uniqueitem_2.zip"), -- Treasure sniffing: scroll: have to be added here or else character anim will be broken
    Asset("ANIM", "anim/musha/messagebottle.zip"), -- Treasure sniffing: scroll

    -- Map icon
    Asset("IMAGE", "images/map_icons/musha_mapicon.tex"),
    Asset("ATLAS", "images/map_icons/musha_mapicon.xml"),
    Asset("IMAGE", "images/map_icons/musha_treasure2.tex"),
    Asset("ATLAS", "images/map_icons/musha_treasure2.xml"),

    -- Inventory and recipes
    Asset("ATLAS", "images/inventoryimages/musha_inventoryimages2.xml"),
    Asset("IMAGE", "images/inventoryimages/musha_inventoryimages2.tex"),
    Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
    Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
}

AddMinimapAtlas("images/map_icons/musha_mapicon.xml")
AddMinimapAtlas("images/map_icons/musha_treasure2.xml")
AddMinimapAtlas("images/inventoryimages/frosthammer.xml")
