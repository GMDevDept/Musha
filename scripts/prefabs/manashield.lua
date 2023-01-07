local assets =
{
    Asset("ANIM", "anim/general/manashield.zip"),
}

---------------------------------------------------------------------------------------------------------

-- Debuff component

local function OnAttached(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onattachedfn(self.inst, target, followsymbol, followoffset, data)

end

local function OnExtended(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onextendedfn(self.inst, self.target, followsymbol, followoffset, data)

end

local function OnDetached(inst, target) -- Note: components.debuff.ondetachedfn(self.inst, target)

end

local function OnBuffOverTimerDone(inst, data)
    if data.name == "buffover" then
        inst.components.debuff:Stop()
    end
end

local function SetDuration(inst, duration)
    if duration and duration > 0 then
        inst.components.timer:StartTimer("buffover", duration)
        inst:ListenForEvent("timerdone", OnBuffOverTimerDone)
    elseif inst.components.timer:TimerExists("buffover") then
        inst.components.timer:SetTimeLeft("buffover", 0)
    end
end

---------------------------------------------------------------------------------------------------------

local MAX_LIGHT_FRAME = 6

local function OnUpdateLight(inst, dframes)
    local done
    if inst._islighton:value() then
        local frame = inst._lightframe:value() + dframes
        done = frame >= MAX_LIGHT_FRAME
        inst._lightframe:set(done and MAX_LIGHT_FRAME or frame)
    else
        local frame = inst._lightframe:value() - dframes
        done = frame <= 0
        inst._lightframe:set(done and 0 or frame)
    end

    inst.Light:SetRadius(3 * inst._lightframe:value() / MAX_LIGHT_FRAME)

    if inst.previouslightframe == 0 and inst._lightframe:value() > 0 then
        inst.Light:Enable(true)
    elseif inst.previouslightframe > 0 and inst._lightframe:value() == 0 then
        inst.Light:Enable(false)
    end
    inst.previouslightframe = inst._lightframe:value()

    if done then
        inst._lighttask:Cancel()
        inst._lighttask = nil

        if TheWorld.ismastersim and inst._islighton:value() then
            if not inst.components.timer:TimerExists("fireout") then
                inst.components.timer:StartTimer("fireout", TUNING.musha.skills.manashield.lighttime) -- Cancel light effect
            else
                inst.components.timer:SetTimeLeft("fireout", TUNING.musha.skills.manashield.lighttime)
            end
        end
    end
end

local function OnLightDirty(inst)
    if inst._lighttask == nil then
        inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
    end
end

local function OnAttacked(inst)
    inst._islighton:set(true)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle_loop")
    inst.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
    inst.components.timer:SetTimeLeft("fireout", TUNING.musha.skills.manashield.lighttime)
end

local function OnTimerDone(inst, data)
    if data.name == "fireout" then
        inst._islighton:set(false)
    end
end

local function kill_fx(inst)
    inst.AnimState:PlayAnimation("close")
    inst._islighton:set(false)
    inst:DoTaskInTime(.6, inst.Remove)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("forcefield")
    inst.AnimState:SetBuild("manashield")
    inst.AnimState:PlayAnimation("open")
    inst.AnimState:PushAnimation("idle_loop", true)
    inst.AnimState:SetSortOrder(2)

    inst.SoundEmitter:PlaySound("dontstarve/wilson/forcefield_LP", "loop")

    inst.Light:SetRadius(0)
    inst.Light:SetIntensity(.9)
    inst.Light:SetFalloff(.9)
    inst.Light:SetColour(1, 1, 1)
    inst.Light:EnableClientModulation(true)

    inst._lightframe = net_tinybyte(inst.GUID, "forcefieldfx._lightframe", "lightdirty")
    inst._islighton = net_bool(inst.GUID, "forcefieldfx._islighton", "lightdirty")
    inst._lighttask = nil
    inst._islighton:set(true)
    inst.previouslightframe = 0

    inst:ListenForEvent("lightdirty", OnLightDirty)

    OnLightDirty(inst)

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
    inst:ListenForEvent("timerdone", OnTimerDone)

    inst.SetDuration = SetDuration
    inst.kill_fx = kill_fx

    inst:ListenForEvent("manashieldonattacked", OnAttacked)

    return inst
end

return Prefab("manashield", fn, assets)
