local assets = -- For reference
{
    Asset("ANIM", "anim/fireball_2_fx.zip"),
    Asset("ANIM", "anim/lavaarena_heal_projectile.zip"),
    Asset("ANIM", "anim/gooball_fx.zip"),
}

--------------------------------------------------------------------------

local function FireballOnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local validground = TheWorld.Map:IsAboveGroundAtPoint(x, 0, z, true) and not TheWorld.Map:IsOceanAtPoint(x, y, z)
    local one_of_tags = { "_combat", "canlight" }
    local ignore_tags = { "companion", "musha_companion", "player" }
    local range = TUNING.musha.skills.launchelement.rollingmagma.radius
    local damage = TUNING.musha.skills.launchelement.rollingmagma.damage

    CustomDoAOE(inst, range, nil, ignore_tags, one_of_tags, function(v)
        if v.components.combat ~= nil then
            v.components.combat:GetAttacked(inst.owner, damage)
        end
        if validground and v.components.burnable ~= nil then
            if not v.components.burnable:IsBurning() then
                if not v._ignitecounter then
                    v._ignitecounter = 1
                else
                    v._ignitecounter = v._ignitecounter + 1
                end

                if v._ignitecounter >= TUNING.musha.skills.launchelement.rollingmagma.forceignitecounter then
                    v.components.burnable:Ignite(true, inst.owner)
                    v._ignitecounter = nil
                end
            else
                v.components.burnable:ExtendBurning()
            end
        end
    end)

    if validground then
        local postprefab = SpawnPrefab("deer_fire_circle_musha")
        postprefab.owner = inst.owner
        postprefab.Transform:SetPosition(x, 0, z)
        postprefab.SoundEmitter:PlaySound("dontstarve/common/together/infection_burst")
        postprefab.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")
        postprefab:DoTaskInTime(25 * FRAMES, postprefab.TriggerFX)
        postprefab:DoTaskInTime(TUNING.musha.skills.launchelement.rollingmagma.duration, postprefab.KillFX)
        ShakeAllCameras(CAMERASHAKE.FULL, .4, .02, .5, inst, 40)
    else
        local postprefab = SpawnPrefab("small_puff")
        postprefab.Transform:SetPosition(x, 0, z)
    end
end

local function FrostOnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local must_tags = { "_combat", "locomotor" }
    local ignore_tags = { "companion", "musha_companion", "player" }
    local range = TUNING.musha.skills.launchelement.whitefrost.radius

    CustomDoAOE(inst, range, must_tags, ignore_tags, nil, function(v)
        v:AddDebuff("whitefrost", "debuff_slowdown", {
            duration = TUNING.musha.skills.launchelement.whitefrost.slowdownduration,
            speedmultiplier = TUNING.musha.skills.launchelement.whitefrost.initialspeedmultiplier
        })
        if v.components.freezable then
            v.components.freezable:SpawnShatterFX()
        end
    end)

    local fx = SpawnPrefab("splash")
    fx.Transform:SetPosition(x, 0, z)
    fx.Transform:SetScale(1.5, 1.5, 1.5)
    CustomRemoveEntity(fx, 3)

    local postprefab = SpawnPrefab("deer_ice_circle_musha")
    postprefab.owner = inst.owner
    postprefab.Transform:SetPosition(x, 0, z)
    postprefab.SoundEmitter:PlaySound("dontstarve/characters/walter/slingshot/frozen")
    postprefab:DoTaskInTime(3, postprefab.TriggerFX)
    postprefab:DoTaskInTime(TUNING.musha.skills.launchelement.whitefrost.duration, postprefab.KillFX)

    ShakeAllCameras(CAMERASHAKE.FULL, .2, .02, .4, inst, 40)
end

local function SpawnHealFx(x, y, z, fx_prefab, scale)
    local fx = SpawnPrefab(fx_prefab)
    fx.Transform:SetNoFaced()
    fx.Transform:SetPosition(x, y, z)

    scale = scale or 1
    fx.Transform:SetScale(scale, scale, scale)
end

local function HealingOnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local must_one_of_tags = { "companion", "musha_companion", "player" }
    local range = TUNING.musha.skills.launchelement.bloomingfield.radius

    CustomDoAOE(inst, range, nil, nil, must_one_of_tags, function(v)
        if v.components.health ~= nil and not v.components.health:IsDead() then
            local heal_amount = v:HasTag("player") and TUNING.musha.skills.launchelement.bloomingfield.playerhealthregen or
                TUNING.musha.skills.launchelement.bloomingfield.nonplayerhealthregen

            v.components.health:DoDelta(heal_amount, false, inst.owner)
            CustomAttachFx(v, "spider_heal_target_fx")
        end

        if v.components.locomotor ~= nil then
            CustomCancelTask(v.task_cancelbloomingfieldspeedup)

            v.components.locomotor:SetExternalSpeedMultiplier(v, "bloomingfield",
                TUNING.musha.skills.launchelement.bloomingfield.speedmultiplier)

            v.task_cancelbloomingfieldspeedup =  v:DoTaskInTime(TUNING.musha.skills.launchelement.bloomingfield.duration, function()
                v.components.locomotor:RemoveExternalSpeedMultiplier(v, "bloomingfield")
                v.task_cancelbloomingfieldspeedup = nil
            end)
        end
    end)

    local scale = 1.35
    SpawnHealFx(x, y, z, "spider_heal_ground_fx", scale)
    SpawnHealFx(x, y, z, "spider_heal_fx", scale)
    inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
