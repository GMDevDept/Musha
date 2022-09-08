-- Remove entity
GLOBAL.CustomRemoveEntity = function(entity, delay)
    if delay then
        TheWorld:DoTaskInTime(delay, function()
            if entity then
                entity:Remove()
                entity = nil
            end
        end)
    else
        if entity then
            entity:Remove()
            entity = nil
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Stop scheduled task
GLOBAL.CustomCancelTask = function(task, delay, inst)
    if delay then
        local entity = inst or TheWorld
        entity:DoTaskInTime(delay, function()
            if task then
                task:Cancel()
                if inst then
                    inst:PushEvent("customtaskcancled", { task = task })
                end
                task = nil
            end
        end)
    else
        if task then
            task:Cancel()
            if inst then
                inst:PushEvent("customtaskcancled", { task = task })
            end
            task = nil
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Freeze
local function StartFreezeCooldown(inst)
    inst:AddDebuff("postfreezeslowdown", "debuff_slowdown") -- Add slowdown debuff upon unfreeze
    local debuff = inst.components.debuffable:GetDebuff("postfreezeslowdown") -- Nil if target doesn't have locomotor component, eg. tentacle
    if debuff then
        debuff:SetDuration(TUNING.musha.freezecooldowntime)
    end
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
local function SpawnFx(target, fx_name, duration, scale, offset)
    local a, b, c
    if scale then
        a, b, c = scale.x, scale.y, scale.z
    else
        a, b, c = 1, 1, 1
    end

    local x, y, z
    if offset then
        x, y, z = offset.x, offset.y, offset.z
    else
        x, y, z = 0, 0, 0
    end

    local fx = SpawnPrefab(fx_name)
    local dur = duration or 3

    fx.entity:SetParent(target.entity)
    fx.Transform:SetScale(a, b, c)
    fx.Transform:SetPosition(x, y, z)

    if fx_name == "mossling_spin_fx" then
        fx.AnimState:SetSortOrder(3)
    end

    if dur ~= 0 then
        target:DoTaskInTime(dur, function()
            if fx_name == "balloonparty_confetti_cloud" then
                fx.AnimState:PlayAnimation("confetti_pst")
            else
                fx:Remove()
            end
            fx = nil
        end)
    end

    return fx
end

GLOBAL.CustomAttachFx = function(target, fx_list, duration, scale, offset) -- Set duration = 0 to make it permanent, scale/offset: Vector3
    if target:HasTag("nofx") then
        return
    end

    if type(fx_list) == "string" then
        return SpawnFx(target, fx_list, duration, scale, offset)
    elseif type(fx_list) == "table" then
        for _, fx_name in pairs(fx_list) do
            SpawnFx(target, fx_name, duration, scale, offset)
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Area of effect
GLOBAL.CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)
    local x, y, z = center.Transform:GetWorldPosition()
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost" }

    for _, v in ipairs(additional_ignore_tags) do
        table.insert(ignore_tags, v)
    end

    local targets = TheSim:FindEntities(x, y, z, radius, must_tags, ignore_tags, one_of_tags) -- Note: FindEntities(x, y, z, range, must_tags, ignore_tags, one_of_tags), including inst itself

    if targets then
        for _, target in pairs(targets) do
            fn(target)
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Add modifier to SourceModifierList and set duration

-- Copied from scheduler.lua
local function task_finish(task, success, inst)
    task:fn() -- Execute fn on cancel
    --print ("TASK DONE", task, success, inst)
    if inst and inst.pendingtasks and inst.pendingtasks[task] then
        inst.pendingtasks[task] = nil
    else
        print("   NOT FOUND")
    end
end

-- Source can be an object or a name. If it is an object, then it will handle removing the multiplier if the object is forcefully removed from the game.
-- Key is optional if you are only going to have one multiplier from a source.
GLOBAL.CustomSetModifier = function(SourceModifierList, source, m, key, duration)
    SourceModifierList:SetModifier(source, m, key)
    if duration then
        local task = TheWorld:DoTaskInTime(duration, function()
            SourceModifierList:RemoveModifier(source, key)
        end)
        task.onfinish = task_finish
        return task
    end
end

---------------------------------------------------------------------------------------------------------

-- Play skill failed anim
GLOBAL.CustomPlayFailedAnim = function(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("ghostbuild") or
        inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("busy") then
        return
    end

    if inst.components.rider:IsRiding() then
        inst.sg:GoToState("repelled")
    else
        inst.sg:GoToState("mindcontrolled_pst")
    end
end

---------------------------------------------------------------------------------------------------------

-- Find key by value
GLOBAL.CustomFindKeyByValue = function(table, value)
    for k, v in pairs(table) do
        if v == value then
            return k
        end
    end
end
