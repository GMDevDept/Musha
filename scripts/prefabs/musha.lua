local MakePlayerCharacter = require("prefabs/player_common")
local UserCommands = require("usercommands")
local Emotes = require("src/emotes")
local Musics = require("src/musics")

---------------------------------------------------------------------------------------------------------

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/musha/musha.zip"), -- Character texture
}

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.MUSHA = {
    "tentaclespike",
    "minotaurhorn",
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

-- Sleep

local function ToggleSleep(inst)
    -- Can interrupt sleep (wake up)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        (inst.sg:HasStateTag("musha_nointerrupt") and not inst.sg:HasStateTag("sleeping")) then
        return
    end

    if inst.components.rider:IsRiding() then
        inst.components.rider:Dismount()
    elseif not inst.sg:HasStateTag("sleeping") and not (inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("running")) then
        inst.components.talker:Say(STRINGS.musha.sleep.fail.busy)
    elseif not inst.sg:HasStateTag("sleeping") and (inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("running")) then
        local indanger
        local hounded = TheWorld.components.hounded

        if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
            indanger = true
        else
            local must_tags = { "_combat" }
            local ignore_tags = { "player", "companion", "musha_companion" }

            indanger = FindEntity(inst, 14, function(target)
                return target:HasTag("monster") or target:HasTag("hostile")
                    or (target.components.combat ~= nil and target.components.combat.target == inst)
            end, must_tags, ignore_tags)
        end

        if not inst.LightWatcher:IsInLight() then
            inst.components.talker:Say(STRINGS.musha.sleep.fail.dark)
        elseif inst.components.temperature:GetCurrent() >= 65 then
            inst.components.talker:Say(STRINGS.musha.sleep.fail.hot)
        elseif inst.components.temperature:GetCurrent() <= 0 then
            inst.components.talker:Say(STRINGS.musha.sleep.fail.cold)
        elseif inst.components.hunger:GetPercent() < 0.1 then
            inst.components.talker:Say(STRINGS.musha.sleep.fail.starving)
        elseif indanger ~= nil then
            inst.components.talker:Say(STRINGS.musha.sleep.fail.indanger)
        else
            inst:DecideNormalOrFull()

            local one_of_tags = { "campfire", "yamche" }
            local campfire = FindEntity(inst, 6, function(target)
                return target.components.burnable and target.components.burnable:IsBurning()
            end, nil, nil, one_of_tags)

            if not campfire or TheWorld.state.isday then
                inst.sg:GoToState("knockout")
            else
                if inst.components.temperature:GetCurrent() >= 45 then
                    inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")
                else
                    inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_furry", "bedroll_furry")
                end
                inst.sg:GoToState("bedroll")
            end
        end
    else
        inst.sg:GoToState("wakeup")
    end
end

---------------------------------------------------------------------------------------------------------

-- Treasure sniffing

local function SniffTreasure(inst)
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local treasure = inst.components.treasurehunter:NewStash()
    if treasure ~= nil then
        inst.components.treasurehunter:Reset()
    end
end

local function OnTreasureSniffingReady(inst)
    if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
        return
    end
    inst.components.talker:Say(STRINGS.musha.skills.treasuresniffing.full)
end

---------------------------------------------------------------------------------------------------------

-- Elf melody

-- Trailing fx (Wormwood blooming)
local function AddBloomingTrailFx(inst)
    if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
        return
    end

    local PLANTS_RANGE = 1
    local MAX_PLANTS = 18
    local PLANTFX_TAGS = { "wormwood_plant_fx" }
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

-- Trailing fx (stalker blooming)
local function AddStalkerTrailFx(inst)
    local BLOOM_CHOICES = {
        ["stalker_bulb"] = .5,
        ["stalker_bulb_double"] = .5,
        ["stalker_berry"] = 1,
        ["stalker_fern"] = 8,
    }
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        math.random() * 3,
        8,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return map:IsPassableAtPoint(x1, 0, z1)
                and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                and #TheSim:FindEntities(x1, 0, z1, 2.5, { "stalkerbloom" }) < 4
        end
    )

    if offset ~= nil then
        SpawnPrefab(weighted_random_choice(BLOOM_CHOICES)).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function MelodyOnTimerDone(inst, data)
    if data.name == "cooldown_elfmelody" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.elfmelody.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", MelodyOnTimerDone)
    end
end

local function StopElfMelody(inst, data)
    if data.name == "stopelfmelody_full" or data.name == "stopelfmelody_partial" then
        if data.name == "stopelfmelody_full" then
            inst.components.timer:StartTimer("cooldown_elfmelody", TUNING.musha.skills.elfmelody.full.cooldown)
        elseif data.name == "stopelfmelody_partial" then
            inst.components.timer:StartTimer("cooldown_elfmelody", TUNING.musha.skills.elfmelody.partial.cooldown)
        end
        inst:StopMelodyBuff()
        inst:ListenForEvent("timerdone", MelodyOnTimerDone)
        inst:RemoveEventCallback("timerdone", StopElfMelody)
    end
end

