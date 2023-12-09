STRINGS.musha = {
    segmentation = "------------------",
    segmentation_long = "------------------------------\n",

    lack_of_exp = "Musha需要更多技能点数来解锁这个技能。",
    lack_of_mana = "Musha的魔力不够了!",
    lack_of_sanity = "Musha的理智值不够了!",
    lack_of_stamina = "Musha的耐力值不够了!",
    mount_not_allowed = "Musha得先从坐骑上下来!",
    no_target = "Musha找不到有效目标!",
    out_of_range = "Musha距离目标太远了!",

    switchkeybindings_on = "随从命令快捷键: 开启",
    switchkeybindings_off = "随从命令快捷键: 关闭",

    shadowmushaorder_follow = "影子们, 停下手中的活儿, 到Musha身边来!",
    shadowmushaorder_resume = "影子们, 行动起来吧!",

    sleep = {
        fail = {
            busy = "睡觉之前, Musha得先停下手中的活儿!",
            dark = "不可以, Musha会被查理抓走的!",
            indanger = "附近有危险, Musha还不能放松警惕。",
            hot = "太热啦!",
            cold = "Musha会被冻死的!",
            starving = "肚子好饿, Musha睡不着...",
        },
        poor = {
            "使不上力气...",
            "要昏过去了...",
            "头晕眼花...",
            "不行, Musha顶不住睡意了...",
            "先这样将就着..休息..一下吧...",
        },
        good = {
            "晚安, 伙伴们!",
            "Musha会做一个好梦。",
            "冒险途中偶尔休息一下也不坏呢。",
            "温暖的被窝, Musha喜欢!",
            "Musha要睡觉啦, 明天再努力吧!",
        },
        wakeup = {
            "到起床时间了吗...",
            "哈~~~~~欠!",
            "Musha准备好继续冒险了!",
            "姆咪缪缪... >_<",
            "休息时间结束~~!",
        },
        declarations = {
            quality = {
                string = "睡眠质量: [",
                poor = "低]",
                good = "中]",
                perfect = "高]",
            },
            fatigue = {
                string1 = "当前疲劳: [ ",
                string2 = "% ]",
            },
            melody = {
                string1 = "旋律充能: [ ",
                string2 = "% ]",
            },
        },
    },

    eatbymusha = {
        actionstrings = {
            GENERIC = "吃",
        }
    },

    skills = {
        press_to_confirm = "(确认: 再次按技能键)",
        incooldown = {
            part1 = "技能 [",
            part2 = "] 正在冷却, \n",
            part3 = "剩余冷却时间: [ ",
            part4 = " ] 秒",
        },
        ineffect = {
            part1 = "技能 [",
            part2 = "] 正在生效, \n",
            part3 = "剩余时间: [ ",
            part4 = " ] 秒, 是否取消?",
        },
        cooldownfinished = {
            part1 = "技能 [",
            part2 = "] 冷却完毕!",
        },
        manaspells = {
            actionstrings = {
                GENERIC = "施放法术",
                FREEZINGSPELL = "唤冰法咒",
                THUNDERSPELL = "雷霆法咒",
                SHADOWSPELL = "暗影波动",
                SHADOWPRISON = "暗影囚牢",
            },
            freezingspell = {
                name = "唤冰法咒",
                cast = "冰之精灵, 回应Musha的呼唤!",
                desc = "以角色为中心对周围大范围内目标叠加冰冻累计与减速debuff\n效果范围与冰冻累计随角色等级提升",
            },
            thunderspell = {
                name = "雷霆法咒",
                cast = "雷之精灵, 惩罚Musha的敌人!",
                desc = "以角色为中心对周围目标降下落雷，造成伤害并施加麻痹debuff\n效果范围与麻痹持续时间随角色等级提升",
            },
            shadowspell = {
                name = "暗影波动",
                desc = "以角色为中心对周围敌人造成多次范围逐渐扩大的AOE伤害，基础伤害随角色等级提升",
            },
            shadowprison = {
                name = "暗影囚牢",
                cast = "暗之精灵, 降下束缚的枷锁!",
                desc = "以角色为中心对周围目标降下影之枷锁，范围内的非友方单位将被困在原地无法行动",
            },
        },
        manashield = {
            name = "精灵护盾",
            broken = "敌人好凶, 护盾要碎掉了!",
            broken_other = "[精灵护盾] 耐久已耗尽",
            broken_manadepleted = "Musha已经没有足够的魔力来维持护盾了。",
        },
        princessblessing = {
            name = "公主庇佑",
            cast = "将精灵公主的加护传递给大家!",
        },
        valkyriemode = {
            name = "女武神模式",
            desc = "默认快捷键：R\n长按技能快捷键进行蓄力，蓄力完成后松开按键会施放[荒芜俯冲]并进入女武神模式\n女武神模式下被攻击时受到的伤害降低，同时会对除暗影阵营外的敌对生物造成额外伤害\n作为代价，女武神模式下疲劳值积累速度将大幅增加",
        },
        shadowmode = {
            name = "暗影模式",
        },
        sneak = {
            name = "潜影突袭",
            start = "潜行开始...",
            success = "融于暗影之中...",
            backstab_normal = "成功的背刺!",
            backstab_perfect = "完美的背刺!",
            stop = "现身!",
            failed = "Musha被敌人发现了!",
        },
        elfmelody = {
            name = "精灵旋律",
            progress1 = "旋律充能: [ ",
            progress2 = "% ]",
            full = "Musha已经准备好演奏 [精灵旋律] !\n(按 [ X ] 使用技能)",
            ask_part = "是否要消耗一部分 [精灵旋律] 进行短暂演奏?",
            ask_full = "是否要消耗全部 [精灵旋律] 进行完美演奏?",
        },
        treasuresniffing = {
            name = "宝藏嗅探",
            progress1 = "寻宝进度: [ ",
            progress2 = "% ]",
            full = "Musha已经准备好进行 [宝藏嗅探] !\n(按 [ X ] 使用技能)",
            ask = "是否要发动技能 [宝藏嗅探] ?",
            mount_not_allowed = "取消乘骑状态才可以发动技能 [宝藏嗅探]",
            find = "Musha发现了一个宝藏!",
            mark = "标记在地图上...",
            cannot_find_pos = "宝藏似乎弄丢了...再试一次吧!",
        },
        launchelement = {
            rollingmagma = {
                name = "沸滚熔岩",
                ready = "[沸滚熔岩] 准备就绪!",
            },
            whitefrost = {
                name = "奔涌白霜",
                ready = "[奔涌白霜] 准备就绪!",
            },
            poisonspore = {
                name = "孢子炸弹",
                ready = "[孢子炸弹] 准备就绪!",
            },
            bloomingfield = {
                name = "绽放之蕊",
                ready = "[绽放之蕊] 准备就绪!",
            },
        },
        lightningstrike = {
            name = "充能闪电",
            desc = "默认快捷键：R\n以雷电之力缠绕全身，使下一次攻击或伤害类技能造成额外雷属性伤害\n若耐力值足够，则会消耗耐力使下一次攻击距离增加"
        },
        setsugetsuka = {
            name = "雪月花",
            desc = "默认快捷键：G\n短暂蓄力后向鼠标所在位置发起冲锋，对距离角色最近的目标造成多段伤害\n若[充能闪电]攻击距离加成效果已激活, 则会提升最大冲锋距离",
        },
        phoenixadvent = {
            name = "凤来斩",
            desc = "默认快捷键：G\n无法直接使用，只有[雪月花]冲锋结束后的短时间内可以施放\n挥动武器短暂蓄力后横扫周围敌人，根据命中目标数量恢复耐力值",
        },
        setsugetsukaredux = {
            name = "里太刀·雪月花",
            desc = "雪月花冲锋结束后短时间内再次按下快捷键可以追加施放，最多连续冲锋三次",
        },
        boost_hana = {
            name = "花月轮舞",
            desc = "里太刀·雪月花三段冲锋分别会对目标施加减速、流血及麻痹状态"
        },
        boost_tsuki = {
            name = "月雪极狩",
            desc = "雪月花会依据目标最大生命值造成额外伤害"
        },
        boost_yuki = {
            name = "雪霰拂花",
            desc = "雪月花冲锋距离锁定为最大，无论充能闪电是否激活"
        },
        annihilation = {
            name = "歼灭锤",
            desc = "默认快捷键：R\n向鼠标所在位置发起一次强力跳劈\n若[充能闪电]已激活, 则会额外施加麻痹状态"
        },
        desolatedive = {
            name = "荒芜俯冲",
            desc = "默认快捷键：R\n长按进行蓄力，蓄力完成后向鼠标所在位置发起俯冲并对周围大范围内目标造成伤害"
        },
        magpiestep = {
            name = "鹊踏斩",
            desc = "默认快捷键：R\n无法直接使用，只有[攻击、被攻击、施放法术或使用技能]后的短时间内可以施放\n向鼠标所在位置快速踏跃, 期间角色处于无敌状态"
        },
        magpieslash = {
            name = "鹊踏斩·会心击",
            desc = "鹊踏斩会对沿途第一个目标造成伤害，若斩击成功发动则会额外恢复耐力值"
        },
        valkyrieparry = {
            name = "十方无敌",
            perfect = "就是现在!",
            desc = "默认快捷键：T\n长按快捷键可以进入格挡姿态, 受到攻击或蓄力完成后松开快捷键会向鼠标所在位置进行突刺，击退沿途敌人并造成伤害"
        },
        valkyrieparry_perfect = {
            name = "完美格挡",
            desc = "格挡姿态下在受到攻击的一瞬间松开快捷键则会触发完美弹反。完美弹反会恢复大量耐力值并召唤一道残影反击，同时获得[精灵护盾]效果"
        },
        valkyriewhirl = {
            name = "横扫千军",
            desc = "默认快捷键：G\n无法直接使用，只有[十方无敌]突刺结束后的短时间内可以施放\n地旋转身体并对周围敌人造成伤害、击退与打断效果"
        },
        shadowparry = {
            name = "影瞬身",
        },
        voidphantom = {
            name = "影幻刃",
        },
        phantomslash = {
            name = "影乱舞",
        },
        phantomblossom = {
            name = "影莲华",
        },
        phantomspells = {
            actionstrings = {
                GENERIC = "交换位置",
            },
            fail_notowner = "这个影子的主人并不是Musha。",
        },
        maxstamina1 = {
            name = "耐力提升I",
            desc = "提升耐力上限",
        },
        maxstamina2 = {
            name = "耐力提升II",
            desc = "进一步提升耐力上限",
        },
        maxstamina3 = {
            name = "耐力提升III",
            desc = "耐力上限额外随角色等级提升",
        },
        staminaregen1 = {
            name = "耐力回复I",
            desc = "提升耐力自然回复速度",
        },
        staminaregen2 = {
            name = "耐力回复II",
            desc = "进一步提升耐力自然回复速度",
        },
        maxmana1 = {
            name = "魔力提升I",
            desc = "提升魔力上限",
        },
        maxmana2 = {
            name = "魔力提升II",
            desc = "进一步提升魔力上限",
        },
        maxmana3 = {
            name = "魔力提升III",
            desc = "魔力上限额外随角色等级提升",
        },
        manaregen1 = {
            name = "魔力回复I",
            desc = "提升魔力自然回复速度",
        },
        manaregen2 = {
            name = "魔力回复II",
            desc = "进一步提升魔力自然回复速度",
        },
        maxhealth1 = {
            name = "生命提升I",
            desc = "提升生命上限",
        },
        maxhealth2 = {
            name = "生命提升II",
            desc = "进一步提升生命上限",
        },
        maxhealth3 = {
            name = "生命提升III",
            desc = "生命上限额外随角色等级提升",
        },
        maxsanity1 = {
            name = "理智提升I",
            desc = "提升理智上限",
        },
        maxsanity2 = {
            name = "理智提升II",
            desc = "进一步提升理智上限",
        },
        maxsanity3 = {
            name = "理智提升III",
            desc = "理智上限额外随角色等级提升",
        },
    },

    skilltrees = {
        general = {
            name = "通用技能",
        },
        princess = {
            name = "公主",
        },
        valkyrie = {
            name = "女武神",
        },
        shadow = {
            name = "暗影",
        },
    },

    equipments = {
        enchant_skill = "附魔技能",
        enchant_material_added = "附魔素材已添加",
        skill_unlocked = "已解锁技能",
        locked = "[未解锁]",
        material_required = "所需素材",
        weapon_broken = "武器已损坏",

        frosthammer = {
            enchants = {
                cast_spell = "♠ 召唤: 冰霜触手",
                cooling = "◇ 冷却体温",
                aura = "⊙ 光环: 极寒领域",
            },
            stopcoolinginwinter = "冬季开始, 降温功能已关闭"
        },
    },
}

