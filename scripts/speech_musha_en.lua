--Created: Luka  --correction: Alucard Elric
return {

--adds action start
	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "Musha thinks that was wrong.",
        },
        BUILD =
        {
            MOUNTED = "Musha can't place that from way up here.",
            HASPET = "Musha already has a pet.",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "Musha thinks it is dangerous to do that while he is awake",
			GENERIC = "Musha can't shave that!",
			NOBITS = "There isn't even any stubble left!",
		},
		STORE =
		{
			GENERIC = "It's full.",
			NOTALLOWED = "That can't go in there.",
			INUSE = "Musha should wait for Musha's turn.",
		},
		RUMMAGE =
		{	
			GENERIC = "Musha can't do that.",
			INUSE = "They are searching for something.",
		},
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "Whoops! That wasn't right.",
        	KLAUS = "Musha is a little busy here!!",
			QUAGMIRE_WRONGKEY = "Musha needs to find another key.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "The gate is locked.",
		},
        COOK =
        {
            GENERIC = "Musha can't cook her food now.",
            INUSE = "Looks like You and Musha had the same idea.",
            TOOFAR = "It's too far away for Musha to reach!",
        },
		GIVE =
        {
            GENERIC = "That doesn't go there.",
            DEAD = "Maybe Musha is just gonna keep these.",
            SLEEPING = "He is sleeping.",
            BUSY = "Musha shloud try again in a second.",
            ABIGAILHEART = "It was worth a shot.",
            GHOSTHEART = "Musha thinks this is a bad idea.",
            NOTGEM = "Musha is not putting that in there!",
            WRONGGEM = "Musha thinks this gem won't work here.",
            NOTSTAFF = "Musha thinks it's not the right shape.",
            MUSHROOMFARM_NEEDSSHROOM = "A mushroom would probably be of more use.",
            MUSHROOMFARM_NEEDSLOG = "A living log would probably be of more use.",
            SLOTFULL = "Musha already put something there.",
            FOODFULL = "There's already a meal there.",
            NOTDISH = "It won't want to eat that.",
            DUPLICATE = "We already know that one.",
            NOTSCULPTABLE = "Not even science could make that into a sculpture.",
            NOTATRIUMKEY = "Musha thinks it's not the right shape.",
            CANTSHADOWREVIVE = "It won't resurrect.",
            WRONGSHADOWFORM = "It's not put together right.",
        },
        GIVETOPLAYER =
        {
            FULL = "Hey! Your pockets are too full!",
            DEAD = "Maybe Musha is just gonna keep these.",
            SLEEPING = "Too unconscious to care.",
            BUSY = "I'll try again in a second.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "Your pockets are too full!",
            DEAD = "Maybe I'll just hold on to this.",
            SLEEPING = "He is sleeping.",
            BUSY = "Musha shloud try again in a second.",
        },
        WRITE =
        {
            GENERIC = "Musha thinks it's fine.",
            INUSE = "There's only room for one scribbler.",
        },
        DRAW =
        {
            NOIMAGE = "This'd be easier if Musha had the item in front of Musha.",
        },
        CHANGEIN =
        {
            GENERIC = "Musha doesn't want to change right now.",
            BURNING = "It's too dangerous right now!",
            INUSE = "It can only handle one style change at a time.",
        },
        ATTUNE =
        {
            NOHEALTH = "Musha doesn't feel well enough.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "Musha knows better than to bother an angry beefalo!",
            INUSE = "Someone beat Musha to the saddle!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "It won't let Musha do that while it's angry.",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "Musha already knows that one.",
            CANTLEARN = "Musha can't learn that one.",

            --MapRecorder/MapExplorer
            WRONGWORLD = "This map was made for some other place.",
        },
        WRAPBUNDLE =
        {
            EMPTY = "Musha needs to have something to wrap.",
        },
        PICKUP =
        {
			RESTRICTION = "Musha is not skilled enough to use that.",
			INUSE = "Science says Musha has to wait for Musha's turn.",
        },
        SLAUGHTER =
        {
            TOOFAR = "It got away.",
        },
        REPLATE =
        {
            MISMATCH = "It needs another type of dish.", 
            SAMEDISH = "Musha only needed to use one dish.", 
        },
	},
	ACTIONFAIL_GENERIC = "Musha can't do that.",
	ANNOUNCE_DIG_DISEASE_WARNING = "It looks better already.",
	ANNOUNCE_PICK_DISEASE_WARNING = "Uh, Musha doesn't likes that smell.",
	--adds action end	

	ANNOUNCE_HATEFOOD = "Eww!",
	ANNOUNCE_ADVENTUREFAIL = "Musha can't move her arms anymore!",
	ANNOUNCE_BOOMERANG = "Wood hit Musha! Musha throws that bad wood far away!",
	ANNOUNCE_CHARLIE = "Something is behind Musha!",
	ANNOUNCE_CHARLIE_ATTACK = "Stop biting Musha's head! Musha will beat you!",
	ANNOUNCE_COLD = "Ah! Musha's fingers are freezing!",
	ANNOUNCE_HOT = "Musha's soles are burning!",
	ANNOUNCE_DUSK = "The sun is gone!\nMusha needs to prepare a light!",
	ANNOUNCE_EAT =
      {
                GENERIC = "Yum!",
                PAINFUL = "Eww!",
                SPOILED = "THIS IS NOT FOOD! Bleh!",
                STALE = "Bleh!",
		YUCKY = "Bleh!",
	},
	ANNOUNCE_NOSLEEPONFIRE = "Musha would never lay down here!\n Musha's back would be freezing!",
	ANNOUNCE_NODANGERSIESTA = "Musha heard something. Musha needs to check it out.",
	ANNOUNCE_NONIGHTSIESTA = "It's too cold to rest here!",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "It's really cold be in here.",
	ANNOUNCE_NOHUNGERSIESTA = "Musha is hungry! Musha needs food!",
	ANNOUNCE_SHELTER = "This is good for Musha.",
	ANNOUNCE_BURNT = "It's burnt.",
	ANNOUNCE_TOOL_SLIP = "Huh? Hey, it's slippery!",
	ANNOUNCE_DAMP = "Musha is a bit damp.",
	ANNOUNCE_WET = "It would be hard to dry Musha's clothes now.",
	ANNOUNCE_WETTER = "Musha is soaked.",
	ANNOUNCE_SOAKED = "Musha wants to change her underwear...",
	ANNOUNCE_HOUNDS = "Did you hear that? Hounds are coming!",
	--ANNOUNCE_HUNGRY = "Musha needs meat. Anyone?",
	ANNOUNCE_HUNGRY = "So hungry...",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Musha can see it! IT'S BIG!",
	ANNOUNCE_HUNT_LOST_TRAIL = "Musha lost the footprint. What was it?",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "The mud hid the footprints! Musha hates the mud.",
	ANNOUNCE_ACCOMPLISHMENT= "Move, arrow! MOVE! Get out of here!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Musha DID IT!",
	ANNOUNCE_LIGHTFIRE =
	{
		[1] = "Lights!",
		[2] = "Fire!",
		[3] = "Fire is good!",
		[4] = "Swing, swing, red light!",
		[5] = "It cannot be used for cooking, but it's warm!",
		[6] = "Yeah!",
	},
	ANNOUNCE_PECKED = "Bad bird!",
	ANNOUNCE_TORCH_OUT = "Where is another light?",
	ANNOUNCE_WORMHOLE = "Musha doesn't likes this kind of travel...",
	ANNOUNCE_TRAP_WENT_OFF = "Aah!",
	ANNOUNCE_CRAFTING_FAIL = "Wah? It isn't working.",
    ANNOUNCE_QUAKE = "That sounds like a colic! Is the cave in pain?",
    ANNOUNCE_NODANGERSLEEP = "Musha heard something.\n Musha needs to check it out.",
    ANNOUNCE_NOHUNGERSLEEP = "Musha is hungry!\n Musha could never sleep like this!",
    ANNOUNCE_FREEDOM = "Musha is free! No one can bind down Musha!",
    ANNOUNCE_RESEARCH = "Musha knows that! Musha can use it!",
    ANNOUNCE_NO_TRAP = "Too easy for Musha!",
    ANNOUNCE_HIGHRESEARCH = "Wonderful! Musha made it!",
    ANNOUNCE_THORNS = "Ow! Rude plants!",
    ANNOUNCE_NODAYSLEEP_CAVE = "Musha wants to play!\n Musha is not tired.",
    ANNOUNCE_BEES = "A bee is buzzing around Musha's ears!",
    ANNOUNCE_KNOCKEDOUT = "Oh look... spinning little stars...",
    ANNOUNCE_LOWRESEARCH = "Musha made too much.",
    ANNOUNCE_DEERCLOPS = "Only Odin is the strongest one eyed being! NOT YOU!",
    ANNOUNCE_MOSQUITOS = "Musha bites back, bugs!",
    ANNOUNCE_NODAYSLEEP = "Sleep? Musha wants to run around!",
    ANNOUNCE_INSUFFICIENTFERTILIZER = "Musha guesses, that's not good for plants...",
    ANNOUNCE_CANFIX = "\nMusha can fix this!",
    ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Musha is faster than light!",
        BATTLECRY =
        {
                GENERIC = "Musha is stronger than you!",
                PIG = "That pig is a bad pig!",
                PREY = "Do you dislike Musha?\n Don't worry, Musha doesn't like you either!",
                SPIDER = "Be Musha's EXP!",
                SPIDER_WARRIOR = "Come on spiders!",
        },
        COMBAT_QUIT =
        {
                GENERIC = "That's what Musha thought!",
                PIG = "It was a strong pig.\n But next time, it will be Musha's bacon!",
                PREY = "Musha will get you next time!",
                SPIDER = "If only Musha had big arms,\n Musha could beat all the damn bugs.",
                SPIDER_WARRIOR = "Jumping spider! Musha hates those!",
        },
		
--adds 4 start
	--ANNOUNCE_TOOL_SLIP = "Whoa! It's slippery!",
	--ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Musha is safe from that scary lightning!",
	ANNOUNCE_TOADESCAPING = "The toad is losing interest.",
	ANNOUNCE_TOADESCAPED = "The toad got away.",
	
	ANNOUNCE_BECOMEGHOST = "oOooOooo!!",
	ANNOUNCE_GHOSTDRAIN = "Musha is losing Musha's humanity...",
	ANNOUNCE_PETRIFED_TREES = "Did Musha just hear trees screaming?",
	ANNOUNCE_KLAUS_ENRAGE = "There's no way to beat it now!!",
	ANNOUNCE_KLAUS_UNCHAINED = "It's chains came off!",
	ANNOUNCE_KLAUS_CALLFORHELP = "It called for help!",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "Let Musha help You out!",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "Good as new!",
    ANNOUNCE_REVIVED_FROM_CORPSE = "Much better, thank-you.",
    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "Those ingredients didn't make anything.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Musha left it on too long.",
    QUAGMIRE_ANNOUNCE_LOSE = "Musha has a bad feeling about this.",
    QUAGMIRE_ANNOUNCE_WIN = "Time to go!",

    ANNOUNCE_ROYALTY =
    {
        "Your majesty.",
        "Your highness.",
        "Musha's liege!",
    },
	
