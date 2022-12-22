---@diagnostic disable: need-check-nil, undefined-field
-- Add customized states to SGwison and SGwilson_client

local UserCommands = require("usercommands")

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local function ApplyPhantom(inst, anim)
    local dt = inst.AnimState:GetCurrentAnimationTime()
    local fx_phantom = SpawnPrefab("musha_phantom")
    fx_phantom.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx_phantom.Transform:SetRotation(inst.Transform:GetRotation())
    fx_phantom.AnimState:SetMultColour(math.min(3 * dt, 1), math.min(2 * dt + 0.4, 1), 1, math.min(3 * dt, 1))
    fx_phantom.AnimState:PlayAnimation(anim)
    fx_phantom.AnimState:SetTime(dt)
    fx_phantom:DoTaskInTime(10 * FRAMES, function()
        fx_phantom:Remove()
    end)
end

---------------------------------------------------------------------------------------------------------

-- No interrupt states exclusively for Musha

-- Frozen
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["frozen"].onenter
    self.states["frozen"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
        end
        _onenter(inst)
    end
end)

-- Thaw
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["thaw"].onenter
    self.states["thaw"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
        end
        _onenter(inst)
    end
end)

---------------------------------------------------------------------------------------------------------

-- Add magpie step cast window after attacking or being attacked

AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["attack"].onenter
    self.states["attack"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst:DoTaskInTime(8 * FRAMES, function() -- ? Seems to be not necessary to cancel task on new state
                inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
            end)
        end
        _onenter(inst)
    end
end)

AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["hit"].onenter
    self.states["hit"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
        end
        _onenter(inst)
    end
end)

---------------------------------------------------------------------------------------------------------

-- Sleep related

