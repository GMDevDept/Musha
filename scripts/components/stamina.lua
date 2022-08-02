---@diagnostic disable: undefined-field
local function onmax(self, max)
    self.inst.replica.stamina:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.stamina:SetCurrent(current)
end

local function onratelevel(self, ratelevel)
    self.inst.replica.stamina:SetRateLevel(ratelevel)
end

local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local Stamina = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.maxstamina
    self.current = self.max

    self.ispaused = false
    self.baserate = TUNING.musha.staminarate
    self.modifiers = SourceModifierList(inst, 0, SourceModifierList.additive)
    self.rate = 0 -- Dynamic, delta per second
    self.ratelevel = RATE_SCALE.NEUTRAL -- 0: neutral, 1-3: upwards, 4-6: downwards

    local period = 1
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end,
    nil,
    {
        max = onmax,
        current = oncurrent,
        ratelevel = onratelevel,
    }
)

function Stamina:OnSave()
    return self.current ~= self.max and { stamina = self.current } or nil
end

function Stamina:OnLoad(data)
    if data.stamina ~= nil and self.current ~= data.stamina then
        self.current = data.stamina
        self:DoDelta(0)
    end
end

function Stamina:IsPaused()
    return self.ispaused
end

function Stamina:Pause()
    self.ispaused = true
end

function Stamina:Resume()
    self.ispaused = false
end

function Stamina:GetPercent()
    return self.current / self.max
end

function Stamina:SetPercent(p, overtime)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("staminadelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startstaminadepleted")
            ProfileStatsSet("started_staminadepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopstaminadepleted")
        ProfileStatsSet("stopped_staminadepleted", true)
    end
end

function Stamina:SetMax(amount)
    self.max = amount
    self.current = amount
end

function Stamina:SetRateLevel(ratelevel)
    self.ratelevel = ratelevel
    self.inst.replica.stamina:SetRateLevel(ratelevel)
end

function Stamina:Recalc(dt)
    if self.ispaused then
        return
    end

    local inst = self.inst
    local baserate = self.baserate

    local m = inst.sg:HasStateTag("sleeping") and 15 - baserate
        or inst.sg:HasStateTag("working") and -5 - baserate
        or (inst.sg:HasStateTag("attacking") or inst.sg:HasStateTag("abouttoattack")) and -5 - baserate
        or (inst.sg:HasStateTag("doing") or inst.sg:HasStateTag("fishing")) and -1 - baserate
        or inst.sg:HasStateTag("busy") and 0 - baserate
        or (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("running")) and 1 - baserate
        or inst.sg:HasStateTag("idle") and 0
        or 0 - baserate

    self.modifiers:SetModifier(inst, m, "stategraph")

    self.rate = self.baserate + self.modifiers:Get()

    self.ratelevel = (self.rate >= 5 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate > 1.5 and RATE_SCALE.INCREASE_MED) or
        (self.rate > 0.05 and RATE_SCALE.INCREASE_LOW) or
        (self.rate <= -5 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate < -1 and RATE_SCALE.DECREASE_MED) or
        (self.rate < 0.05 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(dt * self.rate, true)
end

function Stamina:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or
        self.inst.is_teleporting then
        return
    end

    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("staminadelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime,
            delta = self.current - old })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startstaminadepleted")
            ProfileStatsSet("started_staminadepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopstaminadepleted")
        ProfileStatsSet("stopped_staminadepleted", true)
    end
end

function Stamina:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

return Stamina
