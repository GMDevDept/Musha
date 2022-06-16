
local Difficult = GetModConfigData("difficultover")
local IsServer = GLOBAL.TheNet:GetIsServer()
-------difficulty enemiese option

if Difficult == "monster2x" then

function deerclops_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DEERCLOPS_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.75)
  inst:AddTag("giant2x")
end end
function bearger_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BEARGER_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.75)
  inst:AddTag("giant2x")
end end
function dragonfly_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DRAGONFLY_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.25)
  inst:AddTag("giant2x")
end end
function moose_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOOSE_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.75)
  inst:AddTag("giant2x")
end end
function mossling_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOSSLING_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*1.5)
  inst:AddTag("small_giant2x")
end end
function toadstool_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TOADSTOOL_HEALTH*2.2)
    inst:AddTag("giant2x")
end end
function beequeen_2x(inst)
if IsServer and inst.components.health then
	inst.components.health:SetMaxHealth(TUNING.BEEQUEEN_HEALTH*2)
inst:AddTag("giant2x")
end end
function nspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH*2)
    inst:AddTag("monster2x")
end end
function wspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*2)
    inst:AddTag("monster2x")
end end
function qspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDERQUEEN_HEALTH*2)
    inst:AddTag("small_giant2x")
end end
function chspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HIDER_HEALTH*2)
    inst:AddTag("monster2x")
end end
function csspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_SPITTER_HEALTH*2)
    inst:AddTag("monster2x")
end end
function cdspider_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*2)
     inst:AddTag("monster2x")
end end
function nhound_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.HOUND_HEALTH*2)
        inst:AddTag("monster2x")
end end
function fhound_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.FIREHOUND_HEALTH*2)
        inst:AddTag("monster2x")
end end
function ihound_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ICEHOUND_HEALTH*2)
        inst:AddTag("monster2x")
end end
function warg_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.WARG_HEALTH*2)
        inst:AddTag("small_giant2x")
end end
function tentacle_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TENTACLE_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.TENTACLE_DAMAGE*1.5)
        inst:AddTag("monster2x")
end end
function rook_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE*1.5)
        inst:AddTag("monster2x")
end end
function minotaur_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MINOTAUR_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.MINOTAUR_DAMAGE*1.5)
        inst:AddTag("monster2x")
end end
function bishop_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BISHOP_HEALTH*2)
    inst.components.combat:SetDefaultDamage(TUNING.BISHOP_DAMAGE*1.2)
        inst:AddTag("monster2x")
end end
function tallbird_2x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TALLBIRD_HEALTH*2)
        inst:AddTag("monster2x")
end end
function leif_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant2x")
    inst.components.health:SetMaxHealth(TUNING.LEIF_HEALTH*2)
end end
function spat_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant2x")
    inst.components.health:SetMaxHealth(TUNING.SPAT_HEALTH*2)
end end
function birchnutdrake_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(100)
end end
function merm_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(TUNING.MERM_HEALTH*4)
end end
function bat_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(TUNING.BAT_HEALTH*2)
end end
function monkey_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(TUNING.MONKEY_HEALTH*2)
end end
function walus_2x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(TUNING.WALRUS_HEALTH*2)
end end
function eyeplant_2x(inst)
if IsServer and inst.components.health then
  
    inst.components.health:SetMaxHealth(TUNING.EYEPLANT_HEALTH*2)
end end
function antlion_2x(inst)
if IsServer and inst.components.health then
 	inst.components.health:SetMaxHealth(TUNING.ANTLION_HEALTH*2.2)
    inst:AddTag("giant2x")
end end
function stalker_2x(inst)
if IsServer and inst.components.health then
 	inst.components.health:SetMaxHealth(TUNING.STALKER_HEALTH*2)
    inst:AddTag("giant2x")
end end
function stalker_atrium_2x(inst)
if IsServer and inst.components.health then
 	inst.components.health:SetMaxHealth(TUNING.STALKER_ATRIUM_HEALTH*2)
    inst:AddTag("giant2x")
end end

