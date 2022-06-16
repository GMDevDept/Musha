local assets=
{
    Asset("ANIM", "anim/bowm.zip"),
    Asset("ANIM", "anim/swap_bowm.zip"),
	Asset("ANIM", "anim/swap_bowm2.zip"),
	--Asset("ANIM", "anim/swap_bowm3.zip"),
	Asset("ANIM", "anim/swap_bowm_boost.zip"),
	Asset("ANIM", "anim/swap_bowm_broken.zip"),
	
    Asset("ATLAS", "images/inventoryimages/bowm.xml"),
    Asset("IMAGE", "images/inventoryimages/bowm.tex"),

}

local prefabs = 
{
}


local function boostFX(inst)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then 
	if inst.boost then
	local change_fx = SpawnPrefab("firesplash_fx")
	change_fx.Transform:SetScale(0.2, 0.2, 0.2)
    local follower = change_fx.entity:AddFollower()
	follower:FollowSymbol( owner.GUID, "swap_object", 1, -100, 1 )
	else
	local fx = SpawnPrefab("lantern_winter_fx_held2")
    local followerx = fx.entity:AddFollower()
		followerx:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )
	end
end	
end

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say("-[Phoenix Blade]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say(STRINGS.MUSHA_WEAPON_SWORD_BOW.." \n[MAX]")
end
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

local function Upgradedamage(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
	inst.boost = false 	
	--inst:RemoveComponent("spellcaster")
    inst.components.weapon:SetDamage(1)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
  
elseif not inst.broken then

 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(20)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV1)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (20)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
 elseif inst.level >=10 and inst.level <30 then
    inst.components.weapon:SetDamage(21)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV2)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (21)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
 elseif inst.level >=30 and inst.level <50 then
    inst.components.weapon:SetDamage(22)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV3)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (22)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
 elseif inst.level >=50 and inst.level <70 then
    inst.components.weapon:SetDamage(23)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV4)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (23)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
  elseif inst.level >=70 and inst.level <90 then
    inst.components.weapon:SetDamage(24)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV5)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (24)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
 elseif inst.level >=90 and inst.level <120 then
    inst.components.weapon:SetDamage(25)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV6)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (25)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
 elseif inst.level >=120 and inst.level <150 then
    inst.components.weapon:SetDamage(26)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV7)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (26)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
elseif inst.level >=150 and inst.level <180 then
    inst.components.weapon:SetDamage(27)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV8)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (27)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
elseif inst.level >=180 and inst.level <210 then
    inst.components.weapon:SetDamage(28)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV9)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (28)\n"..STRINGS.MUSHA_WEAPON_POISON.." (4D/30C)")
elseif inst.level >=210 and inst.level <250 then
    inst.components.weapon:SetDamage(29)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV10)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (29)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=250 and inst.level <350 then
    inst.components.weapon:SetDamage(30)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV11)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (30)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=350 and inst.level <450 then
    inst.components.weapon:SetDamage(31)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV12)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (31)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=450 and inst.level <550 then
    inst.components.weapon:SetDamage(32)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV13)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (32)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=550 and inst.level <650 then
    inst.components.weapon:SetDamage(33)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV14)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (33)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=650 and inst.level <750 then
    inst.components.weapon:SetDamage(34)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV15)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (34)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=750 and inst.level <850 then
    inst.components.weapon:SetDamage(35)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV16)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (35)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=850 and inst.level <950 then
    inst.components.weapon:SetDamage(36)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV17)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (36)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=950 and inst.level <1050 then
    inst.components.weapon:SetDamage(37)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV18)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (37)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=1050 and inst.level <1200 then
    inst.components.weapon:SetDamage(38)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV19)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (38)\n"..STRINGS.MUSHA_WEAPON_POISON.." (8D/35C)")
elseif inst.level >=1200 and inst.level <1400 then
    inst.components.weapon:SetDamage(39)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV20)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (39)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)")
