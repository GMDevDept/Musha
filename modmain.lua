-----------
local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
local Vector3 = GLOBAL.Vector3
TECH = GLOBAL.TECH
local IsServer = GLOBAL.TheNet:GetIsServer()
local containers = require("containers")

ACTIONS.GIVE.priority = 2
ACTIONS.ADDFUEL.priority = 4
ACTIONS.USEITEM.priority = 3

local ThePlayer = GLOBAL.ThePlayer
-----------
local TheInput = GLOBAL.TheInput
-----------sleep--------
local Badge_type = GetModConfigData("badge_type")
local Difficult = GetModConfigData("difficultover")
local DifficultHealth = GetModConfigData("difficulthealth")
local DifficultDamage = GetModConfigData("difficultdamage")
local DifficultDamage_Range = GetModConfigData("difficultdamage_range")
local DifficultSanity = GetModConfigData("difficultsanity")
local death_penalty = GetModConfigData("deathPenalty")
local Loud_Lightning = GetModConfigData("loudlightning")
--local Difficult_Recipe = GetModConfigData("difficultrecipe")
--local Gem_Recipe = GetModConfigData("craftgems")
local avisual_Musha = GetModConfigData("avisual_musha")
local avisual_Princess = GetModConfigData("avisual_princess")
local avisual_Pirate = GetModConfigData("avisual_pirate")
local avisual_Pirate_Armor = GetModConfigData("avisual_pirate_armor")
local butterfly_shield = GetModConfigData("on_butterfly_shield")
local moontree_stop = GetModConfigData("stop_spawning")
local frostblade3rd = GetModConfigData("frostblade3rd")
--local extra_backpack = GetModConfigData("extrabackpack")
--local Smart = GetModConfigData("smartmusha")
local Diet = GetModConfigData("dietmusha")
local Dislike = GetModConfigData("favoritemusha")
local PuppyPrincess = GetModConfigData("princess_taste")
local Dtired = GetModConfigData("difficulttired")
local Dsleep = GetModConfigData("difficultsleep")
local Dmusic = GetModConfigData("difficultmusic")
local Dsniff = GetModConfigData("difficultysniff")
local Dmana = GetModConfigData("difficultmana")
local bodyguard_wilson = GetModConfigData("bodyguardwilson")
--local share_item = GetModConfigData("shareitems")
--local in_container =  GetModConfigData("incontainer")
--local musha_in_container =  GetModConfigData("musha_incontainer")
local Mod_language =  GetModConfigData("modlanguage")

local Widget = require("widgets/widget")
local Image = require("widgets/image")
local Text = require("widgets/text")
local PlayerBadge = require("widgets/playerbadge")
local Badge = require("widgets/badge")


modimport("libs/env.lua")
-----------specific
--use "data/actions/pickup"
--use "data/components/inits"

modimport("scripts/prefabasset.lua")
modimport("scripts/musha_adds_recipe.lua")
-----------
--translation

