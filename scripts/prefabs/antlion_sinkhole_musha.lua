require("stategraphs/commonstates")

local assets =
{
    Asset("ANIM", "anim/antlion_sinkhole.zip"),
    Asset("MINIMAP_IMAGE", "sinkhole"),
}

local prefabs =
{
    "sinkhole_spawn_fx_1",
    "sinkhole_spawn_fx_2",
    "sinkhole_spawn_fx_3",
    "mining_ice_fx",
    "mining_fx",
    "mining_moonglass_fx",
}

local NUM_CRACKING_STAGES = 3
local COLLAPSE_STAGE_DURATION = TUNING.musha.skills.desolatedive.sinkhole.collapsetime

local function UpdateOverrideSymbols(inst, state)
    if state == NUM_CRACKING_STAGES then
        inst.AnimState:ClearOverrideSymbol("cracks1")
    else
        inst.AnimState:OverrideSymbol("cracks1", "antlion_sinkhole", "cracks_pre" .. tostring(state))
    end
end

local function SpawnFx(inst, stage, scale)
    local theta = math.random() * PI * 2
    local num = 7
    local radius = 1.6
    local dtheta = 2 * PI / num
    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("sinkhole_spawn_fx_" .. math.random(3)).Transform:SetPosition(x, y, z)
    for i = 1, num do
        local dust = SpawnPrefab("sinkhole_spawn_fx_" .. math.random(3))
        dust.Transform:SetPosition(x + math.cos(theta) * radius * (1 + math.random() * .1), 0,
            z - math.sin(theta) * radius * (1 + math.random() * .1))
        local s = scale + math.random() * .2
        dust.Transform:SetScale(i % 2 == 0 and -s or s, s, s)
        theta = theta + dtheta
    end
    inst.SoundEmitter:PlaySoundWithParams("dontstarve/creatures/together/antlion/sfx/ground_break",
        { size = math.pow(stage / NUM_CRACKING_STAGES, 2) })
end

-- c_sel():PushEvent("timerdone", {name = "nextrepair"})
local function OnTimerDone(inst, data)
    if data ~= nil and data.name == "nextrepair" then
        inst.remainingrepairs = inst.remainingrepairs - 1
        if inst.remainingrepairs <= 0 then
            ErodeAway(inst)
        else
            UpdateOverrideSymbols(inst, inst.remainingrepairs)
            inst.components.timer:StartTimer("nextrepair",
                TUNING.musha.skills.desolatedive.sinkhole.repairtime[inst.remainingrepairs])
        end

        if not inst:IsAsleep() then
            SpawnFx(inst, inst.remainingrepairs, .45)
        end
    end
end

local COLLAPSIBLE_WORK_ACTIONS =
{
    CHOP = true,
    DIG = true,
    HAMMER = true,
    MINE = true,
}
local COLLAPSIBLE_TAGS = { "_combat", "pickable", "NPC_workable" }
for k, v in pairs(COLLAPSIBLE_WORK_ACTIONS) do
    table.insert(COLLAPSIBLE_TAGS, k .. "_workable")
end
local NON_COLLAPSIBLE_TAGS = { "player", "companion", "musha_companion", "flying", "bird", "ghost", "playerghost", "FX",
    "NOCLICK", "DECOR", "INLIMBO" }

local function SmallLaunch(inst, launcher, basespeed)
    local hp = inst:GetPosition()
    local pt = launcher:GetPosition()
    local vel = (hp - pt):GetNormalized()
    local speed = basespeed * .5 + math.random()
    local angle = math.atan2(vel.z, vel.x) + (math.random() * 20 - 10) * DEGREES
    inst.Physics:Teleport(hp.x, .1, hp.z)
    inst.Physics:SetVel(math.cos(angle) * speed, 3 * speed + math.random(), math.sin(angle) * speed)
end

local TOSS_MUST_TAGS = { "_inventoryitem" }
local TOSS_CANT_TAGS = { "locomotor", "INLIMBO" }

local SLOWDOWN_MUST_TAGS = { "locomotor" }
local SLOWDOWN_CANT_TAGS = { "player", "flying", "playerghost", "INLIMBO" }

local function SlowDownTaskUpdate(inst, x, y, z)
    for i, v in ipairs(TheSim:FindEntities(x, y, z, TUNING.musha.skills.desolatedive.radius, SLOWDOWN_MUST_TAGS,
        SLOWDOWN_CANT_TAGS)) do
        local is_follower = v.components.follower ~= nil and v.components.follower.leader ~= nil and
            v.components.follower.leader:HasTag("player")
        if v.components.locomotor ~= nil and not is_follower then
            v.components.locomotor:PushTempGroundSpeedMultiplier(TUNING.musha.skills.desolatedive.speedmultiplier,
                WORLD_TILES.MUD)
        end
    end
