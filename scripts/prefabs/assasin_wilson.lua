require "brains/assasin_w_brain"
local brain = require "brains/assasin_w_brain"
require "stategraphs/SGassasin_w"
require "prefabs/player_common"
--local MakePlayerCharacter = require "prefabs/player_common"

local assets = 
{
 	Asset("ANIM", "anim/assasin_wilson.zip"),
	Asset("SOUND", "sound/wilson.fsb"),
	---------
		Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),
	
}

local prefabs = 
{
}

local start_inv = 
{
}

local items =
{
	AXE = "swap_axe",
	PICK = "swap_pickaxe",
	SWORD = "swap_nightmaresword",
    SWORD1 = "swap_mushasword_base",
	SWORD2 = "swap_mushasword_frost1",
	SWORD3 = "swap_mushasword_frost2",
	SWORD4 = "swap_mushasword_frost1_boost",
	SWORD5 = "swap_mushasword_frost2_boost",
	SWORD6 = "swap_mushasword_frost3_boost",
	BODY = "swap_backpack",
	BODY1 = "armor_grass",
	BODY2 = "armor_wood",
	BODY3 = "armor_marble",
	BODY4 = "armor_slurper",
	BODY5 = "armor_ruins",
	BODY6 = "armor_slurtleshell",
	HAT3 = "hat_miner",
	HAT2 = "hat_football",
	HAT1 = "hat_top",
}

local function ondeath(inst, data)
	--if inst.components.inventory then
	--inst.components.inventory:DropEverything() end
local dark2 = SpawnPrefab("statue_transition_2")
local pos = Vector3(inst.Transform:GetWorldPosition())
local player = inst.components.follower.leader
if player ~= nil then
 		if math.random() < 0.2 then
player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_1)
elseif math.random() < 0.25  then
player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_2)
elseif math.random() < 0.3  then
player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_3)
else
player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_4)
		end
end
end

local function chating(inst)
local player = inst.components.follower.leader



local danger = FindEntity(inst, 15, function(target) 
                return (target:HasTag("monster") and not target:HasTag("player") and not inst:HasTag("spiderwhisperer"))
                    or (target:HasTag("monster") and not target:HasTag("player") and inst:HasTag("spiderwhisperer") and not target:HasTag("spider"))
                    or (target:HasTag("pig") and not target:HasTag("player") and inst:HasTag("spiderwhisperer"))
                    or (target.components.combat and target.components.combat.target == inst) end)

            local hounded = TheWorld.components.hounded
			if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
	
				danger = true
			end	
if not inst.chating and player and player:HasTag("musha") and danger and not (player.sleep_on and player.tiny_sleep) then			
	if math.random() < 0.5 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_1)
	elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_2)
	elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_3)
	elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_4)
	elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_5)
	else
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_DANGER_6)
	end
	if not inst.talk_on then
inst.sg:GoToState("talk")
inst.components.locomotor:Stop()
inst.talk_on = true
inst.talk_danger = true
	inst:DoTaskInTime( 10, function() 
		inst.chating = false
		inst.talk_on = false end)
	end		
elseif not inst.chating and player and player:HasTag("musha") and not danger and not (player.sleep_on and player.tiny_sleep) then
if not ( inst.sleep and inst.sleep_on and inst.wakeup_check) then
if not inst.sg:HasStateTag("attack") and not player.sg:HasStateTag("moving") and not inst.sg:HasStateTag("hit") then
if not inst.talk_on then
inst.sg:GoToState("talk")
inst.components.locomotor:Stop()
inst.talk_on = true
inst.talk_danger = false
--inst:DoTaskInTime( 2, function() inst.sg:GoToState("idle") end)
end
inst.chating = true
--chat random
if math.random() < 0.1 then
	if math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_1)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_2)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_3)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_4)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_5)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_6)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_7)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_8)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_9)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_R_10)
	end 
--night
elseif TheWorld.state.isnight then
	if math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_1)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_2)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_3)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_4)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_5)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_NIGHT_6)
	end 
