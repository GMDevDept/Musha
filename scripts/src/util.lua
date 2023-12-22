-- Remove entity
GLOBAL.CustomRemoveEntity = function(entity, delay)
    if delay then
        TheWorld:DoTaskInTime(delay, function()
            if entity then
                entity:Remove()
            end
        end)
    else
        if entity then
            entity:Remove()
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
            end
        end)
    else
        if task then
            task:Cancel()
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Freeze
local function StartFreezeCooldown(inst)
    if inst.components and inst.components.locomotor then
        inst:AddDebuff("postfreezeslowdown", "debuff_slowdown", { duration = TUNING.musha.freezecooldowntime }) -- Add slowdown debuff upon unfreeze
    end
    inst:DoTaskInTime(TUNING.musha.freezecooldowntime, function()
        inst:RemoveTag("freeze_cooldown")
    end)
    inst:RemoveEventCallback("unfreeze", StartFreezeCooldown)
end

GLOBAL.CustomOnFreeze = function(inst)
    if not inst:HasTag("freeze_cooldown") then
        inst:AddTag("freeze_cooldown")
        inst:ListenForEvent("unfreeze", StartFreezeCooldown)
    end
end

---------------------------------------------------------------------------------------------------------

-- Attach fx to inst
local function SpawnFx(target, fx_name, data, scale, offset)
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
    local dur = data and data.duration or 3

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
        end)
    end

    return fx
end

GLOBAL.CustomAttachFx = function(target, fx_list, data, scale, offset) -- Set data.duration = 0 to make it permanent, scale/offset: Vector3
    if target:HasTag("nofx") then
        return
    end

    if type(fx_list) == "string" then
        return SpawnFx(target, fx_list, data, scale, offset)
    elseif type(fx_list) == "table" then
        for _, fx_name in pairs(fx_list) do
            SpawnFx(target, fx_name, data, scale, offset)
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Area of effect
GLOBAL.CustomDoAOE = function(center, radius, must_tags, additional_ignore_tags, one_of_tags, fn)
    local x, y, z = center.Transform:GetWorldPosition()
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost" }

    if additional_ignore_tags then
        for _, v in ipairs(additional_ignore_tags) do
            table.insert(ignore_tags, v)
        end
    end

    local targets = TheSim:FindEntities(x, y, z, radius, must_tags, ignore_tags, one_of_tags) -- Note: FindEntities(x, y, z, range, must_tags, ignore_tags, one_of_tags), including center entity itself

    if targets then
        for _, target in pairs(targets) do
            fn(target)
        end
    end
end

---------------------------------------------------------------------------------------------------------

-- Play skill failed anim
GLOBAL.CustomPlayFailedAnim = function(inst)
    if inst.components.health:IsDead() or inst:HasTag("playerghost") or inst.sg:HasStateTag("musha_nointerrupt")
        or inst.sg:HasStateTag("busy") then
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

---------------------------------------------------------------------------------------------------------

-- Reset mana, stamina, fatigue and cooldowns on c_supergodmode
local Timers = require("src/timers")
GLOBAL.c_mushagodmode = function(player)
    if TheWorld ~= nil and not TheWorld.ismastersim then
        c_remote("c_mushagodmode()")
        return
    end

    player = ConsoleCommandPlayer()
    if player ~= nil and not player:HasTag("playerghost") then
        if player.components.mana then
            player.components.mana:SetPercent(1)
        end
        if player.components.stamina then
            player.components.stamina:SetPercent(1)
        end
        if player.components.fatigue then
            player.components.fatigue:SetPercent(0)
        end
        if player.components.melody then
            player.components.melody:SetPercent(1)
        end
        if player:HasTag("musha") then
            for _, name in pairs(Timers) do
                player.components.timer:SetTimeLeft(name, 0)
            end
        end
    end

    return c_supergodmode(player)
end

---------------------------------------------------------------------------------------------------------
