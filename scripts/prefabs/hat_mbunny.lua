local assets=
{
	Asset("ANIM", "anim/hat_mbunny.zip"),
	Asset("ANIM", "anim/hat_mbunny2.zip"),
  Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
  Asset("IMAGE", "images/inventoryimages/hat_mbunny.tex")
}
--------------growable

local function levelexp(inst,data)

	local max_exp = 4100
	local exp = math.min(inst.level, max_exp)

if inst.level >= 4005 then

end
if inst.level >=0 and inst.level <10 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/10")
elseif inst.level >=10 and inst.level <30 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/30")
elseif inst.level >=30 and inst.level <50 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/50")
elseif inst.level >=50 and inst.level <70 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/70")
elseif inst.level >=70 and inst.level <90 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/90")
elseif inst.level >=90 and inst.level <120 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/120")
elseif inst.level >=120 and inst.level <150 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/150")
elseif inst.level >=150 and inst.level <180 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/180")
elseif inst.level >=180 and inst.level <210 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/210")
elseif inst.level >=210 and inst.level <250 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/250")
elseif inst.level >=250 and inst.level <350 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/350")
elseif inst.level >=350 and inst.level <450 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/450")
elseif inst.level >=450 and inst.level <550 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/550")
elseif inst.level >=550 and inst.level <650 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/650")
elseif inst.level >=650 and inst.level <750 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/750")
elseif inst.level >=750 and inst.level <850 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/850")
elseif inst.level >=850 and inst.level <950 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/950")
elseif inst.level >=950 and inst.level <1050 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1050")
elseif inst.level >=1050 and inst.level <1200 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1200")
elseif inst.level >=1200 and inst.level <1400 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1400")
elseif inst.level >=1400 and inst.level <1600 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1600")
elseif inst.level >=1600 and inst.level <1800 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/1800")
elseif inst.level >=1800 and inst.level <2000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2000")
elseif inst.level >=2000 and inst.level <2200 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2200")
elseif inst.level >=2200 and inst.level <2400 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2400")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2600")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/2800")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/3000")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/4000")
elseif inst.level >=4000 and inst.level <4005 then
inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n[MAX]")
end
end

local function onpreload(inst, data)
	if data then
		if data.level then
		inst.level = data.level
			levelexp(inst)
		end
		if data.goggles_on then
		inst.goggles_on = data.goggles_on
		end
	end
end
		
local function onsave(inst, data)
	data.level = inst.level
	data.goggles_on = inst.goggles_on
end
---------------------------------------
local function UpgradeArmor(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
   inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0)
inst.components.talker:Say(STRINGS.MUSHA_HAT_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.." (0)\n"..STRINGS.MUSHA_ITEM_DUR.." (0)")
            inst.components.fueled:StopConsuming()   
			    if inst.task then inst.task:Cancel() inst.task = nil end
   end

if not inst.broken and not inst.boost then
   if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.11)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV1)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(11)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.12)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV2)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(12)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.13)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV3)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(13)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.14)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV4)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(14)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition( 99999999999999999999999999999999999999999999999999, 0.15)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV5)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(15)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.16)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV6)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(16)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.17)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05 
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV7)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(17)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.18)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV8)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(18)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.19)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.05
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV9)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(5)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(19)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition( 99999999999999999999999999999999999999999999999999, 0.20)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV10)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(20)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.21)
     inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV11)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(21)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.22)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV12)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(22)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.23)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV13)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(23)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.24)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV14)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(24)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.25)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV15)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(25)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition( 99999999999999999999999999999999999999999999999999, 0.26)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV16)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(26)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.27)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV17)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(27)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.28)
     inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV18)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(28)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.29)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.08
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV19)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(8)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(29)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.30)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV20)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(30)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.32)
      inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV21)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(32)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.34)
      inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV22)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(34)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.36)
      inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV23)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(36)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.38)
      inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV24)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(38)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.40)
      inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV25)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(40)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.42)
     inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV26)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(42)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.44)
     inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV27)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(44)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.46)
     inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV28)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(46)")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.48)
     inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.12
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV29)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(12)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(48)")
elseif inst.level >=4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.50)
     inst.components.insulator.insulation = (TUNING.INSULATION_MED * 2)
    inst.components.equippable.walkspeedmult = 1.15
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV30)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(15)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Great)\n"..STRINGS.MUSHA_ARMOR.."(50)")
end
elseif not inst.broken and inst.boost then
  if inst.level >=0 and inst.level <10 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.11)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.2
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV1)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(20)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(11)")
  elseif inst.level >=10 and inst.level <30 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.12)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.2
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV2)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(20)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(12)")
 elseif inst.level >=30 and inst.level <50 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.13)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.2
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV3)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(20)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(13)")
 elseif inst.level >=50 and inst.level <70 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.14)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.2
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV4)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(20)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(14)")
  elseif inst.level >=70 and inst.level <90 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.15)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV5)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(15)")
 elseif inst.level >=90 and inst.level <120 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.16)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV6)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(16)")
 elseif inst.level >=120 and inst.level <150 then
  inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.17)
      inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV7)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(17)")
