local MakePlayerCharacter = require("prefabs/player_common")
local UserCommands = require("usercommands")

---------------------------------------------------------------------------------------------------------

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),

    -- Musha character textures
    Asset("ANIM", "anim/musha/musha.zip"),
}

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.MUSHA = {
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

---------------------------------------------------------------------------------------------------------

-- Bonus damage
local function BonusDamageFn(inst, target, damage, weapon)
    -- return (target:HasTag("") and TUNING.EXTRADAMAGE) or 0
    return 0
end

---------------------------------------------------------------------------------------------------------

-- Spells

-- Common
local function OnCastSpellToSelf(inst)
end

-- Freezing spell
local function FreezingSpell(inst)
    if inst.components.mana.current < TUNING.musha.skills.freezingspell.maxmanacost then
        inst.components.talker:Say(STRINGS.musha.lack_of_mana)
        inst.sg:GoToState("mindcontrolled_pst")
        return
    end

    local validtargets = 0
    local must_tags = { "_combat" }
    local ignore_tags = { "freeze_cooldown", "nofreeze", "companion", "musha_companion", "player" }

    CustomDoAOE(inst, TUNING.musha.skills.freezingspell.range, must_tags, ignore_tags, function(v)
        if v.components.freezable and not v.components.freezable:IsFrozen() then
            v.components.freezable:AddColdness(4) -- Freeze
            v.components.freezable:SpawnShatterFX()
            if v.components.freezable:IsFrozen() then
                CustomOnFreeze(v)
            else
                v:AddDebuff("freezingspell", "debuff_slowdown") -- Add slowdown debuff if not frozen
            end
            validtargets = validtargets + 1
        elseif not v.components.freezable and v:HasTag("locomotor") then
            v:AddDebuff("freezingspell", "debuff_slowdown") -- Add slowdown debuff if not freezable
            validtargets = validtargets + 1
        end
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, fn)

    inst.components.mana:DoDelta(-
        math.min(TUNING.musha.skills.freezingspell.manacost * validtargets, TUNING.musha.skills.freezingspell.maxmanacost))
    inst.components.talker:Say(STRINGS.musha.skills.manaspells.freezingspell.cast)
    OnCastSpellToSelf(inst)
end

---------------------------------------------------------------------------------------------------------

-- Pet leash related

local function ShadowMinionFx(pet)
    local x, y, z = pet.Transform:GetWorldPosition()
    SpawnPrefab("statue_transition_2").Transform:SetPosition(x, y, z)
end

local function KillPet(pet)
    pet.components.health:Kill()
end

local function OnSpawnPet(inst, pet)
    if pet:HasTag("shadowminion") then -- Shadow Musha and Maxwell's shadow puppets
        pet:DoTaskInTime(0, ShadowMinionFx) -- Delayed in case we need to relocate for migration spawning

        if not (inst.components.health:IsDead() or inst:HasTag("playerghost")) then
            if not pet:HasTag("musha_companion") then -- Shadow maxwell
                if not inst.components.builder.freebuildmode then
                    inst.components.sanity:AddSanityPenalty(pet,
                        TUNING.SHADOWWAXWELL_SANITY_PENALTY[string.upper(pet.prefab)])
                end
                inst:ListenForEvent("onremove", inst._onpetlost, pet)
            end
        elseif pet._killtask == nil then
            pet._killtask = pet:DoTaskInTime(math.random(), KillPet)
        end
    elseif inst._OnSpawnPet ~= nil then
        inst:_OnSpawnPet(pet)
    end
end

local function OnDespawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
        ShadowMinionFx(pet)
        pet:Remove()
    elseif inst._OnDespawnPet ~= nil then
        inst:_OnDespawnPet(pet)
    end
end

local function OnDeathForPetLeash(inst)
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if (not v:HasTag("musha_companion")) and v:HasTag("shadowminion") and v._killtask == nil then
            v._killtask = v:DoTaskInTime(math.random(), KillPet)
        end
    end
end

local function OnRerollForPetLeash(inst)
    local todespawn = {}
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("musha_companion") or v:HasTag("shadowminion") then
            table.insert(todespawn, v)
        end
    end
    for i, v in ipairs(todespawn) do
        inst.components.petleash:DespawnPet(v)
    end
end

---------------------------------------------------------------------------------------------------------

-- Companion Orders

-- Enable/disable hotkeys
local function SwitchKeyBindings(inst)
    if inst.companionhotkeysenabled then
        inst.companionhotkeysenabled = false
        inst.components.talker:Say(STRINGS.musha.switchkeybindings_off)
        UserCommands.RunTextUserCommand("no", inst, false)
    else
        inst.companionhotkeysenabled = true
        inst.components.talker:Say(STRINGS.musha.switchkeybindings_on)
        UserCommands.RunTextUserCommand("wave", inst, false)
    end
end

-- Order shadow musha to toggle follow-only mode
local function DoShadowMushaOrder(inst)
    if not inst.companionhotkeysenabled then
        return
    elseif inst.shadowmushafollowonly then
        inst.shadowmushafollowonly = false
        inst.components.talker:Say(STRINGS.musha.shadowmushaorder_resume)
        UserCommands.RunTextUserCommand("rude", inst, false)
        for k, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") then
                v:RemoveTag("followonly")
                v.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, "followonlybuff")
            end
        end
    else
        inst.shadowmushafollowonly = true
        inst.components.talker:Say(STRINGS.musha.shadowmushaorder_follow)
        UserCommands.RunTextUserCommand("happy", inst, false)
        for k, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") and not v:HasTag("followonly") then
                v:AddTag("followonly")
                v.components.combat.externaldamagetakenmultipliers:SetModifier(inst,
                    TUNING.musha.creatures.shadowmusha.followonlydamagetakenmultplier, "followonlybuff")
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Sleep

