---@diagnostic disable: deprecated
local ICE_COLOUR = { 60 / 255, 120 / 255, 255 / 255 }
local FIRE_COLOUR = { 220 / 255, 100 / 255, 0 / 255 }

local function OnUpdateFade(inst)
    local k
    if inst._fade:value() <= inst._fadeframes then
        inst._fade:set_local(math.min(inst._fade:value() + inst._fadeinspeed, inst._fadeframes))
        k = inst._fade:value() / inst._fadeframes
    else
        inst._fade:set_local(math.min(inst._fade:value() + inst._fadeoutspeed, inst._fadeframes * 2 + 1))
        k = (inst._fadeframes * 2 + 1 - inst._fade:value()) / inst._fadeframes
    end

    inst.Light:SetIntensity(inst._fadeintensity * k)
    inst.Light:SetRadius(inst._faderadius * k)
    inst.Light:SetFalloff(1 - (1 - inst._fadefalloff) * k)

    if TheWorld.ismastersim then
        inst.Light:Enable(inst._fade:value() > 0 and inst._fade:value() <= inst._fadeframes * 2)
    end

    if inst._fade:value() == inst._fadeframes or inst._fade:value() > inst._fadeframes * 2 then
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

local function FadeOut(inst)
    inst._fade:set(inst._fadeframes + 1)
    if inst._fadetask == nil then
        inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
    end
end

local function OnFXKilled(inst)
    if inst.fxcount > 0 then
        inst.fxcount = inst.fxcount - 1
    else
        inst:Remove()
    end
end

local function TriggerFX(inst)
    if not inst.killed and inst.fx ~= nil then
        return
    end
    inst.fx = {}
    inst.fxcount = 0
    local function onremovefx(fx)
        OnFXKilled(inst)
    end

    for i, v in ipairs(inst.fxprefabs) do
        local fx = SpawnPrefab(v)
        fx.entity:SetParent(inst.entity)
        inst.fxcount = inst.fxcount + 1
        inst:ListenForEvent("onremove", onremovefx, fx)
        table.insert(inst.fx, fx)
    end
end

local function KillFX(inst, anim)
    if not inst.killed then
        if inst.OnKillFX ~= nil then
            inst:OnKillFX(anim)
        end
        inst.killed = true
        inst.AnimState:PlayAnimation(anim or "pst")
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + .25, inst.fx ~= nil and OnFXKilled or inst.Remove)
        if inst.task ~= nil then
            inst.task:Cancel()
            inst.task = nil
        end
        if inst._fade ~= nil then
            FadeOut(inst)
        end
        if inst.fx ~= nil then
            for i, v in ipairs(inst.fx) do
                v:KillFX()
            end
        end
    end
end

--------------------------------------------------------------------------

local RANDOM_SEGS = 8
local SEG_ANGLE = 360 / RANDOM_SEGS
local ANGLE_VARIANCE = SEG_ANGLE * 2 / 3
local function GetRandomAngle(inst)
    if inst.angles == nil then
        inst.angles = {}
        local offset = math.random() * 360
        for i = 0, RANDOM_SEGS - 1 do
            table.insert(inst.angles, offset + i * SEG_ANGLE)
        end
    end
    local rnd = math.random()
    rnd = rnd * rnd
    local angle = table.remove(inst.angles, math.max(1, math.ceil(rnd * rnd * RANDOM_SEGS)))
    table.insert(inst.angles, angle)
    return (angle + math.random() * ANGLE_VARIANCE) * DEGREES
end

local function DoBurst(inst, x, z, minr, maxr)
    if inst.burstprefab ~= nil then
        local fx = SpawnPrefab(inst.burstprefab)
        local theta = GetRandomAngle(inst)
        local rad = GetRandomMinMax(minr, maxr)
        fx.Transform:SetPosition(x + rad * math.cos(theta), 0, z + rad * math.sin(theta))
    end
end

--------------------------------------------------------------------------

local ICE_CIRCLE_RADIUS = 3
local NOTAGS = { "playerghost", "INLIMBO" }
for k, v in pairs(FUELTYPE) do
    table.insert(NOTAGS, v .. "_fueled")
end

