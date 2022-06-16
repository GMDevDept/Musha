local assets =
{

	Asset("ANIM", "anim/woby_big_build.zip"),
    Asset("ANIM", "anim/woby_big_transform.zip"),
    Asset("ANIM", "anim/woby_big_travel.zip"),
    Asset("ANIM", "anim/woby_big_mount_travel.zip"),
    Asset("ANIM", "anim/woby_big_mount_basic.zip"),
    Asset("ANIM", "anim/woby_big_actions.zip"),
    Asset("ANIM", "anim/woby_big_basic.zip"),
    Asset("ANIM", "anim/woby_big_boat_jump.zip"),

    Asset("ANIM", "anim/ui_woby_3x3.zip"),

    Asset("ANIM", "anim/pupington_woby_build.zip"),
    Asset("SOUND", "sound/beefalo.fsb"),
	
    Asset("ANIM", "anim/beefalo_basic.zip"),
	Asset("ANIM", "anim/arong_build.zip"),
    Asset("ANIM", "anim/beefalo_actions.zip"),
    Asset("ANIM", "anim/beefalo_actions_domestic.zip"),
	Asset("ANIM", "anim/beefalo_actions_quirky.zip"),
 
  --  Asset("ANIM", "anim/beefalo_shaved_build.zip"),
  
	Asset("ANIM", "anim/arong_baby_build.zip"),

  -- Asset("ANIM", "anim/beefalo_domesticated.zip"),
 	Asset("ANIM", "anim/arong_personality_docile.zip"),
    Asset("ANIM", "anim/arong_personality_ornery.zip"),
    Asset("ANIM", "anim/arong_personality_pudgy.zip"),

    Asset("ANIM", "anim/beefalo_fx.zip"),
    Asset("SOUND", "sound/beefalo.fsb"),
}

local prefabs =
{
    "wobysmall",
}

local brain = require("brains/arong_dogbrain")

local function levelexp(inst,data)

	local max_exp = 1200
	local level = math.min(inst.level, max_exp)

if inst.full_level then
	--inst.level = 160

	--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 6\n"..STRINGS.CRITTER_LEVEL_EXP.."\nDamage:65")
	inst.level1 = false
	inst.level2 = false
	inst.level3 = false
	inst.level4 = false
	inst.level5 = false
	inst.level6 = true
--inst.components.combat:SetDefaultDamage(65)

end

if inst.level_off then
	inst.level = 0
	inst.level1 = true
	inst.level2 = false
	inst.level3 = false
	inst.level4 = false
	inst.level5 = false
	inst.level6 = false
	--inst.components.combat:SetDefaultDamage(15)

end

if not inst.full_level and not inst.level_off then

if inst.level >=0 and inst.level <=9 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 1\n"..STRINGS.CRITTER_LEVEL_EXP..": "..(inst.level).."/10\nDamage:15")
if not inst.level2 and not inst.level3 and not inst.level4 and not inst.level5 and not inst.level6 then
inst.level1 = true
end
--inst.components.combat:SetDefaultDamage(15)
	elseif inst.level >9 and inst.level1 and not inst.level2 then
		inst.levelsup = true
    		
		
		inst.level1 = false
		inst.level2 = true

elseif inst.level >9 and inst.level <=29 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 2\n"..STRINGS.CRITTER_LEVEL_EXP..": "..(inst.level).."/30\nDamage:25")
if not inst.level3 and not inst.level4 and not inst.level5 and not inst.level6 then
inst.level2 = true
end
--inst.components.combat:SetDefaultDamage(25)
	elseif inst.level >29 and inst.level2 and not inst.level3 then
		inst.levelsup = true
    		
			
		inst.level1 = false
		inst.level2 = false
		inst.level3 = true

elseif inst.level >29 and inst.level <=59 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 3\n"..STRINGS.CRITTER_LEVEL_EXP..": "..(inst.level).."/60\nDamage:35")
if not inst.level4 and not inst.level5 and not inst.level6 then
inst.level3 = true
end
--inst.components.combat:SetDefaultDamage(35)
	elseif inst.level >59 and inst.level3 and not inst.level4 then
	inst.levelsup = true
    		
			
		inst.level1 = false
		inst.level2 = false
		inst.level3 = false
		inst.level4 = true

elseif inst.level >59 and inst.level <=99 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 4\n"..STRINGS.CRITTER_LEVEL_EXP..": "..(inst.level).."/100\nDamage:45")
if not inst.level5 and not inst.level6 then
inst.level4 = true
end
--inst.components.combat:SetDefaultDamage(45)
	elseif inst.level >99 and inst.level4 and not inst.level5 then
	inst.levelsup = true
    		
		
		inst.level1 = false
		inst.level2 = false
		inst.level3 = false
		inst.level4 = false
		inst.level5 = true