if Mod_language == "auto" then
	
	--ENG
	 KOR = 0
	 CHA = 0
	 RUS = 0
	
	for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
	local language = GLOBAL.KnownModIndex:GetModInfo(moddir).name
	if language == "한글 모드 서버 버전" or language == "한글 모드 클라이언트 버전" or language == "굶지마 다함께 한글화 [서버 버전]" or language == "굶지마 다함께 한글화 [클라이언트 버전]" then 
	KOR = 1
	elseif language == "Chinese Language Pack" or language == "Chinese Plus" then
	CHA = 1
	elseif language == "Russian Language Pack" or language == "Russification Pack for DST" or language == "Russian For Mods (Client)" then
	RUS = 1
	end 
	end  

	if KOR == 1 then
	modimport("scripts/strings_musha_ko.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_ko"
	elseif CHA == 1 then
	modimport("scripts/strings_musha_cn.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_cn"
	elseif RUS == 1 then
	modimport("scripts/strings_musha_ru.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_ru"
	else
	modimport("scripts/strings_musha_en.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_en"
	end

elseif Mod_language == "korean" then
	modimport("scripts/strings_musha_ko.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_ko"
elseif Mod_language == "chinese" then
	modimport("scripts/strings_musha_cn.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_cn"
elseif Mod_language == "russian" then
	modimport("scripts/strings_musha_ru.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_ru"
elseif Mod_language == "english" then
	modimport("scripts/strings_musha_en.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_en"	

end

modimport("scripts/musha_adds_states.lua")

modimport("scripts/musha_adds_actions.lua")

modimport("scripts/musha_adds_container.lua")

--bodyguard wilson
function bodyguardwilson(inst)
if IsServer then
  if bodyguard_wilson == 1 then
	inst.no_bodyguard = true
 end end
end
AddPrefabPostInit("musha", bodyguardwilson)


function exp_type_meat(inst)
if IsServer then
inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
	
	
end end
 function exp_type_veggie(inst)
if IsServer then
inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.VEGGIE
end end
	
function musha_princess_taste(inst)
if IsServer then
inst.princess_taste = true
end end	
if PuppyPrincess == "princess" then
AddPrefabPostInit("musha", musha_princess_taste)
end

function musha_dis_meat(inst)
if IsServer then
inst.dis_meat_taste = true
end end
function musha_dis_veggie(inst)
if IsServer then
inst.dis_veggie_taste = true
end end
function musha_normal(inst)
if IsServer then
inst.normal_taste = true
end end
function musha_meat(inst)
if IsServer then
inst.meat_taste = true
end end
function musha_veggie(inst)
if IsServer then
inst.veggie_taste = true
end end



if Dislike == "dis_meat" then
AddPrefabPostInit("musha", musha_dis_meat)
end
if Dislike == "dis_veggie" then
AddPrefabPostInit("musha", musha_dis_veggie)
end

if Diet == "normal" then
AddPrefabPostInit("musha", musha_normal)
end
if Diet == "meat" then
AddPrefabPostInit("musha", musha_meat)
--AddPrefabPostInit("exp", exp_type_meat)
end
if Diet == "veggie" then
AddPrefabPostInit("musha", musha_veggie)
--AddPrefabPostInit("exp", exp_type_veggie)
end


function tentacle_arm(inst)
if IsServer then
inst:AddTag("no_exp")
end end
AddPrefabPostInit("tentacle_pillar_arm", tentacle_arm)

function yamche_blue(inst)
if IsServer then
inst:AddTag("icecream")
end  end
AddPrefabPostInit("icecream", yamche_blue)
--end
--AddPrefabPostInit("musha", rockss)
--elemental
local function elemental( inst )
inst:AddComponent("fuel")
inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
--inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
inst.components.fuel.fueltype = "CHEMICAL"
inst:AddTag("elements")
end
local function elemental_ore( inst )
inst:AddComponent("fuel")
inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
inst.components.fuel.fueltype = "CHEMICAL"
inst:AddTag("elements")
end
local function elemental_gold( inst )
inst:AddComponent("fuel")
inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
inst.components.fuel.fueltype = "CHEMICAL"
inst:AddTag("elements")
end

AddPrefabPostInit("goldnugget",elemental_gold)
AddPrefabPostInit("thulecite",elemental_gold)
AddPrefabPostInit("rocks",elemental_ore)
AddPrefabPostInit("flint",elemental_ore)
AddPrefabPostInit("marble",elemental_ore)
AddPrefabPostInit("moonrocknugget",elemental_ore)
AddPrefabPostInit("thulecite_pieces",elemental_ore)
AddPrefabPostInit("boneshard",elemental_ore)
AddPrefabPostInit("stinger",elemental)
AddPrefabPostInit("spidergland",elemental)
AddPrefabPostInit("houndstooth",elemental)
AddPrefabPostInit("snakeskin",elemental)
AddPrefabPostInit("slurtle_shellpieces",elemental)
AddPrefabPostInit("silk",elemental)

local function musha_wildness(inst)
if inst:HasTag("musha") then
if not inst.ghostenabled then
	inst.yamche_egg_hunted = true
end end
end
AddPrefabPostInit("musha",musha_wildness)

modimport("scripts/mypower_musha_1.lua")
modimport("scripts/widgets/spellpower_statusdisplays.lua")
modimport("scripts/widgets/fatigue_sleep_statusdisplays.lua")
modimport("scripts/widgets/stamina_sleep_statusdisplays.lua")
modimport("scripts/difficulty_monster_dst.lua")

--active key
-- Import the lib use.
modimport("libs/use.lua")

-- Import the mod environment as our environment.
use "libs/mod_env"(env)
-- Imports to keep the keyhandler from working while typing in chat.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
local MushaCommands = GLOBAL.require("usercommands")

GLOBAL.TUNING.MUSHA = {}
GLOBAL.TUNING.MUSHA.KEY = GetModConfigData("key") or 108  --L
GLOBAL.TUNING.MUSHA.KEY2 = GetModConfigData("key2") or 114  --R
GLOBAL.TUNING.MUSHA.KEY3 = GetModConfigData("key3") or 99  --C
GLOBAL.TUNING.MUSHA.KEY4 = GetModConfigData("key4") or 120  --X  
GLOBAL.TUNING.MUSHA.KEY5 = GetModConfigData("key5") or 107  --K
GLOBAL.TUNING.MUSHA.KEY6 = GetModConfigData("key6") or 122  --Z
GLOBAL.TUNING.MUSHA.KEY7 = GetModConfigData("key7") or 112  --P
GLOBAL.TUNING.MUSHA.KEY15 = GetModConfigData("key15") or 111  --O
GLOBAL.TUNING.MUSHA.KEY8 = GetModConfigData("key8") or 118  --V
GLOBAL.TUNING.MUSHA.KEY9 = GetModConfigData("key9") or 98  --B
--GLOBAL.TUNING.MUSHA.KEY10 = GetModConfigData("key10") or 110  --N
GLOBAL.TUNING.MUSHA.KEY11 = GetModConfigData("key11") or 103  --G
GLOBAL.TUNING.MUSHA.KEY12 = GetModConfigData("key12") or 116  --T
GLOBAL.TUNING.MUSHA.KEY13 = GetModConfigData("key13") or 282  --F1
GLOBAL.TUNING.MUSHA.KEY14 = GetModConfigData("key14") or 283  --F2
GLOBAL.TUNING.MUSHA.KEY16 = GetModConfigData("key16") or 285  --F3


 function visual_back_musha(inst)
if avisual_Musha == "Bmm" then
inst.Bmm = true
elseif avisual_Musha == "BT" then
inst.BT = true
elseif avisual_Musha == "BS" then
inst.BS = true
elseif avisual_Musha == "BM" then
inst.BL = true
elseif avisual_Musha == "BL" then
inst.BL = true
elseif avisual_Musha == "WSP" then
inst.WSP = true
elseif avisual_Musha == "WSR" then
inst.WSR = true
elseif avisual_Musha == "WSB" then
inst.WSB = true
elseif avisual_Musha == "WSH" then
inst.WSH = true
elseif avisual_Musha == "WLR" then
inst.WLR = true
elseif avisual_Musha == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("armor_mushaa", visual_back_musha)

 function visual_back_princess(inst)
if avisual_Princess == "Bmm" then
inst.Bmm = true
elseif avisual_Princess == "BT" then
inst.BT = true
elseif avisual_Princess == "BS" then
inst.BS = true
elseif avisual_Princess == "BM" then
inst.BL = true
elseif avisual_Princess == "BL" then
inst.BL = true
elseif avisual_Princess == "WSP" then
inst.WSP = true
elseif avisual_Princess == "WSR" then
inst.WSR = true
elseif avisual_Princess == "WSB" then
inst.WSB = true
elseif avisual_Princess == "WSH" then
inst.WSH = true
elseif avisual_Princess == "WLR" then
inst.WLR = true
elseif avisual_Princess == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("armor_mushab", visual_back_princess)

 function visual_back_pirate(inst)
if avisual_Pirate == "Bmm" then
inst.Bmm = true
elseif avisual_Pirate == "BT" then
inst.BT = true
elseif avisual_Pirate == "BS" then
inst.BS = true
elseif avisual_Pirate == "BM" then
inst.BL = true
elseif avisual_Pirate == "BL" then
inst.BL = true
elseif avisual_Pirate == "WSP" then
inst.WSP = true
elseif avisual_Pirate == "WSR" then
inst.WSR = true
elseif avisual_Pirate == "WSB" then
inst.WSB = true
elseif avisual_Pirate == "WSH" then
inst.WSH = true
elseif avisual_Pirate == "WLR" then
inst.WLR = true
elseif avisual_Pirate == "WLB" then
inst.WLB = true
end
end
AddPrefabPostInit("pirateback", visual_back_pirate)


 function visual_armor_pirate(inst)
if avisual_Pirate_Armor == "pirate" then
inst.Pirate = true
elseif avisual_Pirate_Armor == "green" then
inst.Green = true
elseif avisual_Pirate_Armor == "pink" then
inst.Pink = true
elseif avisual_Pirate_Armor == "blue" then
inst.Blue = true
elseif avisual_Pirate_Armor == "chest" then
inst.Chest = true
end
end
AddPrefabPostInit("pirateback", visual_armor_pirate)


 function frostarmor_shield(inst)
if butterfly_shield == 2 then
inst.no_butterfly_shield = true

end
end
AddPrefabPostInit("broken_frosthammer", frostarmor_shield)

 function moontree_spawn(inst)

if moontree_stop == 2 then
inst.radius_spawning = true
end
if moontree_stop == 3 then
inst.stop_spawning = true

end
end
AddPrefabPostInit("moontree_musha", moontree_spawn)

 function frostblade_3rdbooster(inst)
if frostblade3rd == 2 then
inst.frostblade3rd_spear = true
end
if frostblade3rd == 3 then
inst.frostblade3rd_spear = true
inst.frostblade3rd_spear_range = true
end
end
AddPrefabPostInit("mushasword_frost", frostblade_3rdbooster)

---------------
 function on_yamcheinfo(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"yamche"})
for k,v in pairs(ents) do
if inst.components.leader:IsFollower(v) and v.components.follower.leader then 
v.yamcheinfo = true
end
end end
 function on_critterinfo(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"critter"})
for k,v in pairs(ents) do
if inst.components.leader:IsFollower(v) and v.components.follower.leader then 
v.yamcheinfo = true
end
end end
 function INFO(inst)
--Active info level?
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()

local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
local TheInput = TheInput
local max_exp = 999997000
local level = math.min(inst.level, max_exp)
	local max_stamina = 100
	local min_stamina = 0
	local max_fatigue = 100
	local min_fatigue = 0	
	local max_music = 100
	local min_music = 0	
	local max_treasure = 100
	local min_treasure = 0	
	local stamina_sleep = inst.components.stamina_sleep.current
	local fatigue_sleep = inst.components.fatigue_sleep.current
			local mx=math.floor(max_stamina-min_stamina)
			local cur=math.floor(stamina_sleep-min_stamina)
			local mx2=math.floor(max_fatigue-min_fatigue)
			local cur2=math.floor(fatigue_sleep-min_fatigue)
			local mxx=math.floor(max_music-min_music)
			local curr=math.floor(inst.music-min_music)
			local mxt=math.floor(max_treasure-min_treasure)
			local curt=math.floor(inst.treasure-min_treasure)
		
			sleep = ""..math.floor(cur*100/mx).."%"
			sleepy = ""..math.floor(cur2*100/mx2).."%"
			musics = ""..math.floor(curr*100/mxx).."%"
			treasures = ""..math.floor(curt*100/mxt).."%"
inst.keep_check = false			
if not inst.keep_check then		
inst.keep_check = true	
--inst.sg:AddStateTag("notalking")

inst.components.talker:Say("["..STRINGS.MUSHA_LEVEL_NEXT_LEVEL_UP.."] "..STRINGS.MUSHA_LEVEL_EXP..":" .. (inst.level) .."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
on_yamcheinfo(inst)
on_critterinfo(inst)
if inst.level <5 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "1 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 5".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=5 and inst.level <9  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "2 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 10".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=10 and inst.level <29  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "3 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 30".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=30 and inst.level <49  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "4 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 50".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=50 and inst.level <79  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "5 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 80".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=80 and inst.level <124  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "6 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 125".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=125 and inst.level <199  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "7 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 200".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=200 and inst.level <339  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "8 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 340".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=340 and inst.level <429  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "9 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 430".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=430 and inst.level <529  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "10 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 530".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=530 and inst.level <639  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "11 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 640".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=640 and inst.level <759  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "12 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 760".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=760 and inst.level <889  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "13 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 890".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=890 and inst.level <1029  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "14 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1030".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1030 and inst.level <1179  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "15 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1180".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1180 and inst.level <1339  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "16 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1340".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1340 and inst.level <1509  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "17 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1510".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1510 and inst.level <1689  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "18 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1690".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1690 and inst.level <1879  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "19 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 1880".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=1880 and inst.level <2079  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "20 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 2080".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=2080 and inst.level <2289  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "21 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 2289".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=2290 and inst.level <2499  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "22 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 2500".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=2500 and inst.level <2849  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "23 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 2850".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=2850 and inst.level <3199  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "24 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 3200".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=3200 and inst.level <3699  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "25 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 3700".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=3700 and inst.level <4199  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "26 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 4200".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=4200 and inst.level <4699  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "27 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 4700".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=4700 and inst.level <5499 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "28 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 5500".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=5500 and inst.level <6999 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "29 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/ 7000".."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
elseif inst.level >=7000  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "30 \n[MAX]\n Extra EXP ".. (inst.level -7000).."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	

end
elseif inst.keep_check then		
inst.keep_check = false	
--inst.components.talker:ShutUp()
--inst.sg:RemoveStateTag("notalking")
end
inst:DoTaskInTime( 0.5, function()
if inst.keep_check then
inst.keep_check = false
--inst.sg:RemoveStateTag("notalking") 
end end)
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end 
end
AddModRPCHandler("musha", "INFO", INFO)
-------------------------
-------------------------
--active skill?  --skill_info
 function INFO2(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
local TheInput = TheInput
local max_exp = 999997000
local level = math.min(inst.level, max_exp)
inst.keep_check = false			
if not inst.keep_check then		
inst.keep_check = true
--inst.sg:AddStateTag("notalking")
if inst.level >=0 and inst.level <=4 then --level[1]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[0/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[0/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[0/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[0/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[0/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >4 and inst.level <10 then --level[2]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[0/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[0/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[0/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[1/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[0/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >10 and inst.level <30  then --level[3]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[0/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[1/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[1/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[0/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=30 and inst.level <50  then --level[4]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[0/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[1/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[1/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=50 and inst.level <80  then --level[5]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[1/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[2/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[1/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=80 and inst.level <124  then --level[6]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[1/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[2/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[0/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[2/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=125 and inst.level <200  then --level[7]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[1/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[2/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[2/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=200 and inst.level <340  then --level[8]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[1/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[3/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[2/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=340 and inst.level <430  then --level[9]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[1/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[1/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[1/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[4/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[2/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=430 and inst.level <530  then --level[10]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[2/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[4/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[3/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[1/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=530 and inst.level <640  then --level[11]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[2/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[4/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[3/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[2/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=640 and inst.level <760  then --level[12]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[2/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[4/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[3/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[3/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=760 and inst.level <890  then --level[13]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[2/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[5/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[3/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[3/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=890 and inst.level <1030  then --level[14]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[2/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[6/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[3/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[3/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=1030 and inst.level <1180  then --level[15]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[3/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[6/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[3/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=1180 and inst.level <1340  then --level[16]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[3/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[6/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[4/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=1340 and inst.level <1510  then --level[17]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[3/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[7/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[4/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=1510 and inst.level <1690  then --level[18]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[3/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[8/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[1/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[4/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=1690 and inst.level <1880  then --level[19]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[2/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[2/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[3/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[8/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[2/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[4/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=1880 and inst.level <2080  then --level[20]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[4/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[8/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[2/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[4/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[5/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=2080 and inst.level <2290  then --level[21]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[4/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[8/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[2/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[5/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=2290 and inst.level <2500  then --level[22]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[4/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[9/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[2/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[5/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=2500 and inst.level <2850  then --level[23]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[4/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[10/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[2/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[5/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=2850 and inst.level <3200  then --level[24]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[4/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[10/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[5/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=3200 and inst.level <3700  then --level[25]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[5/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[10/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[6/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")
elseif inst.level >=3700 and inst.level <4200  then --level[26]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[5/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[11/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[6/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=4200 and inst.level <4700  then --level[27]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[5/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[11/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[7/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=4700 and inst.level <5500 then --level[28]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[5/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[12/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[7/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=5500 and inst.level <7000 then --level[29]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[3/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[3/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[5/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[13/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[7/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[0/1]")	
elseif inst.level >=7000  then --level[30]
inst.components.talker:Say(STRINGS.MUSHA_SKILL_ACTIVE.."\n[*]"..STRINGS.MUSHA_SKILL_SLEEP.."[1/1]-(T)\n[*]"..STRINGS.MUSHA_SKILL_POWER.."[4/4]-(R)\n[*]"..STRINGS.MUSHA_SKILL_SHIELD.."[4/4]-(C)\n[*]"..STRINGS.MUSHA_SKILL_MUSIC.."[1/1]-(X)\n[*]"..STRINGS.MUSHA_SKILL_SHADOW.."[6/6]-(G)\n"..STRINGS.MUSHA_SKILL_PASSIVE.."\n[*]"..STRINGS.MUSHA_SKILL_VALKYR.."[14/14] \n[*]"..STRINGS.MUSHA_SKILL_BERSERK.."[3/3] \n[*]"..STRINGS.MUSHA_SKILL_ELECTRA.."[5/5] \n[*]"..STRINGS.MUSHA_SKILL_CRITIC.."[7/7] \n[*]"..STRINGS.MUSHA_SKILL_DOUBLE.."[1/1]")	
end
elseif inst.keep_check then		
inst.keep_check = false	
--inst.components.talker:ShutUp()
--inst.sg:RemoveStateTag("notalking")
end
inst:DoTaskInTime( 0.5, function()
if inst.keep_check then
inst.keep_check = false
--inst.sg:RemoveStateTag("notalking") 
end end)
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end
end
AddModRPCHandler("musha", "INFO2", INFO2)

--active lightning strike
 function on_hitLightnings_9(inst, data)

local other = data.target
if not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") then
inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
inst.lightning_spell_cost = false
if other and other.components.health ~= nil and inst.level <=430  then
if inst.loud_1 or inst.loud_2 or inst.loud_3 then
SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
end
SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())

SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
local fx = SpawnPrefab("firering_fx")
	  fx.Transform:SetScale(0.6, 0.6, 0.6)
  	  fx.Transform:SetPosition(other:GetPosition():Get())
other.components.health:DoDelta(-40)
--inst.components.sanity:DoDelta(-5)
inst.components.combat:SetRange(2)
other.burn = false
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
end
inst.switch = false
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
if inst.frost and other.components.freezable then
other.components.freezable:AddColdness(1.5)
other.components.health:DoDelta(-5)
elseif inst.fire and other.components.burnable then
other.components.burnable:Ignite()
other.components.health:DoDelta(-15)
end
elseif other and other.components.health ~= nil and inst.level > 430 and inst.level <= 1880  then
if inst.loud_1 or inst.loud_2 or inst.loud_3 then
SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
end
SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
local fx = SpawnPrefab("firering_fx")
	  fx.Transform:SetScale(0.6, 0.6, 0.6)
  	  fx.Transform:SetPosition(other:GetPosition():Get())
other.components.health:DoDelta(-60)
--inst.components.sanity:DoDelta(-5)
inst.components.combat:SetRange(2)
other.burn = false
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
	if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
	end
inst.switch = false
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
if inst.frost and other.components.freezable then
other.components.freezable:AddColdness(2)
other.components.health:DoDelta(-10)
elseif inst.fire and other.components.burnable then
other.components.burnable:Ignite()
other.components.health:DoDelta(-30)
end
elseif other and other.components.health ~= nil and inst.level > 1880 and inst.level <= 6999  then
if inst.loud_1 or inst.loud_2 or inst.loud_3 then
SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
end
SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
local fx = SpawnPrefab("firering_fx")
	  fx.Transform:SetScale(0.6, 0.6, 0.6)
  	  fx.Transform:SetPosition(other:GetPosition():Get())
other.components.health:DoDelta(-80)
--inst.components.sanity:DoDelta(-5)
inst.components.combat:SetRange(2)
other.burn = false
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
	if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
	end
inst.switch = false  
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
if inst.frost and other.components.freezable then
other.components.freezable:AddColdness(2.5)
other.components.health:DoDelta(-15)
elseif inst.fire and other.components.burnable then
other.components.burnable:Ignite()
other.components.health:DoDelta(-45)
end
elseif other and other.components.health ~= nil and inst.level >= 7000  then
if inst.loud_1 or inst.loud_2 or inst.loud_3 then
SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
end
SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
local fx = SpawnPrefab("firering_fx")
	  fx.Transform:SetScale(0.6, 0.6, 0.6)
  	  fx.Transform:SetPosition(other:GetPosition():Get())
other.components.health:DoDelta(-100)
--inst.components.sanity:DoDelta(-5)
inst.components.combat:SetRange(2)
other.burn = false
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
	if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
	end
inst.switch = false  
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
if inst.frost and other.components.freezable then
other.components.freezable:AddColdness(3)
other.components.health:DoDelta(-20)
elseif inst.fire and other.components.burnable then
other.components.burnable:Ignite()
other.components.health:DoDelta(-60)
end
end 

--debuff with power lightning

if other:HasTag("burn") then
	other:DoTaskInTime(0.3, function() SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get()) 
	SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
	other:DoTaskInTime(0.4, function() SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get()) 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(other:GetPosition():Get())
	  end)
	
	other.slow = true 
			if not other:HasTag("slow") then
			other:AddTag("slow") 
			end

	other.burn = false other.bloom = false 
	other:RemoveTag("burn")
		if not other:HasTag("lightninggoat") then
		other.AnimState:SetBloomEffectHandle( "" ) 
		other.bloom = false 
		end
	

	if other:HasTag("slow") then
	
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(other:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		if not other.shocked then
		other.components.health:DoDelta(-25)
		elseif other.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
		other.components.health:DoDelta(-50)
		other.shocked = false
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(other:GetPosition():Get())
		if debuff and other:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
		if not other:HasTag("cavedweller") then
			follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(other.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if other:HasTag("slow") and not other.components.health:IsDead() then 
			other.components.health:DoDelta(-8)
			--other.components.combat:GetAttacked(inst, 8)
			
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if other.components.locomotor ~= nil then other.components.locomotor.groundspeedmultiplier = 1 other.slow = false other:RemoveTag("slow") debuff:Remove() end end)
	end
	end)
end

if other:HasTag("lightninggoat") and not other:HasTag("charged") then
--other.charged = true
--other:AddTag("charged")
end
--if other:HasTag("lightninggoat") then
--	other.sg:GoToState("shocked")
--end
--[[if other.components.freezable and other.components.freezable:IsFrozen() and other:HasTag("dragonfly") then
      inst:DoTaskInTime( 1.5, function()  other.components.freezable:Unfreeze() end)
end]]
if other.components.burnable and other.components.burnable:IsBurning() then
        other.components.burnable:Extinguish()
end

local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
weapon.components.weapon.stimuli = nil 
end
--[[local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"musha_items"})
for k,v in pairs(ents) do
if v.components.weapon then
v.components.weapon.stimuli = nil end
end]]
if inst.switch and inst.frosthammer2 then
    inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
    inst.AnimState:Show("ARM_carry") 
    inst.AnimState:Hide("ARM_normal") 
elseif not inst.switch and inst.frosthammer2 then
	inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    inst.AnimState:Show("ARM_carry") 
    inst.AnimState:Hide("ARM_normal") 
end
end
end
 
  function InShadow(inst, data)
if inst.sneaka then	
if inst.active_valkyrie or inst.switch then
inst.components.combat:SetRange(2)
inst.switch = false
end
local player = GLOBAL.ThePlayer
local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 12)
for k,v in pairs(ents) do
if v.components.health and not v.components.health:IsDead() and v.components.combat and v.components.combat.target == inst and not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly")) then
		v.components.combat.target = nil
 end
 end end
 end
--old book skill

 function Call_lightining_on(inst, data)

local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 12)
for k,v in pairs(ents) do	
	if v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and not v:HasTag("groundspike") and not v:HasTag("player") and not v:HasTag("stalkerminion") and not v:HasTag("yamche") and not v:HasTag("companion") and not inst.components.rider ~= nil and not inst.components.rider:IsRiding() and not inst.sg:HasStateTag("moving") and not inst.sg:HasStateTag("attack") and not v:HasTag("structure") and v.components.combat and (v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or v:HasTag("frog")) then		
			
	inst.components.locomotor:Stop()
if --[[inst.switch and inst.active_valkyrie and]] not inst.casting then 
----------------------------------------------------
--[[local fx_1 = SpawnPrefab("stalker_shield_musha")
	  fx_1.Transform:SetScale(0.5, 0.5, 0.5)
  	  fx_1.Transform:SetPosition(inst:GetPosition():Get())]]
	if not inst.casting then 
	inst.casting = true 
	if inst.components.spellpower then
	inst.components.spellpower:DoDelta(-10)
	end
	inst.sg:GoToState("book2") 
	end 
	
if inst.level < 430 then

	
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if inst.loud_2 or inst.loud_3 then
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
	
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
	local fx_2 = SpawnPrefab("groundpoundring_fx")
		fx_2.Transform:SetScale(0.4, 0.4, 0.4)
		fx_2.Transform:SetPosition(inst:GetPosition():Get())
	  
	v:DoTaskInTime(0.3, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.4, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(v:GetPosition():Get())
	  end)
		if v:HasTag("burn") then
			v.slow = true 
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		else	
		v.components.health:DoDelta(-10)
		--v.components.combat:GetAttacked(inst, 10)
			
		end
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
	v.burn = false v.bloom = false 
	v:RemoveTag("burn")
		if not v:HasTag("lightninggoat") then
		v.AnimState:SetBloomEffectHandle( "" ) 
		v.bloom = false 
		end
	

	if v:HasTag("slow") then
	
		--[[local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	]]
		
		if not v.shocked then
		v.components.health:DoDelta(-25)
		--v.components.combat:GetAttacked(inst, 20)
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-40)
		--v.components.combat:GetAttacked(inst, 40)
		
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		v.shocked = false
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
			if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and not v.components.health:IsDead() then 
			v.components.health:DoDelta(-2)
			--
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
	elseif not v:HasTag("slow")	then
	v:AddTag("burn")	
	end
	end)
	
elseif inst.level >= 430 and inst.level < 1880 then

	
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if inst.loud_2 or inst.loud_3 then
	
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
	
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
	local fx_2 = SpawnPrefab("groundpoundring_fx")
		fx_2.Transform:SetScale(0.4, 0.4, 0.4)
		fx_2.Transform:SetPosition(inst:GetPosition():Get())
	  
	v:DoTaskInTime(0.3, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.4, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(v:GetPosition():Get())
	  end)
		if v:HasTag("burn") then
			v.slow = true 
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		else	
		
		v.components.health:DoDelta(-15)
		--v.components.combat:GetAttacked(inst, 15)
		end
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
	v.burn = false v.bloom = false 
	v:RemoveTag("burn")
		if not v:HasTag("lightninggoat") then
		v.AnimState:SetBloomEffectHandle( "" ) 
		v.bloom = false 
		end
	

	if v:HasTag("slow") then
		
		if not v.shocked then
		v.components.health:DoDelta(-30)
		--v.components.combat:GetAttacked(inst, 30)
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-50)
		--v.components.combat:GetAttacked(inst, 50)
		
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		v.shocked = false
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
		if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and not v.components.health:IsDead() then 
			v.components.health:DoDelta(-4)
			--
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
	elseif not v:HasTag("slow")	then
	v:AddTag("burn")	
	end
	end)
	
elseif inst.level >= 1880 and inst.level < 7000 then

	 
	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if inst.loud_2 or inst.loud_3 then
	
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
	
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
	local fx_2 = SpawnPrefab("groundpoundring_fx")
		fx_2.Transform:SetScale(0.4, 0.4, 0.4)
		fx_2.Transform:SetPosition(inst:GetPosition():Get())
	  
	v:DoTaskInTime(0.3, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.4, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(v:GetPosition():Get())
	  end)
		if v:HasTag("burn") then
			v.slow = true 
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		else	
		
		v.components.health:DoDelta(-20)
		--v.components.combat:GetAttacked(inst, 20)
		end
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
	v.burn = false v.bloom = false 
	v:RemoveTag("burn")
		if not v:HasTag("lightninggoat") then
		v.AnimState:SetBloomEffectHandle( "" ) 
		v.bloom = false 
		end
	

	if v:HasTag("slow") then
	
		
		if not v.shocked then
		v.components.health:DoDelta(-35)
		--v.components.combat:GetAttacked(inst, 35)
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-60)
		--v.components.combat:GetAttacked(inst, 60)
		
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		v.shocked = false
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
			if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and not v.components.health:IsDead() then 
			v.components.health:DoDelta(-6)
			--
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
	elseif not v:HasTag("slow")	then
	v:AddTag("burn")
		
	end
	end)
	
elseif inst.level >= 7000 then

			

	inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
	if inst.loud_2 or inst.loud_3 then
	
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
	
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
	local fx_2 = SpawnPrefab("groundpoundring_fx")
		fx_2.Transform:SetScale(0.4, 0.4, 0.4)
		fx_2.Transform:SetPosition(inst:GetPosition():Get())
	  
	v:DoTaskInTime(0.3, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	v:DoTaskInTime(0.4, function() SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get()) 
	local fx_3 = SpawnPrefab("groundpoundring_fx")
		fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		fx_3.Transform:SetPosition(v:GetPosition():Get())
	  end)
		if v:HasTag("burn") then
			v.slow = true 
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		else	
		
		v.components.health:DoDelta(-25)
		--v.components.combat:GetAttacked(inst, 25)
		end
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
	v.burn = false v.bloom = false 
	v:RemoveTag("burn")
		if not v:HasTag("lightninggoat") then
		v.AnimState:SetBloomEffectHandle( "" ) 
		v.bloom = false 
		end
	

	if v:HasTag("slow") then
	
				
		if not v.shocked then
		v.components.health:DoDelta(-40)
		--v.components.combat:GetAttacked(inst, 40)
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-70)
		--v.components.combat:GetAttacked(inst, 70)
		
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		v.shocked = false
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
		if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and not v.components.health:IsDead() then 
			v.components.health:DoDelta(-8)
			--
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
	elseif not v:HasTag("slow")	then
	v:AddTag("burn")	
	end
	end)
	
		end 
	end
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
		end
	end
end	
--power lightning

 function Lightning_a(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if inst.sneaka then
--inst.components.talker:Say("Be quiet..")
	if not inst.poison_sneaka then
		if inst.components.sanity.current > 10 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_READY_POISON)
		inst.components.sanity:DoDelta(-25)
		inst.poison_sneaka = true
			local poison_sneaka = SpawnPrefab("shadowbomb_r")
			if poison_sneaka then
			poison_sneaka.entity:SetParent(inst.entity)
			poison_sneaka.Follower:FollowSymbol(inst.GUID, "headbase", -5, -225, 0.5)
			end
		elseif inst.components.sanity.current <= 25 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
		end
	elseif inst.poison_sneaka then	
	inst.components.talker:Say(STRINGS.MUSHA_TALK_CANCEL_POISON)
		inst.poison_sneaka = false
		inst.components.sanity:DoDelta(25)
	end
	
else
			
if not inst.writing and inst.berserk then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GRRR)
local fx = SpawnPrefab("stalker_shield_musha")
	  fx.Transform:SetScale(0.5, 0.5, 0.5)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
	local x,y,z = inst.Transform:GetWorldPosition()	
	local ents = TheSim:FindEntities(x, y, z, 10)
	for k,v in pairs(ents) do	
	if inst.components.spellpower.current > 1 and v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and not v.components.health:IsDead() and not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and not v:HasTag("groundspike") and not v:HasTag("player") and not v:HasTag("stalkerminion") and not v:HasTag("structure") and not v:HasTag("groundspike") and not v:HasTag("stalkerminion") and v.components.locomotor and not v.ghost_spark and v.components.combat and (v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or v:HasTag("frog")) then
	--cost
	inst.components.spellpower:DoDelta(-1) 
	
	v.ghost_spark = true
	if inst.loud_1 or inst.loud_2 then
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	else
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	end
	inst:DoTaskInTime(0.6, function() SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get()) end)
		
		-- lightning skill cost
		--inst.components.sanity:DoDelta(-3)
	if v:HasTag("burn") and v.components.combat ~= nil then
			
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
			if not v:HasTag("slow") then
			v:AddTag("slow") 
			end
		if v:HasTag("slow") then
	
		--[[local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	]]
		
		if not v.shocked then
		v.components.health:DoDelta(-30)
		--v.components.combat:GetAttacked(inst, 40)
		elseif v.shocked then
		SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
		v.components.health:DoDelta(-45)
		--v.components.combat:GetAttacked(inst, 65)
		
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
		
		v.shocked = false
		
		end
	
		local debuff = SpawnPrefab("debuff_short")
		debuff.Transform:SetPosition(v:GetPosition():Get())
		if debuff and v:HasTag("slow") then
		local follower = debuff.entity:AddFollower()
		if not v:HasTag("cavedweller") then
			follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
			else
			follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
			end
		TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slow") and not v.components.health:IsDead() then 
			v.components.health:DoDelta(-2)
			--
		end	end)
		end	
		TheWorld:DoTaskInTime(15, function() if v.components.locomotor then v.components.locomotor.groundspeedmultiplier = 1 v.slow = false v:RemoveTag("slow") debuff:Remove() end end)
			end
	else
		v.components.health:DoDelta(-25)
		--v.components.combat:GetAttacked(inst, 30)
	end		
				--[[if v.ghost_spark and v:HasTag("spider") then
					v.sg:GoToState("hit_stunlock")
				else
					v.sg:GoToState("hit")
				end]]
			if v.components.locomotor and not v:HasTag("ghost") then
					v.components.locomotor:StopMoving()
			if v:HasTag("spider") and not v:HasTag("spiderqueen") then
					v.sg:GoToState("hit_stunlock")
			else
					v.sg:GoToState("hit")
				end
			end
				
				
				if v.components.combat and not v:HasTag("companion") then
				v.components.combat:SuggestTarget(inst)
				end
		v:DoTaskInTime(3, function() v.ghost_spark = false end)
	end
	end

elseif not inst.writing and not inst.berserk then
		
if inst.components.stamina_sleep.current  >= 20 and inst.components.sanity.current >= 0 and not inst.components.health:IsDead() and not inst.active_valkyrie and not inst.switch and inst.valkyrie_on then
inst.active_valkyrie = true

--inst:DoTaskInTime( 60, function() inst.active_valkyrie = false SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get()) end) 
elseif (inst.components.stamina_sleep.current < 20 or inst.components.sanity.current <= 0) and not inst.active_valkyrie and inst.valkyrie_on then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GRRR)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
inst.components.combat:SetRange(2)
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
	end
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
inst.switch = false
inst.active_valkyrie = false
 
elseif inst.components.sanity.current <= 0 and inst.active_valkyrie and inst.valkyrie_on then 
inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
 inst.components.combat:SetRange(2)
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
end
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.switch = false
inst.active_valkyrie = false
--inst.components.sanity:DoDelta(4)
end
if inst.components.stamina_sleep.current  >= 20 and not inst.switch and inst.components.sanity.current > 0 and inst.level < 430  and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not ( inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and inst.valkyrie_on then
	if inst.components.spellpower.current >=9 then
	inst.components.spellpower:DoDelta(-9) inst.lightning_spell_cost = true
inst.components.combat:SetRange(10,12)
inst:ListenForEvent("onhitother", on_hitLightnings_9)

inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
local fx = SpawnPrefab("groundpoundring_fx")
	  fx.Transform:SetScale(0.3, 0.3, 0.3)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
		if not inst.sneak_pang then
		inst:DoTaskInTime(2, function() if inst.switch then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
		end
	end
inst.switch = true

local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		
		end	
--Call_lightining_on(inst)
--inst.components.sanity:DoDelta(-2)
elseif inst.components.stamina_sleep.current  >= 20 and not inst.switch and inst.components.sanity.current > 0 and inst.level >= 430 and inst.level < 1880  and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not ( inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and inst.valkyrie_on then
	if inst.components.spellpower.current >=9 then
	inst.components.spellpower:DoDelta(-9) inst.lightning_spell_cost = true
inst.components.combat:SetRange(10,12)
inst:ListenForEvent("onhitother", on_hitLightnings_9)

inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
local fx = SpawnPrefab("groundpoundring_fx")
	  fx.Transform:SetScale(0.3, 0.3, 0.3)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
	 	if not inst.sneak_pang then
		inst:DoTaskInTime(2, function() if inst.switch then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
		end
	end
inst.switch = true

local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		
		end	
--Call_lightining_on(inst)
--inst.components.sanity:DoDelta(-2)
if not inst.berserk then
--inst.components.talker:Say("Valkyrie!") 
end
elseif inst.components.stamina_sleep.current  >= 20 and not inst.switch and inst.components.sanity.current > 0 and inst.level >= 1880 and inst.level < 7000  and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not ( inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and inst.valkyrie_on then
	if inst.components.spellpower.current >=9 then
	inst.components.spellpower:DoDelta(-9) inst.lightning_spell_cost = true
inst.components.combat:SetRange(10,12)
inst:ListenForEvent("onhitother", on_hitLightnings_9)

inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
local fx = SpawnPrefab("groundpoundring_fx")
	  fx.Transform:SetScale(0.3, 0.3, 0.3)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
		if not inst.sneak_pang then
		inst:DoTaskInTime(2, function() if inst.switch then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
		end
	end
inst.switch = true

local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		
		end	
--Call_lightining_on(inst)
--inst.components.sanity:DoDelta(-2)
if not inst.berserk then
--inst.components.talker:Say("Valkyrie!") 
end
elseif inst.components.stamina_sleep.current  >= 20 and not inst.switch and inst.components.sanity.current > 0 and inst.level >= 7000 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not ( inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and inst.valkyrie_on then
	if inst.components.spellpower.current >=9 then
	inst.components.spellpower:DoDelta(-9) inst.lightning_spell_cost = true
inst.components.combat:SetRange(10,12)
inst:ListenForEvent("onhitother", on_hitLightnings_9)

inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
local fx = SpawnPrefab("groundpoundring_fx")
	  fx.Transform:SetScale(0.3, 0.3, 0.3)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
		if not inst.sneak_pang then
		inst:DoTaskInTime(2, function() if inst.switch then inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) end end)
		end
	end
inst.switch = true

local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(inst:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		
		end	
--Call_lightining_on(inst)
--inst.components.sanity:DoDelta(-2)

elseif not inst.switch and not inst.components.health:IsDead() and ( inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and inst.valkyrie_on then
inst.components.combat:SetRange(2)
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
end
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.switch = false
inst.active_valkyrie = false
--inst.components.sanity:DoDelta(6)
	if inst.lightning_spell_cost then
	inst.components.spellpower:DoDelta(6)
	end
elseif inst.switch and not inst.components.health:IsDead() and inst.valkyrie_on then
inst.components.combat:SetRange(2)
inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
if inst.in_shadow then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.in_shadow = false
end
inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.switch = false
inst.active_valkyrie = false
--inst.components.sanity:DoDelta(1)
	if inst.lightning_spell_cost then
	inst.components.spellpower:DoDelta(6)
	end
elseif not inst.switch and inst.components.sanity.current <= 0 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.valkyrie_on then
inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
elseif inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_REVENGE)

local x,y,z = inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, 10)
for k,v in pairs(ents) do	
	if v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and not v.ghost_spark and not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and not v:HasTag("groundspike") and not v:HasTag("player") and not v:HasTag("stalkerminion") and not inst.components.rider ~= nil and not inst.components.rider:IsRiding() and not inst.sg:HasStateTag("moving") and not inst.sg:HasStateTag("attack") and not v:HasTag("structure") and v.components.combat and (v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or v:HasTag("frog")) then
	v.ghost_spark = true
	SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
	if v.ghost_spark then
	local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	
	end	
		v.components.health:DoDelta(-10)
				if v.ghost_spark and v:HasTag("spider") and not v:HasTag("spiderqueen") then
					v.sg:GoToState("hit_stunlock")
				elseif v.ghost_spark and v:HasTag("hound") then
					v.sg:GoToState("hit")
				end
		v:DoTaskInTime(3, function() v.ghost_spark = false end)
		
end
end

end 
--inst:ListenForEvent("killed", onkilll)
if not inst.valkyrie_on and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_EXP.."\n[REQUIRE]: level 3")
end
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 40, {"yamcheb"})
for k,v in pairs(ents) do
if inst.components.leader:IsFollower(v) and not inst.switch then
v.yamche_lightning = false
elseif inst.components.leader:IsFollower(v) and inst.switch then
v.yamche_lightning = true
end end

local weapon = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
if inst.switch and weapon and weapon.components.weapon then 
weapon.components.weapon.stimuli = "electric"
elseif not inst.switch and weapon and weapon.components.weapon and not weapon:HasTag("electric_weapon") then
weapon.components.weapon.stimuli = nil
end

----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end 
end
if inst.switch and inst.frosthammer2 then
    inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
    inst.AnimState:Show("ARM_carry") 
    inst.AnimState:Hide("ARM_normal") 
elseif not inst.switch and inst.frosthammer2 then
	inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
    inst.AnimState:Show("ARM_carry") 
    inst.AnimState:Hide("ARM_normal") 
end
end
AddModRPCHandler("musha", "Lightning_a", Lightning_a)

--shield
--active shield
 function shield_go(inst, attacked, data)
	
if not inst.components.health:IsDead() and inst.level < 430 and not inst.activec0 and inst.shield_level1 then
--inst.components.talker:Say("Shield on!!")
--inst.components.health:SetAbsorptionAmount(1)
local fx = SpawnPrefab("forcefieldfxx")
inst.on_sparkshield = true 

inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.activec0 = true
inst.timec1 = true
inst:DoTaskInTime(--[[Duration]] 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)

if inst:IsValid() then
fx.kill_fx(fx)

inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_90)
inst.on_sparkshield = false 

inst:DoTaskInTime(--[[Cooldown]] 90, function() inst.activec0 = false inst.timec1 = false inst.casting = false end)
end end) 
end 
if not inst.components.health:IsDead() and inst.level >= 430 and inst.level < 1880 and not inst.activec0 and inst.shield_level2 then
--inst.components.talker:Say("Shield on!!")
--inst.components.health:SetAbsorptionAmount(1)
local fx = SpawnPrefab("forcefieldfxx")
inst.on_sparkshield = true 

inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.activec0 = true
inst.timec2 = true
inst:DoTaskInTime(--[[Duration]] 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)

inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_80)
inst.on_sparkshield = false 
inst:DoTaskInTime(--[[Cooldown]] 80, function() inst.activec0 = false inst.timec2 = false end)
end end) 
end 
if not inst.components.health:IsDead() and inst.level >= 1880 and inst.level < 7000 and not inst.activec0 and inst.shield_level3 then
--inst.components.talker:Say("Shield on!!")
--inst.components.health:SetAbsorptionAmount(1)
local fx = SpawnPrefab("forcefieldfxx")
inst.on_sparkshield = true 

inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.activec0 = true
inst.timec3 = true
inst:DoTaskInTime(--[[Duration]] 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)

inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_70)
inst.on_sparkshield = false 
inst:DoTaskInTime(--[[Cooldown]] 70, function() inst.activec0 = false inst.timec3 = false end)
end end) 
end 
if not inst.components.health:IsDead() and inst.level >= 7000 and not inst.activec0 and inst.shield_level4 then
--inst.components.talker:Say("Shield on!!")
--inst.components.health:SetAbsorptionAmount(1)
local fx = SpawnPrefab("forcefieldfxx")
inst.on_sparkshield = true 

inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
fx.entity:SetParent(inst.entity)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx.Transform:SetScale(2, 2, 2)
		else
		fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
fx.AnimState:PlayAnimation("hit")
fx.AnimState:PushAnimation("idle_loop")
end
fx:ListenForEvent("blocked", fx_hitanim, inst)
inst.activec0 = true
inst.timec4 = true
inst:DoTaskInTime(--[[Duration]] 12, function()
fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then
fx.kill_fx(fx)

inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_60)
inst.on_sparkshield = false 

	--[[if  inst.berserk and inst.berserk_armor_1 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.15)
	elseif  inst.berserk and inst.berserk_armor_2 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.3)	
	elseif  inst.berserk and inst.berserk_armor_3 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.45)
	elseif  inst.valkyrie and not (inst.valkyrie_armor_1 or inst.valkyrie_armor_2 or inst.valkyrie_armor_3 or inst.valkyrie_armor_4) and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.1)
	elseif  inst.valkyrie and inst.valkyrie_armor_1 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.1)
	elseif  inst.valkyrie and inst.valkyrie_armor_2 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.2)	
	elseif  inst.valkyrie and inst.valkyrie_armor_3 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.25)	
	elseif  inst.valkyrie and inst.valkyrie_armor_4 and not inst.music_armor then
	inst.components.health:SetAbsorptionAmount(0.3)
	else
	inst.components.health:SetAbsorptionAmount(0)
	end	]]
	
	--inst.components.health:SetAbsorptionAmount(0)
inst:DoTaskInTime(--[[Cooldown]] 60, function() inst.activec0 = false inst.timec4 = false end)
end end) 
end 
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end

---
 function shieldgo(inst)
if not inst.activec0 and not inst.timec1 and inst.level < 430  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.timec1 = true
elseif not inst.activec0 and not inst.timec2 and inst.level >= 430 and inst.level < 1880  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.timec2 = true
elseif not inst.activec0 and not inst.timec3 and inst.level >= 1880 and inst.level < 7000  then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.timec3 = true
elseif not inst.activec0 and not inst.timec4 and inst.level >= 7000 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
inst.timec4 = true
end 
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end
 function on_shield_act(inst)

inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
if inst.components.health ~=nil and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst:ListenForEvent("hungerdelta", shieldgo )
--inst:ListenForEvent("attacked", Sparkshield_1)
if inst.level < 430 then
inst.shield_level1 = true
elseif inst.level >= 430 and inst.level < 1880 then
inst.shield_level2 = true
inst.shield_level1 = false
elseif inst.level >= 1880 and inst.level < 7000 then
inst.shield_level3 = true
inst.shield_level2 = false
inst.shield_level1 = false
elseif inst.level >= 7000 then
inst.shield_level4 = true
inst.shield_level3 = false
inst.shield_level2 = false
inst.shield_level1 = false
end

if not inst.activec0 and inst.components.spellpower.current >= 30 then
--[[local fx_1 = SpawnPrefab("stalker_shield_musha")
	  fx_1.Transform:SetScale(0.4, 0.4, 0.4)
  	  fx_1.Transform:SetPosition(inst:GetPosition():Get())]]
	  --inst.components.locomotor:Stop()
		if not inst.casting and not inst.components.rider:IsRiding() and not inst.sg:HasStateTag("moving") and not inst.sg:HasStateTag("attack") then 
		inst.casting = true 
		--inst.sg:GoToState("book2") 
		--inst.AnimState:PlayAnimation("sing")
		inst.on_sparkshield = true 
		end 
			
	local shocking_self = SpawnPrefab("musha_spin_fx")
		shocking_self.Transform:SetPosition(inst:GetPosition():Get())
		if shocking_self then
		local follower = shocking_self.entity:AddFollower()
		follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	

	local x,y,z = inst.Transform:GetWorldPosition()	
	local ents = TheSim:FindEntities(x, y, z, 10)
for k,v in pairs(ents) do	
if inst.components.sanity and v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and not v:HasTag("groundspike") and not v:HasTag("player") and not v:HasTag("companion") and not v:HasTag("stalkerminion") and not v:HasTag("structure") and v.components.combat ~= nil and (v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn")) then
		
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
	--SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
		local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end
		
	if v.components.locomotor and not v:HasTag("ghost") then
        v.components.locomotor:StopMoving()
		if v:HasTag("spider") and not v:HasTag("spiderqueen") then
			v.sg:GoToState("hit_stunlock")
		else
			v.sg:GoToState("hit")
		end
	end
		v.components.health:DoDelta(-20)
		--v.components.combat:GetAttacked(inst, 10)
	
	if v.components.combat and not v:HasTag("companion") then
        v.components.combat:SuggestTarget(inst)
    end
end
end
		
elseif inst.activec0 or inst.components.spellpower.current < 30 then
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
end

if inst.level < 430 and not inst.activec0 and inst.components.spellpower.current >= 30 then

shield_go(inst)
	if inst.components.spellpower then
	inst.components.spellpower:DoDelta(-30) 
	end
elseif inst.level >= 430 and inst.level < 1880 and not inst.activec0 and inst.components.spellpower.current >= 30 then

shield_go(inst)
	if inst.components.spellpower then
	inst.components.spellpower:DoDelta(-30) 
	end
elseif inst.level >= 1880 and inst.level < 7000 and not inst.activec0 and inst.components.spellpower.current >= 30 then

shield_go(inst)
	if inst.components.spellpower then
	inst.components.spellpower:DoDelta(-30) 
	end
elseif inst.level >= 7000 and not inst.activec0 and inst.components.spellpower.current >= 30 then

shield_go(inst)
	if inst.components.spellpower then
	inst.components.spellpower:DoDelta(-30) 
	end
elseif inst.components.spellpower.current < 30 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SPELLPOWER.."\n(30)")
--inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEPY)
  
elseif inst.activec0 then

inst.shield_level1 = false
inst.shield_level2 = false
inst.shield_level3 = false
inst.shield_level4 = false

end
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
elseif inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
end
end
 
AddModRPCHandler("musha", "on_shield_act", on_shield_act)

--treasure hunt

	
 function musha_egghunt(inst, data)
		-- egghunt -- 
		
if not inst.yamche_egg_hunted then
		local pos1 = inst:GetPosition()
		local offset1 = FindWalkableOffset(pos1, math.random() * 2 * math.pi, math.random(5, 10), 10)
		local spawn_pos1 = pos1 + offset1
    
		if offset1 ~= nil then 
		local hidden_egg = SpawnPrefab("musha_hidden_egg")
		hidden_egg.Transform:SetPosition(spawn_pos1:Get())
		local puff = SpawnPrefab("small_puff")
		puff.Transform:SetPosition(spawn_pos1:Get())
		local shovel = SpawnPrefab("shovel")
		shovel.Transform:SetPosition(spawn_pos1:Get())
		hidden_egg:SetTreasureHunt()
			inst.yamche_egg_hunted = true	
			inst:DoTaskInTime(0.5, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FIRST) 
			inst:DoTaskInTime(2, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_YAMCHE) 
			end) end)

		elseif not offset1 then 
		inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAILED)
			inst.treasure = inst.treasure + 95
		end		
end	
end	
	
	
 function musha_treasurehunt(inst, isload)

if not inst.yamche_egg_hunted then
musha_egghunt(inst)
--elseif not inst.arong_egg_hunted then
--musha_egghunt(inst)
elseif inst.yamche_egg_hunted --[[and inst.arong_egg_hunted]] then
	
		local pos1 = inst:GetPosition()
		local offset1 = FindWalkableOffset(pos1, math.random() * 800 * math.pi, math.random(900, 1000), 500)
		local offset2 = FindWalkableOffset(pos1, math.random() * 200 * math.pi, math.random(250, 300), 180)
		local offset3 = FindWalkableOffset(pos1, math.random() * 3 * math.pi, math.random(25, 30), 18)
		local guard1 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 3), 1)
		local guard2 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 2), 2)
		local guard3 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 1), 3)	
	--test
	--[[
			if offset3 then
		inst.treasure3 = true
		inst:DoTaskInTime(0.5, function() inst.components.talker:Say("It is near !!") end)
			local spawn_pos3 = pos1 + offset3
			local treasure3 = SpawnPrefab("musha_treasure2")
			treasure3.Transform:SetPosition(spawn_pos3:Get())
			treasure3:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos3:Get())
			treasure3:AddTag("treasure")
			inst.treasure = inst.treasure + 100 end
		]]
	
		if math.random() < 0.5 and offset1 ~= nil then
		inst.treasure1 = true
		inst:DoTaskInTime(1, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAR) end)		
			local spawn_pos1 = pos1 + offset1
			local treasure1 = SpawnPrefab("musha_treasure2")
			treasure1.Transform:SetPosition(spawn_pos1:Get())
			treasure1:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos1:Get())
			--treasure1:AddTag("treasure")
		-- green worm
		if math.random() < 0.5 and guard1 ~= nil then
		local spawn_pos1_gw = pos1 + offset1 + guard1
		local gworm = SpawnPrefab("greenworm")
		gworm.Transform:SetPosition(spawn_pos1_gw:Get())
		gworm.sg:GoToState("lure_enter")
		end
		-- green fruit
		if math.random() < 0.5 and guard2 ~= nil then
		local spawn_pos1_gw = pos1 + offset1 + guard2
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos1_gw:Get())
		end
		if math.random() < 0.25 and guard3 ~= nil then
		local spawn_pos1_gw = pos1 + offset1 + guard3
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos1_gw:Get())
		end
	
		elseif math.random() < 0.6 and not inst.treasure1 and offset2 ~= nil then
		inst.treasure2 = true
		inst:DoTaskInTime(1, function()	inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_MED) end)
			local spawn_pos2 = pos1 + offset2
			local treasure2 = SpawnPrefab("musha_treasure2")
			treasure2.Transform:SetPosition(spawn_pos2:Get())
			treasure2:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos2:Get())
			--treasure2:AddTag("treasure")
		-- green worm
		if math.random() < 0.55 and guard1 ~= nil then
		local spawn_pos2_gw = pos1 + offset2 + guard1
		local gworm = SpawnPrefab("greenworm")
		gworm.Transform:SetPosition(spawn_pos2_gw:Get())
		gworm.sg:GoToState("lure_enter")
		end
		-- green fruit
		if math.random() < 0.5 and guard2 ~= nil then
		local spawn_pos2_gw = pos1 + offset2 + guard2
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos2_gw:Get())
		end
		-- green fruit
		if math.random() < 0.25 and guard3 ~= nil then
		local spawn_pos2_gw = pos1 + offset2 + guard3
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos2_gw:Get())
		end	
		
		elseif not inst.treasure1 and not inst.treasure2 and offset3 ~= nil then
		inst.treasure3 = true
		inst:DoTaskInTime(0.5, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_NEAR) end)
			local spawn_pos3 = pos1 + offset3
			local treasure3 = SpawnPrefab("musha_treasure2")
			treasure3.Transform:SetPosition(spawn_pos3:Get())
			treasure3:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos3:Get())
			--treasure3.near_treasure = true
		-- green worm 
		if math.random() < 0.5 and guard1 ~= nil then
		local spawn_pos3_gw = pos1 + offset3 + guard1
		local gworm = SpawnPrefab("greenworm")
		gworm.Transform:SetPosition(spawn_pos3_gw:Get())
		gworm.sg:GoToState("lure_enter")
		end
		-- green fruit
		if math.random() < 0.5 and guard2 ~= nil then
		local spawn_pos3_gw = pos1 + offset3 + guard2
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos3_gw:Get())
		end
		if math.random() < 0.25 and guard3 ~= nil then
		local spawn_pos3_gw = pos1 + offset3 + guard3
		local gworm = SpawnPrefab("green_apple_plant")
		gworm.Transform:SetPosition(spawn_pos3_gw:Get())
		end	
	
		elseif not inst.treasure1 and not inst.treasure2 and not inst.treasure3 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAILED)
			inst.treasure = inst.treasure + 90
		end
	
		-------------
	
	--test
	--[[
	if IsServer then
	local minimap_fog = TheSim:FindFirstEntityWithTag("minimap")
		if minimap_fog then
			minimap_fog.MiniMap:EnableFogOfWar(false)
			minimap_fog.MiniMap:DrawForgottenFogOfWar(true)
		inst:DoTaskInTime( 5, function() if minimap_fog then 
			minimap_fog.MiniMap:EnableFogOfWar(true) 
		end end)
		end
	end]]
				
		-------------

	if inst.treasure1 or inst.treasure2 or inst.treasure3 then 		
	inst.treasure1 = false
	inst.treasure2 = false
	inst.treasure3 = false
			end
	end
end

 function on_treasure_hunt(inst)
if inst.components.playercontroller then
inst.components.playercontroller:Enable(false)

--[[	if TheSim:FindFirstEntityWithTag("musha_treasure") then
	local treasures = TheSim:FindFirstEntityWithTag("musha_treasure")
	local x, y, z = treasures.Transform:GetWorldPosition()
	local minimap = TheWorld.minimap.MiniMap
	minimap:ShowArea(x, y, z, 20)
			end]]

inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_SNIFF)
local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if item then
inst.sg:GoToState("talk")
inst.components.inventory:Unequip(EQUIPSLOTS.HANDS, true) 
inst.components.inventory:GiveItem(item)
end
inst:DoTaskInTime(1.5, function() inst.components.playercontroller:Enable(false) inst.sg:GoToState("peertelescope2") inst.components.talker.colour = Vector3(1, 0.85, 0.7, 1) inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FOUND) 
inst:DoTaskInTime(3, function() inst.components.playercontroller:Enable(false) inst.sg:GoToState("map") inst.components.talker.colour = Vector3(1, 0.85, 0.7, 1) inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_MARK)  
inst:DoTaskInTime(3.5, function() inst.components.playercontroller:Enable(true) inst.components.talker.colour = Vector3(1, 1, 1, 1) musha_treasurehunt(inst) end) end) end)
end 
end
local PLANTS_RANGE = 1
local MAX_PLANTS = 18
local PLANTFX_TAGS = { "wormwood_plant_fx" }
local function PlantTick(inst)
    if inst.sg:HasStateTag("ghostbuild") or inst.components.health:IsDead() or not inst.entity:IsVisible() then
        return
    end

	local t = inst.components.bloomness.timer
	local chance = TheWorld.state.isspring and 1
					or t <= TUNING.WORMWOOD_BLOOM_PLANTS_WARNING_TIME_LOW and 1/3
					or t <= TUNING.WORMWOOD_BLOOM_PLANTS_WARNING_TIME_MED and 2/3
					or 1

	if chance < 1 and math.random() > chance then
		return
	end

	if inst:GetCurrentPlatform() ~= nil then
		return
	end

    local x, y, z = inst.Transform:GetWorldPosition()
    if #TheSim:FindEntities(x, y, z, PLANTS_RANGE, PLANTFX_TAGS) < MAX_PLANTS then
        local map = TheWorld.Map
        local pt = Vector3(0, 0, 0)
        local offset = FindValidPositionByFan(
            math.random() * 2 * PI,
            math.random() * PLANTS_RANGE,
            3,
            function(offset)
                pt.x = x + offset.x
                pt.z = z + offset.z
                return map:CanPlantAtPoint(pt.x, 0, pt.z)
                    and #TheSim:FindEntities(pt.x, 0, pt.z, .5, PLANTFX_TAGS) < 3
                    and map:IsDeployPointClear(pt, nil, .5)
                    and not map:IsPointNearHole(pt, .4)
            end
        )
        if offset ~= nil then
            local plant = SpawnPrefab("wormwood_plant_fx")
            plant.Transform:SetPosition(x + offset.x, 0, z + offset.z)
            --randomize, favoring ones that haven't been used recently
            local rnd = math.random()
			inst.plantpool = { 1, 2, 3, 4 }
            rnd = table.remove(inst.plantpool, math.clamp(math.ceil(rnd * rnd * #inst.plantpool), 1, #inst.plantpool))
            table.insert(inst.plantpool, rnd)
            plant:SetVariation(rnd)
        end
    end
end

 function on_music_act1(inst)
if inst.components.playercontroller then
local lightorb = SpawnPrefab("musha_spore2")
local hounds = SpawnPrefab("ghosthound")
inst.components.playercontroller:Enable(false)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.sg:GoToState("play_flute2")
inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
inst.entity:AddLight()
inst.Light:SetRadius(0.5)
inst.Light:SetFalloff(.75)
inst.Light:SetIntensity(.1)
inst.Light:SetColour(90/255,90/255,90/255)

inst.music_armor = true inst.nsleep = true inst.start_music = false 
--[[inst.components.health:SetInvincible(true)]] 
inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE*5)
inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2")
inst:DoTaskInTime(3, function() SpawnPrefab("balloonparty_confetti_cloud").Transform:SetPosition(inst.Transform:GetWorldPosition()) inst.sg:GoToState("enter_onemanband")inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2") 
inst:DoTaskInTime(3, function() inst.components.playercontroller:Enable(true) inst.AnimState:SetBloomEffectHandle("") inst.Light:Enable(true)  --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]] lightorb.Transform:SetPosition(inst:GetPosition():Get()) lightorb.components.follower:SetLeader(inst) inst.small_light = true inst.lightaura = true inst.moondrake_on = true inst.sg:GoToState("play_horn2") inst.nsleep = false  SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) hounds.Transform:SetPosition(inst:GetPosition():Get())  hounds.Transform:SetPosition(inst:GetPosition():Get()) hounds.followdog = true --[[hounds.components.follower:SetLeader(inst)]] inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE) inst.components.sanity:DoDelta(10) inst.music_armor = false --[[inst.components.health:SetInvincible(false)]] inst:DoTaskInTime(180, function() --[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false inst.lightaura = false inst.moondrake_on = false inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) inst.components.sanityaura.aura = 0 inst.Light:SetRadius(0.5) inst:DoTaskInTime(5, function() inst.Light:Enable(false) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
if inst.planttask ~= nil then inst.planttask:Cancel() end
end) end)end)end)end)end)
end
end 

 function on_music_act2(inst)
if inst.components.playercontroller then
local lightorb = SpawnPrefab("musha_spore2")
local shadows = SpawnPrefab("shadowmusha")
inst.components.playercontroller:Enable(false)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.sg:GoToState("play_flute2")
inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
inst.entity:AddLight()
inst.Light:SetRadius(0.5)
inst.Light:SetFalloff(.75)
inst.Light:SetIntensity(.1)
inst.Light:SetColour(90/255,90/255,90/255)

inst.music_armor = true inst.nsleep = true inst.start_music = false
--[[inst.components.health:SetInvincible(true)]]
inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE*5)
inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2")
inst:DoTaskInTime(3, function() SpawnPrefab("balloonparty_confetti_cloud").Transform:SetPosition(inst.Transform:GetWorldPosition()) inst.sg:GoToState("enter_onemanband")inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2")inst:DoTaskInTime(3, function() inst.sg:GoToState("enter_onemanband")
inst:DoTaskInTime(3, function() inst.components.playercontroller:Enable(true) inst.AnimState:SetBloomEffectHandle("") inst.Light:Enable(true)  --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]] lightorb.Transform:SetPosition(inst:GetPosition():Get()) lightorb.components.follower:SetLeader(inst) inst.small_light = true inst.lightaura = true inst.moondrake_on = true inst.sg:GoToState("play_horn2") inst.nsleep = false  SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) shadows.Transform:SetPosition(inst:GetPosition():Get())  shadows.followdog = true  inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE) inst.components.sanity:DoDelta(10) inst.music_armor = false --[[inst.components.health:SetInvincible(false)]] inst:DoTaskInTime(180, function() --[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false inst.lightaura = false inst.moondrake_on = false inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) inst.components.sanityaura.aura = 0 inst.Light:SetRadius(0.5) inst:DoTaskInTime(5, function() inst.Light:Enable(false) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
if inst.planttask ~= nil then inst.planttask:Cancel() end
end) end)end)end)end)end)end)
end
end 

 function on_music_act3(inst)
local drakeangle = math.random(1, 360)

local offset0 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local offset1 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local offset2 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local offset3 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local offset4 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
local offset5 = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
if offset0 ~= nil and offset1 ~= nil and offset2 ~= nil and offset3 ~= nil and offset4 ~= nil and offset5 ~= nil then
local tentacle_frost0 = SpawnPrefab("tentacle_frost")
local tentacle_frost1 = SpawnPrefab("tentacle_frost")
local tentacle_frost2 = SpawnPrefab("tentacle_frost")
local tentacle_frost3 = SpawnPrefab("tentacle_frost")
local tentacle_frost4 = SpawnPrefab("tentacle_frost")
local tentacle_frost5 = SpawnPrefab("tentacle_frost")
if inst.components.playercontroller then
local lightorb = SpawnPrefab("musha_spore2")
inst.components.playercontroller:Enable(false)
inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
inst.sg:GoToState("play_flute2")
inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
inst.entity:AddLight()
inst.Light:SetRadius(0.5)
inst.Light:SetFalloff(.75)
inst.Light:SetIntensity(.1)
inst.Light:SetColour(90/255,90/255,90/255)

inst.music_armor = true inst.nsleep = true inst.start_music = false
--[[inst.components.health:SetInvincible(true)]]
inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE*5)
inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2")
inst:DoTaskInTime(3, function() SpawnPrefab("balloonparty_confetti_cloud").Transform:SetPosition(inst.Transform:GetWorldPosition()) inst.sg:GoToState("enter_onemanband")inst:DoTaskInTime(3, function() inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.sg:GoToState("play_flute2")inst:DoTaskInTime(3, function() inst.sg:GoToState("enter_onemanband")
inst:DoTaskInTime(3, function() inst.components.playercontroller:Enable(true) inst.AnimState:SetBloomEffectHandle("") inst.Light:Enable(true)  --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]] lightorb.Transform:SetPosition(inst:GetPosition():Get()) lightorb.components.follower:SetLeader(inst) inst.small_light = true inst.lightaura = true inst.moondrake_on = true inst.sg:GoToState("play_horn2") inst.nsleep = false  
local x,y,z = inst.Transform:GetWorldPosition()
tentacle_frost0.Transform:SetPosition(x + offset0.x, y + offset0.y, z + offset0.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost0:GetPosition():Get()) 
inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
inst:DoTaskInTime( 3, function() tentacle_frost1.Transform:SetPosition(x + offset1.x, y + offset1.y, z + offset1.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost1:GetPosition():Get()) tentacle_frost1.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") end)
inst:DoTaskInTime( 6, function() tentacle_frost2.Transform:SetPosition(x + offset2.x, y + offset2.y, z + offset2.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost2:GetPosition():Get()) tentacle_frost2.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") end)
inst:DoTaskInTime( 9, function() tentacle_frost3.Transform:SetPosition(x + offset3.x, y + offset3.y, z + offset3.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost3:GetPosition():Get()) tentacle_frost3.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") end)
inst:DoTaskInTime( 12, function() tentacle_frost4.Transform:SetPosition(x + offset4.x, y + offset4.y, z + offset4.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost4:GetPosition():Get()) tentacle_frost4.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") end)
inst:DoTaskInTime( 15, function() tentacle_frost5.Transform:SetPosition(x + offset5.x, y + offset5.y, z + offset5.z)
SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost5:GetPosition():Get())  tentacle_frost5.SoundEmitter:PlaySound("dontstarve/common/gem_shatter") end)
  inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE) inst.components.sanity:DoDelta(10) inst.music_armor = false --[[inst.components.health:SetInvincible(false)]] inst:DoTaskInTime(180, function() --[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false inst.lightaura = false inst.moondrake_on = false inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get()) inst.components.sanityaura.aura = 0 inst.Light:SetRadius(0.5) inst:DoTaskInTime(5, function() inst.Light:Enable(false) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut") 
  if inst.planttask ~= nil then inst.planttask:Cancel() end
  end) end)end)end)end)end)
end)
end
end 
end

 function on_sleep(inst)
	if inst.fberserk or inst.berserks and not inst:HasTag("playerghost") then
 	inst.berserks = false
	inst.fberserk = false
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
   	if not inst:HasTag("playerghost") then
	if inst.components.hunger.current >= 160 then
		inst.strength = "full"  
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
		end
		end
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha_normal")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		end
	end	
	end
	end
	 
	inst:RemoveTag("notarget")
	if inst.sneaka or inst.sneak_pang then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	end
	inst.sneaka = false
	inst.poison_sneaka = false
	inst.sneak_pang = false	
	if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
	inst.switch = false
	inst.active_valkyrie = false

local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
weapon.components.weapon.stimuli = nil 
end
inst.components.locomotor:Stop()
--local bedroll = inst.sg:GoToState("bedroll2")
--inst.sg:AddStateTag("sleeping")
inst.sg:AddStateTag("busy")
--inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")

		if inst.components.temperature:GetCurrent() < 10 then
		
    		inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_furry", "bedroll_furry")
        else 
  			inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")
        end
if inst.components.health and not inst.components.health:IsDead() then 
--inst.AnimState:PlayAnimation("bedroll")
inst.sg:GoToState("bedroll2")
inst:DoTaskInTime(2, function() inst.sleep_on = true end)
--inst.sleepheal = inst:DoPeriodicTask(5, function() onsleepheal(inst) end)
end
end

 function on_tiny_sleep(inst)
if inst.components.health and not inst.components.health:IsDead() then 
	if inst.fberserk or inst.berserks and not inst:HasTag("playerghost") then
 	inst.berserks = false
	inst.fberserk = false
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
   	if not inst:HasTag("playerghost") then
	if inst.components.hunger.current >= 160 then
		inst.strength = "full"  
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_full_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_full_sw2")
		end
		end
	elseif inst.components.hunger.current < 160 then
		inst.strength = "normal"   
		if inst.visual_cos then
	inst.AnimState:SetBuild("musha_normal")
		elseif not inst.visual_cos and not inst.change_visual then
			if not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal")
			elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_k")
			elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
			inst.AnimState:SetBuild("musha_normal_old")
			elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
			inst.AnimState:SetBuild("musha_normal_sw2")			
		end
		end
	end	
	end
	end
	 
	inst:RemoveTag("notarget")
	if inst.sneaka or inst.sneak_pang then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	end
	inst.sneaka = false
	inst.poison_sneaka = false
	inst.sneak_pang = false	
	if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
	inst.switch = false
	inst.active_valkyrie = false
	inst.berserks = false
	inst.fberserk = false
local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
weapon.components.weapon.stimuli = nil 
end
	if not inst:HasTag("playerghost") then
	inst.sg:GoToState("knockout") inst.tiny_sleep = true
	elseif inst:HasTag("playerghost") then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_SLEEP)
	end
	
end
end
 

 function on_wakeup(inst)

if not inst.music_check and inst.sleep_on then
inst.sleep_on = false
inst.sg:GoToState("wakeup")
inst.entity:AddLight()
inst.Light:SetRadius(1)
inst.Light:SetFalloff(.8)
inst.Light:SetIntensity(.8)
inst.Light:SetColour(150/255,150/255,150/255)
--inst.components.health:SetAbsorptionAmount(1)
inst.music_armor = true
inst.Light:Enable(true)
inst:DoTaskInTime(1.5, function() inst.Light:Enable(false) inst.music_armor = false
inst.musha_press = false 
if inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
	if math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime1", false)
		elseif math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime4", false)
		else
		inst.AnimState:PushAnimation("mime3", false)
	end
else
	if inst.components.stamina_sleep.current < 99 then 
	inst.AnimState:PlayAnimation("yawn")
	elseif inst.components.stamina_sleep.current >= 99 then 
		if math.random() < 0.3 then
		inst.AnimState:PlayAnimation("yawn")
		elseif math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime1", false)
		elseif math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime4", false)
		else
		inst.AnimState:PushAnimation("mime3", false)
		end
	end
end	
end)
elseif not inst.music_check and inst.tiny_sleep then
inst.tiny_sleep = false
inst.sg:GoToState("wakeup")
inst.entity:AddLight()
inst.Light:SetRadius(1)
inst.Light:SetFalloff(.8)
inst.Light:SetIntensity(.8)
inst.Light:SetColour(150/255,150/255,150/255)
--inst.components.health:SetAbsorptionAmount(1)
inst.music_armor = true
inst.Light:Enable(true)
inst:DoTaskInTime(3.1, function() inst.Light:Enable(false) inst.music_armor = false
	--inst.sg:GoToState("yawn") 
	inst.musha_press = false
	
if inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
	if math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime1", false)
		elseif math.random() < 0.3 then
		inst.AnimState:PushAnimation("mime4", false)
		else
		inst.AnimState:PushAnimation("mime3", false)
	end
else
		inst.AnimState:PlayAnimation("yawn")
end
	
	--inst.AnimState:PlayAnimation("yawn")
	
end)

--if inst.sleepheal then inst.sleepheal:Cancel() inst.sleepheal = nil end
elseif inst.music_check then
	inst.components.playercontroller:Enable(false)
inst.sleep_on = false
inst.tiny_sleep = false
--inst.sg.statemem.iswaking = true
inst.sg:GoToState("wakeup")
inst.entity:AddLight()
inst.Light:SetRadius(1)
inst.Light:SetFalloff(.8)
inst.Light:SetIntensity(.8)
inst.Light:SetColour(150/255,150/255,150/255)
--inst.components.health:SetAbsorptionAmount(1)
--inst.music_armor = true
inst.Light:Enable(true)
if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end
inst.music_check = false
inst.switlight = true
inst:DoTaskInTime(2, function() inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_READY) inst.sg:GoToState("play_flute2") inst.Light:Enable(false) inst.music_armor = false inst.music_check = false if inst.wormlight == nil then
	inst.AnimState:SetBloomEffectHandle( "" )
	end inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband") inst.musha_press = false inst.components.playercontroller:Enable(true) 
end)

end
end

 function on_buff_act(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
local performance0 = 1
local performance1 = 0.25
local performance2 = 0.3
local performance3 = 0.1
local performance4 = 0.15
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then	
			local emote = "sad"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_RIDE)
		else
			local emote = "dance"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
if inst.treasure_sniffs then
	on_treasure_hunt(inst)
	inst.treasure = inst.treasure *0
	inst.treasure_sniffs = false
elseif not inst.treasure_sniffs then

if inst.switlight and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.start_music then
inst.start_music = true
inst.music = inst.music * 0
inst.switlight = false
	if math.random() < 0.5 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE.. "1")
	on_music_act1(inst)
	elseif math.random() < 0.3 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE.. "2")
	on_music_act2(inst)
	elseif math.random() < 0.15 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE.. "3")
	on_music_act3(inst)
	else
	inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE.. "4")
	on_music_act1(inst)
	end
	
	if inst.planttask == nil then
	inst.planttask = inst:DoPeriodicTask(.25, PlantTick)
	end
	
	
elseif not inst.switlight and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
	if inst.music < 100 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEP)
	elseif inst.music >= 100 then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_READY)
	inst.switlight = true
	end
	
elseif inst.components.health:IsDead() or inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_MUSIC)
end
----inst.components.talker.colour = Vector3(1, 0.85, 0.75, 1)
end
end
end
end
AddModRPCHandler("musha", "buff", on_buff_act)
 
 
 
  function on_sleeping(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and inst.components.stamina_sleep.current >= 90 then
if TheWorld.state.isday and not inst.tiny_sleep then 

if math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_1)
elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_2)
elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_3)
elseif math.random() < 0.2 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_4)
else
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_5)
end

elseif TheWorld.state.isday and inst.tiny_sleep and not inst.musha_press then 
inst.musha_press = true
on_wakeup(inst)
end   
elseif not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and inst.components.stamina_sleep.current < 90 then
if TheWorld.state.isday and not inst.tiny_sleep then 
if (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_3)
end
if inst.components.stamina_sleep.current >=40 and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
elseif inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >=25  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
elseif inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >=5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
elseif inst.components.stamina_sleep.current < 5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
end
inst:DoTaskInTime(1, function() on_tiny_sleep(inst) end)
inst.sg:AddStateTag("busy")
elseif TheWorld.state.isday and inst.tiny_sleep and not inst.musha_press then 
inst.musha_press = true
on_wakeup(inst)
end
end 
if not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and not TheWorld.state.isday and not inst.sleep_on and not inst.tiny_sleep and not inst.nsleep and not (inst.warm_on or inst.warm_tent) then
if not TheWorld.state.isnight then
if inst.components.stamina_sleep.current >=40 and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
elseif inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >=25  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
elseif inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >=5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
elseif inst.components.stamina_sleep.current < 5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
end
inst:DoTaskInTime(1, function() on_tiny_sleep(inst) end)
inst.sg:AddStateTag("busy")
elseif TheWorld.state.isnight then
local random1 = 0.2
local last = 1
if not inst.LightWatcher:IsInLight() then
if math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_1)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_2)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_3)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_4)
elseif math.random() <= last then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_5)
end
elseif inst.LightWatcher:IsInLight() then
if inst.components.stamina_sleep.current >=40 and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
elseif inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >=25  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
elseif inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >=5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
elseif inst.components.stamina_sleep.current < 5  and not (inst.warm_on or inst.warm_tent) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
end
inst:DoTaskInTime(1, function() on_tiny_sleep(inst) end)
end
end

elseif not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and not TheWorld.state.isday and not inst.sleep_on and not inst.tiny_sleep and not inst.nsleep and (inst.warm_on or inst.warm_tent) and not inst.sleep_no then 

local random1 = 0.2
if math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_1)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_2)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_3)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_4)
else
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD)
end
on_sleep(inst)

elseif not TheWorld.state.isday	and not inst.sleep_on and not inst.tiny_sleep and not inst.nsleep and (inst.warm_on or inst.warm_tent) and  inst.sleep_no then 
local random1 = 0.2
if math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_1)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_2)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_3)
elseif math.random() < random1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_4)
elseif math.random() <= 1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_5)
end
elseif not inst.components.health:IsDead() and (inst.sleep_on or inst.tiny_sleep) and not inst.nsleep and not inst:HasTag("playerghost") and not inst.musha_press then
inst.musha_press = true
on_wakeup(inst)

elseif inst.components.health:IsDead() or inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
----inst.components.talker.colour = Vector3(1, 0.85, 0.75, 1)
end
 --end
 AddModRPCHandler("musha", "sleeping", on_sleeping)
 
  ---------------------moon tree
 
 function dall_update(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"dall"})
for k,v in pairs(ents) do
if inst.follow_dall and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("dall") == 0 then
if not v.onsleep then
inst.components.leader:AddFollower(v)
v.yamche = true
v.sleep_on = false
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_FOLLOW)
local emote = "happy"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
elseif v.onsleep then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_SLEEPY)

end
elseif not inst.follow_dall and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("dall") == 1 then
if not v.onsleep then
v.yamche = true 
v.sleep_on = true
inst.components.leader:RemoveFollowersByTag("dall")
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_STAY)

elseif v.onsleep then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_SLEEPY)

end
end end end
 
 function order_dall(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
			
if inst.dall_follow and not inst.follow_dall and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then

inst.follow_dall = true
dall_update(inst)
elseif inst.dall_follow and inst.follow_dall and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then

inst.follow_dall = false
inst.dall_follow = false
dall_update(inst)
elseif not inst.dall_follow and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_LOST)
elseif inst.dall_follow and not inst.follow_dall and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
inst.follow_dall = true
dall_update(inst)
elseif inst.dall_follow and inst.follow_dall and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
inst.follow_dall = false
inst.dall_follow = false
dall_update(inst)
elseif not inst.dall_follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
end
end 

AddModRPCHandler("musha","dall", order_dall)
-----pet

 
 ---------------------arong
 
 function arong_update(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"Arongb"})
for k,v in pairs(ents) do
if inst.follow_arong and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("Arongb") == 0 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_FOLLOW)
local emote = "happy"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
inst.components.leader:AddFollower(v)
v.yamche = true
v.mount = true
v.sleep_on = false
v.follow = true
elseif not inst.follow_arong and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("Arongb") == 1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_STAY)

v.yamche = true 
v.active_hunt = false
v.mount = false
v.sleep_on = true
v.follow = false
inst.components.leader:RemoveFollowersByTag("Arongb")
end end 
end
 
 function order_arong(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
if inst.arong_follow and not inst.follow_arong and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.follow_arong = true
arong_update(inst)
elseif inst.arong_follow and inst.follow_arong and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.follow_arong = false
inst.arong_follow = false
arong_update(inst)
elseif not inst.arong_follow and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_LOST)
elseif inst.arong_follow and not inst.follow_arong and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
inst.follow_arong = true
arong_update(inst)
elseif inst.arong_follow and inst.follow_arong and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
inst.follow_arong = false
inst.arong_follow = false
arong_update(inst)
elseif not inst.arong_follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
end
end 

AddModRPCHandler("musha","arong", order_arong)
 
 -----------------------------
 function yamche_update(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"yamcheb"})
for k,v in pairs(ents) do
if not v.house and not v.hat then
if inst.follow and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("yamcheb") == 0 then
inst.components.leader:AddFollower(v)
v.MiniMapEntity:SetIcon( "" )
--on_yamche(inst)
v.yamche = true
v.sleepn = false 
v.fightn = false
v.slave = true
--off_yamche(inst)
elseif not inst.follow and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("yamcheb") == 1 then
v.sleepn = true
v.yamche = true 
v.fightn = true
v.active_hunt = false
v.slave = false
inst.components.leader:RemoveFollowersByTag("yamcheb")
v.MiniMapEntity:SetIcon( "musha_small.txt" )
if v.pick1 then
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER_STOP)
v.pick1 = false
v.working_food = false
end
end end end
end
 
 function order_yamche(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing and not inst.hat and not inst.house then
if inst.yamche_follow and not inst.follow and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_FOLLOW)
local emote = "happy"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
inst.follow = true
--master_yamche(inst)
yamche_update(inst)
elseif inst.yamche_follow and inst.follow and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_STAY)

inst.follow = false
inst.yamche_follow = false
--master_yamche(inst)
yamche_update(inst)
elseif not inst.yamche_follow and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LOST)

elseif inst.yamche_follow and not inst.follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
inst.follow = true
yamche_update(inst)
elseif inst.yamche_follow and inst.follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
inst.follow = false
inst.yamche_follow = false
yamche_update(inst)
elseif not inst.yamche_follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
end
end 

AddModRPCHandler("musha","yamche", order_yamche)

--sneak attack --hide in shadow
 
 function on_Sneak_pang(inst, data)
local other = data.target
if not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") then
if not inst.sneaka and inst.sneak_pang then
	inst.components.sanity:DoDelta(50)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	 
	inst:RemoveTag("notarget")
	inst.sneaka = false
	if inst.poison_sneaka then	
		inst.poison_sneaka = false
		inst.components.sanity:DoDelta(10)
	end
	inst.sneak_pang = false	
elseif inst.sneaka and inst.sneak_pang and (other:HasTag("no_target") or other:HasTag("structure") or other:HasTag("wall") or other:HasTag("pillarretracting") or other:HasTag("tentacle_pillar") or other:HasTag("arm") or other:HasTag("shadow")) and  other.components.locomotor ~= nil then
	inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_NO_TARGET)
		inst.components.sanity:DoDelta(50)
	--inst.components.talker:Say("Unhide !")
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	 
	inst:RemoveTag("notarget")
	inst.sneaka = false
	if inst.poison_sneaka then	
		inst.poison_sneaka = false
		inst.components.sanity:DoDelta(10)
	end
	inst.sneak_pang = false	
elseif inst.sneaka and inst.sneak_pang and not (other:HasTag("no_target") or other:HasTag("structure") or other:HasTag("wall") or other:HasTag("pillarretracting") or other:HasTag("tentacle_pillar") or other:HasTag("arm") or other:HasTag("shadow")) and other.components.locomotor ~= nil then	

if not (other.sg:HasStateTag("attack") and other.sg:HasStateTag("shield") and other.sg:HasStateTag("moving")) and not other.sg:HasStateTag("frozen") then
	inst.components.sanity:DoDelta(50)
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)


if inst.level >=50 and inst.level <429  then  --5
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(1)")
	other.components.health:DoDelta(-300)
elseif inst.level >=430 and inst.level <1029  then  --10
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(2)")
	other.components.health:DoDelta(-400)
elseif inst.level >=1030 and inst.level <1879  then --15
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(3)")
	other.components.health:DoDelta(-500)
elseif inst.level >=1880 and inst.level <3199  then --20
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(4)")
	other.components.health:DoDelta(-600)
elseif inst.level >=3200 and inst.level <6999 then --25
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(5)")
	other.components.health:DoDelta(-700)
elseif inst.level >=7000 then --30
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\nLV(6)")
    other.components.health:DoDelta(-800)
end
	
	inst.switch = false
	inst.components.combat:SetRange(2)

	local dark1 = SpawnPrefab("statue_transition")
	local pos = Vector3(other.Transform:GetWorldPosition())
	dark1.Transform:SetPosition(pos:Get())
	dark1.Transform:SetScale(0.5,4,0.5)
	local fx = SpawnPrefab("explode_small")
	local pos = Vector3(other.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
	inst:RemoveTag("notarget")
	inst.sneak_pang = false	inst.sneaka = false
	inst:RemoveEventCallback("onhitother", on_Sneak_pang)
	
elseif other.sg:HasStateTag("frozen") then
	inst.components.sanity:DoDelta(50)
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS.."\n"..STRINGS.MUSHA_TALK_SNEAK_FROZEN)
    if inst.level >=50 and inst.level <429  then  --5
	other.components.health:DoDelta(-150)
elseif inst.level >=430 and inst.level <1029  then  --10
	other.components.health:DoDelta(-200)
elseif inst.level >=1030 and inst.level <1879  then --15
	other.components.health:DoDelta(-250)
elseif inst.level >=1880 and inst.level <3199  then --20
	other.components.health:DoDelta(-300)
elseif inst.level >=3200 and inst.level <6999 then --25
	other.components.health:DoDelta(-350)
elseif inst.level >=7000 then --30
    other.components.health:DoDelta(-400)
	end
	local dark1 = SpawnPrefab("statue_transition")
	local pos = Vector3(other.Transform:GetWorldPosition())
	dark1.Transform:SetPosition(pos:Get())
	dark1.Transform:SetScale(0.5,4,0.5)
	local fx = SpawnPrefab("explode_small")
	local pos = Vector3(other.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
	inst:RemoveTag("notarget")
	inst.sneak_pang = false	inst.sneaka = false
	inst:RemoveEventCallback("onhitother", on_Sneak_pang)
	
elseif (other.sg:HasStateTag("attack") or other.sg:HasStateTag("shield") or other.sg:HasStateTag("moving")) and not other.sg:HasStateTag("frozen") then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_FAILED)
	local fx = SpawnPrefab("splash")
	local pos = Vector3(other.Transform:GetWorldPosition())
	fx.Transform:SetPosition(pos:Get())
	inst:RemoveTag("notarget")
	inst.sneak_pang = false	inst.sneaka = false
	inst:RemoveEventCallback("onhitother", on_Sneak_pang)
	--inst:DoTaskInTime(0.5, function() on_tiny_sleep(inst) end)
end
	if inst.poison_sneaka then
	inst.poison_sneaka = false
	if other.components.health ~= nil and not other.components.health:IsDead() and other.components.combat ~= nil then		
			local shadowbomb = SpawnPrefab("shadowbomb")
			if shadowbomb then
			shadowbomb.entity:SetParent(other.entity)
			local follower = shadowbomb.entity:AddFollower()
			if not other:HasTag("cavedweller") then
			follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, -200, 0.5 )
			else
			follower:FollowSymbol(other.GUID, "body", 0, -200, 0.5 )
			end
			end	
	else 		
		local cloud = SpawnPrefab("sporecloud2")
			cloud.Transform:SetPosition(other:GetPosition():Get())
			cloud:FadeInImmediately()		
	end
	end
end 
end
end
 
 function hide_discorved(inst, data)
    if inst.sneak_pang then
	inst.components.colourtweener:StartTween({1,1,1,1}, 0)
	inst.sneak_pang = false		
	inst.sneaka = false
	inst.poison_sneaka = false
	inst:RemoveTag("notarget")
	local fx = SpawnPrefab("statue_transition_2")
        fx.entity:SetParent(inst.entity)
	fx.Transform:SetScale(1.2, 1.2, 1.2)
        fx.Transform:SetPosition(0, 0, 0.5)
	inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_ATTACKED)
	inst:RemoveEventCallback("onhitother", on_Sneak_pang)
	inst:RemoveEventCallback("attacked", hide_discorved)	
    end end
 
 function HideIn(inst)	
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
 
if not (inst.tiny_sleep or inst.sleep_on) then
if inst.level <50 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_NEED_EXP)
	if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
	inst.sg:GoToState("repelled")
	else
	--inst.sg:GoToState("mindcontrolled")
	inst.sg:GoToState("mindcontrolled_pst")
	end
elseif inst.level >=50 then
    if not inst.sneak_pang and inst.components.sanity.current >= 50 and inst.components.stamina_sleep.current >= 30 then
	if inst.level >=50 and inst.level <429  then  --5
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV1)")
elseif inst.level >=430 and inst.level <1029  then  --10
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV2)")
elseif inst.level >=1030 and inst.level <1879  then --15
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV3)")
elseif inst.level >=1880 and inst.level <3199  then --20
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV4)")
elseif inst.level >=3200 and inst.level <6999 then --25
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV5)")
elseif inst.level >=7000 then --30
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE.."(LV6)")
	end
	inst.components.sanity:DoDelta(-50)
			inst.sneak_pang = true  
				inst.components.colourtweener:StartTween({0.3,0.3,0.3,1}, 0)		
