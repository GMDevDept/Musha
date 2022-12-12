local function doneact(inst)
    inst._activetask = nil
    if inst.isfloating then
        inst.AnimState:PlayAnimation("proximity_loop", true)
        if not inst.SoundEmitter:PlayingSound("idlesound") then
            inst.SoundEmitter:PlaySound("dontstarve/common/together/book_maxwell/active_LP", "idlesound")
            inst.SoundEmitter:SetVolume("idlesound", .5)
        end
    else
        inst.AnimState:PushAnimation("proximity_pst")
        inst.AnimState:PushAnimation("idle", false)
    end
end

local function onuse(inst, hasfx)
    inst.AnimState:PlayAnimation("use")
    if hasfx then
        inst.AnimState:Show("FX")
    else
        inst.AnimState:Hide("FX")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/together/book_maxwell/use")
    if inst._activetask ~= nil then
        inst._activetask:Cancel()
    end
    inst._activetask = inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), doneact)
end

local function onactivate(inst)
    if not inst.isfloating then
        return
    end
    onuse(inst, true)
end

local function PrefabPostInitFn(inst)
    inst:AddTag("prototyper")

    inst:AddComponent("prototyper")
    inst.components.prototyper.restrictedtag = "musha"
    inst.components.prototyper.onactivate = onactivate
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.WAXWELLJOURNAL
end

AddPrefabPostInit("waxwelljournal", PrefabPostInitFn)
