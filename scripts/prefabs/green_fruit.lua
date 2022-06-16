local assets=
{
	Asset("ANIM", "anim/green_fruit.zip"),
	Asset("ANIM", "anim/green_fruit_cooked.zip"),
  Asset("ATLAS", "images/inventoryimages/green_fruit.xml"),
  Asset("IMAGE", "images/inventoryimages/green_fruit.tex"),
  Asset("ATLAS", "images/inventoryimages/green_fruit_cooked.xml"),
  Asset("IMAGE", "images/inventoryimages/green_fruit_cooked.tex"),
}
local function item_oneaten(inst, eater)
if eater.components.stamina_sleep then
eater.components.fatigue_sleep:DoDelta(-10)
eater.components.stamina_sleep:DoDelta(3)
end
if eater.components.spellpower then
eater.components.spellpower:DoDelta(5)
end
end
local function item_oneaten2(inst, eater)
if eater.components.stamina_sleep then
eater.components.fatigue_sleep:DoDelta(-15)
eater.components.stamina_sleep:DoDelta(5)
end
if eater.components.spellpower then
eater.components.spellpower:DoDelta(10)
end
end

AddIngredientValues({"green_fruit"}, {fruit=1}, true)
AddIngredientValues({"green_fruit_cooked"}, {fruit=1}, true)

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("green_fruit")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("cookable")
	inst:AddTag("green_fruit")
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
	inst.Transform:SetScale(0.7,0.6,0.7)  
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
    inst.components.fuel.fueltype = "CAVE"
	
     inst:AddComponent("tradable")
     inst:AddComponent("edible")
     --inst.components.edible.foodtype = "VEGGIE"
	 inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst.components.edible.sanityvalue = 6
    inst.components.edible.healthvalue = 3
    inst.components.edible.hungervalue = 5
	inst.components.edible:SetOnEatenFn(item_oneaten)
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_BRIEF
			
		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
	
    --[[local light = inst.entity:AddLight()
    light:SetFalloff(0.6)
    light:SetIntensity(.5)
    light:SetRadius(0.25)
    light:SetColour(69/255, 131/255, 145/255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )]]
	

    ---------------------       
    
    inst:AddComponent("inspectable")
	--inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/green_fruit.xml"
	
        inst:AddComponent("cookable")
        inst.components.cookable.product = "green_fruit_cooked"
		
    return inst
end

local function fn_cooked()
	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("green_fruit_cooked")
    inst.AnimState:PlayAnimation("idle")
	inst:AddTag("green_fruit")
	     inst.entity:SetPristine()
     if not TheWorld.ismastersim then
        return inst
    end	
	
	inst.Transform:SetScale(0.7,0.6,0.7)  
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	--inst:AddComponent("fuel")
    --inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
    --inst.components.fuel.fueltype = "CAVE"
	
     inst:AddComponent("tradable")
     inst:AddComponent("edible")
     --inst.components.edible.foodtype = "VEGGIE"
	 inst.components.edible.foodtype = FOODTYPE.VEGGIE

    inst.components.edible.sanityvalue = 12
    inst.components.edible.healthvalue = 6
    inst.components.edible.hungervalue = 5
	inst.components.edible:SetOnEatenFn(item_oneaten)
	inst.components.edible.temperaturedelta = TUNING.COLD_FOOD_BONUS_TEMP
	inst.components.edible.temperatureduration = TUNING.FOOD_TEMP_BRIEF
			
		inst:AddComponent("perishable")
		inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
		inst.components.perishable:StartPerishing()
		inst.components.perishable.onperishreplacement = "spoiled_food"
  
    ---------------------       
    
    inst:AddComponent("inspectable")
	--inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/green_fruit_cooked.xml"
	
  	
    return inst
end


-----------------

return Prefab( "green_fruit", fn, assets),
		Prefab( "green_fruit_cooked", fn_cooked, assets)
