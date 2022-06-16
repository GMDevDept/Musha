local assets=
{
	Asset("ANIM", "anim/hat_mphoenix.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mphoenix.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mphoenix.tex")
}


---------------------------
--------------growable

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then

end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n[MAX]")
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

local function health(inst, owner)
     if (owner.components.health and owner.components.health:IsHurt())then
        owner.components.health:DoDelta(1,false)
end
end

local function consume(inst, owner)
if not inst.broken and inst.boost then
inst.components.fueled:DoDelta(-15000)
end
if inst.broken and inst.boost then
inst.components.fueled:DoDelta(0)
end
end

local function UpgradeArmor(inst, data, owner)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
 inst.components.fueled:StopConsuming()        
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0)
inst.components.talker:Say(STRINGS.MUSHA_HAT_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.." (0)\n"..STRINGS.MUSHA_ITEM_DUR.." (0)")
elseif not inst.broken and not inst.boost then
 
 if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.65)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV1)]\n"..STRINGS.MUSHA_ARMOR.."(65)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
  inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.66)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV2)]\n"..STRINGS.MUSHA_ARMOR.."(66)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.67)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV3)]\n"..STRINGS.MUSHA_ARMOR.."(67)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.68)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV4)]\n"..STRINGS.MUSHA_ARMOR.."(68)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.69)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV5)]\n"..STRINGS.MUSHA_ARMOR.."(69)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.70)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV6)]\n"..STRINGS.MUSHA_ARMOR.."(70)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
 elseif inst.level >=120 and inst.level <150 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.71)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV7)]\n"..STRINGS.MUSHA_ARMOR.."(71)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.72)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV8)]\n"..STRINGS.MUSHA_ARMOR.."(72)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.58)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV9)]\n"..STRINGS.MUSHA_ARMOR.."(73)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.74)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV10)]\n"..STRINGS.MUSHA_ARMOR.."(74)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(2)")
 inst.components.equippable.walkspeedmult = 1.02  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.75)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV11)]\n"..STRINGS.MUSHA_ARMOR.."(75)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.76)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV12)]\n"..STRINGS.MUSHA_ARMOR.."(76)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.77)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV13)]\n"..STRINGS.MUSHA_ARMOR.."(77)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.78)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV14)]\n"..STRINGS.MUSHA_ARMOR.."(78)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.79)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV15)]\n"..STRINGS.MUSHA_ARMOR.."(79)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.80)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV16)]\n"..STRINGS.MUSHA_ARMOR.."(80)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.81)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV17)]\n"..STRINGS.MUSHA_ARMOR.."(81)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.82)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV18)]\n"..STRINGS.MUSHA_ARMOR.."(82)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.83)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV19)]\n"..STRINGS.MUSHA_ARMOR.."(83)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.84)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV20)]\n"..STRINGS.MUSHA_ARMOR.."(84)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)")
 inst.components.equippable.walkspeedmult = 1.05 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.85)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV21)]\n"..STRINGS.MUSHA_ARMOR.."(85)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.86)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV22)]\n"..STRINGS.MUSHA_ARMOR.."(86)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.87)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV23)]\n"..STRINGS.MUSHA_ARMOR.."(87)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.88)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV24)]\n"..STRINGS.MUSHA_ARMOR.."(88)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.89)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV25)]\n"..STRINGS.MUSHA_ARMOR.."(89)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.90)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV26)]\n"..STRINGS.MUSHA_ARMOR.."(90)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.91)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV27)]\n"..STRINGS.MUSHA_ARMOR.."(91)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.92)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV28)]\n"..STRINGS.MUSHA_ARMOR.."(92)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.93)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV29)]\n"..STRINGS.MUSHA_ARMOR.."(93)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)")
 inst.components.equippable.walkspeedmult = 1.08 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