local fx = SpawnPrefab("statue_transition_2")
      fx.entity:SetParent(inst.entity)
	  fx.Transform:SetScale(1.2, 1.2, 1.2)
      fx.Transform:SetPosition(0, 0, 0.5)
	
inst:DoTaskInTime( 4, function() if inst.sneak_pang then 
inst.sneaka = true 
inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SHADOW) 
	local fx = SpawnPrefab("stalker_shield_musha")
	  fx.Transform:SetScale(0.5, 0.5, 0.5)
  	  fx.Transform:SetPosition(inst:GetPosition():Get())
	if not inst:HasTag("notarget") then
	inst:AddTag("notarget") end
SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get()) 
inst.components.colourtweener:StartTween({0.1,0.1,0.1,1}, 0) 
inst.in_shadow = true
InShadow(inst)  
end 
end)
		
	inst:ListenForEvent("onhitother", on_Sneak_pang)
	inst:ListenForEvent("attacked", hide_discorved)
	
elseif not inst.sneak_pang and inst.components.sanity.current < 50 and inst.components.stamina_sleep.current >= 30 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
elseif not inst.sneak_pang and inst.components.sanity.current > 50 and inst.components.stamina_sleep.current < 30 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEPY)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
elseif not inst.sneak_pang and inst.components.sanity.current < 50 and inst.components.stamina_sleep.current < 30 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEP)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
inst.sg:GoToState("repelled")
else
inst.sg:GoToState("mindcontrolled_pst")
end
		
