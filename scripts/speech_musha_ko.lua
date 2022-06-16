--Created: Luka 
return {
--adds action start
	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "이게 아닌 모양이야",
        },
        BUILD =
        {
            MOUNTED = "뮤샤는 물건을 쌓아올리는 재주는 없어",
            HASPET = "똑같은 펫을 여러마리 키우면 안돼",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "깨어있는 동물한테 칼을 대면 큰일나",
			GENERIC = "뮤샤는 이런 털은 모아도 쓸데가 없다고 생각해",
			NOBITS = "이 이상 털을 밀면 부끄러워 죽어버릴지도 몰라",
		},
		STORE =
		{
			GENERIC = "더 이상은 안들어가",
			NOTALLOWED = "이건 뮤샤가 손을 대면 안돼",
			INUSE = "뮤샤의 차례는 좀 더 기다려야해",
		},
		RUMMAGE =
		{	
			GENERIC = "이건 아니야",
			INUSE = "뮤샤가 지금 손을 대도 바뀌는건 없을거야",
		},
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "뮤샤가 보기엔 다른게 필요해",
        	KLAUS = "뮤샤는 제정신으로 돌아왔다!",
			QUAGMIRE_WRONGKEY = "뮤샤가 보기엔 다른게 필요해",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "잠겨있어",
		},
        COOK =
        {
            GENERIC = "뮤샤는 음식은 요리해서 먹는걸 좋아해",
            INUSE = "뮤샤가 생각하는 그 요리일까?.",
            TOOFAR = "뮤샤는 음식은 요리해서 먹는걸 좋아해",
        },
		GIVE =
        {
            GENERIC = "뮤샤는 이걸 어떻게 줘야할 지 모르겠어",
            DEAD = "받을 손이 없어서 줄 수 없어",
            SLEEPING = "몰래 가방에 넣는거는 하면 안돼",
            BUSY = "지금은 받을 수 없는 모양이야",
            ABIGAILHEART = "이렇게 하는 것 보다 재대로 된 방법이  있을거야",
            GHOSTHEART = "아무일도 일어나지 않아",
            NOTGEM = "아무일도 일어나지 않아",
            WRONGGEM = "아무일도 일어나지 않아",
            NOTSTAFF = "아무일도 일어나지 않아",
            MUSHROOMFARM_NEEDSSHROOM = "우선 버섯을 심어보자",
            MUSHROOMFARM_NEEDSLOG = "버섯을 심을 통나무가 필요해",
            SLOTFULL = "넣을 자리가 없어",
            FOODFULL = "볼도 빵빵하고 배도 빵빵한게 더는 안들어가겠어",
            NOTDISH = "뮤샤도 역시 이건 먹을 수 없을거라고 봐",
            DUPLICATE = "아무일도 일어나지 않아",
            NOTSCULPTABLE = "아무일도 일어나지 않아",
            NOTATRIUMKEY = "아무일도 일어나지 않아",
            CANTSHADOWREVIVE = "아무일도 일어나지 않아",
            WRONGSHADOWFORM = "아무일도 일어나지 않아",
        },
        GIVETOPLAYER =
        {
            FULL = "아무래도 이걸 넣을 만한 빈자리가 보이질 않아",
            DEAD = "시체엔 아무것도 넣어지지 않아",
            SLEEPING = "자고있는 동안 아이템을 넣어버리면 일어날 때 깜짝 놀랄거야",
            BUSY = "불쑥 끼어드는건 좋지 않다고 뮤샤는 생각해",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "아무래도 이걸 넣을 만한 빈자리가 보이질 않아",
            DEAD = "시체엔 아무것도 넣어지지 않아",
            SLEEPING = "자고있는 동안 아이템을 넣어버리면 일어날 때 깜짝 놀랄거야",
            BUSY = "불쑥 끼어드는건 좋지 않다고 뮤샤는 생각해",
        },
        WRITE =
        {
            GENERIC = "뮤샤가 봐도 이건 잘 만든것 같아",
            INUSE = "덧씌우기 같은건 안돼",
        },
        DRAW =
        {
            NOIMAGE = "뭐가 들었는지 뭐를 준비해두었는지 표시해두면 될거야",
        },
        CHANGEIN =
        {
            GENERIC = "뭔가를 바꾸어보는것도 기분이 날지도 모라",
            BURNING = "이 상황에서 그럴 여유는 없지 않을까?",
            INUSE = "먼저 사용중인 상대가 있어서 기다려야해",
        },
        ATTUNE =
        {
            NOHEALTH = "뮤샤의 코가 위험을 알리고있어",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "뮤샤는 화난 비팔로를 타는건 하지 않아",
            INUSE = "비팔로를 타면 뮤샤가 달리는거보다 훨씬 빨라",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "뮤샤는 화난 비팔로를 타는건 하지 않아",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "뮤샤가 알고 있는 내용과 똑같네",
            CANTLEARN = "뮤샤는 이거 하나도 모르겠어",

            --MapRecorder/MapExplorer
            WRONGWORLD = "이 지도 전혀 안맞잖아!",
        },
        WRAPBUNDLE =
        {
            EMPTY = "여기에 뭔가 빠져있어",
        },
        PICKUP =
        {
			RESTRICTION = "뮤샤의 지식엔 이걸 다루는 방법은 없었어",
			INUSE = "지금 만지면 안된다고 뮤샤의 감이 핑핑 거리고있어",
        },
        SLAUGHTER =
        {
            TOOFAR = "뮤샤의 코도 놓쳐버렸어",
        },
        REPLATE =
        {
            MISMATCH = "이 요리에 이 접시는 어울리지 않아", 
            SAMEDISH = "똑같은 접시니까 접시를 바꿀 필요는 없어", 
        },
	},
	ACTIONFAIL_GENERIC = "무언가 뮤샤 생각대로 되지 않았어",
	ANNOUNCE_DIG_DISEASE_WARNING = "뮤샤가 생각했던대로 움직이는게 느껴져?",
	ANNOUNCE_PICK_DISEASE_WARNING = "뮤샤의 모험이 다시 움직일거야",
--adds action end
	ANNOUNCE_HATEFOOD = "정말 맛없어!",
	ANNOUNCE_ADVENTUREFAIL = "뮤샤는 조금만 잘거야. 조금만.",
	ANNOUNCE_BOOMERANG = "뮤샤를 때리지마 거미같은 나무야!",
	ANNOUNCE_CHARLIE = "뮤샤 뒤에 뭔가 있어!",
	ANNOUNCE_CHARLIE_ATTACK = "비겁한 녀석, 숨어서 때리지마!",
	ANNOUNCE_COLD = "뮤샤의 손가락이 얼었어!",
	ANNOUNCE_HOT = "이 날씨는 뮤샤에겐 너무 더워!",
	ANNOUNCE_DUSK = "햇살이 지고있어. 뮤샤는 불을 준비해야해!",
	ANNOUNCE_EAT =
      {
                GENERIC = "냠냠!",
                PAINFUL = "딱딱한게 씹혔어!",
                SPOILED = "썩었잖아!",
                STALE = "물컹하고 질척해!",
		YUCKY = "역겨워!",
	},
	ANNOUNCE_NOSLEEPONFIRE = "뮤샤는 여기에서는 잘 수 없어!\n뮤샤는 불을 먼저 피워야해!",
	ANNOUNCE_NODANGERSIESTA = "뮤샤는 이상한 소리를 들었어!\n뮤샤는 안전을 확인 해야해!",
	ANNOUNCE_NONIGHTSIESTA = "밤에 여기에서 쉬기에는 너무 추워!",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "바닥이 너무 차가워!",
	ANNOUNCE_NOHUNGERSIESTA = "뮤샤는 쉬는 것보다 먹는 것을 먼저 할거야",
	ANNOUNCE_SHELTER = "그늘 아래는 편안해.",
	ANNOUNCE_BURNT = "이 나무의 이 부분은 사람 얼굴같지 않아?",
	ANNOUNCE_TOOL_SLIP = "미끄러졌어!",
	ANNOUNCE_DAMP = "비가 와! 빨리 비를 피해야해!",
	ANNOUNCE_WET = "뮤샤 머리가 축축해",
	ANNOUNCE_WETTER = "뮤샤의 옷하고 신발이 모두 축축해",
	ANNOUNCE_SOAKED = "물에 젖은 가방이 너무 무거워! 쉬고싶어!",
	ANNOUNCE_HOUNDS = "들었어? 하운드가 가까이 왔어",
	--ANNOUNCE_HUNGRY = "Musha needs meats. Anyone?",
	ANNOUNCE_HUNGRY = "너무 배고파",
	ANNOUNCE_HUNT_BEAST_NEARBY = "뮤샤가 사냥감을 찾았어! 정말 커!",
	ANNOUNCE_HUNT_LOST_TRAIL = "뮤샤는 발자국을 잃어버렸어",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "진흙이 발자국을 지웠어. 뮤샤는 진흙이 싫어",
	ANNOUNCE_ACCOMPLISHMENT= "뮤샤와 모험은 언제나 함께야!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "뮤샤가 해냈어!",
	ANNOUNCE_LIGHTFIRE =
	{
		[1] = "빛이야!",
		[2] = "불이야!",
		[3] = "불을 피우면 여러가지를 할 수 있어!",
		[4] = "불길을 휘둘러 어둠을 내쫒는거야",
		[5] = "불을 피우면 따뜻해",
		[6] = "좋아!",
	},
	ANNOUNCE_PECKED = "나쁜 새!",
	ANNOUNCE_TORCH_OUT = "빛이 사라졌어!",
	ANNOUNCE_WORMHOLE = "뮤샤는 끈적한게 싫어.",
	ANNOUNCE_TRAP_WENT_OFF = "아! 함정을 보충해야겠어",
	ANNOUNCE_CRAFTING_FAIL = "어라? 만든게 작동하지 않아",
    ANNOUNCE_QUAKE = "동굴이 배탈났어!",
    ANNOUNCE_NODANGERSLEEP = "뮤샤는 이상한 소리를 들었어!\n뮤샤는 안전을 확인 해야해",
    ANNOUNCE_NOHUNGERSLEEP = "뮤샤는 너무 배고파!\n 뮤샤는 먼저 뭔가 먹어야 해!",
    ANNOUNCE_FREEDOM = "뮤샤는 자유야, 아무것도 뮤샤를 막을 수 없어!",
    ANNOUNCE_RESEARCH = "뮤샤는 그걸 알아! 뮤샤는 이걸 사용할 수 있어!",
    ANNOUNCE_NO_TRAP = "너무 쉬워!",
    ANNOUNCE_HIGHRESEARCH = "멋져! 뮤샤가 만든거야!",
    ANNOUNCE_THORNS = "아야! 무례한 식물!", --읭?
    ANNOUNCE_NODAYSLEEP_CAVE = "뮤샤는 더 놀고 싶어!\n뮤샤는 피곤하지 않아!",
    ANNOUNCE_BEES = "붕붕붕거리는 소리가 시끄러워",
    ANNOUNCE_KNOCKEDOUT = "어.. 작은 별들이 보여..",
    ANNOUNCE_LOWRESEARCH = "뮤샤는 너무 많이 만들었어",
    ANNOUNCE_DEERCLOPS = "강한 외눈은 오딘뿐이야!",
    ANNOUNCE_MOSQUITOS = "뮤샤도 너를 물거야!",
    ANNOUNCE_NODAYSLEEP = "졸려? 뮤샤는 더 놀고 싶어!",
    ANNOUNCE_INSUFFICIENTFERTILIZER = "이건 식물한테 별로 안좋을거야",
    ANNOUNCE_CANFIX = "뮤샤는 이걸 고칠 수 있어!",
    ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "뮤샤는 빛보다 빨라!",
        BATTLECRY =
        {
                GENERIC = "저 녀석을 잡는거야!",
                PIG = "나쁜 돼지!",
                PREY = "네가 오늘 뮤샤의 사냥감이야!",
                SPIDER = "거미 따위 무섭지 않아!",
                SPIDER_WARRIOR = "병정거미를 잡을거야!",
        },
        COMBAT_QUIT =
        {
                GENERIC = "살아남은 자가 강한거야.",
                PIG = "강한 돼지였어.\n 하지만 다음엔 뮤샤의 베이컨이 될거야!",
                PREY = "다음엔 널 잡아먹을거야!",
                SPIDER = "뮤샤도 팔이 많았으면 전부 때릴수 있었어..",
                SPIDER_WARRIOR = "뮤샤는 병정거미가 싫어!",
        },
		
--adds 4 start
	ANNOUNCE_TOADESCAPING = "개구리 머리가 보이지 않게 되기 전에 사냥해야해",
	ANNOUNCE_TOADESCAPED = "개구리가 보이지 않게 되어버렸어",
	
	ANNOUNCE_BECOMEGHOST = "으므므므므므",
	ANNOUNCE_GHOSTDRAIN = "뮤샤는 제정신이야!",
	ANNOUNCE_PETRIFED_TREES = "뮤샤가 보기에 이건 정말 특별한 나무야!",
	ANNOUNCE_KLAUS_ENRAGE = "뮤샤는 위험을 느꼈어!",
	ANNOUNCE_KLAUS_UNCHAINED = "뮤샤가 보기에도 저건 필요 없어보였어",
	ANNOUNCE_KLAUS_CALLFORHELP = "조심해! 뮤샤의 코에 다른게 느껴져!",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "뮤샤가 도와줄거야!",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "뮤샤와 함께 모험을 하는거야!",
    ANNOUNCE_REVIVED_FROM_CORPSE = "뮤샤의 모험은 아직 끝나지 않았던거야!",
    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "뮤샤는 새로운 것을 시도하는 모험을 해보았어. 실패했지만",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "뮤샤의 코가 느꼈을땐, 이미 늦은 뒤였어",
    QUAGMIRE_ANNOUNCE_LOSE = "뮤샤의 모험에 굴곡이 있다는건 알아! 낮을때도 있지!",
    QUAGMIRE_ANNOUNCE_WIN = "뮤샤의 모험은 재미있다구!",

    ANNOUNCE_ROYALTY =
    {
        "뮤샤와 함께하는거야!",
        "프린세스 뮤샤, 갑니다!",
        "즐거운일이 가득하길!",
    },
	
