local MakePlayerCharacter = require("prefabs/player_common")
local UserCommands = require("usercommands")
local Emotes = require("src/emotes")
local Musics = require("src/musics")
local Timers = require("src/timers")

---------------------------------------------------------------------------------------------------------

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/musha/musha.zip"), -- Character texture
}

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.MUSHA = {
    "taffy",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.MUSHA
end

-- Character required prefabs
local prefabs = FlattenTree(start_inv, true)

-- Element projectile list
local elementlist = {
    rollingmagma = 1,
    whitefrost = 2,
    poisonspore = 3,
    bloomingfield = 4,
}

---------------------------------------------------------------------------------------------------------

-- Get mouse cursor position from client side and send to server

-- Mod RPC Handler on server side
local function GetCursorPosition(inst, x, y, z)
    inst.bufferedcursorpos = Vector3(x, y, z)
    inst:PushEvent("cursorpositionupdated")
end

-- Net event handler on client side
local function SendCursorPosition()
    if TheInput ~= nil then
        local CursorPosition = TheInput:GetWorldEntityUnderMouse() and
            TheInput:GetWorldEntityUnderMouse():GetPosition() or TheInput:GetWorldPosition()

        SendModRPCToServer(MOD_RPC.musha.getcursorposition, CursorPosition.x, CursorPosition.y, CursorPosition.z)
    end
end

---------------------------------------------------------------------------------------------------------

-- Mod RPC Handler for skill tree widget activate event
local function ActivateSkill(inst, skillname, category)
    inst.components.mushaskilltree:ActivateSkill(skillname, category)
end

---------------------------------------------------------------------------------------------------------

-- Push event when debuff is added or removed

local function OnDebuffAdded(inst, name, debuff, data)
    inst:PushEvent("debuffadded", { name = name, debuff = debuff, data = data })
end

local function OnDebuffRemoved(inst, name, debuff)
    inst:PushEvent("debuffremoved", { name = name, debuff = debuff })
end

---------------------------------------------------------------------------------------------------------

-- Bonus damage
local function BonusDamageFn(inst, target, damage, weapon) -- Triggered by target's Combat:GetAttacked, and only when damage > 0
    local bonusdamage = 0

    if inst.mode:value() == 2 and target:HasOneOfTags({ "monster", "hostile" })
        and not target:HasOneOfTags({ "shadow", "shadowcreature", "shadowchesspiece", "stalker" }) then
        bonusdamage = bonusdamage + damage * TUNING.musha.charactermode.valkyrie.bonusdamagetomonster
    end

    if inst.mode:value() == 3 and target:HasOneOfTags({ "shadow", "shadowcreature", "shadowchesspiece", "stalker" }) then
        bonusdamage = bonusdamage + damage * TUNING.musha.charactermode.shadow.bonusdamagetoshadow
    end

    return bonusdamage
end

---------------------------------------------------------------------------------------------------------

-- Additional effects on eating certain foods

local function RemoveJellyBeanEffect(inst, data)
    if data.name == "jellybeanineffect" then
        inst.components.mana.modifiers:RemoveModifier(inst, "jellybean")
        inst.components.stamina.modifiers:RemoveModifier(inst, "jellybean")
        inst:RemoveEventCallback("timerdone", RemoveJellyBeanEffect)
    end
end

local function OnEatFood(inst, data)
    if data.food then
        if data.food.prefab == "taffy" then
            inst.components.health:DoDelta(TUNING.musha.foodbonus.taffy.health)
            inst.components.mana:DoDelta(TUNING.musha.foodbonus.taffy.mana)
            inst.components.stamina:DoDelta(TUNING.musha.foodbonus.taffy.stamina)
        elseif data.food.prefab == "jellybean" then
            if not inst.components.timer:TimerExists("jellybeanineffect") then
                inst.components.mana.modifiers:SetModifier(inst, TUNING.musha.foodbonus.jellybean.mana, "jellybean")
                inst.components.stamina.modifiers:SetModifier(inst, TUNING.musha.foodbonus.jellybean.stamina, "jellybean")

                inst.components.timer:StartTimer("jellybeanineffect", TUNING.musha.foodbonus.jellybean.duration)
                inst:ListenForEvent("timerdone", RemoveJellyBeanEffect)
            else
                inst.components.timer:SetTimeLeft("jellybeanineffect", TUNING.musha.foodbonus.jellybean.duration)
            end
        elseif data.food.prefab == "nightmarefuel" and inst.mode:value() == 3 then
            inst.components.sanity:AddSanityPenalty("shadowmodebuff",
                math.max(0, inst.components.sanity.sanity_penalties["shadowmodebuff"] -
                    TUNING.musha.charactermode.shadow.sanitypenaltydeltaonrefuel / inst.components.sanity.max))
            inst.components.sanity:DoDelta(TUNING.musha.charactermode.shadow.sanitypenaltydeltaonrefuel)
        elseif data.food.prefab == "shadowheart" and inst.mode:value() == 3 then
            inst.components.sanity:AddSanityPenalty("shadowmodebuff", 0)
            inst.components.sanity:SetPercent(1)
            CustomCancelTask(inst.task_updatesanitypenalty)
            CustomAttachFx(inst,
                { "waxwell_shadow_book_fx", "statue_transition", "statue_transition_2",
                    "shadow_shield" .. math.random(1, 6) })
        end
    end
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
                v:AddDebuff("freezingspell", "debuff_slowdown", {
                    duration =  TUNING.musha.skills.freezingspell.slowdownduration,
                }) -- Add slowdown debuff if not frozen
            end
            validtargets = validtargets + 1
        elseif not v.components.freezable and v:HasTag("locomotor") then
            v:AddDebuff("freezingspell", "debuff_slowdown", {
                duration = TUNING.musha.skills.freezingspell.slowdownduration,
            }) -- Add slowdown debuff if not freezable
            validtargets = validtargets + 1
        end
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

    if inst.components.mushaskilltree:IsActivated("freezingspellboost") then
        local FIRE_CANT_TAGS = { "INLIMBO", "lighter" }
        local FIRE_ONEOF_TAGS = { "fire", "smolder" }

        CustomDoAOE(inst, range, nil, FIRE_CANT_TAGS, FIRE_ONEOF_TAGS, function(v)
            if v.components.burnable ~= nil and v.components.fueled == nil then
                v.components.burnable:Extinguish(true, 0)
                validtargets = validtargets + 1
            end
        end)

        local x, y, z = inst.Transform:GetWorldPosition()
        local size = TILE_SCALE -- 4

        for i = x - range, x + range, size do
            for j = z - range, z + range, size do
                local distsq = inst:GetDistanceSqToPoint(i, y, j)
                if math.sqrt(distsq) <= range and TheWorld.Map:GetTileAtPoint(i, 0, j) == WORLD_TILES.FARMING_SOIL then
                    TheWorld.components.farming_manager:AddSoilMoistureAtPoint(i, y, j,
                        TUNING.musha.skills.freezingspellboost.addsoilmoisture)
                    validtargets = validtargets + 1
                end
            end
        end
    end

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
    local range = TUNING.musha.skills.thunderspell.range
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
            CustomAttachFx(v, "lightning_musha")
        end)
        validtargets = validtargets + 1
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

    inst.components.mana:DoDelta(-
        math.min(TUNING.musha.skills.thunderspell.manacost * validtargets, TUNING.musha.skills.thunderspell.maxmanacost))
    inst.components.talker:Say(STRINGS.musha.skills.manaspells.thunderspell.cast)

    inst.components.timer:StartTimer("cooldown_thunderspell", TUNING.musha.skills.thunderspell.cooldown)
    inst:ListenForEvent("timerdone", ThunderSpellOnTimerDone)
end

-- Shadow prison
local function ShadowPrisonOnTimerDone(inst, data)
    if data.name == "cooldown_shadowprison" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manaspells.shadowprison.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ShadowPrisonOnTimerDone)
    end
end

local function ShadowPrison(inst)
    local spellprefab = SpawnPrefab("shadow_pillar_spell_9_musha")
    spellprefab.caster = inst
    spellprefab.item = inst.components.combat:GetWeapon()
    spellprefab.Transform:SetPosition(inst.Transform:GetWorldPosition())

    inst.components.mana:DoDelta(-TUNING.musha.skills.shadowprison.manacost)
    inst.components.sanity:DoDelta(-TUNING.musha.skills.shadowprison.sanitycost)
    inst.components.talker:Say(STRINGS.musha.skills.manaspells.shadowprison.cast)

    inst.components.timer:StartTimer("cooldown_shadowprison", TUNING.musha.skills.shadowprison.cooldown)
    inst:ListenForEvent("timerdone", ShadowPrisonOnTimerDone)
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

-- Sleep

local function ToggleSleep(inst)
    -- Can interrupt sleep (wake up)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or
        (inst.sg:HasStateTag("musha_nointerrupt") and not inst.sg:HasStateTag("sleeping")) then
        return
    end

    if inst:HasDebuff("elementloaded") then
        inst.components.debuffable:RemoveDebuff("elementloaded")

        local element = CustomFindKeyByValue(elementlist, inst.elementmode)
        if TUNING.musha.skills.launchelement[element].manacost then
            inst.components.mana:DoDelta(TUNING.musha.skills.launchelement[element].manacost)
        end
        if TUNING.musha.skills.launchelement[element].sanitycost then
            inst.components.sanity:DoDelta(TUNING.musha.skills.launchelement[element].sanitycost)
        end
    elseif inst.components.rider:IsRiding() then
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

            indanger = FindEntity(inst, 8, function(target)
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
        ["stalker_bulb"] = 2,
        ["stalker_bulb_double"] = 2,
        ["stalker_berry"] = 3,
        ["stalker_fern"] = 7,
    }
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        math.random() * 4,
        8,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return map:IsPassableAtPoint(x1, 0, z1)
                and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                and #TheSim:FindEntities(x1, 0, z1, 2.5, { "stalkerbloom" }) < 1
        end
    )

    if offset ~= nil then
        local plant = SpawnPrefab(weighted_random_choice(BLOOM_CHOICES))
        plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
        if math.random() < .9 then
            plant:AddTag("NOCLICK")
            plant.AnimState:SetMultColour(1, 1, 1, .3)
        end
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
        inst.stalkertrailtask = inst:DoPeriodicTask(0.5, AddStalkerTrailFx)
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
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt")
        or inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("musha_elfmelody") then
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

local function PrincessBlessingOnTimerDone(inst, data)
    if data.name == "cooldown_princessblessing" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.princessblessing.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", PrincessBlessingOnTimerDone)
    end
end