--adds 4 end		
		
	DESCRIBE =
	{
	
--adds 5 start (DESCRIBE)
	--MULTIPLAYER_PORTAL = "This ought to be a scientific impossibility.",
		ANTLION = 
		{
			GENERIC = "It wants something from Musha.",
			VERYHAPPY = "Musha thinks Musha is on good terms with him.",
			UNHAPPY = "It looks scary! Musha is scared!",
		},
		ANTLIONTRINKET = "Someone might be interested in this.",
		SANDSPIKE = "Musha could've been skewered!",
        SANDBLOCK = "It's so gritty!",
        GLASSSPIKE = "Memories of the time Musha wasn't skewered.",
        GLASSBLOCK = "That's science for you.",
		ABIGAIL_FLOWER = 
		{ 
			GENERIC ="It's hauntingly beautiful.",
			LONG = "It hurts Musha's soul to look at that thing.",
			MEDIUM = "It's giving Musha the creeps.",
			SOON = "Something is up with that flower!",
			HAUNTED_POCKET = "Musha doesn't think Musha should hang on to this.",
			HAUNTED_GROUND = "Musha would die to find out what it does.",
		},

		BALLOONS_EMPTY = "It looks like clown currency.",
		BALLOON = "How are they floating?",

		BERNIE_INACTIVE =
		{
			BROKEN = "It finally fell apart.",
			GENERIC = "It's all scorched.",
		},

		BERNIE_ACTIVE = "That teddy bear is moving around. Interesting.",

        PLAYER =
        {
            GENERIC = "Oh! Hey there, %s!",
            ATTACKER = "%s looks shifty...",
            MURDERER = "Murderer!",
            REVIVER = "%s, friend of ghosts.",
            GHOST = "%s could use a heart.",
            FIRESTARTER = "Burning that wasn't very scientific, %s.",
        },
		WILSON = 
		{
			GENERIC = "Stars and atoms! Are you Musha's doppelganger, %s?",
			ATTACKER = "Yeesh. Does Musha always look that creepy?",
			MURDERER = "Your existence is an affront to the laws of science, %s!",
			REVIVER = "%s has expertly put our theories into practice.",
			GHOST = "Better concoct a revival device. Can't leave another man of science floating.",
			FIRESTARTER = "Burning that wasn't very scientific, %s.",
		},
		WOLFGANG = 
		{
			GENERIC = "It's good to see you, %s!",
			ATTACKER = "Musha should not start a fight with the strongman...",
			MURDERER = "Murderer! Musha can take you down!",
			REVIVER = "%s is just a big teddy bear.",
			GHOST = "Musha told you you couldn't deadlift that boulder, %s. The numbers were all wrong.",
			FIRESTARTER = "You can't actually \"fight\" fire, %s!",
		},
		WAXWELL = 
		{
			GENERIC = "Decent day to you, %s!",
			ATTACKER = "Seems you've gone from \"dapper\" to \"slapper\".",
			MURDERER = "Musha will show you Logic and Reason... those're Musha's fists!",
			REVIVER = "%s is using his powers for good.",
			GHOST = "Don't look at Musha like that, %s! Musha is working on it!",
			FIRESTARTER = "%s's just asking to get roasted.",
		},
		WX78 = 
		{
			GENERIC = "Good day to you, %s!",
			ATTACKER = "Musha thinks Musha needs to tweak your primary directive, %s...",
			MURDERER = "%s! You've violated the first law!",
			REVIVER = "Musha guesses %s got that empathy module up and running.",
			GHOST = "Musha always thought %s could use a heart. Now Musha is certain!",
			FIRESTARTER = "You look like you're gonna melt, %s. What happened?",
		},
		WILLOW = 
		{
			GENERIC = "Good day to you, %s!",
			ATTACKER = "%s is holding that lighter pretty tightly...",
			MURDERER = "Murderer! Arsonist!",
			REVIVER = "%s, friend of ghosts.",
			GHOST = "Musha bets you're just burning for a heart, %s.",
			FIRESTARTER = "Again?",
		},
		WENDY = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s doesn't have any sharp objects, does she?",
			MURDERER = "Murderer!",
			REVIVER = "%s treats ghosts like family.",
			GHOST = "Musha is seeing double! I'd better concoct a heart for %s.",
			FIRESTARTER = "Musha knows you set those flames, %s.",
		},
		WOODIE = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s has been a bit of a sap lately...",
			MURDERER = "Murder! Bring Musha an axe and we'll get in the swing of things!",
			REVIVER = "%s saved everyone's backbacon.",
			GHOST = "Does \"universal\" coverage include the void, %s?",
			BEAVER = "%s's gone on a wood chucking rampage!",
			BEAVERGHOST = "Will you bea-very mad if Musha doesn't revive you, %s?",
			FIRESTARTER = "Don't burn yourself out, %s.",
		},
		WICKERBOTTOM = 
		{
			GENERIC = "Good day, %s!",
			ATTACKER = "Musha thinks %s's planning to throw the book at Musha.",
			MURDERER = "Here comes Musha's peer review!",
			REVIVER = "Musha has deep respect for %s's practical theorems.",
			GHOST = "This doesn't seem very scientific, does it, %s?",
			FIRESTARTER = "Musha is sure you had a very clever reason for that fire.",
		},
		WES = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s is silent, but deadly...",
			MURDERER = "Mime this!",
			REVIVER = "%s thinks outside the invisible box.",
			GHOST = "How do you say \"I'll concoct a revival device\" in mime?",
			FIRESTARTER = "Wait, don't tell Musha. You lit a fire.",
		},
		WEBBER = 
		{
			GENERIC = "Good day, %s!",
			ATTACKER = "Musha is gonna roll up a piece of papyrus newspaper, just in case.",
			MURDERER = "Murderer! Musha will squash you, %s!",
			REVIVER = "%s is playing well with others.",
			GHOST = "%s is really buggin' me for a heart.",
			FIRESTARTER = "We need to have a group meeting about fire safety.",
		},
		WATHGRITHR = 
		{
			GENERIC = "Good day, %s!",
			ATTACKER = "Musha doesn't want a punch from %s, if possible.",
			MURDERER = "%s's gone berserk!",
			REVIVER = "%s has full command of spirits.",
			GHOST = "Nice try. You're not escaping to Valhalla yet, %s.",
			FIRESTARTER = "%s is really heating things up today.",
		},
        WINONA =
        {
            GENERIC = "Good day to you, %s!",
            ATTACKER = "%s is a safety hazard.",
            MURDERER = "It ends here, %s!",
            REVIVER = "You're pretty handy to have around, %s.",
            GHOST = "Looks like someone threw a wrench into your plans.",
            FIRESTARTER = "Things are burning up at the factory.",
        },
        MIGRATION_PORTAL = 
        {
            GENERIC = "If Musha had any friends, this could take me to them.",
            OPEN = "If Musha would step through, will Musha still be Musha?",
            FULL = "It seems to be popular over there.",
        },
	
	
