local function PrefabPostInitFn(inst)
    local function SetDirty(netvar, val)
        --Forces a netvar to be dirty regardless of value
        netvar:set_local(val)
        netvar:set(val)
    end

    local function OnManaDelta(parent, data)
        if data.newpercent > data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.ismanapulseup, true)
        elseif data.newpercent < data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.ismanapulsedown, true)
        end
    end

    local function OnManaDirty(inst)
        if inst._parent ~= nil then
            local oldpercent = inst._oldmanapercent
            local percent = inst.currentmana:value() / inst.maxmana:value()
            local data =
            {
                oldpercent = oldpercent,
                newpercent = percent,
                overtime =
                not (inst.ismanapulseup:value() and percent > oldpercent) and
                    not (inst.ismanapulsedown:value() and percent < oldpercent),
            }
            inst._oldmanapercent = percent
            inst.ismanapulseup:set_local(false)
            inst.ismanapulsedown:set_local(false)
            inst._parent:PushEvent("manadelta", data)
            if oldpercent > 0 then
                if percent <= 0 then
                    inst._parent:PushEvent("startmanadepleted")
                end
            elseif percent > 0 then
                inst._parent:PushEvent("stopmanadepleted")
            end
        else
            inst._oldmanapercent = 1
            inst.ismanapulseup:set_local(false)
            inst.ismanapulsedown:set_local(false)
        end
    end

    local function OnLevelerDelta(parent, data)
        -- Reserved for possible future use (e.g. exp badge and level up animation)
    end

    local function OnLevelerDirty(inst)
        if inst._parent ~= nil then
            local data = nil -- Reserved for possible future use
            inst._parent:PushEvent("levelerdelta", data)
        end
    end

    local function OnStaminaDelta(parent, data)
        if data.newpercent > data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.isstaminaup, true)
        elseif data.newpercent < data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.isstaminadown, true)
        end
    end

    local function OnStaminaDirty(inst)
        if inst._parent ~= nil then
            local oldpercent = inst._oldstaminapercent
            local percent = inst.currentstamina:value() / inst.maxstamina:value()
            local data =
            {
                oldpercent = oldpercent,
                newpercent = percent,
                overtime =
                not (inst.isstaminaup:value() and percent > oldpercent) and
                    not (inst.isstaminadown:value() and percent < oldpercent),
            }
            inst._oldstaminapercent = percent
            inst.isstaminaup:set_local(false)
            inst.isstaminadown:set_local(false)
            inst._parent:PushEvent("staminadelta", data)
            if oldpercent > 0 then
                if percent <= 0 then
                    inst._parent:PushEvent("startstaminadepleted")
                end
            elseif percent > 0 then
                inst._parent:PushEvent("stopstaminadepleted")
            end
        else
            inst._oldstaminapercent = 1
            inst.isstaminaup:set_local(false)
            inst.isstaminadown:set_local(false)
        end
    end

    local function OnFatigueDelta(parent, data)
        if data.newpercent > data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.isfatigueup, true)
        elseif data.newpercent < data.oldpercent then
            --Force dirty, we just want to trigger an event on the client
            SetDirty(parent.player_classified.isfatiguedown, true)
        end
    end

    local function OnFatigueDirty(inst)
        if inst._parent ~= nil then
            local oldpercent = inst._oldfatiguepercent
            local percent = inst.currentfatigue:value() / inst.maxfatigue:value()
            local data =
            {
                oldpercent = oldpercent,
                newpercent = percent,
                overtime =
                not (inst.isfatigueup:value() and percent > oldpercent) and
                    not (inst.isfatiguedown:value() and percent < oldpercent),
            }
            inst._oldfatiguepercent = percent
            inst.isfatigueup:set_local(false)
            inst.isfatiguedown:set_local(false)
            inst._parent:PushEvent("fatiguedelta", data)
            if oldpercent > 0 then
                if percent <= 0 then
                    inst._parent:PushEvent("startfatiguedepleted")
                end
            elseif percent > 0 then
                inst._parent:PushEvent("stopfatiguedepleted")
            end
        else
            inst._oldfatiguepercent = 0
            inst.isfatigueup:set_local(false)
            inst.isfatiguedown:set_local(false)
        end
    end

    _OnEntityReplicated = inst.OnEntityReplicated
    local function OnEntityReplicated(inst)
        inst._parent = inst.entity:GetParent()
        if inst._parent then
            inst._parent:AttachClassified(inst)
            if inst._parent.replica.leveler ~= nil then
                inst._parent.replica.leveler:AttachClassified(inst)
            end
            if inst._parent.replica.mana ~= nil then
                inst._parent.replica.mana:AttachClassified(inst)
            end
            if inst._parent.replica.stamina ~= nil then
                inst._parent.replica.stamina:AttachClassified(inst)
            end
            if inst._parent.replica.fatigue ~= nil then
                inst._parent.replica.fatigue:AttachClassified(inst)
            end
        end
        return _OnEntityReplicated(inst)
    end

    --------------------------------------------------------------------------

    local function RegisterNetListeners(inst)
        if TheWorld.ismastersim then
            inst._parent = inst.entity:GetParent()
            inst:ListenForEvent("manadelta", OnManaDelta, inst._parent)
            inst:ListenForEvent("levelerdelta", OnLevelerDelta, inst._parent)
            inst:ListenForEvent("staminadelta", OnStaminaDelta, inst._parent)
            inst:ListenForEvent("fatiguedelta", OnFatigueDelta, inst._parent)
        else
            inst.ismanapulseup:set_local(false)
            inst.ismanapulsedown:set_local(false)
            inst:ListenForEvent("manadirty", OnManaDirty)
            inst:ListenForEvent("levelerdirty", OnLevelerDirty)
            inst:ListenForEvent("staminadirty", OnStaminaDirty)
            inst:ListenForEvent("fatiguedirty", OnFatigueDirty)

            if inst._parent ~= nil then
                inst._oldmanapercent = inst.maxmana:value() > 0 and inst.currentmana:value() / inst.maxmana:value()
                    or 0
            end
        end
    end

    --------------------------------------------------------------------------

    --Net variables for leveler
    inst.maxexperience = net_ushortint(inst.GUID, "leveler.maxexp", "levelerdirty")
    inst.maxlevel = net_ushortint(inst.GUID, "leveler.maxlvl", "levelerdirty")
    inst.experience = net_ushortint(inst.GUID, "leveler.exp", "levelerdirty")
    inst.level = net_ushortint(inst.GUID, "leveler.lvl", "levelerdirty")
    inst.maxexperience:set(0)
    inst.maxlevel:set(30)
    inst.experience:set(0)
    inst.level:set(0)

    --Net variables for mana
    inst._oldmanapercent = 1
    inst.currentmana = net_ushortint(inst.GUID, "mana.current", "manadirty")
    inst.maxmana = net_ushortint(inst.GUID, "mana.max", "manadirty")
    inst.manaratelevel = net_tinybyte(inst.GUID, "mana.ratelevel")
    inst.ismanapulseup = net_bool(inst.GUID, "mana.dodeltaovertime(up)", "manadirty")
    inst.ismanapulsedown = net_bool(inst.GUID, "mana.dodeltaovertime(down)", "manadirty")
    inst.currentmana:set(50)
    inst.maxmana:set(50)

    --Net variables for fatigue
    inst._oldfatiguepercent = 0
    inst.currentfatigue = net_ushortint(inst.GUID, "fatigue.current", "fatiguedirty")
    inst.maxfatigue = net_ushortint(inst.GUID, "fatigue.max", "fatiguedirty")
    inst.fatigueratelevel = net_tinybyte(inst.GUID, "fatigue.ratelevel")
    inst.isfatigueup = net_bool(inst.GUID, "fatigue.dodeltaovertime(up)", "fatiguedirty")
    inst.isfatiguedown = net_bool(inst.GUID, "fatigue.dodeltaovertime(down)", "fatiguedirty")
    inst.currentfatigue:set(0)
    inst.maxfatigue:set(100)

    --Net variables for stamina
    inst._oldstaminapercent = 1
    inst.currentstamina = net_ushortint(inst.GUID, "stamina.current", "staminadirty")
    inst.maxstamina = net_ushortint(inst.GUID, "stamina.max", "staminadirty")
    inst.staminaratelevel = net_tinybyte(inst.GUID, "stamina.ratelevel")
    inst.isstaminaup = net_bool(inst.GUID, "stamina.dodeltaovertime(up)", "staminadirty")
    inst.isstaminadown = net_bool(inst.GUID, "stamina.dodeltaovertime(down)", "staminadirty")
    inst.currentstamina:set(100)
    inst.maxstamina:set(100)

    --Delay net listeners until after initial values are deserialized
    inst:DoStaticTaskInTime(0, RegisterNetListeners)

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated
    end
end

AddPrefabPostInit("player_classified", PrefabPostInitFn)
