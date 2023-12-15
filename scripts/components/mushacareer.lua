local VALID_STRUCTRUES = {
    "researchlab2",
    "researchlab4",
}

local MushaCareer = Class(function(self, inst)
    self.inst = inst
    self.killcounter = {}
    self.buildcounter = {}

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
    }
end

function MushaCareer:OnLoad(data)
    self.killcounter = data.killcounter or {}
    self.buildcounter = data.buildcounter or {}
end

function MushaCareer:OnEntityDeath(data)
    if self.inst.components.health:IsDead() or inst:HasTag("playerghost") then
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