end

local function start_repairs(inst, repairdata)
    inst.remainingrepairs = (repairdata and repairdata.num_stages) or NUM_CRACKING_STAGES

    local repairtime = (repairdata and repairdata.time) or
        TUNING.musha.skills.desolatedive.sinkhole.repairtime[NUM_CRACKING_STAGES]
    inst.components.timer:StartTimer("nextrepair", repairtime)
end

local function donextcollapse(inst)
    inst.collapsestage = inst.collapsestage + 1

    local isfinalstage = inst.collapsestage >= NUM_CRACKING_STAGES

    if isfinalstage then
        inst.collapsetask:Cancel()
        inst.collapsetask = nil

        if inst.slowdowntask ~= nil then
            inst.slowdowntask:Cancel()
        end

        local x, y, z = inst.Transform:GetWorldPosition()
        inst.slowdowntask = inst:DoPeriodicTask(0, SlowDownTaskUpdate, nil, x, y, z)
        SlowDownTaskUpdate(inst, x, y, z)

        inst:RemoveTag("scarytoprey")
        start_repairs(inst)
    end

    UpdateOverrideSymbols(inst, inst.collapsestage)

    SpawnFx(inst, inst.collapsestage, .8)

    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, 0, z, TUNING.musha.skills.desolatedive.sinkhole.destructionradius, nil,
        NON_COLLAPSIBLE_TAGS, COLLAPSIBLE_TAGS)
    for i, v in ipairs(ents) do
        if v:IsValid() then
            local isworkable = false
            if v.components.workable ~= nil then
                local work_action = v.components.workable:GetWorkAction()
                --V2C: nil action for NPC_workable (e.g. campfires)
                --     allow digging spawners (e.g. rabbithole)
                isworkable = (
                    (work_action == nil and v:HasTag("NPC_workable")) or
                        (
                        v.components.workable:CanBeWorked() and work_action ~= nil and
                            COLLAPSIBLE_WORK_ACTIONS[work_action.id])
                    )
            end
            if isworkable then
                if isfinalstage then
                    v.components.workable:Destroy(inst)
                    if v:IsValid() and v:HasTag("stump") then
                        v:Remove()
                    end
                else
                    if v.components.workable:GetWorkAction() == ACTIONS.MINE then
                        PlayMiningFX(inst, v, true)
                    end
                    v.components.workable:WorkedBy(inst, 1)
                end
            elseif v.components.pickable ~= nil
                and v.components.pickable:CanBePicked()
                and not v:HasTag("intense") then
                local num = v.components.pickable.numtoharvest or 1
                local product = v.components.pickable.product
                local x1, y1, z1 = v.Transform:GetWorldPosition()
                v.components.pickable:Pick(inst) -- only calling this to trigger callbacks on the object
                if product ~= nil and num > 0 then
                    for i = 1, num do
                        SpawnPrefab(product).Transform:SetPosition(x1, 0, z1)
                    end
                end
            elseif v.components.combat ~= nil
                and v.components.health ~= nil
                and not v.components.health:IsDead() then
                if v.components.combat:CanBeAttacked() then
                    v.components.combat:GetAttacked(inst, TUNING.musha.skills.desolatedive.sinkhole.centerdamage)
                end
            end
        end
    end
    local totoss = TheSim:FindEntities(x, 0, z, TUNING.musha.skills.desolatedive.sinkhole.destructionradius,
        TOSS_MUST_TAGS, TOSS_CANT_TAGS)
    for i, v in ipairs(totoss) do
        if v.components.mine ~= nil then
            v.components.mine:Deactivate()
        end
        if not v.components.inventoryitem.nobounce and v.Physics ~= nil and v.Physics:IsActive() then
            SmallLaunch(v, inst, 1.5)
        end
    end
end

local function onstartcollapse(inst)
    inst.collapsestage = 0

    inst:AddTag("scarytoprey")

    inst.collapsetask = inst:DoPeriodicTask(COLLAPSE_STAGE_DURATION, donextcollapse)
    donextcollapse(inst)
end

-------------------------------------------------------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("sinkhole")
    inst.AnimState:SetBuild("antlion_sinkhole")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(2)

    inst.MiniMapEntity:SetIcon("sinkhole.png")

    inst.Transform:SetEightFaced()

    inst:AddTag("antlion_sinkhole")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("NOCLICK")

    inst:SetDeployExtraSpacing(4)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("timer")
    inst:ListenForEvent("timerdone", OnTimerDone)

    inst:ListenForEvent("startcollapse", onstartcollapse)
    inst:ListenForEvent("startrepair", start_repairs)

    return inst
end

return Prefab("antlion_sinkhole_musha", fn, assets, prefabs)