---------------------------------------------------------------------------------------------------------

-- The character's name as appears in-game
STRINGS.NAMES.MUSHA = "Musha"

-- character select screen
STRINGS.CHARACTER_TITLES.musha = "精灵公主"
STRINGS.CHARACTER_NAMES.musha = "Musha"
STRINGS.CHARACTER_DESCRIPTIONS.musha = "[升级解锁技能]\n状态(L) 技能(K) 外貌(P)\n女武神(R) 影子(G) 护盾(C) 音乐(X) 睡觉(T) Yamche(Z,V,B)"
STRINGS.CHARACTER_QUOTES.musha = "我是真正的公主！"
STRINGS.CHARACTER_SURVIVABILITY.musha = "由你决定！"

-- Skins
STRINGS.SKIN_NAMES.musha_none = "通常"
STRINGS.SKIN_DESCRIPTIONS.musha_none = "默认状态，饱食度低于75%时自动触发\n"
STRINGS.SKIN_QUOTES.musha_none = "我是真正的公主！"
STRINGS.SKIN_NAMES.musha_full = "充盈"
STRINGS.SKIN_DESCRIPTIONS.musha_full = "充盈状态，饱食度高于75%时自动触发\n"
STRINGS.SKIN_QUOTES.musha_full = "吃饱饱，睡好好~"
STRINGS.SKIN_NAMES.musha_valkyrie = "女武神"
STRINGS.SKIN_DESCRIPTIONS.musha_valkyrie = "解锁条件：暂无，按R键触发\n"
STRINGS.SKIN_QUOTES.musha_valkyrie = "就让你见识，Musha真正的力量！"
STRINGS.SKIN_NAMES.musha_berserk = "狂暴"
STRINGS.SKIN_DESCRIPTIONS.musha_berserk = "解锁条件：暂无，按G键触发\n"
STRINGS.SKIN_QUOTES.musha_berserk = "狂暴状态，限制解除！"

STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.MUSHA = ("也许她能成为我书友会的成员。")
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.MUSHA = ("贵族的血？唔...")
STRINGS.CHARACTERS.WOODIE.DESCRIBE.MUSHA = ("她能变身？..不，也许不是")
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.MUSHA = ("她很弱..不过好像要帮我们。")
STRINGS.CHARACTERS.WENDY.DESCRIBE.MUSHA = ("我感觉强烈..")
STRINGS.CHARACTERS.WX78.DESCRIBE.MUSHA = ("我感到自己的心。")
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA = {
    GENERIC = "感觉很好！",
    ATTACKER = "战斗 战斗 战斗",
    MURDERER = "谋杀！",
    REVIVER = "回来..",
    GHOST = "走开！",
}

STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.RUMMAGE.MUSHA_NOT_OWNER = "我想它的主人不希望我这样做。"

STRINGS.NAMES.SHADOWMUSHA = "影子Musha"
STRINGS.NAMES.SHADOWMUSHA_BUILDER = "影子Musha"
STRINGS.RECIPE_DESC.SHADOWMUSHA_BUILDER = "召唤自己阴影中的另一面。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHADOWMUSHA = "影子看起来和Musha一模一样。"

---------------------------------------------------------------------------------------------------------

--translated by deloquac
--status
STRINGS.MUSHA_LEVEL_NEXT_LEVEL_UP = "下一等级提升"
STRINGS.MUSHA_LEVEL_LEVEL = "等级"
STRINGS.MUSHA_LEVEL_EXP = "[经验]"
STRINGS.MUSHA_LEVEL_SLEEP = "体力"
STRINGS.MUSHA_LEVEL_TIRED = "疲劳"
STRINGS.MUSHA_LEVEL_MUSIC = "音乐"
STRINGS.MUSHA_LEVEL_SNIFF = "嗅觉"
STRINGS.MUSHA_SLEEP_TIRED = "[体力 ◑ 疲劳]"
STRINGS.MUSHA_VISUAL_BASE = "[默认外貌]"
STRINGS.MUSHA_BADGE_SLEEP = "[体力提示]"
STRINGS.MUSHA_YAMCHE_DEBUG = "[调试]\n扔下全部物品"
STRINGS.MUSHA_MUSIC_DYNAMIC = "[动态音乐]♪\n：随机"
STRINGS.MUSHA_MUSIC_DYNAMIC_OFF = "[动态音乐]♪\n：关闭"
STRINGS.MUSHA_DEATH_PENALTY = "[死亡]\n[经验]"

STRINGS.MUSHA_SKILL_ACTIVE        = "[------主动技能------]"
STRINGS.MUSHA_SKILL_SLEEP         = "睡觉◑醒来  "
STRINGS.MUSHA_SKILL_POWER         = "闪电攻击    "
STRINGS.MUSHA_SKILL_SHIELD        = "火焰护盾	 "
STRINGS.MUSHA_SKILL_MUSIC         = "音乐♪       "
STRINGS.MUSHA_SKILL_SHADOW        = "隐身  影子  "
STRINGS.MUSHA_SKILL_PASSIVE       = "[------被动技能------] "
STRINGS.MUSHA_SKILL_VALKYR        = "女武神状态  "
STRINGS.MUSHA_SKILL_BERSERK       = "狂暴状态     "
STRINGS.MUSHA_SKILL_ELECTRA       = "带电护盾     "
STRINGS.MUSHA_SKILL_CRITIC        = "致命一击     "
STRINGS.MUSHA_SKILL_DOUBLE        = "双倍伤害     "
STRINGS.MUSHA_T_SKILL_UNLOCK      = "解锁： "
STRINGS.MUSHA_T_SKILL_VALKYRIE    = "女武神状态"
STRINGS.MUSHA_T_SKILL_V_LIGHTNING = "自动闪电"
STRINGS.MUSHA_T_SKILL_V_POWER     = "闪电攻击"
STRINGS.MUSHA_T_SKILL_V_ARMOR     = "女武神护甲"
STRINGS.MUSHA_T_SKILL_V_LIGHTNING = "女武神闪电"
STRINGS.MUSHA_T_SKILL_UP_ACTIVE   = "升级 [主动技能]"
STRINGS.MUSHA_T_SKILL_CRITICAL    = "致命一击"
STRINGS.MUSHA_T_SKILL_E_SHIELD    = "带电护盾"
STRINGS.MUSHA_T_SKILL_BERSERK     = "狂暴状态"
STRINGS.MUSHA_T_SKILL_B_ARMOR     = "狂暴护甲"
STRINGS.MUSHA_T_SKILL_DOUBLE      = "双倍伤害"

