local prefabs_spell =
{
    "shadow_pillar",
    "shadow_pillar_target",
    "shadow_glob_fx",
}

--------------------------------------------------------------------------
--"shadow_pillar_spell" is a hidden entity that finds valid targets in an
--area for spawning "shadow_pillar_target" and "shadow_pillar" entities

local TRAIL_TAGS = { "shadowtrail" }
local function TryFX(inst, offsets, map)
    local offs1, offs2, offs3 = unpack(offsets)
    while true do --should we limit number of tries?
        local offset = table.remove(offs1, math.random(#offs1))
        local x, y, z = inst.entity:LocalToWorldSpaceIncParent(offset:Get())
        table.insert(offs3, offset)
        if map:IsPassableAtPoint(x, 0, z, true) and not map:IsGroundTargetBlocked(Vector3(x, 0, z)) then
            if #TheSim:FindEntities(x, 0, z, .7, TRAIL_TAGS) <= 0 then
                local fx = SpawnPrefab("shadow_glob_fx")
                if map:IsOceanAtPoint(x, 0, z, true) then
                    local platform = map:GetPlatformAtPoint(x, z)
                    if platform ~= nil then
                        fx.entity:SetParent(platform.entity)
                        x, y, z = platform.entity:WorldToLocalSpace(x, 0, z)
                    else
                        fx:EnableRipples(true)
                    end
                end
                fx.Transform:SetPosition(x, 0, z)
            end
            break
        elseif #offs1 <= 0 then
            if #offs2 > 0 then
                --Swap in page 2 offsets
                offsets[1] = offs2
                offsets[2] = offs1
                offs1 = offs2
                offs2 = offsets[2]
            else
                --Tried all offsets, none valid
                offsets[1] = offs3
                offsets[3] = offs1
                return
            end
        end
    end

    for i = 1, #offs3 do
        table.insert(offs2, offs3[i])
        offs3[i] = nil
    end
    if #offs1 <= 0 then
        offsets[1] = offs2
        offsets[2] = offs1
    end
end

local function StartFX(inst)
    local angle = math.random() * PI2
    local offsets = {}
    for i = 1, inst.fxcirclecount do
        local radius = (i - 1) * 1.6
        local count = i > 1 and i * i - 1 or 1
        local delta = PI2 / count
        for j = 1, count do
            angle = angle + delta
            table.insert(offsets, Vector3(math.cos(angle) * radius, 0, -math.sin(angle) * radius))
        end
        angle = angle + delta * .5
    end
    inst:DoPeriodicTask(FRAMES, TryFX, 0, { offsets, {}, {} }, TheWorld.Map)
end

local function IsNearOther(pt, newpillars)
    for i, v in ipairs(newpillars) do
        if distsq(pt.x, pt.z, v.x, v.z) < 1 then
            return true
        end
    end
    return false
end

local function DoPillarsTarget(target, caster, item, newpillars, map, x0, z0)
    --Dispell existing pillars first
    target:PushEvent("dispell_shadow_pillars")

    local padding =
    (target:HasTag("epic") and 1) or
        (target:HasTag("smallcreature") and 0) or
        .75
    local radius = math.max(1, target:GetPhysicsRadius(0) + padding)
    local circ = PI2 * radius
    local num = math.floor(circ / 1.4 + .5)

    local period = 1 / num
    local delays = {}
    for i = 0, num - 1 do
        table.insert(delays, i * period)
    end

    local platform = target:GetCurrentPlatform()
    local flying = not platform and target:HasTag("flying")

    local ent = SpawnPrefab("shadow_pillar_target")
    ent.Transform:SetPosition(x0, 0, z0)
    ent:SetDelay(delays[#delays]) --this just extends lifetime, spell still takes effect right away
    ent:SetTarget(target, radius, platform ~= nil)

    local theta = math.random() * PI2
    local delta = PI2 / num
    for i = 1, num do
        local pt = Vector3(x0 + math.cos(theta) * radius, 0, z0 - math.sin(theta) * radius)
        if not IsNearOther(pt, newpillars) and
            map:IsPassableAtPoint(pt.x, 0, pt.z, true) and
            flying or (map:GetPlatformAtPoint(pt.x, pt.z) == platform) and
            not map:IsGroundTargetBlocked(pt) then
            ent = SpawnPrefab("shadow_pillar")
            ent.Transform:SetPosition(pt:Get())
            ent:SetDelay(table.remove(delays, math.random(#delays)))
            ent:SetTarget(target, platform ~= nil)
            newpillars[ent] = pt
        end
        theta = theta + delta
    end

    if not ((target.sg ~= nil and target.sg:HasStateTag("noattack")) or (caster and caster:HasTag("notarget"))) then
        target:PushEvent("attacked", { attacker = caster, damage = 0, weapon = item })
    end
end

local SPELL_MUST_TAGS = { "locomotor" }
local SPELL_NO_TAGS_PVP = { "INLIMBO", "notarget", "flight", "invisible", "notraptrigger", "projectile" }
local SPELL_NO_TAGS = deepcopy(SPELL_NO_TAGS_PVP)
table.insert(SPELL_NO_TAGS, "player")
local function DoPillars(inst, targets, newpillars)
    local map = TheWorld.Map
    local caster = inst.caster ~= nil and inst.caster:IsValid() and inst.caster or nil
    local castercombat = caster ~= nil and caster.components.combat or nil
    local item = inst.item ~= nil and inst.item:IsValid() and inst.item or nil
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, 0, z, inst.range, SPELL_MUST_TAGS,
        TheNet:GetPVPEnabled() and SPELL_NO_TAGS_PVP or SPELL_NO_TAGS)
    for i, v in ipairs(ents) do
        if v ~= caster and not targets[v] and v.entity:IsVisible() and
            not (v.components.health ~= nil and v.components.health:IsDead()) and
            not (castercombat ~= nil and castercombat:IsAlly(v)) then
            x, y, z = v.Transform:GetWorldPosition()
            if map:IsPassableAtPoint(x, y, z, true) then
                targets[v] = true
                DoPillarsTarget(v, caster, item, newpillars, map, x, z)
            end
        end
    end
end

local function StopTask(inst, task)
    task:Cancel()
    inst.SoundEmitter:KillSound("loop")
end

local function MakeSpell(name, data)
    local function spell_fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        inst:AddTag("CLASSIFIED")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        -- Caster and item should be set when spawned, item can be nil (only decides weapon)
        -- inst.caster = nil
        -- inst.item = inst.caster.components.combat:GetWeapon()
        inst.range = data.range
        inst.fxcirclecount = data.fxcirclecount

        inst.SoundEmitter:PlaySound("maxwell_rework/shadow_magic/shadow_goop_ground", "loop")
        StartFX(inst)
        local task = inst:DoPeriodicTask(.25, DoPillars, 0, {}, {})
        inst:DoTaskInTime(1.25, StopTask, task)
        inst:DoTaskInTime(1.5, inst.Remove)

        inst.persists = false

        return inst
    end

    return Prefab(name, spell_fn, nil, prefabs_spell)
end

--------------------------------------------------------------------------

return MakeSpell("shadow_pillar_spell_4_musha", { range = 4, fxcirclecount = 3 }),
    MakeSpell("shadow_pillar_spell_9_musha", { range = 9, fxcirclecount = 5 })
