local assets=
{
	Asset("ANIM", "anim/frosthammer.zip"),
	Asset("ANIM", "anim/swap_frosthammer.zip"),
	Asset("ANIM", "anim/swap_frosthammer2.zip"),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
}

local prefabs =
{
    "icespike_fx_1",
    "icespike_fx_2",
    "icespike_fx_3",
    "icespike_fx_4",
}
local function boostFX(inst)
local owner = inst.components.inventoryitem.owner
	if owner ~= nil then
	local fx = SpawnPrefab("lantern_winter_fx_held2")
    local follower = fx.entity:AddFollower()
		follower:FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )
		
	local fx2 = SpawnPrefab("weaponsparks")
    local follower2 = fx.entity:AddFollower()
		follower2:FollowSymbol( owner.GUID, "swap_object", 1, -350, 1 )	
	end	
	
end
local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then
--inst.components.talker:Say(STRINGS.MUSHA_ITEM_BLADE_A.."[]-\n[Grow Points]".. (inst.level))
end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.."] \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say("-["..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n[MAX]")
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
   inst.components.weapon:SetDamage(1)
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN.." \n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (1)")
  
elseif not inst.broken then

 if inst.level >=0 and inst.level <10 then
    inst.components.weapon:SetDamage(75)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV1)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (75)")
 elseif inst.level >=10 and inst.level <30 then
    inst.components.weapon:SetDamage(77)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV2)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (77)")
 elseif inst.level >=30 and inst.level <50 then
    inst.components.weapon:SetDamage(79)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV3)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (79)")
 elseif inst.level >=50 and inst.level <70 then
    inst.components.weapon:SetDamage(81)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV4)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (81)")
 elseif inst.level >=70 and inst.level <90 then
    inst.components.weapon:SetDamage(83)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV5)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (83)")
 elseif inst.level >=90 and inst.level <120 then
    inst.components.weapon:SetDamage(85)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV6)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (85)")
 elseif inst.level >=120 and inst.level <150 then
    inst.components.weapon:SetDamage(87)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV7)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (87)")
elseif inst.level >=150 and inst.level <180 then
    inst.components.weapon:SetDamage(89)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV8)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (89)")
elseif inst.level >=180 and inst.level <210 then
    inst.components.weapon:SetDamage(91)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV9)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (91)")
elseif inst.level >=210 and inst.level <250 then
    inst.components.weapon:SetDamage(93)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV10)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (93)")
elseif inst.level >=250 and inst.level <350 then
    inst.components.weapon:SetDamage(95)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV11)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (95)")
elseif inst.level >=350 and inst.level <450 then
    inst.components.weapon:SetDamage(97)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV12)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (97)")
elseif inst.level >=450 and inst.level <550 then
    inst.components.weapon:SetDamage(99)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV13)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (99)")
elseif inst.level >=550 and inst.level <650 then
    inst.components.weapon:SetDamage(101)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV14)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (101)")
elseif inst.level >=650 and inst.level <750 then
    inst.components.weapon:SetDamage(103)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV15)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (103)")
elseif inst.level >=750 and inst.level <850 then
    inst.components.weapon:SetDamage(105)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV16)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (105)")
elseif inst.level >=850 and inst.level <950 then
    inst.components.weapon:SetDamage(107)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV17)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (107)")
elseif inst.level >=950 and inst.level <1050 then
    inst.components.weapon:SetDamage(109)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV18)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (109)")
elseif inst.level >=1050 and inst.level <1200 then
    inst.components.weapon:SetDamage(111)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV19)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (111)")
elseif inst.level >=1200 and inst.level <1400 then
    inst.components.weapon:SetDamage(113)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV20)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (113)")
elseif inst.level >=1400 and inst.level <1600 then
    inst.components.weapon:SetDamage(115)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV21)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (115)")
elseif inst.level >=1600 and inst.level <1800 then
    inst.components.weapon:SetDamage(120)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV22)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (120)")
elseif inst.level >=1800 and inst.level <2000 then
    inst.components.weapon:SetDamage(130)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV23)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (130)")
elseif inst.level >=2000 and inst.level <2200 then
    inst.components.weapon:SetDamage(140)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV24)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (140)")
elseif inst.level >=2200 and inst.level <2400 then
    inst.components.weapon:SetDamage(150)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV25)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (150)")
elseif inst.level >=2400 and inst.level <2600 then
    inst.components.weapon:SetDamage(160)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV26)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (160)")
elseif inst.level >=2600 and inst.level <2800 then
    inst.components.weapon:SetDamage(170)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV27)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (170)")
