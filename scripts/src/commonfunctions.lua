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
GLOBAL.CustomAttachFx = function(target, fx_list, offset --[[Vector3]] , duration)
    ---@diagnostic disable-next-line: unbalanced-assignments
    local x, y, z = offset or Vector3(0, 0, 0)
    if type(fx_list) == "string" then
        local fx = SpawnPrefab(fx_list)
        local dur = duration or 1

        fx.entity:SetParent(target.entity)
        fx.Transform:SetPosition(x, y, z)

        target:DoTaskInTime(dur, function()
            fx:Remove()
            fx = nil
        end)
    elseif type(fx_list) == "table" then
        for i, fx_name in pairs(fx_list) do
            local fx = SpawnPrefab(fx_name)
            local dur = duration or 1

            fx.entity:SetParent(target.entity)
            fx.Transform:SetPosition(x, y, z)

            target:DoTaskInTime(dur, function()
                fx:Remove()
                fx = nil
            end)
        end
    end
end
