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

---------------------------------------------------------------------------------------------------------

-- Sneak

local function BackStab(inst, data)
    inst:RemoveSneakEffects()
    inst.components.sanity:DoDelta(TUNING.musha.sneaksanitycost)
    local target = data.target
    local extradamage = TUNING.musha.backstabbasedamage + 100 * math.floor(inst.components.leveler.lvl / 5)
    if not (target.components and target.components.combat) then
        inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)
    elseif target.sg:HasStateTag("attack") or target.sg:HasStateTag("moving") or target.sg:HasStateTag("frozen") then
        inst.components.talker:Say(STRINGS.musha.skills.backstab_normal)
        target.components.combat:GetAttacked(inst, extradamage * 0.5, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
        CustomAttachFx(target, "statue_transition")
    else
        inst.components.talker:Say(STRINGS.musha.skills.backstab_perfect)
        target.components.combat:GetAttacked(inst, extradamage, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
        CustomAttachFx(target, "statue_transition")
        CustomAttachFx(inst, "nightsword_curve_fx")
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sneakspeedboost",
            TUNING.musha.sneakspeedboost) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier)
        inst.task_cancelsneakspeedboost = inst:DoTaskInTime(2, function()
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
            inst.task_cancelsneakspeedboost = nil
        end)
    end
end

local function SneakFailed(inst, data)
    inst:RemoveSneakEffects()
    inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_ATTACKED)
end

local function StartSneaking(inst)
    if inst.skills.sneak and inst.components.sanity.current >= TUNING.musha.sneaksanitycost then
        inst:AddTag("sneaking")
        inst:RemoveTag("scarytoprey")
        inst.components.sanity:DoDelta(-TUNING.musha.sneaksanitycost)
        inst.components.talker:Say(STRINGS.musha.skills.startsneaking)
        inst.components.colourtweener:StartTween({ 0.3, 0.3, 0.3, 1 }, 0)
        CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))

        inst.task_entersneak = inst:DoTaskInTime(4, function()
            if not inst:HasTag("sneaking") then return end
            inst:AddTag("notarget")
            inst.components.talker:Say(STRINGS.musha.skills.sneaksucceed)
            inst.components.colourtweener:StartTween({ 0.1, 0.1, 0.1, 1 }, 0)
            CustomAttachFx(inst, "statue_transition")

            local x, y, z = inst.Transform:GetWorldPosition()
            local must_tags = { "_combat" }
            local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead" }
            local targets = TheSim:FindEntities(x, y, z, 12, must_tags, ignore_tags) -- Note: FindEntities(x, y, z, range, must_tags, ignore_tags)
            if targets then
                for k, v in pairs(targets) do
                    if v.components.combat and v.components.combat.target == inst then
                        v.components.combat.target = nil
                    end
                end
            end

            if inst.components.stamina.current >= 50 then
                inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sneakspeedboost",
                    TUNING.musha.sneakspeedboost) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier)
                inst.task_cancelsneakspeedboost = inst:DoTaskInTime(TUNING.musha.sneakspeedboostduration, function()
                    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
                end)
                inst.task_sneakspeedbooststaminacost = inst:CustomDoPeriodicTask(
                    TUNING.musha.sneakspeedboostduration, 0.5, function()
                        inst.components.stamina:DoDelta(-5)
                    end, 0.5)
            end

            inst:ListenForEvent("onhitother", BackStab)
        end)

        inst:ListenForEvent("attacked", SneakFailed)
    else
        if not inst.skills.sneak then
            inst.components.talker:Say(STRINGS.musha.lack_of_exp)
        elseif inst.components.sanity.current < TUNING.musha.sneaksanitycost then
            inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
        end

        if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
            inst.sg:GoToState("repelled")
        else
            inst.sg:GoToState("mindcontrolled_pst")
        end
    end
end

local function StopSneaking(inst)
    inst:RemoveSneakEffects()
    inst.components.sanity:DoDelta(TUNING.musha.sneaksanitycost)
    inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)
end

local function RemoveSneakEffects(inst)
    inst:RemoveTag("sneaking")
    inst:RemoveTag("notarget")
    inst:AddTag("scarytoprey")
    inst:RemoveEventCallback("onhitother", BackStab)
    inst:RemoveEventCallback("attacked", SneakFailed)
    CustomCancelTask(inst.task_sneakspeedbooststaminacost)
    CustomCancelTask(inst.task_cancelsneakspeedboost)
    CustomCancelTask(inst.task_entersneak)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
    inst.components.colourtweener:StartTween({ 1, 1, 1, 1 }, 0)
    CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))
end

---------------------------------------------------------------------------------------------------------

-- Character mode related

