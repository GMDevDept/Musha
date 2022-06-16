--require "prefabutil"
require "brains/mushasmallbrain"
local brain = require "brains/mushasmallbrain"
require "stategraphs/SGmusha_small"
require "stategraphs/SGmusha_teen"
require "stategraphs/SGmusha_tall"
require "stategraphs/SGmusha_tall2"
require "stategraphs/SGmusha_tall3"
require "stategraphs/SGmusha_tall4"
require "stategraphs/SGmusha_tall5"
require "stategraphs/SGmusha_tall6"

local SLEEP_NEAR_LEADER_DISTANCE = 2
local CRY_NEAR_LEADER_DISTANCE = 20
local MONSTER_DISTANCE = 10
--local BACK_DISTANCE = 9

local assets =
{
	Asset("ANIM", "anim/musha_small.zip"),
	Asset("ANIM", "anim/musha_tall.zip"),
	Asset("ANIM", "anim/musha_tall2.zip"),
	Asset("ANIM", "anim/musha_tall3.zip"),
	Asset("ANIM", "anim/musha_tall4.zip"),
	Asset("ANIM", "anim/musha_tall5.zip"),
	Asset("ANIM", "anim/musha_ice.zip"),
    Asset("ANIM", "anim/hat_yamche.zip"),
	Asset("ANIM", "anim/hat_yamche_on.zip"),
	Asset("SOUND", "sound/tallbird.fsb"),
	

Asset("IMAGE", "images/inventoryimages/musha_small.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teen.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp7.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rpice.tex"),

Asset("ATLAS", "images/inventoryimages/musha_small.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teen.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp7.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rpice.xml"),

Asset("IMAGE", "images/inventoryimages/musha_small_super.tex"),
Asset("ATLAS", "images/inventoryimages/musha_small_super.xml"),
}

local prefabs=
{	--"hat_yamche",
    "musha_small",
    "musha_teen",
    "musha_tall",
    "musha_tall2",
    "musha_tall3",
    "musha_tall4",
    "musha_tall5",
    "musha_rp1",
    "musha_rp2",
    "musha_rp3",
    "musha_rp4",
    "musha_rp5",
    "musha_rp6",
  
}

----------------

local function ondeath(inst)
local dark2 = SpawnPrefab("statue_transition_2")
local pos = Vector3(inst.Transform:GetWorldPosition())
dark2.Transform:SetPosition(pos:Get())
if inst.components.container and not inst.level1 then
inst.components.container:DropEverything() 
	end
	if inst.components.inventory and not inst.level1 then
	inst.components.inventory:DropEverything() 
	inst:RemoveComponent("inventory") 
	end
 if  inst.level1 and not inst.ndie then
local poo = SpawnPrefab("musha_egg")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)		
 elseif  inst.level2 and not inst.ndie then
local poo = SpawnPrefab("musha_egg")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)		
 elseif  inst.level3 and not inst.ndie then
local poo = SpawnPrefab("musha_eggs1")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)		
 elseif  inst.level4 and not inst.ndie then
local poo = SpawnPrefab("musha_eggs2")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)	
 elseif  inst.level5 and not inst.ndie then
local poo = SpawnPrefab("musha_eggs3")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)	
 elseif  inst.level6 and not inst.ndie then
local poo = SpawnPrefab("musha_egg1")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)	
 elseif  inst.level7 and not inst.ndie then
local poo = SpawnPrefab("musha_egg2")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)	
 elseif  inst.level8 and not inst.ndie then
local poo = SpawnPrefab("musha_egg3")
poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) --poo.Transform:SetScale(0.5, 0.5, 0.5)		
--elseif inst.ndie then
--inst.ndie = false
end 
end 

local function die(inst)
	inst.components.health:Kill()
end
local function ndie(inst)
	inst.ndie = true
	inst.components.health:Kill()
end
----------------
local function level_inventory(inst,data)
if inst.components.inventory then
if inst.level1 then
inst.components.inventory.maxslots = 3
elseif inst.level2 then
inst.components.inventory.maxslots = 5
elseif inst.level3 then
inst.components.inventory.maxslots = 7
elseif inst.level4 then
inst.components.inventory.maxslots = 9
elseif inst.level5 then
inst.components.inventory.maxslots = 10
elseif inst.level6 then
inst.components.inventory.maxslots = 11
elseif inst.level7 then
inst.components.inventory.maxslots = 12
elseif inst.level8 then
inst.components.inventory.maxslots = 14
end end
end
---------------------------

local function InShadow(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 8)

for k,v in pairs(ents) do
	if v.components.health ~= nil and not v.components.health:IsDead() and v.components.combat ~= nil and v.components.combat.target == inst and not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly")) then
		v.components.combat.target = nil		
	end 
end 
end
 
local function stop_working(inst)


	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false

	inst.item_ready_drop = false
	end

inst.stop_working = true
InShadow(inst)
inst.components.growable:StartGrowing()
inst.components.health:SetInvincible(true)
end

--compatible with shipwrecked

local function Rippletask(inst)
if inst.components.drownable ~= nil then 
	if inst.components.drownable:IsOverWater() then
	SpawnPrefab("weregoose_ripple"..tostring(math.random(2))).entity:SetParent(inst.entity)
	inst.on_ground = false
		local x, y, z = inst.Transform:GetWorldPosition()
        local fx = SpawnPrefab("splash_water_drop")
		inst.SoundEmitter:PlaySound( "dontstarve_DLC002/common/boat_paddle")
        fx.Transform:SetScale(0.6, 0.6, 0.6)
        fx.Transform:SetPosition(x, y, z)
		
		local yamchaep = inst:GetPosition()
		local ground = TheWorld.Map:GetTileAtPoint(yamchaep.x, yamchaep.y, yamchaep.z)	
		if (inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("idle_blink") or inst.sg:HasStateTag("taunt") or inst.sg:HasStateTag("open") or inst.sg:HasStateTag("close") or inst.sg:HasStateTag("hit") or inst.sg:HasStateTag("eat") or inst.sg:HasStateTag("attack2") or inst.sg:HasStateTag("sleep") or inst.sg:HasStateTag("idle_peep") or inst.sg:HasStateTag("cry") or inst.sg:HasStateTag("mine") or inst.sg:HasStateTag("chop") or inst.sg:HasStateTag("throw") or inst.sg:HasStateTag("action") or inst.sg:HasStateTag("walk_stop") or inst.sg:HasStateTag("run_stop") or inst.sg:HasStateTag("animover")) then
		inst.sg:GoToState("walk") 
		end		
	else
	inst.on_ground = true
	end
end
end

local function Splash_Ripple(inst)
	inst.Rippletask = Rippletask(inst)
	if inst.on_ground then
			if inst.Rippletask ~= nil then
				inst.Rippletask:Cancel()
				inst.Rippletask = nil
			end
	end
end


---------------------------
local function levelexp(inst,data)

	local max_exp = 99999999999999993000
	local exp = math.min(inst.level, max_exp)
	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()

--inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP_NEXT)
if inst.super_baby then
	inst.components.health.maxhealth = math.ceil (300 + exp* 1)
	inst.components.talker:Say(STRINGS.MUSHA_HEALTH_MAX.."\n".. (inst.level + 300))
	
end
if inst.level8 or inst.level >= 500 then
	--inst.components.hunger.max = math.ceil (130 + exp* 1)
	inst.components.health.maxhealth = math.ceil (800 + exp* 1)
inst.components.talker:Say(STRINGS.MUSHA_HEALTH_MAX.."\n".. (inst.level + 800))
end

if not inst.level8 then
	
 if inst.level >0 and inst.level <9 and inst.level1 and not inst.baby then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 1\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/10")
	elseif inst.level >9 and inst.level1 and not inst.baby then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <19 and inst.level2 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 2\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/20")
	elseif inst.level >19 and inst.level2 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <49 and inst.level3 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 3\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/50")
	elseif inst.level >49 and inst.level3 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <99 and inst.level4 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 4\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/100")
	elseif inst.level >99 and inst.level4 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <299 and inst.level5 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 5\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/300")
	elseif inst.level >299 and inst.level5 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <399 and inst.level6 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 6\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/400")
	elseif inst.level >399 and inst.level6 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
elseif inst.level >0 and inst.level <499 and inst.level7 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 7\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/500")
	elseif inst.level >499 and inst.level7 then
    		stop_working(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GROWUP)
	
end
end
	
	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
end
	
local function growup_check(inst,data)	
inst:ListenForEvent("levelup", levelexp)
--[[
if not inst.house then
	if inst.level >9 and inst.level1 then
    		stop_working(inst)
	elseif inst.level >19 and inst.level2 then
    		stop_working(inst)
	elseif inst.level >49 and inst.level3 then
    		stop_working(inst)
	elseif inst.level >99 and inst.level4 then
    		stop_working(inst)
	elseif inst.level >299 and inst.level5 then
    		stop_working(inst)
	elseif inst.level >399 and inst.level6 then
    		stop_working(inst)
	elseif inst.level >499 and inst.level7 then
    		stop_working(inst)
	end
end]]
end

local function IsValidVictim(victim)
    return victim ~= nil
        and not ((victim:HasTag("prey") and not victim:HasTag("hostile")) or
                victim:HasTag("veggie") or
                victim:HasTag("structure") or
                victim:HasTag("wall") or
                victim:HasTag("balloon") or
                victim:HasTag("groundspike") or
                victim:HasTag("smashable") or
                victim:HasTag("companion") or
				victim:HasTag("no_exp") or
				victim:HasTag("fossil"))
        and victim.components.health ~= nil
        and victim.components.combat ~= nil
end

local smallllchance = 0.45
local normalchance = 0.9
local largechance = 1

local function onkilll(inst, data)
	local victim = data.victim
	if IsValidVictim(victim) then
		    if math.random() < normalchance then
					inst.level = inst.level + 1
 					if victim:HasTag("monster1x") then
					--inst.level = inst.level + 1
					elseif victim:HasTag("monster2x") then
					inst.level = inst.level + 1
						if math.random() < 0.09 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						end	
					elseif victim:HasTag("monster3x") then
					inst.level = inst.level + 2
						if math.random() < 0.12 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						end
					elseif victim:HasTag("monster4x") then
					inst.level = inst.level + 3
						if math.random() < 0.15 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					--SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						end
					end 
					levelexp(inst)
			end
					
		 if (victim:HasTag("epic") or victim:HasTag("deerclops") or 
			 victim:HasTag("bearger") or victim:HasTag("moose") or 
							  victim:HasTag("dragonfly")  ) then
					if victim:HasTag("small_giant1x") then
					inst.level = inst.level + 5
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_EPIC.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 5 ")

					elseif victim:HasTag("small_giant2x") then
					inst.level = inst.level + 10
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_EPIC.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 10 ")
											if math.random() < 0.2 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.02 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("small_giant3x") then
					inst.level = inst.level + 15
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_EPIC.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 15 ")
											if math.random() < 0.3 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.05 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("small_giant4x") then
					inst.level = inst.level + 20
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_EPIC.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 20 ")
											if math.random() < 0.4 then
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
											elseif math.random() < 0.1 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant1x") then
					inst.level = inst.level + 10
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_GIANT.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 10 ")
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.2 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant2x") then
					inst.level = inst.level + 20
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_GIANT.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 20 ")
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.15 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.05 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant3x") then
					inst.level = inst.level + 30
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_GIANT.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 30 ")
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						if math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.3 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("greengem").Transform:SetPosition(victim:GetPosition():Get())		
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.2 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					elseif victim:HasTag("giant4x") then
					inst.level = inst.level + 40
					inst.components.talker:Say(STRINGS.MUSHA_TALK_KILL_GIANT.."\n "..STRINGS.MUSHA_LEVEL_EXP.." + 40 ")
					SpawnPrefab("statue_transition_2").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("redgem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("bluegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					if math.random() < 0.7 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("amulet").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("greengem").Transform:SetPosition(victim:GetPosition():Get())	
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())					
						elseif math.random() < 0.6 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("purplegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("yellowgem").Transform:SetPosition(victim:GetPosition():Get())	
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
						elseif math.random() < 0.5 then
					SpawnPrefab("glowdust").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("orangegem").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("mandrake").Transform:SetPosition(victim:GetPosition():Get())
					SpawnPrefab("goldnugget").Transform:SetPosition(victim:GetPosition():Get())
					end
					end 
					levelexp(inst)
  					end					
			if (victim:HasTag("prey") or victim:HasTag("insect") or victim:HasTag("frog")) then
				if math.random() < normalchance then
    				inst.level = inst.level + 1
					levelexp(inst)
				end					
			end
	end
end		

------------

local function GetStatus(inst)
    --print("smallbird - GetStatus")
    if inst.components.hunger then
        if inst.components.hunger:IsStarving(inst) then
            --print("STARVING")
            return "STARVING"
        elseif inst.components.hunger:GetPercent() < .2 then
            --print("HUNGRY")
            return "HUNGRY"
        end
	end
end

------------------   
	
local function ystarve(inst, data)

if not inst.house then
  if (inst.sleep_on or inst.fightn) then
inst.components.hunger:SetRate(0)
elseif not inst.sleep_on and not inst.fightn then
	if not inst.light_on and not inst.pick1 then
--inst.components.hunger:SetRate(15/TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(0.015)
	elseif inst.light_on and not inst.pick1 then
--inst.components.hunger:SetRate(120/TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(0.12)
	elseif inst.light_on and inst.pick1 then
--inst.components.hunger:SetRate(210/TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(0.21)
	elseif not inst.light_on and inst.pick1 then
--inst.components.hunger:SetRate(90/TUNING.TEENBIRD_STARVE_TIME)
inst.components.hunger:SetRate(0.075)
	end
end
elseif inst.house then
if not inst.baby_light_on then
inst.components.hunger:SetRate(0.015)
elseif inst.baby_light_on then
inst.components.hunger:SetRate(0.03)
end
end

if inst.components.health and not inst.open and not inst.campfire then 
	if not inst.sleep_on and inst.components.health:GetPercent() > .3 then
		inst.components.health:StartRegen(1, 30)
elseif not inst.sleep_on and inst.components.health:GetPercent() <= .3 then
		inst.components.health:StartRegen(2, 1)		
elseif inst.sleep_on then
		inst.components.health:StartRegen(5, 1)		
	end		
elseif inst.components.health and not inst.open and inst.campfire then 
		inst.components.health:StartRegen(5, 1)
end

if not inst.fightn and inst.light_on then
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.level1 then
	inst.Light:SetRadius(0.25)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	end
		if not inst.level1 and inst.level2 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.8)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level3 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level4 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.4)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level5 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.7)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level6 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level7 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(3.3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level8 and inst.components.hunger:GetPercent() > .9 then
    --inst.entity:AddLight()
	inst.Light:SetRadius(4)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
		elseif not inst.level1 and inst.level2 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.4)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level3 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.7)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level4 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level5 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level6 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.6)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level7 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.9)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level8 and inst.components.hunger:GetPercent() <= .9 and inst.components.health:GetPercent() > .75  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(3.4)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
	
		elseif not inst.level1 and inst.level2 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.level3 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.4)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)	
		elseif not inst.level1 and inst.level4 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.7)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)		
		elseif not inst.level1 and inst.level5 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)		
		elseif not inst.level1 and inst.level6 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)		
		elseif not inst.level1 and inst.level7 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(2.6)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)		
		elseif not inst.level1 and inst.level8 and inst.components.hunger:GetPercent() <= .75 and inst.components.health:GetPercent() > .5  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(3)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)			
		
		elseif not inst.level1 and inst.components.hunger:GetPercent() <= .5 and inst.components.health:GetPercent() > .35  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(1.1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		
		elseif not inst.level1 and inst.components.hunger:GetPercent() <= .35 and inst.components.health:GetPercent() > .25  then
    --inst.entity:AddLight()
	inst.Light:SetRadius(0.75)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.components.hunger:GetPercent() <= .25 and inst.components.health:GetPercent() > .1 then
      --inst.entity:AddLight()
	inst.Light:SetRadius(0.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
		elseif not inst.level1 and inst.components.hunger:GetPercent() <= .1 then
  		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(0.25)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	end

elseif not inst.fightn and not inst.light_on then
--inst.components.hunger:SetRate(15/TUNING.TEENBIRD_STARVE_TIME)
elseif inst.fightn and inst.light_on then
--inst.components.hunger:SetRate(0)
--inst.entity:AddLight()
inst.Light:SetRadius(0.2)
inst.Light:SetFalloff(.8)
inst.Light:SetIntensity(.5)
inst.Light:SetColour(180/255,180/255,180/255)
elseif inst.fightn and not inst.light_on then
--inst.components.hunger:SetRate(0)
end 


--[[if inst.baby then
	if inst.house then
	local owner = inst.components.inventoryitem.owner
		if inst.components.inventoryitem and owner and TheWorld.state.isnight and inst.light_on then
		inst.Light:Enable(true)
	  
			if not inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x2)")
			inst.baby_light_on = true
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche_on", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		elseif inst.components.inventoryitem and owner and TheWorld.state.isnight and inst.light_on then
			if not inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x2)")
			inst.baby_light_on = true
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche_on", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		end
	end
end]]

