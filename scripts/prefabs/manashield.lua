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

local function OnTimerDone(inst, data)
    if data.name == "fireout" then
        inst._islighton:set(false)
    elseif data.name == "buffover" and not inst.components.timer:TimerExists("shieldbrokendelay") then
        inst.components.debuff:Stop()
    elseif data.name == "shieldbrokendelay" then
        inst.components.debuff:Stop()
    end
end

local function kill_fx(inst)
    inst.AnimState:PlayAnimation("close")
    inst._islighton:set(false)
    inst:DoTaskInTime(.6, inst.Remove)
end

local function TargetOnAttacked(inst, data) -- inst = buff target
    local shield = inst.components.debuffable:GetDebuff("manashield")
    shield._islighton:set(true)
    shield.AnimState:PlayAnimation("hit")
    shield.AnimState:PushAnimation("idle_loop")
    shield.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
    shield.components.timer:SetTimeLeft("fireout", TUNING.musha.skills.manashield.lighttime)

    if shield.durability and shield.durability > 0 and data
        and not shield.components.timer:TimerExists("shieldbrokendelay") then -- data = nil when pushed by OnManaDepleted
        local delta = TUNING.musha.skills.manashield.durabilitydamage
        if data.damage and data.damage > 0 then
            delta = delta + data.damage * TUNING.musha.skills.manashield.durabilitydamagemultiplier
        end
        if data.stimuli and data.stimuli == "darkness" then
            delta = math.max(delta, shield.durability - 1)
        end
        shield.durability = shield.durability - delta
        if shield.durability <= 0 then
            if inst:HasTag("musha") then
                inst.components.talker:Say(STRINGS.musha.skills.manashield.broken)
            elseif inst.components.talker then
                inst.components.talker:Say(STRINGS.musha.skills.manashield.broken_other)
            end

            shield.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
            shield.components.timer:StartTimer("shieldbrokendelay", TUNING.musha.skills.manashield.brokendelay)
        end
    end
end

local function OnManaDepleted(inst) -- inst = buff target
    local shield = inst.components.debuffable:GetDebuff("manashield")
    if shield.components.timer:TimerExists("shieldbrokendelay") then return end

    shield.components.timer:StartTimer("shieldbrokendelay", TUNING.musha.skills.manashield.brokendelay)
    inst:PushEvent("manashieldonattacked")
    inst.components.talker:Say(STRINGS.musha.skills.manashield.broken_manadepleted)
end

local function ShieldOnTimerDone(inst, data) -- inst = buff target
    if data.name == "cooldown_manashield" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manashield.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ShieldOnTimerDone)
    end
end

---------------------------------------------------------------------------------------------------------

-- Debuff component

local function OnAttached(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onattachedfn(self.inst, target, followsymbol, followoffset, data)
    inst.entity:SetParent(target.entity)
    local radius = target:GetPhysicsRadius(0.5) -- Player: 0.5, beefalo also 0.5 (!?)
    inst.Transform:SetScale(1.8 * radius, 1.8 * radius, 1.8 * radius)
    inst.Transform:SetPosition(0, -0.2, 0)

    target:AddTag("manashieldactivated")
    target.components.health.externalabsorbmodifiers:SetModifier(target, TUNING.musha.skills.manashield.damageabsorbrate
        , "manashield")

    inst:ListenForEvent("manashieldonattacked", TargetOnAttacked, target)

    inst:ListenForEvent("mounted", function()
        inst.Transform:SetScale(2, 2, 2)
    end, target)

    inst:ListenForEvent("dismounted", function()
        inst.Transform:SetScale(0.9, 0.9, 0.9)
    end, target)

    inst:ListenForEvent("death", function() -- Triggered when target is killed (pushed from target entity)
        inst.components.debuff:Stop()
    end, target)

    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")

    if data and data.durability then
        inst.durability = data.durability
    end

    if data and data.duration then
        inst:SetDuration(data.duration)
    end

    if data and data.single then -- Musha cast to herself
        inst.single = true
        target.components.mana.modifiers:SetModifier(target, -TUNING.musha.skills.manashield.manaongoingcost,
            "manashield")
        inst:ListenForEvent("manadepleted", OnManaDepleted, target)
    end
end

local function OnExtended(inst, target, followsymbol, followoffset, data) -- Note: components.debuff.onextendedfn(self.inst, self.target, followsymbol, followoffset, data)
    inst.components.timer:StopTimer("shieldbrokendelay")

    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")

    if data and data.durability then
        inst.durability = data.durability
    else
        inst.durability = nil
    end

    if data and data.duration then
        inst:SetDuration(data.duration)
    else
        inst.components.timer:StopTimer("buffover")
    end

    if data and data.single then -- Therotically won't happen
        inst.single = true
        target.components.mana.modifiers:SetModifier(target, -TUNING.musha.skills.manashield.manaongoingcost,
            "manashield")
        inst:ListenForEvent("manadepleted", OnManaDepleted, target)
    else
        inst.single = nil
        if target.components.mana then
            target.components.mana.modifiers:RemoveModifier(target, "manashield")
            inst:RemoveEventCallback("manadepleted", OnManaDepleted, target)
        end
    end
end

local function OnDetached(inst, target) -- Note: components.debuff.ondetachedfn(self.inst, target)
    target:RemoveTag("manashieldactivated")
    target.components.health.externalabsorbmodifiers:RemoveModifier(target, "manashield")

    if inst.single then
        target.components.mana:DoDelta(-TUNING.musha.skills.manashield.manacost)
        target.components.mana.modifiers:RemoveModifier(target, "manashield")
        inst:RemoveEventCallback("manadepleted", OnManaDepleted, target)

        target.components.timer:StartTimer("cooldown_manashield", TUNING.musha.skills.manashield.cooldown)
        target:ListenForEvent("timerdone", ShieldOnTimerDone)
    end

    inst.SoundEmitter:PlaySound("moonstorm/common/moonstorm/glass_break")
    inst.SoundEmitter:PlaySound("turnoftides/common/together/moon_glass/mine")

    inst:kill_fx() -- Remove inst
end

local function SetDuration(inst, duration)
    if duration then
        duration = math.max(0, duration)
        if inst.components.timer:TimerExists("buffover") then
            inst.components.timer:SetTimeLeft("buffover", duration)
        elseif duration > 0 then
            inst.components.timer:StartTimer("buffover", duration)
        end
    end
end

---------------------------------------------------------------------------------------------------------

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
    -- inst.duration = 0 -- Added when AddDebuff
    -- inst.durability = 0 -- Added when AddDebuff
    -- inst.single = nil -- Added when AddDebuff

    return inst
end

return Prefab("manashield", fn, assets)
