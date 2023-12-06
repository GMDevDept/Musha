local skilltreedata_all = require("prefabs/skilltree_defs_musha")
local SKILLTREE_DEFS, SKILLTREE_METAINFO = skilltreedata_all.SKILLTREE_DEFS, skilltreedata_all.SKILLTREE_METAINFO

local NILDATA = nil -- Local cache to have same copy across all instances of MushaSkillTree.

local MushaSkillTree = Class(function(self, inst)
    self.inst = inst
    self.activatedskills = {}
    self.skillxp = {}
    NILDATA = NILDATA or self:EncodeSkillTreeData() -- NOTES(JBK): This the default output when no data is available.
    self.NILDATA = NILDATA

    --self.save_enabled = nil
    --self.dirty = nil
end)

function MushaSkillTree:RespecSkills(category) -- More efficient handling of this action.
    self.activatedskills[category] = nil
    self:UpdateSaveState(category)
end

-- NOTES(JBK): Chances are you want to use the wrapper functions in skilltreeupdater for these.

function MushaSkillTree:IsActivated(skill, category)
    if SKILLTREE_DEFS[category] == nil then
        --print("Invalid skilltree category to IsActivated:", category, skill)
        return false
    end
    local skills = self.activatedskills[category]
    return skills and (skills[skill] ~= nil) or false
end

function MushaSkillTree:IsValidSkill(skill, category)
    if SKILLTREE_DEFS[category] == nil then
        --print("Invalid skilltree category to IsValidSkill:", category, skill)
        return false
    end
    return SKILLTREE_DEFS[category][skill] ~= nil
end

function MushaSkillTree:GetSkillXP(category)
    return self.skillxp[category] or 0
end

function MushaSkillTree:GetMaximumExperiencePoints()
    local tally = 0
    for i,threshold in ipairs(TUNING.SKILL_THRESHOLDS)do
        tally = tally + threshold
    end
    return tally
end

function MushaSkillTree:GetPointsForSkillXP(skillxp)
    local tally = 0
    local current = 0
    for i, threshold in ipairs(TUNING.SKILL_THRESHOLDS) do
        tally = tally + threshold

        if skillxp < tally then
            return current
        end
        current = i
        if skillxp == tally then
            return current
        end
    end
    return 0
end

function MushaSkillTree:GetAvailableSkillPoints(category)
    local total = 0
    local skills = self.activatedskills[category]
    if skills then
        for k, v in pairs(skills) do
            total = total + 1
        end
    end

    return self:GetPointsForSkillXP(self:GetSkillXP(category)) - total
end

function MushaSkillTree:GetPlayerSkillSelection(category)
    local skillselection = {}
    -- NOTES(JBK): [Searchable "SN_SKILLSELECTION"] The engine will only use the first slot for a maximum of 32 skills at this time. Adding more data will not be shown to other players.
    local bitfield = 0
    local skills = self.activatedskills[category]
    if skills then
        local skilldefs = SKILLTREE_DEFS[category]
        if skilldefs then
            for skill in pairs(skills) do
                local rpc_id = skilldefs[skill].rpc_id
                if rpc_id then
                    local rpc_bit = 2 ^ rpc_id
                    bitfield = bit.bor(bitfield, rpc_bit)
                end
            end
        end
    end
    skillselection[1] = bitfield
    return skillselection
end

function MushaSkillTree:GetNamesFromSkillSelection(skillselection, category)
    local activatedskills = {}
    local skilldefs = SKILLTREE_DEFS[category]
    if skilldefs then
        -- NOTES(JBK): [Searchable "SN_SKILLSELECTION"] The engine will only use the first slot for a maximum of 32 skills at this time. Adding more data will not be shown to other players.
        local bitfield = skillselection[1]
        for skill, skilldata in pairs(skilldefs) do
            local rpc_id = skilldata.rpc_id
            if rpc_id then
                local rpc_bit = 2 ^ rpc_id
                if bit.band(bitfield, rpc_bit) > 0 then
                    activatedskills[skill] = true
                end
            end
        end
    end
    return activatedskills
end

function MushaSkillTree:GetActivatedSkills(category)
    return self.activatedskills[category]
end

