local function onmax(self, max)
    self.inst.replica.mana:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.mana:SetCurrent(current)
end

local function onratelevel(self, ratelevel)
    self.inst.replica.mana:SetRateLevel(ratelevel)
end

local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local Mana = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.maxmana
    self.current = self.max

    self.ispaused = false
    self.baserate = TUNING.musha.manaregenspeed
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

function Mana:OnSave()
    return self.current ~= self.max and { mana = self.current } or nil
end

function Mana:OnLoad(data)
    if data.mana ~= nil and self.current ~= data.mana then
        self.current = data.mana
        self:DoDelta(0)
    end
end

function Mana:IsPaused()
    return self.ispaused
end

function Mana:Pause()
    self.ispaused = true
end

function Mana:Resume()
    self.ispaused = false
end

function Mana:GetPercent()
    return self.current / self.max
end

function Mana:SetPercent(p, overtime)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("manadelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("manadepleted")
            ProfileStatsSet("started_manadepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopmanadepleted")
        ProfileStatsSet("stopped_manadepleted", true)
    end
end

function Mana:SetMax(amount)
    self.max = amount
    self.current = amount
end

function Mana:SetRateLevel(ratelevel)
    self.ratelevel = ratelevel
    self.inst.replica.mana:SetRateLevel(ratelevel)
end

function Mana:ModifierOnly()
    return self.inst:HasTag("manashieldactivated")
end

function Mana:Recalc(dt)
    if self.ispaused then
        return
    end

    local baserate = self.baserate
    local skillbonus = self.inst.components.mushaskilltree:IsActivated("manaregen2") and TUNING.musha.skills.manaregen2.bonus
        or self.inst.components.mushaskilltree:IsActivated("manaregen1") and TUNING.musha.skills.manaregen1.bonus or 0
    local modemult = self.inst.mode:value() == 1 and TUNING.musha.charactermode.full.manaregenmult or 1

    self.rate = self:ModifierOnly() and self.modifiers:Get() or (baserate + skillbonus) * modemult + self.modifiers:Get()

    self.ratelevel = (self.rate > 3 * (baserate + skillbonus) and RATE_SCALE.INCREASE_HIGH) or
        (self.rate > 2 * (baserate + skillbonus) and RATE_SCALE.INCREASE_MED) or
        (self.rate > 1 * (baserate + skillbonus) and RATE_SCALE.INCREASE_LOW) or
        (self.rate < -2 * (baserate + skillbonus) and RATE_SCALE.DECREASE_HIGH) or
        (self.rate < -1 * (baserate + skillbonus) and RATE_SCALE.DECREASE_MED) or
        (self.rate < 0 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(dt * self.rate, true)
end

function Mana:DoDelta(delta, overtime, follow_invincible)
    if follow_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or
        self.inst.is_teleporting then
        return
    end

    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("manadelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime,
            delta = self.current - old })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("manadepleted")
            ProfileStatsSet("started_manadepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopmanadepleted")
        ProfileStatsSet("stopped_manadepleted", true)
    end
end

function Mana:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

return Mana
