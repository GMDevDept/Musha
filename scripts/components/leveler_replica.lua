---@diagnostic disable: undefined-field
local Leveler = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.musha_classified
    elseif self.classified == nil and inst.musha_classified ~= nil then
        self:AttachClassified(inst.musha_classified)
    end
end)

--------------------------------------------------------------------------

function Leveler:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

Leveler.OnRemoveEntity = Leveler.OnRemoveFromEntity

function Leveler:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function Leveler:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function Leveler:SetExperience(experience)
    if self.classified ~= nil then
        self.classified:SetValue("experience", experience)
    end
end

function Leveler:SetLevel(level)
    if self.classified ~= nil then
        self.classified:SetValue("level", level)
    end
end

function Leveler:SetMaxExperience(max)
    if self.classified ~= nil then
        self.classified:SetValue("maxexperience", max)
    end
end

function Leveler:SetMaxLevel(max)
    if self.classified ~= nil then
        self.classified:SetValue("maxlevel", max)
    end
end

function Leveler:GetExperience()
    if self.inst.components.leveler ~= nil then
        return self.inst.components.leveler.exp
    elseif self.classified ~= nil then
        return self.classified.experience:value()
    else
        return 0
    end
end

function Leveler:GetLevel()
    if self.inst.components.leveler ~= nil then
        return self.inst.components.leveler.lvl
    elseif self.classified ~= nil then
        return self.classified.level:value()
    else
        return 0
    end
end

function Leveler:GetMaxExperience()
    if self.inst.components.leveler ~= nil then
        return self.inst.components.leveler.maxexp
    elseif self.classified ~= nil then
        return self.classified.maxexperience:value()
    else
        return 0
    end
end

function Leveler:GetMaxLevel()
    if self.inst.components.leveler ~= nil then
        return self.inst.components.leveler.maxlvl
    elseif self.classified ~= nil then
        return self.classified.maxlevel:value()
    else
        return 30
    end
end

return Leveler
