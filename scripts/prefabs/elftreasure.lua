local assets =
{
    Asset("ANIM", "anim/x_marks_spot.zip"),
    Asset("IMAGE", "images/map_icons/musha_treasure2.tex"),
    Asset("ATLAS", "images/map_icons/musha_treasure2.xml"),
}

local function fling_loot(loot)
    Launch(loot, loot, 2)
end

local MAX_LOOTFLING_DELAY = 0.8
local function stash_dug(inst)
    local inst_pos = inst:GetPosition()

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst_pos:Get())

    inst:Hide()
    for i, loot in ipairs(inst.loot) do
        loot:ReturnToScene()
        loot.Transform:SetPosition(inst_pos:Get())
        loot:DoTaskInTime(MAX_LOOTFLING_DELAY * math.random(), fling_loot)

        if loot.components.perishable then
            loot.components.perishable:StartPerishing()
        end
    end

    -- Ensure that the remove happens after all of our loot gets flung.
    inst:DoTaskInTime(MAX_LOOTFLING_DELAY + 0.2, function()
        inst:Remove()
    end)
end

local function stashloot(inst, item)
    item.Transform:SetPosition(inst.Transform:GetWorldPosition())
    item:RemoveFromScene()
    table.insert(inst.loot, item)
    if item.components.perishable then
        item.components.perishable:StopPerishing()
    end
    if inst.onstashed then
        inst:onstashed()
    end
end

local function OnSave(inst, data)
    data.loot = {}
    for i, k in ipairs(inst.loot) do
        table.insert(data.loot, k.GUID)
    end
    return data.loot
end

local function OnLoadPostPass(inst, ents, data)
    inst.loot = {}
    if data and data.loot then
        for i, k in ipairs(data.loot) do
            if ents[k] and ents[k].entity then
                stashloot(inst, ents[k].entity)
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()

    inst.MiniMapEntity:SetIcon("musha_treasure2.tex")

    inst.AnimState:SetBank("x_marks_spot")
    inst.AnimState:SetBuild("x_marks_spot")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnWorkCallback(stash_dug)

    inst.loot = {}
    inst.stashloot = stashloot

    inst.OnSave = OnSave
    inst.OnLoadPostPass = OnLoadPostPass

    return inst
end

return Prefab("elftreasure", fn, assets)
