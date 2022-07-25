---@diagnostic disable: undefined-field
local function onmax(self, max)
    self.inst.replica.stamina:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.stamina:SetCurrent(current)
end

local function OnTaskTick(inst, self, period)
    self:DoRegen(period)
end

local Stamina = Class(function(self, inst)
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


function Stamina:OnSave()
    return self.current ~= self.max and { stamina = self.current } or nil
end

function Stamina:OnLoad(data)
    if data.stamina ~= nil and self.current ~= data.stamina then
        self.current = data.stamina
        self:DoDelta(0)
    end
end

function Stamina:LongUpdate(dt)
    self:DoRegen(dt)
end

function Stamina:Pause()
    self.ispalsed = true
end

function Stamina:Resume()
    self.ispalsed = false
end

function Stamina:IsPaused()
    return self.ispalsed
end

function Stamina:IsEmpty()
    return self.current <= 0
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

function Stamina:SetRate(rate)
    self.rate = rate
    self.inst.replica.stamina:SetRate(rate)
end

function Stamina:DoDeltaToRate(delta)
    local old = self.rate
    self.rate = self.rate + delta
end

function Stamina:DoRegen(dt)
    local old = self.current

    if not self.ispalsed then
        self:DoDelta(dt * self.rate / 1000, true)
    end
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
    return string.format("%2.2f / %2.2f, rate: (%2.2f * %2.2f)", self.current, self.max, self.rate)
end

return Stamina