elseif inst.level >=2800 and inst.level <3000 then
    inst.components.weapon:SetDamage(180)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV28)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (180)")
elseif inst.level >=3000 and inst.level <4000 then
    inst.components.weapon:SetDamage(190)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(LV29)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (190)")
elseif inst.level >=4000 then
    inst.components.weapon:SetDamage(200)
	inst.components.talker:Say("[" ..STRINGS.MUSHA_WEAPON_FROSTHAMMER.. "] \n(Max30)\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (200)")
end
end
end

local function OnDurability(inst, data)
inst.broken = true
 	Upgradedamage(inst)
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
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4005 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4005 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say("-"..STRINGS.MUSHA_WEAPON_FROSTHAMMER.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(8)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
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
-------- --------
local function OnLoad(inst, data)
    Upgradedamage(inst)
end

local function frosta_hammer(inst, owner)
local player = inst.components.inventoryitem.owner
local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and (inst.power or player.switch) then
 	player.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
    player.AnimState:Show("ARM_carry") 
    player.AnimState:Hide("ARM_normal") 
else
	player.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    player.AnimState:Show("ARM_carry") 
    player.AnimState:Hide("ARM_normal") 
end
	end
	
local function SpawnIceFx(inst, target)
    if not inst or not target then return end
    local numFX = math.random(3,5)
    local pos = target:GetPosition()
    local targetPos = target:GetPosition()
    local vec = targetPos - pos
    vec = vec:Normalize()
    local dist = pos:Dist(targetPos)
    local angle = inst:GetAngleToPoint(targetPos:Get())

    for i = 1, numFX do
        inst:DoTaskInTime(math.random() * 0.1, function(inst)
            local prefab = "icespike_fx_"..math.random(1,4)
            local fx = SpawnPrefab(prefab)
            if fx then
                local x = GetRandomWithVariance(0, 1)
                local z = GetRandomWithVariance(0, 1)
                local offset = (vec * math.random(dist * 0.1, dist)) + Vector3(x,0,z)
                fx.Transform:SetPosition((offset+pos):Get())
            end
        end)
    end
end	
local function mana_cost(inst,owner)
local owner = inst.components.inventoryitem.owner
    if owner ~= nil and owner.components.spellpower ~= nil and inst.boost then
	inst.power = true
	boostFX(inst)
        if not inst.winter then
        owner.components.spellpower:DoDelta(-2,false)
		end
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
		owner.AnimState:Show("ARM_carry") 
		owner.AnimState:Hide("ARM_normal")
    end
end

local function onattack_FROST(inst, attacker, target)
local freezechance1 = 0.42
local freezechance2 = 0.52
local freezechance3 = 0.62
local expchance = 0.1
local damagedur1 = 0.2
local damagedur2 = 0.5
local damagedur3 = 0.7
local damagedur4 = 1

if not inst.boost then
local fx = SpawnPrefab("groundpoundring_fx")
local fx2 = SpawnPrefab("groundpoundring_fx")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetScale(0.3, 0.3, 0.3)
	fx2.Transform:SetScale(0.45, 0.45, 0.45)
	fx.Transform:SetPosition(pos:Get())
	TheWorld:DoTaskInTime(0.2, function() fx2.Transform:SetPosition(pos:Get()) end)
	
elseif inst.boost then
local fx = SpawnPrefab("groundpoundring_fx")
local fx2 = SpawnPrefab("groundpoundring_fx")
local pos = Vector3(target.Transform:GetWorldPosition())
	fx.Transform:SetScale(0.45, 0.45, 0.45)
	fx2.Transform:SetScale(0.6, 0.6, 0.6)
	fx.Transform:SetPosition(pos:Get())
	TheWorld:DoTaskInTime(0.2, function() fx2.Transform:SetPosition(pos:Get()) end)
end
	
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

	if target.components.freezable then
		if not inst.power then
		target.components.freezable:AddColdness(0.15)
        target.components.freezable:SpawnShatterFX()
		elseif inst.power then
        target.components.freezable:AddColdness(1.65)
        target.components.freezable:SpawnShatterFX()
		SpawnIceFx(inst, attacker.components.combat.target)
		inst.power = false
		local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1.0, 2, 1.0)
		fx.Transform:SetPosition(target:GetPosition():Get())	
		end
	end	

	if not inst.boost then
	if target ~= nil and not target:HasTag("smashable") and not target:HasTag("companion") and not target:HasTag("yamcheb") and not target:HasTag("yamche") and not target:HasTag("critter") then
	if math.random() < freezechance1 and target.components.freezable and inst.level <250 then
        target.components.freezable:AddColdness(0.7)
       	local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 1.2, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())	
		--target.components.health:DoDelta(-10)
		if target.components.locomotor and target.components.health and not target.components.health:IsDead() and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("slow_frozen") then
		target:AddTag("slow_frozen")
		local frozen = SpawnPrefab("debuff_frozen")
		frozen.Transform:SetPosition(target:GetPosition():Get())
		frozen.Transform:SetScale(0.5,0.8,0.5)
		if frozen and target:HasTag("slow_frozen") then
		local follower = frozen.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
	TheWorld:DoTaskInTime(4, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_frozen") frozen:Remove() end)
		end
	elseif math.random() < freezechance2 and target.components.freezable and inst.level >=250 and inst.level <1400 then
        target.components.freezable:AddColdness(0.8)
        local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 1.35, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())
		--target.components.health:DoDelta(-20)
		if target.components.locomotor and target.components.health and not target.components.health:IsDead() and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("slow_frozen") then
		target:AddTag("slow_frozen")
		local frozen = SpawnPrefab("debuff_frozen")
		frozen.Transform:SetPosition(target:GetPosition():Get())
		frozen.Transform:SetScale(0.5,0.8,0.5)
		if frozen and target:HasTag("slow_frozen") then
		local follower = frozen.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
	TheWorld:DoTaskInTime(4, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_frozen") frozen:Remove() end)
		end
	elseif math.random() < freezechance3 and target.components.freezable and inst.level >=1400 then
        target.components.freezable:AddColdness(0.9)
        local prefab = "icespike_fx_"..math.random(1,4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 1.5, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())	
		--target.components.health:DoDelta(-30)	
		if target.components.locomotor and target.components.health and not target.components.health:IsDead() and not target:HasTag("shadowcreature") and not target:HasTag("structure") and not target:HasTag("slow_frozen") then
		target:AddTag("slow_frozen")
		local frozen = SpawnPrefab("debuff_frozen")
		frozen.Transform:SetPosition(target:GetPosition():Get())
		frozen.Transform:SetScale(0.5,0.8,0.5)
		if frozen and target:HasTag("slow_frozen") then
		local follower = frozen.entity:AddFollower()
		follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0 )
		end
	TheWorld:DoTaskInTime(4, function() target.components.locomotor.groundspeedmultiplier = 1 target:RemoveTag("slow_frozen") frozen:Remove() end)
		end		
	end
	end
	end
	
    if target.components.sleeper and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable and target.components.burnable:IsBurning() then
        target.components.burnable:Extinguish()
    end
    if target.components.combat and not target:HasTag("companion") then
        target.components.combat:SuggestTarget(attacker)
    end
	
	inst.power = false
	
	if inst.boost then
	inst:DoTaskInTime(3, function()
	mana_cost(inst) end)
	end

	frosta_hammer(inst)
	
	
