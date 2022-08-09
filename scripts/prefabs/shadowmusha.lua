local prefabs =
{
    "shadow_despawn",
    "statue_transition_2",
    "nightmarefuel",
}

local brain = require "brains/shadowmushabrain"

local assets =
{
    Asset("ANIM", "anim/player_basic.zip"),
    Asset("ANIM", "anim/swap_axe.zip"),
    Asset("ANIM", "anim/swap_pickaxe.zip"),
    Asset("ANIM", "anim/swap_shovel.zip"),
    Asset("ANIM", "anim/swap_nightmaresword_shadow.zip"),
    Asset("ANIM", "anim/creatures/shadowmusha.zip"),
    Asset("ANIM", "anim/creatures/shadowberserk.zip"),
    Asset("SOUND", "sound/maxwell.fsb"),
    Asset("SOUND", "sound/willow.fsb"),
}

local function OnAttackOther(inst, data)
    local target = data.target
    if inst:HasTag("shadowberserk") then
        local dmg = TUNING.musha.creatures.shadowmusha.damage *
            TUNING.musha.creatures.shadowberserk.randomdamagemultiplier *
            math.random()
        target.components.combat:GetAttacked(inst, dmg)
    end
end

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        if data.attacker.components.petleash ~= nil and
            data.attacker.components.petleash:IsPet(inst) then
            inst.components.lootdropper:SpawnLootPrefab("nightsword", inst:GetPosition())
            data.attacker.components.petleash:DespawnPet(inst)
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
            inst.components.combat:ShareTarget(data.attacker,
                TUNING.musha.creatures.shadowmusha.targetrange * 2,
                function(dude) return dude.components.follower:GetLeader() == inst.components.follower:GetLeader() end,
                TUNING.musha.maxpets,
                { "shadowmusha" }) -- Note: Combat:ShareTarget(target, range, fn, maxnum, musttags)
        end
    end
end

local function OnKilled(inst)
    inst.components.lootdropper:DropLoot(inst:GetPosition())
end

local function OnEnterShadowBerserk(inst)
    if inst:HasTag("shadowberserk") then
        return
    end
    inst:AddTag("shadowberserk")

    local _healthpercent = inst.components.health:GetPercent()
    inst.components.health:SetMaxHealth(TUNING.musha.creatures.shadowberserk.maxhealth)
    inst.components.health:SetPercent(_healthpercent)
    inst.components.health:StartRegen(TUNING.musha.creatures.shadowberserk.healthregen,
        TUNING.musha.creatures.shadowmusha.healthregenperiod)
    inst.components.combat:SetDefaultDamage(TUNING.musha.creatures.shadowberserk.damage)
    inst.components.combat:SetAttackPeriod(TUNING.musha.creatures.shadowberserk.attackperiod)

    inst.AnimState:SetBuild("shadowberserk")
    inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
    CustomAttachFx(inst, "statue_transition")
    inst.AnimState:OverrideSymbol("swap_object", "swap_nightmaresword_shadow", "swap_nightmaresword_shadow")
end

local function OnQuitShadowBerserk(inst)
    if not inst:HasTag("shadowberserk") then
        return
    end
    inst:RemoveTag("shadowberserk")

    local _healthpercent = inst.components.health:GetPercent()
    inst.components.health:SetMaxHealth(TUNING.musha.creatures.shadowmusha.maxhealth)
    inst.components.health:SetPercent(_healthpercent)
    inst.components.health:StartRegen(TUNING.musha.creatures.shadowmusha.healthregen,
        TUNING.musha.creatures.shadowmusha.healthregenperiod)
    inst.components.combat:SetDefaultDamage(TUNING.musha.creatures.shadowmusha.damage)
    inst.components.combat:SetAttackPeriod(TUNING.musha.creatures.shadowmusha.attackperiod)

    inst.AnimState:SetBuild("shadowmusha")
    CustomAttachFx(inst, "statue_transition_2")
end

local RETARGET_MUST_TAGS = { "_combat" }
local RETARGET_CANT_TAGS = { "playerghost", "INLIMBO" }
local function retargetfn(inst)
    --Find things attacking leader
    local leader = inst.components.follower:GetLeader()
    return leader ~= nil
        and FindEntity(
            leader,
            TUNING.musha.creatures.shadowmusha.targetrange,
            function(guy)
                return guy ~= inst
                    and (guy.components.combat:TargetIs(leader) or guy.components.combat:TargetIs(inst)
                        or (inst:HasTag("shadowberserk") and (guy:HasTag("monster") or guy:HasTag("hostile"))))
                    and inst.components.combat:CanTarget(guy)
            end,
            RETARGET_MUST_TAGS, -- see entityreplica.lua
            RETARGET_CANT_TAGS
        )
        or nil