local function StartMelodyBuff(inst, data)
    if data.mode == "full" then
        local music = Musics[math.random(#Musics)]
        inst.SoundEmitter:PlaySound(music, "elfmelody")
        inst.components.mana:DoDelta(TUNING.musha.skills.elfmelody.full.manarecover)
        inst.components.mana.modifiers:SetModifier(inst, TUNING.musha.skills.elfmelody.full.manaregen, "elfmelody")
        inst.components.stamina.modifiers:SetModifier(inst, TUNING.musha.skills.elfmelody.full.staminaregen, "elfmelody")
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "elfmelody",
            TUNING.musha.skills.elfmelody.full.speedboost)
        inst.stalkertrailtask = inst:DoPeriodicTask(3 * FRAMES, AddStalkerTrailFx, 2 * FRAMES)
        inst.components.timer:StartTimer("stopelfmelody_full", TUNING.musha.skills.elfmelody.full.duration)
    elseif data.mode == "partial" then
        inst.components.mana:DoDelta(TUNING.musha.skills.elfmelody.partial.manarecover)
        inst.components.mana.modifiers:SetModifier(inst, TUNING.musha.skills.elfmelody.partial.manaregen, "elfmelody")
        inst.components.stamina.modifiers:SetModifier(inst, TUNING.musha.skills.elfmelody.partial.staminaregen,
            "elfmelody")
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "elfmelody",
            TUNING.musha.skills.elfmelody.partial.speedboost)
        inst.components.timer:StartTimer("stopelfmelody_partial", TUNING.musha.skills.elfmelody.partial.duration)
    end
    CustomAttachFx(inst, "fx_book_fish")
    inst.bloomingtrailtask = inst:DoPeriodicTask(.25, AddBloomingTrailFx)
    inst:ListenForEvent("timerdone", StopElfMelody)
end

local function StopMelodyBuff(inst)
    inst.components.mana.modifiers:RemoveModifier(inst, "elfmelody")
    inst.components.stamina.modifiers:RemoveModifier(inst, "elfmelody")
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "elfmelody")
    inst.SoundEmitter:KillSound("elfmelody")
    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
    CustomCancelTask(inst.bloomingtrailtask)
    CustomCancelTask(inst.stalkertrailtask)
end

local function PlayElfMelody(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("musha_elfmelody") then
        return
    end

    if not inst.components.timer:TimerExists("premelody") then
        local declaration = STRINGS.musha.segmentation .. "\n"
            .. STRINGS.musha.skills.treasuresniffing.progress1
            .. math.floor(inst.components.treasurehunter:GetPercent() * 100)
            .. STRINGS.musha.skills.treasuresniffing.progress2 .. "\n"
            .. STRINGS.musha.skills.elfmelody.progress1
            .. math.floor(inst.components.melody:GetPercent() * 100)
            .. STRINGS.musha.skills.elfmelody.progress2 .. "\n"
            .. STRINGS.musha.segmentation .. "\n"

        if inst.components.treasurehunter:IsReady() then
            if inst.components.rider:IsRiding() then
                declaration = declaration
                    .. STRINGS.musha.skills.treasuresniffing.mount_not_allowed
            else
                declaration = declaration
                    .. STRINGS.musha.skills.treasuresniffing.ask
            end
        elseif inst.components.timer:TimerExists("stopelfmelody_full") or
            inst.components.timer:TimerExists("stopelfmelody_partial") then
            local timeleft = inst.components.timer:GetTimeLeft("stopelfmelody_full") or
                inst.components.timer:GetTimeLeft("stopelfmelody_partial")
            declaration = declaration
                .. STRINGS.musha.skills.ineffect.part1
                .. STRINGS.musha.skills.elfmelody.name
                .. STRINGS.musha.skills.ineffect.part2
                .. STRINGS.musha.skills.ineffect.part3
                .. math.ceil(timeleft)
                .. STRINGS.musha.skills.ineffect.part4 .. "\n"
                .. STRINGS.musha.skills.press_to_confirm
        elseif inst.components.timer:TimerExists("cooldown_elfmelody") then
            declaration = declaration
                .. STRINGS.musha.skills.incooldown.part1
                .. STRINGS.musha.skills.elfmelody.name
                .. STRINGS.musha.skills.incooldown.part2
                .. STRINGS.musha.skills.incooldown.part3
                .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_elfmelody"))
                .. STRINGS.musha.skills.incooldown.part4
        elseif inst.components.melody:IsFull() then
            declaration = declaration
                .. STRINGS.musha.skills.elfmelody.ask_full .. "\n"
                .. STRINGS.musha.skills.press_to_confirm
        elseif inst.components.melody:IsReady() then
            declaration = declaration
                .. STRINGS.musha.skills.elfmelody.ask_part .. "\n"
                .. STRINGS.musha.skills.press_to_confirm
        end

        inst.components.talker:Say(declaration, 4)
        inst.components.timer:StartTimer("premelody", 4)
    else
        inst.components.talker:Say("", nil, true)
        inst.components.timer:SetTimeLeft("premelody", 0)
        if inst.components.treasurehunter:IsReady() then
            if inst.components.rider:IsRiding() then
                inst.components.talker:Say(STRINGS.musha.mount_not_allowed)
                CustomPlayFailedAnim(inst)
            else
                inst.snifftreasure:push()
            end
        elseif inst.components.timer:TimerExists("stopelfmelody_full") or
            inst.components.timer:TimerExists("stopelfmelody_partial") then
            inst.components.timer:SetTimeLeft("stopelfmelody_full", 0)
            inst.components.timer:SetTimeLeft("stopelfmelody_partial", 0)
        elseif inst.components.timer:TimerExists("cooldown_elfmelody") then
            return
        elseif inst.components.melody:IsFull() then
            inst.playfullelfmelody:push()
        elseif inst.components.melody:IsReady() then
            inst.playpartialelfmelody:push()
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Mana Shield

local function ShieldOnAttacked(inst, data)
    inst.fx_manashield:PushEvent("blocked")

    if inst.components.stamina then
        inst.components.stamina:DoDelta(TUNING.musha.skills.manashield.staminacostonhit)
    end

    if inst.shielddurability and inst.shielddurability > 0 then
        local delta = TUNING.musha.skills.manashield.durabilitydamage
        if data.original_damage and data.original_damage > 0 then
            delta = delta + data.original_damage
        end
        inst.shielddurability = inst.shielddurability - delta
        if inst.shielddurability <= 0 then
            inst.components.talker:Say(STRINGS.musha.skills.manashield.broken)
            inst.task_shieldbrokendelay = inst:DoTaskInTime(3, function()
                if inst:HasTag("manashieldactivated") then
                    inst:ShieldOff()
                elseif inst:HasTag("areamanashieldactivated") then
                    inst.components.timer:SetTimeLeft("cancel_manashield_area", 0)
                end
            end)
        end
    end
end

local function ShieldOnTimerDone(inst, data)
    if data.name == "cooldown_manashield" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manashield.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ShieldOnTimerDone)
    end
