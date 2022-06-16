local assets=
{
	Asset("ANIM", "anim/swap_frostpocket.zip"),
	Asset("ANIM", "anim/swap_frostback.zip"),
	Asset("ATLAS", "images/inventoryimages/broken_frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/broken_frosthammer.tex"),
	Asset("ANIM", "anim/armor_butterfly_green_s.zip"),
Asset("ANIM", "anim/armor_butterfly_blue_s.zip"),
Asset("ANIM", "anim/armor_butterfly_blue.zip"),
Asset("ANIM", "anim/armor_butterfly_s.zip"),
Asset("ANIM", "anim/armor_butterfly.zip"),
Asset( "ANIM", "anim/armor_frostar.zip"),
}

-- compatible with SW mods
local function OnDropped(inst)
if inst.DLC2 then
	
local map = TheWorld.Map
local x, y, z = inst.Transform:GetWorldPosition()
local ground = map:GetTile(map:GetTileCoordsAtPoint(x, y, z))

if ground == GROUND.WATER_MANGROVE or ground == GROUND.WATER_CORAL or ground == GROUND.WATER_DEEP or ground == GROUND.WATER_MEDIUM or ground == GROUND.IMPASSABLE or ground == GROUND.WATER_SHALLOW or ground == GROUND.MANGROVE or
ground == GROUND.RIVER or ground == GROUND.OCEAN_CORAL or ground == GROUND.OCEAN_DEEP or ground == GROUND.OCEAN_MEDIUM or
ground == GROUND.OCEAN_SHIPGRAVEYARD or ground == GROUND.OCEAN_SHALLOW or ground == GROUND.IMPASSABLE
then
	if inst.DLC2_fly and not inst.floating then
	inst.floating = true
	MakeInventoryFloatable(inst, "idle_water", "anim")
	end
        inst.AnimState:PlayAnimation("idle_water", true)
inst.AnimState:OverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:OverrideSymbol("water_shadow", "ripple_build", "water_shadow")
else
        inst.AnimState:PlayAnimation("anim", true)
inst.AnimState:ClearOverrideSymbol("water_ripple", "ripple_build", "water_ripple")
inst.AnimState:ClearOverrideSymbol("water_shadow", "ripple_build", "water_shadow")
end
end
end

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then

end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n[MAX]")
end
end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
end
	end
		end
local function onsave(inst, data)
	data.level = inst.level
end
---------------------------------------

local function UpgradeArmor(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end


if inst.broken then
 inst.components.fueled:StopConsuming()        
    inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.." (0)\n"..STRINGS.MUSHA_ITEM_DUR.." (0)")
  
elseif not inst.broken and not inst.shield then

 if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.03)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV1)\n"..STRINGS.MUSHA_ARMOR.."(3)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.06)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV2)\n"..STRINGS.MUSHA_ARMOR.."(6)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.09)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV3)\n"..STRINGS.MUSHA_ARMOR.."(9)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.12)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV4)\n"..STRINGS.MUSHA_ARMOR.."(12)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.15)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV5)\n"..STRINGS.MUSHA_ARMOR.."(15)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.18)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV6)\n"..STRINGS.MUSHA_ARMOR.."(18)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.21)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV7)\n"..STRINGS.MUSHA_ARMOR.."(21)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.24)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV8)\n"..STRINGS.MUSHA_ARMOR.."(24)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.27)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV9)\n"..STRINGS.MUSHA_ARMOR.."(27)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(20)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.3)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV10)\n"..STRINGS.MUSHA_ARMOR.."(30)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.33)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV11)\n"..STRINGS.MUSHA_ARMOR.."(33)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.36)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV12)\n"..STRINGS.MUSHA_ARMOR.."(36)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.39)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV13)\n"..STRINGS.MUSHA_ARMOR.."(39)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.42)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV14)\n"..STRINGS.MUSHA_ARMOR.."(42)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.45)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV15)\n"..STRINGS.MUSHA_ARMOR.."(45)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.48)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV16)\n"..STRINGS.MUSHA_ARMOR.."(48)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.51)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV17)\n"..STRINGS.MUSHA_ARMOR.."(51)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.54)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV18)\n"..STRINGS.MUSHA_ARMOR.."(54)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.57)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV19)\n"..STRINGS.MUSHA_ARMOR.."(57)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(30)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.60)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV20)\n"..STRINGS.MUSHA_ARMOR.."(60)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(40)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.63)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV21)\n"..STRINGS.MUSHA_ARMOR.."(63)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(40)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.66)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV22)\n"..STRINGS.MUSHA_ARMOR.."(66)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(40)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.69)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV23)\n"..STRINGS.MUSHA_ARMOR.."(69)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(40)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.72)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV24)\n"..STRINGS.MUSHA_ARMOR.."(72)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(40)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.75)
 --inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV25)\n"..STRINGS.MUSHA_ARMOR.."(75)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.78)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV26)\n"..STRINGS.MUSHA_ARMOR.."(78)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.80)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV27)\n"..STRINGS.MUSHA_ARMOR.."(80)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.82)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV28)\n"..STRINGS.MUSHA_ARMOR.."(82)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.84)
--inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV29)\n"..STRINGS.MUSHA_ARMOR.."(84)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
elseif inst.level >=4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.85)
--inst.components.equippable.walkspeedmult = 1.1
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." (LV30)\n"..STRINGS.MUSHA_ARMOR.."(85)\n"..STRINGS.MUSHA_ITEM_FREEZE.."(50)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Small)")
end
end
end

local function OnDurability(inst, data)
inst.broken = true
 	UpgradeArmor(inst)
	inst.components.fueled:StopConsuming()        
 end
 
local function forgelab(inst, data)
inst._5 = false
inst._4 = false
inst._3 = false
inst._2 = false
inst._1 = false	
if inst.active_forge then
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 5, {"forge_musha"})
for k,v in pairs(ents) do
if v ~= nil then
v.active_forge =  true
	if v._5 then
		inst._5 = true	
	elseif v._4 then
		inst._4 = true	
	elseif v._3 then
		inst._3 = true	
	elseif v._2 then
		inst._2 = true	
	elseif v._1 then
		inst._1 = true	
	end
inst.active_forge = false

end end end 
end
-------- --------
local function TakeItem_effect(inst)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then
	local fx = SpawnPrefab("firesplash_fx")
	fx.Transform:SetScale(0.2, 0.2, 0.2)
	fx.Transform:SetPosition(owner:GetPosition():Get())
end	
end
local function TakeItem(inst, item, data)
local expchance0 = 1
local expchance1 = 0.3
local expchance2 = 0.2
local expchance3 = 0.12
	inst.components.fueled:DoDelta(5000000)
	TakeItem_effect(inst)
inst.broken = false      
UpgradeArmor(inst)
 if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4600 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4600 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4600 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_ARMOR_FROST.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(8)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4600 then
	inst.level = inst.level + 1
	levelexp(inst)
     end