end

local function keeptargetfn(inst, target)
    --Is your leader nearby and your target not dead? Stay on it.
    --Match KEEP_WORKING_DIST in brain
    return inst.components.follower:IsNearLeader(TUNING.musha.creatures.shadowmusha.targetrange)
        and inst.components.combat:CanTarget(target)
        and target.components.minigame_participator == nil
        and not target:HasTag("musha")
        and not (target.components.follower and
            target.components.follower:GetLeader() == inst.components.follower:GetLeader())
end

local function nodebrisdmg(inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
    return afflicter ~= nil and afflicter:HasTag("quakedebris")
end

---------------------------------------------------------------------------------------------------------

local function MakeMinion(prefab, tool, hat, master_postinit)
    local function fn()
        local inst = CreateEntity()

        inst:AddTag("musha_companion")
        inst:AddTag("shadowmusha")
        inst:AddTag("shadowminion")
        inst:AddTag("NOBLOCK")

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeGhostPhysics(inst, 1, 0.5)

        inst.Transform:SetFourFaced(inst)

        inst.AnimState:SetBank("wilson")
        inst.AnimState:SetBuild("shadowmusha")
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetMultColour(1, 1, 1, .6)

        if tool ~= nil then
            inst.AnimState:OverrideSymbol("swap_object", tool, tool)
            inst.AnimState:Hide("ARM_normal")
        else
            inst.AnimState:Hide("ARM_carry")
        end

        if hat ~= nil then
            inst.AnimState:OverrideSymbol("swap_hat", hat, "swap_hat")
            inst.AnimState:Hide("HAIR_NOHAT")
            inst.AnimState:Hide("HAIR")
        else
            inst.AnimState:Hide("HAT")
            inst.AnimState:Hide("HAIR_HAT")
        end

        inst:SetPrefabNameOverride("shadowmusha")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("locomotor")
        inst.components.locomotor.runspeed = TUNING.musha.creatures.shadowmusha.speed
        inst.components.locomotor:SetTriggersCreep(false)
        inst.components.locomotor.pathcaps = { ignorecreep = true }
        inst.components.locomotor:SetSlowMultiplier(.6)

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(TUNING.musha.creatures.shadowmusha.maxhealth)
        inst.components.health:StartRegen(TUNING.musha.creatures.shadowmusha.healthregen,
            TUNING.musha.creatures.shadowmusha.healthregenperiod)
        inst.components.health.nofadeout = true
        inst.components.health.redirect = nodebrisdmg

        inst:AddComponent("combat")
        inst.components.combat:SetDefaultDamage(TUNING.musha.creatures.shadowmusha.damage)
        inst.components.combat:SetAttackPeriod(TUNING.musha.creatures.shadowmusha.attackperiod)
        inst.components.combat:SetRetargetFunction(2, retargetfn) --Look for leader's target.
        inst.components.combat:SetKeepTargetFunction(keeptargetfn) --Keep attacking while leader is near.
        inst.components.combat:SetRange(2)
        inst.components.combat.hiteffectsymbol = "torso"

        inst:AddComponent("follower")
        inst.components.follower:KeepLeaderOnAttacked()
        inst.components.follower.keepdeadleader = true
        inst.components.follower.keepleaderduringminigame = true

        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot({ "nightmarefuel" })

        inst:SetBrain(brain)
        inst:SetStateGraph("SGshadowmusha")

        inst:ListenForEvent("onattackother", OnAttackOther)
        inst:ListenForEvent("attacked", OnAttacked)
        inst:ListenForEvent("death", OnKilled)
        inst:ListenForEvent("shadowberserk_activate", OnEnterShadowBerserk)
        inst:ListenForEvent("shadowberserk_quit", OnQuitShadowBerserk)

        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    return Prefab(prefab, fn, assets, prefabs)
end

---------------------------------------------------------------------------------------------------------

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onbuilt(inst, builder)
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
    builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, inst.pettype)
    inst:Remove()
end

local function MakeBuilder(prefab)
    --These shadows are summoned this way because petleash needs to
    --be the component that summons the pets, not the builder.
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()

        inst:AddTag("CLASSIFIED")

        --[[Non-networked entity]]
        inst.persists = false

        --Auto-remove if not spawned by builder
        inst:DoTaskInTime(0, inst.Remove)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.pettype = prefab
        inst.OnBuiltFn = onbuilt

        return inst
    end

    return Prefab(prefab .. "_builder", fn, nil, { prefab })
end

---------------------------------------------------------------------------------------------------------

return MakeMinion("shadowmusha", "swap_nightmaresword_shadow"),
    MakeBuilder("shadowmusha")