end

local function SetShieldDurability(inst)
    inst.shielddurability = (TUNING.musha.skills.manashield.durabilitybase +
        TUNING.musha.skills.manashield.durabilitygrowth * inst.components.leveler.lvl)
end

local function ShieldOn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
    inst.fx_manashield = CustomAttachFx(inst, "manashield", 0, Vector3(0.9, 0.9, 0.9), Vector3(0, -0.2, 0)) -- Put before ListenForEvent("attacked", ShieldOnAttacked)

    inst.components.health.externalabsorbmodifiers:SetModifier(inst, 1, "manashield")
    inst:ListenForEvent("attacked", ShieldOnAttacked) -- Caster is not really in invincible state so event is "attacked" instead of "blocked"

    if not inst.skills.manashield_area then
        inst:AddTag("manashieldactivated")
        inst:SetShieldDurability()
        inst.components.mana.modifiers:SetModifier(inst, TUNING.musha.skills.manashield.manaongoingcost, "manashield")
    else
        local validtargets = 0
        local must_tags = { "_combat" }
        local ignore_tags = { "manashieldactivated" }
        local one_of_tags = { "player", "companion", "musha_companion" }

        local function cancel_manashield_area(v, data)
            if data.name == "cancel_manashield_area" then
                v:RemoveTag("areamanashieldactivated")
                if v == inst then -- Only be triggered by caster himself, even not by other musha players
                    v:ShieldOff()
                    v.components.timer:SetTimeLeft("cooldown_manashield", TUNING.musha.skills.manashield_area.cooldown)
                else
                    v:RemoveEventCallback("blocked", ShieldOnAttacked)
                    v.fx_manashield:kill_fx()
                    v.components.health:SetInvincible(false)
                end
                v:RemoveEventCallback("timerdone", cancel_manashield_area)
            end
        end

        CustomDoAOE(inst, TUNING.musha.skills.freezingspell.range, must_tags, ignore_tags, one_of_tags, function(v)
            if not v.components.health then
                return
            elseif not v.components.timer then
                v:AddComponent("timer")
            end

            if not v:HasTag("areamanashieldactivated") then
                v:AddTag("areamanashieldactivated")
                if v ~= inst then
                    v.fx_manashield = CustomAttachFx(v, "manashield", 0, Vector3(0.9, 0.9, 0.9), Vector3(0, -0.2, 0))
                    v:ListenForEvent("blocked", ShieldOnAttacked) -- For other targets except for caster, they are in truely invincible state so event is "blocked" instead of "attacked"
                    v.components.health:SetInvincible(true)
                end
                v.components.timer:StartTimer("cancel_manashield_area", TUNING.musha.skills.manashield_area.duration)
                v:ListenForEvent("timerdone", cancel_manashield_area)
            else
                v.components.timer:SetTimeLeft("cancel_manashield_area", TUNING.musha.skills.manashield_area.duration)
            end
            validtargets = validtargets + 1
        end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

        inst.components.mana:DoDelta(-math.min(TUNING.musha.skills.manashield_area.manacost * validtargets,
            TUNING.musha.skills.manashield_area.maxmanacost))

        inst.bufferedspell = "SetShieldDurability"
        inst.bufferedbookfx = {
            swap_build = "swap_books",
            swap_prefix = "book_horticulture_upgraded",
            def = {
                fx = "fx_book_moon",
                fx_under_prefab = "fx_plants_big_under_book",
                layer_sound = { frame = 30, sound = "wickerbottom_rework/book_spells/upgraded_horticulture" },
            }
        }
        inst.castmanaspell:push()
    end
end

local function ShieldOff(inst)
    inst.components.health.externalabsorbmodifiers:RemoveModifier(inst, "manashield")
    inst.components.mana.modifiers:RemoveModifier(inst, "manashield")
    inst.shielddurability = nil
    inst:RemoveEventCallback("attacked", ShieldOnAttacked)
    CustomCancelTask(inst.task_shieldbrokendelay)

    inst.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
    inst.SoundEmitter:PlaySound("turnoftides/common/together/moon_glass/mine")
    inst.fx_manashield:kill_fx()

    inst:RemoveTag("manashieldactivated")

    inst.components.timer:StartTimer("cooldown_manashield", TUNING.musha.skills.manashield.cooldown)
    inst:ListenForEvent("timerdone", ShieldOnTimerDone)
end

local function ToggleShield(inst)
    -- Can interrupt wake up state
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        (inst.sg:HasStateTag("musha_nointerrupt") and not inst.sg:HasStateTag("waking")) then
        return
    end

    local manarequired = inst.skills.manashield_area and TUNING.musha.skills.manashield_area.maxmanacost or
        TUNING.musha.skills.manashield.manacost

    if inst:HasTag("manashieldactivated") then -- Shield is on (not area shield)
        inst:ShieldOff()
        inst.components.mana:DoDelta(-TUNING.musha.skills.manashield.manacost)
    elseif inst:HasTag("areamanashieldactivated") then -- Area Shield is on (by self or other)
        inst.components.timer:SetTimeLeft("cancel_manashield_area", 0)
    elseif not inst.skills.manashield then
        inst.components.talker:Say(STRINGS.musha.lack_of_exp)
    elseif inst.components.timer:TimerExists("cooldown_manashield") then
        inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
            .. STRINGS.musha.skills.manashield.name
            .. STRINGS.musha.skills.incooldown.part2
            .. STRINGS.musha.skills.incooldown.part3
            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_manashield"))
            .. STRINGS.musha.skills.incooldown.part4)
    elseif inst.components.mana.current < manarequired then
        inst.components.talker:Say(STRINGS.musha.lack_of_mana)
        CustomPlayFailedAnim(inst)
    else
        ShieldOn(inst)
    end