--TALK
STRINGS.MUSHA_TALK_READY_POISON = "带毒攻击已经准备好！"
STRINGS.MUSHA_TALK_CANCEL_POISON = "Musha改变主意.."
STRINGS.MUSHA_TALK_NEED_SANITY = "需要更多 [SAN].."
STRINGS.MUSHA_TALK_NEED_SLEEPY = "Musha无法集中精神。太困了.."
STRINGS.MUSHA_TALK_NEED_SLEEP = "Musha需要睡觉！"
STRINGS.MUSHA_TALK_NEED_EXP = "需要更多经验值！"

STRINGS.MUSHA_TALK_GRRR = "嗷...！"
STRINGS.MUSHA_TALK_GHOST_REVENGE = "噢！复仇！！"
STRINGS.MUSHA_TALK_GHOST_OOOOHHHH = "噢噢噢！！"
STRINGS.MUSHA_TALK_GHOST_OOOOH = "噢噢...."
STRINGS.MUSHA_TALK_GHOST_MUSIC = "噢~♪ 噢嗷嗷~♪"
STRINGS.MUSHA_TALK_GHOST_SLEEP = " .. 好困啦 .. "
STRINGS.MUSHA_TALK_GHOST_FOLLOW = "跟着我..."
STRINGS.MUSHA_TALK_GHOST_STAY = "站住..."
STRINGS.MUSHA_TALK_GHOST_GATHER = "集合..."
STRINGS.MUSHA_TALK_GHOST_STOP = "停下来..."

STRINGS.MUSHA_TALK_SHIELD_COOL_90 = "[护盾]\n冷却 -[90秒]"
STRINGS.MUSHA_TALK_SHIELD_COOL_80 = "[护盾]\n冷却 -[80秒]"
STRINGS.MUSHA_TALK_SHIELD_COOL_70 = "[护盾]\n冷却 -[70秒]"
STRINGS.MUSHA_TALK_SHIELD_COOL_60 = "[护盾]\n冷却 -[60秒]"
STRINGS.MUSHA_TALK_SHIELD_FULL = "[护盾]准备就绪"
STRINGS.MUSHA_TALK_TREASURE_FIRST = "奇怪的地方！！"
STRINGS.MUSHA_TALK_TREASURE_YAMCHE = "Musha闻到了花鸟的气味。"
STRINGS.MUSHA_TALK_TREASURE_FAILED = "它不见了.. \n 也许我可以再试一次.."
STRINGS.MUSHA_TALK_TREASURE_FAR = "气味来自很远的地方.."
STRINGS.MUSHA_TALK_TREASURE_MED = "气味可能不那么远.."
STRINGS.MUSHA_TALK_TREASURE_NEAR = "它在附近！！"
STRINGS.MUSHA_TALK_TREASURE_SMELL = "什么味道？？"
STRINGS.MUSHA_TALK_TREASURE_SNIFF = "也许这是宝物的气味.."
STRINGS.MUSHA_TALK_TREASURE_FOUND = "[Musha发现了什么！]"
STRINGS.MUSHA_TALK_TREASURE_MARK = "[标记在地图上..]"

STRINGS.MUSHA_TALK_MUSIC_READY = "Musha准备好 [表演♪]"
STRINGS.MUSHA_TALK_MUSIC_RIDE = "Musha不能调戏牛牛.."
STRINGS.MUSHA_TALK_MUSIC_TYPE = "看我！\n音乐♪[类型]： "

STRINGS.MUSHA_TALK_SLEEP_NO_1 = "你好？"
STRINGS.MUSHA_TALK_SLEEP_NO_2 = "早上好？"
STRINGS.MUSHA_TALK_SLEEP_NO_3 = "太亮了.."
STRINGS.MUSHA_TALK_SLEEP_NO_4 = "起来了Musha。"
STRINGS.MUSHA_TALK_SLEEP_NO_5 = "睡觉？不.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_0 = "头晕目眩.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_1 = "有点晕晕的.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_2 = "好累.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_3 = "Musha睡死了.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_4 = "看不见东西.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_5 = "Musha要休息了.."
STRINGS.MUSHA_TALK_SLEEP_DIZZY_6 = "好困.."
STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_1 = "好暗.."
STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_2 = "需要亮一点！"
STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_3 = "黑暗太危险了.."
STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_4 = "Musha必须找到火！"
STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_5 = "Musha需要火！"
STRINGS.MUSHA_TALK_SLEEP_GOOD_1 = "总是困......"
STRINGS.MUSHA_TALK_SLEEP_GOOD_2 = "很高兴"
STRINGS.MUSHA_TALK_SLEEP_GOOD_3 = "喜欢温暖"
STRINGS.MUSHA_TALK_SLEEP_GOOD_4 = "甜蜜的梦"
STRINGS.MUSHA_TALK_SLEEP_GOOD = "[好的睡眠]"
STRINGS.MUSHA_TALK_SLEEP_DANGER_1 = "好像有危险。"
STRINGS.MUSHA_TALK_SLEEP_DANGER_2 = "Musha感觉有点不对.."
STRINGS.MUSHA_TALK_SLEEP_DANGER_3 = "这地方不是我的坟墓。"
STRINGS.MUSHA_TALK_SLEEP_DANGER_4 = "..听到什么.."
STRINGS.MUSHA_TALK_SLEEP_DANGER_5 = "不！起来！"

STRINGS.MUSHA_TALK_SNEAK_UNHIDE = "现身！"
STRINGS.MUSHA_TALK_SNEAK_NO_TARGET = "它不是生物"
STRINGS.MUSHA_TALK_SNEAK_SUCCESS = "成功的背刺！"
STRINGS.MUSHA_TALK_SNEAK_FROZEN = "冰冻目标： [伤害减半]"
STRINGS.MUSHA_TALK_SNEAK_FAILED = "失败的背刺.."
STRINGS.MUSHA_TALK_SNEAK_ATTACKED = "敌人发现我了！"
STRINGS.MUSHA_TALK_SNEAK_NEED_EXP = "Musha无法 [隐藏]..\n(需要等级： 5)"
STRINGS.MUSHA_TALK_SNEAK_HIDE = "隐藏"
STRINGS.MUSHA_TALK_SNEAK_SHADOW = "你看不到Musha！"
--PET
STRINGS.MUSHA_TALK_THIEF_1 = "[ 别碰我..]"
STRINGS.MUSHA_TALK_THIEF_2 = "[ 走开！]"
STRINGS.MUSHA_TALK_THIEF_3 = "[ 猴子..]"
STRINGS.MUSHA_TALK_THIEF_4 = "[ 小偷！]"
STRINGS.MUSHA_TALK_FOLLOW = "[我喜欢跟着..]"
STRINGS.MUSHA_HEALTH_MAX = "[生命上限]"
STRINGS.MUSHA_TALK_EXP_EXTRA = "额外 [经验](+1)"
STRINGS.MUSHA_TALK_GROWUP_NEXT = "下一级[成长]"
STRINGS.MUSHA_TALK_GROWUP = "[成长]"
STRINGS.MUSHA_TALK_YAM_COME = "来吧，Yamche！"
STRINGS.MUSHA_YAMCHE_FOOD = "食 食物？"
STRINGS.MUSHA_YAMCHE_FOO = "食 ？"
STRINGS.MUSHA_YAMCHE_FOOOD = "食 食物！"
STRINGS.MUSHA_YAMCHE_FOOOOD = "食食食物物物！"
STRINGS.MUSHA_YAMCHE_HEAL = "Kkuu"
STRINGS.MUSHA_YAMCHE_GREETING_1 = "[Musha！]"
STRINGS.MUSHA_YAMCHE_GREETING_2 = "[我跟着你]"
STRINGS.MUSHA_YAMCHE_GREETING_3 = "[开心]"
STRINGS.MUSHA_YAMCHE_GREETING_4 = "[我想你]"
STRINGS.MUSHA_YAMCHE_GREETING_5 = "[我看见你了]"
STRINGS.MUSHA_YAMCHE_GREETING_6 = "[Musha选我]"
STRINGS.MUSHA_YAMCHE_GREETING_7 = "[我爱Musha]"
STRINGS.MUSHA_YAMCHE_GREETING_8 = "[走 走]"
STRINGS.MUSHA_YAMCHE_GREETING_9 = "[喜欢你]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_FOLLOW = "Yamche，跟着我！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_STAY = "Yamche，呆在这"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_SLEEPY = "他好像很困.."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_EGG = "他需要休息.."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_LOST = "Musha不能呼唤到Yamche.."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER = "Yamche，收集物品"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER_STOP = "停止收集"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_SHOWME = "Yamche，给我看看你的收集"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_DROP = "[全部扔下]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY = "饥饿速度"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF = "[收集物品]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT = "光◎[开]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT_OFF = "光◎[关]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_WORKING = "[工作中..]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_SLEEP = "[睡觉中..]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_SLEEPY = "好困..."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST = "[生命] 消耗："
STRINGS.MUSHA_TALK_ORDER_YAMCHE_COST_HUNGER = "[饥饿] 消耗：-5"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHTNING = "发光[开]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_ON = "营火-(开)"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_CAMPFIRE_OFF = "营火-(关)"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_FIRE_WARM = "[♨]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_FIRE_COLD = "[※]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_DANGER = "危险！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_OVEN = "[♨]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_FREEZER = "[※]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV = "[收集]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_INV_FULL = "[收集-已满]"
STRINGS.MUSHA_TALK_YAMCHE_REVIVE_D = "他太年轻了.."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_SHIELD_COOL = "[护盾]\n冷却 -[300秒]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_HEALTH_WARN1 = "[生命：低于(20%)]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_HEALTH_WARN2 = "[生命：低于(10%)]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST = "[休息]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNT = "Yamche，狩猎开始！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_OFFENSE = "[进攻]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_PROTECT = "Yamche，保护我！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_DEFFENSE = "[防御]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_RETREAT = "Yamche，回避战斗！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID = "[回避]"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_BERSERK = "退后！嗷！"
STRINGS.MUSHA_TALK_ORDER_YAMCHE_GHOST = "唔..不要怕.."
STRINGS.MUSHA_TALK_ORDER_DALL_FOLLOW = "Dall，跟着我！"
STRINGS.MUSHA_TALK_ORDER_DALL_STAY = "Dall，呆在这"
STRINGS.MUSHA_TALK_ORDER_DALL_SLEEPY = "他好像很困.."
STRINGS.MUSHA_TALK_ORDER_DALL_LOST = "Musha不能呼唤到Dall.."