--hungry
elseif math.random() < 0.2 and inst.components.hunger:GetPercent() < .25 then
	if math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_1)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_2)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_3)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_4)
	end 

--chat1		
elseif math.random() < 0.1  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C1_1)
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C1_2) end)
inst:DoTaskInTime( 5, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C1_3) end)
player:DoTaskInTime( 8, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C1_4) end)
--chat2
elseif math.random() < 0.05  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C2_1)
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C2_2) end)
--chat3
elseif math.random() < 0.15  then
SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C3_1) end)
inst:DoTaskInTime( 4, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C3_2) end)
inst:DoTaskInTime( 6, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C3_3) end)
player:DoTaskInTime( 9, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C3_4) end)
--chat4	
elseif math.random() < 0.15  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C4_1)
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C4_2) end)
inst:DoTaskInTime( 4, function()
SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
		end)
player:DoTaskInTime( 6, function()
		player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C4_3) end)		
--chat5
elseif math.random() < 0.15 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C5_1)
player:DoTaskInTime( 2, function()
if player.components.stamina_sleep and player.components.stamina_sleep.current > 70 then
 player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C5_2) 
else
 player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C5_3) 
 end end)
--chat6
elseif math.random() < 0.15  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C6_1)
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C6_2) end)
inst:DoTaskInTime( 4, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C6_3) end)
player:DoTaskInTime( 7, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C6_4) end)
--chat7
elseif math.random() < 0.15  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C7_1)
player:DoTaskInTime( 3, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C7_2) end)
inst:DoTaskInTime( 5, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C7_3) end)
--chat8
elseif math.random() < 0.15  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C8_1)
player:DoTaskInTime( 1, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C8_2) 
end)
--chat9
elseif math.random() < 0.15  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C9_1)
player:DoTaskInTime( 2, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C9_2) end)
inst:DoTaskInTime( 5, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C9_3) end)
player:DoTaskInTime( 8, function() player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_C9_4) end)


end
end
inst:DoTaskInTime( 10, function() 
inst.chating = false
inst.talk_on = false end)
end 
end
end

	
local function lightning(inst)

if inst.fight then
inst:DoTaskInTime( 15, function() inst.fight = false end) end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"monster"})
for k,v in pairs(ents) do
if v.components.health --[[and not v.components.health:IsDead()]] and inst.components.health:GetPercent() <= 0.7 then 
local random = 0.8
if math.random() < random and not inst.yamche_lightning then
inst.yamche_lightning = true
inst.bloom = true
end end
end end


local function OnRanger(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
 if other and inst.ranger2 and inst.yamche_lightning then
           SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        --other.components.health:DoDelta(-30)
		if math.random() < 0.5 then
	if math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT_1)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT_2)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT_3)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT_4)
	elseif math.random() < 0.2 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT_5)
	end 
		end
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "" ) 
	inst.ranger2 = false inst.yamche_lightning = false
inst.components.combat:SetRange(2)	
end
end
end

function Power_check(inst, data)
if inst.yamche_lightning then -- and inst.components.health:GetPercent() >=0.4 then 
inst.ranger2 = true
inst.components.combat:SetRange(12)
if inst.bloom then
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
--inst.components.talker:Say("[Lightning -On]")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.bloom = false
end
elseif inst.yamche_lightning and inst.components.health:GetPercent() <0.4 then
--scheduler:ExecuteInTime(3, function() inst.components.talker:Say("[Not enough cost]")end)
inst.yamche_lightning = false
end end

    local function cure1_proc(inst, data)
inst.components.health:SetAbsorptionAmount(1)
--inst.components.health:DoDelta(50)
local fx = SpawnPrefab("forcefieldfxx")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
fx.Transform:SetScale(0.7, 0.7, 0.7)
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.shield_on = true
inst.sg:GoToState("talk")
if math.random() < 0.6 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FIGHT)
end
inst:DoTaskInTime( 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)
inst.components.health:SetAbsorptionAmount(0.5)