local function PrincessBlessing(inst) local validtargets = 0
    local must_tags = { "_combat", "_health" }
    local ignore_tags = { "playerghost", "INLIMBO", "isdead" }
    local one_of_tags = { "player", "companion", "musha_companion" }
    local durability = TUNING.musha.skills.manashield.durability
        + TUNING.musha.skills.manashield.healthbonusmultiplier * inst.components.health.maxhealth
        + (inst.components.mushaskilltree:IsActivated("manashielddurability1")
            and TUNING.musha.skills.manashielddurability1.bonus or 0 )
        + (inst.components.mushaskilltree:IsActivated("manashielddurability2")
            and TUNING.musha.skills.manashielddurability2.bonusmultiplier * inst.components.leveler.lvl or 0 )
    local duration = TUNING.musha.skills.princessblessing.duration
        + (inst.components.mushaskilltree:IsActivated("princessblessingduration1")
            and TUNING.musha.skills.princessblessingduration1.bonus or 0 )

    CustomDoAOE(inst, TUNING.musha.skills.princessblessing.range, must_tags, ignore_tags, one_of_tags, function(v)
        if not v.components.health then
            return
        end

        v:AddDebuff("manashield", "manashield",
            { durability = durability, duration = duration }) -- Note: EntityScript:AddDebuff(name, prefab, data, skip_test, pre_buff_fn), name is key

        validtargets = validtargets + 1
    end) -- Note: CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)

    inst.components.talker:Say(STRINGS.musha.skills.princessblessing.cast)
    inst.components.mana:DoDelta(-math.min(TUNING.musha.skills.princessblessing.manacost * validtargets,
        TUNING.musha.skills.princessblessing.maxmanacost))

    inst.components.timer:StartTimer("cooldown_princessblessing", TUNING.musha.skills.princessblessing.cooldown)
    inst:ListenForEvent("timerdone", PrincessBlessingOnTimerDone)
end

local function DoPrincessBlessing(inst)
    inst.bufferedspell = "PrincessBlessing" -- Refresh durability (mainly for SG related, check this namespace in stategraphs.lua)
    inst.bufferedbookfx = {
        swap_build = "swap_books",
        swap_prefix = "book_horticulture_upgraded",
        def = {
            fx = "fx_book_moon",
            fx_under_prefab = "fx_plants_big_under_book",
            layer_sound = { frame = 30, sound = "wickerbottom_rework/book_spells/upgraded_horticulture" },
        },
        reticule = {
            prefab = "reticuleaoe_1d2_12_musha",
            prefab_ping = "reticuleaoeping_1d2_12_musha",
            scale = math.sqrt(TUNING.musha.skills.princessblessing.range / 12)
        }
    }
    inst.castmanaspell:push()
end

local function RemoveStabStartedFlag(inst, data)
    inst.valkyriestabstarted = nil
    inst:RemoveEventCallback("newstate", RemoveStabStartedFlag)
end

local function ShieldKeyLongPressed(inst, data)
    if data.name == "shieldkeyonlongpress" then
        -- Delayed event, need to check again
        if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
            inst:RemoveEventCallback("timerdone", ShieldKeyLongPressed)
            return
        end

        if inst.mode:value() == 0 or inst.mode:value() == 1 and not inst.sg:HasStateTag("musha_spell") then
            if not inst.components.mushaskilltree:IsActivated("princessblessing") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.timer:TimerExists("cooldown_princessblessing") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.princessblessing.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_princessblessing"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.mana.current < TUNING.musha.skills.princessblessing.maxmanacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            else
                -- Mana cost handled during casting spell
                DoPrincessBlessing(inst)
            end
        elseif inst.mode:value() == 2 then
            if not inst.components.mushaskilltree:IsActivated("valkyrieparry") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.rider:IsRiding() then
                inst.components.talker:Say(STRINGS.musha.mount_not_allowed)
                CustomPlayFailedAnim(inst)
            elseif inst.components.timer:TimerExists("cooldown_valkyrieparry") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.valkyrieparry.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_valkyrieparry"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.stamina.current < TUNING.musha.skills.valkyrieparry.staminacostonhit then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                CustomPlayFailedAnim(inst)
            else
                -- Stamina cost handled in stamina component and sg
                inst.startvalkyrieparry:push()
            end
        elseif inst.mode:value() == 3 then
            if not inst.components.mushaskilltree:IsActivated("shadowparry") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.timer:TimerExists("cooldown_shadowparry") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.shadowparry.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_shadowparry"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.sanity.current < TUNING.musha.skills.shadowparry.sanitycost then
                inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                CustomPlayFailedAnim(inst)
            elseif inst.components.stamina.current < TUNING.musha.skills.shadowparry.staminacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                CustomPlayFailedAnim(inst)
            else
                -- Stamina cost handled in sg
                inst.components.sanity:DoDelta(-TUNING.musha.skills.shadowparry.sanitycost)
                inst.startshadowparry:push()
            end
        end

        inst:RemoveEventCallback("timerdone", ShieldKeyLongPressed)
    end
end

local function ShieldKeyDown(inst, x, y, z)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        return
    end

    inst.components.timer:StartTimer("shieldkeyonlongpress", TUNING.musha.singleclicktimewindow)
    inst:ListenForEvent("timerdone", ShieldKeyLongPressed)
end

local function ShieldKeyUp(inst, x, y, z)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        inst.components.timer:StopTimer("shieldkeyonlongpress")
        inst:RemoveEventCallback("timerdone", ShieldKeyLongPressed)
        return
    end

    inst.bufferedcursorpos = Vector3(x, y, z)

    if inst.components.timer:TimerExists("shieldkeyonlongpress") then
        if inst:HasTag("manashieldactivated") then
            inst:RemoveDebuff("manashield")
        elseif not inst.components.mushaskilltree:IsActivated("manashield") then
            inst.components.talker:Say(STRINGS.musha.lack_of_xp)
        elseif inst.components.timer:TimerExists("cooldown_manashield") then
            inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                .. STRINGS.musha.skills.manashield.name
                .. STRINGS.musha.skills.incooldown.part2
                .. STRINGS.musha.skills.incooldown.part3
                .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_manashield"))
                .. STRINGS.musha.skills.incooldown.part4)
        elseif inst.components.mana.current < TUNING.musha.skills.manashield.manacost then
            inst.components.talker:Say(STRINGS.musha.lack_of_mana)
            CustomPlayFailedAnim(inst)
        else
            -- Mana cost handled at the time shield set off by debuff:OnDetached
            local durability = TUNING.musha.skills.manashield.durability
                + TUNING.musha.skills.manashield.healthbonusmultiplier * inst.components.health.maxhealth
                + (inst.components.mushaskilltree:IsActivated("manashielddurability1")
                    and TUNING.musha.skills.manashielddurability1.bonus or 0 )
                + (inst.components.mushaskilltree:IsActivated("manashielddurability2")
                    and TUNING.musha.skills.manashielddurability2.bonusmultiplier * inst.components.leveler.lvl or 0 )

            inst:AddDebuff("manashield", "manashield", { durability = durability, single = true }) -- Note: EntityScript:AddDebuff(name, prefab, data, skip_test, pre_buff_fn), name is key
        end
    elseif inst.mode:value() == 2 then
        if inst.sg:HasStateTag("musha_valkyrieparrying") then
            inst.valkyriestabstarted = true
            inst:ListenForEvent("newstate", RemoveStabStartedFlag)
            inst.startvalkyriestab:push()
        end
    elseif inst.mode:value() == 3 then
        if inst.sg:HasStateTag("musha_shadowparry") then
            inst.endshadowparry:push()
        end
    end

    inst.components.timer:StopTimer("shieldkeyonlongpress")
    inst:RemoveEventCallback("timerdone", ShieldKeyLongPressed)
end

---------------------------------------------------------------------------------------------------------

-- Launch element

-- Magma
local function RollingMagma(inst, data)
    if inst:HasDebuff("elementloaded") then
        local x, y, z = inst.components.debuffable:GetDebuff("elementloaded").Transform:GetWorldPosition()
        local prefab = inst.components.debuffable:GetDebuff("elementloaded").prefab

        inst.components.debuffable:RemoveDebuff("elementloaded")

        local cooldownoverride = nil
        local projectile = SpawnPrefab(prefab)

        if prefab == "deer_fire_charge_musha" then
            projectile.nosound = true
            cooldownoverride = TUNING.musha.skills.launchelement.rollingmagma.charged.cooldown
        end
        projectile.owner = inst
        projectile.Transform:SetPosition(x, y, z)
        projectile.components.complexprojectile:Launch(data.CursorPosition, inst)
        inst.SoundEmitter:PlaySound("dontstarve/cave/tentapiller_hole_throw_item")

        local function RollingMagmaOnTimerDone(inst, data)
            if data.name == "cooldown_rollingmagma" then
                inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
                    .. STRINGS.musha.skills.launchelement.rollingmagma.name
                    .. STRINGS.musha.skills.cooldownfinished.part2)
                inst:RemoveEventCallback("timerdone", RollingMagmaOnTimerDone)
            end
        end

        inst.components.timer:StartTimer("cooldown_rollingmagma",
            cooldownoverride or TUNING.musha.skills.launchelement.rollingmagma.cooldown)
        inst:ListenForEvent("timerdone", RollingMagmaOnTimerDone)

        return true
    elseif not inst.components.mushaskilltree:IsActivated("rollingmagma") then
        return false, STRINGS.musha.lack_of_xp
    elseif inst.components.timer:TimerExists("cooldown_rollingmagma") then
        local reason = STRINGS.musha.skills.incooldown.part1
            .. STRINGS.musha.skills.launchelement.rollingmagma.name
            .. STRINGS.musha.skills.incooldown.part2
            .. STRINGS.musha.skills.incooldown.part3
            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_rollingmagma"))
            .. STRINGS.musha.skills.incooldown.part4
        return false, reason
    elseif inst.components.mana.current < TUNING.musha.skills.launchelement.rollingmagma.manacost then
        return false, STRINGS.musha.lack_of_mana
    else
        inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.rollingmagma.manacost)
        inst:AddDebuff("elementloaded", "fireball_projectile_musha")
        inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
        inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop")
        return true
    end
end

local function ChargedRollingMagma(inst)
    inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.rollingmagma.charged.extramanacost)
    inst.components.debuffable:RemoveDebuff("elementloaded")
    inst:AddDebuff("elementloaded", "deer_fire_charge_musha")
end