end

---------------------------------------------------------------------------------------------------------

-- Spells

-- Freezing spell
local function FreezingSpellOnTimerDone(inst, data)
    if data.name == "cooldown_freezingspell" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manaspells.freezingspell.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", FreezingSpellOnTimerDone)
    end
end

local function FreezingSpell(inst)
    local validtargets = 0
    local must_tags = { "_combat" }
    local ignore_tags = { "freeze_cooldown", "nofreeze", "companion", "musha_companion", "player" }
    local range = TUNING.musha.skills.freezingspell.range +
        TUNING.musha.skills.freezingspell.rangegrowth * inst.components.leveler.lvl
    local coldness = TUNING.musha.skills.freezingspell.coldness +
        TUNING.musha.skills.freezingspell.coldnessgrowth * math.floor(inst.components.leveler.lvl / 5) * 5

    CustomDoAOE(inst, range, must_tags, ignore_tags, nil, function(v)
        if v.components.freezable and not v.components.freezable:IsFrozen() then
            v.components.freezable:AddColdness(coldness)
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
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

    inst.components.mana:DoDelta(-
        math.min(TUNING.musha.skills.freezingspell.manacost * validtargets, TUNING.musha.skills.freezingspell.maxmanacost))
    inst.components.talker:Say(STRINGS.musha.skills.manaspells.freezingspell.cast)

    inst.components.timer:StartTimer("cooldown_freezingspell", TUNING.musha.skills.freezingspell.cooldown)
    inst:ListenForEvent("timerdone", FreezingSpellOnTimerDone)
end

-- Thunder spell
local function ThunderSpellOnTimerDone(inst, data)
    if data.name == "cooldown_thunderspell" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manaspells.thunderspell.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ThunderSpellOnTimerDone)
    end
end

