
# [DST] Musha (Neko Ver.)

## 1. 角色

### Musha可以在四种角色模式间进行切换

* 角色选择界面能够以皮肤的形式查看四种模式的简介（仅供查看，进入游戏时会自动切换）
* 游戏中使用衣柜可以通过选择皮肤暂时改变角色模式外观，直到下次角色模式切换

### 1.1 通常状态

* 当Musha的饥饿值低于75%时将会处于通常状态，本篇角色介绍中绝大部分数值对比都是以通常状态为基准
* 基础攻击倍率0.8，不同角色模式下伤害倍率计算也有所差别
* 食用不新鲜的食物或变质食物时饥饿值回复量只有一般角色的50%
* 基础三维

### 1.2 充盈状态

* 当Musha的饥饿值大于等于75%时将会进入充盈状态
* 每秒额外恢复0.1点生命和理智
* 每秒额外恢复0.5点魔力
* 每秒额外恢复1点耐力
* 每次进入充盈状态时，会从肉食、素食、烹饪料理中随机选择一种作为食物偏好，在此期间角色只会食用指定种类的食物
* 饥饿值消耗速度提高50%，食用不新鲜的食物时不会恢复饥饿值，并会拒绝食用变质食物
* 疲劳值积累速度增加50%

### 1.3 女武神模式