-- NOTES(JBK): Very internal functions below see skilltreeupdater for use of things.

function MushaSkillTree:ActivateSkill(skill, category)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to ActivateSkill:", category, skill)
        return false
    end
    local skills = self.activatedskills[category] or {}
    self.activatedskills[category] = skills
    if not skills[skill] then
        skills[skill] = true
        if not self.skip_validation and not self:ValidateCharacterData(category, self.activatedskills[category], self.skillxp[category]) then
            -- Something bad is with this selection state do not activate.
            skills[skill] = nil
            if next(skills) == nil then
                self.activatedskills[category] = nil
            end
            return false
        end
        self:UpdateSaveState(category)
        return true
    end
    return false
end

function MushaSkillTree:DeactivateSkill(skill, category)
    if not self:IsValidSkill(skill, category) then
        print("Invalid skilltree skill to DeactivateSkill:", category, skill)
        return false
    end
    local skills = self.activatedskills[category]
    if skills ~= nil and skills[skill] then
        skills[skill] = nil
        if not self.skip_validation and not self:ValidateCharacterData(category, self.activatedskills[category], self.skillxp[category]) then
            -- Something bad is with this selection state do not activate.
            skills[skill] = true
            return false
        end
        if next(skills) == nil then
            self.activatedskills[category] = nil
        end
        self:UpdateSaveState(category)
        return true
    end
    return false
end

function MushaSkillTree:AddSkillXP(amount, category)
    local oldskillxp = self:GetSkillXP(category)
    if self.ignorexp then
        return true, oldskillxp
    end
    local newskillxp = math.clamp(oldskillxp + amount, 0, self:GetMaximumExperiencePoints())

    if newskillxp > oldskillxp or BRANCH == "dev" and newskillxp ~= oldskillxp then
        self.skillxp[category] = newskillxp
        self:UpdateSaveState(category)
        return true, newskillxp
    end

    return false, oldskillxp
end

-- NOTES(JBK): RPC handlers should only be used for networkclientrpc things.

function MushaSkillTree:GetSkillNameFromID(category, skill_rpc_id)
    local skillmeta = SKILLTREE_METAINFO[category] or nil
    local skill = skillmeta and skillmeta.RPC_LOOKUP[skill_rpc_id] or nil
    return skill
end

function MushaSkillTree:GetSkillIDFromName(category, skill)
    local skilldefs = SKILLTREE_DEFS[category] or nil
    local skill_rpc_id = skilldefs and skilldefs[skill] and skilldefs[skill].rpc_id or nil
    return skill_rpc_id
end

-- NOTES(JBK): These do not have use case out of the data layer they are here in case mods want to make their own handlers. Do not call.

function MushaSkillTree:OPAH_DoBackup()
    --print("[OPAH] TheSkillTree:DoBackup")
    local category = ThePlayer.prefab
    self.save_enabled = nil -- We will get a bunch of events from the server do not write to disk every time.
    -- The server is intending to send the client its known state to the local player.
    -- The local player will preserve its skill selection and other data it does not want to get stomped.
    if self.activatedskills_backup == nil and self.activatedskills[category] ~= nil and next(self.activatedskills[category]) ~= nil then
        -- We have data on the local client, try to preserve it.
        self.activatedskills_backup = deepcopy(self.activatedskills)
        self.activatedskills = {}
    end

    -- Send off stats to the server it should know of.
    self.ignorexp = true
    local xp = self:GetSkillXP(category)
    if xp > 0 then
        local skilltreeupdater = ThePlayer.components.skilltreeupdater
        skilltreeupdater:AddSkillXP(xp)
    end
    self.skip_validation = true