if inst.super_baby then
	if inst.house then
	local owner = inst.components.inventoryitem.owner
		if inst.components.inventoryitem and owner and TheWorld.state.isnight and inst.light_on then
		inst.Light:Enable(true)
	  
			if not inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x2)")
			inst.baby_light_on = true
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche_on", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		
				if inst.components.hunger.current >= 15 then
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(2.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 15 and inst.components.hunger.current >= 7 then
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(2.2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 7 and inst.components.hunger.current >3 then
				--inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current <=3 then
		    inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 
			inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_FOOOD)
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
				end
	
		elseif owner and not TheWorld.state.isnight and inst.light_on then
		inst.Light:Enable(false)
			if inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
			inst.baby_light_on = false
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		end
	elseif not inst.house then	
		if inst.components.hunger.current >= 15 then
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 15 and inst.components.hunger.current >= 7 then
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 7 and inst.components.hunger.current >3 then
				--inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current <=3 then
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(0.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
				end
	end
end


if inst.baby then
	if inst.house then
	local owner = inst.components.inventoryitem.owner
		if inst.components.inventoryitem and owner and TheWorld.state.isnight and inst.light_on then
		inst.Light:Enable(true)
	
			if not inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x2)")
			inst.baby_light_on = true
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche_on", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		
				if inst.components.hunger.current >= 15 then
 		
	   	inst.Light:SetRadius(1)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 15 and inst.components.hunger.current >= 7 then
 		
	   	inst.Light:SetRadius(0.9)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 7 and inst.components.hunger.current >3 then
		
	   	inst.Light:SetRadius(0.8)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current <=3 then
		    inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/chirp") 
			inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_FOOOD)
 		   --inst.entity:AddLight()
	   	inst.Light:SetRadius(0.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
				end
	
		elseif owner and not TheWorld.state.isnight and inst.light_on then
		inst.Light:Enable(false)
			if inst.baby_light_on then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
			inst.baby_light_on = false
			end
			owner.AnimState:OverrideSymbol("swap_hat", "hat_yamche", "swap_hat")
			owner.AnimState:Show("HAT")
			owner.AnimState:Hide("HAIR_NOHAT")
			owner.AnimState:Show("HAIR")
		end
	elseif not inst.house then	
		if inst.components.hunger.current >= 15 then
 
	   	inst.Light:SetRadius(0.8)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 15 and inst.components.hunger.current >= 7 then
 		
	   	inst.Light:SetRadius(0.7)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current < 7 and inst.components.hunger.current >3 then
		
	   	inst.Light:SetRadius(0.6)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	
				elseif inst.components.hunger.current <=3 then
 		
	   	inst.Light:SetRadius(0.2)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
				end
	end
end


--[[if inst.components.health:GetPercent() >= .5 and inst.components.health:GetPercent() <= 1 and inst.light_on and not inst.iceyamche and inst.open then
if not TheWorld.state.issummer then

		if not inst.fire then 
			
            inst.fire = SpawnPrefab( "debuff_bloodlp" )
			inst.fire.Transform:SetScale(0.3, 0.3, 0.3)
            local follower = inst.fire.entity:AddFollower()
            follower:FollowSymbol( inst.GUID, "head", 0, -150, 2 )
        end
SpawnPrefab("dr_hot_loop").Transform:SetPosition(inst:GetPosition():Get())
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
  inst.components.heater.heat = 80
  inst.components.talker:Say("[Heater]-On\nCost:[Health]")
  inst.components.health:StartRegen(-2, 1)
  inst.components.heater:SetThermics(true, false)
  if inst.peace then inst.peace = false inst.active_hunt = false inst.defense = false end
elseif TheWorld.state.issummer then
  inst.components.heater.heat = 0
  inst.components.talker:Say("Hot Weather\n[Heater]-Off")  
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)
  end
elseif not inst.light_on and not inst.iceyamche and inst.open then  
  inst.components.heater.heat = 0
  if not inst.house then
  inst.components.talker:Say("[Heater]-Off")  
  end
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)
  
elseif inst.components.health:GetPercent() >= .5 and inst.components.health:GetPercent() <= 1 and inst.light_on and inst.iceyamche and inst.open then
if not TheWorld.state.iswinter then

		if not inst.cold then 
			
            inst.cold = SpawnPrefab( "debuff_bloodlp" )
			inst.cold.Transform:SetScale(0.3, 0.3, 0.3)
            local follower = inst.cold.entity:AddFollower()
            follower:FollowSymbol( inst.GUID, "head", 0, -130, 2 )
        end
SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
  inst.components.heater.heat = -20
  inst.components.talker:Say("[Cooler]-On\nCost:[Health]")  
  inst.components.health:StartRegen(-2, 1)
  inst.components.heater:SetThermics(false, true)
  if inst.peace then inst.peace = false inst.active_hunt = false inst.defense = false end
  --inst.components.heater:SetThermics(true, false)
elseif TheWorld.state.iswinter then  
  inst.components.heater.heat = 0
  inst.components.talker:Say("Cold Weather\n[Cooler]-Off") 
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)  
  end
elseif not inst.light_on and inst.iceyamche and inst.open then
  inst.components.heater.heat = 0
  if not inst.house then
  inst.components.talker:Say("[Cooler]-Off\n[ice-box]") 
  end
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)  
elseif inst.components.health:GetPercent() >= 0 and inst.components.health:GetPercent() < 5 and inst.light_on and not inst.iceyamche and inst.open then
  inst.components.heater.heat = 0
  inst.components.talker:Say("[Heater]-Off\n(Not enough Cost)")
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)
		if inst.fire then 
        inst.fire:Remove()
        inst.fire = nil
		end 
elseif inst.components.health:GetPercent() >= 0 and inst.components.health:GetPercent() < 5 and inst.light_on and inst.iceyamche and inst.open then
  inst.components.heater.heat = 0
  inst.components.talker:Say("[Heater]-Off\n(Not enough Cost)\n[ice-box]") 
  inst.components.health:StartRegen(1, 10)
  inst.components.heater:SetThermics(true, false)
		if inst.cold then 
        inst.cold:Remove()
        inst.cold = nil
		end 
elseif not inst.open then
  inst.components.heater.heat = 0
  inst.components.heater:SetThermics(true, false)
		if inst.fire then 
        inst.fire:Remove()
        inst.fire = nil
		end 
		if inst.cold then 
        inst.cold:Remove()
        inst.cold = nil
		end 
   end ]]
   
   end  
  
---------hat

local function Dropped_Yamche(inst,data)
inst.house = false
--with sw mods on the sea
if inst.DLC2_fly and inst.components.inventoryitem ~= nil and inst.house then
	local yamchaep = inst:GetPosition()
	local ground = TheWorld.Map:GetTileAtPoint(yamchaep.x, yamchaep.y, yamchaep.z)	

	if ( ground == GROUND.MANGROVE or ground == GROUND.RIVER or ground == GROUND.OCEAN_CORAL or ground == GROUND.OCEAN_DEEP or ground == GROUND.OCEAN_MEDIUM or ground == GROUND.OCEAN_SHIPGRAVEYARD or ground == GROUND.OCEAN_SHALLOW or ground == GROUND.IMPASSABLE ) then

	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"musha"})
	for k,v in pairs(ents) do
	if v ~= nil then
	v.AnimState:ClearOverrideSymbol("swap_hat", "hat_house", "swap_hat")
	v.AnimState:ClearOverrideSymbol("swap_hat", "hat_yamche", "swap_hat")
	v.AnimState:ClearOverrideSymbol("swap_hat", "hat_yamche_on", "swap_hat")
		v.AnimState:Hide("HAT")
        v.AnimState:Hide("HAT_HAIR")
        v.AnimState:Show("HAIR_NOHAT")
        v.AnimState:Show("HAIR")
	end	
	end
	MakeInventoryFloatable(inst, "idle", "idle")
	inst.AnimState:PlayAnimation("idle")
	SpawnPrefab("splash_water_drop").Transform:SetPosition(inst:GetPosition():Get())
	end
end

if inst.components.inventoryitem ~= nil then
	inst:RemoveComponent("inventoryitem")
	--[[if inst.components.equippable ~= nil then
	inst:RemoveComponent("equippable")
	end]]
end
inst.light_on = false
inst.Light:Enable(false)


inst.picked = false
inst.icon = false
inst.sg:GoToState("walk")

	if inst.level1 or inst.super_baby then
   inst.baby = false
   inst.house = false
   inst.baby_light_off = true
   ystarve(inst)
   inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
   inst.AnimState:SetBloomEffectHandle( "" )
   --inst.components.growable:StartGrowing()
	end
	
    local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 3, {"musha"})
	for k,v in pairs(ents) do
	if v.components.leader:CountFollowers("yamcheb") == 0 then
		inst.components.follower:SetLeader(v)
		inst.sleepn = false 
		inst.fightn = false
		inst.slave = true
		v.follow = true
    end
end	

if inst.components.burnable and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
end

end

local function OnPutInInventory_Yamche(inst,data)
inst.components.follower:SetLeader(nil)
--[[if inst.components.container and not inst.picked then
inst.components.container:Close()
inst.components.container:DropEverything() 
--inst.components.container.canbeopened = false
end]]


	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false

	inst.item_ready_drop = false
	end

inst.light_on = false
inst.Light:Enable(false)

inst.picked = true	

	--[[if inst.level1 then
    inst.baby = true
    inst.light_on = false
	inst.house = false
	inst.baby_light_off = true
	end]]
end

local function onyamche_house(inst, owner)
inst.house = true
if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
         owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
end
	
if inst.components.equippable then
inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
end


	inst.pick1 = false
	inst.drop = true
	inst.working_food = false

	inst.item_ready_drop = false


	inst.components.follower:SetLeader(nil)
	if not inst.level1 and not inst.super_baby then	
	    owner.AnimState:OverrideSymbol("swap_hat", "hat_house", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
	end
if inst.level1 then		
inst.components.growable:StopGrowing()
 
    inst.baby = true
	inst.light_on = true
	inst.Light:Enable(true)

	ystarve(inst)
		
end
if inst.super_baby then		

    inst.baby = true
	inst.light_on = true
	inst.Light:Enable(true)

	ystarve(inst)
		
end
end

local function offyamche_house(inst, owner)
		owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
	if inst.level1 or inst.super_baby then	
	inst.baby = false
	inst.light_on = false
	inst.Light:Enable(false)
    end
end
	
local function Yamche_Hat(inst, data)
local leader = inst.components.follower.leader

if not leader and inst.components.inventoryitem ~= nil and inst.components.equippable --[[and inst.picked]] and not inst.icon and not inst.pick_me_up then
inst.icon = true
local inv_name = inst.prefab
	inst.components.inventoryitem.atlasname = "images/inventoryimages/"..inv_name..".xml"
 	
elseif not leader and inst.components.inventoryitem == nil and not inst.picked then
	if not inst.pick_me_up then
--inst.components.talker:Say("[ Pick me up ]") 
--inst.sg:GoToState("command") 
	inst.pick_me_up = true
	end
inst:AddComponent("inventoryitem")
inst.components.inventoryitem.cangoincontainer = false
local inv_name = inst.prefab
	inst.components.inventoryitem.atlasname = "images/inventoryimages/"..inv_name..".xml"
	inst.components.inventoryitem:SetOnDroppedFn(Dropped_Yamche)
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory_Yamche)
	if not inst.components.equippable then
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onyamche_house)
    inst.components.equippable:SetOnUnequip(offyamche_house)
		if inst.level1 then
	inst.components.equippable.walkspeedmult = 1.25
    inst.components.equippable.runspeedmult = 1.25
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small.xml"
		if not inst.components.insulator then
		inst:AddComponent("insulator")
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
		end
		end
		if inst.super_baby then
	inst.components.equippable.walkspeedmult = 1.25
    inst.components.equippable.runspeedmult = 1.25
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small_super.xml"
		if not inst.components.insulator then
		inst:AddComponent("insulator")
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
		end
		end
	end
elseif leader ~= nil and not inst.house and inst.components.inventoryitem ~= nil and not inst.picked then
inst:RemoveComponent("inventoryitem")
inst:RemoveComponent("equippable")
inst.pick_me_up = false
end

end
	 
local function GetReturnPos(inst)
    local rad = 2
    local pos = inst:GetPosition()
    --print("GetReturnPos", inst, pos)
    local angle = math.random()*2*PI
    pos = pos + Point(rad*math.cos(angle), 0, -rad*math.sin(angle))
    --print("    ", pos)
    return pos:Get()
end
	
local function hunting(inst)
if inst.active_hunt then
local random = 0.1
if math.random() < random then
inst.yamche_lightning = true
end
if not inst.active_hunt then
end	
end end

local function yamche_hunt(inst)

    local dist = 20
    if inst.active_hunt then --or inst.anti_monkey then
    return FindEntity(inst, dist, function(guy)
        return inst.components.combat:CanTarget(guy)
    end,
    nil,
   {"musha","player","wall","houndmound","structure","companion","yamche","yamcheb","beefalo","koalefant","arongb","pig","bee","rocky","webber","bird","statue","character","abigail","smashable","veggie","shadowminion","catcoon","animal"})
	end
end 	
 
local function Onhunt(inst, target)
    return inst.components.combat:CanTarget(target)
end

--level?
local function Checklevel(inst, data)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 15, {"musha"})
for k,v in pairs(ents) do
--[[if v.sleep_on or v.tiny_sleep and v.components.leader:IsFollower(inst) and v.components.leader:CountFollowers("yamcheb") == 1 then
	local max_stamina = 100
	local min_stamina = 0
	local max_fatigue = 100
	local min_fatigue = 0	
	local max_music = 100
	local min_music = 0	
			local mx=math.floor(max_stamina-min_stamina)
			local cur=math.floor(v.stamina-min_stamina)
			local mx2=math.floor(max_fatigue-min_fatigue)
			local cur2=math.floor(v.fatigue-min_fatigue)
			local mxx=math.floor(max_music-min_music)
			local curr=math.floor(v.music-min_music)
			local sleep = ""..math.floor(cur*100/mx).."%"
			local sleepy = ""..math.floor(cur2*100/mx2).."%"
			local music = ""..math.floor(curr*100/mxx).."%"
			
inst.components.talker:Say("[Musha]\n[Sleep]: "..(sleep).."   [Tired]: "..(sleepy).."\n[Performance]:"..(music))

elseif not v.sleep_on and not v.tiny_sleep then]]
    if inst.yamcheinfo and inst.level1 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 1\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/10")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level2 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 2\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/20")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level3 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 3\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/50")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level4 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 4\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/100")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level5 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 5\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/300")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level6 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 6\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/400")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level7 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 7\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/500")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level8 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 8\n"..STRINGS.MUSHA_HEALTH_MAX.."\n".. (inst.level + 800))
    inst.yamcheinfo = false 
