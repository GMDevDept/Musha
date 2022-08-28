
# [DST] Musha (Neko.Ver)

## 角色

### 切换四种角色模式

   1. 角色选择界面能够以皮肤的形式查看四种模式的简介（仅供查看，进入游戏时会自动切换）
   2. 通常状态
      1. 基础攻击倍率0.75
      2. 基础三维
   3. 充盈状态
      1. 10%移动速度加成
      2. 缓慢恢复生命和理智（每十秒1点）
      3. 每秒额外恢复0.5点耐力
      4. 饥饿值消耗速度提高30%
   4. 女武神模式
      1. 默认快捷键：R
      2. 20%近战伤害加成，20%自身减伤
      3. 免疫火焰伤害，免疫冰冻，冰冻状态下激活可以解除冰冻
      4. 武器不会脱手
   5. 暗影模式
      1. 默认快捷键：G
      2. 激活时释放暗影波动，对周围敌人造成最多六次AOE伤害，AOE范围逐渐扩大，释放期间角色自身无敌
         1. 基础伤害为5点/hit，角色等级每提高5级增加5，30级可达到35点（吃满共计210）
      3. 暗影模式下普通攻击会造成AOE伤害，若武器本身已有AOE攻击模组则AOE范围大幅扩大
      4. 暗影模式可以通过睡眠、死亡或重进游戏解除
      5. 潜影突袭
         1. 处于暗影模式时再次按技能快捷键可消耗50点理智激活潜影突袭
         2. 激活瞬间进入半潜行状态，小动物将不会再对Musha产生恐惧，随后进入4秒准备时间
         3. 潜行冲刺
            1. 潜影突袭激活瞬间若耐力不为0，则会根据当前耐力值大幅提高移动速度（50%-150%）并每秒消耗10点耐力，移动速度加成会持续衰减直到耐力耗尽。退出潜行状态会结束此效果
         4. 准备时间结束进入完全潜行状态，消除周围敌人仇恨并不会再次被主动攻击
         5. 完全潜行状态下攻击敌人会触发背刺，造成额外偷袭伤害，额外伤害基础值为100点，角色等级每提高5级增加50，30级可达到400点
         6. 完美背刺：背刺时若攻击目标未处于 **攻击、移动或冰冻** 状态则会触发完美背刺，造成 **双倍** 额外伤害，同时获得100%移动速度加成持续2秒
         7. 背刺成功或再次按快捷键取消技能可返还50点理智，潜行状态下被攻击也会取消潜行状态，但不会返还理智
   6. 游戏中使用衣柜可以通过选择皮肤暂时改变角色模式外观，直到下次角色模式切换

### 等级系统

   1. 初始等级为0，等级上限为30

### 魔力槽

   1. 初始MP上限为50点，每次升级级提升5点MP上限

### 耐力/疲劳度

   1. 耐力：影响疲劳积累速度及部分技能效果
      1. 进行各种活动会消耗耐力，基础恢复速度为挂机每秒恢复5点，移动时每秒恢复1点
   2. 疲劳
      1. 基础每天增加5点，耐力处于低水平时疲劳上涨速度会相应增加
      2. 疲劳值过高时工作效率、移动速度会降低
      3. 可以通过睡觉恢复

### 睡觉

   1. 重击

### 特殊攻击模组

   1. 重击

### 精灵魔法

   1. 右键点击角色可以根据当前角色模式施放精灵魔法；在乘骑状态下也可以使用（取消乘骑可以按睡觉快捷键）
   2. 唤冰法咒
      1. 通常状态和充盈状态下可以使用
      2. 效果：以角色为中心对周围大范围内目标叠加冰冻累计，若目标冰冻抗性较高或免疫冰冻则会对其额外追加减速debuff，移动速度降低70%持续5秒；效果范围与冰冻累计随角色等级提升
         1. 效果范围：9（Lv.1）- 18（Lv.30）
         2. 冰冻累计：1（Lv.1，相当于冰杖）- 4（Lv.30），每5级提高0.5
      3. 消耗：施法需要当前魔力值大于等于15，实际消耗魔力值为5*命中目标数量，若超过15则按15点计算
      4. 冷却时间：3秒
      5. 施法动作中角色处于霸体状态
   3. 雷霆法咒
      1. 女武神模式下可以使用
      2. 效果：以角色为中心对周围中范围内目标降下落雷，造成伤害并施加麻痹debuff；效果范围与麻痹持续时间随角色等级提升
         1. 落雷：基础伤害为20点，角色等级每提高5级增加5点，命中时触发目标的充电效果
         2. 麻痹：生效时间内目标攻击内置冷却时间加倍（对部分生物无效，如触手），每2秒受到5点伤害，并在发起攻击时受到额外伤害
         3. 效果范围：6（Lv.1）- 12（Lv.30）
         4. 麻痹持续时间：8（Lv.1）- 20（Lv.30）
      3. 消耗：施法需要当前魔力值大于等于30，实际消耗魔力值为10*命中目标数量，若超过30则按30点计算
      4. 冷却时间：10秒
      5. 施法动作中角色处于霸体状态
   4. 暗影波动
      1. 暗影模式下可以使用
      2. 效果：对周围敌人造成最多六次AOE伤害（与暗影模式激活时效果相同）
      3. 消耗：50点理智值
      4. 冷却时间：无
      5. 施放期间角色处于无敌状态

