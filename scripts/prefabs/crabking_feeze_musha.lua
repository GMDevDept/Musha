local freezeprefabs =
{
    "mushroomsprout_glow",
    "crab_king_icefx",
}

local function spawnicespike(inst)
    local counter = 1
    local x, y, z = inst.Transform:GetWorldPosition()
    inst:CustomDoPeriodicTask(1, 1 / TUNING.musha.skills.launchelement.whitefrost.charged.range,
        function()
            for i = 1, counter do
                local offset = FindValidPositionByFan(
                    math.random() * 2 * PI,
                    counter,
                    TUNING.musha.skills.launchelement.whitefrost.charged.range,
                    function(offset)
                        local x1 = x + offset.x
                        local z1 = z + offset.z
                        return not TheWorld.Map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                            and #TheSim:FindEntities(x1, 0, z1, 1, nil, nil, { "FX" }) == 0
                    end
                )

                if offset ~= nil then
                    local postprefab = SpawnPrefab("icespike_fx_" .. math.random(1, 4))
                    postprefab.Transform:SetPosition(x + offset.x, 0, z + offset.z)
                end
            end
            counter = counter + 1
        end)
end

local NO_DAMAGE_TAGS = { "player", "companion", "musha_companion", "wall" }

local function onfreeze(inst, target)
    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end

    if target.components.combat ~= nil and not target:HasOneOfTags(NO_DAMAGE_TAGS) and inst.owner and
        inst.owner:IsValid() then
        target.components.combat:SuggestTarget(inst.owner)
    end

    if target.components.freezable and target.components.freezable:IsFrozen() and target.components.combat and
        target.components.health and not target:HasOneOfTags(NO_DAMAGE_TAGS) and inst.owner and inst.owner:IsValid() then
        local basedamage = TUNING.musha.skills.launchelement.whitefrost.charged.basedamage
        local percentdamage = TUNING.musha.skills.launchelement.whitefrost.charged.percentdamage
        local maxdamage = TUNING.musha.skills.launchelement.whitefrost.charged.maxdamage
        target.components.combat:GetAttacked(inst.owner,
            math.min(maxdamage, basedamage + percentdamage * target.components.health.maxhealth))
    elseif target.components.freezable and not target.components.freezable:IsFrozen() then
        target.components.freezable:Freeze(TUNING.musha.skills.launchelement.whitefrost.charged.frosttime)
        target.components.freezable:SpawnShatterFX()
        if target.components.freezable:IsFrozen() and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
            CustomOnFreeze(target)
        end
    elseif not target.components.freezable and target.components.locomotor then
        target:AddDebuff("chargedwhitefrost", "debuff_slowdown", {
            speedmult = TUNING.musha.skills.launchelement.whitefrost.charged.speedmultiplier,
            duration = TUNING.musha.skills.launchelement.whitefrost.charged.frosttime,
        })
    end
end

local function dofreezefz(inst)
    if inst.freezetask then
        inst.freezetask:Cancel()
        inst.freezetask = nil
    end
    local time = 0.1
    inst.freezetask = inst:DoTaskInTime(time, function() inst.freezefx(inst) end)
end

local function freezefx(inst)
    local function spawnfx()
        local MAXRADIUS = TUNING.musha.skills.launchelement.whitefrost.charged.range
        local x, y, z = inst.Transform:GetWorldPosition()
        local theta = math.random() * 2 * PI
        local radius = 4 + math.pow(math.random(), 0.8) * MAXRADIUS
        local offset = Vector3(radius * math.cos(theta), 0, -radius * math.sin(theta))

        local prefab = "crab_king_icefx"
        local fx = SpawnPrefab(prefab)
        fx.Transform:SetPosition(x + offset.x, y + offset.y, z + offset.z)
    end

    local MAXFX = Remap(0, 0, 9, 5, 15)

    local fx = Remap(inst.components.age:GetAge(), 0, TUNING.CRABKING_CAST_TIME_FREEZE, 1, MAXFX)

    for i = 1, fx do
        if math.random() < 0.2 then
            spawnfx()
        end
    end

    dofreezefz(inst)
