TUNING.musha = {
    health = 200,
    hunger = 200,
    sanity = 200,

    maxmana = 200,
    manaregenspeed = 1,

    maxstamina = 100,
    staminarate = 0,

    maxfatigue = 100,
    fatiguerate = 1 / 96, -- 5/day

    fatiguelevel = {
        level0 = {
            workmultiplier = 1.5,
        },
        level1 = {
        },
        level2 = {
            workmultiplier = 0.75,
            speedmultiplier = 0.9,
        },
        level3 = {
            workmultiplier = 0.5,
            speedmultiplier = 0.75,
        },
        level4 = {
            workmultiplier = 0.1,
            speedmultiplier = 0.4,
        },
    },

    damagemultiplier = 0.8,
    damageonmaxstamina = 0.8,
    damageonminstamina = 0.5,
    areahitdamagepercent = 0.25,
    areaattackrange = 3,

    charactermode = {
        shadow = {
            bonusdamagetoshadow = 1,
        },
    },

    fullmodespeedboost = 1.15,
    fullmodehealthregen = 0.1,
    fullmodesanityregen = 0.1,
    fullmodestaminaregen = 1,
    fullmodehungerdrain = 1.3,

    valkyriebonusdamagemultiplier = 0.5,
    valkyriedamagetakenmultiplier = 0.8,
    valkyriemanaongoingmodifier = 0,

    activateberserkbasedamage = 5,

    freezecooldowntime = 5,

    singleclicktimewindow = 0.5,

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
            mana = 5,
            stamina = 25,
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

    leveltounlockskill = {
        freezingspell      = 0,
        manashield         = 0,
        manashield_area    = 1,
        manashield_passive = 0,
        valkyrie           = 0,
        berserk            = 0,
        thunderspell       = 0,
        shadowspell        = 0,
        sneak              = 0,
        sneakspeedboost    = 0,
        rollingmagma       = 0,
        whitefrost         = 0,
        poisonspore        = 0,
        shadowshield       = 0,
        instantcast        = 0,
        setsugetsuka       = 0,
        setsugetsukaredux  = 0,
        phoenixadvent      = 0,
        desolatedive       = 0,
        magpiestep         = 0,
        annihilation       = 0,
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
            regen_small = 0.5,
            regen_large = 0.75,
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
            range = 12,
            rangegrowth = 0.2,
            coldness = 1,
            coldnessgrowth = 0.1,
            cooldown = 3,
        },
        thunderspell = {
            manacost = 10,
            maxmanacost = 30,
            range = 12,
            damage = 20,
            damagegrowth = 1,
            cooldown = 10,
            duration = 8,
            durationgrowth = 0.4,
        },
        shadowspell = {
            sanitycost = -50,
        },
        manashield = {
            manacost = 10,
            manaongoingcost = -1,
            lighttime = 4,
            brokendelay = 3,
            durabilitybase = 400,
            durabilitygrowth = 40,
            durabilitydamage = 20,
            cooldown = 30,
        },
        manashield_area = {
            manacost = 30,
            maxmanacost = 50,
            duration = 15,
            cooldown = 5,
            range = 18,
        },
        valkyriemode = {
            cooldown = 20,
            manacost = 30,
        },
        sneak = {
            sanitycost = 50,
            backstabbasedamage = 100,
        },
        sneakspeedboost = {
            max = 1.5,
            staminacost = -10,
            backstabbonustime = 2,
        },
        launchelement = {
            maxdelay = 10,
            rollingmagma = {
                manacost = 5,
                damage = 45,
                radius = 4,
                forceignitecounter = 3,
                igniteframe = 10,
                cooldown = 3,
                duration = 3,
                charged = {
                    extramanacost = 25,
                    range = 10,
                    chargetime = 3,
                    mincount = 15,
                    maxcount = 20,
                    cooldown = 10,
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
                    chargetime = 3,
                    range = 10,
                    casttime = 10,
                    frosttime = 10,
                    temperaturedecrease = 50,
                    tickperiod = 2,
                    coldnessontick = 0.4,
                    speedmultiplier = 0.25,
                    basedamage = 100,
                    percentdamage = 0.2,
                    maxdamage = 2000,
                    cooldown = 15,
                },
            },
            poisonspore = {
                manacost = 10,
                sanitycost = 20,
                radius = 3.5,
                damage = 20,
                rot = 0.1,
                duration = 20,
                tickperiod = 1,
                cooldown = 10,
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
            staminacost = 10,
            damagemultiplier = 0.4,
            damagetakenmultiplier = 0.5,
            radius = 3,
            mindist = 4,
            usewindow = 1,
            cooldown = 5,
        },
        phoenixadvent = {
            damagemultiplier = 2,
            radius = 4.5,
            staminaregen = 25,
        },
        annihilation = {
            manacost = 0,
            staminacost = 15,
            damagemultiplier = 1.25,
            radius = 3.5,
            maxdist = 10,
            paralysisduration = 8,
            cooldown = 12,
        },
        desolatedive = {
            staminacost = 0,
            staminacostrate = 1,
            radius = 10,
            mindist = 10,
            damagemultiplier = 0.5,
            speedmultiplier = 0.25,
            maxchargingtime = 6,
            cooldown = 20,
            sinkhole = {
                destructionradius = 3.5,
                centerdamage = 25,
                collapsetime = 0.2,
                repairtime = { 2, 3, 7 }, -- Sum = duration
            },
        },
        magpiestep = {
            staminacost = 5,
            maxdist = 10,
            usewindow = 0.5,
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