end
end end
-- end

local function OnPower(inst, data)

local other = data.target
if not other:HasTag("smashable") and not other:HasTag("shadowminion") and other.components.health ~= nil then 

if inst.ranger2 then
local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetScale(0.6, 0.6, 0.6)
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
end
	if other and not inst.baby and inst.level1 and inst.ranger2 then
           SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-20)
		inst.components.health:DoDelta(-4)
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -4")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

	inst.ranger2 = false inst.yamche_lightning = false 
    elseif other and inst.level2 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-30)
		inst.components.health:DoDelta(-5)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -5")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level3 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-40)
		inst.components.health:DoDelta(-6)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -6")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level4 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-50)
		inst.components.health:DoDelta(-7)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -7")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level5 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-60)
		inst.components.health:DoDelta(-8)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -8")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level6 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-70)
		inst.components.health:DoDelta(-9)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -9")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level7 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-80)
		inst.components.health:DoDelta(-10)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -10")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level8 and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-90)
		inst.components.health:DoDelta(-12)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -11")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

	elseif other and inst.super_baby and inst.ranger2 then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-40)
		inst.components.health:DoDelta(-6)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST.." -6")
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			
inst.ranger2 = false inst.yamche_lightning = false 
 inst.components.combat:SetRange(2,3)
  
    end	
end 
end

function Power_check(inst, data)

if inst.yamche_lightning and inst.components.health:GetPercent() >=0.3 then 
inst.ranger2 = true
inst.bloom2 = true
inst.components.combat:SetRange(10,13)
if inst.bloom then
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHTNING)

inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst:DoTaskInTime(2, function() inst.AnimState:SetBloomEffectHandle( "" ) end)
inst.bloom = false
end
elseif not inst.yamche_lightning then
inst.ranger2 = false inst.yamche_lightning = false
inst.components.combat:SetRange(2,3)
inst.bloom = true
if inst.bloom2 then
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.bloom2 = false
end
elseif inst.yamche_lightning and inst.components.health:GetPercent() <0.3 then
--scheduler:ExecuteInTime(3, function() inst.components.talker:Say("[Not enough cost]")end)
end end


local function ForceFields(inst)
	if (inst.components.health ~= nil and not inst.components.health:IsDead()) then
		inst:AddDebuff("forcefield", "forcefield2")
	end
end
local function OnAttacked(inst, data)
local attacker = data.attacker

	if not inst.components.health:IsDead() then
    if inst.components.health:GetPercent() >= .7 then
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())	
    elseif inst.components.health:GetPercent() < .7 and inst.components.health:GetPercent() >= .5 then
	SpawnPrefab("yellow_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .5 and inst.components.health:GetPercent() >= .3 then
	SpawnPrefab("orange_leaves").Transform:SetPosition(inst:GetPosition():Get())
    elseif inst.components.health:GetPercent() < .3 then
	SpawnPrefab("red_leaves").Transform:SetPosition(inst:GetPosition():Get())
	end	end

	if inst.forcefields then
	
if attacker ~= nil and attacker.components.health ~= nil and attacker.components.combat ~= nil and not attacker:HasTag("musha") then
if attacker and not attacker:HasTag("thorny") and not attacker:HasTag("shadowcreature") and not attacker:HasTag("groundspike") and not attacker:HasTag("smashable") then
 
if not inst.iceyamche and inst.components.health:GetPercent() < .3 then
	if attacker and attacker.components.burnable and not attacker:HasTag("thorny") and not attacker:HasTag("shadowcreature") then
		local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(attacker:GetPosition():Get())
            attacker.components.burnable:IsBurning()
            attacker.components.health:DoDelta(-50)
            attacker.components.burnable:Ignite(true)
    end 
	if attacker and attacker.components.burnable and attacker.components.burnable:IsBurning() then
        attacker.components.burnable:Extinguish()
    end
	
elseif not inst.iceyamche and inst.components.health:GetPercent() then
	if attacker and not attacker:HasTag("thorny") and not attacker:HasTag("shadowcreature") then
        local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(attacker:GetPosition():Get())
            attacker.components.health:DoDelta(-10)
         
    end 

elseif inst.iceyamche and inst.components.health:GetPercent() < .3 then
	if attacker and attacker.components.freezable then
	local prefab = "icespike_fx_"..math.random(1,4)
    local fx = SpawnPrefab(prefab)
    local shards = math.random(0.7,0.8)
 	fx.Transform:SetScale(shards, shards, shards)
	fx.Transform:SetPosition(attacker:GetPosition():Get())

            attacker.components.freezable:AddColdness(2)
            attacker.components.freezable:SpawnShatterFX()
    end 
elseif inst.iceyamche and inst.components.health:GetPercent() >= .3 then
	if attacker and attacker.components.freezable then
	local prefab = "icespike_fx_"..math.random(1,4)
    local fx = SpawnPrefab(prefab)
    local shards = math.random(0.7,0.8)
 	fx.Transform:SetScale(shards, shards, shards)
	fx.Transform:SetPosition(attacker:GetPosition():Get())

            attacker.components.freezable:AddColdness(0.5)
            attacker.components.freezable:SpawnShatterFX()
    end 
end	
end	
end	
	
	inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/on")
	ForceFields(inst)
	inst.forcefields = false
	
		if inst.field_check and not inst.field_check_on then 
			inst.field_check_on = true
		end
		inst.field_check = true
		
		inst:DoTaskInTime(20,function(inst)
		if not inst.forcefields then
		inst.forcefields = true 
		end
		end)
	end
	
	
if attacker and attacker:HasTag("musha") then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end

if inst.sleep_on then
InShadow(inst)
end
if not inst.fightn and attacker and not attacker:HasTag("player") then
    inst.components.combat:SuggestTarget(attacker)
    inst.components.combat:ShareTarget(attacker, 3, function(dude) return dude:HasTag("yamche") and not dude.components.health:IsDead() end, 5)
end
end

local function OnRanger(inst, data)
local rangechance = 0.1
local other = data.target
		if inst.ranger then
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetScale(0.6, 0.6, 0.6)
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
		end
if not other:HasTag("smashable") and not other:HasTag("shadowminion") then
    if other and not inst.baby and not inst.ranger and math.random() < rangechance and not inst.ranger3 then
inst.ranger = true 
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	--inst.components.talker:Say("Full charged\n[Spark Strike]")
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
 inst.components.combat:SetRange(10,13)
 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level1 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-5)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level2 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-10)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level3 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-15)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level4 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-20)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level5 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-25)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level6 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-30)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level7 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-35)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
    elseif other and inst.level8 and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-40)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)
	elseif other and inst.super_baby and inst.ranger then
            SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-15)
            SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())

inst.ranger = false 
 inst.components.combat:SetRange(2,3)

    end
end 
end

local function hit_Ranger(inst, data)
local other = data.target
if not other:HasTag("smashable") and not other:HasTag("shadowminion") then
if other and not inst.baby and inst.level1 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --     SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-5)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst:DoTaskInTime(2, function() inst.AnimState:SetBloomEffectHandle( "" ) end)
   elseif other and inst.level2 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-10)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
 inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level3 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-15)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level4 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-20)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
 inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level5 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-25)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level6 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-30)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
 inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level7 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-35)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
    elseif other and inst.level8 and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-40)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)
	elseif other and inst.super_baby and inst.components.health:GetPercent() < .3 and inst.ranger3 then
        --    SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
        other.components.health:DoDelta(-15)
            SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.ranger = false 
inst:DoTaskInTime(2, function() if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end end)

    end end
end

local function continue_Ranger(inst, data)

    if --[[not inst.baby and]] inst.components.health:GetPercent() < .3 and not inst.ranger2 then
inst.ranger3 = true 
inst.components.combat:SetRange(10,13)

    elseif --[[not inst.baby and]] inst.components.health:GetPercent() >= .3 and not inst.ranger2 then
inst.ranger3 = false	
inst.components.combat:SetRange(2,3)
    end
end

local function OnHitfire(inst, data)
local other = data.target
if other ~= nil then
if not inst.iceyamche and not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") and other.components.health and not other.components.health:IsDead() then

	--if math.random() < 0.3 then
		--SpawnPrefab("deer_fire_burst").Transform:SetPosition(other:GetPosition():Get())
		
		local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(other:GetPosition():Get())
		
		if inst.level1 then
		elseif inst.level2 then
		other.components.health:DoDelta(-3)
		elseif inst.level3 then
		other.components.health:DoDelta(-6)
		elseif inst.level4 then
		other.components.health:DoDelta(-9)
		elseif inst.level5 then
		other.components.health:DoDelta(-12)
		elseif inst.level6 then
		other.components.health:DoDelta(-15)
		elseif inst.level7 then
		other.components.health:DoDelta(-18)
		elseif inst.level8 then
		other.components.health:DoDelta(-21)
		else
		other.components.health:DoDelta(-10)
		end
		
	--else
			
   --local pos = other:GetPosition()
   if math.random() < 0.7 then
	if not other:HasTag("buzzard") and not other:HasTag("player") then
    if other.components.burnable and not other:HasTag("structure") and (inst.level1 or inst.super_baby) then
		other.components.burnable:Ignite()

		other.components.health:DoDelta(-5)
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level2 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-10)		
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level3 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-15)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level4 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-20)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level5 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-25)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level6 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-30)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level7 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-35)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level8 and not inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-40)	

   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level2 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-4)		
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level3 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-8)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level4 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-12)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level5 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-16)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level6 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-20)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level7 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-24)	
   elseif other and other.components.burnable and not other:HasTag("structure") and inst.level8 and inst.doctor then
        other.components.burnable:Ignite()
		
		
		other.components.health:DoDelta(-28)	

	end
		if other.components.burnable and other.components.burnable:IsBurning() and not other:HasTag("buzzard") then
        other.components.burnable:Extinguish()
		end
	end	
	end
		
		if other:HasTag("musha") then
		inst.components.combat:SetTarget(nil)
		inst.components.combat:GiveUp()
		end
end
end
end

local function OnHitfreeze(inst, data)
local other = data.target
if inst.iceyamche and not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") and other.components.health and not other.components.health:IsDead() then
	
		--[[if inst.level1 then
		elseif inst.level2 then
		other.components.health:DoDelta(-2)
		elseif inst.level3 then
		other.components.health:DoDelta(-4)
		elseif inst.level4 then
		other.components.health:DoDelta(-6)
		elseif inst.level5 then
		other.components.health:DoDelta(-8)
		elseif inst.level6 then
		other.components.health:DoDelta(-10)
		elseif inst.level7 then
		other.components.health:DoDelta(-12)
		elseif inst.level8 then
		other.components.health:DoDelta(-15)
		end]]
	
   --local pos = other:GetPosition()
	  if other and other.components.freezable and not other:HasTag("structure") and inst.level2 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.2)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.1,0.2)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level3 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.3)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.2,0.3)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level4 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.7)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.3,0.4)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level5 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.5)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.4,0.5)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level6 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.6)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.5,0.6)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level7 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.7)
        other.components.freezable:SpawnShatterFX()
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.6,0.7)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.level8 and not inst.ranger2 then
        other.components.freezable:AddColdness(0.8)
        other.components.freezable:SpawnShatterFX()  	
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			local shards = math.random(0.7,0.8)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())		
  elseif other and other.components.freezable and not other:HasTag("structure") and inst.ranger2 then
        other.components.freezable:AddColdness(2)
        other.components.freezable:SpawnShatterFX() 
		local prefab = "icespike_fx_"..math.random(1,4)
			local fx = SpawnPrefab(prefab)
			fx.Transform:SetScale(1, 1.5, 1)
			fx.Transform:SetPosition(other:GetPosition():Get())
elseif other and other:HasTag("musha") then
	inst.components.combat:SetTarget(nil)
	inst.components.combat:GiveUp()

    end
--[[if other.components.freezable and other.components.freezable:IsFrozen() and other:HasTag("dragonfly") then
      inst:DoTaskInTime( 1.5, function()  other.components.freezable:Unfreeze() end)
end]]
    if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
    end
end
end


local function OnHitvampire(inst, data)
local other = data.target
if not other:HasTag("smashable") and not other:HasTag("shadowminion") then
--[[inst.darkyamche]]
 if other and inst.vampire and inst.vampire_on then
        SpawnPrefab("statue_transition").Transform:SetPosition(other:GetPosition():Get())
        inst.components.health:DoDelta(10)

    end
end
end


local function cure1_proc(inst, data)

--inst.components.health:DoDelta(100)
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
inst:DoTaskInTime(--[[Duration]] 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)

inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_SHIELD_COOL)
inst:DoTaskInTime(--[[Cooldown]] 300, function() inst.shield_on = false end)
end 
end) 
end 

local function tryproc(inst)
if not inst.shield_on and inst.components.health:GetPercent() < .2  then
            cure1_proc(inst)
elseif inst.shield_on and inst.components.health:GetPercent() < .2  and inst.components.health:GetPercent() > .1 then
 inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HEALTH_WARN1)			
elseif inst.shield_on and inst.components.health:GetPercent() <= .1 then 
  inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HEALTH_WARN2)			
    end end


local function on_close(inst)
local owner = inst.components.follower.leader
if owner ~= nil then
inst.MiniMapEntity:SetIcon( "" )
inst.follow = false
elseif owner == nil then
inst.MiniMapEntity:SetIcon( "musha_small.tex" )
end
if inst.pick1 then

inst.components.locomotor.walkspeed = 8
else
	if inst.super_baby then
	inst.components.locomotor.walkspeed = 8
	else
	inst.components.locomotor.walkspeed = 6
	end
end
end

local function on_far(inst)
local owner = inst.components.follower.leader

if owner ~= nil then

	if inst.active_hunt then
		inst.MiniMapEntity:SetIcon( "musha_small.tex" )
	elseif not inst.active_hunt then
		inst.MiniMapEntity:SetIcon( "" )
	end
	
inst.follow = true

inst.components.combat:GiveUp()
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp() 
end

if owner.riding_arong then
inst.components.locomotor.walkspeed = 22
else
	if inst.super_baby then
	inst.components.locomotor.walkspeed = 18
	else
	inst.components.locomotor.walkspeed = 12
	end
end

elseif owner == nil then
inst.MiniMapEntity:SetIcon( "musha_small.tex" )
inst.components.locomotor.walkspeed = 6
end 

end

-----------------------
local function onignite(inst)
local danger = FindEntity(inst, 3, function(target) 
	return target:HasTag("monster") or (target.components.combat and target.components.combat.target == inst) end)
if danger then
	if inst.components.burnable:IsBurning() and not inst.components.health:IsDead() then
		inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DANGER.." \n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_OFF)
		inst.components.health:DoDelta(30)
	end
else
if inst.house then
	local owner = inst.components.follower.leader
	if owner and inst.components.burnable:IsBurning() then
	owner.components.health.fire_damage_scale = 0
    --inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	--inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_OFF)
	elseif owner and not inst.components.burnable:IsBurning() then
		if not owner.active_valkyrie and not owner.berserks then
		owner.components.health.fire_damage_scale = 1	
		end
	end