-- Frost
local function WhiteFrost(inst, data)
    if inst:HasDebuff("elementloaded") then
        local x, y, z = inst.components.debuffable:GetDebuff("elementloaded").Transform:GetWorldPosition()
        local prefab = inst.components.debuffable:GetDebuff("elementloaded").prefab

        inst.components.debuffable:RemoveDebuff("elementloaded")

        local cooldownoverride = nil
        local projectile = SpawnPrefab(prefab)

        if prefab == "deer_ice_charge_musha" then
            projectile.nosound = true
            cooldownoverride = TUNING.musha.skills.launchelement.whitefrost.charged.cooldown
        end
        projectile.owner = inst
        projectile.Transform:SetPosition(x, y, z)
        projectile.components.complexprojectile:Launch(data.CursorPosition, inst)
        inst.SoundEmitter:PlaySound("dontstarve/cave/tentapiller_hole_throw_item")

        local function WhiteFrostOnTimerDone(inst, data)
            if data.name == "cooldown_whitefrost" then
                inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
                    .. STRINGS.musha.skills.launchelement.whitefrost.name
                    .. STRINGS.musha.skills.cooldownfinished.part2)
                inst:RemoveEventCallback("timerdone", WhiteFrostOnTimerDone)
            end
        end

        inst.components.timer:StartTimer("cooldown_whitefrost",
            cooldownoverride or TUNING.musha.skills.launchelement.whitefrost.cooldown)
        inst:ListenForEvent("timerdone", WhiteFrostOnTimerDone)

        return true
    elseif not inst.components.mushaskilltree:IsActivated("whitefrost") then
        return false, STRINGS.musha.lack_of_xp
    elseif inst.components.timer:TimerExists("cooldown_whitefrost") then
        local reason = STRINGS.musha.skills.incooldown.part1
            .. STRINGS.musha.skills.launchelement.whitefrost.name
            .. STRINGS.musha.skills.incooldown.part2
            .. STRINGS.musha.skills.incooldown.part3
            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_whitefrost"))
            .. STRINGS.musha.skills.incooldown.part4
        return false, reason
    elseif inst.components.mana.current < TUNING.musha.skills.launchelement.whitefrost.manacost then
        return false, STRINGS.musha.lack_of_mana
    else
        inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.whitefrost.manacost)
        inst:AddDebuff("elementloaded", "frostball_projectile_musha")
        inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
        inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop")

        return true
    end
end

local function ChargedWhiteFrost(inst)
    inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.whitefrost.charged.extramanacost)
    inst.components.debuffable:RemoveDebuff("elementloaded")
    inst:AddDebuff("elementloaded", "deer_ice_charge_musha")
end

-- Poison
local function PoisonSpore(inst, data)
    if inst:HasDebuff("elementloaded") then
        local x, y, z = inst.components.debuffable:GetDebuff("elementloaded").Transform:GetWorldPosition()
        local charged = inst.components.debuffable:GetDebuff("elementloaded").ischarged

        inst.components.debuffable:RemoveDebuff("elementloaded")

        local cooldownoverride = nil
        local projectile = SpawnPrefab("sporebomb_musha")
        if charged then
            projectile.charged:push()
            projectile.bounce = TUNING.musha.skills.launchelement.poisonspore.charged.bouncetime
                + math.floor(TUNING.musha.skills.launchelement.poisonspore.charged.bouncetimegrowth
                    * inst.components.leveler.lvl)
            cooldownoverride = TUNING.musha.skills.launchelement.poisonspore.charged.cooldown
        end
        projectile.owner = inst
        projectile.Transform:SetPosition(x, y, z)
        projectile.components.complexprojectile:Launch(data.CursorPosition, inst)
        inst.SoundEmitter:PlaySound("dontstarve/cave/tentapiller_hole_throw_item")

        local function PoisonSporeOnTimerDone(inst, data)
            if data.name == "cooldown_poisonspore" then
                inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
                    .. STRINGS.musha.skills.launchelement.poisonspore.name
                    .. STRINGS.musha.skills.cooldownfinished.part2)
                inst:RemoveEventCallback("timerdone", PoisonSporeOnTimerDone)
            end
        end

        inst.components.timer:StartTimer("cooldown_poisonspore",
            cooldownoverride or TUNING.musha.skills.launchelement.poisonspore.cooldown)
        inst:ListenForEvent("timerdone", PoisonSporeOnTimerDone)

        return true
    elseif not inst.components.mushaskilltree:IsActivated("poisonspore") then
        return false, STRINGS.musha.lack_of_xp
    elseif inst.components.timer:TimerExists("cooldown_poisonspore") then
        local reason = STRINGS.musha.skills.incooldown.part1
            .. STRINGS.musha.skills.launchelement.poisonspore.name
            .. STRINGS.musha.skills.incooldown.part2
            .. STRINGS.musha.skills.incooldown.part3
            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_poisonspore"))
            .. STRINGS.musha.skills.incooldown.part4
        return false, reason
    elseif inst.components.mana.current < TUNING.musha.skills.launchelement.poisonspore.manacost then
        return false, STRINGS.musha.lack_of_mana
    elseif inst.components.sanity.current < TUNING.musha.skills.launchelement.poisonspore.sanitycost then
        return false, STRINGS.musha.lack_of_sanity
    else
        inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.poisonspore.manacost)
        inst.components.sanity:DoDelta(-TUNING.musha.skills.launchelement.poisonspore.sanitycost)
        inst:AddDebuff("elementloaded", "sporebomb_musha")
        inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
        inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop")
        return true
    end
end

local function ChargedPoisonSpore(inst)
    inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.poisonspore.charged.extramanacost)
    inst.components.sanity:DoDelta(-TUNING.musha.skills.launchelement.poisonspore.charged.extrasanitycost)
    local debuff = inst.components.debuffable:GetDebuff("elementloaded")
    debuff.charged:push() -- No need to set bounce time here because entity will be removed and respawned
end

-- Bloom
local function BloomingField(inst, data)
    if inst:HasDebuff("elementloaded") then
        local x, y, z = inst.components.debuffable:GetDebuff("elementloaded").Transform:GetWorldPosition()
        local prefab = inst.components.debuffable:GetDebuff("elementloaded").prefab

        inst.components.debuffable:RemoveDebuff("elementloaded")

        local cooldownoverride = nil
        local projectile = SpawnPrefab(prefab)

        if prefab == "deer_blossom_charge_musha" then
            projectile.nosound = true
            cooldownoverride = TUNING.musha.skills.launchelement.bloomingfield.charged.cooldown
        end
        projectile.owner = inst
        projectile.Transform:SetPosition(x, y, z)
        projectile.components.complexprojectile:Launch(data.CursorPosition, inst)
        inst.SoundEmitter:PlaySound("dontstarve/cave/tentapiller_hole_throw_item")

        local function BloomingFieldOnTimerDone(inst, data)
            if data.name == "cooldown_bloomingfield" then
                inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
                    .. STRINGS.musha.skills.launchelement.bloomingfield.name
                    .. STRINGS.musha.skills.cooldownfinished.part2)
                inst:RemoveEventCallback("timerdone", BloomingFieldOnTimerDone)
            end
        end

        inst.components.timer:StartTimer("cooldown_bloomingfield",
            cooldownoverride or TUNING.musha.skills.launchelement.bloomingfield.cooldown)
        inst:ListenForEvent("timerdone", BloomingFieldOnTimerDone)

        return true
    elseif not inst.components.mushaskilltree:IsActivated("bloomingfield") then
        return false, STRINGS.musha.lack_of_xp
    elseif inst.components.timer:TimerExists("cooldown_bloomingfield") then
        local reason = STRINGS.musha.skills.incooldown.part1
            .. STRINGS.musha.skills.launchelement.bloomingfield.name
            .. STRINGS.musha.skills.incooldown.part2
            .. STRINGS.musha.skills.incooldown.part3
            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_bloomingfield"))
            .. STRINGS.musha.skills.incooldown.part4
        return false, reason
    elseif inst.components.mana.current < TUNING.musha.skills.launchelement.bloomingfield.manacost then
        return false, STRINGS.musha.lack_of_mana
    else
        inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.bloomingfield.manacost)
        inst:AddDebuff("elementloaded", "blossom_projectile_musha")
        inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
        inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop")
        return true
    end
end

local function ChargedBloomingField(inst)
    inst.components.mana:DoDelta(-TUNING.musha.skills.launchelement.bloomingfield.charged.extramanacost)
    inst.components.debuffable:RemoveDebuff("elementloaded")
    inst:AddDebuff("elementloaded", "deer_blossom_charge_musha")
end

local function ElementTakeTurns(inst, data)
    local availables = {}
    local max = 0

    for k, v in pairs(TUNING.musha.skills.launchelement) do
        if inst.components.mushaskilltree:IsActivated(k) then
            table.insert(availables, k)
        end
        max = max + 1
    end

    if #availables == 0 then
        return false, "noskill"
    end

    if #availables == 1 then
        if elementlist[availables[1]] == inst.elementmode then
            return false, "noalter"
        else
            inst.elementmode = elementlist[availables[1]]
            return true
        end
    else
        local success
        local _elementmode = inst.elementmode
        inst.elementmode = inst.elementmode < max and inst.elementmode + 1 or 1

        while inst.elementmode ~= _elementmode do
            if CustomFindKeyByValue(elementlist, inst.elementmode)
                and CustomFindKeyByValue(availables, CustomFindKeyByValue(elementlist, inst.elementmode)) then
                success = inst:LaunchElement(data, true)
                if success then return false, "complete" end
            end
            inst.elementmode = inst.elementmode < max and inst.elementmode + 1 or 1
        end

        return false, "noalter"
    end
end

local function LaunchElement(inst, data, norecur)
    local success, reason1, reason2

    if inst.elementmode == 1 then
        success, reason1 = RollingMagma(inst, data)
    elseif inst.elementmode == 2 then
        success, reason1 = WhiteFrost(inst, data)
    elseif inst.elementmode == 3 then
        success, reason1 = PoisonSpore(inst, data)
    elseif inst.elementmode == 4 then
        success, reason1 = BloomingField(inst, data)
    end

    if norecur then return success end

    if success then return true end

    success, reason2 = ElementTakeTurns(inst, data)

    if success then
        return LaunchElement(inst, data)
    elseif reason2 == "noskill" then
        inst.components.talker:Say(STRINGS.musha.lack_of_xp)
        return false
    elseif reason2 == "noalter" then
        inst.components.talker:Say(reason1)
        return false
    elseif reason2 == "complete" then
        return true
    end
end