AddPrefabPostInit("deerclops", deerclops_2x)
AddPrefabPostInit("bearger", bearger_2x)
AddPrefabPostInit("dragonfly", dragonfly_2x)
AddPrefabPostInit("moose", moose_2x)
AddPrefabPostInit("mossling", mossling_2x)
AddPrefabPostInit("spider", nspider_2x)
AddPrefabPostInit("spider_warrior", wspider_2x)
AddPrefabPostInit("spiderqueen", qspider_2x)
AddPrefabPostInit("spider_hider", chspider_2x)
AddPrefabPostInit("spider_spitter", csspider_2x)
AddPrefabPostInit("spider_dropper", cdspider_2x)
AddPrefabPostInit("hound", nhound_2x)
AddPrefabPostInit("firehound", fhound_2x)
AddPrefabPostInit("icehound", ihound_2x)
AddPrefabPostInit("warg", warg_2x)
AddPrefabPostInit("tentacle", tentacle_2x)
AddPrefabPostInit("rook", rook_2x)
AddPrefabPostInit("minotaur", minotaur_2x)
AddPrefabPostInit("bishop", bishop_2x)
AddPrefabPostInit("tallbird", tallbird_2x)
AddPrefabPostInit("leif", leif_2x)
AddPrefabPostInit("spat", spat_2x)
AddPrefabPostInit("merm", merm_2x)
AddPrefabPostInit("birchnutdrake", birchnutdrake_2x)
AddPrefabPostInit("bat", bat_2x)
AddPrefabPostInit("walus", walus_2x)
AddPrefabPostInit("monkey", monkey_2x)
AddPrefabPostInit("eyeplant", eyeplant_2x)
AddPrefabPostInit("toadstool", toadstool_2x)
AddPrefabPostInit("beequeen", beequeen_2x)
AddPrefabPostInit("antlion", antlion_2x)
AddPrefabPostInit("stalker", stalker_2x)
AddPrefabPostInit("stalker_atrium", stalker_atrium_2x)
--AddPrefabPostInit("buzzard", buzzard_2x)
end
if Difficult == "monster3x" then

function deerclops_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DEERCLOPS_HEALTH*3)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*2.5)
    inst.components.combat:SetAttackPeriod(2.6)
  inst:AddTag("giant3x")
end end
function bearger_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BEARGER_HEALTH*3)
    inst.components.combat:SetDefaultDamage(TUNING.BEARGER_DAMAGE*2.5)
    inst.components.combat:SetRange(TUNING.BEARGER_ATTACK_RANGE, TUNING.BEARGER_MELEE_RANGE)
    inst.components.combat:SetAttackPeriod(2.6)
  inst:AddTag("giant3x")
end end
function dragonfly_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DRAGONFLY_HEALTH*3)
    inst.components.combat:SetDefaultDamage(TUNING.DRAGONFLY_DAMAGE*2.5)
    inst.components.combat:SetAttackPeriod(2.1)
  inst:AddTag("giant3x")
end end
function moose_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOOSE_HEALTH*3)
    inst.components.combat:SetDefaultDamage(TUNING.MOOSE_DAMAGE*2.5)
    inst.components.combat:SetAttackPeriod(2.6)
   inst:AddTag("giant3x")
end end
function mossling_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOSSLING_HEALTH*3)
    inst.components.combat:SetDefaultDamage(TUNING.MOSSLING_DAMAGE*2.5)
   inst:AddTag("small_giant3x")
end end
function toadstool_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TOADSTOOL_HEALTH*3.3)
    inst:AddTag("giant3x")
end end
function beequeen_3x(inst)
if IsServer and inst.components.health then
	inst.components.health:SetMaxHealth(TUNING.BEEQUEEN_HEALTH*3)
inst:AddTag("giant3x")
end end
function nspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(2.75)
     inst:AddTag("monster3x")
end end
function wspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_WARRIOR_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(3.75 + math.random()*2)
     inst:AddTag("monster3x")
end end
function qspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDERQUEEN_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDERQUEEN_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(2.75)
     inst:AddTag("small_giant3x")
end end
function chspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HIDER_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_HIDER_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(2.75)
     inst:AddTag("monster3x")
end end
function csspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_SPITTER_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_SPITTER_DAMAGE_MELEE*1.5)
    inst.components.combat:SetAttackPeriod(4.75 + math.random()*2)
     inst:AddTag("monster3x")
end end
function cdspider_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_WARRIOR_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(2.75 + math.random()*2)
     inst:AddTag("monster3x")
