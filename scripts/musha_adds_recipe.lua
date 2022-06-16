local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
local STRINGS = GLOBAL.STRINGS
TECH = GLOBAL.TECH
local IsServer = GLOBAL.TheNet:GetIsServer()
local containers = require("containers")

local Difficult_Recipe = GetModConfigData("difficultrecipe")
local Gem_Recipe = GetModConfigData("craftgems")
local Smart = GetModConfigData("smartmusha")
---------------------------------------------------------------
-----------[[--recipe--]]-----------

local bladeb = Ingredient( "mushasword_base", 1)
bladeb.atlas = "images/inventoryimages/mushasword_base.xml"
local armora = Ingredient( "armor_mushaa", 1)
armora.atlas = "images/inventoryimages/armor_mushaa.xml"
local phoenixb = Ingredient( "mushasword", 1)
phoenixb.atlas = "images/inventoryimages/mushasword.xml"
local phoenixf = Ingredient( "mushasword_frost", 1)
phoenixf.atlas = "images/inventoryimages/mushasword_frost.xml"

local phoenix_egg = Ingredient( "musha_egg", 1)
phoenix_egg.atlas = "images/inventoryimages/musha_egg.xml"
local phoenix_eggs1 = Ingredient( "musha_eggs1", 1)
phoenix_eggs1.atlas = "images/inventoryimages/musha_eggs1.xml"
local phoenix_eggs2 = Ingredient( "musha_eggs2", 1)
phoenix_eggs2.atlas = "images/inventoryimages/musha_eggs2.xml"
local phoenix_eggs3 = Ingredient( "musha_eggs3", 1)
phoenix_eggs3.atlas = "images/inventoryimages/musha_eggs3.xml"
local phoenix_egg1 = Ingredient( "musha_egg1", 1)
phoenix_egg1.atlas = "images/inventoryimages/musha_egg1.xml"
local phoenix_egg2 = Ingredient( "musha_egg2", 1)
phoenix_egg2.atlas = "images/inventoryimages/musha_egg2.xml"
local phoenix_egg3 = Ingredient( "musha_egg3", 1)
phoenix_egg3.atlas = "images/inventoryimages/musha_egg3.xml"
local phoenix_egg8 = Ingredient( "musha_egg8", 1)
phoenix_egg8.atlas = "images/inventoryimages/musha_egg8.xml"
local arong_egg = Ingredient( "musha_egg_arong", 1)
arong_egg.atlas = "images/inventoryimages/musha_egg_arong.xml"
local glowdust = Ingredient( "glowdust", 1)
glowdust.atlas = "images/inventoryimages/glowdust.xml"
local glowdust2 = Ingredient( "glowdust", 2)
glowdust2.atlas = "images/inventoryimages/glowdust.xml"
local glowdust3 = Ingredient( "glowdust", 3)
glowdust3.atlas = "images/inventoryimages/glowdust.xml"
local glowdust5 = Ingredient( "glowdust", 5)
glowdust5.atlas = "images/inventoryimages/glowdust.xml"
local glowdust10 = Ingredient( "glowdust", 10)
glowdust10.atlas = "images/inventoryimages/glowdust.xml"
local glowdust15 = Ingredient( "glowdust", 15)
glowdust15.atlas = "images/inventoryimages/glowdust.xml"
local glowdust20 = Ingredient( "glowdust", 20)
glowdust20.atlas = "images/inventoryimages/glowdust.xml"
local crystal = Ingredient( "cristal", 1)
crystal.atlas = "images/inventoryimages/cristal.xml"
local crystal2 = Ingredient( "cristal", 2)
crystal2.atlas = "images/inventoryimages/cristal.xml"
local crystal3 = Ingredient( "cristal", 3)
crystal3.atlas = "images/inventoryimages/cristal.xml"
local greenf = Ingredient( "green_fruit", 1)
greenf.atlas = "images/inventoryimages/green_fruit.xml"
local greenfk = Ingredient( "green_fruit_cooked", 1)
greenfk.atlas = "images/inventoryimages/green_fruit_cooked.xml"
local broken_arrow = Ingredient( "arrowm_broken", 1)
broken_arrow.atlas = "images/inventoryimages/arrowm_broken.xml"
--local broken_arrow2 = Ingredient( "arrowm_broken", 2)
--broken_arrow2.atlas = "images/inventoryimages/arrowm_broken.xml"

local bunny_scout = Ingredient( "hat_mbunny", 1)
bunny_scout.atlas = "images/inventoryimages/hat_mbunny.xml"
local iron_cat = Ingredient( "hat_mwildcat", 1)
iron_cat.atlas = "images/inventoryimages/hat_mwildcat.xml"

--local fish = Ingredient( "fish", 1)
----

