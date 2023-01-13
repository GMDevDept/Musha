local assets = {
    Asset("ANIM", "anim/musha/musha_normal.zip"),
    Asset("ANIM", "anim/musha/musha_full.zip"),
    Asset("ANIM", "anim/musha/musha_valkyrie.zip"),
    Asset("ANIM", "anim/musha/musha_berserk.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:AddNetwork()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeTinyFlyingCharacterPhysics(inst, 1, .1)

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("musha_valkyrie")
    inst.AnimState:SetSortOrder(1)

    inst.Transform:SetFourFaced()

    inst:DoTaskInTime(0, function()
        if inst.owner then
            local build = inst.owner.AnimState:GetBuild()
            inst.AnimState:SetBuild(build)
        end
    end)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("musha_phantom", fn, assets)
