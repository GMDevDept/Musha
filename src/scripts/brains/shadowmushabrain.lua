require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/attackwall"
require "behaviours/standstill"
require "behaviours/leash"
require "behaviours/runaway"

local BrainCommon = require "brains/braincommon"

local ShadowMushaBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

--Images will help chop, mine and fight.

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 8
local MAX_FOLLOW_DIST = 10

local START_FACE_DIST = 8
local KEEP_FACE_DIST = 10

local MAX_TOLEADER_DIST = 18
local KEEP_WORKING_DIST = 14
local SEE_WORK_DIST = 10

local KEEP_DANCING_DIST = 5

local KITING_DIST = 5
local STOP_KITING_DIST = 8

local RUN_AWAY_DIST = 8
local STOP_RUN_AWAY_DIST = 10

local AVOID_EXPLOSIVE_DIST = 5

local DIG_TAGS = { "stump", "grave", "farm_debris" }

local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetLeaderPos(inst)
    return inst.components.follower.leader:GetPosition()
end

local function GetFaceTargetFn(inst)
    local target = FindClosestPlayerToInst(inst, START_FACE_DIST, true)
    return target ~= nil and not target:HasTag("notarget") and target or nil
end

local function IsNearLeader(inst, dist)
    local leader = GetLeader(inst)
    return leader ~= nil and inst:IsNear(leader, dist)
end

local TOWORK_CANT_TAGS = { "fire", "smolder", "event_trigger", "INLIMBO", "NOCLICK", "carnivalgame_part" }
local function FindEntityToWorkAction(inst, action, addtltags)
    local leader = GetLeader(inst)
    if leader ~= nil then
        --Keep existing target?
        local target = inst.sg.statemem.target
        if target ~= nil and
            target:IsValid() and
            not (target:IsInLimbo() or
                target:HasTag("NOCLICK") or
                target:HasTag("event_trigger")) and
            target:IsOnValidGround() and
            target.components.workable ~= nil and
            target.components.workable:CanBeWorked() and
            target.components.workable:GetWorkAction() == action and
            not (target.components.burnable ~= nil
                and (target.components.burnable:IsBurning() or
                    target.components.burnable:IsSmoldering())) and
            target.entity:IsVisible() and
            target:IsNear(leader, KEEP_WORKING_DIST) then

            if addtltags ~= nil then
                for _, v in ipairs(addtltags) do
                    if target:HasTag(v) then
                        return BufferedAction(inst, target, action)
                    end
                end
            else
                return BufferedAction(inst, target, action)
            end
        end

        --Find new target
        target = FindEntity(leader, SEE_WORK_DIST, nil, { action.id .. "_workable" }, TOWORK_CANT_TAGS, addtltags)
        return target ~= nil and BufferedAction(inst, target, action) or nil
    end
end

local function KeepFaceTargetFn(inst, target)
    return not target:HasTag("notarget") and inst:IsNear(target, KEEP_FACE_DIST)
end

local function DanceParty(inst)
    inst:PushEvent("dance")
end

local function ShouldDanceParty(inst)
    local leader = GetLeader(inst)
    return leader ~= nil and leader.sg:HasStateTag("dancing")
end

local function ShouldAvoidExplosive(target)
    return target.components.explosive == nil
        or target.components.burnable == nil
        or target.components.burnable:IsBurning()
end

local function ShouldRunAway(target)
    return not (target.components.health ~= nil and target.components.health:IsDead())
        and
        (
        not target:HasTag("shadowcreature") or
            (target.components.combat ~= nil and target.components.combat:HasTarget()
            ))
end

local function ShouldKite(target, inst)
    return inst.components.combat:TargetIs(target)
        and target.components.health ~= nil
        and not target.components.health:IsDead()
end

local function ShouldWatchMinigame(inst)
    if inst.components.follower.leader ~= nil and inst.components.follower.leader.components.minigame_participator ~= nil then
        if inst.components.combat.target == nil or inst.components.combat.target.components.minigame_participator ~= nil then
            return true
        end
    end
    return false
end

local function WatchingMinigame(inst)
    return (
        inst.components.follower.leader ~= nil and
            inst.components.follower.leader.components.minigame_participator ~= nil) and
        inst.components.follower.leader.components.minigame_participator:GetMinigame() or nil
end

local function WatchingMinigame_MinDist(inst)
    local minigame = WatchingMinigame(inst)
    return minigame ~= nil and minigame.components.minigame.watchdist_min or 0
end