elseif inst.level >=1400 and inst.level <1600 then
    inst.components.weapon:SetDamage(40)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV21)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (40)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=1600 and inst.level <1800 then
    inst.components.weapon:SetDamage(41)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV22)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (41)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=1800 and inst.level <2000 then
    inst.components.weapon:SetDamage(42)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV23)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (42)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=2000 and inst.level <2200 then
    inst.components.weapon:SetDamage(43)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV24)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (43)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=2200 and inst.level <2400 then
    inst.components.weapon:SetDamage(44)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV25)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (44)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=2400 and inst.level <2600 then
    inst.components.weapon:SetDamage(45)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV26)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (45)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=2600 and inst.level <2800 then
    inst.components.weapon:SetDamage(46)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV27)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (46)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=2800 and inst.level <3000 then
    inst.components.weapon:SetDamage(47)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV28)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (47)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=3000 and inst.level <4000 then
    inst.components.weapon:SetDamage(48)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(LV29)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (48)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=4000 then
    inst.components.weapon:SetDamage(50)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_VIPER.."\n(Max30)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (50)\n"..STRINGS.MUSHA_WEAPON_POISON.." (12D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(2/30C)")
end
end
end


local function OnDurability(inst, data)
inst.broken = true
 	Upgradedamage(inst)
	--if inst.task then inst.task:Cancel() inst.task = nil end
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
Upgradedamage(inst)
if not inst.forgelab_on then
   if math.random() < expchance1 and inst.level <= 4005 then
	inst.level = inst.level + 2
	levelexp(inst)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_SWORD_BOW.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_SWORD_BOW.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_SWORD_BOW.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(8)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance0 and inst.level <= 4005 then
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

local function OnLoad(inst, data)
    Upgradedamage(inst)
end





local function onattack_Flame(inst, attacker, target)
--check arrow
 	local arrowm = inst.components.container:FindItem(function(arrowm) 	
	return arrowm.prefab == "arrowm" end )
		
			if arrowm then
				inst.arrow_ready = true
			else
				inst.arrow_ready = false	
			end
			
if not inst.arrow_ready and inst:HasTag("bowm") and inst.boost then
	inst:RemoveTag("bowm") inst:RemoveTag("blowdart")	
	owner.bowm = false
	inst.boost = false
	inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
	--inst:RemoveComponent("weapon")
	--inst:AddComponent("weapon")
    inst.components.weapon:SetProjectile(nil)
	inst.components.weapon:SetProjectileOffset(1)
	inst.components.weapon:SetRange(0)
	Upgradedamage(inst)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_ARROWS)
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
end

local poisone_1 = 0.3
local poisone_2 = 0.35
local poisone_3 = 0.4

local flamechanceb = 0.2
local flamechance2b = 0.3
local flamechance3b = 0.4
local expchance = 0.1
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1


if math.random() < expchance and not inst.broken and inst.level <= 4000 then
	inst.level = inst.level + 1
		inst.components.talker:Say(STRINGS.MUSHA_WEAPON..":GP+1")
	--levelexp(inst)
	end
    if target and not inst.broken and math.random() < damagedur1 then
inst.components.fueled:DoDelta(-150000)
    elseif target and not inst.broken and math.random() < damagedur2 then
inst.components.fueled:DoDelta(-75000)
    elseif target and not inst.broken and math.random() < damagedur3 then
inst.components.fueled:DoDelta(-35000)
    elseif target and not inst.broken and math.random() < damagedur4 then
inst.components.fueled:DoDelta(-20000)
    elseif target and inst.broken then
TakeItem_effect(inst)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
    end
 
	-----
