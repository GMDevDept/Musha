local VALID_STRUCTRUES = {
    "researchlab2",
    "researchlab3",
}

local BONUS_DAYS = {
    1,4,10,20,30,40,50,60,80,100,120,140,160,180,200,220,240,
    260,280,300,320,340,360,380,400,420,440,460,480,500
}

local MushaCareer = Class(function(self, inst)
    self.inst = inst
    self.killcounter = {}
    self.buildcounter = {}
    self.bonusdays = BONUS_DAYS

    self.inst:ListenForEvent("cycleschanged", function(_, cycle)
        self:OnCyclesChanged(cycle)
    end, TheWorld)

    self.inst:ListenForEvent("entity_death", function(_, data)
        self:OnEntityDeath(data)
    end, TheWorld)

    self.inst:ListenForEvent("buildstructure", function(_, data)
        self:OnBuildStructure(data)
    end)
end)

function MushaCareer:OnSave()
    return {
        killcounter = self.killcounter,
        buildcounter = self.buildcounter,
        bonusdays = self.bonusdays,
    }
end

function MushaCareer:OnLoad(data)
    self.killcounter = data.killcounter or {}
    self.buildcounter = data.buildcounter or {}
    self.bonusdays = data.bonusdays or BONUS_DAYS
end

function MushaCareer:OnCyclesChanged(cycle)
    if self.inst.components.age and table.contains(self.bonusdays, self.inst.components.age:GetAgeInDays()) then
        table.removearrayvalue(self.bonusdays, self.inst.components.age:GetAgeInDays())
        if self.inst.components.mushaskilltree then
            self.inst.components.mushaskilltree:AddSkillXP(1)
        end
    end
end

function MushaCareer:OnEntityDeath(data)
    if self.inst.components.health:IsDead() or self.inst:HasTag("playerghost") then
        return
    end

    local victim = data.inst
    local victim_name = victim.prefab
    if victim:HasTag("epic") and victim:IsNear(self.inst, TUNING.musha.killcounterrange) then
        if self.killcounter[victim_name] == nil then
            self.killcounter[victim_name] = 1
            if self.inst.components.mushaskilltree then
                self.inst.components.mushaskilltree:AddSkillXP(1)
            end
        else
            self.killcounter[victim_name] = self.killcounter[victim_name] + 1
        end
    end
end

function MushaCareer:OnBuildStructure(data)
    local prodname = data.item.prefab
    if table.contains(VALID_STRUCTRUES, prodname) and not self.buildcounter[prodname] then
        self.buildcounter[prodname] = true
        if self.inst.components.mushaskilltree then
            self.inst.components.mushaskilltree:AddSkillXP(1)
        end
    end
end

return MushaCareer