elseif inst.forgelab_on then
inst.active_forge = true
forgelab(inst)
	if inst._5 and inst.level <= 4005 then
	inst.level = inst.level + 30
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(30)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif inst._4 and inst.level <= 4005 then
	inst.level = inst.level + 20
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(20)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif inst._3 and inst.level <= 4005 then
	inst.level = inst.level + 10
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(10)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif inst._2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif inst._1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif not inst._5 and not inst._4 and not inst._3 and not inst._2 and not inst._1 and inst.level <= 4005 then
		inst.level = inst.level + 1
		levelexp(inst)
		inst.components.talker:Say(STRINGS.MUSHA_TALK_FORGE_LUCKY.."\n+(1)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
		
    end
	inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end
	if inst.broken then
	inst.broken = false 
	end
end
-------- --------

local function sanity_cost(inst, owner)
    
	if not inst.components.heater and inst.shield then
	inst:AddComponent("heater")
	end
    if owner.components.sanity and inst.shield then
	 
        owner.components.sanity:DoDelta(-1,false)
		inst.components.heater:SetThermics(false, true)
		inst.components.heater.equippedheat = -2
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	end
	
end

local function Release_Frost(inst,owner)
 
local danger = FindEntity(owner, 7, function(target) 
                return (target:HasTag("monster") and not target:HasTag("player") and not owner:HasTag("spiderwhisperer"))
                    or (target:HasTag("monster") and not target:HasTag("player") and owner:HasTag("spiderwhisperer") and not target:HasTag("spider"))
                    or (target:HasTag("pig") and not target:HasTag("player") and owner:HasTag("spiderwhisperer"))
                    or (target.components.combat and target.components.combat.target == owner) end)

            local hounded = TheWorld.components.hounded
			if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
	
				danger = true
			end
			
			
		if owner then
			if danger and not owner.on_sparkshield and not owner.sg:HasStateTag("book2") and not inst.shield and not owner.valkyrie and not owner.berserk and not inst.danger_wing_s then 
			inst.danger_wing_s = true	inst.danger_wing = false
			inst.peace_wing = false
			inst.blue_wing_s = false inst.blue_wing = false
		if inst.level >=0 and inst.level <250 then
inst.components.equippable.walkspeedmult = 1.15
elseif inst.level >=250 and inst.level <250 then
inst.components.equippable.walkspeedmult = 1.2
elseif inst.level >=250 and inst.level <1400 then
inst.components.equippable.walkspeedmult = 1.25
elseif inst.level >= 1400 and inst.level <4000 then
inst.components.equippable.walkspeedmult = 1.3
elseif inst.level >= 4000 then
inst.components.equippable.walkspeedmult = 1.35
		end
				owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_s", "swap_body_tall")
			elseif danger and not owner.on_sparkshield and not owner.sg:HasStateTag("book2")  and not inst.shield and (owner.valkyrie or owner.berserk) and not inst.danger_wing then 
			inst.danger_wing_s = false	inst.danger_wing = true
			inst.peace_wing = false
			inst.blue_wing_s = false inst.blue_wing = false
		if inst.level >=0 and inst.level <250 then
inst.components.equippable.walkspeedmult = 1.2
elseif inst.level >=250 and inst.level <250 then
inst.components.equippable.walkspeedmult = 1.25
elseif inst.level >=250 and inst.level <1400 then
inst.components.equippable.walkspeedmult = 1.3
elseif inst.level >= 1400 and inst.level <4000 then
inst.components.equippable.walkspeedmult = 1.35
elseif inst.level >= 4000 then
inst.components.equippable.walkspeedmult = 1.4
		end
				owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly", "swap_body_tall")
			elseif not owner.on_sparkshield and not owner.sg:HasStateTag("book2") and not danger and not inst.shield and not inst.peace_wing then 
			inst.danger_wing_s = false	inst.danger_wing = false
			inst.peace_wing = true
			inst.blue_wing_s = false inst.blue_wing = false
			inst.components.equippable.walkspeedmult = 1.0
				owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_green_s", "swap_body_tall")
			elseif owner.sg:HasStateTag("book2") and not inst.blue_wing_s and not inst.shield then  
			inst.danger_wing_s = false	inst.danger_wing = false
			inst.peace_wing = false
			inst.blue_wing_s = true	inst.blue_wing = false
			inst.components.equippable.walkspeedmult = 1.0
				owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue", "swap_body_tall")	
			elseif not owner.sg:HasStateTag("book2") and (owner.on_sparkshield or inst.shield) and not inst.blue_wing then  
			inst.danger_wing_s = false	inst.danger_wing = false
			inst.peace_wing = false
			inst.blue_wing_s = false	inst.blue_wing = true
			inst.components.equippable.walkspeedmult = 1.0
				owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue", "swap_body_tall")		
			end
		end
end

local function OnBlocked(owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function OnOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

end 

local function OnClose(inst) 
    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")

end 

local function OnLoad(inst, data)
    UpgradeArmor(inst)
end

local function OnPutInInventory(inst)
    UpgradeArmor(inst)
    end 
---------------------------------------shield on
local function consume(inst, owner)
if not inst.broken and inst.shield then
inst.components.fueled:DoDelta(-20000)
end
if inst.broken and inst.shield then
inst.components.fueled:DoDelta(0)
end
end

local function on_shield(inst, owner)
if inst.shield and not inst.broken then
inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD.."\n"..STRINGS.MUSHA_ARMOR.."(100)\n"..STRINGS.MUSHA_ITEM_COOL)
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 1)
    inst.consume = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
	
	elseif inst.shield and inst.broken then
inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.."(0)")
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0)
      if inst.consume then inst.consume:Cancel() inst.consume = nil end
end end

local function off_shield(inst)
if inst.shield then
inst.shield = false
UpgradeArmor(inst)
if inst.consume then inst.consume:Cancel() inst.consume = nil end
end
	if inst.components.heater then
	inst:RemoveComponent("heater")
	end