-- Common function
local function SleepDeclaration(inst, quality) -- poor, good, perfect
    inst.task_sleepdeclaration = inst:DoPeriodicTask(4, function()
        if inst.sg:HasStateTag("sleeping") then
            local declaration = STRINGS.musha.sleep.declarations.quality.string
                .. STRINGS.musha.sleep.declarations.quality[quality] .. "\n"
                .. STRINGS.musha.sleep.declarations.fatigue.string1
                .. math.floor(inst.components.fatigue:GetPercent() * 100)
                .. STRINGS.musha.sleep.declarations.fatigue.string2 .. "\n"
                .. STRINGS.musha.sleep.declarations.melody.string1
                .. math.floor(inst.components.melody:GetPercent() * 100)
                .. STRINGS.musha.sleep.declarations.melody.string2 .. "\n"

            inst.components.talker:StopIgnoringAll("sleeping")
            inst.components.talker:Say(declaration) -- Note: Talker:Say(script, duration, noanim, force...
        end
    end, 0)
end

-- Knockout
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["knockout"].onenter
    self.states["knockout"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
            inst.components.talker:Say(STRINGS.musha.sleep.poor[math.random(#STRINGS.musha.sleep.poor)])
            SleepDeclaration(inst, "poor")
        end
        _onenter(inst)
        if inst:HasTag("musha") then
            inst.components.grue:RemoveImmunity("sleeping")
        end
    end

    local _onexit = self.states["knockout"].onexit
    self.states["knockout"].onexit = function(inst)
        CustomCancelTask(inst.task_sleepdeclaration)
        _onexit(inst)
    end
end)

-- Bedroll
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["bedroll"].onenter
    self.states["bedroll"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
            inst.components.talker:Say(STRINGS.musha.sleep.good[math.random(#STRINGS.musha.sleep.good)])
            SleepDeclaration(inst, "good")
        end
        _onenter(inst)
    end

    local _fn = self.states["bedroll"].events["animqueueover"].fn
    self.states["bedroll"].events["animqueueover"].fn = function(inst)
        if inst:HasTag("musha") and inst.AnimState:AnimDone()
            and not (TheWorld.state.isday or
                (inst.components.health ~= nil and inst.components.health.takingfiredamage) or
                (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()))
            and not inst:GetBufferedAction() then

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            inst.sg:AddStateTag("sleeping")
            inst.sg:AddStateTag("silentmorph")
            inst.sg:RemoveStateTag("nomorph")
            inst.sg:RemoveStateTag("busy")
            inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
        else
            return _fn(inst)
        end
    end

    local _onexit = self.states["bedroll"].onexit
    self.states["bedroll"].onexit = function(inst)
        CustomCancelTask(inst.task_sleepdeclaration)
        _onexit(inst)
    end
end)

-- Tent
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["tent"].onenter
    self.states["tent"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
            inst.components.talker:Say(STRINGS.musha.sleep.good[math.random(#STRINGS.musha.sleep.good)])
            SleepDeclaration(inst, "perfect")
        end
        _onenter(inst)
    end

    local _onexit = self.states["tent"].onexit
    self.states["tent"].onexit = function(inst)
        CustomCancelTask(inst.task_sleepdeclaration)
        _onexit(inst)
    end
end)

-- Wakeup
AddStategraphPostInit("wilson", function(self)
    local _onenter = self.states["wakeup"].onenter
    self.states["wakeup"].onenter = function(inst)
        if inst:HasTag("musha") then
            inst.sg:AddStateTag("musha_nointerrupt")
        end
        _onenter(inst)
    end

    local _events = self.states["wakeup"].events
    _events["musha_attacked"] = EventHandler("attacked", function(inst)
        if inst:HasTag("musha") then
            inst.sg:GoToState("hit")
        end
    end)

    local _onexit = self.states["wakeup"].onexit
    self.states["wakeup"].onexit = function(inst)
        if inst:HasTag("musha") then
            if inst.components.melody:IsFull() then
                inst.components.talker:Say(STRINGS.musha.skills.elfmelody.full)
                UserCommands.RunTextUserCommand("dance", inst, false)
            else
                inst.components.talker:Say(STRINGS.musha.sleep.wakeup[math.random(#STRINGS.musha.sleep.wakeup)])
            end
        end
        _onexit(inst)
    end
end)

---------------------------------------------------------------------------------------------------------

-- Smite

local function DoMountSound(inst, mount, sound, ispredicted)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, ispredicted)
    end
end

local musha_smite = State {
    name = "musha_smite",
    tags = { "musha_smite", "attack", "notalking", "abouttoattack", "autopredict" },

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
            if equip and equip:HasTag("frosthammer") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_icestaff", nil, nil, true)
            else
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_firestaff", nil, nil, true)
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
            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
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
    name = "musha_smite",
    tags = { "musha_smite", "attack", "notalking", "abouttoattack" },

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
            DoMountSound(inst, rider:GetMount(), "angry", true)
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

-- Redefine attack action handlers
AddStategraphPostInit("wilson", function(self)
    local _deststate = self.actionhandlers[ACTIONS.ATTACK].deststate
    self.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action)
        local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon()
        if weapon and weapon:HasTag("attackmodule_smite") and _deststate(inst, action) == "attack" then
            return "musha_smite"
        else
            return _deststate(inst, action)
        end
    end
end)

AddStategraphPostInit("wilson_client", function(self)
    local _deststate = self.actionhandlers[ACTIONS.ATTACK].deststate
    self.actionhandlers[ACTIONS.ATTACK].deststate = function(inst, action)
        local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if weapon and weapon:HasTag("attackmodule_smite") and _deststate(inst, action) == "attack" then
            return "musha_smite"
        else
            return _deststate(inst, action)
        end
    end
end)

---------------------------------------------------------------------------------------------------------

-- On entering berserk mode
local ActivateBerserkAOE = function(target, inst)
    target.components.combat:GetAttacked(inst,
        TUNING.musha.activateberserkbasedamage + 5 * math.floor(inst.components.leveler.lvl / 5),
        inst.components.combat:GetWeapon()) -- Note: Combat:GetAttacked(attacker, damage, weapon, stimuli)
end

local function ShadowSpellOnTimerDone(inst, data)
    if data.name == "cooldown_shadowspell" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.manaspells.shadowspell.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", ShadowSpellOnTimerDone)
    end
end

local musha_berserk_pre = State {
    name = "musha_berserk_pre",
    tags = { "musha_berserk_pre", "doing", "busy", "nomorph", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst)
        inst.components.playercontroller:Enable(false)
        inst.components.health:SetInvincible(true)
        inst.SoundEmitter:PlaySound("dontstarve/charlie/warn")
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("emoteXL_angry")
    end,

    timeline =
    {
        TimeEvent(15 * FRAMES, function(inst)
            ShakeAllCameras(CAMERASHAKE.FULL, 1, .02, .5, inst, 40)
            CustomDoAOE(inst, 3, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield1", nil, Vector3(2, 2, 2), Vector3(0, -2, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(21 * FRAMES, function(inst)
            CustomDoAOE(inst, 4, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield2", nil, Vector3(3, 3, 3), Vector3(0, -3, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(27 * FRAMES, function(inst)
            CustomDoAOE(inst, 5, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield3", nil, Vector3(3.5, 3.5, 3.5), Vector3(0, -4, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(31 * FRAMES, function(inst)
            inst.mode:set(3)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/vargr/howl")
            CustomDoAOE(inst, 6, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield4", nil, Vector3(4, 4, 4), Vector3(0, -5, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(33 * FRAMES, function(inst)
            CustomDoAOE(inst, 8, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
                function(target)
                    ActivateBerserkAOE(target, inst)
                end)
            CustomAttachFx(inst, "shadow_shield5", nil, Vector3(4.5, 4.5, 4.5), Vector3(0, -5.75, 0))
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        end),
        TimeEvent(35 * FRAMES, function(inst)
            CustomDoAOE(inst, 10, { "_combat" }, { "player", "companion", "musha_companion" }, nil,
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
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle", true)
            end
        end),
    },

    onexit = function(inst)
        inst.components.health:SetInvincible(false)
        inst.components.playercontroller:Enable(true)
        inst.components.timer:StartTimer("cooldown_shadowspell", TUNING.musha.skills.shadowspell.cooldown)
        inst:ListenForEvent("timerdone", ShadowSpellOnTimerDone)
    end,
}

-- Client
local musha_berserk_pre_client = State {
    name = "musha_berserk_pre",
    tags = { "musha_berserk_pre", "doing", "busy", "nomorph", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("emoteXL_angry")
    end,

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    }
}

AddStategraphState("wilson", musha_berserk_pre)
AddStategraphState("wilson_client", musha_berserk_pre_client)

AddStategraphEvent("wilson", EventHandler("activateberserk",
    function(inst)
        inst.sg:GoToState("musha_berserk_pre")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("activateberserk",
    function(inst)
        inst.sg:GoToState("musha_berserk_pre")
    end)
)

---------------------------------------------------------------------------------------------------------

-- Mana spell
local musha_spell = State {
    name = "musha_spell",
    tags = { "musha_spell", "doing", "nomorph", "nointerrupt" },

    onenter = function(inst)
        if inst.bufferedspell == "SetShieldDurability" then
            inst.sg:AddStateTag("busy")
            inst.sg:AddStateTag("nopredict")
            inst.sg:AddStateTag("musha_nointerrupt")
        end

        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("book", false)

        local book = inst.bufferedbookfx
        if book ~= nil then
            if book.def ~= nil then
                inst.sg.statemem.fx_over_prefab = book.def.fx_over_prefab
                inst.sg.statemem.fx_under_prefab = book.def.fx_under_prefab

                local suffix = inst.components.rider:IsRiding() and "_mount" or ""
                if inst.sg.statemem.fx_over_prefab ~= nil then
                    inst.sg.statemem.fx_over = SpawnPrefab(inst.sg.statemem.fx_over_prefab .. suffix)
                    inst.sg.statemem.fx_over.entity:SetParent(inst.entity)
                    inst.sg.statemem.fx_over.Follower:FollowSymbol(inst.GUID, "swap_book_fx_over", 0, 0, 0, true)
                end
                if inst.sg.statemem.fx_under_prefab ~= nil then
                    inst.sg.statemem.fx_under = SpawnPrefab(inst.sg.statemem.fx_under_prefab .. suffix)
                    inst.sg.statemem.fx_under.entity:SetParent(inst.entity)
                    inst.sg.statemem.fx_under.Follower:FollowSymbol(inst.GUID, "swap_book_fx_under", 0, 0, 0, true)
                end

                if book.def.fx ~= nil then
                    inst.sg.statemem.success_fx = book.def.fx
                end

                if book.def.layer_sound ~= nil then
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

        inst.sg.statemem.castsound = book ~= nil and book.castsound ~= nil and book.castsound
            or "dontstarve/common/book_spell"
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
            if inst.bufferedspell and inst[inst.bufferedspell] then
                inst[inst.bufferedspell](inst)
            end
            if inst.sg.statemem.success_fx then
                CustomAttachFx(inst, inst.sg.statemem.success_fx)
            end
            inst.SoundEmitter:PlaySound(inst.sg.statemem.castsound)
            inst.sg.statemem.book_fx = nil --Don't cancel anymore

            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
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
        if inst.sg.statemem.fx_over ~= nil and inst.sg.statemem.fx_over:IsValid() then
            inst.sg.statemem.fx_over:Remove()
        end
        if inst.sg.statemem.fx_under ~= nil and inst.sg.statemem.fx_under:IsValid() then
            inst.sg.statemem.fx_under:Remove()
        end
        if inst.sg.statemem.soundtask ~= nil then
            inst.sg.statemem.soundtask:Cancel()
        elseif inst.SoundEmitter:PlayingSound("book_layer_sound") then
            inst.SoundEmitter:SetVolume("book_layer_sound", .5)
        end

        inst.bufferedspell = nil
        inst.bufferedbookfx = nil
    end,
}

local musha_spell_client = State {
    name = "musha_spell",
    tags = { "musha_spell", "doing", "nomorph", "nointerrupt" },

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
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", musha_spell)
AddStategraphState("wilson_client", musha_spell_client)

AddStategraphEvent("wilson", EventHandler("castmanaspell",
    function(inst)
        inst.sg:GoToState("musha_spell")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("castmanaspell",
    function(inst)
        inst.sg:GoToState("musha_spell")
    end)
)

---------------------------------------------------------------------------------------------------------

-- Play elf melody

local musha_elfmelody_full = State {
    name = "musha_elfmelody_full",
    tags = { "musha_elfmelody", "doing", "playing", "canrotate", "nomorph", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:Hide("ARM_carry")
        inst.AnimState:Show("ARM_normal")
        inst.AnimState:OverrideSymbol("pan_flute01", "pan_flute", "pan_flute01")
        inst.AnimState:OverrideSymbol("hound_whistle01", "houndwhistle", "hound_whistle01")
        inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
        inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("whistle", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband1_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pst", false)
        inst.AnimState:PushAnimation("idle_onemanband2_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband2_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband2_pst", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("bell", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("horn", false)
    end,

    timeline =
    {
        TimeEvent(1 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(33 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/flute_LP", "flute")
        end),
        TimeEvent(85 * FRAMES, function(inst)
            inst.SoundEmitter:KillSound("flute")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(95 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(105 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(115 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(140 * FRAMES, function(inst)
            inst.Light:SetRadius(2)
            inst.Light:Enable(true)
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
            inst.SoundEmitter:PlaySound("dontstarve/common/together/houndwhistle")
        end),
        TimeEvent(170 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(175 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(180 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(190 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(220 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/flute_LP", "flute")
        end),
        TimeEvent(275 * FRAMES, function(inst)
            inst.components.melody:SetPercent(0)
            inst.sg:AddStateTag("busy")
            inst.sg:AddStateTag("musha_nointerrupt")
            inst.SoundEmitter:KillSound("flute")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(290 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(295 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(300 * FRAMES, function(inst)
            inst.AnimState:OverrideSymbol("swap_body_tall", "armor_onemanband", "swap_body_tall")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(305 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(310 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(315 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(325 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(335 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(345 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(350 * FRAMES, function(inst)
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
            inst.SoundEmitter:PlaySound("dontstarve/common/together/houndwhistle")
        end),
        TimeEvent(355 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(360 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/together/houndwhistle")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(365 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(370 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/together/houndwhistle")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(375 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(390 * FRAMES, function(inst)
            inst.AnimState:ClearOverrideSymbol("swap_body_tall")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(420 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/flute_LP", "flute")
        end),
        TimeEvent(475 * FRAMES, function(inst)
            inst.SoundEmitter:KillSound("flute")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(495 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(500 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(525 * FRAMES, function(inst)
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
        end),
        TimeEvent(590 * FRAMES, function(inst)
            inst:StartMelodyBuff({ mode = "full" })
        end),
        TimeEvent(605 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/horn_beefalo")
        end),
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
        inst.Light:Enable(false)
        inst.SoundEmitter:KillSound("flute")
        inst.AnimState:ClearOverrideSymbol("swap_body_tall")
        if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
            inst.AnimState:Show("ARM_carry")
            inst.AnimState:Hide("ARM_normal")
        end
    end,
}

local musha_elfmelody_full_client = State {
    name = "musha_elfmelody_full",
    tags = { "musha_elfmelody", "doing", "playing", "canrotate", "nomorph", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:OverrideSymbol("pan_flute01", "pan_flute", "pan_flute01")
        inst.AnimState:OverrideSymbol("hound_whistle01", "houndwhistle", "hound_whistle01")
        inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
        inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("whistle", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband1_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pst", false)
        inst.AnimState:PushAnimation("idle_onemanband2_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband2_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband2_pst", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("flute", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("bell", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("horn", false)
    end,

    timeline = {
        TimeEvent(275 * FRAMES, function(inst)
            inst.sg:AddStateTag("busy")
            inst.sg:AddStateTag("musha_nointerrupt")
        end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

AddStategraphState("wilson", musha_elfmelody_full)
AddStategraphState("wilson_client", musha_elfmelody_full_client)

AddStategraphEvent("wilson", EventHandler("playfullelfmelody",
    function(inst)
        inst.sg:GoToState("musha_elfmelody_full")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("playfullelfmelody",
    function(inst)
        inst.sg:GoToState("musha_elfmelody_full")
    end)
)

local musha_elfmelody_partial = State {
    name = "musha_elfmelody_partial",
    tags = { "musha_elfmelody", "doing", "playing", "canrotate", "nomorph", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:Hide("ARM_carry")
        inst.AnimState:Show("ARM_normal")
        inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
        inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("bell", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband1_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pst", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("horn", false)
    end,

    timeline =
    {
        TimeEvent(1 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(5 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(10 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(25 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
        end),
        TimeEvent(40 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(50 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(60 * FRAMES, function(inst)
            inst.Light:SetRadius(2)
            inst.Light:Enable(true)
            inst.components.melody:DoDelta(-TUNING.musha.skills.elfmelody.minrequired)
            inst.sg:AddStateTag("busy")
            inst.sg:AddStateTag("musha_nointerrupt")
            CustomAttachFx(inst, "balloonparty_confetti_cloud")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(70 * FRAMES, function(inst)
            inst.AnimState:OverrideSymbol("swap_body_tall", "armor_onemanband", "swap_body_tall")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(75 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(80 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(85 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(90 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(110 * FRAMES, function(inst)
            inst.AnimState:ClearOverrideSymbol("swap_body_tall")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(120 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end),
        TimeEvent(150 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/horn_beefalo")
        end),
        TimeEvent(155 * FRAMES, function(inst)
            inst:StartMelodyBuff({ mode = "partial" })
        end),
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
        inst.Light:Enable(false)
        inst.SoundEmitter:KillSound("flute")
        inst.AnimState:ClearOverrideSymbol("swap_body_tall")
        if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
            inst.AnimState:Show("ARM_carry")
            inst.AnimState:Hide("ARM_normal")
        end
    end,
}

local musha_elfmelody_partial_client = State {
    name = "musha_elfmelody_partial",
    tags = { "musha_elfmelody", "doing", "playing", "canrotate", "nomorph", "nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
        inst.AnimState:OverrideSymbol("horn01", "horn", "horn01")
        inst.AnimState:PlayAnimation("action_uniqueitem_pre")
        inst.AnimState:PushAnimation("bell", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pre", false)
        inst.AnimState:PushAnimation("idle_onemanband1_loop", false)
        inst.AnimState:PushAnimation("idle_onemanband1_pst", false)
        inst.AnimState:PushAnimation("action_uniqueitem_pre", false)
        inst.AnimState:PushAnimation("horn", false)
    end,

    timeline = {
        TimeEvent(60 * FRAMES, function(inst)
            inst.sg:AddStateTag("busy")
            inst.sg:AddStateTag("musha_nointerrupt")
        end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

AddStategraphState("wilson", musha_elfmelody_partial)
AddStategraphState("wilson_client", musha_elfmelody_partial_client)

AddStategraphEvent("wilson", EventHandler("playpartialelfmelody",
    function(inst)
        inst.sg:GoToState("musha_elfmelody_partial")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("playpartialelfmelody",
    function(inst)
        inst.sg:GoToState("musha_elfmelody_partial")
    end)
)

---------------------------------------------------------------------------------------------------------

-- Treasure sniffing

local musha_treasuresniffing = State {
    name = "musha_treasuresniffing",
    tags = { "musha_treasuresniffing", "doing" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if item then
            inst.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
            inst.components.inventory:GiveItem(item)
        end
        inst.AnimState:Show("ARM_carry")
        inst.AnimState:Hide("ARM_normal")
        inst.AnimState:OverrideSymbol("swap_object", "swap_telescope", "swap_object")
        inst.AnimState:OverrideSymbol("scroll", "messagebottle", "scroll")
        inst.AnimState:PlayAnimation("telescope")
        inst.AnimState:PushAnimation("telescope_pst", false)
        inst.AnimState:PushAnimation("scroll", false)
        inst.AnimState:PushAnimation("scroll_pst", false)
    end,

    timeline =
    {
        TimeEvent(2 * FRAMES, function(inst)
            inst.components.talker:Say(STRINGS.musha.skills.treasuresniffing.find)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        end),
        TimeEvent(20 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/blink")
        end),
        TimeEvent(100 * FRAMES, function(inst)
            inst.components.talker:Say(STRINGS.musha.skills.treasuresniffing.mark)
            inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
        end),
        TimeEvent(150 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
        end),
        TimeEvent(155 * FRAMES, function(inst)
            inst:SniffTreasure()
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:IsCurrentAnimation("scroll") then
                inst.AnimState:Hide("ARM_carry")
                inst.AnimState:Show("ARM_normal")
            end
        end),
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

local musha_treasuresniffing_client = State {
    name = "musha_treasuresniffing",
    tags = { "musha_treasuresniffing", "doing" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:Show("ARM_carry")
        inst.AnimState:Hide("ARM_normal")
        inst.AnimState:OverrideSymbol("swap_object", "swap_telescope", "swap_object")
        inst.AnimState:OverrideSymbol("scroll", "messagebottle", "scroll")
        inst.AnimState:PlayAnimation("telescope")
        inst.AnimState:PushAnimation("telescope_pst", false)
        inst.AnimState:PushAnimation("scroll", false)
        inst.AnimState:PushAnimation("scroll_pst", false)
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:IsCurrentAnimation("scroll") then
                inst.AnimState:Hide("ARM_carry")
                inst.AnimState:Show("ARM_normal")
            end
        end),
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

AddStategraphState("wilson", musha_treasuresniffing)
AddStategraphState("wilson_client", musha_treasuresniffing_client)

AddStategraphEvent("wilson", EventHandler("snifftreasure",
    function(inst)
        inst.sg:GoToState("musha_treasuresniffing")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("snifftreasure",
    function(inst)
        inst.sg:GoToState("musha_treasuresniffing")
    end)
)

---------------------------------------------------------------------------------------------------------

-- Setsu-Getsu-Ka

local function ClearSetsuGetsuKaCounter(inst, data)
    if data.name == "clearsetsugetsukacounter" then
        inst.setsugetsuka_counter = nil
        inst:RemoveEventCallback("timerdone", ClearSetsuGetsuKaCounter)
    end
end

local function SetsuGetsuKaOnTimerDone(inst, data)
    if data.name == "cooldown_setsugetsuka" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.setsugetsuka.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", SetsuGetsuKaOnTimerDone)
    end
end

local function DoThrust(inst, lightning, attachfx)
    local radius = TUNING.musha.skills.setsugetsuka.radius
    local must_tags = { "_combat" }
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player",
        "companion", "musha_companion" }
    local target = FindEntity(inst, radius, nil, must_tags, ignore_tags)
    local weapon = inst.sg.statemem.weapon

    if target ~= nil then
        local damage = inst.components.combat:CalcDamage(target, weapon) *
            TUNING.musha.skills.setsugetsuka.damagemultiplier

        if lightning then
            local extradamage = (TUNING.musha.skills.lightningstrike.damage +
                TUNING.musha.skills.lightningstrike.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5) *
                TUNING.musha.skills.setsugetsuka.damagemultiplier
            target.components.combat:GetAttacked(inst, damage + extradamage, weapon, "electric")
            if attachfx then CustomAttachFx(target, "shock_fx") end
        else
            target.components.combat:GetAttacked(inst, damage, weapon)
        end
    end
end

local musha_setsugetsuka_pre = State {
    name = "musha_setsugetsuka_pre",
    tags = { "musha_setsugetsuka_pre", "doing", "busy", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("multithrust_yell")
        inst:ForceFacePoint(target.x, target.y, target.z)
        inst.sg.statemem.target = target
        inst.components.timer:SetTimeLeft("clearsetsugetsukacounter", 0)
    end,

    timeline =
    {
        TimeEvent(1 * FRAMES, function(inst)
            inst.fx_setsugetsuka = CustomAttachFx(inst, "crab_king_icefx")
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("musha_setsugetsuka", { target = inst.sg.statemem.target })
            end
        end),
    },
}

local musha_setsugetsuka_pre_client = State {
    name = "musha_setsugetsuka_pre",
    tags = { "musha_setsugetsuka_pre", "doing", "busy", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("multithrust_yell")
        inst:ForceFacePoint(target.x, target.y, target.z)

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
        inst.sg:GoToState("idle")
    end,
}

local musha_setsugetsuka = State {
    name = "musha_setsugetsuka",
    tags = { "musha_setsugetsuka", "doing", "busy", "nopredict", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        local dist = math.sqrt(inst:GetDistanceSqToPoint(target))
        local maxdist = math.max(inst.components.combat.attackrange, TUNING.musha.skills.setsugetsuka.mindist)
        local mult = math.min(1, maxdist / dist)
        local weapon = inst.components.combat:GetWeapon()

        inst.components.locomotor:Stop()
        inst.Transform:SetEightFaced()
        inst.AnimState:PlayAnimation("multithrust")
        inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")

        inst.sg.statemem.startingpos = inst:GetPosition()
        inst.sg.statemem.targetpos = inst.sg.statemem.startingpos + (target - inst.sg.statemem.startingpos) * mult -- Numeric value must behind Vector3
        if inst.sg.statemem.startingpos.x ~= inst.sg.statemem.targetpos.x
            or inst.sg.statemem.startingpos.z ~= inst.sg.statemem.targetpos.z then
            inst.sg.statemem.motorvelset = true
            inst:ForceFacePoint(inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.y, inst.sg.statemem.targetpos.z)
            inst.Physics:SetMotorVel(math.sqrt(distsq(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z,
                inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z)) / (13 * FRAMES), 0, 0)
        end

        inst.components.combat.externaldamagetakenmultipliers:SetModifier(inst,
            TUNING.musha.skills.setsugetsuka.damagetakenmultiplier, "setsugetsuka")

        inst.components.timer:SetTimeLeft("premagpiestep", 0)
        inst.components.timer:StopTimer("cooldown_setsugetsuka")
        inst:RemoveEventCallback("timerdone", SetsuGetsuKaOnTimerDone)
        inst.components.timer:StopTimer("clearsetsugetsukacounter")
        inst:RemoveEventCallback("timerdone", ClearSetsuGetsuKaCounter)
        inst.setsugetsuka_counter = inst.setsugetsuka_counter and inst.setsugetsuka_counter + 1 or 1

        inst.sg.statemem.weapon = weapon
        inst.sg.statemem.lightningapplied = inst:HasTag("lightningstrikeready")

        if inst.sg.statemem.lightningapplied then
            inst:LightningDischarge()
        end
    end,

    timeline =
    {
        TimeEvent(1 * FRAMES, function(inst)
            if inst.setsugetsuka_counter > 1 then
                CustomRemoveEntity(inst.fx_setsugetsuka)
                inst.fx_setsugetsuka = CustomAttachFx(inst, "crab_king_icefx")
            end
        end),
        TimeEvent(7 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
        end),
        TimeEvent(9 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
        end),
        TimeEvent(11 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            DoThrust(inst, inst.sg.statemem.lightningapplied, true)
            ShakeAllCameras(CAMERASHAKE.FULL, .5, .02, .5, inst, 40) -- Note: ShakeAllCameras(mode, duration, speed, scale, source_or_pt, maxDist)
        end),
        TimeEvent(13 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            DoThrust(inst, inst.sg.statemem.lightningapplied)
            inst.sg.statemem.motorvelset = nil
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
        end),
        TimeEvent(15 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            DoThrust(inst, inst.sg.statemem.lightningapplied)
        end),
        TimeEvent(17 * FRAMES, function(inst)
            DoThrust(inst, inst.sg.statemem.lightningapplied)
        end),
        TimeEvent(19 * FRAMES, function(inst)
            DoThrust(inst, inst.sg.statemem.lightningapplied)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("nopredict")
            inst.sg:RemoveStateTag("nointerrupt")
            inst.sg:RemoveStateTag("musha_nointerrupt")

            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
            inst.components.timer:StartTimer("clearsetsugetsukacounter", TUNING.musha.skills.setsugetsuka.usewindow)
            inst:ListenForEvent("timerdone", ClearSetsuGetsuKaCounter)
        end),
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
        if inst.sg.statemem.motorvelset then
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
        end
        inst.Transform:SetFourFaced()

        inst.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, "setsugetsuka")
        inst.components.timer:StartTimer("cooldown_setsugetsuka", TUNING.musha.skills.setsugetsuka.cooldown)
        inst:ListenForEvent("timerdone", SetsuGetsuKaOnTimerDone)

        if inst.sg.statemem.weapon and inst.sg.statemem.weapon.components.stackable then
            inst.sg.statemem.weapon.components.stackable:Get():Remove()
        end
    end,
}

AddStategraphState("wilson", musha_setsugetsuka_pre)
AddStategraphState("wilson_client", musha_setsugetsuka_pre_client)

AddStategraphState("wilson", musha_setsugetsuka)

AddStategraphEvent("wilson", EventHandler("startsetsugetsuka_pre",
    function(inst)
        local target = inst.bufferedcursorpos
        if target ~= nil then
            inst.sg:GoToState("musha_setsugetsuka_pre", { target = target })
        end
        inst.bufferedcursorpos = nil
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startsetsugetsuka_pre",
    function(inst)
        local target = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()
        if target ~= nil then
            inst.sg:GoToState("musha_setsugetsuka_pre", { target = target })
        end
    end)
)

AddStategraphEvent("wilson", EventHandler("startsetsugetsuka",
    function(inst)
        local target = inst.bufferedcursorpos
        if target ~= nil then
            inst.sg:GoToState("musha_setsugetsuka", { target = target })
        end
        inst.bufferedcursorpos = nil
    end)
)

---------------------------------------------------------------------------------------------------------

-- Phoenix advent

local function DoAdvent(inst)
    local must_tags = { "_combat" }
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player",
        "companion", "musha_companion" }
    local radius = TUNING.musha.skills.phoenixadvent.radius
    local lightning = inst:HasTag("lightningstrikeready")
    local weapon = inst.components.combat:GetWeapon()

    local function fn(target)
        local damage = inst.components.combat:CalcDamage(target, weapon) *
            TUNING.musha.skills.phoenixadvent.damagemultiplier

        if lightning then
            local extradamage = TUNING.musha.skills.lightningstrike.damage +
                TUNING.musha.skills.lightningstrike.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5
            target.components.combat:GetAttacked(inst, damage + extradamage, weapon, "electric")
            CustomAttachFx(target, { "lightning_musha", "shock_fx" })
        else
            target.components.combat:GetAttacked(inst, damage, weapon)
        end

        inst.components.stamina:DoDelta(TUNING.musha.skills.phoenixadvent.staminaregen)
    end

    CustomDoAOE(inst, radius, must_tags, ignore_tags, nil, fn)

    if lightning then
        inst:LightningDischarge()
    end

    ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, .5, inst, 40) -- Renew camera shaking effect caused by lightnings

    if weapon and weapon.components.stackable then
        weapon.components.stackable:Get():Remove()
    end
end

local musha_phoenixadvent = State {
    name = "musha_phoenixadvent",
    tags = { "musha_phoenixadvent", "doing", "busy", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("lunge_pre")
        inst.AnimState:PushAnimation("lunge_lag", false)
        inst.AnimState:PushAnimation("lunge_pst", false)
        inst:ForceFacePoint(target.x, target.y, target.z)

        inst.components.timer:SetTimeLeft("clearsetsugetsukacounter", 0)
    end,

    onupdate = function(inst)
        if inst.sg.statemem.flash and inst.sg.statemem.flash > 0 then
            inst.sg.statemem.flash = math.max(0, inst.sg.statemem.flash - .1)
            inst.components.colouradder:PushColour("lunge", inst.sg.statemem.flash, inst.sg.statemem.flash, 0, 0)
        end
    end,

    timeline =
    {
        TimeEvent(4 * FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/common/twirl", nil, nil, true)
        end),
        TimeEvent(24 * FRAMES, function(inst)
            DoAdvent(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            inst.SoundEmitter:PlaySound("dontstarve/common/lava_arena/fireball")
            inst.components.bloomer:PushBloom("lunge", "shaders/anim.ksh", -2)
            inst.components.colouradder:PushColour("lunge", 1, 1, 0, 0)
            inst.sg.statemem.flash = 1
            inst:ScreenFlash(1)
            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
        end),
        TimeEvent(36 * FRAMES, function(inst)
            inst.components.bloomer:PopBloom("lunge")
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.components.bloomer:PopBloom("lunge")
        inst.components.colouradder:PopColour("lunge")
    end,
}

local musha_phoenixadvent_client = State {
    name = "musha_phoenixadvent",
    tags = { "musha_phoenixadvent", "doing", "busy", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("lunge_pre")
        inst.AnimState:PushAnimation("lunge_lag", false)
        inst.AnimState:PushAnimation("lunge_pst", false)
        inst:ForceFacePoint(target.x, target.y, target.z)
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },
}

AddStategraphState("wilson", musha_phoenixadvent)
AddStategraphState("wilson_client", musha_phoenixadvent_client)

AddStategraphEvent("wilson", EventHandler("startphoenixadvent",
    function(inst)
        local target = inst.bufferedcursorpos
        if target ~= nil then
            inst.sg:GoToState("musha_phoenixadvent", { target = target })
        end
        inst.bufferedcursorpos = nil
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startphoenixadvent",
    function(inst)
        local target = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()
        if target ~= nil then
            inst.sg:GoToState("musha_phoenixadvent", { target = target })
        end
    end)
)

---------------------------------------------------------------------------------------------------------

-- Annihilation

local function AnnihilationOnTimerDone(inst, data)
    if data.name == "cooldown_annihilation" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.annihilation.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", AnnihilationOnTimerDone)
    end
end

local function DoAnnihilation(inst)
    local must_tags = { "_combat" }
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player",
        "companion", "musha_companion" }
    local radius = TUNING.musha.skills.annihilation.radius
    local lightning = inst:HasTag("lightningstrikeready")
    local weapon = inst.components.combat:GetWeapon()

    local function fn(target)
        local damage = inst.components.combat:CalcDamage(target, weapon) *
            TUNING.musha.skills.annihilation.damagemultiplier

        if lightning then
            local extradamage = TUNING.musha.skills.lightningstrike.damage +
                TUNING.musha.skills.lightningstrike.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5
            target.components.combat:GetAttacked(inst, damage + extradamage, weapon, "electric")
            target:AddDebuff("annihilation", "debuff_paralysis")
            if target.components.debuffable:GetDebuff("annihilation") then
                target.components.debuffable:GetDebuff("annihilation"):SetDuration(TUNING.musha.skills.annihilation.paralysisduration)
            end
        else
            target.components.combat:GetAttacked(inst, damage, weapon)
        end
    end

    CustomDoAOE(inst, radius, must_tags, ignore_tags, nil, fn)

    local fx = SpawnPrefab("groundpoundring_fx")
    local scale = 0.4 + 0.066 * radius
    fx.Transform:SetScale(scale, scale, scale)
    fx.Transform:SetPosition(inst:GetPosition():Get())

    if lightning then
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(-1.5, 0, 0))
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(2, 0, -2.5))
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(2, 0, 2.5))
        inst:LightningDischarge()
    end

    ShakeAllCameras(CAMERASHAKE.FULL, .7, .02, .5, inst, 40) -- Renew camera shaking effect caused by lightnings

    if weapon and weapon.components.stackable then
        weapon.components.stackable:Get():Remove()
    end
end

local musha_annihilation_pre = State {
    name = "musha_annihilation_pre",
    tags = { "musha_annihilation_pre", "doing", "busy", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst:ForceFacePoint(target.x, target.y, target.z)
        inst.AnimState:PlayAnimation("atk_leap_pre")
        inst.sg.statemem.target = target
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("musha_annihilation", { target = inst.sg.statemem.target })
            end
        end),
    }
}

local musha_annihilation_pre_client = State {
    name = "musha_annihilation_pre",
    tags = { "musha_annihilation_pre", "doing", "busy", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        inst.components.locomotor:Stop()
        inst:ForceFacePoint(target.x, target.y, target.z)
        inst.AnimState:PlayAnimation("atk_leap_pre")

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
        inst.sg:GoToState("idle")
    end,
}

local musha_annihilation = State {
    name = "musha_annihilation",
    tags = { "musha_annihilation", "doing", "busy", "nopredict", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        local dist = math.sqrt(inst:GetDistanceSqToPoint(target))
        local maxdist = TUNING.musha.skills.annihilation.maxdist
        local mult = math.min(1, maxdist / dist)

        ToggleOffPhysics(inst)
        inst.Transform:SetEightFaced()
        inst.AnimState:PlayAnimation("atk_leap")
        inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")

        inst.sg.statemem.flash = 0
        inst.sg.statemem.startingpos = inst:GetPosition()
        inst.sg.statemem.targetpos = inst.sg.statemem.startingpos + (target - inst.sg.statemem.startingpos) * mult -- Numeric value must behind Vector3
        if inst.sg.statemem.startingpos.x ~= inst.sg.statemem.targetpos.x
            or inst.sg.statemem.startingpos.z ~= inst.sg.statemem.targetpos.z then
            inst:ForceFacePoint(inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.y, inst.sg.statemem.targetpos.z)
            inst.Physics:SetMotorVel(math.sqrt(distsq(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z,
                inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z)) / (12 * FRAMES), 0, 0)
        end
    end,

    onupdate = function(inst)
        if inst.sg.statemem.flash > 0 then
            inst.sg.statemem.flash = math.max(0, inst.sg.statemem.flash - .1)
            local c = math.min(1, inst.sg.statemem.flash)
            inst.components.colouradder:PushColour("leap", c, c, 0, 0)
        end
    end,

    timeline =
    {
        TimeEvent(10 * FRAMES, function(inst)
            inst.components.colouradder:PushColour("leap", .1, .1, 0, 0)
        end),
        TimeEvent(11 * FRAMES, function(inst)
            inst.components.colouradder:PushColour("leap", .2, .2, 0, 0)
        end),
        TimeEvent(12 * FRAMES, function(inst)
            inst.components.colouradder:PushColour("leap", .4, .4, 0, 0)
            ToggleOnPhysics(inst)
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
            inst.Physics:Teleport(inst.sg.statemem.targetpos.x, 0, inst.sg.statemem.targetpos.z)
        end),
        TimeEvent(13 * FRAMES, function(inst)
            DoAnnihilation(inst)
            inst.components.bloomer:PushBloom("leap", "shaders/anim.ksh", -2)
            inst.components.colouradder:PushColour("leap", 1, 1, 0, 0)
            inst.sg.statemem.flash = 1.3
            inst.sg:RemoveStateTag("nointerrupt")
            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
        end),
        TimeEvent(25 * FRAMES, function(inst)
            inst.components.bloomer:PopBloom("leap")
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.isphysicstoggle then
            ToggleOnPhysics(inst)
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
            local x, y, z = inst.Transform:GetWorldPosition()
            if TheWorld.Map:IsPassableAtPoint(x, 0, z) and not TheWorld.Map:IsGroundTargetBlocked(Vector3(x, 0, z)) then
                inst.Physics:Teleport(x, 0, z)
            else
                inst.Physics:Teleport(inst.sg.statemem.targetpos.x, 0, inst.sg.statemem.targetpos.z)
            end
        end
        inst.Transform:SetFourFaced()
        inst.components.bloomer:PopBloom("leap")
        inst.components.colouradder:PopColour("leap")

        inst.components.timer:StartTimer("cooldown_annihilation", TUNING.musha.skills.annihilation.cooldown)
        inst:ListenForEvent("timerdone", AnnihilationOnTimerDone)
    end,
}

AddStategraphState("wilson", musha_annihilation_pre)
AddStategraphState("wilson_client", musha_annihilation_pre_client)

AddStategraphState("wilson", musha_annihilation)

AddStategraphEvent("wilson", EventHandler("startannihilation",
    function(inst)
        local target = inst.bufferedcursorpos
        if target ~= nil then
            inst.sg:GoToState("musha_annihilation_pre", { target = target })
        end
        inst.bufferedcursorpos = nil
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startannihilation",
    function(inst)
        local target = TheInput:GetWorldEntityUnderMouse() and TheInput:GetWorldEntityUnderMouse():GetPosition()
            or TheInput:GetWorldPosition()
        if target ~= nil then
            inst.sg:GoToState("musha_annihilation_pre", { target = target })
        end
    end)
)

---------------------------------------------------------------------------------------------------------

-- Desolate dive

local function DesolateDiveOnTimerDone(inst, data)
    if data.name == "cooldown_desolatedive" then
        inst.components.talker:Say(STRINGS.musha.skills.cooldownfinished.part1
            .. STRINGS.musha.skills.desolatedive.name
            .. STRINGS.musha.skills.cooldownfinished.part2)
        inst:RemoveEventCallback("timerdone", DesolateDiveOnTimerDone)
    end
end

local function DoDive(inst)
    local must_tags = { "_combat" }
    local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player",
        "companion", "musha_companion", "wall" }
    local radius = TUNING.musha.skills.desolatedive.radius
    local lightning = inst:HasTag("lightningstrikeready")
    local weapon = inst.components.combat:GetWeapon()

    local function fn(target)
        local damage = inst.components.combat:CalcDamage(target, weapon) *
            TUNING.musha.skills.desolatedive.damagemultiplier

        if lightning then
            local extradamage = (TUNING.musha.skills.lightningstrike.damage +
                TUNING.musha.skills.lightningstrike.damagegrowth * math.floor(inst.components.leveler.lvl / 5) * 5)
                * TUNING.musha.skills.desolatedive.damagemultiplier
            target.components.combat:GetAttacked(inst, damage + extradamage, weapon, "electric")
            CustomAttachFx(target, { "lightning_musha", "shock_fx" })
        else
            target.components.combat:GetAttacked(inst, damage, weapon)
        end
    end

    CustomDoAOE(inst, radius, must_tags, ignore_tags, nil, fn)

    local fx = SpawnPrefab("groundpoundring_fx")
    fx.Transform:SetPosition(inst:GetPosition():Get())

    local sinkhole = SpawnPrefab("antlion_sinkhole_musha")
    sinkhole.fx_scale = 1.8
    sinkhole.Transform:SetScale(sinkhole.fx_scale, sinkhole.fx_scale, sinkhole.fx_scale)
    sinkhole.Transform:SetPosition(inst:GetPosition():Get())
    sinkhole:PushEvent("startcollapse")

    local fx_sinkhole = SpawnPrefab("antlion_sinkhole_musha")
    fx_sinkhole.Transform:SetPosition(inst:GetPosition():Get())
    CustomRemoveEntity(fx_sinkhole, TUNING.musha.skills.desolatedive.sinkhole.repairtime[3]
        + 2 * TUNING.musha.skills.desolatedive.sinkhole.collapsetime)

    if lightning then
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(-1.5, 0, 0))
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(2, 0, -2.5))
        CustomAttachFx(inst, "lightning_musha", nil, nil, Vector3(2, 0, 2.5))
        inst:LightningDischarge()
    end

    ShakeAllCameras(CAMERASHAKE.FULL, 1, .02, .8, inst, 40) -- Renew camera shaking effect caused by lightnings

    if weapon and weapon.components.stackable then
        weapon.components.stackable:Get():Remove()
    end
end

local musha_desolatedive_pre = State {
    name = "musha_desolatedive_pre",
    tags = { "musha_desolatedive_pre", "doing", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("superjump_pre")
    end,

    events =
    {
        EventHandler("startdesolatedive", function(inst)
            if inst.sg.statemem.ready then
                local target = inst.bufferedcursorpos
                if target ~= nil then
                    inst.sg:GoToState("musha_desolatedive", { target = target })
                end
            else
                inst.sg:GoToState("idle")
            end
            inst.bufferedcursorpos = nil
        end),
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                if inst.AnimState:IsCurrentAnimation("superjump_pre") then
                    inst.AnimState:PlayAnimation("superjump_lag")
                elseif inst.AnimState:IsCurrentAnimation("superjump_lag") then
                    inst.sg.statemem.ready = true
                    inst.sg.statemem.flash = 0.8
                    inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
                    inst:ShakeCamera(CAMERASHAKE.FULL, TUNING.musha.skills.desolatedive.maxchargingtime, .01, .1)
                    inst.sg:SetTimeout(TUNING.musha.skills.desolatedive.maxchargingtime)
                end
            end
        end),
    },

    onupdate = function(inst)
        if inst.sg.statemem.flash and inst.sg.statemem.flash > 0 then
            inst.sg.statemem.flash = math.max(0, inst.sg.statemem.flash - .025)
            local c = math.min(1, inst.sg.statemem.flash)
            inst.components.colouradder:PushColour("superjump", c, c, 0, 0)
        end
    end,

    ontimeout = function(inst)
        inst.sg:GoToState("idle")
        inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")

        if inst.mode:value() == 2 then
            inst.components.timer:StartTimer("cooldown_desolatedive", TUNING.musha.skills.desolatedive.cooldown)
            inst:ListenForEvent("timerdone", DesolateDiveOnTimerDone)
        end
    end,

    onexit = function(inst)
        inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")
        inst.components.colouradder:PopColour("superjump")
        if TheCamera.shake ~= nil then
            TheCamera.shake:StopShaking()
        end
    end,
}

local musha_desolatedive_pre_client = State {
    name = "musha_desolatedive_pre",
    tags = { "musha_desolatedive_pre", "doing", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("superjump_pre")
        inst.AnimState:PushAnimation("superjump_lag", true)

        inst.sg:SetTimeout(TUNING.musha.skills.desolatedive.maxchargingtime)
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
        inst.sg:GoToState("idle")
    end
}

local musha_desolatedive = State {
    name = "musha_desolatedive",
    tags = { "musha_desolatedive", "doing", "busy", "nopredict", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        if inst.AnimState:IsCurrentAnimation("superjump_lag") then
            local target = data.target
            local dist = math.sqrt(inst:GetDistanceSqToPoint(target))
            local maxdist = math.max(inst.components.stamina.current / TUNING.musha.skills.desolatedive.staminacostrate,
                TUNING.musha.skills.desolatedive.mindist)
            local mult = math.min(1, maxdist / dist)
            local fxlist = {
                "crabking_chip_high",
                "crabking_chip_med",
                "crabking_chip_low"
            }

            ToggleOffPhysics(inst)
            inst.AnimState:PlayAnimation("superjump")
            inst.AnimState:SetMultColour(.8, .8, .8, 1)
            inst.components.colouradder:PushColour("superjump", .1, .1, .1, 0)
            inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt", nil, .4)
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")

            inst.sg.statemem.startingpos = inst:GetPosition()
            inst.sg.statemem.targetpos = inst.sg.statemem.startingpos +
                (target - inst.sg.statemem.startingpos) * mult -- Numeric value must behind Vector3
            if inst.sg.statemem.startingpos.x ~= inst.sg.statemem.targetpos.x
                or inst.sg.statemem.startingpos.z ~= inst.sg.statemem.targetpos.z then
                inst:ForceFacePoint(inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.y,
                    inst.sg.statemem.targetpos.z)
            end

            for _, fx in pairs(fxlist) do
                SpawnPrefab(fx).Transform:SetPosition(inst:GetPosition():Get())
            end

            inst.components.stamina:DoDelta(-TUNING.musha.skills.desolatedive.staminacostrate * dist * mult)

            inst.sg:SetTimeout(1)
            return
        end
        --Failed
        inst.sg:GoToState("idle", true)
    end,

    onupdate = function(inst)
        if inst.sg.statemem.dalpha ~= nil and inst.sg.statemem.alpha > 0 then
            inst.sg.statemem.dalpha = math.max(.1, inst.sg.statemem.dalpha - .1)
            inst.sg.statemem.alpha = math.max(0, inst.sg.statemem.alpha - inst.sg.statemem.dalpha)
            inst.AnimState:SetMultColour(0, 0, 0, inst.sg.statemem.alpha)
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst)
            inst.DynamicShadow:Enable(false)
            inst.components.health:SetInvincible(true)
            inst:RemoveTag("scarytoprey")
            inst.AnimState:SetMultColour(.5, .5, .5, 1)
            inst.components.colouradder:PushColour("superjump", .3, .3, .2, 0)
            inst.Physics:SetMotorVel(math.sqrt(distsq(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z,
                inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z)) / (10 * FRAMES), 0, 0)
        end),
        TimeEvent(2 * FRAMES, function(inst)
            inst.AnimState:SetMultColour(0, 0, 0, 1)
            inst.components.colouradder:PushColour("superjump", .6, .6, .4, 0)
        end),
        TimeEvent(3 * FRAMES, function(inst)
            inst.sg.statemem.alpha = 1
            inst.sg.statemem.dalpha = .5
        end),
        TimeEvent(11 * FRAMES, function(inst)
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst:Hide()
                inst.Physics:Teleport(inst.sg.statemem.targetpos.x, 0, inst.sg.statemem.targetpos.z)
            end
        end),
    },

    ontimeout = function(inst)
        inst.sg.statemem.superjump = true
        inst.sg.statemem.data = {}
        inst.sg.statemem.data.startingpos = inst.sg.statemem.startingpos
        inst.sg.statemem.data.targetpos = inst.sg.statemem.targetpos
        inst.sg.statemem.data.isphysicstoggle = inst.sg.statemem.isphysicstoggle
        inst.sg:GoToState("musha_desolatedive_pst", inst.sg.statemem.data)
    end,

    onexit = function(inst)
        if not inst.sg.statemem.superjump then
            inst.components.health:SetInvincible(false)
            inst:AddTag("scarytoprey")
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            inst.components.colouradder:PopColour("superjump")
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            inst.DynamicShadow:Enable(true)
        end
        inst:Show()
    end,
}

local musha_desolatedive_pst = State {
    name = "musha_desolatedive_pst",
    tags = { "musha_desolatedive_pst", "doing", "busy", "nopredict", "musha_nointerrupt" },

    onenter = function(inst, data)
        if data ~= nil then
            inst.sg.statemem.startingpos = data.startingpos
            inst.sg.statemem.isphysicstoggle = data.isphysicstoggle
            if inst.sg.statemem.startingpos ~= nil and
                data.targetpos ~= nil and
                inst.AnimState:IsCurrentAnimation("superjump") then
                inst.AnimState:PlayAnimation("superjump_land")
                inst.AnimState:SetMultColour(1, 1, 1, .4)
                inst.sg.statemem.targetpos = data.targetpos
                inst.sg.statemem.flash = 0
                if not inst.sg.statemem.isphysicstoggle then
                    ToggleOffPhysics(inst)
                end
                inst.Physics:Teleport(data.targetpos.x, 0, data.targetpos.z)
                inst.components.health:SetInvincible(true)
                inst:RemoveTag("scarytoprey")
                inst.sg:SetTimeout(22 * FRAMES)
                return
            end
        end
        --Failed
        inst.sg:GoToState("idle", true)
    end,

    onupdate = function(inst)
        if inst.sg.statemem.flash > 0 then
            inst.sg.statemem.flash = math.max(0, inst.sg.statemem.flash - .1)
            local c = math.min(1, inst.sg.statemem.flash)
            inst.components.colouradder:PushColour("superjump", c, c, 0, 0)
        end
    end,

    timeline =
    {
        TimeEvent(FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            inst.AnimState:SetMultColour(1, 1, 1, .7)
            inst.components.colouradder:PushColour("superjump", .1, .1, 0, 0)
        end),
        TimeEvent(2 * FRAMES, function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, .9)
            inst.components.colouradder:PushColour("superjump", .2, .2, 0, 0)
        end),
        TimeEvent(3 * FRAMES, function(inst)
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            inst.components.colouradder:PushColour("superjump", .4, .4, 0, 0)
            inst.DynamicShadow:Enable(true)
        end),
        TimeEvent(4 * FRAMES, function(inst)
            inst.components.colouradder:PushColour("superjump", 1, 1, 0, 0)
            inst.components.bloomer:PushBloom("superjump", "shaders/anim.ksh", -2)
            ToggleOnPhysics(inst)
            inst.sg.statemem.flash = 1.3

            if inst.mode:value() == 0 or inst.mode:value() == 1 then
                inst.components.mana:DoDelta(-TUNING.musha.skills.valkyriemode.manacost)
                inst.mode:set(2)
            end

            inst:DoTaskInTime(0, DoDive) -- Get lightning strike effect
            inst.components.health:SetInvincible(false)
            inst:AddTag("scarytoprey")
            inst.sg:RemoveStateTag("nopredict")
            inst.sg:RemoveStateTag("musha_nointerrupt")

            inst.components.timer:StartTimer("premagpiestep", TUNING.musha.skills.magpiestep.usewindow)
        end),
        TimeEvent(8 * FRAMES, function(inst)
            inst.components.bloomer:PopBloom("superjump")
        end),
        TimeEvent(19 * FRAMES, PlayFootstep),
    },

    ontimeout = function(inst)
        inst.sg:GoToState("idle", true)
    end,

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.isphysicstoggle then
            ToggleOnPhysics(inst)
        end
        inst.AnimState:SetMultColour(1, 1, 1, 1)
        inst.DynamicShadow:Enable(true)
        inst.components.health:SetInvincible(false)
        inst.components.bloomer:PopBloom("superjump")
        inst.components.colouradder:PopColour("superjump")

        inst.components.timer:StartTimer("cooldown_desolatedive", TUNING.musha.skills.desolatedive.cooldown)
        inst:ListenForEvent("timerdone", DesolateDiveOnTimerDone)
    end,
}

AddStategraphState("wilson", musha_desolatedive_pre)
AddStategraphState("wilson_client", musha_desolatedive_pre_client)

AddStategraphState("wilson", musha_desolatedive)

AddStategraphState("wilson", musha_desolatedive_pst)

AddStategraphEvent("wilson", EventHandler("startdesolatedive_pre",
    function(inst)
        inst.sg:GoToState("musha_desolatedive_pre")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startdesolatedive_pre",
    function(inst)
        inst.sg:GoToState("musha_desolatedive_pre")
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startdesolatedive",
    function()
        if TheCamera.shake ~= nil then
            TheCamera.shake:StopShaking()
        end
    end)
)

---------------------------------------------------------------------------------------------------------

-- Magpie step

local musha_magpiestep = State {
    name = "musha_magpiestep",
    tags = { "musha_magpiestep", "doing", "busy", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst, data)
        local target = data.target
        local dist = math.sqrt(inst:GetDistanceSqToPoint(target))
        local maxdist = TUNING.musha.skills.magpiestep.maxdist
        local mult = math.min(1, maxdist / dist)

        ToggleOffPhysics(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("asa_dodge")
        inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
        inst.components.health:SetInvincible(true)
        inst.components.timer:SetTimeLeft("premagpiestep", 0)
        inst.components.timer:PauseTimer("clearsetsugetsukacounter")

        inst.sg.statemem.startingpos = inst:GetPosition()
        inst.sg.statemem.targetpos = inst.sg.statemem.startingpos + (target - inst.sg.statemem.startingpos) * mult -- Numeric value must behind Vector3
        if inst.sg.statemem.startingpos.x ~= inst.sg.statemem.targetpos.x
            or inst.sg.statemem.startingpos.z ~= inst.sg.statemem.targetpos.z then
            inst:ForceFacePoint(inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.y, inst.sg.statemem.targetpos.z)
            inst.Physics:SetMotorVel(math.sqrt(distsq(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z,
                inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z)) / (9 * FRAMES), 0, 0)
        end

        inst.task_phantom = inst:DoPeriodicTask(FRAMES, function()
            ApplyPhantom(inst, "asa_dodge")
        end)
    end,

    onupdate = function(inst)
        if inst.sg.statemem.attackdone then
            return
        end

        local radius = TUNING.musha.skills.magpiestep.radius
        local must_tags = { "_combat" }
        local ignore_tags = { "INLIMBO", "notarget", "noattack", "flight", "invisible", "isdead", "playerghost", "player",
            "companion", "musha_companion" }
        local target = FindEntity(inst, radius, nil, must_tags, ignore_tags)

        if target ~= nil and target:IsValid() then
            local fx = SpawnPrefab(math.random() < .5 and "shadowstrike_slash_fx" or "shadowstrike_slash2_fx")
            local x, y, z = target.Transform:GetWorldPosition()
            fx.Transform:SetPosition(x, y + 1.5, z)
            fx.Transform:SetRotation(inst.Transform:GetRotation())
            fx.Transform:SetScale(2, 2, 2)

            local weapon = inst.components.combat:GetWeapon()
            local damage = inst.components.combat:CalcDamage(target, weapon,
                TUNING.musha.skills.magpiestep.damagemultiplier) -- Note: CalcDamage(target, weapon, multiplier)
            target.components.combat:GetAttacked(inst, damage, weapon)

            inst.sg.statemem.attackdone = true
        end
    end,

    timeline = {
        TimeEvent(1 * FRAMES, function(inst)
            inst.sg:AddStateTag("nopredict")
        end),
        TimeEvent(6 * FRAMES, function(inst)
            inst:ForceFacePoint(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.y,
                inst.sg.statemem.startingpos.z)
            inst.Physics:SetMotorVel(-math.sqrt(distsq(inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z
                , inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z)) / (9 * FRAMES), 0, 0)
        end),
        TimeEvent(9 * FRAMES, function(inst)
            CustomCancelTask(inst.task_phantom)
            ToggleOnPhysics(inst)
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
            inst.Physics:Teleport(inst.sg.statemem.targetpos.x, 0, inst.sg.statemem.targetpos.z)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("nopredict")
            inst.sg:RemoveStateTag("nointerrupt")
            inst.sg:RemoveStateTag("musha_magpiestep")
            inst.sg:RemoveStateTag("musha_nointerrupt")
            inst.components.timer:ResumeTimer("clearsetsugetsukacounter")
        end),
    },

    events =
    {
        EventHandler("animover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        CustomCancelTask(inst.task_phantom)
        inst.components.health:SetInvincible(false)
        if inst.sg.statemem.isphysicstoggle then
            ToggleOnPhysics(inst)
            inst.Physics:Stop()
            inst.Physics:SetMotorVel(0, 0, 0)
            local x, y, z = inst.Transform:GetWorldPosition()
            if TheWorld.Map:IsPassableAtPoint(x, 0, z) and not TheWorld.Map:IsGroundTargetBlocked(Vector3(x, 0, z)) then
                inst.Physics:Teleport(x, 0, z)
            else
                inst.Physics:Teleport(inst.sg.statemem.targetpos.x, 0, inst.sg.statemem.targetpos.z)
            end
        end
    end,
}

local musha_magpiestep_client = State {
    name = "musha_magpiestep",
    tags = { "musha_magpiestep", "doing", "busy", "nointerrupt", "musha_nointerrupt" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("asa_dodge")

        inst.sg:SetTimeout(9 * FRAMES)
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
        inst.sg:GoToState("idle")
    end,
}

AddStategraphState("wilson", musha_magpiestep)
AddStategraphState("wilson_client", musha_magpiestep_client)

AddStategraphEvent("wilson", EventHandler("startmagpiestep",
    function(inst)
        local target = inst.bufferedcursorpos
        if target ~= nil then
            inst.sg:GoToState("musha_magpiestep", { target = target })
        end
        inst.bufferedcursorpos = nil
    end)
)

AddStategraphEvent("wilson_client", EventHandler("startmagpiestep",
    function(inst)
        inst.sg:GoToState("musha_magpiestep")
    end)
)
