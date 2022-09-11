local assets =
{
    Asset("ANIM", "anim/general/manashield.zip"),
}

local MAX_LIGHT_FRAME = 6

local function OnUpdateLight(inst, dframes)
    local done
    if inst._islighton:value() then
        local frame = inst._lightframe:value() + dframes
        done = frame >= MAX_LIGHT_FRAME
        inst._lightframe:set_local(done and MAX_LIGHT_FRAME or frame)
    else
        local frame = inst._lightframe:value() - dframes
        done = frame <= 0
        inst._lightframe:set_local(done and 0 or frame)
    end

    inst.Light:SetRadius(3 * inst._lightframe:value() / MAX_LIGHT_FRAME)

    if done then
        inst._lighttask:Cancel()
        inst._lighttask = nil
        if inst._islighton:value() then
            if not inst.components.timer:TimerExists("fireout") then
                inst.components.timer:StartTimer("fireout", 3) -- Cancel light effect after 3 seconds
            else
                inst.components.timer:SetTimeLeft("fireout", 3)
            end
        end
    end
end

local function OnLightDirty(inst)
    if inst._lighttask == nil then
        inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
    end
    OnUpdateLight(inst, 0)
end

local function OnAttacked(inst)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle_loop")
    inst.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
    if not inst._islighton:value() then -- Light again
        inst._islighton:set(true)
        inst._lightframe:set(inst._lightframe:value())
        inst:OnLightDirty()
    else
        if inst.components.timer:TimerExists("fireout") then
            inst.components.timer:SetTimeLeft("fireout", 3)
        end
        inst:OnLightDirty()
    end
end

local function OnTimerDone(inst, data)
    if data.name == "fireout" then
        inst._islighton:set(false)
        inst._lightframe:set(inst._lightframe:value())
        inst:OnLightDirty()
    end
end

local function kill_fx(inst)
    inst.AnimState:PlayAnimation("close")
    inst._islighton:set(false)
    inst._lightframe:set(inst._lightframe:value())
    OnLightDirty(inst)
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

    inst.SoundEmitter:PlaySound("dontstarve/wilson/forcefield_LP", "loop")

    inst.Light:SetRadius(0)
    inst.Light:SetIntensity(.9)
    inst.Light:SetFalloff(.9)
    inst.Light:SetColour(1, 1, 1)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    inst._lightframe = net_tinybyte(inst.GUID, "forcefieldfx._lightframe", "lightdirty")
    inst._islighton = net_bool(inst.GUID, "forcefieldfx._islighton", "lightdirty")
    inst._lighttask = nil
    inst._islighton:set(true)

    inst.OnLightDirty = OnLightDirty

    inst:AddComponent("timer")

    inst.entity:SetPristine()

    OnLightDirty(inst)

    inst:ListenForEvent("manashieldonattacked", OnAttacked)
    inst:ListenForEvent("timerdone", OnTimerDone)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("lightdirty", OnLightDirty)

        return inst
    end

    inst.persists = false

    inst.kill_fx = kill_fx

    return inst
end

return Prefab("manashield", fn, assets)