local function OnElementCharged(inst, data)
    if data.name == "chargingelement" then
        inst.nolaunchelement = nil
        if inst:HasDebuff("elementloaded") then
            if inst.elementmode == 1 then
                ChargedRollingMagma(inst)
            elseif inst.elementmode == 2 then
                ChargedWhiteFrost(inst)
            elseif inst.elementmode == 3 then
                ChargedPoisonSpore(inst)
            elseif inst.elementmode == 4 then
                ChargedBloomingField(inst)
            end
        end
        inst:RemoveEventCallback("timerdone", OnElementCharged)
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

    local fx = SpawnPrefab("firering_fx")
    fx.Transform:SetScale(.6, .6, .6)
    fx.Transform:SetPosition(target:GetPosition():Get())
    CustomAttachFx(target, { "lightning_musha", "shock_fx" })

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

    if not inst.sg:HasStateTag("musha_desolatedive_pst") then -- No sound on mode change
        inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
    end
    CustomAttachFx(inst, "electricchargedfx")
    inst.task_lightningfx = inst:DoPeriodicTask(2.6, function()
        inst.fx_lightning = CustomAttachFx(inst, "mossling_spin_fx_musha", { duration = 0 })
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

-- Void phantom

local function VoidPhantomOnTimerDone(inst, data)
    if data.name == "cooldown_voidphantom" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.voidphantom.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", VoidPhantomOnTimerDone)
    end
end

local function ClearPhantomSlashTarget(inst, data)
    if data.name == "phantomslashready" then
        inst.bufferedphantomslashtarget = nil
    end
end

local function StartPhantomAttack(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition()
    local voidphantom = SpawnPrefab("musha_voidphantom")
    voidphantom.owner = inst

    if data and data.shadowparry then
        voidphantom.Transform:SetPosition(x, 0, z)
    else
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * 5,
            8,
            function(offset)
                local x1 = x + offset.x
                local z1 = z + offset.z
                return TheWorld.Map:IsPassableAtPoint(x1, 0, z1)
                    and not TheWorld.Map:IsPointNearHole(Vector3(x1, 0, z1), .4)
            end
        )
        voidphantom.Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end

    if not (data and data.target and data.target:IsValid()) then
        return
    end

    voidphantom.sg:GoToState("lunge_pre", data.target)

    local x1, y1, z1 = data.target.Transform:GetWorldPosition()
    local phantoms = TheSim:FindEntities(x1, y1, z1, TUNING.musha.skills.voidphantom.range,
        { "musha_voidphantom" }, nil, nil)

    if phantoms then
        for _, phantom in pairs(phantoms) do
            if phantom.owner == inst and not phantom.sg:HasStateTag("busy") then
                phantom.sg:GoToState("lunge_pre", data.target)
            end
        end
    end

    if data and data.addphantomslashusewindow then
        inst.bufferedphantomslashtarget = data.target
        inst.components.timer:StartTimer("phantomslashready", TUNING.musha.skills.phantomslash.usewindow)
        inst:ListenForEvent("timerdone", ClearPhantomSlashTarget)
    end

    if data and data.standardcast then
        inst.components.timer:StartTimer("cooldown_voidphantom", TUNING.musha.skills.voidphantom.cooldown)
        inst:ListenForEvent("timerdone", VoidPhantomOnTimerDone)
    end
end

local function StartPhantomSlash(inst, data)
    if not (data.target and data.target:IsValid()) then return end

    local x1, y1, z1 = data.target.Transform:GetWorldPosition()
    local phantoms = TheSim:FindEntities(x1, y1, z1, TUNING.musha.skills.voidphantom.range * 2,
        { "musha_voidphantom" }, nil, nil)

    if phantoms then
        for _, phantom in pairs(phantoms) do
            if phantom.owner == inst and phantom.sg:HasStateTag("attack") then
                phantom.phantomslashready = true
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Sneak

local function ResetSneakSpeedMultiplier(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "sneakspeedboost",
        Remap(inst.components.stamina:GetPercent(), 0, 1,
            TUNING.musha.skills.sneakspeedboost.min, TUNING.musha.skills.sneakspeedboost.max))
end

local function CancelSneakSpeedBoost(inst)
    inst:RemoveEventCallback("staminadelta", ResetSneakSpeedMultiplier)
    inst:RemoveEventCallback("staminadepleted", CancelSneakSpeedBoost)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "sneakspeedboost")
    inst.components.stamina.modifiers:RemoveModifier(inst, "sneakspeedboost")
end

local function SneakSpeedBoost(inst)
    if inst.components.stamina.current > 0 then
        inst:ListenForEvent("staminadelta", ResetSneakSpeedMultiplier)
        inst:ListenForEvent("staminadepleted", CancelSneakSpeedBoost)
        inst.components.stamina.modifiers:SetModifier(inst, -TUNING.musha.skills.sneakspeedboost.staminacost,
            "sneakspeedboost")
        inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "backstabspeedboost")
        ResetSneakSpeedMultiplier(inst)
    end
end

local function BackStab(inst, data)
    inst:StopSneaking()
    inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
    local target = data.target
    local extradamage = TUNING.musha.skills.sneak.backstabbasedamage + 50 * math.floor(inst.components.leveler.lvl / 5)
    if not (target.components and target.components.combat) then
        inst.components.talker:Say(STRINGS.musha.skills.sneak.stop)
    elseif target.sg and (target.sg:HasStateTag("attack") or target.sg:HasStateTag("moving")
        or target.sg:HasStateTag("frozen") or target.sg:HasStateTag("thawing")) then
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_normal)
        CustomAttachFx(target, "statue_transition")
        CustomAttachFx(inst, "nightsword_curve_fx", nil, Vector3(2, 2, 2))

        target.components.combat:GetAttacked(inst, extradamage, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
    else
        inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        inst.components.talker:Say(STRINGS.musha.skills.sneak.backstab_perfect)
        CustomAttachFx(target, "statue_transition")
        CustomAttachFx(inst, "nightsword_curve_fx", nil, Vector3(2, 2, 2))

        target.components.combat:GetAttacked(inst, 2 * extradamage, inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)

        CustomCancelTask(inst.task_removebackstabspeedboost)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "backstabspeedboost",
            (TUNING.musha.skills.sneakspeedboost.max)) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier)
        inst.task_removebackstabspeedboost = inst:DoTaskInTime(TUNING.musha.skills.sneakspeedboost.backstabbonustime,
            function()
                inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "backstabspeedboost")
                inst.task_removebackstabspeedboost = nil
            end)
    end
end

local function EnterSneak(inst, data)
    if data.name == "entersneak" then
        inst:AddTag("notarget")
        CustomDoAOE(inst, 40, { "_combat" }, nil, nil, function(v)
            if v.components.combat and v.components.combat.target == inst then
                v.components.combat.target = nil
            end
        end)

        inst.components.talker:Say(STRINGS.musha.skills.sneak.success)
        inst.components.colourtweener:StartTween({ 0.1, 0.1, 0.1, 1 }, 0)
        inst.Physics:SetCollisionMask(COLLISION.WORLD)
        CustomAttachFx(inst, { "statue_transition", "shadow_shield" .. math.random(1, 6) })
        CancelSneakSpeedBoost(inst)
        inst:ListenForEvent("onattackother", BackStab)

        inst:RemoveEventCallback("timerdone", EnterSneak)
    end
end

local function SneakFailed(inst)
    inst:StopSneaking()
    inst.components.talker:Say(STRINGS.musha.skills.sneak.failed)
end

local function StartSneaking(inst)
    inst:AddTag("sneaking")
    if inst.components.mushaskilltree:IsActivated("shadowprison") then inst:AddTag("shadowprisonready") end -- For MANASPELL action's strfn
    inst:RemoveTag("scarytoprey")
    inst.components.talker:Say(STRINGS.musha.skills.sneak.start)
    inst:ListenForEvent("attacked", SneakFailed)
    inst.components.colourtweener:StartTween({ 0.3, 0.3, 0.3, 1 }, 0)
    CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))

    inst.components.timer:StartTimer("entersneak", TUNING.musha.skills.sneak.preparetime)
    inst:ListenForEvent("timerdone", EnterSneak)

    if inst.components.mushaskilltree:IsActivated("sneakspeedboost") then
        SneakSpeedBoost(inst)
    end
end

local function StopSneaking(inst)
    CancelSneakSpeedBoost(inst)
    inst:RemoveTag("sneaking")
    inst:RemoveTag("notarget")
    inst:RemoveTag("shadowprisonready")
    inst:AddTag("scarytoprey")
    inst:RemoveEventCallback("onattackother", BackStab)
    inst:RemoveEventCallback("attacked", SneakFailed)
    inst:RemoveEventCallback("timerdone", EnterSneak)
    inst.components.timer:StopTimer("entersneak")
    inst.components.colourtweener:StartTween({ 1, 1, 1, 1 }, 0)
    ChangeToCharacterPhysics(inst, 75, .5)
    CustomAttachFx(inst, "statue_transition_2", nil, Vector3(1.2, 1.2, 1.2))
end

---------------------------------------------------------------------------------------------------------

-- Character mode related

-- Decide normal mode or full mode
local function DecideNormalOrFull(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        return
    end

    if inst.components.hunger.current < TUNING.musha.charactermode.full.hungerthreshold then
        inst.mode:set(0)
    else
        inst.mode:set(1)
    end
end

local function ValkyrieModeOnTimerDone(inst, data)
    if data.name == "cooldown_valkyriemode" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.valkyriemode.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ValkyrieModeOnTimerDone)
    end
end

local function ShadowModeOnTimerDone(inst, data)
    if data.name == "cooldown_shadowmode" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.shadowmode.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ShadowModeOnTimerDone)
    end
end

