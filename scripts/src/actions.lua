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
AddAction("MANASPELL", STRINGS.musha.manaspell.GENERIC, function(act)
    -- No need to worry whether player is dead, action will be disabled anyway
    if (act.doer.mode:value() == 0 or act.doer.mode:value() == 1) and act.doer.skills.freezingspell then
        act.doer:FreezingSpell()
        return true
    elseif act.doer.mode:value() == 2 and act.doer.skills.thunderspell then
        return true
    elseif act.doer.mode:value() == 3 and act.doer.skills.shadowspell then
        return true
    else
        return false
    end
end)

ACTIONS.MANASPELL.instant = true

-- ACTIONS.MANASPELL.str = STRINGS.musha.manaspell
STRINGS.ACTIONS.MANASPELL = STRINGS.musha.manaspell

ACTIONS.MANASPELL.strfn = function(act)
    if (act.doer.mode:value() == 0 or act.doer.mode:value() == 1) and act.doer.skills.freezingspell then
        return "FREEZINGSPELL"
    elseif act.doer.mode:value() == 2 and act.doer.skills.thunderspell then
        return "THUNDERSPELL"
    elseif act.doer.mode:value() == 3 and act.doer.skills.shadowspell then
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