local FREEZETARGET_ONEOF_TAGS = { "locomotor", "freezable", "fire", "smolder" }
local function OnUpdateIceCircle(inst, x, z)
    inst._rad:set(inst._rad:value() * .98 + ICE_CIRCLE_RADIUS * .02)

    if inst.fx ~= nil then
        inst.burstdelay = (inst.burstdelay or 6) - 1
        if inst.burstdelay < 0 then
            inst.burstdelay = math.random(5, 6)
            DoBurst(inst, x, z, inst._rad:value() - .7, inst._rad:value() - .2)
        end
    end

    inst._track1 = inst._track2 or {}
    inst._track2 = {}

    for i, v in ipairs(TheSim:FindEntities(x, 0, z, inst._rad:value(), nil, NOTAGS, FREEZETARGET_ONEOF_TAGS)) do
        if v:IsValid() and not (v.components.health ~= nil and v.components.health:IsDead()) then
            local nodamage = v:HasTag("player") or v:HasTag("companion") or v:HasTag("musha_companion")

            if v.components.locomotor ~= nil then
                v.components.locomotor:PushTempGroundSpeedMultiplier(TUNING.musha.skills.launchelement.whitefrost.speedmultiplier)
            end

            if v.components.burnable ~= nil and v.components.fueled == nil then
                v.components.burnable:Extinguish()
            end

            if v.components.freezable ~= nil and inst.fx ~= nil then -- TriggerFX has been called
                if v.components.freezable:IsFrozen() then
                    if not nodamage then CustomOnFreeze(v) end
                    inst._track2[v] = TUNING.DEER_ICE_FREEZE_LOCK_FRAMES
                    v.components.freezable:AddColdness(.1, 1)
                else
                    inst._track2[v] = (inst._track1[v] or 0) > 0 and inst._track1[v] - 1 or nil
                    if inst._track2[v] == nil then
                        if not v:HasTag("freeze_cooldown") then
                            if v.components.combat ~= nil and not nodamage then
                                v.components.combat:GetAttacked(inst.owner,
                                    TUNING.musha.skills.launchelement.whitefrost.damageperhit)
                            end
                            v.components.freezable:AddColdness(TUNING.musha.skills.launchelement.whitefrost.coldnessperhit
                                , 1) -- Must be called after GetAttacked
                        elseif v.components.health ~= nil and not nodamage then -- For targets in freeze cooldown, only do delta to health to prevent freezing and attacked stun
                            v.components.health:DoDelta(-TUNING.musha.skills.launchelement.whitefrost.damageperhit)
                        end
                    elseif v.components.freezable.coldness < v.components.freezable:ResolveResistance() * .7
                        and not v:HasTag("freeze_cooldown") then
                        v.components.freezable:AddColdness(.1, 1, true)
                    end
                end
            end

            if v.components.temperature ~= nil then
                local newtemp = math.max(v.components.temperature.mintemp, TUNING.DEER_ICE_TEMPERATURE)
                if newtemp < v.components.temperature:GetCurrent() then
                    v.components.temperature:SetTemperature(newtemp)
                end
            end

            if v.components.grogginess ~= nil and not v.components.grogginess:IsKnockedOut() then
                local curgrog = v.components.grogginess.grog_amount
                if curgrog < TUNING.DEER_ICE_FATIGUE then
                    v.components.grogginess:AddGrogginess(TUNING.DEER_ICE_FATIGUE)
                end
            end
        end
    end
end

local function OnUpdateIceCircleClient(inst, x, z)
    local rad = inst._rad:value()
    if rad > 0 then
        local player = ThePlayer
        if player ~= nil and
            player.components.locomotor ~= nil and
            not player:HasTag("playerghost") and
            player:GetDistanceSqToPoint(x, 0, z) < rad * rad then
            player.components.locomotor:PushTempGroundSpeedMultiplier(TUNING.DEER_ICE_SPEED_PENALTY)
        end
    end
end

