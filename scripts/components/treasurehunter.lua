---@diagnostic disable: undefined-field
local function OnTaskTick(inst, self, period)
    self:Recalc(period)
end

local TreasureHunter = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.musha.skills.treasuresniffing.max
    self.current = 0
    self.count = 0
    self.ispaused = false
    self.baserate = TUNING.musha.skills.treasuresniffing.regen
    self.modifiers = SourceModifierList(inst, 0, SourceModifierList.additive)
    self.rate = 0

    local period = 5
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
end)

function TreasureHunter:OnSave()
    return {
        current = self.current,
        count = self.count,
    }
end

function TreasureHunter:OnLoad(data)
    self.count = data.count or 0
    if self.count == 0 then
        self.max = TUNING.musha.skills.treasuresniffing.first
    end
    self.current = data.current or 0
    self:DoDelta(0)
end

function TreasureHunter:IsPaused()
    return self.ispaused
end

function TreasureHunter:Pause()
    self.ispaused = true
end

function TreasureHunter:Resume()
    self.ispaused = false
end

function TreasureHunter:IsReady()
    return self.current == self.max
end

function TreasureHunter:GetPercent()
    return self.current / self.max
end

function TreasureHunter:SetPercent(p)
    local old    = self.current
    self.current = p * self.max
    self.inst:PushEvent("treasuredelta", { oldpercent = old / self.max, newpercent = p })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("treasurefull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("treasurenolongerfull")
        end
    end
end

function TreasureHunter:Reset()
    self.count = self.count + 1
    self.max = TUNING.musha.skills.treasuresniffing.max
    self.current = 0
end

function TreasureHunter:IsEffective()
    return self.modifiers:Get() ~= 0 or self.inst.sg:HasStateTag("moving")
end

function TreasureHunter:Recalc(dt)
    if self.ispaused or not self:IsEffective() then
        return
    end

    self.rate = self.baserate + self.modifiers:Get()

    self:DoDelta(dt * self.rate)
end

function TreasureHunter:DoDelta(delta)
    local old = self.current
    self.current = math.clamp(self.current + delta, 0, self.max)

    self.inst:PushEvent("treasuredelta",
        { oldpercent = old / self.max, newpercent = self.current / self.max, delta = self.current - old })

    if old < self.max then
        if self.current >= self.max then
            self.inst:PushEvent("treasurefull")
        end
    else
        if self.current < self.max then
            self.inst:PushEvent("treasurenolongerfull")
        end
    end
end

function TreasureHunter:GetDebugString()
    return string.format("%2.2f / %2.2f, rate: %2.2f", self.current, self.max, self.rate)
end

return TreasureHunter