elseif inst.sneak_pang then		
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)	
			inst.components.colourtweener:StartTween({1,1,1,1}, 0)
			local fx = SpawnPrefab("statue_transition_2")
      fx.entity:SetParent(inst.entity)
	  fx.Transform:SetScale(1.2, 1.2, 1.2)
      fx.Transform:SetPosition(0, 0, 0.5)
		inst.components.sanity:DoDelta(50)
	inst.sneak_pang = false	inst.sneaka = false
	inst.poison_sneaka = false
	inst:RemoveTag("notarget")
	inst:RemoveEventCallback("onhitother", on_Sneak_pang)
	inst:RemoveEventCallback("attacked", hide_discorved)
end	
end	
end
end	

end
	
AddModRPCHandler("musha","shadows", HideIn)

-----------------------------------------------
function hiteffectsymbol_hound(inst)
if IsServer then
inst.components.combat.hiteffectsymbol = "hound_body"
end end
function hiteffectsymbol_frog(inst)
if IsServer then
inst.components.combat.hiteffectsymbol = "frogsack"
end end
function hiteffectsymbol_body(inst)
if IsServer then
 inst.components.combat.hiteffectsymbol = "body"
end end
AddPrefabPostInit("hound", hiteffectsymbol_hound)
AddPrefabPostInit("firehound", hiteffectsymbol_hound)
AddPrefabPostInit("icehound", hiteffectsymbol_hound)
AddPrefabPostInit("frog", hiteffectsymbol_frog)
AddPrefabPostInit("hound", hiteffectsymbol_body)


function electric_weapon(inst)
if IsServer then
        inst:AddTag("electric_weapon")
end end
AddPrefabPostInit("nightstick", electric_weapon)
function no_target(inst)
if IsServer then
        inst:AddTag("no_target")
end end
AddPrefabPostInit("slurtlehole", no_target)

function arms(inst)
if IsServer then
        inst:AddTag("arm")
end end
AddPrefabPostInit("tentacle_pillar_arm", arms)

function green_mush(inst)
if IsServer then
	 inst:AddComponent("follower")
	 inst:AddTag("mushrooms")
end end
function veggie(inst)
if IsServer then
	 inst:AddComponent("follower")
	 inst:AddTag("wild_veggie")
	 
end end
AddPrefabPostInit("farm_plant_randomseed", veggie)
AddPrefabPostInit("green_mushroom", green_mush)

-----------------------------------------------
local function visual_cos(inst)
----------------------------------------------
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing and not inst.visual_cos then
	inst.musha_full = false
	inst.musha_normal = false
	inst.musha_battle = false
	inst.musha_hunger = false

inst.visual_cos = true
inst.components.talker:Say(STRINGS.MUSHA_VISUAL_BASE)
inst.soundsname = "willow"
inst.set_on = false
inst.visual_hold = false

inst.visual_hold2 = false
inst.visual_hold3 = false
inst.visual_hold4 = false
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
inst.willow = false
inst.wigfred = false
inst.change_visual = false
end