-- Hotkey: R
local function ValkyrieKeyLongPressed(inst, data)
    if data.name == "valkyriekeyonlongpress" then
        -- Delayed event, need to check again
        if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
            inst:RemoveEventCallback("timerdone", ValkyrieKeyLongPressed)
            return
        end

        if inst.mode:value() == 0 or inst.mode:value() == 1 then
            if inst:HasDebuff("elementloaded") then
                local element = CustomFindKeyByValue(elementlist, inst.elementmode)
                if TUNING.musha.skills.launchelement[element].charged then
                    inst.nolaunchelement = true
                    if not inst.components.mushaskilltree:IsActivated("charged" .. element) then
                        inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                    elseif TUNING.musha.skills.launchelement[element].charged.extramanacost and
                        inst.components.mana.current < TUNING.musha.skills.launchelement[element].charged.extramanacost then
                        inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                        CustomPlayFailedAnim(inst)
                    elseif TUNING.musha.skills.launchelement[element].charged.extrasanitycost and
                        inst.components.sanity.current <
                        TUNING.musha.skills.launchelement[element].charged.extrasanitycost then
                        inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                        CustomPlayFailedAnim(inst)
                    else
                        local function ElementRemoved(inst, data)
                            if data.name == "elementloaded" then
                                inst:RemoveEventCallback("timerdone", OnElementCharged)
                                inst.components.timer:SetTimeLeft("chargingelement", 0) -- After RemoveEventCallback
                                inst.SoundEmitter:KillSound("charging")
                                inst:RemoveEventCallback("debuffremoved", ElementRemoved)
                            end
                        end

                        local chargetime = TUNING.musha.skills.launchelement[element].charged.chargetime
                        inst.components.timer:StartTimer("chargingelement", chargetime)
                        inst:ListenForEvent("timerdone", OnElementCharged)
                        inst:ListenForEvent("debuffremoved", ElementRemoved)
                        inst.SoundEmitter:PlaySound("dontstarve/creatures/together/deer/fx/charge_LP", "charging")
                    end
                end
            else
                if not inst.components.mushaskilltree:IsActivated("valkyriemode") then
                    inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                elseif inst.components.rider:IsRiding() then
                    inst.components.talker:Say(STRINGS.musha.mount_not_allowed)
                    CustomPlayFailedAnim(inst)
                elseif inst.components.timer:TimerExists("cooldown_valkyriemode") then
                    inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                        .. STRINGS.musha.skills.valkyriemode.name
                        .. STRINGS.musha.skills.incooldown.part2
                        .. STRINGS.musha.skills.incooldown.part3
                        .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_valkyriemode"))
                        .. STRINGS.musha.skills.incooldown.part4)
                elseif inst.components.mana.current < TUNING.musha.skills.valkyriemode.manacost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                    CustomPlayFailedAnim(inst)
                elseif inst.components.stamina.current < TUNING.musha.skills.desolatedive.staminacost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                    CustomPlayFailedAnim(inst)
                else
                    -- Mana and stamina cost handled in stategraph
                    inst.startdesolatedive_pre:push()
                end
            end
        elseif inst.mode:value() == 2 then
            if not inst.components.mushaskilltree:IsActivated("desolatedive") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.rider:IsRiding() then
                inst.components.talker:Say(STRINGS.musha.mount_not_allowed)
                CustomPlayFailedAnim(inst)
            elseif inst.components.timer:TimerExists("cooldown_desolatedive") then -- Different skill cooldown timer
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.desolatedive.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_desolatedive"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.stamina.current < TUNING.musha.skills.desolatedive.staminacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                CustomPlayFailedAnim(inst)
            else
                -- Stamina cost handled in stategraph
                inst.startdesolatedive_pre:push()
            end
        elseif inst.mode:value() == 3 then
            if not inst.components.mushaskilltree:IsActivated("phantomblossom") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.rider:IsRiding() then
                inst.components.talker:Say(STRINGS.musha.mount_not_allowed)
                CustomPlayFailedAnim(inst)
            elseif inst.components.timer:TimerExists("cooldown_phantomblossom") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.phantomblossom.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_phantomblossom"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.mana.current < TUNING.musha.skills.phantomblossom.manacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            elseif inst.components.sanity.current < TUNING.musha.skills.phantomblossom.sanitycost then
                inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                CustomPlayFailedAnim(inst)
            elseif inst.components.stamina.current < TUNING.musha.skills.phantomblossom.staminacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                CustomPlayFailedAnim(inst)
            else
                -- Costs handled in the stategraph
                inst.startphantomblossom_pre:push()
            end
        end

        inst:RemoveEventCallback("timerdone", ValkyrieKeyLongPressed)
    end
end

local function ValkyrieKeyDown(inst, x, y, z)
    -- Can recharge when using skills
    if inst.components.health:IsDead() or inst:HasTag("playerghost")
        or (inst.sg:HasStateTag("musha_nointerrupt") and not inst.sg:HasStateTag("musha_attacking")) then
        inst.novalkyriekeyonlongpress = nil
        return
    end

    inst.bufferedcursorpos = Vector3(x, y, z)

    if inst.mode:value() == 2 then
        if inst.components.timer:TimerExists("premagpiestep") and inst.components.mushaskilltree:IsActivated("magpiestep")
            and not inst.components.rider:IsRiding() then
            inst.startmagpiestep:push()
            inst.novalkyriekeyonlongpress = true
        else
            if not inst:HasTag("lightningstrikeready") and inst.components.mushaskilltree:IsActivated("lightningstrike") then
                if inst.components.mana.current < TUNING.musha.skills.lightningstrike.manacost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                    CustomPlayFailedAnim(inst)
                else
                    inst.components.mana:DoDelta(-TUNING.musha.skills.lightningstrike.manacost)
                    LightningRecharge(inst)
                    inst.noannihilation = true -- No annihilation until release key and press again
                end
            end

            if inst.sg:HasStateTag("musha_attacking") then
                inst.novalkyriekeyonlongpress = true
            end
        end
    end

    if not inst.novalkyriekeyonlongpress then
        inst.components.timer:StartTimer("valkyriekeyonlongpress", TUNING.musha.singleclicktimewindow)
        inst:ListenForEvent("timerdone", ValkyrieKeyLongPressed)
    end

    inst.novalkyriekeyonlongpress = nil
end

local function ValkyrieKeyUp(inst, x, y, z)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        inst.noannihilation = nil
        inst.nolaunchelement = nil
        inst.components.timer:StopTimer("valkyriekeyonlongpress")
        inst:RemoveEventCallback("timerdone", ValkyrieKeyLongPressed)
        return
    end

    inst.bufferedcursorpos = Vector3(x, y, z)

    if inst.mode:value() == 0 or inst.mode:value() == 1 then
        if inst.components.timer:TimerExists("valkyriekeyonlongpress") then
            LaunchElement(inst, { CursorPosition = Vector3(x, y, z) })
        elseif inst:HasDebuff("elementloaded") then
            if inst.nolaunchelement then -- Stop charging
                inst:PushEvent("debuffremoved", { name = "elementloaded" })
            else -- Launch charged element
                LaunchElement(inst, { CursorPosition = Vector3(x, y, z) })
            end
        elseif inst.sg:HasStateTag("musha_desolatedive_pre") then
            inst.startdesolatedive:push()
        end
    elseif inst.mode:value() == 2 then
        if inst.components.timer:TimerExists("valkyriekeyonlongpress")
            and not inst.noannihilation and not inst.components.rider:IsRiding() then
            if not inst.components.mushaskilltree:IsActivated("annihilation") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.timer:TimerExists("cooldown_annihilation") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.annihilation.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_annihilation"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.mana.current < TUNING.musha.skills.annihilation.manacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            elseif inst.components.stamina.current < TUNING.musha.skills.annihilation.staminacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                CustomPlayFailedAnim(inst)
            else
                inst.components.mana:DoDelta(-TUNING.musha.skills.annihilation.manacost)
                inst.components.stamina:DoDelta(-TUNING.musha.skills.annihilation.staminacost)
                inst.startannihilation:push()
            end
        elseif inst.sg:HasStateTag("musha_desolatedive_pre") then
            inst.startdesolatedive:push()
        end
    elseif inst.mode:value() == 3 then
        if inst.components.timer:TimerExists("valkyriekeyonlongpress") then
            if inst.components.timer:TimerExists("phantomslashready") then
                if not inst.components.mushaskilltree:IsActivated("phantomslash") then
                    inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                elseif inst.components.stamina.current < TUNING.musha.skills.phantomslash.staminacost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                    CustomPlayFailedAnim(inst)
                else
                    inst.components.stamina:DoDelta(-TUNING.musha.skills.phantomslash.staminacost)
                    StartPhantomSlash(inst, { target = inst.bufferedphantomslashtarget })
                end
            else
                if not inst.components.mushaskilltree:IsActivated("voidphantom") then
                    inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                elseif inst.components.timer:TimerExists("cooldown_voidphantom") then
                    inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                        .. STRINGS.musha.skills.voidphantom.name
                        .. STRINGS.musha.skills.incooldown.part2
                        .. STRINGS.musha.skills.incooldown.part3
                        .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_voidphantom"))
                        .. STRINGS.musha.skills.incooldown.part4)
                else
                    local must_tags = { "_combat" }
                    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead",
                        "playerghost", "player", "companion", "musha_companion" }
                    local target = TheSim:FindEntities(x, y, z, 4, must_tags, ignore_tags)[1] or
                        inst.components.combat.target

                    if not (target and target:IsValid()) then
                        inst.components.talker:Say(STRINGS.musha.no_target)
                    elseif not inst:IsNear(target, TUNING.musha.skills.voidphantom.range) then
                        inst.components.talker:Say(STRINGS.musha.out_of_range)
                        local scale = math.sqrt(TUNING.musha.skills.voidphantom.range / 12)
                        CustomAttachFx(inst, "reticuleaoeping_1d2_12_musha", nil, Vector3(scale, scale, scale))
                    elseif inst.components.mana.current < TUNING.musha.skills.voidphantom.manacost then
                        inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                        CustomPlayFailedAnim(inst)
                    elseif inst.components.sanity.current < TUNING.musha.skills.voidphantom.sanitycost then
                        inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                        CustomPlayFailedAnim(inst)
                    elseif inst.components.stamina.current < TUNING.musha.skills.voidphantom.staminacost then
                        inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                        CustomPlayFailedAnim(inst)
                    else
                        inst.components.mana:DoDelta(-TUNING.musha.skills.voidphantom.manacost)
                        inst.components.sanity:DoDelta(-TUNING.musha.skills.voidphantom.sanitycost)
                        inst.components.stamina:DoDelta(-TUNING.musha.skills.voidphantom.staminacost)
                        inst:StartPhantomAttack({ target = target, standardcast = true, addphantomslashusewindow = true })
                    end
                end
            end
        elseif inst.sg:HasStateTag("musha_phantomblossom_pre") then
            inst.startphantomblossom:push()
        end
    end

    inst.noannihilation = nil
    inst.nolaunchelement = nil
    inst.components.timer:StopTimer("valkyriekeyonlongpress")
    inst:RemoveEventCallback("timerdone", ValkyrieKeyLongPressed)
end

-- Hotkey: G
local function ShadowKeyLongPressed(inst, data)
    if data.name == "shadowkeyonlongpress" then
        -- Delayed event, need to check again
        if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
            inst:RemoveEventCallback("timerdone", ShadowKeyLongPressed)
            return
        end

        if inst.mode:value() == 0 or inst.mode:value() == 1 then
            if not inst.components.mushaskilltree:IsActivated("shadowmode") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.timer:TimerExists("cooldown_shadowmode") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.shadowmode.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_shadowmode"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.sanity.current < TUNING.musha.skills.shadowmode.sanitycost then
                inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                CustomPlayFailedAnim(inst)
            else
                inst.components.sanity:DoDelta(-TUNING.musha.skills.shadowmode.sanitycost)
                inst.activateberserk:push()
            end
        end

        inst:RemoveEventCallback("timerdone", ShadowKeyLongPressed)
    end
end

local function ShadowKeyDown(inst, x, y, z)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        return
    end

    inst.components.timer:StartTimer("shadowkeyonlongpress", TUNING.musha.singleclicktimewindow)
    inst:ListenForEvent("timerdone", ShadowKeyLongPressed)
end