local function ThunderSpell(inst)
    local validtargets = 0
    local must_tags = { "_combat" }
    local ignore_tags = { "companion", "musha_companion", "player" }
    local range = TUNING.musha.skills.thunderspell.range +
        TUNING.musha.skills.thunderspell.rangegrowth * inst.components.leveler.lvl
    local damage = TUNING.musha.skills.thunderspell.damage +
        TUNING.musha.skills.thunderspell.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5
    local duration = TUNING.musha.skills.thunderspell.duration +
        TUNING.musha.skills.thunderspell.durationgrowth * inst.components.leveler.lvl

    CustomDoAOE(inst, range, must_tags, ignore_tags, nil, function(v)
        v:DoTaskInTime(validtargets * (.3 + math.random() * .2), function()
            v.components.combat:GetAttacked(inst, damage, nil, "electric")
            v:AddDebuff("thunderspell", "debuff_paralysis")
            if v.components.debuffable:GetDebuff("thunderspell") then
                v.components.debuffable:GetDebuff("thunderspell"):SetDuration(duration)
            end
            CustomAttachFx(v, "lightning")
        end)
        validtargets = validtargets + 1
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

    inst.components.mana:DoDelta(-
        math.min(TUNING.musha.skills.thunderspell.manacost * validtargets, TUNING.musha.skills.thunderspell.maxmanacost))
    inst.components.talker:Say(STRINGS.musha.skills.manaspells.thunderspell.cast)

    inst.components.timer:StartTimer("cooldown_thunderspell", TUNING.musha.skills.thunderspell.cooldown)
    inst:ListenForEvent("timerdone", ThunderSpellOnTimerDone)
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
    for _, v in pairs(inst.components.petleash:GetPets()) do
        if (not v:HasTag("musha_companion")) and v:HasTag("shadowminion") and v._killtask == nil then
            v._killtask = v:DoTaskInTime(math.random(), KillPet)
        end
    end
end

local function OnRerollForPetLeash(inst)
    local todespawn = {}
    for _, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("musha_companion") or v:HasTag("shadowminion") then
            table.insert(todespawn, v)
        end
    end
    for _, v in ipairs(todespawn) do
        inst.components.petleash:DespawnPet(v)
    end
end

---------------------------------------------------------------------------------------------------------

-- F1-F12 keybinds

local function NyaNya(inst)
    local emote = Emotes[math.random(#Emotes)]
    inst:PushEvent("emote", emote)
end

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
        NyaNya(inst)
    elseif inst.shadowmushafollowonly then
        inst.shadowmushafollowonly = false
        inst.components.talker:Say(STRINGS.musha.shadowmushaorder_resume, nil, true)
        UserCommands.RunTextUserCommand("rude", inst, false)
        for _, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") then
                v:RemoveTag("followonly")
                v.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, "followonlybuff")
            end
        end
    else
        inst.shadowmushafollowonly = true
        inst.components.talker:Say(STRINGS.musha.shadowmushaorder_follow, nil, true)
        UserCommands.RunTextUserCommand("happy", inst, false)
        for _, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") and not v:HasTag("followonly") then
                v:AddTag("followonly")
                v.components.combat.externaldamagetakenmultipliers:SetModifier(inst,
                    TUNING.musha.creatures.shadowmusha.followonlydamagetakenmultplier, "followonlybuff")
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Lightning strike

local function LightningStrike(inst, data)
    if not data.target then return end

    local target = data.target
    local damage = TUNING.musha.skills.lightningstrike.damage +
        TUNING.musha.skills.lightningstrike.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5

    target.components.combat:GetAttacked(inst, damage, inst.components.combat:GetWeapon(), "electric")
    CustomAttachFx(target, { "lightning", "shock_fx" })
    inst:LightningDischarge()
end

local function LightningRecharge(inst)
    if not inst.components.electricattacks then
        inst:AddComponent("electricattacks")
    end
    inst.components.electricattacks:AddSource("lightningstrike")

    if inst.components.stamina.current >= TUNING.musha.skills.lightningstrike.staminacost then
        inst.components.stamina:DoDelta(-TUNING.musha.skills.lightningstrike.staminacost)
        inst.components.combat:SetRange(TUNING.musha.skills.lightningstrike.range)
    end

    inst.components.timer:StopTimer("lightningrecharge")
    inst:ListenForEvent("onattackother", LightningStrike)
    inst:AddTag("lightningstrikeready")

    inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
    CustomAttachFx(inst, "electricchargedfx")
    inst.task_lightningfx = inst:DoPeriodicTask(2.6, function()
        inst.fx_lightning = CustomAttachFx(inst, "mossling_spin_fx", 0)
    end, 0)
end

local function LightningDischarge(inst)
    inst:RemoveTag("lightningstrikeready")
    inst.components.combat:SetRange(TUNING.DEFAULT_ATTACK_RANGE)
    inst:RemoveEventCallback("onattackother", LightningStrike)

    if inst.components.electricattacks then
        inst.components.electricattacks:RemoveSource("lightningstrike")
    end

    CustomCancelTask(inst.task_lightningfx)
    CustomRemoveEntity(inst.fx_lightning)
    if inst.mode:value() == 2 then
        inst.components.timer:StartTimer("lightningrecharge", TUNING.musha.skills.lightningstrike.cooldown)
    end
end

local function LightningStrikeOnTimerDone(inst, data)
    if data.name == "lightningrecharge" then
        LightningRecharge(inst)
    end
end

---------------------------------------------------------------------------------------------------------

-- Sneak

local function ResetSneakSpeedMultiplier(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sneakspeedboost",
        (TUNING.musha.skills.sneakspeedboost.max + inst.components.stamina:GetPercent()))
end

local function CancelSneakSpeedBoost(inst)
    inst:RemoveEventCallback("staminadelta", ResetSneakSpeedMultiplier)
    inst:RemoveEventCallback("startstaminadepleted", CancelSneakSpeedBoost)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
    inst.components.stamina.modifiers:RemoveModifier(inst, "sneakspeedboost")
    inst:RemoveTag("sneakspeedboost")
end

local function SneakSpeedBoost(inst)
    if inst.components.stamina.current > 0 then
        inst:AddTag("sneakspeedboost")
        ResetSneakSpeedMultiplier(inst)
        inst:ListenForEvent("staminadelta", ResetSneakSpeedMultiplier)
        inst:ListenForEvent("startstaminadepleted", CancelSneakSpeedBoost)
        inst.components.stamina.modifiers:SetModifier(inst, TUNING.musha.skills.sneakspeedboost.staminacost,
            "sneakspeedboost")
    end
end

local function BackStab(inst, data)
    inst:RemoveSneakEffects()
    inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
    local target = data.target
    local extradamage = TUNING.musha.skills.sneak.backstabbasedamage + 50 * math.floor(inst.components.leveler.lvl / 5)
    if not (target.components and target.components.combat) then
        inst.components.talker:Say(STRINGS.musha.skills.sneak.stop)
    elseif target.sg:HasStateTag("attack") or target.sg:HasStateTag("moving") or target.sg:HasStateTag("frozen") then
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_normal)
        target.components.combat:GetAttacked(inst, extradamage, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
        CustomAttachFx(target, "statue_transition")
        CustomAttachFx(inst, "nightsword_curve_fx")
    else
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_perfect)
        target.components.combat:GetAttacked(inst, 2 * extradamage, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
        CustomAttachFx(target, "statue_transition")
        CustomAttachFx(inst, "nightsword_curve_fx")
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sneakspeedboost",
            (TUNING.musha.skills.sneakspeedboost.max + 1)) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier)
        inst:DoTaskInTime(TUNING.musha.skills.sneakspeedboost.backstabbonustime, function()
            if not inst:HasTag("sneakspeedboost") then
                inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
            end
        end)
    end
end

local function SneakFailed(inst, data)
    inst:RemoveSneakEffects()
    inst.components.talker:Say(STRINGS.musha.skills.sneak.failed)
end