inst:DoTaskInTime( 120, function() inst.shield_on = false end)
end end) 
 end 
 
  local function EquipHead(inst, item)
 if item then
        inst.AnimState:OverrideSymbol("swap_hat", item, "swap_hat")
        inst.AnimState:Show("HAT")
        inst.AnimState:Show("HAT_HAIR")
        inst.AnimState:Show("HAIR_NOHAT")
        inst.AnimState:Hide("HAIR")
		
end
end

 local function EquipArmor(inst, item)
 if item then
	inst.AnimState:OverrideSymbol("swap_body", item, "swap_body")
end
end

local function EquipAxe(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_axe")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end
local function EquipPickaxe(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_pickaxe")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end
local function EquipItem(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, "swap_nightmaresword")
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
			
			
	end
end
local function ShouldAcceptItem(inst, item)
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        return true
    elseif item.components.edible and inst.components.hunger:GetPercent() <= 0.9 then
        return true
    end
    end

local function OnRefuseItem(inst, item)
   inst.sg:GoToState("talk")
   inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FULL)
   inst.components.locomotor:Stop()
  -- inst:DoTaskInTime( 1.5, function() inst.sg:GoToState("idle") end)
   --[[if inst.components.sleeper:IsAsleep() then
    inst.components.sleeper:WakeUp()
    end]]
end


local function OnGetItemFromPlayer(inst, giver, item)
 
 --[[if inst.components.sleeper:IsAsleep() then
    inst.components.sleeper:WakeUp()
    end]]

    if item.components.edible then

    if inst.components.combat.target and inst.components.combat.target == giver then
            inst.components.combat:SetTarget(nil)
elseif giver.components.leader then
giver.components.leader:AddFollower(inst)
        end
        if inst.components.eater:Eat(item) then
		if item.components.edible.hungervalue >= 15 then
		inst.sg:GoToState("eat")
	--inst.components.talker:Say("Yam Yam")
		elseif item.components.edible.hungervalue < 15 then
		inst.sg:GoToState("quickeat")
		end    end    
		end
   --I wear hats
    if item.components.equippable ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
        local current = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
        if current ~= nil then
            inst.components.inventory:DropItem(current)
        end
        inst.components.inventory:Equip(item)
        inst.AnimState:Show("hat")
    end		
    end
	
local function OnEat(inst, food, item)
inst.components.health:DoDelta(15)
inst.components.hunger:DoDelta(10)
if food.components.edible and food.components.edible.hungervalue > 20 or food.components.edible.healthvalue > 15 then
inst.components.health:DoDelta(100)
inst.components.hunger:DoDelta(50)
end end

local function byebye(inst)
local player = inst.components.follower.leader
	inst.sg:GoToState("talk") 
	inst.components.locomotor:Stop()
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_W)  
	--inst.hide = true
	if player ~= nil then
	player:DoTaskInTime( 1, function() 
	if math.random() < 0.2 then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_1)
	elseif math.random() < 0.25  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_2)
	elseif math.random() < 0.3  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_3)
	else
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_4)
	end
	end) end
		inst.bye = true
	inst:DoTaskInTime(1.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get()) 
	inst:Remove() 	
	end) end)
	
end

--[[local function Hiding(inst) 
 inst.components.talker:Say("Hide !")
end]]

local function HideInShadow(inst)
local player = inst.components.follower.leader
if player ~= nil then
	if player.components.drownable ~= nil and player.components.drownable:IsOverWater() then
		if math.random() < 0.2 then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_1)
		elseif math.random() < 0.25  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_2)
		elseif math.random() < 0.3  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_3)
		else
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_4)
		end
	byebye(inst)
	end
	if inst.components.hunger.current <= 0 and not inst.time then
		inst.time = true
	end
