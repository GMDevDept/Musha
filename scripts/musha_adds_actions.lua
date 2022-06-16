local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS

ACTIONS.TURNON.priority = 3
ACTIONS.TURNOFF.priority = 2
ACTIONS.ABANDON.priority = 5
--ACTIONS.PET.priority = 0
--ACTIONS.RUMMAGE.priority = 2

ACTIONS.USEITEM.fn = function(act)
	if act.invobject ~= nil and act.invobject:HasTag("musha_items") and not act.invobject.mushacrown and
        act.invobject.components.useableitem ~= nil and act.invobject.components.machine ~= nil and
        act.doer.components.inventory ~= nil then
		if not act.invobject.boost then
		act.invobject.components.machine:TurnOn()
		return true
		end
		if act.invobject.boost then
		act.invobject.components.machine:TurnOff()
		return true
		end
    elseif act.invobject ~= nil and act.invobject:HasTag("musha_items") and act.invobject.mushacrown and
        act.invobject.components.useableitem ~= nil and
        act.invobject.components.useableitem:CanInteract() and
        act.doer.components.inventory ~= nil and
        act.doer.components.inventory:IsOpenedBy(act.doer) then
        return act.invobject.components.useableitem:StartUsingItem()
		
	elseif act.invobject ~= nil and not act.invobject:HasTag("musha_items") and
        act.invobject.components.useableitem ~= nil and
        act.invobject.components.useableitem:CanInteract() and
        act.doer.components.inventory ~= nil and
        act.doer.components.inventory:IsOpenedBy(act.doer) then
        return act.invobject.components.useableitem:StartUsingItem()	
    end
end


ACTIONS.TURNON.str = STRINGS.ACTIONS.TURNON
ACTIONS.TURNON.id = "TURNON"
ACTIONS.TURNON.strfn = function(act)
	local targ = act.target or act.invobject

	if targ:HasTag("critter") then
		STRINGS.ACTIONS.TURNON = (STRINGS.CRITTER_ACTION_TURNON)
		return 

	else
		STRINGS.ACTIONS.TURNON = (STRINGS.ACTIONS.TURNON)
		return 
	end	
end

ACTIONS.TURNON.fn = function(act)
    local tar = act.target or act.invobject
	local owner = act.target.components.follower and act.target.components.follower.leader
	
	if tar:HasTag("musha_items") then
	return false
	end
	
	if tar and not tar:HasTag("critter") then
    if tar and tar.components.machine and not tar.components.machine:IsOn() then
        tar.components.machine:TurnOn(tar)
        return true
	end
	
	
	elseif tar and tar:HasTag("critter") and not tar:HasTag("musha_items") and act.doer.components.petleash ~= nil then
		
	if act.doer.despawn then

		if tar.despawn_confirm and tar.components.talker and owner == act.doer then
			if act.target.components.container then
		act.target.components.container:DropEverything() 
			end
			if act.target.components.inventory then
		act.target.components.inventory:DropEverything() 
			end
			
			act.doer.components.talker:Say(STRINGS.CRITTER_BYEBYE)
			act.doer.components.petleash:DespawnPet(act.target)
			return true
		elseif not tar.despawn_confirm and tar.components.talker and owner == act.doer then
			tar.components.talker:Say(STRINGS.CRITTER_SAD)
			act.doer.components.talker:Say(STRINGS.CRITTER_BYE)
			tar.sg:GoToState("hungry")
			tar.despawn_confirm = true
			return true
		end
	
	elseif not act.doer.despawn then
		
		if tar.woby and not act.doer.bigwoby_cool then
			tar.item_ready_drop = false
			tar.working_food = false
			tar.pick1 = false
			if tar.sg.currentstate.name ~= "transform" and not tar.transforming then
        tar.persists = false
        tar:AddTag("NOCLICK")
        tar.transforming = true

			if tar.components.container:IsOpen() then
            tar.components.container:Close()
			end
            tar:PushEvent("transform")
			
			act.doer.bigwoby_cool = true
			act.doer:DoTaskInTime( 60, function()
				act.doer.bigwoby_cool = false
			 end)
			end
			return	
		elseif tar.woby and act.doer.bigwoby_cool then
			act.doer.components.talker:Say(STRINGS.CRITTER_BIGWOBY_COOL)
		
			return
		elseif not tar.woby then
	if tar.components.machine and not tar.components.machine:IsOn() and owner == act.doer and not tar.components.container:IsFull() then
		if not tar:HasTag("musha_items") then
		tar.components.machine:TurnOn(tar)
        return true
		end
	elseif tar.components.machine and not tar.components.machine:IsOn() and owner == act.doer and tar.components.container:IsFull() then
		tar.components.talker:Say(STRINGS.CRITTER_INV_FULL)
		act.doer.components.talker:Say(STRINGS.CRITTER_REFUSE_INV)
        return false	
		
	elseif tar.components.machine and not tar.components.machine:IsOn() and owner ~= act.doer then
        return false	
    end
		if tar.despawn_confirm then
		tar.despawn_confirm = false 
		end
	end
		end

