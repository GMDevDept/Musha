local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    -- Musha character textures
    Asset( "ANIM", "anim/musha/musha_normal.zip" ),
    Asset( "ANIM", "anim/musha/musha_full.zip" ),
    Asset( "ANIM", "anim/musha/musha_valkyrie.zip" ), 
    Asset( "ANIM", "anim/musha/musha_berserk.zip" ),
    Asset( "ANIM", "anim/musha/ghost_musha_build.zip" ),
}

-- Basic stats
TUNING.MUSHA_HEALTH = 100
TUNING.MUSHA_HUNGER = 100
TUNING.MUSHA_SANITY = 100

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

-- Update current status
local function update_status(inst)
    -- Won't transform to full or normal if valkyrie or berserk is active
    if not inst.valkyrie_activated and not inst.berserk_activated then
        if inst.components.hunger:GetPercent() > 0.75 then
            if inst.musha_normal == true then
                SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
            end
            inst.AnimState:SetBuild("musha_full")
            inst.musha_full = true
            inst.musha_normal = false
        else
            if inst.musha_full == true then
                SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
            end
            inst.AnimState:SetBuild("musha_normal")
            inst.musha_full = false
            inst.musha_normal = true
        end            
        inst.soundsname = "willow"
    end
end

-- When state changes, update morph availability and 
local function onnewstate(inst)
    -- if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
    --     inst._wasnomorph = not inst._wasnomorph
    --     if not inst._wasnomorph then
    --         update_status(inst)
    --     end
    -- end
end

-- When the character is revived to human
local function onbecamehuman(inst)
    inst.valkyrie_activated = false
    inst.berserk_activated = false
    inst:ListenForEvent("hungerdelta", update_status)
    inst:ListenForEvent("newstate", onnewstate)
    update_status(inst)
end

-- When the character turn into a ghost 
local function onbecameghost(inst)
    inst.valkyrie_activated = false
    inst.berserk_activated = false
    inst:RemoveEventCallback("hungerdelta", update_status)
    inst:RemoveEventCallback("newstate", onnewstate)
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
local function onsave(inst, data)
    print("onsave")
end

-- When preload
local function onpreload(inst, data)
    print("onpreload")
end  

-- Toggle valkyrie mode
local function toggle_valkyrie(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or inst.sg:HasStateTag("nomorph") then
        return
    end
    if inst.valkyrie_activated then
        inst.valkyrie_activated = false
        inst.berserk_activated = false
        SpawnPrefab("weregoose_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
        update_status(inst)
    elseif not inst.berserk_activated then
        inst.valkyrie_activated = true
        inst.berserk_activated = false
        inst.musha_full = false
        inst.musha_normal = false
        SpawnPrefab("lucy_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
        inst.AnimState:SetBuild("musha_valkyrie")
        inst.soundsname = "winnie"
    end
end
-- Use Remote Procedure Call, because client cannot handel components.health or sg
AddModRPCHandler("musha", "toggle_valkyrie", toggle_valkyrie) 

-- Toggle stealth mode
local function toggle_stealth(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") then
        return
    end
    if inst.berserk_activated then
        inst.valkyrie_activated = false
        inst.berserk_activated = false
        SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
        update_status(inst)
    else
        inst.berserk_activated = true
        inst.valkyrie_activated = false
        inst.musha_full = false
        inst.musha_normal = false
        SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
        inst.AnimState:SetBuild("musha_berserk")
        inst.soundsname = "wendy"
    end
end
-- Use Remote Procedure Call, because client cannot handel components.health or sg
AddModRPCHandler("musha", "toggle_stealth", toggle_stealth) 

-- This initializes for both the server and client. Tags, animes and minimap icons can be added here.
local function common_postinit(inst)
    -- Tags
    inst:AddTag("musha")

    -- Warly
	inst:AddTag("masterchef")
    inst:AddTag("professionalchef")
    inst:AddTag("expertchef")

	-- Minimap icon
	inst.MiniMapEntity:SetIcon("musha_mapicon.tex")

    -- Hotkey binds
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.hotkey_valkyrie, "toggle_valkyrie")
    inst.components.keyhandler:AddActionListener("musha", TUNING.MUSHA.hotkey_stealth, "toggle_stealth")
end

-- This initializes for the server only. Components are added here.
local function master_postinit(inst)
	-- Choose which sounds this character will play
	inst.soundsname = "willow"

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
    MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)