elseif not inst.house then
InShadow(inst)
inst.sg:GoToState("sleep")
inst.campfire = true
local leader = inst.components.follower.leader
if leader then
leader.follow = false
leader.yamche_follow = false
end
inst.components.follower:SetLeader(nil)
if not inst.iceyamche then 
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_ON.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_FIRE_WARM)
elseif inst.iceyamche then 
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_ON.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_FIRE_COLD)
end
	  
	if inst.campfire then	  
		inst.components.locomotor.walkspeed = 0
	end
	if not inst.components.cooker then
        inst:AddComponent("cooker")
	end
 end 
 end
end

local function onextinguish(inst)
if inst.campfire and inst.components.sleeper:IsAsleep() then
    inst.components.sleeper:WakeUp()
end			
inst.components.locomotor.walkspeed = 8
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)
    end
	if inst.components.cooker then
        inst:RemoveComponent("cooker")
	end

end

local function cooked(inst)

	local container = inst.components.container

	if not inst.iceyamche then
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
	     		local replacement = nil 
				if (item.components.cookable ~= nil) or item.prefab == "log" then 
				inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
					local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
					fx.Transform:SetPosition(pos:Get())
				end
				
		     	if item.components.cookable ~= nil then 
		     		replacement = item.components.cookable:GetProduct()
		     	elseif item.prefab == "log" then 
		     		replacement = "charcoal"
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

	--[[if inst.iceyamche then
		for i = 1, container:GetNumSlots() do
	        local item = container:GetItemInSlot(i)
	     	if item then 
	     		local replacement = nil 
				if item.prefab == "watermelon" or item.prefab == "butter" or item.prefab == "cave_banana" then 
				inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") 
						local fx = SpawnPrefab("collapse_small")
					local pos = Vector3(inst.Transform:GetWorldPosition())
					fx.Transform:SetScale(0.5, 0.5, 0.5)
				fx.Transform:SetPosition(pos:Get())
				end
				
		     	if item.prefab == "watermelon" then 
		     		replacement = "watermelonicle"
				elseif item.prefab == "butter" then 
		     		replacement = "icecream"
				elseif item.prefab == "cave_banana" then 
		     		replacement = "bananapop"	
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
	end ]]
	end
-----------------------

local function OnOpen(inst)
 if not inst.components.health:IsDead() then
inst.open = true
inst.sg:GoToState("open") 

--[[inst:DoTaskInTime(0, function()
	if inst.components.inventory ~= nil then
	inst.opening = true
	local inv = inst.components.inventory 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
	if not item and inst.opening then
		
	inst.opening = false
	elseif item and item:IsValid() and inst.opening then
	if inst.components.container ~= nil then
	inst.components.container:DropEverything() end 
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
		if not inst.light_on then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DROP.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
		elseif inst.light_on then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DROP..STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x5)")
		end
	end
	
		if inst.components.inventory ~= nil then
		inst.components.inventory:DropEverything(true) 
		end
	inst.item_ready_drop = false
	SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
	if inst.components.container ~= nil then
	inst.components.container:Close()
	end
	inst.sg:GoToState("taunt")
	
	inst.opening = false
	inst.open = false
	
	end 
	end
	end
end)]]
	if inst.iceyamche then	
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		if not inst.house then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_FREEZER)
		end
	else
	inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		if not inst.house then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_OVEN)
		end
	end
	
if inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.campfire = false
	if not inst.components.follower.leader then
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 3, {"musha"})
	for k,v in pairs(ents) do
	if v.components.leader:CountFollowers("yamcheb") == 0 then
		inst.components.follower:SetLeader(v)
		inst.sleepn = false 
		inst.fightn = false
		inst.slave = true
		v.follow = true
    end
	end	
	end
end

if inst.components.freezable:IsFrozen() then
        inst.components.freezable:Unfreeze()
end
end
end

local function blueone(inst)
	
	if inst.components.inventory then
	inst.components.inventory:DropEverything() end
	if inst.components.container then
	inst.components.container:DropEverything() end
	
	SpawnPrefab("lightning_blue").Transform:SetPosition(inst.Transform:GetWorldPosition())
  	SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
	--inst.sg:GoToState("walk")
	