if inst.time and not inst.bye then
	inst.sg:GoToState("talk") 
	inst.components.locomotor:Stop()
	--inst:DoTaskInTime( 2, function() inst.sg:GoToState("idle") end)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_W)  inst.hide = true
	if player then
	player:DoTaskInTime( 1, function() 
	if math.random() < 0.2 then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_1)
	elseif math.random() < 0.25  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_2)
	elseif math.random() < 0.3  then
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_3)
	else
	player.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_4)
	end
	end) end
		inst.bye = true
	inst:DoTaskInTime(1.5, function()  SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get())
	inst:DoTaskInTime(0.25, function() SpawnPrefab("lightning2").Transform:SetPosition(inst:GetPosition():Get()) 
	inst:Remove() 	
	end) end)
end
end
if player ~= nil and player.components.health:IsDead() and not inst.player_die then
inst.player_die = true
inst.sg:GoToState("talk")
inst.components.locomotor:Stop()
--inst:DoTaskInTime( 3, function() inst.sg:GoToState("idle") end)
inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_FAILED)

inst:DoTaskInTime(3, function() inst.hide = true end)
inst:DoTaskInTime(0.25, function() inst:Remove() end)
end
 if inst.hiding then
 	--Hiding(inst) 
	inst.hiding = false
	inst.hide = true
	inst.components.health:SetInvincible(true)
	inst:AddTag("hiding")
	inst:DoTaskInTime(2, function() inst:RemoveTag("hiding")
	inst.sneak_attack = true
	inst.components.health:SetInvincible(false) end)
	inst:DoTaskInTime(6, function() if inst.hide then
	inst.hide = false end end)
	end
 if inst.hide and not inst:HasTag("notarget") then	
	inst:AddTag("notarget")
 		if inst.pop then 
		inst.pop = false
		local fx = SpawnPrefab("statue_transition_2")
fx.Transform:SetScale(1.5,1.5, 1.5)
fx.Transform:SetPosition(inst:GetPosition():Get())
				end
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.4)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.4)	
inst.components.colourtweener:StartTween({0.1,0.1,0.1,.05}, 0)
 elseif not inst.hide and inst:HasTag("notarget") then
 inst:RemoveTag("notarget")
		if not inst.pop then 
		inst.pop = true
		local fx = SpawnPrefab("statue_transition_2")
fx.Transform:SetScale(1.5,1.5, 1.5)
fx.Transform:SetPosition(inst:GetPosition():Get())
				end
 inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED )
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED )	
		inst.components.colourtweener:StartTween({1,1,1,1}, 0) 
end
end
		
local function OnAttacked(inst, data)
if math.random() < 0.2 and not inst.hiding and inst.components.health:GetPercent() <= 0.7 then
 inst.hiding = true
end
if inst.sneak_attack then
inst.hide = false
inst.sneak_attack = false
end
if data.attacker:HasTag("musha") then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
inst.time = true
elseif not data.attacker:HasTag("musha") then
    inst.components.combat:SuggestTarget(data.attacker)
    --inst.components.combat:ShareTarget(data.attacker, 3, function(dude) return dude:HasTag("companion") and not dude.components.health:IsDead() end, 5)
end
end

