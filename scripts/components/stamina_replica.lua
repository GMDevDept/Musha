local Stamina = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.player_classified
    elseif self.classified == nil and inst.player_classified ~= nil then
        self:AttachClassified(inst.player_classified)
    end
end)

--------------------------------------------------------------------------

function Stamina:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

Stamina.OnRemoveEntity = Stamina.OnRemoveFromEntity

function Stamina:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function Stamina:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function Stamina:Max()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.max
    elseif self.classified ~= nil then
        return self.classified.maxstamina:value()
    else
        return 100
    end
end

function Stamina:GetCurrent()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.current
    elseif self.classified ~= nil then
        return self.classified.currentstamina:value()
    else
        return 100
    end
end

function Stamina:GetPercent()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina:GetPercent()
    elseif self.classified ~= nil then
        return self.classified.currentstamina:value() / self.classified.maxstamina:value()
    else
        return 1
    end
end

function Stamina:GetCurrentRate()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.rate
    elseif self.classified ~= nil then
        return self.classified.staminarate:value()
    else
        return 0
    end
end

function Stamina:SetMax(max)
    if self.classified ~= nil then
        self.classified.maxstamina:set(max)
    end
end

function Stamina:SetCurrent(current)
    if self.classified ~= nil then
        self.classified.currentstamina:set(current)
    end
end

function Stamina:SetRate(rate)
    if self.classified ~= nil then
        self.classified.staminarate:set(rate) -- value below 0 cannot use player_classified:SetValue()
    end
end

return Stamina
