ACTIONS.ABANDON.priority = 5
ACTIONS.ADDFUEL.priority = 4
ACTIONS.USEITEM.priority = 3
ACTIONS.TURNOFF.priority = 2
ACTIONS.TURNON.priority = 3
ACTIONS.GIVE.priority = 2

---------------------------------------------------------------------------------------------------------

-- Redefinations of game built-in actions

-- Open a useable item (for musha's equipments they can be always right-clicked while kept being equipped)
local _UseItemFn = ACTIONS.USEITEM.fn
ACTIONS.USEITEM.fn = function(act)
    -- Most of musha's equipments
    if act.invobject ~= nil and act.invobject:HasTag("musha_equipment") and
        act.invobject.components.useableitem ~= nil and
        act.invobject.components.machine ~= nil and
        act.doer.components.inventory ~= nil then
        if not act.invobject.boost then
            act.invobject.components.machine:TurnOn()
            return true
        else
            act.invobject.components.machine:TurnOff()
            return true
        end
    else
        return _UseItemFn(act)
    end
end

-- RUMMAGE (container, crockpot, etc.)
local _RummageFn = ACTIONS.RUMMAGE.fn
ACTIONS.RUMMAGE.fn = function(act)
    local targ = act.target or act.invobject
    -- Musha's companions' container,can only be opened by leader
    if targ:HasTag("musha_companion") and targ.components.follower.leader ~= act.doer then
        return false, "MUSHA_NOT_OWNER"
    else
        return _RummageFn(act)
    end
end

-- On pick up item from ground
local _PickupFn = ACTIONS.PICKUP.fn
ACTIONS.PICKUP.fn = function(act)
    -- When picker is Musha's companions, using components.container instead of components.inventory
    if act.doer:HasTag("musha_companion") then
        if act.doer.components.container ~= nil and
            act.target ~= nil and
            act.target.components.inventoryitem ~= nil and
            (act.target.components.inventoryitem.canbepickedup or
                (act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
            not (act.target:IsInLimbo() or
                (act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
                (act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

            if act.target.components.container ~= nil and act.target:HasTag("drop_inventory_onpickup") then
                act.target.components.container:TransferInventory(act.doer)
            end

            act.doer:PushEvent("onpickupitem", { item = act.target })
            act.doer.components.container:GiveItem(act.target, nil, act.target:GetPosition())

            return true
        end
    else
        return _PickupFn(act)
    end
end

-- On harvest crop, crockpot, dried meats or other harvestables
local _HarvestFn = ACTIONS.HARVEST.fn
ACTIONS.HARVEST.fn = function(act)
    -- When havester is Musha's companions, using components.container instead of components.inventory
    if act.doer:HasTag("musha_companion") then
        if act.target.components.crop ~= nil then
            local harvested--[[, product]]  = act.target.components.crop:Harvest(act.doer)
            return harvested
        elseif act.target.components.harvestable ~= nil then
            return act.target.components.harvestable:Harvest(act.doer)
        elseif act.target.components.stewer ~= nil then
            return act.target.components.stewer:Harvest(act.doer)
        elseif act.target.components.dryer ~= nil then
            return act.target.components.dryer:Harvest(act.doer)
        elseif act.target.components.occupiable ~= nil and act.target.components.occupiable:IsOccupied() then
            local item = act.target.components.occupiable:Harvest(act.doer)
            if item ~= nil then
                act.doer.components.container:GiveItem(item) -- here's the diff
                return true
            end
        elseif act.target.components.quagmire_tappable ~= nil then
            return act.target.components.quagmire_tappable:Harvest(act.doer)
        end
    else
        return _HarvestFn(act)
    end
end

---------------------------------------------------------------------------------------------------------

-- Add new actions

---------------------------------------------------------------------------------------------------------

-- Cast spell on self

AddAction("MANASPELL", STRINGS.musha.skills.manaspells.actionstrings.GENERIC, function(act)
    local inst = act.doer
    -- No need to worry whether player is dead, action.ghost_valid is disabled by default
    if inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("musha_spell") then
        return false
    elseif (inst.mode:value() == 0 or inst.mode:value() == 1) then
        if not inst.skills.freezingspell then
            inst.components.talker:Say(STRINGS.musha.lack_of_exp)
        elseif inst.components.timer:TimerExists("cooldown_freezingspell") then
            inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                .. STRINGS.musha.skills.manaspells.freezingspell.name
                .. STRINGS.musha.skills.incooldown.part2
                .. STRINGS.musha.skills.incooldown.part3
                .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_freezingspell"))
                .. STRINGS.musha.skills.incooldown.part4)
        elseif inst.components.mana.current < TUNING.musha.skills.freezingspell.maxmanacost then
            inst.components.talker:Say(STRINGS.musha.lack_of_mana)
            CustomPlayFailedAnim(inst)
        else
            inst.bufferedspell = "FreezingSpell"
            inst.bufferedbookfx = {
                swap_build = "swap_books",
                swap_prefix = "book_sleep",
                def = {
                    fx = "fx_book_temperature",
                    fx_under_prefab = "fx_roots_under_book",
                    layer_sound = { frame = 25, sound = "wickerbottom_rework/book_spells/silviculture" },
                }
            }
            inst.castmanaspell:push()
        end
        return true
    elseif inst.mode:value() == 2 then
        if not inst.skills.thunderspell then
            inst.components.talker:Say(STRINGS.musha.lack_of_exp)
        elseif inst.components.timer:TimerExists("cooldown_thunderspell") then
            inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                .. STRINGS.musha.skills.manaspells.thunderspell.name
                .. STRINGS.musha.skills.incooldown.part2
                .. STRINGS.musha.skills.incooldown.part3
                .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_thunderspell"))
                .. STRINGS.musha.skills.incooldown.part4)
        elseif inst.components.mana.current < TUNING.musha.skills.thunderspell.maxmanacost then
            inst.components.talker:Say(STRINGS.musha.lack_of_mana)
            CustomPlayFailedAnim(inst)
        else
            inst.bufferedspell = "ThunderSpell"
            inst.bufferedbookfx = {
                swap_build = "swap_books",
                swap_prefix = "book_moon",
                def = {
                    fx = "fx_book_rain",
                    fx_over_prefab = "fx_lightning_over_book",
                    layer_sound = { frame = 30, sound = "wickerbottom_rework/book_spells/upgraded_horticulture" },
                }
            }
            inst.castmanaspell:push()
        end
        return true
    elseif inst.mode:value() == 3 then
        if inst:HasTag("shadowprisonready") then
            if inst.components.timer:TimerExists("cooldown_shadowprison") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.manaspells.shadowprison.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_shadowprison"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.mana.current < TUNING.musha.skills.shadowprison.manacost then
                inst.components.talker:Say(STRINGS.musha.lack_of_mana)
                CustomPlayFailedAnim(inst)
            elseif inst.components.sanity.current < TUNING.musha.skills.shadowprison.sanitycost then
                inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                CustomPlayFailedAnim(inst)
            else
                inst.components.mana:DoDelta(-TUNING.musha.skills.shadowprison.manacost)
                inst.components.sanity:DoDelta(-TUNING.musha.skills.shadowprison.sanitycost)
                inst.bufferedspell = "ShadowPrison"
                inst.bufferedbookfx = {
                    swap_build = "swap_books",
                    swap_prefix = "book_tentacles",
                    def = {
                        fx = "waxwell_shadow_book_fx",
                        fx_under_prefab = "fx_tentacles_under_book",
                        layer_sound = { frame = 30, sound = "maxwell_rework/shadow_magic/cast" },
                    }
                }
                inst.castmanaspell:push()
            end
        else
            if not inst.skills.shadowspell then
                inst.components.talker:Say(STRINGS.musha.lack_of_exp)
            elseif inst.components.timer:TimerExists("cooldown_shadowspell") then
                inst.components.talker:Say(STRINGS.musha.skills.incooldown.part1
                    .. STRINGS.musha.skills.manaspells.shadowspell.name
                    .. STRINGS.musha.skills.incooldown.part2
                    .. STRINGS.musha.skills.incooldown.part3
                    .. math.ceil(inst.components.timer:GetTimeLeft("cooldown_shadowspell"))
                    .. STRINGS.musha.skills.incooldown.part4)
            elseif inst.components.sanity.current < TUNING.musha.skills.shadowspell.sanitycost then
                inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
                CustomPlayFailedAnim(inst)
            else
                inst.components.sanity:DoDelta(-TUNING.musha.skills.shadowspell.sanitycost)
                inst.activateberserk:push()
            end
        end
        return true
    else
        return false
    end
end)

ACTIONS.MANASPELL.instant = true
ACTIONS.MANASPELL.mount_valid = true
ACTIONS.MANASPELL.priority = 2 -- Mount and unmount: 1

STRINGS.ACTIONS.MANASPELL = STRINGS.musha.skills.manaspells.actionstrings

ACTIONS.MANASPELL.strfn = function(act)
    if (act.doer.mode:value() == 0 or act.doer.mode:value() == 1) then
        return "FREEZINGSPELL"
    elseif act.doer.mode:value() == 2 then
        return "THUNDERSPELL"
    elseif act.doer.mode:value() == 3 then
        if act.doer:HasTag("shadowprisonready") then
            return "SHADOWPRISON"
        else
            return "SHADOWSPELL"
        end
    else
        return "GENERIC"
    end
end

---------------------------------------------------------------------------------------------------------

-- Switch position with phantom (teleport)

AddAction("PHANTOMSPELL", STRINGS.musha.skills.phantomspells.actionstrings.GENERIC, function(act)
    local inst = act.doer
    -- No need to worry whether player is dead, action.ghost_valid is disabled by default
    if inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("musha_nointerrupt") or inst.sg:HasStateTag("musha_spell") then
        return false
    elseif inst.mode:value() == 3 then
        if act.target.owner ~= inst then
            inst.components.talker:Say(STRINGS.musha.skills.phantomspells.fail_notowner)
            return false
        elseif inst.components.sanity.current < TUNING.musha.skills.phantomspells.teleport.sanitycost then
            inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
            CustomPlayFailedAnim(inst)
            return false
        else
            inst.components.sanity:DoDelta(-TUNING.musha.skills.phantomspells.teleport.sanitycost)

            local doerpos = inst:GetPosition()
            local targetpos = act.target:GetPosition()

            if not inst.components.rider:IsRiding() then
                inst.sg:GoToState("musha_portal_jumpout", { dest = targetpos })
            else
                inst.Physics:Teleport(targetpos:Get())
                inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/hop_out")
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                CustomAttachFx(inst, "sanity_lower", nil, Vector3(2, 2, 2))
                CustomAttachFx(inst, "statue_transition_2", nil, Vector3(3, 3, 3))
            end

            act.target.Physics:Teleport(doerpos:Get())
            act.target:ForceFacePoint(targetpos:Get())
            act.target.sg:GoToState("appear")

            return true
        end
    else
        return false
    end
end)

ACTIONS.PHANTOMSPELL.instant = true
ACTIONS.PHANTOMSPELL.mount_valid = true
ACTIONS.PHANTOMSPELL.priority = 2

STRINGS.ACTIONS.PHANTOMSPELL = STRINGS.musha.skills.phantomspells.actionstrings

ACTIONS.PHANTOMSPELL.strfn = function(act)
    return "GENERIC"
end

---------------------------------------------------------------------------------------------------------

local function CastSpell(inst, doer, actions, right) -- Both inst and doer are client side objects
    if right then
        if inst:HasTag("musha") and inst == doer then
            table.insert(actions, GLOBAL.ACTIONS.MANASPELL)
        elseif inst:HasTag("musha_voidphantom") and doer.mode:value() == 3 then
            table.insert(actions, GLOBAL.ACTIONS.PHANTOMSPELL)
        end
    end
end

AddComponentAction("SCENE", "spelltarget", CastSpell) -- Note: AddComponentAction = function(actiontype, component, fn)