if target ~= nil and not target:HasTag("smashable") and not target:HasTag("companion") and not target:HasTag("yamcheb") and not target:HasTag("yamche") and (target.components.burnable or target.components.freezable) then	
	if target.components.locomotor and target.components.health and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and not inst.boost then
				if math.random() < poisone_1 and not inst.boost and inst.level <250 and not target:HasTag("slow_poison") then
        
		local poison = SpawnPrefab("poisonbubble_short2")
		poison.Transform:SetPosition(target:GetPosition():Get())
		poison.Transform:SetScale(0.3,0.3,0.3)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
		local follower = poison.entity:AddFollower()
			if not target:HasTag("cavedweller") then
			follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, -10, 0.5 )
			else
			follower:FollowSymbol(target.GUID, "body", 0, -10, 0.5 )
			end
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then
				--target.components.health:DoDelta(-4)
				target.components.combat:GetAttacked(inst, 4)
		elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then			
				target.components.health:DoDelta(-4)
			end
			end)
		TheWorld:DoTaskInTime(9, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() end)
		
	elseif math.random() < poisone_2 and not inst.boost and inst.level >=250 and inst.level <1400 and not target:HasTag("slow_poison") then
        
 		local poison = SpawnPrefab("poisonbubble_short2")
		poison.Transform:SetPosition(target:GetPosition():Get())
		poison.Transform:SetScale(0.3,0.3,0.3)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
		local follower = poison.entity:AddFollower()
			if not target:HasTag("cavedweller") then
			follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, -10, 0.5 )
			else
			follower:FollowSymbol(target.GUID, "body", 0, -10, 0.5 )
			end
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then
				--target.components.health:DoDelta(-8)
				target.components.combat:GetAttacked(inst, 8)
		elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then			
				target.components.health:DoDelta(-8)
			end
			end)		
		TheWorld:DoTaskInTime(12, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() end)
	
	elseif math.random() < poisone_3 and not inst.boost and inst.level >=1400 and not target:HasTag("slow_poison") then
        
		local poison = SpawnPrefab("poisonbubble_short2")
		poison.Transform:SetPosition(target:GetPosition():Get())
		poison.Transform:SetScale(0.3,0.3,0.3)
		target:AddTag("slow_poison")
		if poison and target:HasTag("slow_poison") then
		local follower = poison.entity:AddFollower()
			if not target:HasTag("cavedweller") then
			follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, -10, 0.5 )
			else
			follower:FollowSymbol(target.GUID, "body", 0, -10, 0.5 )
			end
		end
		TheWorld:DoPeriodicTask(3, function() 
		if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and not target:HasTag("epic") then
				--target.components.health:DoDelta(-12)
				target.components.combat:GetAttacked(inst, 12)
		elseif target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() and target:HasTag("epic") then			
				target.components.health:DoDelta(-12)
			end
			end)
		TheWorld:DoTaskInTime(15, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_poison") poison:Remove() end)
		end
	
	elseif target.components.health and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.boost then
	if not (target:HasTag("bird") or target:HasTag("rabbit") or target:HasTag("butterfly")) then
	if math.random() < flamechanceb and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.boost and inst.level <250 then
        local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(target:GetPosition():Get())
        if target.components.burnable then
		target.components.burnable:Ignite()
		end
        target.components.health:DoDelta(-20)
	elseif math.random() < flamechance2b and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.boost and inst.level >=250 and inst.level <1400 then
        local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(target:GetPosition():Get())
        if target.components.burnable then
		target.components.burnable:Ignite()
		end
        target.components.health:DoDelta(-30)
	elseif math.random() < flamechance3b and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.boost and inst.level >=1400 then
        local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)
		fx.Transform:SetPosition(target:GetPosition():Get())
        if target.components.burnable then
		target.components.burnable:Ignite()
		end
        target.components.health:DoDelta(-40)	
		--attacker.components.sanity:DoDelta(1)
	end
	end
