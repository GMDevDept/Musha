local UI_LEFT, UI_RIGHT = -214, 228
local UI_VERTICAL_MIDDLE = (UI_LEFT + UI_RIGHT) * 0.5
local UI_TOP, UI_BOTTOM = 176, 20
local TILE_SIZE, TILE_HALFSIZE = 34, 16

--------------------------------------------------------------------------------------------------

local ORDERS =
{
    { "generic", { UI_LEFT, UI_TOP } },
}

--------------------------------------------------------------------------------------------------

local function BuildSkillsData(SkillTreeFns)
    local skills =
    {
        valkyriemode = {
            title = STRINGS.musha.skills.valkyriemode.name,
            desc = STRINGS.musha.skills.valkyriemode.desc,
            icon = "wilson_favor_lunar",
            pos = { UI_VERTICAL_MIDDLE, UI_BOTTOM + 100 },

            group = "generic",
            tags = {},
            unlocklevel = 3,
            root = true,
            connects = {
                "thunderspell",
                "setsugetsuka",
                "annihilation",
                "desolatedive",
                "magpiestep",
                "valkyrieparry",
                "lightningstrike",
                "stronggrip",
                "areaattack",
                "fightingspirit",
            }
        },

        maxstamina1 = {
            title = STRINGS.musha.skills.maxstamina1.name,
            desc = STRINGS.musha.skills.maxstamina1.desc,
            icon = "wolfgang_planardamage_1",
            pos = { UI_VERTICAL_MIDDLE, UI_BOTTOM + 10 },

            group = "generic",
            tags = {},
            root = true,
            connects = {
                "maxstamina2",
                "staminaregen1",
            },

            onactivate = function(inst, data)
                inst:RecalcStatus("stamina", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("stamina")
            end,
        },
        maxstamina2 = {
            title = STRINGS.musha.skills.maxstamina2.name,
            desc = STRINGS.musha.skills.maxstamina2.desc,
            icon = "wolfgang_planardamage_3",
            pos = { UI_VERTICAL_MIDDLE - 50, UI_BOTTOM - 10 },

            group = "generic",
            tags = {},
            connects = {
                "maxstamina3",
            },

            onactivate = function(inst, data)
                inst:RecalcStatus("stamina", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("stamina")
            end,
        },
        maxstamina3 = {
            title = STRINGS.musha.skills.maxstamina3.name,
            desc = STRINGS.musha.skills.maxstamina3.desc,
            icon = "wolfgang_planardamage_5",
            pos = { UI_VERTICAL_MIDDLE - 100, UI_BOTTOM - 10 },

            group = "generic",
            tags = {},
            unlocklevel = 10,

            onactivate = function(inst, data)
                inst:RecalcStatus("stamina", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("stamina")
            end,
        },
        staminaregen1 = {
            title = STRINGS.musha.skills.staminaregen1.name,
            desc = STRINGS.musha.skills.staminaregen1.desc,
            icon = "woodie_curse_weremeter_1",
            pos = { UI_VERTICAL_MIDDLE + 50, UI_BOTTOM - 10 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
            connects = {
                "staminaregen2",
            },
        },
        staminaregen2 = {
            title = STRINGS.musha.skills.staminaregen2.name,
            desc = STRINGS.musha.skills.staminaregen2.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_VERTICAL_MIDDLE + 100, UI_BOTTOM - 10 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        setsugetsuka = {
            title = STRINGS.musha.skills.setsugetsuka.name,
            desc = STRINGS.musha.skills.setsugetsuka.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE - 95, UI_BOTTOM + 175 },

            group = "generic",
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
            pos = { UI_VERTICAL_MIDDLE - 150, UI_BOTTOM + 175 },

            group = "generic",
            tags = {},
        },
        setsugetsukaredux = {
            title = STRINGS.musha.skills.setsugetsukaredux.name,
            desc = STRINGS.musha.skills.setsugetsukaredux.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE - 205, UI_BOTTOM + 175 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        valkyrieparry = {
            title = STRINGS.musha.skills.valkyrieparry.name,
            desc = STRINGS.musha.skills.valkyrieparry.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 95, UI_BOTTOM + 175 },

            group = "generic",
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
            pos = { UI_VERTICAL_MIDDLE + 150, UI_BOTTOM + 175 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
        },
        valkyriewhirl = {
            title = STRINGS.musha.skills.valkyriewhirl.name,
            desc = STRINGS.musha.skills.valkyriewhirl.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 205, UI_BOTTOM + 175 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
        },

        lightningstrike = {
            title = STRINGS.musha.skills.lightningstrike.name,
            desc = STRINGS.musha.skills.lightningstrike.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE, UI_BOTTOM + 150 },

            group = "generic",
            tags = {},
        },

        thunderspell = {
            title = STRINGS.musha.skills.manaspells.thunderspell.name,
            desc = STRINGS.musha.skills.manaspells.thunderspell.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 95, UI_BOTTOM + 95 },

            group = "generic",
            tags = {},
        },

        annihilation = {
            title = STRINGS.musha.skills.annihilation.name,
            desc = STRINGS.musha.skills.annihilation.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 135, UI_BOTTOM + 95 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
        },

        desolatedive = {
            title = STRINGS.musha.skills.desolatedive.name,
            desc = STRINGS.musha.skills.desolatedive.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 175, UI_BOTTOM + 95 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
        },

        magpiestep = {
            title = STRINGS.musha.skills.magpiestep.name,
            desc = STRINGS.musha.skills.magpiestep.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 95, UI_BOTTOM + 50 },

            group = "generic",
            tags = {},
            connects = {
                "magpieslash",
            },
        },
        magpieslash = {
            title = STRINGS.musha.skills.magpieslash.name,
            desc = STRINGS.musha.skills.magpieslash.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE + 135, UI_BOTTOM + 50 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        stronggrip = {
            title = STRINGS.musha.skills.stronggrip.name,
            desc = STRINGS.musha.skills.stronggrip.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE - 95, UI_BOTTOM + 95 },

            group = "generic",
            tags = {},
        },

        areaattack = {
            title = STRINGS.musha.skills.areaattack.name,
            desc = STRINGS.musha.skills.areaattack.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE - 135, UI_BOTTOM + 95 },

            group = "generic",
            tags = {},
        },

        fightingspirit = {
            title = STRINGS.musha.skills.fightingspirit.name,
            desc = STRINGS.musha.skills.fightingspirit.desc,
            icon = "wolfgang_critwork_2",
            pos = { UI_VERTICAL_MIDDLE - 175, UI_BOTTOM + 95 },

            group = "generic",
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