inst.visual_cos = false

end

AddModRPCHandler("musha","visual_cos", visual_cos)


AddModRPCHandler("musha","visual_human", visual_human)

-----------------------------------------------
local function visual_hold(inst)
----------------------------------------------
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing and not inst:HasTag("playerghost") then
if not inst.visual_cos then
	inst.musha_full = false
	inst.musha_normal = false
	inst.musha_battle = false
	inst.musha_hunger = false
if not inst.willow and not inst.wigfred then
inst.change_visual = true
inst.willow = true
inst.components.talker:Say("[Visual] : Willow \nCancel(O)key")
inst.AnimState:SetBuild("Willow")
inst.wigfred = false
elseif inst.willow and not inst.wigfred then
inst.change_visual = true
inst.willow = true
inst.components.talker:Say("[Visual] : Wigfred \nCancel(O)key")
inst.AnimState:SetBuild("wathgrithr")
inst.wigfred = true
elseif inst.willow and inst.wigfred then
inst.change_visual = false
if not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key\nVisual:[Auto] SET 1")
inst.set_on = true
inst.visual_hold = true
inst.visual_hold2 = false
inst.visual_hold3 = false
inst.visual_hold4 = false
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
--inst.AnimState:SetBuild("musha")

elseif inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 2")
inst.set_on = true
inst.visual_hold = false
inst.visual_hold2 = true
inst.visual_hold3 = false
inst.visual_hold4 = false
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false