local function OnInitIceCircleClient(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst:DoPeriodicTask(0, OnUpdateIceCircleClient, nil, x, z)
    OnUpdateIceCircleClient(inst, x, z)
end

local function OnInitIceCircle(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst._rad:set(.25)
    inst.task = inst:DoPeriodicTask(0, OnUpdateIceCircle, nil, x, z)
    OnUpdateIceCircle(inst, x, z)
end

local function OnAnimOverIceCircle(inst)
    inst.SoundEmitter:KillSound("loop")
end

local function deer_ice_circle_common_postinit(inst)
    inst:AddTag("deer_ice_circle")

    inst._rad = net_float(inst.GUID, "deer_ice_circle._rad")

    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, OnInitIceCircleClient)
    end
end

local function deer_ice_circle_master_postinit(inst)
    inst.task = inst:DoTaskInTime(0, OnInitIceCircle)
    inst:ListenForEvent("animover", OnAnimOverIceCircle)
end

local function deer_ice_circle_onkillfx(inst, anim)
    inst:RemoveTag("deer_ice_circle")
    inst._rad:set(0)
end

--------------------------------------------------------------------------

local function deer_ice_fx_onkillfx(inst, anim)
    inst.SoundEmitter:KillSound("loop")
end

--------------------------------------------------------------------------

local FIRE_CIRCLE_RADIUS = 3.6
local FIRE_TARGET_ONEOF_TAGS = { "_health", "canlight", "freezable" }
local FIND_DEER_ICE_CIRCLE_TAG = { "deer_ice_circle" }
local function OnUpdateFireCircle(inst, x, z)
    inst._rad = inst._rad * .9 + FIRE_CIRCLE_RADIUS * .1

    if inst._rad > 1 then
        inst.burstdelay = (inst.burstdelay or 2) - 1
        if inst.burstdelay < 0 then
            inst.burstdelay = math.random(1, 2)
            DoBurst(inst, x, z, math.max(1, inst._rad - 1.5), inst._rad - .25)
        end
    end

    inst._track1 = inst._track2 or {}
    inst._track2 = {}

    local y --dummy
    for i, v in ipairs(TheSim:FindEntities(x, 0, z, inst._rad, nil, NOTAGS, FIRE_TARGET_ONEOF_TAGS)) do
        if v:IsValid() and not (v.components.health ~= nil and v.components.health:IsDead()) then
            x, y, z = v.Transform:GetWorldPosition()
            local iced = false
            for _, ice in ipairs(TheSim:FindEntities(x, 0, z, ICE_CIRCLE_RADIUS, FIND_DEER_ICE_CIRCLE_TAG)) do
                if not ice.killed then
                    iced = true
                    break
                end
            end
            if not iced then
                if v.components.freezable ~= nil then
                    if v.components.freezable:IsFrozen() then
                        v.components.freezable:Unfreeze()
                    elseif v.components.freezable.coldness > 0 then
                        v.components.freezable:AddColdness(-.1)
                    end
                end
                if v.components.burnable ~= nil and
                    v.components.fueled == nil and
                    v.components.health ~= nil then
                    if not v.components.burnable:IsBurning() then
                        inst._track2[v] = (inst._track1[v] or 0) + 1
                        if v:HasTag("player") then -- Take longer to ignite players
                            if inst._track2[v] > 3 * TUNING.musha.skills.launchelement.rollingmagma.igniteframe then
                                v.components.burnable:Ignite(true, inst)
                            end
                        else
                            if inst._track2[v] > TUNING.musha.skills.launchelement.rollingmagma.igniteframe then
                                v.components.burnable:Ignite(true, inst)
                            end
                        end
                    else
                        inst._track2[v] = TUNING.musha.skills.launchelement.rollingmagma.igniteframe
                        v.components.burnable:ExtendBurning()
                    end
                end
                if v.components.temperature ~= nil then
                    local newtemp = math.min(v.components.temperature:GetMax(), TUNING.DEER_FIRE_TEMPERATURE)
                    if newtemp > v.components.temperature:GetCurrent() then
                        v.components.temperature:SetTemperature(newtemp)
                    end
                end
            end
        end
    end
end

local function OnInitFireCircle(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    inst._rad = .25
    inst.task = inst:DoPeriodicTask(0, OnUpdateFireCircle, nil, x, z)
    OnUpdateFireCircle(inst, x, z)
end

local function deer_fire_circle_common_postinit(inst)
    inst:AddTag("deer_fire_circle")
end

local function deer_fire_circle_master_postinit(inst)
    inst.task = inst:DoTaskInTime(0, OnInitFireCircle)
end

local function OnKillFireCircle(inst)
    inst.SoundEmitter:KillSound("loop")
end

local function deer_fire_circle_onkillfx(inst, anim)
    inst:RemoveTag("deer_fire_circle")
    inst:ListenForEvent("animover", OnKillFireCircle)
end

--------------------------------------------------------------------------

local function ChargedFireOnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local owner = inst.owner
    local postprefab = SpawnPrefab("fireball_projectile_musha")
    postprefab.owner = owner
    postprefab.Transform:SetPosition(x, 0, z)
    postprefab.components.complexprojectile:Hit()

    local function Split()
        local range = TUNING.musha.skills.launchelement.rollingmagma.charged.range
        local map = TheWorld.Map
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * range,
            4,
            function(offset)
                local x1 = x + offset.x
                local z1 = z + offset.z
                return not map:IsPointNearHole(Vector3(x1, 0, z1), .4)
                    and #TheSim:FindEntities(x1, 0, z1, 3, nil, nil, { "dummyplaceholder", "deer_fire_circle" }) == 0
            end
        )

        if offset ~= nil then
            local placeholder = SpawnPrefab("dummyplaceholder")
            placeholder.Transform:SetPosition(x + offset.x, 0, z + offset.z)

            local postprefab = SpawnPrefab("fireball_projectile_musha")
            postprefab.owner = owner
            postprefab.Transform:SetPosition(x, y, z)
            postprefab.components.complexprojectile:Launch(Vector3(x + offset.x, 0, z + offset.z), owner)
        end
    end

    local min = TUNING.musha.skills.launchelement.rollingmagma.charged.mincount
    local max = TUNING.musha.skills.launchelement.rollingmagma.charged.maxcount

    TheWorld:CustomDoPeriodicTask(math.random(min, max) * 0.15, .15, Split)
end

local function ChargedIceOnExplode(inst)
    local x, y, z
    local parent = inst.entity:GetParent()
    if parent ~= nil then
        x, y, z = parent.Transform:GetWorldPosition()
    else
        x, y, z = inst.Transform:GetWorldPosition()
    end

    local fx = SpawnPrefab("crab_king_waterspout")
    fx.Transform:SetPosition(x, 0, z)

    local postprefab = SpawnPrefab("crabking_feeze_musha")
    postprefab.owner = inst.owner
    postprefab.Transform:SetPosition(x, 0, z)
    postprefab.SoundEmitter:PlaySound("dontstarve/common/break_iceblock")
end

local function OnAttached(inst, target)
    inst.entity:SetParent(target.entity)
    inst.Transform:SetPosition(0, 4, 0)
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

local function deer_charge_common_postinit(inst)
    MakeInventoryPhysics(inst)

    inst:AddTag("NOCLICK")
    inst:AddTag("projectile")

    inst.SoundEmitter:SetParameter("loop", "intensity", 1)
end

local function deer_charge_master_postinit(inst, init, horizontalspeed, gravity, onexplodefn)
    if not init then
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

        inst:DoTaskInTime(0, deer_charge_master_postinit, true)
    elseif not inst.killed then
        inst:DoTaskInTime(0, function(inst)
            if not inst.nosound then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_gemstaff")
                inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop_fail")
            end
        end)
    end
end

local function deer_charge_onkillfx(inst, anim)
    inst.SoundEmitter:KillSound("loop")
    if anim ~= nil then
        inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop")
    end
end

--------------------------------------------------------------------------

local function MakeFX(name, data)
    local buildname = string.sub(name, 1, -7)
    local assets =
    {
        Asset("ANIM", "anim/" .. buildname .. ".zip"),
    }

    local prefabs = {}
    if data.burstprefab ~= nil then
        table.insert(prefabs, data.burstprefab)
    end
    if data.fxprefabs ~= nil then
        for i, v in ipairs(data.fxprefabs) do
            table.insert(prefabs, v)
        end
    end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        if data.sound ~= nil or data.soundloop ~= nil then
            inst.entity:AddSoundEmitter()
        end
        inst.entity:AddNetwork()

        inst.AnimState:SetBank(buildname)
        inst.AnimState:SetBuild(buildname)
        inst.AnimState:PlayAnimation(data.oneshotanim or "pre")
        inst.AnimState:SetLightOverride(1)
        inst.AnimState:SetFinalOffset(1)

        if data.bloom then
            inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        end

        if data.onground then
            inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
            inst.AnimState:SetLayer(LAYER_BACKGROUND)
            inst.AnimState:SetSortOrder(3)
        end

        if data.soundloop ~= nil then
            inst.SoundEmitter:PlaySound(data.soundloop, "loop")
        end

        if data.light then
            if data.onground then
                inst._fadeframes = 30
                inst._fadeintensity = .8
                inst._faderadius = 3
                inst._fadefalloff = .9
                inst._fadeinspeed = 1
                inst._fadeoutspeed = 2
            else
                inst._fadeframes = 15
                inst._fadeintensity = .8
                inst._faderadius = 2
                inst._fadefalloff = .7
                inst._fadeinspeed = 3
                inst._fadeoutspeed = 1
            end

            inst.entity:AddLight()
            inst.Light:SetColour(unpack(data.light))
            inst.Light:SetRadius(inst._faderadius)
            inst.Light:SetFalloff(inst._fadefalloff)
            inst.Light:SetIntensity(inst._fadeintensity)
            inst.Light:Enable(false)
            inst.Light:EnableClientModulation(true)

            inst._fade = net_smallbyte(inst.GUID, "deer_fx._fade", "fadedirty")

            inst._fadetask = inst:DoPeriodicTask(FRAMES, OnUpdateFade)
        end

        inst:AddTag("FX")

        if data.common_postinit ~= nil then
            data.common_postinit(inst)
        end

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            if data.light then
                inst:ListenForEvent("fadedirty", OnFadeDirty)
            end

            return inst
        end

        inst.persists = false

        if data.sound ~= nil then
            inst.SoundEmitter:PlaySound(data.sound)
        end

        if data.oneshotanim ~= nil then
            inst.killed = true
            inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + .25, inst.Remove)
        else
            inst.burstprefab = data.burstprefab

            if data.fxprefabs ~= nil then
                inst.fxprefabs = data.fxprefabs
                inst.TriggerFX = TriggerFX
            end

            if data.looping then
                inst.AnimState:PushAnimation("loop")
            end
        end

        inst.KillFX = KillFX
        inst.OnKillFX = data.onkillfx

        if data.master_postinit ~= nil then
            data.master_postinit(inst, nil, data.horizontalspeed, data.gravity, data.onexplodefn)
        end

        return inst
    end

    return Prefab(name, fn, assets, #prefabs > 0 and prefabs or nil)
end

return MakeFX("deer_ice_circle_musha", {
    light = ICE_COLOUR,
    onground = true,
    soundloop = "dontstarve/creatures/together/deer/fx/ice_circle_LP",
    fxprefabs = { "deer_ice_fx", "deer_ice_flakes" },
    burstprefab = "deer_ice_burst",
    common_postinit = deer_ice_circle_common_postinit,
    master_postinit = deer_ice_circle_master_postinit,
    onkillfx = deer_ice_circle_onkillfx,
}),
    MakeFX("deer_ice_fx_musha", {
        looping = true,
        soundloop = "dontstarve/creatures/together/deer/fx/steam_LP",
        onkillfx = deer_ice_fx_onkillfx,
    }),
    MakeFX("deer_ice_charge_musha", {
        light = ICE_COLOUR,
        bloom = true,
        looping = true,
        soundloop = "dontstarve/creatures/together/deer/fx/charge_LP",
        common_postinit = deer_charge_common_postinit,
        master_postinit = deer_charge_master_postinit,
        onkillfx = deer_charge_onkillfx,
        horizontalspeed = 25,
        gravity = -35,
        onexplodefn = ChargedIceOnExplode,
    }),
    MakeFX("deer_fire_circle_musha", {
        light = FIRE_COLOUR,
        bloom = true,
        onground = true,
        soundloop = "dontstarve/creatures/together/deer/fx/fire_circle_LP",
        fxprefabs = { "deer_fire_flakes" },
        burstprefab = "deer_fire_burst",
        common_postinit = deer_fire_circle_common_postinit,
        master_postinit = deer_fire_circle_master_postinit,
        onkillfx = deer_fire_circle_onkillfx,
    }),
    MakeFX("deer_fire_charge_musha", {
        light = FIRE_COLOUR,
        bloom = true,
        looping = true,
        soundloop = "dontstarve/creatures/together/deer/fx/charge_LP",
        common_postinit = deer_charge_common_postinit,
        master_postinit = deer_charge_master_postinit,
        onkillfx = deer_charge_onkillfx,
        horizontalspeed = 25,
        gravity = -35,
        onexplodefn = ChargedFireOnExplode,
    })
