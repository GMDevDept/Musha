require "prefabutil"

local tent_assets =
{
    Asset("ANIM", "anim/forge_musha.zip"),
	Asset("ANIM", "anim/forge_musha_on.zip"),
	Asset("ANIM", "anim/forge_musha_broken.zip"),
	Asset("ANIM", "anim/musha_oven_fire.zip"),
}

local function cooked(inst)
if inst.components.container ~= nil then
	local container = inst.components.container
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
	     		local replacement = nil 
				if item.components.cookable or item.prefab == "log" then 
				inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
						local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(-0.2, 0, 0)
				fx.Transform:SetPosition(pos:Get())
	
        local fx2 = SpawnPrefab("small_puff")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0, 0)
		
				end
				
		     	if item.components.cookable then 
		     		replacement = item.components.cookable:GetProduct()
		     	elseif item.prefab == "log" then 
		     		replacement = "charcoal"
					
		     	elseif item.components.burnable and not item.prefab == "log" then 
		     		replacement = "ash"				
		     	end  
		     	if replacement then 
	     			local stacksize = 1 
	     			if item.components.stackable then 
	     				stacksize = item.components.stackable:StackSize()
	     			end 
	     			local newprefab = SpawnPrefab(replacement)
	     			if newprefab.components.stackable then 
	     				newprefab.components.stackable:SetStackSize(stacksize)
	     			end 
	     			container:RemoveItemBySlot(i)
	     			item:Remove()
	     			container:GiveItem(newprefab, i)
	     		end 
		     end 
		end 
		return false 
end
end

local function duration_fire(inst, data)
	if inst.burning then
		local fuel_all = inst.components.fueled:GetPercent()*100
		local fuels_section = inst.components.fueled:GetSectionPercent()*100
	
				if inst._5 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." LV[5] "..(fuels_section).." %/ "..(fuel_all).."%")	
				elseif inst._4 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." LV[4] "..(fuels_section).." %/ "..(fuel_all).."%")
				elseif inst._3 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." LV[3] "..(fuels_section).." %/ "..(fuel_all).."%")
				elseif inst._2 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." LV[2] "..(fuels_section).." %/ "..(fuel_all).."%")
				elseif inst._1 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." LV[1] "..(fuels_section).." %/ "..(fuel_all).."%")
				elseif not inst._5 and not inst._4 and not inst._3 and not inst._2 and not inst._1 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." "..(fuels_section).." %/ "..(fuel_all).."%")
				end
	end
	
end
local function take_fuels(inst, data)
	if not inst.burning then
		local fuel_all = inst.components.fueled:GetPercent()*100
		local fuels_section = inst.components.fueled:GetSectionPercent()*100
		inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_ON.." "..(fuels_section).." %/ "..(fuel_all).."%")
	end
end
 