end
end

ACTIONS.ADDFUEL.str = STRINGS.ACTIONS.ADDFUEL
ACTIONS.ADDFUEL.id = "ADDFUEL"

ACTIONS.ADDFUEL.strfn = function(act)
	local targ = act.target or act.invobject

	if targ:HasTag("musha_items") then
		STRINGS.ACTIONS.ADDFUEL = (STRINGS.MUSHA_ACTION_REPAIR)
		return 
	else
		STRINGS.ACTIONS.ADDFUEL = (STRINGS.ACTIONS.ADDFUEL)
		return 
	end	
end
ACTIONS.ADDFUEL.fn = function(act)
    if act.doer.components.inventory then
        local fuel = act.doer.components.inventory:RemoveItem(act.invobject)
        if fuel then
            if act.target.components.fueled:TakeFuelItem(fuel, act.doer) then
                return true
            else
                --print("False")
                act.doer.components.inventory:GiveItem(fuel)
            end
        end
    end
end

ACTIONS.RUMMAGE.fn = function(act)
    local targ = act.target or act.invobject

if targ ~= nil and targ.components.container ~= nil and not targ:HasTag("critter") and not targ:HasTag("yamcheb") then
   
        if targ.components.container:IsOpenedBy(act.doer) then
            targ.components.container:Close(act.doer)
            act.doer:PushEvent("closecontainer", { container = targ })
            return true
        elseif targ:HasTag("mastercookware") and not act.doer:HasTag("masterchef") then
            return false, "NOTMASTERCHEF"
        --elseif targ:HasTag("professionalcookware") and not act.doer:HasTag("professionalchef") then
            --return false, "NOTPROCHEF"
        elseif not targ.components.container:IsOpenedBy(act.doer) and not targ.components.container:CanOpen() then
            return false, "INUSE"
        elseif targ.components.container.canbeopened then
            local owner = targ.components.inventoryitem ~= nil and targ.components.inventoryitem:GetGrandOwner() or nil
            if owner ~= nil and (targ.components.quagmire_stewer ~= nil or targ.components.container.droponopen) then
                if owner == act.doer then
                    owner.components.inventory:DropItem(targ, true, true)
                elseif owner.components.container ~= nil and owner.components.container:IsOpenedBy(act.doer) then
                    owner.components.container:DropItem(targ)
                else
                    --Silent fail, should not reach here
                    return true
                end
            end
            --Silent fail for opening containers in the dark
            if CanEntitySeeTarget(act.doer, targ) then
                act.doer:PushEvent("opencontainer", { container = targ })
                targ.components.container:Open(act.doer)
            end
            return true
        end
 end   