STRINGS.MUSHA_TALK_ORDER_ARONG_FOLLOW = "Arong，跟着我！"
STRINGS.MUSHA_TALK_ORDER_ARONG_STAY = "Arong，呆在这"
STRINGS.MUSHA_TALK_ORDER_ARONG_SLEEPY = "他需要休息.."
STRINGS.MUSHA_TALK_ORDER_ARONG_LOST = "Musha不能呼唤到Arong.."

--bodyguard wilson
STRINGS.MUSHA_TALK_WILSON_DANGER_1 = "是时候战斗了。"
STRINGS.MUSHA_TALK_WILSON_DANGER_2 = "小心，Musha"
STRINGS.MUSHA_TALK_WILSON_DANGER_3 = "准备战斗！"
STRINGS.MUSHA_TALK_WILSON_DANGER_4 = "我们得在一起。"
STRINGS.MUSHA_TALK_WILSON_DANGER_5 = "别担心，公主！"
STRINGS.MUSHA_TALK_WILSON_DANGER_6 = "Musha，我会保护你。"
STRINGS.MUSHA_TALK_WILSON_RANDOM_1 = "Musha！我在这！！"
STRINGS.MUSHA_TALK_WILSON_RANDOM_2 = "Musha！！"
STRINGS.MUSHA_TALK_WILSON_RANDOM_3 = "Musha！我会帮你！！"
STRINGS.MUSHA_TALK_WILSON_RANDOM_4 = "Musha！我听到你的声音了！！"
STRINGS.MUSHA_TALK_WILSON_RANDOM_5 = "别担心，公主！"
STRINGS.MUSHA_TALK_WILSON_RANDOM_6 = "Musha，我会保护你！！"
STRINGS.MUSHA_TALK_WILSON_MUSHA_1 = "威尔逊！！"
STRINGS.MUSHA_TALK_WILSON_MUSHA_2 = "你救了我！！"
STRINGS.MUSHA_TALK_WILSON_MUSHA_3 = "谢谢你！"
STRINGS.MUSHA_TALK_WILSON_MUSHA_4 = "来得正好！"
STRINGS.MUSHA_TALK_WILSON_MUSHA_5 = "我想你了"
STRINGS.MUSHA_TALK_WILSON_MUSHA_6 = "很好！"
STRINGS.MUSHA_TALK_WILSON_BYE_W = "时间到了，再见，Musha.."
STRINGS.MUSHA_TALK_WILSON_BYE_1 = "谢谢你威尔逊.."
STRINGS.MUSHA_TALK_WILSON_BYE_2 = "再见.."
STRINGS.MUSHA_TALK_WILSON_BYE_3 = "拜拜.."
STRINGS.MUSHA_TALK_WILSON_BYE_4 = "谢谢你。"
STRINGS.MUSHA_TALK_WILSON_FAILED = "噢不.."

STRINGS.MUSHA_TALK_WILSON_C_R_1 = "我是的你剑刃。"
STRINGS.MUSHA_TALK_WILSON_C_R_2 = "跟随你"
STRINGS.MUSHA_TALK_WILSON_C_R_3 = "我很酷"
STRINGS.MUSHA_TALK_WILSON_C_R_4 = "去？"
STRINGS.MUSHA_TALK_WILSON_C_R_5 = "冒险在等着我们。"
STRINGS.MUSHA_TALK_WILSON_C_R_6 = "我们停下来？"
STRINGS.MUSHA_TALK_WILSON_C_R_7 = "有趣.."
STRINGS.MUSHA_TALK_WILSON_C_R_8 = "如果可以，叫我绝地武士。"
STRINGS.MUSHA_TALK_WILSON_C_R_9 = "那是什么？噢..一只小鸟.."
STRINGS.MUSHA_TALK_WILSON_C_R_10 = "伟大的冒险。"

STRINGS.MUSHA_TALK_WILSON_C_NIGHT_1 = "黑暗来临.."
STRINGS.MUSHA_TALK_WILSON_C_NIGHT_2 = "别担心，我会在你身边。"
STRINGS.MUSHA_TALK_WILSON_C_NIGHT_3 = "小心，Musha"
STRINGS.MUSHA_TALK_WILSON_C_NIGHT_4 = "我们准备好迎接黑暗。"
STRINGS.MUSHA_TALK_WILSON_C_NIGHT_5 = "晚安，好运。"
STRINGS.MUSHA_TALK_WILSON_C_NIGHT_6 = "晚上了..\n我们需要睡觉。"

STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_1 = "我肚子饿了。"
STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_2 = "我想要吃东西。"
STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_3 = "我需要零食。"
STRINGS.MUSHA_TALK_WILSON_C_HUNGRY_4 = "如果我肚饿就要回家。"

STRINGS.MUSHA_TALK_WILSON_FIGHT_1 = "死吧，怪兽！！"
STRINGS.MUSHA_TALK_WILSON_FIGHT_2 = "来！"
STRINGS.MUSHA_TALK_WILSON_FIGHT_3 = "闪电！！"
STRINGS.MUSHA_TALK_WILSON_FIGHT_4 = "科学的力量！"
STRINGS.MUSHA_TALK_WILSON_FIGHT_5 = "看我的厉害！！"

STRINGS.MUSHA_TALK_WILSON_FULL_1 = "我不是猪人。"
STRINGS.MUSHA_TALK_WILSON_FULL_1 = "不用，谢谢。"
STRINGS.MUSHA_TALK_WILSON_FULL = "我饱了。"

--chat1
STRINGS.MUSHA_TALK_WILSON_C1_1 = "我很酷，不是吗？"
STRINGS.MUSHA_TALK_WILSON_C1_2 = "..."
STRINGS.MUSHA_TALK_WILSON_C1_3 = "Musha，你真是漂亮的女孩。"
STRINGS.MUSHA_TALK_WILSON_C1_4 = "好吧，你挺酷的。"
--chat2
STRINGS.MUSHA_TALK_WILSON_C2_1 = "Musha，你真漂亮。"
STRINGS.MUSHA_TALK_WILSON_C2_2 = "你饿了吗？"
--chat3
STRINGS.MUSHA_TALK_WILSON_C3_1 = "什么味道？"
STRINGS.MUSHA_TALK_WILSON_C3_2 = "..什么味道？"
STRINGS.MUSHA_TALK_WILSON_C3_3 = "抱歉是我。"
STRINGS.MUSHA_TALK_WILSON_C3_4 = "Musha知道。"
--chat4
STRINGS.MUSHA_TALK_WILSON_C4_1 = "等一下。"
STRINGS.MUSHA_TALK_WILSON_C4_2 = "为什么？"
STRINGS.MUSHA_TALK_WILSON_C4_3 = "..."
--chat5
STRINGS.MUSHA_TALK_WILSON_C5_1 = "Musha，我们在这休息嘛？"
STRINGS.MUSHA_TALK_WILSON_C5_2 = "不，我们得继续.."
STRINGS.MUSHA_TALK_WILSON_C5_3 = "好吧..我们得休息。"
--chat6
STRINGS.MUSHA_TALK_WILSON_C6_1 = "Musha，我能买你的Yamche吗？"
STRINGS.MUSHA_TALK_WILSON_C6_2 = "Yamche是朋友。"
STRINGS.MUSHA_TALK_WILSON_C6_3 = "好吧，你要买我吗？如果你想。"
STRINGS.MUSHA_TALK_WILSON_C6_4 = "我不想.."
--chat7
STRINGS.MUSHA_TALK_WILSON_C7_1 = "Musha，我要怎样才能得到凤凰？"
STRINGS.MUSHA_TALK_WILSON_C7_2 = "试试用铲子挖泥土。"
STRINGS.MUSHA_TALK_WILSON_C7_3 = "你在开玩笑吗？..真的吗？"
--chat8
STRINGS.MUSHA_TALK_WILSON_C8_1 = "你真漂亮。嫁给我吧？"
STRINGS.MUSHA_TALK_WILSON_C8_2 = "不要。"
--chat9
STRINGS.MUSHA_TALK_WILSON_C9_1 = "小狗和鸟和天才。"
STRINGS.MUSHA_TALK_WILSON_C9_2 = "谁是天才？"
STRINGS.MUSHA_TALK_WILSON_C9_3 = "...当然是你。"
STRINGS.MUSHA_TALK_WILSON_C9_4 = "你是个出色的生存大师。"