function musha_verysmart(inst)
if IsServer then
inst.components.builder.science_bonus = 2
end end
function musha_smart(inst)
if IsServer then
inst.components.builder.science_bonus = 1
end end
function musha_normal(inst)
if IsServer then
inst.components.builder.science_bonus = 0
end end

if Smart == "verysmart" then
AddPrefabPostInit("musha", musha_verysmart)
end
if Smart == "smart" then
AddPrefabPostInit("musha", musha_smart)
end
if Smart == "normal" then
AddPrefabPostInit("musha", musha_normal)
end

GLOBAL.STRINGS.TABS.MUSHA = "MushA"
GLOBAL.RECIPETABS['MUSHA'] = {str = "MUSHA", sort=12, icon = "mushatab.tex", icon_atlas = "images/mushatab.xml"}

----BOOK----


--[[AddRecipe("book_musha_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1) ,glowdust}, RECIPETABS.MUSHA, {SCIENCE=0},nil, nil, nil, nil, "musha")]]


--[[if Smart == "normal" then

AddRecipe("book_birds", {Ingredient("papyrus", 2), Ingredient("bird_egg", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_horticulture", {Ingredient("papyrus", 2), Ingredient("seeds", 5), Ingredient("poop", 5)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_silviculture", {Ingredient("papyrus", 2), Ingredient("livinglog", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_TWO, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1), Ingredient("poop", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_sleep", {Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_TWO, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_brimstone", {Ingredient("papyrus", 2), Ingredient("redgem", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_TWO, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_tentacles", {Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_TWO, nil, nil, nil, nil, "bookbuilder")

elseif Smart ~= "normal" then
AddRecipe("book_birds", {Ingredient("papyrus", 2), Ingredient("bird_egg", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_horticulture", {Ingredient("papyrus", 2), Ingredient("seeds", 5), Ingredient("poop", 5)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_silviculture", {Ingredient("papyrus", 2), Ingredient("livinglog", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_THREE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_gardening", {Ingredient("papyrus", 2), Ingredient("seeds", 1), Ingredient("poop", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_ONE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_sleep", {Ingredient("papyrus", 2), Ingredient("nightmarefuel", 2)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_TWO, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_brimstone", {Ingredient("papyrus", 2), Ingredient("redgem", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.MAGIC_THREE, nil, nil, nil, nil, "bookbuilder")
AddRecipe("book_tentacles", {Ingredient("papyrus", 2), Ingredient("tentaclespots", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.SCIENCE_THREE, nil, nil, nil, nil, "bookbuilder")

end]]

if Gem_Recipe == "color" then
AddRecipe("bluegem", {Ingredient( "redgem",1),glowdust}, RECIPETABS.MUSHA, {SCIENCE=0},nil, nil, nil, nil, "musha")
AddRecipe("redgem", {Ingredient( "bluegem",1),glowdust}, RECIPETABS.MUSHA, {SCIENCE=0},nil, nil, nil, nil, "musha")
AddRecipe("greengem",  {Ingredient("purplegem", 8),Ingredient( "goldnugget",15),glowdust5}, RECIPETABS.MUSHA, {SCIENCE=2},nil, nil, nil, nil, "musha")
AddRecipe("yellowgem", {Ingredient("purplegem", 8),Ingredient( "goldnugget",15),glowdust5}, RECIPETABS.MUSHA, {SCIENCE=2},nil, nil, nil, nil, "musha")
AddRecipe("orangegem", {Ingredient("purplegem", 8),Ingredient( "goldnugget",15),glowdust5}, RECIPETABS.MUSHA, {SCIENCE=2},nil, nil, nil, nil, "musha")
end
if Gem_Recipe == "craft_basic" then
AddRecipe("bluegem", {Ingredient( "goldnugget",10),Ingredient("feather_robin_winter", 2),glowdust}, RECIPETABS.MUSHA, {SCIENCE=0})
AddRecipe("redgem", {Ingredient( "goldnugget",10),Ingredient("feather_robin", 2),glowdust}, RECIPETABS.MUSHA, {SCIENCE=0})
end
 
 --[[local musha_nametag = AddRecipe("musha_nametag", { Ingredient("charcoal", 1),Ingredient("goldnugget", 1), Ingredient("papyrus", 1)}, RECIPETABS.ORPHANAGE, TECH.ORPHANAGE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_nametag.xml", "musha_nametag.tex" )
musha_nametag.atlas = "images/inventoryimages/musha_nametag.xml"
musha_nametag.tagneeded = true
musha_nametag.builder_tag ="player"]]

local musha_nametag = AddRecipe("musha_nametag", { Ingredient("charcoal", 1), Ingredient("papyrus", 1)}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_nametag.xml", "musha_nametag.tex" )
musha_nametag.atlas = "images/inventoryimages/musha_nametag.xml"
musha_nametag.tagneeded = false

if Difficult_Recipe == "easy" then

--glow berry
--[[local lesserf = AddRecipe("wormlight_lesser", { greenf, GLOBAL.Ingredient("berries", 1)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/lesserf.xml", "lesserf.tex" )
lesserf.tagneeded = false
lesserf.builder_tag ="musha"]]
--glowdust
local glowdusts = AddRecipe("glowdust", { GLOBAL.Ingredient("ash", 1),GLOBAL.Ingredient("honey", 2), greenfk}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/glowdust.xml", "glowdust.tex" )
glowdusts.tagneeded = false
glowdusts.builder_tag ="musha"
--energy drink

local portion_e = AddRecipe("portion_e", { glowdust,GLOBAL.Ingredient("redgem", 1),GLOBAL.Ingredient("nightmarefuel", 1)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/portion_e.xml", "portion_e.tex" )
portion_e.tagneeded = false
portion_e.builder_tag ="musha"


--arrows
--local arrowm = AddRecipe("arrowm", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_crow", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/arrowm.xml", "arrowm.tex" )
--arrowm.tagneeded = false
--arrowm.builder_tag ="musha"

local dummy_arrow0 = AddRecipe("dummy_arrow0", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_crow", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow0.xml", "dummy_arrow0.tex" )
dummy_arrow0.tagneeded = false
dummy_arrow0.builder_tag ="musha"
local dummy_arrow1 = AddRecipe("dummy_arrow1", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_robin", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow1.xml", "dummy_arrow1.tex" )
dummy_arrow1.tagneeded = false
dummy_arrow1.builder_tag ="musha"
local dummy_arrow2 = AddRecipe("dummy_arrow2", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_robin_winter", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow2.xml", "dummy_arrow2.tex" )
dummy_arrow2.tagneeded = false
dummy_arrow2.builder_tag ="musha"
local dummy_arrow4 = AddRecipe("dummy_arrow4", {Ingredient("stinger", 3), Ingredient("twigs", 3), Ingredient("feather_canary", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,  "images/inventoryimages/dummy_arrow4.xml", "dummy_arrow4.tex" )
dummy_arrow4.tagneeded = false
dummy_arrow4.builder_tag ="musha"
local dummy_arrow3 = AddRecipe("arrowm", {broken_arrow, Ingredient("twigs", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow3.xml", "dummy_arrow3.tex" )
dummy_arrow3.tagneeded = false
dummy_arrow3.builder_tag ="musha"

--tuna
local tunacan = AddRecipe("tunacan_musha", { GLOBAL.Ingredient("fish_cooked", 1),GLOBAL.Ingredient("charcoal", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/tunacan_musha.xml", "tunacan_musha.tex" )
tunacan.tagneeded = false
tunacan.builder_tag ="musha"
--grass hut
local musha_hut = AddRecipe("musha_hut", { GLOBAL.Ingredient("log", 2), Ingredient("cutgrass", 3), Ingredient("rope", 2), }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, "musha_hut_placer" ) 
musha_hut.atlas = "images/inventoryimages/musha_hut.xml"
musha_hut.tagneeded = false
musha_hut.builder_tag ="musha"
--dall
local moontree = AddRecipe("moontree_musha", { glowdust10,GLOBAL.Ingredient("livinglog", 10),phoenix_egg }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "moontree_musha_placer" ) 
moontree.atlas = "images/inventoryimages/moontree_musha.xml"
moontree.tagneeded = false
moontree.builder_tag ="musha"
--oven 
--[[local musha_oven = AddRecipe("musha_oven", { glowdust3, GLOBAL.Ingredient("rocks", 10), GLOBAL.Ingredient("froglegs", 5), GLOBAL.Ingredient("purplegem", 1) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "musha_oven_placer" ) 
musha_oven.atlas = "images/inventoryimages/musha_oven.xml"
musha_oven.tagneeded = false
musha_oven.builder_tag ="musha"]]
--forge
-- working on
local forge_musha = AddRecipe("forge_musha", { GLOBAL.Ingredient("gears", 1), GLOBAL.Ingredient("redgem", 3), GLOBAL.Ingredient("dragon_scales", 1), GLOBAL.Ingredient("rocks", 10) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "forge_musha_placer" ) 
forge_musha.atlas = "images/inventoryimages/forge_musha.xml"
forge_musha.tagneeded = false
forge_musha.builder_tag ="musha"
--tent
local tent_musha = AddRecipe("tent_musha", { glowdust3, Ingredient("fireflies", 1), Ingredient("papyrus", 3), Ingredient("cutgrass", 15), }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, "tent_musha_placer" ) 
tent_musha.atlas = "images/inventoryimages/tent_musha.xml"
tent_musha.tagneeded = false
tent_musha.builder_tag ="musha"
----
local mushasword_base = AddRecipe("mushasword_base", { glowdust, GLOBAL.Ingredient("goldnugget", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword_base.xml", "mushasword_base.tex" )
mushasword_base.tagneeded = false
mushasword_base.builder_tag ="musha"

local mushasword = AddRecipe("mushasword", {bladeb, GLOBAL.Ingredient("redgem", 2), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword.xml", "mushasword.tex" )
mushasword.tagneeded = false
mushasword.builder_tag ="musha"

local mushasword_frost = AddRecipe("mushasword_frost", {bladeb, GLOBAL.Ingredient("bluegem", 2), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword_frost.xml", "mushasword_frost.tex" )
mushasword_frost.tagneeded = false
mushasword_frost.builder_tag ="musha"
--bow
local bowm = AddRecipe("bowm", {phoenixb, GLOBAL.Ingredient("spidergland", 6), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/bowm.xml", "bowm.tex" )
bowm.tagneeded = false
bowm.builder_tag ="musha"
--spear
local phoenixspear = AddRecipe("phoenixspear", {phoenixb, phoenixf, GLOBAL.Ingredient("goldnugget", 20), glowdust2}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/phoenixspear.xml", "phoenixspear.tex" )
phoenixspear.tagneeded = false
phoenixspear.builder_tag ="musha"
--
local mushasword4 = AddRecipe("mushasword4", {Ingredient("goldnugget", 80), Ingredient("purplegem", 6), GLOBAL.Ingredient("greengem", 6), crystal}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword4.xml", "mushasword4.tex" )
mushasword4.tagneeded = false
mushasword4.builder_tag ="musha"

local frosthammer = AddRecipe("frosthammer", {GLOBAL.Ingredient( "deerclops_eyeball", 1), GLOBAL.Ingredient( "bluegem", 12), GLOBAL.Ingredient("livinglog", 5), GLOBAL.Ingredient("gears", 3)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/frosthammer.xml", "frosthammer.tex" )
frosthammer.tagneeded = false
frosthammer.builder_tag ="musha"

local armor_mushaa = AddRecipe("armor_mushaa", {glowdust, GLOBAL.Ingredient("goldnugget", 10), Ingredient("rope", 2)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/armor_mushaa.xml", "armor_mushaa.tex" )
armor_mushaa.tagneeded = false
armor_mushaa.builder_tag ="musha"

local broken_frosthammer = AddRecipe("broken_frosthammer", {armora, GLOBAL.Ingredient("bluegem", 5), GLOBAL.Ingredient("butterfly", 5),GLOBAL.Ingredient("gears", 2)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/broken_frosthammer.xml", "broken_frosthammer.tex" )
broken_frosthammer.tagneeded = false
broken_frosthammer.builder_tag ="musha"	

local pirateback = AddRecipe("pirateback", {armora, GLOBAL.Ingredient("goldnugget", 30), GLOBAL.Ingredient("yellowgem", 2),GLOBAL.Ingredient("livinglog", 4)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/pirateback.xml", "pirateback.tex" )
pirateback.tagneeded = false
pirateback.builder_tag ="musha"	

local armor_mushab = AddRecipe("armor_mushab", {armora, GLOBAL.Ingredient("goose_feather", 10), GLOBAL.Ingredient("orangegem", 3),GLOBAL.Ingredient("bearger_fur", 2)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/armor_mushab.xml", "armor_mushab.tex" )
armor_mushab.tagneeded = false
armor_mushab.builder_tag ="musha"	

--rabbit and cat
local hat_mbunny = AddRecipe("hat_mbunny", {GLOBAL.Ingredient("cutgrass", 8), GLOBAL.Ingredient("redgem", 1), GLOBAL.Ingredient("deserthat", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mbunny.xml", "hat_mbunny.tex" )
hat_mbunny.tagneeded = false
hat_mbunny.builder_tag ="musha"

local hat_mwildcat = AddRecipe("hat_mwildcat", { bunny_scout, GLOBAL.Ingredient("purplegem", 2), GLOBAL.Ingredient("gears", 2)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mwildcat.xml", "hat_mwildcat.tex" )
hat_mwildcat.tagneeded = false
hat_mwildcat.builder_tag ="musha"

local hat_mbunnya = AddRecipe("hat_mbunnya", {bunny_scout, GLOBAL.Ingredient("walrus_tusk", 1), GLOBAL.Ingredient("orangegem", 1) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mbunnya.xml", "hat_mbunnya.tex" )
hat_mbunnya.tagneeded = false
hat_mbunnya.builder_tag ="musha"

local hat_mprincess = AddRecipe("hat_mprincess", {glowdust3, GLOBAL.Ingredient("redgem", 4), GLOBAL.Ingredient("amulet", 1) }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mprincess.xml", "hat_mprincess.tex" )
hat_mprincess.tagneeded = false
hat_mprincess.builder_tag ="musha"	
--phoenixb
local hat_mphoenix = AddRecipe("hat_mphoenix", { GLOBAL.Ingredient("panflute", 1), GLOBAL.Ingredient("dragon_scales", 1), GLOBAL.Ingredient("yellowgem", 1), GLOBAL.Ingredient("greengem", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mphoenix.xml", "hat_mphoenix.tex" )
hat_mphoenix.tagneeded = false
hat_mphoenix.builder_tag ="musha"
--magic
--flute
local musha_flute = AddRecipe("musha_flute", { glowdust5, GLOBAL.Ingredient("horn", 1), GLOBAL.Ingredient("spidergland", 20)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_flute.xml", "musha_flute.tex" )
musha_flute.tagneeded = false
musha_flute.builder_tag ="musha"

--crystal
local cristal = AddRecipe("cristal", { glowdust3, GLOBAL.Ingredient("bluegem", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/cristal.xml", "cristal.tex" )
cristal.tagneeded = false
cristal.builder_tag ="musha"

--arong egg
local musha_egg_arong = AddRecipe("musha_egg_arong", { glowdust5, GLOBAL.Ingredient("amulet", 1), GLOBAL.Ingredient("beefalowool", 30), GLOBAL.Ingredient("purplegem", 4) }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg_arong.xml", "musha_egg_arong.tex" )
musha_egg_arong.tagneeded = false
musha_egg_arong.builder_tag ="musha"

--random egg
local musha_egg_random = AddRecipe("musha_egg_random", { phoenix_egg, glowdust3}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg_random.xml", "musha_egg_random.tex" )
musha_egg_random.tagneeded = false
musha_egg_random.builder_tag ="musha"

--yamche egg
local musha_egg = AddRecipe("musha_egg", { GLOBAL.Ingredient("amulet", 1), GLOBAL.Ingredient("redgem", 7), GLOBAL.Ingredient("bluegem", 7)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg.xml", "musha_egg.tex" )
musha_egg.tagneeded = false
musha_egg.builder_tag ="musha"

local musha_eggs1 = AddRecipe("musha_eggs1", { phoenix_egg, GLOBAL.Ingredient("goldnugget", 2)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs1.xml", "musha_eggs1.tex" )
musha_eggs1.tagneeded = false
musha_eggs1.builder_tag ="musha"

local musha_eggs2 = AddRecipe("musha_eggs2", { phoenix_eggs1, GLOBAL.Ingredient("goldnugget", 5) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs2.xml", "musha_eggs2.tex" )
musha_eggs2.tagneeded = false
musha_eggs2.builder_tag ="musha"

local musha_eggs3 = AddRecipe("musha_eggs3", { phoenix_eggs2, GLOBAL.Ingredient("goldnugget", 10) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs3.xml", "musha_eggs3.tex" )
musha_eggs3.tagneeded = false
musha_eggs3.builder_tag ="musha"

local musha_egg1 = AddRecipe("musha_egg1", { phoenix_eggs3, GLOBAL.Ingredient("goldnugget", 15), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg1.xml", "musha_egg1.tex" )
musha_egg1.tagneeded = false
musha_egg1.builder_tag ="musha"

local musha_egg2 = AddRecipe("musha_egg2", { phoenix_egg1, GLOBAL.Ingredient("goldnugget", 20), GLOBAL.Ingredient("purplegem", 1), glowdust3 }, RECIPETABS.MUSHA, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg2.xml", "musha_egg2.tex" )
musha_egg2.tagneeded = false
musha_egg2.builder_tag ="musha"

local musha_egg3 = AddRecipe("musha_egg3", { phoenix_egg2, GLOBAL.Ingredient("goldnugget", 30), GLOBAL.Ingredient("purplegem", 2), glowdust5}, RECIPETABS.MUSHA, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg3.xml", "musha_egg3.tex" )
musha_egg3.tagneeded = false
musha_egg3.builder_tag ="musha"

local musha_egg8 = AddRecipe("musha_egg8", { phoenix_egg3, GLOBAL.Ingredient("goldnugget", 40), GLOBAL.Ingredient("purplegem", 5), glowdust10}, RECIPETABS.MUSHA, TECH.MAGIC_THREE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg8.xml", "musha_egg8.tex" )
musha_egg8.tagneeded = false
musha_egg8.builder_tag ="musha"

end 

if Difficult_Recipe == "normal" then
--glow berry
--[[local lesserf = AddRecipe("wormlight_lesser", { greenf, GLOBAL.Ingredient("berries", 2), GLOBAL.Ingredient("ash", 1)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/lesserf.xml", "lesserf.tex" )
lesserf.tagneeded = false
lesserf.builder_tag ="musha"]]

--glowdust
local glowdusts = AddRecipe("glowdust", { GLOBAL.Ingredient("ash", 1),GLOBAL.Ingredient("honey", 5),greenfk}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/glowdust.xml", "glowdust.tex" )
glowdusts.tagneeded = false
glowdusts.builder_tag ="musha"
--energy drink
local portion_e = AddRecipe("portion_e", { glowdust3,GLOBAL.Ingredient("redgem", 1),GLOBAL.Ingredient("nightmarefuel", 1)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/portion_e.xml", "portion_e.tex" )
portion_e.tagneeded = false
portion_e.builder_tag ="musha"

--arrows
--local arrowm = AddRecipe("arrowm", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_crow", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/arrowm.xml", "arrowm.tex" )
--arrowm.tagneeded = false
--arrowm.builder_tag ="musha"
local dummy_arrow0 = AddRecipe("dummy_arrow0", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_crow", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow0.xml", "dummy_arrow0.tex" )
dummy_arrow0.tagneeded = false
dummy_arrow0.builder_tag ="musha"
local dummy_arrow1 = AddRecipe("dummy_arrow1", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_robin", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow1.xml", "dummy_arrow1.tex" )
dummy_arrow1.tagneeded = false
dummy_arrow1.builder_tag ="musha"
local dummy_arrow2 = AddRecipe("dummy_arrow2", {Ingredient("stinger", 1), Ingredient("twigs", 1), Ingredient("feather_robin_winter", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow2.xml", "dummy_arrow2.tex" )
dummy_arrow2.tagneeded = false
dummy_arrow2.builder_tag ="musha"
local dummy_arrow4 = AddRecipe("dummy_arrow4", {Ingredient("stinger", 3), Ingredient("twigs", 3), Ingredient("feather_canary", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil,  "images/inventoryimages/dummy_arrow4.xml", "dummy_arrow4.tex" )
dummy_arrow4.tagneeded = false
dummy_arrow4.builder_tag ="musha"
local dummy_arrow3 = AddRecipe("arrowm", {broken_arrow, Ingredient("twigs", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/dummy_arrow3.xml", "dummy_arrow3.tex" )
dummy_arrow3.tagneeded = false
dummy_arrow3.builder_tag ="musha"

--tuna
local tunacan = AddRecipe("tunacan_musha", { GLOBAL.Ingredient("fish_cooked", 1),GLOBAL.Ingredient("charcoal", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/tunacan_musha.xml", "tunacan_musha.tex" )
tunacan.tagneeded = false
tunacan.builder_tag ="musha"
--grass hut
local musha_hut = AddRecipe("musha_hut", { GLOBAL.Ingredient("log", 4), Ingredient("cutgrass", 6), Ingredient("rope", 3), }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, "musha_hut_placer" ) 
musha_hut.atlas = "images/inventoryimages/musha_hut.xml"
musha_hut.tagneeded = false
musha_hut.builder_tag ="musha"
--dall
local moontree = AddRecipe("moontree_musha", { glowdust20,GLOBAL.Ingredient("livinglog", 25),phoenix_egg }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "moontree_musha_placer" ) 
moontree.atlas = "images/inventoryimages/moontree_musha.xml"
moontree.tagneeded = false
moontree.builder_tag ="musha"
--oven
--[[local musha_oven = AddRecipe("musha_oven", { glowdust5, GLOBAL.Ingredient("rocks", 20), GLOBAL.Ingredient("froglegs", 10), GLOBAL.Ingredient("purplegem", 2) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "musha_oven_placer" ) 
musha_oven.atlas = "images/inventoryimages/musha_oven.xml"
musha_oven.tagneeded = false
musha_oven.builder_tag ="musha"]]
--forge

local forge_musha = AddRecipe("forge_musha", { GLOBAL.Ingredient("gears", 2), GLOBAL.Ingredient("redgem", 6), GLOBAL.Ingredient("dragon_scales", 1), GLOBAL.Ingredient("rocks", 20) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, "forge_musha_placer" ) 
forge_musha.atlas = "images/inventoryimages/forge_musha.xml"
forge_musha.tagneeded = false
forge_musha.builder_tag ="musha"
--tent
local tent_musha = AddRecipe("tent_musha", { glowdust5, Ingredient("fireflies", 1), Ingredient("papyrus", 6), Ingredient("cutgrass", 30), }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, "tent_musha_placer" ) 
tent_musha.atlas = "images/inventoryimages/tent_musha.xml"
tent_musha.tagneeded = false
tent_musha.builder_tag ="musha"
----
local mushasword_base = AddRecipe("mushasword_base", { glowdust, GLOBAL.Ingredient("goldnugget", 2)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword_base.xml", "mushasword_base.tex" )
mushasword_base.tagneeded = false
mushasword_base.builder_tag ="musha"

local mushasword = AddRecipe("mushasword", {bladeb, GLOBAL.Ingredient("redgem", 4), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword.xml", "mushasword.tex" )
mushasword.tagneeded = false
mushasword.builder_tag ="musha"

local mushasword_frost = AddRecipe("mushasword_frost", {bladeb, GLOBAL.Ingredient("bluegem", 4), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword_frost.xml", "mushasword_frost.tex" )
mushasword_frost.tagneeded = false
mushasword_frost.builder_tag ="musha"
--bow
local bowm = AddRecipe("bowm", {phoenixb, GLOBAL.Ingredient("spidergland", 12), glowdust3}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/bowm.xml", "bowm.tex" )
bowm.tagneeded = false
bowm.builder_tag ="musha"
--spear
local phoenixspear = AddRecipe("phoenixspear", {phoenixb, phoenixf, GLOBAL.Ingredient("goldnugget", 30), glowdust3}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/phoenixspear.xml", "phoenixspear.tex" )
phoenixspear.tagneeded = false
phoenixspear.builder_tag ="musha"
--
local mushasword4 = AddRecipe("mushasword4", {Ingredient("goldnugget", 160), Ingredient("purplegem", 12), GLOBAL.Ingredient("greengem", 12), cristal}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/mushasword4.xml", "mushasword4.tex" )
mushasword4.tagneeded = false
mushasword4.builder_tag ="musha"

local frosthammer = AddRecipe("frosthammer", {GLOBAL.Ingredient( "deerclops_eyeball", 1), GLOBAL.Ingredient( "bluegem", 24), GLOBAL.Ingredient("livinglog", 10), GLOBAL.Ingredient("gears", 6)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/frosthammer.xml", "frosthammer.tex" )
frosthammer.tagneeded = false
frosthammer.builder_tag ="musha"

local armor_mushaa = AddRecipe("armor_mushaa", {glowdust3, GLOBAL.Ingredient("goldnugget", 20), Ingredient("rope", 3)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/armor_mushaa.xml", "armor_mushaa.tex" )
armor_mushaa.tagneeded = false
armor_mushaa.builder_tag ="musha"

local broken_frosthammer = AddRecipe("broken_frosthammer", {armora, GLOBAL.Ingredient("bluegem", 10), GLOBAL.Ingredient("butterfly", 10),GLOBAL.Ingredient("gears", 4)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/broken_frosthammer.xml", "broken_frosthammer.tex" )
broken_frosthammer.tagneeded = false
broken_frosthammer.builder_tag ="musha"	

local pirateback = AddRecipe("pirateback", {armora, GLOBAL.Ingredient("goldnugget", 60), GLOBAL.Ingredient("yellowgem", 3),GLOBAL.Ingredient("livinglog", 8)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/pirateback.xml", "pirateback.tex" )
pirateback.tagneeded = false
pirateback.builder_tag ="musha"	

local armor_mushab = AddRecipe("armor_mushab", {armora, GLOBAL.Ingredient("goose_feather", 20), GLOBAL.Ingredient("orangegem", 5),GLOBAL.Ingredient("bearger_fur", 4)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/armor_mushab.xml", "armor_mushab.tex" )
armor_mushab.tagneeded = false
armor_mushab.builder_tag ="musha"	

--rabbit and cat 2
local hat_mbunny = AddRecipe("hat_mbunny", {GLOBAL.Ingredient("cutgrass", 12), GLOBAL.Ingredient("redgem", 2), GLOBAL.Ingredient("deserthat", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mbunny.xml", "hat_mbunny.tex" )
hat_mbunny.tagneeded = false
hat_mbunny.builder_tag ="musha"

local hat_mwildcat = AddRecipe("hat_mwildcat", { bunny_scout, GLOBAL.Ingredient("purplegem", 4), GLOBAL.Ingredient("gears", 4)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mwildcat.xml", "hat_mwildcat.tex" )
hat_mwildcat.tagneeded = false
hat_mwildcat.builder_tag ="musha"

local hat_mbunnya = AddRecipe("hat_mbunnya", {bunny_scout, GLOBAL.Ingredient("walrus_tusk", 2), GLOBAL.Ingredient("orangegem", 2) }, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mbunnya.xml", "hat_mbunnya.tex" )
hat_mbunnya.tagneeded = false
hat_mbunnya.builder_tag ="musha"

local hat_mprincess = AddRecipe("hat_mprincess", {glowdust5, GLOBAL.Ingredient("redgem", 3), GLOBAL.Ingredient("amulet", 1) }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mprincess.xml", "hat_mprincess.tex" )
hat_mprincess.tagneeded = false
hat_mprincess.builder_tag ="musha"	
--phoenixb
local hat_mphoenix = AddRecipe("hat_mphoenix", { GLOBAL.Ingredient("panflute", 1), GLOBAL.Ingredient("dragon_scales", 1), GLOBAL.Ingredient("yellowgem", 2), GLOBAL.Ingredient("greengem", 2)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/hat_mphoenix.xml", "hat_mphoenix.tex" )
hat_mphoenix.tagneeded = false
hat_mphoenix.builder_tag ="musha"
--magic
--flute
local musha_flute = AddRecipe("musha_flute", { glowdust10, GLOBAL.Ingredient("horn", 1), GLOBAL.Ingredient("spidergland", 40)}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_flute.xml", "musha_flute.tex" )
musha_flute.tagneeded = false
musha_flute.builder_tag ="musha"

--crystal
local cristal = AddRecipe("cristal", { glowdust5, GLOBAL.Ingredient("purplegem", 1)}, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/cristal.xml", "cristal.tex" )
cristal.tagneeded = false
cristal.builder_tag ="musha"

--arong egg
local musha_egg_arong = AddRecipe("musha_egg_arong", { glowdust5, GLOBAL.Ingredient("amulet", 1), GLOBAL.Ingredient("beefalowool", 60), GLOBAL.Ingredient("purplegem", 8) }, RECIPETABS.MUSHA, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg_arong.xml", "musha_egg_arong.tex" )
musha_egg_arong.tagneeded = false
musha_egg_arong.builder_tag ="musha"

--random egg
local musha_egg_random = AddRecipe("musha_egg_random", { phoenix_egg, glowdust5}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg_random.xml", "musha_egg_random.tex" )
musha_egg_random.tagneeded = false
musha_egg_random.builder_tag ="musha"

--yamche egg
local musha_egg = AddRecipe("musha_egg", { GLOBAL.Ingredient("amulet", 1), GLOBAL.Ingredient("redgem", 15), GLOBAL.Ingredient("bluegem", 15)}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg.xml", "musha_egg.tex" )
musha_egg.tagneeded = false
musha_egg.builder_tag ="musha"

local musha_eggs1 = AddRecipe("musha_eggs1", { phoenix_egg, GLOBAL.Ingredient("goldnugget", 4), glowdust}, RECIPETABS.MUSHA, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs1.xml", "musha_eggs1.tex" )
musha_eggs1.tagneeded = false
musha_eggs1.builder_tag ="musha"

local musha_eggs2 = AddRecipe("musha_eggs2", { phoenix_eggs1, GLOBAL.Ingredient("goldnugget", 10), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs2.xml", "musha_eggs2.tex" )
musha_eggs2.tagneeded = false
musha_eggs2.builder_tag ="musha"

local musha_eggs3 = AddRecipe("musha_eggs3", { phoenix_eggs2, GLOBAL.Ingredient("goldnugget", 20), glowdust}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_eggs3.xml", "musha_eggs3.tex" )
musha_eggs3.tagneeded = false
musha_eggs3.builder_tag ="musha"

local musha_egg1 = AddRecipe("musha_egg1", { phoenix_eggs3, GLOBAL.Ingredient("goldnugget", 30), glowdust3}, RECIPETABS.MUSHA, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg1.xml", "musha_egg1.tex" )
musha_egg1.tagneeded = false
musha_egg1.builder_tag ="musha"

local musha_egg2 = AddRecipe("musha_egg2", { phoenix_egg1, GLOBAL.Ingredient("goldnugget", 40), GLOBAL.Ingredient("purplegem", 1), glowdust10 }, RECIPETABS.MUSHA, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg2.xml", "musha_egg2.tex" )
musha_egg2.tagneeded = false
musha_egg2.builder_tag ="musha"

local musha_egg3 = AddRecipe("musha_egg3", { phoenix_egg2, GLOBAL.Ingredient("goldnugget", 60), GLOBAL.Ingredient("purplegem", 5), glowdust15}, RECIPETABS.MUSHA, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg3.xml", "musha_egg3.tex" )
musha_egg3.tagneeded = false
musha_egg3.builder_tag ="musha"

local musha_egg8 = AddRecipe("musha_egg8", { phoenix_egg3, GLOBAL.Ingredient("goldnugget", 80), GLOBAL.Ingredient("purplegem", 10), glowdust20}, RECIPETABS.MUSHA, TECH.MAGIC_THREE, nil, nil, nil, nil, nil, "images/inventoryimages/musha_egg8.xml", "musha_egg8.tex" )
musha_egg8.tagneeded = false
musha_egg8.builder_tag ="musha"
end 