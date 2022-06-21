local assets = {
	Asset("ANIM", "anim/inventories/frosthammer.zip"),
	Asset("ANIM", "anim/inventories/swap_frosthammer.zip"),
	Asset("ANIM", "anim/inventories/swap_frosthammer2.zip"),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
}

local prefabs = {
    "icespike_fx_1",
    "icespike_fx_2",
    "icespike_fx_3",
    "icespike_fx_4",
}

-- Exp to level
local function update_level(inst)
    if inst.exp >= 4000 then
        inst.level = 30
        inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. "[ LEVEL MAX ]")
    else
        local exp_to_level = {10,30,50,70,90,120,150,180,210,250,350,450,550,650,750,850,950,1050,1200,1400,1600,1800,2000,2200,2400,2600,2800,3000,4000,9999} -- len = 30
        for i,v in ipairs(exp_to_level) do
            if inst.exp < v then
                inst.level = i
                break
            end
        end
        inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.exp).."/"..exp_to_level[inst.level])
    end
end

-- Check weapon status and set damage
local function update_damage(inst)
    if inst.components.fueled:IsEmpty() then
        inst.broken = true
    elseif not inst.components.fueled:IsEmpty() then
        inst.broken = false
    end

    if inst.broken then
        inst.components.weapon:SetDamage(1)
        inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
    elseif not inst.broken then
        local level_to_damage = {75,77,79,81,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,120,130,140,150,160,170,180,190,200}
        inst.components.weapon:SetDamage(level_to_damage[inst.level])
        inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV"..inst.level..")\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..level_to_damage[inst.level]..")")
    end
end

-- Broken anime
local function fx_splash(inst)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
        local fx = SpawnPrefab("firesplash_fx")
        fx.Transform:SetScale(0.2, 0.2, 0.2)
        fx.Transform:SetPosition(owner:GetPosition():Get())
    end	
end

-- Dynamic anime when boost mode is on
local function fx_boost(inst)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
        inst.boost_fx = SpawnPrefab("lantern_winter_fx_held")
        inst.boost_fx.entity:AddFollower():FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
            
        local fx = SpawnPrefab("weaponsparks")
        fx.entity:AddFollower():FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
    end	
end

-- On attack
local function onattack(inst, attacker, target, data)
    update_damage(inst)
    
    local freezechance1 = 0.42
    local freezechance2 = 0.52
    local freezechance3 = 0.62
    local expchance = 0.1
    local damagedur1 = 0.2
    local damagedur2 = 0.5
    local damagedur3 = 0.7
    local damagedur4 = 1

    local fx = SpawnPrefab("groundpoundring_fx")
    local fx2 = SpawnPrefab("groundpoundring_fx")
    local pos = Vector3(target.Transform:GetWorldPosition())
    fx.Transform:SetScale(0.3, 0.3, 0.3)
    fx2.Transform:SetScale(1.2, 1.2, 1.2)
    fx.Transform:SetPosition(pos:Get())
    TheWorld:DoTaskInTime(1, function() fx2.Transform:SetPosition(pos:Get()) end)

    if target and not inst.broken then
        inst.components.fueled:DoDelta(-50000)
    elseif target and inst.broken then
        fx_splash(inst)
        inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
    end
    
    if target.components.freezable then
        target.components.freezable:AddColdness(1.65)
        target.components.freezable:SpawnShatterFX()
        local prefab = "icespike_fx_"..math.random(1,4)
        local fx = SpawnPrefab(prefab)
        fx.Transform:SetScale(1.0, 2, 1.0)
        fx.Transform:SetPosition(target:GetPosition():Get())
    end	

    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat and not target:HasTag("companion") then
        target.components.combat:SuggestTarget(attacker)
    end

    fx_boost(inst)
end

-- Reticule
local function yellow_reticuletargetfn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0, 0))
end

-- On put in inventory
local function onputininventory(inst)
    update_damage(inst)
end

-- On equip
local function onequip(inst, owner)
    -- Check owner
    if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
        owner.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
        owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
    end
    
    update_damage(inst)

    owner.frost = true
    owner.frosthammer_equipped = true
    if inst.boost then
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
		owner.AnimState:Show("ARM_carry") 
		owner.AnimState:Hide("ARM_normal")
    end
        owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal")
    end