local function WatchingMinigame_TargetDist(inst)
    local minigame = WatchingMinigame(inst)
    return minigame ~= nil and minigame.components.minigame.watchdist_target or 0
end

local function WatchingMinigame_MaxDist(inst)
    local minigame = WatchingMinigame(inst)
    return minigame ~= nil and minigame.components.minigame.watchdist_max or 0
end

function ShadowMushaBrain:OnStart()

    local watch_game = WhileNode(function() return ShouldWatchMinigame(self.inst) end, "Watching Game",
        PriorityNode({
            Follow(self.inst, WatchingMinigame, WatchingMinigame_MinDist, WatchingMinigame_TargetDist,
                WatchingMinigame_MaxDist),
            RunAway(self.inst, "minigame_participator", 5, 7),
            FaceEntity(self.inst, WatchingMinigame, WatchingMinigame),
        }, 0.25))

    local root = PriorityNode(
        {
            watch_game,

            --#1 priority is dancing beside your leader. Obviously.
            WhileNode(function() return ShouldDanceParty(self.inst) end, "Dance Party",
                PriorityNode({
                    Leash(self.inst, GetLeaderPos, KEEP_DANCING_DIST, KEEP_DANCING_DIST),
                    ActionNode(function() DanceParty(self.inst) end),
                }, .25)),

            WhileNode(function() return IsNearLeader(self.inst, MAX_TOLEADER_DIST) end, "Leader In Range",
                PriorityNode({
                    --All shadows will avoid explosives
                    RunAway(self.inst, { fn = ShouldAvoidExplosive, tags = { "explosive" }, notags = { "INLIMBO" } },
                        AVOID_EXPLOSIVE_DIST, AVOID_EXPLOSIVE_DIST),

                    -- Attack and work only when inst not under follow-only mode
                    WhileNode(function() return not self.inst:HasTag("followonly") end, "Not Follow-Only",
                        PriorityNode({
                            -- Flee from enemy if health level is low and not under berserk mode
                            WhileNode(function() return self.inst.components.health:GetPercent() < 0.25 and
                                    not self.inst:HasTag("shadowberserk")
                            end, "Flee",
                                RunAway(self.inst,
                                    { fn = ShouldRunAway, oneoftags = { "monster", "hostile" },
                                        notags = { "player", "INLIMBO", "companion" } }, RUN_AWAY_DIST,
                                    STOP_RUN_AWAY_DIST)),

                            -- Dodge if attack in cooldown
                            WhileNode(function() return (self.inst.components.combat:InCooldown() and
                                    ShouldKite(self.inst.components.combat.target, self.inst))
                            end, "Dodge",
                                RunAway(self.inst,
                                    { fn = ShouldKite, tags = { "_combat", "_health" }, notags = { "INLIMBO" } },
                                    KITING_DIST, STOP_KITING_DIST)),

                            -- Attack
                            ChaseAndAttack(self.inst),

                            -- Won't flee or do works under berserk mode
                            WhileNode(function() return not self.inst:HasTag("shadowberserk") end, "Not Berserk",
                                PriorityNode({
                                    --Flee from danger
                                    RunAway(self.inst,
                                        { fn = ShouldRunAway, oneoftags = { "monster", "hostile" },
                                            notags = { "player", "INLIMBO", "companion" } }, RUN_AWAY_DIST,
                                        STOP_RUN_AWAY_DIST),

                                    --Try to work if not fleeing
                                    BrainCommon.NodeAssistLeaderDoAction(self,
                                        { action = "CHOP", keepgoing_leaderdist = KEEP_WORKING_DIST }),
                                    BrainCommon.NodeAssistLeaderDoAction(self,
                                        { action = "MINE", keepgoing_leaderdist = KEEP_WORKING_DIST }),
                                    DoAction(self.inst,
                                        function() return FindEntityToWorkAction(self.inst, ACTIONS.DIG, DIG_TAGS) end),
                                }, .25))
                        }, .25)),

                    -- Under follow-only mode, just ran away from danger and follow the leader
                    -- Won't flee under berserk mode
                    WhileNode(function() return not self.inst:HasTag("shadowberserk") end, "Not Berserk",
                        RunAway(self.inst,
                            { fn = ShouldRunAway, oneoftags = { "monster", "hostile" },
                                notags = { "player", "INLIMBO", "companion" } }, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
                }, .25)),

            Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),

            WhileNode(function() return GetLeader(self.inst) ~= nil end, "Has Leader",
                FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)),
        }, .25)

    self.bt = BT(self.inst, root)
end

return ShadowMushaBrain
