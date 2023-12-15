local skilltreedata = require("prefabs/skilltree_defs_musha")
local SKILLTREE_DEFS, ALL_SKILLS, FN = skilltreedata.SKILLTREE_DEFS, skilltreedata.ALL_SKILLS, skilltreedata.FN

local function onskillxp(self, skillxp)
    self.inst.replica.mushaskilltree:SetSkillXP(skillxp)
end

local function onmaxskillxp(self, skillxp)
    self.inst.replica.mushaskilltree:SetMaxSkillXP(skillxp)
end

local MushaSkillTree = Class(function(self, inst)
    self.inst = inst
    self.activatedskills = {}
    self.skillxp = 20
    self.maxskillxp = 999
end, nil, {
    skillxp = onskillxp,
    maxskillxp = onmaxskillxp,
})

function MushaSkillTree:OnSave()
    return { activatedskills = self.activatedskills, skillxp = self.skillxp }
end

function MushaSkillTree:UpdateSaveState()
    self.inst.replica.mushaskilltree:SetActivatedSkills(self.activatedskills)
end

function MushaSkillTree:OnLoad(data)
    if type(data.activatedskills) == "table" then
        for k, v in pairs(data.activatedskills) do
            self:ActivateSkill(k, nil, true, true)
        end
    end
    self:UpdateSaveState()

    if type(data.skillxp) == "number" then
        self:SetSkillXP(data.skillxp)
    end
end

function MushaSkillTree:RespecSkills()
    for k, v in pairs(self.activatedskills) do
        self:DeactivateSkill(k, nil, true)
    end
    self:UpdateSaveState()
    self.inst.SoundEmitter:PlaySound("wilson_rework/ui/respec")
end

function MushaSkillTree:IsValidSkill(skillname, category)
    if category then
        if SKILLTREE_DEFS[category] and SKILLTREE_DEFS[category][skillname] then
            return true
        else
            return false
        end
    else
        return ALL_SKILLS[skillname] ~= nil
    end
end

function MushaSkillTree:IsActivated(skill)
    return self.activatedskills[skill] == true
end

function MushaSkillTree:CountSkillTag(tag, category) -- Category is optional
    return FN.CountTags(category, tag, self:GetActivatedSkills())
end

function MushaSkillTree:HasSkillTag(tag, category) -- Category is optional
    return self:CountSkillTag(tag, category) > 0
end

function MushaSkillTree:GetSkillXP()
    return self.skillxp
end

function MushaSkillTree:GetMaxSkillXP()
    return self.maxskillxp
end

function MushaSkillTree:GetAvailableSkillXP()
    local usedtotal = 0
    for k, v in pairs(self.activatedskills) do
        usedtotal = usedtotal + 1
    end

    return self:GetSkillXP() - usedtotal
end

function MushaSkillTree:GetActivatedSkills()
    return self.activatedskills
end

function MushaSkillTree:AddSkillXP(amount)
    return self:SetSkillXP(self:GetSkillXP() + amount)
end

function MushaSkillTree:SetSkillXP(amount)
    local oldskillxp = self:GetSkillXP()
    local newskillxp = math.clamp(amount, 0, self:GetMaxSkillXP())

    if newskillxp ~= oldskillxp then
        self.skillxp = newskillxp
    end
end

function MushaSkillTree:SetMaxSkillXP(amount)
    self.maxskillxp = amount
end

function MushaSkillTree:ActivateSkill(skill, category, locally, init)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to ActivateSkill:", skill)
    elseif not self.activatedskills[skill] then
        self.activatedskills[skill] = true
        if not locally then
            self:UpdateSaveState()
        end

        local onactivate = ALL_SKILLS[skill].onactivate
        if onactivate then
            onactivate(self.inst, {init = init})
        end
    end
end

function MushaSkillTree:DeactivateSkill(skill, category, locally)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to DeactivateSkill:", skill)
    elseif self.activatedskills[skill] then
        self.activatedskills[skill] = nil
        if not locally then
            self:UpdateSaveState()
        end

        local ondeactivate = ALL_SKILLS[skill].ondeactivate
        if ondeactivate then
            ondeactivate(self.inst)
        end
    end
end

return MushaSkillTree