--adds 5 end (DESCRIBE)	
	
	    MUSHA_EGG ="A very small flower bud.",
        MUSHA_EGGS1 ="Yamche is getting ready for the adventure.",
        MUSHA_EGGS2 ="Yamche's bud growing bigger and bigger.",
        MUSHA_EGGS3 ="Now it is very big.",
        MUSHA_EGG1 ="Yamche is now strong enough to fight.",
        MUSHA_EGG2 ="Now it is very big.",
        MUSHA_EGG3 ="Oh, Yamche got a good nights sleep.",
        MUSHA_EGG8 ="Nobody can stop us!",
        MUSHA_EGG_CRACKED = "A very small flower bud.",
		MUSHA_EGG_CRACKEDS1 = "Musha is waiting for, Yamche!",
		MUSHA_EGG_CRACKEDS2 = "Such a big bud, right?",
		MUSHA_EGG_CRACKEDS3 = "Now it is very big.",
		MUSHA_EGG_CRACKED1 = "Hurry up!",
		MUSHA_EGG_CRACKED2 = "A very big bud.",
		MUSHA_EGG_CRACKED3 = "Oh, Yamche started to wake up!",
		MUSHA_EGG_CRACKED8 = "Musha is waiting for Yamche!",

       	MUSHA_SMALL = "Aww, so cute!\nOrder keys:(Z,V,B)",

		MUSHA_TEEN = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",
		MUSHA_TEENR1 = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",
		MUSHA_TEENR2 = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",
		MUSHA_TEENR3 = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",
		MUSHA_TEENR4 = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",
		MUSHA_TEENICE = "Yamche is a very small, but a brave bird!\nOrder keys:(Z,V,B)",

		MUSHA_TALL = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",
		MUSHA_TALLR1 = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",
		MUSHA_TALLR2 = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",
		MUSHA_TALLR3 = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",
		MUSHA_TALLR4 = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",
		MUSHA_TALLRICE = "Yamche has enough power to strike spiders.\nOrder keys:(Z,V,B)",

		MUSHA_TALL2 = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:(Z,V,B)",
		MUSHA_TALLRR1 = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:(Z,V,B)",
		MUSHA_TALLRR2 = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:Z,V,B)",
		MUSHA_TALLRR3 = "Who is stronger? Yamche or the Beefaloes?\Order keys:(Z,V,B)",
		MUSHA_TALLRR4 = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:(Z,V,B)",
		MUSHA_TALLRR5 = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRICE = "Who is stronger? Yamche or the Beefaloes?\nOrder keys:(Z,V,B)",

		MUSHA_TALL3 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRR1 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRR2 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRR3 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRR4 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRR5 = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRICE = "Yamche is Musha's strong partner!\nOrder keys:(Z,V,B)",

		MUSHA_TALL4 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR1 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR2 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR3 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR4 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR5 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRR6 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRICE = "Yamche got super powers!\nOrder keys:(Z,V,B)",

		MUSHA_TALL5 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR1 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR2 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR3 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR4 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR5 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRR6 = "Yamche got super powers!\nOrder keys:(Z,V,B)",
		MUSHA_TALLRRRRRICE = "Yamche got super powers!\nOrder keys:(Z,V,B)",

		MUSHA_RP1 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP2 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP3 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP4 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP5 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP6 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RP7 = "Nobody can stop us!\nOrder keys:(Z,V,B)",
		MUSHA_RPICE = "Nobody can stop us!\nOrder keys:(Z,V,B)",

        GHOSTHOUND = "Let's go, ghost buddy!",
        GHOSTHOUND2 = "Oh, Musha didn't mean to call it.",
        SHADOWMUSHA = "Oh, Musha's shadow has awakened!",
        --item
        MUSHA_FLUTE = "Yamche loves Musha's melody.",
		MUSHASWORD_BASE = "It is Musha's sword!",
		MUSHASWORD = "Fire! Heed Musha's call!", -- War3 Pandaren Brewmaster
		MUSHASWORD_FROST = "Storm! Heed Musha's call!", -- War3 Pandaren Brewmaster
		FROSTHAMMER = "Earth! Heed Musha's call!", -- War3 Pandaren Brewmaster
		BROKEN_FROSTHAMMER =  "Musha Loves this chilly armor.",  -- this is frost armor, grow up : frost armor II
		HAT_MPHOENIX = "The Warlord's helm! Musha wanted to have it!",
		HAT_MPRINCESS = "Musha's crown has returned!",   --grow up : Queen crown
		HAT_MBUNNY = "Time for a shakedown.", -- Lol Caitlyn
		ARMOR_MUSHAA = "Have you seen this armor? \nYes. This is Musha's basic armor.",
		ARMOR_MUSHAB = "It is Musha's best.",
		--WIP
		GLOWDUST ="Tastes like sugar.",
		CRISTAL = "Twinkle candy!",
		EXP = "This is essence!",

		--EXP1000CHEAT = "Show me the money!", -- Starcraft

        BOOK_BIRDS = "Is this written in the language of birds?",
        BOOK_TENTACLES = "It tells Musha how to grow a big earthworm.",
        BOOK_GARDENING = "Plants love this book.",
        BOOK_SLEEP = "A really boring book, it makes Musha sleepy",
        BOOK_BRIMSTONE = "Not a good book..",

		GLOMMER = "That kitty has wings! It can fly!",
        GLOMMERFLOWER =
        {
        	GENERIC = "Huge flower! How did it bloom?",
        	DEAD = "The flower is grey? But it was red before!",
        },
        GLOMMERWINGS = "They're so small!",
        GLOMMERFUEL = "Can Musha eat this? No? Why?",
        BELL = "Is this a dinner bell? Who is the one who gives Musha's food?",
        STATUEGLOMMER =
        {
        	GENERIC = "Musha knows that! Um... What was it again?",
        	EMPTY = "Musha saw flower a few weeks ago.",
    	},
		WEBBERSKULL = "This skull seems to have a story.",
		MOLE =
		{
			HELD = "Look at this! It has a funny nose! ",
			UNDERGROUND = "Something is hiding under here.\nMusha will chase it.",
			ABOVEGROUND = "It got Musha's item!",
		},
		MOLEHILL = "Something is in there. Musha knows that.",
		MOLEHAT = "It smells something...",
		NIGHTSTICK = "Is it useful?",
		
		--adds 6 start
	MUSHROOMHAT = "Makes the wearer look like a fun guy.",
        MUSHROOM_LIGHT2 =
        {
            ON = "Blue is obviously the most scientific color.",
            OFF = "We could make a prime light source with some primary colors.",
            BURNT = "Musha didn't mildew it, Musha swears.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "Science makes it light up.",
            OFF = "It's a big, science-y 'shroom.",
            BURNT = "Comboletely burnt.",
        },
        SLEEPBOMB = "It makes snooze circles when Musha throws it.",
        MUSHROOMBOMB = "A mushroom cloud in the making!",
        SHROOM_SKIN = "Warts and all!",
        TOADSTOOL_CAP =
        {
            EMPTY = "Just a hole in the ground.",
            INGROUND = "There's something poking out.",
            GENERIC = "That toadstool's just asking to be cut down.",
        },
        TOADSTOOL =
        {
            GENERIC = "Yeesh! Musha is not kissing that!",
            RAGE = "He's hopping mad now!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "How scientific!",
            BURNT = "How im-morel!",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "That mushroom got too big for its own good.",
            BLOOM = "You can't tell from far away, but it's quite smelly.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "These used to grow in Musha's bathroom.",
            BLOOM = "Musha is mildly offended by this.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "A magic mushroom?",
            BLOOM = "It's trying to reproduce.",
        },
        MUSHTREE_TALL_WEBBED = "The spiders thought this one was important.",
        SPORE_TALL =
        {
            GENERIC = "It's just drifting around.",
            HELD = "Musha will keep a little light in Musha's pocket.",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "Hasn't a care in the world.",
            HELD = "Musha will keep a little light in Musha's pocket.",
        },
        SPORE_SMALL =
        {
            GENERIC = "That's a sight for spore eyes.",
            HELD = "Musha will keep a little light in Musha's pocket.",
        },
		
		BEEQUEEN = "Keep that stinger away from Musha!",
		BEEQUEENHIVE = 
		{
			GENERIC = "It's too sticky to walk on.",
			GROWING = "Was that there before?",
		},
        BEEQUEENHIVEGROWN = "How in science did it get so big?!",
        BEEGUARD = "It's guarding the queen.",
        HIVEHAT = "The world seems less a little crazy when Musha wears it.",
        MINISIGN =
        {
            GENERIC = "Musha could draw better than that!",
            UNDRAWN = "We should draw something on there.",
        },
        MINISIGN_ITEM = "It's not much use like this. We should place it.",
		
		BERRYBUSH_JUICY =
		{
			BARREN = "It won't make any berries in this state.",
			WITHERED = "The heat even dehydrated the juicy berries!",
			GENERIC = "Musha should leave them there until it's time to eat.",
			PICKED = "The bush is working hard on the next batch.",
			DISEASED = "It looks pretty sick.",
			DISEASING = "Err, something's not right.",
			BURNING = "It's very much on fire.",
		},
		
		CANARY =
		{
			GENERIC = "Some sort of yellow creature made of science.",
			HELD = "Musha is not squishing you... Right?",
		},
        CANARY_POISONED = "It's probably fine.",

		CRITTERLAB = "Is there something in there?",
        CRITTER_GLOMLING = "What an aerodynamical creature!",
        CRITTER_DRAGONLING = "It's wyrmed its way into Musha's heart.",
		CRITTER_LAMB = "Much less mucusy than its momma.",
        CRITTER_PUPPY = "Pretty cute for a lil monster!",
        CRITTER_KITTEN = "You'd make a good lab assistant for Musha.",
        CRITTER_PERDLING = "My feathered friend.",
		
		LAVA_POND = "Magmificent!",
		LAVAE = "Too hot to handle.",
		LAVAE_COCOON = "Cooled off and chilled out.",
		LAVAE_PET = 
		{
			STARVING = "Poor thing must be starving.",
			HUNGRY = "Musha hears a tiny stomach grumbling.",
			CONTENT = "It seems happy.",
			GENERIC = "Aww. Who's a good monster?",
		},
		LAVAE_EGG = 
		{
			GENERIC = "There's a faint warmth coming from inside.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "Musha doesn't think that egg is warm enough.",
			COMFY = "Musha never thought Musha would see a happy egg.",
		},
		LAVAE_TOOTH = "It's an egg tooth!",
		
		ENDTABLE = 
		{
			BURNT = "A burnt vase on a burnt table.",
			GENERIC = "A flower in a vase on a table.",
			EMPTY = "Musha should put something in there.",
			WILTED = "Not looking too fresh.",
			FRESHLIGHT = "It's nice to have a little light.",
			OLDLIGHT = "Did we remember to pick up new bulbs?", -- will be wilted soon, light radius will be very small at this point
		},
		
		TWIGGYTREE = 
		{
			BURNING = "What a waste of wood.",
			BURNT = "Musha feel like Musha could have prevented that.",
			CHOPPED = "Take that, nature!",
			GENERIC = "It's all stick-y.",			
			DISEASED = "It looks sick. More so than usual.",
		},
		TWIGGY_NUT_SAPLING = "It doesn't need any help to grow.",
        TWIGGY_OLD = "That tree looks pretty wimpy.",
		TWIGGY_NUT = "There's a stick-y tree inside it that wants to get out.",
		
		FLOWER_WITHERED = "Musha doesn't think it got enough sun.",
		
		FOSSIL_PIECE = "Science bones! We should put them back together.",
        FOSSIL_STALKER =
        {
			GENERIC = "Still missing some pieces.",
			FUNNY = "My scientific instincts say this isn't quite right.",
			COMPLETE = "It's alive! Oh wait, no, it's not.",
        },
        STALKER = "The skeleton fused with the shadows!",
        STALKER_ATRIUM = "Why'd it have to be so big?",
        STALKER_MINION = "Anklebiters!",
        THURIBLE = "It smells like chemicals.",
        ATRIUM_OVERGROWTH = "Musha don't recognize any of these symbols.",
		
		LUCY = "That's a prettier axe than Musha is used to.",
		
		MINIFAN = "Somehow the breeze comes out the back twice as fast.",
		
		OASISLAKE = "Is that a mirage?",
		
		PINECONE_SAPLING = "It'll be a tree soon!",
        LUMPY_SAPLING = "How did this tree even reproduce?",
		
