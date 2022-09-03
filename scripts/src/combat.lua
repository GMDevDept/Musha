local function ClassPostConstructFn(self)
    local _GetAttacked = self.GetAttacked
    function self:GetAttacked(attacker, damage, weapon, stimuli)
        -- Cancel attacked effects if manashield is active
        if not (self.inst.components.health and self.inst.components.health:IsDead())
            and (self.inst:HasTag("manashieldactivated") or self.inst:HasTag("areamanashieldactivated")) then

            self.inst:PushEvent("manashieldonattacked",
                { attacker = attacker, damage = damage, weapon = weapon, stimuli = stimuli })
            return
        else
            return _GetAttacked(self, attacker, damage, weapon, stimuli)
        end
    end
end

AddClassPostConstruct("components/combat", ClassPostConstructFn)