local function ToggleSleep(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") then
        return
    end

    inst:DecideNormalOrFull()
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
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_normal)
        target.components.combat:GetAttacked(inst, extradamage * 0.5, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
        CustomAttachFx(target, "statue_transition")
    else
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_perfect)
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
        inst:RemoveTag("areaattack")
        inst.components.sanity:DoDelta(-TUNING.musha.sneaksanitycost)
        inst.components.talker:Say(STRINGS.musha.skills.sneak.start)
        inst.components.colourtweener:StartTween({ 0.3, 0.3, 0.3, 1 }, 0)
        CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))

        inst.task_entersneak = inst:DoTaskInTime(4, function()
            if not inst:HasTag("sneaking") then return end
            inst:AddTag("notarget")
            inst.components.talker:Say(STRINGS.musha.skills.sneak.success)
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
                inst.task_sneakspeedbooststaminacost = CustomSetModifier(inst.components.stamina.modifiers, inst, -10,
                    "sneakspeedboost", TUNING.musha.sneakspeedboostduration)
            end

            inst:ListenForEvent("onattackother", BackStab)
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
    inst:AddTag("areaattack")
    inst:RemoveEventCallback("onattackother", BackStab)
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
local function ToggleValkyrie(inst)
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
local function ToggleBerserk(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()
    if previousmode == 0 or previousmode == 1 then
        inst.activateberserk:push()
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

-- OnAttack fn for berserk mode
local function BerserkOnAttackOther(inst, data)
    local target = data.target
    local weapon = data.weapon

    if inst:HasTag("areaattack") then
        local range = weapon and weapon:HasTag("areaattack") and 1.5 * TUNING.musha.areaattackrange
            or TUNING.musha.areaattackrange
        local excludetags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost",
            "wall", "companion", "musha_companion" }

        inst.components.combat:DoAreaAttack(target, range, weapon, nil, nil, excludetags) -- Note: DoAreaAttack(target, range, weapon, validfn, stimuli, excludetags)

        local fx = SpawnPrefab("groundpoundring_fx")
        local scale = 0.4 + 0.066 * range
        fx.Transform:SetScale(scale, scale, scale)
        fx.Transform:SetPosition(target:GetPosition():Get())
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
local function OnModeChange(inst)
    local previousmode = inst._mode
    local currentmode = inst.mode:value()

    if previousmode == 1 and currentmode ~= 1 then
        inst:PushEvent("stopsmallhealthregen", inst) -- Health badge arrow
    end

    if currentmode == 1 then
        inst:PushEvent("startsmallhealthregen", inst) -- Health badge arrow
    end

    if not TheWorld.ismastersim then
        inst._mode = currentmode -- Update previous mode on client side
        return
    end

    -- Remove attributes obtained from previous mode
    if previousmode == 1 and currentmode ~= 1 then
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fullmodebuff")
        inst.components.sanity.externalmodifiers:RemoveModifier(inst, "fullmodebuff")
        inst.components.hunger.burnratemodifiers:RemoveModifier(inst, "fullmodebuff")
        inst.components.stamina.modifiers:RemoveModifier(inst, "fullmodebuff")
        CustomCancelTask(inst.task_fullmodehealthregen)
        CustomRemoveEntity(inst.fx_fullmode)
    end

    if previousmode == 2 and currentmode ~= 2 then
        inst:RemoveTag("stronggrip")
        inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, "valkyriebuff") -- Note: SourceModifierList:RemoveModifier(source, key)
        inst.components.health.externalabsorbmodifiers:RemoveModifier(inst, "valkyriebuff")
        inst.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "valkyriebuff")
        inst:RemoveEventCallback("freeze", UnfreezeOnFreeze)
        CustomCancelTask(inst.modetrailtask)

        CustomAttachFx(inst, "electrichitsparks")
        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    if previousmode == 3 and currentmode ~= 3 then
        if inst:HasTag("sneaking") then
            inst:RemoveSneakEffects()
            inst.components.sanity:DoDelta(TUNING.musha.sneaksanitycost)
        else
            CustomAttachFx(inst, "statue_transition_2") -- Avoid dupulicate fx
        end
        inst:RemoveTag("areaattack") -- Must be removed after inst:RemoveSneakEffects()
        inst:RemoveEventCallback("onattackother", BerserkOnAttackOther)
        CustomCancelTask(inst.modetrailtask)

        for k, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") and not v:HasTag("shadowvalkyrie") then
                v:DoTaskInTime(math.random() * 0.5 + 0.5,
                    function() -- Delay for at least 0.5 seconds to make sure the activate event is triggered
                        v:PushEvent("shadowberserk_quit")
                    end)
            end
        end

        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    -- Set new attributes for new mode
    if currentmode == 0 then
        inst.components.skinner:SetSkinName("musha_none")
        inst.customidleanim = "idle_warly"
        inst.soundsname = "willow"
    end

    if currentmode == 1 then
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fullmodebuff",
            TUNING.musha.fullmodespeedboost) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier)
        inst.components.sanity.externalmodifiers:SetModifier(inst, TUNING.musha.fullmodesanityregen, "fullmodebuff")
        inst.components.hunger.burnratemodifiers:SetModifier(inst, TUNING.musha.fullmodehungerdrain, "fullmodebuff")
        inst.components.stamina.modifiers:SetModifier(inst, TUNING.musha.fullmodestaminaregen, "fullmodebuff")
        inst.task_fullmodehealthregen = inst:DoPeriodicTask(1, function()
            if not inst.components.health:IsDead() then
                inst.components.health:DoDelta(TUNING.musha.fullmodehealthregen, true, "regen")
            end
        end, nil, inst.components.health)

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

        inst:AddTag("areaattack")
        inst:ListenForEvent("onattackother", BerserkOnAttackOther)

        inst.shadowmushafollowonly = false
        for k, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") then
                v:RemoveTag("followonly")
                v.components.health.externalabsorbmodifiers:RemoveModifier(inst, "followonlybuff")
                if not v:HasTag("shadowvalkyrie") then
                    v:DoTaskInTime(math.random() * 0.5, function()
                        v:PushEvent("shadowberserk_activate")
                    end)
                end
            end
        end

        CustomAttachFx(inst, "statue_transition")
        inst.components.skinner:SetSkinName("musha_berserk")
        inst.customidleanim = "idle_winona"
        inst.soundsname = "wendy"
        inst.modetrailtask = inst:DoPeriodicTask(6 * FRAMES, AddBerserkTrailFx, 2 * FRAMES)
    end

    inst._mode = currentmode -- Update previous mode
