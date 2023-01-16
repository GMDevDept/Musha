local assets =
{
    Asset("ANIM", "anim/sporebomb.zip"),
}

local prefabs =
{
    "sporecloud_musha",
}

local FADE_FRAMES = 5
local FADE_INTENSITY = .8
local FADE_RADIUS = 1
local FADE_FALLOFF = .5

local function OnUpdateFade(inst)
    local k
    if inst._fade:value() <= FADE_FRAMES then
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES))
        k = inst._fade:value() / FADE_FRAMES
    else
        inst._fade:set_local(math.min(inst._fade:value() + 1, FADE_FRAMES * 2 + 1))
        k = (FADE_FRAMES * 2 + 1 - inst._fade:value()) / FADE_FRAMES
    end

    inst._light.Light:SetIntensity(FADE_INTENSITY * k)
    inst._light.Light:SetRadius(FADE_RADIUS * k)
    inst._light.Light:SetFalloff(1 - (1 - FADE_FALLOFF) * k)
    inst._light.Light:Enable(inst._fade:value() > 0 and inst._fade:value() <= FADE_FRAMES * 2)

    if inst._fade:value() == FADE_FRAMES or inst._fade:value() > FADE_FRAMES * 2 then
        inst._fadetask:Cancel()
        inst._fadetask = nil
    end
end

local function OnFadeDirty(inst)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
    OnUpdateFade(inst)
end

local function AlignToTarget(inst, target)
    inst.Transform:SetRotation(target.Transform:GetRotation())
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst._light.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, target.components.rider and target.components.rider:IsRiding() and 6 or 4, 0)
    if inst._followtask ~= nil then
        inst._followtask:Cancel()
    end
    inst._followtask = inst:DoPeriodicTask(0, AlignToTarget, nil, target)
    AlignToTarget(inst, target)
end

local function OnDetached(inst)
    inst:Remove()
end

local function OnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local must_tags = { "_combat" }
    local ignore_tags = { "player", "companion", "musha_companion", "wall" }
    local range = TUNING.musha.skills.launchelement.poisonspore.radius
    local damage = TUNING.musha.skills.launchelement.poisonspore.damage

    CustomDoAOE(inst, range, must_tags, ignore_tags, nil, function(v)
        v.components.combat:GetAttacked(inst.owner, damage)
    end)

    local cloud = SpawnPrefab("sporecloud_musha")
    cloud.owner = inst.owner
    cloud.Transform:SetPosition(x, 0, z)
    cloud:FadeInImmediately()
    cloud.SoundEmitter:PlaySound("dontstarve/common/together/infection_burst")

    ShakeAllCameras(CAMERASHAKE.FULL, .2, .02, .5, inst, 40)

    if inst.bounce and inst.bounce > 0 then
        local maxdist = TUNING.musha.skills.launchelement.poisonspore.charged.maxbouncedist
        local mindist = TUNING.musha.skills.launchelement.poisonspore.charged.minbouncedist
        local map = TheWorld.Map
        local offset

        local target = FindEntity(inst, maxdist, nil, must_tags,
            { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player", "companion",
                "musha_companion", "wall" })

        if target ~= nil then
            local tx, ty, tz = target.Transform:GetWorldPosition()

            offset = FindValidPositionByFan(
                math.random() * 2 * PI,
                math.random() * range,
                20,
                function(offset)
                    local x1 = tx + offset.x
                    local z1 = tz + offset.z
                    return not map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                        and #TheSim:FindEntities(x1, 0, z1, mindist, { "sporecloud" }, nil, nil) == 0
                end
            )

            if offset ~= nil then
                offset.x = offset.x + tx - x
                offset.z = offset.z + tz - z
            end
        end

        if target == nil or (target ~= nil and offset == nil) then
            offset = FindValidPositionByFan(
                math.random() * 2 * PI,
                (1 + math.random()) * range, -- range is doubled for jumping out from the last cloud
                10,
                function(offset)
                    local x1 = x + offset.x
                    local z1 = z + offset.z
                    return not map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                        and #TheSim:FindEntities(x1, 0, z1, mindist, { "sporecloud" }, nil, nil) == 0
                end
            )
        end

        if offset ~= nil then
            local postprefab = SpawnPrefab("sporebomb_musha")
            postprefab.owner = inst.owner
            postprefab.bounce = inst.bounce - 1
            postprefab.Transform:SetPosition(x, y, z)
            postprefab.charged:push()
            postprefab.components.complexprojectile:SetHorizontalSpeed(12)
            postprefab.components.complexprojectile:SetGravity(-12)
            postprefab.components.complexprojectile:Launch(Vector3(x + offset.x, 0, z + offset.z), inst.owner)
        end
    end
end

local function OnTimerDone(inst, data)
    if data.name == "explode" then
        OnExplode(inst)
        inst.components.debuff:Stop()
        inst:Remove()
    end
end

local function OnHit(inst, attacker, target)
    OnExplode(inst)
    inst.components.debuff:Stop()
    inst:Remove()
end

local function OnThrown(inst)
    inst.Physics:SetMass(1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(0)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.ITEMS)
    inst.Physics:SetCapsule(.2, .2)
end

local function CreateLight()
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddLight()

    inst.Light:SetFalloff(FADE_FALLOFF)
    inst.Light:SetIntensity(FADE_INTENSITY)
    inst.Light:SetRadius(FADE_RADIUS)
    inst.Light:SetColour(125 / 255, 200 / 255, 50 / 255)
    inst.Light:Enable(false)

    return inst
end

local function OnEntityReplicated(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        inst._light.entity:SetParent(parent.entity)
    end
end

local function OnRemoveEntity(inst)
    if inst._light:IsValid() then
        inst._light:Remove()
    end
end

local function PushFumeFX(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        parent:PushEvent("startfumedebuff", inst)
    end
end

local function OnCharged(inst)
    inst.AnimState:SetMultColour(1, 1, 1, 1)

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)

    inst:DoTaskInTime(0, PushFumeFX)

    if not TheWorld.ismastersim then
        return
    end

    inst.ischarged = true

    inst.SoundEmitter:PlaySound("dontstarve/wilson/use_gemstaff")
    inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop_fail")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("projectile")

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sporebomb")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:PushAnimation("sporebomb_loop")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:SetMultColour(.8, .8, .8, .7)

    inst._light = CreateLight()
    inst._light.entity:SetParent(inst.entity)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")
    inst.charged = net_event(inst.GUID, "charged")

    inst.OnRemoveEntity = OnRemoveEntity

    inst:ListenForEvent("charged", OnCharged)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("fadedirty", OnFadeDirty)

        inst.OnEntityReplicated = OnEntityReplicated

        return inst
    end

    inst.persists = false

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetHorizontalSpeed(10)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(OnThrown)
    inst.components.complexprojectile:SetOnHit(OnHit)

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("explode", TUNING.musha.skills.launchelement.maxdelay)
    inst:ListenForEvent("timerdone", OnTimerDone)

    -- inst.ischarged = nil
    -- inst.owner = nil -- Assigned when projectile is launched
    -- inst.bounce = 0 -- Assigned when projectile is launched

    return inst
end

return Prefab("sporebomb_musha", fn, assets, prefabs)
