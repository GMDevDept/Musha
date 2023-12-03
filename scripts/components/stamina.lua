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
            self.inst:PushEvent("staminadepleted")
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

function Stamina:ModifierOnly()
    return self.inst:HasTag("sneakspeedbooston")
end

function Stamina:Recalc(dt)
    if self.ispaused then
        return
    end

    local inst = self.inst

    local m = inst.sg:HasStateTag("sleeping") and
        (inst.sg:HasStateTag("tent") and 50
            or inst.sg:HasStateTag("bedroll") and 33
            or inst.sg:HasStateTag("knockout") and 20
            or 20)
        or (inst.sg:HasStateTag("working") or inst.sg:HasStateTag("attack") or
            inst.sg:HasStateTag("abouttoattack")) and -10
        or inst.sg:HasStateTag("doing") and -5
        or inst.sg:HasStateTag("fishing") and -5
        or inst.sg:HasStateTag("musha_valkyrieparrying") and TUNING.musha.skills.valkyrieparry.staminaongoingcost
        or inst.sg:HasStateTag("busy") and 0
        or (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("running")) and 2
        or inst.sg:HasStateTag("idle") and 10
        or 0

    self.baserate = TUNING.musha.staminarate + m

    self.rate = self:ModifierOnly() and self.modifiers:Get() or self.baserate + self.modifiers:Get()

    self.ratelevel = (self.rate >= 5 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate >= 2 and RATE_SCALE.INCREASE_MED) or
        (self.rate > 0.05 and RATE_SCALE.INCREASE_LOW) or
        (self.rate <= -5 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate <= -2 and RATE_SCALE.DECREASE_MED) or
        (self.rate < -0.05 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(dt * self.rate, true)
end

function Stamina:DoDelta(delta, overtime, follow_invincible)
    if follow_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or
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
            self.inst:PushEvent("staminadepleted")
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

function Stamina:GetDamageMultiplier()
    return Remap(self.current, 0, self.max,
        TUNING.musha.damageonminstamina / TUNING.musha.damagemultiplier,
        TUNING.musha.damageonmaxstamina / TUNING.musha.damagemultiplier)
end

return Stamina