elseif not inst.visual_hold and inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 3")
inst.set_on = true
inst.visual_hold = false
inst.visual_hold2 = false
inst.visual_hold3 = true
inst.visual_hold4 = false
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false

elseif not inst.visual_hold and not inst.visual_hold2 and inst.visual_hold3 and not inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 4")
inst.set_on = true
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
--[[
elseif not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 5")
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
]]
----------------------------------------------
elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Full]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = false
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and not inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Normal]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = false
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_normal")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and not inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Valkyrie]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = false
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true

inst.AnimState:SetBuild("musha_battle")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and not inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Berserk]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = false
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_hunger")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and not inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 1]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = false
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_old")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and not inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 2]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = false
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_normal_old")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and not inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 3]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = false
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_battle_old")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and not inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 4]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = false
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_hunger_old")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and not inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 5]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = false
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_full_sw2")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and not inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 6]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = false
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_normal_sw2")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and not inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 7]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = false
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true
inst.AnimState:SetBuild("musha_battle_sw2")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and not inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 8]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = false
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true

inst.AnimState:SetBuild("musha_hunger_sw2")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and not inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 9]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = false
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true

inst.AnimState:SetBuild("musha_full_k")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and not inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 10]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = false
inst.berserk_k_hold = true

inst.AnimState:SetBuild("musha_normal_k")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and not inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 11]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = false

inst.AnimState:SetBuild("musha_battle_k")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 12]")
inst.set_on = false
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = true
inst.normal_hold = true
inst.valkyrie_hold = true
inst.berserk_hold = true
inst.hold_old1 = true
inst.hold_old2 = true
inst.hold_old3 = true
inst.hold_old4 = true
inst.hold_old5 = true
inst.hold_old6 = true
inst.hold_old7 = true
inst.hold_old8 = true
inst.full_k_hold = true
inst.normal_k_hold = true
inst.valkyrie_k_hold = true
inst.berserk_k_hold = true

inst.AnimState:SetBuild("musha_hunger_k")

elseif inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and inst.full_hold and inst.normal_hold and inst.valkyrie_hold and inst.berserk_hold and inst.hold_old1 and inst.hold_old2 and inst.hold_old3 and inst.hold_old4 and inst.hold_old5 and inst.hold_old6 and inst.hold_old7 and inst.hold_old8 and inst.full_k_hold and inst.normal_k_hold and inst.valkyrie_k_hold and inst.berserk_k_hold then
inst.components.talker:Say("[Visual Hold - Off] \nVisual:[Auto]")
inst.set_on = false
inst.visual_hold = false
inst.visual_hold = false
inst.visual_hold2 = false
inst.visual_hold3 = false
inst.visual_hold4 = false
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
inst.willow = false
inst.wigfred = false
inst.change_visual = false
end 
end
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end end
end
AddModRPCHandler("musha","visual_hold", visual_hold)

local function yamche2(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
--hunt --defense --avoid
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"yamche"})
for k,v in pairs(ents) do
if not inst.components.leader:IsFollower(v) and v:HasTag("yamcheb") and not inst:HasTag("playerghost") and inst.components.leader:CountFollowers("yamcheb") == 0 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_SLEEPY)
elseif v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.peace and not v.active_hunt and not v.defense and not inst:HasTag("playerghost") and not inst.berserks and not inst.fberserk then
v.yamche = true 
if v:HasTag("yamcheb") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNT)
--v.components.talker:Say("[Aggressive]\nArmor:40")
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_OFFENSE)
v.peace = false
v.active_hunt = true
v.defense = false
v.crazyness = false

end
elseif v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.peace and v.active_hunt and not v.defense and inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and not inst.berserks and not inst.fberserk then
v.yamche = true 
if v:HasTag("yamcheb") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_RETREAT)
--v.components.talker:Say("[Avoidance]\nArmor:95")
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
v.peace = true
v.active_hunt = false
v.defense = true
v.crazyness = true

end
elseif v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and v.peace and not v.active_hunt and v.defense and inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and not inst.berserks and not inst.fberserk then
v.yamche = true 
if v:HasTag("yamcheb") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_PROTECT)
--v.components.talker:Say("[Defensive]\nArmor:60")
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DEFFENSE)
v.peace = false
v.active_hunt = false
v.defense = false
v.crazyness = false
	
end
elseif v.components.follower and v.components.follower.leader and v.peace and inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and (inst.berserks or inst.fberserk) then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_BERSERK)
v.yamche = true 
if v:HasTag("yamcheb") then
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
v.peace = true
v.active_hunt = false
v.defense = true
v.crazyness = true

end
elseif v.components.follower and v.components.follower.leader and not v.peace and inst.components.leader:IsFollower(v) and inst:HasTag("playerghost") and not inst.berserks and not inst.fberserk then
v.yamche = true 
if v:HasTag("yamcheb") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GHOST)
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
v.peace = true
v.active_hunt = false
v.defense = true
v.crazyness = false
end
elseif v.components.follower and v.components.follower.leader and v.peace and inst.components.leader:IsFollower(v) and inst:HasTag("playerghost") and not inst.berserks and not inst.fberserk then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOHHHH)
v.yamche = true 
if v:HasTag("yamcheb") then
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DEFFENSE)
v.peace = false
v.active_hunt = false
v.defense = false
v.crazyness = false
end
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end end end
end
AddModRPCHandler("musha","yamche2", yamche2)

local function yamche3(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"yamcheb"})
for k,v in pairs(ents) do
if not v.removinv then
if v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and v.level1 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LEVEL1)
v.yamche = true

elseif not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and v.components.container and v.item_max_full then	
	v.working_food = false
	v.pick1 = false
	v.drop = true
	v.item_1 = false 
	v.item_ready_drop = false
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_SHOWME)
	v.yamche = true

	SpawnPrefab("dr_warm_loop_2").Transform:SetPosition(v:GetPosition():Get())
		if not v.light_on then
		v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
		elseif v.light_on then
		v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x8)")
		end

elseif not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.pick1 and not inst:HasTag("playerghost") and not v.item_max_full then 
	
	inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER)
	local emote = "cheer"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
	v.working_food = true
	v.pick1 = true
	v.drop = false
	v.yamche = true 

	if not v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x6)")
	elseif v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."+"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x14)")
	end
	
elseif not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and v.pick1 and not inst:HasTag("playerghost") and not v.item_max_full then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER_STOP)
v.working_food = false
v.pick1 = false
v.drop = true
v.yamche = true 
	if not v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
	elseif v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x8)")
	end


elseif not v.level1 and not inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and inst.components.leader:CountFollowers("yamcheb") == 0 then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_EGG)
elseif v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.pick1 and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_GATHER)
v.working_food = true
v.pick1 = true
v.drop = false
v.yamche = true 

	if not v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x6)")
	elseif v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."+"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x14)")
	end
elseif not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and v.pick1 and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STOP)
v.working_food = false
v.pick1 = false
v.drop = true
	if not v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x1)")
	elseif v.light_on then
	v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT.."\n"..STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY.."(x8)")
	end
end
----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end 
end
--
local x,y,z = inst.Transform:GetWorldPosition()
local critter = TheSim:FindEntities(x,y,z, 25, {"critter"})
for k,v in pairs(critter) do
if v.components.follower.leader and inst.components.leader:IsFollower(v) and v.components.container ~= nil and v.critter_musha and inst.components.leader:CountFollowers("yamcheb") == 0 then

--v.pet_mood_check = true
if v.components.container:IsFull() then
		if v.components.locomotor ~= nil then
		v.components.locomotor:StopMoving()
		end
		local emote = "annoyed"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
	v.AnimState:PlayAnimation("distress")
	v.components.machine:TurnOff()
	v.working_on = false
	v.item_ready_drop = false
	v.working_food = false
	v.pick1 = false
	v.collect_off = true
else

if not v.pick1 and not v.working_food then

if v.components.container ~= nil then
v.components.container:Close()
v.collect_work = true
end

inst.components.talker:Say(STRINGS.CRITTER_GATHERING)
local emote = "cheer"
			if emote ~= nil then
				MushaCommands.RunTextUserCommand(emote, inst, false)
			end
		v.components.machine:TurnOn()
		v.working_on = true
		v.item_ready_drop = true
			if v.components.locomotor ~= nil then
			v.components.locomotor:StopMoving()
			end
		local random_ani = math.random(1, 2)
		if random_ani == 1 then
		v.sg:GoToState("playful")
		else
		v.AnimState:PlayAnimation("emote_nuzzle")
		end
	
	v.item_ready_drop = true
	v.working_food = true
	v.pick1 = true
	