elseif inst.level >=150 and inst.level <180 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.18)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV8)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(18)")
elseif inst.level >=180 and inst.level <210 then
inst.components.armor:InitCondition(
99999999999999999999999999999999999999999999999999, 0.19)
    inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV9)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Small)\n"..STRINGS.MUSHA_ARMOR.."(19)")
elseif inst.level >=210 and inst.level <250 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.20)
     inst.components.insulator.insulation = TUNING.INSULATION_SMALL
    inst.components.equippable.walkspeedmult = 1.25
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV10)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(25)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(20)")
elseif inst.level >=250 and inst.level <350 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.21)
     inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.3
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV11)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(30)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(21)")
elseif inst.level >=350 and inst.level <450 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.22)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.3
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV12)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(30)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(22)")
elseif inst.level >=450 and inst.level <550 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.23)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.3
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV13)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(30)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(23)")
elseif inst.level >=550 and inst.level <650 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.24)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.3
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV14)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(30)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(24)")
elseif inst.level >=650 and inst.level <750 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.25)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.3
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV15)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(30)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(25)")
elseif inst.level >=750 and inst.level <850 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.26)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.35
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV16)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(35)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(26)")
elseif inst.level >=850 and inst.level <950 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.27)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.35
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV17)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(35)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(27)")
elseif inst.level >=950 and inst.level <1050 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.28)
     inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.35
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV18)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(35)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(28)")
elseif inst.level >=1050 and inst.level <1200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.29)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.35
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV19)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(35)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(29)")
elseif inst.level >=1200 and inst.level <1400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.30)
      inst.components.insulator.insulation = TUNING.INSULATION_MED
    inst.components.equippable.walkspeedmult = 1.35
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV20)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(35)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(30)")
elseif inst.level >=1400 and inst.level <1600 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.32)
       inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.4
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV21)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(40)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(32)")
elseif inst.level >=1600 and inst.level <1800 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.34)
        inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.4
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV22)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(40)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(34)")
elseif inst.level >=1800 and inst.level <2000 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.36)
        inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.4
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV23)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(40)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(36)")
elseif inst.level >=2000 and inst.level <2200 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.38)
        inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.4
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV24)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(40)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(38)")
elseif inst.level >=2200 and inst.level <2400 then
 inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.40)
        inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.45
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV25)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(45)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(40)")
elseif inst.level >=2400 and inst.level <2600 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.42)
       inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.45
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV26)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(45)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(42)")
elseif inst.level >=2600 and inst.level <2800 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.44)
       inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.45
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV27)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(45)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(44)")
elseif inst.level >=2800 and inst.level <3000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.46)
       inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.45
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV28)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(45)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(46)")
elseif inst.level >=3000 and inst.level <4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.48)
       inst.components.insulator.insulation = (TUNING.INSULATION_MED)
    inst.components.equippable.walkspeedmult = 1.45
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV29)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(45)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(MED)\n"..STRINGS.MUSHA_ARMOR.."(48)")
elseif inst.level >=4000 then
inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.50)
       inst.components.insulator.insulation = (TUNING.INSULATION_LARGE * 2)
    inst.components.equippable.walkspeedmult = 1.5
inst.components.talker:Say("["..STRINGS.MUSHA_HAT_BUNNY.."(LV30)]\n"..STRINGS.MUSHA_ITEM_SPEED.."(50)\n"..STRINGS.MUSHA_ITEM_WARMNCOOL.."(Large)\n"..STRINGS.MUSHA_ARMOR.."(50)")
end
end
end

local function OnDurability(inst, data)
inst.broken = true
 	UpgradeArmor(inst)
	inst.components.fueled:StopConsuming()        
 end
 
 local function ChangeInsulation(inst)
if TheWorld.state.issummer then
    inst.components.insulator:SetSummer()
elseif not TheWorld.state.issummer then
 	inst.components.insulator:SetWinter()
    end end	
	
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
	inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(2)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
    elseif  math.random() < expchance2 and inst.level <= 4600 then
	inst.level = inst.level + 5
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(5)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
	elseif  math.random() < expchance3 and inst.level <= 4600 then
	inst.level = inst.level + 8
	levelexp(inst)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_BUNNY.." \n"..STRINGS.MUSHA_ITEM_LUCKY.." +(8)\n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]".. (inst.level))
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

local function consume(inst, owner)
if not inst.broken and inst.boost then
inst.components.fueled:DoDelta(-30000)
end
if inst.broken and inst.boost then
inst.components.fueled:DoDelta(0)
end
if not inst.boost then
inst.components.fueled:DoDelta(0)
end
end

local function Gogglesoff(inst, data, owner)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then
inst.boost = false

	if inst:HasTag("goggles") then
	inst:RemoveTag("goggles")
	end

	if inst.broken then
	owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_BROKEN.."\n"..STRINGS.MUSHA_ITEM_DUR.." (0)\n"..STRINGS.MUSHA_ITEM_SPEED.."(0)")
    inst.components.equippable.walkspeedmult = 1
	end
	
	if inst.task ~= nil then inst.task:Cancel() inst.task = nil end
	
		UpgradeArmor(inst)
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
		
	if owner.goggle_musha then
	owner.goggle_musha = false
			owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
			owner:DoTaskInTime(0, function()  
			owner.components.inventory:Equip(inst) 
			end)
	end			
		
end
end

local function Goggleson(inst, data, owner)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then 
ChangeInsulation(inst)
if inst.broken then
	inst.boost = false 
		  
	owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
	inst.components.talker:Say(STRINGS.MUSHA_HAT_BROKEN.."\n"..STRINGS.MUSHA_ITEM_DUR.." (0)\n"..STRINGS.MUSHA_ITEM_SPEED.."(0)")
    inst.components.equippable.walkspeedmult = 1
        
elseif not inst.broken and not inst.boost then
	inst.boost = true 
	owner.goggle_musha = true
		if not inst:HasTag("goggles") then
		inst:AddTag("goggles")
		end
			owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
			owner:DoTaskInTime(0, function()  
			owner.components.inventory:Equip(inst) 
			end)
end


if inst.boost then


		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny2", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
	
	
    inst.task = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
 
		UpgradeArmor(inst)
    end

end
end

local function onunequip(inst, owner)
		if not owner.goggle_musha then
		inst:RemoveTag("goggles")
		end
		
	inst.boost = false 
	 UpgradeArmor(inst)
	
	inst.components.fueled:StopConsuming()        
    inst:RemoveEventCallback("attacked", inst.expfn, owner)
    if inst.task then inst.task:Cancel() inst.task = nil end

        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

    end
local function onequip(inst, owner)
local owner = inst.components.inventoryitem.owner
if owner ~= nil then
	if not inst.share_item and not owner:HasTag("musha") and owner.components.inventory then
         owner.components.inventory:Unequip(EQUIPSLOTS.HEAD, true)
		owner:DoTaskInTime(0.5, function()  owner.components.inventory:DropItem(inst) end)
	end
	
	inst.components.fueled:StartConsuming()

	if owner.goggle_musha then
	inst.boost = true
	Goggleson(inst)
	end
	
	ChangeInsulation(inst)	

	if not inst.boost then
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
	elseif inst.boost then	
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny2", "swap_hat")
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

    inst:ListenForEvent("attacked", inst.expfn, owner)

end
end

---------------hat fn sim
	
local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

     MakeInventoryPhysics(inst)  
   
    inst:AddTag("hat")
	inst:AddTag("musha_items")
	
	if inst.goggles_on then
	inst:AddTag("goggles")
	end
 
     inst.AnimState:SetBank("beehat")
     inst.AnimState:SetBuild("hat_mbunny")
     inst.AnimState:PlayAnimation("anim")    
      		inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "hat_mbunny.tex") 	
		
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.8, 1, 0.65, 1)
    inst.components.talker.offset = Vector3(0,-500,0)
    inst.components.talker.symbol = "swap_object"
	
	local swap_data = {bank = "beehat", anim = "anim"}
	MakeInventoryFloatable(inst)
        inst.components.floater:SetBankSwapOnFloat(false, nil, swap_data)
		
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
		end		
		
    inst:AddComponent("inspectable")
    	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mbunny.xml"

    inst:AddComponent("armor")
	inst.components.armor:InitCondition(99999999999999999999999999999999999999999999999999, 0.11)

	inst:AddComponent("machine")
    inst.components.machine.turnonfn = Goggleson
    inst.components.machine.turnofffn = Gogglesoff
    inst.components.machine.cooldowntime = 1

            inst:AddComponent("useableitem")
		inst.components.useableitem:SetOnUseFn(Goggleson)
        inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable:SetOnEquip( onequip )
        inst.components.equippable:SetOnUnequip( onunequip )

        inst:AddComponent("insulator")
	inst.boost = false 
	inst.level = 0
	inst:ListenForEvent("levelup", levelexp)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.check_level = levelexp
	
        inst:AddComponent("fueled")
       inst.components.fueled.fueltype = "CHEMICAL"
        inst.components.fueled:InitializeFuelLevel(25000000)
       inst.components.fueled:SetDepletedFn(OnDurability)
        inst.components.fueled.ontakefuelfn = TakeItem
        inst.components.fueled.accepting = true
		inst.components.fueled:StopConsuming()


    return inst
end
---------------------------------
return Prefab( "common/inventory/hat_mbunny", fn, assets ) 
