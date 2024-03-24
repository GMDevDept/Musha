local assets = -- Reference
{
    Asset("ANIM", "anim/general/tired_debuff_30.zip"), -- Red
    Asset("ANIM", "anim/general/tired_debuff_50.zip"), -- Orange
    Asset("ANIM", "anim/general/tired_debuff_70.zip"), -- Yellow
    Asset("ANIM", "anim/general/tired_debuff_90.zip"), -- White
}

local function MakeFX(name, build)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        inst:AddTag("FX")
        inst:AddTag("NOCLICK")

        inst.AnimState:SetBank("sporebomb")
        inst.AnimState:SetBuild(build)
        inst.AnimState:SetLightOverride(.3)
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.AnimState:SetFinalOffset(3)
        inst.AnimState:PlayAnimation("sporebomb_pre")
        inst.AnimState:PushAnimation("sporebomb_loop")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false

        return inst
    end

    return Prefab(name, fn, { Asset("ANIM", "anim/general/" .. build .. ".zip") })
end

return MakeFX("fx_pawprint_white", "tired_debuff_90"),
    MakeFX("fx_pawprint_yellow", "tired_debuff_70"),
    MakeFX("fx_pawprint_orange", "tired_debuff_50"),
    MakeFX("fx_pawprint_red", "tired_debuff_30")