local function ShadowKeyUp(inst, x, y, z)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt") then
        inst.components.timer:StopTimer("shadowkeyonlongpress")
        inst:RemoveEventCallback("timerdone", ShadowKeyLongPressed)
        return
    end

    inst.bufferedcursorpos = Vector3(x, y, z)

    if inst.mode:value() == 0 or inst.mode:value() == 1 then
        if inst.components.timer:TimerExists("shadowkeyonlongpress") then
            if inst:HasDebuff("elementloaded") then
                inst:RemoveDebuff("elementloaded")

                local element = CustomFindKeyByValue(elementlist, inst.elementmode)

                if TUNING.musha.skills.launchelement[element].manacost then
                    inst.components.mana:DoDelta(TUNING.musha.skills.launchelement[element].manacost)
                end
                if TUNING.musha.skills.launchelement[element].sanitycost then
                    inst.components.sanity:DoDelta(TUNING.musha.skills.launchelement[element].sanitycost)
                end

                local success, reason = ElementTakeTurns(inst, { CursorPosition = Vector3(x, y, z) })

                if success then
                    LaunchElement(inst, { CursorPosition = Vector3(x, y, z) })
                elseif reason == "noskill" then
                    inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                elseif reason == "noalter" then
                    LaunchElement(inst, { CursorPosition = Vector3(x, y, z) })
                end
            end
        end
    elseif inst.mode:value() == 2 and not inst.components.rider:IsRiding() then
        if inst.components.timer:TimerExists("shadowkeyonlongpress") then
            if inst.components.timer:TimerExists("prevalkyriewhirl")
                and inst.components.mushaskilltree:IsActivated("valkyriewhirl") then
                if inst.components.stamina.current < TUNING.musha.skills.valkyriewhirl.staminacost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                    CustomPlayFailedAnim(inst)
                else
                    inst.components.stamina:DoDelta(-TUNING.musha.skills.valkyriewhirl.staminacost)
                    inst.startvalkyriewhirl:push()
                end
            elseif inst.components.timer:TimerExists("clearsetsugetsukacounter")
                and inst.components.mushaskilltree:IsActivated("phoenixadvent")
                and ((inst.components.mushaskilltree:IsActivated("setsugetsukaredux") and inst.setsugetsuka_counter >= 3)
                    or not inst.components.mushaskilltree:IsActivated("setsugetsukaredux")) then
                inst.startphoenixadvent:push()
            elseif not inst.components.mushaskilltree:IsActivated("setsugetsuka") then
                inst.components.talker:Say(STRINGS.musha.lack_of_xp)
            elseif inst.components.mana.current < TUNING.musha.skills.setsugetsuka.manacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            elseif inst.components.stamina.current < TUNING.musha.skills.setsugetsuka.staminacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_stamina)
                if inst.components.timer:TimerExists("clearsetsugetsukacounter")
                    and inst.components.mushaskilltree:IsActivated("phoenixadvent") then
                    inst.startphoenixadvent:push()
                else
                    CustomPlayFailedAnim(inst)
                end
            else
                if inst.components.timer:TimerExists("clearsetsugetsukacounter") and inst.setsugetsuka_counter < 3
                    and inst.components.mushaskilltree:IsActivated("setsugetsukaredux") then
                    inst.components.mana:DoDelta(-TUNING.musha.skills.setsugetsuka.manacost)
                    inst.components.stamina:DoDelta(-TUNING.musha.skills.setsugetsuka.staminacost)
                    inst:PushEvent("startsetsugetsuka")
                else
                    if inst.components.timer:TimerExists("cooldown_setsugetsuka") then
                        inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                            .. STRINGS.musha.skills.setsugetsuka.name
                            .. STRINGS.musha.skills.incooldown.part2
                            .. STRINGS.musha.skills.incooldown.part3
                            .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_setsugetsuka"))
                            .. STRINGS.musha.skills.incooldown.part4)
                    else
                        inst.components.mana:DoDelta(-TUNING.musha.skills.setsugetsuka.manacost)
                        inst.components.stamina:DoDelta(-TUNING.musha.skills.setsugetsuka.staminacost)
                        inst.startsetsugetsuka_pre:push()
                    end
                end
            end
        end
    elseif inst.mode:value() == 3 then
        if inst.components.timer:TimerExists("shadowkeyonlongpress") then
            if inst:HasTag("sneaking") then
                StopSneaking(inst)
                inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
                inst.components.talker:Say(STRINGS.musha.skills.sneak.stop)
            else
                if not inst.components.mushaskilltree:IsActivated("sneak") then
                    inst.components.talker:Say(STRINGS.musha.lack_of_xp)
                elseif inst.components.sanity.current < TUNING.musha.skills.sneak.sanitycost then
                    inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                    CustomPlayFailedAnim(inst)
                else
                    inst.components.sanity:DoDelta(-TUNING.musha.skills.sneak.sanitycost)
                    StartSneaking(inst)
                end
            end
        end
    end

    inst.components.timer:StopTimer("shadowkeyonlongpress")
    inst:RemoveEventCallback("timerdone", ShadowKeyLongPressed)
end

-- Resist freeze
local function UnfreezeOnFreeze(inst)
    inst.components.freezable:Unfreeze()

    inst:AddTag("MUSHA_fueled") -- Prevents continuous freezing (deer_ice_circle)
    inst:DoTaskInTime(0.5, function()
        inst:RemoveTag("MUSHA_fueled")
    end)
end

-- Area attack
local function ValkyrieOnAttackOther(inst, data)
    local target = data.target
    local weapon = data.weapon

    if inst:HasTag("areaattack") then
        local range = weapon and weapon:HasTag("areaattack") and 1.5 * TUNING.musha.areaattackrange
            or TUNING.musha.areaattackrange
        local excludetags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost",
            "player", "companion", "musha_companion" }

        inst.components.combat:DoAreaAttack(target, range, weapon, nil, nil, excludetags) -- Note: DoAreaAttack(target, range, weapon, validfn, stimuli, excludetags)

        local fx = SpawnPrefab("groundpoundring_fx")
        local scale = math.sqrt(range / 12)
        fx.Transform:SetScale(scale, scale, scale)
        fx.Transform:SetPosition(target:GetPosition():Get())
    end
end

-- Regen health and sanity when kill monster
local function ValkyrieOnKilled(inst, data)
    local victim = data.victim

    if victim and (victim:HasTag("monster") or victim:HasTag("hostile")) then
        local baseamt = victim.components.health and victim.components.health.maxhealth or 100
        inst.components.health:DoDelta(TUNING.musha.charactermode.valkyrie.healthregenonkill * baseamt, nil, nil, true) -- Note: DoDelta(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
        inst.components.sanity:DoDelta(TUNING.musha.charactermode.valkyrie.sanityregenonkill * baseamt)
        inst.components.mana:DoDelta(TUNING.musha.charactermode.valkyrie.manaregenonkill * baseamt)
    end
end

-- Remove sanity penalty when kill shadow creature
local function RemoveSanityPenaltyOnKilled(inst, data)
    local victim = data.victim

    if victim and victim:HasOneOfTags({ "shadow", "shadowcreature", "shadowchesspiece", "stalker" }) then
        inst.components.sanity:AddSanityPenalty("shadowmodebuff",
            math.max(0, inst.components.sanity.sanity_penalties["shadowmodebuff"] -
                TUNING.musha.charactermode.shadow.sanitypenaltydeltaonkill / inst.components.sanity.max))
    end
end

-- Regen mana when attacked by electric
local function ValkyrieOnAttacked(inst, data)
    if data.stimuli == "electric" then
        inst.components.mana:DoDelta(TUNING.musha.charactermode.valkyrie.manaregenbyelectric)
    end
end

-- Custom drowning damage
local function GetDrowningDamgeTunings(inst)
    return TUNING.musha.charactermode.valkyrie.drowningdamage
end

-- Shadow trailing fx (ancient cane)
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
        inst.components.sanity.externalmodifiers:RemoveModifier(inst, "fullmodebuff")
        inst.components.hunger.burnratemodifiers:RemoveModifier(inst, "fullmodebuff")
        inst.components.eater:SetDiet({ FOODGROUP.OMNI })
        inst.components.eater.preferseatingtags = nil
        inst.components.eater.stale_hunger = TUNING.musha.stalefoodhungerrate
        inst.components.eater:SetRefusesSpoiledFood(false)
        CustomCancelTask(inst.task_fullmodehealthregen)
    end

    if previousmode == 2 and currentmode ~= 2 then
        inst.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, "valkyriebuff") -- Note: SourceModifierList:RemoveModifier(source, key)
        inst.components.mana.modifiers:RemoveModifier(inst, "valkyriebuff")

        inst:RemoveTag("areaattack")
        inst:RemoveEventCallback("onattackother", ValkyrieOnAttackOther)

        inst:RemoveEventCallback("killed", ValkyrieOnKilled)

        inst.components.inventory.isexternallyinsulated:RemoveModifier(inst, "valkyriebuff")
        inst:RemoveEventCallback("attacked", ValkyrieOnAttacked)

        inst:RemoveTag("stronggrip")
        inst.components.drownable:SetCustomTuningsFn(nil)

        inst:LightningDischarge()
        inst.components.timer:StopTimer("lightningrecharge")
        inst:RemoveEventCallback("timerdone", LightningStrikeOnTimerDone)

        CustomAttachFx(inst, "electrichitsparks")
        inst.components.timer:StartTimer("cooldown_valkyriemode", TUNING.musha.skills.valkyriemode.cooldown)
        inst:ListenForEvent("timerdone", ValkyrieModeOnTimerDone)
        inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    end

    if previousmode == 3 and currentmode ~= 3 then
        if inst:HasTag("sneaking") then
            inst:StopSneaking()
            inst.components.sanity:DoDelta(TUNING.musha.skills.sneak.sanitycost)
        else
            CustomAttachFx(inst, "statue_transition_2") -- Avoid dupulicate fx
        end

        inst:RemoveEventCallback("freeze", UnfreezeOnFreeze)

        inst.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "shadowmodebuff")

        inst.components.sanity.externalmodifiers:RemoveModifier(inst, "shadowmodebuff")
        inst.components.sanity.neg_aura_absorb = 0 -- Check sanity component, could be deprecated in the future
        inst.components.sanity:RemoveSanityPenalty("shadowmodebuff") -- Currently sanity penalty will not be saved, if there are future changes, this line should be added to onsave/onload
        CustomCancelTask(inst.task_updatesanitypenalty)
        inst:RemoveEventCallback("killed", RemoveSanityPenaltyOnKilled)

        CustomCancelTask(inst.modetrailtask)

        for _, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowmusha") and not v:HasTag("shadowvalkyrie") then
                v:DoTaskInTime(math.random() * 0.5 + 0.5,
                    function() -- Delay for at least 0.5 seconds to make sure the activate event is triggered
                        v:PushEvent("shadowberserk_quit")
                    end)
            end
        end

        inst.components.timer:StartTimer("cooldown_shadowmode", TUNING.musha.skills.shadowmode.cooldown)
        inst:ListenForEvent("timerdone", ShadowModeOnTimerDone)
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
        inst.components.hunger.burnratemodifiers:SetModifier(inst, TUNING.musha.charactermode.full.hungerdrain,
            "fullmodebuff")
        inst.components.sanity.externalmodifiers:SetModifier(inst, TUNING.musha.charactermode.full.sanityregen,
            "fullmodebuff")
        inst.task_fullmodehealthregen = inst:DoPeriodicTask(1, function()
            if not inst.components.health:IsDead() then
                inst.components.health:DoDelta(TUNING.musha.charactermode.full.healthregen, true, "regen")
            end
        end, nil, inst.components.health)

        if math.random() < 1 / 3 then
            inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODTYPE.MEAT, FOODTYPE.GOODIES })
        elseif math.random() < 1 / 2 then
            inst.components.eater:SetDiet({ FOODGROUP.VEGETARIAN })
        else
            inst.components.eater:SetPrefersEatingTag("preparedfood")
            inst.components.eater:SetPrefersEatingTag("pre-preparedfood")
        end
        inst.components.eater.stale_hunger = 0
        inst.components.eater:SetRefusesSpoiledFood(true)

        inst.components.skinner:SetSkinName("musha_full")
        inst.customidleanim = "idle_warly"
        inst.soundsname = "willow"
        if previousmode == 0 then
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
        end
    end

    if currentmode == 2 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
        inst.components.debuffable:RemoveDebuff("elementloaded")

        inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst,
            TUNING.musha.charactermode.valkyrie.damagetakenmultiplier, "valkyriebuff")
        inst.components.mana.modifiers:SetModifier(inst,
            TUNING.musha.charactermode.valkyrie.manaongoingmodifier, "valkyriebuff")

        inst.components.inventory.isexternallyinsulated:SetModifier(inst, true, "valkyriebuff")
        inst:ListenForEvent("attacked", ValkyrieOnAttacked)

        if inst.components.mushaskilltree:IsActivated("areaattack") then
            inst:AddTag("areaattack")
            inst:ListenForEvent("onattackother", ValkyrieOnAttackOther)
        end

        if inst.components.mushaskilltree:IsActivated("fightingspirit") then
            inst:ListenForEvent("killed", ValkyrieOnKilled)
        end

        if inst.components.mushaskilltree:IsActivated("stronggrip") then
            inst:AddTag("stronggrip")
            inst.components.drownable:SetCustomTuningsFn(GetDrowningDamgeTunings)
        end

        if inst.components.mushaskilltree:IsActivated("lightningstrike") then
            LightningRecharge(inst)
        end
        inst:ListenForEvent("timerdone", LightningStrikeOnTimerDone)

        inst.components.skinner:SetSkinName("musha_valkyrie")
        inst.customidleanim = "idle_wathgrithr"
        inst.soundsname = "winnie"
    end

    if currentmode == 3 then
        inst:RemoveEventCallback("hungerdelta", DecideNormalOrFull)
        inst.components.debuffable:RemoveDebuff("elementloaded")

        inst.components.freezable:Unfreeze() -- Therotically not necessary
        inst:ListenForEvent("freeze", UnfreezeOnFreeze)

        inst.components.health.externalfiredamagemultipliers:SetModifier(inst, 0, "shadowmodebuff")

        inst.components.sanity.externalmodifiers:SetModifier(inst, TUNING.musha.charactermode.shadow.sanityregen,
            "shadowmodebuff")
        inst.components.sanity.neg_aura_absorb = TUNING.musha.charactermode.shadow.negsanityauraabsorb -- Check sanity component, could be deprecated in the future
        inst.components.sanity:AddSanityPenalty("shadowmodebuff",
            1 - math.clamp((inst.components.sanity.current + TUNING.musha.skills.shadowmode.sanitycost) / inst.components.sanity.max, 0, 1)) -- Note: AddSanityPenalty(key, modifier:pct)
        inst.task_updatesanitypenalty = inst:DoPeriodicTask(TUNING.musha.charactermode.shadow.sanitypenaltyrecaltime,
            function()
                inst.components.sanity:AddSanityPenalty("shadowmodebuff",
                    math.min(1, inst.components.sanity.sanity_penalties["shadowmodebuff"] +
                        TUNING.musha.charactermode.shadow.sanitypenaltyrecaltime *
                        TUNING.musha.charactermode.shadow.sanitypenaltyongoing / inst.components.sanity.max))
            end, TUNING.musha.charactermode.shadow.sanitypenaltyrecaltime)
        inst:ListenForEvent("killed", RemoveSanityPenaltyOnKilled)

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

