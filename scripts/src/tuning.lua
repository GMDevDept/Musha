TUNING.musha = {
    health = 200,
    hunger = 200,
    sanity = 200,

    maxmana = 50,
    manaregenspeed = 1,

    maxfatigue = 100,
    fatiguerate = 1 / 96, -- 5/day

    maxstamina = 100,
    staminarate = 0,

    damagemultiplier = 0.75,
    areahitdamagepercent = 0.25,
    areaattackrange = 3,

    maxpets = 50,

    fullmodespeedboost = 1.15,
    fullmodehealthregen = 0.1,
    fullmodesanityregen = 0.1,
    fullmodestaminaregen = 0.5,
    fullmodehungerdrain = 1.3,

    valkyrieattackboost = 1.2,
    valkyriedefenseboost = 0.2,

    activateberserkbasedamage = 5,

    freezecooldowntime = 2.5,

    debuffslowdownmult = 0.3,
    debuffslowdownduration = 5,

    debuffparalysisattackperiodmult = 2,
    debuffparalysisattackperiodmax = 4,
    debuffparalysisduration = 20,
    debuffparalysisperiod = 2,
    debuffparalysisdamage = 5,

    maxexperience = 300,
    maxlevel = 30,
    exprate = 1,
    exp_to_level = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210,
        220, 230, 240, 250, 260, 270, 280, 290, 300 }, -- len = 30

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
        sporebomb          = 0,
        shadowshield       = 0,
        instantcast        = 0,
    },

    skills = {
        freezingspell = {
            manacost = 5,
            maxmanacost = 15,
            range = 18,
            cooldown = 5,
        },
        thunderspell = {
            manacost = 10,
            maxmanacost = 30,
            range = 12,
            damage = 20,
            cooldown = 10,
        },
        shadowspell = {
            sanitycost = -50,
        },
        manashield = {
            manacost = 10,
            manaongoingcost = -1,
            cooldown = 30,
            staminacostonhit = -5,
            durabilitybase = 400,
            durabilitygrowth = 40,
        },
        manashield_area = {
            manacost = 30,
            maxmanacost = 50,
            duration = 15,
            cooldown = 5,
            range = 18,
        },
        sneak = {
            sanitycost = 50,
            backstabbasedamage = 100,
        },
        sneakspeedboost = {
            max = 2,
            staminacost = -10,
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
