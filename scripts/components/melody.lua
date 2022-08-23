---@diagnostic disable: undefined-field
local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local Melody = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.skills.elfmelody.max
    self.current = 0
    self.minrequired = TUNING.musha.skills.elfmelody.minrequired
    self.ispaused = false
    self.baserate = 0
    self.modifiers = SourceModifierList(inst, 0, SourceModifierList.additive)
    self.rate = 0

    local period = 4
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end)

function Melody:OnSave()
    return self.current ~= 0 and { melody = self.current } or nil
end

function Melody:OnLoad(data)
    if data.melody ~= nil and self.current ~= data.melody then
        self.current = data.melody
        self:DoDelta(0)
    end
end

function Melody:IsPaused()
    return self.ispaused
end

function Melody:Pause()
    self.ispaused = true
end

function Melody:Resume()
    self.ispaused = false
end

function Melody:IsReady()
    return self.current >= self.minrequired
end

function Melody:IsFull()
    return self.current == self.max
end

function Melody:GetPercent()
    return self.current / self.max
end

function Melody:SetPercent(p)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("melodydelta", { oldpercent = old / self.max, newpercent = p })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("melodyfull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("melodynolongerfull")
        end
    end
end

function Melody:SetMax(amount)
    self.max = amount
    self.current = amount
end

function Melody:IsEffective()
    return self.modifiers:Get() ~= 0 or self.inst.sg:HasStateTag("sleeping")
end

function Melody:Recalc(dt)
    if self.ispaused or not self:IsEffective() then
        return
    end

    local inst = self.inst

    self.baserate = inst.sg:HasStateTag("sleeping") and
        (inst.sg:HasStateTag("tent") and TUNING.musha.skills.elfmelody.regen_large
            or inst.sg:HasStateTag("bedroll") and TUNING.musha.skills.elfmelody.regen_small
            or 0) or 0

    self.rate = self.baserate + self.modifiers:Get()

    self:DoDelta(dt * self.rate)
end

function Melody:DoDelta(delta)
    if self.inst.is_teleporting then
        return
    end

    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("melodydelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, delta = self.current - old })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("melodyfull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("melodynolongerfull")
        end
    end
end

function Melody:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

return Melody