elseif inst.level >=4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.94)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV30)]\n"..STRINGS.MUSHA_ARMOR.."(94)\n"..STRINGS.MUSHA_ITEM_WARM.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED.."(10)")
 inst.components.equippable.walkspeedmult = 1.1 inst.components.equippable.dapperness = 0    inst.components.insulator.insulation = TUNING.INSULATION_MED
end
	elseif not inst.broken and inst.boost then
		
 if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.65)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV1)]\n"..STRINGS.MUSHA_ARMOR.."(65)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
  inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED   inst.components.insulator.insulation = TUNING.INSULATION_LARGE
   elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.66)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV2)]\n"..STRINGS.MUSHA_ARMOR.."(66)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.67)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV3)]\n"..STRINGS.MUSHA_ARMOR.."(67)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.68)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV4)]\n"..STRINGS.MUSHA_ARMOR.."(68)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.69)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV5)]\n"..STRINGS.MUSHA_ARMOR.."(69)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.70)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV6)]\n"..STRINGS.MUSHA_ARMOR.."(70)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
 elseif inst.level >=120 and inst.level <150 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.71)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV7)]\n"..STRINGS.MUSHA_ARMOR.."(71)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.72)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV8)]\n"..STRINGS.MUSHA_ARMOR.."(72)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.58)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV9)]\n"..STRINGS.MUSHA_ARMOR.."(73)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(MED)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.74)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV10)]\n"..STRINGS.MUSHA_ARMOR.."(74)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(20)")
 inst.components.equippable.walkspeedmult = 0.8  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.75)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV11)]\n"..STRINGS.MUSHA_ARMOR.."(75)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.76)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV12)]\n"..STRINGS.MUSHA_ARMOR.."(76)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.77)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV13)]\n"..STRINGS.MUSHA_ARMOR.."(77)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.78)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV14)]\n"..STRINGS.MUSHA_ARMOR.."(78)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.79)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV15)]\n"..STRINGS.MUSHA_ARMOR.."(79)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.80)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV16)]\n"..STRINGS.MUSHA_ARMOR.."(80)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.81)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV17)]\n"..STRINGS.MUSHA_ARMOR.."(81)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.82)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV18)]\n"..STRINGS.MUSHA_ARMOR.."(82)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.83)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV19)]\n"..STRINGS.MUSHA_ARMOR.."(83)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.84)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV20)]\n"..STRINGS.MUSHA_ARMOR.."(84)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(15)")
 inst.components.equippable.walkspeedmult = 0.85  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.85)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV21)]\n"..STRINGS.MUSHA_ARMOR.."(85)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.86)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV22)]\n"..STRINGS.MUSHA_ARMOR.."(86)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.87)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV23)]\n"..STRINGS.MUSHA_ARMOR.."(87)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.88)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV24)]\n"..STRINGS.MUSHA_ARMOR.."(88)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.89)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV25)]\n"..STRINGS.MUSHA_ARMOR.."(89)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.90)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV26)]\n"..STRINGS.MUSHA_ARMOR.."(90)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.91)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV27)]\n"..STRINGS.MUSHA_ARMOR.."(91)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.92)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV28)]\n"..STRINGS.MUSHA_ARMOR.."(92)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.93)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV29)]\n"..STRINGS.MUSHA_ARMOR.."(93)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(10)")
 inst.components.equippable.walkspeedmult = 0.9  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
elseif inst.level >=4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.94)
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_PHOENIX.."(LV30)]\n"..STRINGS.MUSHA_ARMOR.."(94)\n"..STRINGS.MUSHA_ITEM_WARM.."(Large)\n"..STRINGS.MUSHA_ITEM_REGEN.."(2)\n"..STRINGS.MUSHA_ITEM_SANITY_REGEN.."(Large)\n"..STRINGS.MUSHA_ITEM_SPEED_DOWN.."(5)")
 inst.components.equippable.walkspeedmult = 0.95  inst.components.equippable.dapperness = TUNING.DAPPERNESS_LARGE    inst.components.insulator.insulation = TUNING.INSULATION_LARGE
