---@diagnostic disable: undefined-field
local function onmax(self, max)
    self.inst.replica.fatigue:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.fatigue:SetCurrent(current)
end

local function onratelevel(self, ratelevel)
    self.inst.replica.fatigue:SetRateLevel(ratelevel)
end

local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local Fatigue = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.maxfatigue
    self.current = 0

    self.ispaused = false
    self.baserate = TUNING.musha.fatiguerate
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

function Fatigue:OnSave()
    return self.current ~= 0 and { fatigue = self.current } or nil
end

function Fatigue:OnLoad(data)
    if data.fatigue ~= nil and self.current ~= data.fatigue then
        self.current = data.fatigue
        self:DoDelta(0)
    end
end

function Fatigue:IsPaused()
    return self.ispaused
end

function Fatigue:Pause()
    self.ispaused = true
end

function Fatigue:Resume()
    self.ispaused = false
end

function Fatigue:GetPercent()
    return self.current / self.max
end

function Fatigue:SetPercent(p, overtime)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("fatiguedelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startfatiguedepleted")
            ProfileStatsSet("started_fatiguedepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopfatiguedepleted")
        ProfileStatsSet("stopped_fatiguedepleted", true)
    end
end

function Fatigue:SetMax(amount)
    self.max = amount
    self.current = 0
end

function Fatigue:SetRateLevel(ratelevel)
    self.ratelevel = ratelevel
    self.inst.replica.fatigue:SetRateLevel(ratelevel)
end

function Fatigue:Recalc(dt)
    if self.ispaused then
        return
    end

    local inst = self.inst
    local baserate = self.baserate
    local stamina = inst.components.stamina:GetPercent()

    local m = inst.sg:HasStateTag("sleeping") and -2
        or stamina == 0 and 0.25
        or stamina < 0.2 and 0.1
        or stamina < 0.4 and 0.05
        or stamina < 0.6 and 0.02
        or stamina < 0.8 and 0.01
        or 0

    self.modifiers:SetModifier(inst, m, "stamina")

    self.rate = self.baserate + self.modifiers:Get()

    self.ratelevel = (self.rate >= 0.25 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate >= 0.05 and RATE_SCALE.INCREASE_MED) or
        (self.rate > baserate and RATE_SCALE.INCREASE_LOW) or
        (self.rate <= -3 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate < -1 and RATE_SCALE.DECREASE_MED) or
        (self.rate < 0 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(dt * self.rate, true)
end

function Fatigue:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or
        self.inst.is_teleporting then
        return
    end

    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("fatiguedelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime,
            delta = self.current - old })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startfatiguedepleted")
            ProfileStatsSet("started_fatiguedepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopfatiguedepleted")
        ProfileStatsSet("stopped_fatiguedepleted", true)
    end
end

function Fatigue:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

return Fatigue
