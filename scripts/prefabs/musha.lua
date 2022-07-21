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

-- Bonus damage
local function bonusdamagefn(inst, target, damage, weapon)
    -- return (target:HasTag("") and TUNING.EXTRADAMAGE) or 0
    return 0
end

-- When level up
local function onlevelup(inst, data)

end

---------------------------------------------------------------------------------------------------------

-- Character mode related

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
        inst:decidenormalorfull()
    end
end

-- Toggle berserk mode
local function toggle_berserk(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()
    if previousmode == 0 or previousmode == 1 then
        inst.mode:set(3)
    elseif previousmode == 3 then
        inst:decidenormalorfull()
    end
end

local PLANTS_RANGE = 1
local MAX_PLANTS = 18
local PLANTFX_TAGS = { "wormwood_plant_fx" }
local function addvalkyrietrailfx(inst)
    if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()
    if #TheSim:FindEntities(x, y, z, PLANTS_RANGE, PLANTFX_TAGS) < MAX_PLANTS then
        local map = TheWorld.Map
        local pt = Vector3(0, 0, 0)
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * PLANTS_RANGE,
            3,
            function(offset)
                pt.x = x + offset.x
                pt.z = z + offset.z
                return map:CanPlantAtPoint(pt.x, 0, pt.z)
                    and #TheSim:FindEntities(pt.x, 0, pt.z, .5, PLANTFX_TAGS) < 3
                    and map:IsDeployPointClear(pt, nil, .5)
                    and not map:IsPointNearHole(pt, .4)
            end
        )
        if offset ~= nil then
            local plant = SpawnPrefab("wormwood_plant_fx")
            plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
            --randomize, favoring ones that haven't been used recently
            local rnd = math.random()
            ---@diagnostic disable-next-line: undefined-field
            rnd = table.remove(inst.plantpool, math.clamp(math.ceil(rnd * rnd * #inst.plantpool), 1, #inst.plantpool))
            table.insert(inst.plantpool, rnd)
            plant:SetVariation(rnd)
        end
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

-- When character mode changes
local function onmodechange(inst)
    local previousmode = inst._mode
    local currentmode = inst.mode:value()

    if currentmode == 0 or currentmode == 1 then
        inst:ListenForEvent("hungerdelta", decidenormalorfull)

        if previousmode == 0 or previousmode == 1 then
            CustomAttachFx(inst, "chester_transform_fx")
        elseif previousmode == 2 then
            CustomAttachFx(inst, "electrichitsparks")
        elseif previousmode == 3 then
            CustomAttachFx(inst, "statue_transition_2")
        end

        inst.soundsname = "willow"

        removetrailtask(inst, "modetrailtask")

        if inst.fx_fullmode then
            inst.fx_fullmode:Remove()
            inst.fx_fullmode = nil
        end
    end

    if currentmode == 0 then
        inst.components.skinner:SetSkinName("musha_none")
    end

    if currentmode == 1 then
        inst.components.skinner:SetSkinName("musha_full")
    end

    if currentmode == 2 then
        inst:RemoveEventCallback("hungerdelta", decidenormalorfull)
        CustomAttachFx(inst, "electricchargedfx")
        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.soundsname = "winnie"

        -- CustomAttachFx(inst, "fx_fullmode", 30, nil)

        inst.fx_fullmode = SpawnPrefab("fx_fullmode")
        inst.fx_fullmode.entity:SetParent(inst.entity)
        inst.fx_fullmode.Transform:SetPosition(0, -0.1, 0)
        -- inst.fx_fullmode.Follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, -30, 40, -0.1)
        -- if not inst.plantpool then
        --     inst.plantpool = { 1, 2, 3, 4 }
        --     for i = #inst.plantpool, 1, -1 do
        --         --randomize in place
        --         table.insert(inst.plantpool, table.remove(inst.plantpool, math.random(i)))
        --     end
        -- end
        -- inst.modetrailtask = inst:DoPeriodicTask(.25, addvalkyrietrailfx)
    end

    if currentmode == 3 then
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
    inst:decidenormalorfull()
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

    -- Codex Umbra
    inst:AddTag("shadowmagic")

    -- Able to craft and use Warly's cooking kit
    inst:AddTag("masterchef") -- Craft and use cooking kit
    inst:AddTag("professionalchef") -- Make spices
    inst:AddTag("expertchef") -- No damage when cooking on fire

    -- Able to craft and use Winona's tools
    inst:AddTag("handyperson")

    -- Able to craft balloons
    inst:AddTag("balloonomancer")

    -- Additional animes
    inst.AnimState:AddOverrideBuild("player_idles_warly")
    inst.AnimState:AddOverrideBuild("player_idles_wes")

    -- Minimap icon
    inst.MiniMapEntity:SetIcon("musha_mapicon.tex")

    -- Common attributes
    inst.customidleanim = "idle_wathgrithr"
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

    -- Petleash
    inst.components.petleash:SetMaxPets(TUNING.musha.maxpets)
    -- inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    -- inst.components.petleash:SetOnDespawnFn(OnDespawnPet)

    -- Food bonus
    inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_LARGE)

    -- Common attributes

    -- Character specific attributes
    inst.mode = net_tinybyte(inst.GUID, "musha.mode", "modechange") -- 0: normal, 1: full, 2: valkyrie, 3: berserk
    inst.mode:set_local(0) -- Force to trigger dirty event on next :set()
    inst._mode = 0 -- Store previous mode
    inst.decidenormalorfull = decidenormalorfull
    inst.toggle_valkyrie = toggle_valkyrie
    inst.toggle_berserk = toggle_berserk

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

---------------------------------------------------------------------------------------------------------

-- Set up remote procedure calls for client side
AddModRPCHandler("musha", "toggle_valkyrie", toggle_valkyrie)
AddModRPCHandler("musha", "toggle_berserk", toggle_berserk)

---------------------------------------------------------------------------------------------------------

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)