end
function MushaSkillTree:OPAH_Ready()
    --print("[OPAH] TheSkillTree:Ready")
    local category = ThePlayer.prefab
    -- The server is done sending the client data on the activated skills it knows of.
    -- The local player will first check if the states are identical and if so disregard preservation entirely.
    -- Afterwards the local player will send to the server stats it knows of that the server should also be aware of.
    if self.activatedskills_backup ~= nil then
        if self.activatedskills_backup[category] == nil or -- No reason to backup.
            self.activatedskills[category] ~= nil and -- Has a reason to check keys to backup.
            table.keysareidentical(self.activatedskills[category], self.activatedskills_backup[category]) -- Keys are identical, no reason to backup.
        then
            -- There is no need to backup this table for this character.
            self.activatedskills = self.activatedskills_backup
            self.activatedskills_backup = nil
        end
    end

    self.save_enabled = true -- Safe to write to disk again.
    self.ignorexp = nil
    self.skip_validation = nil
    local skilltreeupdater = ThePlayer.components.skilltreeupdater
    skilltreeupdater:AddSkillXP(0) -- Update local client to see if it needs to show a notification.
end

function MushaSkillTree:DecodeSkillTreeData(data)
    -- "s1,s2,s3,s4,s5|12345"
    local datachunks = string.split(data, "|")
    if datachunks[1] == nil or datachunks[2] == nil then
        -- "" or "|"
        return nil, nil
    end
    local activatedskillsarray = string.split(datachunks[1], ",")
    local activatedskills = {}
    if activatedskillsarray[1] ~= "!" then
        for _, skill in ipairs(activatedskillsarray) do
            activatedskills[skill] = true
        end
    end
    local skillxp = tonumber(datachunks[2])
    return activatedskills, skillxp
end

function MushaSkillTree:EncodeSkillTreeData(category)
    local skillxp_backup = self.skillxp_backup or 0
    local skillxp = self.skillxp[category]
    if skillxp == nil then
        skillxp = 0
    end
    skillxp = math.max(skillxp, skillxp_backup) -- Do not lose experience.

    local activatedskills = self.activatedskills_backup and self.activatedskills_backup[category] or self.activatedskills[category]
    if activatedskills == nil then
        return string.format("!|%d", skillxp)
    end

    if next(activatedskills) == nil then -- Should not happen but just in case.
        return string.format("!|%d", skillxp)
    end

    local activatedskillsarray = {}
    for skill in pairs(activatedskills) do
        table.insert(activatedskillsarray, skill)
    end
    table.sort(activatedskillsarray) -- Make the output consistent between encoding runs.

    return string.format("%s|%d", table.concat(activatedskillsarray, ","), skillxp)
end

function MushaSkillTree:Save(force_save, category)
    --print("[STData] Save")
    if force_save or (self.save_enabled and self.dirty) then
        local str
        if category == "LOADFIXUP" then
            str = json.encode({activatedskills = self.activatedskills, skillxp = self.skillxp, })
        else
            self.skillxp[category] = self.skillxp_backup or self.skillxp[category]
            str = json.encode({activatedskills = self.activatedskills_backup or self.activatedskills, skillxp = self.skillxp, })
        end
        TheSim:SetPersistentString("skilltree", str, false)
        self.dirty = false
    end
end

function MushaSkillTree:Load()
    --print("[STData] Load")
    self.activatedskills = {}
    self.skillxp = {}
    local needs_save = false
    TheSim:GetPersistentString("skilltree", function(load_success, data)
        if load_success and data ~= nil then
            local status, skilltree_data = pcall(function() return json.decode(data) end)
            if status and skilltree_data then
                if type(skilltree_data.activatedskills) == "table" and type(skilltree_data.skillxp) == "table" then
                    for category, activatedskills in pairs(skilltree_data.activatedskills) do
                        local skillxp = skilltree_data.skillxp[category]
                        if skillxp == nil or not self:ValidateCharacterData(category, activatedskills, skillxp) then
                            --print("[STData] Load clearing skill tree for character due to bad state", category)
                            skilltree_data.activatedskills[category] = nil
                            needs_save = true
                        end
                    end
                    self.activatedskills = skilltree_data.activatedskills
                    self.skillxp = skilltree_data.skillxp
                else
                    print("Failed to load activated skills or skillxp tables in skilltree!")
                end
            else
                print("Failed to load the data in skilltree!", status, skilltree_data)
            end
        end
    end)
    if needs_save then
        self:Save(true, "LOADFIXUP")
    end
end