end end
function nhound_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.HOUND_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(1.75)
        inst:AddTag("monster3x")
end end
function fhound_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.FIREHOUND_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.FIREHOUND_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(1.75)
        inst:AddTag("monster3x")
end end
function ihound_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ICEHOUND_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.ICEHOUND_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(1.75)
        inst:AddTag("monster3x")
end end
function warg_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.WARG_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.WARG_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(2.75)
        inst:AddTag("small_giant3x")
end end
function tentacle_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TENTACLE_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.TENTACLE_DAMAGE*2)
        inst:AddTag("monster3x")
end end
function rook_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE*2)
        inst:AddTag("monster3x")
end end
function minotaur_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MINOTAUR_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.MINOTAUR_DAMAGE*2)
        inst:AddTag("monster3x")
end end
function bishop_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BISHOP_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.BISHOP_DAMAGE*1.6)
        inst:AddTag("monster3x")
end end
function tallbird_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TALLBIRD_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.TALLBIRD_DAMAGE*1.5)
    inst.components.combat:SetAttackPeriod(1.75)
        inst:AddTag("monster3x")
end end
function leif_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant3x")
    inst.components.health:SetMaxHealth(TUNING.LEIF_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.LEIF_DAMAGE*1.5)
end end
function spat_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant3x")
    inst.components.health:SetMaxHealth(TUNING.SPAT_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.SPAT_PHLEGM_DAMAGE*1.25)
end end
function birchnutdrake_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster3x")
    inst.components.health:SetMaxHealth(150)
    inst.components.combat:SetDefaultDamage(10)
end end
function merm_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster3x")
    inst.components.health:SetMaxHealth(TUNING.MERM_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.MERM_DAMAGE*1.5)
end end
function bat_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster3x")
    inst.components.health:SetMaxHealth(TUNING.BAT_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.BAT_DAMAGE*1.5)
end end
function monkey_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster3x")
    inst.components.health:SetMaxHealth(TUNING.MONKEY_HEALTH*4)
end end
function walus_3x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster3x")
    inst.components.health:SetMaxHealth(TUNING.WALRUS_HEALTH*4)
    inst.components.locomotor.runspeed = 6
    inst.components.locomotor.walkspeed = 2
end end
function eyeplant_3x(inst)
if IsServer and inst.components.health then
        -- inst:AddTag("monster1x")
    inst.components.health:SetMaxHealth(TUNING.EYEPLANT_HEALTH*4)
    inst.components.combat:SetDefaultDamage(TUNING.EYEPLANT_DAMAGE*1.5)
end end
function antlion_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ANTLION_HEALTH*3.3)
    inst:AddTag("giant3x")
end end
function stalker_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.STALKER_HEALTH*3)
    inst:AddTag("giant3x")
end end
function stalker_atrium_3x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.STALKER_ATRIUM_HEALTH*3)
    inst:AddTag("giant3x")
end end

AddPrefabPostInit("deerclops", deerclops_3x)
AddPrefabPostInit("bearger", bearger_3x)
AddPrefabPostInit("dragonfly", dragonfly_3x)
AddPrefabPostInit("moose", moose_3x)
AddPrefabPostInit("mossling", mossling_3x)
AddPrefabPostInit("spider", nspider_3x)
AddPrefabPostInit("spider_warrior", wspider_3x)
AddPrefabPostInit("spiderqueen", qspider_3x)
AddPrefabPostInit("spider_hider", chspider_3x)
AddPrefabPostInit("spider_spitter", csspider_3x)
AddPrefabPostInit("spider_dropper", cdspider_3x)
AddPrefabPostInit("hound", nhound_3x)
AddPrefabPostInit("firehound", fhound_3x)
AddPrefabPostInit("icehound", ihound_3x)
AddPrefabPostInit("warg", warg_3x)
AddPrefabPostInit("tentacle", tentacle_3x)
AddPrefabPostInit("rook", rook_3x)
AddPrefabPostInit("minotaur", minotaur_3x)
AddPrefabPostInit("bishop", bishop_3x)
AddPrefabPostInit("tallbird", tallbird_3x)
AddPrefabPostInit("leif", leif_3x)
AddPrefabPostInit("spat", spat_3x)
AddPrefabPostInit("merm", merm_3x)
AddPrefabPostInit("birchnutdrake", birchnutdrake_3x)
AddPrefabPostInit("bat", bat_3x)
AddPrefabPostInit("walus", walus_3x)
AddPrefabPostInit("monkey", monkey_3x)
AddPrefabPostInit("eyeplant", eyeplant_3x)
AddPrefabPostInit("toadstool", toadstool_3x)
AddPrefabPostInit("beequeen", beequeen_3x)
AddPrefabPostInit("antlion", antlion_3x)
AddPrefabPostInit("stalker", stalker_3x)
AddPrefabPostInit("stalker_atrium", stalker_atrium_3x)
--AddPrefabPostInit("buzzard", buzzard_3x)
end
if Difficult == "monster4x" then