STRINGS.MUSHA_TALK_HUNGRY = "好饿.."
STRINGS.MUSHA_TALK_BERSERK = "..感受我的力量.."
STRINGS.MUSHA_TALK_KILL_EPIC = "[ 杀掉稀有怪物 ]"
STRINGS.MUSHA_TALK_KILL_GIANT = "[ 杀掉巨人 ]"
STRINGS.MUSHA_TALK_COFFEE_1 = "这是咖啡！"
STRINGS.MUSHA_TALK_COFFEE_2 = "闻起来不错！"
STRINGS.MUSHA_TALK_COFFEE_3 = "好极了！"
STRINGS.MUSHA_TALK_FOOD_EXP = "美味！！\n [经验] + 25"
STRINGS.MUSHA_TALK_FOOD_BAD_1 = "难吃！"
STRINGS.MUSHA_TALK_FOOD_BAD_2 = "超难吃！"
STRINGS.MUSHA_TALK_FOOD_BAD_3 = "在我口中留下恶心的味道。"
STRINGS.MUSHA_TALK_FOOD_BAD_4 = "这食物不合我口味.."
STRINGS.MUSHA_TALK_FOOD_BAD_MEAT = "Musha不喜欢肉的味道.."
STRINGS.MUSHA_TALK_FOOD_BAD_VEGGIE = "Musha不喜欢蔬菜的味道.."
STRINGS.MUSHA_TALK_FOOD_OLD_1 = "..不能闻！"
STRINGS.MUSHA_TALK_FOOD_OLD_2 = "旧食物..."
STRINGS.MUSHA_TALK_FOOD_OLD_3 = "不新鲜.."
STRINGS.MUSHA_TALK_FOOD_BUG_1 = "这是虫子！"
STRINGS.MUSHA_TALK_FOOD_BUG_2 = "在我口中留下恶心的味道。"
STRINGS.MUSHA_TALK_FOOD_BUG_3 = "为什么Musha要吃虫子？"
STRINGS.MUSHA_TALK_FOOD_MONSTER_1 = "怪物肉不合我口味.."
STRINGS.MUSHA_TALK_FOOD_MONSTER_2 = "Musha不喜欢怪物的味道.."
STRINGS.MUSHA_TALK_FOOD_VEGE = "..甚至可以吃蔬菜。"
STRINGS.MUSHA_TALK_FOOD_MEAT = "..甚至可以吃肉。"

STRINGS.MUSHA_TALK_FORGE_ON = "[锻造]-(开)"
STRINGS.MUSHA_TALK_FORGE_OFF = "[锻造]-(关)"

STRINGS.MUSHA_TALK_CANNOT1 = "Musha现在不能做。"
STRINGS.MUSHA_TALK_CANNOT2 = "Musha现在不能做。\n[冰霜触手]：限制召唤"
--Items
STRINGS.MUSHA_TALK_FORGE_LUCKY = "[锻造 ]"
STRINGS.MUSHA_ITEM_GROWPOINTS = "成长点数☆"
STRINGS.MUSHA_ITEM_LUCKY = "幸运点数★"
STRINGS.MUSHA_ITEM_DUR = "耐久度"
STRINGS.MUSHA_ITEM_LIGHT = "光◎"
STRINGS.MUSHA_ITEM_SPEED = "加速▲"
STRINGS.MUSHA_ITEM_SPEED_DOWN = "减速▼"
STRINGS.MUSHA_ITEM_REGEN = "再生♥"
STRINGS.MUSHA_ITEM_SANITY_REGEN = "SAN恢复♤"
STRINGS.MUSHA_ITEM_WARMNCOOL = "♣温暖和凉快◇"
STRINGS.MUSHA_ITEM_WARM = "温暖♣"
STRINGS.MUSHA_ITEM_COOL = "凉快◇"
STRINGS.MUSHA_ITEM_FREEZE = "冻结※"
STRINGS.MUSHA_ITEM_SHIELD = "[护盾打开]"
STRINGS.MUSHA_ITEM_SHIELD_BROKEN = "[护盾损坏]"

STRINGS.MUSHA_UPGRADE = "进化"
STRINGS.MUSHA_WEAPON = "[武器]"
STRINGS.MUSHA_WEAPON_DAMAGE = "伤害"
STRINGS.MUSHA_WEAPON_FIRE = "火焰◀"
STRINGS.MUSHA_WEAPON_DARK = "暗火◀"
STRINGS.MUSHA_WEAPON_FIRE_D = "火焰伤害◀"
STRINGS.MUSHA_WEAPON_FROST = "冰霜※"
STRINGS.MUSHA_WEAPON_BLINK = "闪现◈"
STRINGS.MUSHA_WEAPON_BLOOD = "血毒⊙"
STRINGS.MUSHA_WEAPON_POISON = "毒⊙"
STRINGS.MUSHA_WEAPON_SANITY = "SAN吸收♠"
STRINGS.MUSHA_WEAPON_FROST_RELEASE = "[ 释放冰霜 ]"
STRINGS.MUSHA_WEAPON_FROST_PRESERVED = "[ 保存冰霜 ]"
STRINGS.MUSHA_WEAPON_AREA = "▣ 范围攻击"
STRINGS.MUSHA_WEAPON_FROZENSHARD = "冰刺※"
STRINGS.MUSHA_WEAPON_TENTACLE_FROST = "⊙ 冰霜触手"
STRINGS.MUSHA_WEAPON_WINTERCOST = "◇ 冬天(无消耗)"
STRINGS.MUSHA_WEAPON_COOLER = "◇ 冷却器(有消耗)"
STRINGS.MUSHA_WEAPON_FREEZESLOW = "※ 冻结和减速"

STRINGS.MUSHA_HAT_BROKEN = "损坏的帽子"
STRINGS.MUSHA_HAT_BROKEN_C = "损坏的皇冠"
STRINGS.MUSHA_HAT_PRINCESS = "公主皇冠"
STRINGS.MUSHA_HAT_QUEEN = "女王皇冠"
STRINGS.MUSHA_HAT_BUNNY = "兔子侦查帽"
STRINGS.MUSHA_HAT_BUNNYA = "钢铁兔子帽"
STRINGS.MUSHA_HAT_CAT = "钢铁猫"
STRINGS.MUSHA_HAT_PHOENIX = "凤凰头盔"

STRINGS.MUSHA_ARMOR = "护甲值"
STRINGS.MUSHA_ARMOR_BROKEN = "损坏的盔甲"
STRINGS.MUSHA_ARMOR_MUSHAA = "Musha的盔甲"
STRINGS.MUSHA_ARMOR_MUSHAB = "公主的盔甲"
STRINGS.MUSHA_ARMOR_FROST = "冰霜战甲"
STRINGS.MUSHA_ARMOR_PIRATE = "海盗箱子"

STRINGS.MUSHA_WEAPON_BROKEN = "损坏的武器"
STRINGS.MUSHA_WEAPON_BROKEN_TALK = "坏掉了！"
STRINGS.MUSHA_WEAPON_SWORD_BASE = "损坏的剑"
STRINGS.MUSHA_WEAPON_SWORD_BASE_UP = "原型剑"
STRINGS.MUSHA_WEAPON_SWORD_FIRE = "凤凰剑"
STRINGS.MUSHA_WEAPON_SWORD_FROST = "冰霜剑"
STRINGS.MUSHA_WEAPON_SWORD_AXE = "凤凰斧"
STRINGS.MUSHA_WEAPON_SWORD_PAXE = "凤凰镐"
STRINGS.MUSHA_WEAPON_SWORD_SPEAR = "凤凰长剑"
STRINGS.MUSHA_WEAPON_SPEAR_FIRE = "火焰长剑"
STRINGS.MUSHA_WEAPON_SPEAR_FROST = "冰霜长剑"
STRINGS.MUSHA_WEAPON_SWORD_BOW = "剑-弓"
STRINGS.MUSHA_WEAPON_FROSTHAMMER = "冰霜之锤"
STRINGS.MUSHA_WEAPON_BB_VIPER = "毒蛇"
STRINGS.MUSHA_WEAPON_BB_BOW = "阳光"
STRINGS.MUSHA_WEAPON_BB_ARROWS = "- 没有箭 -"
STRINGS.MUSHA_WEAPON_SWORD_POWER_1 = "[ 能量剑刃 I ]"
STRINGS.MUSHA_WEAPON_SWORD_POWER_2 = "[ 能量剑刃 II ]"
STRINGS.MUSHA_WEAPON_SWORD_POWER_3 = "[ 能量剑刃 III ]"
STRINGS.MUSHA_WEAPON_SWORD_POWER_OFF = "能量关闭"