end
--------

local function summoning(staff, target, pos)
--local player = inst.components.inventoryitem.owner
    local caster = staff.components.inventoryitem.owner
if caster.components.spellpower.current >= 25 and caster.components.leader:CountFollowers("frost_tentacle") < 8 then
    local light1 = SpawnPrefab("splash")
    local monster = SpawnPrefab("tentacle_frost")
 	local fail1 = SpawnPrefab("statue_transition")
    local fail2 = SpawnPrefab("statue_transition_2")

    fail1.Transform:SetPosition(pos.x, pos.y, pos.z)
    fail2.Transform:SetPosition(pos.x, pos.y, pos.z)
    light1.Transform:SetPosition(pos.x, pos.y, pos.z)
    monster.Transform:SetPosition(pos.x, pos.y, pos.z)
	--monster.limited = true
	monster.components.follower:SetLeader(caster)
	
	caster.components.spellpower:DoDelta(-25)

    elseif caster.components.spellpower.current < 25 then
	local fail1 = SpawnPrefab("small_puff")
    fail1.Transform:SetPosition(pos.x, pos.y, pos.z)
	caster.components.talker:Say(STRINGS.MUSHA_TALK_CANNOT)
	
	elseif caster.components.leader:CountFollowers("frost_tentacle") >= 8 then
	local fail1 = SpawnPrefab("small_puff")
    fail1.Transform:SetPosition(pos.x, pos.y, pos.z)
	caster.components.talker:Say(STRINGS.MUSHA_TALK_CANNOT2)
 
    end
end

local function yellow_reticuletargetfn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0, 0))
end


