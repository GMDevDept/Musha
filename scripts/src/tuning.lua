TUNING.musha = {
    singleclicktimewindow = 0.2,

    freezecooldowntime = 5,

    health = 200,
    hunger = 200,
    sanity = 200,

    stalefoodhungerrate = 1 / 3,
    spoiledfoodhungerrate = 1 / 6,

    maxmana = 200,
    manaregenspeed = 0.5,

    maxstamina = 200,
    staminarate = 0,

    maxfatigue = 100,
    fatiguebaserate = 1 / 48, -- 10/day
    fatiguerate1 = 0.02,
    fatiguerate2 = 0.05,
    fatiguerate3 = 0.1,
    fatiguerate4 = 0.2,
    fatiguerate5 = 0.5,
    fatiguelevel = {
        level0 = {
            upper = 0.1,
            workmultiplier = 1.5,
            speedmultiplier = 1.15,
        },
        level1 = {
            upper = 0.4,
        },
        level2 = {
            upper = 0.65,
            workmultiplier = 0.75,
            speedmultiplier = 0.9,
        },
        level3 = {
            upper = 0.85,
            workmultiplier = 0.5,
            speedmultiplier = 0.8,
            groggyprobmin = 0.025,
            groggyprobmax = 0.05,
            groggytimebase = 2,
            groggytimemultiplier = 5,
            groggyspeedmultiplier = 0.5,
        },
        level4 = {
            upper = 1,
            workmultiplier = 0.1,
            speedmultiplier = 0.75,
            groggyprobmin = 0.05,
            groggyprobmax = 0.2,
            groggytimebase = 5,
            groggytimemultiplier = 10,
            groggyspeedmultiplier = 1 / 3,
            knockoutprob = 0.025,
        },
    },

    damagemultiplier = 0.8,
    damageonmaxstamina = 0.8,
    damageonminstamina = 0.5,
    areahitdamagepercent = 0.25,
    areaattackrange = 3,

    sleep = {
        fatiguerate = {
            poor = -0.5,
            good = -1.5,
            perfect = -2,
            daytimemultiplier = 0.5,
        }
    },

    charactermode = {
        full = {
            healthregen = 0.1,
            sanityregen = 0.1,
            staminaregen = 1,
            manaregen = 0.5,
            hungerdrain = 1.5,
            fatiguemultiplier = 1.5,
        },
        valkyrie = {
            damagetakenmultiplier = 0.8,
            bonusdamagetomonster = 0.5,
            fatiguemultiplier = 2,
            manaregenbyelectric = 10,
            manaongoingmodifier = 0,
            healthregenonkill = 0.02,
            sanityregenonkill = 0.01,
            manaregenonkill = 0.025,
            drowningdamage = {
                HEALTH_PENALTY = 0,
                HUNGER = 0,
                SANITY = 0,
                WETNESS = 100,
            },
        },
        shadow = {
            sanitypenaltyongoing = 0.5, -- per second
            sanitypenaltyrecaltime = 10,
            sanitypenaltydeltaonrefuel = 25,
            sanitypenaltydeltaonkill = 25,
            sanityregen = 3,
            negsanityauraabsorb = 1,
            bonusdamagetoshadow = 0.5,
        },
    },

    debuffslowdownmult = 0.25,
    debuffslowdownduration = 5,

    debuffparalysisattackperiodmult = 2,
    debuffparalysisattackperiodmax = 4,
    debuffparalysisduration = 8,
    debuffparalysisperiod = 2,
    debuffparalysisdamage = 5,

    foodbonus = {
        taffy = {
            health = 3,
            mana = 10,
            stamina = 20,
        },
        jellybean = {
            mana = 1,
            stamina = 2,
            duration = 30,
        },
    },

    maxpets = 50,

    maxexperience = 300,
    maxlevel = 30,
    exprate = 1,
    exp_to_level = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210,
        220, 230, 240, 250, 260, 270, 280, 290, 300 }, -- len = 30
    _exp_to_level = { 1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 100, 125, 150, 175, 200,
        250, 300, 350, 400, 500, 600, 700, 800, 900, 1000 }, -- len = 30

    leveltounlockskill = { -- Maintain src/timers.lua after adding new skill with cooldown timer
        freezingspell     = 0,
        manashield        = 0,
        princessblessing  = 0,
        valkyriemode      = 0, -- Should be same as desolatedive
        shadowmode        = 0,
        thunderspell      = 0,
        shadowspell       = 0,
        shadowprison      = 0,
        sneak             = 0,
        sneakspeedboost   = 0,
        rollingmagma      = 0,
        whitefrost        = 0,
        poisonspore       = 0,
        setsugetsuka      = 0,
        setsugetsukaredux = 0,
        phoenixadvent     = 0,
        annihilation      = 0,
        desolatedive      = 0,
        magpiestep        = 0,
        valkyrieparry     = 0,
        valkyriewhirl     = 0,
        shadowparry       = 0,
        voidphantom       = 0,
        phantomslash      = 0,
        phantomblossom    = 0,
    },

    skills = {
        treasuresniffing = {
            max = 960, -- 2 days
            regen = 1,
            first = 60,
            chestchance = 0.25,
        },
        elfmelody = {
            max = 100,
            regen_small = 1,
            regen_large = 1.5,
            minrequired = 20,
            full = {
                manarecover = 50,
                manaregen = 5,
                staminaregen = 5,
                speedboost = 1.3,
                duration = 240,
                cooldown = 480,
            },
            partial = {
                manarecover = 30,
                manaregen = 3,
                staminaregen = 3,
                speedboost = 1.2,
                duration = 30,
                cooldown = 60,
            },
        },
        freezingspell = {
            manacost = 5,
            maxmanacost = 15,
            range = 14,
            rangegrowth = 0.2,
            coldness = 1,
            coldnessgrowth = 0.1,
            cooldown = 3,
        },
        thunderspell = {
            manacost = 5,
            maxmanacost = 15,
            range = 14,
            damage = 20,
            damagegrowth = 1,
            cooldown = 10,
            duration = 8,
            durationgrowth = 0.4,
        },
        shadowspell = {
            basedamage = 10,
            damagegrowth = 5, -- per 5 levels
            sanitycost = 50,
            cooldown = 5,
        },
        shadowprison = {
            manacost = 15,
            sanitycost = 15,
            range = 9, -- Reference only, check shadow_pillar_musha prefab
            cooldown = 12,
        },
        manashield = {
            manacost = 5,
            manaongoingcost = 1,
            damageabsorbrate = 0.5, -- Only affect health:DoDelta, combat:GetAttacked will always be cancelled
            lighttime = 4,
            brokendelay = 3,
            durabilitybase = 600,
            durabilitygrowth = 30,
            durabilitybasedamage = 10,
            durabilitydamagemultiplier = 5,
            healthtodurabilitymultiplier = 2,
            cooldown = 30,
        },
        princessblessing = {
            manacost = 15,
            maxmanacost = 45,
            duration = 15,
            cooldown = 15,
            range = 18,
        },
        valkyriemode = {
            cooldown = 20,
            manacost = 30,
        },
        shadowmode = {
            cooldown = 20,
            sanitycost = 50,
        },
        sneak = {
            sanitycost = 50,
            backstabbasedamage = 100,
            preparetime = 4,
        },
        sneakspeedboost = {
            min = 1.5,
            max = 2.5,
            staminacost = 10,
            backstabbonustime = 2,
        },
        launchelement = {
            maxdelay = 10,
            rollingmagma = {
                manacost = 5,
                damage = 35,
                damageperhit = 1 / 3,
                radius = 4,
                forceignitecounter = 3,
                igniteframe = 10,
                cooldown = 1,
                duration = 3,
                charged = {
                    extramanacost = 20,
                    range = 10,
                    mindistinterval = 2,
                    chargetime = 2,
                    mincount = 20,
                    maxcount = 30,
                    cooldown = 5,
                },
            },
            whitefrost = {
                manacost = 15,
                speedmultiplier = 0.25,
                initialspeedmultiplier = 0.4,
                coldnessperhit = 0.03,
                damageperhit = 2 / 3,
                radius = 4,
                cooldown = 10,
                duration = 10,
                slowdownduration = 3, -- Time before burst
                charged = {
                    extramanacost = 15,
                    chargetime = 2,
                    range = 10,
                    casttime = 10,
                    frosttime = 10,
                    temperaturedecrease = 50,
                    tickperiod = 2,
                    coldnessontick = 0.4,
                    speedmultiplier = 0.25,
                    basedamage = 100,
                    percentdamage = 0.2,
                    maxdamage = 2500,
                    cooldown = 15,
                },
            },
            poisonspore = {
                manacost = 10,
                sanitycost = 10,
                radius = 3.5,
                damage = 30,
                frozendamagemultiplier = 0.5,
                rot = 0.1,
                duration = 20,
                tickperiod = 1,
                cooldown = 10,
                charged = {
                    extramanacost = 20,
                    extrasanitycost = 20,
                    chargetime = 2,
                    bouncetime = 4,
                    maxbouncedist = 10,
                    minbouncedist = 3.5,
                    cooldown = 20,
                },
            },
        },
        lightningstrike = {
            manacost = 10,
            staminacost = 10,
            range = 12,
            cooldown = 5,
            damage = 20,
            damagegrowth = 1,
        },
        setsugetsuka = {
            manacost = 0,
            staminacost = 15,
            damagemultiplier = 0.5,
            damagetakenmultiplier = 0.25,
            radius = 3,
            mindist = 4,
            usewindow = 1.5,
            cooldown = 5,
        },
        phoenixadvent = {
            damagemultiplier = 2.5,
            damagetakenmultiplier = 0.25,
            radius = 4,
            staminaregen = 30,
        },
        annihilation = {
            manacost = 0,
            staminacost = 20,
            damagemultiplier = 1,
            damagetakenmultiplier = 0.25,
            radius = 4,
            maxdist = 15,
            paralysisduration = 12,
            cooldown = 8,
        },
        desolatedive = {
            staminacost = 25, -- Minimum required
            staminacostrate = 2.5,
            radius = 10,
            mindist = 10,
            damagemultiplier = 0.5,
            extradamagemultiplier = 0.05, -- by target's max health
            maxdamagemultiplier = 5,
            speedmultiplier = 0.25,
            maxchargingtime = 10,
            cooldown = 20,
            sinkhole = {
                destructionradius = 3.5,
                centerdamage = 25,
                collapsetime = 0.2,
                repairtime = { 2, 3, 7 }, -- Sum = duration
            },
        },
        magpiestep = {
            staminaregen = 5,
            maxdist = 10,
            usewindow = 0.5,
            radius = 2,
            damagemultiplier = 1,
        },
        valkyrieparry = {
            staminacostonhit = 5,
            staminaongoingcost = -2,
            damagetakenmultiplier = 0,
            cooldown = 10,
            perfecttimewindow = 6, -- Frames
            shieldduration = 4,
            staminaregen = 50,
            damagereflectionbase = 50,
            damagereflectionrate = 2,
        },
        valkyriestab = {
            damageperhit = 10 / 3, -- per frame
            maxdist = 15,
            radius = 2,
        },
        valkyriewhirl = {
            staminacost = 25,
            basedamagemultiplier = 0.5,
            extradamagemultiplier = 0.05, -- by target's max health
            maxdamagemultiplier = 2.5,
            radius = 5,
            usewindow = 1,
        },
        shadowparry = {
            sanitycost = 25,
            staminacost = 25,
            damagetakenmultiplier = 0,
            traplifetime = 15,
            perfecttimewindow = 9, -- Frames
            cooldown = 10,
            sneakinglag = 1,
            sanitypenaltydelta = 10,
            staminaregen = 25,
            shadowprisonrange = 4, -- Reference only, check shadow_pillar_musha prefab
        },
        voidphantom = {
            manacost = 5,
            sanitycost = 10,
            staminacost = 10,
            basedamage = 10,
            damagemultiplier = 0.5,
            range = 10,
            duration = 40,
            cooldown = 3,
        },
        phantomslash = {
            staminacost = 20,
            damagemultiplier = 0.5,
            usewindow = 1,
        },
        phantomblossom = {
            manacost = 5,
            sanitycost = 10,
            staminacost = 10,
            maxcount = 20,
            range = 15,
            maxchargingtime = 10,
            cooldown = 30,
        },
        phantomspells = {
            teleport = {
                sanitycost = 10,
            },
        },
    },

    creatures = {
        shadowmusha = {
            maxhealth = 400,
            healthregen = 20,
            healthregenperiod = 2,
            speed = 8,
            damage = 40,
            attackperiod = 2,
            targetrange = 18,
            followonlydamagetakenmultplier = 0.2,
            workmultiplier = 1.5,
        },
        shadowberserk = {
            maxhealth = 800,
            healthregen = 40,
            damage = 0,
            randomdamagemultiplier = 1,
            attackperiod = 0.4, -- TUNING.WILSON_ATTACK_PERIOD
        },
    },

    equipments = {
        frosthammer = {
            fuellevel = 1000,
            refueldelta = 200,
            fuelconsume_attack = -10,
            fuelconsume_cast = -50,
            fuelconsume_aura = -10,
            expdelta = 5,
            auraradius = 10,
            auraperiod = 2,
            areaattackrange = 3,
        },
    }
}
