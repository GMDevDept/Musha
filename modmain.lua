-- Inherit variables from GLOBAL
GLOBAL.setmetatable(env,{__index = function(t,k) 
    return GLOBAL.rawget(GLOBAL,k) 
end})

-- Run scripts
modimport("scripts/prefab_asset.lua")
modimport("scripts/musha_adds_skins.lua")
modimport("scripts/musha_adds_recipe.lua")
modimport("scripts/musha_adds_actions.lua")

-- Configuration options from modinfo
local modlanguage =  GetModConfigData("modlanguage")

-- Hotkeys from modinfo
GLOBAL.TUNING.MUSHA = {}
GLOBAL.TUNING.MUSHA.hotkey_valkyrie = GetModConfigData("hotkey_valkyrie") or 114  --R
GLOBAL.TUNING.MUSHA.hotkey_stealth = GetModConfigData("hotkey_stealth") or 115  --G

-- Custom strings (i18n)
if  modlanguage == "english" then
	modimport("scripts/strings_musha_en.lua")   
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_en"    
elseif modlanguage == "chinese" then
	modimport("scripts/strings_musha_cn.lua")
	STRINGS.CHARACTERS.MUSHA = require "speech_musha_cn"
end

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    ghost_skin = {
        type = "ghost_skin", -- When skin tab is setup, ghost skin will automatically be added, however you can change the zoom ratio using this option
        anim_bank = "ghost", -- "wilson" or "ghost" unless you are not using the default animation banks like werebeaver
        idle_anim = "idle", -- default animation to play such as "idle" or "idle_loop" for ghosts see SG_wilson
        play_emotes = false, -- enable or disable emotes, werebeaver and ghost cannot play emotes
        scale = 0.5, -- multiplier to change the size: zoom out 50%
        offset = { 0, -25 } -- x,y offset: move down
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("musha", "FEMALE", skin_modes)