end	

		
	if math.random() < 0.15 and target.components.health and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.level >=1400 and inst.level <4000 then
			local fx = SpawnPrefab("statue_transition")
			local pos = Vector3(target.Transform:GetWorldPosition())
			fx.Transform:SetPosition(pos:Get())
			attacker.components.sanity:DoDelta(1)
	elseif math.random() < 0.2 and target.components.health and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and not target:HasTag("alignwall") and not target:HasTag("shadowminion") and target.components.health and not target.components.health:IsDead() and inst.level >=4000 then
			local fx = SpawnPrefab("statue_transition")
			local pos = Vector3(target.Transform:GetWorldPosition())
			fx.Transform:SetPosition(pos:Get())
			attacker.components.sanity:DoDelta(2)		
	end
end
	
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() and not target:HasTag("buzzard") then
        target.components.burnable:Extinguish()
    end
    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

end


local function onequip(inst, owner)	
	if not inst.share_item and owner ~= nil and not owner:HasTag("musha") and owner.components.inventory then
		owner.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
        owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	
	if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end	
	
 	--[[local arrowm = inst.components.container:FindItem(function(arrowm) 	
	return arrowm.prefab == "arrowm" end )
		
			if arrowm then
				inst.arrow_ready = true
			else
				inst.arrow_ready = false	
			end]]
			

	owner.fire = true
	Upgradedamage(inst)
if inst.broken then 
    owner.AnimState:OverrideSymbol("swap_object", "swap_bowm_broken", "bowm")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
elseif not inst.broken and not inst.boost then  
    owner.AnimState:OverrideSymbol("swap_object", "swap_bowm", "bowm")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
elseif not inst.broken and inst.boost then    
    owner.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 	
	inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
	if inst.level <250 then 
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (20D/20C)")
	elseif inst.level >=250 and inst.level <1400 then 
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (30D/30C)")
	elseif inst.level >=1400  and inst.level <4000 then   
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (40D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/15C)")
	elseif inst.level >=4000 then  
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (40D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(2/20C)")
	end
	
end
boostFX(inst)
end
 
local function onunequip(inst, owner)	
 
	owner.fire = false
    Upgradedamage(inst)
	--inst.boost = false 
  
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
	
	if inst.components.container ~= nil then
        inst.components.container:Close()
    end
end


local function off_boost(inst, data)
local owner = inst.components.inventoryitem.owner 
if owner and inst.boost and not inst.broken then
	inst.boost = false 
	owner.bowm = false
	inst:RemoveTag("bowm") inst:RemoveTag("blowdart")	
	--inst:RemoveComponent("weapon")
	--inst:AddComponent("weapon")
	inst.components.weapon:SetProjectile(nil)
	inst.components.weapon:SetProjectileOffset(1)
	inst.components.weapon:SetRange(0)
	Upgradedamage(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	onequip(inst, owner)
end
end

local function fire_arrow(inst, attacker, target)

	--[[if not target:IsValid() then
        return
    end]]

--[[if inst:HasTag("bowm") and inst.arrow_ready then
	inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_impact_fire")
	if inst.components.container ~= nil and inst.components.container:Has("arrowm", 1) then
    inst.components.container:ConsumeByName("arrowm", 1)
	end
	target.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_impact_fire")	
end]]

local arrowm = inst.components.container:FindItem(function(arrowm) 	
	return arrowm.prefab == "arrowm" end )
		
			if arrowm then
				inst.arrow_ready = true
			else
				inst.arrow_ready = false	
				off_boost(inst)
			end
 	
if not attacker:HasTag("framea") and not attacker:HasTag("lightningblue1") and not attacker:HasTag("lightningblue2") then

if math.random() < 0.7 and target.components.health and not target.components.health:IsDead() and target:HasTag("bird") then
	target:DoTaskInTime(0.3, function() 
	if not target.components.health:IsDead() then
	target.sg:GoToState("flyaway") 

	end
	end)
end

if math.random() < 0.5 and target.components.health and not target.components.health:IsDead() and (target:HasTag("rabbit") or target:HasTag("butterfly")) then

	if target:HasTag("rabbit") and not target.components.health:IsDead() then	
	target:DoTaskInTime(0.3, function() target:PushEvent("gohome") end)
	end

end

if target:HasTag("rabbit") and target.components.health and not target.components.health:IsDead() then	
target:DoTaskInTime(0.3, function() target:PushEvent("gohome") end)
end

end
end

local function on_boost(inst, data)
local owner = inst.components.inventoryitem.owner
    inst.AnimState:SetBank("bowm")
    inst.AnimState:SetBuild("bowm")
    inst.AnimState:PlayAnimation("idle")
if owner ~= nil and inst.broken then
	inst.boost = false 	
	owner.bowm = false
	inst:RemoveTag("bowm") inst:RemoveTag("blowdart")
	--inst:RemoveComponent("spellcaster")
	owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON.."\n"..STRINGS.MUSHA_ITEM_DUR.." (0)")
    --inst.components.equippable.walkspeedmult = 1
	owner.AnimState:OverrideSymbol("swap_object", "swap_bowm_broken", "bowm")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
        --inst.components.useableitem:StopUsingItem()
end

-- check arrow	
--[[if owner ~= nil then
 	local arrowm = inst.components.container:FindItem(function(arrowm) 	
	return arrowm.prefab == "arrowm" end )
		
			if arrowm then
				inst.arrow_ready = true
			else
				inst.arrow_ready = false	
			
				inst:RemoveTag("bowm") inst:RemoveTag("blowdart")
				inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_ARROWS)
				inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
				--inst.components.useableitem:StopUsingItem()
			end
end]]
if owner and not inst.boost and not inst.broken and inst.arrow_ready then
		
	inst.boost = true
	owner.bowm = true
	inst:AddTag("bowm") inst:AddTag("blowdart")
