local skilltreedata = require("prefabs/skilltree_defs_musha")

local function ClassPostConstructFn(self)
    local _IsActivated = self.IsActivated
    function self:IsActivated(skill, ...)
        if self.inst:HasTag("musha") then
            if self.inst.replica.mushaskilltree:IsActivated(skill) then
                -- Cannot modify mushaskilltree:IsActivated because it decides skill tree display on frontend
                if skilltreedata.ALL_SKILLS[skill].redirect_isactivated ~= nil then
                    return skilltreedata.ALL_SKILLS[skill].redirect_isactivated(self.inst)
                else
                    return true
                end
            else
                return false
            end
        else
            return _IsActivated(self, skill, ...)
        end
    end
end

AddClassPostConstruct("components/skilltreeupdater", ClassPostConstructFn)
