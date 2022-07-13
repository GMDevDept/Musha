-- Freeze
local function StartFreezeCooldown(inst)
    inst:DoTaskInTime(TUNING.musha.freezecooldowntime, function()
        inst:RemoveTag("freeze_cooldown")
        inst:RemoveEventCallback("unfreeze", StartFreezeCooldown)
    end)
end

GLOBAL.CustomOnFreeze = function(inst)
    inst:AddTag("freeze_cooldown")
    inst:ListenForEvent("unfreeze", StartFreezeCooldown)
end

---------------------------------------------------------------------------------------------------------

-- Slowdown
GLOBAL.CustomSlowDown = function(target, src, key, multiplier, time)
    if not target.components and target.components.locomotor then
        return
    end

    target.components.locomotor:SetExternalSpeedMultiplier(src, key, multiplier) -- Note: LocoMotor:SetExternalSpeedMultiplier(source, key, multiplier) set source as self to avoid duplicate effect

    local task = target["stopslowdowntask" .. key]
    if task then
        task:Cancel()
        task = nil
    end

    target["stopslowdowntask" .. key] = target:DoTaskInTime(time, function()
        target.components.locomotor:RemoveExternalSpeedMultiplier(src, key)
    end)
end