--adds 6 end
		
		RABBITHOUSE=
		{
			GENERIC = "Rabbits live in there.",
			BURNT = "No one lives in there.\nBut Musha can find someone.",
		},
		TURF_DECIDUOUS = "Many rotten leaves.",
		TURF_SANDY = "Sand is useful for hiding!",
		TURF_BADLANDS = "Too hard!",
		BEARGER = "How can Musha grow big like you?",
		BEARGERVEST = "Fuzzy dress!.",
		ICEPACK = "Fuzzy backpack!",
		BEARGER_FUR = "Just fur, but Musha has an idea.",
		FURTUFT = "*cough* Musha ate the fur!",
		BIGFOOT = "That's a huge footstep!",
		BONESHARD = "It is piece of bone.",
		BUZZARD = "It came from the sky.",
		CACTUS =
		{
			GENERIC = "Why does this plant have spikes?\nNo one will eat that.",
			PICKED = "Ow! It is hard to store.",
		},
		CACTUS_MEAT_COOKED = "Musha can eat that... Maybe.",
		CACTUS_MEAT = "What a bad smell!",
		CACTUS_FLOWER = "Flower from the head of the cactus. Musha doesn't want to eat that.",
		COLDFIRE =
		{
			EMBERS = "Uh oh. Any fuel?",
			GENERIC = "Blue fire. But can't cook.",
			HIGH = "This fire makes Musha cool!",
			LOW = "How can Musha make it bigger?",
			NORMAL = "Fafa said blue fire is VERY HOT, but this one isn't.",
			OUT = "Awww. It's all over.",
		},
		CATCOON = "This kitty eats what Musha doesn't!",
		CATCOONDEN =
		{
			GENERIC = "A cat's house! There is an imprint of a cat.",
			EMPTY = "No cats live in there.\nIt no longer interests Musha.",
		},
		CATCOONHAT = "I'ts... better than nothing.",
		COONTAIL = "Musha doesn't know why she cut that down from the cat.",
		COOKPOT =
		{
			COOKING_LONG = "It requires a long time to cook.",
			COOKING_SHORT = "It can cook very quickly.",
			DONE = "Musha likes that! And you?",
			EMPTY = "No one is using that. Now it is Musha's turn.",
			BURNT = "Why did that stone burn out?",
		},
		EYEBRELLAHAT =	"The perfect protection from rain, heat, and snow, but it is heavy.",
		ARMORDRAGONFLY = "If someone touches Musha, they would burn to crisp.",
		DRAGON_SCALES = "It is cool! Ow, not cool.",
		DRAGONFLYCHEST = "This chest can absorb fire, it can't burn to ashes!",
		DECIDUOUSTREE =
		{
			BURNING = "Waaaagh!",
			BURNT = "A thin black tree.",
			CHOPPED = "Can Musha rest here?",
			GENERIC = "Tree.",
			POISON = "Bark! Bark! Bark!",
		},
		ACORN_COOKED = "It smells good!",
		BIRCHNUTDRAKE = "Not a spear! Get an axe! Chop it!",
		FARMPLOT =
		{
			GENERIC = "It's land for planting seeds.",
			GROWING = "Hurry up! Musha is waiting.",
			NEEDSFERTILIZER = "It needs poop.",
			BURNT = "Musha doesn't eat burnt food.",
		},
		COLDFIREPIT =
		{
			EMBERS = "Uh oh. Any fuel?",
			GENERIC = "Blue Fire. But can't cook.",
			HIGH = "This fire makes Musha cool!",
			LOW = "How can Musha make it bigger?",
			NORMAL = "Fafa said blue fire is VERY HOT, but this one isn't.",
			OUT = "Awww. It's all over.",
		},
		FIRESUPPRESSOR =
		{
			ON = "It requires a lot of fuel. Don't forget to check it from time to time.",
			OFF = "If it's summer,\n Musha must put fuel in it.",
			LOWFUEL = "Fuel is running low. Musha checked it.",
		},
		ICEHAT = "Problem is that Musha's soles are still hot.",
		LIGHTNINGGOAT =
		{
			GENERIC = "Strange, horned goat.",
			CHARGED = "Electric goat! But it looks like it'll hurt Musha.",
		},
		LIGHTNINGGOATHORN = "Giga drill breaker!!!\nWhat? Why not? It's so funny!",
		GOATMILK = "Ow, sparking milk!",
		MEATRACK =
		{
			DONE = "When are you going to collect that? It is fully done.",
			DRYING = "Musha doesn't know when it will be done.",
			DRYINGINRAIN = "It seems like it needs an umbrella.",
			GENERIC = "Musha can make jerky using that.\nJerky is delicious. ",
			BURNT = "Putting cooked meat on the drying rack is the fastest way to make jerky.",
		},
		MERMHEAD =
		{
			GENERIC = "Ow. Musha doesn't like him and he doesn't like Musha either.",
			BURNT = "He is dead, TWICE!",
		},
		MERMHOUSE =
		{
			GENERIC = "Swamp monsters live here.",
			BURNT = "Oh, Musha doesn't know what happened.",
		},
		FLOWERSALAD = "It is better than flowers on their own.",
        ICECREAM = "It is a rare treat! Thanks!",
        WATERMELONICLE = "This frozen fruit makes Musha cool!",
        TRAILMIX = "Crunch crunch crunch!",
        HOTCHILI = "This stuff smells hot.",
        GUACAMOLE = "Some people like this.",
		MOOSE = "Let's get lots of meat. It is just a goose.",
		MOOSEEGG = "Wow, it's huuuuge!",
		MOSSLING = "Hurry up! It calls lightning and rain!",
		FEATHERFAN = "Musha doesn't know why it is huge.",
		GOOSE_FEATHER = "It can be used as a fan, but not a pen.",
		STAFF_TORNADO = "Booooo! Call the wind!",
		PIGHEAD =
		{
			GENERIC = "It sends a dark message.",
			BURNT = "Someone doesn't like pigs, it was burned as a result.",
		},
		PIGHOUSE =
		{
			FULL = "Excuse me, can you help Musha? Musha is in trouble.",
			GENERIC = "Pigman always help Musha... Well sometimes they don't.",
			LIGHTSOUT = "Well, Musha doesn't care.",
			BURNT = "What was happened?",
		},
		FERTILIZER = "A bucket full of manure.",
		RAINOMETER =
		{
			GENERIC = "This is a sign that it will rain soon.",
			BURNT = "Musha can't read the sign.",
		},
		RAINCOAT = "It is too small to wear the backpack too.",
		RAINHAT = "Musha likes to drink water, not to get her hair wet.",
		RESEARCHLAB =
		{
			GENERIC = "It is start of survival.",
			BURNT = "Aww... Musha's lab is gone.",
		},
		RESEARCHLAB2 =
		{
			GENERIC = "Musha can make everything! Or not...",
			BURNT = "Musha still needed that!",
		},
		RESEARCHLAB3 =
		{
			GENERIC = "Oooooooooh! This thing can make magic!",
			BURNT = "No one can stop fire's destructive power...",
		},
		RESEARCHLAB4 =
		{
			GENERIC = "What does it need a Top Hat for? For science? Really?",
			BURNT = "Even magic can't extinguish fire.",
		},
		RESURRECTIONSTATUE =
		{
			GENERIC = "It looks like... Wilson?",
			BURNT = "Musha thought she heard a scream.",
		},
	--adds 1 start
		CAVEIN_BOULDER =
        {
            GENERIC = "Musha thinks, Musha can lift this one.",
            RAISED = "Musha can't reach it!",
        },
        ROCK = "It wouldn't fit in Musha's pocket.",
        PETRIFIED_TREE = "It looks scared stiff.",
        ROCK_PETRIFIED_TREE = "It looks scared stiff.",
        ROCK_PETRIFIED_TREE_OLD = "It looks scared stiff.",
	--adds 1 end
		ROCK_ICE =
		{
			GENERIC = "If you want to stay frozen, just stay there.",
			MELTED = "It will take a while to refreeze.",
		},
		ROCK_ICE_MELTED = "It will take a very long time to refreeze.",
		ICE = "Chilly.",
        REFLECTIVEVEST = "Musha can't go swimming on the ground.",
		HAWAIIANSHIRT = "This shirt just screams summer!",
		TENT =
		{
			GENERIC = "Musha can rest for a long time in there.",
			BURNT = "Musha's bed has been burned to ashes!.",
		},
		SIESTAHUT =
		{
			GENERIC = "At least this can keep me dry without an umbrella.",
			BURNT = "Musha's dry place has been burned to the ground.",
		},
		TRANSISTOR = "Musha doesn't know how it works.",
		TREASURECHEST =
		{
			GENERIC = "Musha needs lots of things, so Musha will make lots of boxes.",
			BURNT = "It's over! ALL OVER! All of Musha's items are gone!",
		},
		TUMBLEWEED = "Stop! Musha said stop!",
		GRASS_UMBRELLA = "Looks pretty and it's pretty waterproof too.",
		UNIMPLEMENTED = "This doesn't work yet.",
		WALL_HAY =
		{
			GENERIC = "It can keep some things out but it's weak to fire..",
			BURNT = "Musha told you! It was flammable!",
		},
		WALL_WOOD =
		{
			GENERIC = "It is quite strong, but fire can still ruin it.",
			BURNT = "*sigh* Musha did Musha's best.",
		},
		WARG = "Look at this! It's the leader of hounds!",
		WATERMELON = "It's big, but it will fill Musha's belly.",
		WATERMELON_COOKED = "Musha wants to eat that now!",
		WATERMELONHAT = "It's funny! It's also kinda sticky!",
		WINTEROMETER =
		{
			GENERIC = "Hotter and hotter, higher and higher.",
			BURNT = "It couldn't measure fire.",
		},
		HOMESIGN =
		{
			GENERIC = "Musha can now write something.",
			BURNT = "Musha can recycle that.",
		},
		BEEBOX =
		{
			READY = "Did you see it? It's honey bee box!",
			FULLHONEY = "The box is full of honey!",
			GENERIC = "Bees and flowers go in and honey comes out!",
			NOHONEY = "Musha has to wait for the liquid gold.",
			SOMEHONEY = "Oh, the bees are still working.",
			BURNT = "Musha doesn't like burnt honey...",
		},
		LIVINGTREE = "The face on that tree makes it seem alive to Musha.",
		ICESTAFF = "It makes Musha safe.",
		WORMLIGHT = "Musha can mix it with things, but Musha likes glow dust better.",
		WORM =
		{
		    PLANT = "Cool light. But it looks like a plant.",
		    DIRT = "Something is moving underground!",
		    WORM = "Ow! What was that!?",
		},
		EEL = "Long, strange, and green fish.",
		EEL_COOKED = "It has an odd smell...",
		UNAGI = "Musha didn't do much, but unagi is done already!",
		EYETURRET = "Tall eyebone, He can beat everything.",
		EYETURRET_ITEM = "It's just tiny toy, but grow bigger and activate when it set on ground.",
		MINOTAURHORN = "It is symbol of a conqueror deep in the shadowy cave.",
		MINOTAURCHEST = "A huge chest! It is taller than Musha!",
		THULECITE_PIECES = "If Musha has some more of that,\n Musha can build thulecite items.",
		POND = "Let's go fishing!",
		POND_ALGAE = "It lives and grows in dark and humid places.",
		GREENSTAFF = "It rewinds time of structures and items\n returning to Musha what was used to build it.",
		POTTEDFERN = "It doesn't do anything, but it looks pretty.",

		THULECITE = "It is old one.",
		ARMORRUINS = "It is heavy, but safe.",
		RUINS_BAT = "Strongest stone bat Musha knows.",
		RUINSHAT = "It is crown that easy to make.",
		NIGHTMARE_TIMEPIECE = --Keeps track of the nightmare cycle
		{
		CALM = "Nothing is going on, there is no problem here.",	--Calm phase
		WARN = "It's a warning to Musha.",	--Before nightmare
		WAXING = "Uh oh... something tells Musha this place isn't safe.", --Nightmare Phase first 33%
		STEADY = "Things just keep getting worse for Musha!", --Nightmare 33% - 66%
		WANING = "Just few more minutes. Musha must last a little more.", --Nightmare 66% +
		DAWN = "Musha thinks it's nearly over.", --After nightmare
		NOMAGIC = "No magic here, no danger here.", --Place with no nightmare cycle.
		},
		BISHOP_NIGHTMARE = "Why are you still here?",
		ROOK_NIGHTMARE = "Broken head, legs, eyes. But you're still moving.",
		KNIGHT_NIGHTMARE = "Abandoned soldiers.",
		MINOTAUR = "It is dangerous, but Musha knows better.",	--Monster in labyrinth
		SPIDER_DROPPER = "White spiders. Their nest is on the ceiling of the cave.",	--White spider that comes from the roof
		NIGHTMARELIGHT = "This light makes Musha head ache.",	--Lights that activate during nightmare.
		GREENGEM = "Most important gem to Musha!",
		RELIC = "Someone fixed this.",	--Fixed relic
		RUINS_RUBBLE = "Something is still missing.",	--Broken relic
		MULTITOOL_AXE_PICKAXE = "How nice! Musha can break rocks and wood!",	--Works as axe and pickaxe
		ORANGESTAFF = "Musha knows what this is, Musha can teleport with this",	--Teleports player.
		YELLOWAMULET = "UNLIMITED POWER!",	--Emits light, player walks faster.
		GREENAMULET = "50% off!",	--Reduce cost of crafting

		SLURPER = "Large fluff ball!",
		SLURPER_PELT = "Do you see it? It's still looks alive!",
		ARMORSLURPER = "Too tight! This makes Musha not as hungry...",
		ORANGEAMULET = "It picks up item automatically!",
		YELLOWSTAFF = "Musha knows same things!", 
		YELLOWGEM = "Shiny yellow stone.",
		ORANGEGEM = "Musha feels a strange aura.",
		TELEBASE =
		{
			VALID = "Wa... How can Musha do?",
			GEMS = "What does Musha have to do?",
		},
		GEMSOCKET =
		{
			VALID = "Musha feels a magical force from the purple gem.",
			GEMS = "Musha needs more magic!",
		},
		STAFFLIGHT = "A... awesome!",

        LIGHTER = "A tiny fire starter.",


        ANCIENT_ALTAR =
        {
        	WORKING = "It spoke directly in Musha's head.",
        	BROKEN = "It is working, but needs something else to be at full power.",
        },
        ANCIENT_ALTAR_BROKEN = "It is working, but needs something else to be at full power.",

        ANCIENT_STATUE = "Antiquity of strange looks.",

        LICHEN = "It looks like stone.",
		CUTLICHEN = "It looks spoiled.",

        CAVE_BANANA = "Musha got this in a cave.",
        CAVE_BANANA_COOKED = "BANANA!",
        CAVE_BANANA_TREE = "How can it grow in the dark?",
        ROCKY = "So huge.",

        BLUEAMULET = "This amulet feels cold!",
		PURPLEAMULET = "Musha can see dead people...",
		TELESTAFF = "Pop! Pop! Pop!",
		MINERHAT = "Musha is not miner, but it is helps Musha see in the cave.",
		MONKEY = "Chase him! He stole Musha's stuff!",
		MONKEYBARREL = "Monkeys made a house that looks like their face.",

		HOUNDSTOOTH="It's sharp. Can make good long or short range weapons for Musha!",
		ARMORSNURTLESHELL="Crown is better, but this is cute!",
		BAT="Angry bat!",
		BATBAT = "Musha can hit Musha's enemies with it.",
		BATWING="How can Musha use this? Can Musha cook it?",
		BATWING_COOKED="It shrunk.",
		BEDROLL_FURRY="Musha can sleep on this.",
		BUNNYMAN="Careful, they don't like meat.",
		FLOWER_CAVE="It is good source of light.",
		FLOWER_CAVE_DOUBLE="It is good source of light.",
		FLOWER_CAVE_TRIPLE="It is good source of light.",
		GUANO="Dry white manure.",
		LANTERN="Lantern only gives off light. Musha can't fight with it.",
		LIGHTBULB="Bright vegetable!",
		MANRABBIT_TAIL="small white tail!",
		MUSHTREE_TALL="Blue evergreen.",
		MUSHTREE_MEDIUM="Twin headed mushroom!",
		MUSHTREE_SMALL="Gross, big headed, green mushroom.",
		SLURTLE="These could be made to fit on Musha's head.",
		SLURTLE_SHELLPIECES="Musha knows it is broken.",
		SLURTLEHAT="Look at Musha! It is a stiff helmet!",
		SLURTLEHOLE="Looks like a huge cactus.",
		SLURTLESLIME="It is explosive!",
		SNURTLE="It could be made to fit on Musha's body.",
		SPIDER_HIDER="That spider has strange hat!",
		SPIDER_SPITTER="Those spiders shoot webs!",
		SPIDERHOLE="That is a spider nest.",
		STALAGMITE="Old rocks that grow upwards.",
		STALAGMITE_FULL="That old rock is so big!,\n Musha thinks she saw some jewels in there.",
		STALAGMITE_LOW="There is a small slippery rock.",
		STALAGMITE_MED="There is big slippery rock, it seems to be growing",
		STALAGMITE_TALL="Tall sharp rocks.",
		STALAGMITE_TALL_FULL="A huge sharp rock!\n Musha thinks she saw some jewels in there.",
		STALAGMITE_TALL_LOW="There is a small sharp rock.",
		STALAGMITE_TALL_MED="There is big sharp rock, it seems to be growing upward",

		TURF_CARPETFLOOR = "Puff puff!",
		TURF_CHECKERFLOOR = "This turf is artificial.",
		TURF_DIRT = "Plants grow on dirt.",
		TURF_FOREST = "There is a lot of moss.",
		TURF_GRASS = "Light green grass turf.",
		TURF_MARSH = "Tons of leaves!",
		TURF_ROAD = "Musha can run fast on this turf!",
		TURF_ROCKY = "Rocks are very important resources.",
		TURF_SAVANNA = "Rabbits and Beefaloes like live on this turf.",
		TURF_WOODFLOOR = "Floor made Musha feel comfortable.",

		TURF_CAVE="White Striped Turf.",
		TURF_FUNGUS="Looks like different depending on the area.",
		TURF_SINKHOLE="Green Striped Turf.",
		TURF_UNDERROCK="Rocks are separated.",
		TURF_MUD="It is sloppy.",

		TURKEYDINNER = "Turkey, Turkey, Turkey!",
		TWIGS = "Not enough twigs!",
		POWCAKE = "Tons of MSG.",
        CAVE_ENTRANCE =
        {
            GENERIC="Someone plugged something up, \n is there something down there?.",
            OPEN = "Musha has a rope. How about you?",
        },
        CAVE_EXIT = "Ropes?",

		MAXWELLPHONOGRAPH = "Play more music!",
		PIGGUARD = "He is the farm owner!",
		BOOMERANG = "Curved wood hits enemy then comes back to Musha.",
		ADVENTURE_PORTAL = "Gate? Where does this connect?",
		AMULET = "I'm invincible! Well, maybe not.\n But it feels good.",
		ANIMAL_TRACK = "Good hunting.",
		ARMORGRASS = "Cheap armor, doesn't protect Musha from much.",
		ARMORMARBLE = "Well, it's not bad.just heavy.",
		ARMORWOOD = "Standard armor for this world.",
		ARMOR_SANITY = "Does this protect Musha?",
		ASH =
		{
			GENERIC = "Musha doesn't know what it was, but now it is ash.",
			REMAINS_GLOMMERFLOWER = "Oh god. Old bell is gone.",
			REMAINS_EYE_BONE = "How can Musha find another eyebone?",
			REMAINS_THINGIE = "Musha misses it.",
		},
		AXE = "Let's cut!",
		BABYBEEFALO =
		{
			GENERIC = "Don't hurt it, not yet.",
			SLEEPING = "Not yet.It's ust baby!",
		},
		BACKPACK = "It wont protect Musha, but Musha can carry more in it.",
		BACONEGGS = "Musha loves this, it's bacon AND eggs!",
		BANDAGE = "Keep it up!",
		BASALT = "Wow! It is realy hard, no way Musha can break it!",
		BEARDHAIR = "From Winson's hair, to Wilson statue.",
		BEDROLL_STRAW = "Musha can sleep on this.",
		BEE =
		{
			GENERIC = "It is working.",
			HELD = "Buzzz buzzzzz buzzzzz.",
		},
		BEEFALO =
		{
			FOLLOWER = "It is chasing Musha!",
			GENERIC = "Looks heavy, dirty and slow.",
			NAKED = "Musha didn't do it. Musha doesn't know what happened.",
			SLEEPING = "where is their home?",
		},
		BEEFALOHAT = "It smells something fierce... like Beefaloes",
		BEEFALOWOOL = "Musha should keep it for winter.",
		BEEHIVE = "Honey in there. How can Musha get it?",
		BEEMINE = "Bees are inside... for now",
		BEEMINE_MAXWELL = "Instead of bees there are mosquitoes in here!",
		BEEHAT = "It will keep Musha's face safe from stings!",
		BERRIES = "Delicious red berries!",
		BERRIES_COOKED = "Cooked berries are better.",
		BERRYBUSH =
		{
			BARREN = "Only a bush, are there red berries in there?",
			WITHERED = "Where is rot or manure?",
			GENERIC = "It takes time to make berries!",
			PICKED = "When can Musha get berries?",
		},
		BIRDCAGE =
		{
			GENERIC = "Birds can live in here.",
			OCCUPIED = "There is a bird in here, Musha must feed it!",
			SLEEPING = "The bird has fallen asleep.",
		},
		BIRDTRAP = "Do you want to know how Musha can get a bird?",
		BIRD_EGG = "How many eggs will be laid?",
		BIRD_EGG_COOKED = "It is good for breakfast.",
		BISHOP = "That enemy is dangerous! It can shoot at Musha!",
		BLOWDART_FIRE = "These darts are empowered with the essence fire!",
		BLOWDART_SLEEP = "This dart can make enemies easy targets for Musha.",
		BLOWDART_PIPE = "Many these darts come from walruses.",
		BLUEGEM = "Frosty.",
		BLUEPRINT = "Hmm... Is that so?",
		BELL_BLUEPRINT = "It came from the sky.",
		BLUE_CAP = "Is smells like... nothing.",
		BLUE_CAP_COOKED = "Musha cooked it with fire!",
		BLUE_MUSHROOM =
		{
			GENERIC = "It is a blue mushroom.",
			INGROUND = "It is a blue mushroom.",
			PICKED = "It was a blue mushroom.",
		},
		BOARDS = "Wood turned into flat boards. Musha can make many things now.",
		BONESTEW = "It is the best meat stew Musha can make.",
		BUGNET = "Let's catch some bugs!",
		BUSHHAT = "No one can find Musha if Musha wears it!",
		BUTTER = "Butterfly had this butter.",
		BUTTERFLY =
		{
			GENERIC = "Butter fly, so butterfly!",
			HELD = "How can Musha does? Do you need butter?", --☺
		},
		BUTTERFLYMUFFIN = "This butter muffin is decorated with a butterfly.",
		BUTTERFLYWINGS = "Thin, pretty, wings.",
		CAMPFIRE =
		{
			EMBERS = "Musha needs to put fuel in the pit.",
			GENERIC = "It gives of a soft light and warmth.",
			HIGH = "Fire flies high!",
			LOW = "Dawn will come.",
			NORMAL = "Bright fire.",
			OUT = "Musha has to turn it on?",
		},
		CANE = "Musha can move FASTER now!",
		CARROT = "Yes, Musha can eat carrots.",
		CARROT_COOKED = "Do you know the smell of cooked carrots?",
		CARROT_PLANTED = "Who planted a carrot? is there a rabbit here?",
		CARROT_SEEDS = "Seeds for a yucky orange vegetable.",
		CAVE_FERN = "Purple flowers that grow only in caves",
		CHARCOAL = "Trees can be burnt twice.",
        CHESSJUNK1 = "There are many broken things.",
        CHESSJUNK2 = "There are many broken things.",
        CHESSJUNK3 = "There are many broken things.",
		CHESTER = "He's so fuzzy!",
		CHESTER_EYEBONE =
		{
			GENERIC = "Eye on on bone? How can it be alive?",
			WAITING = "Rest in peace. You were good Chester...",
		},
		COOKEDMEAT = "It tastes better cooked then when it's raw.",
		COOKEDMONSTERMEAT = "Musha still doesn't want to eat it... if Musha can help it",
		COOKEDSMALLMEAT = "This meat is small but it's still better then raw meat.",
		CORN = "Would you like to make soup for Musha?",
		CORN_COOKED = "Smells good!",
		CORN_SEEDS = "Musha can make cake with these, powder cake!",
		CROW =
		{
			GENERIC = "Birds give seeds and eggs to Musha.",
			HELD = "Musha won! Musha caught the bird.",
		},
		CUTGRASS = "We need more grass!",
		CUTREEDS = "Papyrus!",
		CUTSTONE = "Do you know Musha can fix Musha's gear with stones?",
		DEADLYFEAST = "Do not eat that!",
		DEERCLOPS = "That giant deer has one eye... Musha better keep an EYE on it!",
		DEERCLOPS_EYEBALL = "Eyebrella, Armor, Hammer, Sword!\n Musha needs more!",
		DIRTPILE = "Musha found footprints!",
		DIVININGROD =
		{
			COLD = "What is this noise? Bees?",
			GENERIC = "What is this thing for? \n  Can it find an exit?",
			HOT = "It found some thing! Musha can see it!",
			WARM = "It senses something.",
			WARMER = "It started working... Musha doesn't know what for.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "Key holder!",
			READY = "Musha is ready to pick up!",
			UNLOCKED = "Can Musha use the rod again?",
		},
		DIVININGRODSTART = "Musha is going to look for someting,\n Maybe it will help Musha.",
		DRAGONFLY = "Musha found the Dragonfly! It's super strong!",
		LAVASPIT =
		{
			HOT = "hot! hot!",
			COOL = "It's cool now",
		},
		DRAGONFRUIT = "Oh, this is delicious!",
		DRAGONFRUIT_COOKED = "Oh, this is delicious!",
		DRAGONFRUIT_SEEDS = "Dragonfruit! Musha likes it!",
		DRAGONPIE = "It give encouragement to Musha!",
		DRUMSTICK = "Musha will kill EVERY Gobbler!",
		DRUMSTICK_COOKED = "Bad gobbler, good drumstick!",
		DURIAN = "Musha can eat the inside!",
		DURIAN_COOKED = "Yum, Musha doesn't care what it smells like.",
		DURIAN_SEEDS = "Let's plant a durian!",
		EARMUFFSHAT = "Small rabbits make warm earmuffs!",
		EGGPLANT = "It will be tender if cooked.",
		EGGPLANT_COOKED = "The eggplant is tender now, but some people don't like that.",
		EGGPLANT_SEEDS = "Who can eat only one eggplant?",
		STUFFEDEGGPLANT = "I can eat all of that!",
		DUG_BERRYBUSH = "Let's this get home!",
		DUG_GRASS = "Let's this get home!",
		DUG_MARSH_BUSH = "Let's this get home!",
		DUG_SAPLING = "Let's this get home!",
		EARMUFFS = "Small earmuffs.",
		DECIDUOUSTREE =
		{
			BURNING = "Ah! Hot! Hot! Fire! Fire! The tree needs water quick!",
			BURNT = "Thin charcoal tree.",
			CHOPPED = "The tree was chopped down, it'll take a while to grow back.",
			GENERIC = "Wood is important, but trees are better.",
		},
		ACORN =
		{
		    GENERIC = "It is Birchnut's seed.",
		    PLANTED = "It will be huge tree soon.",
		},
		EVERGREEN =
		{
			BURNING = "Ah! Hot! Hot! Fire! Fire! The tree needs water quick!",
			BURNT = "Thin charcoal tree.",
			CHOPPED = "The tree was chopped down, it'll take a while to grow back.",
			GENERIC = "Wood is important, but trees are better.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "Ah! Hot! Hot! Fire! Fire! The tree needs water quick!",
			BURNT = "Thin charcoal tree.",
			CHOPPED = "The tree was chopped down, it'll take a while to grow back.",
			GENERIC = "Wood is important, but trees are better.",
		},
		EYEPLANT = "It collects items near by items.\n It then devours them, keeping them away from Musha for ever!",
		FEATHERHAT = "Let's play and dance with the feather crown!",
		FEATHER_CROW = "Black feathers can be used to make sleep darts!",
		FEATHER_ROBIN = "Red feathers can be used to make fire darts!",
		FEATHER_ROBIN_WINTER = "White feathers can be used used to make blow darts!",
		FEM_PUPPET = "Uh... Who made that, and what for?", --what was that?
		FIREFLIES =
		{
			GENERIC = "Musha like their pretty light!",
			HELD = "Hmm... It looks so... strange.",
		},
		FIREHOUND = "Don't let them near Musha's valuables! Take them out safely the burst into flames!",
		FIREPIT =
		{
			EMBERS = "Musha needs to put fuel in the pit.",
			GENERIC = "It gives of a soft light and warmth.",
			HIGH = "Fire flies high!",
			LOW = "Dawn will come.",
			NORMAL = "Bright fire.",
			OUT = "Musha has to turn it on?",
		},
		FIRESTAFF = "It is dangerous magical staff.",
		FISH = "Musha got this from a pond... or maybe a merman?",
		FISHINGROD = "Fishing for fish so Musha can survive.",
		FISHSTICKS = "Sticks of fish! Easy to make, simple to eat!",
		FISHTACOS = " You know about tacos? These are tacos, with 'fish!' ",
		FISH_COOKED = "Musha wants to eat smoked salmon.",
		FLINT = "The edge to most of the tools Musha can make.",
		FLOWER = "Musha might be able to do something with a lot of these",
		FLOWERHAT = "A halo of flowers. It makes Musha feel so good.",
		FLOWER_EVIL = "Ew, this flower smells really bad, not like the other flowers",
		FOLIAGE = "Musha got this in the cave.",
		FOOTBALLHAT = "It keeps Musha's head safe!",
		FROG =
		{
			DEAD = "A good frog is a dead frog.",
			GENERIC = "Musha doesn't like when frogs lick Musha...",
			SLEEPING = "Sleeping frogs, should Musha sneak up on them?",
		},
		FROGGLEBUNWICH = "A frog inside of sandwich.",
		FROGLEGS = "Musha only eats the legs from the frogs.",
		FROGLEGS_COOKED = "It's yummy!",
		FRUITMEDLEY = "Yummy, fruit!",
		GEARS = "Metal gear Musha.",
		GHOST = "Turn undead? Just beat the ghost with a sword!!",
		GOLDENAXE = "Golden shiny axe!",
		GOLDENPICKAXE = "Golden shiny pickaxe!",
		GOLDENPITCHFORK = "Golden shiny pitchfork!",
		GOLDENSHOVEL = "Golden shiny shovel!",
		GOLDNUGGET = "Musha has to collect them!",
		GRASS =
		{
			BARREN = "It needs poop.",
			WITHERED = "It is bone dry.",
			BURNING = "Fire! Fire! Musha need water!",
			GENERIC = "Grass is base of survival.",
			PICKED = "Grass will always grow.",
		},
		GREEN_CAP = "Yes. Don't eat raw. Will see hallucination.",
		GREEN_CAP_COOKED = "It can help your mental health.",
		GREEN_MUSHROOM =
		{
			GENERIC = "It can be used as a sedative.",
			INGROUND = "Musha has to come back in the evening.",
			PICKED = "Someone picked it already, maybe it was Musha.",
		},
		GUNPOWDER = "Maybe Musha should keep this incase Musha has to fight a dragonfly!",
		HAMBAT = "Nice to 'meat' you!",
		HAMMER = "Hammer bros!",
		HEALINGSALVE = "It saved Musha several times.",
		HEATROCK =
		{
			FROZEN = "Freezing!",
			COLD = "It's stone cold.",
			GENERIC = "Musha needs to keep it Cooler in summer, and hotter in winter.",
			WARM = "Warm yellow stone.",
			HOT = "Red hot stone!",
		},
		HONEY = "Yeah! Honey!",
		HONEYCOMB = "Bees probably don't want Musha to have this.",
		HONEYHAM = "Lots of meat, and lots of honey.",
		HONEYNUGGETS = "Musha loves meat. Musha loves honey. Musha has both!",
		HORN = "It makes a loud and low sound.",
		HOUND = "They were friends, but now they make Musha stronger.",
		HOUNDMOUND = "Where are hounds coming from? Underground?",
		HOUNDBONE = "This was a hound at one point, now it's just bones ",
		ICEBOX = "Allows Musha to store food for a long time!",
		ICEHOUND = "Its fur is snow white!",
		INSANITYROCK =
		{
			ACTIVE = "It rises at low sainty.",
			INACTIVE = "It's open.",
		},
		JAMMYPRESERVES = "Eat slowly!",
		KABOBS = "Meat chunks speared by a stick!",
		KILLERBEE =
		{
			GENERIC = "It is not honeybee!\n Why do wasps and bees live together?",
			HELD = "Red devils!",
		},
		KNIGHT = "Not Musha's little pony!",
		KOALEFANT_SUMMER = "Elepha... What was that?",
		KOALEFANT_WINTER = "Elepha... What was that?",
		KRAMPUS = "Demon!",
		KRAMPUS_SACK = "It is bigger than Musha!",
		LAVAE = "It likes to set things on fire... Musha hate's them...",
		LEIF = "Walking Tree!",
		LEIF_SPARSE = "Walking Tree!",
		LIGHTNING_ROD =
		{
			CHARGED = "Oh, Charged steel! Don't touch it!",
			GENERIC = "It makes the area safe from lightning.",
		},
		LITTLE_WALRUS = "Unarmed baby follows father!",
		LIVINGLOG = "That is from an old tree",
		LOCKEDWES = "He's trapped!",
		LOG =
		{
			BURNING = "Fire! It is on fire!",
			GENERIC = "Wood is so useful! What should Musha do with it?",
		},
		LUREPLANT = "This plant has huge stomach.",
		LUREPLANTBULB = "It is mine now.",
		MALE_PUPPET = "It looks like... Wilson?",
		MANDRAKE =
		{
			DEAD = "It has a human like face & leafy hair.",
			GENERIC = "It isn't exactly a carrot.",
			PICKED = "It has a human like face & leafy hair.",
		},
		COOKEDMANDRAKE = "This time Musha cooked mandrake,\n but Musha likes mandrake soup more.",
		MANDRAKESOUP = "Mandrake soup! Totally perfect!",
		MARBLE = "Oof... It's heavy!",
		MARBLEPILLAR = "It looks nice.",
		MARBLETREE = "Who made this, and what for?",
		MARSH_BUSH =
		{
			BURNING = "Fire! Fire! Hey, Musha needs water!",
			GENERIC = "Too many spines!",
			PICKED = "Musha has no interest in it.",
		},
		MARSH_PLANT = "This area makes spiky plants.",
		MARSH_TREE =
		{
			BURNING = "Oh, It is not Musha's fault.",
			BURNT = "All burned wood becomes charcoal.",
			CHOPPED = "A stump is all that is left.",
			GENERIC = "That tree seems to be sick.",
		},
		MAXWELL = "He's so tall.",
		MAXWELLHEAD = "Bla bla bla.",
		MAXWELLLIGHT = "It lit on its own!.",
		MAXWELLLOCK = "Hmm, Musha needs a key.",
		MAXWELLTHRONE = "Looks dangerous...",
		MEAT = "Musha can eat this now, but it's better if it's jerky, but it's best when cooked.",
		MEATBALLS = "Meatballs!",
		MEAT_DRIED = "Musha likes that!",
		MERM = "Oh, They seem to dislike Musha.",
		MONSTERLASAGNA = "It is food, but it's not healthy for Musha. \n Maybe someone else can eat it",
		MONSTERMEAT = "Who would eat this? Eww.",
		MONSTERMEAT_DRIED = "Disgusting smell is disappeared.\n But it is still... 'not good'.",
		MOSQUITO =
		{
			GENERIC = "Musha's blood is not delicious!",
			HELD = "Now, it is mine, no more itchy bites!",
		},
		MOSQUITOSACK = "It is fluffy!",
		MOUND =
		{
			DUG = "No one will rest in peace.\n If anyones dies we just try and try again...",
			GENERIC = "Whose mound?",
		},
		MULTIPLAYER_PORTAL = "It is alpha and omega\n the beginning and the end.",
		NIGHTLIGHT = "Its fuel is man's nightmares.",
		NIGHTMAREFUEL = "The little fear is still alive!",
		NIGHTSWORD = "Musha's nightmare blade can vanquish real nightmares!",
		NITRE = "Others use this for making gunpowder,\n Musha can use this for gear repair.",
		ONEMANBAND = "LeT's DaNcE aNd PlAy!",
		PANDORASCHEST = "A chest from the old age? How'd it get here?",
		PANFLUTE = "Sleeping Beasty.",
		PAPYRUS = "Useful plant! Musha can make papyrus!",
		PENGUIN = "They slide on land! Can you believe it?",
		PERD = "Does anyone have berries or mushrooms? \n Musha can lure that bird with them.",
		PEROGIES = "Fortune cookies! Oh, wait, there is meat inside?",
		PETALS = "Smells good. But not enough to fill Musha's belly.",
		PETALS_EVIL = "Ew, These flowers smell really bad, not like the others ones around here.",
		PHLEGM = "What the... What can Musha do?",
		PICKAXE = "Cut stone, and then build a house!",
		PIGGYBACK = "Big, Fire and water proof backpack!",
		PIGKING = "He has a tons of gold! Musha need's to barter with him!",
		PIGMAN =
		{
			DEAD = "Dead pigman is just a pig.",
			FOLLOWER = "Let's go! Let's cut trees and kill spiders!",
			GENERIC = "They are friendly to Musha.",
			GUARD = "Oh, come on!",
			WEREPIG = "You are not a pigman anymore! You're a monster!",
		},
		PIGSKIN = "A pig's skin!",
		PIGTORCH = "They seem to like decorating their torches.",
		PINECONE =
		{
		    GENERIC = "It is an Evergreen's seed.",
		    PLANTED = "It will be huge tree soon.",
		},
		PITCHFORK = "Musha can pull up turf.",
		PLANTMEAT = "Eww, it started melting.",
		PLANTMEAT_COOKED = "Oh, it smells like a meat!",
		PLANT_NORMAL =
		{
			GENERIC = "Vegetables... Vegetables.",
			GROWING = "Let it grow~ Let it grow~",
			READY = "It's finished! Musha should pick it!",
			WITHERED = "It id totally dry... Musha has to get that out of there.",
		},
		POMEGRANATE = "It is not an apple! It's Pomegranate!",
		POMEGRANATE_COOKED = "It makes Musha feel healthy.\n So, can Musha eat this now?",
		POMEGRANATE_SEEDS = "A tiny ruby red seed.",
		POOP = "Ick... It is messy to use and it smells horid... But it's useful.",
		PUMPKIN = "Pumpkin! Musha loves Jack-O-lanterns!",
		PUMPKINCOOKIE = "Pumpkin cookies!",
		PUMPKIN_COOKED = "It was gently cooked.",
		PUMPKIN_LANTERN = "It looks like hound's face, doesn't it?",
		PUMPKIN_SEEDS = "Do you need more pumpkins?",
		PURPLEGEM = "Purple gem makes the world crazy.",
		RABBIT =
		{
			GENERIC = "It's fast! But Musha has an idea!",
			HELD = "What does Musha do? Kill it? Nourish it?",
		},
		RABBITHOLE =
		{
			GENERIC = "Did you hear that? There are still bunnies in there.",
			SPRING = "This hole was filled with snow. But rabbits are still inside.",
		},
		RATATOUILLE = "Where is the meat? There is none? Oh...",
		RAZOR = "Musha will shave your hair!",
		REDGEM = "Red gem is symbol of life and fire.",
		RED_CAP = "Mushrooms of brilliant colors are posionus, usually.",
		RED_CAP_COOKED = "Useless, isn't it?",
		RED_MUSHROOM =
		{
			GENERIC = "Mushroom of brilliant colors has poison, usually.",
			INGROUND = "It only comes above gound in the day",
			PICKED = "Someone picked the mushroom.",
		},
		REEDS =
		{
			BURNING = "FIRE! Somebody help Musha!",
			GENERIC = "Mostly, reeds are materials for darts and bandages.",
			PICKED = "Musha hoped that Musha could get some more.",
		},
        RELIC =
        {
            GENERIC = "Hm. Can Musha take it?",
            BROKEN = "Needs to repair.",
        },
        RUBBLE = "Time flies.",
		RESURRECTIONSTONE = "It is not resurrection.\n It forces Musha die again.",
		ROBIN =
		{
			GENERIC = "A red bird. The color of fire, like Yamche.",
			HELD = "What does Musha do? Where is a cage Musha can put it in?",
		},
		ROBIN_WINTER =
		{
			GENERIC = "That blue bird has a warm body. Yamche doesn't. Strange.",
			HELD = "What does Musha do? Where is a cage Musha can put it in?",
		},
		ROBOT_PUPPET = "No one can escape from death.",
		ROCK_LIGHT =-- what the flame blast?
		{
			GENERIC = "Musha doesn't understand how this happened.",
			OUT = "Lights out.",
			LOW = "The lava is cooling.",
			NORMAL = "Yes, it's very very hot.",
		},
		ROCKS = "Musha can do many things using these.",
        ROOK = "Steel rhinoceros!",
        ROPE = "Musha can use this as bindings!",
		ROTTENEGG = "Rotten egg smells bad but is still useful.\n Especially to make gunpowder.",
		SANITYROCK =
		{
			ACTIVE = "It rises if Musha has high sainty.",
			INACTIVE = "It's open.'",
		},
	--adds 2 start
		SCARECROW = 
   		{
			GENERIC = "All dressed up and no where to crow.",
			BURNING = "Someone made that strawman eat crow.",
			BURNT = "Someone MURDERed that scarecrow!",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "We can make stone sculptures with this.",
			BLOCK = "Ready for sculpting.",
			SCULPTURE = "A masterpiece!",
			BURNT = "Burnt right down.",
   		},
        SCULPTURE_KNIGHTHEAD = "Where's the rest of it?",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "It's an odd marble statue.",
			UNCOVERED = "Musha guesses he cracked under the pressure.",
			FINISHED = "At least it's back in one piece now.",
			READY = "Something's moving inside.",
		},
        SCULPTURE_BISHOPHEAD = "Is that a head?",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "It looks old, but it feels new.",
			UNCOVERED = "There's a big piece missing.",
			FINISHED = "Now what?",
			READY = "Something's moving inside.",
		},
        SCULPTURE_ROOKNOSE = "Where did this come from?",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "It's some sort of marble statue.",
			UNCOVERED = "It's not in the best shape.",
			FINISHED = "All patched up.",
			READY = "Something's moving inside.",
		},
        GARGOYLE_HOUND = "Musha doesn't like how it's looking at Musha.",
        GARGOYLE_WEREPIG = "It looks very lifelike.",
	--adds 2 end	
	
		SAPLING =
		{
			BURNING = "WILLOW!? IS SHE AGAIN BURNING THINGS AGAIN!?",
			WITHERED = "It needs water. Or poop.",
			GENERIC = "This is essential.",
			PICKED = "It will always grow back for Musha",
		},
		SEEDS = "Meats or vegetables. That is the question.",
		SEEDS_COOKED = "Musha can eat to fill hunger. They are easy to find.",
		SEWING_KIT = "Musha can sew clothes!",
		SHOVEL = "Musha can dig up items!",
		SILK = "Musha always hunting spiders,\n so Musha has tons of web.",
		SKELETON = "Its soul suffers in another world.",
		--SKELETON_PLAYER = "That gives me the willies.",

		SKELETON_PLAYER =
		{
			MALE = "Here is %s's corpse, cause is %s.",
			FEMALE = "Here is %s's bone, cause is %s.",
			ROBOT = "Here is %s's wreck, cause is %s.",
			DEFAULT = "Here is %s's corpse, cause is %s.",
		},

		SKULLCHEST = "What's for? This design feels like an bad omen!", --what was that?
		SMALLBIRD =
		{
			GENERIC = "It is similar to yamche, kinda.",
			HUNGRY = "Are you hungry?",
			STARVING = "Wait, wait. Musha knows, you are starving.",
		},
		SMALLMEAT = "Looks like a leg, body, head or wing.",
		SMALLMEAT_DRIED = "Smells good!",
		SPAT = "Sheep? Nope... Rhino? Nah...",
		SPEAR = "Musha will FIGHT!",
		SPIDER =
		{
			DEAD = "Musha needs more spiders to become stronger.",
			GENERIC = "Easy to beat, easy training!.",
			SLEEPING = "The spider is sleeping, should Musha sneak up on it or leave it be?",
		},
		SPIDERDEN = "Musha isn't scared of that!",
		SPIDEREGGSACK = "Musha can take it to Musha's backyard.",
		SPIDERGLAND = "This can heal Musha!, \n also it can make healing slave!",
		SPIDERHAT = "Musha is your mother!",
		SPIDERQUEEN = "Big mother spider, and big mother load of EXP for Musha!",
		SPIDER_WARRIOR =
		{
			DEAD = "You did your best, but Musha is too strong!",
			GENERIC = "It can lunge and bite from a distance. Musha needs to be careful.",
			SLEEPING = "The warrior is sleeping, should Musha lunge at it this time?",
		},
		SPOILED_FOOD = "Musha said that it was yucky.",
		STATUEHARP = "Is that a harp? Musha's never seen it before.",
		STATUEMAXWELL = "He trapped me here... Musha hates him.",
		STEELWOOL = "Should Musha make a jumper? What? it's a joke!",
		STINGER = "The stinger of a little bee.",
		STRAWHAT = "Made by straw, but it keeps Musha dry and cool.",
		SUNKBOAT = "What's happen to it?",
		SWEATERVEST = "It is a fashionable vest!",
		TAFFY = "More candy for Musha!",
		TALLBIRD = "Really tall black bird. Sometimes it's vicious!",
		TALLBIRDEGG = "A big blue egg.",
		TALLBIRDEGG_COOKED = "It is too large to eat alone, But Musha can because Musha's very hungry.",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "The egg needs to be warmer!",
			GENERIC = "It is raised  the same as Yamche!",
			HOT = "It is too hot to hatch!",
			LONG = "How long is this going to take?",
			SHORT = "Musha hears something it might hatch soon!",
		},
		TALLBIRDNEST =
		{
			GENERIC = "Did you see that? It is a big egg!",
			PICKED = "Angry bird's egg is gone.",
		},
		TEENBIRD =
		{
			GENERIC = "It seems to that bird wants something...",
			HUNGRY = "That bird is always hungry.",
			STARVING = "Do not peck Musha!\n Musha gave your foods!",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "Musha just wanted to meet you over the monitor.",
			GENERIC = "Is it a warp gate?",
			LOCKED = "Needs something before Musha can use it.",
			PARTIAL = "To the next world!",
		},
		TELEPORTATO_BOX = "Surprise box!",
		TELEPORTATO_CRANK = "What does this go to?",
		TELEPORTATO_POTATO = "Just a metal thing.",
		TELEPORTATO_RING = "Some large ring.",
		TENTACLE = "Looks like a squid's leg.",
		TENTACLESPOTS = "Something is in here! Does Musha have to keep it?",
		TENTACLESPIKE = "Oh, It has spikes on it. How nice!",
		TENTACLE_PILLAR = "That's alive!",
		TENTACLE_PILLAR_ARM = "Do not grope Musha!",
		TENTACLE_GARDEN = "Musha heard something digging.",
		TOPHAT = "Gentlemanly hat.",
		TORCH = "No darkness, no fear!",
		TRAP = "For rabbits, frogs and spiders.",
		TRAP_TEETH = "For killing hounds, pengull and mosling.",
		TRAP_TEETH_MAXWELL = "What was that? a Landmine?\n Is that a danger to Musha?",
		TRINKET_1 = "It doesn't deal much damage to monsters.\n Is there anyone interested it?",-- Melty Marbles
		TRINKET_10 = "Teeth? It is not strong enough to bite.",-- Second-hand Dentures
		TRINKET_11 = "Toy!",-- Lying Robot
		TRINKET_12 = "It is too hard to eat that tentacle.",--Dessicated Tentacle
		TRINKET_13 = "Some people like this, but Musha doesn't.",
		TRINKET_2 = "Ocarina of Wind... Wha? Musha can't play it",--Fake Kazoo
		TRINKET_3 = "If it's to difficult to untie the knot, just cut it.",--Gord's Knot
		TRINKET_4 = "Gnome gnome gnome~ Little little gnome~",--Gnome
		TRINKET_5 = "Nuclear lunch detected? What does that mean?", --starcraft
		TRINKET_6 = "Assassination? With wires? are these wires?\n Musha's not interested.",--Frazzled Wires
		TRINKET_7 = "Try to catch the ball in the cup!",-- Ball and Cup
		TRINKET_8 = "Musha knows what this is... uh, it's parts to a mini flail.",-- Hardened Rubber Bung
		TRINKET_9 = "Musha will decorate a statue with these buttons!",--Mismatched Buttons
	--adds 3 start
		TRINKET_10 = "They've quickly become Wes' favorite prop.", --Dentures
		TRINKET_11 = "Hal whispers beautiful lies to Musha.", --Lying Robot
		TRINKET_12 = "That's just asking to be experimented on.", --Dessicated Tentacle
		TRINKET_13 = "It must be some kind of religious artifact.", --Gnomette
		TRINKET_14 = "Now if Musha only had some tea...", --Leaky Teacup
		TRINKET_15 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_16 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_17 = "A horrifying utensil fusion. Maybe science *can* go too far.", --Bent Spork
		TRINKET_18 = "Musha wonders what it's hiding?", --Trojan Horse
		TRINKET_19 = "It doesn't spin very well.", --Unbalanced Top
		TRINKET_20 = "Wigfrid keeps jumping out and hitting Musha with it?!", --Backscratcher
		TRINKET_21 = "This egg beater is all bent out of shape.", --Egg Beater
		TRINKET_22 = "Musha has a few theories about this string.", --Frayed Yarn
		TRINKET_23 = "Musha can put Musha's shoes on without help, thanks.", --Shoehorn
		TRINKET_24 = "Musha thinks Wickerbottom had a cat.", --Lucky Cat Jar
		TRINKET_25 = "It smells kind of stale.", --Air Unfreshener
		TRINKET_26 = "Food and a cup! The ultimate survival container.", --Potato Cup
		TRINKET_27 = "If you unwound it you could poke someone from really far away.", --Coat Hanger
		TRINKET_28 = "How Machiavellian.", --Rook
        TRINKET_29 = "How Machiavellian.", --Rook
        TRINKET_30 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_31 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_32 = "Musha knows someone who'd have a ball with this!", --Cubic Zirconia Ball
        TRINKET_33 = "Musha hopes this doesn't attract spiders.", --Spider Ring
        TRINKET_34 = "Let's make a wish. For science.", --Monkey Paw
        TRINKET_35 = "Hard to find a good flask around here.", --Empty Elixir
        TRINKET_36 = "Musha might need these after all that candy.", --Faux fangs
        TRINKET_37 = "Musha doesn't believe in the supernatural.", --Broken Stake
        TRINKET_38 = "Musha thinks it came from another world. One with grifts.", -- Binoculars Griftlands trinket
        TRINKET_39 = "Musha wonders where the other one is?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "Holding it makes me feel like bartering.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "It's a little warm to the touch.", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "It's full of someone's childhood memories.", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "It's not very good at jumping.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "It's some sort of plant specimen.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "It's picking up frequencies from another world.", -- Odd Radio ONI trinket
        TRINKET_46 = "Maybe a tool for testing aerodynamics?", -- Hairdryer ONI trinket
		
		HALLOWEENCANDY_1 = "The cavities are probably worth it, right?",
        HALLOWEENCANDY_2 = "What corruption of science grew these?",
        HALLOWEENCANDY_3 = "It's... corn.",
        HALLOWEENCANDY_4 = "They wriggle on the way down.",
        HALLOWEENCANDY_5 = "Musha's teeth are going to have something to say about this tomorrow.",
        HALLOWEENCANDY_6 = "Musha... doesn't think Musha will be eating those.",
        HALLOWEENCANDY_7 = "Everyone'll be raisin' a fuss over these.",
        HALLOWEENCANDY_8 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_9 = "Sticks to Musha's teeth.",
        HALLOWEENCANDY_10 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_11 = "Much better tasting than the real thing.",
        HALLOWEENCANDY_12 = "Did that candy just move?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Oh, Musha's poor jaw.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "Musha doesn't do well with spice.", --Hot Lava pepper candy
        CANDYBAG = "It's some sort of delicious pocket dimension for sugary treats.",

        DRAGONHEADHAT = "So who gets to be the head?",
        DRAGONBODYHAT = "Musha is middling on this middle piece.",
        DRAGONTAILHAT = "Someone has to bring up the rear.",
        PERDSHRINE =
        {
            GENERIC = "Musha feels like it wants something.",
            EMPTY = "Musha needs to plant something there.",
            BURNT = "That won't do at all.",
        },
        REDLANTERN = "This lantern feels more special than the others.",
        LUCKY_GOLDNUGGET = "What a lucky find!",
        FIRECRACKERS = "Filled with explosion science!",
        PERDFAN = "It's inordinately large.",
        REDPOUCH = "Is there something inside?",
        WARGSHRINE = 
        {
            GENERIC = "Musha should make something fun.",
            EMPTY = "Musha needs to put a torch in it.",
            BURNT = "It burned down.",
        },
        CLAYWARG = 
        {
        	GENERIC = "A terror cotta monster!",
        	STATUE = "Did it just move?",
        },
        CLAYHOUND = 
        {
        	GENERIC = "It's been unleashed!",
        	STATUE = "It looks so real.",
        },
        HOUNDWHISTLE = "This'd stop a dog in its tracks.",
        CHESSPIECE_CLAYHOUND = "That thing's the leashed of my worries.",
        CHESSPIECE_CLAYWARG = "And Musha didn't even get eaten!",

		BISHOP_CHARGE_HIT = "Ow!",
	--adds 3 end
		TRUNKVEST_SUMMER = "It is a warm waterproof vest!",
		TRUNKVEST_WINTER = "Someone said the padding for the vest is hard to get,\n but Musha did it.",
		TRUNK_COOKED = "Would you eat this? Why?",
		TRUNK_SUMMER = "A long nose!",
		TRUNK_WINTER = "A long nose!",
		UMBRELLA = "Musha loves the colour!",
		WAFFLES = "Hi, waffles! It is time to eat you!",
		WALL_HAY_ITEM = "Hmmm. I worry about how easily it can burn.",
		WALL_STONE = "It would be safe..",--0
		WALL_STONE_ITEM = "It looks heavy, but Musha doesn't mind.",
		WALL_RUINS = "Wellow stone wall!",--0
		WALL_RUINS_ITEM = "It looks heavy, but Musha doesn't mind.",
		WALL_WOOD_ITEM = "Wooden walls. Better than hay.",
		WALRUS = "Stay close! He only has darts!",
		WALRUSHAT = "PERFECT.",
		WALRUS_CAMP =
		{
			EMPTY = "Someone lived here.",
			GENERIC = "Musha wants to live in a house like that!",
		},
		WALRUS_TUSK = "It is large and sleek.",
		WARG = "Bring your brothers kid.",
		WASPHIVE = "Looks very dangerous.",
		WETGOOP = "Musha did nothing wrong.",
		WINTERHAT = "Basic equipment for the winter.",
		WORMHOLE =
		{
			GENERIC = "Is that the tail end or the head?",
			OPEN = "Musha can't be sure that thing is safe.",
		},
		ACCOMPLISHMENT_SHRINE = "Musha hates that arrow!",
	},
	DESCRIBE_TOODARK = "Where is glow dust?\n Musha needs more light now!",
	DESCRIBE_SMOLDERING = "Oooooooooh!",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "This is yummy, but meat is better.",
	},
}