function deerclops_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DEERCLOPS_HEALTH*5)
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_DAMAGE*3)
 --   inst.components.combat:SetAreaDamage(TUNING.DEERCLOPS_AOE_RANGE, TUNING.DEERCLOPS_AOE_SCALE)
    inst.components.combat:SetAttackPeriod(2.3)
   inst:AddTag("giant4x")
end end
function bearger_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BEARGER_HEALTH*5)
    inst.components.combat:SetDefaultDamage(TUNING.BEARGER_DAMAGE*3)
    inst.components.combat:SetRange(TUNING.BEARGER_ATTACK_RANGE, TUNING.BEARGER_MELEE_RANGE)
 --   inst.components.combat:SetAreaDamage(6, 0.8)
    inst.components.combat:SetAttackPeriod(2.3)
   inst:AddTag("giant4x")
end end
function dragonfly_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.DRAGONFLY_HEALTH*5)
    inst.components.combat:SetDefaultDamage(TUNING.DRAGONFLY_DAMAGE*3)
   -- inst.components.combat:SetAreaDamage(6, 0.8)
    inst.components.combat:SetAttackPeriod(1.8)
   inst:AddTag("giant4x")
end end
function moose_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOOSE_HEALTH*5)
    inst.components.combat:SetDefaultDamage(TUNING.MOOSE_DAMAGE*3)
    inst.components.combat:SetAttackPeriod(2.3)
    inst:AddTag("giant4x")
end end
function mossling_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MOSSLING_HEALTH*5)
    inst.components.combat:SetDefaultDamage(TUNING.MOSSLING_DAMAGE*3)
    inst:AddTag("small_giant4x")
end end
function toadstool_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TOADSTOOL_HEALTH*5.5)
    inst:AddTag("giant4x")
end end
function beequeen_4x(inst)
if IsServer and inst.components.health then
	inst.components.health:SetMaxHealth(TUNING.BEEQUEEN_HEALTH*4)
inst:AddTag("giant4x")
end end
function nspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.5)
     inst:AddTag("monster4x")
end end
function wspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_WARRIOR_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(3.5 + math.random()*2)
     inst:AddTag("monster4x")
end end
function qspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDERQUEEN_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDERQUEEN_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.5)
     inst:AddTag("small_giant4x")
end end
function chspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HIDER_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_HIDER_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.5)
     inst:AddTag("monster4x")
end end
function csspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_SPITTER_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_SPITTER_DAMAGE_MELEE*2)
    inst.components.combat:SetAttackPeriod(4.5 + math.random()*2)
        inst:AddTag("monster4x")
end end
function cdspider_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.SPIDER_WARRIOR_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_WARRIOR_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(3.5 + math.random()*2)
        inst:AddTag("monster4x")
end end
function nhound_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.HOUND_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.HOUND_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(1.5)
        inst:AddTag("monster4x")
end end
function fhound_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.FIREHOUND_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.FIREHOUND_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(1.5)
        inst:AddTag("monster4x")
end end
function ihound_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ICEHOUND_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.ICEHOUND_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(1.5)
        inst:AddTag("monster4x")
end end
function warg_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.WARG_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.WARG_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(2.5)
        inst:AddTag("small_giant4x")
end end
function tentacle_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TENTACLE_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.TENTACLE_DAMAGE*2.5)
        inst:AddTag("monster4x")
end end
function rook_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ROOK_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.ROOK_DAMAGE*3)
        inst:AddTag("monster4x")