end
end end

local function OnDurability(inst, data)
inst.broken = true
 	UpgradeArmor(inst)
	inst.components.fueled:StopConsuming()    
 if inst.consume then inst.consume:Cancel() inst.consume = nil end    
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
	inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4600 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4600 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_PHOENIX.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(8)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
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

local function OnLoad(inst, data)
    UpgradeArmor(inst)
end

local function onequip(inst, owner)
	if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
                owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end

inst.components.fueled:StartConsuming()        
	if inst.boost then
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
	elseif not inst.boost then
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix2", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
     end
	UpgradeArmor(inst)
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
		 
    inst.gasfn = function(attacked, data)
local other = data.attacker 
    if data and data.attacker and data.attacker.components.sleeper and inst.boost then
            data.attacker.components.sleeper:AddSleepiness(5, 24)
	SpawnPrefab("small_puff").Transform:SetPosition(other:GetPosition():Get())
       end end
    inst:ListenForEvent("attacked", inst.gasfn, owner)
		   inst:ListenForEvent("attacked", inst.expfn, owner)
	end	
	

local function onunequip(inst, owner)
inst.components.fueled:StopConsuming()  
	UpgradeArmor(inst)      
	inst.boost = false 
	if inst.task then inst.task:Cancel() inst.task = nil end
	if inst.health then inst.health:Cancel() inst.health = nil end	
    inst:RemoveEventCallback("attacked", inst.gasfn, owner)
    inst:RemoveEventCallback("attacked", inst.expfn, owner)
	if owner ~= nil then
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")
	end
end

local function maskoff(inst, owner)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then
inst.boost = false 
UpgradeArmor(inst)	
	
	if inst.task then inst.task:Cancel() inst.task = nil end
	if inst.health then inst.health:Cancel() inst.health = nil end	
	
    inst:RemoveEventCallback("attacked", inst.gasfn, owner)
    inst:RemoveEventCallback("attacked", inst.expfn, owner)
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix2", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")

end
end

local function maskon(inst, data, owner)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then 
if owner and not inst.boost then
    inst.task = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
    inst.health = inst:DoPeriodicTask(6, function() health(inst, owner) end)
	inst.boost = true 
	UpgradeArmor(inst)
	
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
end
end
end
	
local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

     MakeInventoryPhysics(inst)  
   inst:AddTag("waterproofer")
    inst:AddTag("hat")
	 inst:AddTag("musha_items")
	inst:AddTag("metal")
        inst.AnimState:SetBank("beehat")
        inst.AnimState:SetBuild("hat_mphoenix")
        inst.AnimState:PlayAnimation("anim")
        		inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "hat_mphoenix.tex") 	 

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 0.8, 0.65, 1)
    inst.components.talker.offset = Vector3(0,-500,0)
    inst.components.talker.symbol = "swap_object"
	
	inst:AddComponent("floater")
	inst.components.floater:SetSize("med")
    inst.components.floater:SetScale(0.68)
		
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
		end		
		
    inst:AddComponent("inspectable")
    	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mphoenix.xml"

	inst:AddComponent("machine")
    inst.components.machine.turnonfn = maskon
    inst.components.machine.turnofffn = maskoff
    inst.components.machine.cooldowntime = 1
	
     inst:AddComponent("useableitem")
     inst.components.useableitem:SetOnUseFn(maskon)
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
    inst:AddComponent("armor")
	inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.65)
        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable:SetOnEquip( onequip )
        inst.components.equippable:SetOnUnequip( onunequip )
	inst.boost = false 

    inst.OnLoad = OnLoad

     inst:AddComponent("insulator")
 
        inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
       inst.components.fueled:InitializeFuelLevel(32000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
inst.components.fueled:StartConsuming()        

	inst.level = 0
inst:ListenForEvent("levelup", levelexp)
inst.check_level = levelexp
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mphoenix", fn, assets) 