end
--------------Shield hat
    local function stopusingshield(inst, data)
        local hat = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        if hat and not (data.statename == "shell_idle" or data.statename == "shell_hit" or data.statename == "shell_enter") then
		inst.shield = false
        hat.components.useableitem:StopUsingItem()
        end
		--[[if inst.components.container ~= nil then
        inst.components.container:Open(owner)
		end]]
    end	

local function onequip(inst, owner) 
if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
         owner.components.inventory:Unequip(EQUIPSLOTS.BODY, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end

inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

	UpgradeArmor(inst)
	inst.components.fueled:StartConsuming() 
	
	inst:ListenForEvent("blocked", OnBlocked, owner)
	
    owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_green_s", "swap_body_tall")
	owner.AnimState:OverrideSymbol("swap_body", "armor_frostar", "backpack")
	owner.AnimState:OverrideSymbol("swap_body", "armor_frostar", "swap_body")
	if inst.level <750 then
	 	inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
	elseif inst.level >=750 then	
	 	inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
	end 
	  if inst.components.container ~= nil then
        inst.components.container:Open(owner)
	  end
	
inst.task1 = inst:DoPeriodicTask(0.2, function() Release_Frost(inst, owner) end)

inst.task2 = inst:DoPeriodicTask(3, function() sanity_cost(inst, owner) end)

    inst.expfn = function(attacked, data)
local expchance = 0.5
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1

if data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 10 then
inst.components.fueled:DoDelta(-50000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 10 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 20 then
inst.components.fueled:DoDelta(-80000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 20 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 30 then
inst.components.fueled:DoDelta(-110000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 30 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 40 then
inst.components.fueled:DoDelta(-140000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 40 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 50 then
inst.components.fueled:DoDelta(-170000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 50 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 60 then
inst.components.fueled:DoDelta(-300000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 60 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 70 then
inst.components.fueled:DoDelta(-330000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 70 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 60 then
inst.components.fueled:DoDelta(-360000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 70 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 80 then
inst.components.fueled:DoDelta(-390000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 80 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 90 then
inst.components.fueled:DoDelta(-450000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 90 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 100 then
inst.components.fueled:DoDelta(-600000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 100 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 100 then
inst.components.fueled:DoDelta(-850000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 100 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 150 then
inst.components.fueled:DoDelta(-1000000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 150 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 200 then
inst.components.fueled:DoDelta(-1400000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 200 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 250 then
inst.components.fueled:DoDelta(-1800000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 250 and data.attacker.components.combat and data.attacker.components.combat.defaultdamage <= 300 then
inst.components.fueled:DoDelta(-2600000)
elseif data and data.attacker and data.attacker.components.combat and data.attacker.components.combat.defaultdamage > 300 then
inst.components.fueled:DoDelta(-3000000)
end

if data and data.attacker and math.random() < damagedur1 then
inst.components.fueled:DoDelta(-50000)
elseif data and data.attacker and math.random() < damagedur2 then
inst.components.fueled:DoDelta(-30000)
elseif data and data.attacker and math.random() < damagedur3 then
inst.components.fueled:DoDelta(-10000)
end

if data and data.attacker and math.random() < expchance and inst.level < 4010 then
	inst.level = inst.level + 1
			levelexp(inst)

		end 
	    end

    inst.freezefn = function(attacked, data)
	local attacker = data.attacker
	local freezechance1 = 0.2
	local freezechance2 = 0.3
	local freezechance3 = 0.4
	local freezechance4 = 0.5
	local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
	       if data and math.random() < freezechance1 and attacker and attacker.components.freezable and inst.level <250 and attacker.components.combat then 
            attacker.components.freezable:AddColdness(0.2)
            attacker.components.freezable:SpawnShatterFX()
			fx.Transform:SetScale(1, 0.5, 1)
			fx.Transform:SetPosition(attacker:GetPosition():Get())
        elseif data and math.random() < freezechance2 and attacker and attacker.components.freezable and inst.level >=250 and inst.level <1400 and attacker.components.combat then
            attacker.components.freezable:AddColdness(0.3)
            attacker.components.freezable:SpawnShatterFX()
			fx.Transform:SetScale(1, 0.7, 1)
			fx.Transform:SetPosition(attacker:GetPosition():Get())
        elseif data and math.random() < freezechance3 and attacker and attacker.components.freezable and inst.level >=1400 and inst.level <2200 and attacker.components.combat then 
            attacker.components.freezable:AddColdness(0.4)
            attacker.components.freezable:SpawnShatterFX()
			fx.Transform:SetScale(1, 1, 1)
			fx.Transform:SetPosition(attacker:GetPosition():Get())
		elseif data and math.random() < freezechance3 and attacker and attacker.components.freezable and inst.level >=2200 and attacker.components.combat then
			attacker.components.freezable:AddColdness(0.5)
            attacker.components.freezable:SpawnShatterFX()
			fx.Transform:SetScale(1, 1.1, 1)
			fx.Transform:SetPosition(attacker:GetPosition():Get())
		            end end
    inst:ListenForEvent("attacked", inst.freezefn, owner)
	
    inst:ListenForEvent("attacked", inst.expfn, owner)

	inst:ListenForEvent("newstate", stopusingshield, owner)
	
end
local function onuseshield(inst,owner)
	if inst.components.container ~= nil then
         inst.components.container:Open(owner)
    end
	if not inst.broken then
	inst.shield = true
	inst:AddTag("fridge")
	on_shield(inst)
	local owner = inst.components.inventoryitem.owner
        if owner then
           owner.sg:GoToState("shell_enter")
	owner.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
        end
		
	elseif inst.broken then
		inst:RemoveTag("fridge")
	end
end

local function offuseshield(inst,owner)
	--[[if inst.components.container ~= nil then
        inst.components.container:Open(owner)
		end]]
	inst.components.fueled:StopConsuming()
	inst:RemoveTag("fridge")	
   if inst.consume then inst.consume:Cancel() inst.consume = nil end
	off_shield(inst)

end
	
local function onunequip(inst, owner)
if inst.task1 then inst.task1:Cancel() inst.task1 = nil end
if inst.task2 then inst.task2:Cancel() inst.task2 = nil end
	if inst.components.heater then
	inst:RemoveComponent("heater")
	end
  	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
    if inst.components.container ~= nil then
        
    end
inst.components.fueled:StopConsuming()      
   	
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
  	
	owner.AnimState:ClearOverrideSymbol("swap_body_tall")
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("backpack")
	        inst:RemoveEventCallback("attacked", inst.freezefn, owner)
		inst:RemoveEventCallback("attacked", inst.expfn, owner)

  inst:RemoveEventCallback("newstate", stopusingshield, owner)
  
		   UpgradeArmor(inst)
if inst.components.container ~= nil then
        inst.components.container:Close(owner)
		end

end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
   MakeInventoryPhysics(inst)  
      	
    inst.AnimState:SetBank("armor_wood")
    inst.AnimState:SetBuild("armor_frostar")
    inst.AnimState:PlayAnimation("anim")
	        inst:AddTag("waterproofer")
		    inst:AddTag("musha_items")
			inst:AddTag("butterfly")
			inst:AddTag("fridge")
			inst:AddTag("backpack")
			-- inst:AddTag("lowcool")
			inst:AddTag("aquatic")
		inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "broken_frosthammer.tex" )
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"
		
   inst:AddTag("shell")

    inst.foleysound = "dontstarve/movement/foley/shellarmour"
	
	local swap_data = {bank = "armor_wood", anim = "anim"}
    MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, swap_data)
	
inst.entity:SetPristine()	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("backpack") 
		end
		return inst
	end


    inst:AddComponent("inspectable")
    	--inst.boost = true
	    inst:AddComponent("inventoryitem")
		inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
		inst:DoTaskInTime(0, OnDropped)
	   --inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/krampuspack"
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/broken_frosthammer.xml"

--inst.components.inventoryitem.cangoincontainer = false
 
 
    inst:AddComponent("armor")
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.03)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("backpack")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose
	
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = onuseshield
    inst.components.machine.turnofffn = offuseshield
    inst.components.machine.cooldowntime = 1
	
    inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onuseshield)
       inst.components.useableitem:SetOnStopUseFn(offuseshield)
	
	
  inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
  inst.components.insulator:SetSummer()
--inst.components.insulator.insulation = TUNING.INSULATION_SMALL
 
 
    inst.OnLoad = OnLoad
    inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

        inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
        inst.components.fueled:InitializeFuelLevel(30000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
inst.components.fueled:StartConsuming()        

	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
inst.check_level = levelexp
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	

  
MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab( "common/inventory/broken_frosthammer", fn, assets) 