if inst.level2 then
	
		local poo = SpawnPrefab("musha_teenice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level3 then
	
		local poo = SpawnPrefab("musha_tallrice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level4 then
	
		local poo = SpawnPrefab("musha_tallrrice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level5 then
	
		local poo = SpawnPrefab("musha_tallrrrice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level6 then

		local poo = SpawnPrefab("musha_tallrrrrice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level7 then
	
		local poo = SpawnPrefab("musha_tallrrrrrice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level8 then
	
		local poo = SpawnPrefab("musha_rpice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()		
		
end
end

local function fireone(inst)
	
	if inst.components.container ~= nil then
	inst.components.container:DropEverything() end
	
	SpawnPrefab("lightning_blue").Transform:SetPosition(inst.Transform:GetWorldPosition())
  	SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
	--inst.sg:GoToState("walk")
	
if inst.level2 then
	
		local poo = SpawnPrefab("musha_teen")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level3 then
	
		local poo = SpawnPrefab("musha_tallr3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level4 then
	
		local poo = SpawnPrefab("musha_tallrr3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level5 then
	
		local poo = SpawnPrefab("musha_tallrrr3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level6 then

		local poo = SpawnPrefab("musha_tallrrrr3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level7 then
	
		local poo = SpawnPrefab("musha_tallrrrrr3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()
elseif inst.level8 then
	
		local poo = SpawnPrefab("musha_rp3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition())
            ndie(inst)
		inst:Remove()		
		
end
end

local function OnClose(inst) 
if not inst.components.health:IsDead() then
inst.open = false
--inst.opening = true
inst.opening = false
  
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	
inst.sg:GoToState("close")
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) 
end
cooked(inst)

if inst.iceyamche then
	
	local inv = inst.components.container 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
		if item and item.components.perishable then 
		item.components.perishable:StopPerishing()
		end
	end	
end

if not inst.iceyamche then
	if inst.components.container ~= nil then

	local inv = inst.components.container 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
        if item == nil then
            return false, false
        end
      
        if item.prefab == "cristal" then
            blueone(inst)
        end
    end
	end
	
elseif inst.iceyamche then
	if inst.components.container ~= nil then

	local inv = inst.components.container 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
        if item == nil then
            return false, false
        end
      
        if item.prefab == "cristal" then
            fireone(inst)
        end
    end
	end
end

end	
end 

----------
local function PhoenixSanityAura(inst, observer)
	if inst.components.hunger:GetPercent() < .5 then
		return TUNING.SANITYAURA_TINY
	elseif inst.components.hunger:GetPercent() >= .5 then
			return TUNING.SANITYAURA_SMALL_TINY
	end

	if inst.components.follower and inst.components.follower.leader == observer then
		--return TUNING.SANITYAURA_TINY
		return 0
	end
		return 0
	end

local function ShouldWakeUp(inst)
--DefaultWakeTest(inst)
--inst.inst.fightn  --inst.sleep_on 
    return 
end

local function ShouldSleep(inst)
--DefaultSleepTest(inst)
local owner = inst.components.follower.leader
    return (inst.fightn or inst.sleep_on) and not inst.components.hunger:IsStarving(inst) 
end

--[[
local function CanEatTest(inst, item)
    --print("smallbird - CanEatTest", inst.name, item.components.edible.foodtype, item, item.prefab)
	    --local canEat = (item.components.edible.foodtype == "SEEDS") or (item.prefab == "berries")
    --print("   canEat?", canEat)

	if not item:HasTag("spoiled") or not item:HasTag("flower") then
			return true
-- return canEat

end 
end]]

 	
--[[local function ShouldAcceptItem(inst, item)
    if inst.components.eater:CanEat(item) and inst.components.hunger:GetPercent() <= 0.9 then
    	return true
	else
		return false
	end
end]]

local function ShouldAcceptItem(inst, item)

    if item.components.edible then
        return inst.components.eater:CanEat(item) and inst.components.hunger:GetPercent() <= 0.9
    end 
	if inst.components.sleeper:IsAsleep() then
        inst.components.sleeper:WakeUp()
		inst.sleep_on = false
		inst.fightn = false
		if inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
		inst.campfire = false
		end
	end end

local function OnGetItemFromPlayer(inst, giver, item)
      
	if inst.components.sleeper:IsAsleep() then
        if inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.campfire = false
		end
    end
    --I eat food
    if item.components.edible then
	        if inst.components.combat.target and inst.components.combat.target == giver then
            inst.components.combat:SetTarget(nil)
	elseif giver.components.leader then
	--inst.SoundEmitter:PlaySound("dontstarve/creatures/smallbird/scratch_ground")
	--giver.components.leader:AddFollower(inst)
        end
        if inst.components.eater:Eat(item) then
		inst.sg:GoToState("eating")
	    end 
	end
end

local function yamche_campfire(inst)
if not inst.components.burnable then
inst:AddComponent("burnable")
end
if not inst.iceyamche then 
   inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,.9,0) )  

 	inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
	inst.components.fueled.bonusmult = 2
    inst.components.fueled:SetSections(6)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
   inst.components.fueled:SetUpdateFn( function()
       local fueled = inst.components.fueled

    fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1

    if inst.components.burnable ~= nil then
        inst.components.burnable:SetFXLevel(fueled:GetCurrentSection(), fueled:GetSectionPercent())
    end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
				inst.campfire = false
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
    
else
    inst.components.burnable:AddBurnFX("coldfirefire", Vector3(0,0.5,0) )
   -------------------------
  	inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
	inst.components.fueled.bonusmult = 2
    inst.components.fueled:SetSections(6)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
   inst.components.fueled:SetUpdateFn( function()
        local fueled = inst.components.fueled

    fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1

    if inst.components.burnable ~= nil then
        inst.components.burnable:SetFXLevel(fueled:GetCurrentSection(), fueled:GetSectionPercent())
    end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
				inst.campfire = false
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
   
end
end

local poopchance2 = 0.65
local poopchance = 0.45
local rebackchance = 0.25
local tynychance = 0.2
local tynyychance = 0.1
local eggchance = 1.0

local function OnEat(inst, food, item, spawn)
 --inst.components.health:Kill()
 
 if inst.iceyamche then
 if food.prefab == "glowdust" then
	local inv = inst.components.container 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
		if item and item.components.perishable then 
			 item.components.perishable:SetPercent(1)
	local fresh = item.components.perishable:GetPercent()
	inst.components.talker:Say(" ※ ")
		end
	end	
end
end
 
 
if (food.prefab == "icecream" or food.prefab =="watermelonicle") and not inst.iceyamche then
inst.changed = true
inst.iceyamche = true

inst:RemoveComponent("burnable")
yamche_campfire(inst)
inst:AddTag("fridge")
inst.doctor = false
if inst.changed then
inst.changed = false
SpawnPrefab("lightning_blue").Transform:SetPosition(inst.Transform:GetWorldPosition())
  	SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.sg:GoToState("walk")
end
inst.AnimState:SetBuild("musha_ice")

elseif food.prefab == "hotchili" and inst.iceyamche then
inst.changed = true

inst.iceyamche = false
inst:RemoveComponent("burnable")
yamche_campfire(inst)
inst:RemoveTag("fridge")
if inst.changed then
inst.changed = false
SpawnPrefab("lightning_blue").Transform:SetPosition(inst.Transform:GetWorldPosition())
  	SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.sg:GoToState("walk")
end

if math.random() < 0.25 then
inst.AnimState:SetBuild("musha_small")
inst.doctor = true
elseif math.random() < 0.5 then
inst.AnimState:SetBuild("musha_teen")
inst.doctor = false
elseif math.random() < 0.5 then
inst.AnimState:SetBuild("musha_tall")
inst.doctor = false
elseif math.random() < 0.5 then
inst.AnimState:SetBuild("musha_tall2")
inst.doctor = false
elseif math.random() < 0.5 then
inst.AnimState:SetBuild("musha_tall3")
inst.doctor = false
elseif math.random() < 0.25 then
inst.AnimState:SetBuild("musha_tall4")
inst.doctor = false
elseif math.random() < 0.25 then
inst.AnimState:SetBuild("musha_tall5")
inst.doctor = false
else
inst.AnimState:SetBuild("musha_tall")
inst.doctor = false
end
end


--[[if food.components.edible and food.components.edible.hungervalue == TUNING.SPOILED_HUNGER then 
inst.sg:GoToState("refuse")
inst.components.talker:Say("foo? food?")
inst.components.hunger:DoDelta(15)]]

if not inst.changed then

if not inst.house and food.components.edible and food.components.edible.hungervalue <= 0 then 
--inst.sg:GoToState("refuse")
inst.components.talker:Say("foo? food?")
inst.components.hunger:DoDelta(18)
inst.sg:GoToState("refuse")
end

    if food.components.edible then
	inst.components.health:DoDelta(40)
	end

    -- food heal
    --if inst:HasTag("companion") then
        inst.components.health:DoDelta(inst.components.health.maxhealth * .05, nil, food.prefab)
        inst.components.combat:SetTarget(nil)
    --else
    --    inst.components.health:DoDelta(inst.components.health.maxhealth, nil, food.prefab)
    --end
    -- VEGGIE -- MEAT -- SEEDS

if not inst.house then	

if food.prefab == "mandrakesoup" then 
	inst.level = inst.level + 80
	levelexp(inst)
inst.components.hunger:DoDelta(150)
inst.components.talker:Say(" ★ \n"..STRINGS.MUSHA_LEVEL_EXP.." + 80 ")

else
	
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
	elseif food.components.edible and food.components.edible.hungervalue < 9 and math.random() < 0.1 then
		inst.level = inst.level + 1
		levelexp(inst)			
		end
end		
	end
		
		
inst:DoTaskInTime(1, function()
	
    if food.components.edible and (food.components.edible.hungervalue >= 140 and food.components.edible.healthvalue >= 90) then
inst.components.health:DoDelta(300)

    if math.random() < tynychance then
		local poo = SpawnPrefab("orangegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("greengem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("yellowgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < 0.5 then
		local poo = SpawnPrefab("purplegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < 0.5 then
		local poo = SpawnPrefab("redgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < 0.5 then
		local poo = SpawnPrefab("bluegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
  	end
	

    elseif food.components.edible and (food.components.edible.hungervalue >= 140 or food.components.edible.healthvalue >= 30) then
inst.components.health:DoDelta(400)

    if math.random() < rebackchance then
		local poo = SpawnPrefab("goldnugget")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
		levelexp(inst)
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("redgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		levelexp(inst)
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("bluegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
		levelexp(inst)
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("purplegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		levelexp(inst)
    --[[elseif math.random() < tynyychance then
		local poo = SpawnPrefab("greengem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		levelexp(inst)
	elseif math.random() < tynyychance then
		local poo = SpawnPrefab("yellowgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		levelexp(inst)
	elseif math.random() < tynyychance then
		local poo = SpawnPrefab("orangegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		levelexp(inst)]]
	elseif math.random() < tynychance then
		local poo = SpawnPrefab("wormlight_lesser")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
		
	end

    elseif food.components.edible and (food.components.edible.hungervalue >= 50 or food.components.edible.healthvalue >= 20 ) then
inst.components.health:DoDelta(200)

    if math.random() < rebackchance then
		local poo = SpawnPrefab("goldnugget")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("nitre")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
	elseif math.random() < rebackchance then
		local poo = SpawnPrefab("wormlight_lesser")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < 0.05 then
		local poo = SpawnPrefab("redgem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < 0.05 then
		local poo = SpawnPrefab("bluegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)			
  elseif math.random() < 0.05 then
		local poo = SpawnPrefab("purplegem")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
	end
	end


	if food.components.edible and food.components.edible.foodtype == "MEAT" then
	local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.7, 0.7, 0.7)
	fx.Transform:SetPosition(inst:GetPosition():Get())
   	
    if math.random() < poopchance then
		local poo = SpawnPrefab("guano")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < rebackchance then
		local poo = SpawnPrefab("poop")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("spoiled_food")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif inst.iceyamche and math.random() < poopchance then
		local poo = SpawnPrefab("ice")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < tynyychance then
		local poo = SpawnPrefab("wormlight_lesser")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
	end
	
    elseif food.components.edible and food.components.edible.foodtype == "VEGGIE" then
	local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.5, 0.5, 0.5)
	fx.Transform:SetPosition(inst:GetPosition():Get())
    if math.random() < poopchance then
		local poo = SpawnPrefab("seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("carrot_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pumpkin_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("dragonfruit_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("watermelon_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)			
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("pomegranate_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("corn_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("eggplant_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)			
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("eggplant_seeds")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)	
    elseif math.random() < tynychance then
		local poo = SpawnPrefab("lightbulb")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
    elseif math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
	end
    elseif food.components.edible and food.components.edible.foodtype == "SEEDS" then
	local fx = SpawnPrefab("poopcloud")
	fx.Transform:SetScale(0.2, 0.2, 0.2)
	fx.Transform:SetPosition(inst:GetPosition():Get())
    if math.random() < poopchance then
		local poo = SpawnPrefab("ash")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) poo.Transform:SetScale(0.5, 0.5, 0.5)		
	end
	end
	
end)

if food and food.components.edible and food.prefab == "cristal" then
	local dark2 = SpawnPrefab("statue_transition_2")
	dark2.Transform:SetPosition(inst:GetPosition():Get())
	if inst.components.container ~= nil then
	inst.components.container:DropEverything() end 

	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
		
if food and food.components.edible and food.prefab == "cristal" and inst.level1 then
		local poo = SpawnPrefab("musha_egg")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()

end
if food and food.components.edible and food.prefab == "cristal" and inst.level2 then
		local poo = SpawnPrefab("musha_eggs1")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
    end

if food and food.components.edible and food.prefab == "cristal" and inst.level3 then
		local poo = SpawnPrefab("musha_eggs2")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
end

if food and food.components.edible and food.prefab == "cristal" and inst.level4 then
		local poo = SpawnPrefab("musha_eggs3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
end

if food and food.components.edible and food.prefab == "cristal" and inst.level5 then
		local poo = SpawnPrefab("musha_egg1")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
end

if food and food.components.edible and food.prefab == "cristal" and inst.level6 then
		local poo = SpawnPrefab("musha_egg2")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
end

if food and food.components.edible and food.prefab == "cristal" and inst.level7 then
		local poo = SpawnPrefab("musha_egg3")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 	
            ndie(inst)
    inst:Remove()
end

if food and food.components.edible and food.prefab == "cristal" and inst.level8 then
		local poo = SpawnPrefab("musha_egg8")
		poo.Transform:SetPosition(inst.Transform:GetWorldPosition()) 
            ndie(inst)
    inst:Remove()
end
end 
end
end

local function OnRefuseItem(inst, item)
    inst.sg:GoToState("refuse")
    if inst.components.sleeper:IsAsleep() then
        if inst.components.burnable:IsBurning() then
		inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.campfire = false
		end
end
end

local function OnNewTarget(inst, data)
    --print("teenbird - OnNewTarget", data.target, inst.components.follower.leader)
    if data.target and data.target:HasTag("player") then
	return 
end end

	
local function resist(inst, data)

if inst.components.health:GetPercent() < 0.2 and not inst.vampire then
            inst.vampire = SpawnPrefab( "debuff_bloodlp" )
			inst.vampire.Transform:SetScale(0.3, 0.3, 0.3)
            local follower = inst.vampire.entity:AddFollower()
            follower:FollowSymbol( inst.GUID, "head", 0, -130, 2 )
			inst.vampire_on = true
			inst:DoTaskInTime(--[[Duration]] 30, function()
			if inst.vampire then
				inst.vampire:Remove()
				inst.vampire = nil
				inst.vampire_on = false
			end	
			inst:DoTaskInTime(--[[Cooldown]] 300, function() inst.vampire_on = false end)
			end)
end	
--[[if inst.components.health:GetPercent() >= 0.9 and inst.vampire then
			inst.vampire:Remove()
			inst.vampire = nil
			inst.vampire_on = false
end]]

if inst.components.health and not inst.open then 
	if not inst.sleep_on and inst.components.health:GetPercent() >= .3 then
		inst.components.health:StartRegen(1, 30)
elseif not inst.sleep_on and inst.components.health:GetPercent() < .3 then
		inst.components.health:StartRegen(1, 1)		
elseif inst.sleep_on then
		inst.components.health:StartRegen(2, 1)		
	end		
end

if inst.components.health:GetPercent() <= 1 and  inst.components.health:GetPercent() > 0.7 then
        inst.components.freezable.wearofftime = 1.5

elseif inst.components.health:GetPercent() <= 0.7 and  inst.components.health:GetPercent() > 0.5 then
        inst.components.freezable.wearofftime = 0.5

elseif inst.components.health:GetPercent() <= 0.5 and  inst.components.health:GetPercent() > 0.2 then
        inst.components.freezable.wearofftime = 0.25

elseif inst.components.health:GetPercent() <= 0.2 then
        inst.components.freezable.wearofftime = 0
end end

local function anti_monkey(inst)
if inst.components.follower.leader and inst.components.container and not inst.picked then
inst.components.container.canbeopened = false
inst:DoTaskInTime(9, function() inst.anti_monkey = false inst.components.container.canbeopened = true end)

end end


local function on_follow(inst, data)

--Checklevel
    if inst.yamcheinfo and inst.level1 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 1\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/10\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 0")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level2 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 2\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/20\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 2")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level3 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 3\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/50\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 4")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level4 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 4\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/100\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 6")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level5 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 5\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/300\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 9")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level6 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 6\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/400\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 16")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level7 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 7\n"..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level).."/500\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 20")
    inst.yamcheinfo = false 
    elseif inst.yamcheinfo and inst.level8 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." 8\n"..STRINGS.MUSHA_HEALTH_MAX.."\n".. (inst.level + 800).."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 20")
    inst.yamcheinfo = false 
	 elseif inst.yamcheinfo and inst.super_baby then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.." Super Baby\n"..STRINGS.MUSHA_HEALTH_MAX.."\n".. (inst.level + 300).."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV..": 6")
    inst.yamcheinfo = false 
end

--anti monkey  -- Don't Touch Me
if not inst.sleep_on and not inst.anti_monkey then
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"monkey"})
for k,v in pairs(ents) do
if not v:HasTag("nightmare") then
inst.anti_monkey = true
local random = 0.2
if math.random() < random then
inst.components.talker:Say(STRINGS.MUSHA_TALK_THIEF_1)
elseif math.random() < random then
inst.components.talker:Say(STRINGS.MUSHA_TALK_THIEF_2)
elseif math.random() < random then
inst.components.talker:Say(STRINGS.MUSHA_TALK_THIEF_3)
elseif math.random() < random then
inst.components.talker:Say(STRINGS.MUSHA_TALK_THIEF_4)
end
inst.yamche = true
anti_monkey(inst)
end end
end
--close with sleep
if inst.components.container ~= nil then

if not inst.house then
if not inst.components.follower.leader and not inst.picked then
inst.components.container.canbeopened = false
inst.anti_monkey = false
elseif inst.components.follower.leader and not inst.sleep_on and not inst.anti_monkey and not inst.picked then
inst.components.container.canbeopened = true
end
elseif inst.house then
inst.components.container.canbeopened = true
end
end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20, {"musha"})
for k,v in pairs(ents) do
if not v.yamche_follow then
v.yamche_follow = true
end
 end
 end 
 
local function on_wakeup(inst, data)
--light 
if TheWorld.state.isnight and not inst.light_on and not inst.house then
inst.Light:Enable(true)
inst.light_on = true
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
	if not inst.campfire then
	if not inst.fightn and not inst.pick1 then
		ystarve(inst)
		if not inst.components.sleeper:IsAsleep() then
		inst.sg:GoToState("taunt")
		end
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x5)")
	elseif not inst.fightn and inst.pick1 then
		ystarve(inst)
		if not inst.components.sleeper:IsAsleep() then
		inst.sg:GoToState("taunt")
		end
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_WORKING.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x14)")
	elseif inst.fightn then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(0)")
		inst.sg:GoToState("close")
	end
	local leader = inst.components.follower.leader
	if leader == nil then
	inst.sleep_on = true
	end
	end
elseif not TheWorld.state.isnight and inst.light_on and not inst.house then
inst.Light:Enable(false)
inst.light_on = false
inst.AnimState:SetBloomEffectHandle( "" )
	inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
	if not inst.fightn and not inst.pick1 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
	elseif not inst.fightn and inst.pick1 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_WORKING.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x6)")
	if not inst.baby then
	inst.sg:GoToState("close")
	end
	end
end

local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 4, {"musha"})
for k,v in pairs(ents) do
if (v.sleep_on or v.tiny_sleep) and inst.components.follower and v.components.leader:IsFollower(inst) then
inst.sleep_on = true
elseif not (v.sleep_on and v.tiny_sleep) and inst.components.follower and v.components.leader:IsFollower(inst) then
inst.sleep_on = false
inst.fightn = false
if not inst.campfire and inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp() 
end
end 

end 

--[[if not inst.components.follower:IsNearLeader(6) then
		if inst.campfire and inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp() 
		inst.campfire = false
			if inst.components.burnable:IsBurning() then
			inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_OFF)
			end
		end
end]]
end
 


local function updatestats(inst, data)
	if inst.components.health ~= nil then
		if inst.components.health:GetPercent() >= .3 and not inst.iceyamche and not inst.open then
    inst.components.combat:SetAttackPeriod(0.8)

		elseif inst.components.health:GetPercent() >= .3 and inst.iceyamche and not inst.open then
    inst.components.combat:SetAttackPeriod(0.8)

		elseif inst.components.health:GetPercent() < .3 and not inst.iceyamche and not inst.open then
    inst.components.combat:SetAttackPeriod(2.4)
	
		elseif inst.components.health:GetPercent() < .3 and inst.iceyamche and not inst.open then
    inst.components.combat:SetAttackPeriod(2.4)
	
		end
	end
end

local function taunting(inst, data)
local leader = inst.components.follower.leader
if leader and not inst.peace and not inst.active_hunt and not inst.defense and inst.components.health:GetPercent() >= .25 then
if leader.components.health:GetPercent() >= .5 and leader.components.health:GetPercent() < .95 then

	local x,y,z = inst.Transform:GetWorldPosition()	
	local enemy = TheSim:FindEntities(x, y, z, 8)
	for k,v in pairs(enemy) do
	if v and v.components.combat and v.components.health and not v.components.health:IsDead() and v.entity:IsVisible() and leader.components.combat.target == v then
		if not ( v:HasTag("shadowcreature") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("structure")) then
		v.components.combat.target = inst
		inst.components.combat.target = v		
		--inst.taunting = true
		SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_hot_loop").Transform:SetPosition(v:GetPosition():Get())
		inst.sg:GoToState("command")
			if not inst.components.health:IsDead() then
			inst.components.health:DoDelta(1)
			end
		end
	end
	end
 
elseif leader.components.health:GetPercent() <= .5 then
	local x,y,z = inst.Transform:GetWorldPosition()	
	local enemy = TheSim:FindEntities(x, y, z, 8)
	for k,v in pairs(enemy) do
	if v and v.components.combat and v.components.combat.target == leader then
		if not ( v:HasTag("shadowcreature") or v:HasTag("butterfly") or v:HasTag("bird") or v:HasTag("prey") or v:HasTag("companion") or v:HasTag("player") or v:HasTag("character") or v:HasTag("structure")) then
		v.components.combat.target = inst	
		--inst.taunting = true
		SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("dr_hot_loop").Transform:SetPosition(v:GetPosition():Get())
		inst.sg:GoToState("taunt")
			if not inst.components.health:IsDead() then
			inst.components.health:DoDelta(5)
			end
		end
	end
	end
end 
end
end


local function Peace(inst)

local owner = inst.components.follower.leader

if owner ~= nil and owner:HasTag("beefalo") and not inst:HasTag("beefalo") then 
inst:AddTag("beefalo")
elseif owner ~= nil and not owner:HasTag("beefalo") and inst:HasTag("beefalo") then 
inst:RemoveTag("beefalo")
end

if owner ~= nil and owner.no_growup and not inst.no_growup then
 inst.no_growup = true
end

--command
if inst.yamche then
inst.sg:GoToState("command")

	if inst.components.burnable:IsBurning() then
    inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_OFF)
	inst.campfire = false
	end
if inst.yamche and inst.active_hunt and not inst.peace and not inst.defense and not inst.sleepn then
SpawnPrefab("dr_hot_loop").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.yamche and not inst.active_hunt and inst.peace and inst.defense and not inst.sleepn then
SpawnPrefab("dr_warm_loop_2").Transform:SetPosition(inst:GetPosition():Get())
elseif inst.yamche and not inst.active_hunt and not inst.peace and not inst.defense and not inst.sleepn then
SpawnPrefab("dr_warmer_loop").Transform:SetPosition(inst:GetPosition():Get())
end

inst.yamche = false
if inst.components.sleeper:IsAsleep() then
inst.components.sleeper:WakeUp()
	inst.sleep_on = false
	inst.fightn = false
	inst.campfire = false
if inst.onsleep then
local random2 = 0.2
if math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_1)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_2)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_3)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_4)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_5)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_6)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_7)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_8)
elseif math.random() < random2 then
inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_9)
end
inst.onsleep = false
end end
end
---

if owner == nil then

--if inst.components.hunger.current == 0 then
--inst.components.hunger:DoDelta(5)
--end 
if inst.sleepn then
	 	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_SLEEPY.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(0)")
		inst.sleepn = false		end
inst.fightn = true
--inst.components.hunger:SetRate(0)
if inst.components.sleeper:IsAsleep() and not inst.level1 then
inst.onsleep = true 
end
end 

if owner ~= nil and inst.follow and not inst.active_hunt then
inst.components.combat:GiveUp()
end


if inst.resurrect_yamche and not inst.dead_yamche then
inst.peace = false
inst.dead_yamche = true
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0)
inst.components.health:DoDelta(-5000)
end
--armor
if owner ~= nil and not inst.resurrect_yamche then

if owner.berserk and not inst.crazy_dist then
inst.crazy_dist = true
elseif not owner.berserk and inst.crazy_dist then
inst.crazy_dist = false
end

if owner.berserk and not inst.peace then
inst.peace = true
inst.active_hunt = false
inst.defense = true
end
if inst.peace then
inst.components.combat:SetTarget(nil)
inst.components.combat:GiveUp()
end

if owner.berserk then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 1)
elseif owner ~= nil and not owner.berserk then

	if inst.shield_on or inst.forcefields then
	inst.components.health.externalabsorbmodifiers:SetModifier(inst, 1)
	elseif not inst.shield_on and not inst.forcefields then
--if owner.f_attack then 
--inst.components.health.externalabsorbmodifiers:SetModifier(inst, 1)
	end
if inst.peace then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0.9)
elseif not inst.peace and not inst.fightn and not inst.active_hunt then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0.5)
elseif not inst.peace and not inst.fightn and inst.active_hunt then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0.4)
elseif inst.fightn then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0.9)
 inst.components.combat:GiveUp()
 GetReturnPos(inst)
 inst.pick1 = false
 inst.working_food = false
 inst.drop = true
