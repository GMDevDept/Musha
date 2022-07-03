TUNING.MUSHA = {
    -- Hotkeys from modinfo
    hotkey_valkyrie = GetModConfigData("hotkey_valkyrie") or 114, --R
    hotkey_stealth = GetModConfigData("hotkey_stealth") or 115, --G

    -- Stats related
    health = 200,
    hunger = 200,
    sanity = 200,

    maxmana = 50,
    manaregenspeed = -0.33,

    maxexp = 300,
    maxlvl = 30,
    exprate = 1,
    exp_to_level = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210,
        220, 230, 240, 250, 260, 270, 280, 290, 300 }, -- len = 30
}