### 精灵护盾

   1. 默认快捷键：T
   2. 效果：为角色自身施加精灵护盾，护盾持续期间角色处于无敌状态，再次按快捷键可以取消技能效果。护盾没有持续时间限制，但存在承受伤害上限，超过上限时护盾会破碎。护盾承伤上限随角色等级提升
      1. 承受伤害上限：400（Lv.1）- 1600（Lv.30）
      2. 承受伤害计算：每当角色被攻击时，护盾受到 20+攻击原始伤害值（计算护甲及角色自身各类增减伤前）的伤害
      3. 护盾破碎前角色会发出提醒，收到提醒三秒后护盾消失
   3. 消耗：施放需要当前魔力值大于等于10（但施放时并不消耗魔力值）。护盾持续期间角色每秒消耗1点魔力值，主动取消时消耗10点魔力值（受到伤害破碎时不消耗）
   4. 冷却时间：30秒（从效果结束时开始计算）
   5. 达成一定条件时，技能精灵护盾将被替换为**公主庇佑**
      1. 效果：为角色自身及周围大范围内友方单位施加护盾效果，持续时间15秒，护盾持续期间目标处于无敌状态，施加给角色以外友方单位的护盾没有承受伤害上限，不会因敌人攻击而破碎（角色自身护盾仍会被击碎）
      2. 消耗：施放需要当前魔力值大于等于50，施放时，若范围内没有除角色自身以外的友方单位，则只消耗30点；反之，只要有任何其他友方单位享受到了护盾效果则消耗50点
      3. 冷却时间：5秒（从效果结束时开始计算）

### 使用暗影秘典（麦克斯韦）

   1. 可通过暗影秘典制作专属随从[影子Musha](#1-影子musha)

### 制作和使用书本（薇克巴顿）

### 制作和使用便携厨具（沃利）

### 制作修补胶带和工匠建筑（薇诺娜）

### 制作气球（韦斯）

### 随从数量上限为50（包括宠物、老麦的影子人偶、[影子Musha](#1-影子musha)）

### 喜欢的食物：太妃糖🍬

## 伙伴

### 1. 影子Musha

   1. 使用暗影秘典解锁制作，制作所需材料：救赎之心、暗影剑
   2. Musha攻击自己的影子时影子会直接消失，同时返还一把暗影剑。影子被除主人外的其他目标消灭时只会掉落一个噩梦燃料
   3. 拥有400点基础生命值，40点基础攻击力，2秒攻击冷却时间，每2秒恢复20点生命
   4. 会协助Musha砍树、挖矿，同时也会自动挖树根、挖坟；砍树、挖矿拥有1.5倍工作效率
   5. 在自己、Musha、其他影子被攻击时会进行反击，生命低于25%时会优先躲避敌人
   6. 当Musha激活暗影模式时，周围的影子会强制进入狂暴状态
      1. 狂暴状态下的影子拥有800点基础生命值，每2秒恢复40点
      2. 连续攻击不再有冷却时间，但由于精神状态不稳定，每次攻击时会随机造成0-40点伤害，而不是固定40点
      3. 不再对敌人进行躲避，并且会主动攻击周围的怪物类生物
      4. 狂暴状态下不能进行砍树挖矿等工作活动
   7. 在伙伴命令快捷键开启时，可按F2命令影子Musha切换跟随模式，跟随模式下不会进行攻击和工作，同时所受伤害降低80%，对狂暴状态下的影子也有效
   8. 影子Musha不会受到孢子炸弹技能效果的影响
   9. 不同于猪人兔人鱼人，影子的碰撞体积不会阻挡Musha的行动
   10. 当Musha通过聊天栏执行 /dance 指令时，影子会跟随Musha一起跳舞 💃

## 装备

### 1. 冰霜之锤

   1. 工具：锤子，作为工具使用不消耗耐久
   2. 重击模组
   3. 启动状态（右键）
      1. 范围攻击
      2. 冰冻效果
      3. 开启附魔技能
      4. 角色移动速度降低
   4. 附魔技能
      1. 添加不同材料解锁
      2. 召唤：冰霜触手（没做完，目前是陨石）
         1. 消耗：魔力10、理智15、武器耐久
      3. 光环：极寒领域
         1. 发光
         2. 降温
         3. 冰冻、减速周围目标
         4. 持续消耗耐久度
      4. 冷却体温
         1. 体温50以上每三秒消耗2魔力
         2. 冬季自动关闭
   5. 攻击时若目标处于燃烧状态则会自动解除

## 快捷键

1. 睡觉/醒来/取消乘骑状态：Z
2. 激活女武神模式：R
3. 激活暗影模式：G
4. 激活/取消潜影突袭：暗影模式下按G
5. 开启/关闭以下伙伴命令按键：F1 （默认开启，设置开关是为了防止与其他Mod快捷键冲突）
   1. 命令影子Musha切换跟随模式：F2
   2. 关闭命令按键后继续按会发生什么呢？

## 注释

1. Musha全部的冰冻效果（来源包括角色技能、装备、伙伴、其他Musha玩家，不包括游戏内原有的冰冻方式，如冰魔杖等）共享2.5秒冷却时间，即敌人被 **Musha相关效果** 冰冻后，在冰冻解除后2.5秒内无法再次被 **Musha相关效果** 冰冻。作为补偿，目标在冰冻冷却时间内将进入减速状态，移动速度降低70%，可与其他减速效果叠加
