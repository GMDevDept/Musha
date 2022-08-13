---@diagnostic disable: need-check-nil
-- Add customized states to SGwison and SGwilson_client

---------------------------------------------------------------------------------------------------------

-- Smite
local musha_smite = State {
    name = "musha_smite",
    tags = { "attack", "notalking", "abouttoattack", "autopredict" },

    onenter = function(inst)
        if inst.components.combat:InCooldown() then
            inst.sg:RemoveStateTag("abouttoattack")
            inst:ClearBufferedAction()
            inst.sg:GoToState("idle", true)
            return
        end
        if inst.sg.laststate == inst.sg.currentstate then
            inst.sg.statemem.chained = true
        end
        local buffaction = inst:GetBufferedAction()
        local target = buffaction ~= nil and buffaction.target or nil
        local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        inst.components.combat:SetTarget(target)
        inst.components.combat:StartAttack()
        inst.components.locomotor:Stop()
        local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES
        if inst.components.rider:IsRiding() then
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", false)
            DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
            cooldown = math.max(cooldown, 16 * FRAMES)
        else
            inst.AnimState:PlayAnimation("pickaxe_pre")
            inst.AnimState:PushAnimation("pickaxe_loop", false)
            if equip and equip:HasTag("phoenix_axe") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff", nil, nil, true)
            else
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff", nil, nil, true)
            end
            cooldown = math.max(cooldown, 24 * FRAMES)
        end

        inst.sg:SetTimeout(cooldown)

        if target ~= nil then
            inst.components.combat:BattleCry()
            if target:IsValid() then
                inst:FacePoint(target:GetPosition())
                inst.sg.statemem.attacktarget = target
                inst.sg.statemem.retarget = target
            end
        end
    end,

    timeline =
    {
        TimeEvent(18 * FRAMES, function(inst)
            inst:PerformBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end),
    },


    ontimeout = function(inst)
        inst.sg:RemoveStateTag("attack")
        inst.sg:AddStateTag("idle")
    end,

    events =
    {
        EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.AnimState:PlayAnimation("pickaxe_pst")
                inst.sg:GoToState("idle", true)
            end
        end),
    },

    onexit = function(inst)
        inst.components.combat:SetTarget(nil)
        if inst.sg:HasStateTag("abouttoattack") then
            inst.components.combat:CancelAttack()
        end
    end,
}

-- Smite client
local musha_smite_client = State {
    name = "musha_smite_client",
    tags = { "attack", "notalking", "abouttoattack" },

    onenter = function(inst)
        local buffaction = inst:GetBufferedAction()
        local cooldown = 0
        if inst.replica.combat ~= nil then
            if inst.replica.combat:InCooldown() then
                inst.sg:RemoveStateTag("abouttoattack")
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle", true)
                return
            end
            inst.replica.combat:StartAttack()
            cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
        end
        if inst.sg.laststate == inst.sg.currentstate then
            inst.sg.statemem.chained = true
        end
        inst.components.locomotor:Stop()
        local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        local rider = inst.replica.rider
        if rider ~= nil and rider:IsRiding() then
            inst.AnimState:PlayAnimation("atk_pre")
            inst.AnimState:PushAnimation("atk", false)
            DoMountSound(inst, rider:GetMount(), "angry")
            if cooldown > 0 then
                cooldown = math.max(cooldown, 16 * FRAMES)
            end
        else
            inst.AnimState:PlayAnimation("pickaxe_pre")
            inst.AnimState:PushAnimation("pickaxe_loop", false)
            if equip and equip:HasTag("phoenix_axe") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff", nil, nil, true)
            else
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff", nil, nil, true)
            end
            if cooldown > 0 then
                cooldown = math.max(cooldown, 24 * FRAMES)
            end
        end

        if buffaction ~= nil then
            inst:PerformPreviewBufferedAction()

            if buffaction.target ~= nil and buffaction.target:IsValid() then
                inst:FacePoint(buffaction.target:GetPosition())
                inst.sg.statemem.attacktarget = buffaction.target
                inst.sg.statemem.retarget = buffaction.target
            end
        end

        if cooldown > 0 then
            inst.sg:SetTimeout(cooldown)
        end
    end,

    timeline =
    {
        TimeEvent(18 * FRAMES, function(inst)
            inst:ClearBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end),
    },

    ontimeout = function(inst)
        inst.sg:RemoveStateTag("attack")
        inst.sg:AddStateTag("idle")
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.AnimState:PlayAnimation("pickaxe_pst")
                inst.sg:GoToState("idle", true)
            end
        end),
    },

    onexit = function(inst)
        if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
            inst.replica.combat:CancelAttack()
        end
    end,
}

