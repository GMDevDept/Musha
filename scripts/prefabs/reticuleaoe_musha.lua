local assets =
{
    Asset("ANIM", "anim/reticuleaoe.zip"),
}

local PAD_DURATION = .1
local SCALE = 1.5
local FLASH_TIME = .3

local function UpdatePing(inst, s0, s1, t0, duration, multcolour, addcolour) -- s1: scaleup, s0 = 1
    if next(multcolour) == nil then
        multcolour[1], multcolour[2], multcolour[3], multcolour[4] = inst.AnimState:GetMultColour()
    end
    if next(addcolour) == nil then
        addcolour[1], addcolour[2], addcolour[3], addcolour[4] = inst.AnimState:GetAddColour()
    end
    local t = GetTime() - t0
    local k = 1 - math.max(0, t - PAD_DURATION) / duration
    k = 1 - k * k
    local s = Lerp(s0, s1, k)
    local c = Lerp(1, 0, k)
    local currentscale = inst.Transform:GetScale()
    inst.Transform:SetScale(currentscale * s, currentscale * s, currentscale * s)
    inst.AnimState:SetMultColour(multcolour[1], multcolour[2], multcolour[3], c * multcolour[4])

    k = math.min(FLASH_TIME, t) / FLASH_TIME
    c = math.max(0, 1 - k * k)
    inst.AnimState:SetAddColour(c * addcolour[1], c * addcolour[2], c * addcolour[3], c * addcolour[4])
end

local function MakePing(name, anim, scaleup)
    local function fn()
        local inst = CreateEntity()

        inst:AddTag("FX")
        inst:AddTag("NOCLICK")
        --[[Non-networked entity]]
        inst.entity:SetCanSleep(false)
        inst.persists = false

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        inst.AnimState:SetBank("reticuleaoe")
        inst.AnimState:SetBuild("reticuleaoe")
        inst.AnimState:PlayAnimation(anim)
        inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGroundFixed)
        inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
        inst.AnimState:SetSortOrder(3)
        inst.AnimState:SetScale(SCALE, SCALE)
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

        local duration = .5
        inst:DoPeriodicTask(0, UpdatePing, nil, 1, scaleup, GetTime(), duration, {}, {})
        inst:DoTaskInTime(duration, inst.Remove)

        return inst
    end

    return Prefab(name, fn, assets)
end

--ping scales to grow radius by .2 (or .1 of inner ring for summons)
return MakePing("reticuleaoeping_musha", "idle", 1.003), -- Radius 4
    -- MakePing("reticuleaoesmallping", "idle_small", 1.1),
    MakePing("reticuleaoesummonping_musha", "idle_summon", 1.002), -- Radius 8
    -- MakePing("reticuleaoeping_1_6", "idle_1_6", 1.1),
    MakePing("reticuleaoeping_1d2_12_musha", "idle_1d2_12", 1.002) -- Radius 12
