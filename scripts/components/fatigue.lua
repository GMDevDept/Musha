---@diagnostic disable: undefined-field
local function onmax(self, max)
    self.inst.replica.fatigue:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.fatigue:SetCurrent(current)
end

local function OnTaskTick(inst, self, period)
    self:DoRegen(period)
end

local Fatigue = Class(function(self, inst)
    self.inst = inst
    self.max = 100
    self.current = self.max

    self.ispalsed = false
    self.rate = 0

    local period = 1
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end,
    nil,
    {
        max = onmax,
        current = oncurrent,
    })


function Fatigue:OnSave()
    return self.current ~= self.max and { fatigue = self.current } or nil
end

function Fatigue:OnLoad(data)
    if data.fatigue ~= nil and self.current ~= data.fatigue then
        self.current = data.fatigue
        self:DoDelta(0)
    end
end

function Fatigue:LongUpdate(dt)
    self:DoRegen(dt)
end

function Fatigue:Pause()
    self.ispalsed = true
end

function Fatigue:Resume()
    self.ispalsed = false
end

function Fatigue:IsPaused()
    return not self.ispalsed
end

function Fatigue:IsEmpty()
    return self.current <= 0
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
    self.current = amount
end

function Fatigue:SetRate(rate)
    self.rate = rate
    self.inst.replica.fatigue:SetRate(rate)
end

function Fatigue:DoDeltaToRate(delta)
    local old = self.rate
    self.rate = self.rate + delta
end

function Fatigue:DoRegen(dt)
    local old = self.current

    if not self.ispalsed then
        self:DoDelta(dt * self.rate / 1000, true)
    end
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
    return string.format("%2.2f / %2.2f, rate: (%2.2f * %2.2f)", self.current, self.max, self.rate)
end

return Fatigue
