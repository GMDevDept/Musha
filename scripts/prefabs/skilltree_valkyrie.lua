local UI_LEFT, UI_RIGHT = -214, 228
local UI_VERTICAL_MIDDLE = (UI_LEFT + UI_RIGHT) * 0.5
local UI_TOP, UI_BOTTOM = 176, 20
local TILE_SIZE, TILE_HALFSIZE = 34, 16

--------------------------------------------------------------------------------------------------

local ORDERS =
{
    { "crafting",    { UI_LEFT, UI_TOP } },
    { "gathering",   { UI_LEFT, UI_TOP } },
}

--------------------------------------------------------------------------------------------------

local function BuildSkillsData(SkillTreeFns)
    local skills =
    {
        valkyriemode = {
            title = STRINGS.musha.skills.valkyriemode.name,
            desc = STRINGS.musha.skills.valkyriemode.desc,
            icon = "wilson_favor_lunar",
            pos = {(UI_LEFT + UI_RIGHT) * 0.5, UI_BOTTOM},

            group = "gathering",
            tags = {},
            root = true,
            connects = {
                "thunderspell",
                "setsugetsuka",
                "annihilation",
                "desolatedive",
                "magpiestep",
                "valkyrieparry",
                "lightningstrike",
            }
        },

        maxstamina1 = {
            title = STRINGS.musha.skills.maxstamina1.name,
            desc = STRINGS.musha.skills.maxstamina1.desc,
            icon = "wolfgang_planardamage_1",
            pos = {UI_VERTICAL_MIDDLE - 105, UI_BOTTOM + 10},

            group = "crafting",
            tags = {},
            root = true,
            connects = {
                "maxstamina2",
            },
        },
        maxstamina2 = {
            title = STRINGS.musha.skills.maxstamina2.name,
            desc = STRINGS.musha.skills.maxstamina2.desc,
            icon = "wolfgang_planardamage_3",
            pos = {UI_VERTICAL_MIDDLE - 105 - 50, UI_BOTTOM + 10},

            group = "crafting",
            tags = {},
            connects = {
                "maxstamina3",
                "staminaregen1",
            },
        },
        maxstamina3 = {
            title = STRINGS.musha.skills.maxstamina3.name,
            desc = STRINGS.musha.skills.maxstamina3.desc,
            icon = "wolfgang_planardamage_5",
            pos = {UI_VERTICAL_MIDDLE - 105 - 100, UI_BOTTOM + 10},

            group = "crafting",
            tags = {},
        },
        staminaregen1 = {
            title = STRINGS.musha.skills.staminaregen1.name,
            desc = STRINGS.musha.skills.staminaregen1.desc,
            icon = "woodie_curse_weremeter_1",
            pos = {UI_VERTICAL_MIDDLE - 115 - 60, UI_BOTTOM + 58},

            group = "crafting",
            tags = {},
            connects = {
                "staminaregen2",
            },
        },
        staminaregen2 = {
            title = STRINGS.musha.skills.staminaregen2.name,
            desc = STRINGS.musha.skills.staminaregen2.desc,
            icon = "woodie_curse_weremeter_2",
            pos = {UI_VERTICAL_MIDDLE - 115 - 120, UI_BOTTOM + 58},

            group = "crafting",
            tags = {},
        },

        setsugetsuka = {
            title = STRINGS.musha.skills.setsugetsuka.name,
            desc = STRINGS.musha.skills.setsugetsuka.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE - 35, UI_BOTTOM + 65},

            group = "crafting",
            tags = {},
            connects = {
                "setsugetsukaredux",
                "phoenixadvent",
            },
        },
        phoenixadvent = {
            title = STRINGS.musha.skills.phoenixadvent.name,
            desc = STRINGS.musha.skills.phoenixadvent.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE - 90, UI_BOTTOM + 95},

            group = "crafting",
            tags = {},
        },
        setsugetsukaredux = {
            title = STRINGS.musha.skills.setsugetsukaredux.name,
            desc = STRINGS.musha.skills.setsugetsukaredux.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE - 30, UI_BOTTOM + 125},

            group = "crafting",
            tags = {},
        },

        lightningstrike = {
            title = STRINGS.musha.skills.lightningstrike.name,
            desc = STRINGS.musha.skills.lightningstrike.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 105, UI_BOTTOM + 10},

            group = "gathering",
            tags = {},
        },
        annihilation = {
            title = STRINGS.musha.skills.annihilation.name,
            desc = STRINGS.musha.skills.annihilation.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 105 + 50, UI_BOTTOM + 10},

            group = "gathering",
            tags = {},
        },
        thunderspell = {
            title = STRINGS.musha.skills.manaspells.thunderspell.name,
            desc = STRINGS.musha.skills.manaspells.thunderspell.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 165, UI_BOTTOM + 60},

            group = "gathering",
            tags = {},
        },
        desolatedive = {
            title = STRINGS.musha.skills.desolatedive.name,
            desc = STRINGS.musha.skills.desolatedive.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 105 + 100, UI_BOTTOM + 10},

            group = "gathering",
            tags = {},
        },

        valkyrieparry = {
            title = STRINGS.musha.skills.valkyrieparry.name,
            desc = STRINGS.musha.skills.valkyrieparry.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 55, UI_BOTTOM + 45 + TILE_SIZE},

            group = "gathering",
            tags = {},
            connects = {
                "valkyrieparry_perfect",
                "valkyriewhirl",
            },
        },
        valkyrieparry_perfect = {
            title = STRINGS.musha.skills.valkyrieparry_perfect.name,
            desc = STRINGS.musha.skills.valkyrieparry_perfect.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 43, UI_BOTTOM + 150},

            group = "gathering",
            tags = {},
        },
        valkyriewhirl = {
            title = STRINGS.musha.skills.valkyriewhirl.name,
            desc = STRINGS.musha.skills.valkyriewhirl.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 95, UI_BOTTOM + 115},

            group = "gathering",
            tags = {},
        },

        magpiestep = {
            title = STRINGS.musha.skills.magpiestep.name,
            desc = STRINGS.musha.skills.magpiestep.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 150, UI_BOTTOM + 130},

            group = "gathering",
            tags = {},
            connects = {
                "magpieslash",
            },
        },
        magpieslash = {
            title = STRINGS.musha.skills.magpieslash.name,
            desc = STRINGS.musha.skills.magpieslash.desc,
            icon = "wolfgang_critwork_2",
            pos = {UI_VERTICAL_MIDDLE + 200, UI_BOTTOM + 150},

            group = "gathering",
            tags = {},
        },
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData
