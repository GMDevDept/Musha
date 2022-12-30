local assets = {
    Asset("ANIM", "anim/musha/musha_alter.zip"),
}

local function OwnerValid(inst)
    return inst.owner ~= nil and inst.owner:IsValid() and inst.owner.components.health ~= nil
        and not inst.owner.components.health:IsDead()
end

local fn = function()
    local inst = CreateEntity()

    inst:AddTag("musha_voidphantom")
    inst:AddTag("musha_companion")
    inst:AddTag("shadowminion")
    inst:AddTag("scarytoprey")
    inst:AddTag("NOBLOCK")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeTinyFlyingCharacterPhysics(inst, 1, .1)

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("musha_alter")
    inst.AnimState:AddOverrideBuild("lavaarena_shadow_lunge")
    inst.AnimState:SetMultColour(.1, .1, .1, .85)
    inst.AnimState:OverrideSymbol("swap_object", "swap_nightmaresword_shadow", "swap_nightmaresword_shadow")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("spelltarget")

    inst:SetStateGraph("SGvoidphantom")

    inst.OwnerValid = OwnerValid

    inst:DoTaskInTime(0, function()
        if not inst:OwnerValid() then
            inst:Remove()
        else
            CustomAttachFx(inst, "statue_transition")
        end
    end)

    inst:DoTaskInTime(TUNING.musha.skills.voidphantom.duration, function()
        inst.sg:GoToState("disappear")
    end)

    return inst
end

return Prefab("musha_voidphantom", fn, assets)