--[[local change_fx = SpawnPrefab("small_puff")
        local follower = change_fx.entity:AddFollower()
				follower:FollowSymbol( owner.GUID, "swap_object", 1, -150, 1 )]]
	if inst.components.weapon ~= nil then
	inst.components.weapon:SetRange(12, 15)
 
    inst.components.weapon:SetProjectile("bowm_projectile")
    inst.components.weapon:SetOnProjectileLaunch(fire_arrow)
	Upgradedamage(inst)

	end

   -- inst.task = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
	inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel") 
    inst.entity:AddLight()
	--SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
 
        --inst.components.useableitem:StopUsingItem()

	owner.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
	--owner.AnimState:OverrideSymbol("swap_object", "swap_bowm_boost", "bowm")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
	
if inst.level <250 then  --250
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n("..STRINGS.MUSHA_LEVEL_LEVEL..":"..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (20D/20C)")
elseif inst.level >=250 and inst.level <1400 then  --250  1400
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n("..STRINGS.MUSHA_LEVEL_LEVEL..":"..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (30D/30C)")
elseif inst.level >=1400  and inst.level <4000 then  --1400
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n("..STRINGS.MUSHA_LEVEL_LEVEL..":"..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (40D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(1/25C)")
elseif inst.level >=4000 then  
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BB_BOW.."\n("..STRINGS.MUSHA_LEVEL_LEVEL..":"..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." ("..STRINGS.MUSHA_WEAPON_BB_VIPER..")\n"..STRINGS.MUSHA_WEAPON_FIRE.." (40D/40C)\n"..STRINGS.MUSHA_WEAPON_SANITY.."\n(2/30C)")
end
-----------
elseif owner and inst.boost and not inst.broken then
	inst.boost = false 
	owner.bowm = false
	inst:RemoveTag("bowm") inst:RemoveTag("blowdart")	
	--inst:RemoveComponent("weapon")
	--inst:AddComponent("weapon")
	inst.components.weapon:SetProjectile(nil)
	inst.components.weapon:SetProjectileOffset(1)
	inst.components.weapon:SetRange(0)

	--owner.components.talker:Say("Blade !")
	--inst.components.talker:Say("[ Sunny Blade ]\nPower Off")
	Upgradedamage(inst)

    inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
  --inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
--SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
	onequip(inst, owner)


        --inst.components.useableitem:StopUsingItem()
end
boostFX(inst)
end

local function OnAmmoLoaded(inst, data)
	if inst.components.weapon ~= nil then
		if data ~= nil and data.item ~= nil then
			--inst.components.weapon:SetProjectile(data.item.prefab.."arrowm")
			inst.arrow_ready = true
			data.item:PushEvent("ammoloaded", {slingshot = inst})
		end
	end
end

local function OnAmmoUnloaded(inst, data)
	if inst.components.weapon ~= nil then
		--inst.components.weapon:SetProjectile(nil)
		inst.components.weapon:SetRange(0)
		if data ~= nil and data.prev_item ~= nil then
			inst.arrow_ready = false
			on_boost(inst)
			data.prev_item:PushEvent("ammounloaded", {slingshot = inst})
		end
	end
end

local function OnProjectileLaunched(inst, attacker, target)
	if inst.components.container ~= nil then
		local ammo_stack = inst.components.container:GetItemInSlot(1)
		local item = inst.components.container:RemoveItem(ammo_stack, false)
		if item ~= nil then
			if item == ammo_stack then
				item:PushEvent("ammounloaded", {slingshot = inst})
			end
			item:Remove()
		end
	end
end

local function mushabow()
 	local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    inst.entity:AddLight()
	inst.Light:SetRadius(.4)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(80/255,120/255,250/255)
	inst.Light:Enable(true)
	
    MakeInventoryPhysics(inst)
	
     	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "bowm.tex" )
	
    inst.AnimState:SetBank("bowm")
    inst.AnimState:SetBuild("bowm")
    inst.AnimState:PlayAnimation("idle")
 
	--inst:AddTag("bowm") inst:AddTag("blowdart")
	--inst:AddTag("sharp")
	inst:AddTag("musha_items")
	inst:AddTag("waterproofer")

	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 0.8, 0.65, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"
	
	local swap_data = {bank = "bowm", anim = "anim"}
    MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, swap_data)
	
    inst.entity:SetPristine()
 
    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("slingshot") 
		end
        return inst
    end	
	inst.boost = false
    inst:AddComponent("inspectable")

	inst:AddComponent("weapon")
    inst.components.weapon:SetOnAttack(Upgradedamage)
    inst.components.weapon:SetOnAttack(onattack_Flame)
	
	inst.components.weapon:SetOnProjectileLaunched(OnProjectileLaunched)
	inst.components.weapon:SetProjectile(nil)
	inst.components.weapon:SetProjectileOffset(1)
	
	inst:AddComponent("container")
	
    inst.components.container:WidgetSetup("slingshot")
	inst.components.container.canbeopened = false
    inst:ListenForEvent("itemget", OnAmmoLoaded)
    inst:ListenForEvent("itemlose", OnAmmoUnloaded)
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "bowm"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bowm.xml"
	inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0	
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_boost
    inst.components.machine.turnofffn = off_boost
    inst.components.machine.cooldowntime = 1
	inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(on_boost)
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
       inst:AddComponent("fueled")
	   inst.components.fueled.verb = "Repair"
       inst.components.fueled.fueltype = "CHEMICAL"
       inst.components.fueled:InitializeFuelLevel(30000000)
		
       inst.components.fueled:SetDepletedFn(OnDurability)
       inst.components.fueled.ontakefuelfn = TakeItem
       inst.components.fueled.accepting = true
	   inst.components.fueled:StopConsuming()        
	   inst.boost = false 

	inst.level = 0
	inst:ListenForEvent("levelup", levelexp)
	inst.check_level = levelexp
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	MakeHauntableLaunch(inst)
    return inst
end

return  Prefab("common/inventory/bowm", mushabow, assets, prefabs)