end
end
elseif owner == nil and not inst.resurrect_yamche then
inst.components.health.externalabsorbmodifiers:SetModifier(inst, 0.5)
end

end

local ValidItems = {
 "goldnugget", "rocks", "cutstone", "nitre", "flint", "marble", "redgem", "purplegem", "bluegem", "yellowgem", "greengem", "orangegem",    "log", "boards", "cutgrass", "dug_grass", "rope", "twigs", "dug_sapling", "gears", "spidergland", "healingsalve", "mosquitosack", "silk", "spidereggsack", "ash", "poop", "guano", "charcoal", "beefalowool", "cutreeds", "houndstooth", "ice", "stinger", "livinglog", "lightbulb", "slurper_pelt", "honeycomb", "arrowm",
 "turf_road", "turf_rocky", "turf_forest", "turf_marsh", "turf_grass", "turf_savanna", "turf_dirt", "turf_woodfloor", "turf_carpetfloor", "turf_checkerfloor", "turf_cave", "turf_fungus", "turf_fungus_red", "turf_fungus_green", "turf_sinkhole", "turf_underrock", "turf_mud", 
  "walrus_tusk", "houndstooth", "wormlight_lesser", "wormlight", "nightmarefuel", "manrabbit_tail", "beardhair", "trinket_1", "trinket_2", "trinket_3", "trinket_4", "trinket_5", "trinket_6", "trinket_7",  "trinket_8", "trinket_9", "trinket_10", "trinket_11", "trinket_12",  "coontail", "tentaclespots", "beefalowool", "horn", "feather_robin", "feather_robin_winter", "feather_crow", "boneshard", "transistor",   "boomerang", "goose_feather", "drumstick", 
  "bearger_fur", "dragon_scales", 
  "acorn", "pinecone",
 --sw 
"coconut", "coral", "bamboo", "dug_bambootree", "vine", "dug_bush_vine", "limestone", "hail_ice", "obsidian", "palmleaf", "snake_poison", "snake_skin", "messagebottle", "messagebottleempty", "fabric", 
}
	
local function ItemIsInList(item, list)
    for k,v in pairs(list) do
        if v == item or k == item then
            return true
        end
    end
end

local function Take_order(inst)

if inst.components.follower and inst.components.follower.leader then
if inst.components.follower:IsNearLeader(3) then
	if not inst.focus_leader then
	inst.focus_leader = true
	end
else
	if inst.focus_leader then
	inst.focus_leader = false
	end
end
end

if inst.components.container ~=nil and not inst.sg:HasStateTag("open") then 

if inst.components.container:IsFull() then 
	if not inst.item_max_full then 
		inst.item_max_full = true
		--inst.item_ready_drop = true
		if inst.pick1 then
			if not inst.item_1 then 
			inst.sg:GoToState("command")
			inst.item_1 = true
			end
		if not inst.light_on then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV_FULL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
		elseif inst.light_on then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV_FULL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x5)")
		end
			inst.pick1 = false
			inst.droping = false
			inst.working_food = false
			inst.drop = true
		end
	end

else 
	if inst.item_max_full then 
		inst.item_max_full = false
		--inst.item_ready_drop = false
	end
end
end

--[[if inst.pick1 then
inst.droping = false	

end
if not inst.house and inst.drop then

	if inst.components.inventory then
	inst.components.inventory:DropEverything(true)
	end
inst.item_max_full = false
inst.item_1 = false 

if not inst.droping then
inst.sg:GoToState("command")
inst.droping = true
end	
end ]]
end


	
local function GetPeepChance(inst)
    local peep_percent = 0
   if inst.components.hunger:IsStarving() then
            peep_percent = 0.5
	inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_FOOOOD)
	elseif inst.components.hunger:GetPercent() <= .1 then
            peep_percent = 0.5
	inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_FOOOD)
    elseif inst.components.hunger:GetPercent() < .5 then
	inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_FOO)
		 peep_percent = 0.25
       end
    return peep_percent
end

local function GetCryChance(inst, data)
local cry_percent = 0
local leader = inst.components.follower.leader
if inst.components.follower:IsNearLeader(CRY_NEAR_LEADER_DISTANCE) then
        if inst.components.health:GetPercent() < .15 and inst.components.hunger:GetPercent() >= .5 then
            cry_percent = 0.25
	inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
	        inst.components.health:DoDelta(100)
			inst.components.hunger:DoDelta(-5)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.25, .25, .25)
    heal_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil then
		inst.AnimState:SetBloomEffectHandle( "" )
		end end)
	
	end
if leader.components.health:GetPercent() <= 0.7 and inst.components.hunger:GetPercent() >= .9 then
            cry_percent = 0.05
	    leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.3, .3, .3)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" )	end end)
		if not inst.doctor then
		inst.components.hunger:DoDelta(-5)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER)
		elseif inst.doctor then
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
		end
elseif leader.components.health:GetPercent() <= 0.6 and inst.components.hunger:GetPercent() >= .7 then
            cry_percent = 0.1
        leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.3, .3, .3)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" )	end end)
				if not inst.doctor then
		inst.components.hunger:DoDelta(-5)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER)
		elseif inst.doctor then
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
		end
elseif leader.components.health:GetPercent() <= 0.5 and inst.components.hunger.current >= 30 then
            cry_percent = 0.4
        leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.3, .3, .3)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" ) end end)
				if not inst.doctor then
		inst.components.hunger:DoDelta(-5)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER)
		elseif inst.doctor then
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
		end
elseif leader.components.health:GetPercent() <= 0.2 and inst.components.hunger.current >= 20 then
            cry_percent = 0.6
        leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.4, .4, .4)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" ) end end)	
				if not inst.doctor then
		inst.components.hunger:DoDelta(-5)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER)
		elseif inst.doctor then
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
		end
elseif leader.components.health:GetPercent() <= 0.1 and inst.components.hunger:GetPercent() >= 10 then
            cry_percent = 1
        leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.3, .3, .3)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())	
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" ) end end)
				if not inst.doctor then
		inst.components.hunger:DoDelta(-5)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER)
		elseif inst.doctor then
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
		end
elseif leader.components.health:GetPercent() <= 0.4 and inst.doctor then
            cry_percent = 0.5
        leader.components.health:DoDelta(15)
        leader.components.sanity:DoDelta(2)
        inst.components.health:DoDelta(20)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		local heal_fx = SpawnPrefab("spider_heal_fx")
	heal_fx.Transform:SetScale(.3, .3, .3)
    heal_fx.Transform:SetPosition(leader.Transform:GetWorldPosition())	
SpawnPrefab("green_leaves").Transform:SetPosition(inst.Transform:GetWorldPosition())
		leader.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
		inst:DoTaskInTime(1.8, function() if inst.wormlight == nil and not inst.switch then
		leader.AnimState:SetBloomEffectHandle( "" ) end end)
		inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_HEAL)
				
    end end
    return cry_percent
	end 

	
local function OnHaunt(inst, haunter)
    
	if haunter:HasTag("musha") and inst.level1 then
	haunter.components.talker:Say(STRINGS.MUSHA_TALK_YAMCHE_REVIVE_D)
	inst.sg:GoToState("command")
	elseif haunter:HasTag("musha") and not inst.level1 then
	inst.components.hauntable:SetOnHauntFn()
	inst.sg:GoToState("command")
	inst.components.talker:Say(STRINGS.MUSHA_YAMCHE_GREETING_7)
	inst:DoTaskInTime(1.8, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_WILSON_BYE_2) end)
	inst.components.locomotor.walkspeed = 0
	if inst.components.container and not inst.level1 then
	inst.components.container:DropEverything() end
	inst:DoTaskInTime(2.8, function() inst.resurrect_yamche = true end)
	return true
end end

local function onspawnfn(inst, spawn)
	if not inst.campfire and not inst.sleep_on then
    inst.sg:GoToState("command")
	end
   -- inst.SoundEmitter:PlaySound("dontstarve/cave/mushtree_tall_spore_fart")
	SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("musha_spore").Transform:SetPosition(inst:GetPosition():Get())	
end

local function Resurrection_yamche(inst, guy)
    TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
    inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_break")
   
end

local function SetTeen(inst)
    --print("smallbird - SetTeen")
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
    inst.sg:GoToState("growup") -- calls back to SpawnTeen
end

local function SpawnTeen(inst)
    --print("smallbird - SpawnTeen")
local random = 0.2
local last = 1.0

    if math.random() < random then
    local musha_0 = SpawnPrefab("musha_teen")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_teenice")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_teenr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_teenr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_teenr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_teenr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_teenice")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_teenr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_teenr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_teenr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_0 = SpawnPrefab("musha_teen")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)

 
    else
    local musha_0 = SpawnPrefab("musha_teen")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)

    end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()
	
    end

local function SetAdult(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult(inst)
    --print("smallbird - SpawnAdult")
local random = 0.2
local last = 1.0

    if math.random() < random then
 local musha_0 = SpawnPrefab("musha_tall")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrice")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrice")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
 local musha_0 = SpawnPrefab("musha_tall")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrice")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
 local musha_0 = SpawnPrefab("musha_tall")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)

    elseif math.random() <= last then
 local musha_0 = SpawnPrefab("musha_tall")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
end

if inst.components.container then
inst.components.container:DropEverything() 
end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end

local function SetAdult2(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult2(inst)

local random = 0.2
local last = 1.0

    if math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall2")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrice")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrice")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall2")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrice")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() <= last then
    local musha_0 = SpawnPrefab("musha_tall2")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
end

if inst.components.container then
inst.components.container:DropEverything() 
end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end
local function SetAdult3(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult3(inst)

local random = 0.2
local last = 1.0

    if math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall3")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrrice")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrrice")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() <= last then
    local musha_0 = SpawnPrefab("musha_tall3")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
end

if inst.components.container then
inst.components.container:DropEverything() 
end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end
local function SetAdult4(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
    inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult4(inst)
local random = 0.2
local last = 1.0

    if math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall4")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_7 = SpawnPrefab("musha_tallrrrrice")
    musha_7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_7.sg:GoToState("walk")
musha_7.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrrrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrrrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrrrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrrrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrrrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrrr6")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_7 = SpawnPrefab("musha_tallrrrrice")
    musha_7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_7.sg:GoToState("walk")
musha_7.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall4")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrrrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrrrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrrrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrrrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrrrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrrr6")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_7 = SpawnPrefab("musha_tallrrrrice")
    musha_7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_7.sg:GoToState("walk")
musha_7.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() <= last then
    local musha_0 = SpawnPrefab("musha_tall4")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
end

	if inst.components.container then
	inst.components.container:DropEverything() 
end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end
local function SetAdult5(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
   inst.sg:GoToState("growup") -- calls back to SpawnAdult
end


local function SpawnAdult5(inst)
local random = 0.2
local last = 1.0
    if math.random() < random then
    local musha_0 = SpawnPrefab("musha_tall5")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_7 = SpawnPrefab("musha_tallrrrrrice")
    musha_7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_7.sg:GoToState("walk")
musha_7.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_1 = SpawnPrefab("musha_tallrrrrr1")
    musha_1.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_1.sg:GoToState("walk")
musha_1.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_2 = SpawnPrefab("musha_tallrrrrr2")
    musha_2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_2.sg:GoToState("walk")
musha_2.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_3 = SpawnPrefab("musha_tallrrrrr3")
    musha_3.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_3.sg:GoToState("walk")
musha_3.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_4 = SpawnPrefab("musha_tallrrrrr4")
    musha_4.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_4.sg:GoToState("walk")
musha_4.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_5 = SpawnPrefab("musha_tallrrrrr5")
    musha_5.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_5.sg:GoToState("walk")
musha_5.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_6 = SpawnPrefab("musha_tallrrrrr6")
    musha_6.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_6.sg:GoToState("walk")
musha_6.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() < random then
    local musha_7 = SpawnPrefab("musha_tallrrrrrice")
    musha_7.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_7.sg:GoToState("walk")
musha_7.components.follower:SetLeader(inst.components.follower.leader)
    elseif math.random() <= last then
    local musha_0 = SpawnPrefab("musha_tall5")
    musha_0.Transform:SetPosition(inst.Transform:GetWorldPosition())
    musha_0.sg:GoToState("walk")
musha_0.components.follower:SetLeader(inst.components.follower.leader)
end

	if inst.components.container then
	inst.components.container:DropEverything() 
end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end

local function SetAdult6(inst)
    --print("smallbird - SetAdult")
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	if inst.pick1 then	
	inst.pick1 = false
	inst.drop = true
	inst.working_food = false
	end
   inst.sg:GoToState("growup") -- calls back to SpawnAdult
end

local function SpawnAdult6(inst)
	local dark1 = SpawnPrefab("statue_transition")
	local dark2 = SpawnPrefab("statue_transition_2")
	local pos = Vector3(inst.Transform:GetWorldPosition())

    local musha_tall6= SpawnPrefab("musha_egg8")
    musha_tall6.Transform:SetPosition(inst.Transform:GetWorldPosition())
dark1.Transform:SetPosition(pos:Get())
dark2.Transform:SetPosition(pos:Get())
 
	if inst.components.container then
	inst.components.container:Close()
	inst.components.container.canbeopened = false
	inst.components.container:DropEverything()
	end
if not inst.light_on then inst.AnimState:SetBloomEffectHandle( "" ) end
inst.components.health:SetInvincible(false)
            ndie(inst)
    inst:Remove()

    end

--time
--(lv2)
local function GetTeenGrowTime(inst)
	return 1
end
--(lv3)
local function GetTallGrowTime(inst)
	return 1
	--return 1400
end
--(lv4)
local function GetTall2GrowTime(inst)
	return 1
	--return 2200
end
--(lv5)
local function GetTall3GrowTime(inst)
	return 1
	--return 3000
end
--(lv6)
local function GetTall4GrowTime(inst)
	return 1
	--return 3800
end
--(lv7)
local function GetTall5GrowTime(inst)
	return 1
	--return 4600
end
--(RP)
local function GetTall6GrowTime(inst)
	return 1
	--return 4600
end

--[[
local function GetTallGrowTime(inst)
	return TUNING.TEENBIRD_GROW_TIME
end
]]--

local function Finish_arong_Transformation(inst)
    local items = inst.components.container:RemoveAllItems()

local arong_doggy = ReplacePrefab(inst, "arong_big_dog")
    for i,v in ipairs(items) do
        arong_doggy.components.container:GiveItem(v)
    end
arong_doggy.components.follower:SetLeader(inst.components.follower.leader)


if inst.level ~= nil then 
	arong_doggy.level = inst.level end
if inst.level1 ~= nil then 	
	arong_doggy.level1 = inst.level1 end
if inst.level2 ~= nil then 
	arong_doggy.level2 = inst.level2 end
if inst.level3 ~= nil then 
	arong_doggy.level3 = inst.level3 end
if inst.level4 ~= nil then 
	arong_doggy.level4 = inst.level4 end
if inst.level5 ~= nil then 
	arong_doggy.level5 = inst.level5 end
if inst.level6 ~= nil then 
	arong_doggy.level6 = inst.level6 end
if inst.level7 ~= nil then 
	arong_doggy.level7 = inst.level6 end
if inst.level8 ~= nil then 
	arong_doggy.level8 = inst.level6 end
	
end

local function onuse_yamche(inst)
	local owner = inst.components.follower.leader
	if owner ~= nil then
		inst:PushEvent("transform")
end
end
local function offuse_yamche(inst)
  
end


local function Activateicon(inst)
local minimap = TheWorld.minimap.MiniMap
    inst.activatetask = nil
	minimap:DrawForgottenFogOfWar(true)
	if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
	end
	inst.components.maprevealer.revealperiod = 0.5
	inst.components.maprevealer:Start()

end

local function create_base(inst)

    inst:AddTag("yamche")
    inst:AddTag("yamcheb")
    --inst:AddTag("companion")
    --inst:AddTag("character")
    inst:AddTag("scarytoprey")
	--inst:AddTag("noauradamage")
	--inst:AddTag("notraptrigger")
	--inst:AddTag("flying")
	--inst:AddTag("trader")
	--inst:AddTag("resurrector")
	inst:AddTag("lowcool")
 	--inst:AddTag("musha_slave")
	inst:AddTag("notarget")
	inst:AddTag("NOBLOCK")
	inst:AddTag("crazy")
		
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_small.tex" )
	inst.MiniMapEntity:SetEnabled(true)
	--inst.MiniMapEntity:SetPriority(10)
	--inst.MiniMapEntity:SetDrawOverFogOfWar(false)
   
	--inst.MiniMapEntity:SetIcon( "musha_teen.tex" )

	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	
	--MakeCharacterPhysics(inst, 5, .5)
	
				--[[inst.Physics:ClearCollisionMask()
                inst.Physics:CollidesWith(COLLISION.GROUND)
                inst.Physics:CollidesWith(COLLISION.OBSTACLES)
                inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                inst.Physics:CollidesWith(COLLISION.CHARACTERS)
                inst.Physics:Teleport(inst.Transform:GetWorldPosition())]]
	
			inst.entity:AddPhysics()
            inst.Physics:SetMass(1)
            inst.Physics:SetFriction(0)
            inst.Physics:SetDamping(5)
            inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
            inst.Physics:ClearCollisionMask()
            inst.Physics:CollidesWith((TheWorld.has_ocean and COLLISION.GROUND) or COLLISION.WORLD)
            --inst.Physics:CollidesWith(COLLISION.FLYERS)
            inst.Physics:CollidesWith(COLLISION.CHARACTERS)
            inst.Physics:SetCapsule(.5, 1)
			inst:AddTag("ignorewalkableplatformdrowning")
			MakeInventoryFloatable(inst)		
				
    inst.Transform:SetFourFaced()
		
    inst.entity:AddLight()
	inst.entity:AddDynamicShadow()
	inst.Light:SetRadius(0.5)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(180/255,180/255,180/255)
	inst.DynamicShadow:SetSize(.8, .5)
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 22
    inst.components.talker.colour = Vector3(1, 0.85, 0.75, 1)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI } )
	inst.components.eater.strongstomach = true

    inst.components.eater:SetOnEatFn(OnEat)

  
	
  