elseif inst.level >99 and inst.level <=159 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 5\n"..STRINGS.CRITTER_LEVEL_EXP..": "..(inst.level).."/160\nDamage:55")
if not inst.level6 then
inst.level5 = true
end
--inst.components.combat:SetDefaultDamage(55)
	elseif inst.level >159 and inst.level5 and not inst.level6 then
	inst.levelsup = true
    		
		
		inst.level1 = false
		inst.level2 = false
		inst.level3 = false
		inst.level4 = false
		inst.level5 = false
		inst.level6 = true

elseif inst.level >159 then
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_LEVEL.." 6\nDamage:65")
inst.level6 = true
--inst.components.combat:SetDefaultDamage(65)
end

end
end

local function ClearBuildOverrides(inst, animstate)
    local basebuild = "arong_big_build"
    if animstate ~= inst.AnimState then
        animstate:ClearOverrideBuild(basebuild)
    end
    -- this presumes that all the face builds have the same symbols
    animstate:ClearOverrideBuild(basebuild)
end

-- This takes an anim state so that it can apply to itself, or to its rider
local function ApplyBuildOverrides(inst, animstate)
    local basebuild = "arong_big_build"
    if animstate ~= nil and animstate ~= inst.AnimState then
        animstate:AddOverrideBuild(basebuild)
    else
        animstate:SetBuild(basebuild)
    end
end

local function TriggerTransformation(inst)
    if inst.sg.currentstate.name ~= "transform" and not inst.transforming then
        inst.persists = false
        inst:AddTag("NOCLICK")
        inst.transforming = true

        inst.components.rideable.canride = false

        if inst.components.container:IsOpen() then
            inst.components.container:Close()
        end

        if inst.components.rideable:IsBeingRidden() then
            --SG won't handle "transformation" event while we're being ridden
            --SG is forced into transformation state AFTER dismounting (OnRiderChanged)
            inst.components.rideable:Buck(true)
        else
            inst:PushEvent("transform")
        end
    end
end



local function SetRunSpeed(inst, speed)
    if speed == nil then
        return
    end

    inst.components.locomotor.runspeed = speed
    local rider = inst.components.rideable:GetRider()
    if rider and rider.player_classified ~= nil then
        rider.player_classified.riderrunspeed:set(speed)
    end
end

local function OnHungerDelta(inst, data)
    if data.newpercent >= 0.7 then
        SetRunSpeed(inst, TUNING.WOBY_BIG_SPEED.FAST)
    elseif data.newpercent >= 0.33 then
        SetRunSpeed(inst, TUNING.WOBY_BIG_SPEED.MEDIUM)
    else
        SetRunSpeed(inst, TUNING.WOBY_BIG_SPEED.SLOW)
    end
end

local function ShouldAcceptItem(inst, item)
if inst.components.eater:CanEat(item) and inst.components.perishable:GetPercent() < 0.95 then
    	return true
	else
		return false
	end
end
local function ShouldAcceptItem(inst, item)
local hunger_percent = inst.components.perishable:GetPercent()
    if item.components.edible and hunger_percent <= 0.95 then
        return inst.components.eater:CanEat(item) 
    end 
end
local function OnGetItemFromPlayer(inst, giver, item)
if inst.components.eater:CanEat(item) and inst.components.perishable:GetPercent() < 0.95 then
   
	end
end

local function OnRefuseItem(inst, item)
local hunger_percent = inst.components.perishable:GetPercent()
inst.sg:GoToState("hungry")
	if hunger_percent >= 0.95 then
	local random_half = math.random(1, 2)
		if random_half == 1 then
	--inst.components.talker:Say(STRINGS.CRITTER_REFUSE)
		else
	--inst.components.talker:Say(STRINGS.CRITTER_REFUSE2)
		end
	else
	
	--inst.components.talker:Say(STRINGS.CRITTER_REFUSE3)
	end
end

local function transforming(inst, item)

end

local function oneat(inst, food)

if food.prefab ~= "mandrakesoup" then

if food.prefab == "meatballs" then
--inst.components.talker:Say("♥")

inst.level = inst.level + 1
levelexp(inst)
end
end

if food.prefab == "mandrakesoup" then 
	inst.level = inst.level + 30
	
	levelexp(inst)
--inst.components.talker:Say(STRINGS.CRITTER_LEVEL_EXP.."★+30")
	
