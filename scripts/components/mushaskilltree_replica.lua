local MushaSkillTree = Class(function(self, inst)
    self.inst = inst

    if TheWorld.ismastersim then
        self.classified = inst.musha_classified
    elseif self.classified == nil and inst.musha_classified ~= nil then
        self:AttachClassified(inst.musha_classified)
    end
end)

--------------------------------------------------------------------------

function MushaSkillTree:OnRemoveFromEntity()
    if self.classified ~= nil then
        if TheWorld.ismastersim then
            self.classified = nil
        else
            self.inst:RemoveEventCallback("onremove", self.ondetachclassified, self.classified)
            self:DetachClassified()
        end
    end
end

MushaSkillTree.OnRemoveEntity = MushaSkillTree.OnRemoveFromEntity

function MushaSkillTree:AttachClassified(classified)
    self.classified = classified
    self.ondetachclassified = function() self:DetachClassified() end
    self.inst:ListenForEvent("onremove", self.ondetachclassified, classified)
end

function MushaSkillTree:DetachClassified()
    self.classified = nil
    self.ondetachclassified = nil
end

--------------------------------------------------------------------------

function MushaSkillTree:GetMaxSkillXP()
    if self.inst.components.mushaskilltree ~= nil then
        return self.inst.components.mushaskilltree.maxskillxp
    elseif self.classified ~= nil then
        return self.classified.maxskillxp:value()
    else
        return 0
    end
end

function MushaSkillTree:GetSkillXP()
    if self.inst.components.mushaskilltree ~= nil then
        return self.inst.components.mushaskilltree.skillxp
    elseif self.classified ~= nil then
        return self.classified.skillxp:value()
    else
        return 0
    end
end

function MushaSkillTree:GetActivatedSkills()
    if self.inst.components.mushaskilltree ~= nil then
        return self.inst.components.mushaskilltree.activatedskills
    elseif self.classified ~= nil then
        return json.decode(self.classified.activatedskills:value())
    else
        return {}
    end
end

function MushaSkillTree:IsActivated(skill)
    local activatedskills = self:GetActivatedSkills()
    return activatedskills[skill]
end

function MushaSkillTree:GetAvailableSkillXP()
    local usedtotal = 0
    for k, v in pairs(self:GetActivatedSkills()) do
        usedtotal = usedtotal + 1
    end

    return self:GetSkillXP() - usedtotal
end

--------------------------------------------------------------------------

-- For server side use only

function MushaSkillTree:SetMaxSkillXP(amount)
    if self.classified ~= nil then
        self.classified:SetValue("maxskillxp", amount)
    end
end

function MushaSkillTree:SetSkillXP(amount)
    if self.classified ~= nil then
        self.classified:SetValue("skillxp", amount)
    end
end

function MushaSkillTree:SetActivatedSkills(activatedskills)
    if self.classified ~= nil then
        local jsonstr = json.encode(activatedskills)
        self.classified:SetValue("activatedskills", jsonstr)
    end
end

return MushaSkillTree
