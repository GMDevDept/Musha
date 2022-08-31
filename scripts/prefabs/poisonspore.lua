local assets =
{
    Asset("ANIM", "anim/sporebomb.zip"),
}

local prefabs =
{
    "sporecloud",
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
    inst.Transform:SetPosition(0, 4, 0)
    inst._light.entity:SetParent(target.entity)
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

    local cloud = SpawnPrefab("sporecloud")
    cloud.Transform:SetPosition(x, 0, z)
    cloud:FadeInImmediately()
    cloud.SoundEmitter:PlaySound("dontstarve/common/together/infection_burst")
end

local function OnTimerDone(inst, data)
    if data.name == "explode" then
        inst.components.debuff:Stop()
        OnExplode(inst)
    end
end

local function OnHit(inst, attacker, target)
    inst:Remove()
    OnExplode(inst)
end

local function OnThrown(inst)
    inst.persists = false
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

local function OnInit(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        parent:PushEvent("startfumedebuff", inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    inst:AddTag("projectile")

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("sporebomb")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)

    inst._light = CreateLight()
    inst._light.entity:SetParent(inst.entity)

    inst._fade = net_smallbyte(inst.GUID, "sporebomb._fade", "fadedirty")

    inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)

    inst.OnRemoveEntity = OnRemoveEntity
    inst:DoTaskInTime(0, OnInit)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("fadedirty", OnFadeDirty)

        inst.OnEntityReplicated = OnEntityReplicated

        return inst
    end

    inst.AnimState:PushAnimation("sporebomb_loop")

    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(OnThrown)
    inst.components.complexprojectile:SetOnHit(OnHit)

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(OnAttached)
    inst.components.debuff:SetDetachedFn(OnDetached)

    inst:AddComponent("timer")
    inst.components.timer:StartTimer("explode", TUNING.musha.skills.poisonspore.maxdelay)
    inst:ListenForEvent("timerdone", OnTimerDone)

    return inst
end

return Prefab("poisonspore", fn, assets, prefabs)