elseif food.prefab ~= "mandrakesoup" then  
	
	if food.components.edible and food.components.edible.hungervalue >= 75 or food.components.edible.healthvalue >= 40 then
		inst.level = inst.level + 3
		
		levelexp(inst)
	elseif food.components.edible and food.components.edible.hungervalue < 75 and food.components.edible.hungervalue >= 40 then
		inst.level = inst.level + 2
		
		levelexp(inst)
	elseif food.components.edible and food.components.edible.hungervalue < 40 and food.components.edible.hungervalue >= 25 then
		inst.level = inst.level + 1
		
		levelexp(inst)
	elseif food.components.edible and food.components.edible.hungervalue < 25 and food.components.edible.hungervalue >= 12 and math.random() < 0.5 then
		inst.level = inst.level + 1
		
		levelexp(inst)
	elseif food.components.edible and food.components.edible.hungervalue < 12 and food.components.edible.hungervalue >= 9 and math.random() < 0.25 then
		inst.level = inst.level + 1
		
		levelexp(inst)		
	elseif food.components.edible and food.components.edible.hungervalue < 9 and food.components.edible.hungervalue >= 5 and math.random() < 0.15 then
		inst.level = inst.level + 1
			
		levelexp(inst)
	elseif food.components.edible and food.components.edible.hungervalue < 5 and math.random() < 0.1 then
		inst.level = inst.level + 1
			
		levelexp(inst)	
		end
end
end


local function OnStarving(inst)
    TriggerTransformation(inst)
end

local function DoRiderSleep(inst, sleepiness, sleeptime)
    inst._ridersleeptask = nil
end

local function OnRiderChanged(inst, data)

    if inst._ridersleeptask ~= nil then
        inst._ridersleeptask:Cancel()
        inst._ridersleeptask = nil
    end

    if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
    end

    if inst.components.hunger:GetPercent() <= 0 then
        if inst.sg.currentstate.name ~= "transform" then
            -- The SG won't listen for the event right now, so we wait a frame
            inst:DoTaskInTime(0, function() inst:PushEvent("transform") end)
        end
    end
end

local function OnRiderSleep(inst, data)
    inst._ridersleep = inst.components.rideable:IsBeingRidden() and {
        time = GetTime(),
        sleepiness = data.sleepiness,
        sleeptime = data.sleeptime,
    } or nil
end

local function LinkToPlayer(inst, player)
    inst._playerlink = player
    inst.components.follower:SetLeader(player)

    inst:ListenForEvent("onremove", inst._onlostplayerlink, player)
end

local function OnPlayerLinkDespawn(inst)
	if inst.components.container ~= nil then
		inst.components.container:Close()
		inst.components.container.canbeopened = false

		if GetGameModeProperty("drop_everything_on_despawn") then
			inst.components.container:DropEverything()
		else
			inst.components.container:DropEverythingWithTag("irreplaceable")
		end
	end

	if inst.components.drownable ~= nil then
		inst.components.drownable.enabled = false
	end

	local fx = SpawnPrefab(inst.spawnfx)
	fx.entity:SetParent(inst.entity)

	inst.components.colourtweener:StartTween({ 0, 0, 0, 1 }, 13 * FRAMES, inst.Remove)

	if not inst.sg:HasStateTag("busy") then
		inst.sg:GoToState("despawn")
	end
end

local function FinishTransformation(inst)
    local items = inst.components.container:RemoveAllItems()
	local player = inst._playerlink
    local new_woby = ReplacePrefab(inst, "wobysmall")
	
    for i,v in ipairs(items) do
        new_woby.components.container:GiveItem(v)
    end

	if player ~= nil then
		new_woby:LinkToPlayer(player)
	    player:OnWobyTransformed(new_woby)
	end
	
	if new_woby.components.machine then
	new_woby.components.machine:TurnOff()
	end
if inst.level ~= nil then 
	new_woby.level = inst.level end
if inst.level1 ~= nil then 	
	new_woby.level1 = inst.level1 end
if inst.level2 ~= nil then 
	new_woby.level2 = inst.level2 end
if inst.level3 ~= nil then 
	new_woby.level3 = inst.level3 end
if inst.level4 ~= nil then 
	new_woby.level4 = inst.level4 end
if inst.level5 ~= nil then 
	new_woby.level5 = inst.level5 end
if inst.level6 ~= nil then 
	new_woby.level6 = inst.level6 end	
	
end
local function OnOpen(inst)
inst.openc = true
    if not inst.components.health:IsDead() then
		inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()

if not inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("pleased")
elseif inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("shaved")
end
inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/shake_off")
end
if inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
end
if inst.components.freezable:IsFrozen() then
        inst.components.freezable:Unfreeze()
    end
end 