--description

STRINGS.NAMES.PIRATEBACK = "海盗箱子"
STRINGS.RECIPE_PIRATEBACK = "亡灵宝藏"
STRINGS.RECIPE_DESC.PIRATEBACK = "亡灵宝藏\n- 戴维琼斯 -"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PIRATEBACK = "嗯..Musha决对不会把我的心放进这个箱子."

STRINGS.NAMES.MUSHA_OVEN = "青蛙烤箱"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_OVEN = "看起来像青蛙！"
STRINGS.RECIPE_MUSHA_OVEN = "青蛙烤箱"
STRINGS.RECIPE_DESC.MUSHA_OVEN = "温暖还是寒冷\n烤箱还是冰箱"

STRINGS.NAMES.TENT_MUSHA = "Musha的帐篷"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TENT_MUSHA = "温暖的家"
STRINGS.RECIPE_TENT_MUSHA = "离开帐篷"
STRINGS.RECIPE_DESC.TENT_MUSHA = "帐篷，灯笼"

STRINGS.NAMES.FORGE_MUSHA = "Musha的熔炉"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORGE_MUSHA = "让我们升级物品！"
STRINGS.RECIPE_FORGE_MUSHAA = "锻造升级"
STRINGS.RECIPE_DESC.FORGE_MUSHA = "锻造，灯笼，烤箱"

STRINGS.NAMES.MUSHA_HUT = "茅草棚"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_HUT = "很舒服！"
STRINGS.MUSHA_HUT = "茅草棚"
STRINGS.RECIPE_DESC.MUSHA_HUT = "躲雨处"

STRINGS.NAMES.GREEN_APPLE_PLANT = "苹果植物"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREEN_APPLE_PLANT = "很好闻"
STRINGS.NAMES.GREEN_FRUIT = "咖啡因苹果"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREEN_FRUIT = "这非常好！"
STRINGS.NAMES.GREEN_FRUIT_COOKED = "奶油苹果"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREEN_FRUIT_COOKED = "太棒了！"
STRINGS.NAMES.GREENWORM = "苹果怪兽"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREENWORM = "难闻.."
STRINGS.NAMES.GWORM = "绿怪兽"
STRINGS.NAMES.GWORM_PLANT = "苹果植物"
STRINGS.NAMES.GWORM_DIRT = "泥土"
STRINGS.NAMES.TUNACAN = "金枪鱼"
STRINGS.RECIPE_DESC.TUNACAN = "罐头食物，金枪鱼含量 0.001%"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TUNACAN = "装在铁罐里的食物！"
STRINGS.NAMES.TUNACAN_MUSHA = "金枪鱼"
STRINGS.RECIPE_DESC.TUNACAN_MUSHA = "罐头食物，金枪鱼含量 0.001%"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TUNACAN_MUSHA = "装在铁罐里的食物！"

STRINGS.NAMES.MUSHA_EGG_RANDOM = "超级凤凰蛋"
STRINGS.NAMES.MUSHA_EGG_RANDOM_CRACKED = "超级凤凰蛋"
STRINGS.NAMES.MUSHA_EGG_ARONG = "毛茸茸的蛋"
STRINGS.NAMES.MUSHA_EGG_CRACKED_ARONG = "毛茸茸的蛋"
STRINGS.NAMES.MUSHA_EGG = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG_CRACKED = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGGS1 = "凤凰蛋(2级)"
STRINGS.NAMES.MUSHA_EGG_CRACKEDS1 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGGS2 = "凤凰蛋(3级)"
STRINGS.NAMES.MUSHA_EGG_CRACKEDS2 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGGS3 = "凤凰蛋(4级)"
STRINGS.NAMES.MUSHA_EGG_CRACKEDS3 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG1 = "凤凰蛋(5级)"
STRINGS.NAMES.MUSHA_EGG_CRACKED1 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG2 = "凤凰蛋(6级)"
STRINGS.NAMES.MUSHA_EGG_CRACKED2 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG3 = "凤凰蛋(7级)"
STRINGS.NAMES.MUSHA_EGG_CRACKED3 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG8 = "凤凰蛋(8级)"
STRINGS.NAMES.MUSHA_EGG_CRACKED8 = "凤凰蛋"
STRINGS.NAMES.MUSHA_EGG = "凤凰蛋"