AddStategraphState("wilson", musha_smite)
AddStategraphState("wilson_client", musha_smite_client)

-- Redefine action handlers
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTACK,
    function(inst, action)
        inst.sg.mem.localchainattack = not action.forced or nil
        if not
            (
            inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or
                inst.components.health:IsDead()) then
            local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
            return (weapon == nil and "attack")
                or (weapon:HasTag("blowdart") and "blowdart")
                or (weapon:HasTag("slingshot") and "slingshot_shoot")
                or (weapon:HasTag("thrown") and "throw")
                or (weapon:HasTag("propweapon") and "attack_prop_pre")
                or (weapon:HasTag("multithruster") and "multithrust_pre")
                or (weapon:HasTag("helmsplitter") and "helmsplitter_pre")
                or (weapon:HasTag("attackmodule_smite") and "musha_smite")
                or "attack"
        end
    end)
)

AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.ATTACK,
    function(inst, action)
        if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or IsEntityDead(inst)) then
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equip == nil then
                return "attack"
            end
            local inventoryitem = equip.replica.inventoryitem
            return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
                or (equip:HasTag("blowdart") and "blowdart")
                or (equip:HasTag("slingshot") and "slingshot_shoot")
                or (equip:HasTag("thrown") and "throw")
                or (equip:HasTag("propweapon") and "attack_prop_pre")
                or (equip:HasTag("attackmodule_smite") and "musha_smite_client")
                or "attack"
        end
    end)
)

---------------------------------------------------------------------------------------------------------