local function OnClose(inst) 
inst.openc = false
    if not inst.components.health:IsDead() then
inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/shake_off")
    if inst.AnimState:IsCurrentAnimation("alert_idle") then
        inst.AnimState:PlayAnimation("alert_pre") end
	if not inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("refuse")
elseif inst.components.sleeper:IsAsleep() then
inst.sg:GoToState("shaved")
end
    end
end 

local WAKE_TO_FOLLOW_DISTANCE = 6
local SLEEP_NEAR_LEADER_DISTANCE = 5

local function IsLeaderSleeping(inst)
    return inst.components.follower.leader and inst.components.follower.leader:HasTag("sleeping")
end

local function IsLeaderTellingStory(inst)
    local leader = inst.components.follower.leader
    return leader and leader.components.storyteller and leader.components.storyteller:IsTellingStory()
end

local function ShouldWakeUp(inst)
    return not (IsLeaderSleeping(inst) or IsLeaderTellingStory(inst)) or not inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return (IsLeaderSleeping(inst) or IsLeaderTellingStory(inst)) and inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE)
end

local function onpreload(inst, data)
	if data ~= nil then
		
		if data.level then
		inst.level = data.level
		end
		if data.level1 then
		inst.level1 = data.level1
		end
		if data.level2 then
		inst.level2 = data.level2
		end
		if data.level3 then
		inst.level3 = data.level3
		end
		if data.level4 then
		inst.level4 = data.level4
		end
		if data.level5 then
		inst.level5 = data.level5
		end
		if data.level6 then
		inst.level6 = data.level6
		end
		levelexp(inst)
	end
end
local function OnSave(inst, data)
	
	if data ~= nil and data.level then 
	data.level = inst.level:GetSaveRecord() 
	end
		
	data.level = inst.level or nil
	data.level1 = inst.level1 or nil
	data.level2 = inst.level2 or nil
	data.level3 = inst.level3 or nil
	data.level4 = inst.level4 or nil
	data.level5 = inst.level5 or nil
	data.level6 = inst.level6 or nil
	data.holololo = inst.holololo or nil
	data.feeling = inst.feeling or nil
		levelexp(inst)
	
    if inst.wormlight ~= nil then
        data.wormlight = inst.wormlight:GetSaveRecord()
    end

end

local function OnLoad(inst, data)

	if data ~= nil then
		if data.level then
		inst.level = data.level
		end
		if data.level1 then
		inst.level1 = data.level1
		end
		if data.level2 then
		inst.level2 = data.level2
		end
		if data.level3 then
		inst.level3 = data.level3
		end
		if data.level4 then
		inst.level4 = data.level4
		end
		if data.level5 then
		inst.level5 = data.level5
		end
		if data.level6 then
		inst.level6 = data.level6
		end
		levelexp(inst)
	end

    if data ~= nil and data.wormlight ~= nil and inst.wormlight == nil then
        local wormlight = SpawnSaveRecord(data.wormlight)
        if wormlight ~= nil and wormlight.components.spell ~= nil then
            wormlight.components.spell:SetTarget(inst)
            if wormlight:IsValid() then
                if wormlight.components.spell.target == nil then
                    wormlight:Remove()
                else
                    wormlight.components.spell:ResumeSpell()
                end
            end
        end
    end
end

local function OnBrushed(inst, doer, numprizes)
    if numprizes > 0 then
   
    end
end

-------------------------------------------------------------------------------

local function ondeath(inst)
local owner = inst.components.follower.leader
if inst.components.container ~= nil then
inst.components.container:DropEverything() 
end 
if owner then
owner.components.petleash:DespawnPet(inst)
end
end

local function taunting(inst, data)
if inst.taunt then
local leader = inst.components.follower.leader
if leader and inst.components.health:GetPercent() >= .25 then
if leader.components.health:GetPercent() <= .75 then

	local x,y,z = inst.Transform:GetWorldPosition()	
	local enemy = TheSim:FindEntities(x, y, z, 8)
	for k,v in pairs(enemy) do
	if v and v.components.combat and v.components.combat.target == leader then
		if not ( v:HasTag("shadowcreature") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("companion") or v:HasTag("player") or v:HasTag("character") or v:HasTag("structure")) then
		v.components.combat.target = inst	
		--inst.taunting = true
		SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_hot_loop").Transform:SetPosition(v:GetPosition():Get())
			if not inst.AnimState:IsCurrentAnimation("bark1_woby") then
                inst.AnimState:PlayAnimation("bark1_woby", false)
                inst.AnimState:PushAnimation("bark1_woby", false)
				inst.SoundEmitter:PlaySound("dontstarve/characters/walter/woby/big/bark")
            end
			
		end
	end
	end