end end
function minotaur_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.MINOTAUR_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.MINOTAUR_DAMAGE*2.5)
        inst:AddTag("monster4x")
end end
function bishop_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.BISHOP_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.BISHOP_DAMAGE*2)
        inst:AddTag("monster4x")
end end
function tallbird_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.TALLBIRD_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.TALLBIRD_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(1.5)
        inst:AddTag("monster4x")
end end
function leif_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant4x")
    inst.components.health:SetMaxHealth(TUNING.LEIF_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.LEIF_DAMAGE*2)
end end
function spat_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("small_giant4x")
    inst.components.health:SetMaxHealth(TUNING.SPAT_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.SPAT_PHLEGM_DAMAGE*1.5)
end end
function birchnutdrake_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster4x")
    inst.components.health:SetMaxHealth(200)
    inst.components.combat:SetDefaultDamage(15)
end end
function merm_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster4x")
    inst.components.health:SetMaxHealth(TUNING.MERM_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.MERM_DAMAGE*2)
end end
function bat_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster4x")
    inst.components.health:SetMaxHealth(TUNING.BAT_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.BAT_DAMAGE*2)
end end
function walus_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster4x")
    inst.components.health:SetMaxHealth(TUNING.WALRUS_HEALTH*6)
    inst.components.locomotor.runspeed = 8
    inst.components.locomotor.walkspeed = 2
end end
function monkey_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster4x")
    inst.components.health:SetMaxHealth(TUNING.MONKEY_HEALTH*6)
end end
function eyeplant_4x(inst)
if IsServer and inst.components.health then
        inst:AddTag("monster2x")
    inst.components.health:SetMaxHealth(TUNING.EYEPLANT_HEALTH*6)
    inst.components.combat:SetDefaultDamage(TUNING.EYEPLANT_DAMAGE*2)
end end
function antlion_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.ANTLION_HEALTH*5.5)
    inst:AddTag("giant4x")
end end
function stalker_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.STALKER_HEALTH*5)
    inst:AddTag("giant4x")
end end
function stalker_atrium_4x(inst)
if IsServer and inst.components.health then
    inst.components.health:SetMaxHealth(TUNING.STALKER_ATRIUM_HEALTH*5)
    inst:AddTag("giant4x")
end end

AddPrefabPostInit("deerclops", deerclops_4x)
AddPrefabPostInit("bearger", bearger_4x)
AddPrefabPostInit("dragonfly", dragonfly_4x)
AddPrefabPostInit("moose", moose_4x)
AddPrefabPostInit("mossling", mossling_4x)
AddPrefabPostInit("spider", nspider_4x)
AddPrefabPostInit("spider_warrior", wspider_4x)
AddPrefabPostInit("spiderqueen", qspider_4x)
AddPrefabPostInit("spider_hider", chspider_4x)
AddPrefabPostInit("spider_spitter", csspider_4x)
AddPrefabPostInit("spider_dropper", cdspider_4x)
AddPrefabPostInit("hound", nhound_4x)
AddPrefabPostInit("firehound", fhound_4x)
AddPrefabPostInit("icehound", ihound_4x)
AddPrefabPostInit("warg", warg_4x)
AddPrefabPostInit("tentacle", tentacle_4x)
AddPrefabPostInit("rook", rook_4x)
AddPrefabPostInit("minotaur", minotaur_4x)
AddPrefabPostInit("bishop", bishop_4x)
AddPrefabPostInit("tallbird", tallbird_4x)
AddPrefabPostInit("leif", leif_4x)
AddPrefabPostInit("spat", spat_4x)
AddPrefabPostInit("merm", merm_4x)
AddPrefabPostInit("birchnutdrake", birchnutdrake_4x)
AddPrefabPostInit("bat", bat_4x)
AddPrefabPostInit("walus", walus_4x)
AddPrefabPostInit("monkey", monkey_4x)
AddPrefabPostInit("eyeplant", eyeplant_4x)
AddPrefabPostInit("toadstool", toadstool_4x)
AddPrefabPostInit("beequeen", beequeen_4x)
AddPrefabPostInit("antlion", antlion_4x)
AddPrefabPostInit("stalker", stalker_4x)
AddPrefabPostInit("stalker_atrium", stalker_atrium_4x)
--AddPrefabPostInit("buzzard", buzzard_4x)
end