end

--------------------------------------------------------------------------

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, target.components.rider and target.components.rider:IsRiding() and 4 or 2, 0)
end

local function OnDetached(inst)
    inst:Remove()
end

local function OnTimerDone(inst, data)
    if data.name == "explode" then
        inst:OnExplode()
        inst.components.debuff:Stop()
        inst:Remove()
    end
end

local function OnHit(inst, attacker, target)
    inst:OnExplode()
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

--------------------------------------------------------------------------

local function CreateTail(bank, build, lightoverride, addcolour, multcolour)
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    inst.Physics:ClearCollisionMask()

    inst.AnimState:SetBank(bank)
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("disappear")
    if addcolour ~= nil then
        inst.AnimState:SetAddColour(unpack(addcolour))
    end
    if multcolour ~= nil then
        inst.AnimState:SetMultColour(unpack(multcolour))
    end
    if lightoverride > 0 then
        inst.AnimState:SetLightOverride(lightoverride)
    end
    inst.AnimState:SetFinalOffset(3)

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function OnUpdateProjectileTail(inst, bank, build, speed, lightoverride, addcolour, multcolour, hitfx, tails)
    local x, y, z = inst.Transform:GetWorldPosition()
    for tail, _ in pairs(tails) do
        tail:ForceFacePoint(x, y, z)
    end
    if inst.entity:IsVisible() then
        local tail = CreateTail(bank, build, lightoverride, addcolour, multcolour)
        local rot = inst.Transform:GetRotation()
        tail.Transform:SetRotation(rot)
        rot = rot * DEGREES
        local offsangle = math.random() * 2 * PI
        local offsradius = math.random() * .2 + .2
        local hoffset = math.cos(offsangle) * offsradius
        local voffset = math.sin(offsangle) * offsradius
        tail.Transform:SetPosition(x + math.sin(rot) * hoffset, y + voffset, z + math.cos(rot) * hoffset)
        tail.Physics:SetMotorVel(speed * (.2 + math.random() * .3), 0, 0)
        tails[tail] = true
        inst:ListenForEvent("onremove", function(tail) tails[tail] = nil end, tail)
        tail:ListenForEvent("onremove", function(inst)
            tail.Transform:SetRotation(tail.Transform:GetRotation() + math.random() * 30 - 15)
        end, inst)
    end
end

local function MakeProjectile(name, bank, build, speed, lightoverride, addcolour, multcolour, hitfx,
                              onexplodefn, horizontalspeed, gravity)
    local assets =
    {
        Asset("ANIM", "anim/" .. build .. ".zip"),
    }

    local prefabs = hitfx ~= nil and { hitfx } or nil

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

        inst.AnimState:SetBank(bank)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("idle_loop", true)
        if addcolour ~= nil then
            inst.AnimState:SetAddColour(unpack(addcolour))
        end
        if multcolour ~= nil then
            inst.AnimState:SetMultColour(unpack(multcolour))
        end
        if lightoverride > 0 then
            inst.AnimState:SetLightOverride(lightoverride)
        end
        inst.AnimState:SetFinalOffset(3)

        if not TheNet:IsDedicated() then
            inst:DoPeriodicTask(0, OnUpdateProjectileTail, nil, bank, build, speed, lightoverride, addcolour, multcolour
                , hitfx, {})
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        inst:AddComponent("complexprojectile")
        inst.components.complexprojectile:SetHorizontalSpeed(horizontalspeed)
        inst.components.complexprojectile:SetGravity(gravity)
        inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
        inst.components.complexprojectile:SetOnLaunch(OnThrown)
        inst.components.complexprojectile:SetOnHit(OnHit)

        inst:AddComponent("debuff")
        inst.components.debuff:SetAttachedFn(OnAttached)
        inst.components.debuff:SetDetachedFn(OnDetached)

        inst:AddComponent("timer")
        inst.components.timer:StartTimer("explode", TUNING.musha.skills.launchelement.maxdelay)
        inst:ListenForEvent("timerdone", OnTimerDone)

        inst.owner = nil -- Assigned when projectile is launched
        inst.OnExplode = onexplodefn

        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

--------------------------------------------------------------------------

return MakeProjectile("fireball_projectile_musha", "fireball_fx", "fireball_2_fx", 15, 1, nil, nil, "fireball_hit_fx",
    FireballOnExplode, 20, -30),
    MakeProjectile("blossom_projectile_musha", "lavaarena_heal_projectile", "lavaarena_heal_projectile", 15, 0,
        { 0, .2, .1, 0 }, nil, "blossom_hit_fx", HealingOnExplode, 20, -30),
    MakeProjectile("frostball_projectile_musha", "gooball_fx", "gooball_fx", 20, 1, nil, { .9, .9, .9, 1 },
        "gooball_hit_fx", FrostOnExplode, 18, -40)
