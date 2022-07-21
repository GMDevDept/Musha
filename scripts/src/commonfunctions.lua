-- Freeze
local function StartFreezeCooldown(inst)
    inst:AddDebuff("postfreezeslowdown", "debuff_slowdown") -- Add slowdown debuff upon unfreeze
    inst.components.debuffable:GetDebuff("postfreezeslowdown"):SetDuration(TUNING.musha.freezecooldowntime)
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

-- Attach fx to inst
local function SpawnFx(target, fx_name, duration, offset)
    local x, y, z
    if offset then
        x, y, z = offset.x, offset.y, offset.z
    else
        x, y, z = 0, 0, 0
    end

    local fx = SpawnPrefab(fx_name)
    local dur = duration or 1

    fx.entity:SetParent(target.entity)
    fx.Transform:SetPosition(x, y, z)

    if dur ~= 0 then
        target:DoTaskInTime(dur, function()
            fx:Remove()
            fx = nil
        end)
    end
end

GLOBAL.CustomAttachFx = function(target, fx_list, duration, offset) -- Set duration = 0 to make it permanent
    if type(fx_list) == "string" then
        SpawnFx(target, fx_list, duration, offset)
    elseif type(fx_list) == "table" then
        for i, fx_name in pairs(fx_list) do
            SpawnFx(target, fx_name, duration, offset)
        end
    end
end

---------------------------------------------------------------------------------------------------------