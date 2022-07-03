local Mana = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.player_classified
    elseif self.classified == nil and inst.player_classified ~= nil then
        self:AttachClassified(inst.player_classified)
    end
end)

--------------------------------------------------------------------------

function Mana:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

Mana.OnRemoveEntity = Mana.OnRemoveFromEntity

function Mana:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function Mana:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function Mana:Max()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.max
    elseif self.classified ~= nil then
        return self.classified.maxmana:value()
    else
        return 100
    end
end

function Mana:GetCurrent()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.current
    elseif self.classified ~= nil then
        return self.classified.currentmana:value()
    else
        return 100
    end
end

function Mana:GetPercent()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana:GetPercent()
    elseif self.classified ~= nil then
        return self.classified.currentmana:value() / self.classified.maxmana:value()
    else
        return 1
    end
end

function Mana:GetCurrentRate()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.regenspeed
    elseif self.classified ~= nil then
        return self.classified.manaregenspeed:value()
    else
        return 0
    end
end

function Mana:SetMax(max)
    if self.classified ~= nil then
        self.classified:SetValue("maxmana", max)
    end
end

function Mana:SetCurrent(current)
    if self.classified ~= nil then
        self.classified:SetValue("currentmana", current)
    end
end

function Mana:SetRate(rate)
    if self.classified ~= nil then
        self.classified.manaregenspeed:set(rate) -- float below 0 cannot use player_classified:SetValue()
    end
end

return Mana