if targ ~= nil and targ.components.container ~= nil and (targ:HasTag("critter") or targ:HasTag("yamcheb")) then
    local leader = targ.components.follower.leader
	if act.doer == leader then
        if targ.components.container:IsOpenedBy(act.doer) then
            targ.components.container:Close(act.doer)
            act.doer:PushEvent("closecontainer", { container = targ })
            return true
        elseif targ:HasTag("mastercookware") and not act.doer:HasTag("masterchef") then
            return false, "NOTMASTERCHEF"
        --elseif targ:HasTag("professionalcookware") and not act.doer:HasTag("professionalchef") then
            --return false, "NOTPROCHEF"
        elseif not targ.components.container:IsOpenedBy(act.doer) and not targ.components.container:CanOpen() then
            return false, "INUSE"
        elseif targ.components.container.canbeopened then
            local owner = targ.components.inventoryitem ~= nil and targ.components.inventoryitem:GetGrandOwner() or nil
            if owner ~= nil and (targ.components.quagmire_stewer ~= nil or targ.components.container.droponopen) then
                if owner == act.doer then
                    owner.components.inventory:DropItem(targ, true, true)
                elseif owner.components.container ~= nil and owner.components.container:IsOpenedBy(act.doer) then
                    owner.components.container:DropItem(targ)
                else
                    --Silent fail, should not reach here
                    return true
                end
            end
            --Silent fail for opening containers in the dark
            if CanEntitySeeTarget(act.doer, targ) then
                act.doer:PushEvent("opencontainer", { container = targ })
                targ.components.container:Open(act.doer)
            end
            return true
        end
	elseif targ.house then 
			if targ.components.container:IsOpenedBy(act.doer) then
				targ.components.container:Close(act.doer)
				act.doer:PushEvent("closecontainer", { container = targ })
            return true
			elseif CanEntitySeeTarget(act.doer, targ) then
                act.doer:PushEvent("opencontainer", { container = targ })
                targ.components.container:Open(act.doer)
			return true		
            end

    end
	
	
	end
end


ACTIONS.PICKUP.fn = function(act)

if act.doer.critter_musha or act.doer:HasTag("yamcheb") then	
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