local function Release_Frost(inst,owner, data)

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if TheWorld.state.iswinter then
		inst.winter = true
	if inst.level >=0 and inst.level <10 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (75)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=10 and inst.level <30 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (77)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=30 and inst.level <50 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (79)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=50 and inst.level <70 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (81)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=70 and inst.level <90 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (83)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=90 and inst.level <120 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (85)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=120 and inst.level <150 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (87)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=150 and inst.level <180 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (89)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=180 and inst.level <210 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (91)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=210 and inst.level <250 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (93)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=250 and inst.level <350 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (95)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=350 and inst.level <450 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (97)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=450 and inst.level <550 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (99)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=550 and inst.level <650 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (101)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=650 and inst.level <750 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (103)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=750 and inst.level <850 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (105)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=850 and inst.level <950 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (107)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=950 and inst.level <1050 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (109)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=1050 and inst.level <1200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (111)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=1200 and inst.level <1400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (113)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=1400 and inst.level <1600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (115)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=1600 and inst.level <1800 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (120)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=1800 and inst.level <2000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (130)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=2000 and inst.level <2200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (140)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=2200 and inst.level <2400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (150)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=2400 and inst.level <2600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (160)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=2600 and inst.level <2800 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (170)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=2800 and inst.level <3000 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (180)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=3000 and inst.level <4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (190)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
elseif inst.level >=4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (200)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n"..STRINGS.MUSHA_WEAPON_WINTERCOST)
end	
	else	
		inst.winter = false
	if inst.level >=0 and inst.level <10 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (75)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=10 and inst.level <30 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (77)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=30 and inst.level <50 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (79)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=50 and inst.level <70 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (81)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=70 and inst.level <90 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (83)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=90 and inst.level <120 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (85)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=120 and inst.level <150 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (87)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=150 and inst.level <180 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (89)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=180 and inst.level <210 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (91)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=210 and inst.level <250 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (93)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=250 and inst.level <350 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (95)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=350 and inst.level <450 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (97)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=450 and inst.level <550 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (99)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=550 and inst.level <650 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (101)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=650 and inst.level <750 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (103)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=750 and inst.level <850 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (105)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=850 and inst.level <950 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (107)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=950 and inst.level <1050 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (109)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=1050 and inst.level <1200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (111)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=1200 and inst.level <1400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (113)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=1400 and inst.level <1600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (115)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=1600 and inst.level <1800 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (120)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=1800 and inst.level <2000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (130)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=2000 and inst.level <2200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (140)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=2200 and inst.level <2400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (150)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n")
elseif inst.level >=2400 and inst.level <2600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (160)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n")
elseif inst.level >=2600 and inst.level <2800 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (170)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n")
elseif inst.level >=2800 and inst.level <3000 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (180)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n")
elseif inst.level >=3000 and inst.level <4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (190)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n")
elseif inst.level >=4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_RELEASE.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (200)\n"..STRINGS.MUSHA_WEAPON_AREA.."\n"..STRINGS.MUSHA_WEAPON_FROZENSHARD.."\n"..STRINGS.MUSHA_WEAPON_TENTACLE_FROST.."\n")
end


end

	if inst.level >=2200 then	--lv10
		if not inst.components.spellcaster then
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(summoning)
    inst.components.spellcaster.canuseonpoint = true
		end
		--[[if not inst.components.reticule then
	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = yellow_reticuletargetfn
    inst.components.reticule.ease = true
		end]]
	end
	
    MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, function(inst, haunter)
        if math.random() <= TUNING.HAUNT_CHANCE_RARE then
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local start_angle = math.random()*2*PI
            local offset = FindWalkableOffset(pos, start_angle, math.random(3,12), 60, false, true)
            local pt = pos + offset
            createlight(inst, nil, pt)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
        return false
    end, true, false, true)
end
	 
local function Preserved_Frost(inst, data)
	inst.power = false
	inst.boost = false

	if inst.components.heater then
	inst:RemoveComponent("heater")
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if inst.components.reticule then

	end
	if inst.components.spellcaster then
    inst:RemoveComponent("spellcaster")
 	end
end 

 
local function OnDropped(inst,data)
    end
local function OnPutInInventory(inst)
    Upgradedamage(inst)
    end 
	


local function onunequip(inst, owner) 
inst.boost = false
inst.power = false
owner.frost = false
owner.frosthammer2 = false
inst.cost_on = false
--if inst.task2 then inst.task2:Cancel() inst.task2 = nil end
    Upgradedamage(inst)
    if inst.components.heater then
	inst:RemoveComponent("heater")
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if inst.components.reticule then
	inst:RemoveComponent("reticule")
	end
	if inst.components.spellcaster then
    inst:RemoveComponent("spellcaster")
 	end
    if inst.task then inst.task:Cancel() inst.task = nil end
     owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
