local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    -- Musha character textures
    Asset("ANIM", "anim/musha/musha.zip"),
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

-- Decide normal mode or full mode
local function decidenormalorfull(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    if inst.components.hunger:GetPercent() < 0.75 then
        inst.mode:set(0)
    else
        inst.mode:set(1)
    end
end

-- Toggle valkyrie mode
local function toggle_valkyrie(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()

    if previousmode == 0 or previousmode == 1 then
        inst.mode:set(2)
    elseif previousmode == 2 then
        decidenormalorfull(inst)
    end
end

local function addberserktrailfx(inst)
    local owner = inst
    if not owner.entity:IsVisible() then
        return
    end

    local x, y, z = owner.Transform:GetWorldPosition()
    if owner.sg ~= nil and owner.sg:HasStateTag("moving") then
        local theta = -owner.Transform:GetRotation() * DEGREES
        local speed = owner.components.locomotor:GetRunSpeed() * .1
        x = x + speed * math.cos(theta)
        z = z + speed * math.sin(theta)
    end
    local mounted = owner.components.rider ~= nil and owner.components.rider:IsRiding()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        (mounted and 1 or .5) + math.random() * .5,
        4,
        function(offset)
            local pt = Vector3(x + offset.x, 0, z + offset.z)
            return map:IsPassableAtPoint(pt:Get())
                and not map:IsPointNearHole(pt)
                and #TheSim:FindEntities(pt.x, 0, pt.z, .7, { "shadowtrail" }) <= 0
        end
    )

    if offset ~= nil then
        SpawnPrefab("cane_ancient_fx").Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function removetrailtask(inst, taskname)
    if inst[taskname] ~= nil then
        inst[taskname]:Cancel()
        inst[taskname] = nil
    end
end

-- Toggle stealth mode
local function toggle_stealth(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()

    if previousmode == 0 or previousmode == 1 then
        inst.mode:set(3)
    elseif previousmode == 3 then
        decidenormalorfull(inst)
    end
end

-- Bonus damage
local function bonusdamagefn(inst, target, damage, weapon)
    -- return (target:HasTag("") and TUNING.EXTRADAMAGE) or 0
    return 0
end

-- When level up
local function onlevelup(inst, data)

end

-- When character mode changes
local function onmodechange(inst)
    local previousmode = inst._mode
    local currentmode = inst.mode:value()

    if currentmode == 0 then
        inst:ListenForEvent("hungerdelta", decidenormalorfull)

        if previousmode == 1 then
            CustomAttachFx(inst, "chester_transform_fx")
        elseif previousmode == 2 then
            CustomAttachFx(inst, "electrichitsparks")
        elseif previousmode == 3 then
            CustomAttachFx(inst, "statue_transition_2")
        end

        inst.components.skinner:SetSkinName("musha_none")
        inst.soundsname = "willow"

        removetrailtask(inst, "modetrailtask")

    elseif currentmode == 1 then
        inst:ListenForEvent("hungerdelta", decidenormalorfull)

        if previousmode == 0 then
            CustomAttachFx(inst, "chester_transform_fx")
        elseif previousmode == 2 then
            CustomAttachFx(inst, "electrichitsparks")
        elseif previousmode == 3 then
            CustomAttachFx(inst, "statue_transition_2")
        end

        inst.components.skinner:SetSkinName("musha_full")
        inst.soundsname = "willow"

        removetrailtask(inst, "modetrailtask")

    elseif currentmode == 2 then
        inst:RemoveEventCallback("hungerdelta", decidenormalorfull)
        CustomAttachFx(inst, "electricchargedfx")
        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.soundsname = "winnie"

    elseif currentmode == 3 then
        inst:RemoveEventCallback("hungerdelta", decidenormalorfull)
        CustomAttachFx(inst, "statue_transition")
        inst.components.skinner:SetSkinName("musha_berserk")
        inst.soundsname = "wendy"
        inst.modetrailtask = inst:DoPeriodicTask(6 * FRAMES, addberserktrailfx, 2 * FRAMES)
    end

    inst._mode = currentmode -- Update previous mode
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function onbecamehuman(inst)
    decidenormalorfull(inst)
end

-- When the character turn into a ghost
local function onbecameghost(inst)
end

-- When save game progress
local function onsave(inst, data)
end

-- When preload (before loading components)
local function onpreload(inst, data)
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

    -- Common attributes
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
    inst.mode = net_tinybyte(inst.GUID, "musha.mode", "modechange") -- 0: normal, 1: full, 2: valkyrie, 3: berserk
    inst.mode:set_local(0) -- Force to trigger dirty event on next :set()
    inst._mode = 0 -- Store previous mode
    inst.toggle_valkyrie = toggle_valkyrie
    inst.toggle_stealth = toggle_stealth

    -- Common attributes

    -- Event handlers
    inst:ListenForEvent("levelup", onlevelup)
    inst:ListenForEvent("modechange", onmodechange)

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
