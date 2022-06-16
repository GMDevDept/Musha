local assets=
{
	Asset("ANIM", "anim/arrowm.zip"),
    Asset("ATLAS", "images/inventoryimages/bowm.xml"),
    Asset("IMAGE", "images/inventoryimages/bowm.tex"),
    Asset("ATLAS", "images/inventoryimages/arrowm.xml"),
    Asset("IMAGE", "images/inventoryimages/arrowm.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow0.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow0.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow1.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow1.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow2.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow2.tex"),
    Asset("ATLAS", "images/inventoryimages/arrowm_broken.xml"),
    Asset("IMAGE", "images/inventoryimages/arrowm_broken.tex"),
	
}
 
 
local function arrowm_broken()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_red")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("arrowm_broken")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/arrowm_broken.xml"
	inst:AddComponent("tradable")
	inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunchAndIgnite(inst)

	
    return inst
end


local function no_aggro(attacker, target)
	local targets_target = target.components.combat ~= nil and target.components.combat.target or nil
	return targets_target ~= nil and targets_target:IsValid() and targets_target ~= attacker and attacker ~= nil and attacker:IsValid()
			and (GetTime() - target.components.combat.lastwasattackedbytargettime) < 4
			and (targets_target.components.health ~= nil and not targets_target.components.health:IsDead())
end

local function OnAttack(inst, attacker, target)
local impactfx = SpawnPrefab("impact")
	if impactfx and attacker then
		local follower = impactfx.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		impactfx:FacePoint(attacker.Transform:GetWorldPosition())
	end
end

local function OnPreHit(inst, attacker, target)
    if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		target.components.combat.temp_disable_aggro = no_aggro(attacker, target)
	end
end
 
local function OnHit(inst, attacker, target)
	--[[local impactfx = SpawnPrefab("impact")
	if impactfx and attacker then
		local follower = impactfx.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		impactfx:FacePoint(attacker.Transform:GetWorldPosition())
	end]]

if target:HasTag("bird") or target:HasTag("rabbit") or target:HasTag("butterfly") then
	if math.random() < 0.4 then
	SpawnPrefab("arrowm").Transform:SetPosition(target:GetPosition():Get())
	else
	SpawnPrefab("arrowm_broken").Transform:SetPosition(target:GetPosition():Get())
	end

else

	if math.random() < 0.7 then
		if target.components.inventory ~= nil then
		target.components.inventory:GiveItem(SpawnPrefab("arrowm"))
		elseif target.components.inventory == nil and target.components.container ~= nil then
		target.components.container:GiveItem(SpawnPrefab("arrowm"))
		elseif target.components.inventory == nil and target.components.container == nil then
		SpawnPrefab("arrowm").Transform:SetPosition(target:GetPosition():Get())
		end
	else
		SpawnPrefab("arrowm_broken").Transform:SetPosition(target:GetPosition():Get())
	end

end	
	
	inst:Remove()
end

local function OnMiss(inst, owner, target)

    inst:Remove()
end


local function onthrown(inst, data)
	inst.AnimState:SetOrientation( ANIM_ORIENTATION.OnGround )
end

local function projectile_fn(anim, tags, removephysicscolliders)
 	local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    --inst.Transform:SetFourFaced()

    --MakeProjectilePhysics(inst)
	MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("dart_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
    inst:AddTag("projectile")
	inst:AddTag("NOCLICK")
	inst:AddTag("sharp")
	inst:AddTag("weapon")

	if removephysicscolliders then
        RemovePhysicsColliders(inst)
    end

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.5, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.persists = false
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(10)
	inst.components.weapon:SetOnAttack(OnAttack)
	
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(45)
	inst.components.projectile:SetHoming(false)
	inst.components.projectile:SetOnPreHitFn(OnPreHit)
    inst.components.projectile:SetOnHitFn(OnHit)
	inst.components.projectile:SetOnMissFn(OnMiss)
	inst.components.projectile.range = 30
	inst.components.projectile:SetLaunchOffset(Vector3(0,1.1,0))
	
	inst:ListenForEvent("onthrown", onthrown)
	
	--[[inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(35)
    inst.components.projectile:SetHoming(false)
    inst.components.projectile:SetHitDist(1.5)
    inst.components.projectile:SetOnPreHitFn(OnPreHit)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(OnMiss)
    inst.components.projectile.range = 30
	inst.components.projectile.has_damage_set = true
	
	inst.components.projectile:SetLaunchOffset(Vector3(0,1.1,0))]]
	
    return inst
end
 
 
 local function onloadammo(inst, data)
	if data ~= nil and data.slingshot then
		data.slingshot:AddTag("extinguisher")
	end
end

local function onunloadammo(inst, data)
	if data ~= nil and data.slingshot then
		data.slingshot:RemoveTag("extinguisher")
	end
end

local function arrow_normal(removephysicscolliders)
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("arrowm")
	inst:AddTag("slingshotammo")
	inst:AddTag("reloaditem_ammo")
	
	if removephysicscolliders then
        RemovePhysicsColliders(inst)
    end
	
	--MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.5, 0.75})
	local swap_data = {bank = "blow_dart", anim = "idle_pipe"}
    MakeInventoryFloatable(inst, "small", 0.2, 0.65, nil, nil, swap_data)
	
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("reloaditem")
	
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	--inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/arrowm.xml"
	inst:AddComponent("tradable")

	
    return inst
end
 
 
 local function dummy_to_arrow(inst)
 local player = inst.components.inventoryitem.owner
 local arrow = SpawnPrefab("arrowm")
 local arrow2 = SpawnPrefab("arrowm")
  if player ~= nil and player.components.inventory then
  player.components.inventory:GiveItem(arrow)
  player.components.inventory:GiveItem(arrow2)
  else
  SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
  arrow.Transform:SetPosition(inst:GetPosition():Get())
  arrow2.Transform:SetPosition(inst:GetPosition():Get())
  end
  inst:Remove()
  end
  
 local function dummy_to_arrow3(inst)
 local player = inst.components.inventoryitem.owner
 local arrow = SpawnPrefab("arrowm")
 local arrow2 = SpawnPrefab("arrowm")
 local arrow3 = SpawnPrefab("arrowm")
 local arrow4 = SpawnPrefab("arrowm")
 local arrow5 = SpawnPrefab("arrowm")
 local arrow6 = SpawnPrefab("arrowm")
 
  if player ~= nil and player.components.inventory then
  player.components.inventory:GiveItem(arrow)
  player.components.inventory:GiveItem(arrow2)
  player.components.inventory:GiveItem(arrow3)
  player.components.inventory:GiveItem(arrow4)
  player.components.inventory:GiveItem(arrow5)
  player.components.inventory:GiveItem(arrow6)
  
  else
  SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
  arrow.Transform:SetPosition(inst:GetPosition():Get())
  arrow2.Transform:SetPosition(inst:GetPosition():Get())
  arrow3.Transform:SetPosition(inst:GetPosition():Get())
  arrow4.Transform:SetPosition(inst:GetPosition():Get())
  arrow5.Transform:SetPosition(inst:GetPosition():Get())
  arrow6.Transform:SetPosition(inst:GetPosition():Get())
  
  end
  inst:Remove()
  end  
 

local function dummy_arrow0()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("dummy_arrow")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dummy_arrow0.xml"
	inst:DoTaskInTime(0.5, function()	dummy_to_arrow(inst) end)
	
    return inst
end

local function dummy_arrow1()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("dummy_arrow")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dummy_arrow1.xml"
	inst:DoTaskInTime(0.5, function()	dummy_to_arrow(inst) end)
	
    return inst
end

local function dummy_arrow2()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("dummy_arrow")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dummy_arrow2.xml"
	inst:DoTaskInTime(0.5, function()	dummy_to_arrow(inst) end)
	
	
    return inst
end

local function dummy_arrow3()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("dummy_arrow")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dummy_arrow3.xml"
	inst:DoTaskInTime(0.5, function()	dummy_to_arrow(inst) end)
	
	
    return inst
end

local function dummy_arrow4()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("blow_dart")
    inst.AnimState:SetBuild("arrowm")
    inst.AnimState:PlayAnimation("idle_pipe")
	inst.Transform:SetScale(1, 1.45, 1)
	
	inst:AddTag("dummy_arrow")
	inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
        return inst
    end
	inst:AddComponent("inspectable")
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/dummy_arrow2.xml"
	inst:DoTaskInTime(0.5, function()	dummy_to_arrow3(inst) end)
	
    return inst
end

return Prefab( "arrowm", arrow_normal, assets),
Prefab( "dummy_arrow0", dummy_arrow0, assets),
Prefab( "dummy_arrow1", dummy_arrow1, assets),
Prefab( "dummy_arrow2", dummy_arrow2, assets),
Prefab( "dummy_arrow3", dummy_arrow3, assets),
Prefab( "dummy_arrow4", dummy_arrow4, assets),
Prefab( "bowm_projectile", projectile_fn, assets),
Prefab( "arrowm_broken", arrowm_broken, assets)
	