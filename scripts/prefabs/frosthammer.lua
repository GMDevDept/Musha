local assets = {
	Asset("ANIM", "anim/inventories/frosthammer.zip"),
	Asset("ANIM", "anim/inventories/frosthammer2.zip"),
	Asset("ANIM", "anim/inventories/swap_frosthammer.zip"),
	Asset("ANIM", "anim/inventories/swap_frosthammer2.zip"),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
}

local prefabs = {}

-- Check weapon status and set damage
local function update_damage(inst)
    if inst.components.fueled:IsEmpty() then
        inst.broken = true
        inst.components.weapon:SetDamage(1)
    else
        inst.broken = false
        local level_to_damage = {75,77,79,81,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,120,127,134,141,148,155,162,170,200} -- len = 30
        inst.components.weapon:SetDamage(level_to_damage[inst.level])
    end
end

-- Exp to level
local function update_level(inst)
    if inst.exp >= 4000 then
        inst.level = 30
        inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. "[ LEVEL MAX ]")
    else
        local exp_to_level = {10,30,50,70,90,120,150,180,210,250,350,450,550,650,750,850,950,1050,1200,1400,1600,1800,2000,2200,2400,2600,2800,3000,4000} -- len = 29
        for i,v in ipairs(exp_to_level) do
            if inst.exp < v then
                inst.level = i
                inst.required_exp = v
                break
            end
        end
        inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.exp).."/"..exp_to_level[inst.level])
    end
    update_damage(inst)
end

-- Broken effects
local function fx_broken(inst)
    local owner = inst.components.inventoryitem.owner
    local fx = SpawnPrefab("weaponsparks")
    if owner then
        fx.entity:AddFollower():FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
    else
        local offset = Vector3(0, 2.4, 0)
        fx.Transform:SetPosition((inst:GetPosition() + offset):Get())
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
end

-- Add fuel effects
local function fx_addfuel(inst)
    local owner = inst.components.inventoryitem.owner
    if owner then
        local fx = SpawnPrefab("firesplash_fx")
        fx.Transform:SetScale(0.3, 0.3, 0.3)
        fx.Transform:SetPosition(owner:GetPosition():Get())
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    end	
end

-- Dynamic anime when boost mode is on
local function fx_boost(inst)
    local owner = inst.components.inventoryitem.owner
    if owner then
        inst.boost_fx = SpawnPrefab("lantern_winter_fx_held")
        inst.boost_fx.entity:AddFollower():FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
            
        local fx = SpawnPrefab("weaponsparks")
        fx.entity:AddFollower():FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
    end	
end

-- Words to declare on boost
local function speak_boost_on(inst)
    local str1 = "["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."]\n"
        ..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..inst.components.weapon.damage..")\n"

    local str2 = inst.level<30 and "EXP ( "..inst.exp.."/"..inst.required_exp.." )\n" or ""

    local str3 = STRINGS.MUSHA_WEAPON_AREA.."\n"
        ..STRINGS.MUSHA_WEAPON_FREEZESLOW.."\n"

    local str4 = STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"

    local str5 = STRINGS.MUSHA_WEAPON_COOLER.."\n"

    local str6 = inst.level<30 and "LV ( "..inst.level.."/30 )\n" or "LV ( "..inst.level.."/30 ) [ MAX ]\n"
    
    local declaration = str1..str6..str2..str3..str4..str5
    return declaration
end

-- Words to declare on boost off
local function speak_boost_off(inst)
    local str1 = "["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."]\n"
        ..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..inst.components.weapon.damage..")\n"

    local str2 = inst.level<30 and "EXP ( "..inst.exp.."/"..inst.required_exp.." )\n" or ""

    local str6 = inst.level<30 and "LV ( "..inst.level.."/30 )\n" or "LV ( "..inst.level.."/30 ) [ MAX ]\n"
    
    local declaration = str1..str6..str2
    return declaration
end

-- Reticule (gamepad support)
local function yellow_reticuletargetfn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0, 0))
end

-- On attack
local function onattack(inst, attacker, target, data)    
    local fx = SpawnPrefab("groundpoundring_fx")
    fx.Transform:SetScale(0.45, 0.45, 0.45)
    fx.Transform:SetPosition(target:GetPosition():Get())

    if target and not inst.broken then
        inst.components.fueled:DoDelta(-50)

        if inst.boost then
            local range = 2
            local excludetags = { "INLIMBO", "notarget", "noattack", "invisible", "playerghost", "companion", "wall", "musha_companion" }
            attacker.components.combat:DoAreaAttack(target, range, inst, nil, nil, excludetags)
        end

        if target.components.freezable then
            target.components.freezable:AddColdness(1.65)
            target.components.freezable:SpawnShatterFX()
            local prefab = "icespike_fx_"..math.random(1,4)
            local fx = SpawnPrefab(prefab)
            fx.Transform:SetScale(1.0, 2, 1.0)
            fx.Transform:SetPosition(target:GetPosition():Get())
        end	


    elseif target and inst.broken then
        fx_broken(inst)
    end

    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
