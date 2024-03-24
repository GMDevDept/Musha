local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()

    inst:AddTag("NOCLICK")
    inst:AddTag("dummyplaceholder")

    inst.persists = false

    inst:DoTaskInTime(3, inst.Remove)

    return inst
end

return Prefab("dummyplaceholder", fn)
