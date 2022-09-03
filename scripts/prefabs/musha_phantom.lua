local assets = {
    Asset("ANIM", "anim/musha/musha_valkyrie.zip"),
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddNetwork()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("musha_valkyrie")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetSortOrder(-1)

    inst.Transform:SetFourFaced()

    inst.persists = false

    inst:DoTaskInTime(10 * FRAMES, function()
        inst:Remove()
    end)

    return inst
end

return Prefab("musha_phantom", fn, assets)
