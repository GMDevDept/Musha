local assets =
{
    Asset("ANIM", "anim/general/tired_debuff_90.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("sporebomb")
    inst.AnimState:SetBuild("tired_debuff_90")
    inst.AnimState:PlayAnimation("sporebomb_pre")
    inst.AnimState:SetLightOverride(.3)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:PushAnimation("sporebomb_loop")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("fx_fullmode", fn, assets)