local function onfinishedsound(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl")
end

local function Onfinished(inst)
end

 local function forgelab_gas(inst, data)
if inst.warm_tent and inst.active_forge then
   inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
   if inst.burning then
   inst.AnimState:PlayAnimation("enter")
   else
   inst.AnimState:PlayAnimation("hit")
   end
  
	inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get()) 
		local fx = SpawnPrefab("firesplash_fx")
        fx.entity:SetParent(inst.entity)
		fx.Transform:SetScale(0.5, 0.5, 0.5)
	    fx.Transform:SetPosition(-0.2, 0, 0.5)
		
		if inst._5 then
		local fx2 = SpawnPrefab("mighty_gym_bell_perfect_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._4 then
		local fx2 = SpawnPrefab("mighty_gym_bell_perfect_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._3 then
		local fx2 = SpawnPrefab("mighty_gym_bell_succeed_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._2 then
		local fx2 = SpawnPrefab("mighty_gym_bell_succeed_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._1 then
		local fx2 = SpawnPrefab("mighty_gym_bell_fail_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		end

inst.active_forge = false
end
end 
 
 local function forgelab(inst, data)
 
if inst.burning then
 duration_fire(inst)
end
 
 --[[if inst.finished and inst.components.container then
 inst.components.container.canbeopened = false
 elseif not inst.finished and inst.components.container then
 inst.components.container.canbeopened = true
 end]]
if inst.burning and inst.AnimState:AnimDone() and inst.components.burnable:IsBurning() then
inst.AnimState:PlayAnimation("sleep_loop")
elseif not inst.burning and inst.AnimState:AnimDone() and not inst.components.burnable:IsBurning() then
inst.AnimState:PlayAnimation("idle")
end
 
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 5, {"musha_items"})
for k,v in pairs(ents) do
if inst.warm_tent and not inst.finished then
	if not v.forgelab_on then
	v.forgelab_on = true 
	end
elseif inst.warm_tent_out then
if v.forgelab_on then
 v.forgelab_on = false end
end 
if inst.finished then
v.forgelab_on = false
end
end

if inst.active_forge then
 forgelab_gas(inst) 
end

end
  
local function musha_sleep(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 6, {"musha"})
for k,v in pairs(ents) do
if inst.warm_tent then
v.warm_tent = true
elseif inst.warm_tent_out then
v.warm_tent = false
end
end 
end 


local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
	inst.burning = false
	inst.components.machine:TurnOff()
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
	if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.AnimState:PlayAnimation("hit")
	inst.burning = false
	inst.components.machine:TurnOff()
    inst.AnimState:PushAnimation("idle", true)
end


local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
end

local function wakeuptest(inst, phase)
 --   if phase ~= inst.sleep_phase then
 --       inst.components.sleepingbag:DoWakeUp()
--	end
end

local function on_near(inst)
if inst.light_on then
inst.warm_tent = true
inst.warm_tent_out = false
elseif not inst.light_on then
inst.warm_tent = false
inst.warm_tent_out = true
end  
 musha_sleep(inst)
 forgelab(inst)
 
end

local function on_far(inst)
inst.warm_tent = false
inst.warm_tent_out = true
 musha_sleep(inst)
 forgelab(inst)
end

local function on_light_forge(inst, data)

--inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")

	if inst.components.burnable ~= nil and not inst.components.burnable:IsBurning() then
	inst.burning = true
	inst.components.burnable:Ignite()
		if not inst.components.cooker then
        inst:AddComponent("cooker")
		end
	end
	
	if not inst.burning then
	inst.components.fueled:StopConsuming()
	elseif inst.burning then
	inst.components.fueled:StartConsuming()
	end


inst.AnimState:PlayAnimation("enter")
inst.AnimState:SetBuild("forge_musha_on")

inst.light_on = true
on_near(inst)
 musha_sleep(inst)
 inst.finished = false

	
end 

 -----------
local function off_light_forge(inst, data)
inst.AnimState:PlayAnimation("hit") 
	if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
    inst.components.burnable:Extinguish()
	end
	
	inst.burning = false
	inst.components.fueled:StopConsuming()
	

inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")

inst.light_on = false
inst.warm_tent = false
inst.warm_tent_out = true
inst.finished = true
on_near(inst)
 musha_sleep(inst)
 
 if not inst.components.burnable:IsBurning() then
 inst.AnimState:SetBuild("forge_musha")
 end
 
end 
-------- --------
		
local function OnOpen(inst)
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")

end 

local function auto_upgrade(inst)

local container = inst.components.container
if container ~= nil and inst.burning then
	for i = 1, container:GetNumSlots() do
	     local item = container:GetItemInSlot(i)
	    if item ~= nil and inst.burning then
				if item:HasTag("musha_items") and item.components.fueled.currentfuel < item.components.fueled.maxfuel then
				item.components.fueled:DoDelta(2500000)
					
					if item:HasTag("musha_items") and item.level ~= nil and item.level >=4000 then
						local fuel_gas = SpawnPrefab("firesplash_fx")
						fuel_gas.entity:SetParent(inst.entity)
						fuel_gas.Transform:SetPosition(-0.2, 0.5, 0.5)
						--inst.AnimState:PlayAnimation("hit")
						inst.AnimState:PushAnimation("hit", true)
						inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
					end
				end
			
			
			if item:HasTag("musha_items") and item.level ~= nil and item.level <4000 then 
				if inst._5 then
					item.level = item.level +5
				elseif inst._4 then
					item.level = item.level +4
				elseif inst._3 then
					item.level = item.level +3
				elseif inst._2 then
					item.level = item.level +2					
				elseif inst._1 then
					item.level = item.level +1	
				end
					item.check_level(item)
					
		--inst.AnimState:PlayAnimation("enter")
		inst.AnimState:PushAnimation("enter", true)
		
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get()) 
		local fx = SpawnPrefab("firesplash_fx")
        fx.entity:SetParent(inst.entity)
		fx.Transform:SetScale(0.5, 0.5, 0.5)
	    fx.Transform:SetPosition(-0.2, 0, 0.5)
		
		if inst._5 then
		local fx2 = SpawnPrefab("mighty_gym_bell_perfect_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._4 then
		local fx2 = SpawnPrefab("mighty_gym_bell_perfect_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._3 then
		local fx2 = SpawnPrefab("mighty_gym_bell_succeed_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._2 then
		local fx2 = SpawnPrefab("mighty_gym_bell_succeed_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		elseif inst._1 then
		local fx2 = SpawnPrefab("mighty_gym_bell_fail_fx")
        fx2.entity:SetParent(inst.entity)
	    fx2.Transform:SetPosition(-0.2, 0.5, 0)
		end
		
			end
		end	
	end	
end
end

local function OnClose(inst) 
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
cooked(inst)

end
 
local function TakeItem(inst, item, data)

	SpawnPrefab("orange_leaves").Transform:SetPosition(inst:GetPosition():Get())
	
	if not inst.finished then
	--inst.AnimState:PlayAnimation("hit")
	 inst.AnimState:PushAnimation("hit", true)
	elseif inst.finished then 
	inst.finished = false
	--inst.AnimState:PlayAnimation("enter")
	 inst.AnimState:PushAnimation("enter", true)
	--[[scheduler:ExecuteInTime(1, function()
	inst.AnimState:SetBuild("forge_musha_on")
	inst.AnimState:PlayAnimation("place") inst.AnimState:PushAnimation("idle", true) 
	end)]]
	end

	take_fuels(inst)
end
 
local function onpreload(inst, data)

	if data ~= nil then
		if data.burning ~= nil then
		inst.burning = true
		end
	end	
end
		
local function onsave(inst, data)
	--data.duration = inst.duration
   -- if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
   --     data.burnt = true
   -- end
   if dater ~= nil then
	data.burning = inst.burning
	end		
   
end

local function onload(inst, data)
  --  if data ~= nil and data.burnt then
  --      inst.components.burnable.onburnt(inst)
  --  end
end

local function complete_onactivate(inst)
    --inst.AnimState:PlayAnimation("use")
    inst.AnimState:PushAnimation("enter", true)

    inst._activecount = inst._activecount + 1

    if not inst.SoundEmitter:PlayingSound("sound") then
        inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
    end

end

local function fn(Sim)
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

 	MakeObstaclePhysics(inst, 1)

    inst:AddTag("forge_musha")
    inst:AddTag("structure")
	--inst:AddTag("altar")
	inst:AddTag("stone")
	inst:AddTag("giftmachine")
	--inst:AddTag("prototyper")

       --  inst:AddTag("level2")
		
    inst.AnimState:SetBank("tent")
    inst.AnimState:SetBuild("forge_musha")
    inst.AnimState:PlayAnimation("idle")  

    inst.MiniMapEntity:SetIcon( "forge_musha.tex" )

    MakeSnowCoveredPristine(inst)
	
	inst.entity:AddLight()
	--[[inst.Light:SetRadius(5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.8)]]
	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.8)
    inst.Light:SetColour(180/255,180/255,180/255)	
	inst.Light:Enable(true)
	inst.light_on = false
	
	--[[inst:AddComponent("prototyper")
	inst.components.prototyper.onactivate = complete_onactivate
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.ANCIENTALTAR_LOW]]
	
	inst:AddComponent("fueled")
	
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_light_forge
    inst.components.machine.turnofffn = off_light_forge
    inst.components.machine.cooldowntime = 0	
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 21
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(0,-780,0)
    inst.components.talker.symbol = "swap_object"
   	
	
	inst:AddComponent("burnable")
    --inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX*5
    inst.components.fueled.accepting = true

		inst.components.fueled.fueltype = "BURNABLE"
		--inst.components.fueled:InitializeFuelLevel(100)
		inst.components.fueled.maxfuel = 1000
		inst.components.fueled:InitializeFuelLevel(200)
        inst.components.fueled:SetDepletedFn(off_light_forge)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
		inst.components.fueled:StopConsuming() 	

    inst.components.fueled:SetSections(5)
    inst.components.fueled.bonusmult = 2
    inst.components.fueled.ontakefuelfn = function()
        inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
        local fx2 = SpawnPrefab("small_puff")
        fx2.entity:SetParent(inst.entity)
        fx2.Transform:SetPosition(-0.2, 0, 0)
    end
    inst.components.fueled.rate = 1

    inst.components.fueled:SetUpdateFn(
			function()
            if inst.light_on and inst.components.burnable and inst.components.fueled then
                inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
            end
			end
			)

    inst.components.fueled:SetSectionCallback(
        function(section)
            if section == 0 then
				if inst.components.burnable:IsBurning() then
                inst.components.burnable:Extinguish()
				inst.components.machine:TurnOff()
				end
				
            else
			inst._5 = false
			inst._4 = false
			inst._3 = false
			inst._2 = false
			inst._1 = false
				if section == 5 then
					inst._5 = true
				elseif section == 4 then
					inst._4 = true
				elseif section == 3 then
					inst._3 = true
				elseif section == 2 then
					inst._2 = true
				elseif section == 1 then
					inst._1 = true	
				end
				if inst.components.burnable:IsBurning() then
					inst.burning = true
					inst.components.machine:TurnOn()
				end
			
                if inst.burning and not inst.components.burnable:IsBurning() then
                    inst.components.burnable:Ignite()
					inst.components.machine:TurnOn()
                end
                inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            end
        end
    )
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)
    inst.components.burnable:AddBurnFX("musha_ovenfire", Vector3(-0.2 ,-0.1, 0) )

    inst:ListenForEvent("onextinguish", off_light_forge)
    inst:ListenForEvent("onignite", on_light_forge)
	
    inst.entity:SetPristine()

  	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chest_yamche0") 
		end
		return inst
	end

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	
       inst._activecount = 0
        inst._activetask = nil
    inst:AddComponent("inspectable")
		
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(5)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
		
	inst:DoPeriodicTask(10, function()
	auto_upgrade(inst) end)
	inst:DoPeriodicTask(1, function()
	forgelab(inst) end)
	
  --  MakeSnowCovered(inst)
    inst:ListenForEvent("onbuilt", onbuilt)

  --  MakeLargeBurnable(inst, nil, nil, true)
 --   MakeMediumPropagator(inst)
	
	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 4)
    inst.components.playerprox:SetOnPlayerNear(on_near)
    inst.components.playerprox:SetOnPlayerFar(on_far)


    --inst.OnSave = onsave 
    --inst.OnLoad = onload
	--inst.OnPreLoad = onpreload


    MakeHauntableWork(inst)

    return inst
end
 
return Prefab("common/objects/forge_musha", fn, tent_assets),
    MakePlacer("common/forge_musha_placer", "tent", "forge_musha", "idle")
 
