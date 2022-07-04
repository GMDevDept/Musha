local Fatigue = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.player_classified
    elseif self.classified == nil and inst.player_classified ~= nil then
        self:AttachClassified(inst.player_classified)
    end
end)

--------------------------------------------------------------------------

function Fatigue:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

Fatigue.OnRemoveEntity = Fatigue.OnRemoveFromEntity

function Fatigue:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function Fatigue:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function Fatigue:Max()
    if self.inst.components.fatigue ~= nil then
        return self.inst.components.fatigue.max
    elseif self.classified ~= nil then
        return self.classified.maxfatigue:value()
    else
        return 100
    end
end

function Fatigue:GetCurrent()
    if self.inst.components.fatigue ~= nil then
        return self.inst.components.fatigue.current
    elseif self.classified ~= nil then
        return self.classified.currentfatigue:value()
    else
        return 100
    end
end

function Fatigue:GetPercent()
    if self.inst.components.fatigue ~= nil then
        return self.inst.components.fatigue:GetPercent()
    elseif self.classified ~= nil then
        return self.classified.currentfatigue:value() / self.classified.maxfatigue:value()
    else
        return 1
    end
end

function Fatigue:GetCurrentRate()
    if self.inst.components.fatigue ~= nil then
        return self.inst.components.fatigue.rate
    elseif self.classified ~= nil then
        return self.classified.fatiguerate:value()
    else
        return 0
    end
end

function Fatigue:SetMax(max)
    if self.classified ~= nil then
        self.classified.maxfatigue:set(max)
    end
end

function Fatigue:SetCurrent(current)
    if self.classified ~= nil then
        self.classified.currentfatigue:set(current)
    end
end

function Fatigue:SetRate(rate)
    if self.classified ~= nil then
        self.classified.fatiguerate:set(rate) -- value below 0 cannot use player_classified:SetValue()
    end
end

return Fatigue
