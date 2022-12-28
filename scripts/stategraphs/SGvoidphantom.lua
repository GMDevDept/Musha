local function DoPhantomSlash(inst)
    local fx = CustomAttachFx(inst,
        math.random() < .5 and "shadowstrike_slash_fx" or "shadowstrike_slash2_fx",
        nil, Vector3(2, 2, 2), Vector3(0, 1.5, 0))
    fx.Transform:SetRotation(math.random() * 360)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_nightsword")
    inst.SoundEmitter:PlaySound("dontstarve/impacts/impact_shadow_med_sharp")

    local target = inst.sg.statemem.target
    if inst:OwnerValid() and target ~= nil and target:IsValid() and inst:IsNear(target, 2) then
        local owner = inst.owner
        local weapon = owner.components.combat:GetWeapon()
        local damage = owner.components.combat:CalcDamage(target, weapon,
            TUNING.musha.skills.phantomslash.damagemultiplier) -- Note: CalcDamage(target, weapon, multiplier)
        target.components.combat:GetAttacked(owner, damage)
    end
end

local function NotBlocked(pt)
    return not TheWorld.Map:IsGroundTargetBlocked(pt)
end

local states =
{
    State {
        name = "idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("ready_stance_pre")
            inst.AnimState:PushAnimation("ready_stance_loop", true)
        end,
    },

    State {
        name = "lunge_pre",
        tags = { "attack", "busy", "noattack", "temp_invincible" },

        onenter = function(inst, target)
            inst.AnimState:SetBankAndPlayAnimation("lavaarena_shadow_lunge", "lunge_pre")
            inst.SoundEmitter:PlaySound("dontstarve/common/twirl")

            if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst.sg.statemem.targetpos = target:GetPosition()
                inst:ForceFacePoint(inst.sg.statemem.targetpos:Get())
            else
                target = nil
            end
        end,

        onupdate = function(inst)
            if inst.sg.statemem.target ~= nil then
                if inst.sg.statemem.target:IsValid() then
                    inst.sg.statemem.targetpos = inst.sg.statemem.target:GetPosition()
                else
                    inst.sg.statemem.target = nil
                end
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg.statemem.lunge = true
                    inst.sg:GoToState("lunge_loop",
                        { target = inst.sg.statemem.target, targetpos = inst.sg.statemem.targetpos })
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.lunge then
                inst.AnimState:SetBank("wilson")
            end
        end,
    },

    State {
        name = "lunge_loop",
        tags = { "attack", "busy", "noattack", "temp_invincible" },

        onenter = function(inst, data)
            inst.AnimState:PlayAnimation("lunge_loop")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_nightsword")
            inst.SoundEmitter:PlaySound("dontstarve/impacts/impact_shadow_med_sharp")

            if data ~= nil then
                if data.target ~= nil and data.target:IsValid() then
                    inst.sg.statemem.target = data.target
                    inst:ForceFacePoint(data.target.Transform:GetWorldPosition())
                elseif data.targetpos ~= nil then
                    inst:ForceFacePoint(data.targetpos)
                end
            end
            inst.Physics:SetMotorVelOverride(7 * TUNING.musha.skills.voidphantom.range, 0, 0)

            inst.sg:SetTimeout(8 * FRAMES)
        end,

        onupdate = function(inst)
            if inst.sg.statemem.attackdone then
                return
            end
            local target = inst.sg.statemem.target
            if target == nil or not target:IsValid() then
                if inst.sg.statemem.animdone then
                    inst.sg.statemem.lunge = true
                    inst.sg:GoToState("lunge_pst")
                    return
                end
                inst.sg.statemem.target = nil
            elseif inst:IsNear(target, 2) then
                local fx = SpawnPrefab(math.random() < .5 and "shadowstrike_slash_fx" or "shadowstrike_slash2_fx")
                local x, y, z = target.Transform:GetWorldPosition()
                fx.Transform:SetPosition(x, y + 1.5, z)
                fx.Transform:SetRotation(inst.Transform:GetRotation())
                fx.Transform:SetScale(2, 2, 2)

                if inst:OwnerValid() then
                    local owner = inst.owner
                    local weapon = owner.components.combat:GetWeapon()
                    local damage = owner.components.combat:CalcDamage(target, weapon,
                        TUNING.musha.skills.voidphantom.damagemultiplier) -- Note: CalcDamage(target, weapon, multiplier)
                    target.components.combat:GetAttacked(owner, damage)
                    owner:PushEvent("onattackother", { target = target })
                    if weapon and weapon.components.stackable then
                        weapon.components.stackable:Get():Remove()
                    end
                end

                if inst.sg.statemem.animdone then
                    inst.sg.statemem.lunge = true
                    inst.sg:GoToState("lunge_pst", target)
                    return
                end
                inst.sg.statemem.attackdone = true
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg.statemem.attackdone or inst.sg.statemem.target == nil then
                        inst.sg.statemem.lunge = true
                        inst.sg:GoToState("lunge_pst", inst.sg.statemem.target)
                        return
                    end
                    inst.sg.statemem.animdone = true
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg.statemem.lunge = true
            inst.sg:GoToState("lunge_pst")
        end,

        onexit = function(inst)
            if not inst.sg.statemem.lunge then
                inst.AnimState:SetBank("wilson")
            end
        end,
    },

    State {
        name = "lunge_pst",
        tags = { "busy", "noattack", "temp_invincible", "phasing" },

        onenter = function(inst, target)
            inst.AnimState:PlayAnimation("lunge_pst")
            inst.Physics:SetMotorVelOverride(12, 0, 0)
            inst.sg.statemem.target = target
        end,

        onupdate = function(inst)
            inst.Physics:SetMotorVelOverride(inst.Physics:GetMotorVel() * .8, 0, 0)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    local target = inst.sg.statemem.target
                    local pos = inst:GetPosition()
                    pos.y = 0
                    local moved = false
                    if target ~= nil then
                        if target:IsValid() then
                            local targetpos = target:GetPosition()
                            local dx, dz = targetpos.x - pos.x, targetpos.z - pos.z
                            local theta = math.atan2(dz, -dx)
                            local offs = FindWalkableOffset(targetpos, theta,
                                inst.phantomslashready and 1 or 3 + 2 * math.random(), 8, false, true
                                , NotBlocked, true, true) -- Note: FindWalkableOffset(pos, theta, dist, ...)
                            if offs ~= nil then
                                pos.x = targetpos.x + offs.x
                                pos.z = targetpos.z + offs.z
                                inst.Physics:Teleport(pos:Get())
                                moved = true
                            end
                        else
                            target = nil
                        end
                    end
                    if not moved and not TheWorld.Map:IsPassableAtPoint(pos.x, 0, pos.z, true) then
                        pos = FindNearbyLand(pos, 1) or FindNearbyLand(pos, 2)
                        if pos ~= nil then
                            inst.Physics:Teleport(pos.x, 0, pos.z)
                        end
                    end

                    if target ~= nil then
                        inst:ForceFacePoint(target.Transform:GetWorldPosition())
                    end

                    if inst.phantomslashready then
                        inst.sg:GoToState("phantomslash", target)
                        return
                    end

                    inst.sg.statemem.appearing = true
                    inst.sg:GoToState("appear")
                end
            end),
        },

        onexit = function(inst)
            inst.AnimState:SetBank("wilson")
        end,
    },

    State {
        name = "appear",
        tags = { "busy", "noattack", "temp_invincible", "phasing" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("appear")
            CustomAttachFx(inst, "sanity_raise")
        end,

        timeline =
        {
            TimeEvent(11 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("temp_invincible")
                inst.sg:RemoveStateTag("phasing")
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        }
    },

    State {
        name = "disappear",
        tags = { "busy", "noattack", "temp_invincible", "phasing" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("disappear")
            CustomAttachFx(inst, "statue_transition_2")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst:Remove()
                end
            end),
        }
    },

    State {
        name = "phantomslash",
        tags = { "attack", "busy", "noattack", "temp_invincible" },

        onenter = function(inst, target)
            if not (target ~= nil and target:IsValid()) then
                inst.sg:GoToState("idle")
                return
            end

            inst.AnimState:PlayAnimation("asa_zan1")
            inst.AnimState:PushAnimation("asa_zan2")
            inst.AnimState:PushAnimation("asa_zan3")
            inst.AnimState:PushAnimation("lunge_pst", false)
            CustomAttachFx(inst, "shadow_shield" .. math.random(1, 6))

            inst.sg.statemem.target = target
            inst:ForceFacePoint(target.Transform:GetWorldPosition())
            inst.Physics:SetMotorVelOverride(15, 0, 0)
        end,

        timeline =
        {
            TimeEvent(1 * FRAMES, function(inst)
                DoPhantomSlash(inst)
            end),
            TimeEvent(5 * FRAMES, function(inst)
                local target = inst.sg.statemem.target
                if target ~= nil and target:IsValid() then
                    inst:ForceFacePoint(target.Transform:GetWorldPosition())
                end
            end),
            TimeEvent(9 * FRAMES, function(inst)
                DoPhantomSlash(inst)
            end),
            TimeEvent(14 * FRAMES, function(inst)
                local target = inst.sg.statemem.target
                if target ~= nil and target:IsValid() then
                    inst:ForceFacePoint(target.Transform:GetWorldPosition())
                end
            end),
            TimeEvent(20 * FRAMES, function(inst)
                DoPhantomSlash(inst)
            end),
            TimeEvent(25 * FRAMES, function(inst)
                local target = inst.sg.statemem.target
                if target ~= nil and target:IsValid() then
                    inst:ForceFacePoint(target.Transform:GetWorldPosition())
                end
            end),
            TimeEvent(31 * FRAMES, function(inst)
                DoPhantomSlash(inst)
            end),
            TimeEvent(33 * FRAMES, function(inst)
                inst.Physics:Stop()
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("disappear")
                end
            end),
        },
    },
}

return StateGraph("voidphantom", states, {}, "idle", nil) -- Note: StateGraph(name, states, events, defaultstate, actionhandlers)
