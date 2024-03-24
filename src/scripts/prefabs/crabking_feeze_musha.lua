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
                local offset = FindValidPositionByFan( -- Note: FindValidPositionByFan(angle, radius, attempts, testfn)
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

    local scale = math.sqrt(TUNING.musha.skills.launchelement.whitefrost.charged.range / 6)
    inst.reticule = SpawnPrefab("reticuleaoe_thin_musha")
    inst.reticule.Transform:SetPosition(x, y, z)
    inst.reticule.AnimState:OverrideMultColour(.3, .3, 1, 1)
    inst.reticule.Transform:SetScale(scale, scale, scale)
end

local function dofreezefz(inst)
    if inst.freezetask then
        inst.freezetask:Cancel()
        inst.freezetask = nil
    end
    local time = 0.1
    inst.freezetask = inst:DoTaskInTime(time, function() inst:freezefx() end)
end

local function freezefx(inst)
    local function spawnfx()
        local MAXRADIUS = TUNING.musha.skills.launchelement.whitefrost.charged.range
        local x, y, z = inst.Transform:GetWorldPosition()
        local theta = math.random() * 2 * PI
        local radius = 1 + math.pow(math.random(), 0.8) * MAXRADIUS
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

local FREEZE_CANT_TAGS = { "playerghost", "FX", "NOCLICK", "DECOR", "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead" }
local FREEZE_ONEOF_TAGS = { "locomotor", "freezable", "fire", "smolder" }
local NO_DAMAGE_TAGS = { "player", "companion", "musha_companion", "wall" }

local function dofreeze(inst)
    local interval = TUNING.musha.skills.launchelement.whitefrost.charged.tickperiod
    local pos = Vector3(inst.Transform:GetWorldPosition())
    local range = TUNING.musha.skills.launchelement.whitefrost.charged.range
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, range, nil, FREEZE_CANT_TAGS, FREEZE_ONEOF_TAGS)
    for i, target in pairs(ents) do
        if target.components.temperature then
            local rate = TUNING.musha.skills.launchelement.whitefrost.charged.temperaturedecrease /
                (TUNING.musha.skills.launchelement.whitefrost.charged.casttime / interval)

            if target.components.moisture then
                rate = rate * Remap(target.components.moisture:GetMoisture(), 0, target.components.moisture.maxmoisture, 1, 3)
            end

            local mintemp = target.components.temperature.mintemp
            local curtemp = target.components.temperature:GetCurrent()
            if mintemp < curtemp then
                target.components.temperature:DoDelta(math.max(-rate, mintemp - curtemp))
            end
        end

        if target.components.burnable ~= nil then
            target.components.burnable:Extinguish(true, 0)
        end

        if target.components.health and target.components.combat and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
            if not (target.components.freezable and target.components.freezable:IsFrozen()) then
                target.components.combat:GetAttacked(inst.owner, TUNING.musha.skills.launchelement.whitefrost.charged.damageontick)
            end
        end

        if target.components.freezable ~= nil then
            target.components.freezable:AddColdness(TUNING.musha.skills.launchelement.whitefrost.charged.coldnessontick)
            if target.components.freezable:IsFrozen() and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
                CustomOnFreeze(target)
            end
        end

        if target.components.locomotor and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
            target:AddDebuff("chargedwhitefrost", "debuff_slowdown", {
                speedmult = TUNING.musha.skills.launchelement.whitefrost.charged.speedmultiplier,
                duration = interval,
            })
        end
    end

    inst.SoundEmitter:PlaySound("hookline_2/creatures/boss/crabking/ice_attack")
    inst.ticktask = inst:DoTaskInTime(interval, function() inst.dofreeze(inst) end)
end

local function iceblast(inst, target)
    if target.components.burnable ~= nil then
       target.components.burnable:Extinguish(true, 0)
    end

    local nofreeze

    if target.components.health and target.components.combat and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
        local basedamage = TUNING.musha.skills.launchelement.whitefrost.charged.finalbasedamage
            + inst.owner.components.leveler.lvl * TUNING.musha.skills.launchelement.whitefrost.charged.basedamagegrowth
        local percentdamage = TUNING.musha.skills.launchelement.whitefrost.charged.finalpercentdamage
            + inst.owner.components.leveler.lvl * TUNING.musha.skills.launchelement.whitefrost.charged.percentdamagegrowth
        local maxdamage = TUNING.musha.skills.launchelement.whitefrost.charged.finalmaxdamage
            + inst.owner.components.leveler.lvl * TUNING.musha.skills.launchelement.whitefrost.charged.maxdamagegrowth
        local finaldamage = math.min(maxdamage, basedamage + percentdamage * target.components.health.maxhealth)

        if target.components.freezable and target.components.freezable:IsFrozen() then
            finaldamage = finaldamage * TUNING.musha.skills.launchelement.whitefrost.charged.frozendamagemultiplier
            target.components.freezable:SpawnShatterFX()
            nofreeze = true
        end

        target.components.combat:GetAttacked(inst.owner, finaldamage)
    end

    if not nofreeze and target.components.freezable and not target:HasTag("freeze_cooldown") then
        target.components.freezable:Freeze(TUNING.musha.skills.launchelement.whitefrost.charged.frosttime)
        target.components.freezable:SpawnShatterFX()
        if target.components.freezable:IsFrozen() and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
            CustomOnFreeze(target)
        end
    elseif target.components.freezable == nil and target.components.locomotor and not target:HasOneOfTags(NO_DAMAGE_TAGS) then
        target:AddDebuff("chargedwhitefrost", "debuff_slowdown", {
            speedmult = TUNING.musha.skills.launchelement.whitefrost.charged.speedmultiplier,
            duration = TUNING.musha.skills.launchelement.whitefrost.charged.frosttime,
        })
    end
end

local function endfreeze(inst)
    if inst.freezetask then
        inst.freezetask:Cancel()
        inst.freezetask = nil
    end

    if inst.ticktask then
        inst.ticktask:Cancel()
        inst.ticktask = nil
    end

    local pos = Vector3(inst.Transform:GetWorldPosition())
    local range = TUNING.musha.skills.launchelement.whitefrost.charged.range
    local ents = TheSim:FindEntities(pos.x, pos.y, pos.z, range, nil, FREEZE_CANT_TAGS, FREEZE_ONEOF_TAGS)
    for i, v in pairs(ents) do
        iceblast(inst, v)
    end

    CustomRemoveEntity(inst.reticule)
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

    -- inst.owner = nil -- set on ChargedIceOnExplode
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
