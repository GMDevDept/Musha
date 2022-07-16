-- Freeze
local function StartFreezeCooldown(inst)
    inst:AddDebuff("postfreezeslowdown", "debuff_slowdown")
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
