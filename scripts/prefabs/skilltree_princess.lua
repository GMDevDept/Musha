local UI_LEFT, UI_RIGHT = -214, 228
local UI_VERTICAL_MIDDLE = (UI_LEFT + UI_RIGHT) * 0.5
local UI_TOP, UI_BOTTOM = 176, 20

--------------------------------------------------------------------------------------------------

local ORDERS =
{
    { "generic", { UI_LEFT, UI_TOP } },
}

--------------------------------------------------------------------------------------------------

local function BuildSkillsData(SkillTreeFns)
    local skills =
    {
        freezingspell = {
            title = STRINGS.musha.skills.manaspells.freezingspell.name,
            desc = STRINGS.musha.skills.manaspells.freezingspell.desc,
            icon = "wolfgang_planardamage_1",
            pos = { UI_LEFT, UI_TOP },

            group = "generic",
            tags = {},
            root = true,
            connects = {
                "freezingspellboost",
            },
        },
        freezingspellboost = {
            title = STRINGS.musha.skills.manaspells.freezingspellboost.name,
            desc = STRINGS.musha.skills.manaspells.freezingspellboost.desc,
            icon = "wolfgang_planardamage_3",
            pos = { UI_LEFT + 40, UI_TOP },

            group = "generic",
            tags = {},
            unlocklevel = 5,
        },

        maxmana1 = {
            title = STRINGS.musha.skills.maxmana1.name,
            desc = STRINGS.musha.skills.maxmana1.desc,
            icon = "wolfgang_planardamage_1",
            pos = { UI_LEFT + 20, UI_TOP - 70 },

            group = "generic",
            tags = {},
            root = true,
            connects = {
                "maxmana2",
                "manaregen1",
            },

            onactivate = function(inst, data)
                inst:RecalcStatus("mana", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("mana")
            end,
        },
        maxmana2 = {
            title = STRINGS.musha.skills.maxmana2.name,
            desc = STRINGS.musha.skills.maxmana2.desc,
            icon = "wolfgang_planardamage_3",
            pos = { UI_LEFT, UI_TOP - 70 - 45 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
            connects = {
                "maxmana3",
            },

            onactivate = function(inst, data)
                inst:RecalcStatus("mana", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("mana")
            end,
        },
        maxmana3 = {
            title = STRINGS.musha.skills.maxmana3.name,
            desc = STRINGS.musha.skills.maxmana3.desc,
            icon = "wolfgang_planardamage_5",
            pos = { UI_LEFT, UI_TOP - 70 - 45 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 10,

            onactivate = function(inst, data)
                inst:RecalcStatus("mana", data.init)
            end,
            ondeactivate = function(inst, data)
                inst:RecalcStatus("mana")
            end,
        },
        manaregen1 = {
            title = STRINGS.musha.skills.manaregen1.name,
            desc = STRINGS.musha.skills.manaregen1.desc,
            icon = "woodie_curse_weremeter_1",
            pos = { UI_LEFT + 40, UI_TOP - 70 - 45 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
            connects = {
                "manaregen2",
            },
        },
        manaregen2 = {
            title = STRINGS.musha.skills.manaregen2.name,
            desc = STRINGS.musha.skills.manaregen2.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 40, UI_TOP - 70 - 45 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 15,
        },

        wormwood_bugs = {
            title = STRINGS.musha.skills.wormwood_bugs.name,
            desc = STRINGS.musha.skills.wormwood_bugs.desc,
            icon = "wormwood_bugs",
            pos = { UI_LEFT + 130, UI_TOP },

            group = "generic",
            tags = {},
            root = true,
            redirect_isactivated = function(inst, data)
                return inst.mode:value() == 1
            end,
        },

        manashield = {
            title = STRINGS.musha.skills.manashield.name,
            desc = STRINGS.musha.skills.manashield.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 130, UI_TOP - 70 },

            group = "generic",
            tags = {},
            root = true,
            unlocklevel = 3,
            connects = {
                "manashielddurability1",
                "princessblessing",
            },
        },
        manashielddurability1 = {
            title = STRINGS.musha.skills.manashielddurability1.name,
            desc = STRINGS.musha.skills.manashielddurability1.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 110, UI_TOP - 70 - 45 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
            connects = {
                "manashielddurability2",
            },
        },
        manashielddurability2 = {
            title = STRINGS.musha.skills.manashielddurability2.name,
            desc = STRINGS.musha.skills.manashielddurability2.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 110, UI_TOP - 70 - 45 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 20,
        },
        princessblessing = {
            title = STRINGS.musha.skills.princessblessing.name,
            desc = STRINGS.musha.skills.princessblessing.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 150, UI_TOP - 70 - 45 },

            group = "generic",
            tags = {},
            unlocklevel = 5,
            connects = {
                "princessblessingduration1",
            },
        },
        princessblessingduration1 = {
            title = STRINGS.musha.skills.princessblessingduration1.name,
            desc = STRINGS.musha.skills.princessblessingduration1.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 150, UI_TOP - 70 - 45 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        rollingmagma = {
            title = STRINGS.musha.skills.launchelement.rollingmagma.name,
            desc = STRINGS.musha.skills.launchelement.rollingmagma.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 260, UI_TOP - 50 },

            group = "generic",
            tags = {},
            root = true,
            unlocklevel = 5,
            connects = {
                "chargedrollingmagma",
            },
        },
        chargedrollingmagma = {
            title = STRINGS.musha.skills.launchelement.chargedrollingmagma.name,
            desc = STRINGS.musha.skills.launchelement.chargedrollingmagma.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 260, UI_TOP - 50 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        whitefrost = {
            title = STRINGS.musha.skills.launchelement.whitefrost.name,
            desc = STRINGS.musha.skills.launchelement.whitefrost.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 300, UI_TOP - 50 },

            group = "generic",
            tags = {},
            root = true,
            unlocklevel = 6,
            connects = {
                "chargedwhitefrost",
            },
        },
        chargedwhitefrost = {
            title = STRINGS.musha.skills.launchelement.chargedwhitefrost.name,
            desc = STRINGS.musha.skills.launchelement.chargedwhitefrost.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 300, UI_TOP - 50 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        poisonspore = {
            title = STRINGS.musha.skills.launchelement.poisonspore.name,
            desc = STRINGS.musha.skills.launchelement.poisonspore.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 340, UI_TOP - 50 },

            group = "generic",
            tags = {},
            root = true,
            unlocklevel = 7,
            connects = {
                "chargedpoisonspore",
            },
        },
        chargedpoisonspore = {
            title = STRINGS.musha.skills.launchelement.chargedpoisonspore.name,
            desc = STRINGS.musha.skills.launchelement.chargedpoisonspore.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 340, UI_TOP - 50 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 10,
        },

        bloomingfield = {
            title = STRINGS.musha.skills.launchelement.bloomingfield.name,
            desc = STRINGS.musha.skills.launchelement.bloomingfield.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 380, UI_TOP - 50 },

            group = "generic",
            tags = {},
            root = true,
            unlocklevel = 8,
            connects = {
                "chargedbloomingfield",
            },
        },
        chargedbloomingfield = {
            title = STRINGS.musha.skills.launchelement.chargedbloomingfield.name,
            desc = STRINGS.musha.skills.launchelement.chargedbloomingfield.desc,
            icon = "woodie_curse_weremeter_2",
            pos = { UI_LEFT + 380, UI_TOP - 50 - 40 },

            group = "generic",
            tags = {},
            unlocklevel = 12,
        },
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

--------------------------------------------------------------------------------------------------

return BuildSkillsData
