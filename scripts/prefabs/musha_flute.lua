local assets=
{
	Asset("ANIM", "anim/musha_flute.zip"),
	Asset("ATLAS", "images/inventoryimages/musha_flute.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_flute.tex"),
}

local function onfinished(inst)
	if not inst.broken then
	inst:RemoveComponent("instrument")
	inst.broken = true
end end

local function Hearmusha(inst, musician, instrument, data)
local user = musician
if not inst.broken then
	if inst.components.health ~= nil and inst.components.sanity ~= nil and inst:HasTag("musha") then
	inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
	end
	if inst.components.health ~= nil and inst.components.sanity ~= nil and inst:HasTag("player") then
	inst.components.health:DoDelta(40) 
	inst.components.sanity:DoDelta(3)
	local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.4, .4, .4)
    heal_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	
		local fx2 = SpawnPrefab("mighty_gym_bell_succeed_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(0, 2.5, 0)
	
	--SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
		
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch and not inst:HasTag("ghound") and not inst.light_on then
		inst.AnimState:SetBloomEffectHandle( "" ) end end)
	end
	if inst.components.health ~= nil and (inst:HasTag("companion") or inst:HasTag("yamcheb") or inst:HasTag("critter")) then
 	inst.components.health:DoDelta(250) 
	local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.4, .4, .4)
    heal_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	--SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
		
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch and not inst:HasTag("ghound") and not inst.light_on then
		inst.AnimState:SetBloomEffectHandle( "" ) end end)
		
	end
        if inst.components.farmplanttendable ~= nil then
		inst.components.farmplanttendable:TendTo(musician)
		SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
		end
			
		user.components.playercontroller:Enable(false)
		user:DoTaskInTime(2.4, function() user.components.playercontroller:Enable(true) end)

end	
end

local function TakeItem(inst, item, data)
	inst.components.finiteuses:SetUses(10)
		if inst.broken then
		inst.broken = false
		end
if inst.components.instrument == nil then 
	inst:AddComponent("instrument")
	inst.components.instrument.range = TUNING.PANFLUTE_SLEEPRANGE
    inst.components.instrument:SetOnHeardFn(Hearmusha)
end 
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
 MakeInventoryPhysics(inst) 
 	
    inst.AnimState:SetBank("pan_flute")
    inst.AnimState:SetBuild("musha_flute")
	inst.AnimState:PlayAnimation("idle")
	inst:AddTag("flute")
  	inst:AddTag("musha_flute")
	   inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_flute.tex" )

  inst.entity:SetPristine()
	   if not TheWorld.ismastersim then
        return inst
    end
		
    inst:AddComponent("inspectable")
    inst:AddComponent("instrument")
    inst.components.instrument.range = TUNING.PANFLUTE_SLEEPRANGE
    inst.components.instrument:SetOnHeardFn(Hearmusha)
    
    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.PLAY)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished( onfinished)
	 
    inst.components.finiteuses:SetConsumption(ACTIONS.PLAY, 1)
	
	inst:AddComponent("fueled")
    inst.components.fueled.fueltype = "CAVE"
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true 
		
    inst:AddComponent("inventoryitem")
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_flute.xml"
  
MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, function(inst, haunter)
        if math.random() <= TUNING.HAUNT_CHANCE_HALF then
            if inst.components.finiteuses then
                inst.components.finiteuses:Use(1)
                inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
                return true
            end
        end
        return false
    end, true, false, true)

    return inst
end

return Prefab( "common/inventory/musha_flute", fn, assets) 