end

-- On unequip
local function onunequip(inst, owner) 
    inst.power = false
    owner.frost = false
    owner.frosthammer_equipped = false

    if inst.components.heater then
        inst:RemoveComponent("heater")
    end
    if inst.components.reticule then
        inst:RemoveComponent("reticule")
    end
    if inst.components.spellcaster then
        inst:RemoveComponent("spellcaster")
    end
    if inst.task then 
        inst.task:Cancel() inst.task = nil 
    end

    update_damage(inst)

    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    if inst.boost_fx then
        inst.boost_fx:Remove()
    end
end

-- Boost mode on (right click)
local function boost_on(inst)
    local owner = inst.components.inventoryitem.owner
    if owner ~= nil then
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
		owner.AnimState:Show("ARM_carry") 
		owner.AnimState:Hide("ARM_normal")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    fx_boost(inst)
    inst.boost = true
end	
    
-- Boost mode off (right click)
local function boost_off(inst, data)
    local owner = inst.components.inventoryitem.owner 
    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
    inst.power = false
    inst.boost = false

    if inst.components.heater then
        inst:RemoveComponent("heater")
    end
    if inst.components.spellcaster then
        inst:RemoveComponent("spellcaster")
    end
    if owner ~= nil then
        owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
    end
    if inst.boost_fx then
        inst.boost_fx:Remove()
    end
end

-- On fuel deplete
local function ondeplete(inst, data)
    update_damage(inst)
end

-- On add fuel
local function onaddfuel(inst, item, data)
    inst.components.fueled:DoDelta(8000000)
    inst.broken = false 
    fx_splash(inst)
    update_damage(inst)  

    local expchance0 = 1
    local expchance1 = 0.3
    local expchance2 = 0.2
    local expchance3 = 0.12  

    if not inst.forgelab_on then
            inst.exp = inst.exp + 2
            inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
            update_level(inst)
        end
    -- elseif inst.forgelab_on then
    --     inst.active_forge = true

    --     inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    -- end
end


-- On save 
local function onsave(inst, data)
	data.exp = inst.exp
end

-- On preload
local function onpreload(inst, data)
	if data then
		if data.exp then
		    inst.exp = data.exp
			update_level(inst)
        end
	end
end

-- On load
local function onload(inst, data)
    update_damage(inst)
end

-- Main function
local function fn()
    local inst = CreateEntity()
    
    inst:AddTag("waterproofer")
    inst:AddTag("musha_items")
    inst:AddTag("frost_hammer")
        
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()    
    inst.entity:SetPristine()

    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("frosthammer")
    inst.AnimState:SetBuild("frosthammer")
    inst.AnimState:PlayAnimation("idle")

    inst.MiniMapEntity:SetIcon( "frosthammer.tex" )

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)

    inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

    inst:AddComponent("weapon")
    inst.components.weapon:SetOnAttack(onattack)
    inst.components.weapon:SetRange(1.6)
        
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = yellow_reticuletargetfn
    inst.components.reticule.ease = true
	
    if not TheWorld.ismastersim then
        return inst
    end
  
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")    
    inst.components.inventoryitem:SetOnPutInInventoryFn(onputininventory)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/frosthammer.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    
    inst:AddComponent("machine")
    inst.components.machine.turnonfn = boost_on
    inst.components.machine.turnofffn = boost_off
    inst.components.machine.cooldowntime = 0
    
    inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(boost_on)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "BURNABLE"
    inst.components.fueled:InitializeFuelLevel(40000000)    
    inst.components.fueled:SetDepletedFn(ondeplete)
    inst.components.fueled.ontakefuelfn = onaddfuel
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()        
    
    inst.exp = 0 
    inst.level = 1
    inst.boost = false  
    -- inst.check_exp = expexp 
    -- inst:ListenForEvent("expup", expexp)

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    inst.OnLoad = onload
    
    return inst
end

    
return Prefab( "common/inventory/frosthammer", fn, assets, prefabs) 