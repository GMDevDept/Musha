local function onmax(self, max)
    self.inst.replica.mana:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.mana:SetCurrent(current)
end

local function OnTaskTick(inst, self, period)
    self:DoDec(period)
end

local Mana = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = self.max

    self.manarate = 1
    self.hurtrate = 1
    self.overridestarvefn = nil

    self.burning = true
    self.burnrate = 1

    local period = 1
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end,
nil,
{
    max = onmax,
    current = oncurrent,
})

function Mana:OnSave()
    return self.current ~= self.max and { mana = self.current } or nil
end

function Mana:OnLoad(data)
    if data.mana ~= nil and self.current ~= data.mana then
        self.current = data.mana
        self:DoDelta(0)
    end
end

function Mana:SetOverrideStarveFn(fn)
    self.overridestarvefn = fn
end

function Mana:LongUpdate(dt)
    self:DoDec(dt, true)
end

function Mana:Pause()
    self.burning = false
end

function Mana:Resume()
    self.burning = true
end

function Mana:IsPaused()
    return self.burning
end

function Mana:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: (%2.2f * %2.2f)", self.current, self.max, self.manarate, self.burnrate)
end

function Mana:SetMax(amount)
    self.max = amount
    self.current = amount
end

function Mana:IsStarving()
    return self.current <= 0
end

function Mana:DoDelta(delta, overtime, ignore_invincible)
    if self.redirect ~= nil then
        self.redirect(self.inst, delta, overtime)
        return
    end

    if not ignore_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or self.inst.is_teleporting then
        return
    end

    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("manadelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime, delta = self.current-old })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startconsumingmana")
            ProfileStatsSet("started_consumingmana", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopconsumingmana")
        ProfileStatsSet("stopped_consumingmana", true)
    end
end

function Mana:GetPercent()
    return self.current / self.max
end

function Mana:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("manadelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })

    if old > 0 then
        if self.current <= 0 then
            self.inst:PushEvent("startconsumingmana")
            ProfileStatsSet("started_consumingmana", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopconsumingmana")
        ProfileStatsSet("stopped_consumingmana", true)
    end
end

function Mana:DoDec(dt, ignore_damage)
    local old = self.current

    if self.burning then
        if self.current > 0 then
            self:DoDelta(-self.manarate * dt * self.burnrate, true)
        elseif not ignore_damage then
            if self.overridestarvefn ~= nil then
                self.overridestarvefn(self.inst, dt)
            else
                self.inst.components.health:DoDelta(-self.hurtrate * dt, true, "mana") --  ich haber mana
            end
        end
    end
end

function Mana:SetKillRate(rate)
    self.hurtrate = rate
end

function Mana:SetRate(rate)
    self.manarate = rate
end

return Mana
