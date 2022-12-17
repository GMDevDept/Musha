local assets = {
    Asset("ANIM", "anim/musha/musha_alter.zip"),
}

local fn = function()
    local inst = CreateEntity()

    inst:AddTag("musha_companion")
    inst:AddTag("shadowminion")
    inst:AddTag("scarytoprey")
    inst:AddTag("NOBLOCK")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeGhostPhysics(inst, 1, 0.5)

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("musha_alter")
    inst.AnimState:SetMultColour(.7, .7, .7, .5)

    inst:DoTaskInTime(0, function()
        if not inst.owner then
            inst:Remove()
        end
    end)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(1)
    inst.components.health.nofadeout = true

    inst:SetStateGraph("SGvoidphantom")

    return inst
end

Prefab("musha_voidphantom", fn, assets)
