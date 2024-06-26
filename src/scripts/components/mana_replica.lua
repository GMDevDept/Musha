local Mana = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.musha_classified
    elseif self.classified == nil and inst.musha_classified ~= nil then
        self:AttachClassified(inst.musha_classified)
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

function Mana:GetMax()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.max
    elseif self.classified ~= nil then
        return self.classified.maxmana:value()
    else
        return 0
    end
end

function Mana:GetCurrent()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.current
    elseif self.classified ~= nil then
        return self.classified.currentmana:value()
    else
        return 0
    end
end

function Mana:GetPercent()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana:GetPercent()
    elseif self.classified ~= nil then
        return self.classified.currentmana:value() / self.classified.maxmana:value()
    else
        return 0
    end
end

function Mana:GetRateLevel()
    if self.inst.components.mana ~= nil then
        return self.inst.components.mana.ratelevel
    elseif self.classified ~= nil then
        return self.classified.manaratelevel:value()
    else
        return 0
    end
end

function Mana:SetRateLevel(ratelevel)
    if self.classified ~= nil then
        self.classified:SetValue("manaratelevel", ratelevel)
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

return Mana