end 
end

if leader ~= nil and inst.components.health:GetPercent() >= 0.25 and inst.components.follower.leader.components.health:GetPercent() <= 0.75 then
    local dist = 12
    
    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
   {"musha","player","wall","houndmound","structure","companion","yamche","yamcheb","beefalo","koalefant","arongb","pig","bee","rocky","webber","bird","statue","character","abigail","smashable","veggie","shadowminion","catcoon","animal"})
	
end 	
end
end


local function on_close(inst)

inst.taunt = true
end

local function on_far(inst)
inst.taunt = false
inst.components.combat:GiveUp()

end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .5)

    inst.DynamicShadow:SetSize(6, 2)
    inst.Transform:SetSixFaced()

    inst.AnimState:SetBank("wobybig")
    inst.AnimState:SetBuild("arong_big_build")
	--inst.AnimState:SetBank("beefalo")
	--inst.AnimState:SetBuild("arong_build")

    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:Hide("HEAT")

    inst:AddTag("animal")
    inst:AddTag("largecreature")
    inst:AddTag("woby")
	inst:AddTag("critter")
	inst.critter_musha = true
	inst.wobybig = true
    inst:AddTag("handfed")
    inst:AddTag("fedbyall")
    inst:AddTag("dogrider_only")
    inst:AddTag("peacefulmount")
	
    inst:AddTag("companion")

    inst:AddTag("NOBLOCK")
	
	inst:AddTag("companion")
    inst:AddTag("notraptrigger")	
	inst:AddTag("Arongb")
	inst:AddTag("yamche")
	
	
    inst.entity:SetPristine()

   if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 22
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	inst.level = 0 
	
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI },{ FOODGROUP.OMNI })
	inst.components.eater:SetOnEatFn(oneat)
    inst.components.eater:SetAbsorptionModifiers(4,1,1)

	inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(9, 12)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(on_far)
	
    inst:AddComponent("inspectable")

    inst:AddComponent("follower")
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true

    inst:AddComponent("rideable")
    inst.components.rideable:SetShouldSave(false)
    inst.components.rideable.canride = true

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.sleeptestfn = ShouldSleep
    inst.components.sleeper.waketestfn = ShouldWakeUp

    inst:AddComponent("hunger")
    inst.components.hunger:SetMax(TUNING.WOBY_BIG_HUNGER)
    inst.components.hunger:SetRate(TUNING.WOBY_BIG_HUNGER_RATE)
    inst.components.hunger:SetOverrideStarveFn(OnStarving)

    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.WOBY_BIG_WALK_SPEED
    SetRunSpeed(inst, TUNING.WOBY_BIG_SPEED.FAST)
    inst.components.locomotor:SetAllowPlatformHopping(true)

	
	inst:AddComponent("health")
	inst.components.health:SetMaxHealth(200)
	inst.components.health:SetAbsorptionAmount(0.5)
	inst.components.health:StartRegen(1,10)
inst.avoid = function(inst, attacked, data)
	if inst.components.health:GetPercent() < 0.25 then
		TriggerTransformation(inst)
	end
end
inst:ListenForEvent("attacked", inst.avoid, inst)
inst:ListenForEvent("death", ondeath)

	inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(50)
    inst.components.combat:SetAttackPeriod(6)
	inst.components.combat:SetRange(2,3)
	inst.taunting = inst:DoPeriodicTask(8,taunting)
    inst:AddComponent("embarker")
    inst:AddComponent("drownable")

	inst:AddComponent("colourtweener")

    MakeHauntablePanic(inst)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGArong_dog")

    inst.persists = false

	inst.spawnfx = "spawn_fx_medium"

    inst:ListenForEvent("riderchanged", OnRiderChanged)
    inst:ListenForEvent("hungerdelta", OnHungerDelta)
    inst:ListenForEvent("ridersleep", OnRiderSleep)

    --[[inst.LinkToPlayer = LinkToPlayer
	inst.OnPlayerLinkDespawn = OnPlayerLinkDespawn
	inst._onlostplayerlink = function(player) inst._playerlink = nil end]]


    inst.FinishTransformation = FinishTransformation

    inst.ApplyBuildOverrides = ApplyBuildOverrides
    inst.ClearBuildOverrides = ClearBuildOverrides

	levelexp(inst)
	
		inst.OnSave = OnSave
        inst.OnLoad = OnLoad

	inst.OnPreLoad = onpreload
	
    return inst
end

return Prefab("arong_dog", fn, assets, prefabs)
--return Prefab("arong", arong, assets, prefabs)