local function StartSneaking(inst)
    if not inst.skills.sneak then
        inst.components.talker:Say(STRINGS.musha.lack_of_exp)
    elseif inst.components.sanity.current < TUNING.musha.skills.sneak.sanitycost then
        inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
        CustomPlayFailedAnim(inst)
    elseif inst.skills.sneak and inst.components.sanity.current >= TUNING.musha.skills.sneak.sanitycost then
        inst:AddTag("sneaking")
        inst:RemoveTag("scarytoprey")
        inst:RemoveTag("areaattack")
        inst.components.sanity:DoDelta(-TUNING.musha.skills.sneak.sanitycost)
        inst.components.talker:Say(STRINGS.musha.skills.sneak.start)
        inst:ListenForEvent("attacked", SneakFailed)
        inst.components.colourtweener:StartTween({ 0.3, 0.3, 0.3, 1 }, 0)
        CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))

        inst.task_entersneak = inst:DoTaskInTime(4, function()
            if not inst:HasTag("sneaking") then return end
            inst:AddTag("notarget")

            local x, y, z = inst.Transform:GetWorldPosition()
            local must_tags = { "_combat" }
            local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead" }
            local targets = TheSim:FindEntities(x, y, z, 12, must_tags, ignore_tags) -- Note: FindEntities(x, y, z, range, must_tags, ignore_tags)
            if targets then
                for _, v in pairs(targets) do
                    if v.components.combat and v.components.combat.target == inst then
                        v.components.combat.target = nil
                    end
                end
            end

            inst.components.talker:Say(STRINGS.musha.skills.sneak.success)
            inst:ListenForEvent("onattackother", BackStab)
            inst.components.colourtweener:StartTween({ 0.1, 0.1, 0.1, 1 }, 0)
            CustomAttachFx(inst, "statue_transition")
        end)

        if inst.skills.sneakspeedboost and not inst:HasTag("sneakspeedboost") then
            SneakSpeedBoost(inst)
        end
    end
end

local function StopSneaking(inst)
    inst:RemoveSneakEffects()
    inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
    inst.components.talker:Say(STRINGS.musha.skills.sneak.stop)
end

local function RemoveSneakEffects(inst)
    CancelSneakSpeedBoost(inst)
    inst:RemoveTag("sneaking")
    inst:RemoveTag("notarget")
    inst:AddTag("scarytoprey")
    inst:AddTag("areaattack")
    inst:RemoveEventCallback("onattackother", BackStab)
    inst:RemoveEventCallback("attacked", SneakFailed)
    CustomCancelTask(inst.task_entersneak)
    inst.components.colourtweener:StartTween({ 1, 1, 1, 1 }, 0)
    CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))
end

---------------------------------------------------------------------------------------------------------

-- Character mode related

-- Decide normal mode or full mode
local function DecideNormalOrFull(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("nomorph") then
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
    -- Can interrupt frozen
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        (inst.sg:HasStateTag("musha_nointerrupt") and not inst.sg:HasStateTag("frozen")) or
        inst.sg:HasStateTag("nomorph") then
        return
    end

    local previousmode = inst.mode:value()
    if previousmode == 0 or previousmode == 1 then
        if inst.components.mana.current >= TUNING.musha.skills.lightningstrike.manacost then
            inst.components.mana:DoDelta(-TUNING.musha.skills.lightningstrike.manacost)
            inst.mode:set(2)
        else
            inst.components.talker:Say(STRINGS.musha.lack_of_mana)
            CustomPlayFailedAnim(inst)
        end
    elseif previousmode == 2 then
        if not inst:HasTag("lightningstrikeready") then
            if inst.components.mana.current >= TUNING.musha.skills.lightningstrike.manacost then
                inst.components.mana:DoDelta(-TUNING.musha.skills.lightningstrike.manacost)
                LightningRecharge(inst)
            else
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            end
        else
            inst:DecideNormalOrFull()
        end
    elseif previousmode == 3 and not inst.sg:HasStateTag("frozen") then
        if inst:HasDebuff("poisonspore") then
            local x, y, z = inst.components.debuffable:GetDebuff("poisonspore").Transform:GetWorldPosition()
            inst.components.debuffable:RemoveDebuff("poisonspore")
            inst.fx_poisonspore = SpawnPrefab("poisonspore")
            inst.fx_poisonspore.Transform:SetPosition(x, y, z)
            inst.fx_poisonspore.components.complexprojectile:Launch(ConsoleWorldPosition(), inst)
            inst.SoundEmitter:PlaySound("dontstarve/cave/tentapiller_hole_throw_item")

            local function PoisonSporeOnTimerDone(inst, data)
                if data.name == "cooldown_poisonspore" then
                    inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
                        .. STRINGS.musha.skills.poisonspore.name
                        .. STRINGS.musha.skills.cooldownfinished.part2)
                    inst:RemoveEventCallback("timerdone", PoisonSporeOnTimerDone)
                end
            end

            inst.components.timer:StartTimer("cooldown_poisonspore", TUNING.musha.skills.poisonspore.cooldown)
            inst:ListenForEvent("timerdone", PoisonSporeOnTimerDone)
        elseif not inst.skills.poisonspore then
            inst.components.talker:Say(STRINGS.musha.lack_of_exp)
        elseif inst.components.timer:TimerExists("cooldown_poisonspore") then
            inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                .. STRINGS.musha.skills.poisonspore.name
                .. STRINGS.musha.skills.incooldown.part2
                .. STRINGS.musha.skills.incooldown.part3
                .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_poisonspore"))
                .. STRINGS.musha.skills.incooldown.part4)
        elseif inst.components.mana.current < TUNING.musha.skills.poisonspore.manacost then
            inst.components.talker:Say(STRINGS.musha.lack_of_mana)
            CustomPlayFailedAnim(inst)
        elseif inst.components.sanity.current < TUNING.musha.skills.poisonspore.sanitycost then
            inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
            CustomPlayFailedAnim(inst)
        else
            inst.components.mana:DoDelta(-TUNING.musha.skills.poisonspore.manacost)
            inst.components.sanity:DoDelta(-TUNING.musha.skills.poisonspore.sanitycost)
            inst:AddDebuff("poisonspore", "poisonspore")
            inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
            inst.components.talker:Say(STRINGS.musha.skills.poisonspore.ready)
        end
    end