local function SetFatigueGrogginess(inst, data)
    -- No worry if character is dead since fatigue level is reset to 1 by OnBecameGhost
    local fatiguelevel = inst.fatiguelevel:value()

    if not inst.task_removefatiguegrogginess then
        local probability = Remap(inst.components.fatigue:GetPercent(),
            TUNING.musha.fatiguelevel["level" .. fatiguelevel - 1].upper,
            TUNING.musha.fatiguelevel["level" .. fatiguelevel].upper,
            TUNING.musha.fatiguelevel["level" .. fatiguelevel].groggyprobmin,
            TUNING.musha.fatiguelevel["level" .. fatiguelevel].groggyprobmax)
        if math.random() < probability then
            inst:AddTag("groggy")
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguegrogginess",
                TUNING.musha.fatiguelevel["level" .. fatiguelevel].groggyspeedmultiplier)

            local duration = TUNING.musha.fatiguelevel["level" .. fatiguelevel].groggytimebase
                + math.random() * TUNING.musha.fatiguelevel["level" .. fatiguelevel].groggytimemultiplier
            inst.task_removefatiguegrogginess = inst:DoTaskInTime(duration, function()
                inst:RemoveTag("groggy")
                inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguegrogginess")
                inst.task_removefatiguegrogginess = nil
            end)
        end
    end

    if fatiguelevel == 4 and not inst.sg:HasStateTag("musha_nointerrupt") then
        if math.random() < TUNING.musha.fatiguelevel["level" .. fatiguelevel].knockoutprob then
            inst.sg:GoToState("knockout")
        end
    end
end

local function DecideFatigueLevel(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") then
        return
    end

    local pct = inst.components.fatigue:GetPercent()

    if pct < TUNING.musha.fatiguelevel.level0.upper then
        inst.fatiguelevel:set(0)
    elseif pct < TUNING.musha.fatiguelevel.level1.upper then
        inst.fatiguelevel:set(1)
    elseif pct < TUNING.musha.fatiguelevel.level2.upper then
        inst.fatiguelevel:set(2)
    elseif pct < TUNING.musha.fatiguelevel.level3.upper then
        inst.fatiguelevel:set(3)
    else
        inst.fatiguelevel:set(4)
    end
end

local function OnFatigueLevelChange(inst)
    local _fatiguelevel = inst._fatiguelevel
    local fatiguelevel = inst.fatiguelevel:value()
    local workmultiplier = TUNING.musha.fatiguelevel["level" .. fatiguelevel].workmultiplier
    local speedmultiplier = TUNING.musha.fatiguelevel["level" .. fatiguelevel].speedmultiplier

    CustomRemoveEntity(inst.fx_fatiguelevel)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, inst)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, inst)
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguelevel")

    if _fatiguelevel == 3 and fatiguelevel ~= 3 then
        if fatiguelevel ~= 4 then
            inst:RemoveTag("groggy")
            CustomCancelTask(inst.task_removefatiguegrogginess)
            inst.task_removefatiguegrogginess = nil
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguegrogginess")
        end
        inst:RemoveEventCallback("newstate", SetFatigueGrogginess)
    end

    if _fatiguelevel == 4 and fatiguelevel ~= 4 then
        if fatiguelevel ~= 3 then
            inst:RemoveTag("groggy")
            CustomCancelTask(inst.task_removefatiguegrogginess)
            inst.task_removefatiguegrogginess = nil
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "fatiguegrogginess")
        end
        inst:RemoveEventCallback("newstate", SetFatigueGrogginess)
    end

    if fatiguelevel == 0 then
        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
        inst.fx_fatiguelevel = CustomAttachFx(inst, "fx_pawprint_white", { duration = 0 }, nil, Vector3(0, -0.1, 0))
    end

    if fatiguelevel == 2 then
        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
        inst.fx_fatiguelevel = CustomAttachFx(inst, "fx_pawprint_yellow", { duration = 0 }, nil, Vector3(0, -0.1, 0))
    end

    if fatiguelevel == 3 then
        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
        inst.fx_fatiguelevel = CustomAttachFx(inst, "fx_pawprint_orange", { duration = 0 }, nil, Vector3(0, -0.1, 0))

        inst:ListenForEvent("newstate", SetFatigueGrogginess)
    end

    if fatiguelevel == 4 then
        inst.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.MINE, workmultiplier, inst)
        inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, workmultiplier, inst)
        inst.components.locomotor:SetExternalSpeedMultiplier(inst, "fatiguelevel", speedmultiplier)
        inst.fx_fatiguelevel = CustomAttachFx(inst, "fx_pawprint_red", { duration = 0 }, nil, Vector3(0, -0.1, 0))

        inst:ListenForEvent("newstate", SetFatigueGrogginess)
    end

    inst._fatiguelevel = fatiguelevel -- Update previous fatiguelevel
end

---------------------------------------------------------------------------------------------------------

-- Recalculate max status on skill tree change

local function RecalcStatus(inst, status, init)
    -- For health and sanity their OnLoad fn are called before mushaskilltree.OnLoad, for stamina and mana their loading sequence can be set by reordering inst:AddComponent (currently after mushaskilltree)
    if status == "stamina" then
        local base = TUNING.musha.maxstamina
        local bonus = inst.components.mushaskilltree:IsActivated("maxstamina3")
            and (TUNING.musha.skills.maxstamina3.bonus + TUNING.musha.skills.maxstamina3.bonusmultiplier * inst.components.leveler:GetLevel())
            or inst.components.mushaskilltree:IsActivated("maxstamina2") and TUNING.musha.skills.maxstamina2.bonus
            or inst.components.mushaskilltree:IsActivated("maxstamina1") and TUNING.musha.skills.maxstamina1.bonus or 0

        if init then
            inst.components.stamina.max = base + bonus
        else
            inst.components.stamina:SetMax(base + bonus)
        end
    elseif status == "mana" then
        local base = TUNING.musha.maxmana
        local bonus = inst.components.mushaskilltree:IsActivated("maxmana3")
            and (TUNING.musha.skills.maxmana3.bonus + TUNING.musha.skills.maxmana3.bonusmultiplier * inst.components.leveler:GetLevel())
            or inst.components.mushaskilltree:IsActivated("maxmana2") and TUNING.musha.skills.maxmana2.bonus
            or inst.components.mushaskilltree:IsActivated("maxmana1") and TUNING.musha.skills.maxmana1.bonus or 0

        if init then
            inst.components.mana.max = base + bonus
        else
            inst.components.mana:SetMax(base + bonus)
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- When level up
local function OnLevelUp(inst, data)
    for status in { "health", "sanity", "stamina", "mana" } do
        inst:RecalcStatus(status)
    end
