local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    -- Musha character textures
    Asset( "ANIM", "anim/musha/musha_battle.zip" ), 
    Asset( "ANIM", "anim/musha/musha.zip" ),
    Asset( "ANIM", "anim/musha/musha_normal.zip" ),
    Asset( "ANIM", "anim/musha/musha_hunger.zip" ),
    Asset( "ANIM", "anim/musha/ghost_musha_build.zip" ),
}

-- Basic stats
TUNING.MUSHA_HEALTH = 125
TUNING.MUSHA_HUNGER = 125
TUNING.MUSHA_SANITY = 125

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.MUSHA = {
	"flowerhat",
	"torch",
}
local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.MUSHA
end
local prefabs = FlattenTree(start_inv, true)

-- When the character is revived to human
local function onbecamehuman(inst)
    print("onbecamehuman")
end

-- When the character turn into a ghost 
local function onbecameghost(inst)
    print("onbecameghost")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

-- When save game progress
function onsave(inst, data)
    print("onsave")
end

-- When preload
function onpreload(inst, data)
    print("onpreload")
end  

-- This initializes for both the server and client. Tags can be added here.
local function common_postinit(inst)
    inst:AddTag("musha")

	-- choose which sounds this character will play
	inst.soundsname = "willow"

	-- Minimap icon
	inst.MiniMapEntity:SetIcon("musha_mapicon.tex")
end

-- This initializes for the server only. Components are added here.
local function master_postinit(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	-- Stats
    inst.components.health:SetMaxHealth(TUNING.MUSHA_HEALTH)
    inst.components.hunger:SetMax(TUNING.MUSHA_HUNGER)
    inst.components.sanity:SetMax(TUNING.MUSHA_SANITY)

	-- Damage multiplier 
    inst.components.combat.damagemultiplier = 1

    -- Hunger rate
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE

    -- Food bonus
	inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_LARGE)

    inst.OnLoad = onload
    inst.OnNewSpawn = onload
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
end

return -- Character and skin on selection screen
    MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit),
    CreatePrefabSkin("musha_none", {
        base_prefab = "musha", 
        skins = {
            normal_skin = "musha",
            ghost_skin = "ghost_musha_build",
        }, 
        assets = assets,
        skin_tags = {"BASE", "CHARACTER"},
        build_name_override = "musha",
    })