end

local function onequip(inst, owner)
 
if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
		owner.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
        owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	
 inst.boost = false
 owner.frost = true
 owner.frosthammer2 = true
 Upgradedamage(inst)
 --inst.task2 = inst:DoPeriodicTask(3, function() mana_cost(inst, owner) end)
    owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
    --[[if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end]]
end
	  
local function off_boost(inst, data)
local owner = inst.components.inventoryitem.owner 
if owner ~= nil then
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	onequip(inst, owner)
end
end
	
local function on_boost(inst)
if not inst.boost then
	
	inst.boost = true
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	Release_Frost(inst)
	--inst.cost_on = true
	mana_cost(inst)
	
elseif inst.boost then
	
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
if inst.level >=0 and inst.level <10 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (75)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=10 and inst.level <30 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (77)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=30 and inst.level <50 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (79)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=50 and inst.level <70 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (81)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=70 and inst.level <90 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (83)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=90 and inst.level <120 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (85)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=120 and inst.level <150 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (87)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=150 and inst.level <180 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (89)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=180 and inst.level <210 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (91)\n"..STRINGS.MUSHA_WEAPON_FROST.."(40C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=210 and inst.level <250 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (93)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=250 and inst.level <350 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (95)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=350 and inst.level <450 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (97)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=450 and inst.level <550 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (99)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=550 and inst.level <650 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (101)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=650 and inst.level <750 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (103)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=750 and inst.level <850 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (105)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=850 and inst.level <950 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (107)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=950 and inst.level <1050 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (109)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=1050 and inst.level <1200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (111)\n"..STRINGS.MUSHA_WEAPON_FROST.."(50C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=1200 and inst.level <1400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (113)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=1400 and inst.level <1600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (115)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=1600 and inst.level <1800 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (120)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=1800 and inst.level <2000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (130)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=2000 and inst.level <2200 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (140)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=2200 and inst.level <2400 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (150)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=2400 and inst.level <2600 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (160)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=2600 and inst.level <2800 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (170)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=2800 and inst.level <3000 then
 	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (180)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=3000 and inst.level <4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (190)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
elseif inst.level >=4000 then
	inst.components.talker:Say(STRINGS.MUSHA_WEAPON_FROST_PRESERVED.."\n"..STRINGS.MUSHA_WEAPON_DAMAGE.." (200)\n"..STRINGS.MUSHA_WEAPON_FROST.."(60C)\n("..STRINGS.MUSHA_WEAPON_FREEZESLOW..")")
end
	Preserved_Frost(inst)
	inst.boost = false
	--inst.cost_on = false
	frosta_hammer(inst)
		
	end 
end		

 
local function fn()
local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)  
    inst.AnimState:SetBank("frosthammer")
    inst.AnimState:SetBuild("frosthammer")
    inst.AnimState:PlayAnimation("idle")
	
    inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "frosthammer.tex" )
	
   inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)
    inst.OnLoad = OnLoad
	    inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

     inst:AddComponent("weapon")
    inst.components.weapon:SetOnAttack(Upgradedamage)
	inst.components.weapon:SetOnAttack(onattack_FROST)
    inst.components.weapon:SetRange(1.6)

	 inst:AddTag("musha_items")
       inst:AddTag("waterproofer")
	    inst:AddTag("frost_hammer")
		
	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = yellow_reticuletargetfn
    inst.components.reticule.ease = true
	
inst.entity:SetPristine()	
    if not TheWorld.ismastersim then
		return inst
	end

    inst.boost = false 
	
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
 
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)
    	inst.components.inventoryitem.atlasname = "images/inventoryimages/frosthammer.xml"
 

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
	
	inst:AddComponent("machine")
    inst.components.machine.turnonfn = on_boost
    inst.components.machine.turnofffn = off_boost
    inst.components.machine.cooldowntime = 1
	
	inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(on_boost)
------------------------

       inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
       inst.components.fueled:InitializeFuelLevel(40000000)
		
        inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
		inst.components.fueled:StopConsuming()        
	
	inst.level = 0
	inst:ListenForEvent("levelup", levelexp)
	inst.check_level = levelexp
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	--inst.components.equippable.walkspeedmult = 0.75
    --inst.components.equippable.runspeedmult = 0.75

    MakeHauntableLaunch(inst)
 
    return inst
end


return Prefab( "common/inventory/frosthammer", fn, assets, prefabs) 
