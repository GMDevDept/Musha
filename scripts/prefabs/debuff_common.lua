local assets = -- Reference
{
    Asset("ANIM", "anim/general/debuff_slowdown.zip"),
    Asset("ANIM", "anim/general/debuff_poison.zip"),
    Asset("ANIM", "anim/general/debuff_blood.zip"),
    Asset("ANIM", "anim/general/debuff_spark.zip"),
}

---------------------------------------------------------------------------------------------------------

--Slowdown

local function slowdown_attach(inst, target, followsymbol, followoffset, data)
    if target.components and target.components.locomotor then
        local speedmultiplier = data and data.speedmultiplier or TUNING.musha.debuffslowdownmult
        target.components.locomotor:SetExternalSpeedMultiplier(inst, inst.GUID, speedmultiplier) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier) set source as self to avoid duplicate effect
        CustomAttachFx(target, "splash")
    else
        inst.components.debuff:Stop()
    end
end

local function slowdown_extend(inst, target, followsymbol, followoffset, data)
    CustomAttachFx(target, "splash")
end

local function slowdown_detach(inst, target)
    if target.components and target.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(inst, inst.GUID)
    end

    inst.AnimState:PushAnimation("level2_pst", false)
    inst:ListenForEvent("animqueueover", function()
        inst:Remove()
    end)
end

---------------------------------------------------------------------------------------------------------

-- Paralysis
local function ParalysisDamageReflection(inst, data)
    if data.target then
        inst.components.combat:GetAttacked(data.target, TUNING.musha.debuffparalysisdamage)
    else
        inst.components.health:DoDelta(-TUNING.musha.debuffparalysisdamage)
    end
end

local function paralysis_attach(inst, target, followsymbol, followoffset, data)
    if target.components and target.components.combat then
        -- Periodic get damage and prolong attack period
        inst.task_debuff_paralysis = inst:DoPeriodicTask(TUNING.musha.debuffparalysisperiod, function()
            local damagesource = target.components.combat.target or target.components.combat.lastattacker or nil
            if damagesource then
                target.components.combat:GetAttacked(damagesource, TUNING.musha.debuffparalysisdamage)
            else
                target.components.health:DoDelta(-TUNING.musha.debuffparalysisdamage)
            end

            if target.components.combat.min_attack_period > 0 and not target._min_attack_period then -- This effect can only be set once
                target._min_attack_period = target.components.combat.min_attack_period
                target.components.combat:SetAttackPeriod(math.max((target._min_attack_period *
                    TUNING.musha.debuffparalysisattackperiodmult), TUNING.musha.debuffparalysisattackperiodmax))
            end
        end)

        -- Get damage when attack
        -- ? How to handle multiple paralysis debuff? -- Currently will reset when trigger paralysis_extend()
        target:ListenForEvent("onattackother", ParalysisDamageReflection)

        CustomAttachFx(target, "electrichitsparks")
    else
        inst.components.debuff:Stop()
    end
end

local function paralysis_extend(inst, target, followsymbol, followoffset, data)
    target:RemoveEventCallback("onattackother", ParalysisDamageReflection)
    target:ListenForEvent("onattackother", ParalysisDamageReflection)
    CustomAttachFx(target, "electrichitsparks")
end

local function paralysis_detach(inst, target)
    if target.components and target.components.combat then
        if target._min_attack_period then
            target.components.combat:SetAttackPeriod(target._min_attack_period)
            target._min_attack_period = nil
        end
        CustomCancelTask(inst.task_debuff_paralysis)
        target:RemoveEventCallback("onattackother", ParalysisDamageReflection)
    end

    inst.AnimState:PushAnimation("level2_pst", false)
    inst:ListenForEvent("animqueueover", function()
        inst:Remove()
    end)
end

---------------------------------------------------------------------------------------------------------

local function OnTimerDone(inst, data)
    if data.name == "buffover" then
        inst.components.debuff:Stop()
    end
end

local function SetDuration(inst, duration)
    if duration and duration > 0 then
        inst.components.timer:SetTimeLeft("buffover", duration)
    else
        inst.components.timer:SetTimeLeft("buffover", 0)
    end
end

---------------------------------------------------------------------------------------------------------

local function MakeBuff(name, onattachedfn, onextendedfn, ondetachedfn, defaultduration)
    local function OnAttached(inst, target, followsymbol, followoffset, data)
        inst.entity:SetParent(target.entity)
        local radius = target:GetPhysicsRadius(0) + 1
        inst.Transform:SetScale(radius * 0.7, radius * 0.6, radius * 0.7)
        inst.Transform:SetPosition(0, 0, 0)
        inst:ListenForEvent("death", function()
            inst.components.debuff:Stop()
        end, target)

        if data and data.duration then
            inst:SetDuration(data.duration)
        end

        if onattachedfn ~= nil then
            onattachedfn(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onattachedfn(self.inst, target, followsymbol, followoffset, data)
        end
    end

    local function OnExtended(inst, target, followsymbol, followoffset, data)
        if data and data.duration then
            inst:SetDuration(data.duration)
        else
            inst:SetDuration(defaultduration)
        end

        if onextendedfn ~= nil then
            onextendedfn(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onextendedfn(self.inst, self.target, followsymbol, followoffset, data)
        end
    end

    local function OnDetached(inst, target)
        if ondetachedfn ~= nil then
            ondetachedfn(inst, target) -- Note: components.debuff.ondetachedfn(self.inst, target)
        end
    end

    local function fn()
        local inst = CreateEntity()

        inst:AddTag("FX")
        inst:AddTag("NOCLICK")

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst.AnimState:SetBank("poison")
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("level2_pre")
        inst.AnimState:PushAnimation("level2_loop", true) -- Let this loop until detach
        inst.AnimState:SetFinalOffset(2)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        inst:AddComponent("debuff")
        inst.components.debuff:SetAttachedFn(OnAttached)
        inst.components.debuff:SetDetachedFn(OnDetached)
        inst.components.debuff:SetExtendedFn(OnExtended)

        inst:AddComponent("timer")
        inst.components.timer:StartTimer("buffover", defaultduration)
        inst:ListenForEvent("timerdone", OnTimerDone)

        inst.SetDuration = SetDuration

        return inst
    end

    return Prefab(name, fn, { Asset("ANIM", "anim/general/" .. name .. ".zip") })
end

return MakeBuff("debuff_slowdown", slowdown_attach, slowdown_extend, slowdown_detach,
    TUNING.musha.debuffslowdownduration),
    MakeBuff("debuff_paralysis", paralysis_attach, paralysis_extend, paralysis_detach,
        TUNING.musha.debuffparalysisduration)
-- MakeBuff("debuff_poison"),
-- MakeBuff("debuff_blood"),
-- MakeBuff("debuff_spark")
