local function PrefabPostInitFn(inst)
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("mushaedible")
end

AddPrefabPostInit("shadowheart", PrefabPostInitFn)
