local assets =
{
    Asset("ANIM", "anim/mossling_spin_fx.zip")
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.AnimState:SetBank("mossling_spin_fx")
    inst.AnimState:SetBuild("mossling_spin_fx")
    inst.AnimState:PlayAnimation("spin_loop")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mossling/spin_electric")

    inst.persists = false
    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

return Prefab("mossling_spin_fx_musha", fn, assets)
