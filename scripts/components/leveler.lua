local function SetReplicaMaxLevel(self, maxlevel)
    self.inst.replica.leveler:SetMaxLevel(maxlevel)
end

local function SetReplicaMaxExperience(self, maxexp)
    self.inst.replica.leveler:SetMaxExperience(maxexp)
end

local function SetReplicaLevel(self, level)
    self.inst.replica.leveler:SetLevel(level)
end

local function SetReplicaExperience(self, exp)
    self.inst.replica.leveler:SetExperience(exp)
end

local Leveler = Class(function(self, inst)
    self.inst = inst

    self.exp = 0
    self.maxexp = 0

    self.lvl = 0
    self.maxlvl = 30

    self.exprate = 1

    self.exp_to_level = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210,
        220, 230, 240, 250, 260, 270, 280, 290, 300 } -- len = 30
end)

function Leveler:SetExperience(experience)
    self.exp = math.clamp(experience, 0, self.maxexp)
    SetReplicaExperience(self, experience)
end

function Leveler:SetLevel(level)
    self.lvl = math.clamp(level, 0, self.maxlvl)
    SetReplicaLevel(self, level)
end

function Leveler:SetMaxExperience(max)
    self.maxexp = math.max(max, 0)
    SetReplicaMaxExperience(self, max)
end

function Leveler:SetMaxLevel(max)
    self.maxlvl = math.max(max, 0)
    SetReplicaMaxLevel(self, max)
end

function Leveler:GetExperience()
    return self.exp
end

function Leveler:GetLevel()
    return self.lvl
end

function Leveler:GetMaxExperience()
    return self.maxexp
end

function Leveler:GetMaxLevel()
    return self.maxlvl
end

function Leveler:GetRequiredExp()
    return self.lvl < self.maxlvl and self.exp_to_level[self.lvl + 1] or nil
end

function Leveler:DoDelta(delta)
    local sys_req_exp = self:GetRequiredExp()
    local sys_max_lvl = self:GetMaxLevel()
    local sys_cur_exp = self:GetExperience()
    local sys_old_exp = self:GetExperience()
    local sys_cur_lvl = self:GetLevel()

    if sys_cur_lvl < sys_max_lvl then
        sys_cur_exp = math.clamp(sys_old_exp + delta * self.exprate, 0, self.maxexp)

        if sys_cur_exp >= sys_req_exp then
            if sys_cur_exp >= self.maxexp then
                sys_cur_lvl = sys_max_lvl
                self.inst:PushEvent("maxlevelreached")
            else
                for i, v in ipairs(self.exp_to_level) do
                    if sys_cur_exp < v then
                        sys_cur_lvl = i - 1
                        break
                    end
                end
            end

            self:SetExperience(sys_cur_exp)
            self:SetLevel(sys_cur_lvl)
            self.inst:PushEvent("levelup", { experience = self.exp, lvl = self.lvl })
        end
    end
end

function Leveler:OnSave()
    local data = {
        exp = self.exp,
        maxexp = self.maxexp,
        lvl = self.lvl,
        maxlvl = self.maxlvl,
        exp_to_level = self.exp_to_level,
    }
    return data
end

function Leveler:OnLoad(data)
    if data then
        self:SetMaxLevel(data.maxlvl)
        self:SetMaxExperience(data.maxexp)
        self:SetExperience(data.exp)
        self:SetLevel(data.lvl)
        self.exp_to_level = data.exp_to_level
        self:DoDelta(0) -- Force on dirty
    end
end

return Leveler