end

-- Toggle berserk mode
local function ToggleBerserk(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("nomorph") then
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
    end

    if previousmode == 2 and currentmode ~= 2 then
        inst:RemoveTag("stronggrip")
        inst.components.combat.externaldamagemultipliers:RemoveModifier(inst, "valkyriebuff") -- Note: SourceModifierList:RemoveModifier(source, key)
        inst.components.health.externalabsorbmodifiers:RemoveModifier(inst, "valkyriebuff")
        inst.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "valkyriebuff")
        inst.components.mana.modifiers:RemoveModifier(inst, "valkyriebuff")
        inst:RemoveEventCallback("freeze", UnfreezeOnFreeze)

        LightningDischarge(inst)
        inst.components.timer:StopTimer("lightningrecharge")
        inst:RemoveEventCallback("timerdone", LightningStrikeOnTimerDone)

        CustomAttachFx(inst, "electrichitsparks")
        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    if previousmode == 3 and currentmode ~= 3 then
        if inst:HasTag("sneaking") then
            inst:RemoveSneakEffects()
            inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
        else
            CustomAttachFx(inst, "statue_transition_2") -- Avoid dupulicate fx
        end
        inst:RemoveTag("areaattack") -- Must be removed after inst:RemoveSneakEffects()
        inst:RemoveEventCallback("onattackother", BerserkOnAttackOther)
        inst.components.debuffable:RemoveDebuff("poisonspore")
        CustomCancelTask(inst.modetrailtask)

        for _, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") and not v:HasTag("shadowvalkyrie") then
                v:DoTaskInTime(math.random() * 0.5 + 0.5,
                    function() -- Delay for at least 0.5 seconds to make sure the activate event is triggered
                        v:PushEvent("shadowberserk_quit")
                    end)
            end
        end

        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
        inst.emotesoundoverride = "dontstarve/characters/willow/emote"
    end

    -- Set new attributes for new mode
    if currentmode == 0 then
        inst.components.skinner:SetSkinName("musha_none")
        inst.customidleanim = "idle_warly"
        inst.soundsname = "willow"
        if previousmode == 1 then
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
        end
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
        if previousmode == 0 then
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
        end
    end

    if currentmode == 2 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)

        inst:AddTag("stronggrip")

        inst.components.combat.externaldamagemultipliers:SetModifier(inst, TUNING.musha.valkyrieattackboost,
            "valkyriebuff")
        inst.components.health.externalabsorbmodifiers:SetModifier(inst, TUNING.musha.valkyriedefenseboost,
            "valkyriebuff")
        inst.components.health.externalfiredamagemultipliers:SetModifier(inst, 0, "valkyriebuff") -- Note: SourceModifierList:SetModifier(source, m, key)
        inst.components.mana.modifiers:SetModifier(inst, TUNING.musha.valkyriemanaongoingcost, "valkyriebuff")

        inst.components.freezable:Unfreeze()
        inst:ListenForEvent("freeze", UnfreezeOnFreeze)

        LightningRecharge(inst)
        inst:ListenForEvent("timerdone", LightningStrikeOnTimerDone)

        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.customidleanim = "idle_wathgrithr"
        inst.soundsname = "winnie"
    end

    if currentmode == 3 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)

        inst:AddTag("areaattack")
        inst:ListenForEvent("onattackother", BerserkOnAttackOther)

        inst.shadowmushafollowonly = false
        for _, v in pairs(inst.components.petleash:GetPets()) do
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
        inst.emotesoundoverride = "dontstarve/characters/wendy/emote"
        inst.modetrailtask = inst:DoPeriodicTask(6 * FRAMES, AddBerserkTrailFx, 2 * FRAMES)
    end

    inst._mode = currentmode -- Update previous mode
end

---------------------------------------------------------------------------------------------------------

-- Fatigue level related

local function DecideFatigueLevel(inst)
    if inst:HasTag("playerghost") or inst.components.health:IsDead() or inst.sg:HasStateTag("ghostbuild")
        or inst.sg:HasStateTag("musha_nointerrupt") then
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

    CustomRemoveEntity(inst.fx_fatiguelevel)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, inst)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, inst)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguelevel")

    if fatiguelevel == 0 then
        local workmultiplier = TUNING.musha.fatiguelevel.level0.workmultiplier

        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.fx_fatiguelevel = CustomAttachFx(inst, "fx_fullmode", 0, nil, Vector3(0, -0.1, 0))
    end

    if fatiguelevel == 1 then
    end

    if fatiguelevel == 2 then
        local workmultiplier = TUNING.musha.fatiguelevel.level2.workmultiplier
        local speedmultiplier = TUNING.musha.fatiguelevel.level2.speedmultiplier

        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
    end

    if fatiguelevel == 3 then
        local workmultiplier = TUNING.musha.fatiguelevel.level3.workmultiplier
        local speedmultiplier = TUNING.musha.fatiguelevel.level3.speedmultiplier

        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
    end

    if fatiguelevel == 4 then
        local workmultiplier = TUNING.musha.fatiguelevel.level4.workmultiplier
        local speedmultiplier = TUNING.musha.fatiguelevel.level4.speedmultiplier

        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
    end