end

local FREEZE_CANT_TAGS = { "ghost", "playerghost", "FX", "NOCLICK", "DECOR", "INLIMBO" }

local function dofreeze(inst)
    local interval = TUNING.musha.skills.launchelement.whitefrost.charged.tickperiod
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local range = TUNING.musha.skills.launchelement.whitefrost.charged.range
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, range, nil, FREEZE_CANT_TAGS)
    for i, v in pairs(ents) do
        if v.components.temperature then
            local rate = TUNING.musha.skills.launchelement.whitefrost.charged.temperaturedecrease /
                (TUNING.musha.skills.launchelement.whitefrost.charged.casttime / interval)

            if v.components.moisture then
                rate = rate * Remap(v.components.moisture:GetMoisture(), 0, v.components.moisture.maxmoisture, 1, 3)
            end

            local mintemp = v.components.temperature.mintemp
            local curtemp = v.components.temperature:GetCurrent()
            if mintemp < curtemp then
                v.components.temperature:DoDelta(math.max(-rate, mintemp - curtemp))
            end
        end

        if v.components.burnable ~= nil then
            if v.components.burnable:IsBurning() then
                v.components.burnable:Extinguish()
            elseif v.components.burnable:IsSmoldering() then
                v.components.burnable:SmotherSmolder()
            end
        end

        if v.components.freezable ~= nil then
            v.components.freezable:AddColdness(TUNING.musha.skills.launchelement.whitefrost.charged.coldnessontick)
            v.components.freezable:SpawnShatterFX()
            if v.components.freezable:IsFrozen() and not v:HasOneOfTags(NO_DAMAGE_TAGS) then
                CustomOnFreeze(v)
            end
        end

        if v.components.locomotor then
            v:AddDebuff("chargedwhitefrost", "debuff_slowdown", {
                speedmult = TUNING.musha.skills.launchelement.whitefrost.charged.speedmultiplier,
                duration = interval,
            })
        end
    end

    inst.lowertemptask = inst:DoTaskInTime(interval, function() inst.dofreeze(inst) end)
end

local function endfreeze(inst)
    if inst.freezetask then
        inst.freezetask:Cancel()
        inst.freezetask = nil
    end

    if inst.lowertemptask then
        inst.lowertemptask:Cancel()
        inst.lowertemptask = nil
    end

    local pos = Vector3(inst.Transform:GetWorldPosition())
    local range = TUNING.musha.skills.launchelement.whitefrost.charged.range
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, range, nil, FREEZE_CANT_TAGS)
    for i, v in pairs(ents) do
        onfreeze(inst, v)
    end
    SpawnPrefab("crabking_ring_fx").Transform:SetPosition(pos.x, pos.y, pos.z)
    inst.SoundEmitter:PlaySound("dontstarve/common/break_iceblock")
    inst:DoTaskInTime(1, function() inst:Remove() end)
end

local function freezefn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("NOCLICK")
    inst:AddTag("fx")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("age")

    inst.spawnicespike = spawnicespike
    inst.freezefx = freezefx
    inst.dofreeze = dofreeze
    inst:DoTaskInTime(0, function()
        spawnicespike(inst)
        dofreezefz(inst)
        dofreeze(inst)
    end)

    inst.SoundEmitter:PlaySound("hookline_2/creatures/boss/crabking/ice_attack")

    inst:ListenForEvent("onremove", function()
        if inst.burbletask then
            inst.burbletask:Cancel()
            inst.burbletask = nil
        end
    end)

    inst:DoTaskInTime(TUNING.musha.skills.launchelement.whitefrost.charged.casttime +
        TUNING.musha.skills.launchelement.whitefrost.charged.tickperiod, function()
        endfreeze(inst)
    end)

    return inst
end

return Prefab("crabking_feeze_musha", freezefn, nil, freezeprefabs)