STRINGS.NAMES.MUSHA_SPORE_FIRE = "火精灵"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_SPORE_FIRE = "这在冬天会很温暖。"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_ARONG = "毛茸茸的蛋"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_RANDOM = "超级凤凰蛋"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG = "凤凰蛋"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGGS1 = "凤凰蛋(2级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGGS2 = "凤凰蛋(3级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGGS3 = "凤凰蛋(4级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG1 = "凤凰蛋(5级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG2 = "凤凰蛋(6级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG3 = "凤凰蛋(7级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG8 = "凤凰蛋(8级)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKED = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKEDS1 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKEDS2 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKEDS3 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKED1 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKED2 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKED3 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_EGG_CRACKED8 = "不是我的。Musha说那是Yamche的花蕾。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARONG_BABY = "我的交通工具快长大吧！\n命令：(F1)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARONG = "世界上最快的牛牛！！\n命令：(F1)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AROM = "世界上最快的女孩！！\n命令：(F1)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOONTREE_MUSHA = "他是 '月亮树'.\n在古语中指的是桂树.\n命令：(F2)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOONNUTDRAKE = "国王的仆人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOONNUTDRAKE2 = "他们来自哪儿？"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOONLIGHT_PLANT = "颜色漂亮！味道很差。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_SMALL = "一只小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_SMALL_SUPER = "一只小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEEN = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEENR1 = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEENR2 = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEENR3 = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEENR4 = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TEENICE = "他不能睡在我头上.. \n不过他还挺可爱的。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALL = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLR1 = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLR2 = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLR3 = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLR4 = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRICE = "Yamche什么都吃。真开心。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALL2 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRR1 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRR2 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRR3 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRR4 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRR5 = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRICE = "真是有用的小鸟！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALL3 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRR1 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRR2 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRR3 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRR4 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRR5 = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRICE = "Yamche不只是只小鸟。他是我的朋友。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALL4 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR1 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR2 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR3 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR4 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR5 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRR6 = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRICE = "是的。我同意。我们是一家人。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALL5 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR1 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR2 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR3 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR4 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR5 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRR6 = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TALLRRRRRICE = "一起旅行。真棒。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP1 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP2 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP3 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP4 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP5 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP6 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RP7 = "别让同伴饿着。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_RPICE = "别让同伴饿着。"
STRINGS.NAMES.GHOSTHOUND = "幽灵猎犬"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GHOSTHOUND = "Musha召唤了一只远古幽灵。"
STRINGS.NAMES.GHOSTHOUND2 = "小幽灵猎犬"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GHOSTHOUND2 = "净化的小幽灵猎犬"
STRINGS.NAMES.TENTACLE_FROST = "冰霜触手"
STRINGS.NAMES.TENTACLE_SHADOW = "影子触手"

STRINGS.RECIPE_DESC.MUSHA_EGG = "同伴Yamche (命令'Z,V,B')"
STRINGS.RECIPE_DESC.MUSHA_EGG_ARONG = "同伴Arong (命令'F1')"
STRINGS.RECIPE_DESC.MUSHA_EGG_RANDOM = "强大且永恒的伙伴."
STRINGS.RECIPE_DESC.MOONTREE_MUSHA = "同伴Dall (命令'F2')"
STRINGS.NAMES.MOONTREE_MUSHA = "桂树"
STRINGS.RECIPE_DESC.MUSHA_EGGS1 = "凤凰蛋 (2级)"
STRINGS.RECIPE_DESC.MUSHA_EGGS2 = "凤凰蛋 (3级)"
STRINGS.RECIPE_DESC.MUSHA_EGGS3 = "凤凰蛋 (4级)"
STRINGS.RECIPE_DESC.MUSHA_EGG1 = "凤凰蛋 (5级)"
STRINGS.RECIPE_DESC.MUSHA_EGG2 = "凤凰蛋 (6级)"
STRINGS.RECIPE_DESC.MUSHA_EGG3 = "凤凰蛋 (7级)"
STRINGS.RECIPE_DESC.MUSHA_EGG8 = "凤凰蛋 (满级)"
STRINGS.RECIPE_DESC.REDGEM = "炼金宝石"
STRINGS.RECIPE_DESC.BLUEGEM = "炼金宝石"
STRINGS.RECIPE_DESC.GREENGEM = "炼金宝石"
STRINGS.RECIPE_DESC.YELLOWGEM = "炼金宝石"
STRINGS.RECIPE_DESC.ORANGEGEM = "炼金宝石"

STRINGS.NAMES.MOONNUTDRAKE = "Kkobong"
STRINGS.NAMES.MOONNUTDRAKE2 = "桦果小精灵"
STRINGS.NAMES.MOONBUSH = "浆果丛"
STRINGS.NAMES.MOONLIGHT_PLANT = "发光浆果树"

STRINGS.NAMES.REDGEM = "红宝石"
STRINGS.NAMES.BLUEGEM = "蓝宝石"
STRINGS.NAMES.GREENGEM = "绿宝石"
STRINGS.NAMES.YELLOWGEM = "黄宝石"
STRINGS.NAMES.ORANGEGEM = "橙宝石"

STRINGS.NAMES.MUSHASWORD_BASE = "损坏的剑刃"
STRINGS.NAMES.MUSHASWORD = "凤凰剑"
STRINGS.NAMES.MUSHASWORD4 = "凤凰斧"
STRINGS.NAMES.MUSHASWORD_FROST = "冰霜凤凰剑"
STRINGS.RECIPE_DESC.MUSHASWORD_BASE = "损坏的凤凰剑,\n改变外貌"
STRINGS.RECIPE_DESC.MUSHASWORD = "可成长武器,\n改变外貌"
STRINGS.RECIPE_DESC.MUSHASWORD4 = "可成长武器，斧头"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TREASURE = "Musha找到你了！"
STRINGS.NAMES.MUSHA_TREASURE = "宝藏"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ASSASIN_WILSON = "威尔逊？"
STRINGS.NAMES.ASSASIN_WILSON = "威尔逊"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_TREASURE2 = "Musha找到你了！"
STRINGS.NAMES.MUSHA_TREASURE2 = "隐藏地点"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_HIDDEN_EGG = "出来Yamche！"
STRINGS.NAMES.MUSHA_HIDDEN_EGG = "隐藏地点"

STRINGS.RECIPE_DESC.MUSHASWORD_FROST = "可成长武器,\n改变外貌"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHASWORD_BASE = "基础的可修复的剑。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHASWORD = "基础的可修复的火焰剑。"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHASWORD_FROST = "基础的可修复的冰霜剑。"
STRINGS.NAMES.MUSHA_FLUTE = "Musha短笛"
STRINGS.RECIPE_DESC.MUSHA_FLUTE = "治愈音乐♪。修理：光之尘埃，灯泡花"
STRINGS.NAMES.GLOWDUST = "光之尘埃"
STRINGS.RECIPE_DESC.GLOWDUST = "发光的粉尘,很美味"

STRINGS.RECIPE_DESC.WORMLIGHT_LESSER = "炼金发光浆果。"
STRINGS.NAMES.PORTION_E = "能量饮料"
STRINGS.RECIPE_DESC.PORTION_E = "能量饮料"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PORTION_E = "让我看看.. [咖啡因苹果： 99%]"
STRINGS.NAMES.CRISTAL = "水晶糖果"
STRINGS.RECIPE_DESC.CRISTAL = "非常美味"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CRISTAL = "看着像不寻常的水晶。"
STRINGS.NAMES.EXP = "能量精华"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.EXP = "它能提供玩家一些经验值。"
STRINGS.NAMES.EXP1000CHEAT = "作弊的精华"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.EXP1000CHEAT = "它能提供玩家大量经验值。"
STRINGS.NAMES.FROSTHAMMER = "冰霜之锤"
STRINGS.RECIPE_DESC.FROSTHAMMER = "可成长，可修复,\n范围攻击(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FROSTHAMMER = "笨重的蓝色朋友"
STRINGS.NAMES.BROKEN_FROSTHAMMER = "冰霜战甲"
STRINGS.RECIPE_DESC.BROKEN_FROSTHAMMER = "可成长，坚固,\n冰箱，反射"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BROKEN_FROSTHAMMER = "它有多功能用途。"
STRINGS.NAMES.PHOENIXSPEAR = "凤凰长剑"
STRINGS.RECIPE_DESC.PHOENIXSPEAR = "可成长，长剑，铲子"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PHOENIXSPEAR = "是把长武器，但很轻！"
STRINGS.NAMES.BOWM = "剑-弓"
STRINGS.RECIPE_DESC.BOWM = "可成长，弓(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BOWM = "抱歉毒蛇。Musha更喜欢阳光。"
STRINGS.NAMES.ARROWM = "箭"
STRINGS.RECIPE_DESC.ARROWM = "基本的箭"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARROWM = "你好，刀锋男孩。"
STRINGS.NAMES.ARROWM_BROKEN = "损坏的箭"
STRINGS.RECIPE_DESC.ARROWM_BROKEN = "损坏的箭"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARROWM_BROKEN = "Musha能修复它。"
STRINGS.NAMES.DUMMY_ARROW0 = "箭"
STRINGS.RECIPE_DESC.DUMMY_ARROW0 = "基本的箭 x2"
STRINGS.NAMES.DUMMY_ARROW1 = "箭"
STRINGS.RECIPE_DESC.DUMMY_ARROW1 = "基本的箭 x2"
STRINGS.NAMES.DUMMY_ARROW2 = "箭"
STRINGS.RECIPE_DESC.DUMMY_ARROW2 = "基本的箭 x2"
STRINGS.NAMES.DUMMY_ARROW3 = "箭"
STRINGS.RECIPE_DESC.DUMMY_ARROW3 = "基本的箭 x2"
STRINGS.NAMES.DUMMY_ARROW4 = "箭"
STRINGS.RECIPE_DESC.DUMMY_ARROW4 = "基本的箭 x6"
STRINGS.NAMES.HAT_MPHOENIX = "凤凰头盔"
STRINGS.RECIPE_DESC.HAT_MPHOENIX = "可成长，面具(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MPHOENIX = "一个中世纪的头盔。"
STRINGS.NAMES.HAT_MPRINCESS = "精灵公主皇冠"
STRINGS.RECIPE_DESC.HAT_MPRINCESS = "护盾，SAN恢复,\n改变外貌"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MPRINCESS = "一个黄金小皇冠。"
STRINGS.NAMES.HAT_MCROWN = "精灵女王皇冠"
STRINGS.RECIPE_DESC.HAT_MCROWN = "护盾，SAN恢复,\n特殊选项"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MCROWN = "看着很棒。"
STRINGS.NAMES.HAT_MBUNNY = "兔子侦察帽"
STRINGS.RECIPE_DESC.HAT_MBUNNY = "可成长,\n护目镜(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MBUNNY = "看着像兔子耳朵。"
STRINGS.NAMES.HAT_MBUNNYA = "钢铁兔子帽"
STRINGS.RECIPE_DESC.HAT_MBUNNYA = "可成长，发光,\n护目镜(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MBUNNYA = "超级英雄钢铁兔！"
STRINGS.NAMES.HAT_MWILDCAT = "钢铁猫头盔"
STRINGS.RECIPE_DESC.HAT_MWILDCAT = "可成长，发光(右击)"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HAT_MWILDCAT = "超级英雄钢铁喵！"
STRINGS.NAMES.ARMOR_MUSHAA = "Musha的盔甲"
STRINGS.RECIPE_DESC.ARMOR_MUSHAA = "可成长的盔甲,\n坚固，背包"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARMOR_MUSHAA = "这是条波浪裙。"
STRINGS.NAMES.ARMOR_MUSHAB = "公主的盔甲"
STRINGS.RECIPE_DESC.ARMOR_MUSHAB = "可成长的盔甲,\n背包，温暖凉快"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ARMOR_MUSHAB = "这是波浪，但很安全。"
-----------------random -name
STRINGS.PHOENIXS = {
    "Captain Yamche", "Hulk Yamche", "Iron Yamche", "Torr Yamche", "Yamche", "Brave Yamche", "Cutie Yamche", "Owl Yamche",
    "Sunny Yamche", "Moon Yamche", "Seoul Yamche", "Suri Yamche", "Vilja Yamche", "Sunny Yamche", "Sunnyholic",
    "Musha Yamche", "Mellisa Yamche", "Lidia Yamche ", "Battleborn Yamche ", "Grey Yamche", "Sky Yamche", "Lucia Yamche",
    "Khajit Yamche", "Pig Yamche", "Mjoll Yamche", "Lioness Yamche", "Muiri Yamche", "Ysolda Yamche", "Rayya Yamche",
    "Falkas Yamche", "Vilkas Yamche", "Aela Yamche", "Huter Yamche", "Huntress Yamche", "Queen Yamche", "Fire Yamche",
    "Cicero Yamche", "Top Yamche", "Lina Yamche", "Totoro Yamche", "Yu-na Yamche", "Winter Yamche", "White Yamche",
    "Mellisa Yamche", "Riften Yamche", "Dawnstar Yamche", "Windhelm Yamche", "Pho Yamche", "Sneaky Yamche",
    "Kiwis Yamche", "Coco Yamche", "Moon Yamche", "Pizza Yamche", "Sugar Yamche", "Orc Yamche", "Elf Yamche",
    "Knight Yamche", "Vlad Yamche", "Azeroth Yamche", "Tauren Yamche", "Troll Yamche", "Thrall Yamche", "Narugar Yamche",
    "Yancook Yamche", "Tirano Yamche", "Honey Yamche", "Golum Yamche", "Bosom Yamche", "Esmeralda Yamche",
    "Pluvia Yamche", "Doraemon Yamche", "Dooly Yamche", "Apple Yamche", "IU Yamche", "Gandalf Yamche", "Frodo Yamche",
    "Sam Yamche", "Regolas Yamche", "Gimli Yamche", "Boromir Yamche", "Wilxon Yamche", "Willo Yamche", "Wolfkong Yamche",
    "Wenil Yamche", "WX79 Yamche", "Wickerbi Yamche", "Woorie Yamche", "Wex Yamche", "Maximus Yamche",
    "Wigfreedom Yamche", "Webbers Yamche", "Naruto Yamche", "Sasuke Yamche", "Witcher Yamche", "Luka Yamche",
    "Arong Yamche", "Puppy Yamche",
}
STRINGS.ARONG = {
    "Captain Arong", "Hulk Arong", "Iron Arong", "Torr Arong", "Yamche", "Brave Arong", "Cutie Arong", "Owl Arong",
    "Sunny Arong", "Moon Arong", "Seoul Arong", "Suri Arong", "Vilja Arong", "Sunny Arong", "Sunnyholic", "Musha Arong",
    "Mellisa Arong", "Lidia Arong ", "Battleborn Arong ", "Grey Arong", "Sky Arong", "Lucia Arong", "Khajit Arong",
    "Pig Arong", "Mjoll Arong", "Lioness Arong", "Muiri Arong", "Ysolda Arong", "Rayya Arong", "Falkas Arong",
    "Vilkas Arong", "Aela Arong", "Huter Arong", "Huntress Arong", "Queen Arong", "Fire Arong", "Cicero Arong",
    "Top Arong", "Lina Arong", "Totoro Arong", "Yu-na Arong", "Winter Arong", "White Arong", "Mellisa Arong",
    "Riften Arong", "Dawnstar Arong", "Windhelm Arong", "Pho Arong", "Sneaky Arong", "Kiwis Arong", "Coco Arong",
    "Moon Arong", "Pizza Arong", "Sugar Arong", "Orc Arong", "Elf Arong", "Knight Arong", "Vlad Arong", "Azeroth Arong",
    "Tauren Arong", "Troll Arong", "Thrall Arong", "Narugar Arong", "Yancook Arong", "Tirano Arong", "Honey Arong",
    "Golum Arong", "Bosom Arong", "Esmeralda Arong", "Pluvia Arong", "Doraemon Arong", "Dooly Arong", "Apple Arong",
    "IU Arong", "Gandalf Arong", "Frodo Arong", "Sam Arong", "Regolas Arong", "Gimli Arong", "Boromir Arong",
    "Wilxon Arong", "Willo Arong", "Wolfkong Arong", "Wenil Arong", "WX79 Arong", "Wickerbi Arong", "Woorie Arong",
    "Wex Arong", "Maximus Arong", "Wigfreedom Arong", "Webbers Arong", "Naruto Arong", "Sasuke Arong", "Witcher Arong",
    "Luka Arong", "Arong Arong", "Puppy Arong",
}
STRINGS.AROM = {
    "Captain Arom", "Hulk Arom", "Iron Arom", "Torr Arom", "Yamche", "Brave Arom", "Cutie Arom", "Owl Arom", "Sunny Arom",
    "Moon Arom", "Seoul Arom", "Suri Arom", "Vilja Arom", "Sunny Arom", "Sunnyholic", "Musha Arom", "Mellisa Arom",
    "Lidia Arom ", "Battleborn Arom ", "Grey Arom", "Sky Arom", "Lucia Arom", "Khajit Arom", "Pig Arom", "Mjoll Arom",
    "Lioness Arom", "Muiri Arom", "Ysolda Arom", "Rayya Arom", "Falkas Arom", "Vilkas Arom", "Aela Arom", "Huter Arom",
    "Huntress Arom", "Queen Arom", "Fire Arom", "Cicero Arom", "Top Arom", "Lina Arom", "Totoro Arom", "Yu-na Arom",
    "Winter Arom", "White Arom", "Mellisa Arom", "Riften Arom", "Dawnstar Arom", "Windhelm Arom", "Pho Arom",
    "Sneaky Arom", "Kiwis Arom", "Coco Arom", "Moon Arom", "Pizza Arom", "Sugar Arom", "Orc Arom", "Elf Arom",
    "Knight Arom", "Vlad Arom", "Azeroth Arom", "Tauren Arom", "Troll Arom", "Thrall Arom", "Narugar Arom",
    "Yancook Arom", "Tirano Arom", "Honey Arom", "Golum Arom", "Bosom Arom", "Esmeralda Arom", "Pluvia Arom",
    "Doraemon Arom", "Dooly Arom", "Apple Arom", "IU Arom", "Gandalf Arom", "Frodo Arom", "Sam Arom", "Regolas Arom",
    "Gimli Arom", "Boromir Arom", "Wilxon Arom", "Willo Arom", "Wolfkong Arom", "Wenil Arom", "WX79 Arom",
    "Wickerbi Arom", "Woorie Arom", "Wex Arom", "Maximus Arom", "Wigfreedom Arom", "Webbers Arom", "Naruto Arom",
    "Sasuke Arom", "Witcher Arom", "Luka Arom", "Arong Arom", "Puppy Arom",
}
STRINGS.DALL = {
    "Captain Dall", "Hulk Dall", "Iron Dall", "Torr Dall", "Yamche", "Brave Dall", "Cutie Dall", "Owl Dall", "Sunny Dall",
    "Moon Dall", "Seoul Dall", "Suri Dall", "Vilja Dall", "Sunny Dall", "Sunnyholic", "Musha Dall", "Mellisa Dall",
    "Lidia Dall ", "Battleborn Dall ", "Grey Dall", "Sky Dall", "Lucia Dall", "Khajit Dall", "Pig Dall", "Mjoll Dall",
    "Lioness Dall", "Muiri Dall", "Ysolda Dall", "Rayya Dall", "Falkas Dall", "Vilkas Dall", "Aela Dall", "Huter Dall",
    "Huntress Dall", "Queen Dall", "Fire Dall", "Cicero Dall", "Top Dall", "Lina Dall", "Totoro Dall", "Yu-na Dall",
    "Winter Dall", "White Dall", "Mellisa Dall", "Riften Dall", "Dawnstar Dall", "Windhelm Dall", "Pho Dall",
    "Sneaky Dall", "Kiwis Dall", "Coco Dall", "Moon Dall", "Pizza Dall", "Sugar Dall", "Orc Dall", "Elf Dall",
    "Knight Dall", "Vlad Dall", "Azeroth Dall", "Tauren Dall", "Troll Dall", "Thrall Dall", "Narugar Dall",
    "Yancook Dall", "Tirano Dall", "Honey Dall", "Golum Dall", "Bosom Dall", "Esmeralda Dall", "Pluvia Dall",
    "Doraemon Dall", "Dooly Dall", "Apple Dall", "IU Dall", "Gandalf Dall", "Frodo Dall", "Sam Dall", "Regolas Dall",
    "Gimli Dall", "Boromir Dall", "Wilxon Dall", "Willo Dall", "Wolfkong Dall", "Wenil Dall", "WX79 Dall",
    "Wickerbi Dall", "Woorie Dall", "Wex Dall", "Maximus Dall", "Wigfreedom Dall", "Webbers Dall", "Naruto Dall",
    "Sasuke Dall", "Witcher Dall", "Luka Dall", "Arong Dall", "Puppy Dall",
}
--adds
STRINGS.MUSHA_YAMCHE = "[ Yamche ]"
STRINGS.MUSHA_HEALTH_HUNGER = "生命/饥饿"
STRINGS.MUSHA_HEALTH = "生命"
STRINGS.MUSHA_HUNGER = "饥饿"
STRINGS.MUSHA_TALK_ORDER_PET_FOLLOW = "跟着我！"
STRINGS.MUSHA_TALK_ORDER_PET_STAY = "走开."
STRINGS.MUSHA_TALK_ORDER_PET_LOST = "Musha, 看不到宠物."
STRINGS.MUSHA_TALK_ORDER_YAMCHE_LEVEL1 = "它太年轻了"
STRINGS.MUSHA_TALK_NEED_SPELLPOWER = "没有足够的法力..."
STRINGS.MUSHA_MYPOWER_CALL_LIGHTNING = "闪电"
STRINGS.MUSHA_MYPOWER_FROST_WIND = "霜冻"
STRINGS.MUSHA_MYPOWER_SMITE = "重击"

STRINGS.MUSHA_ACTION_REPAIR = "修理"
STRINGS.MUSHA_ACTION_ADDFUEL = "添加燃料"
STRINGS.CRITTER_WOBY_SMALL = "回来！"
STRINGS.CRITTER_BYE = "..."
STRINGS.CRITTER_BYEBYE = "再见！"
STRINGS.CRITTER_SAD = "离开我了吗？"
STRINGS.CRITTER_ACTION_TURNON = "打开"
STRINGS.CRITTER_BIGWOBY_COOL = "Woby还没准备好\n(冷却时间:60秒)"

STRINGS.MUSHA_ITEM_MANA_REGEN = "法力恢复♥"

STRINGS.NAMES.MUSHA_NAMETAG = "命名项圈"
STRINGS.RECIPE_DESC.MUSHA_NAMETAG = "可以给你的Yamche或宠物替换一个新的名字"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHA_NAMETAG = " 正在思考 .. "