end

local function create_chester(inst)
	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chester")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
   return inst
end

local function onpreload(inst, data)
	if data ~= nil then
		if data.level then
		inst.level = data.level
			levelexp(inst)
		end
		
		if data.picked then
		inst.picked = data.picked
		end
		
		--[[if data.iceyamche then
		inst.iceyamche = data.iceyamche
		end
		if data.doctor then
		inst.doctor = data.doctor
		end]]
	end
end

local function onsave(inst, data)
	data.level = inst.level
	data.picked = inst.picked
	--data.iceyamche = inst.iceyamche
	--data.doctor = inst.doctor

end

local function FollowPlayer(inst)
local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 10, {"musha"})
	for k,v in pairs(ents) do
	if v.components.leader:CountFollowers("yamcheb") == 0 then
		inst.components.follower:SetLeader(v)
		v.components.leader:AddFollower(inst)
		inst.sleepn = false 
		inst.fightn = false
		inst.slave = true
		v.follow = true
	end
	end	

end

local function create_common(inst)
    --print("smallbird - create_common")
	--inst = inst or CreateEntity()

	inst:SetBrain(brain)	

    inst.userfunctions = 
    {
        FollowPlayer = FollowPlayer,
        GetPeepChance = GetPeepChance,
        GetCryChance = GetCryChance,
        SpawnTeen = SpawnTeen,
        SpawnAdult = SpawnAdult,
        SpawnAdult2 = SpawnAdult2,
        SpawnAdult3 = SpawnAdult3,
        SpawnAdult4 = SpawnAdult4,
        SpawnAdult5 = SpawnAdult5,
        SpawnAdult6 = SpawnAdult6,

	updatestats = updatestats
    }

    --inst:AddComponent("uniqueid")
		inst:AddComponent("characterspecific_musha")	
	inst.components.characterspecific_musha:SetOwner("musha")
	inst.components.characterspecific_musha:SetStorable(false)
	
    inst:AddComponent("named")
    inst.components.named.possiblenames = STRINGS.PHOENIXS
    inst.components.named:PickNewName()

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = PhoenixSanityAura

--------------------
        inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(9, 9)
    inst.components.playerprox:SetOnPlayerNear(on_close)
    inst.components.playerprox:SetOnPlayerFar(on_far)

    ------------------------------------------
    inst:AddComponent("health")
	inst.components.health.fire_damage_scale = 0
	inst.components.health.canmurder = false
--inst.components.health:SetAbsorptionAmount(0.5)
--inst.components.health:SetAbsorptionAmountFromPlayer(1)

    inst:AddComponent("hunger")

--inst.components.hunger:SetRate(15/TUNING.TEENBIRD_STARVE_TIME)

    inst:AddComponent("combat")
    inst.forcefields = true
    inst.components.combat.playerdamagepercent = 0
	inst:ListenForEvent("attacked", OnAttacked)
        inst.procfn = function() tryproc(inst) end
        inst:ListenForEvent("attacked", inst.procfn)

	--inst:ListenForEvent("hungerdelta", Checklevel)
	inst:ListenForEvent("healthdelta", resist)
	--inst:ListenForEvent("hungerdelta", ystarve)
	inst.ystarve = inst:DoPeriodicTask(1, ystarve)  
	inst.on_wakeup = inst:DoPeriodicTask(2, on_wakeup)  	
	--inst:ListenForEvent("hungerdelta", on_wakeup)

	inst:AddComponent("maprevealer")
	inst.components.maprevealer.revealperiod = 0.3
	inst.components.maprevealer:Start()
	
	--[[inst.activatetask = inst:DoTaskInTime(0.25, function() 
	local leader = inst.components.follower.leader
	local minimap = TheWorld.minimap.MiniMap
	if not leader then 
		if not inst.components.maprevealer then
		inst:AddComponent("maprevealer")
		minimap:DrawForgottenFogOfWar(true)
		inst.MiniMapEntity:SetIcon( "musha_teen.tex" )
		inst.components.maprevealer.revealperiod = 0.25
		inst.components.maprevealer:Start()
		end
	elseif leader then
		minimap:DrawForgottenFogOfWar(false)
		if inst.components.maprevealer then
		inst:RemoveComponent("maprevealer")
		end
	end
	end)]]
	
	
    inst:ListenForEvent("onhitother", OnHitfire)
    inst:ListenForEvent("onhitother", OnHitfreeze)
    inst:ListenForEvent("onhitother", OnHitvampire)
    inst:ListenForEvent("onhitother", OnRanger)
	inst:ListenForEvent("onhitother", hit_Ranger)
	inst:ListenForEvent("healthdelta", continue_Ranger)
	inst:ListenForEvent("hungerdelta", Power_check)
	inst:ListenForEvent("onhitother", OnPower)
	inst:ListenForEvent("death", ondeath)
	
	inst.growup_check = inst:DoPeriodicTask(5, growup_check) 
	
    inst.Take_order = inst:DoPeriodicTask(1, Take_order)   
	
	inst.Splash_Ripple = inst:DoPeriodicTask(0.8, Splash_Ripple)
	
	inst.Peaceful = inst:DoPeriodicTask(0, Peace)   
	inst.on_follow = inst:DoPeriodicTask(0, on_follow)  
	inst.hunt = inst:DoPeriodicTask(8, hunting)
	inst.icebox = inst:DoPeriodicTask(5, function()
	if inst.iceyamche and inst.components.container ~= nil then
	local inv = inst.components.container 
    for i = 1, inv:GetNumSlots() do
        local item = inv:GetItemInSlot(i)
		if item and item.components.perishable then 
		item.components.perishable:StopPerishing()
		end
	end	
	end
	end)
	
    inst.components.combat:SetRetargetFunction(1, yamche_hunt)
    inst.components.combat:SetKeepTargetFunction(Onhunt)

    inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
	inst:AddComponent("leader")
	inst.taunting = inst:DoPeriodicTask(8,taunting)
--------------------------------------------------------------------------
	--[[inst:AddComponent("machine")
    inst.components.machine.turnonfn = onuse_yamche
    inst.components.machine.turnofffn = offuse_yamche
    inst.components.machine.cooldowntime = 1]]
--------------------------------------------------------------------------

inst:AddComponent("inventoryitem") 
inst:AddComponent("equippable")


if inst.components.inventoryitem ~= nil and inst.components.equippable then 
	--if not inst.level1 then
	inst.components.inventoryitem.cangoincontainer = false
	--end
	inst.components.inventoryitem:SetOnDroppedFn(Dropped_Yamche)
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory_Yamche)
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onyamche_house)
    inst.components.equippable:SetOnUnequip(offyamche_house)
	
	if inst.level1 then
	inst.components.equippable.walkspeedmult = 1.25
    inst.components.equippable.runspeedmult = 1.25
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small.xml"
		if not inst.components.insulator then
		inst:AddComponent("insulator")
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
		end
	
	elseif inst.level2 then
	inst.components.inventoryitem:ChangeImageName("musha_teen")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_teen.xml"
	elseif inst.level3 then
	inst.components.inventoryitem:ChangeImageName("musha_tall")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall.xml"	
	elseif inst.level4 then
	inst.components.inventoryitem:ChangeImageName("musha_tall2")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall2.xml"	
	elseif inst.level5 then
	inst.components.inventoryitem:ChangeImageName("musha_tall3")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall3.xml"	
	elseif inst.level6 then
	inst.components.inventoryitem:ChangeImageName("musha_tall4")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall4.xml"	
	elseif inst.level7 then
	inst.components.inventoryitem:ChangeImageName("musha_tall5")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_tall5.xml"	
	elseif inst.level8 then
	inst.components.inventoryitem:ChangeImageName("musha_rp3")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_rp3.xml"	
		
	elseif inst.super_baby then
	inst.components.equippable.walkspeedmult = 1.25
    inst.components.equippable.runspeedmult = 1.25
	inst.components.inventoryitem:ChangeImageName("musha_small_super")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_small_super.xml"
		if not inst.components.insulator then
		inst:AddComponent("insulator")
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
		end
	end
	
	inst:DoPeriodicTask(0, Yamche_Hat )	
  
end


--------------------------------------------------------------------------	
	
    inst:AddComponent("inspectable") 
    inst.components.inspectable.getstatus = GetStatus
	--inst:AddComponent("thief")
----------resurrect
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)
    inst:ListenForEvent("activateresurrection", Resurrection_yamche)	
------------	
    MakeSmallFreezableCharacter(inst, "head")
	
    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 8
	inst.components.locomotor:EnableGroundSpeedMultiplier(true)
        inst.components.locomotor:SetTriggersCreep(false)
        inst.components.locomotor.softstop = true
		--inst.components.locomotor:SetAllowPlatformHopping(true)
		
	inst:AddComponent("drownable")
	inst.components.drownable.enabled = false


    inst:AddComponent("lootdropper")

      inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(20)
    inst.components.sleeper.testperiod = GetRandomWithVariance(8, 4)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
  --  inst:AddComponent("freezable")
    inst.components.freezable:SetResistance(8)

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("glowdust")
	inst.components.periodicspawner:SetOnSpawnFn(onspawnfn)
	inst.components.periodicspawner:SetRandomTimes(450, 900)

    inst.components.periodicspawner:Start()
 
----------------------------------------------------
inst:AddComponent("burnable")
--MakeSmallBurnableCharacter(inst, "head")
	--inst.components.burnable:SetBurnTime(1)
	yamche_campfire(inst)
--[[if not inst.iceyamche then 
   inst.components.burnable:AddBurnFX("campfirefire", Vector3(0,.9,0) )  

 	inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
	inst.components.fueled.bonusmult = 2
    inst.components.fueled:SetSections(6)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
   inst.components.fueled:SetUpdateFn( function()
       local fueled = inst.components.fueled

    fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1

    if inst.components.burnable ~= nil then
        inst.components.burnable:SetFXLevel(fueled:GetCurrentSection(), fueled:GetSectionPercent())
    end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
				inst.campfire = false
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
    
else
    inst.components.burnable:AddBurnFX("coldfirefire", Vector3(0,0.5,0) )
   -------------------------
  	inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true
	inst.components.fueled.bonusmult = 2
    inst.components.fueled:SetSections(6)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") end
   inst.components.fueled:SetUpdateFn( function()
        local fueled = inst.components.fueled

    fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1

    if inst.components.burnable ~= nil then
        inst.components.burnable:SetFXLevel(fueled:GetCurrentSection(), fueled:GetSectionPercent())
    end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
				inst.campfire = false
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
   
end]]


	--[[if not inst.campfire and inst.components.burnable:IsBurning() then
    inst.campfire = true
	inst.sg:GoToState("sleep")
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_ON.."")
	end]]


	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 3, {"musha"})
	for k,v in pairs(ents) do
	if v.components.leader:CountFollowers("yamcheb") == 0 then
		inst.components.follower:SetLeader(v)
		inst.sleepn = false 
		inst.fightn = false
		inst.slave = true
		v.follow = true
		v.yamche_follow = true
	end
	end	

----------------------------------------------------	
	inst.Light:Enable(false)
	inst.light_on = false
	
inst:ListenForEvent( "healthdelta", updatestats)

	inst.level = 0
    --inst:ListenForEvent("entity_death", function(wrld, data) onkilll(inst, data) end, GetWorld())
	inst:ListenForEvent("killed", onkilll)
	inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
    return inst
end

-----------super baby yamche
local function create_smallbird_super()
 

	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()
	----inst.MiniMapEntity:SetIcon( "musha_small.tex" )

    
  
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
	create_base(inst)
	------------------------
    --inst.entity:AddLight()
	--inst.Light:SetRadius(.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(10/255,125/255,125/255)
	-----inst.Light:Enable(true)
-----------------------
	
	inst.entity:SetPristine()
  	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
		return inst
	end
	
	create_chester(inst)
	
	--inst.level1 = true
    inst.doctor = true
	inst.super_baby = true
-------------------------------------


    create_common(inst) inst:SetStateGraph("SGmusha_small")
    inst.Transform:SetScale(0.4, 0.4, 0.4)

	inst.DynamicShadow:SetSize( 0.8, .3 )
 

    inst.components.locomotor.walkspeed = 18
    
    
    inst.components.health:SetMaxHealth(300)

    inst.components.hunger:SetMax(90)
 
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)

    inst.components.lootdropper:SetLoot({"glowdust"})

   
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP", }

    --[[local growth_stages = {
        {name="small", time = GetTeenGrowTime, fn = function() end },
        {name="tall", fn = SetTeen}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()]]


    --print("smallbird - create_smallbird END")
	return inst
end

local function create_smallbird()
    --print("smallbird - create_smallbird")

	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()
	----inst.MiniMapEntity:SetIcon( "musha_small.tex" )
  
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
	
	create_base(inst)


	inst.entity:SetPristine()
  	if not TheWorld.ismastersim then
		--[[inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)]]
		return inst
	end

	--[[inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose]]
	
	inst.level1 = true
    inst.doctor = true
