local skilltreedata_all = require("prefabs/skilltree_defs_musha")
local SKILLTREE_DEFS, ALL_SKILLS = skilltreedata_all.SKILLTREE_DEFS, skilltreedata_all.ALL_SKILLS

local function onskillxp(self, skillxp)
    self.inst.replica.mushaskilltree:SetSkillXP(skillxp)
end

local function onmaxskillxp(self, skillxp)
    self.inst.replica.mushaskilltree:SetMaxSkillXP(skillxp)
end

local MushaSkillTree = Class(function(self, inst)
    self.inst = inst
    self.activatedskills = {}
    self.skillxp = 10
    self.maxskillxp = 999
end, nil, {
    skillxp = onskillxp,
    maxskillxp = onmaxskillxp,
})

function MushaSkillTree:OnSave()
    return { activatedskills = self.activatedskills, skillxp = self.skillxp }
end

function MushaSkillTree:OnLoad(data)
    if type(data.activatedskills) == "table" then
        for k, v in pairs(data.activatedskills) do
            if not self:IsValidSkill(k) then
                print("Invalid skilltree skill to OnLoad:", k)
                data.activatedskills[k] = nil
            end
        end
        self.activatedskills = data.activatedskills
    end
    self:UpdateSaveState()

    if type(data.skillxp) == "number" then
        self:SetSkillXP(data.skillxp)
    end
end

function MushaSkillTree:UpdateSaveState()
    self.inst.replica.mushaskilltree:SetActivatedSkills(self.activatedskills)
end

function MushaSkillTree:RespecSkills()
    self.activatedskills = {}
    self:UpdateSaveState()

    self.inst.SoundEmitter:PlaySound("wilson_rework/ui/respec")
end

function MushaSkillTree:IsActivated(skill)
    return self.activatedskills[skill]
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

function MushaSkillTree:ActivateSkill(skill, category)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to ActivateSkill:", skill)
        return false
    end
    if not self.activatedskills[skill] then
        self.activatedskills[skill] = true
        self:UpdateSaveState()
        return true
    else
        print("Error: skill already activated:", skill)
        return false
    end
end

function MushaSkillTree:DeactivateSkill(skill, category)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to DeactivateSkill:", skill)
        return false
    end
    if self.activatedskills[skill] then
        self.activatedskills[skill] = nil
        self:UpdateSaveState()
        return true
    else
        print("Error: skill not activated yet:", skill)
        return false
    end
end

function MushaSkillTree:AddSkillXP(amount)
    local oldskillxp = self:GetSkillXP()
    local newskillxp = math.clamp(oldskillxp + amount, 0, self:GetMaxSkillXP())

    if newskillxp > oldskillxp then
        self.skillxp = newskillxp
        return true, newskillxp
    end

    return false, oldskillxp
end

function MushaSkillTree:SetSkillXP(amount)
    self.skillxp = math.clamp(amount, 0, self:GetMaxSkillXP())
end

function MushaSkillTree:SetMaxSkillXP(amount)
    self.maxskillxp = amount
end

return MushaSkillTree