local function OnHitfreeze(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
if other and other:HasTag("player") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()
end
if inst.sneak_attack and other and other.components.freezable and inst.components.health:GetPercent() <= 0.7 then
        other.components.freezable:AddColdness(2)
        other.components.freezable:SpawnShatterFX()
		
            local fx2 = SpawnPrefab("groundpoundring_fx")
	 	  fx2.Transform:SetScale(0.6, 0.6, 0.6)
	  	  fx2.Transform:SetPosition(other:GetPosition():Get())
			
				inst.sneak_attack = false 
				inst.hide = false 
	end 
if math.random() < 0.2 and not inst.hiding and other and other.components.health then
 inst.hiding = true
 end
if inst.hide or inst.sneak_attack then
 inst.hide = false
 inst.sneak_attack = false
end
   local pos = other:GetPosition()
    if other and other.components.freezable then
        other.components.freezable:AddColdness(0.1)
        other.components.freezable:SpawnShatterFX()
	elseif other and other.components.freezable and math.random() < 0.2 then
        other.components.freezable:AddColdness(1)
        other.components.freezable:SpawnShatterFX()
		
            local fx2 = SpawnPrefab("groundpoundring_fx")
	 	  fx2.Transform:SetScale(0.6, 0.6, 0.6)
	  	  fx2.Transform:SetPosition(other:GetPosition():Get())
		  
    end
end
end

local function tryproc(inst)
if not inst.shield_on and inst.components.health:GetPercent() < .1  then
            cure1_proc(inst)
    end end
	
local function Onhunt(inst, target)
    return inst.components.combat:CanTarget(target)
end

	
local function hound_hunt(inst)
    if not inst.active_hunt and not inst.peace then
if inst.combat_no then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
 end
    local dist = 30
    if inst.active_hunt then

    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
      {"musha","player","wall","houndmound","structure","companion","yamche","beefalo","koalefant","arongb","pig","bee","rocky","bird","statue","character","abigail","smashable","veggie","shadowminion"})
	
 elseif not inst.active_hunt and inst.peace then
 inst.components.combat:SetTarget(nil)

end 	
end

local function assasin_hunt(inst)
    local dist = 6
if inst.combat_no then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
if inst.fighting then
    return FindEntity(inst, dist, function(guy)
	return inst.components.combat:CanTarget(guy) 
     end,
    nil,
     {"musha","player","wall","houndmound","structure","companion","yamche","animal","beefalo","koalefant","pig","bee","insect","rocky","bird","statue","frog","prey","character","companion","webber","abigail","smashable","veggie"})
	end
	end


local function sleeping(inst)	
local player = inst.components.follower.leader
if player ~= nil and player:HasTag("musha") then
if player.sleep_on or player.tiny_sleep then
inst.sleep = true
end
if (player.sleep_on or player.tiny_sleep) and inst.sleep and not inst.sleep_on then
inst:DoTaskInTime(0, function() 
inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw") 
inst.AnimState:PlayAnimation("bedroll",true) 
inst.sg:GoToState("bedroll")
inst.sleep_on = true end)
end
if inst.sleep_on and inst.AnimState:AnimDone() and not inst.wakeup_check then
inst.wakeup_check = true
inst.AnimState:PlayAnimation("bedroll_sleep_loop", true) 
end

if not player.sleep_on and not player.tiny_sleep and inst.sleep and inst.sleep_on and inst.wakeup_check then
inst:DoTaskInTime(1, function() 
--inst.sg:GoToState("wakeup")
inst.sleep = false
inst.sleep_on = false
inst.wakeup_check = false
inst.wakeup_on = true
end)
end 

if inst.sleep_on then
inst.components.health:StartRegen(10, 1)
inst.components.hunger:SetRate(0)
elseif not inst.sleep_on then
inst.components.health:StartRegen(1, 10)
inst.components.hunger:SetRate(0.25)
end 
if inst.wakeup_on then
inst.wakeup_on = false
inst.sg:GoToState("wakeup")
inst.sg:RemoveStateTag("sleeping")
end

end
end

local function item_set(inst)

if TheWorld.state.isnight and not inst.hat3 then	
inst.hat3 = true

inst.hat2 = false
inst.hat1 = false
inst.equipfn3(inst, inst.items["HAT3"])
inst.Light:Enable(true)
elseif inst.fight and not TheWorld.state.isnight and not inst.hat2 then	
inst.hat2 = true

inst.hat1 = false
inst.hat3 = false
inst.equipfn3(inst, inst.items["HAT2"])
inst.Light:Enable(false)
elseif not inst.fight and not TheWorld.state.isnight and not inst.hat1 then	
inst.hat1 = true

inst.hat2 = false
inst.hat3 = false
inst.equipfn3(inst, inst.items["HAT1"])
inst.Light:Enable(false)
end