-- Decide normal mode or full mode
local function DecideNormalOrFull(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or
        inst.sg:HasStateTag("ghostbuild") or inst.sg:HasStateTag("nomorph") then
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
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()
    if previousmode == 0 or previousmode == 1 then
        inst.mode:set(2)
    elseif previousmode == 2 then
        inst:DecideNormalOrFull()
    end
end

-- Toggle berserk mode
local function toggle_berserk(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()
    if previousmode == 0 or previousmode == 1 then
        inst:PushEvent("activateberserk")
    elseif previousmode == 3 and not inst:HasTag("sneaking") then
        StartSneaking(inst)
    elseif previousmode == 3 and inst:HasTag("sneaking") then
        StopSneaking(inst)
    end
end

-- Resist freeze
local function UnfreezeOnFreeze(inst)
    inst.components.freezable:Unfreeze()
end

-- Valkyrie trailing fx (Wormwood blooming)
local PLANTS_RANGE = 1
local MAX_PLANTS = 18
local PLANTFX_TAGS = { "wormwood_plant_fx" }
local function AddValkyrieTrailFx(inst)
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

-- Berserk trailing fx (ancient cane)
local function AddBerserkTrailFx(inst)
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

-- When character mode changes
local function onmodechange(inst)
    local previousmode = inst._mode
    local currentmode = inst.mode:value()

    -- Remove attributes obtained from previous mode
    if previousmode == 1 and currentmode ~= 1 then
        CustomRemoveEntity(inst.fx_fullmode)
    end

    if previousmode == 2 and currentmode ~= 2 then
        inst:RemoveTag("stronggrip")
        CustomCancelTask(inst.modetrailtask)
        inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, "valkyriebuff") -- Note: SourceModifierList:RemoveModifier(source, key)
        inst.components.health.externalabsorbmodifiers:RemoveModifier(inst, "valkyriebuff")
        inst.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "valkyriebuff")
        inst:RemoveEventCallback("freeze", UnfreezeOnFreeze)
        CustomAttachFx(inst, "electrichitsparks")
        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    if previousmode == 3 and currentmode ~= 3 then
        CustomCancelTask(inst.modetrailtask)
        CustomAttachFx(inst, "statue_transition_2")
        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    -- Set new attributes for new mode
    if currentmode == 0 then
        inst.components.skinner:SetSkinName("musha_none")
        inst.customidleanim = "idle_warly"
        inst.soundsname = "willow"
    end

    if currentmode == 1 then
        inst.components.skinner:SetSkinName("musha_full")
        inst.customidleanim = "idle_warly"
        inst.soundsname = "willow"

        inst.fx_fullmode = SpawnPrefab("fx_fullmode")
        inst.fx_fullmode.entity:SetParent(inst.entity)
        inst.fx_fullmode.Transform:SetPosition(0, -0.1, 0)
    end

    if currentmode == 2 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
        inst:AddTag("stronggrip")
        inst.components.combat.externaldamagemultipliers:SetModifier(inst, TUNING.musha.valkyrieattackboost,
            "valkyriebuff")
        inst.components.health.externalabsorbmodifiers:SetModifier(inst, TUNING.musha.valkyriedefenseboost,
            "valkyriebuff")
        inst.components.health.externalfiredamagemultipliers:SetModifier(inst, 0, "valkyriebuff") -- Note: SourceModifierList:SetModifier(source, m, key)     
        inst:ListenForEvent("freeze", UnfreezeOnFreeze)
        CustomAttachFx(inst, "electricchargedfx")
        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.customidleanim = "idle_wathgrithr"
        inst.soundsname = "winnie"
        inst.modetrailtask = inst:DoPeriodicTask(.25, AddValkyrieTrailFx)
    end

    if currentmode == 3 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
        CustomAttachFx(inst, "statue_transition")
        inst.components.skinner:SetSkinName("musha_berserk")
        inst.customidleanim = "idle_winona"
        inst.soundsname = "wendy"
        inst.modetrailtask = inst:DoPeriodicTask(6 * FRAMES, AddBerserkTrailFx, 2 * FRAMES)
    end

    inst._mode = currentmode -- Update previous mode
end

---------------------------------------------------------------------------------------------------------

-- When level up
local function onlevelup(inst, data)
    inst.skills.freezingspell      = data.lvl >= TUNING.musha.leveltounlockskill.freezingspell and true or nil
    inst.skills.manashield         = data.lvl >= TUNING.musha.leveltounlockskill.manashield and true or nil
    inst.skills.valkyrie           = data.lvl >= TUNING.musha.leveltounlockskill.valkyrie and true or nil
    inst.skills.manashield_passive = data.lvl >= TUNING.musha.leveltounlockskill.manashield_passive and true or nil
    inst.skills.berserk            = data.lvl >= TUNING.musha.leveltounlockskill.berserk and true or nil
    inst.skills.thunderspell       = data.lvl >= TUNING.musha.leveltounlockskill.thunderspell and true or nil
    inst.skills.sneak              = data.lvl >= TUNING.musha.leveltounlockskill.sneak and true or nil
    inst.skills.sporebomb          = data.lvl >= TUNING.musha.leveltounlockskill.sporebomb and true or nil
    inst.skills.shadowshield       = data.lvl >= TUNING.musha.leveltounlockskill.shadowshield and true or nil
    inst.skills.instantcast        = data.lvl >= TUNING.musha.leveltounlockskill.instantcast and true or nil
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function onbecamehuman(inst)
    inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    inst:DecideNormalOrFull()
end

-- When the character turn into a ghost
local function onbecameghost(inst)
    inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
    inst.mode:set(0)
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

    onlevelup(inst, inst.components.leveler)
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

    -- Minimap icon
    inst.MiniMapEntity:SetIcon("musha_mapicon.tex")

    -- Common attributes
    inst.customidleanim = "idle_warly"
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

    -- Fatigue
    inst:AddComponent("fatigue")
    inst.components.fatigue:SetRate(TUNING.musha.fatiguerate)

    -- Stamina
    inst:AddComponent("stamina")
    inst.components.stamina:SetRate(TUNING.musha.staminarate)

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
    inst.skills = {}
    inst.DecideNormalOrFull = DecideNormalOrFull
    inst.toggle_valkyrie = toggle_valkyrie
    inst.toggle_berserk = toggle_berserk
    inst.RemoveSneakEffects = RemoveSneakEffects

    inst.plantpool = { 1, 2, 3, 4 }
    -- for i = #inst.plantpool, 1, -1 do
    --     --randomize in place
    --     table.insert(inst.plantpool, table.remove(inst.plantpool, math.random(i)))
    -- end

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
