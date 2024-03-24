-- Basic info
name = "Musha"
description = [[
    Rebuilt Musha character mod of Don't Starve Together
]]
author = ""
version = "0.1.0"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Required by all clients
all_clients_require_mod = true
client_only_mod = false

-- Icon shown in the mods list
icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- Higher priority means the mod will get loaded first
-- priority = 2147483647

-- The mod's tags displayed on the server list
server_filter_tags = {
    "Musha",
}

---------------------------------------------------------------------------------------------------------

key_options = {
    { description = "TAB", data = 9 },
    { description = "KP_PERIOD", data = 266 },
    { description = "KP_DIVIDE", data = 267 },
    { description = "KP_MULTIPLY", data = 268 },
    { description = "KP_MINUS", data = 269 },
    { description = "KP_PLUS", data = 270 },
    { description = "KP_ENTER", data = 271 },
    { description = "KP_EQUALS", data = 272 },
    { description = "MINUS", data = 45 },
    { description = "EQUALS", data = 61 },
    { description = "SPACE", data = 32 },
    { description = "ENTER", data = 13 },
    { description = "ESCAPE", data = 27 },
    { description = "HOME", data = 278 },
    { description = "INSERT", data = 277 },
    { description = "DELETE", data = 127 },
    { description = "END", data = 279 },
    { description = "PAUSE", data = 19 },
    { description = "PRINT", data = 316 },
    { description = "CAPSLOCK", data = 301 },
    { description = "SCROLLOCK", data = 302 },
    { description = "RSHIFT", data = 303 }, -- use SHIFT instead
    { description = "LSHIFT", data = 304 }, -- use SHIFT instead
    { description = "RCTRL", data = 305 }, -- use CTRL instead
    { description = "LCTRL", data = 306 }, -- use CTRL instead
    { description = "RALT", data = 307 }, -- use ALT instead
    { description = "LALT", data = 308 }, -- use ALT instead
    { description = "ALT", data = 400 },
    { description = "CTRL", data = 401 },
    { description = "SHIFT", data = 402 },
    { description = "BACKSPACE", data = 8 },
    { description = "PERIOD", data = 46 },
    { description = "SLASH", data = 47 },
    { description = "LEFTBRACKET", data = 91 },
    { description = "BACKSLASH", data = 92 },
    { description = "RIGHTBRACKET", data = 93 },
    { description = "TILDE", data = 96 },

    { description = "A", data = 97 },
    { description = "B", data = 98 },
    { description = "C", data = 99 },
    { description = "D", data = 100 },
    { description = "E", data = 101 },
    { description = "F", data = 102 },
    { description = "G", data = 103 },
    { description = "H", data = 104 },
    { description = "I", data = 105 },
    { description = "J", data = 106 },
    { description = "K", data = 107 },
    { description = "L", data = 108 },
    { description = "M", data = 109 },
    { description = "N", data = 110 },
    { description = "O", data = 111 },
    { description = "P", data = 112 },
    { description = "Q", data = 113 },
    { description = "R", data = 114 },
    { description = "S", data = 115 },
    { description = "T", data = 116 },
    { description = "U", data = 117 },
    { description = "V", data = 118 },
    { description = "W", data = 119 },
    { description = "X", data = 120 },
    { description = "Y", data = 121 },
    { description = "Z", data = 122 },
    { description = "F1", data = 282 },
    { description = "F2", data = 283 },
    { description = "F3", data = 284 },
    { description = "F4", data = 285 },
    { description = "F5", data = 286 },
    { description = "F6", data = 287 },
    { description = "F7", data = 288 },
    { description = "F8", data = 289 },
    { description = "F9", data = 290 },
    { description = "F10", data = 291 },
    { description = "F11", data = 292 },
    { description = "F12", data = 293 },

    { description = "UP", data = 273 },
    { description = "DOWN", data = 274 },
    { description = "RIGHT", data = 275 },
    { description = "LEFT", data = 276 },
    { description = "PAGEUP", data = 280 },
    { description = "PAGEDOWN", data = 281 },

    { description = "0", data = 48 },
    { description = "1", data = 49 },
    { description = "2", data = 50 },
    { description = "3", data = 51 },
    { description = "4", data = 52 },
    { description = "5", data = 53 },
    { description = "6", data = 54 },
    { description = "7", data = 55 },
    { description = "8", data = 56 },
    { description = "9", data = 57 },
}

-- Configuration options
configuration_options = {
    {
        name = "modlanguage",
        label = "Mod Language",
        hover = "Choose mod language\n选择语言",
        options = {
            { description = "中文", data = "chinese" },
            { description = "English", data = "english" },
            { description = "한글", data = "korean" },
            { description = "русский", data = "russian" },
        },
        default = "chinese",
    },
    {
        name = "hotkey_valkyrie",
        label = "Activate Valkyrie Mode",
        hover = "Activate valkyrie mode/lightning charge\n激活女武神模式/充能闪电",
        options = key_options,
        default = 114, -- R
    },
    {
        name = "hotkey_shadow",
        label = "Activate Shadow Mode",
        hover = "Activate shadow mode/sneaking\n激活暗影模式/潜影突袭",
        options = key_options,
        default = 103, -- G
    },
    {
        name = "hotkey_shield",
        label = "Mana Shield",
        hover = "Activate mana shield/激活精灵护盾",
        options = key_options,
        default = 116, -- T
    },
    {
        name = "hotkey_sleep",
        label = "Go Sleep",
        hover = "Go sleep/wake up\n睡觉/醒来",
        options = key_options,
        default = 122, -- Z
    },
    {
        name = "hotkey_elfmelody",
        label = "Play Elf Melody and Sniff Treasure",
        hover = "Play elf melody/sniff treasure\n演奏精灵旋律/寻宝",
        options = key_options,
        default = 120, -- X
    },
    {
        name = "hotkey_keybinding",
        label = "Switch Companion Order Hotkeys",
        hover = "Switch ON/OFF companion order hotkey bindings (F2-F11)\n开启/关闭随从命令快捷键 (F2-F11)",
        options = key_options,
        default = 282, -- F1
    },
    {
        name = "hotkey_shadowmusha",
        label = "Companion Order: Shadow Musha",
        hover = "Order all shadow mushas to enter follow-only mode/normal mode\n命令所有影子Musha进入跟随模式/正常行动模式",
        options = key_options,
        default = 283, -- F2
    }
}
