local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    -- Musha character textures
    Asset("ANIM", "anim/musha/musha.zip"),
    Asset("ANIM", "anim/musha/musha_normal.zip"),
    Asset("ANIM", "anim/musha/musha_full.zip"),
    Asset("ANIM", "anim/musha/musha_valkyrie.zip"),
    Asset("ANIM", "anim/musha/musha_berserk.zip"),
    Asset("ANIM", "anim/musha/ghost_musha_build.zip"),
}

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.MUSHA = {
    "torch",
    "hammer",
    "tentaclespike",
    "minotaurhorn",
    "ice",
    "ice",
    "ice",
    "ice",
    "ice",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.MUSHA
end

-- Character required prefabs
local prefabs = FlattenTree(start_inv, true)

-- Update character mode
local function update_mode(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end
    -- Won't transform to full or normal if valkyrie or berserk is active
    if not inst.valkyrie_activated and not inst.berserk_activated then
        if inst.components.hunger:GetPercent() > 0.75 then
            if inst.musha_normal == true then
                SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
            end
            inst.components.skinner:SetSkinName("musha_full")
            inst.musha_full = true
            inst.musha_normal = false
        else
            if inst.musha_full == true then
                SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
            end
            inst.components.skinner:SetSkinName("musha_none")
            inst.musha_full = false
            inst.musha_normal = true
        end
        inst.soundsname = "willow"
    end
end

-- Toggle valkyrie mode
local function toggle_valkyrie(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end
    if inst.valkyrie_activated then
        inst.valkyrie_activated = false
        inst.berserk_activated = false
        SpawnPrefab("electrichitsparks").Transform:SetPosition(inst:GetPosition():Get())
        update_mode(inst)
    else
        inst.valkyrie_activated = true
        inst.berserk_activated = false
        inst.musha_full = false
        inst.musha_normal = false
        SpawnPrefab("electricchargedfx").Transform:SetPosition(inst:GetPosition():Get())
        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.soundsname = "winnie"
    end
end

-- Toggle stealth mode
local function toggle_stealth(inst)
    inst.components.leveler:DoDelta(10)
    inst.components.talker:Say(inst.components.leveler:GetExperience() .. "\n" .. inst.components.leveler:GetLevel())
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end
    if inst.berserk_activated then
        inst.valkyrie_activated = false
        inst.berserk_activated = false
        SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
        update_mode(inst)
    else
        inst.berserk_activated = true
        inst.valkyrie_activated = false
        inst.musha_full = false
        inst.musha_normal = false
        SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
        inst.components.skinner:SetSkinName("musha_berserk")
        inst.soundsname = "wendy"
    end
end

-- When state changes, update morph availability and
local function onnewstate(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            update_mode(inst)
        end
    end
end

-- When level up
local function onlevelup(inst, data)

end

-- Bonus damage
local function bonusdamagefn(inst, target, damage, weapon)
    -- return (target:HasTag("") and TUNING.EXTRADAMAGE) or 0
    return 0
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function onbecamehuman(inst)
    inst.valkyrie_activated = false
    inst.berserk_activated = false

    update_mode(inst)

    inst:ListenForEvent("hungerdelta", update_mode)
    inst:ListenForEvent("newstate", onnewstate)
end

-- When the character turn into a ghost
local function onbecameghost(inst)
    inst._wasnomorph = nil
    inst.valkyrie_activated = false
    inst.berserk_activated = false

    inst:RemoveEventCallback("hungerdelta", update_mode)
    inst:RemoveEventCallback("newstate", onnewstate)
end

-- When save game progress
local function onsave(inst, data)
    print("onsave")
end

-- When preload (before loading components)
local function onpreload(inst, data)
    print("onpreload")
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

---------------------------------------------------------------------------------------------------------

-- This initializes for both the server and client. Tags, animes and minimap icons can be added here.
local function common_postinit(inst)
    -- Tags defined by this mod
    inst:AddTag("musha")

    -- Able to build and read books
    inst:AddTag("bookbuilder")
    inst:AddTag("reader")

    -- Able to craft and use Warly's cooking kit
    inst:AddTag("masterchef") -- Craft and use cooking kit
    inst:AddTag("professionalchef") -- Make spices
    inst:AddTag("expertchef") -- No damage when cooking on fire

    -- Able to craft and use Winona's tools
    inst:AddTag("handyperson")

    -- Able to craft balloons
    inst:AddTag("balloonomancer")

    -- Minimap icon
    inst.MiniMapEntity:SetIcon("musha_mapicon.tex")

    -- Choose which sounds this character will play
    inst.soundsname = "willow"
end

---------------------------------------------------------------------------------------------------------

-- This initializes for the server only. Components are added here.
local function master_postinit(inst)
    -- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    -- Leveler
    inst:AddComponent("leveler")
    inst.components.leveler:SetMaxExperience(TUNING.musha.maxexperience)
    inst.components.leveler:SetMaxLevel(TUNING.musha.maxlevel)
    inst.components.leveler.exprate = TUNING.musha.exprate
    inst.components.leveler.exp_to_level = TUNING.musha.exp_to_level

    -- Mana
    inst:AddComponent("mana")
    inst.components.mana:SetMax(TUNING.musha.maxmana)
    inst.components.mana:SetRate(TUNING.musha.manaregenspeed)

    -- Stamina
    inst:AddComponent("stamina")
    inst.components.stamina:SetRate(TUNING.musha.staminarate)

    -- Fatigue
    inst:AddComponent("fatigue")
    inst.components.fatigue:SetRate(TUNING.musha.fatiguerate)

    -- Read books
    inst:AddComponent("reader")

    -- Stats
    inst.components.health:SetMaxHealth(TUNING.musha.health)
    inst.components.hunger:SetMax(TUNING.musha.hunger)
    inst.components.sanity:SetMax(TUNING.musha.sanity)

    -- Combat
    inst.components.combat.damagemultiplier = TUNING.musha.damagemultiplier
    inst.components.combat.areahitdamagepercent = TUNING.musha.areahitdamagepercent
    inst.components.combat.bonusdamagefn = bonusdamagefn

    -- Food bonus
    inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_LARGE)

    -- Character specific attributes
    inst.toggle_valkyrie = toggle_valkyrie
    inst.toggle_stealth = toggle_stealth

    -- Common attributes

    -- Event handlers
    inst:ListenForEvent("levelup", onlevelup)

    -- FIRST, the entity runs its PreLoad method.
    -- SECOND, the entity runs the OnLoad function of its components.
    -- THIRD, the entity runs its OnLoad method.
    inst.OnLoad = onload
    inst.OnNewSpawn = onload
    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
end

-- Set up remote procedure call for client side
AddModRPCHandler("musha", "toggle_valkyrie", toggle_valkyrie)
AddModRPCHandler("musha", "toggle_stealth", toggle_stealth)

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)
