local function ClassPostConstructFn(self)
    local _GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker, damage, weapon, stimuli)
        -- By this way 'attacked' event won't be pushed to self.inst and 'onhitother' event won't be pushed to attacker
        -- Thus attacked effects will be cancelled if manashield is active (including stategraph event)
        if not (self.inst.components.health and self.inst.components.health:IsDead())
            and (self.inst:HasTag("manashieldactivated")
                or self.inst.sg:HasStateTag("musha_valkyrieparrying")
                or self.inst.sg:HasStateTag("musha_shadowparry")) then

            self.inst:PushEvent("blocked", { attacker = attacker })
            self.inst:PushEvent("manashieldonattacked",
                { attacker = attacker, damage = damage, weapon = weapon, stimuli = stimuli }) -- Here is original damage before calculating equipments and health absorb multipliers
            return
        else
            return _GetAttacked(self, attacker, damage, weapon, stimuli)
        end
    end
end

AddClassPostConstruct("components/combat", ClassPostConstructFn)
