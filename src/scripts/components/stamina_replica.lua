local Stamina = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.musha_classified
    elseif self.classified == nil and inst.musha_classified ~= nil then
        self:AttachClassified(inst.musha_classified)
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

function Stamina:GetMax()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.max
    elseif self.classified ~= nil then
        return self.classified.maxstamina:value()
    else
        return 0
    end
end

function Stamina:GetCurrent()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.current
    elseif self.classified ~= nil then
        return self.classified.currentstamina:value()
    else
        return 0
    end
end

function Stamina:GetPercent()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina:GetPercent()
    elseif self.classified ~= nil then
        return self.classified.currentstamina:value() / self.classified.maxstamina:value()
    else
        return 0
    end
end

function Stamina:GetRateLevel()
    if self.inst.components.stamina ~= nil then
        return self.inst.components.stamina.ratelevel
    elseif self.classified ~= nil then
        return self.classified.staminaratelevel:value()
    else
        return 0
    end
end

function Stamina:SetRateLevel(ratelevel)
    if self.classified ~= nil then
        self.classified:SetValue("staminaratelevel", ratelevel)
    end
end

function Stamina:SetMax(max)
    if self.classified ~= nil then
        self.classified:SetValue("maxstamina", max)
    end
end

function Stamina:SetCurrent(current)
    if self.classified ~= nil then
        self.classified:SetValue("currentstamina", current)
    end
end

return Stamina