-- On entering berserk mode
local ActivateBerserkAOE = function(target, inst)
    target.components.combat:GetAttacked(inst,
        TUNING.musha.activateberserkbasedamage + 5 * math.floor(inst.components.leveler.lvl / 5),
        inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
end

local musha_berserk_pre = State {
    name = "musha_berserk_pre",
    tags = { "busy", "nomorph", "nointerrupt" },

    onenter = function(inst)
        if inst.mode:value() ~= 3 then -- Set invincible if transform form other mode, else super armor only
            inst.components.health:SetInvincible(true)
        end
        inst.SoundEmitter:PlaySound("dontstarve/charlie/warn")
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("emoteXL_angry")
    end,

    timeline =
    {
        TimeEvent(15 * FRAMES, function(inst)
            CustomDoAOE(inst, 3, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield1", nil, Vector3(2, 2, 2), Vector3(0, -2, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(21 * FRAMES, function(inst)
            CustomDoAOE(inst, 4, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield2", nil, Vector3(3, 3, 3), Vector3(0, -3, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(27 * FRAMES, function(inst)
            CustomDoAOE(inst, 5, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield3", nil, Vector3(3.5, 3.5, 3.5), Vector3(0, -4, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(31 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/werepig/howl")
            inst.mode:set(3)
            CustomDoAOE(inst, 6, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield4", nil, Vector3(4, 4, 4), Vector3(0, -5, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(33 * FRAMES, function(inst)
            CustomDoAOE(inst, 8, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield5", nil, Vector3(4.5, 4.5, 4.5), Vector3(0, -5.75, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(35 * FRAMES, function(inst)
            CustomDoAOE(inst, 10, { "_combat" }, { "player", "companion", "musha_companion" },
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield6", nil, Vector3(5, 5, 5), Vector3(0, -6.5, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            inst.sg:GoToState("idle", true)
            inst.components.health:SetInvincible(false)
        end),
    },

    onexit = function(inst)
        inst.components.health:SetInvincible(false)
    end,
}

-- Client
local musha_berserk_pre_client = State {
    name = "musha_berserk_pre_client",
    tags = { "busy", "nomorph", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("emoteXL_angry")
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            inst.sg:GoToState("idle", true)
        end),
    }
}

AddStategraphState("wilson", musha_berserk_pre)
AddStategraphState("wilson_client", musha_berserk_pre_client)

AddStategraphEvent("wilson", EventHandler("activateberserk",
    function(inst, data)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("musha_berserk_pre")
        end
    end)
)

AddStategraphEvent("wilson_client", EventHandler("activateberserk",
    function(inst, data)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("musha_berserk_pre_client")
        end
    end)
)

---------------------------------------------------------------------------------------------------------

-- Mana spell
local BOOK_LAYERS = {
    "FX_tentacles",
    "FX_fish",
    "FX_plants",
    "FX_plants_big",
    "FX_plants_small",
    "FX_lightning",
    "FX_roots",
}

local musha_spell = State {
    name = "musha_spell",
    tags = { "doing", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("book", false)

        local book = inst.bufferedbookfx or nil
        if book ~= nil then
            if book.def ~= nil then
                if book.def.fx ~= nil then
                    inst.sg.statemem.success_fx = book.def.fx
                end

                if book.def.layer ~= nil then
                    for i, v in ipairs(BOOK_LAYERS) do
                        if book.def.layer == v then
                            inst.AnimState:Show(v)
                        else
                            inst.AnimState:Hide(v)
                        end
                    end

                    inst.sg.statemem.book_layer = book.def.layer
                end

                if book.def.layer_sound ~= nil then
                    --track and manage via soundtask and sound name (even though it is not a loop)
                    --so we can handle interruptions to this state
                    local frame = book.def.layer_sound.frame or 0
                    if frame > 0 then
                        inst.sg.statemem.soundtask = inst:DoTaskInTime(frame * FRAMES, function(inst)
                            inst.sg.statemem.soundtask = nil
                            inst.SoundEmitter:KillSound("book_layer_sound")
                            inst.SoundEmitter:PlaySound(book.def.layer_sound.sound, "book_layer_sound")
                        end)
                    else
                        inst.SoundEmitter:KillSound("book_layer_sound")
                        inst.SoundEmitter:PlaySound(book.def.layer_sound.sound, "book_layer_sound")
                    end
                end
            end

            local swap_build = book.swap_build
            local swap_prefix = book.swap_prefix or "book"
            if swap_build ~= nil then
                inst.AnimState:OverrideSymbol("book_open", swap_build, swap_prefix .. "_open")
                inst.AnimState:OverrideSymbol("book_closed", swap_build, swap_prefix .. "_closed")
                inst.sg.statemem.symbolsoverridden = true
            end
        end

        inst.sg.statemem.castsound = book ~= nil and book.castsound or "dontstarve/common/book_spell"
    end,

    timeline =
    {
        TimeEvent(0, function(inst)
            inst.sg.statemem.book_fx = SpawnPrefab(inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx")
            inst.sg.statemem.book_fx.entity:SetParent(inst.entity)
            inst.sg.statemem.book_fx.Transform:SetPosition(0, .2, 0)
        end),
        TimeEvent(28 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
        end),
        TimeEvent(54 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
        end),
        TimeEvent(58 * FRAMES, function(inst)
            inst[inst.bufferedspell](inst)
            CustomAttachFx(inst, inst.sg.statemem.success_fx)
            inst.SoundEmitter:PlaySound(inst.sg.statemem.castsound)
            inst.sg.statemem.book_fx = nil --Don't cancel anymore
        end)
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.symbolsoverridden then
            inst.AnimState:OverrideSymbol("book_open", "player_actions_uniqueitem", "book_open")
            inst.AnimState:OverrideSymbol("book_closed", "player_actions_uniqueitem", "book_closed")
        end
        if inst.sg.statemem.book_fx ~= nil and inst.sg.statemem.book_fx:IsValid() then
            inst.sg.statemem.book_fx:Remove()
        end
        if inst.sg.statemem.book_layer ~= nil then
            if type(inst.sg.statemem.book_layer) == "table" then
                for i, v in ipairs(inst.sg.statemem.book_layer) do
                    inst.AnimState:Hide(v)
                end
            else
                inst.AnimState:Hide(inst.sg.statemem.book_layer)
            end
        end
        if inst.sg.statemem.soundtask ~= nil then
            inst.sg.statemem.soundtask:Cancel()
        elseif inst.SoundEmitter:PlayingSound("book_layer_sound") then
            inst.SoundEmitter:SetVolume("book_layer_sound", .5)
        end

        inst.sg.statemem.success_fx = nil
        inst.bufferedspell = nil
        inst.bufferedbookfx = nil
    end,
}

local musha_spell_client = State {
    name = "musha_spell_client",
    tags = { "doing", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst:HasTag("doing") then
            if inst.entity:FlattenMovementPrediction() then
                inst.sg:GoToState("idle", "noanim")
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", musha_spell)
AddStategraphState("wilson_client", musha_spell_client)

AddStategraphEvent("wilson", EventHandler("castmanaspell",
    function(inst, data)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("musha_spell")
        else
            inst.bufferedspell = nil
            inst.bufferedbookfx = nil
        end
    end)
)

AddStategraphEvent("wilson_client", EventHandler("castmanaspell",
    function(inst, data)
        if not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("musha_spell_client")
        end
    end)
)

---------------------------------------------------------------------------------------------------------