local player = inst.components.follower.leader
if player ~= nil then
if not inst.equip_set then
if player and player:HasTag("musha") then
if player.level >=0 and player.level <200  then --1
inst.LV1 = true
	inst.equipfn(inst, inst.items["SWORD1"])
	inst.equipfn2(inst, inst.items["BODY"])
	inst.components.combat:SetDefaultDamage(30)
	inst.components.health:SetMaxHealth(300)
inst.components.health:SetAbsorptionAmount(0.15)	
elseif 	player.level >=200 and player.level <530  then	--2
inst.LV2 = true
	inst.equipfn(inst, inst.items["SWORD2"])
	inst.equipfn2(inst, inst.items["BODY1"])
	inst.components.combat:SetDefaultDamage(35)
	inst.components.health:SetMaxHealth(500)

inst.components.health:SetAbsorptionAmount(0.25)

elseif 	player.level >=530 and player.level <1340  then	--3
inst.LV3 = true
	inst.equipfn(inst, inst.items["SWORD3"])
	inst.equipfn2(inst, inst.items["BODY2"])	
	inst.components.combat:SetDefaultDamage(40)
	inst.components.health:SetMaxHealth(600)
	inst.AnimState:OverrideSymbol("beard", "beard", "beard_short")

inst.components.health:SetAbsorptionAmount(0.35)

elseif 	player.level >=1340 and player.level <2290  then	--4
inst.LV4 = true
	inst.equipfn(inst, inst.items["SWORD4"])
	inst.equipfn2(inst, inst.items["BODY3"])	
	inst.components.combat:SetDefaultDamage(45)
	inst.components.health:SetMaxHealth(700)
	
	inst.AnimState:OverrideSymbol("beard", "beard", "beard_short")

inst.components.health:SetAbsorptionAmount(0.45)
	
elseif 	player.level >=2290 and player.level <4200  then	--5
inst.LV5 = true
	inst.equipfn(inst, inst.items["SWORD5"])
	inst.equipfn2(inst, inst.items["BODY4"])	
inst.components.combat:SetDefaultDamage(50)	
	inst.components.health:SetMaxHealth(800)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_medium")

inst.components.health:SetAbsorptionAmount(0.55)
	   
elseif 	player.level >=4200 and player.level <7000  then	--6
inst.LV6 = true
	inst.equipfn(inst, inst.items["SWORD6"])
	inst.equipfn2(inst, inst.items["BODY5"])		
	inst.components.combat:SetDefaultDamage(55)
	inst.components.health:SetMaxHealth(900)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_medium")

inst.components.health:SetAbsorptionAmount(0.65)
	   
elseif 	player.level >=7000 then	-- 7
inst.LV7 = true
	inst.equipfn(inst, inst.items["SWORD6"])
	inst.equipfn2(inst, inst.items["BODY6"])		
	inst.components.combat:SetDefaultDamage(60)
	inst.components.health:SetMaxHealth(1000)
	
       inst.AnimState:OverrideSymbol("beard", "beard", "beard_long")

inst.components.health:SetAbsorptionAmount(0.75)
	   
	end
	inst.equip_set = true
end
end
end
--if player then
--inst.equip_set = false
--end
end

local function on_close(inst)
local player = inst.components.follower.leader
if player then
inst.fighting = true
inst.combat_no = false
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
end 
	end
	
local function far(inst)
local player = inst.components.follower.leader
if player then
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.25)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.25)
inst.combat_no = true
inst.fighting = false
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end
end


local function fn()
  local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
	
	inst.Transform:SetFourFaced(inst)

    MakeCharacterPhysics(inst, 75, .5) 
 	
	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("assasin_wilson")
	inst.AnimState:PlayAnimation("idle")

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("hat")
    inst.AnimState:Hide("hat_hair")

    inst:AddTag("scarytoprey")
	inst:AddTag("crazy")
	inst.soundsname = "wilson"
	inst.talker_path_override = "dontstarve/characters/"

	--inst:AddTag("NOCLICK")
	--inst:AddTag("assasin")
	inst:AddTag("character")
	inst:AddTag("companion")
	inst:AddTag("yamche")
	--inst:AddTag("musha_slave")
	inst:AddTag("bodyguard_w")
	inst:AddTag("notraptrigger")