end

---------------------------------------------------------------------------------------------------------

-- When level up
local function OnLevelUp(inst, data)
    inst.skills.freezingspell      = data.lvl >= TUNING.musha.leveltounlockskill.freezingspell and true or nil
    inst.skills.manashield         = data.lvl >= TUNING.musha.leveltounlockskill.manashield and true or nil
    inst.skills.manashield_area    = data.lvl >= TUNING.musha.leveltounlockskill.manashield_area and true or nil -- TODO: Set unchangable when HasTag("manashieldactivated")
    inst.skills.manashield_passive = data.lvl >= TUNING.musha.leveltounlockskill.manashield_passive and true or nil
    inst.skills.valkyrie           = data.lvl >= TUNING.musha.leveltounlockskill.valkyrie and true or nil
    inst.skills.berserk            = data.lvl >= TUNING.musha.leveltounlockskill.berserk and true or nil
    inst.skills.thunderspell       = data.lvl >= TUNING.musha.leveltounlockskill.thunderspell and true or nil
    inst.skills.shadowspell        = data.lvl >= TUNING.musha.leveltounlockskill.shadowspell and true or nil
    inst.skills.sneak              = data.lvl >= TUNING.musha.leveltounlockskill.sneak and true or nil
    inst.skills.sneakspeedboost    = data.lvl >= TUNING.musha.leveltounlockskill.sneakspeedboost and true or nil
    inst.skills.poisonspore        = data.lvl >= TUNING.musha.leveltounlockskill.poisonspore and true or nil
    inst.skills.shadowshield       = data.lvl >= TUNING.musha.leveltounlockskill.shadowshield and true or nil
    inst.skills.instantcast        = data.lvl >= TUNING.musha.leveltounlockskill.instantcast and true or nil
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function OnBecameHuman(inst)
    inst:AddTag("nofx")
    inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    inst:DecideNormalOrFull()

    local timers = {
        "cooldown_thunderspell",
        "cooldown_freezingspell",
        "cooldown_manashield",
        "cooldown_poisonspore",
        "cooldown_elfmelody",
        "stopelfmelody_full",
        "stopelfmelody_partial",
        "premelody",
        "lightningrecharge",
        "cancel_manashield_areas"
    }

    for _, name in pairs(timers) do
        inst.components.timer:StopTimer(name)
    end

    inst:DoTaskInTime(1.5, function()
        inst:RemoveTag("nofx")
        inst:ListenForEvent("fatiguedelta", DecideFatigueLevel)
        inst:DecideFatigueLevel()
    end)
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
    inst.emotesoundoverride = "dontstarve/characters/willow/emote"

    -- Character specific attributes
    inst._mode = 0 -- Store previous mode
    inst.mode = net_tinybyte(inst.GUID, "musha.mode", "modechange") -- 0: normal, 1: full, 2: valkyrie, 3: berserk
    inst.fatiguelevel = net_tinybyte(inst.GUID, "musha.fatiguelevel", "fatiguelevelchange")
    inst.activateberserk = net_event(inst.GUID, "activateberserk") -- Handler set in SG
    inst.castmanaspell = net_event(inst.GUID, "castmanaspell") -- Handler set in SG
    inst.playfullelfmelody = net_event(inst.GUID, "playfullelfmelody") -- Handler set in SG
    inst.playpartialelfmelody = net_event(inst.GUID, "playpartialelfmelody") -- Handler set in SG
    inst.snifftreasure = net_event(inst.GUID, "snifftreasure") -- Handler set in SG

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

    -- Elf melody
    inst:AddComponent("melody")

    -- Treasure sniffing
    inst:AddComponent("treasurehunter")

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
    inst.SetShieldDurability = SetShieldDurability
    inst.ShieldOff = ShieldOff
    inst.FreezingSpell = FreezingSpell
    inst.ThunderSpell = ThunderSpell
    inst.LightningDischarge = LightningDischarge
    inst.StartMelodyBuff = StartMelodyBuff
    inst.StopMelodyBuff = StopMelodyBuff
    inst.SniffTreasure = SniffTreasure

    -- Event handlers
    inst:ListenForEvent("levelup", OnLevelUp)
    inst:ListenForEvent("fatiguelevelchange", OnFatigueLevelChange)
    inst:ListenForEvent("treasurefull", OnTreasureSniffingReady)
    inst:ListenForEvent("death", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnBecameGhost)
    inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
    inst:ListenForEvent("ms_playerreroll", OnRerollForPetLeash)
end

-- Set up remote procedure calls for client side
AddModRPCHandler("musha", "togglevalkyrie", ToggleValkyrie)
AddModRPCHandler("musha", "toggleberserk", ToggleBerserk)
AddModRPCHandler("musha", "toggleshield", ToggleShield)
AddModRPCHandler("musha", "togglesleep", ToggleSleep)
AddModRPCHandler("musha", "playelfmelody", PlayElfMelody)
AddModRPCHandler("musha", "switchkeybindings", SwitchKeyBindings)
AddModRPCHandler("musha", "doshadowmushaorder", DoShadowMushaOrder)

---------------------------------------------------------------------------------------------------------

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)
