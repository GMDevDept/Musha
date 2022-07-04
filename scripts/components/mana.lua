---@diagnostic disable: undefined-field
local function onmax(self, max)
    self.inst.replica.mana:SetMax(max)
end

local function oncurrent(self, current)
    self.inst.replica.mana:SetCurrent(current)
end

local function OnTaskTick(inst, self, period)
    self:DoRegen(period)
end

local Mana = Class(function(self, inst)
    self.inst = inst
    self.max = 0
    self.current = self.max

    self.regen = true
    self.regenspeed = 0

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

function Mana:LongUpdate(dt)
    self:DoRegen(dt)
end

function Mana:Pause()
    self.regen = false
end

function Mana:Resume()
    self.regen = true
end

function Mana:IsPaused()
    return not self.regen
end

function Mana:IsEmpty()
    return self.current <= 0
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
            self.inst:PushEvent("startmanadepleted")
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

function Mana:SetRate(rate)
    self.regenspeed = rate
    self.inst.replica.mana:SetRate(rate)
end

function Mana:DoDeltaToRate(delta)
    local old = self.regenspeed
    self.regenspeed = self.regenspeed + delta
end

function Mana:DoRegen(dt)
    local old = self.current

    if self.regen then
        self:DoDelta(dt * self.regenspeed / 1000, true)
    end
end

function Mana:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or
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
            self.inst:PushEvent("startmanadepleted")
            ProfileStatsSet("started_manadepleted", true)
        end
    elseif self.current > 0 then
        self.inst:PushEvent("stopmanadepleted")
        ProfileStatsSet("stopped_manadepleted", true)
    end
end

function Mana:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: (%2.2f * %2.2f)", self.current, self.max, self.regenspeed)
end

return Mana