end
if not act.doer.critter_musha and not act.doer:HasTag("yamcheb") then	


    if act.doer.components.inventory ~= nil and
        act.target ~= nil and
        act.target.components.inventoryitem ~= nil and
        (act.target.components.inventoryitem.canbepickedup or
        (act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
        not (act.target:IsInLimbo() or
            (act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
            (act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

        if act.doer.components.itemtyperestrictions ~= nil and not act.doer.components.itemtyperestrictions:IsAllowed(act.target) then
            return false, "restriction"
        elseif act.target.components.container ~= nil and act.target.components.container:IsOpenedByOthers(act.doer) then
            return false, "INUSE"
        elseif (act.target.components.yotc_racecompetitor ~= nil and act.target.components.entitytracker ~= nil) then
            local trainer = act.target.components.entitytracker:GetEntity("yotc_trainer")
            if trainer ~= nil and trainer ~= act.doer then
                return false, "NOTMINE_YOTC"
            end
		elseif act.doer.components.inventory.noheavylifting and act.target:HasTag("heavy") then
			return false, "NO_HEAVY_LIFTING"
        end

        if (act.target:HasTag("spider") and act.doer:HasTag("spiderwhisperer")) and 
           (act.target.components.follower.leader ~= nil and act.target.components.follower.leader ~= act.doer) then
            return false, "NOTMINE_SPIDER"
        end

        if act.target.components.inventory ~= nil and act.target:HasTag("drop_inventory_onpickup") then
            act.target.components.inventory:TransferInventory(act.doer)
        end

        act.doer:PushEvent("onpickupitem", { item = act.target })

        if act.target.components.equippable ~= nil and not act.target.components.equippable:IsRestricted(act.doer) then
            local equip = act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot)
            if equip ~= nil and not act.target.components.inventoryitem.cangoincontainer then
                --special case for trying to carry two backpacks
                if equip.components.inventoryitem ~= nil and equip.components.inventoryitem.cangoincontainer then
                    --act.doer.components.inventory:SelectActiveItemFromEquipSlot(act.target.components.equippable.equipslot)
                    act.doer.components.inventory:GiveItem(act.doer.components.inventory:Unequip(act.target.components.equippable.equipslot))
                else
                    act.doer.components.inventory:DropItem(equip)
                end
                act.doer.components.inventory:Equip(act.target)
                return true
            elseif act.doer:HasTag("player") then
                if equip == nil or act.doer.components.inventory:GetNumSlots() <= 0 then
                    act.doer.components.inventory:Equip(act.target)
                    return true
                elseif GetGameModeProperty("non_item_equips") then
                    act.doer.components.inventory:DropItem(equip)
                    act.doer.components.inventory:Equip(act.target)
                    return true
                end
            end
        end

        act.doer.components.inventory:GiveItem(act.target, nil, act.target:GetPosition())
        return true
    end
end
end

ACTIONS.HARVEST.fn = function(act)
if act.doer.critter_musha or act.doer:HasTag("yamcheb") then
	if act.target.components.crop ~= nil then
        local harvested--[[, product]] = act.target.components.crop:Harvest(act.doer)
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
            act.doer.components.container:GiveItem(item)
            return true
        end
	elseif act.target.components.quagmire_tappable ~= nil then
		return act.target.components.quagmire_tappable:Harvest(act.doer)
    end
end	
if not act.doer.critter_musha and not act.doer:HasTag("yamcheb") then	

    if act.target.components.crop ~= nil then
        local harvested--[[, product]] = act.target.components.crop:Harvest(act.doer)
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
            act.doer.components.inventory:GiveItem(item)
            return true
        end
	elseif act.target.components.quagmire_tappable ~= nil then
		return act.target.components.quagmire_tappable:Harvest(act.doer)
    end
end
end

----
ACTIONS.FEED.fn = function(act)
    	
	if act.target and not act.target.critter_musha then
	
	if act.target.components.trader then
        local abletoaccept, reason = act.target.components.trader:AbleToAccept(act.invobject,act.doer)
        if abletoaccept then
            act.target.components.trader:AcceptGift(act.doer, act.invobject, 1)
            return true
        else
            return false, reason
        end

    elseif act.doer ~= nil and act.target ~= nil and act.target.components.eater ~= nil and act.target.components.eater:CanEat(act.invobject) then
        act.target.components.eater:Eat(act.invobject, act.doer)
        local murdered =
            act.target:IsValid() and
            act.target.components.health ~= nil and
            act.target.components.health:IsDead() and
            act.target or nil

        if murdered ~= nil then
            murdered.causeofdeath = act.doer

            local owner = murdered.components.inventoryitem ~= nil and murdered.components.inventoryitem.owner or nil
            if owner ~= nil then
                --In inventory or container:
                --Slightly different from MURDER action since victim ate and died
                --in place, so there should be no looting animation, and the loot
                --should always replace the victim's old slot.
                local grandowner = murdered.components.inventoryitem:GetGrandOwner()
                local x, y, z = grandowner.Transform:GetWorldPosition()
                murdered.components.inventoryitem:RemoveFromOwner(true)
                murdered.Transform:SetPosition(x, y, z)

                if murdered.components.health.murdersound ~= nil and grandowner.SoundEmitter then
                    grandowner.SoundEmitter:PlaySound(FunctionOrValue(murdered.components.health.murdersound, murdered, act.doer))
                end

                if murdered.components.lootdropper ~= nil then
                    local container = owner.components.inventory or owner.components.container
                    if container ~= nil then
                        local stacksize = murdered.components.stackable ~= nil and murdered.components.stackable:StackSize() or 1
                        for i = 1, stacksize do
                            local loots = murdered.components.lootdropper:GenerateLoot()
                            for k, v in pairs(loots) do
                                local loot = SpawnPrefab(v)
                                if loot ~= nil then
                                    container:GiveItem(loot, murdered.prevslot)
                                end
                            end
                        end
                    end
                end
            end

            act.doer:PushEvent("killed", { victim = murdered })

            if owner ~= nil then
                murdered:Remove()
            end
        end
        return true	
		
		end
		
	elseif act.target and act.target.critter_musha then
		
	if act.doer ~= nil and act.target ~= nil and act.target.components.eater ~= nil and act.target.components.eater:CanEat(act.invobject) then
		local pet = act.target
		if pet:HasTag("woby") then
				pet.components.eater:Eat(act.invobject, act.doer)
				return true
		elseif not pet:HasTag("woby") and pet:HasTag("critter") then
			if pet.components.perishable:GetPercent() <= 0.95 then
				pet.components.eater:Eat(act.invobject, act.doer)
				pet.master_gift = true
				return true
			elseif pet.components.perishable:GetPercent() > 0.95 then
				local random_half = math.random(1, 3)
					if random_half == 1 then
				pet.components.talker:Say(STRINGS.CRITTER_REFUSE)
					elseif random_half == 2 then
				pet.components.talker:Say(STRINGS.CRITTER_REFUSE2)
					elseif random_half == 3 then
				pet.components.talker:Say(STRINGS.CRITTER_REFUSE3)
					end
					pet.sg:GoToState("hungry")
				return false
		
			else
				pet.components.talker:Say(STRINGS.CRITTER_REFUSE3)
				pet.sg:GoToState("hungry")
				return false
			end
		end
	end
    end
end