--adds 4 end	
		
	--우와 정말 귀찮다..
	DESCRIBE =
	{

--adds 5 start (DESCRIBE)
		ANTLION = 
		{
			GENERIC = "뮤샤에게 뭘 바라는거야?",
			VERYHAPPY = "뮤샤는 잘 하고 있어!",
			UNHAPPY = "뮤샤가 놓친게 있었던걸까?",
		},
		ANTLIONTRINKET = "이거 생긴거 신기해",
		SANDSPIKE = "무언가 숨겨진게 있을 지도 몰라",
        SANDBLOCK = "부스스해!",
        GLASSSPIKE = "무언가 숨겨진게 있을 지도 몰라",
        GLASSBLOCK = "잘 뭉쳐진 형태야",
		ABIGAIL_FLOWER = 
		{ 
			GENERIC ="봉오리만 있는데 시들지 않은건 신기하네",
			LONG = "주인이 있는 물건이지만 그것 외에 뭔가 있는 모양이야",
			MEDIUM = "뮤샤는 누군가의 시선을 느껴",
			SOON = "꽃봉오리가 시들지도 않고 피어났어!",
			HAUNTED_POCKET = "웅웅 거리는것도 아닌데 뭔가 느껴져",
			HAUNTED_GROUND = "금방이라도 이 빛나는게 튀어나올것만같아",
		},

		BALLOONS_EMPTY = "이거 엄청 잘 늘어나",
		BALLOON = "알록달록한 구름이 떠있는것만 같아",

		BERNIE_INACTIVE =
		{
			BROKEN = "망가진것은 어쩔 수 없는 거야",
			GENERIC = "무엇을 해볼까?",
		},

		BERNIE_ACTIVE = "뮤샤의 친구가 점점 많아져!",

        PLAYER =
        {
            GENERIC = "%s와의 모험이 시작되었어!",
			ATTACKER = "%s의 공격에 어울리는거야!",
            MURDERER = "%s이 뮤샤의 모험을 방해하고있어!",
            REVIVER = "%s가 도움을 줬어",
            GHOST = "%s의 모험에는 뮤샤의 도움이 필요해보여",
            FIRESTARTER = "%s의 불꽃놀이가 시작되었어!",
        },
		WILSON = 
		{
			GENERIC = "과학이 얼마나 엄청난건지는 잘 모르지만, 윌슨의 수염이 자라는건 알아",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER = "죽이고 부수는게 과학이 아닌거란건 알아, 그만해!",
			REVIVER = "%s의 저 행동도 과학을 위해서인거야?",
			GHOST = "죽었지만 죽지않은 지금 상황을 윌슨은 무슨 기분일까?",
			FIRESTARTER = "%s의 실험이 시작되는 모양이야",
		},
		WOLFGANG = 
		{
			GENERIC = "%s의 덩치는 언제봐도 놀라워!",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER = "먹을것을 문제로 죽이는건 오히려 문제야!",
			REVIVER = "%s의 행동이 도움이 될거야",
			GHOST = "싸우다 죽거나, 굶어죽거나. %s의 죽는 이유는 대부분 그래",
			FIRESTARTER = "%s의 불피우는 모습을 볼줄은 몰랐어!",
		},
		WAXWELL = 
		{
			GENERIC = "어디선가 본적이 었어, %s!",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER =  "뮤샤는 뺐기는 것을 좋아하지 않아",
			REVIVER = "%s의 모험엔 여럿이 필요한거야",
			GHOST = "아무리 꿍꿍이가 있대도 실수는 있는거야",
			FIRESTARTER = "%s의 불이 더 크거나 하진 않네",
		},
		WX78 = 
		{
			GENERIC = "헬로우 %s!",
			ATTACKER = "%s의 공격은 기계적이야! 기계니까?",
			MURDERER = "%s의 행동은 용서되지 않을거야!",
			REVIVER = "만든사람은 %s의 이런 상황도 예상했었던걸까?",
			GHOST = "%s의 영혼이 있다는건 평범하지 않은거 아닐까?",
			FIRESTARTER = "%s의 불은 무슨 조건이었을까?",
		},
		WILLOW = 
		{
			GENERIC = "%s? 화방녀? 정말로?",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER = "불을 지르는것도 행동도 용서할 수 없는거야!",
			REVIVER = "%s의 도움은 포근하기도 한거야",
			GHOST = "%s의 몸이 사그러들고 혼만 남은거야",
			FIRESTARTER = "또 %s의 불질이 시작된거야?",
		},
		WENDY = 
		{
			GENERIC = "%s는 친구가 필요한거야? 아니면 자매가 필요한거야?",
			ATTACKER = "%s의 전투는 평범하지 않아! 혼자가 아니니까! ",
			MURDERER = "너도, 쟤도 벌을 받아야해!",
			REVIVER = "%s의 바람은 다른 사람을 부활시키는 거겠지만, 도움을 받고있어",
			GHOST = "%s의 혼은 하나가 아니야. 정확히는 %s도 아니긴 해",
			FIRESTARTER = "%s이 불을 피우는건 불꽃에 홀려서가 아닐까",
		},
		WOODIE = 
		{
			GENERIC = "%s에게서 낮선 동물의 냄새가 나!",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER = "뮤샤는 %s의 도끼와 너를 용서하지 않아",
			REVIVER = "%s의 복장은 거칠어도 모두를 돕는 사람이야",
			GHOST = "%s의 실수는 무엇이었을까? 과다벌목?",
			BEAVER = "%s의 모습이 변해버렸어!",
			BEAVERGHOST = "%s의 영혼마저 이상하게 변해버렸어. 무슨 일이 있던걸까?",
			FIRESTARTER = "%s의 불을 지르는 모습은 상상밖이야",
		},
		WICKERBOTTOM = 
		{
			GENERIC = "책을 좋아해도 몸을 움직이는 일도 있는거야!",
			ATTACKER = "%s의 무기는 책 모서리가 아니었어!",
			MURDERER = "독단은 좋지 않은거야, %s!",
			REVIVER = "%s의 생각은 잘 모르지만 뮤샤를 도와주고있어",
			GHOST = "%s의 목숨을 책 보다 소중히 해 주었으면 좋겠어",
			FIRESTARTER = "%s의 불을 피우는 모습을 볼 줄은 몰랐어",
		},
		WES = 
		{
			GENERIC = "손짓은 잘 모르지만 반가워, %s!",
			ATTACKER = "%s의 공격은 전혀 아플것 같지 않은데 능숙해",
			MURDERER = "뮤샤는 풍선같은걸로 용서하지 않을거야",
			REVIVER = "%s는 조용히 뮤샤를 돕고있어",
			GHOST = "%s는 살아있을때도 말을 안했는데 죽어서도 조용하네",
			FIRESTARTER = "%s는 불을 지를때도 조용해서 모를뻔했어",
		},
		WEBBER = 
		{
			GENERIC = "거미는 사냥감이지만 %s는 공격하지 않을거야. 지금은",
			ATTACKER = "거미가 거미와 싸우는걸 보는 날이 있긴 해.",
			MURDERER = "역시 뮤샤는 거미는 사냥감이야! 거기서, %s!",
			REVIVER = "거미가 때때론 도움을 준다는걸 %s의 행동을 보고 알게됐어",
			GHOST = "죽은 뒤 영혼이 나오는 거미는 %s의 경우가 처음이야",
			FIRESTARTER = "불피우는 거미는 희귀하네",
		},
		WATHGRITHR = 
		{
			GENERIC = "%s의 모습은 어느 지역의 전사같아! ",
			ATTACKER = "%s의 싸우는 모습이 저기서 보여",
			MURDERER = "아무리 뮤샤보다 세다 해도 뮤샤는 %s를 용서하지 않아!",
			REVIVER = "%s의 도움은 여러가지가 있는거야",
			GHOST = "%s의 말로는 발할라 라는게 있다고 했는데 아닌가봐",
			FIRESTARTER = "%s가 너무 불타올랐어",
		},
        WINONA =
        {
            GENERIC = "%s와의 모험이 시작되었어!",
			ATTACKER = "%s의 공격에 어울리는거야!",
            MURDERER = "%s이 뮤샤의 모험을 방해하고있어!",
            REVIVER = "%s가 도움을 줬어",
            GHOST = "%s의 모험에는 뮤샤의 도움이 필요해보여",
            FIRESTARTER = "%s의 불꽃놀이가 시작되었어!",
        },
		 MUSHA =
        {
            GENERIC = "쌍둥이는 없지만 %s의 모습은 뮤샤와 똑같아!",
            ATTACKER = "%s의 싸움의 목적은 뮤샤와 같을거야",
            MURDERER = "아무리 모습이 같아도 용서하지 않을거야, %s!",
            REVIVER = "%s의 도움은 뮤샤에게도 도움이 돼",
            GHOST = "%s의 사고는 갑작 스러웠던 모양이야",
            FIRESTARTER = "%s의 불은 뮤샤가 생각했던것과 같을까?",
        },
        MIGRATION_PORTAL = 
        {
            GENERIC = "여럿이서 함께하는 모험은 즐거운거야",
            OPEN = "뮤샤의 모험에 따라와줄래?",
            FULL = "뮤샤도 모험에 같이 가고 싶지만 더 이상은 받아주질 않아",
        },
	
	
--adds 5 end (DESCRIBE)

	    MUSHA_EGG ="얌체 알이야!",
        MUSHA_EGGS1 ="함께 모험하기 충분한 얌체가 태어날거야",
        MUSHA_EGGS2 ="뮤샤 얼굴 보다 큰 얌체 알이야!",
        MUSHA_EGGS3 ="엄청난 크기의 알이야!",
        MUSHA_EGG1 ="이만한 크기의 알이면 거미 걱정은 없을거야",
        MUSHA_EGG2 ="뮤샤보다 무거운 알이야! 정말로!",
        MUSHA_EGG3 ="이 얌체가 태어나면 밤에도 걱정이 없을거야",
        MUSHA_EGG8 ="거대한 얌체가 태어날거야",
        MUSHA_EGG_CRACKED = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKEDS1 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKEDS2 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKEDS3 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKED1 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKED2 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKED3 = "얌체가 깨어나려고 하고있어!",
		MUSHA_EGG_CRACKED8 = "얌체가 깨어나려고 하고있어!",

       	MUSHA_SMALL = "얌체는 귀여워!\n기본값:(Z,V,B)",

		MUSHA_TEEN = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",
		MUSHA_TEENR1 = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",
		MUSHA_TEENR2 = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",
		MUSHA_TEENR3 = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",
		MUSHA_TEENR4 = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",
		MUSHA_TEENICE = "이젠 머리엔 올릴 수 없지만\n얌체는 여전히 귀여워\n기본값:(Z,V,B)",

		MUSHA_TALL = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",
		MUSHA_TALLR1 = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",
		MUSHA_TALLR2 = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",
		MUSHA_TALLR3 = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",
		MUSHA_TALLR4 = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",
		MUSHA_TALLRICE = "얌체는 아무거나 막 먹어\n기본값:(Z,V,B)",

		MUSHA_TALL2 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRR1 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRR2 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRR3 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRR4 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRR5 = "얌체는 내 친구야\n기본값:(Z,V,B)",
		MUSHA_TALLRRICE = "얌체는 내 친구야\n기본값:(Z,V,B)",

		MUSHA_TALL3 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRR1 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRR2 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRR3 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRR4 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRR5 = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",
		MUSHA_TALLRRRICE = "얌체와 함께라면 아무것도 두렵지 않아\n기본값:(Z,V,B)",

		MUSHA_TALL4 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR1 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR2 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR3 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR4 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR5 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRR6 = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRICE = "뮤샤와 얌체는 한 가족이야\n기본값:(Z,V,B)",

		MUSHA_TALL5 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR1 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR2 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR3 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR4 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR5 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRR6 = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",
		MUSHA_TALLRRRRRICE = "함께 여행하는건 정말 즐거워!\n기본값:(Z,V,B)",

		MUSHA_RP1 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP2 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP3 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP4 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP5 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP6 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RP7 = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",
		MUSHA_RPICE = "뮤샤는 얌체를 사랑해!\n얌체는 뮤샤를 사랑해?\n기본값:(Z,V,B)",

        GHOSTHOUND = "가자 멍뭉아!",
        GHOSTHOUND2 = "이게 뮤샤의 멍뭉이 친구야!",
        SHADOWMUSHA = "뮤샤와 꼭 닮은 그림자야!",
        --item
        MUSHA_FLUTE = "뮤샤가 피리를 불면 얌체가 좋아해",
		MUSHASWORD_BASE = "뮤샤의 칼이야",
		MUSHASWORD = "불의 힘이여! 뮤샤의 부름을 들으라!",
		MUSHASWORD_FROST = "얼음의 힘이여! 뮤샤의 부름을 들으라!",
		FROSTHAMMER = "혹한의 힘이 적을 무찌를거야!",
		BROKEN_FROSTHAMMER =  "이 망치에서 바스러지는 소리가 들려",
		HAT_MPHOENIX = "뮤샤에겐 익숙한 투구야! 한번 써보고 싶었어!",
		HAT_MPRINCESS = "뮤샤가 썼던 티아라는 이것과 거의 비슷해",
		HAT_MBUNNY = "수색할 시간이네",
		ARMOR_MUSHAA = "이건 뮤샤 특제 가방이야",
		ARMOR_MUSHAB = "뮤샤는 안전을 위해 보호대를 몇 개 덧댔어!",
		--WIP
		GLOWDUST ="단 맛이 나는 고운 가루야!",
		CRISTAL = "반짝이는 캔디같아!",
		EXP = "먹으면 힘이 강해진대!",

		--EXP1000CHEAT = "Show me the money!", -- Starcraft

        BOOK_BIRDS = "이게 바로 온 세상의 새들의 말을 적은 책이야",
        BOOK_TENTACLES = "왕지렁이를 키우는 108가지 방법",
        BOOK_GARDENING = "이 책을 읽어주면 식물들이 좋아해",
        BOOK_SLEEP = "아주 지루한 책이야",
        BOOK_BRIMSTONE = "위험한 느낌이 드는 책이야",

		GLOMMER = "깜찍한 날개 좀 봐! 게다가 날기까지 해!",
        GLOMMERFLOWER =
        {
        	GENERIC = "거대한 꽃봉오리야! 근데 어떻게 핀 거지?",
        	DEAD = "꽃잎이 회색이 됐어!\n얼마 전까지만 해도 빨갰는데!",
        },
        GLOMMERWINGS = "엄청 작아!",
        GLOMMERFUEL = "이 몽글몽글한 분홍색 좀 봐!\n먹으면 안돼? 왜?",
        BELL = "디너벨이 왜 여기있지?\n누가 뮤샤에게 식사를 가져다주는건데?",
        STATUEGLOMMER =
        {
        	GENERIC = "뮤샤 이거 알아! 음, 뭐였지?",
        	EMPTY = "뮤샤는 여기에 꽃이 핀 것을 본 적이 있어",
    	},
		WEBBERSKULL = "이 해골에는 긴 사연이 있어",
		MOLE =
		{
			HELD = "이것 좀 봐! 코가 재미있게 생겼어!",
			UNDERGROUND = "뭔가 땅 속에 숨어있나봐!\n쫒아가보자!",
			ABOVEGROUND = "이 녀석이 뮤샤의 아이템을 훔쳐갔어!",
		},
		MOLEHILL = "수상한 무더기야. 뮤샤의 코는 속일 수 없어",
		MOLEHAT = "이 모자에서 이상한 냄새가 나는거 같지 않아?",
		NIGHTSTICK = "이것은 밤에 유용한 반짝이 막대야!",
		
--adds 6 start
	MUSHROOMHAT = "뮤샤의 머리가 버섯이 되어버리진 않을까?",
        MUSHROOM_LIGHT2 =
        {
			ON = "뮤샤는 이런 환상적인 불빛이 나올줄 몰랐어!",
            OFF = "뮤샤는 이런 멋진 디자인의 등불이 있는줄 몰랐어!",
            BURNT = "아무리 멋져도 불타면 아무것도 남지 않네",
        },
        MUSHROOM_LIGHT =
        {
			ON = "뮤샤는 이런 환상적인 불빛이 나올줄 몰랐어!",
            OFF = "뮤샤는 이런 멋진 디자인의 등불이 있는줄 몰랐어!",
            BURNT = "아무리 멋져도 불타면 아무것도 남지 않네",
        },
        SLEEPBOMB = "열면 안돼! 영원히 잠에 들어버릴거야",
        MUSHROOMBOMB = "가까이 가면 위험해. 저건 쉽게 터져버려",
        SHROOM_SKIN = "동물에서 떼낸 식물이야!",
        TOADSTOOL_CAP =
        {
            EMPTY = "뮤샤는 알아. 이거 지하로 갈수있는거지?",
            INGROUND = "이만한 크기면 밖으로 나왔을 때 정말 커다랄거야",
            GENERIC = "맨손으론 무리고 커다란 도끼가 필요할거야",
        },
        TOADSTOOL =
        {
            GENERIC = "개구리야! 눈이 3개인 사냥감이야!",
            RAGE = "폴짝폴짝 뛰기 시작했어!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "이게 있으면 공기가 탁해져! 뮤샤의 코가 아파!",
            BURNT = "태우기라도 하니 공기가 좀 나아!",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "이 커다란 파란 버섯나무는 키가 아주 크네",
            BLOOM = "이 버섯나무는 열매가 열리는게 아니라 가루가 날려!",
        },
        MUSHTREE_MEDIUM =
        {
			GENERIC = "빨간색의 쌍둥이 버섯나무야",
            BLOOM = "버섯이 웃고있는 것 같아!",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "커다란 녹색우산 같은 버섯나무야",
            BLOOM = "바람에 뒤집어진 우산같아!",
        },
        MUSHTREE_TALL_WEBBED = "거미는 뮤샤가 잡아버릴거야!",
        SPORE_TALL =
        {
            GENERIC = "파란색 버섯 가루가 빛나고있어",
            HELD = "반짝반짝이는 파란 버섯 가루지만 먹을 순 없어",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "빨간색 버섯 가루가 빛나고있어",
            HELD = "반짝반짝이는 빨간 버섯 가루지만 먹을 순 없어",
        },
        SPORE_SMALL =
        {
            GENERIC = "초록색 버섯 가루가 빛나고있어",
            HELD = "반짝반짝이는 초록 버섯 가루지만 먹을 순 없어",
        },
		
		BEEQUEEN = "혼자서 덤비라구 비겁한 벌!",
		BEEQUEENHIVE = 
		{
			GENERIC = "이 벌통에는 꿀이 어마어마하게 있을 것 같아",
			GROWING = "이 벌집은 지금 손 대면 안될 것 같아",
		},
        BEEQUEENHIVEGROWN = "이만큼 큰 벌집이면 꿀이 엄청 많을거야!",
        BEEGUARD = "이 벌들 정말 방해돼!",
        HIVEHAT = "누군가가 뮤샤에게 이런 말을 하는 것 같아 \"마이 프레셔스\"",
        MINISIGN =
        {
            GENERIC = "글자 대신 그림을 그려놓은건 좋은 생각이야!",
            UNDRAWN = "팻말은 있는데 내용이 없네",
        },
        MINISIGN_ITEM = "누가 와도 쉽게 알아볼 수 있을거야",
		
		BERRYBUSH_JUICY =
		{
			BARREN = "열매를 말리는건 좋은 생각같은데 나무는 아니야",
			WITHERED = "맛이 간거같아. 열매 말고 나무가.",
			GENERIC = "신선한 열매가 열려있어!",
			PICKED = "언제쯤 열매가 다시 열리는걸까?",
			DISEASED = "풀이 병들어버렸어",
			DISEASING = "상태가 이상해보이는걸",
			BURNING = "물기가 많은 풀이어도 불은 붙는구나",
		},
		
		CANARY =
		{
			GENERIC = "가슴털이 복실한 노란 새야",
			HELD = "작은 새이지만 무언가 다른 일에 쓸 수도 있을 것 같아",
		},
        CANARY_POISONED = "살아있는 새가 살아있는 맛이 간 새가 되어버렸어",

		CRITTERLAB = "무언가 저 안에 있어!",
        CRITTER_GLOMLING = "작고 귀여운 동물이 더 작고 귀여워졌어!",
        CRITTER_DRAGONLING = "뮤샤가 구워질 것 같지만 귀여우니까 괜찮아!",
		CRITTER_LAMB = "좀 털이 많고, 지저분해보이지만 단단하고, 귀여워!",
        CRITTER_PUPPY = "솟은 코가 위험을 맡고, 목소린 크고, 귀여워!",
        CRITTER_KITTEN = "큰 귀는 위험을 듣고, 발톱은 날카롭고, 귀여워!",
        CRITTER_PERDLING = "뾰족뾰족한 털에 큰 눈망울은 정말 완벽해!",
		
		LAVA_POND = "뮤샤는 이 빨간 물이 식으면 검정돌이 된다는걸 알아. 그럼 이건 돌물이네!",
		LAVAE = "뮤샤는 저 쫒아오는 불덩이들이 싫어! 더우니까!",
		LAVAE_COCOON = "불꽃처럼 살다가 차갑게 식어버렸어. 뮤샤 멋진 말 한걸지도",
		LAVAE_PET = 
		{
			STARVING = "불꽃을 키우려면 나무를 줄텐데 얘는 어떻하지?",
			HUNGRY = "뭔가 크기가 작아진거 아닐까?",
			CONTENT = "몽글몽글 말랑말랑해보여도 사실은 따끈따끈해",
			GENERIC = "꿈틀꿈틀 거리는게 재미있어!",
		},
		LAVAE_EGG = 
		{
			GENERIC = "이게 알은 아니지만 이 안쪽에 무언가 있다는건 알아",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "불덩이였으니까 태어날려면 더 뜨거워야해",
			COMFY = "안에 있던 무언가가 밖으로 나오려고 하고있어!",
		},
		LAVAE_TOOTH = "돌껍질? 파편? 얇은 돌?",
		
		ENDTABLE = 
		{
			BURNT = "타면 가짜야! 확인은 했지만 못쓰게 되어버렸네",
			GENERIC = "이 테이블 밑에 깜깜한 녀석이 있을까?",
			EMPTY = "뭔가 장식하면 좋지 않을까?",
			WILTED = "영원히 파릇하지는 않아. 평범한거는 말야",
			FRESHLIGHT = "이 신선한 향기와 빛이 좋은거야",
			OLDLIGHT = "색이 바랜것도 뮤샤는 좋아하지만 그래도 처음의 하얀빛이 좋아", -- will be wilted soon, light radius will be very small at this point
		},
		
		TWIGGYTREE = 
		{
			BURNING = "생긴게 달라도 타버리면 결국 다 이렇게 되어버려",
			BURNT = "이렇게 바짝 마른 나무니까 더 불이 잘 붙는거야!",
			CHOPPED = "잔가지 정도면 금방 다시 자라지만 베어버리면 이거 밖에 남지 않아",
			GENERIC = "가지가 무성한 나무야. 바람소리가 들리니?",
			DISEASED = "잎이 적어서 병에 걸린걸까 아니면 잎이 적어서 병에 잘 안걸린걸까?",
		},
		TWIGGY_NUT_SAPLING = "\"병충해에 강하고 척박한 땅에서도 잘 자랍니다.\" 라고해",
        TWIGGY_OLD = "나무 껍질이 두꺼워진것 같지만 금방 털어내고 새로 자랄거야",
		TWIGGY_NUT = "이 나무에도 열매는 재대로 열리는거야",
		
		FLOWER_WITHERED = "꽃이 병들어버렸어! 추웠던걸까? 어두웠던걸까?",
		
		FOSSIL_PIECE = "뼈가 너무 오랫동안 땅속에 있어서 돌처럼 되어버린거야",
        FOSSIL_STALKER =
        {
			GENERIC = "나쁘지는 않지만 그렇다고 뭔지도 모르겠네",
			FUNNY = "뮤샤는 이게 원래 뭐였는지는 모르지만\n수수께끼를 푸는 것 같아서 재미있어!",
			COMPLETE = "턱이라던지 몇개는 모자르지만 이거면 뮤샤도 만족해",
        },
        STALKER = "소라고 하기엔 머리가 이상하고 뿔도 이상하고 다 이상해",
        STALKER_ATRIUM = "소라고 하기엔 머리가 이상하고 뿔도 이상하고 다 이상해",
        STALKER_MINION = "소라고 하기엔 머리가 이상하고 뿔도 이상하고 다 이상해",
        THURIBLE = "죽은이들의 소리가 들려. 선명하게",
        ATRIUM_OVERGROWTH = "무언가가 끌려들어가고, 나오는걸 반복 하고있어",
		
		LUCY = "날이 무디어지지 않는 도끼라니, 이거야 말로 마법이야!",
		
		MINIFAN = "이걸 들고 달리면 시원한 기분이 들어. 정말 기분뿐이지만.",
		
		OASISLAKE = "여러가지가 비치는 물 웅덩이야",
		
		PINECONE_SAPLING = "나무는 이 세상을 무서워하지도 않고 마구 자라",
        LUMPY_SAPLING = "뮤샤는 나무가 포기하지 않고 자라는것을 보면서 희망을 키워",
		
--adds 6 end
		
		RABBITHOUSE=
		{
			GENERIC = "토끼괴인이 사는 집이야",
			BURNT = "토끼라서 불에는 익숙하지 않았나봐",
		},
		TURF_DECIDUOUS = "썩은잎이 가득한 무더기야",
		TURF_SANDY = "건조한 모래가 가득한 무더기야",
		TURF_BADLANDS = "딱딱한 무더기야!",
		BEARGER = "뮤샤도 꿀을 먹으면 키가 커질까?",
		BEARGERVEST = "복실복실한 옷이야",
		ICEPACK = "휴대용 냉장고야",
		BEARGER_FUR = "이 털가죽이 있으면 뮤샤가 새로운 것을 만들 수 있어",
		FURTUFT = "콜록! 뮤샤 입에 털뭉치가 들어갔어!",
		BIGFOOT = "어마어마하게 커다란 발자국이야!",
		BONESHARD = "뼈 무더기도 쓸데가 있어",
		BUZZARD = "얘 말고도 하늘에 엄청 많이 있어",
		CACTUS =
		{
			GENERIC = "왜 이 식물엔 이렇게 가시가 많을까?\n먹을 수도 없는데",
			PICKED = "가시가 많았지만 결국은 채집했어",
		},
		CACTUS_MEAT_COOKED = "조금 질겨진거 같아",
		CACTUS_MEAT = "가시가 없으면 괜찮아. 아마도",
		CACTUS_FLOWER = "이 삐죽한 식물에는 이쁜 꽃이 피어나네",
		COLDFIRE =
		{
			EMBERS = "뭔가 넣어볼까?",
			GENERIC = "이 파란 불꽃은 요리를 할 수 없어",
			HIGH = "엄청난 불꽃인데 차가워!",
			LOW = "차가운 불꽃이 사그러져가",
			NORMAL = "파란 불꽃은 엄청 뜨겁다고 들었는데 실제로는 차갑네",
			OUT = "불꽃이 사그러졌어",
		},
		CATCOON = "이 신경질적인 냐옹이는 남을게 없어보여",
		CATCOONDEN =
		{
			GENERIC = "냐옹이의 집은 냐옹이보다 중요할까?",
			EMPTY = "아무도 살지 않는 집은 뮤샤의 흥미를 끌 수 없어",
		},
		CATCOONHAT = "도끼를 들어야 할 것 같은 느낌이야",
		COONTAIL = "냐옹이에게서 건진 유일한 아이템이야",
		COOKPOT =
		{
			COOKING_LONG = "이렇게 오래 걸리는게 맞는거야?",
			COOKING_SHORT = "만들어봐요♬ 만들어봐요♬\n어디어디 무엇이 만들어질까♬",
			DONE = "요리가 완성됐어!",
			EMPTY = "이제 아무도 사용하지 않나봐.\n드디어 뮤샤의 실력을 발휘할 때야",
			BURNT = "왜 아무도 신경쓰지 않은겨야?",
		},
		EYEBRELLAHAT =	"비도 막아주고, 열도 막아주고,\n눈도 막아주는데, 무겁네.",
		ARMORDRAGONFLY = "살짝만 대어봐도 데어버릴 것 같아",
		DRAGON_SCALES = "멋져! 그리고 화끈해!",
		DRAGONFLYCHEST = "불보다 더 화끈한 상자야!",
		DECIDUOUSTREE =
		{
			BURNING = "탄다!!",
			BURNT = "타버렸네",
			CHOPPED = "여기에 앉아서 쉬면 편할 것 같아",
			GENERIC = "나무야",
			POISON = "왕!왕왕!",
		},
		ACORN_COOKED = "냄새가 좋아!",
		BIRCHNUTDRAKE = "창 말고, 도끼로 찍어버려야해!",
		FARMPLOT =
		{
			GENERIC = "씨앗을 심기위해 땅을 골라봤어",
			GROWING = "빨리빨리 자라라",
			NEEDSFERTILIZER = "비료를 가져와야겠어",
			BURNT = "익어버리기도 전에 타버렸네",
		},
		COLDFIREPIT =
		{
			EMBERS = "뭔가 넣어볼까?",
			GENERIC = "이 파란 불꽃은 요리를 할 수 없어",
			HIGH = "엄청난 불꽃인데 차가워!",
			LOW = "차가운 불꽃이 사그러져가",
			NORMAL = "파란 불꽃은 엄청 뜨겁다고 들었는데 실제로는 차갑네",
			OUT = "불꽃이 사그러졌어",
		},
		FIRESUPPRESSOR =
		{
			ON = "불이 나지 않게 하려면 태울게 많이 필요해",
			OFF = "아껴서 사용할 수 있다면 재료를 절약할 수 있을거야",
			LOWFUEL = "넣은게 거의 바닥났어. 어서 보충해야해",
		},
		ICEHAT = "머리가 축축하긴 하지만 지금 시원한건 좋아",
		LIGHTNINGGOAT =
		{
			GENERIC = "베베꼬인 뿔을 가진 염소야",
			CHARGED = "찌릿한 염소야! 근데 뮤샤에게 착할 것 같진 않아",
		},
		LIGHTNINGGOATHORN = "기가 드릴 브-\n웅? 안된다구? 왜?",
		GOATMILK = "염소젖이야!",
		MEATRACK =
		{
			DONE = "언제 회수하는거야? 이미 바싹 마른 것 같은데",
			DRYING = "뮤샤는 고기를 더욱 맛있게 만들고 있어",
			DRYINGINRAIN = "말리다 젖고 다시 마른 고기는 맛이 괜찮을까?",
			GENERIC = "뮤샤는 이것으로 육포를 만들거야. 육포는 맛있어.",
			BURNT = "뮤샤는 고기를 말리려고 했지 나무를 태울 생각은 없었어",
		},
		MERMHEAD =
		{
			GENERIC = "물고기괴인을 싫어하는게 뮤샤뿐만은 아닌것 같아",
			BURNT = "얘는 두번 죽었네",
		},
		MERMHOUSE =
		{
			GENERIC = "늪지에서 사는 괴물이 사는 집이야",
			BURNT = "늪에서 살아서 불에는 익숙하지 않았나봐",
		},
		FLOWERSALAD = "꽃잎을 요리하면 맛있어져",
        ICECREAM = "엄청 희귀한 요리야! 맛있을것 같아!",
        WATERMELONICLE = "과일하고 얼음하고 같이 먹는건 멋진 생각인것 같아!",
        TRAILMIX = "모든것은 먹을 수 있어. 돌죽도 있는걸",
        HOTCHILI = "화끈한 음식이야",
        GUACAMOLE = "먹을 수 있는것과 먹을 수 있는것을 섞었어",
		MOOSE = "저 오리는 나무도 한 입에 먹을 것 같아",
		MOOSEEGG = "그 새는 이 알을 어떻게 낳은거지?",
		MOSSLING = "뮤샤보다 커다란 병아리야",
		FEATHERFAN = "이 부채는 왜 이렇게 큰거지?",
		GOOSE_FEATHER = "이 깃털은 깃털펜으로 만들기엔 너무 큰거 같은데",
		STAFF_TORNADO = "바람이 분다 바람이 불어",
		PIGHEAD =
		{
			GENERIC = "뭘 하고 싶어서 이런걸 만든걸까?",
			BURNT = "먹을려고 구운건 아닐텐데",
		},
		PIGHOUSE =
		{
			FULL = "여보세요? 뮤샤를 잠깐만 도와줬으면 하는데",
			GENERIC = "돼지괴인들은 뮤샤를 도와줘. 가끔은 아니지만",
			LIGHTSOUT = "아, 비었나보네",
			BURNT = "이 집에 무슨 일이 벌어진거지?",
		},
		FERTILIZER = "똥통! 아니, 비료통!",
		RAINOMETER =
		{
			GENERIC = "비가 올 확률은 Soon™ 입니다",
			BURNT = "비가 올 확률은 N/A 입니- 어?",
		},
		RAINCOAT = "이제 젖을 걱정이 없을거야 그치?",
		RAINHAT = "뮤샤는 물을 마시는건 좋아하지만\n머리에 붓는게 마시는건 아니잖아",
		RESEARCHLAB =
		{
			GENERIC = "생존기술을 배울 수 있는 기계라고 해",
			BURNT = "선생님이 타버린거야?",
		},
		RESEARCHLAB2 =
		{
			GENERIC = "이 세계의 모든 지식의 정수가 담겨있-\n지 않네. 몇갠 없어.",
			BURNT = "타버린 책은 아무것도 읽을 수 없잖아\n이것도 마찬가지야",
		},
		RESEARCHLAB3 =
		{
			GENERIC = "뮤샤가 마법을 부릴 수 있게 해줘. 기적이던가.",
			BURNT = "마법도 기적도 불 앞에서는 손을 쓸 수 없었어",
		},
		RESEARCHLAB4 =
		{
			GENERIC = "결론이 나왔어. 모자와 토끼. 이건 마법이야!",
			BURNT = "마법도 불 앞에서는 손을 쓸 수 없었어",
		},
		RESURRECTIONSTATUE =
		{
			GENERIC = "이거 낮이 익어. 윌슨?",
			BURNT = "불타버린 윌슨이야. 뼈도 안남았다구",
		},
	--adds 1 start
		CAVEIN_BOULDER =
        {
            GENERIC = "이건 어디서 생겨서 여기에 있는거야? 신기하네",
            RAISED = "뭔가 알수없게 되어버렸어",
        },
        ROCK = "잔뜩잔뜩 캐버리는거야. 많이 많이 필요하니까",
        PETRIFIED_TREE = "나무가 왜 돌이 되어버렸을까? 저주?",
        ROCK_PETRIFIED_TREE = "나무가 왜 돌이 되어버렸을까? 저주?",
        ROCK_PETRIFIED_TREE_OLD = "나무가 왜 돌이 되어버렸을까? 저주?",
	--adds 1 end
		ROCK_ICE =
		{
			GENERIC = "얼음이 하늘로 쭉쭉 자라나는거야",
			MELTED = "지금은 이래도 금방 쭉쭉 자랄거야",
		},
		ROCK_ICE_MELTED = "얼음이 하늘로 자라기엔 너무 더운 날씨야",
		ICE = "차가워",
        REFLECTIVEVEST = "뮤샤도 언젠가 헤엄칠 수 있을까?",
		HAWAIIANSHIRT = "알록달록한 옷이야!",
		TENT =
		{
			GENERIC = "텐트에선 밤에 어둠을 피할 수 있어",
			BURNT = "타버린 텐트는 밤에 뮤샤를 지켜주지 않아",
		},
		SIESTAHUT =
		{
			GENERIC = "너무 더울땐 여기서 쉬는 것도 좋아",
			BURNT = "너무 더워서 타버렸나봐",
		},
		TRANSISTOR = "이거야말로 마법이야!",
		TREASURECHEST =
		{
			GENERIC = "뮤샤에겐 많은게 필요하고,\n여기엔 그중에 몇몇개가 들어있어",
			BURNT = "모두 다 타버렸어!",
		},
		TUMBLEWEED = "멈춰! 그만 좀 굴러가!",
		GRASS_UMBRELLA = "파릇파릇한 우산으로 비를 막을거야",
		UNIMPLEMENTED = "재대로 작동을 하는거야?",
		WALL_HAY =
		{
			GENERIC = "간단히 만들수는 있어도 임시니까 조심해야해. 불도 조심해야해",
			BURNT = "뮤샤가 얘기했잖아, 불을 조심해야한다니까",
		},
		WALL_WOOD =
		{
			GENERIC = "볏단보단 낫지만 그래도 불에 조심해야해",
			BURNT = "(한숨) 그래도 뮤샤는 다시 보강해야해",
		},
		WARG = "이것 봐! 이게 검은 늑대들의 우두머리인가봐!",
		WATERMELON = "이 커다랗고 줄무늬있는 열매는 물이 가득해",
		WATERMELON_COOKED = "따끈하고 달콤한 물이 준비됐어",
		WATERMELONHAT = "열매 껍질로 모자를 만들 수 있어, 이것봐",
		WINTEROMETER =
		{
			GENERIC = "내일의 날씨는 SOON™ 입니다",
			BURNT = "화재 경보 기능은 없었나봐",
		},
		HOMESIGN =
		{
			GENERIC = "여기에 뭔갈 적어보자",
			BURNT = "표지판이면 이대로도 괜찮은거 아닐까?",
		},
		BEEBOX =
		{
			READY = "이걸봐! 벌이 안에 잔뜩 들어있어!",
			FULLHONEY = "상자에 꿀이 가득해!",
			GENERIC = "벌들이 사방에서 꿀을 모아올거야",
			NOHONEY = "뮤샤는 꿀을 기다릴거야",
			SOMEHONEY = "좋아, 꿀이 잘 모이고 있어",
			BURNT = "꿀을 상자째로 구워버리는건 좋은 생각이 아니야",
		},
		LIVINGTREE = "이 나무는 살아있는것같아. 특히 얼굴이 말이야",
		ICESTAFF = "파란색으로 빛나는 마법의 지팡이야",
		WORMLIGHT = "밤에 반짝이는 열매야! 먹으면 어떻게 될까?",
		WORM =
		{
		    PLANT = "밤에 반짝이는 열매야! 근데 이게 무슨 냄새지?",
		    DIRT = "땅속에 뭔가 움직이고있어!",
		    WORM = "엄청나게 커다란 지렁이야!",
		},
		EEL = "길고 이상하게 생긴 물고기야",
		EEL_COOKED = "고소한 냄새하고, 이건 무슨 냄새지?",
		UNAGI = "솥에 재료를 넣고 흔들었는데 우나기가 완성되었어!",
		EYETURRET = "이 돌탑이 모든걸 쏴버릴거야",
		EYETURRET_ITEM = "이건 쉽게 구할 수 있는게 아니니까 신중하게 지어야해",
		MINOTAURHORN = "이게 바로 뮤샤가 위대한 모험을 해냈다는 증거야",
		MINOTAURCHEST = "이 커다란 보물상자에는 무엇이 들어있을까?",
		THULECITE_PIECES = "흔하지 않은 재료지만\n뮤샤는 이걸로 무엇을 만들 수 있는지 알고있어",
		POND = "낚시를 하자!",
		POND_ALGAE = "뭔가 이상한게 물속에서 헤엄치고있어",
		GREENSTAFF = "뭐든지 분해할 수 있는 지팡이야\n살아있는 것에는 쓰면 안돼",
		POTTEDFERN = "뭔가에 써먹을 수는 없겠지만 그래도 좋아",

		THULECITE = "뭔가 의미가 있는것 같은 문양이야",
		ARMORRUINS = "확실히 단단할것 같지만 매우 무거워",
		RUINS_BAT = "뮤샤가 알고있는 돌망치 가운데는 가장 단단해",
		RUINSHAT = "이걸 쓰면 뮤샤도 훌륭한 뮤샤가 될까?",
		NIGHTMARE_TIMEPIECE = --Keeps track of the nightmare cycle
		{
		CALM = "아무것도 없고, 아무 문제도 없어",	--Calm phase
		WARN = "조금 더워진거 같아",	--Before nightmare
		WAXING = "뮤샤의 생각이지만 여긴 더 이상 안전하지 않은 것 같아", --Nightmare Phase first 33%
		STEADY = "이 이상은 나빠지지 않을 줄 알았는데!", --Nightmare 33% - 66%
		WANING = "여긴 지금 엄청나게 위험해!", --Nightmare 66% +
		DAWN = "조금만 더 버티면 될것같아!", --After nightmare
		NOMAGIC = "이런 평화로운 날도 있어야지", --Place with no nightmare cycle.
		},
		BISHOP_NIGHTMARE = "이 기계들은 왜 뮤샤를 쏘는거야?",
		ROOK_NIGHTMARE = "머리도, 다리도, 눈도 고장났지만 아직 달리고 있어",
		KNIGHT_NIGHTMARE = "말머리 기계는 박치기를 조심해야해",
		MINOTAUR = "위험해 보이지만 뮤샤는 이길 수 있어",	--Monster in labyrinth
		SPIDER_DROPPER = "하얀 거미는 동굴 위쪽에서 살고있어",	--White spider that comes from the roof
		NIGHTMARELIGHT = "이 불이 켜져있는건 좋은 징조는 아니야",	--Lights that activate during nightmare.
		GREENGEM = "녹색 보석은 흔히 볼 수 있는게 아니야",
		RELIC = "이제 작동할거야!",	--Fixed relic
		RUINS_RUBBLE = "뭔가 부품이 비어있어",	--Broken relic
		MULTITOOL_AXE_PICKAXE = "도끼로도 쓸 수 있고 곡괭이로도 쓸 수 있어!",	--Works as axe and pickaxe
		ORANGESTAFF = "뿅 뿅 하면서 움직일 수 있어!",	--Teleports player.
		YELLOWAMULET = "빨라져!",	--Emits light, player walks faster.
		GREENAMULET = "반값 세일!",	--Reduce cost of crafting

		SLURPER = "검정색 팩맨!",
		SLURPER_PELT = "이것봐! 아직도 살아있는것 처럼 꿈틀거려!",
		ARMORSLURPER = "이 벨트는 배를 너무 꽉 조여",
		ORANGEAMULET = "아이템을 쉽게 주을 수 있는 정도의 능력",
		YELLOWSTAFF = "빛을 만드는 마법의 지팡이!", 
		YELLOWGEM = "노란색 보석은 반짝반짝해!",
		ORANGEGEM = "주황색 보석은 시간하고 공간을 움직인다는 이야기가 있어",
		TELEBASE =
		{
			VALID = "하늘이 아니라 땅이 움직이는 것 같아",
			GEMS = "이제 작동하려나?",
		},
		GEMSOCKET =
		{
			VALID = "뮤샤는 여기에 보라색 보석이 필요하다고 느껴",
			GEMS = "뮤샤의 모험이 더 넓어질거야",
		},
		STAFFLIGHT = "대... 대단해!",

        LIGHTER = "이 작은 물건이 불을 붙일 수 있대",


        ANCIENT_ALTAR =
        {
        	WORKING = "이것도 뮤샤와 관련이 있는걸까?",
        	BROKEN = "재대로 움직이게 하려면 뭔가 더 필요할 것 같아",
        },
        ANCIENT_ALTAR_BROKEN = "재대로 움직이게 하려면 뭔가 더 필요할 것 같아",

        ANCIENT_STATUE = "이것도 뮤샤와 관련이 있는걸까?",

        LICHEN = "돌덩이?",
		CUTLICHEN = "뭔가 썩은냄새가 나",

        CAVE_BANANA = "동굴 속에서 이런 샛노란 과일을 발견했어",
        CAVE_BANANA_COOKED = "익히면 좀 더 달아?",
        CAVE_BANANA_TREE = "빛이 없는데 어떻게 자라는걸까?",
        ROCKY = "커다래!",

        BLUEAMULET = "차가운 목걸이야",
		PURPLEAMULET = "뮤샤는 죽은자가 보여",
		TELESTAFF = "뿅! 뿅! 뿅!",
		MINERHAT = "뮤샤는 광부는 아니지만, 동굴 속에서 이 모자는 유용해",
		MONKEY = "저 녀석이 뮤샤의 아이템을 훔쳐갔어",
		MONKEYBARREL = "저 속에 희귀한 아이템이 숨겨져 있을 지도 몰라",

		HOUNDSTOOTH="저 뼈 무더기에서 사는건 불편해보여",
		ARMORSNURTLESHELL="투구가 더 낫겠지만 이건 이것대로 좋아",
		BAT="나쁜 박쥐!",
		BATBAT = "뮤샤의 사냥감으로 뮤샤의 사냥감을 잡는거야",
		BATWING="이걸로 뮤샤는 여러가지를 해볼 수 있을 것 같아",
		BATWING_COOKED="바삭바삭해",
		BEDROLL_FURRY="이제 편하게 잘 수 있겠어",
		BUNNYMAN="조심해야해, 쟤들은 고기 냄새를 싫어해",
		FLOWER_CAVE="햇살 대신 동굴에서 중요한 빛이야",
		FLOWER_CAVE_DOUBLE="햇살 대신 동굴에서 중요한 빛이야",
		FLOWER_CAVE_TRIPLE="햇살 대신 동굴에서 중요한 빛이야",
		GUANO="뭘 먹었길래 이렇게 나오는거야?",
		LANTERN="손에 들고있어도 빛이 나오고 손에 떼고있어도 빛이 나와!",
		LIGHTBULB="빛나는 열매야!",
		MANRABBIT_TAIL="주먹만한 털뭉치야!",
		MUSHTREE_TALL="파란 버섯나무야",
		MUSHTREE_MEDIUM="빨간 버섯나무야",
		MUSHTREE_SMALL="녹색 버섯나무야",
		SLURTLE="이 단단한 껍질을 짊어지고 다니기엔 너무 작은거 아닐까?",
		SLURTLE_SHELLPIECES="열번찍으면 부셔지네",
		SLURTLEHAT="이 모자 나쁘지 않아!",
		SLURTLEHOLE="커다란 선인장같아",
		SLURTLESLIME="뮤샤는 알아. 먹으면 안되는거지?",
		SNURTLE="갑옷을 입고 있는 것 같아",
		SPIDER_HIDER="저 거미는 이상한 모자를 쓰고 있어",
		SPIDER_SPITTER="저 거미는 거미줄 뭉치를 쏘니까 조심해야해!",
		SPIDERHOLE="저기 거미집이 보여?",
		STALAGMITE="돌이 하늘로 자라고 있었나봐",
		STALAGMITE_FULL="돌이 나무처럼 크게크게 자랐어! 그리고 안쪽이 뭔가 있어!",
		STALAGMITE_LOW="이 돌은 쓸만할 것 같아",
		STALAGMITE_MED="돌이 하늘로 자라는 것 같아.\n잠깐, 뮤샤 전에도 이 말 한 것 같아.",
		STALAGMITE_TALL="돌이 하늘로 자라고 있었나봐",
		STALAGMITE_TALL_FULL="돌이 나무처럼 크게크게 자랐어! 그리고 안쪽이 뭔가 있어!",
		STALAGMITE_TALL_LOW="이 돌은 쓸만할 것 같아",
		STALAGMITE_TALL_MED="돌이 하늘로 자라는 것 같아.\n잠깐, 뮤샤 전에도 이 말 한 것 같아.",

		TURF_CARPETFLOOR = "푹신푹신해",
		TURF_CHECKERFLOOR = "알록달록하고 푹신푹신해",
		TURF_DIRT = "흙무더기야",
		TURF_FOREST = "이끼가 굉장히 많아",
		TURF_GRASS = "푸른 초원의 기분을 낼 수 있어",
		TURF_MARSH = "나뭇잎이 많아!",
		TURF_ROAD = "바닥이 딱딱하면 뮤샤는 더 빠르게 달릴 수 있어",
		TURF_ROCKY = "돌바닥은 쓸모가 있어",
		TURF_SAVANNA = "이거 무슨 냄새나지 않아? 비팔로의-",
		TURF_WOODFLOOR = "뮤샤는 삐걱거리는 소리도 좋아해",

		TURF_CAVE="흰색 바닥",
		TURF_FUNGUS="얼룩덜룩한게 사방에 퍼져있어",
		TURF_SINKHOLE="녹색 얼룩이 보여",
		TURF_UNDERROCK="이 돌은 못쓸거같은데",
		TURF_MUD="이 진흙 어떻게 사용할 수 없을까?",

		TURKEYDINNER = "칠면조 요리야!",
		TWIGS = "나뭇가지는 항상 많은게 좋아.\n여러군데 쓸 수 있으니까",
		POWCAKE = "MSG!",
        CAVE_ENTRANCE =
        {
            GENERIC="이 돌덩이는 마개같아. 뭘 막아놓은거지?",
            OPEN = "이 아래엔 뭐가 있을까?",
        },
        CAVE_EXIT = "지상으로 나가는 로프야!",

		MAXWELLPHONOGRAPH = "이런 취미도 괜찮은것 같아",
		PIGGUARD = "뭔가를 지키고 있나봐",
		BOOMERANG = "상대를 멀리서 공격할 수 있는 무기야",
		ADVENTURE_PORTAL = "여기로 들어가면 어디로 나오는거야?",
		AMULET = "뭔가 힘이 느껴져! 아닌가?",
		ANIMAL_TRACK = "좋은 사냥을",
		ARMORGRASS = "쉽게 만들 수 있어. 없는 것 보단 나아",
		ARMORMARBLE = "무겁다는 것만 빼면 나쁜건 아닌데, 너무 무겁네",
		ARMORWOOD = "가장 오랫동안 사용되었던 보호구가 아닐까",
		ARMOR_SANITY = "살아있는 갑옷인가봐",
		ASH =
		{
			GENERIC = "바람이 불면 타버렸다는 흔적도 사라질거야",
			REMAINS_GLOMMERFLOWER = "되돌릴 수는 없어도 새로 찾을 수는 있을거야",
			REMAINS_EYE_BONE = "되돌릴 수는 없어도 새로 찾을 수는 있을거야",
			REMAINS_THINGIE = "되돌릴 수는 없어도 새로 찾을 수는 있을거야",
		},
		AXE = "나무로는 여러가지를 할 수 있어. 나무를 쓸려면 먼저 베어야해",
		BABYBEEFALO =
		{
			GENERIC = "아기는 귀엽다구",
			SLEEPING = "자고있는 아기는 귀엽다구",
		},
		BACKPACK = "가방은 모험하면서 재료를 모을땐 정말 유용해",
		BACONEGGS = "고기도 있고 후라이도 있다니 정말 좋아!",
		BANDAGE = "붕대 필요해?",
		BASALT = "이건 뮤샤의 힘만으로는 어떻게 할 수 없을 것 같아",
		BEARDHAIR = "털과 수염은 무슨 차이인거야?",
		BEDROLL_STRAW = "뮤샤는 보통 위에서 잠을 자",
		BEE =
		{
			GENERIC = "저 벌들은 일을 하고 있어",
			HELD = "부웅부웅부우우웅",
		},
		BEEFALO =
		{
			FOLLOWER = "얘는 뮤샤를 따라오고있어",
			GENERIC = "크고 묵직하고 더럽고 느려보여",
			NAKED = "다리가 이렇게 가늘 줄은 몰랐어!",
			SLEEPING = "아무데서나 자는거야?",
		},
		BEEFALOHAT = "뮤샤는 아무것이나 들이받을 준비가 되었어",
		BEEFALOWOOL = "이걸 덮으면 따뜻할 것 같아",
		BEEHIVE = "벌들은 여기에 꿀을 쌓아놓아. 뮤샤에게 나누어 줄것 같진 않지만",
		BEEMINE = "벌은 화나면 무서워. 지금 엄청 화나있거든?",
		BEEMINE_MAXWELL = "모기도 화나면 무서울거야. 벌만큼 찔러댈테니까",
		BEEHAT = "벌에게서 최소한 얼굴은 안전해!",
		BERRIES = "맛있는 열매야!",
		BERRIES_COOKED = "구우면 더 맛있는 열매야!",
		BERRYBUSH =
		{
			BARREN = "열매를 말리는건 좋은 생각같은데 나무는 아니야",
			WITHERED = "맛이 간거같아. 열매 말고 나무가.",
			GENERIC = "신선한 열매가 열려있어!",
			PICKED = "언제쯤 열매가 다시 열리는걸까?",
		},
		BIRDCAGE =
		{
			GENERIC = "새를 위한 집이 준비되었어",
			OCCUPIED = "이 새는 밖에서 밥을 먹을 수 없으니까 뮤샤가 밥을 줘야해",
			SLEEPING = "새가 자는 동안엔 이 집이 새를 지켜줄거야",
		},
		BIRDTRAP = "새를 산채로 잡는 방법 가운데 하나야",
		BIRD_EGG = "알이 끝없이 나와!",
		BIRD_EGG_COOKED = "알로 만들 수 있는 요리는 참 많아",
		BISHOP = "저건 뮤샤를 쏘니까 조심해야해",
		BLOWDART_FIRE = "이건 불이 붙으니까 조심해야해",
		BLOWDART_SLEEP = "이걸 맞으면 잠에 들거야",
		BLOWDART_PIPE = "이건 좀 따가울 거야",
		BLUEGEM = "차가운 보석이야",
		BLUEPRINT = "이걸 읽으면 뮤샤의 지식이 늘어날거야",
		BELL_BLUEPRINT = "누군가를 부르는 도구를 만드는 방법이야",
		BLUE_CAP = "먹으면 힘이 나는 버섯이야",
		BLUE_CAP_COOKED = "구워서 먹으면 머리가 맑아져",
		BLUE_MUSHROOM =
		{
			GENERIC = "밤하늘을 좋아하는 파란버섯이야",
			INGROUND = "밤이 온 다음에 다시 와봐야해",
			PICKED = "기둥만 봐서는 무슨 버섯인지 모르겠어",
		},
		BOARDS = "판자로 만들 수 있는건 정말 많아",
		BONESTEW = "두 유 노 곰탕?",
		BUGNET = "벌레를 다치지 않게 잡을려면 이게 제일 간단해",
		BUSHHAT = "기다리게 했군",
		BUTTER = "버터플라이 - 플라이 = 버터",
		BUTTERFLY =
		{
			GENERIC = "버터가 날면 버터플라이!",
			HELD = "나비는 먹는게 아니야 땅에 심는거야", --☺
		},
		BUTTERFLYMUFFIN = "버터머핀이라는게 나비가 꽃혀있는 머핀이었어?",
		BUTTERFLYWINGS = "나비 몸통이 없어졌어",
		CAMPFIRE =
		{
			EMBERS = "사용하고 싶으면 태울만한걸 넣어야해",
			GENERIC = "뮤샤에게 따뜻한 온기를 나눠줘",
			HIGH = "불꽃이 하늘로 치솟고있어!",
			LOW = "불꽃이 사그러들고있어. 새벽이 빨리 온다면 문제는 없을거야",
			NORMAL = "밝은 빛이야",
			OUT = "다시 불을 피워야하는게 아닐까?",
		},
		CANE = "뮤샤는 두발보다 세발로 뛰는걸 더 잘하나봐!",
		CARROT = "뮤샤는 당근도 먹을 수 있어",
		CARROT_COOKED = "이제 당근이 딱딱하지 않아!",
		CARROT_PLANTED = "당근으 심어놨어",
		CARROT_SEEDS = "당근 씨앗이야",
		CAVE_FERN = "동굴 안에서만 볼 수 있는 보랏빛 잎이야",
		CHARCOAL = "한번 탄 나무는 또 탈 수 있어",
        CHESSJUNK1 = "부서진 잔해들이 널려있어",
        CHESSJUNK2 = "부서진 잔해들이 널려있어",
        CHESSJUNK3 = "부서진 잔해들이 널려있어",
		CHESTER = "복실복실해!",
		CHESTER_EYEBONE =
		{
			GENERIC = "뼈 위에 눈이 있을 뿐인데 어떻게 움직이는거지?",
			WAITING = "X를 눌러 조의를 표하시오? X는 뭐지?",
		},
		COOKEDMEAT = "뮤샤는 날것보다 조리한 쪽이 더 좋아",
		COOKEDMONSTERMEAT = "조리를 해도 극복할 수 없는 냄새야",
		COOKEDSMALLMEAT = "고기에는 뭘 넣어도 고기요리가 되어버려",
		CORN = "가루를 내어도 되고 삶아도 되고 구워도 되고 튀겨도 돼!",
		CORN_COOKED = "냄새가 좋아!",
		CORN_SEEDS = "옥수수 씨앗이야",
		CROW =
		{
			GENERIC = "새는 모두 알을 낳아. 검정색 새도 알을 낳아.",
			HELD = "뮤샤가 새를 잡았어! 산채로!",
		},
		CUTGRASS = "풀은 정말 다용도야",
		CUTREEDS = "갈대로 종이를 만들 수 있어!",
		CUTSTONE = "이 돌로 뭘 만들어볼까?",
		DEADLYFEAST = "먹으면 안돼!",
		DEERCLOPS = "어떻게 눈이 하나일 수 있지? 왜 저렇게 큰거지?",
		DEERCLOPS_EYEBALL = "하나만 있던거라면 훌륭한 전리품이야",
		DIRTPILE = "뮤샤가 발자국을 찾았어!",
		DIVININGROD =
		{
			COLD = "이게 무슨 소리지? 벌이 있는거야?",
			GENERIC = "이게 진짜 출구를 찾아주는걸까?",
			HOT = "뭔가 있는것 같아! 최소한 얘는 그렇게 말하고 있어!",
			WARM = "뭔가 느껴져. 진동이",
			WARMER = "뭔가 점점 가까워지는 모양이야. 뮤샤는 잘 모르겠지만",
		},
		DIVININGRODBASE =
		{
			GENERIC = "뭔가 꽃혀있어!",
			READY = "이제 이것은 뮤샤것입니다. 뮤샤가 마음대로 할 수 있는 것 입니다",
			UNLOCKED = "쓸모가 있을거야. 없을지도 모르지만",
		},
		DIVININGRODSTART = "이게 뮤샤를 도와줄거야",
		DRAGONFLY = "잠자리가 아니라 정말로 용-파리잖아!",
		LAVASPIT =
		{
			HOT = "정말 뜨거워!",
			COOL = "이것도 얼긴 하는구나",
		},
		DRAGONFRUIT = "뮤샤는 이것이 괜찮다고 생각해",
		DRAGONFRUIT_COOKED = "생긴게 이상해도 속은 괜찮지 않아?",
		DRAGONFRUIT_SEEDS = "용과 씨앗이야",
		DRAGONPIE = "파이는 언제나 옳아!",
		DRUMSTICK = "먹을 수 있는 다리를 구했어!",
		DRUMSTICK_COOKED = "구운 다리야!",
		DURIAN = "뮤샤에게도 이걸 먹는건 큰 모험이 될거야",
		DURIAN_COOKED = "뮤샤에게 코가 없었다면 이걸 좀 더 쉽게 먹었을지도 몰라",
		DURIAN_SEEDS = "두리안 씨앗이야",
		EARMUFFSHAT = "토끼털로 만든 귀마개야",
		EGGPLANT = "가지 좋아해?",
		EGGPLANT_COOKED = "더 말랑말랑해졌어",
		EGGPLANT_SEEDS = "가지 씨앗이야",
		STUFFEDEGGPLANT = "먹을 수 있는 그릇, 먹을 수 있는 음식, 먹을 수 있는 장식!",
		DUG_BERRYBUSH = "단 열매는 항상 옳아",
		DUG_GRASS = "풀은 쓸모가 많으니까 몇개 심어두면 편리해",
		DUG_MARSH_BUSH = "가시있는 덤불이지만 쓸모있어",
		DUG_SAPLING = "나뭇가지는 재료로 쓸 수 있고 연료로도 쓸 수 있어",
		EARMUFFS = "토끼털로 만든 귀마개야",
		DECIDUOUSTREE =
		{
			BURNING = "쉽게 불이 붙고, 쉽게 불이 번져",
			BURNT = "목탄 덩어리야",
			CHOPPED = "나무가 밑둥만 남아서 이제 더 이상 크지 않을거야",
			GENERIC = "비를 피할 수 있고, 땔감도 되고, 재료도 돼",
		},
		ACORN =
		{
		    GENERIC = "비를 피할 수 있고, 땔감도 되고, 재료도 돼",
		    PLANTED = "도토리 나무야",
		},
		EVERGREEN =
		{
			BURNING = "쉽게 불이 붙고, 쉽게 불이 번져",
			BURNT = "목탄 덩어리야",
			CHOPPED = "나무가 밑둥만 남아서 이제 더 이상 크지 않을거야",
			GENERIC = "비를 피할 수 있고, 땔감도 되고, 재료도 돼",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "쉽게 불이 붙고, 쉽게 불이 번져",
			BURNT = "목탄 덩어리야",
			CHOPPED = "나무가 밑둥만 남아서 이제 더 이상 크지 않을거야",
			GENERIC = "비를 피할 수 있고, 땔감도 되고, 재료도 돼",
		},
		EYEPLANT = "뭐든지 먹어버리는 괴물이야",
		FEATHERHAT = "춤을 춰야만 할것 같은 모자야",
		FEATHER_CROW = "까만새 깃털이야",
		FEATHER_ROBIN = "빨간새 깃털이야",
		FEATHER_ROBIN_WINTER = "하얀새 깃털이야",
		FEM_PUPPET = "어디에 쓰는거지?", --what was that?
		FIREFLIES =
		{
			GENERIC = "밤에 빛나는 벌레야",
			HELD = "반짝일때는 몰랐는데 이거 이상하게 생겼어",
		},
		FIREHOUND = "절대로 집 안에 들어오게 하면 안돼! 다 타버릴거야!",
		FIREPIT =
		{
			EMBERS = "사용하고 싶으면 태울만한걸 넣어야해",
			GENERIC = "뮤샤에게 따뜻한 온기를 나눠줘",
			HIGH = "불꽃이 하늘로 치솟고있어!",
			LOW = "불꽃이 사그러들고있어. 새벽이 빨리 온다면 문제는 없을거야",
			NORMAL = "밝은 빛이야",
			OUT = "다시 불을 피워야하는게 아닐까?",
		},
		FIRESTAFF = "불을 쏘는 물건은 뭐든지 위험해",
		FISH = "이곳의 물고기는 연못에만 있어",
		FISHINGROD = "물고기를 먹으려면 물고기를 잡아야지",
		FISHSTICKS = "가시 걱정만 없다면 더 맛있게 먹을 수 있어",
		FISHTACOS = "물고기와 옥수수 가루만 있으면 만들 수 있어!",
		FISH_COOKED = "가장 간단한 물고기 요리야. 구운거야!",
		FLINT = "불꽃이 튀는 돌이지만 도구를 만드는 데도 쓸 수 있어",
		FLOWER = "색도 좋고, 냄새도 좋고, 맛은-",
		FLOWERHAT = "화환은 색도 좋고, 냄새도 좋고, 맛은-",
		FLOWER_EVIL = "화환의 냄새가 이상해졌어. 뮤샤의 머리에서도 이상한 냄새가 밴것같아",
		FOLIAGE = "그냥은 먹을 수 없겠어",
		FOOTBALLHAT = "튼튼하고 앞이 잘 보여",
		FROG =
		{
			DEAD = "좋은 개구리는 죽은 개구리뿐이야",
			GENERIC = "뮤샤는 개구리를 별로 안좋아하는데 개구리도 마찬가지인가봐",
			SLEEPING = "쉬잇, 개구리가 자고있어",
		},
		FROGGLEBUNWICH = "바삭한 다리로 만든 샌드위치야",
		FROGLEGS = "몸통엔 뭐가 들었을지 모르니까 다리만 챙겼어",
		FROGLEGS_COOKED = "잘 구워졌어",
		FRUITMEDLEY = "과일을 잔뜩 섞은거야",
		GEARS = "메탈 기어 뮤샤!",
		GHOST = "이 유령은 때릴 수 있어!",
		GOLDENAXE = "이 금도끼는 뮤샤의 금도끼야",
		GOLDENPICKAXE = "돌 곡괭이보다는 금으로 만든게 더 튼튼해",
		GOLDENPITCHFORK = "눈부셔!",
		GOLDENSHOVEL = "이걸로 땅을 파서 이거보다 값진게 나올까?",
		GOLDNUGGET = "뮤샤는 금덩이를 유용하게 사용할 줄 알아",
		GRASS =
		{
			BARREN = "비료가 필요해보여",
			WITHERED = "이대로 놔두면 말라 죽을지도 몰라",
			BURNING = "불이야!",
			GENERIC = "풀은 여러모로 쓸모가 많아",
			PICKED = "풀은 놔둬도 잘 자라",
		},
		GREEN_CAP = "녹색 버섯은 환각버섯이래",
		GREEN_CAP_COOKED = "구워 먹으면 정신이 또렷해진대",
		GREEN_MUSHROOM =
		{
			GENERIC = "녹색 버섯이야",
			INGROUND = "해가 질 무렵에 오면 버섯을 얻을 수 있을거야",
			PICKED = "기둥만 봐서는 무슨 버섯인지 모르겠어",
		},
		GUNPOWDER = "이게 있으면 뭐든지 터트릴 수 있어!",
		HAMBAT = "먹을것 가지고 장난치지 말라는 이야기는 있지만\n이건 장난이 아니니까 괜찮아",
		HAMMER = "망치가 있으면 뭐든지 부술 수 있는거야",
		HEALINGSALVE = "아플때 연고를 바르면 아픈게 사라져",
		HEATROCK =
		{
			FROZEN = "꽁꽁 얼었어",
			COLD = "살짝 언것 같아",
			GENERIC = "이 돌은 여름 겨울 가리지 않고 유용해",
			WARM = "따뜻한 돌이야",
			HOT = "돌이 불덩이처럼 뜨거워!",
		},
		HONEY = "꿀이야!",
		HONEYCOMB = "벌집이 있으면 벌통을 만들 수 있어",
		HONEYHAM = "입 속이 단맛으로 꽉 차고 배는 고기로 꽉 차는 요리야",
		HONEYNUGGETS = "꿀하고 고기를 같이 먹는거 뮤샤는 괜찮다고 생각해",
		HORN = "웅웅 거리는 소리가 날거야",
		HOUND = "이곳의 늑대하고 뮤샤하고는 아무런 관련이 없어. 진짜야",
		HOUNDMOUND = "어떻게 이 좁은 무더기에서 늑대들이 끊임없이 나오는거야?",
		HOUNDBONE = "이 상황이 되면 이건 그냥 뼈야",
		ICEBOX = "여기에 넣으면 음식을 오래 보관할 수 있어",
		ICEHOUND = "하얀 늑대야!",
		INSANITYROCK =
		{
			ACTIVE = "이게 열리려면 무슨 조건이 필요한 모양이야",
			INACTIVE = "열렸어!",
		},
	--adds 2 start
		SCARECROW = 
   		{
			GENERIC = "뮤샤가 새를 쫒아낼 수 없다면, 새가 싫어할 만한걸 만들어버리는거야",
			BURNING = "와, 정말로 새가 싫어할만하게 되어버렸어",
			BURNT = "새까만 뼈만 남아버렸네",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "장식할 물건을 만들 수 있대. 대리석으로",
			BLOCK = "여기에 돌이 있어. 뮤샤는 마음대로 만들어도 돼",
			SCULPTURE = "뮤샤의 자신작이야!",
			BURNT = "새하얗게 불태운게 아니라 까맣게 타버렸네",
   		},
        SCULPTURE_KNIGHTHEAD = "말 모양 같긴한데 너무 장난감같아",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "팔은 남았어. 몸통은 그렇게 멋지진 않네",
			UNCOVERED = "몸통에 무언가 머리카락같은게 있어. 근데 머리는?",
			FINISHED = "말머리 석상이야! 근데 몸통이 이상해!",
			READY = "뮤샤는 이 석상에서 수상한 기운을 느껴",
		},
        SCULPTURE_BISHOPHEAD = "빵모자를 쓴 머리 조각이야",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "돌로 만든 테엽도 작동할까?",
			UNCOVERED = "이 물병 조각은 뭔가 부족해 보이는걸",
			FINISHED = "말머리 석상이야! 근데 몸통이 이상해!",
			READY = "뮤샤는 이 석상에서 수상한 기운을 느껴"
			},
        SCULPTURE_ROOKNOSE = "어떤 건물의 기둥이었던 것 같아",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "커다란 머리의 모양은 있지만 이걸론 부족해",
			UNCOVERED = "거대한 돌덩이야",
			FINISHED = "빨갛게 칠해도 움직이진 않을거야. 다리가 없으니까",
			READY = "뮤샤는 이 석상에서 수상한 기운을 느껴"
		},
        GARGOYLE_HOUND = "늑대 모양 석상을 만들 여유가 있었던걸까? 위험하지 않아?",
        GARGOYLE_WEREPIG = "좀더 다른걸 만들었으면 좋았을걸. 얌체라든지",
	--adds 2 end	
	
		JAMMYPRESERVES = "슬로우푸드!",
		KABOBS = "꼬치구이!",
		KILLERBEE =
		{
			GENERIC = "일하지 않는 싸움꾼 벌이야!",
			HELD = "나쁜 벌!",
		},
		KNIGHT = "박치기 하는 말 동상... 말박이?",
		KOALEFANT_SUMMER = "빨간 코끼리야",
		KOALEFANT_WINTER = "파란 코끼리야",
		KRAMPUS = "악마가 나타났어!",
		KRAMPUS_SACK = "산타의 선물꾸러미가 이것보다 클까?",
		LAVAE = "이 불덩이는 뮤샤를 좋아하는건지 싫어하는건지 모르겠어",
		LEIF = "나무 거인이야!",
		LEIF_SPARSE = "나무 거인이야!",
		LIGHTNING_ROD =
		{
			CHARGED = "막대가 번쩍번쩍해!",
			GENERIC = "이게 있으면 번개에 안맞게된대",
		},
		LITTLE_WALRUS = "거슬리긴 하지만 신경쓰진 않아도 돼",
		LIVINGLOG = "통나무에 얼굴이 생기는거야?",
		LOCKEDWES = "누군가 같혀있어!",
		LOG =
		{
			BURNING = "모닥불을 피우는게 나았겠지만 급하면 어쩔수없지",
			GENERIC = "통나무로 할 수 있는 건 많으니까 많으면 좋아",
		},
		LUREPLANT = "이 식물엔 아이템이 끝없이 들어가는거 같아",
		LUREPLANTBULB = "이 식물은 이제 뮤샤꺼입니다.\n뮤샤 마음대로 할 수 있는겁니다",
		MALE_PUPPET = "윌슨을 기리는 동상인거야?",
		MANDRAKE =
		{
			DEAD = "머리같아",
			GENERIC = "당근이나 무라고 하기엔 뭔가 이상하게 생겼어",
			PICKED = "머리같은 뿌리에 머리카락같은 잎사귀야",
		},
		COOKEDMANDRAKE = "이 얼굴을 통째로 씹어먹는건 좋지 않은 생각같아",
		MANDRAKESOUP = "이게 그렇게 몸에 좋대",
		MARBLE = "진짜 무거운 돌이야",
		MARBLEPILLAR = "정말로 멋져",
		MARBLETREE = "이 나무는 어떻게 해서 생긴걸까?",
		MARSH_BUSH =
		{
			BURNING = "가질 필요가 없다면 태워버리면 돼",
			GENERIC = "가시가 많은 덤불이야",
			PICKED = "덤불도 어찌어찌 쓸모는 있어",
		},
		MARSH_PLANT = "이 풀은 너무 거칠어서 못 써먹어",
		MARSH_TREE =
		{
			BURNING = "잎이 없어도 잘 타는건 마찬가지네",
			BURNT = "모든 불탄 나무는 결국 목탄이 돼",
			CHOPPED = "나무는 나무니까 통나무는 있었지",
			GENERIC = "잎 대신 가시만 무성한 나무네",
		},
		MAXWELL = "키가 커!",
		MAXWELLHEAD = "뮤샤는 이 얼굴을 본 적이 있는 것 같아",
		MAXWELLLIGHT = "뭔가 불을 붙일 수 있을 것 같은데.",
		MAXWELLLOCK = "여기에 꼭 맞는 뭔가 있을 것 같은데",
		MAXWELLTHRONE = "이게 재대로 된 게 아니라는건 알겠어",
		MEAT = "고기는 말야, 굽고, 삶고, 튀기고, 말리고, 태울 수 있어",
		MEATBALLS = "미트볼이야!",
		MEAT_DRIED = "육포도 물에 불리면 다시 고기잖아?",
		MERM = "쟤들은 뮤샤를 별로 좋아하는 것 같지 않은데",
		MONSTERLASAGNA = "음식이긴 한데, 뮤샤는 먹고싶진 않아",
		MONSTERMEAT = "뮤샤 입에 모래가 들어가도 이건 먹고 싶지 않아",
		MONSTERMEAT_DRIED = "말리면 나아질 줄 알았는데 아직 아니야",
		MOSQUITO =
		{
			GENERIC = "뮤샤의 피는 맛이 없다구",
			HELD = "살아있는 모기를 써먹을 상황이 있을까?",
		},
		MOSQUITOSACK = "말랑말랑해!",
		MOUND =
		{
			DUG = "주인이 없어져버린 무덤이야",
			GENERIC = "누군가의 무덤이야",
		},
		MULTIPLAYER_PORTAL = "이곳에서 시작하고 이곳에서 끝이 날거야",
		NIGHTLIGHT = "새까만 불이어도 밤에 빛은 나는 불이야",
		NIGHTMAREFUEL = "이 작은 검은 덩어리는 아직도 꿈틀거려",
		NIGHTSWORD = "이건 날카롭다기보단 기분나쁜 칼이야",
		NITRE = "이걸로 화약을 만들 수 있어",
		ONEMANBAND = "신나게 달려보자구!",
		PANDORASCHEST = "보물상자야!",
		PANFLUTE = "뮤샤는 이거 불줄알아!",
		PAPYRUS = "갈대로 만든 종이도 책은 만들 수 있어",
		PENGUIN = "땅에서 헤엄치는 새야. 잠깐, 새?",
		PERD = "덤불속에서 숨어있어서 몰랐지만 저거 칠면조야!",
		PEROGIES = "고기만두!",
		PETALS = "꽃 뭉치 먹을래?",
		PETALS_EVIL = "갈색에 검정색이긴 해도 썩은건 아니니까 괜찮아",
		PHLEGM = "이걸 어떻게 해야하는거야?",
		PICKAXE = "이것저것 할려면 우선 돌을 캐야해",
		PIGGYBACK = "이게 좀 더 큰 가방이야",
		PIGKING = "저 돼지 왕은 기분이 좋으면 마음대로 금덩이를 뿌린다고해",
		PIGMAN =
		{
			DEAD = "죽고나면 결국 돼지야",
			FOLLOWER = "가자구! 가서 뮤샤랑 같이 거미를 잡자!",
			GENERIC = "저 돼지괴인들은 뮤샤를 싫어하지 않는 것 같아",
			GUARD = "저 돼지괴인들은 신경이 날카로워보여",
			WEREPIG = "털난 맷돼지같아! 게다가 사납구!",
		},
		PIGSKIN = "뮤샤는 먹지 않을거지만 누군가는 먹을지도 몰라",
		PIGTORCH = "기둥이 멋진 횃불이야",
		PINECONE =
		{
		    GENERIC = "솔방울이야",
		    PLANTED = "소나무 묘목이야",
		},
		PITCHFORK = "땅을 엎어버릴 수 있어. 아니, 뜯을 수 있어",
		PLANTMEAT = "뮤샤가 보기에 이건 녹아내리고있는 것 같아",
		PLANTMEAT_COOKED = "냄새는 고기같아!",
		PLANT_NORMAL =
		{
			GENERIC = "채소나 과일을 기르려면 필요해",
			GROWING = "Let it grow~ Let it grow~",
			READY = "이제 수확해도 돼!",
			WITHERED = "물기가 너무 없어. 완전히 바싹 말라버렸어",
		},
		POMEGRANATE = "석류야",
		POMEGRANATE_COOKED = "열매 안쪽에 또 열매가 있어",
		POMEGRANATE_SEEDS = "석류 씨앗이야",
		POOP = "너무 큰... 똥이야. 하지만 쓸 구석은 많아",
		PUMPKIN = "호박이야! 뮤샤는 잭-오-랜턴의 이야기를 좋아해!",
		PUMPKINCOOKIE = "호박과자!",
		PUMPKIN_COOKED = "호박을 한번 찌면 자르기 쉬워",
		PUMPKIN_LANTERN = "이렇게 놓고 보니까 늑대 얼굴같아",
		PUMPKIN_SEEDS = "호박 씨앗이야",
		PURPLEGEM = "이 보라색 보석 속에 뭔가 보이는 것 같아",
		RABBIT =
		{
			GENERIC = "빠르긴 해도 뮤샤에겐 손쉬운 사냥감이야",
			HELD = "이 토끼를 어떻게 해볼까?",
		},
		RABBITHOLE =
		{
			GENERIC = "토끼가 숨어있는 구멍이야",
			SPRING = "이제는 사용하지 않는 구멍같아.\n하지만 조사해보면 뭔가 있을지도 몰라",
		},
		RATATOUILLE = "알록달록한 음식이야! 고기는 하나도 없어",
		RAZOR = "뮤샤가 네 털을 몽땅 밀어버릴거야!",
		REDGEM = "빨간 보석은 생명과 불을 상징한다고 해",
		RED_CAP = "빨간 버섯은 독버섯이라던데",
		RED_CAP_COOKED = "구워도 빨간 버섯이야",
		RED_MUSHROOM =
		{
			GENERIC = "빨간 버섯은 독이 있다고 해",
			INGROUND = "낮에 다시 오면 확인할 수 있을거야",
			PICKED = "기둥만 봐서는 무슨 버섯인지 모르겠어",
		},
		REEDS =
		{
			BURNING = "늪지여도 불은 붙어!",
			GENERIC = "갈대는 용도가 참 많아. 특히 종이랑 다트",
			PICKED = "시간이 지나면 다시 자랄거야",
		},
        RELIC =
        {
            GENERIC = "주인이 없다면 이제 뮤샤가 써도 되겠지?",
            BROKEN = "쓸려면 수리를 해야할 거 같아",
        },
        RUBBLE = "이걸 어디에 쓰지?",
		RESURRECTIONSTONE = "부활을 하려면 죽어야하는데, 일부러 그럴 필요는 없을 것 같아",
		ROBIN =
		{
			GENERIC = "이 빨간 새는 나무를 잘 쪼아댈 것 같아.",
			HELD = "뮤샤가 빨간새를 잡았어! 산채로!",
		},
		ROBIN_WINTER =
		{
			GENERIC = "푹신푹신한 하얀 돼지새야",
			HELD = "뮤샤가 하얀새를 잡았어! 산채로!",
		},
		ROBOT_PUPPET = "결국은 모두 죽기마련",
		ROCK_LIGHT =-- what the flame blast?
		{
			GENERIC = "이게 무슨일이 벌어지는거야?",
			OUT = "불이 나갔어",
			LOW = "무슨 일이 벌어질거야",
			NORMAL = "확실히 이건 뜨거워",
		},
		ROCKS = "돌이 있으면 여러가지를 할 수 있어",
        ROOK = "강철로 된 코뿔소야!",
        ROPE = "묶는데 쓸 수 있을까?",
		ROTTENEGG = "상한 알 냄새는 정말 구려",
		SANITYROCK =
		{
			ACTIVE = "이게 열리려면 무슨 조건이 필요한 모양이야",
			INACTIVE = "열렸어!",
		},
		SAPLING =
		{
			BURNING = "아무데서나 잘 자라지만 그렇다고 막 태워도 되는건 아니야",
			WITHERED = "물이 필요한 것 같아",
			GENERIC = "나뭇가지가 필요하면 꺾으면 되잖아",
			PICKED = "몇일 있으면 다시 자랄거야",
		},
		SEEDS = "아무튼 씨앗이야",
		SEEDS_COOKED = "배고프면 씨낱알도 먹어야지",
		SEWING_KIT = "옷을 수선하는데는 쓸 수 있지만 뮤샤는 다른것도 쓸 수 있어",
		SHOVEL = "삽질하는데는 삽이 필요해",
		SILK = "거미를 계속 사냥하다보면 가장 많이 쌓이는것 같아",
		SKELETON = "먼저 왔던 누군가의 시체인 모양이야",
		--SKELETON_PLAYER = "That gives me the willies.",

		SKELETON_PLAYER =
		{
			MALE = "여기 %s의 시체는 %s 때문에 죽었어",
			FEMALE = "여기 %s의 시체는 %s 때문에 죽었어",
			ROBOT = "여기 %s의 시체는 %s 때문에 죽었어",
			DEFAULT = "여기 %s의 시체는 %s 때문에 죽었어",
		},

		SKULLCHEST = "뭐가 들어있을까?", --what was that?
		SMALLBIRD =
		{
			GENERIC = "얌체만큼이나 아주 작은 새야",
			HUNGRY = "이 새는 지금 배고픈가봐",
			STARVING = "잠깐만 기다려봐! 뮤샤도 네가 배고픈거 알고있어",
		},
		SMALLMEAT = "다리일 수도 있고, 팔일 수도 있고, 날개일 수도 있고",
		SMALLMEAT_DRIED = "마르니까 더 작아졌어! 하지만 먹는데는 문제없어",
		SPAT = "양도 아니고 코뿔소도 아니고 저건 대체 무슨 생물이야?",
		SPEAR = "찌르는것 보다 때리는데 더 유용한 창이야!",
		SPIDER =
		{
			DEAD = "뮤샤가 강해지는 가장 빠른 방법이 거미를 끝없이 사냥하는거야",
			GENERIC = "이 세계의 모든 거미는 뮤샤의 사냥감이야",
			SLEEPING = "거미가 자고있어",
		},
		SPIDERDEN = "뮤샤는 거미집을 무서워하지 않아",
		SPIDEREGGSACK = "뮤샤의 뒷마당에 꽃아놓으면 거미가 계속 나올거야",
		SPIDERGLAND = "이걸 상처난 곳에 바르면 회복이 빨라져",
		SPIDERHAT = "뮤샤가 모든 거미를 사냥해버렸어! 여왕거미까지 모두 다!",
		SPIDERQUEEN = "여왕거미는 거미를 계속 낳아대니까 얌체랑 같이 공격해야해",
		SPIDER_WARRIOR =
		{
			DEAD = "병정거미여도 결국은 죽기마련",
			GENERIC = "폴짝뛰어 깨물어대니까 거리를 잘 조절해야해",
			SLEEPING = "거미는 낮이 되면 잠을 자. 굳이 깨울 필요는 없지 않아?",
		},
		SPOILED_FOOD = "완전히 썩었어!",
		STATUEHARP = "왜 돌로 연주도 할 수 없는 하프를 만든걸까?",
		STATUEMAXWELL = "분명히 이 녀석이 뮤샤를 여기에 끌어들인걸거야",
		STEELWOOL = "굉장히 지저분해보여",
		STINGER = "벌침이야",
		STRAWHAT = "밀집모자로도 비는 막을 수 있고 더위도 막을 수 있어",
		SUNKBOAT = "무슨 일이 있었던걸까?",
		SWEATERVEST = "얼룩무늬 상의야",
		TAFFY = "입속이 단맛으로 가득해져!",
		TALLBIRD = "정말 키가 큰 새야. 정확히는 다리가 긴 새야",
		TALLBIRDEGG = "키큰 새의 커다란 알이야.",
		TALLBIRDEGG_COOKED = "정말 커다란 알이지만 뮤샤는 다 먹을 수 있어",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "부화할려면 따뜻한 곳에 놓아야 할 것 같아",
			GENERIC = "아기새가 태어날려나봐",
			HOT = "이대로 놔두면 알이 익어버릴거야!",
			LONG = "언제 부화하는거지?",
			SHORT = "뮤샤는 이 알을 부화시켜볼거야",
		},
		TALLBIRDNEST =
		{
			GENERIC = "다른 알 보다 5배는 커보여",
			PICKED = "알이 있었는데요 없었습니다",
		},
		TEENBIRD =
		{
			GENERIC = "이 새는 뮤샤를 따르기는 하는데 뒤가 근질거려",
			HUNGRY = "아직도 이 새의 밥은 뮤샤가 챙겨줘야해",
			STARVING = "뮤샤는 네가 배가 고픈걸 알고있으니까 잠깐만 기다려",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "뮤샤가 너를 만나러 갈거야",
			GENERIC = "여기서 멀리서 단숨에 이동할 수 있대. 웜홀이네!",
			LOCKED = "작동시키려면 뭔가가 필요해",
			PARTIAL = "다음 모험으로!",
		},
		TELEPORTATO_BOX = "서프라이즈 박스!",
		TELEPORTATO_CRANK = "이 손잡이는 원래 어디 있던거지?",
		TELEPORTATO_POTATO = "감자처럼 생겼는데 감자가 아니야",
		TELEPORTATO_RING = "커다란 링이야",
		TENTACLE = "다리? 그러면 몸통은 땅속에 있는거야?",
		TENTACLESPOTS = "땅이 보글보글 거리고있어! 땅 속에 뭔가 있나봐!",
		TENTACLESPIKE = "이 가시는 좀 따가울거같아",
		TENTACLE_PILLAR = "땅 밑바닥엔 뭐가 있는걸까! 모험이 기대돼!",
		TENTACLE_PILLAR_ARM = "촉수가 잔뜩 있어!",
		TENTACLE_GARDEN = "뭔가 땅속을 움직이고있어",
		TOPHAT = "신사적인 모자야",
		TORCH = "깜깜하지 않다면, 뮤샤에게 무서울 건 없어!",
		TRAP = "작은 사냥감은 이걸로 잡을 수 있어",
		TRAP_TEETH = "좀 큰 사냥감은 이걸로 잡을 수 있어",
		TRAP_TEETH_MAXWELL = "손대면 펑 하고 터질것만 같아",
		TRINKET_1 = "몇번 씹었다가 뱉은 젤리같아.",-- Melty Marbles
		TRINKET_10 = "입을 왜 이렇게 해놓은거야? 고약하네",-- Second-hand Dentures
		TRINKET_11 = "네모네모난 기계야! 움직이진 않지만",-- Lying Robot
		TRINKET_12 = "이건 먹고싶지 않아",--Dessicated Tentacle
		TRINKET_13 = "누군가는 좋아할지도 모르지만, 뮤샤는 아니야",
		TRINKET_2 = "바람의 오카리나.. 전혀 모르겠네!",--Fake Kazoo
		TRINKET_3 = "호루라기를 불면 누군가 나타난대. 그러니까 이름이.. 포돌이?",--Gord's Knot
		TRINKET_4 = "꼬마 요정이 있다면 이렇게 생겼을까?",--Gnome
		TRINKET_5 = "이 신발의 주인은 엄청난 모험을 했었을거야!", --starcraft
		TRINKET_6 = "와이어로 암살하는 108가지 방법? 뮤샤에겐 필요없어",--Frazzled Wires
		TRINKET_7 = "뮤샤는 이걸 어떻게 쓰는지 깨달았어! 전혀 쓸모없네!",-- Ball and Cup
		TRINKET_8 = "뭔가를 막는데 쓰는것 같아. 자국이 있으나까 알 수 있어",-- Hardened Rubber Bung
		TRINKET_9 = "색이 너무 제각각이라 어디에 붙여야할지 모르겠네!",--Mismatched Buttons
	--adds 3 start
		TRINKET_14 = "요즘 뮤샤는 잔보다는 컵이 더 편해", --Leaky Teacup
		TRINKET_15 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Pawn
		TRINKET_16 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Pawn
		TRINKET_17 = "이 수저는 밥을 먹는데도 쓸 수 있고 찌르는 데도 쓸 수 있겠네", --Bent Spork
		TRINKET_18 = "실제 말을 타는것과 방법이야 다르겠지만 분위기는 낼 수 있겠네", --Trojan Horse
		TRINKET_19 = "뮤샤는 이게 잘 돌아간다는 것 외엔 아무것도 알아내지 못했어", --Unbalanced Top
		TRINKET_20 = "어딘가를 긁는데는 쓸 수 있겠네", --Backscratcher
		TRINKET_21 = "손잡이를 잡고 가운데 손잡이를 빙빙 돌리면 아래가 빙빙 돌아가", --Egg Beater
		TRINKET_22 = "이 실뭉치로 만들면 추울 걱정은 없겠어", --Frayed Yarn
		TRINKET_23 = "이게 안쪽으로 휘어있는 이유는 뭘까?", --Shoehorn
		TRINKET_24 = "안에 무언가 들어있었을거야", --Lucky Cat Jar
		TRINKET_25 = "네모나지 않은 공책은 신기하네", --Air Unfreshener
		TRINKET_26 = "컵을 만든다면 이것보다 더 좋은 재료가 많잖아?", --Potato Cup
		TRINKET_27 = "너무 잘 휘고 단단하지도 않아!", --Coat Hanger
		TRINKET_28 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Rook
        TRINKET_29 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Rook
        TRINKET_30 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Knight
        TRINKET_31 = "뭔가 도구인 것 같진 않은데. 뭘까?", --Knight
        TRINKET_32 = "이것도 등불이야? 아니야?", --Cubic Zirconia Ball
        TRINKET_33 = "이건 대체 어느 손가락에 끼워야 하는거야?", --Spider Ring
        TRINKET_34 = "뮤샤는 이런걸 모으는 취미는 없는걸", --Monkey Paw
        TRINKET_35 = "무언가를 담았던 병이야. 뮤샤는 희미하지만 냄새가 나는걸 느끼니까 알아", --Empty Elixir
        TRINKET_36 = "이건 이빨 모양 같은데 다물어지지가 않아", --Faux fangs
        TRINKET_37 = "말뚝을 반으로 쪼개놓은건 무슨 이유일까?", --Broken Stake
        TRINKET_38 = "뮤샤는 망원경을 좋아해. 냄새가 나는 방향의 먼 곳까지 볼 수 있거든", -- Binoculars Griftlands trinket
        TRINKET_39 = "장갑은 장갑인데 손등에 철판이 붙어있어. 때리기용일까? 손등으로?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "위의 접시를 누르면 아래에 있는 바늘이 막 돌아가!", -- Snail Scale Griftlands trinket
        TRINKET_41 = "뭔가를 담았었어. 담았었어?", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "머리는 남아있는데 몸통이 많이 망가진 모양이야", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "바퀴에, 모자에, 커다란 입에, 날카로운 이빨까지 있으니 뮤샤가 좋아할 건 전혀 없네!", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "깨지지 않았다면 좀 더 예쁜 모습이었을까?", -- Broken Terrarium ONI trinket
        TRINKET_45 = "뮤샤는 이게 뭔지 전혀 모르겠어. 눌러도 아무것도 변화가 없는걸", -- Odd Radio ONI trinket
        TRINKET_46 = "이건 어떻게 사용하는 도구지?", -- Hairdryer ONI trinket
		
		HALLOWEENCANDY_1 = "단걸 좋아해도 매 식사를 사탕으로 한다는건 무리야",
        HALLOWEENCANDY_2 = "뮤샤도 단건 좋아해",
        HALLOWEENCANDY_3 = "먹는거를 먹는걸로 만든거니까 아무문제 없어",
        HALLOWEENCANDY_4 = "생긴게 재미있으면 먹는것도 재미있어져",
        HALLOWEENCANDY_5 = "사탕을 잔뜩 먹었으면 입을 잘 헹궈야해",
        HALLOWEENCANDY_6 = "뭐든지 과식하는건 안좋지만, 간식은 과식하기 힘들어",
        HALLOWEENCANDY_7 = "말린게 안말린 것 보다 맛있으니까 말렸을거야. 아마도",
        HALLOWEENCANDY_8 = "배부르는데는 별로 도움은 되지 않아. 맛은 좋지만",
        HALLOWEENCANDY_9 = "딱딱한걸 먹으면 일단 씹고 싶어져",
        HALLOWEENCANDY_10 = "단맛은 일단 좋아",
        HALLOWEENCANDY_11 = "뭐든지 사탕으로 만들면 맛있을거라는 생각은 하지 말았으면 해",
        HALLOWEENCANDY_12 = "이거 벌레는 아닌거지?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "이 돌기나 색은 전혀 평범하지 않네", --Griftlands themed candy
        HALLOWEENCANDY_14 = "아무리 봐도 이걸 사탕으로 만든다고 달 것 같진 않아", --Hot Lava pepper candy
        CANDYBAG = "달그락 달그락 거리는 소리가 들려",

        DRAGONHEADHAT = "이 머리는 끔찍하게 생겼는걸",
        DRAGONBODYHAT = "다리 두개와 등이 있는건 알겠어. 근데 나머지는?",
        DRAGONTAILHAT = "이 삐죽 나온 가죽은 꼬리인거야?",
        PERDSHRINE =
        {
            GENERIC = "이 멍청하고 뭐든지 먹어댈거같은 새의 모습을 뮤샤는 알고있어",
            EMPTY = "이것도 쓸모가 있는걸까?",
            BURNT = "응. 타버리면 결국 이렇게 되어버리는거야",
        },
        REDLANTERN = "이런 모양의 랜턴도 나쁘지 않은것 같아!",
        LUCKY_GOLDNUGGET = "금덩이를 신기한 모양으로 만들었네!",
        FIRECRACKERS = "번쩍번쩍 펑펑 할거야! 엄청 신날거야!",
        PERDFAN = "날카로운 바람이 불거야. 그런 부채니까",
        REDPOUCH = "이 작은 주머니에 뭐가 들어있을까",
        WARGSHRINE = 
        {
            GENERIC = "금으로 만든 동상이라면 좀 더 멋진걸 만들었으면 해",
            EMPTY = "뮤샤는 여기에 뭔갈 더 추가하고 싶어",
            BURNT = "다 타버리면 결국 이런거 밖에 안남아",
        },
        CLAYWARG = 
        {
        	GENERIC = "흙덩이라고 해도 뮤샤에게 예외는 아니야!",
        	STATUE = "움직이거나 그러는거 아니지?",
        },
        CLAYHOUND = 
        {
        	GENERIC = "일단 부수면 안심이야!",
        	STATUE = "금방이라도 움직일거 같아서 뮤샤를 긴장하게 해",
        },
        HOUNDWHISTLE = "뮤샤가 이걸 불면 어떻게 될까?",
        CHESSPIECE_CLAYHOUND = "진짜도 흙덩이고 가짜도 흙덩이니 구분을 할 수가 없어",
        CHESSPIECE_CLAYWARG = "진짜도 흙덩이고 가짜도 흙덩이니 구분을 할 수가 없어",

		BISHOP_CHARGE_HIT = "으앗!",
	--adds 3 end	
		TRUNKVEST_SUMMER = "방수가 되는 옷이야!",
		TRUNKVEST_WINTER = "이 옷이 겨울에 그렇게 따뜻하대",
		TRUNK_COOKED = "한입에 들어갈 것 같진 않아. 근데 이거 먹어도 되는거야?",
		TRUNK_SUMMER = "안이 뻥 뚫려있어!",
		TRUNK_WINTER = "안이 뻥 뚫려있어!",
		UMBRELLA = "뮤샤는 이 색깔이 맘에 들어! 펼쳤을 때 모양도 맘에 들어!",
		WAFFLES = "와플의 바삭함이 딱 좋은 상태로 요리가 됐어",
		WALL_HAY_ITEM = "바람이 분다고 날아가지 않으면 좋겠어",
		WALL_STONE = "이 벽이 있으면 잠깐 시간을 벌 수 있어",--0
		WALL_STONE_ITEM = "돌을 구하는건 어렵지 않고, 나름 튼튼해",
		WALL_RUINS = "이걸 부수고 들어올려면 시간이 오래걸릴거야",--0
		WALL_RUINS_ITEM = "시간을 벌어준다면 이건 낭비가 아니야",
		WALL_WOOD_ITEM = "통나무를 순식간에 부수고 들어올 순 없을거야",
		WALRUS = "저게 쏠 틈을 주면 안돼!",
		WALRUSHAT = "완벽하게 멋져",
		WALRUS_CAMP =
		{
			EMPTY = "이 바닥은 누군가 만들어서 생긴거야",
			GENERIC = "얼음집이라니 엄청나게 추워보여",
		},
		WALRUS_TUSK = "이 이빨에 물렸다면 엄청 아팠을거야",
		WARG = "떼거리로 몰려오기 전에 때려잡으면 돼",
		WASPHIVE = "전리품을 얻으려면 모험이 필요한거야",
		WETGOOP = "원형이 남지 않을정도로 이상한게 되어버렸어",
		WINTERHAT = "겨울을 나려면 이정도는 준비해야지",
		WORMHOLE =
		{
			GENERIC = "이게 입일까 아니면-",
			OPEN = "이게 안전한거 맞지? 뮤샤는 매우 의심스러운데",
		},
		ACCOMPLISHMENT_SHRINE = "엄청난 사치품이야. 정말로",
	},
	DESCRIBE_TOODARK = "아무것도 보이지 않아! 정말로 위험해!",
	DESCRIBE_SMOLDERING = "으아아아앙그아아아아!!",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "알도 고기야",
	},
}