end

---------------------------------------------------------------------------------------------------------

-- Fatigue level related

local function DecideFatigueLevel(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or
        inst.sg:HasStateTag("ghostbuild") or inst.sg:HasStateTag("nomorph") then
        return
    end

    local pct = inst.components.fatigue:GetPercent()

    if pct < 0.1 then
        inst.fatiguelevel:set(0)
    elseif pct < 0.4 then
        inst.fatiguelevel:set(1)
    elseif pct < 0.6 then
        inst.fatiguelevel:set(2)
    elseif pct < 0.8 then
        inst.fatiguelevel:set(3)
    else
        inst.fatiguelevel:set(4)
    end
end

local function OnFatigueLevelChange(inst)
    local fatiguelevel = inst.fatiguelevel:value()

    if fatiguelevel == 0 then
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguelevel")
    elseif fatiguelevel == 1 then
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguelevel")
    elseif fatiguelevel == 2 then
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", 0.85)
    elseif fatiguelevel == 3 then
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", 0.7)
    elseif fatiguelevel == 4 then
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", 0.4)
    end
end

---------------------------------------------------------------------------------------------------------

-- When level up
local function OnLevelUp(inst, data)
    inst.skills.freezingspell      = data.lvl >= TUNING.musha.leveltounlockskill.freezingspell and true or nil
    inst.skills.manashield         = data.lvl >= TUNING.musha.leveltounlockskill.manashield and true or nil
    inst.skills.valkyrie           = data.lvl >= TUNING.musha.leveltounlockskill.valkyrie and true or nil
    inst.skills.manashield_passive = data.lvl >= TUNING.musha.leveltounlockskill.manashield_passive and true or nil
    inst.skills.berserk            = data.lvl >= TUNING.musha.leveltounlockskill.berserk and true or nil
    inst.skills.thunderspell       = data.lvl >= TUNING.musha.leveltounlockskill.thunderspell and true or nil
    inst.skills.shadowspell        = data.lvl >= TUNING.musha.leveltounlockskill.shadowspell and true or nil
    inst.skills.sneak              = data.lvl >= TUNING.musha.leveltounlockskill.sneak and true or nil
    inst.skills.sporebomb          = data.lvl >= TUNING.musha.leveltounlockskill.sporebomb and true or nil
    inst.skills.shadowshield       = data.lvl >= TUNING.musha.leveltounlockskill.shadowshield and true or nil
    inst.skills.instantcast        = data.lvl >= TUNING.musha.leveltounlockskill.instantcast and true or nil
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function OnBecameHuman(inst)
    inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    inst:ListenForEvent("fatiguedelta", DecideFatigueLevel)
    inst:DecideNormalOrFull()
    inst:DecideFatigueLevel()
end

-- When the character turn into a ghost
local function OnBecameGhost(inst)
    inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
    inst:RemoveEventCallback("fatiguedelta", DecideFatigueLevel)
    inst.mode:set(0)
    inst.fatiguelevel:set(0)
end

-- When save game progress
local function OnSave(inst, data)
end

-- When preload (before loading components)
local function OnPreload(inst, data)
end

-- When loading or spawning the character
local function OnLoad(inst)
    if inst:HasTag("playerghost") then
        OnBecameGhost(inst)
    else
        OnBecameHuman(inst)
    end

    OnLevelUp(inst, inst.components.leveler)
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

    -- Character specific attributes
    inst.mode = net_tinybyte(inst.GUID, "musha.mode", "modechange") -- 0: normal, 1: full, 2: valkyrie, 3: berserk
    inst._mode = 0 -- Store previous mode
    inst.fatiguelevel = net_tinybyte(inst.GUID, "musha.fatiguelevel", "fatiguelevelchange")
    inst.activateberserk = net_event(inst.GUID, "activateberserk") -- Handler set in SG
    inst.castmanaspell = net_event(inst.GUID, "castmanaspell") -- Handler set in SG

    -- Event handlers
    inst:ListenForEvent("modechange", OnModeChange)
end

---------------------------------------------------------------------------------------------------------

-- This initializes for the server only. Components are added here.
local function master_postinit(inst)
    -- Leveler
    inst:AddComponent("leveler")
    inst.components.leveler:SetMaxExperience(TUNING.musha.maxexperience)
    inst.components.leveler:SetMaxLevel(TUNING.musha.maxlevel)
    inst.components.leveler.exprate = TUNING.musha.exprate
    inst.components.leveler.exp_to_level = TUNING.musha.exp_to_level

    -- Mana
    inst:AddComponent("mana")

    -- Fatigue
    inst:AddComponent("fatigue")

    -- Stamina
    inst:AddComponent("stamina")

    -- Cast spell to self
    inst:AddComponent("spelltarget")

    -- Read books
    inst:AddComponent("reader")

    -- Stats
    inst.components.health:SetMaxHealth(TUNING.musha.health)
    inst.components.hunger:SetMax(TUNING.musha.hunger)
    inst.components.sanity:SetMax(TUNING.musha.sanity)

    -- Combat
    inst.components.combat.damagemultiplier = TUNING.musha.damagemultiplier
    inst.components.combat.areahitdamagepercent = TUNING.musha.areahitdamagepercent
    inst.components.combat.bonusdamagefn = BonusDamageFn

    -- Petleash
    inst._onpetlost = function(pet) inst.components.sanity:RemoveSanityPenalty(pet) end
    inst._OnSpawnPet = inst.components.petleash.onspawnfn
    inst._OnDespawnPet = inst.components.petleash.ondespawnfn
    inst.components.petleash:SetMaxPets(TUNING.musha.maxpets)
    inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    inst.components.petleash:SetOnDespawnFn(OnDespawnPet)

    -- Food bonus
    inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_LARGE)

    -- Common attributes
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
    inst.OnPreLoad = OnPreload -- FIRST, the entity runs its PreLoad method.
    inst.OnLoad = OnLoad -- SECOND, the entity runs the OnLoad function of its components. THIRD, the entity runs its own OnLoad method.
    inst.OnSave = OnSave
    inst.OnNewSpawn = OnLoad

    -- Character specific attributes
    inst.mode:set_local(0) -- Force to trigger dirty event on next :set()
    inst.fatiguelevel:set_local(0) -- Force to trigger dirty event on next :set()
    inst.skills = {}
    inst.companionhotkeysenabled = true
    inst.shadowmushafollowonly = false
    inst.plantpool = { 1, 2, 3, 4 }
    inst.DecideNormalOrFull = DecideNormalOrFull
    inst.DecideFatigueLevel = DecideFatigueLevel
    inst.RemoveSneakEffects = RemoveSneakEffects
    inst.FreezingSpell = FreezingSpell

    -- Event handlers
    inst:ListenForEvent("levelup", OnLevelUp)
    inst:ListenForEvent("fatiguelevelchange", OnFatigueLevelChange)
    inst:ListenForEvent("death", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnBecameGhost)
    inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
    inst:ListenForEvent("ms_playerreroll", OnRerollForPetLeash)
end

-- Set up remote procedure calls for client side
AddModRPCHandler("musha", "togglevalkyrie", ToggleValkyrie)
AddModRPCHandler("musha", "toggleberserk", ToggleBerserk)
AddModRPCHandler("musha", "togglesleep", ToggleSleep)
AddModRPCHandler("musha", "switchkeybindings", SwitchKeyBindings)
AddModRPCHandler("musha", "doshadowmushaorder", DoShadowMushaOrder)

---------------------------------------------------------------------------------------------------------

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)