* 默认快捷键：R
* 通常或充盈状态下可以消耗30点魔力值长按技能快捷键进行蓄力，蓄力完成后松开按键会施放[荒芜俯冲](#1316-荒芜俯冲)并进入女武神模式
* 被攻击时受到的伤害降低20%
* 对怪物和敌对生物（包括大部分boss，不包括暗影生物）造成伤害时附加50%的额外伤害
* 普通攻击会造成AOE伤害，若武器本身已有AOE攻击模组则AOE范围进一步扩大
* 武器不会脱手，落水时不会受到伤害，也不会丢失携带的物品
* 击杀怪物和敌对生物时会根据击杀目标生命值上限为Musha恢复生命值、理智值和魔力值
* 免疫雷击和触电状态，受到雷属性伤害时恢复魔力值
* 疲劳值积累速度增加100%
* 通过执行睡觉指令可以解除女武神模式，并进入20秒冷却时间

#### 1.3.1 女武神模式技能组

* 注1：完全冰冻状态下无法使用技能，但在碎冰阶段可以使用技能并解除冰冻
* 注2：以下技能除[充能闪电](#1311-充能闪电)外均无法在乘骑状态下使用

#### 1.3.1.1 充能闪电

* 默认快捷键：R
* 以雷电之力缠绕全身，使下一次攻击或伤害类技能造成额外雷属性伤害
* 若充能时角色耐力值大于等于10，则会消耗10点耐力值使攻击距离增加10码直到充能效果结束
* 女武神模式下每5秒会自动进行一次闪电充能，也可以按快捷键进行主动充能
* 自动充能不消耗魔力值，主动充能消耗10点魔力值，没有冷却时间

#### 1.3.1.2 鹊踏斩

* 默认快捷键：R
* 无法直接使用，只有 **攻击、被攻击、施放法术或使用技能** 后的短时间内可以施放
* 施放时向鼠标所在位置进行一次无视碰撞体积的快速踏跃并对沿途的第一个目标发起一次斩击，同时恢复5点耐力值，可以瞬间拉开距离或调整站位追击敌人
* 技能施放全程角色处于无敌状态
* 最大位移距离：10，可以跨越地形
* 无消耗，无冷却时间

#### 1.3.1.3 雪月花

* 默认快捷键：G
* 短暂蓄力后向鼠标所在位置发起冲锋，对距离角色最近的目标造成共计5次伤害
* 若[充能闪电](#1311-充能闪电)已激活，则会消耗充能效果对目标造成额外雷属性伤害
* 技能施放全程角色处于霸体状态，并且被攻击时受到的伤害额外降低75%
* 最大冲锋距离：4；若[充能闪电](#1311-充能闪电)攻击距离加成效果已激活则会提高至12
* 消耗耐力值：15，冷却时间5秒

#### 1.3.1.4 凤来斩

* 默认快捷键：G
* 无法直接使用，只有[雪月花](#1313-雪月花)冲锋结束后的短时间内可以施放。期间使用[鹊踏斩](#1312-鹊踏斩)不会中断施放窗口计时
* 挥动武器短暂蓄力后横扫周围敌人，每命中一个目标恢复30点耐力值
* 若[充能闪电](#1311-充能闪电)已激活，则会消耗充能效果对范围内目标造成额外雷属性伤害
* 技能施放全程角色处于霸体状态，并且被攻击时受到的伤害额外降低75%
* 无消耗，无冷却时间

#### 1.3.1.5 歼灭锤

* 默认快捷键：R
* [充能闪电](#1311-充能闪电)激活状态下或当前魔力值不足以主动激活充能闪电时按快捷键会优先施放本技能
* 向鼠标所在位置发起一次强力跳劈，对小范围内目标造成AOE伤害
* 若[充能闪电](#1311-充能闪电)已激活，则会消耗充能效果对范围内目标造成额外雷属性伤害，并附加8秒麻痹效果
* 麻痹：生效时间内目标攻击内置冷却时间加倍（对部分生物无效，如触手），每2秒受到5点伤害，并在发起攻击时受到额外伤害
* 技能施放全程角色处于霸体状态，并且被攻击时受到的伤害额外降低75%
* 最大位移距离：15，可以跨越地形
* 消耗耐力值：20，冷却时间8秒

#### 1.3.1.6 荒芜俯冲

* 默认快捷键：R
* 长按进行蓄力，蓄力完成后松开按键起跳，短暂延迟后向鼠标所在位置发起俯冲并对周围大范围内目标造成一次受目标最大生命值加成的AOE伤害，并对落点小范围内敌人造成额外伤害
* 俯冲落地时会摧毁落点小范围内全部有效物体（包括但不限于树木、岩石、建筑、雕像等）
* 俯冲震击会造成大范围地裂，地裂范围内地面目标移动速度降低75%（不包括玩家和飞行单位），地裂效果持续12秒
* 若[充能闪电](#1311-充能闪电)已激活，则会消耗充能效果对全体目标造成额外雷属性伤害
* 蓄力期间角色处于霸体状态，起跳到落地期间角色处于无敌状态
* 最大位移距离由Musha当前耐力值决定，可以跨越地形
* 消耗：施放需要当前耐力值大于等于25点，实际消耗的耐力值随位移距离增加而增加，冷却时间20秒

#### 1.3.1.7 十方无敌

* 默认快捷键：T
* 长按快捷键可以进入格挡姿态，同时获得100%战斗伤害减免。格挡姿态下进行移动将会结束技能效果
* 格挡反击：格挡姿态下受到攻击或蓄力完成后松开快捷键会向鼠标所在位置进行突刺，击退沿途敌人并造成伤害
* 完美弹反：格挡姿态下在受到攻击的一瞬间松开快捷键则会触发完美弹反。完美弹反会为Musha恢复50点耐力值并召唤一道残影对攻击者造成一次基于其自身攻击力与当前生命值的反击伤害，同时为Musha附加持续6秒的[精灵护盾](#111-精灵护盾)，且本次护盾不会被敌人击碎（若角色本身已经开启精灵护盾则会覆盖原有护盾效果）
* 突刺期间角色处于霸体状态
* 最大位移距离：15
* 消耗：格挡姿态下每秒消耗2点耐力值，期间每次受到攻击会额外消耗5点耐力值
* 冷却时间：10秒，若触发完美弹反则会立即重置冷却时间

#### 1.3.1.8 横扫千军

* 默认快捷键：G
* 无法直接使用，只有[十方无敌](#1317-十方无敌)突刺结束后的短时间内可以施放。期间使用[鹊踏斩](#1312-鹊踏斩)不会中断施放窗口计时
* 原地旋转身体并对周围敌人造成两次受目标最大生命值加成的AOE伤害，同时造成击退与打断效果
* 若[充能闪电](#1311-充能闪电)已激活，则会消耗充能效果对范围内目标造成额外雷属性伤害
* 技能施放全程角色处于霸体状态
* 消耗耐力值：25，无冷却时间

#### 1.3.1.9 里太刀·雪月花

* 被动技能。[雪月花](#1313-雪月花)冲锋结束后短时间内再次按下快捷键可以追加施放，最多连续冲锋三次。期间使用[鹊踏斩](#1312-鹊踏斩)不会中断施放窗口计时

#### 1.3.1.10 雷霆法咒

* 见精灵魔法-[雷霆法咒](#1102-雷霆法咒)

### 1.4 暗影模式

* 默认快捷键：G
* 通常或充盈状态下可以消耗50点理智值长按快捷键施放[暗影波动](#1103-暗影波动)并激活暗影模式，期间角色处于无敌状态
* 激活暗影模式时，Musha的理智值上限将会被锁定至与当前理智值相等，随后理智值上限会随时间持续降低，但同时Musha会获得高速理智恢复及反转降san光环效果（参考蜂王帽）
* 对暗影生物造成伤害时附加50%的额外伤害，击杀暗影生物可恢复25点理智上限
* 暗影模式下噩梦燃料与暗影心房将转变为可食用状态，吃下噩梦燃料可恢复25点理智上限同时恢复等量的理智值，吃下暗影心房则可取消暗影模式带来的全部理智上限惩罚并恢复全部理智值，同时理智上限将不再降低，直到退出暗影模式为止
* 免疫火焰伤害，免疫冰冻（不包括过热和过冷伤害）
* 当Musha激活暗影模式时，所属的[影子Musha](#1-影子musha)会进入狂暴状态
* 通过执行睡觉指令可以解除暗影模式，并进入20秒冷却时间

#### 1.4.1 暗影模式技能组

* 注：以下技能除[影莲华](#1415-影莲华)外均**可以**在乘骑状态下使用

#### 1.4.1.1 潜影突袭

* 默认快捷键：G
* 处于暗影模式时再次按技能快捷键可以激活潜影突袭。激活瞬间Musha会进入潜行准备状态，小动物将不会再对Musha产生恐惧；随后进入4秒准备时间，准备时间结束进入完全潜行状态，清除周围敌人仇恨，同时取消角色物理碰撞体积
* 潜行冲刺：进入潜行准备状态时会根据当前耐力值大幅提高移动速度并每秒消耗10点耐力，移动速度加成会持续衰减直到耐力耗尽或潜行准备时间结束。主动退出潜行状态也会结束此效果
* 背刺：完全潜行状态下攻击敌人会触发背刺，造成额外偷袭伤害，额外伤害随角色等级提高
* 完美背刺：背刺时若攻击目标 **未处于攻击、移动或冰冻状态** 则会触发完美背刺，造成 **双倍** 额外伤害，同时获得150%移动速度加成持续2秒
* 消耗：50点理智值。背刺成功或取消技能可返还消耗的理智，潜行状态下被攻击则视为潜行失败，会强制退出潜行状态但不会返还理智

#### 1.4.1.2 影幻刃

* 默认快捷键：R
* 召唤一道幻影对鼠标指定目标发起斩击，斩击结束后幻影不会立即消失，而是会留在原地一段时间等待指令
* 幻影协同：施放本技能时，若目标周围存在其他未消失的幻影，则会激活周围所有幻影同时对目标发起斩击
* 此技能可以触发[潜影突袭](#1411-潜影突袭)的背刺效果
* 消耗魔力值：5，消耗理智值：10，消耗耐力值：10，冷却时间：3秒

#### 1.4.1.3 移形换影

* 默认快捷键：鼠标右键点击幻影
* 暗影模型激活时，Musha可以自由地与任意幻影交换位置
* 消耗理智值：10，无冷却时间

#### 1.4.1.4 影乱舞

* 默认快捷键：双击R
* 无法直接使用，只有使用[影幻刃](#1412-影幻刃)后的短时间内可以通过再次按下快捷键施放
* [影幻刃](#1412-影幻刃)斩击结束后幻影会再次追击，对目标发起多段强力终结斩，终结斩结束后幻影会消失
* 幻影协同：施放本技能时，若目标周围存在其他未消失的幻影，则会激活周围所有幻影同时对目标发起终结斩，终结斩结束后幻影会消失
* 消耗耐力值：20，无冷却时间

#### 1.4.1.5 影莲华

* 默认快捷键：R
* 长按进行蓄力，蓄力完成后松开按键施放，解放暗影力量召唤大量幻影同时对鼠标指定目标发起攻击
* 召唤的幻影数量由角色当前魔力值与理智值决定，Musha将在满足技能消耗的前提下尽可能多的召唤幻影直到上限
* 此技能可以触发[潜影突袭](#1411-潜影突袭)的背刺效果
* 蓄力期间角色处于霸体状态
* 每道幻影消耗魔力值：5，消耗理智值：10，消耗耐力值：10，冷却时间：30秒

#### 1.4.1.6 影瞬身

* 默认快捷键：T
* 长按快捷键可以进入瞬身准备姿态，同时获得100%战斗伤害减免。瞬身准备姿态下进行移动将会结束技能效果
* 准备瞬身：瞬身准备姿态持续到最大时间后会瞬移到鼠标指定位置，并在原位置留下一道幻影
* 受击瞬身：瞬身准备姿态下受到攻击则会立即瞬移到鼠标指定位置，在原位置留下一道幻影，并自动对攻击者施放[影幻刃](#1412-影幻刃)，同时在攻击者位置留下一枚暗影陷阱，陷阱在有敌对单位接近时触发，触发时扰乱范围内敌对单位的仇恨目标（以此方式触发影幻刃不会产生消耗，无视冷却时间）
* 完美弹反：在受到攻击的一瞬间进入瞬身准备姿态则会触发完美弹反。完美弹反会为Musha恢复25点耐力值以及10点理智值上限，将暗影陷阱替换为[暗影囚牢](#1418-暗影囚牢)，同时立即激活[潜影突袭](#1411-潜影突袭)并将潜行准备时间缩短至1秒（以此方式触发潜影突袭不会产生消耗）
* 消耗理智值：25，瞬移消耗耐力值：25
* 冷却时间：10秒，若触发完美弹反则会立即重置冷却时间

#### 1.4.1.7 暗影波动

* 见精灵魔法-[暗影波动](#1103-暗影波动)

#### 1.4.1.8 暗影囚牢

* 默认快捷键：鼠标右键点击角色
* 只有当[潜影突袭](#1411-潜影突袭)潜行状态激活时可以施放（满足施放条件时，此技能将自动替换掉[暗影波动](#1417-暗影波动)）
* 以角色为中心对周围目标降下影之枷锁，范围内的非友方单位将被困在原地无法行动
* 消耗魔力值：15，消耗理智值：15，冷却时间：12秒

### 1.5 等级系统

* 初始等级为0，等级上限为30

### 1.6 魔力槽

* 初始MP上限为50点

### 1.7 耐力/疲劳度

#### 1.7.1 耐力

* 影响攻击力、疲劳积累速度及部分技能效果
* 进行各种活动会消耗耐力，站立、移动、睡觉时会回复耐力

#### 1.7.2 疲劳

* 疲劳值上限为100点，初始为0，基础累积速度为每天10点，耐力处于低水平时疲劳上涨速度会大幅增加
* 疲劳值低于10%时可以获得增益buff，提高50%工作效率和15%移动速度
* 疲劳值高于40%时工作效率、移动速度会降低，高于65%时有几率进入疲劳状态，高于85%时有几率直接晕倒
* 可以通过睡眠降低疲劳值，睡眠质量越高疲劳值降低速度越快

### 1.8 睡觉

* 默认快捷键：Z，处于睡眠状态下再次按快捷键可以主动醒来
* 睡眠质量分为三个等级
  * 高质量睡眠：只有当使用帐篷时才会进入高质量睡眠状态
  * 中质量睡眠：时间为黄昏或夜晚，并且周围需要有营火
  * 低质量睡眠：时间为白天，或没有营火，或由于疲劳值过低而晕倒
* Musha可以通过睡觉恢复疲劳值、耐力值以及为精灵旋律充能，睡眠质量越高恢复速度越快，其中旋律充能只能在中/高质量睡眠时触发
* 处于女武神模式或暗影模式时进入睡眠状态会退出当前角色模式
* 处于乘骑状态下按快捷键会取消乘骑状态而不会进入睡眠

### 1.9 特殊攻击模组

* 重击

### 1.10 精灵魔法

* 右键点击角色可以根据当前角色模式施放精灵魔法，在乘骑状态下也可以使用

#### 1.10.1 唤冰法咒

* 通常状态和充盈状态下可以使用
* 效果：以角色为中心对周围大范围内目标叠加冰冻累计，若目标冰冻抗性较高或免疫冰冻则会对其额外追加减速debuff，移动速度降低75%持续5秒；效果范围与冰冻累计随角色等级提升
  * 效果范围：14（Lv.1）- 20（Lv.30）
  * 冰冻累计：1（Lv.1，相当于冰杖）- 4（Lv.30），每5级提高0.5
* 消耗：施法需要当前魔力值大于等于15，实际消耗魔力值为5*命中目标数量，若超过15则按15点计算
* 冷却时间：3秒
* 施法动作中角色处于霸体状态

#### 1.10.2 雷霆法咒

* 女武神模式下可以使用
* 效果：以角色为中心对周围中范围内目标降下落雷，造成伤害并施加麻痹debuff；效果范围与麻痹持续时间随角色等级提升
  * 落雷：基础伤害为20点，角色等级每提高5级增加5点，命中时触发目标的充电效果
  * 麻痹：生效时间内目标攻击内置冷却时间加倍（对部分生物无效，如触手），每2秒受到5点伤害，并在发起攻击时受到额外伤害
  * 效果范围：14
  * 麻痹持续时间：8（Lv.1）- 20（Lv.30）
* 消耗：施法需要当前魔力值大于等于15，实际消耗魔力值为5*命中目标数量，若超过15则按15点计算
* 冷却时间：10秒
* 施法动作中角色处于霸体状态

#### 1.10.3 暗影波动

* 暗影模式下可以使用
* 效果：以角色为中心对周围敌人造成最多六次AOE伤害，AOE范围逐渐扩大，基础伤害随角色等级提高
* 消耗：50点理智值
* 冷却时间：5秒
* 施放期间角色处于无敌状态
* 若[潜影突袭](#1411-潜影突袭)潜行状态已激活，此技能将自动切换为[暗影囚牢](#1418-暗影囚牢)

### 1.11 精灵护盾

* 默认快捷键：T，护盾生效期间再次按快捷键可以取消技能效果
* 效果：为角色自身施加精灵护盾，护盾持续期间角色免疫战斗伤害与硬直，且受到的非战斗伤害降低50%。护盾没有持续时间限制，但存在承受伤害上限，超过上限时护盾会破碎。护盾承伤上限随角色生命值上限与角色等级提升。护盾破碎前角色会发出提醒，收到提醒三秒后护盾消失
* 消耗：施放需要当前魔力值大于等于5（但施放时并不消耗魔力值）。护盾持续期间角色每秒消耗1点魔力值，魔力值耗尽三秒后护盾消失。主动取消或受到伤害破碎时消耗5点魔力值
* 冷却时间：30秒（从效果结束时开始计算）

#### 1.11.1 公主庇佑

* 默认快捷键：T，仅在通常状态和充盈状态下可以使用
* 效果：长按快捷键为角色自身及周围大范围内友方单位施加精灵护盾效果，持续时间15秒，护盾承伤上限与单体护盾相同
* 消耗：施放需要当前魔力值大于等于45，施放时，实际消耗魔力值为15*有效目标数量，若超过45则按45点计算；与单体护盾不同，公主庇佑持续期间角色没有额外魔力值消耗，主动取消时也不会消耗魔力值
* 冷却时间：15秒
* 施法动作中角色处于霸体状态

### 1.12 元素掌握

* 只有在角色处于[通常状态](#11-通常状态)或[充盈状态](#12-充盈状态)时才可以使用
* 默认快捷键：
  * R-装填/发射元素（若已解锁对应技能则可通过长按快捷键蓄力）
  * G-已装填状态下按下快捷键可以切换元素种类
  * Z-已装填状态下按下快捷键可以取消装填
* 在执行元素装填或切换时会自动选择当前可用的元素，若没有可用元素则无法装填/切换
* 目前已加入游戏的元素种类包括：
  * 沸滚熔岩
  * 奔涌白霜
  * 孢子炸弹
  * 绽放之蕊

#### 1.12.1 沸滚熔岩

* 向鼠标指定方向掷出沸腾的熔岩块，命中地面时爆炸，对周围小范围内目标造成AOE伤害并生成岩浆池（若命中水面则只会造成伤害，不会生成岩浆池）
* 岩浆池：持续时间3秒，期间会使范围内物体温度快速升高，并会点燃其中**生物**，造成额外火焰伤害（升温与点燃效果会被[奔涌白霜](#1122-奔涌白霜)的霜冻区域效果覆盖而失效）
* 无论熔岩块本身还是岩浆池都不会直接点燃非生物单位，但命中爆炸时会对范围内全部可燃单位叠加一层燃烧计数，若燃烧计数达到3层则会强制点燃目标
* 消耗魔力值：10，冷却时间：1秒，射程：远

#### 1.12.1.1 沸滚熔岩·裂变

* 若技能已解锁，则装填沸滚熔岩时可以通过再次长按快捷键进行蓄力，蓄力2秒后当前元素将得到强化
* 向鼠标指定方向发射聚能压缩后的熔岩之星，命中地面时爆炸并喷发出大量熔岩块轰炸目标区域。当心，此技能极易引发火灾！
* 额外魔力消耗：20，冷却时间：5秒，射程：远

#### 1.12.2 奔涌白霜

* 向鼠标指定方向掷出低温霜球，命中地面时生成一片3秒内逐渐扩大的霜冻区域，期间会使范围内物体温度快速降低，同时移动速度降低75%（不包括飞行单位）
* 白霜喷发：霜冻区域扩大完成后将会喷发白霜，对范围内未处于冰冻状态的目标造成高频连续伤害并快速叠加冰冻值，直到目标冰冻为止。白霜喷发持续10秒
* 消耗魔力值：15，冷却时间：10秒，射程：中

#### 1.12.2.1 奔涌白霜·冰河

* 若技能已解锁，则装填奔涌白霜时可以通过再次长按快捷键进行蓄力，蓄力2秒后当前元素将得到强化
* 向鼠标指定方向发射聚能压缩后的霜冻之星，命中地面时生成大范围霜冻力场，范围内目标会产生持续性降温、减速和叠加冰冻值效果，持续十秒
* 霜冻力场消失时将会对范围内目标造成一次冰爆，若目标未处于冰冻状态则会强制冰冻10秒，若已处于冰冻状态则会造成一次基于目标最大生命值的高额伤害
* 额外魔力消耗：15，冷却时间：15秒，射程：远

#### 1.12.3 孢子炸弹

* 向鼠标指定方向掷出孢子炸弹，命中地面时生成一片持续20秒的剧毒孢子云，每秒对范围内非友方单位造成伤害，并使其中有新鲜度的物品迅速腐烂
* 消耗魔力值：10，消耗理智值：10，冷却时间：10秒，射程：近

#### 1.12.3.1 孢子炸弹·连锁

* 若技能已解锁，则装填孢子炸弹时可以通过再次长按快捷键进行蓄力，蓄力2秒后当前元素将得到强化
* 向鼠标指定方向掷出可以弹跃多次的孢子炸弹，炸弹每次命中地面时都会生成孢子云，弹跃时会自动追踪一定范围内距离最近的目标
* 额外魔力消耗：20，额外理智值消耗：20，冷却时间：20秒，射程：近，弹跃距离：中

#### 1.12.4 绽放之蕊

* 向鼠标指定方向掷出绽放法球，命中地面时恢复范围内所有友方单位生命值，非玩家友方单位还会受到额外的生命回复
* 消耗魔力值：25，冷却时间：10秒，射程：远

#### 1.12.4.1 绽放之蕊·花轮

* 若技能已解锁，则装填绽放之蕊时可以通过再次长按快捷键进行蓄力，蓄力2秒后当前元素将得到强化
* 向鼠标指定方向发射聚能压缩后的绽放之星，命中地面时生成大范围绽放领域，范围内所有友方单位获得持续的生命回复与耐力回复，同时获得移动速度加成
* 催眠花粉：范围内的**非**友方单位每隔一段时间都会有几率强制进入睡眠状态
* 额外魔力消耗：75，冷却时间：60秒，射程：远

### 1.13 精灵旋律

* 默认快捷键：X
* 在处于**中或高质量的**睡眠状态时，Musha会逐渐积累旋律充能。旋律充能达到一定进度后按下快捷键可以发动精灵旋律，在一段时间内为Musha提供包括魔力值回复、耐力值回复、移动速度提高等多种增益Buff。演奏期间再次按快捷键可以提前结束演奏，但不会返还充能进度
* 精灵旋律可分为短暂演奏与完美演奏。短暂演奏只消耗20%充能进度即可发动，但Buff效果较弱，持续时间很短；完美演奏Buff效果强大，但只有旋律充能达到100%时才能发动
* 短暂演奏：消耗旋律充能：20%，持续时间：30秒，冷却时间：60秒
* 完美演奏：消耗旋律充能：100%，持续时间：240秒，冷却时间：480秒

### 1.14 宝藏嗅探

* 默认快捷键：X
* 在处于移动状态时，Musha会逐渐积累寻宝值。寻宝值满时按下快捷键可以发动宝藏嗅探，在地图上标记出宝藏位置
* 宝藏中往往会有各种对Musha的冒险有帮助的资源，同时也有概率触发彩蛋或陷阱。做好准备迎接惊喜（或惊吓）吧

### 使用暗影秘典（麦克斯韦）

1. 可通过暗影秘典制作专属随从[影子Musha](#1-影子musha)

### 制作和使用书本（薇克巴顿）

### 制作和使用便携厨具（沃利）

### 制作修补胶带和工匠建筑（薇诺娜）

### 制作气球（韦斯）

### 随从数量上限为50（包括宠物、老麦的影子人偶、[影子Musha](#1-影子musha)）

### 喜欢的食物：太妃糖🍬 彩虹糖豆🍭

* 太妃糖：食用时额外恢复5点魔力值与25点耐力值，且原本的生命值-3效果不会生效
* 彩虹糖豆：食用后30秒内每秒额外恢复1点魔力值与2点耐力值，重复食用会刷新持续时间，恢复效果不叠加

## 伙伴

### 1. 影子Musha

* 使用暗影秘典解锁制作，制作所需材料：救赎之心、暗影剑
* Musha攻击自己的影子时影子会直接消失，同时返还一把暗影剑。影子被除主人外的其他目标消灭时只会掉落一个噩梦燃料
* 拥有400点基础生命值，40点基础攻击力，2秒攻击冷却时间，每2秒恢复20点生命
* 会协助Musha砍树、挖矿，同时也会自动挖树根、挖坟；砍树、挖矿拥有1.5倍工作效率
* 在自己、Musha、其他影子被攻击时会进行反击，生命低于25%时会优先躲避敌人
* 当Musha激活暗影模式时，周围的影子会强制进入狂暴状态
  * 狂暴状态下的影子拥有800点基础生命值，每2秒恢复40点
  * 连续攻击不再有冷却时间，但由于精神状态不稳定，每次攻击时会随机造成0-40点伤害，而不是固定40点
  * 不再对敌人进行躲避，并且会主动攻击周围的怪物类生物
  * 狂暴状态下不能进行砍树挖矿等工作活动
* 在伙伴命令快捷键开启时，可按F2命令影子Musha切换跟随模式，跟随模式下不会进行攻击和工作，同时所受伤害降低80%，对狂暴状态下的影子也有效
* 影子Musha不会受到孢子炸弹技能效果的影响
* 不同于猪人兔人鱼人，影子的碰撞体积不会阻挡Musha的行动
* 当Musha通过聊天栏执行 /dance 指令时，影子会跟随Musha一起跳舞 💃

## 装备

### 1. 冰霜之锤

* 工具：锤子，作为工具使用不消耗耐久
* 重击模组
* 启动状态（右键）
  * 范围攻击
  * 冰冻效果
  * 开启附魔技能
  * 角色移动速度降低
* 附魔技能
  * 添加不同材料解锁
  * 召唤：冰霜触手（没做完，目前是陨石）
    * 消耗：魔力10、理智15、武器耐久
  * 光环：极寒领域
    * 发光
    * 降温
    * 冰冻、减速周围目标
    * 持续消耗耐久度
  * 冷却体温
    * 体温50以上每三秒消耗2魔力
    * 冬季自动关闭
* 攻击时若目标处于燃烧状态则会自动解除

## 快捷键

* 睡觉/醒来/取消乘骑状态：Z
* 激活女武神模式：R
* 激活暗影模式：G
* 激活/取消潜影突袭：暗影模式下按G
* 开启/关闭以下伙伴命令按键：F1 （默认开启，设置开关是为了防止与其他Mod快捷键冲突）
  * 命令影子Musha切换跟随模式：F2
  * 关闭命令按键后继续按会发生什么呢？

## 注释

* Musha全部的冰冻效果（来源包括角色技能、装备、伙伴、其他Musha玩家，不包括游戏内原有的冰冻方式，如冰魔杖等）共享5秒冷却时间，即敌人被 **Musha相关效果** 冰冻后，在冰冻解除后5秒内无法再次被 **Musha相关效果** 冰冻。作为补偿，目标在冰冻冷却时间内将进入减速状态，移动速度降低75%，可与其他减速效果叠加