end

-- On put in inventory
local function onputininventory(inst)
end

-- On dropped to ground
local function ondropped(inst)
    if inst.boost then
        inst.AnimState:SetBuild("frosthammer2")
    else
        inst.AnimState:SetBuild("frosthammer")
    end
end

-- On pick up
local function onpickup(inst)
end

-- On equip
local function onequip(inst, owner)
    -- Check owner
    if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
        owner.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
        owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
    end

    if not inst.boost then
        inst.components.talker:Say(speak_boost_off(inst))
        owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    else
        fx_boost(inst)
        inst.components.talker:Say(speak_boost_on(inst))
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
    end
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")

    owner.frost = true
    owner.frosthammer_equipped = true
end

-- On unequip
local function onunequip(inst, owner) 
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
        inst.task:Cancel() 
        inst.task = nil 
    end

    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    if inst.boost_fx then
        inst.boost_fx:Remove()
    end
end

-- Boost mode on (right click)
local function boost_on(inst)
    local owner = inst.components.inventoryitem.owner
    if owner then
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
    else
        inst.AnimState:SetBuild("frosthammer2")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
    inst.components.talker:Say(speak_boost_on(inst))
    inst.components.equippable.walkspeedmult = 0.75
    inst.boost = true
    fx_boost(inst)
end	
    
-- Boost mode off (right click)
local function boost_off(inst, data)
    local owner = inst.components.inventoryitem.owner 
    if owner then
        owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    else
        inst.AnimState:SetBuild("frosthammer")
    end

    if inst.components.heater then
        inst:RemoveComponent("heater")
    end
    if inst.components.spellcaster then
        inst:RemoveComponent("spellcaster")
    end
    if inst.boost_fx then
        inst.boost_fx:Remove()
    end

    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
    inst.components.talker:Say(speak_boost_off(inst))
    inst.components.equippable.walkspeedmult = 1
    inst.boost = false
end

-- On fuel deplete
local function ondeplete(inst, data)
    update_damage(inst)
end

-- On add fuel
local function onaddfuel(inst, item, data)
    local expchance0 = 1
    local expchance1 = 0.3
    local expchance2 = 0.2
    local expchance3 = 0.12  

    if not inst.forgelab_on then
            inst.exp = inst.exp + 1995
            inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
        end
    -- elseif inst.forgelab_on then
    --     inst.active_forge = true
    -- end
    inst.components.fueled:DoDelta(500)
    fx_addfuel(inst)
    update_level(inst)
end

-- On save 
local function onsave(inst, data)
	data.exp = inst.exp
end

-- On preload
local function onpreload(inst, data)
	if data then
		if data.exp then
		    inst.exp = math.min(data.exp, 4000)
        end
	end
end

-- On load
local function onload(inst, data)
    update_level(inst)
    update_damage(inst)
end

-- Main function
local function fn()
    local inst = CreateEntity()

    inst:AddTag("musha_items")
    inst:AddTag("musha_equipment")
    inst:AddTag("frost_hammer")
        
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()    
    inst.entity:SetPristine()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "small", 0.07, 0.73)

    inst.AnimState:SetBank("frosthammer")
    inst.AnimState:SetBuild("frosthammer")
    inst.AnimState:PlayAnimation("idle")

    inst.MiniMapEntity:SetIcon( "frosthammer.tex" )
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)

    inst:AddComponent("weapon")
    inst.components.weapon:SetOnAttack(onattack)
    inst.components.weapon:SetRange(1.6)
        
    inst:AddComponent("reticule") -- for gampad support
    inst.components.reticule.targetfn = yellow_reticuletargetfn
    inst.components.reticule.ease = true
  
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")    
    inst.components.inventoryitem:SetOnPutInInventoryFn(onputininventory)
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPickupFn(onpickup)
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
    inst.components.fueled:InitializeFuelLevel(1000)    
    inst.components.fueled:SetDepletedFn(ondeplete)
    inst.components.fueled.ontakefuelfn = onaddfuel
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()        

    MakeHauntableLaunch(inst)
    
    inst.exp = 0 
    inst.level = 1
    inst.required_exp = 10
    inst.boost = false

    inst.OnSave = onsave
    inst.OnPreLoad = onpreload
    inst.OnLoad = onload
    
    return inst
end

    
return Prefab( "common/inventory/frosthammer", fn, assets, prefabs) 