function MushaSkillTree:UpdateSaveState(category)
    self.dirty = true
    if self.save_enabled then
        --print("[STData] UpdateSaveState", category)
        local metadef = SKILLTREE_METAINFO[category]
        if metadef and not metadef.modded and not TheNet:IsDedicated() and table.contains(DST_CHARACTERLIST, category) then
            TheInventory:SetSkillTreeValue(category, self:EncodeSkillTreeData(category))
        end
        self:Save(true, category)

        return true
    end
    return false
end

local function ValidateCharacterData_PrintHelper(self, category, activatedskills, skillxp)
    local def = SKILLTREE_DEFS[category]
    if def == nil then
        return false -- No error message here because not all characters have skill trees.
    end

    if activatedskills == nil or skillxp == nil then
        return false, "No skills or no skillxp to validate against."
    end

    local maxskillxp = self:GetMaximumExperiencePoints()
    local newskillxp = math.clamp(skillxp, 0, maxskillxp)
    if skillxp ~= newskillxp then
        return false, string.format("Out of range skillxp: %d !in [0, %d].", skillxp, maxskillxp)
    end

    local maxpointsallocatable = self:GetPointsForSkillXP(skillxp)
    local allocatedskills = table.count(activatedskills)
    if allocatedskills > maxpointsallocatable then
        return false, string.format("Too many allocated points for skillxp: %d > %d.", allocatedskills, maxpointsallocatable)
    end

    for skillname, _ in pairs(activatedskills) do
        local skilldef = def[skillname]
        if skilldef == nil then
            return false, string.format("Bad skillname %s this could be from an official forced respec.", skillname)
        end

        -- NOTES(JBK): Validate skill connections.
        if skilldef.must_have_one_of then
            local has_one_of = false
            for must_have_skillname, _ in pairs(skilldef.must_have_one_of) do
                local must_have_skilldef = def[must_have_skillname]

                local has_skill = activatedskills[must_have_skillname] ~= nil
                local has_unlocked_lock = must_have_skilldef.lock_open ~= nil and must_have_skilldef.lock_open(category, activatedskills, true)
                if has_skill or has_unlocked_lock then
                    has_one_of = true
                    break
                end
            end
            if not has_one_of then
                return false, string.format("Test must_have_one_of failed for skill %s.", skillname)
            end
        end
        if skilldef.must_have_all_of then
            for must_have_skillname, _ in pairs(skilldef.must_have_all_of) do
                local must_have_skilldef = def[must_have_skillname]

                local has_skill = activatedskills[must_have_skillname] ~= nil
                local has_unlocked_lock = must_have_skilldef.lock_open ~= nil and must_have_skilldef.lock_open(category, activatedskills, true)
                if not (has_skill or has_unlocked_lock) then
                    return false, string.format("Test must_have_all_of failed for skill %s.", skillname)
                end
            end
        end
    end

    return true
end

function MushaSkillTree:ValidateCharacterData(category, activatedskills, skillxp)
    local is_valid, error_message = ValidateCharacterData_PrintHelper(self, category, activatedskills, skillxp)
    if not is_valid and error_message then
        print(string.format("ValidateCharacterData failed for userid %s as %s: %s", self.owner and self.owner.userid or "N/A", category, error_message))
    end
    return is_valid
end

function MushaSkillTree:ApplyCharacterData(category, skilltreedata)
    --print("[STData] ApplyCharacterData", category, skilltreedata)
    local activatedskills, skillxp = self:DecodeSkillTreeData(skilltreedata)
    if self:ValidateCharacterData(category, activatedskills, skillxp) then
        self.skillxp[category] = math.max(self.skillxp[category] or 0, skillxp)
        self.activatedskills[category] = activatedskills
        return true
    end
    return false
end

function MushaSkillTree:ApplyOnlineProfileData()
    --print("[STData] ApplyOnlineProfileData")
    if not self.synced and
        (TheInventory:HasSupportForOfflineSkins() or not (TheFrontEnd ~= nil and TheFrontEnd:GetIsOfflineMode() or not TheNet:IsOnlineMode())) and
        TheInventory:HasDownloadedInventory() then
        for k, v in pairs(TheInventory:GetLocalSkillTree()) do
            self:ApplyCharacterData(k, v)
        end
        self.synced = true
    end
    return self.synced
end

return MushaSkillTree