-----------light on
    inst.entity:AddLight()
	inst.Light:SetRadius(2.1)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.7)
    inst.Light:SetColour(185/255,175/255,170/255)
	inst.Light:Enable(false)	
	
	--inst.components.eater.monsterimmune = true
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 30
    inst.components.talker.colour = Vector3(1, 0.6, 0.75, 1)
--	inst.Transform:SetScale(1.1,1.1,1.1)
			inst.hurtsoundoverride = "wilson"
		inst.talker_path_override = "wilson"
	
	inst:AddComponent("colourtweener")
	--inst.components.colourtweener:StartTween({.1,.1,.1,.1}, 0)
	
	--inst:DoTaskInTime(2, function() inst.hide = true end)
	
       	if not TheWorld.ismastersim then
   return inst
end	
inst.entity:SetPristine()		

	inst:AddComponent("locomotor")
	--inst.components.locomotor.triggerscreep = false	
	--inst.components.locomotor:SetAllowPlatformHopping(true)
	inst:AddComponent("drownable")
	
	inst:AddComponent("follower")
    inst:AddComponent("combat")
    inst.components.combat.playerdamagepercent = 0
    inst.components.combat.hiteffectsymbol = "torso"
	inst.components.combat:SetRetargetFunction(1, hound_hunt)
	--inst.components.combat:SetRetargetFunction(0, assasin_hunt)
    inst.components.combat:SetKeepTargetFunction(Onhunt)
    inst.components.combat:SetAttackPeriod(1.5)
    inst.components.combat:SetRange(2, 3)
	
     inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(7, 8)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(far)
  
    inst:AddComponent("health")
	inst.components.health:SetMaxHealth(850)
	inst.components.health:StartRegen(1, 10)
	inst:AddComponent("hunger")
	inst.components.hunger:SetRate(0.25)		
	inst.components.hunger:SetMax(300)
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI } )
	inst.components.eater.strongstomach = true
   -- inst.components.eater:SetCanEatRaw()
    inst.components.eater:SetOnEatFn(OnEat)
	
	inst:AddComponent("inventory")
    inst.components.inventory.dropondeath = false
    inst:AddComponent("beard")
   inst.components.beard.prize = "beardhair"
   
	    inst.items = items
    inst.equipfn = EquipItem
	inst.equipfn2 = EquipArmor
	inst.equipfn3 = EquipHead
	inst.equipfna = EquipAxe
	inst.equipfnp = EquipPickaxe
	EquipItem(inst)
	EquipArmor(inst)
	EquipHead(inst)
	
	inst.equipfn(inst, inst.items["SWORD1"])
	inst.equipfn2(inst, inst.items["BODY"])
	inst.equipfn3(inst, inst.items["HAT3"])
	inst.components.combat:SetDefaultDamage(30)

	inst:ListenForEvent("death", ondeath)

	    inst.procfn = function() tryproc(inst) end
        inst:ListenForEvent("attacked", inst.procfn)
		inst:ListenForEvent("attacked", OnAttacked)
		inst:ListenForEvent("onhitother", OnHitfreeze)
	inst.hideinshadow = inst:DoPeriodicTask(0,HideInShadow)
	inst.sleeping = inst:DoPeriodicTask(1,sleeping)
	inst.item_set = inst:DoPeriodicTask(2,item_set)
	inst.hunt = inst:DoPeriodicTask(16, lightning)
	inst.Power_check = inst:DoPeriodicTask(1, Power_check)
	inst:DoPeriodicTask(60, chating)
	
	    inst:ListenForEvent("onhitother", OnRanger)
  
  
	inst:SetBrain(brain)
	inst:SetStateGraph("SGassasin_w")
	
		return inst
end
return Prefab("common/assasin_wilson", fn, assets, prefabs)

