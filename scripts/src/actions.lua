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
                swap_prefix = "book_moon",
                def = {
                    fx = "fx_book_temperature",
                    layer = "FX_fish",
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
                swap_prefix = "book_horticulture_upgraded",
                def = {
                    fx = "fx_book_rain",
                    layer = "FX_lightning",
                    layer_sound = { frame = 30, sound = "wickerbottom_rework/book_spells/upgraded_horticulture" },
                }
            }
            inst.castmanaspell:push()
        end
        return true
    elseif inst.mode:value() == 3 then
        if not inst.skills.shadowspell then
            inst.components.talker:Say(STRINGS.musha.lack_of_exp)
        elseif inst.components.sanity.current < TUNING.musha.skills.shadowspell.sanitycost then
            inst.components.talker:Say(STRINGS.musha.lack_of_sanity)
            CustomPlayFailedAnim(inst)
        else
            inst.components.sanity:DoDelta(TUNING.musha.skills.shadowspell.sanitycost)
            inst.activateberserk:push()
        end
        return true
    else
        return false
    end
end)

ACTIONS.MANASPELL.instant = true

STRINGS.ACTIONS.MANASPELL = STRINGS.musha.skills.manaspells.actionstrings

ACTIONS.MANASPELL.strfn = function(act)
    if (act.doer.mode:value() == 0 or act.doer.mode:value() == 1) then
        return "FREEZINGSPELL"
    elseif act.doer.mode:value() == 2 then
        return "THUNDERSPELL"
    elseif act.doer.mode:value() == 3 then
        return "SHADOWSPELL"
    else
        return "GENERIC"
    end
end

local function CastSpellOnSelf(inst, doer, actions, right)
    if right then
        if inst:HasTag("musha") and inst == doer then
            table.insert(actions, GLOBAL.ACTIONS.MANASPELL)
        end
    end
end

AddComponentAction("SCENE", "spelltarget", CastSpellOnSelf) -- Note: AddComponentAction = function(actiontype, component, fn)