elseif v.pick1 or v.working_food then
	
if v.components.container ~= nil then
v.collect_work = false
end

inst.components.talker:Say(STRINGS.CRITTER_STOP_GATHER)
v.components.machine:TurnOff()
v.working_on = false

	if v.components.locomotor ~= nil then
	v.components.locomotor:StopMoving()
	end
if v.prefab == "critter_lamb" then
v.AnimState:PlayAnimation("distress")
v.SoundEmitter:PlaySound("dontstarve/creatures/together/sheepington/yell") 
else
v.sg:GoToState("emote_cute")
end

	v.item_ready_drop = false
	v.working_food = false
	v.pick1 = false
	
end

end
elseif v.components.follower.leader and inst.components.leader:IsFollower(v) and v.components.container ~= nil and v.critter_musha and inst.components.leader:CountFollowers("yamcheb") >= 1 then
	v.follow_yamche = true
end 
end
end
end

AddModRPCHandler("musha","yamche3", yamche3)


--[[local function ydebug(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then

if not inst.sleepbadge_off then
inst.sleepbadge_off = true
inst.components.talker:Say(STRINGS.MUSHA_BADGE_SLEEP.."\nOFF")
elseif inst.sleepbadge_off then
inst.sleepbadge_off = false
inst.components.talker:Say(STRINGS.MUSHA_BADGE_SLEEP.."\nON")
		inst.sleep_debuff_reset = true
		inst.sleep_debuff_90 = false
		inst.sleep_debuff_70 = false
		inst.sleep_debuff_50 = false
		inst.sleep_debuff_30 = false
end
end
end

AddModRPCHandler("musha","ydebug", ydebug)]]

------------------------------------------------
-------------comfortable health info
local healthinfoActive = 0
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Health Info" then
		healthinfoActive = 1
   end end 

-------------------------------------------------
--yamche health/hunger info (thx health info)

if healthinfoActive == 0 or healthinfoActive == 1 then
AddClassPostConstruct("components/health_replica", function(self)
self.SetCurrent = function(self, current)
if self.inst.components and self.inst.components.health and self.inst.components.healthinfo_copy and self.inst.components.hungerinfo and (self.inst:HasTag("yamche") or self.inst:HasTag("arongbaby")) then
---------
local str = self.inst.components.healthinfo_copy.text
if str ~= nil then
			local h = self.inst.components.health
			local mx = math.floor(h.maxhealth-h.minhealth)
			local cur = math.floor(h.currenthealth-h.minhealth)
			local h2 = self.inst.components.hunger
			local mx2 = math.floor(h2.max-h2.hungerrate)
			local cur2 = math.floor(h2.current-h2.hungerrate)
local i,j = string.find(str, " [", nil, true)
if i ~= nil and i > 1 then str = string.sub(str, 1, (i-1)) end
str = "["..math.floor(cur*100/mx).."%/"..math.floor(cur2*100/mx2).."%]"
if self.inst.components.healthinfo_copy and (self.inst:HasTag("yamche") or self.inst:HasTag("arongbaby"))  then
self.inst.components.healthinfo_copy:SetText(str)
end end 
end
if self.classified ~= nil then
self.classified:SetValue("currenthealth", current)
end end end)
--hover text
AddGlobalClassPostConstruct('widgets/hoverer', 'HoverText', function(self)
self.OnUpdate = function(self)
local using_mouse = self.owner.components and self.owner.components.playercontroller:UsingMouse()
if using_mouse ~= self.shown then
if using_mouse then
self:Show()
else
self:Hide()
end end
if not self.shown then
return
end
local str = nil
if self.isFE == false then
str = self.owner.HUD.controls:GetTooltip() or self.owner.components.playercontroller:GetHoverTextOverride()
else
str = self.owner:GetTooltip()
end
local secondarystr = nil
local lmb = nil
if not str and self.isFE == false then
lmb = self.owner.components.playercontroller:GetLeftMouseAction()
if lmb then
str = lmb:GetActionString()
if lmb.target and lmb.invobject == nil and lmb.target ~= lmb.doer then
local name = lmb.target:GetDisplayName() or (lmb.target.components.named and lmb.target.components.named.name)
if name then
local adjective = lmb.target:GetAdjective()
if adjective then
str = str.. " " .. adjective .. " " .. name
else
str = str.. " " .. name
end
if lmb.target.replica.stackable ~= nil and lmb.target.replica.stackable:IsStack() then
str = str .. " x" .. tostring(lmb.target.replica.stackable:StackSize())
end
if lmb.target.components.inspectable and lmb.target.components.inspectable.recordview and lmb.target.prefab then
GLOBAL.ProfileStatsSet(lmb.target.prefab .. "_seen", true)
end end end
if lmb.target and lmb.target ~= lmb.doer and lmb.target.components and lmb.target.components.healthinfo_copy and lmb.target.components.healthinfo_copy.text ~= '' then
local name = lmb.target:GetDisplayName() or (lmb.target.components.named and lmb.target.components.named.name) or "" 
local i,j = string.find(str, " " .. name, nil, true)
if i ~= nil and i > 1 then str = string.sub(str, 1, (i-1)) end
str = str.. " " .. name .. " " .. lmb.target.components.healthinfo_copy.text
end end
local rmb = self.owner.components.playercontroller:GetRightMouseAction()
if rmb then
secondarystr = GLOBAL.STRINGS.RMB .. ": " .. rmb:GetActionString()
end end
if str then
if self.strFrames == nil then self.strFrames = 1 end
if self.str ~= self.lastStr then
--print("new string")
self.lastStr = self.str
self.strFrames = SHOW_DELAY
else
self.strFrames = self.strFrames - 1
if self.strFrames <= 0 then
if lmb and lmb.target and lmb.target:HasTag("player") then
self.text:SetColour(lmb.target.playercolour)
else
self.text:SetColour(1,1,1,1)
end
self.text:SetString(str)
self.text:Show()
end end
else
self.text:Hide()
end
if secondarystr then
YOFFSETUP = -80
YOFFSETDOWN = -50
self.secondarytext:SetString(secondarystr)
self.secondarytext:Show()
else
self.secondarytext:Hide()
end
local changed = (self.str ~= str) or (self.secondarystr ~= secondarystr)
self.str = str
self.secondarystr = secondarystr
if changed then
local pos = TheInput:GetScreenPosition()
self:UpdatePosition(pos.x, pos.y)
end end end)
end

--------------------------------
AddPrefabPostInitAny(function(inst)
	if inst.components.healthinfo_copy == nil and inst:HasTag("yamche") then
		if not inst.components.healthinfo_copy then
		inst:AddComponent("healthinfo_copy")
		end
		if not inst.components.healthinfo_copy then
		inst:AddComponent("hungerinfo")
		end
	Updateyamche = inst:DoPeriodicTask(0.2, function()
	if inst.components.health and inst.components.hunger then
			str = ""
			local h=inst.components.health
			local mx=math.floor(h.maxhealth-h.minhealth)
			local cur=math.floor(h.currenthealth-h.minhealth)
			local h2 = inst.components.hunger
			local mx2 = math.floor(h2.max-h2.hungerrate)
			local cur2 = math.floor(h2.current-h2.hungerrate)
			str = "["..math.floor(cur*100/mx).."%/"..math.floor(cur2*100/mx2).."%]"
			--str = "\nHealth: "..math.floor(cur*100/mx).."%\nHunger: "..math.floor(cur2*100/mx2).."%"
		inst.components.healthinfo_copy:SetText(str)
		end	
		end) 
		end
end)		

AddPrefabPostInitAny(function(inst)
	if inst.components.healthinfo_copy == nil and inst:HasTag("arongbaby") then
		if not inst.components.healthinfo_copy then
		inst:AddComponent("healthinfo_copy")
		end
	if inst.components.health then
			str = ""
			local h=inst.components.health
			local mx=math.floor(h.maxhealth-h.minhealth)
			local cur=math.floor(h.currenthealth-h.minhealth)
			
			str = "["..math.floor(cur*100/mx).."%]"
			--str = "\nHealth: "..math.floor(cur*100/mx).."%\nHunger: "..math.floor(cur2*100/mx2).."%"
		inst.components.healthinfo_copy:SetText(str)
		end	end 
		end)

-------------------------------------------------

  function loud_Lightning_effect(inst)   
 if IsServer then
if Loud_Lightning == "loud1" then
loud_1 = true
elseif Loud_Lightning == "loud2" then
loud_2 = true
elseif Loud_Lightning == "loud3" then
loud_3 = true
end end end
  AddPrefabPostInit("musha", loud_Lightning_effect)


  function Death_Penalty(inst)   
 if IsServer and death_penalty == "off" then
inst.no_panalty = true
end end
  AddPrefabPostInit("musha", Death_Penalty)

---------------------------------------------------
 

 function SleepnTired(inst)   
if IsServer then
   if Badge_type == 0 then
   inst.No_Sleep_Princess = true 
	else
   inst.No_Sleep_Princess = false 
   end 
end
end
 AddPrefabPostInit("musha", SleepnTired)
 

 function never_eat(inst)
 if IsServer then
        inst:AddTag("no_edible")
		end end
AddPrefabPostInit("powcake", never_eat)
AddPrefabPostInit("mandrake", never_eat)
AddPrefabPostInit("cookedmandrake", never_eat)
AddPrefabPostInit("spoiled_food", never_eat)
-----------------------------difficulty test
--
function musha_font(inst)
   inst.components.talker.fontsize = 26
   inst.components.talker.colour = Vector3(0.75, 0.9, 1, 1)
end
AddPrefabPostInit("musha", musha_font)

function Difficulty_health(inst)
if IsServer then
  if DifficultHealth == "easy" then
 inst.easyh = true
  elseif DifficultHealth == "normal" then
 inst.normalh = true
  elseif DifficultHealth == "hard" then
 inst.hardh = true
  elseif DifficultHealth == "hardcore" then
 inst.hardcoreh = true
 end end
end
AddPrefabPostInit("musha", Difficulty_health)

function Difficulty_damage(inst)
if IsServer then
  if DifficultDamage == "newbie" then
  inst.newbied = true
inst.components.combat.damagemultiplier = 1.5
  elseif DifficultDamage == "sveasy" then
  inst.sveasyd = true
inst.components.combat.damagemultiplier = 1.25
  elseif DifficultDamage == "veasy" then
  inst.seasyd = true
inst.components.combat.damagemultiplier = 1
  elseif DifficultDamage == "easy" then
  inst.easyd = true
inst.components.combat.damagemultiplier = .75
  elseif DifficultDamage == "normal" then
  inst.normald = true
inst.components.combat.damagemultiplier = .55
  elseif DifficultDamage == "hard" then
  inst.hardd = true
inst.components.combat.damagemultiplier = .4
  elseif DifficultDamage == "hardcore" then
  inst.hardcored = true
inst.components.combat.damagemultiplier = .25
end end
end
AddPrefabPostInit("musha", Difficulty_damage)

--range weapon damage
function Difficulty_damage_range(inst)
if IsServer then
if DifficultDamage_Range == "veasy" then
inst.veasy = true
elseif DifficultDamage_Range == "easy" then
inst.easy = true
elseif DifficultDamage_Range == "normal" then
inst.normalr = true
elseif DifficultDamage_Range == "hard" then
inst.hardr = true
elseif DifficultDamage_Range == "hardcore" then
inst.hardcorer = true
end end
end
AddPrefabPostInit("musha", Difficulty_damage_range)

function Range_Weapon(inst)
if IsServer then
inst:AddTag("range_weapon")
end end

AddPrefabPostInit("boomerang", Range_Weapon)
AddPrefabPostInit("blowdart_sleep",Range_Weapon )
AddPrefabPostInit("blowdart_fire",Range_Weapon )
AddPrefabPostInit("blowdart_pipe",Range_Weapon )
AddPrefabPostInit("blowdart_walrus",Range_Weapon)
AddPrefabPostInit("blowdart_poison",Range_Weapon )
AddPrefabPostInit("blowdart_yellow",Range_Weapon )

function Difficulty_tired(inst)
if IsServer then
  if Dtired == "dtired_veasy" then
 inst.dtired_veasy = true
  elseif Dtired == "dtired_easy" then
 inst.dtired_easy = true
  elseif Dtired == "dtired_normal" then
 inst.dtired_normal = true
  elseif Dtired == "dtired_hard" then
 inst.dtired_hard = true
  elseif Dtired == "dtired_hardcore" then
 inst.dtired_hardcore = true
 end end
end
AddPrefabPostInit("musha", Difficulty_tired)

function Difficulty_sleep(inst)
if IsServer then
  if Dsleep == "dsleep_veasy" then
 inst.dsleep_veasy = true
  elseif Dsleep == "dsleep_easy" then
 inst.dsleep_easy = true
  elseif Dsleep == "dsleep_normal" then
 inst.dsleep_normal = true
  elseif Dsleep == "dsleep_hard" then
 inst.dsleep_hard = true
  elseif Dsleep == "dsleep_hardcore" then
 inst.dsleep_hardcore = true
 end end
end
AddPrefabPostInit("musha", Difficulty_sleep)

function Difficulty_music(inst)
if IsServer then
  if Dmusic == "dmusic_veasy" then
 inst.dmusic_veasy = true
  elseif Dmusic == "dmusic_easy" then
 inst.dmusic_easy = true
  elseif Dmusic == "dmusic_normal" then
 inst.dmusic_normal = true
  elseif Dmusic == "dmusic_hard" then
 inst.dmusic_hard = true
  elseif Dmusic == "dmusic_hardcore" then
 inst.dmusic_hardcore = true
 end end
end
AddPrefabPostInit("musha", Difficulty_music)

function Difficulty_mana(inst)
if IsServer then
  if Dmana == "dmana_veasy" then
 inst.dmana_veasy = true
  elseif Dmana == "dmana_easy" then
 inst.dmana_easy = true
  elseif Dmana == "dmana_normal" then
 inst.dmana_normal = true
  elseif Dmana == "dmana_hard" then
 inst.dmana_hard = true
  elseif Dmana == "dmana_hardcore" then
 inst.dmana_hardcore = true
  end 
end
end
AddPrefabPostInit("musha", Difficulty_mana)

function Difficulty_sniff(inst)
if IsServer then
  if Dsniff == "easy" then
 inst.dsniff_easy = true
  elseif Dsniff == "normal" then
 inst.dsniff_normal = true
  elseif Dsniff == "hard" then
 inst.dsniff_hard = true
  elseif Dsniff == "hardcore" then
 inst.dsniff_hardcore = true
 end end
end
AddPrefabPostInit("musha", Difficulty_sniff)

function Difficulty_sanity(inst)
if IsServer then
  if DifficultSanity == "newbie" then
 inst.newbies = true
  elseif DifficultSanity == "easy" then
 inst.easys = true
  elseif DifficultSanity == "normal" then
 inst.normals = true
  elseif DifficultSanity == "hard" then
 inst.hards = true
  elseif DifficultSanity == "hardcore" then
 inst.hardcores = true
 end end
end
AddPrefabPostInit("musha", Difficulty_sanity)

--bodyguard wilson
function bodyguardwilson(inst)
if IsServer then
  if bodyguard_wilson == 1 then
	inst.no_bodyguard = true
 end end
end
AddPrefabPostInit("musha", bodyguardwilson)



-------
AddModCharacter("musha","FEMALE")
--table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "musha")