-------------------------------------


    create_common(inst) inst:SetStateGraph("SGmusha_small")
    inst.Transform:SetScale(0.4, 0.4, 0.4)

	inst.DynamicShadow:SetSize( 0.8, .3 )
   
   

        

    
    
    
    inst.components.health:SetMaxHealth(100)

    inst.components.hunger:SetMax(30)
 
	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(TUNING.SMALLBIRD_DAMAGE)

    inst.components.lootdropper:SetLoot({"glowdust"})

   
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP", }

    local growth_stages = {
        {name="small", time = GetTeenGrowTime, fn = function() end },
        {name="tall", fn = SetTeen}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_smallbird END")
	return inst
end

-----musha_teen
local function create_teen_smallbird()
    --print("smallbird - create_teen_smallbird")

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

     inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
	--inst.Light:Enable(true)
	inst.entity:SetPristine()
  	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
   		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
-------------

-----musha_teenr1
local function create_teenr1_smallbird()
    --print("smallbird - create_teen_smallbird")

   local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	


    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
	--inst.Light:Enable(true)
	inst.entity:SetPristine()	
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    inst.doctor = true
    -----------------------
  
    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


-----musha_teenr2
local function create_teenr2_smallbird()
    --print("smallbird - create_teen_smallbird")

  local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
	--inst.Light:Enable(true)
inst.entity:SetPristine()	
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


-----musha_teenr3
local function create_teenr3_smallbird()
    --print("smallbird - create_teen_smallbird")

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	


    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
	--inst.Light:Enable(true)
		inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 

    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


-----musha_teenr4
local function create_teenr4_smallbird()
    --print("smallbird - create_teen_smallbird")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
		--inst.Light:Enable(true)
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

-----musha_teenr5
local function create_teenice_smallbird()
    --print("smallbird - create_teen_smallbird")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	


    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

inst:AddTag("fridge")
-------------------------------------
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(.6)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(15/255,125/255,125/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche0")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche0")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   inst.baby = false
inst.level1 = false
inst.level2 = true
inst.iceyamche = true


    create_common(inst) inst:SetStateGraph("SGmusha_teen")


    inst.Transform:SetScale(0.45, 0.45, 0.45)

   

	inst.DynamicShadow:SetSize( 0.9, .4 )
   
   

    
  
    MakeMediumFreezableCharacter(inst, "head")
    
    inst.components.health:SetMaxHealth(200)
 

    
    
    inst.components.hunger:SetMax(60)
   


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(15)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTallGrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end




-----musha tall

local function create_tall_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)


			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = false
 


    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
    
    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallr1_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
-----------------------
    
inst.doctor = true
-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = false



    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
    
    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tallr2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = false



    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
    
    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tallr3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)


			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = false



    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
    
    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tallr4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")


-------------------------------------
    create_base(inst)

			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
  
-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = false



    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
    
    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end
local function create_tallrice_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddMiniMapEntity()
	

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

inst:AddTag("fridge")
-------------------------------------
    create_base(inst)


			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche1")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche1")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    

-------------------------------------

    
	
    
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = true
inst.iceyamche = true



    create_common(inst) inst:SetStateGraph("SGmusha_tall")


    inst.Transform:SetScale(0.5, 0.5, 0.5)

   

	inst.DynamicShadow:SetSize( 1.0, .5 )
  
   

        

 
    
        

    inst.components.health:SetMaxHealth(300)

    
    
    inst.components.hunger:SetMax(70)
    ----inst.components.hunger:SetRate(TUNING.TEENBIRD_HUNGER * 1.15 /TUNING.TEENBIRD_STARVE_TIME)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(20)

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall", time = GetTall2GrowTime, fn = function() end },
        {name="adult", fn = SetAdult}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

--------musha_tall2

local function create_tall2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)


 
    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 -------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


local function create_tallrr1_teen()
    --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 inst.doctor = true
-------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrr2_teen()
    --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrr3_teen()
    --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrr4_teen()
    --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 -------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


local function create_tallrrice_teen()
    --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
inst:AddTag("fridge")
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  -------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = true


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
        

    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end



local function create_tallrr5_teen()
   --print("tallbird -  create_tall2_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(100/255,25/255,25/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche2")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche2")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 -------------------------------------

    
	
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall2")


    inst.Transform:SetScale(0.55, 0.55, 0.55)

   

	inst.DynamicShadow:SetSize( 1.1, .6 )
   

    
 
    
    
    inst.components.health:SetMaxHealth(400)

    
    
    inst.components.hunger:SetMax(80)
    


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(25)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    
--inst.components.eater.foodprefs = { "MEAT", "VEGGIE", "INSECT", "SEEDS", "GENERIC", "CRISTAL", "EXP",}

    local growth_stages = {
        {name="tall2", time = GetTall3GrowTime, fn = function() end },
        {name="adult2", fn = SetAdult2}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


------musha tall3

local function create_tall3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)

	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
--	inst.entity:SetPristine()
	  
	
-----------------------
    
 
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


------musha tall3

local function create_tallrrr1_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)
	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
		--	inst.entity:SetPristine()	
			  
	
-----------------------
    
    -----------------------
 inst.doctor = true
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

------musha tall3

local function create_tallrrr2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)
	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
		--	inst.entity:SetPristine()
			  
	
	-----------------------
    
    -----------------------
 
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

------musha tall3

local function create_tallrrr3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)
	
	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
			--	inst.entity:SetPristine()
				  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

------musha tall3

local function create_tallrrr4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)
	
	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
			--	inst.entity:SetPristine()
				  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end

------musha tall3

local function create_tallrrrice_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
inst:AddTag("fridge")
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)

	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
	
			--	inst.entity:SetPristine()
				  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = true


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)
    

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


local function create_tallrrr5_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(1.7)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(120/255,120/255,20/255)
		--inst.Light:Enable(true)
	inst.entity:SetPristine()
  if not TheWorld.ismastersim then
	inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("chester") 
		end
        return inst
    end
			--	inst.entity:SetPristine()
				  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	create_chester(inst)
    
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = true
inst.iceyamche = false


    create_common(inst) inst:SetStateGraph("SGmusha_tall3")


    inst.Transform:SetScale(0.6, 0.6, 0.6)

   

	inst.DynamicShadow:SetSize( 1.15, .7 )
   

    
  
    
    
    inst.components.health:SetMaxHealth(500)

    
    
    inst.components.hunger:SetMax(90)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(30)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall3", time = GetTall4GrowTime, fn = function() end },
        {name="adult3", fn = SetAdult3}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()


    --print("smallbird - create_teen_smallbird END")
	return inst
end


-----------musha_tall4

local function create_tall4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
	
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
    -----------------------
  
--box5
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end


local function create_tallrrrr1_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  inst.doctor = true
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrrrr2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
	
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrrrr3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------

-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrrrr4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrrrr5_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end


local function create_tallrrrrice_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
inst:AddTag("fridge")
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
-----------------------
    
    -----------------------
 
-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = true

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.65, 0.65, 0.65)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)
    

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

local function create_tallrrrr6_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall5")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")

-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(2.1)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(200/255,190/255,15/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche4")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche4")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------

-------------------------------------

    
	
    
   
   
   
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = true
inst.iceyamche = false

inst.darkyamche = true 
    create_common(inst) inst:SetStateGraph("SGmusha_tall4")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

  

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
    
   
    
    
    inst.components.health:SetMaxHealth(600)

    
    
    inst.components.hunger:SetMax(100)


	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(35)



    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    inst.components.lootdropper:SetLoot({"glowdust"})


    local growth_stages = {
        {name="tall4", time = GetTall5GrowTime, fn = function() end },
        {name="adult4", fn = SetAdult4}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

    --print("smallbird - create_teen_smallbird END")
	return inst
end

--------musha_5
-------Level7 phoenix state

local function create_tall5_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall5")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = true 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr1_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  inst.doctor = true
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    


    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
  
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    
  

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr5_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
 
-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
 

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrrice_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
inst:AddTag("fridge")
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------

-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = true

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


   inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)
    

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
  

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end


local function create_tallrrrrr6_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 

-------------------------------------

    
	
    
   
   
   
   
     inst.level7 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.iceyamche = false

inst.darkyamche = false 
 

    create_common(inst) inst:SetStateGraph("SGmusha_tall5")


    inst.Transform:SetScale(0.7, 0.7, 0.7)

   

	inst.DynamicShadow:SetSize( 1.2, 0.9)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(700)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    

    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()

	return inst
end



-------Level8 phoenix state

local function create_rp1_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_small")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 
-------------------------------------------
inst.doctor = true
-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end


local function create_rp2_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_teen")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

local function create_rp3_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
	  
	
-----------------------
    
    -----------------------
 

-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

local function create_rp4_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall2")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------


-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

local function create_rp5_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall3")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 
-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

local function create_rp6_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall4")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
    
    -----------------------
 

-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = false 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


     inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

-------------

local function create_rp7_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_tall5")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
    create_base(inst)




    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
-----------------------
    
    -----------------------
 
-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = false

inst.darkyamche = true 


    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.8, 0.8, 0.8)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    
 
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

-------------

local function create_rpice_teen()
    --print("tallbird -  create_tall_teen")

        local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.AnimState:SetBank("smallbird")
    inst.AnimState:SetBuild("musha_ice")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:Hide("beakfull")




-------------------------------------
inst:AddTag("fridge")
    create_base(inst)

    --inst.entity:AddLight()
	--inst.Light:SetRadius(3)
    --inst.Light:SetFalloff(.7)
    --inst.Light:SetIntensity(.5)
    --inst.Light:SetColour(225/255,200/255,75/255)
		--inst.Light:Enable(true)
			inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		inst:DoTaskInTime(0, function()
			inst.replica.container:WidgetSetup("chest_yamche5")
		end)
		return inst
	end
--	inst.entity:SetPristine()

	inst:AddComponent("container")  
    inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
		  
	
-----------------------
-----------------------
 

-------------------------------------

    
	
    
   
   
   
   
   
     inst.level8 = true
   inst.baby = false
inst.level1 = false
inst.level2 = false
inst.level3 = false
inst.level4 = false
inst.level5 = false
inst.level6 = false
inst.level7 = false
inst.iceyamche = true

inst.darkyamche = false 

    create_common(inst) inst:SetStateGraph("SGmusha_tall6")


    inst.Transform:SetScale(0.75, 0.75, 0.75)

   

	inst.DynamicShadow:SetSize( 1.1, 0.8)
   
   
    

    
    
    
    inst.components.health:SetMaxHealth(800)
    

    
    
    inst.components.hunger:SetMax(120)

  --  inst.components.hunger:SetKillRate(TUNING.TEENBIRD_HEALTH * 1.75 /TUNING.TEENBIRD_STARVE_KILL_TIME)

	inst.components.combat.hiteffectsymbol = "head"
    inst.components.combat:SetRange(2,3)
    inst.components.combat:SetDefaultDamage(40)
    

    inst:ListenForEvent("newcombattarget", OnNewTarget)
    
    

    inst.components.lootdropper:SetLoot({"glowdust"})

    
--[[
    local growth_stages = {
        {name="tall5", time = GetTall6GrowTime, fn = function() end },
        {name="adult5", fn = SetAdult5}
    }

	inst:AddComponent("growable")
    inst.components.growable.stages = growth_stages
    inst.components.growable:SetStage(1)
    inst.components.growable:StopGrowing()
]]
	return inst
end

-------------

return Prefab( "musha_small", create_smallbird, assets),

	   Prefab( "musha_teen", create_teen_smallbird, assets),
	   Prefab( "musha_teenr1", create_teenr1_smallbird, assets),
	   Prefab( "musha_teenr2", create_teenr2_smallbird, assets),
	   Prefab( "musha_teenr3", create_teenr3_smallbird, assets),
	   Prefab( "musha_teenr4", create_teenr4_smallbird, assets),
	   Prefab( "musha_teenice", create_teenice_smallbird, assets),

	   Prefab( "musha_tall", create_tall_teen, assets) ,
	   Prefab( "musha_tallr1", create_tallr1_teen, assets) ,
	   Prefab( "musha_tallr2", create_tallr2_teen, assets) ,
	   Prefab( "musha_tallr3", create_tallr3_teen, assets) ,
	   Prefab( "musha_tallr4", create_tallr4_teen, assets) ,
	   Prefab( "musha_tallrice", create_tallrice_teen, assets) ,

 	   Prefab( "musha_tall2", create_tall2_teen, assets), 
 	   Prefab( "musha_tallrr1", create_tallrr1_teen, assets), 
 	   Prefab( "musha_tallrr2", create_tallrr2_teen, assets), 
 	   Prefab( "musha_tallrr3", create_tallrr3_teen, assets), 
 	   Prefab( "musha_tallrr4", create_tallrr4_teen, assets), 
 	   Prefab( "musha_tallrr5", create_tallrr5_teen, assets), 
 	   Prefab( "musha_tallrrice", create_tallrrice_teen, assets), 

	   Prefab( "musha_tall3", create_tall3_teen, assets), 
 	   Prefab( "musha_tallrrr1", create_tallrrr1_teen, assets), 
 	   Prefab( "musha_tallrrr2", create_tallrrr2_teen, assets), 
 	   Prefab( "musha_tallrrr3", create_tallrrr3_teen, assets), 
 	   Prefab( "musha_tallrrr4", create_tallrrr4_teen, assets), 
 	   Prefab( "musha_tallrrr5", create_tallrrr5_teen, assets), 
 	   Prefab( "musha_tallrrrice", create_tallrrrice_teen, assets), 

	   Prefab( "musha_tall4", create_tall4_teen, assets), 
 	   Prefab( "musha_tallrrrr1", create_tallrrrr1_teen, assets), 
 	   Prefab( "musha_tallrrrr2", create_tallrrrr2_teen, assets), 
 	   Prefab( "musha_tallrrrr3", create_tallrrrr3_teen, assets), 
 	   Prefab( "musha_tallrrrr4", create_tallrrrr4_teen, assets), 
 	   Prefab( "musha_tallrrrr5", create_tallrrrr5_teen, assets), 
 	   Prefab( "musha_tallrrrr6", create_tallrrrr6_teen, assets), 
 	   Prefab( "musha_tallrrrrice", create_tallrrrrice_teen, assets), 

	   Prefab( "musha_tall5", create_tall5_teen, assets), 
	   Prefab( "musha_tallrrrrr1", create_tallrrrrr1_teen, assets), 
 	   Prefab( "musha_tallrrrrr2", create_tallrrrrr2_teen, assets), 
 	   Prefab( "musha_tallrrrrr3", create_tallrrrrr3_teen, assets), 
 	   Prefab( "musha_tallrrrrr4", create_tallrrrrr4_teen, assets), 
 	   Prefab( "musha_tallrrrrr5", create_tallrrrrr5_teen, assets), 
 	   Prefab( "musha_tallrrrrr6", create_tallrrrrr6_teen, assets), 
 	   Prefab( "musha_tallrrrrrice", create_tallrrrrrice_teen, assets), 

	   Prefab( "musha_rp1", create_rp1_teen, assets), 
	   Prefab( "musha_rp2", create_rp2_teen, assets), 
	   Prefab( "musha_rp3", create_rp3_teen, assets), 
	   Prefab( "musha_rp4", create_rp4_teen, assets), 
	   Prefab( "musha_rp5", create_rp5_teen, assets), 
	   Prefab( "musha_rp6", create_rp6_teen, assets), 
	   Prefab( "musha_rp7", create_rp7_teen, assets), 
	   Prefab( "musha_rpice", create_rpice_teen, assets),
	   
	   Prefab( "musha_small_super", create_smallbird_super, assets)


