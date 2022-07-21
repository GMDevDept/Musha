local assets =
{
    Asset("ANIM", "anim/general/debuff_slowdown.zip"),
    Asset("ANIM", "anim/general/debuff_poison.zip"),
    Asset("ANIM", "anim/general/debuff_blood.zip"),
    Asset("ANIM", "anim/general/debuff_spark.zip"),
}

local function slowdown_attach(inst, target)
    if target.components and target.components.locomotor then
        target.components.locomotor:SetExternalSpeedMultiplier(inst, inst.GUID, TUNING.musha.debuffslowdownmult) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier) set source as self to avoid duplicate effect
        SpawnPrefab("weaponsparks").Transform:SetPosition(target.Transform:GetWorldPosition())
    end
end

local function slowdown_extend(inst, target)
    SpawnPrefab("weaponsparks").Transform:SetPosition(target.Transform:GetWorldPosition())
end

local function slowdown_detach(inst, target)
    if target.components and target.components.locomotor then
        target.components.locomotor:RemoveExternalSpeedMultiplier(inst, inst.GUID)
    end
end

local function OnTimerDone(inst, data)
    if data.name == "buffover" then
        inst.components.debuff:Stop()
    end
end

local function SetDuration(inst, duration)
    if duration and duration > 0 then
        inst.components.timer:StopTimer("buffover")
        inst.components.timer:StartTimer("buffover", duration)
    else
        inst.components.timer:StopTimer("buffover")
    end
end

---------------------------------------------------------------------------------------------------------

local function MakeBuff(name, onattachedfn, onextendedfn, ondetachedfn, defaultduration)
    local function OnAttached(inst, target)
        inst.entity:SetParent(target.entity)
        local radius = target:GetPhysicsRadius(0) + 1
        inst.Transform:SetScale(radius * 0.7, radius * 0.6, radius * 0.7)
        inst.Transform:SetPosition(0, 0, 0)
        inst:ListenForEvent("death", function()
            inst.components.debuff:Stop()
        end, target)

        if onattachedfn ~= nil then
            onattachedfn(inst, target)
        end
    end

    local function OnExtended(inst, target)
        inst.components.timer:StopTimer("buffover")
        inst.components.timer:StartTimer("buffover", defaultduration)

        if onextendedfn ~= nil then
            onextendedfn(inst, target)
        end
    end

    local function OnDetached(inst, target)
        if ondetachedfn ~= nil then
            ondetachedfn(inst, target)
        end

        inst.AnimState:PushAnimation("level2_pst", false)
        inst:ListenForEvent("animqueueover", function()
            inst:Remove()
        end)
    end

    local function fn()
        local inst = CreateEntity()

        inst:AddTag("FX")
        inst:AddTag("NOCLICK")

        inst.persists = false

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

return MakeBuff("debuff_slowdown", slowdown_attach, slowdown_extend, slowdown_detach, TUNING.musha.debuffslowdownduration)
-- MakeBuff("debuff_poison"),
-- MakeBuff("debuff_blood"),
-- MakeBuff("debuff_spark")