end

---------------------------------------------------------------------------------------------------------

-- When the character is revived to human
local function OnBecameHuman(inst)
    inst:AddTag("nofx")
    inst:ListenForEvent("hungerdelta", DecideNormalOrFull)
    inst:DecideNormalOrFull()

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
    inst.fatiguelevel:set(1)
    inst.components.timer:SetTimeLeft("stopelfmelody_full", 0)
    inst.components.timer:SetTimeLeft("stopelfmelody_partial", 0)
end

-- When save game progress
local function OnSave(inst, data)
end

-- When preload (before loading components)
local function OnPreload(inst, data)
end

-- When loading the character from a saved game
local function OnLoad(inst)
    if inst:HasTag("playerghost") then
        OnBecameGhost(inst)
    else
        OnBecameHuman(inst)
    end

    for _, name in pairs(Timers) do
        inst.components.timer:StopTimer(name)
    end
end

-- When the character is spawned for the first time
local function OnNewSpawn(inst)
    OnBecameHuman(inst)
end

local function OnDespawn(inst)
end

---------------------------------------------------------------------------------------------------------

-- Musha classified
local function AttachMushaClassified(inst, classified)
    inst.musha_classified = classified
    inst.ondetachmushaclassified = function() inst:DetachMushaClassified() end
    inst:ListenForEvent("onremove", inst.ondetachmushaclassified, classified)
end

local function DetachMushaClassified(inst)
    inst.musha_classified = nil
    inst.ondetachmushaclassified = nil
end

local function OnRemoveEntity(inst)
    if inst.musha_classified ~= nil then
        if TheWorld.ismastersim then
            inst.musha_classified:Remove()
            inst.musha_classified = nil
        else
            inst.musha_classified._parent = nil
            inst:RemoveEventCallback("onremove", inst.ondetachmushaclassified, inst.musha_classified)
            inst:DetachMushaClassified()
        end
    end
    return inst:_OnRemoveEntity()
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

    -- Fire no spread
    inst:AddTag("controlled_burner")

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
    inst._fatiguelevel = 0 -- Store previous fatigue level
    inst.mode = net_tinybyte(inst.GUID, "musha.mode", "modechange") -- 0: normal, 1: full, 2: valkyrie, 3: berserk
    inst.fatiguelevel = net_tinybyte(inst.GUID, "musha.fatiguelevel", "fatiguelevelchange") -- 0-4
    inst.sendcursorposition = net_event(inst.GUID, "sendcursorposition") -- Send cursor position to server
    inst.updaterunninganim = net_event(inst.GUID, "updaterunninganim") -- Handler set in SG
    inst.activateberserk = net_event(inst.GUID, "activateberserk") -- Handler set in SG
    inst.castmanaspell = net_event(inst.GUID, "castmanaspell") -- Handler set in SG
    inst.playfullelfmelody = net_event(inst.GUID, "playfullelfmelody") -- Handler set in SG
    inst.playpartialelfmelody = net_event(inst.GUID, "playpartialelfmelody") -- Handler set in SG
    inst.snifftreasure = net_event(inst.GUID, "snifftreasure") -- Handler set in SG
    inst.startsetsugetsuka_pre = net_event(inst.GUID, "startsetsugetsuka_pre") -- Handler set in SG
    inst.startphoenixadvent = net_event(inst.GUID, "startphoenixadvent") -- Handler set in SG
    inst.startannihilation = net_event(inst.GUID, "startannihilation") -- Handler set in SG
    inst.startdesolatedive_pre = net_event(inst.GUID, "startdesolatedive_pre") -- Handler set in SG
    inst.startdesolatedive = net_event(inst.GUID, "startdesolatedive") -- Handler set in SG
    inst.startmagpiestep = net_event(inst.GUID, "startmagpiestep") -- Handler set in SG
    inst.startvalkyrieparry = net_event(inst.GUID, "startvalkyrieparry") -- Handler set in SG
    inst.startvalkyriestab = net_event(inst.GUID, "startvalkyriestab") -- Handler set in SG
    inst.startvalkyriewhirl = net_event(inst.GUID, "startvalkyriewhirl") -- Handler set in SG
    inst.startshadowparry = net_event(inst.GUID, "startshadowparry") -- Handler set in SG
    inst.endshadowparry = net_event(inst.GUID, "endshadowparry") -- Handler set in SG
    inst.startphantomblossom_pre = net_event(inst.GUID, "startphantomblossom_pre") -- Handler set in SG
    inst.startphantomblossom = net_event(inst.GUID, "startphantomblossom") -- Handler set in SG
    inst._OnRemoveEntity = inst.OnRemoveEntity
    inst.OnRemoveEntity = OnRemoveEntity
    inst.AttachMushaClassified = AttachMushaClassified
    inst.DetachMushaClassified = DetachMushaClassified

    -- Event handlers
    inst:ListenForEvent("modechange", OnModeChange)
    inst:ListenForEvent("sendcursorposition", SendCursorPosition)
end

---------------------------------------------------------------------------------------------------------

-- This initializes for the server only. Components are added here.
local function master_postinit(inst)
    -- Additional classified data
    inst.musha_classified = SpawnPrefab("musha_classified")
    inst.musha_classified.entity:SetParent(inst.entity)

    -- Leveler
    inst:AddComponent("leveler")
    inst.components.leveler:SetMaxExperience(TUNING.musha.maxexperience)
    inst.components.leveler:SetMaxLevel(TUNING.musha.maxlevel)
    inst.components.leveler.exprate = TUNING.musha.exprate
    inst.components.leveler.exp_to_level = TUNING.musha.exp_to_level

    -- Skilltree
    inst:AddComponent("mushaskilltree")

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

    -- Kill counter
    inst:AddComponent("mushacareer")

    -- Read books
    inst:AddComponent("reader")

    -- Stats
    inst.components.health:SetMaxHealth(TUNING.musha.health)
    inst.components.hunger:SetMax(TUNING.musha.hunger)
    inst.components.sanity:SetMax(TUNING.musha.sanity)
    inst.components.eater.stale_hunger = TUNING.musha.stalefoodhungerrate
    inst.components.eater.spoiled_hunger = TUNING.musha.spoiledfoodhungerrate

    -- Combat
    inst.components.combat.damagemultiplier = TUNING.musha.damagemultiplier
    inst.components.combat.areahitdamagepercent = TUNING.musha.areahitdamagepercent
    inst.components.combat.bonusdamagefn = BonusDamageFn

    -- Debuffable
    inst.components.debuffable.ondebuffadded = OnDebuffAdded
    inst.components.debuffable.ondebuffremoved = OnDebuffRemoved

    -- Petleash
    inst._onpetlost = function(pet) inst.components.sanity:RemoveSanityPenalty(pet) end
    inst._OnSpawnPet = inst.components.petleash.onspawnfn
    inst._OnDespawnPet = inst.components.petleash.ondespawnfn
    inst.components.petleash:SetMaxPets(TUNING.musha.maxpets)
    inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    inst.components.petleash:SetOnDespawnFn(OnDespawnPet)

    -- Food bonus
    inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_HUGE)

    -- Common attributes
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
    inst.OnPreLoad = OnPreload -- FIRST, the entity runs its PreLoad method.
    inst.OnLoad = OnLoad -- SECOND, the entity runs the OnLoad function of its components. THIRD, the entity runs its own OnLoad method.
    inst.OnSave = OnSave
    inst.OnNewSpawn = OnNewSpawn
    inst.OnDespawn = OnDespawn

    -- Character specific attributes
    inst.mode:set_local(0) -- Force to trigger dirty event on next :set()
    inst.fatiguelevel:set_local(0) -- Force to trigger dirty event on next :set()
    inst.companionhotkeysenabled = true
    inst.shadowmushafollowonly = false
    inst.elementmode = 1 -- 1: magma, 2: frost, 3: poison, 4: bloom
    inst.plantpool = { 1, 2, 3, 4 }
    inst.DecideNormalOrFull = DecideNormalOrFull
    inst.DecideFatigueLevel = DecideFatigueLevel
    inst.RecalcStatus = RecalcStatus
    inst.StartSneaking = StartSneaking
    inst.StopSneaking = StopSneaking
    inst.PrincessBlessing = PrincessBlessing
    inst.FreezingSpell = FreezingSpell
    inst.ThunderSpell = ThunderSpell
    inst.ShadowPrison = ShadowPrison
    inst.LightningDischarge = LightningDischarge
    inst.StartMelodyBuff = StartMelodyBuff
    inst.StopMelodyBuff = StopMelodyBuff
    inst.SniffTreasure = SniffTreasure
    inst.LaunchElement = LaunchElement
    inst.StartPhantomAttack = StartPhantomAttack

    -- Event handlers
    inst:ListenForEvent("levelup", OnLevelUp)
    inst:ListenForEvent("fatiguelevelchange", OnFatigueLevelChange)
    inst:ListenForEvent("treasurefull", OnTreasureSniffingReady)
    inst:ListenForEvent("oneat", OnEatFood)
    inst:ListenForEvent("death", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnDeathForPetLeash)
    inst:ListenForEvent("ms_becameghost", OnBecameGhost)
    inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
    inst:ListenForEvent("ms_playerreroll", OnRerollForPetLeash)
end

---------------------------------------------------------------------------------------------------------

-- Set up remote procedure calls for client side
AddModRPCHandler("musha", "valkyriekeydown", ValkyrieKeyDown)
AddModRPCHandler("musha", "valkyriekeyup", ValkyrieKeyUp)
AddModRPCHandler("musha", "shadowkeydown", ShadowKeyDown)
AddModRPCHandler("musha", "shadowkeyup", ShadowKeyUp)
AddModRPCHandler("musha", "shieldkeydown", ShieldKeyDown)
AddModRPCHandler("musha", "shieldkeyup", ShieldKeyUp)
AddModRPCHandler("musha", "togglesleep", ToggleSleep)
AddModRPCHandler("musha", "playelfmelody", PlayElfMelody)
AddModRPCHandler("musha", "getcursorposition", GetCursorPosition)
AddModRPCHandler("musha", "switchkeybindings", SwitchKeyBindings)
AddModRPCHandler("musha", "doshadowmushaorder", DoShadowMushaOrder)
AddModRPCHandler("musha", "activateskill", ActivateSkill)

---------------------------------------------------------------------------------------------------------

return MakePlayerCharacter("musha", prefabs, assets, common_postinit, master_postinit)