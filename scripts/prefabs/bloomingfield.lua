local prefabs =
{
    "lavaarena_bloom1", "lavaarena_bloom2", "lavaarena_bloom3",
    "lavaarena_bloom4", "lavaarena_bloom5", "lavaarena_bloom6",
    "wormwood_plant_fx", "reticuleaoe_thin_musha"
}

local function spawnbloom(inst)
    local counter = 1
    local x, y, z = inst.Transform:GetWorldPosition()
    inst:CustomDoPeriodicTask(TUNING.musha.skills.launchelement.bloomingfield.charged.radius * FRAMES, FRAMES,
        function()
            for i = 1, counter do
                local offset = FindValidPositionByFan( -- Note: FindValidPositionByFan(angle, radius, attempts, testfn)
                    math.random() * 2 * PI,
                    counter,
                    TUNING.musha.skills.launchelement.bloomingfield.charged.radius,
                    function(offset)
                        local x1 = x + offset.x
                        local z1 = z + offset.z
                        return not TheWorld.Map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                            and #TheSim:FindEntities(x1, 0, z1, 1, nil, nil, { "FX" }) == 0
                    end
                )

                if offset ~= nil then
                    local postprefab = SpawnPrefab("wormwood_plant_fx")
                    postprefab.Transform:SetPosition(x + offset.x, 0, z + offset.z)
                    postprefab:SetVariation(math.random(1, 4))
                end
            end
            counter = counter + 1
        end)

    local scale = math.sqrt(TUNING.musha.skills.launchelement.bloomingfield.charged.radius / 6)
    inst.reticule = SpawnPrefab("reticuleaoe_thin_musha")
    inst.reticule.Transform:SetPosition(x, y, z)
    inst.reticule.AnimState:OverrideMultColour(.3, .5, .2, 1)
    inst.reticule.Transform:SetScale(scale, scale, scale)
end

local function dobloomfz(inst)
    if inst.bloomtask then
        inst.bloomtask:Cancel()
        inst.bloomtask = nil
    end
    local time = 0.1
    inst.bloomtask = inst:DoTaskInTime(time, function() inst.bloomfx(inst) end)
end

local function bloomfx(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local offset = FindValidPositionByFan( -- Note: FindValidPositionByFan(angle, radius, attempts, testfn)
        math.random() * 2 * PI,
        math.random(1, TUNING.musha.skills.launchelement.bloomingfield.charged.radius),
        8,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return not TheWorld.Map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                and #TheSim:FindEntities(x1, 0, z1, 3, nil, nil, { "FX" }) == 0
        end)

    if offset ~= nil then
        local fx = SpawnPrefab("lavaarena_bloom" .. math.random(1, 6))
        fx.Transform:SetPosition(x + offset.x, 0, z + offset.z)
        fx:ListenForEvent("animqueueover", function()
            ErodeAway(fx)
        end)
    end

    dobloomfz(inst)
end

local function SpawnHealFx(inst, fx_prefab, scale)
    local x, y, z = inst.Transform:GetWorldPosition()
    local fx = SpawnPrefab(fx_prefab)
    fx.Transform:SetNoFaced()
    fx.Transform:SetPosition(x, y, z)

    scale = scale or 1
    fx.Transform:SetScale(scale, scale, scale)
end

local ONE_OF_TAGS = { "player", "companion", "musha_companion", "sleeper" }
local FRIEND_TAGS = { "player", "companion", "musha_companion" }

local function ontick(inst)
    local interval = TUNING.musha.skills.launchelement.bloomingfield.charged.tickperiod
    local radius = TUNING.musha.skills.launchelement.bloomingfield.charged.radius
    CustomDoAOE(inst, radius, nil, nil, ONE_OF_TAGS, function(v)
        if v:HasOneOfTags(FRIEND_TAGS) then
            if v.components.health ~= nil and not v.components.health:IsDead() then
                local heal_amount = v:HasTag("player") and
                    TUNING.musha.skills.launchelement.bloomingfield.charged.playerhealthregen or
                    TUNING.musha.skills.launchelement.bloomingfield.charged.nonplayerhealthregen

                v.components.health:DoDelta(heal_amount, false, inst.owner)
                CustomAttachFx(v, "spider_heal_target_fx")
            end

            if v.components.stamina ~= nil then
                v.components.stamina:DoDelta(TUNING.musha.skills.launchelement.bloomingfield.charged.staminaregen)
            end

            if v.components.locomotor ~= nil then
                v.components.locomotor:SetExternalSpeedMultiplier(inst, "chargedbloomingfield",
                    TUNING.musha.skills.launchelement.bloomingfield.charged.speedmultiplier)

                v:DoTaskInTime(interval - FRAMES, function()
                    v.components.locomotor:RemoveExternalSpeedMultiplier(inst, "chargedbloomingfield")
                end)
            end
        elseif v:HasTag("sleeper") and not v.components.sleeper:IsAsleep() then
            if math.random() < TUNING.musha.skills.launchelement.bloomingfield.charged.enemysleepprob then
                v.components.sleeper:GoToSleep(TUNING.musha.skills.launchelement.bloomingfield.charged.sleeptime)
                CustomAttachFx(v, "fx_book_sleep")
            end
        end
    end)

    local scale = 2
    SpawnHealFx(inst, "spider_heal_ground_fx", scale)
    SpawnHealFx(inst, "spider_heal_fx", scale)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")

    inst.nextticktask = inst:DoTaskInTime(interval, function() inst.ontick(inst) end)
end

local function endbloom(inst)
    if inst.bloomtask then
        inst.bloomtask:Cancel()
        inst.bloomtask = nil
    end

    if inst.nextticktask then
        inst.nextticktask:Cancel()
        inst.nextticktask = nil
    end

    CustomRemoveEntity(inst.reticule)
    inst:DoTaskInTime(1, function() inst:Remove() end)
end

local function bloomfn()
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

    -- inst.owner = nil -- Set at ChargedBlossomOnExplode

    inst.persists = false

    inst.spawnbloom = spawnbloom
    inst.bloomfx = bloomfx
    inst.ontick = ontick
    inst:DoTaskInTime(0, function()
        spawnbloom(inst)
        dobloomfz(inst)
        ontick(inst)
    end)

    inst:DoTaskInTime(TUNING.musha.skills.launchelement.bloomingfield.charged.duration, function()
        endbloom(inst)
    end)

    return inst
end

return Prefab("bloomingfield", bloomfn, nil, prefabs)
